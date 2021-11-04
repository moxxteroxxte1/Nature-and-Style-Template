<select name="[{$name}]"
        [{if $class}]class="[{$class}]"[{/if}]
        [{if $id}]id="[{$id}]"[{/if}]
        [{if $required}]required="required"[{/if}]>
    [{block name="salutation_options"}]
    <option value="" [{if empty($value)}]SELECTED[{/if}]>[{oxmultilang ident="DD_SELECT_SALUTATION"}]</option>
    <option value="MRS" [{if $value|lower  == "mrs" or $value2|lower == "mrs"}]SELECTED[{/if}]>[{oxmultilang ident="MRS"}]</option>
    <option value="MR"  [{if $value|lower  == "mr"  or $value2|lower == "mr"}]SELECTED[{/if}]>[{oxmultilang ident="MR" }]</option>
    <option value="MX" [{if $value|lower  == "mx" or $value2|lower == "mx"}]SELECTED[{/if}]>[{oxmultilang ident="MX"}]</option>
    [{/block}]
</select>
