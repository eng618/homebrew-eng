class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '1.3.4'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v1.3.4/eng_1.3.4_Darwin_x86_64.tar.gz'
    sha256 '0d870613916d76715f26bfef0586968ee3468bf853282d345483dccd511400fc'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v1.3.4/eng_1.3.4_Darwin_arm64.tar.gz'
    sha256 'fc3abba77257884830edca7d79fdb1c072562a1ea76f51307135bc69f7bb2a3f'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v1.3.4/eng_1.3.4_Linux_x86_64.tar.gz'
      sha256 '7da21768a5af749f7acf21ba4c6889917f5fc2ae7f5920bf3513f6b5cb004501'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v1.3.4/eng_1.3.4_Linux_arm64.tar.gz'
      sha256 '6f0538f4bfa4338d033d192cec54f68fbb24ddbc43df267d3c99f1a9a4a5b102'
    end
  end
  license 'MIT'

  def install
    puts "bin: #{bin}"
    puts "Installing eng to: #{bin}"
    bin.install 'eng'
    puts "eng installed successfully"
    puts "Permissions of eng: #{File.stat(\"#{bin}/eng\").mode.to_s(8)}"
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
