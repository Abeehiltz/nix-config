{ lib, rustPlatform, pkg-config, libxkbcommon, libGL, wayland,
  libx11, libxcursor, libxi, libxrandr, openssl, makeWrapper, src }:

rustPlatform.buildRustPackage {
  pname = "raphael-rs";
  version = "unstable";

  inherit src;

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  nativeBuildInputs = [ pkg-config makeWrapper ];

  buildInputs = [
    libxkbcommon libGL wayland openssl
    libx11 libxcursor libxi libxrandr
  ];

  postInstall = ''
    for f in $out/bin/*; do
      wrapProgram "$f" \
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libGL wayland libxkbcommon ]}
    done
  '';

  meta = {
    description = "FFXIV crafting macro solver (GUI)";
    homepage = "https://github.com/KonaeAkira/raphael-rs";
    platforms = lib.platforms.linux;
  };
}
