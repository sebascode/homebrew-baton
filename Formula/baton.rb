class Baton < Formula
  desc "Orquesta instalaciones y despliegues (compose, Dockerfile, sh, SQL) desde la terminal"
  homepage "https://github.com/sebascode/baton_app"
  url "https://github.com/sebascode/baton_app/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c5abfce7a42a38f0619c0ad99fbee9b239d22012c0db92e076f8f0f0238848fb"
  license "MIT"
  head "https://github.com/sebascode/baton_app.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/baton-cli")
    man1.install "man/baton.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/baton version")

    # un proyecto nuevo: init crea el plan y validate lo acepta
    system bin/"baton", "create", "demo"
    assert_path_exists testpath/"baton/plans/demo.toml"
  end
end
