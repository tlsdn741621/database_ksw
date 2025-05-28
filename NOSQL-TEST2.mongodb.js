db.createCollection('logs', { capped: true, size: 5000 })






for (let i = 0; i < 1000; i++) {
    db.logs.insertOne({
        message: `로그 메시지 ${i}`,
        timestamp: new Date(),
    })
}

db.logs.find();








db.users.insertOne({
    name: '강신우',
    birth: '1996-03-23',
    favorite: ['햄버거', '피자'],
    regdate: new Date()
})

db.users.updateOne(
    { name: '강신우' }, // 조건
    { $set: { favorite: ['햄버거', '돼지국밥'] } }// 수정할 값
)

db.users.deleteOne({ name: '강신우' })


db.users.find();