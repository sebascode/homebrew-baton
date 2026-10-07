class Baton < Formula
  desc "Orquesta instalaciones y despliegues de compose, Dockerfile, sh y SQL"
  homepage "https://github.com/sebascode/baton_app"
  url "https://github.com/sebascode/baton_app/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "826e774f3e963ea0fe48505ae29951090a76e3958573201cde5ec879f97d9b85"
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
