# マイベストブック！

好きな本を検索→好きな本が好きな理由を投稿・共有できます。
詳しくはこちらをご覧ください。
<https://www.mybestbooks.xyz/>

## 開発環境
- Ruby 2.5.0
- Ruby on Rails 5.2.3
- mysql  Ver 5.7
- SASS
- Haml
- Dockerにて開発環境構築
- Vue.js
- webpacker

## 機能一覧,使用gem,API
- 簡単ログインでポートフォリオをご確認いただけます
- google maps API を使用して、マーキング、位置情報の登録、思い出の投稿ができます
- GoogleBooksAPI を用いた本の情報検索/表示(Vue.js)
- 本を好きなわけを投稿する機能(CRUD) ※このうち登録はVue.js(vuex,axios)にて実装
- ユーザ登録/編集機能/アイコン画像添付(device/Active Storage)
- ユーザフォロー機能(jqueryにてAjax)
- 読んだ本をマークする機能(Vue.jsにて実装)
- ページネーション機能(kaminari)
- マイページにフォローユーザのタイムライン表示
- 自分が好きな本を好きな人が好きな本をランダムで表示
- ActiveStorageを用いたユーザーのプロフィール画像保存(カスタムバリデーションで画像ファイル＋1MB以下のデータのみ保存されます)
- acts-as-taggable-onを使用した投稿にタグつけ、タグ検索機能
- ransackによる検索機能
- chart.jsを使用した直近６ヶ月の読書量グラフ表示

## テスト
- 統合テスト(system spec)
- 単体テスト(モデル等)
- rubocopによる静的コード解析
- 上記circleciを使ってGitHubへのpush時に自動実行

全ての機能はテストしていませんが、テストパターンを網羅的に記述することを心がけました

## 本番環境
- AWS(EC2,S3(ActiveStorageの画像を保存しています))
- capistranoを使用した自動デプロイ
- ACM ELB でSSL/TLS
- Route53でドメイン管理

## 今後実装したいこと
- コードを美しく記述
- AWSのその他の機能使用
