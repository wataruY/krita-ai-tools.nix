# https://github.com/Acly/krita-ai-toolsのソースを取得してnixでのビルド用にパッチを加えてstoreから参照できるようにする
# このプロジェクト単体ではビルドできないのでビルド環境を整える必要はない
# 実際の使われかた:
# - パッチを当てたこのプロジェクトのツリーがstoreから参照できるので
# - kritaのビルド時にkritaのソースツリー内のプラグイン用のフォルダにコピー
# - cmakeでsubdirとして指定することにより, kritaのビルド時にビルドされてkrita本体に組込まれる
{
  pkgs,
  ...
}:
let 
  version = "1.1.1";
  pname = "krita-ai-tools-src";
  src = pkgs.fetchFromGitHub {
    owner = "Acly";
    repo = "krita-ai-tools";
    rev = "v${version}";
    hash = "sha256-Tok98klMfAsgZ2OZdTtwIeU5st/wwVZwlKm1sz2YM9o=";
  };
in
pkgs.stdenv.mkDerivation {
  inherit pname version src;

  patches = [
    ./0001-use-nix-dlimgedit.patch
  ];

  # このプロジェクトはkritaのプラグインとしてビルドされるため、
  # 単体でのビルドは行わず、ソースコードのみを提供します
  dontBuild = true;
  dontConfigure = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r . $out/
    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Krita plugin which adds selection tools to mask objects with a single click";
    homepage = "https://github.com/Acly/krita-ai-tools";
    license = licenses.gpl3Plus;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
