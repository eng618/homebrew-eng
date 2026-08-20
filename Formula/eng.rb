class Eng < Formula
  desc "Personal CLI to help facilitate my normal workflow"
  homepage "https://github.com/eng618/eng"
  license "MIT"


  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/eng618/eng/releases/download/v1.40.1/eng_1.40.1_Darwin_x86_64.tar.gz"
      sha256 "6332180d7ae46328d94d2fbe34cceddf3a546f80b2c9db334e3c929fc8d9471c"

      def install
        bin.install "eng"
        generate_completions_from_executable(bin/"eng", "completion")
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/eng618/eng/releases/download/v1.40.1/eng_1.40.1_Darwin_arm64.tar.gz"
      sha256 "6c66f9c9f7fe8ce74eaba56fbbab087333bccad5623a316fcb4c5456dcc1f9e0"

      def install
        bin.install "eng"
        generate_completions_from_executable(bin/"eng", "completion")
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/eng618/eng/releases/download/v1.40.1/eng_1.40.1_Linux_x86_64.tar.gz"
        sha256 "1cb8d38648dca33eaed21037ba88d2a7c7979626af706f5f9d4c20e4e0c97f27"

        def install
          bin.install "eng"
          generate_completions_from_executable(bin/"eng", "completion")
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/eng618/eng/releases/download/v1.40.1/eng_1.40.1_Linux_arm64.tar.gz"
        sha256 "57a50a7815580ca5ba486c0ba26b1d2cfdfda6c1d75ad8042575318f529e7f56"

        def install
          bin.install "eng"
          generate_completions_from_executable(bin/"eng", "completion")
        end
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/eng --version")
    assert_match "USAGE", shell_output("#{bin}/eng --help")
  end
end
