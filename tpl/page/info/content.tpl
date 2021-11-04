[{capture append="oxidBlock_content"}]
    [{assign var="oContent" value=$oView->getContent()}]
    [{assign var="tpl" value=$oViewConf->getActTplName()}]
    [{assign var="oxloadid" value=$oViewConf->getActContentLoadId()}]
    [{assign var="template_title" value=$oView->getTitle()}]

    <h1 class="page-header">[{$template_title}]</h1>
    <article class="cmsContent">
        [{$oView->getParsedContent()}]
    </article>
    [{assign var="oSubCats" value=$oContent->getSubCats()}]
    [{if count($oSubCats) > 0}]
    <ul class="list-group link-group">
        [{foreach from=$oSubCats item=aCont}]
            [{foreach from=$aCont item=ocont}]
                <li class="list-group-item link-group-item"><a href="[{$ocont->getLink()}]">[{$ocont->getTitle()}]</a></li>
            [{/foreach}]
        [{/foreach}]
    </ul>
    [{/if}]

    [{insert name="oxid_tracker" title=$template_title}]
    [{/capture}]
[{include file="layout/page.tpl"}]