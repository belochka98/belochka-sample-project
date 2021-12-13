<#include "security.ftlh">

<div class="card-columns">
    <#list messages as message>
        <div class="card my-3">
            <#if message.filename??>
                <img src="/img/${message.filename}" class="card-img-top">
            </#if>
            <div class="m-2">
                <span>${message.text}</span>
                <i>${message.tag}</i>
            </div>
            <div class="card-footer text-muted">${message.authorName}
            </div>
        </div>
        <div class="card-footer text-muted">
            <a href="/userMessages/${message.author.id}">${message.authorName}</a>
            <#if message.author.id == currentUserId>
                <a class="btn btn-primary" href="/userMessages/${message.author.id}?message=${message.id}">
                    Edit
                </a>
            </#if>
        </div>
    <#else>
        No message
    </#list>
</div>