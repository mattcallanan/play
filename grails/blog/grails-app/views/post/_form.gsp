<%@ page import="blog.Post" %>



<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'subject', 'error')} ">
	<label for="subject">
		<g:message code="post.subject.label" default="Subject" />
		
	</label>
	<g:textField name="subject" value="${postInstance?.subject}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="post.content.label" default="Content" />
		
	</label>
	<g:textField name="content" value="${postInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="post.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${postInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: postInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="post.comments.label" default="Comments" />
		
	</label>
	<g:select name="comments" from="${blog.Comment.list()}" multiple="multiple" optionKey="id" size="5" value="${postInstance?.comments*.id}" class="many-to-many"/>
</div>

