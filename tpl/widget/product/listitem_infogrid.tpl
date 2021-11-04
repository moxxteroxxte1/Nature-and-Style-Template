[{block name="widget_product_listitem_infogrid"}]
    [{assign var="product"         value=$oView->getProduct()}]
    [{assign var="blDisableToCart" value=$oView->getDisableToCart()}]
    [{assign var="iIndex"          value=$oView->getIndex()}]
    [{assign var="showMainLink"    value=$oView->getShowMainLink()}]

    [{assign var="currency" value=$oView->getActCurrency()}]
    [{if $showMainLink}]
        [{assign var='_productLink' value=$product->getMainLink()}]
    [{else}]
        [{assign var='_productLink' value=$product->getLink()}]
    [{/if}]
    [{assign var="aVariantSelections" value=$product->getVariantSelections(null,null,1)}]
    [{assign var="blShowToBasket" value=true}] [{* tobasket or more info ? *}]
    [{if !$oxcmp_user || $blDisableToCart || $product->isNotBuyable() || ($aVariantSelections&&$aVariantSelections.selections) || $product->hasMdVariants() || ($oViewConf->showSelectListsInList() && $product->getSelections(1)) || $product->getVariants()}]
        [{assign var="blShowToBasket" value=false}]
    [{/if}]

    [{if !$testid }]
        [{assign var=testid value=$oView->getViewParameter('testid')}]
    [{/if}]
    [{if !$listId }]
        [{assign var=listId value=$oView->getViewParameter('listId')}]
    [{/if}]

    <form name="tobasket[{$testid}]" [{if $blShowToBasket}]action="[{$oViewConf->getSelfActionLink()}]" method="post"[{else}]action="[{$_productLink}]" method="get"[{/if}]>
        <div class="hidden">
            [{$oViewConf->getNavFormParams()}]
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="pgNr" value="[{$oView->getActPage()}]">
            [{if $recommid}]
                <input type="hidden" name="recommid" value="[{$recommid}]">
            [{/if}]
            [{if $blShowToBasket}]
                [{oxhasrights ident="TOBASKET"}]
                    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
                [{if $owishid}]
                    <input type="hidden" name="owishid" value="[{$owishid}]">
                [{/if}]
                [{if $toBasketFunction}]
                    <input type="hidden" name="fnc" value="[{$toBasketFunction}]">
                [{else}]
                    <input type="hidden" name="fnc" value="tobasket">
                [{/if}]
                    <input type="hidden" name="aid" value="[{$product->oxarticles__oxid->value}]">
                [{if $altproduct}]
                    <input type="hidden" name="anid" value="[{$altproduct}]">
                [{else}]
                    <input type="hidden" name="anid" value="[{$product->oxarticles__oxnid->value}]">
                [{/if}]
                [{if $oxcmp_user && $oxcmp_user->inGroup('oxiddealer') && $product->oxarticles__oxamountinpu->value}]
                    <input type="hidden" name="am" value="[{$product->oxarticles__oxpackagingunit->value}]">
                [{else}]
                    <input type="hidden" name="am" value="1">
                [{/if}]
                [{/oxhasrights}]
            [{else}]
                <input type="hidden" name="cl" value="details">
                <input type="hidden" name="anid" value="[{$product->oxarticles__oxnid->value}]">
            [{/if}]

        </div>

        <div class="row">
            <div class="col-12 col-lg-5">
                [{block name="widget_product_listitem_infogrid_gridpicture"}]
                    <div class="picture text-center">
                        <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                            <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$product->getThumbnailUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]" class="img-fluid">
                        </a>
                    </div>
                [{/block}]
            </div>
            <div class="col-12 col-lg-7">
                <div class="listDetails">
                    [{block name="widget_product_listitem_infogrid_titlebox"}]
                        <div class="title">
                            <a id="[{$testid}]" href="[{$_productLink}]" class="title" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                                <span>[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]</span>
                            </a>
                        </div>
                    [{/block}]

                    [{if $product->isNew()}]
                        <div>
                            <p class="new">[{oxmultilang ident="ARTICLE_NEW_BADGE"}]</p>
                        </div>
                    [{/if}]

                    [{block name="widget_product_listitem_infogrid_shortdesc"}]
                        <div class="shortdesc">
                            [{$product->oxarticles__oxshortdesc->rawValue}]
                        </div>
                    [{/block}]

                    [{block name="widget_product_listitem_infogrid_selections"}]
                        [{if $aVariantSelections && $aVariantSelections.selections }]
                            <div id="variantselector_[{$iIndex}]" class="selectorsBox variant-dropdown js-fnSubmit clear">
                                [{foreach from=$aVariantSelections.selections item=oSelectionList key=iKey}]
                                    [{include file="widget/product/selectbox.tpl" oSelectionList=$oSelectionList sJsAction="js-fnSubmit" blHideLabel=true}]
                                [{/foreach}]
                            </div>
                        [{elseif $oViewConf->showSelectListsInList()}]
                            [{assign var="oSelections" value=$product->getSelections(1)}]
                            [{if $oSelections}]
                                <div id="selectlistsselector_[{$iIndex}]" class="selectorsBox js-fnSubmit clear">
                                    [{foreach from=$oSelections item=oList name=selections}]
                                        [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop" sJsAction="js-fnSubmit" blHideLabel=true}]
                                    [{/foreach}]
                                </div>
                            [{/if}]
                        [{/if}]
                    [{/block}]

                    [{if $oxcmp_user}]
                    <div class="price">
                        <div class="content">
                            [{block name="widget_product_listitem_infogrid_price"}]
                                [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                [{assign var="oUnitPrice" value=$product->getUnitPrice()}]
                                [{assign var="tprice"     value=$product->getTPrice()}]
                                [{assign var="price"      value=$product->getPrice()}]

                                <input type="hidden" name="brutto" value="[{$price->getBruttoPrice()}]">
                                <input type="hidden" name="vat_value" value="[{$price->getVatValue()}]">

                                    [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                        <span class="oldPrice text-muted">
                                            <del>[{$product->getFTPrice()}] [{$currency->sign}]</del>
                                        </span>
                                    [{/if}]

                                    [{block name="widget_product_listitem_infogrid_price_value"}]
                                        [{if $product->getFPrice()}]
                                            <span class="lead text-nowrap">
                                            [{if $product->isRangePrice()}]
                                                [{oxmultilang ident="PRICE_FROM"}]
                                                [{if !$product->isParentNotBuyable()}]
                                                    [{$product->getFMinPrice()}]
                                                [{else}]
                                                    [{$product->getFVarMinPrice()}]
                                                [{/if}]
                                            [{else}]
                                                [{if !$product->isParentNotBuyable()}]
                                                    [{$product->getFPrice()}]
                                                [{else}]
                                                    [{$product->getFVarMinPrice()}]
                                                [{/if}]
                                            [{/if}]
                                            [{$currency->sign}]
                                            [{if $oView->isVatIncluded()}]
                                                [{if !($product->hasMdVariants() || ($oViewConf->showSelectListsInList() && $product->getSelections(1)) || $product->getVariants())}]*[{/if}]
                                            [{/if}]
                                        </span>
                                        [{/if}]
                                    [{/block}]
                                    [{if $oUnitPrice}]
                                        <span id="productPricePerUnit_[{$testid}]" class="pricePerUnit">
                                            [{$product->oxarticles__oxunitquantity->value}] [{$product->getUnitName()}] | [{oxprice price=$oUnitPrice currency=$currency}]/[{$product->getUnitName()}]
                                        </span>
                                    [{/if}]
                                [{/oxhasrights}]
                            [{/block}]
                        </div>
                    </div>
                    [{/if}]
                    
                    [{block name="widget_product_listitem_infogrid_tobasket"}]
                        <div class="actions">
                            <div class="btn-group">
                                [{if $blShowToBasket}]
                                    [{oxhasrights ident="TOBASKET"}]
                                [{if $product->getStock() > 0 || $oxcmp_user->inGroup('oxiddealer')}]
                                [{assign var="ident" value="TO_CART"}]
                                [{else}]
                                [{assign var="ident" value="PRE_ORDER"}]
                                [{/if}]
                                <button type="submit" class="btn btn-outline-dark hasTooltip" aria-label="[{oxmultilang ident=$ident}]" data-placement="bottom" title="[{oxmultilang ident=$ident}]" data-container="body">
                                    <i class="fa fa-shopping-cart"></i>
                                </button>
                                    [{/oxhasrights}]
                                    <a class="btn btn-primary" href="[{$_productLink}]" >[{oxmultilang ident="MORE_INFO"}]</a>
                                [{else}]
                                    <a class="btn btn-primary" href="[{$_productLink}]" >[{oxmultilang ident="MORE_INFO"}]</a>
                                [{/if}]
                            </div>
                        </div>
                    [{/block}]
                </div>
            </div>
        </div>
    </form>
[{/block}]
