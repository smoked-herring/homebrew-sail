class Sail < Formula
  desc "Fast and lightweight cross-platform image decoding and encoding library"
  homepage "https://github.com/smoked-herring/sail"
  url "https://github.com/smoked-herring/sail/archive/v0.9.0-pre7.tar.gz"
  sha256 "63b27750aa0b7025d2f7fdb21699bd69825238216ea286f9793d2756e84e3bb6"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/smoked-herring/bottles-sail"
    sha256 "77e7d747af94f54ca1ef491113a2f99016397b731f81a60bb82c786305a0f61b" => :catalina
    sha256 "1be3fae1c9b8df4d239475144a127dfaa052778e1adcf2019b43b750ee1de794" => :mojave
  end

  option "with-sail-dev", "Enable development features like pedantic warnings and ASAN (if possible)"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"

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
