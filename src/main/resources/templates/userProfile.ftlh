<#import "parts/common.ftlh" as common>
<#import "parts/userAccount.ftlh" as account>
<#include "parts/security.ftlh">

<@common.page>
    <@account.form "/userProfile/${currentUserId}" false/>
</@common.page>