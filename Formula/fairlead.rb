class Fairlead < Formula
  desc "Guardrails and a guided path for coding agents: rules enforced as the agent works, tests scoped to what a change can reach, capped project memory, and KPIs."
  homepage "https://github.com/mahkassem/fairlead"
  version "0.20.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.20.1/fairlead-aarch64-apple-darwin.tar.xz"
      sha256 "3049a57c1aebc2239ba45fdc941ae88dfd4db71c89940f2dc6b4f9368875f40d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.20.1/fairlead-x86_64-apple-darwin.tar.xz"
      sha256 "08cc2352931754b78672d59708e96d07c288888c74fc004fa1f5d96f2707c1e1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.20.1/fairlead-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "255f0243a018a4c09448b8d448836356ba8b73be3ea2a1c0f232b5d733cca562"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.20.1/fairlead-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5e82e724e892eb88318083ed87d9c827a02ff249689bfbb712a7223dbf542f37"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "fairlead"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fairlead"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fairlead"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fairlead"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
