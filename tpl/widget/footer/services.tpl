[{block name="footer_services"}]
    <ul class="services list-unstyled">
        [{block name="footer_services_items"}]
        <li><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account"}]">[{oxmultilang ident="ACCOUNT"}]</a></li>
        [{if $oxcmp_user}]
            [{if $oView->isActive('Invitations')}]
                <li><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=invite"}]">[{oxmultilang ident="INVITE_YOUR_FRIENDS"}]</a></li>
            [{/if}]
            [{oxhasrights ident="TOBASKET"}]
                [{block name="footer_services_cart"}]


            <li>
                <a href="[{oxgetseourl ident=$oViewConf->getBasketLink()}]">
                            [{oxmultilang ident="CART"}]
                </a>
                [{if $oxcmp_basket && $oxcmp_basket->getItemsCount() > 0}] <span class="badge">[{$oxcmp_basket->getItemsCount()}]</span>[{/if}]
            </li>

                [{/block}]
            [{/oxhasrights}]
            <li>
                <a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_noticelist"}]">
                    [{oxmultilang ident="WISH_LIST"}]
                </a>
                [{if $oxcmp_user && $oxcmp_user->getNoticeListArtCnt()}] <span class="badge">[{$oxcmp_user->getNoticeListArtCnt()}]</span>[{/if}]
            </li>
            [{if $oView->isEnabledDownloadableFiles()}]
                <li><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_downloads"}]">[{oxmultilang ident="MY_DOWNLOADS"}]</a></li>
            [{/if}]
        [{/if}]

                <li><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=contact"}]">[{oxmultilang ident="CONTACT"}]</a></li>
            [{if $oViewConf->getViewThemeParam('blFooterShowHelp')}]
                <li><a href="[{$oViewConf->getHelpPageLink()}]">[{oxmultilang ident="HELP"}]</a></li>
            [{/if}]
            [{if $oViewConf->getViewThemeParam('blFooterShowLinks')}]
                <li><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=links"}]">[{oxmultilang ident="LINKS"}]</a></li>
            [{/if}]
        [{/block}]
    </ul>
[{/block}]