# profileカラムにJSON型を指定。
#
# 含める情報:
#   nickname: 4文字以上12文字以下の文字列
#   editor: 'vim' OR 'emacs'
#   website: URL形式の文字列
#
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.json :profile, null: false
    end
  end
end
