class Sail < Formula
  desc "Fast and lightweight cross-platform image decoding and encoding library"
  homepage "https://github.com/smoked-herring/sail"
  url "https://github.com/smoked-herring/sail/archive/v0.9.0-pre6.tar.gz"
  sha256 "b2b6e9bc67cb9f69cf92bd084c2bb01d2d6ce9740592a7ace7966c36453c0887"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/smoked-herring/bottles-sail"
    sha256 "46e4212a601e0f1f90b327f4b192f518ac7a2d1ca51984134d08b1be00a2f999" => :catalina
    sha256 "7109320af74e663321025db089d0802a42ca166537c10aa3aed2e0af4ea371c1" => :mojave
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
