class MythwaveLlama < Formula
  desc "Llama.cpp with Responses API namespace support for local agents"
  homepage "https://github.com/Luiz-Frias/llama.cpp"
  url "https://github.com/Luiz-Frias/llama.cpp.git",
      revision: "44f4e8c4f2be03432cb393b08b467f1e2b1ce35b"
  version "0.9.0"
  license "MIT"
  revision 1

  depends_on "cmake" => :build
  depends_on "openssl@4"

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=OFF
      -DLLAMA_BUILD_IS_DEV=OFF
      -DLLAMA_BUILD_TESTS=OFF
      -DLLAMA_BUILD_EXAMPLES=OFF
      -DLLAMA_BUILD_UI=OFF
      -DLLAMA_USE_PREBUILT_UI=OFF
      -DLLAMA_OPENSSL=ON
      -DGGML_METAL_EMBED_LIBRARY=ON
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build", "--target", "llama-app", "llama-server"
    libexec.install "build/bin"
    bin.install_symlink libexec/"bin/llama" => "mythwave-llama"
    bin.install_symlink libexec/"bin/llama-server" => "mythwave-llama-server"
  end

  test do
    assert_match "Available commands", shell_output("#{bin}/mythwave-llama help")
    assert_match "44f4e8c4", shell_output("#{bin}/mythwave-llama version 2>&1")
    assert_match "--host", shell_output("#{bin}/mythwave-llama-server --help 2>&1")
  end
end
