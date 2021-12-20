<#import "parts/common.ftlh" as common>

<@common.page>
    <table class="table table-sm bg-light">
        <thead>
        <tr>
            <th>Name</th>
            <th>EMail</th>
            <th>Active</th>
            <th>File Name</th>
            <th>Role</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td hidden id = "userId">${user.id}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.active?string}</td>
                <td>${user.filename!""}</td>
                <td>
                    <#list user.roles as role>${role}<#sep>, </#list>
                    <!-- ToDo: Edit Roles -->
                </td>
                <td><a href="/userProfile/${user.id}">Edit</a></td>
            </tr>
        </#list>
        </tbody>
    </table>
</@common.page>