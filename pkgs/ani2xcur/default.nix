{
  lib,
  rustPlatform,
  installShellFiles,
  stdenv,
  src,
}:
rustPlatform.buildRustPackage {
  pname = "ani2xcur";
  version = "0.1.3";
  inherit src;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  nativeBuildInputs = [installShellFiles];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd ani2xcur \
      --bash <($out/bin/ani2xcur completions bash) \
      --zsh <($out/bin/ani2xcur completions zsh) \
      --fish <($out/bin/ani2xcur completions fish)
  '';

  meta = {
    description = "Install Windows animated cursor schemes on Unix-like systems";
    homepage = "https://github.com/nicdgonzalez/ani2xcur";
    mainProgram = "ani2xcur";
    platforms = lib.platforms.linux;
  };
}
