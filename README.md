## 自己紹介
こんにちは、私はプログラミングを学び転職を目指している33歳未経験者です。

### 経歴
| 期間                | 業種     | 担当業務               | 内容                                                                 |
|--------------------|---------|------------------|---------------------------------------------------------------------|
| 2009年4月〜2015年12月 | 製造業   | マシンオペレータ     | 建設機械用パーツを製造                                               |
| 2016年2月～2023年7月  | 保険業 | 店頭営業             | 生命保険、損害保険の販売、アフターフォロー                                 |

製造業在職中に人の役に立つ仕事がしたいという想いが芽生え、  
通信教育でFP2級の資格を取得し保険業界に転職しました。  
2023年7月にプログラミング学習に専念するため退職し、  
現在はエンジニアへの転職を目指しております。

### エンジニアになりたい理由
保険業界で働いている間、デジタル化が進む一方で、  
中高齢のお客様がデジタル操作に戸惑っている姿をよく目にしました。  
もっと使いやすいシステムを提供したいという思いから、  
プログラミングに興味を持ち、在職中に自己学習を始めました。  
技術を使って問題を解決することの魅力に気付き、  
自分もその力で社会に貢献したいと強く思いエンジニア転職を決意しました。

# エンディングノートアプリ
<img width="800" alt="エンディングノートトップページ" src="https://github.com/T-clow/endingnote-app-tm/assets/144991160/466b6972-dda0-4232-9efa-59cae7423ee2">

## サービス概要
このアプリはユーザーが自分の想いや重要な情報を主に葬儀に関しての遺志を、  
エンディングノートとして残すことができるアプリです。  
特に中高齢の男女向けにシンプルで使いやすいインターフェースを採用し、  
極力文字入力を避けて大きなボタン配置にこだわりました。

