class Fairlead < Formula
  desc "Guardrails and a guided path for coding agents: rules enforced as the agent works, tests scoped to what a change can reach, capped project memory, and KPIs."
  homepage "https://github.com/mahkassem/fairlead"
  version "0.15.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.15.0/fairlead-aarch64-apple-darwin.tar.xz"
      sha256 "e700bad07976cc7ca89fd34e93a8200a15e6b345f44f299e95d00b5f08e51dd0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.15.0/fairlead-x86_64-apple-darwin.tar.xz"
      sha256 "4c9af2398766e23f7f2469c1aec924b38eaf13afd187bea2755d2f79f2109f35"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.15.0/fairlead-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a4779ffedd5ab9f4f4847d5df5d11cccb27e7d93d9c1cb05325d0b424d0a596"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mahkassem/fairlead/releases/download/v0.15.0/fairlead-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ca232ed1daea1002c881ab31df07571ad4c35e062685301cd064c0773728b63f"
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
