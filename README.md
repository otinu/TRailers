<small>読了目安時間： 2分(詳細・添付資料抜き)</small>

# ![logo_2600441_print](https://user-images.githubusercontent.com/65097619/123244993-63343380-d51f-11eb-876b-5e6ea0dde0e1.png)<br>


### TRailersで出来ること

①TwitterやGitHubアカウントでスムーズにログインができます。<br>
　ログイン時にはそのアカウントの登録メールアドレスへ確認メールが届きます。
![](https://i.imgur.com/n1pQcid.png)<br>

②自分の画像や動画、PDFファイルの投稿ができます。<br>
　プログラミングを頑張ってどんなものができたのか、みんなと共有しましょう。
 
![](https://i.imgur.com/qbKEbZg.png)

![](https://i.imgur.com/BNeO0xN.png)<br><br>

③投稿に対してGoods(いいね)をもらったり、<br>
　個別チャットでフィードバックをもらえることがあるかもしれません。<br>
 
![](https://i.imgur.com/sSssp0p.png)<br>

## テーマ

<span style="color:red">**即断**</span> です。<br>
TRailersではご自身の頑張りを動画やPDF、スクリーンショットなどで投稿することができます。<br>
これに対し、他の人たちは投稿者に対してGoodsボタンでリアクションをするか投稿者に個別で質問をすることしかできません。<br>
選択肢が少ないからこそコミュニケーションを即断でき、ご自身の学習時間の確保と適度なコミュニケーションの確保をバランス良く取れるようになっています。

## テーマを選んだ理由

<details>

**Railsエンジニアの学習効率化**と現代社会人の**SNS疲れ解消**ができるアプリケーションを開発したいと考えたためです。

きっかけはスクールでの学習期間を通じて、「もっと勉強時間とコミュニケーションをバランス良くとりたい」と考えたことです。

また、このアプリケーション開発はいわゆる「SNS疲れ」という社会的問題と向き合うことにも繋がり、現場目線で開発に臨むことができるのではないかとも考えました。
TRailersはTwitterやFacebookといった**SNSよりも軽いコミュニケーションのSNS**にしたいと考え、**即断**をテーマに選びました。
</details>

## ターゲットユーザー

- Rails を学ぶ初・中級者。
- Twitter や Facebook よりも、より軽快なコミュニケーションを望むユーザー。
- プログラミングでの頑張りをQiitaといった技術共有サイトよりももっと気軽に、日常的に投稿したいユーザー。

## 主な利用シーン
<details>

* 通勤時や勉強の休憩時間などのスキマ時間に Rails 仲間の情報を**気軽にインプット**。
* その日のアプリ制作で完全燃焼。もうクタクタだから、TRailers で**気軽に共有**をしておこう。
* まだ学習を始めたばかりで**技術に自信はない**が、自分の頑張った成果物なのでせっかくだから**TRailersに投稿しよう**。
* 今まで学習してこなかった分野(APIやAWSなど)をRailsに組み込んだらどんなことができるのだろう。TRailersで他の人の投稿を見てみよう。
</details>

## 【TRailers】名前の由来

<details>

![](https://i.imgur.com/ijX1eDB.jpg)

</details>

## 実装機能(簡易版)

![](https://i.imgur.com/BOqjCwn.jpg)


<br><br>
<details><summary>実装機能(詳細版)</summary>

1.  ユーザー認証(gem 'devise')
2.  CRUD機能(投稿コントローラにて、new,create,index,show,edit,update,destroy 導入)
3.  画像・動画・PDF投稿機能(ActiveStrage)
4.  タグ付け(gem 'acts-as-taggable-on')
5.  キーワード検索
6.  Goods(いいね)機能
7.  Goodsカウント非公開・非表示機能
8.  通知機能 ⇒ Goods機能・チャット機能に実装
9.  非同期通信(Ajax) ⇒ Goods機能・チャット機能に実装
10.  SNS認証(gem 'omniauth', 'omniauth-rails_csrf_protection', 'omniauth-twitter', 'omniauth-google-oauth2', 'omniauth-github' )
11.  バッチ処理(gem 'whenever'使用) ⇒ 3日に1度、投稿に関するリマインドメールの送信 
12.  メール機能(ActionMailer) ⇒ サインアップ、SNS認証ログイン、リマインドメール
13.  レスポンシブ対応(主にBootstrap、微調整にapplication.scss使用)
14.  jQuery(gem 'jquery-rails')
 ⇒ Topスクロールボタン、Goods公開・表示切替ボタン、虫メガネボタン(投稿詳細)に実装
15.  チャット機能
16.  多言語化(Rails I18n API)

**その他**

17. N+1問題改善(gem 'bullet')
18. 秘密情報取り扱い(gem 'dotenv-rails')
19. 単体テスト、統合テスト(【Rspec】, gem 'rspec-rails' 'capybara' 'factory_bot_rails' )
20. コードフォーマット(gem 'rubocop-airbnb', 'erb_lint')






</details>

## 設計書

- [アプリケーション詳細設計](https://docs.google.com/spreadsheets/d/1nIap4ozZZPbuY8KsQUNegym8Btlm4B4d72xHm6EPrdg/edit?usp=sharing)

- [WBS](https://docs.google.com/spreadsheets/d/1ypdLWg4GF7ctWWHpH9sadE8qHGbdIDpkwMb9uacQ7SI/edit?usp=sharing)

- [データベース設計](https://docs.google.com/spreadsheets/d/1wALfpAW6Xrg7CgSO8vuDQblbhWuHeff6bcZzY2OarVA/edit?usp=sharing)

- [画面遷移図](https://drive.google.com/file/d/1PWxuPi_m9DW6HY3Ia8H1rlbqNBQTZY4b/view?usp=sharing)

- [ER図](https://drive.google.com/file/d/1qzd2XnMXEJVW6jU1AjCB6c_HiwhK-iD1/view?usp=sharing)

- [ワイヤーフレーム](https://drive.google.com/file/d/1pYGHvAhzC8QgzAxkS2BH2Wn__lT-1tlO/view?usp=sharing)

- [テスト項目](https://docs.google.com/document/d/1OuDSHP32JiRupKy1LJROuiXh4ZlZJPX4iWhiJa1WlF8/edit?usp=sharing)

## チャレンジ要素一覧

<https://docs.google.com/spreadsheets/d/1LU4F-JmB1PNmmcD-8zvwlHQIbHdybHoZtaNfvOasu7E/edit?usp=sharing>

## 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JS ライブラリ：jQuery
- IDE：AWS Cloud9
- CI/CDツール： GitHub Actions
- パッケージ依存関係 自動監視： GitHub Dependabot
- TLS証明発行元： Let's Encrypt(Certbot 使用)
- AWS<br>
　**EC2**<br>
　　Webサーバー: Nginx<br>
　　アプリケーションサーバー: Puma<br>
　**RDS**<br>
 　　RDS for MySQL<br>
 

## サイトURL

https://trailers.work


