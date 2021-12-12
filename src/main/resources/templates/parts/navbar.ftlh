<#include "security.ftlh">
<#import "login.ftlh" as login>

<nav class="navbar navbar-expand-lg navbar-light" style="background-color: #e3f2fd">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Navbar</a>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav">
                <a class="nav-link active" aria-current="page" href="#">Home</a>
                <#if isAdmin>
                    <a class="nav-link" href="/user">User List</a>
                </#if>
                <#if user??>
                    <a class="nav-link" href="/main">Messages</a>
                    <a class="nav-link" href="/userMessages/${currentUserId}">My messages</a>
                </#if>
            </div>
        </div>

        <div class="d-flex">
            <#if user??><a class="navbar-item align-middle m-2" href="/user/profile">${name}</a></#if>
            <form action="/logout" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button class="btn btn-outline-success" type="submit"><#if user??>Sign Out<#else>Log in</#if></button>
            </form>
        </div>
    </div>
</nav>
