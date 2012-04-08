<%@ page import="blog.Comment" %>



<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'comment', 'error')} ">
	<label for="comment">
		<g:message code="comment.comment.label" default="Comment" />
		
	</label>
	<g:textField name="comment" value="${commentInstance?.comment}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentInstance, field: 'user', 'error')} ">
	<label for="user">
		<g:message code="comment.user.label" default="User" />
		
	</label>
	<g:textField name="user" value="${commentInstance?.user}"/>
</div>

