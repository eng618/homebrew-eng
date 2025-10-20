class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.25.14'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.25.14/eng_0.25.14_Darwin_x86_64.tar.gz'
    sha256 '896b3d777a9b4c18c098717e543bf9e6a8d8b771febe76b207014d9211d9f7ba'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.25.14/eng_0.25.14_Darwin_arm64.tar.gz'
    sha256 'f48662e306ac17f778d934ab96ef55d8a5f5516d67bbd1384ca603e937a1d769'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.25.14/eng_0.25.14_Linux_x86_64.tar.gz'
      sha256 '799c563093014557b4309408fc09b5ae89eab24082feb84b6fdb1d66e312d973'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.25.14/eng_0.25.14_Linux_arm64.tar.gz'
      sha256 'db86f18f57a64b50690a4312246d7826b9c554ec3ec1bb4c4021345700b828e3'
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
