# ReportToken
### ReportTokenはブロックチェーン技術を用いた、世界初の分散型レポート共有アプリケーション

[チャレキャラ 2020](https://challecara.org/)にて、NFTソリューションイノベータ賞を受賞しました。

![image](https://user-images.githubusercontent.com/55534054/101998984-8fbef580-3d1b-11eb-8715-86da91a36e79.png)

このアプリケーションは仮想通貨ETHを扱っているため、ETHを扱うことのできるGoogle Chromeでしか動きません。また、それに合わせてETHを取得するために拡張機能Metamaskをインストール+アカウント作成する必要があります。

## アーキテクチャ

![スクリーンショット 2020-10-13 14 33 23](https://user-images.githubusercontent.com/47593288/95819481-12015c80-0d61-11eb-875d-d2363a24caeb.png)


## ローカルホストへの接続

```bash
# install dependencies
$ npm install

# serve with hot reload at localhost:3000
$ npm run dev

```
http://localhost:3000/

/firebaseのセッティング/
```
npm install @nuxtjs/dotenv
npm install firebase
```
各自がプロジェクト直下ディレクトリで.envファイルを作成、
<br>
.envファイルにReportTokenのfirebaseの情報を<>の中身を書き換える形で記述する。
``` :.env
FB_API_KEY = ****
FB_AUTH_DOMAIN = ****
FB_DATABASE_URL = ***
FB_PROJECTID = ***
FB_STORAGE_BUCKET = ****
FB_MESSAGING_SENDER_ID = ****

ROPSTEN_URL = ****

MNEMONIC = ****
```


# ReportToken_eth


## Truffle
TruffleはEthereum開発プラットフォームです。
<br>
<br>
①自分のPCが以下の環境を満たしていることを確認してください
```
NodeJS v8.9.4 or later
Windows, Linux or Mac OS X
```
②以下のコマンドでTruffleをインストールしてください。
```
$npm install -g truffle
```

③以下のコマンドでバージョンを確認してください。表示されれば成功です🎉
```
$truffle version
```

Truffleについて、詳しくは[こちら](https://github.com/trufflesuite/truffle)をご覧ください

## Ganache
「個人のイーサリアムブロックチェーン」として開発用のEthereumブロックチェーンを用意してくれるツールです。
<br>
①[こちら](https://www.trufflesuite.com/ganache)からGanacheをダウンロードしてください。
<br>
②ダウンロードが終わったら、インストールしてGanacheを起動してください。
<br>
③このような画面が表示されれば完了です！🎉
<img width="1440" alt="スクリーンショット 2020-10-13 15 14 35" src="https://user-images.githubusercontent.com/47593288/95822413-d5386400-0d66-11eb-9394-3098a7a0a863.png">

## TruffleとGanacheの接続
①「NEW WORKSPACE」をクリック
<img width="1440" alt="スクリーンショット 2020-10-13 15 35 52" src="https://user-images.githubusercontent.com/47593288/95824382-2bf36d00-0d6a-11eb-90b9-6df0ada33d98.png">
②「ADD projelct」→「/CarrierSelect/truffle-config.jsを設定」→「SAVE AND RESTSART」
<img width="1440" alt="スクリーンショット 2020-10-14 11 05 40" src="https://user-images.githubusercontent.com/47593288/95935076-58ac9080-0e0d-11eb-9e0a-fba836375a5a.png">
③このような画面が表示されれば完了です🎉
<br>
ランダムなアドレスを持つ10個のアカウントが得られます
<img width="1440" alt="スクリーンショット 2020-10-14 11 05 12" src="https://user-images.githubusercontent.com/47593288/95935080-59ddbd80-0e0d-11eb-8e12-402a166b2709.png">

## 必要なライブラリのインストール
ERC20トークンを作成するのに必要なライブラリです
下記のコマンドからインストールしてください。
```
$ npm install @openzeppelin/contracts
```
