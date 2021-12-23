<#import "parts/common.ftlh" as common>

<@common.page>
    <form method="get" action="/messagesList">
        <div class="input-group mb-3">
            <button class="btn btn-primary" type="submit" id="button-addon1">Search</button>
            <div class="form-floating form-floating-group flex-grow-1">
                <input type="text"
                       name="filter"
                       value="${filter?ifExists}"
                       class="form-control"
                       id="floatingInput"
                       placeholder="Search by text">
                <label for="floatingInput">Search by text</label>
            </div>
        </div>
    </form>

    <#include "parts/messageEdit.ftlh" />

    <#include "parts/messagesList.ftlh" />
</@common.page>