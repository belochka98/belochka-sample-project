<#import "parts/common.ftlh" as common>
<#import "parts/userAccount.ftlh" as account>

<@common.page false>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
        <div class="alert alert-danger" role="alert">
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
    </#if>

    <#if message??>
        <div class="alert alert-${messageType}" role="alert">
            ${message}
        </div>
    </#if>

    <@account.form "/login" true/>
</@common.page>
