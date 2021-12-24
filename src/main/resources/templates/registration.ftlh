<#import "parts/common.ftlh" as common>
<#import "parts/userAccount.ftlh" as account>

<@common.page false>
    ${message?ifExists}

    <@account.form "/registration" false/>
</@common.page>
