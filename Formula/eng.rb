class Eng < Formula
  desc 'Personal cli to help facilitate my normal workflow'
  homepage 'https://github.com/eng618/eng'
  version '0.27.7'
  # URLs now use TAG_NAME (with v) for path, and FILE variable (without v) for filename
  case
  when OS.mac? && Hardware::CPU.intel?
    url 'https://github.com/eng618/eng/releases/download/v0.27.7/eng_0.27.7_Darwin_x86_64.tar.gz'
    sha256 'c9b6b239010834a8c02d53024cf5207252dc5fe5ffcd5ca5c7826842ed1764a6'
  when OS.mac? && Hardware::CPU.arm?
    url 'https://github.com/eng618/eng/releases/download/v0.27.7/eng_0.27.7_Darwin_arm64.tar.gz'
    sha256 'c6a7897d51e6ac113e6afd94b3d8815e4056bb4e9fdf302d9bff0ee1e9668565'
  when OS.linux?
    if Hardware::CPU.intel?
      url 'https://github.com/eng618/eng/releases/download/v0.27.7/eng_0.27.7_Linux_x86_64.tar.gz'
      sha256 'f425309f9636a1af8fc2b0f86ed5524674b5a9332da6c857ac3b31a7147a88d1'
    elsif Hardware::CPU.arm?
      url 'https://github.com/eng618/eng/releases/download/v0.27.7/eng_0.27.7_Linux_arm64.tar.gz'
      sha256 'f8650f8685e1a26e4c91505932ece7e68c3c06596cd2d9e5db34da66eab99fb1'
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
