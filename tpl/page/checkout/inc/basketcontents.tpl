[{* basket contents *}]
[{*oxscript include="js/widgets/oxbasketchecks.min.js" priority=10*}]
[{*oxscript add="$('#checkAll, #basketRemoveAll').oxBasketChecks();"*}]
[{oxscript add="$('input,select,textarea').not('[type=submit]').jqBootstrapValidation();"}]
[{assign var="currency" value=$oView->getActCurrency()}]

<form name="basket[{$basketindex}]" id="basket_form" action="[{$oViewConf->getSelfActionLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="cl" value="basket">
    <input type="hidden" name="fnc" value="changebasket">
    <input type="hidden" name="CustomError" value="basket">

    <div class="basket" id="basketcontents_list">
        [{block name="checkout_basketcontents_list"}]
        [{include file="page/checkout/inc/basketcontents_list.tpl"}]
        [{/block}]
    </div>

</form>
[{include file="page/checkout/inc/basketsummary.tpl"}]
