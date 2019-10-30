# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Monster.create!([
{
    name: "inoue",
    hp: 10,
    atk: 1,
    def: 0,
    exp: 1,
    money: 1,
    rarity: 0,
    speed: 1,
    mp: 999999
},
{
    name: "inoue2",
    hp: 11,
    atk: 10,
    def: 0,
    exp: 3,
    money: 1,
    rarity: 1,
    speed: 2,
    mp: 99
},
{
    name: "inoue3",
    hp: 20,
    atk: 10,
    def: 1,
    exp: 10,
    money: 133,
    rarity: 2,
    speed: 3,
    mp: 99
},
{
    name: "ガチャで1%しか当たらないマン",
    hp: 100,
    atk: 15,
    def: 0,
    exp: 111,
    money: 123542,
    rarity: 3,
    speed: 99,
    mp: 0
},
{
    name: "合成マン",
    hp: 10,
    atk: 7,
    def: 0,
    exp: 1,
    money: 1,
    rarity: 1,
    speed: 1,
    mp: 9
},
])





Item.create!(
    name: "薬草",
    kind: 1,
    value: 100
)