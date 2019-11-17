class Party < ApplicationRecord
    MONSTER_LIMIT = 1 # 1パーティあたりのモンスター数上限。今は1
    NUMBER_OF_PARTIES_PER_USER = 3

 attr_accessor :user_monster_id, :id, :monster_model

 #after_initialize -> {set_partyinfo(party_infok)}


 def initialize(party_info)
    super

    self[:id] = party_info["id"] unless party_info["id"].nil?
    self[:user_id] = party_info["user_id"]
    self[:user_monster_id] = party_info["user_monster_id"] #現仕様では1パーティにつき一体だけ

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
user_monster= []

parties.each do |row|
    tmp_party_list[row.attributes["id"]] = {
        row.attributes["user_monster_id"] => tmp_monster
    }

    # あまりやりたくないが、一発で抜けてかつ軽量なSQLが思う位浮かばないのでpartyごとにselect
    user_monster << User_monster.where(id: row.attributes["user_monster_id"]).limit(1)
end



tmp_party_list.each.with_index do |(k1,v1), i|
   v1.each.with_index do |(k2,v2), j|
        tmp_party_list[k1][k2] = user_monster[i*MONSTER_LIMIT + j] # where in で取ってくる順番と partylistの順番が同じ前提。さもなければpartyごとにuser_monsterをselectする必要がある
   end
end


monster_ids = []
monster_ids = user_monster.map do |row|
    row[0].monster_id #パーティの仕様が変わったらここはeachにする
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
        v1[k2] = tmp_monster_relation[v2[0].monster_id].clone()
    end
end

parties_for_return = {}
party_info = {}
party_info["user_id"] = user_id

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
def self.init(user_id, user_monster_id)
    array = []

    party_info = {}
    party_info["user_id"] = user_id
    party_info["user_monster_id"] = user_monster_id
    NUMBER_OF_PARTIES_PER_USER.times do |row|
        array << Party.new(party_info)
    end

    # ⤵︎本当はバルクインサートしたいが、id(オートインクリメント分)を除外してinsertするやり方わからん
    # Party.import(array)

    array.each do |row|
        party = Party.new(party_info)
        party.save()
    end
end


def set(user_monster_id)
    if User_monster.find(user_monster_id).count === 0
        raise "それpartyにできない"
    end

    self[:user_monster_id] = user_monster_id
    
    save()
end



end