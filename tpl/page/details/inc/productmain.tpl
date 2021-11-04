[{assign var="oConfig" value=$oViewConf->getConfig()}]
[{assign var="oManufacturer" value=$oView->getManufacturer()}]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]

    [{assign var="isLoggedIn" value=false}]
    [{assign var="blDisableToCart" value=false}]

    [{if $oxcmp_user != NULL}]
        [{assign var="isLoggedIn" value=true}]
    [{else}]
        [{assign var="blDisableToCart" value=true}]
    [{/if}]

[{if $aVariantSelections && $aVariantSelections.rawselections && $isLoggedIn}]
    [{assign var="_sSelectionHashCollection" value=""}]
    [{foreach from=$aVariantSelections.rawselections item=oSelectionList key=iKey}]
    [{assign var="_sSelectionHash" value=""}]
    [{foreach from=$oSelectionList item=oListItem key=iPos}]
    [{assign var="_sSelectionHash" value=$_sSelectionHash|cat:$iPos|cat:":"|cat:$oListItem.hash|cat:"|"}]
    [{/foreach}]
    [{if $_sSelectionHash}]
    [{if $_sSelectionHashCollection}][{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:","}][{/if}]
    [{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:"'`$_sSelectionHash`'"}]
    [{/if}]
    [{/foreach}]
    [{oxscript add="oxVariantSelections  = [`$_sSelectionHashCollection`];"}]

    <form class="js-oxWidgetReload" action="[{$oView->getWidgetLink()}]" method="get">
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="cl" value="[{$oView->getClassName()}]">
        <input type="hidden" name="oxwparent" value="[{$oViewConf->getTopActiveClassName()}]">
        <input type="hidden" name="listtype" value="[{$oView->getListType()}]">
        <input type="hidden" name="nocookie" value="1">
        <input type="hidden" name="cnid" value="[{$oView->getCategoryId()}]">
        <input type="hidden" name="anid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
        <input type="hidden" name="actcontrol" value="[{$oViewConf->getTopActiveClassName()}]">
        [{if $oConfig->getRequestParameter('preview')}]
    <input type="hidden" name="preview" value="[{$oConfig->getRequestParameter('preview')}]">
        [{/if}]
    </form>
    [{/if}]

