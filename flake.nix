{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        # To import a flake module
        # 1. Add foo to inputs
        # 2. Add foo as a parameter to the outputs function
        # 3. Add here: foo.flakeModule

      ];
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Per-system attributes can be defined here. The self' and inputs'
        # module parameters provide easy access to attributes of the same
        # system.

        packages = {
          krita = pkgs.libsForQt5.callPackage ./nix/packages/krita {};
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; with pkgs.libsForQt5; [
            # Build tools
            cmake
            extra-cmake-modules
            pkg-config
            python3Packages.sip
            ninja

            # KDE Frameworks
            karchive
            kconfig
            kwidgetsaddons
            kcompletion
            kcoreaddons
            kguiaddons
            ki18n
            kitemmodels
            kitemviews
            kwindowsystem
            kio
            kcrash
            breeze-icons

            # Qt5 dependencies
            qtmultimedia
            qtx11extras
            
            # python
            python3Packages.pyqt5

            # Libraries
            boost
            libraw
            fftw
            eigen
            exiv2
            fribidi
            lcms2
            gsl
            openexr
            lager
            libaom
            libheif
            libkdcraw
            giflib
            libjxl
            mlt
            openjpeg
            opencolorio
            xsimd
            poppler
            curl
            ilmbase
            immer
            kseexpr
            libmypaint
            libunibreak
            libwebp
            qtmultimedia
            qtx11extras
            quazip
            SDL2
            zug
            python3Packages.pyqt5
          ];

          env = {
            NIX_CFLAGS_COMPILE = with pkgs; toString ([
              "-I${ilmbase.dev}/include/OpenEXR"
            ] ++ lib.optional stdenv.cc.isGNU "-Wno-deprecated-copy");

            PYTHONPATH = with pkgs.python3Packages; makePythonPath [
              sip
              setuptools
            ];

            CMAKE_BUILD_TYPE = "RelWithDebInfo";
            
            PYQT5_SIP_DIR = "${pkgs.python3Packages.pyqt5}/${pkgs.python3Packages.python.sitePackages}/PyQt5/bindings";
            PYQT_SIP_DIR_OVERRIDE = "${pkgs.python3Packages.pyqt5}/${pkgs.python3Packages.python.sitePackages}/PyQt5/bindings";
            BUILD_KRITA_QT_DESIGNER_PLUGINS = "ON";
          };

          shellHook = ''
            echo "Welcome to Krita build environment!"
          '';
        };

      };
      flake = {

        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };
}
