[{block name="dd_widget_tile"}]
[{assign var="oTiles" value=$oView->getTiles()}]

[{if $oTiles|@count}]

<div id="tile" class="container">
    <div class="row">
        [{block name="dd_widget_tile_list"}]
        [{counter start=0 skip=2}]
        [{foreach from=$oTiles key="iPicNr" item="oTile" name="tileList"}]
        [{assign var="oCategory" value=$oTile->getCategory()}]
        [{assign var="sTilePictureUrl" value=$oTile->getPictureUrl()}]

        [{assign var="sTileTitle" value=$oTile->getTitle()}]

        [{if $sTilePictureUrl}]
        <div class="col">
            [{assign var="sTileLink" value=$oTile->getLink()}]

            [{if $sTileLink}]


            [{if !$sTileLink|strstr:$oView->getShopUrl()}]
            [{assign var="target" value="_blank"}]
            [{else}]
            [{assign var="target" value="_self"}]
            [{/if}]

            <a href="[{$sTileLink}]" target="[{$target}]" title="[{$sTileTitle}]">
                [{/if}]

                [{if $smarty.foreach.tileList.iteration is odd by 1}]

                    <img id="tileIMG[{$smarty.foreach.tileList.iteration}]" class="img-fluid tilesIMG"
                        src="[{$sTilePictureUrl}]" alt="[{$sTileTitle}]" title="[{$sTileTitle}]">
                    [{if $oViewConf->getViewThemeParam('blSliderShowImageCaption') && $sTileLink}]

                        <div id="tile[{$smarty.foreach.tileList.iteration}]" [{if isset($oTile->oxactions__oxcolor)}]style="background-color: [{$oTile->getColor()}]"[{/if}]>
                            <h3>[{$sTileTitle}]</h3>
                            [{if $oTile->oxactions__oxlongdesc->value|trim}]
                            <span>[{$oTile->oxactions__oxlongdesc->value|trim}]</span>
                            [{/if}]
                        </div>
                    [{/if}]
                [{else}]
                    [{if $oViewConf->getViewThemeParam('blSliderShowImageCaption') && $sTileLink}]

                        <div id="tile[{$smarty.foreach.tileList.iteration}]" [{if isset($oTile->oxactions__oxcolor)}]style="background-color: [{$oTile->getColor()}]"[{/if}]>
                            <h3>[{$sTileTitle}]</h3>
                            [{if $oTile->oxactions__oxlongdesc->value|trim}]
                            <span>[{$oTile->oxactions__oxlongdesc->value|trim}]</span>
                            [{/if}]
                        </div>
                    [{/if}]

                    <img id="tileIMG[{$smarty.foreach.tileList.iteration}]" class="img-fluid tilesIMG"
                        src="[{$sTilePictureUrl}]" alt="[{$sTileTitle}]" title="[{$sTileTitle}]">


                [{if $sTileLink}]
            </a>
            [{/if}]
            [{/if}]

        </div>
        [{/if}]
        [{/foreach}]
        [{/block}]
    </div>
</div>



[{/if}]
[{/block}]