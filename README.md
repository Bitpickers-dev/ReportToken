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
|  動作  | コマンド  |
| ---- | ---- |              
|Compile   |truffle compile    |
|Migrate     |truffle migrate      |
|create migration file   |truffle create migraton 名前     |
|Console   |truffle console      |
|Test   |truffle test      |


## Ganache
チェーンの動作を制御しながらテストの実行、コマンドの実行、ステートの精査に使用できる
「個人のイーサリアムブロックチェーン」
V2.4.0で作業するように

https://github.com/trufflesuite/ganache

/Ganacheのセッティング/

https://www.trufflesuite.com/ganache
↑を真似してアプリをインストール
・Ganasheを開いてワークスペースは自分でテキトーに作ってね
・truffle-config.jsファイルのパスをGanacheのワークスペースに追加する。
・セーブして終了


## Metamask
Ethereumのウォレットで、Googleのアプリケーションとして利用できる。
様々なEthereumネットワークに接続できる。



For detailed explanation on how things work, check out [Nuxt.js docs](https://nuxtjs.org).
