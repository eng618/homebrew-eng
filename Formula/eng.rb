class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.27.4'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.27.4/eng_0.27.4_Darwin_x86_64.tar.gz'
    sha256 '49923820be22d0407bf828462cdcee90233a58908314318754f232753f78c670'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.27.4/eng_0.27.4_Darwin_arm64.tar.gz'
    sha256 'f76c2591a2af9803051a65657aa4ce1573de4c5ad95cf6fe778b38c10ae8b568'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.27.4/eng_0.27.4_Linux_x86_64.tar.gz'
      sha256 'dde6c3c95268031b98f1a5891b3adc89f762718df2e9415e17cb4057546665b8'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.27.4/eng_0.27.4_Linux_arm64.tar.gz'
      sha256 'b56fcd19c9df333fdb59e973538a4c26198f8d90318de77ee55f5ef20be4ee72'
    end
  end
  license 'MIT'

  def install
    puts "bin: #{bin}"
    puts "Installing eng to: #{bin}"
    bin.install 'eng'
    puts "eng installed successfully"
    puts "Permissions of eng: #{File.stat("#{bin}/eng").mode.to_s(8)}"
    # Verify the binary is functional before generating completions
    system "#{bin}/eng", '--help'
    generate_completions
  end

  def generate_completions
    puts "PATH: #{ENV['PATH']}"
    puts "Running: #{bin}/eng completion bash"
    (bash_completion/'eng').write Utils.safe_popen_read("#{bin}/eng", 'completion', 'bash')
    (zsh_completion/'_eng').write Utils.safe_popen_read("#{bin}/eng", 'completion', 'zsh')
    (fish_completion/'eng.fish').write Utils.safe_popen_read("#{bin}/eng", 'completion', 'fish')
  end

  test do
    system "#{bin}/eng", '--help'
  end
end
