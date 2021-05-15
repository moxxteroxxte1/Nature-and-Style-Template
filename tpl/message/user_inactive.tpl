[{capture append="oxidBlock_content"}]
    <p>[{oxifcontent ident="oxinactive" object="oCont"}]
        [{$oCont->oxcontents__oxcontent->value}]
        [{/oxifcontent}]</p>
    [{insert name="oxid_tracker"}]
    [{/capture}]

[{include file="layout/page.tpl"}]