[{oxhasrights ident="TOBASKET"}]
<form class="js-oxProductForm" action="[{$oViewConf->getSelfActionLink()}]" method="post">
    <div class="hidden">
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
        <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
        <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
        <input type="hidden" name="parentid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
        <input type="hidden" name="panid" value="">
        [{if !$oDetailsProduct->isNotBuyable()}]
    <input type="hidden" name="fnc" value="tobasket">
        [{/if}]
    </div>
    [{/oxhasrights}]

    <div class="details-info" itemscope itemtype="http://schema.org/Product">
        <div class="row">
            <div class="col-12 col-md-4 details-col-left">

                [{* article picture with zoom *}]
                [{block name="details_productmain_zoom"}]
                [{oxscript include="js/libs/photoswipe.min.js" priority=8}]
                [{oxscript include="js/libs/photoswipe-ui-default.min.js" priority=8}]
                [{oxscript add="\$( document ).ready( function() { Wave.initDetailsEvents(); });"}]

                [{* Wird ausgeführt, wenn es sich um einen AJAX-Request handelt *}]
                [{if $blWorkaroundInclude}]
                [{oxscript add="$( document ).ready( function() { Wave.initEvents();});"}]
                [{/if}]

                [{if $oView->showZoomPics()}]
                [{* ToDo: This logical part should be ported into a core function. *}]
                [{if $oConfig->getConfigParam('sAltImageUrl') || $oConfig->getConfigParam('sSSLAltImageUrl')}]
                [{assign var="aPictureInfo" value=$oPictureProduct->getMasterZoomPictureUrl(1)|@getimagesize}]
                [{else}]
                [{assign var="sPictureName" value=$oPictureProduct->oxarticles__oxpic1->value}]
                [{assign var="aPictureInfo" value=$oConfig->getMasterPicturePath("product/1/`$sPictureName`")|@getimagesize}]
                [{/if}]

                <div class="picture details-picture">
                    <a class="details-picture-link" href="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]" id="zoom1"[{if $aPictureInfo}] data-width="[{$aPictureInfo.0}]" data-height="[{$aPictureInfo.1}]"[{/if}]>
                        <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]" itemprop="image" class="img-fluid">
                    </a>
                </div>
                [{else}]
                <div class="picture details-picture">
                    <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]" itemprop="image" class="img-fluid">
                </div>
                [{/if}]
                [{/block}]

                [{block name="details_productmain_morepics"}]
                [{include file="page/details/inc/morepics.tpl"}]
                [{/block}]
            </div>

            <div class="col-12 col-sm-8 col-md-5 col-lg-6 details-col-middle">
                [{block name="details_productmain_title"}]
                <h1 id="productTitle" class="details-title" itemprop="name">
                    [{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]
                </h1>
                [{/block}]

                [{* article number *}]
                [{block name="details_productmain_artnumber"}]
                <span class="small text-muted">[{oxmultilang ident="ARTNUM" suffix="COLON"}] [{$oDetailsProduct->oxarticles__oxartnum->value}]</span>
                [{/block}]

                [{* ratings *}]
                [{if $oView->ratingIsActive()}]
                [{block name="details_productmain_ratings"}]
                [{include file="widget/reviews/rating.tpl" itemid="anid=`$oDetailsProduct->oxarticles__oxnid->value`" sRateUrl=$oDetailsProduct->getLink()}]
                [{/block}]
                [{/if}]

                [{* short description *}]
                [{block name="details_productmain_shortdesc"}]
                [{oxhasrights ident="SHOWSHORTDESCRIPTION"}]
                [{if $oDetailsProduct->oxarticles__oxshortdesc->rawValue}]
                <p class="details-shortdesc" id="productShortdesc" itemprop="description">[{$oDetailsProduct->oxarticles__oxshortdesc->rawValue}]</p>
                [{/if}]
                [{/oxhasrights}]
                [{/block}]

                [{* article main info block *}]
                <div class="details-information[{if $oManufacturer->oxmanufacturers__oxicon->value}] hasBrand[{/if}]" itemprop="offers" itemscope itemtype="http://schema.org/Offer">

                    [{* additional info *}]

                    [{oxhasrights ident="SHOWARTICLEPRICE"}]
                    [{assign var="oUnitPrice" value=$oDetailsProduct->getUnitPrice()}]
                    [{block name="details_productmain_priceperunit"}]
                    [{if $oUnitPrice}]
                    <div class="details-additional-information">
                        <span id="productPriceUnit">[{oxprice price=$oUnitPrice currency=$currency}]/[{$oDetailsProduct->getUnitName()}]</span>
                    </div>
                    [{/if}]
                    [{/block}]
                    [{/oxhasrights}]

                    [{block name="details_productmain_vpe"}]
                    [{if $oDetailsProduct->oxarticles__oxvpe->value > 1}]
                    <span class="vpe small">[{oxmultilang ident="DETAILS_VPE_MESSAGE_1"}] [{$oDetailsProduct->oxarticles__oxvpe->value}] [{oxmultilang ident="DETAILS_VPE_MESSAGE_2"}]</span>
                    [{/if}]
                    [{/block}]

                    [{assign var="blCanBuy" value=$isLoggedIn}][{*true*}]
                    [{* variants | md variants *}]
                    [{block name="details_productmain_variantselections"}]
                    [{if $aVariantSelections && $aVariantSelections.selections && $isLoggedIn}]
                    [{oxscript include="js/widgets/oxajax.min.js" priority=10 }]
                    [{oxscript include="js/widgets/oxarticlevariant.min.js" priority=10 }]
                    [{oxscript add="$( '#variants' ).oxArticleVariant();"}]
                    [{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
                    [{if !$blHasActiveSelections}]
                    [{if !$blCanBuy && !$oDetailsProduct->isParentNotBuyable()}]
                    [{assign var="blCanBuy" value=$isLoggedIn}] [{*true*}]
                    [{/if}]
                    [{/if}]
                    [{/if}]
                    <div id="variants" class="selectorsBox variant-dropdown js-fnSubmit">
                        [{assign var="blHasActiveSelections" value=false}]
                        [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                        [{if $oList->getActiveSelection()}]
                        [{assign var="blHasActiveSelections" value=true}]
                        [{/if}]
                        [{include file="widget/product/selectbox.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                        [{/foreach}]
                    </div>
                    [{/block}]

                    [{* selection lists *}]
                    [{block name="details_productmain_selectlists"}]
                    [{if $oViewConf->showSelectLists()}]
                    [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                    [{if $oSelections}]
                    <div class="selectorsBox variant-dropdown js-fnSubmit clear" id="productSelections">
                        [{foreach from=$oSelections item=oList name=selections}]
                        [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                        [{/foreach}]
                    </div>
                    [{/if}]
                    [{/if}]
                    [{/block}]


                    <div class="price-wrapper">
                        [{block name="details_productmain_tprice"}]
                        [{oxhasrights ident="SHOWARTICLEPRICE"}]
                        [{if $oDetailsProduct->getTPrice() AND $isLoggedIn}]
                        <del class="price-old">[{oxprice price=$oDetailsProduct->getTPrice() currency=$currency}]</del>
                    <br />
                        [{/if}]
                        [{/oxhasrights}]
                        [{/block}]

                        [{block name="details_productmain_watchlist"}][{/block}]

                        [{block name="details_productmain_price"}]
                        [{oxhasrights ident="SHOWARTICLEPRICE"}]
                        [{block name="details_productmain_price_value"}]
                        [{if $oDetailsProduct->getFPrice()  AND $isLoggedIn}]
                        <label id="productPrice" class="price-label">
                            [{assign var="sFrom" value=""}]
                            [{assign var="oPrice" value=$oDetailsProduct->getPrice()}]
                            [{if $oDetailsProduct->isParentNotBuyable()}]
                            [{assign var="oPrice" value=$oDetailsProduct->getVarMinPrice()}]
                            [{if $oDetailsProduct->isRangePrice()}]
                            [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                            [{/if}]
                            [{/if}]
                            <span[{if $oDetailsProduct->getTPrice()}] class="text-danger"[{/if}]>
                            <span class="price-from">[{$sFrom}]</span>
                            <span class="price">[{oxprice price=$oPrice currency=$currency}]</span>
                            [{if $oView->isVatIncluded()}]
                            <span class="price-markup">*</span>
                            [{/if}]
                            <span class="d-none">
                                                <span itemprop="price">[{$oPrice->getBruttoPrice()}]</span>
                                                <span itemprop="priceCurrency">[{$currency->name}]</span>
                                            </span>
                            </span>
                        </label>
                        [{/if}]
                        [{if $oDetailsProduct->loadAmountPriceInfo()}]
                        [{include file="page/details/inc/priceinfo.tpl"}]
                        [{/if}]
                        [{/block}]
                        [{/oxhasrights}]
                        [{/block}]
                    </div>
                </div>

                <div class="tobasket">
                    [{* pers params *}]
                    [{block name="details_productmain_persparams"}]
                    [{if $oView->isPersParam()}]
                    <div class="persparamBox clear form-group">
                        <label for="persistentParam" class="control-label">[{oxmultilang ident="LABEL"}]</label>
                        <input type="text" id="persistentParam" name="persparam[details]" value="[{$oDetailsProduct->aPersistParam.text}]" size="35" class="form-control">
                    </div>
                    [{/if}]
                    [{/block}]

                    [{block name="details_productmain_tobasket"}]
                    <div class="tobasketFunction tobasket-function">
                        [{oxhasrights ident="TOBASKET"}]
                        [{if !$oDetailsProduct->isNotBuyable()}]
                                [{if !$oxcmp_user}]

                                <div class="card m-3" style="height: auto !important;">
                                    <div class="card-header">
                                        <i class="fa fa-user"></i> <a id="reviewsLogin" rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl=details"|cat:$oViewConf->getNavUrlParams()}]">[{oxmultilang ident="MESSAGE_LOGIN_TO_ADD_CART"}]</a>
                                    </div>
                                </div>

                                [{else}]
                                    [{assign var="to_cart_ident" value="TO_CART_NOVARIANT"}]
                                    <div class="input-group tobasket-input-group">
                                    [{if !$oDetailsProduct->isUnique()}]
                                        [{if $oxcmp_user->inGroup('oxiddealer') && $oDetailsProduct->oxarticles__oxamountinpu->value}]
                                            [{assign var="unit" value=$oDetailsProduct->getPackagingUnit()}]
                                        [{else}]
                                            [{assign var="unit" value=1}]
                                        [{/if}]
                                        <input id="amountToBasket" type="number" name="am" value="[{$unit}]" min="[{$unit}]" step="[{$unit}]" autocomplete="off" class="form-control">
                                        <div class="input-group-append">
                                    [{else}]
                                        <input type="hidden" id="amountToBasket" type="text" name="am" value="1" autocomplete="off" class="form-control">
                                        <div>
                                    [{/if}]
                                            [{if $oDetailsProduct->getStock() > 0 || $oxcmp_user->inGroup('oxiddealer')}]
                                                [{assign var="ident" value="TO_CART"}]
                                            [{else}]
                                                [{assign var="ident" value="PRE_ORDER"}]
                                            [{/if}]
                                            <button id="toBasket" type="submit" [{if !$blCanBuy}]disabled="disabled"[{/if}] class="btn btn-primary submitButton" data-disabledtext="[{oxmultilang ident=$to_cart_ident}]"><i class="fa fa-shopping-cart"></i> [{oxmultilang ident=$ident}]</button>
                                        </div>
                                    </div>
                                [{/if}]
                        [{/if}]
                        [{/oxhasrights}]
                    </div>
                    [{/block}]

                    [{if $oxcmp_user && !$oxcmp_user->inGroup('oxiddealer')}]
                        [{block name="details_productmain_stockstatus"}]
                        [{if $oDetailsProduct->getStockStatus() == -1}]
                        <span class="stockFlag notOnStock">
                                <i class="fa fa-circle text-danger"></i>
                                [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
                                    <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                                    [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
                                [{elseif $oViewConf->getStockOffDefaultMessage()}]
                                    <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                                    [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                                [{/if}]
                                [{if $oDetailsProduct->getDeliveryDate()}]
                                    <link itemprop="availability" href="http://schema.org/PreOrder"/>
                                    [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
                                [{/if}]
                            </span>
                        [{elseif $oDetailsProduct->getStockStatus() == 1}]
                    <link itemprop="availability" href="http://schema.org/InStock"/>
                        <span class="stockFlag lowStock">
                                <i class="fa fa-circle text-warning"></i> [{oxmultilang ident="LOW_STOCK"}]
                            </span>
                        [{elseif $oDetailsProduct->getStockStatus() == 0}]
                        <span class="stockFlag">
                                <link itemprop="availability" href="http://schema.org/InStock"/>
                                <i class="fa fa-circle text-success"></i>
                                [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                                    [{$oDetailsProduct->oxarticles__oxstocktext->value}]
                                [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                    [{oxmultilang ident="READY_FOR_SHIPPING"}]
                                [{/if}]
                            </span>
                        [{/if}]
                        [{/block}]
                        [{if $oDetailsProduct->isCarrierShipping()}]
                            <lable style="display: inherit">
                                <span class="stockFlag">
                                    <i class="fas fa-truck"></i> &nbsp; [{oxmultilang ident="MARKED_SHIPPING"}]
                                </span>
                            </lable>
                        [{/if}]
                    [{/if}]

                    [{if $oDetailsProduct->oxarticles__oxamountinpu->value && $oxcmp_user && $oxcmp_user->inGroup('oxiddealer')}]
                        <div class="alert alert-warning mt-2 p-a">
                            <h5><span style="white-space: pre;">[{oxmultilang ident="PRODUCT_MAIN_PU_WARNINT"}] ([{$oDetailsProduct->oxarticles__oxpackagingunit->value}] [{$oDetailsProduct->oxarticles__oxunitname->value}])</span></h5>
                        </div>
                    [{/if}]

                    [{if $oDetailsProduct->getDiscounts()}]
                        <div class="alert alert-success mt-2 p-a">
                            <h5>[{oxmultilang ident="PRODUCT_MAIN_DISCOUNTS"}]</h5>
                        [{foreach from=$oDetailsProduct->getDiscounts() item="oDiscount"}]
                            <p><span style="white-space: pre;">[{$oDiscount->oxdiscount__oxtitle->value}] -[{$oDiscount->oxdiscount__oxaddsum->value}][{$oDiscount->oxdiscount__oxaddsumtype->value}] [{$oDiscount->oxdiscount__oxshortdesc->value}]</span></p>
                        [{/foreach}]
                        </div>
                     [{/if}]

                    [{oxhasrights ident="TOBASKET"}]
                    [{if $oDetailsProduct->isBuyable()}]
                    [{block name="details_productmain_deliverytime"}]
                    [{include file="page/details/inc/deliverytime.tpl"}]
                    [{/block}]
                    [{/if}]
                    [{/oxhasrights}]

                    [{block name="details_productmain_social"}]
                    [{/block}]
                </div>
            </div>

            <div class="col-12 col-sm-4 col-md-3 col-lg-2 details-col-right">
                [{if $oManufacturer}]
                <div class="brandLogo">
                    [{block name="details_productmain_manufacturersicon"}]
                    <a href="[{$oManufacturer->getLink()}]" title="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
                        [{if $oManufacturer->oxmanufacturers__oxicon->value}]
                    <img src="[{$oManufacturer->getIconUrl()}]" alt="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
                        [{/if}]
                    </a>
                    <span itemprop="brand" class="d-none">[{$oManufacturer->oxmanufacturers__oxtitle->value}]</span>
                    [{/block}]
                </div>
                [{/if}]

                [{block name="details_productmain_productlinksselector"}]
                [{block name="details_productmain_productlinks"}]
                <ul class="list-unstyled details-action-links">

                    [{if $oViewConf->getShowCompareList()}]
                    <li>
                        [{oxid_include_dynamic file="page/details/inc/compare_links.tpl" testid="" type="compare" aid=$oDetailsProduct->oxarticles__oxid->value anid=$oDetailsProduct->oxarticles__oxnid->value in_list=$oDetailsProduct->isOnComparisonList() page=$oView->getActPage() text_to_id="COMPARE" text_from_id="REMOVE_FROM_COMPARE_LIST"}]
                    </li>
                    [{/if}]


                    [{if $oViewConf->getShowSuggest()}]
                    <li>
                        <a id="suggest" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=suggest" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:$oViewConf->getNavUrlParams()}]">[{oxmultilang ident="RECOMMEND"}]</a>
                    </li>
                    [{/if}]


                    [{if $oViewConf->getShowListmania()}]
                    <li>
                        [{if $oxcmp_user}]
                        <a id="recommList" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=recommadd" params="aid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:$oViewConf->getNavUrlParams()|cat:"&amp;stoken="|cat:$oViewConf->getSessionChallengeToken()}]">[{oxmultilang ident="ADD_TO_LISTMANIA_LIST"}]</a>
                        [{else}]
                        <a id="loginToRecommlist" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]">[{oxmultilang ident="ADD_TO_LISTMANIA_LIST"}]</a>
                        [{/if}]
                    </li>
                    [{/if}]

                    <li>
                        [{if $oxcmp_user}]
                        <a id="linkToNoticeList" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl="|cat:$oViewConf->getTopActiveClassName() params="aid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;anid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;fnc=tonoticelist&amp;am=1"|cat:$oViewConf->getNavUrlParams()|cat:"&amp;stoken="|cat:$oViewConf->getSessionChallengeToken()}]">[{oxmultilang ident="ADD_TO_WISH_LIST"}]</a>
                        [{else}]
                        <a id="loginToNotice" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]">[{oxmultilang ident="ADD_TO_WISH_LIST"}]</a>
                        [{/if}]
                    </li>

                    [{if $oViewConf->getShowWishlist()}]
                    <li>
                        [{if $oxcmp_user}]
                        <a id="linkToWishList" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl="|cat:$oViewConf->getTopActiveClassName() params="aid=`$oDetailsProduct->oxarticles__oxnid->value`&anid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;fnc=towishlist&amp;am=1"|cat:$oViewConf->getNavUrlParams()|cat:"&amp;stoken="|cat:$oViewConf->getSessionChallengeToken()}]">[{oxmultilang ident="ADD_TO_GIFT_REGISTRY"}]</a>
                        [{else}]
                        <a id="loginToWish" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]">[{oxmultilang ident="ADD_TO_GIFT_REGISTRY"}]</a>
                        [{/if}]
                    </li>
                    [{/if}]

                    <li>
                        [{mailto extra='id="questionMail"' address=$oDetailsProduct->oxarticles__oxquestionemail->value|default:$oxcmp_shop->oxshops__oxinfoemail->value subject='QUESTIONS_ABOUT_THIS_PRODUCT'|oxmultilangassign|cat:" "|cat:$oDetailsProduct->oxarticles__oxartnum->value text='QUESTIONS_ABOUT_THIS_PRODUCT'|oxmultilangassign}]
                    </li>
                </ul>
                [{/block}]
                [{/block}]
            </div>
        </div>
    </div>

    [{oxhasrights ident="TOBASKET"}]
</form>
    [{/oxhasrights}]
