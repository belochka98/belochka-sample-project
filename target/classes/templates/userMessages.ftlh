<#import "parts/common.ftlh" as common>

<@common.page>
    <#if isCurrentUser>
        <#include "parts/messageEdit.ftlh" />
    </#if>

    <#include "parts/messageList.ftlh" />
</@common.page>