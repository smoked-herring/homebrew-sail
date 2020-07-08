class Sail < Formula
  desc "Fast and lightweight cross-platform image decoding and encoding library"
  homepage "https://github.com/smoked-herring/sail"
  url "https://github.com/smoked-herring/sail/archive/v0.9.0-pre5.tar.gz"
  sha256 "4ba2f6b38d85e5dddc184b8cbb93ba18260ba43e6d1b0ff3cab11699f52af56d"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/smoked-herring/bottles-sail"
    rebuild 3
    sha256 "7f5e145102517148e042e692bf507c5b9fc2620b856eeb208f265e61840a1c5f" => :catalina
    sha256 "2b5dc08412502e7a73cb384a3d130fd871aac812aa29176773bbb02f90290cc7" => :mojave
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
