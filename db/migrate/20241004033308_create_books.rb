class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title    # 本のタイトル
      t.text :body       # 感想
      t.references :user, foreign_key: true # ユーザーと関連付けるためのuser_id

      t.timestamps
    end
  end
end
