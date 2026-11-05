class Fairlead < Formula
  desc "Guardrails and a guided path for coding agents: rules enforced as the agent works, tests scoped to what a change can reach, capped project memory, and KPIs."
  homepage "https://github.com/mahkassem/fairlead"
  version "0.14.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.14.2/fairlead-aarch64-apple-darwin.tar.xz"
      sha256 "3c8f3f699ecb10ffaa3b858098f15b6704b3e17a498dec35b2d4146711090bcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.14.2/fairlead-x86_64-apple-darwin.tar.xz"
      sha256 "a94c5b7de017f5a8234fa92d4f9d1e872799062edb3e19c0326c376e9647b414"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.14.2/fairlead-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e6b4bb3bf92c070c768025a888b6ad410e87b6333dab0e86d4e9b237000aab1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.14.2/fairlead-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0f422c7eabbeccd52f8353c31b63a869ab1b11e1359b424d1060a8a4a1c34489"
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
