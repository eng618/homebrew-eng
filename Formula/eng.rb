class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.24.0'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.24.0/eng_0.24.0_Darwin_x86_64.tar.gz'
    sha256 'e82c9055a9e861ebca1797ac591643642d8b8e54d9dd8f5e6f30713d5474e10c'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.24.0/eng_0.24.0_Darwin_arm64.tar.gz'
    sha256 '02586c26e40749c3985bb82f436740fecb51f9834f7afd69330e989ed1c1b53d'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.24.0/eng_0.24.0_Linux_x86_64.tar.gz'
      sha256 'eccbfc2297a78f054d719a8b679712b5d9fea93546144958e841df4fae6426d0'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.24.0/eng_0.24.0_Linux_arm64.tar.gz'
      sha256 '20500c55f6d6e9de8a2a077c6460fec01659c2ad3c52773511f7a74398840c79'
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
