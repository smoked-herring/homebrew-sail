class Sail < Formula
  desc "Fast and lightweight cross-platform image decoding and encoding library"
  homepage "https://github.com/smoked-herring/sail"
  url "https://github.com/smoked-herring/sail/archive/v0.9.0-pre9.tar.gz"
  sha256 "b49dcad863ff8c1990766ab594022c382f0cb7b733ca1bb4bddc27e58d2424ee"
  license "MIT"

  option "with-sail-dev", "Enable development features like pedantic warnings and ASAN (if possible)"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  depends_on "giflib"
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
