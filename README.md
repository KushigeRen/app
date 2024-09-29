# Tatekae Record

Tatekae Recordは、グループ内でのお金の立て替えを記録します。  
外出先からスマートフォンで利用することを想定したデザインとなっています。  
PCから開いた場合、横幅は600px固定で表示されます。  

ーURLー  
https://tatekae-record-e17f77fb7e74.herokuapp.com/

ーQRー  
<img src="https://github.com/user-attachments/assets/7f410e12-62c4-4b91-8111-5e1d360114f2" width="10%" />　　

# 使い方
![スクリーンショット 2024-09-25 21 17 46](https://github.com/user-attachments/assets/d467093a-c5d7-47a2-8ba9-fd2cf352b856)  
![スクリーンショット 2024-09-25 21 40 28](https://github.com/user-attachments/assets/e2ad6abd-c5d3-4e55-a741-c890a7592daa)

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

# 構成図  
![構成図](https://github.com/user-attachments/assets/4c3003fa-02e1-4618-bc9d-b64800545260)  

# ER図
![ER drawio](https://github.com/user-attachments/assets/96464abe-edff-4f7b-95ea-21ec88079ba8)

# Github Actions  
Githubへのpush時に、RspecとRubocopが自動で実行されます。  
masterブランチへのpushでは、RspecとRubocopが成功した場合、Herokuへの自動デプロイが実行されます.
