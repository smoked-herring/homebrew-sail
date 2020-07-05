class Sail < Formula
  desc "Fast and lightweight cross-platform image decoding and encoding library"
  homepage "https://github.com/smoked-herring/sail"
  url "https://github.com/smoked-herring/sail/archive/v0.9.0-pre4.tar.gz"
  sha256 "6e90ad265b6ab8499d4bd86a813492c098d84795f372c7dc7ba6b959cfb8d127"
  license "MIT"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-sail"
    sha256 "578b09606820b027c358c528d7f0f0d0099fb4c1491f7e858bb5f687082b6fe4" => :catalina
  end

  option "with-sail-dev", "Enable development features like pedantic warnings and ASAN (if possible)"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "jpeg-turbo"
  depends_on "libpng"

  def install
    mkdir "build" do
      sail_dev_option = build.with?("sail-dev") ? "-DSAIL_DEV=ON" : "-DSAIL_DEV=OFF"

      system "cmake", "..", *std_cmake_args, "-DBUILD_SHARED_LIBS=ON", sail_dev_option
      system "make"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/sail-probe", "--version"
  end
end
