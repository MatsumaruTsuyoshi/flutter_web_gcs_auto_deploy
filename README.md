# GCSへの自動アップロード手順

前提条件
- GCSのバケットを作成している


大まかな手順は以下の通り
1. ローカルで動かす用のindex.htmlとGCS用のindex.htmlを作成
2. GCS用にindex.htmlの中身を編集
3. シェルスクリプトの作成と編集
4. ターミナルでシェルスクリプトを実行

1~3は最初のみの手順で、以降は4だけでGCSへ自動アップロードされる


## ローカルで動かす用のindex.htmlとGCS用のindex.htmlを作成
- webファイル直下にconfigディレクトリ作成。その直下にdevディレクトリ、releaseディレクトリを作成し、それぞれindex.htmlを用意する。

今回はreleaseディレクトリのindex.htmlをGCS用に編集する。


<img width="500" alt="" src="https://user-images.githubusercontent.com/73928886/137110728-d8726040-2cb0-471c-bc72-c229fe26e63e.png">

## GCS用にindex.htmlの中身を編集
index.htmlの参照先をGCSに変更する
変更点は３つ

１つ目
```html
<link rel="manifest" href="https://storage.googleapis.com/GCSのバケット名/web/manifest.json"> 
```

２つ目
```html
scriptTag.src = 'https://storage.googleapis.com/GCSのバケット名/web/main.dart.js';　
```

３つ目
```html
var serviceWorkerUrl = 'https://storage.googleapis.com/GCSのバケット名/web/flutter_service_worker.js?v=' + serviceWorkerVersion;
```

## シェルスクリプトの作成と編集
ターミナルで以下実行し、run.sh(シェルスクリプト)作成
```sh
touch run.sh && chmod +x run.sh
```

run.shの編集
```sh
# $1　はrun.sh実行時の引数をとる。releaseかdevのどちらか。どちらかをweb/index.htmlにコピーしてbuildする
cp web/config/$1/index.html web/index.html && flutter build web --release --web-renderer html

# 一応google-cloud-sdkのパスを通しておく。google-cloud-sdkがインストールしている場所を指定する必要あり。すでにパスを通していれば必要ないコマンド
source '/Users/ユーザー名/google-cloud-sdk/path.bash.inc'
source '/Users/ユーザー名/google-cloud-sdk/path.zsh.inc'

# GCSの指定したバケットにアップロード
gsutil cp -r /Users/ユーザー名/AndroidStudioProjects/プロジェクト名/build/web gs://GCSのバケット名/

# ブラウザで開く
open https://storage.googleapis.com/GCSのバケット名/web/index.html

```

## ターミナルでシェルスクリプトを実行

```sh
./run.sh release
```
