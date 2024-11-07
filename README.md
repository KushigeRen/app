# Tatekae Record

Tatekae Recordは、グループ内でのお金の立て替えを記録します。  
外出先からスマートフォンで利用することを想定したデザインとなっています。  
PCから開いた場合、横幅は600px固定で表示されます。  

ーURLー  
https://tatekae-record-e17f77fb7e74.herokuapp.com/

ーQRー  
<img src="https://github.com/user-attachments/assets/7f410e12-62c4-4b91-8111-5e1d360114f2" width="10%" />　　


↓すでにある程度のデータを登録した状態で動作確認したい方はこちら↓  
ーURLー  
https://tatekae-record-e17f77fb7e74.herokuapp.com/group/99583529ce66e3d07dd2944e104fff1e

ーQRー  
<img src="https://github.com/user-attachments/assets/606a8c6b-7ce0-442a-acd9-b218fadaabb0" width="10%" />　　

# アプリについて  
「仲間内での金銭のやり取りを手軽に記録したい。」という日常の中の小さなニーズに応えるためにこのアプリを開発しました。  
「とにかく手軽に」をテーマに操作の簡単さを追求し、ストレスの元となる画面遷移も極力少なくしています。  
<br>
煩わしいログイン機能はありません。  
グループを登録するとユニークなURLが生成されるので、  
メッセージアプリなどでURLを共有しみんなで何を立て替えたかどんどん記録してください。  
記録したグループが不要になったら放置していただいて構いません。  
作成から60日が経過したグループは自動的に削除されるようになっています。  
気軽にグループを作成し、便利に使い捨ててください。  
<br>
もし立替をリマインドしたいのであれば、アプリ内の機能でGoogleカレンダーに登録することもできます。  
こちらもぜひご活用ください。  

# 機能紹介（使い方）
##グループ登録機能  
URLにアクセスするとまずこの画面に遷移します。  
https://github.com/user-attachments/assets/719f1bd5-de60-4390-8166-6085f5f0dacf  

## 支払い明細記録機能  
支払い明細を追加できます。  
https://github.com/user-attachments/assets/29e7fd65-1225-4c5c-80b4-d42dd51f63fc  

## 支払い完了機能  
支払い明細を完了状態にします。  
https://github.com/user-attachments/assets/29123de0-59e2-4fb0-8184-4d9074830197  

## まとめて完了機能  
複数の支払い明細をまとめて完了状態にします  
https://github.com/user-attachments/assets/9979c104-da2d-4a35-9e1a-9ea943b8d72e  

## 支払い明細編集機能  
支払い明細を編集できます。  
https://github.com/user-attachments/assets/444b2421-8056-4e75-9c3e-87e40fbe17ca  

## 支払い明細絞り込み機能  
支払ったメンバーで支払い明細を絞り込み検索できます。  
https://github.com/user-attachments/assets/f92b2cd3-af15-4122-b4e6-3712aeff5987  

## グループ名編集機能  
グループ名を編集できます。  
https://github.com/user-attachments/assets/4187002a-70e5-4fc1-85ed-0d4cf413c584  

## メンバー編集・削除機能  
メンバーを編集・削除できます。  
メンバーに関連する支払い明細が存在する場合、削除はできません。  
https://github.com/user-attachments/assets/5e943dff-081b-4f5d-92d0-f287288dcf96  

## URLコピー機能  
グループのURLをコピーします。    
メッセージアプリ等にこのURLを共有する想定です。  
https://github.com/user-attachments/assets/3dc2159f-fdc5-420f-b7dd-c2012b7a8bcb  

## Googleカレンダー登録機能  
支払い明細をGoogleカレンダーにイベントとして登録します。  
https://github.com/user-attachments/assets/df468b06-8b0b-4c60-8b9c-5921ea3d3fbe  

Google側の検証が完了していいないため、認証の際以下の警告画面が表示されます。  
検証手続きは進めていますが、時間がかかるため当面は警告が表示されます。  
<img width="1134" alt="スクリーンショット 2024-11-07 23 24 24" src="https://github.com/user-attachments/assets/f2a700c4-0045-48d9-b554-fba6e966c1e8">  

## グループ自動削除機能  
日次の定期実行ジョブで、毎日4:30時点で作成から60日が経過したグループを削除します。  
グループとグループに関連したメンバー情報、支払い明細情報が削除されます。  





# 使用技術  
| カテゴリ | 技術スタック |
| ------- | ------- |
| フロントエンド | javascript <br> Hotwire(Turbo,Stimulus) |
| バックエンド | Ruby 3.1.4 <br> Ruby on Rails 7.0.8 |
| インフラ | Heroku |
| データベース | MySQL 8.0.36 |
| 環境構築 | Docker |
| CI/CD | Github Actions |
| テスト | Rspec |
| ジョブ | Sidekiq |

# 構成図  
![構成図 drawio](https://github.com/user-attachments/assets/a30e279e-0a9c-4893-b0a3-7d0c6810b80a)  

# ER図
![ER drawio](https://github.com/user-attachments/assets/96464abe-edff-4f7b-95ea-21ec88079ba8)

# Github Actions  
Githubへのpush時に、RspecとRubocopが自動で実行されます。  
masterブランチへのpushでは、RspecとRubocopが成功した場合、Herokuへの自動デプロイが実行されます.

# 今後の実装予定  
①割り勘機能  
-支払いを割り勘した金額を支払い明細として記録する機能  

②支払い明細まとめ機能  
-同じメンバー間の支払い明細が複数あるとき、ひとつにまとめる機能  

③支払い合計額表示機能  
-メンバーごとの支払額の合計を表示する機能  

## 経歴
1995年1月24生（29歳（2024年11月8日現在））
2020年7月〜現在 都内SES企業勤務

2023年10月~3月 ポテパンキャンプ受講
2024年3月~現在　ポートフォリオ作成


