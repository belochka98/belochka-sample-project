<a class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false"
   aria-controls="collapseExample">
    Message editor
</a>

<div class="collapse <#if message??>show</#if>" id="collapseExample">
    <div class="mt-1 card card-body bg-success p-2 text-dark bg-opacity-25">
        <form method="post" enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <input type="hidden" name="id" value="<#if message?? && message.id?has_content>${message.id}</#if>"/>

            <input type="text"
                   class="mb-1 form-control ${(textError??)?string('is-invalid', '')}"
                   value="<#if message??>${message.text}</#if>"
                   name="text"
                   placeholder="Введите сообщение"
                   id="exampleFormControlTextarea1"
                   rows="3"
            >
            <#if textError??>
                <div class="invalid-feedback">
                    ${textError}
                </div>
            </#if>

            <div class="mb-1 form-group">
                <input type="text" class="form-control" name="tag" placeholder="Тэг">
            </div>

            <div class="input-group mb-1 w-50">
                <input type="file" name="file" class="form-control" id="inputGroupFile04"
                       aria-describedby="inputGroupFileAddon04" aria-label="Upload">
                <button type="submit" class="mx-2 btn btn-primary">Save message</button>
            </div>
        </form>
    </div>
</div>