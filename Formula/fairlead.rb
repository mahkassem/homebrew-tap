class Fairlead < Formula
  desc "Guardrails and a guided path for coding agents: rules enforced as the agent works, tests scoped to what a change can reach, capped project memory, and KPIs."
  homepage "https://github.com/mahkassem/fairlead"
  version "0.20.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.20.2/fairlead-aarch64-apple-darwin.tar.xz"
      sha256 "8ae38a9376090604b9b700814ef07f709fa86f9a33e4e7c8b208dbb63c15f7ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.20.2/fairlead-x86_64-apple-darwin.tar.xz"
      sha256 "5f1681ff661c3b105aeb440b6fb00783ae934f007b855009d85e05232ecfafc0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.20.2/fairlead-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0c9523d6ee040ca575f71faa337c9b1ed317997bf837b13e3828a45002c9942"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.20.2/fairlead-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "eb006bdaa7e386becf6630dd24540897f7d7ff56add9192f2a1d63361804e466"
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
