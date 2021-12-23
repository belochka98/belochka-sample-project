<#include "security.ftlh">
<#macro form path isLogIn>
    <form class="position-fixed top-50 start-50 translate-middle p-4 border border-4 border-primary rounded bg-light"
          action="${path}" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <div class="form-group row">
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">User Name</label>
                <input type="text"
                       name="username"
                       class="form-control"
                       placeholder="Put your user name"
                       <#if currentUserId gt 0>readonly</#if>
                       value="<#if user??>${user.username}</#if>"
                >
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
            <div class="mb-3">
                <label for="exampleInputPassword1" class="form-label ${(passwordError??)?string('is-invalid', '')}">Password</label>
                <input type="password" name="password"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       placeholder="Password"
                       id="exampleInputPassword1">
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>

        <#if !isLogIn>
            <div class="mb-3">
                <label for="exampleInputPassword1"
                       class="form-label ${(usernameError??)?string('is-invalid', '')}">Password</label>
                <input type="password" name="password_confirm"
                       class="form-control ${(password_confirmError??)?string('is-invalid', '')}"
                       placeholder="Retype password"
                       id="exampleInputPassword1">
                <#if password_confirmError??>
                    <div class="invalid-feedback">
                        ${password_confirmError}
                    </div>
                </#if>
            </div>
            <div class="mb-3">
                <label for="exampleInputEmail1" class="form-label">Email address</label>
                <input type="email"
                       name="email"
                       class="form-control ${(emailError??)?string('is-invalid', '')}"
                       id="exampleInputEmail1"
                       aria-describedby="emailHelp"
                       value="<#if user??>${user.email}</#if>"
                       placeholder="some@some.com">
                <#if emailError??>
                    <div class="invalid-feedback">
                        ${emailError}
                    </div>
                </#if>
            </div>
        </#if>

        <button class="btn btn-primary" type="submit">
            <#if isLogIn>
                Sign In
            <#else>
                <#if currentUserId??>
                    Save user account
                <#else>
                    Create user account
                </#if>
            </#if>
        </button>

        <#if isLogIn>
            <a class="btn btn-secondary btn-primary enabled"
               role="button"
               aria-disabled="true"
               href="/registration">Add new user</a>
        </#if>
    </form>
</#macro>