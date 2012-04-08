package blog

class Post {
    String subject
    String content
    Date date
    static hasMany = [comments: Comment]

    static constraints = {
        // Ordering constraint
        subject()
        content()
        date()
        comments()
    }
}
