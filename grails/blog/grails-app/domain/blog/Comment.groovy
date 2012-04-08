package blog

class Comment {
    String comment
    String user

    static constraints = {
        comment()
        user()
    }
}
