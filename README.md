# ReportToken_wallet

## ローカルホストへの接続

```bash
# install dependencies
$ npm install

# serve with hot reload at localhost:3000
$ npm run dev

```

# ReportToken_eth
repotokenのスマートコントラクト用のレポジトリー

## truffle
Ethereumの開発プラットフォームです。(RailsとかNuxt.js的な)
「スマートコントラクトをtruffleで実装→Ganacheでデプロイ」という形で開発できます。

https://github.com/trufflesuite/ganache

/truffleのセッティング/
```
npm install -g truffle
```
/truffleのコマンド/
```
Compile:        truffle compile
Migrate:        truffle migrate
Console:        truffle console
Test:           truffle test
```

## Ganache
チェーンの動作を制御しながらテストの実行、コマンドの実行、ステートの精査に使用できる
「個人のイーサリアムブロックチェーン」です。

https://github.com/trufflesuite/ganache

/Ganacheのセッティング/

https://www.trufflesuite.com/ganache
↑を真似してアプリをインストール
・Ganasheを開いてワークスペースは自分でテキトーに作ってね
・truffle-config.jsファイルのパスをGanacheのワークスペースに追加する。
・セーブして終了

## RemixIDE
Web上でスマートコントラクトを開発できるオンラインIDE
Metamaskと一緒に使うことができ、メインネットにデプロイしたいときに利用できる。

## Metamask
Ethereumのウォレットで、Googleのアプリケーションとして利用できる。
様々なEthereumネットワークに接続できる。



For detailed explanation on how things work, check out [Nuxt.js docs](https://nuxtjs.org).