## アプリURL
[エンディングノートアプリ](https://endingnote-app-tm-c5a7b8e1d0f7.herokuapp.com/)  
PCで開発いたしましたが、実際の中高齢のユーザーがPCで操作することは考えにくいので、  
タブレットやスマホでのデザインにも気を配りレスポンシブ対応しました。

## アプリを作成した背景、理由
私自身のファイナンシャルプランナーとしての経験から、  
多くの中高齢のお客様が自分の最期について考える際に、  
家族や親しい人々に迷惑をかけたくないという想いを持っていることを知りました。  
既存のエンディングノートアプリは主に財産管理や保険見直しに焦点を当てており、  
企業の販売促進やニードセールスの要素が多いです。  

私のアプリは感情的な想いを残すことに特化して差別化を図りました。このアプリを通じて、  
ユーザーが自分の最期に関する希望やメッセージを簡単に残すことができるようにしたいと思っております。

## 機能一覧
| 機能               | 説明                                                                                     |
|--------------------|------------------------------------------------------------------------------------------|
| ユーザー登録・ログイン | Deviseを使用して実装。ゲストログイン機能も備えています。                                           |
| 保険金額のグラフ表示  | Vue.jsとChart.jsを使用して保険金額の推移をグラフで表示。                                           |
| 保険情報の管理        | 保険会社、保険種類、保険金額、保険期間を登録・表示する機能。                                             |
| 葬儀場検索           | Google Maps APIを使用して近くの葬儀場を検索。                                                    |
| 葬儀プランの選択      | ドロップダウンメニューから葬儀プランを選択。                                                     |
| ご遺言動画の投稿      | Active Storageを使用してビデオメッセージを投稿。                                             |
| ご遺影の画像投稿        | Active Storageを使用して遺影の画像を投稿。                                                       |
| お問い合わせフォーム | ログイン不要で開発者に連絡が可能。                                                            |

## 各機能への想い、こだわり

### トップページ
視認性の高いアイコンを採用、ユーザーの状況に応じて変遷先が変わる仕組みを実装。  

![トップページ動画](https://github.com/T-clow/endingnote-app-tm/assets/144991160/119412b7-5bcf-48fb-a420-b6c788f54845)  
  
未ログインならログイン画面へ  
![未ログイン時](https://github.com/T-clow/endingnote-app-tm/assets/144991160/5e671c77-e9f0-49fe-8970-619ec100113e)

データ登録がなければ新規登録へ  
![新規登録時](https://github.com/T-clow/endingnote-app-tm/assets/144991160/03ab65c5-57f2-4fe8-b633-ac87d320df17)

データがあれば詳細画面、または一覧画面  
![データ登録済時](https://github.com/T-clow/endingnote-app-tm/assets/144991160/1eaf5b72-f7c7-499c-9525-afe2077a27f2)

ユーザーは状況を気にせずに使いたい機能のボタンを押すだけで目的のページに辿り着けます。

### 保険金額のグラフ表示
実際の保険加入者には、今自分自身が保険にいくら入っているのかは知っているが、  
それがいつまでなのかをご存知ない方がとても多くいらっしゃいます。  

![保険金額グラフ](https://github.com/T-clow/endingnote-app-tm/assets/144991160/31ff3fc4-896e-4963-909e-900a2a497f0d)  

亡くなられた時期により死亡保険の額が異なること可視化することで葬儀の計画や予算の立案を支援します。  
十分な保険に入っていたつもりが、いざ亡くなると満期が過ぎており1円も遺せない。  
というような事態を事前に防げるツールになります。

### 保険情報の管理
保険情報の管理で保険金額を入力する際、円単位ではなく万単位で入力する仕様にしました。  
円で入力すると0の数が多くなり一桁間違えただけでも一大事です。  

![保険証券登録](https://github.com/T-clow/endingnote-app-tm/assets/144991160/21b5cfaa-484d-430f-9905-ea6f22847a4f)  

万単位で入力することにより、入力ミスや見間違いを極力防ぐことができると考えています。  
また、保険料や満期金などの家計簿管理や運用目線の要素はあえて排除し、  
あくまで遺せるお金に注力しシンプル化しました。  

単にview表示の単位を変えるだけでもインターフェース上は同じことはできたとは思いますが、  
jsonでchart.jsに渡す際にロジックを挟まず自然数で渡したいこと、かつ  
今後、医療保険の保障額などの１万円以下の数値を扱うことを考慮し、  
データベース上では円単位に戻して保存する仕組みをとっています。

### 葬儀場検索
Google Maps APIを使用して近くの葬儀場を検索できるようにしました。  
ユーザー自身の位置情報を基に最適な葬儀場を簡単に見つけることができます。 

![現在地周辺MAP](https://github.com/T-clow/endingnote-app-tm/assets/144991160/0aecac9f-e250-4f40-81d2-83710593e05e)  

アイコンをクリックするとGoogleさんの詳細ページに飛び、  
口コミや料金、電話番号などの情報をチェックできます。  
特に中高齢者にとって直感的で使いやすいインターフェースを目指しました。  

また外出先からでも使用できるよう、現在地を変更できるようにしています。 

![現在地変更MAP](https://github.com/T-clow/endingnote-app-tm/assets/144991160/bd779d2d-40b3-4819-821d-80d8ecf58e2d)  

こちらにより任意の中心地から半径10キロ以内の検索をかけれます。

### 葬儀プランの選択
ユーザーが迷わないように事前に設定されたプランを、  
ドロップダウンメニューから選択できるようにしました。 

![葬儀プラン](https://github.com/T-clow/endingnote-app-tm/assets/144991160/ecb60b48-23dd-4961-b22d-517d340ce1f0)  

これにより煩雑な入力を避け、簡単に希望のプランを選べるようにしています。

### ご遺言動画の投稿
動画の遺言に法的な効力はありませんが、自身の声や映像で想いを伝えることができます。  
また震災等で住居や家財が紛失してもweb上に保存されていることで想いを遺せる可能性を増やしています。  

![遺言投稿](https://github.com/T-clow/endingnote-app-tm/assets/144991160/86a510a2-5c63-47a2-8872-c5153171705b)  

形式を MP4 MOV MPEG QUICKTIME に限定し　サイズを80MBと限定することで、  
本来の用途と異なる使用を防ぎS3の圧迫を防止します。（長編映画の投稿など）

### ご遺影写真の投稿
遺影の写真は昨今は準備している方の方が少なく、  
身分証明書の写真などを加工して当日使用するケースが多々あります。  
そうすると実際の顔と異なったり違和感を感じることもあります。  
遺影の画像投稿を使うことで、元気な時の写真を気軽に残せて遺影として利用できる価値があります。  
また動画と同様に震災等で住居や家財が紛失してもweb上に保存されていることでご遺影を遺せます。 

![遺影投稿](https://github.com/T-clow/endingnote-app-tm/assets/144991160/ca9063fb-a528-46bc-a1d1-d5a2456ba561)  
 
JPEGまたはPNG以外の画像と20MB以上の画像には制限をかけてあります。  
画像は追加で3枚まで保存可能です。  

### 使用技術

#### バックエンド

| 使用技術 | 詳細 |
|--------------|-----------|
| Ruby 3.2.2 | プログラミング言語 |
| Rails 7.1.3 | フルスタックフレームワーク |
| MySQL | データベース |
| Devise | 認証用ジェム、ゲストログイン機能を実装しました。 |
| Active Storage | ファイルアップロードと管理 |
| RuboCop | コードスタイルの一貫性を維持 |
| ERB Lint | フロントエンドのコードスタイルの一貫性を維持 |
| RSpec | テストを実行 |
| Capybara | システムテストを実行 |

#### フロントエンド

| 使用技術 | 詳細 |
|--------------|-----------|
| HTML/CSS/JavaScript | ウェブ開発の基本技術 |
| Bootstrap | CSSフレームワーク |
| Vue.js | JavaScriptフレームワーク、下記のChart.jsを使いやすくします |
| Chart.js | JSONで渡した100歳までの保険金額を棒グラフに変換 |
| FontAwesome | ユーザーに直感的な操作を提供するためのアイコンライブラリ |
| Importmap | JavaScriptモジュールの依存関係を簡単に管理し、ページロードを効率化 |

#### インフラ

| 使用技術 | 詳細 |
|--------------|-----------|
| Docker | 環境が変わっても開発できるようにコンテナ化 |
| Heroku | デプロイ先 |
| AWS S3 | ユーザー画像、遺言動画、遺影の画像を保存 |
| GitHub Actions | スムーズなCI/CDフローを構築 |

#### API

| 使用技術 | 詳細 |
|--------------|-----------|
| Google Maps API | 半径10キロ以内の葬儀場のマップを表示 |
| Google Places API | 葬儀場の場所を検索、`type: ['funeral_home']` で検索 |
| Geolocation API | ユーザーの現在地を取得 |

## インフラ構成図
![インフラ構成図](https://github.com/T-clow/endingnote-app-tm/assets/144991160/afa62521-1306-441a-85f9-66dc03df197c)

## ER図
<img width="1399" alt="ER図" src="https://github.com/T-clow/endingnote-app-tm/assets/144991160/4efb8748-d2b0-4c21-be14-766d57ce15bb">

## 今後、挑戦したい機能、技術
### エンディングノートアプリ
- ページのSPA化
- 家族ユーザー招待機能
- 収入保障保険への対応 (逓減型で月額給付の死亡保険ですので合計保険金が毎年下がっていく計算ロジックが必要)
- 医療保険,がん保険 治療後に日数や術式名を入力し給付金額や支払い可否を計算をする機能  
  (各社が約款をPDFで公開しているので,OpenAIのAPIを使って約款を学習させることで実現可能だと考えています。)
- 終活やることリスト、亡くなった後に親族がすること機能の追加（FP時代の顧客フィードバックからのご要望）

### その他
- 太陽光パネル事業者と施工希望者のマッチングアプリ制作（FP時代の法人顧客からのご要望）
- React、Pythonなどのモダンな言語の取り組み
- AWS技術の学習

### 課題
  今回のアプリケーションは感情にフォーカスしているため、  
  既存のエンディングノートと比較すると、   
  ビジネスの観点で見た時に収益性があまり考えられていない状態です。  
  ですので、今後はPayPalやStripeなどの決済用APIを学習し、  
  有料でも使いたいと思える機能を考えるアイデア力を鍛えたいと考えています。  
  社会貢献をしながら、しっかりとビジネスとして成立する視点を持つことが必要だと思っています。  

## 自己PR

私は保険業界で培った知識と顧客への理解を基に、社会に貢献できるエンジニアを目指しています。  
顧客のニーズを深く理解し、それに応えるための解決策を提案する能力を磨いてきました。  
これまでのキャリアを通じて、顧客の問題に対して彼らの視点に立ったサービスを考えることを大切にしています。

保険業界では常に最新の知識を学び続けることで、市場動向を把握し提案を行う力を身に付けました。  
このスキルは、常に進化するIT業界でも活かせると信じています。

製造業から保険業に異業種転職に成功した経験から、  
新しい環境への適応力や継続的な学習の重要性を学びました。  
この経験は、エンジニアとしてのキャリアを築く上でも大きな強みになると考えています。
