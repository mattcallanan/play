package blog

class Comment {
    String comment
    String user
    static belongsTo = Post

    static constraints = {
        comment()
        user()
    }
}
