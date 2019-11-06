class Party < ApplicationRecord
    MONSTER_LIMIT = 1 # 1パーティあたりのモンスター数上限。今は1

 attr_reader :id, :monster_model
 attr_accessor :user_monster_id

 #after_initialize -> {set_partyinfo(party_infok)}

 def set_partyinfo(party_info)
    puts party_info
 end

 def initialize(party_info)
    super
    
     @id = party_info["id"]
     @user_monster_id = party_info["user_monster_id"] #現仕様では1パーティにつき一体だけ
     @monster_model = party_info["monster_model"]
 end

# To do 真面目に綺麗に書く
def self.get(user_id)
tmp_party_list = {}

tmp_monster = nil

# 最終的にreturnするpartyモデルの配列を作成するためのhashの雛形 
tmp_party_list = {}

parties = Party.where(user_id: user_id).limit(3)
#仕様としてpartyの数は3としてる。
user_monster_ids = []
parties.each do |row|
    tmp_party_list[row.attributes["id"]] = {
        row.attributes["user_monster_id"] => tmp_monster
    }

    user_monster_ids << row.attributes["user_monster_id"]
end

user_monster = User_monster.where(id: user_monster_ids).limit(3)


tmp_party_list.each.with_index do |(k1,v1), i|
   v1.each.with_index do |(k2,v2), j|
        tmp_party_list[k1][k2] = user_monster[i*MONSTER_LIMIT + j] # where in で取ってくる順番と partylistの順番が同じ前提。さもなければpartyごとにuser_monsterをselectする必要がある
   end
end

monster_ids = []
monster_ids = user_monster.map do |row|
    row.monster_id
end

monsters = Monster.where(id: monster_ids)

#monster_ids = monster_ids.group_by(&:itself).map{ |key, value| [key, value.count] }.to_h
# {5 => 1, 3 => 2}の形にする（重複がある時の下記ループの生合成保証ため）


tmp_monster_relation = {}
monsters.each do |row|
        tmp_monster_relation[row.attributes["id"]] = row
end

tmp_party_list.each do |k1, v1|
    v1.each do |k2, v2|
        binding.pry

        v1[k2] = tmp_monster_relation[v2.monster_id].clone()
    end
end

parties_for_return = {}
party_info = {}

# ↓　1パーティ1体という仕様じゃなくなったら改造が必要
tmp_party_list.each do |k1, v1|
    v1.each do |k2, v2|
        party_info["id"] = k1
        party_info["user_monster_id"] = k2
        party_info["monster_model"] = v2
    end
    parties_for_return[k1] = Party.new(party_info)
end

return parties_for_return

end

# ユーザ新規登録時のみ叩かれる
def self.init(user_id, possession_monster_id)
 sql_transaction = SQL_transaction.instance.sql

 statement = sql_transaction.prepare("insert into party(user_id, possession_monster_id) values(?,?),(?,?),(?,?)")
 result = statement.execute(user_id,possession_monster_id,user_id,possession_monster_id,user_id,possession_monster_id)
 statement.close
end


def set(possession_monster_id)
 sql_transaction = SQL_transaction.instance.sql
 sql_master = SQL_master.instance.sql

 statement1 = sql_transaction.prepare("select monster_id from user_monster where id = ? and user_id = ? limit 1")
 result1 = statement1.execute(possession_monster_id, @user_id)

 Validator.validate_SQL_error(result1.count, is_multi_line: false)

 statement2 = sql_master.prepare("select * from monsters where id = ? limit 1")
 result2 = statement2.execute(result1.first()["monster_id"])

 Validator.validate_SQL_error(result2.count, is_multi_line: false)

 @monster_model = Monster.new(result2.first())
 @possession_monster_id = possession_monster_id

 statement1.close()
 statement2.close()
end

# init時に3枠が確保され、insertは使わずupdateだけが使われる仕様
def save()
 sql_transaction = SQL_transaction.instance.sql

 statement = sql_transaction.prepare("update party set possession_monster_id = ? where id = ?")
 statement.execute(@possession_monster_id, @id)
 statement.close()
end

end