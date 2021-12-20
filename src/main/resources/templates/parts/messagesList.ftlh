<#include "security.ftlh">

<#if messages??>
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <#list messages as message>
            <div>
                <div class="card my-3">
                    <div class="card-body">
                        <#if message.filename??>
                            <img src="/uploads/${message.filename}" class="card-img-top img-fluid rounded">
                        </#if>
                        <p class="card-text">
                            <span>${message.text}</span>
                            <i>${message.tag}</i>
                        </p>
                        <div class="card-footer text-muted">
                            Author: <a href="/userMessages/${message.author.id}">${message.authorName}</a>
                            <#if message.author.id == currentUserId>
                                <a class="btn btn-primary ms-1"
                                   href="/userMessages/${message.author.id}?message=${message.id}">
                                    Edit
                                </a>
                                <a class="btn btn-primary ms-1"
                                   href="/messagesList/${message.id}/del">
                                    Del
                                </a>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </#list>
    </div>
</#if>

<#if filter?has_content && !messages?has_content>
    <div class="d-inline p-2 my-3">
        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
            <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
                <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
            </symbol>
        </svg>
        <div class="alert alert-danger d-flex align-items-center w-80 p-3 m-3" role="alert">
            <svg class="bi flex-shrink-0 me-2 " width="24" height="24" role="img" aria-label="Danger:">
                <use xlink:href="#exclamation-triangle-fill"/>
            </svg>
            <div>
                <strong>Hey!</strong>
                Sorry, but the database does not contain the information you are looking for, try to put
                something else into the search bar
            </div>
        </div>
    </div>
</#if>