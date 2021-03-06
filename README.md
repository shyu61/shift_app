# SHIFT_app

社員やアルバイトのシフトを管理できるアプリです。
主にアルバイトスタッフの勤怠管理を想定したアプリで、
「シフトの回収」→「作成」→「勤怠」→「給与」まで一括して管理できます。

# DEMO
![demo_2](https://github.com/Shu-Omura/shift_app/blob/images/public/demo_2.png)
![demo_1](https://github.com/Shu-Omura/shift_app/blob/images/public/demo_1.png)

# Features

登録が非常に簡単です。
管理者が作成した会社ページを登録(認証キーを入力)してもらうだけで完了です。

機能がシンプルなので直感的に使いやすいアプリです。

カレンダー形式で見やすく、従業員も従業員同士のシフトを見れるところが特徴です。
空き状況や誰がシフトを出してるかを各スタッフが見れることで、管理者側のシフト作成の手間を最小限に抑えることが可能です。

# Requirement
* ruby 2.7.1
* rails 6.0.3

# Install & Setup
```bash
git clone https://github.com/Shu-Omura/shift_app.git
cd shift_app
docker-compose up --build
```
# Author

* Shu Omura
* ohs6261@gmail.com

# License
[MIT license](https://en.wikipedia.org/wiki/MIT_License)
