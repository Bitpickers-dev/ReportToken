# ReportToken_front

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
各自がプロジェクト直かディレクトリで.envファイルを作成、
.envファイルにReportTokenのfirebaseの情報を<>の中身を書き換える形で記述する。
``` :.env
FB_API_KEY=<FIREBASE_API_KEY>
FB_AUTH_DOMAIN=<FIREBASE_ AUTH_DOMAIN>
FB_DATABASE_URL=<FIREBASE_DATABASE_URL>
FB_PROJECTID=<FIREBASE_PROJECT_ID>
FB_STORAGE_BUCKET=<FIREBASE_ STORAGE_BUCKET>
FB_MESSAGING_SENDER_ID=<MESSAGING_SENDER_ID>
```


# ReportToken_eth

## Truffle
Ethereumの開発プラットフォームです。(RailsとかNuxt.js的な)
「スマートコントラクトをtruffleで実装→Ganacheでデプロイ」という形で開発できます。

https://github.com/trufflesuite/ganache

/truffleのセッティング/
```
$npm install -g truffle
```
/truffleのコマンド/
|  動作  | コマンド  |
| ---- | ---- |              
|Compile   |truffle compile    |
|Migrate     |truffle migrate      |
|create migration file   |truffle create migraton 名前     |
|Console   |truffle console      |
|Test   |truffle test      |

migrateがうまくいかない時は、
```
$truffle migrate --reset
```
を実行してみる。build/contractsを削除するのもあり 

## Ganache
・チェーンの動作を制御しながらテストの実行、コマンドの実行、ステートの精査に使用できる
<br>
・「個人のイーサリアムブロックチェーン」としてテスト用に使う
<br>
・V2.4.0で作業するように

https://github.com/trufflesuite/ganache

/Ganacheのセッティング/

https://www.trufflesuite.com/ganache
<br>
↑を真似してアプリをインストール
<br>
・Ganasheを開いてワークスペースは自分でテキトーに作ってね
<br>
・truffle-config.jsファイルのパスをGanacheのワークスペースに追加する。
<br>
・セーブして終了
