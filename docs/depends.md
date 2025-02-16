# Kritaビルド環境の必要パッケージ

## ビルドシステム
- cmake
- extra-cmake-modules
- pkg-config
- python3Packages.sip

## KDE Frameworks依存
- karchive
- kconfig
- kwidgetsaddons
- kcompletion
- kcoreaddons
- kguiaddons
- ki18n
- kitemmodels
- kitemviews
- kwindowsystem
- kio
- kcrash
- breeze-icons

## Qt5依存（libsForQt5から提供）
- qtmultimedia
- qtx11extras

## 画像処理ライブラリ
- boost
- libraw
- fftw
- eigen
- exiv2
- fribidi
- libaom
- libheif
- libkdcraw
- lcms2
- gsl
- openexr
- giflib
- libjxl
- mlt
- openjpeg
- opencolorio
- xsimd
- poppler
- curl
- ilmbase
- immer
- kseexpr
- lager
- libmypaint
- libunibreak
- libwebp
- quazip
- SDL2
- zug

## 使用方法
このパッケージは以下のように`libsForQt5`を使用してビルドします：

```nix
krita-ai = pkgs.libsForQt5.callPackage ./krita-ai { };
```

## 注意点
Qt5用のライブラリを使用するため、libsForQt5名前空間から提供されるパッケージを利用します
バージョン5.2.6用の設定が含まれています
SIP 6.8との互換性のためのパッチが適用されています
