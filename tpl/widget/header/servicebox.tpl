<div class="topPopList">
    [{block name="widget_header_servicebox_flyoutbox"}]
        <span class="lead">[{oxmultilang ident="ACCOUNT"}]</span>
        <hr class="solid">
        <div class="flyoutBox">
            <ul id="services" class="list-unstyled">
                [{block name="widget_header_servicebox_items"}]
                    <li>
                        <a href="[{oxgetseourl ident=$oViewConf->getSslSelfLink()|cat:"cl=account"}]">[{oxmultilang ident="MY_ACCOUNT"}]</a>
                    </li>
                    <li>
                        <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_order"}]"><span>[{oxmultilang ident="ORDER_HISTORY"}]</span></a>
                        [{if $oxcmp_user && $oxcmp_user->getOrderCount()}] <span class="badge">[{$oxcmp_user->getOrderCount()}]</span>[{/if}]
                    </li>
                    [{if $oViewConf->getShowWishlist()}]
                        <li>
                            <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_wishlist"}]"><span>[{oxmultilang ident="MY_GIFT_REGISTRY"}]</span></a>
                            [{if $oxcmp_user && $oxcmp_user->getWishListArtCnt()}] <span class="badge">[{$oxcmp_user->getWishListArtCnt()}]</span>[{/if}]
                        </li>
                    [{/if}]
                        <li>
                            <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_noticelist"}]"><span>[{oxmultilang ident="MY_WISH_LIST"}]</span></a>
                            [{if $oxcmp_user && $oxcmp_user->getNoticeListArtCnt()}] <span class="badge">[{$oxcmp_user->getNoticeListArtCnt()}]</span>[{/if}]
                        </li>
                    [{if $oViewConf->isFunctionalityEnabled( "blEnableDownloads" )}]
                        <li>
                            <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_downloads"}]"><span>[{oxmultilang ident="MY_DOWNLOADS"}]</span></a>
                        </li>
                    [{/if}]
                    [{if $oViewConf->getShowCompareList()}]
                        <li>
                            <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=compare"}]">[{oxmultilang ident="MY_PRODUCT_COMPARISON"}]</a> [{if $oView->getCompareItemsCnt()}]<span class="badge">[{$oView->getCompareItemsCnt()}]</span>[{/if}]
                        </li>
                    [{/if}]
                [{/block}]
            </ul>
        </div>
    [{/block}]
</div>