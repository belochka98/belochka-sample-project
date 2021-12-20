<#import "parts/common.ftlh" as common>

<@common.page>
    <#if isCurrentUser>
        <#include "parts/messageEdit.ftlh" />
    </#if>

    <#include "parts/messagesList.ftlh" />
</@common.page>