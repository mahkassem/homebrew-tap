class Fairlead < Formula
  desc "Guardrails and a guided path for coding agents: rules enforced as the agent works, tests scoped to what a change can reach, capped project memory, and KPIs."
  homepage "https://github.com/mahkassem/fairlead"
  version "0.15.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.15.2/fairlead-aarch64-apple-darwin.tar.xz"
      sha256 "4840335d437de12618fa6fdd5c4184877a7110573a7bdcdf8ac455652d806e80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.15.2/fairlead-x86_64-apple-darwin.tar.xz"
      sha256 "a38b44eaaa2b1d4fd5fb99d4d7f9a39b3d4a72dc9521234c21e798a1f1bff10d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.15.2/fairlead-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8d8f8261c2d909776ac587cb85a66770596b2a0b3e89e08e42f2eb012ce38f13"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.15.2/fairlead-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6ee84ea8799f6577059ebfae9b09f9ac3dfe207637a0160c632660826355d252"
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
