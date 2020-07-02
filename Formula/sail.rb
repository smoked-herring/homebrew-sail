class Sail < Formula
  desc "Fast and lightweight cross-platform image decoding and encoding library providing multi-leveled APIs from one-liners to complex use-cases with custom I/O sources."
  homepage "https://github.com/smoked-herring/sail"
  #head "https://github.com/smoked-herring/sail.git"
  url "https://github.com/smoked-herring/sail/archive/v0.9.0-pre3.tar.gz"
  sha256 "f442978c37eeaea3b7b4f55408749aa0292702fb0319958b315f22d3b91d53d5"
  license "MIT"

  option "with-sail-dev", "Enable development features like pedantic warnings and ASAN (if possible)"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "libjpeg-turbo"
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
