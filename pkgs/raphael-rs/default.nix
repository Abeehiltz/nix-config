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
    wrapProgram $out/bin/raphael-xiv \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ libGL wayland libxkbcommon ]}
  
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/64x64/apps
    cp ${src}/assets/favicon-64x64.png $out/share/icons/hicolor/64x64/apps/raphael-xiv.png
  
    cat > $out/share/applications/raphael-xiv.desktop << EOF
    [Desktop Entry]
    Name=Raphael XIV
    Comment=FFXIV Crafting Macro Solver
    Exec=$out/bin/raphael-xiv
    Icon=raphael-xiv
    Terminal=false
    Type=Application
    Categories=Game;Utility;
    EOF
  '';

  meta = {
    description = "FFXIV crafting macro solver";
    homepage = "https://github.com/KonaeAkira/raphael-rs";
    platforms = lib.platforms.linux;
  };
}
