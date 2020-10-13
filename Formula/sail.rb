class Sail < Formula
  desc "Fast and lightweight cross-platform image decoding and encoding library"
  homepage "https://github.com/smoked-herring/sail"
  url "https://github.com/smoked-herring/sail/archive/v0.9.0-pre8.tar.gz"
  sha256 "f8738d436a6933879e8ec83c46795cbf587b4009a25f6049062ad62333d9589f"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/smoked-herring/bottles-sail"
    sha256 "f4ef2269e03ad3120e7f9b0dc449dfb30918b626d64e6c0656e8957ee20a0281" => :catalina
    sha256 "1268ff9d9a6a2f1cac38ef1fe317115342c5d1809dc439d9b885eaf5569999f4" => :mojave
  end

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
