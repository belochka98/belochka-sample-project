<#include "security.ftlh">
<#import "userAccount.ftlh" as login>

<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd">
    <div class="container-fluid">
        <a class="navbar-brand" href="/main">Navbar</a>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link active" aria-current="page" href="/main">Home</a>

                <#if isAdmin>
                    <a class="nav-link" href="/userList">User List</a>
                </#if>

                <#if user??>
                    <a class="nav-link" href="/messagesList">Messages</a>
                    <a class="nav-link" href="/userMessages/${currentUserId}">My messages</a>
                </#if>
            </div>
        </div>

        <div class="d-flex">
            <#if user??>
                <a class="navbar-item align-middle m-2" href="/userProfile/${currentUserId}">${name}</a>
            </#if>

            <form action="/logout" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button class="btn btn-outline-success" type="submit"><#if user??>Sign Out<#else>Log in</#if></button>
            </form>
        </div>
    </div>
</nav>
