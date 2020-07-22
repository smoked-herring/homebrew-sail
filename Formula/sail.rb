class Sail < Formula
  desc "Fast and lightweight cross-platform image decoding and encoding library"
  homepage "https://github.com/smoked-herring/sail"
  url "https://github.com/smoked-herring/sail/archive/v0.9.0-pre5.tar.gz"
  sha256 "4ba2f6b38d85e5dddc184b8cbb93ba18260ba43e6d1b0ff3cab11699f52af56d"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/smoked-herring/bottles-sail"
    rebuild 4
    sha256 "a214383bf2dce043c6eeb7950ba6dc9eae0ae4cc5b7eb385442e1a0b53a5269d" => :catalina
    sha256 "cd0d71dbd71cb587d8faa84ac7c9490e9f9e97e070529ca372865ea23d5760ef" => :mojave
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
