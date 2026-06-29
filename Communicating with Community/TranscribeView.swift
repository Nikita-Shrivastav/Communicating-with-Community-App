import SwiftUI
import SwiftUI
import Translation

// MARK: - Transcribe View

struct TranscribeView: View {

    let targetLanguageCode: String

    @Environment(\.dismiss) private var dismiss
    @StateObject private var engine: TranscriptionEngine
    @State private var showInfo = false
    @State private var showClearConfirm = false
    @State private var scrollProxy: ScrollViewProxy? = nil
    @State private var translationConfig: TranslationSession.Configuration?

    init(targetLanguageCode: String) {
        self.targetLanguageCode = targetLanguageCode
        _engine = StateObject(wrappedValue: TranscriptionEngine(targetLanguageCode: targetLanguageCode))
    }




    var body: some View {
        VStack(spacing: 0) {
            topBar
            statusBanner
            transcriptArea
            controlBar
        }
        #if os(iOS)
        .background(Color(uiColor: .systemGroupedBackground))
        #else
        .background(Color(nsColor: .windowBackgroundColor))
        #endif
        .alert(L("transcribe_info_title"), isPresented: $showInfo) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(L("transcribe_info_body"))
        }
        .confirmationDialog(
            L("transcribe_clear_confirm"),
            isPresented: $showClearConfirm,
            titleVisibility: .visible
        ) {
            Button(L("transcribe_clear"), role: .destructive) { engine.clearEntries() }
            Button(L("back"), role: .cancel) {}
        }
        .translationTask(translationConfig) { session in
            if #available(iOS 17.4, macOS 14.4, *) {
                TranslationBridge.session = session
            }
        }
        .onAppear {
            if #available(iOS 17.4, macOS 14.4, *) {
                translationConfig = TranslationSession.Configuration(
                    target: Locale.Language(identifier: targetLanguageCode)
                )
            }
        }
        .onDisappear {
            engine.stop()
            if #available(iOS 17.4, macOS 14.4, *) {
                TranslationBridge.session = nil
            }
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack(spacing: 0) {
            Button(action: { dismiss() }) {
                HStack(spacing: 6) {
                    Image(systemName: "chevron.left")
                    Text(L("back"))
                }
                .font(.headline)
            }
            .padding(.leading)

            Spacer()

            Button(action: { showInfo = true }) {
                HStack(spacing: 4) {
                    Image(systemName: "info.circle")
                    Text(L("info"))
                }
            }
            .padding(.horizontal, 8)

            if !engine.entries.isEmpty {
                Button(action: { showClearConfirm = true }) {
                    HStack(spacing: 4) {
                        Image(systemName: "trash")
                        Text(L("transcribe_clear"))
                    }
                    .foregroundStyle(.red)
                }
                .padding(.horizontal, 8)
            }
        }
        .padding(.vertical, 12)
        #if os(iOS)
        .background(Color(uiColor: .systemBackground))
        #else
        .background(Color(nsColor: .windowBackgroundColor))
        #endif
        .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
    }

    // MARK: - Status Banner

    @ViewBuilder
    private var statusBanner: some View {
        if let error = engine.errorMessage {
            HStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(.red)
                Text(error).font(.footnote).foregroundStyle(.red).multilineTextAlignment(.leading)
            }
            .padding(.horizontal).padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.red.opacity(0.08))
        } else if engine.isListening {
            HStack(spacing: 8) {
                Image(systemName: "waveform.and.mic")
                    .symbolEffect(.variableColor.iterative.dimInactiveLayers)
                    .foregroundStyle(.teal)
                Text(L("transcribe_listening")).font(.footnote.bold()).foregroundStyle(.teal)
                Spacer()
            }
            .padding(.horizontal).padding(.vertical, 8)
            .background(Color.teal.opacity(0.08))
        } else if !engine.entries.isEmpty {
            HStack(spacing: 8) {
                Image(systemName: "stop.circle").foregroundStyle(.secondary)
                Text(L("transcribe_stopped")).font(.footnote).foregroundStyle(.secondary)
            }
            .padding(.horizontal).padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        if let note = engine.translationUnavailableNote {
            Text(note).font(.caption).foregroundStyle(.orange)
                .padding(.horizontal).padding(.bottom, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Transcript Area

    private var transcriptArea: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 12) {
                    if engine.entries.isEmpty {
                        emptyStateView
                    } else {
                        ForEach(engine.entries) { entry in
                            transcriptBubble(for: entry).id(entry.id)
                        }
                    }
                }
                .padding(.horizontal).padding(.vertical, 16)
            }
            .onAppear { scrollProxy = proxy }
            .onChange(of: engine.entries.count) {
                if let last = engine.entries.last {
                    withAnimation(.easeOut(duration: 0.25)) { proxy.scrollTo(last.id, anchor: .bottom) }
                }
            }
            .onChange(of: engine.entries.last?.text) {
                if let last = engine.entries.last {
                    withAnimation(.easeOut(duration: 0.15)) { proxy.scrollTo(last.id, anchor: .bottom) }
                }
            }
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "waveform.and.mic")
                .font(.system(size: 60)).foregroundStyle(.teal.opacity(0.5))
            Text(L("transcribe_placeholder"))
                .font(.body).foregroundStyle(.secondary).multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity).padding(.top, 60)
    }

    // MARK: - Transcript Bubble

    @ViewBuilder
    private func transcriptBubble(for entry: TranscriptEntry) -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .bottom, spacing: 6) {
                    if entry.isPartial {
                        ProgressView().scaleEffect(0.7).tint(.primary)
                    }
                    Text(entry.text.isEmpty ? "…" : entry.text)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 14).padding(.vertical, 10)
                .background(Color.gray.opacity(0.15))
                .clipShape(.rect(
                    topLeadingRadius:     4,
                    bottomLeadingRadius:  18,
                    bottomTrailingRadius: 18,
                    topTrailingRadius:    18
                ))

                if let langCode = entry.detectedLanguageCode {
                    let langName = Locale.current.localizedString(forLanguageCode: langCode) ?? langCode
                    Text("\(L("transcribe_translated_from")) \(langName)")
                        .font(.caption2).foregroundStyle(.secondary).padding(.horizontal, 4)
                }

                Text(entry.timestamp, style: .time)
                    .font(.caption2).foregroundStyle(.tertiary).padding(.horizontal, 4)
            }
            Spacer(minLength: 48)
        }
    }

    // MARK: - Control Bar

    private var controlBar: some View {
        HStack(spacing: 20) {
            Button(action: { engine.start() }) {
                Label(L("transcribe_start"), systemImage: "play.fill")
                    .font(.title3.bold()).frame(maxWidth: .infinity).padding()
                    .background(engine.isListening ? Color.green.opacity(0.4) : Color.green)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .disabled(engine.isListening)

            Button(action: { engine.stop() }) {
                Label(L("transcribe_stop"), systemImage: "stop.fill")
                    .font(.title3.bold()).frame(maxWidth: .infinity).padding()
                    .background(engine.isListening ? Color.red : Color.red.opacity(0.4))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .disabled(!engine.isListening)
        }
        .padding(.horizontal).padding(.vertical, 16)
        #if os(iOS)
        .background(Color(uiColor: .systemBackground))
        #else
        .background(Color(nsColor: .windowBackgroundColor))
        #endif
        .shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: -2)
    }

    // MARK: - Localisation Helper

    private func L(_ key: String) -> String {
        Localizer.string(key, langCode: targetLanguageCode)
    }
}

#Preview {
    TranscribeView(targetLanguageCode: "en")
}
