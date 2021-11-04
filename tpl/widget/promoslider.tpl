[{block name="dd_widget_promoslider"}]
    [{assign var="oBanners" value=$oView->getBanners()}]
    [{assign var="currency" value=$oView->getActCurrency()}]

    [{if $oBanners|@count}]

    <div id="promo-carousel" class="flexslider">
        <ul class="slides">
            [{block name="dd_widget_promoslider_list"}]
            [{foreach from=$oBanners key="iPicNr" item="oBanner" name="promoslider"}]
            [{assign var="oArticle" value=$oBanner->getBannerObject()}]
            [{assign var="sBannerPictureUrl" value=$oBanner->getBannerPictureUrl()}]

            [{assign var="sBannerTitle" value=$oBanner->getBannerTitle()}]

            [{if $sBannerPictureUrl}]
            <li class="item">
                [{assign var="sBannerLink" value=$oBanner->getBannerLink()}]
                [{if $sBannerLink}]

                [{if !$sBannerLink|strstr:$oView->getShopUrl()}]
                [{assign var="target" value="_blank"}]
                [{else}]
                [{assign var="target" value="_self"}]
                [{/if}]

                <a href="[{$sBannerLink}]" target="[{$target}]" title="[{$oBanner->oxactions__oxtitle->value}]">
                    [{/if}]
                    <img src="[{$sBannerPictureUrl}]" alt="[{$oBanner->oxactions__oxtitle->value}]" title="[{$oBanner->oxactions__oxtitle->value}]">

                    [{if $sBannerLink}]
                </a>
                [{/if}]
                [{if $oViewConf->getViewThemeParam('blSliderShowImageCaption') && $oBanner->getBannerTitle()}]
                <p class="flex-caption">
                    [{if $sBannerLink}]
                    <a href="[{$sBannerLink}]" target="[{$target}]" class="flex-caption-link" title="[{$oBanner->getBannerTitle()}]">
                        [{/if}]
                        <span class="title" [{if $oBanner->getBannerTextColor() != null}]style="color: [{$oBanner->getBannerTextColor()}] !important"[{/if}]>[{$oBanner->getBannerTitle()}]</span>[{if $oBanner->getLongDesc()|trim}]<br/><span class="shortdesc">[{$oBanner->getLongDesc()|trim}]</span>[{/if}]
                        [{if $sBannerLink}]
                    </a>
                    [{/if}]
                </p>
                [{/if}]
            </li>
            [{/if}]
            [{/foreach}]
            [{/block}]
        </ul>
    </div>
    [{/if}]
    [{/block}]
