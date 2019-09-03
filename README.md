# マイベストブック！

## 開発環境
- Ruby 2.5.0
- Ruby on Rails 5.2.3
- mysql  Ver 8.0.17
- SASS
- Haml
- Dockerにて開発環境構築

## 機能一覧,使用gem,API
- ユーザ登録/編集機能(device)
- ユーザフォロー機能(jqueryにてAjax)
- 読んだ本をマークする機能(jqueryにてAjax)
- GoogleBooksAPI を用いた本の情報検索/表示
- 本を好きなわけを投稿する機能(CRUD)
- ページネーション機能(kaminari)
- マイページにフォローユーザのタイムライン表示
- 自分が好きな本を好きな人が好きな本をランダムで表示
- ActiveStorageを用いたユーザーのプロフィール画像保存

## テスト
- 統合テスト(system spec)
- 機能テスト(request spec)
- 単体テスト(モデル等)
- rubocopによる静的コード解析
- 上記circleciを使ってGitHubへのpush時に自動実行

全ての機能はテストしていませんが、テストパターンを網羅的に記述することを心がけました

## 本番環境
- AWS(EC2,S3(ActiveStorageの画像を保存しています))
- capistranoを使用した自動デプロイ