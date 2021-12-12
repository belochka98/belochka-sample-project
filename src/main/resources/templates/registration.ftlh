<#import "parts/common.ftlh" as common>
<#import "parts/login.ftlh" as login>

<@common.page>
    Add new user
    ${message?ifExists}
    <@login.login "/registration" true/>
</@common.page>
