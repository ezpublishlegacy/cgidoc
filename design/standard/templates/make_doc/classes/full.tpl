{def $table_style = 'border:1px solid;width: 100%'
     $h2_style = 'color:#485255;border-bottom: 2px solid'
     $h3_style = 'color:#485255;text-decoration:underline;'
     $th_style = 'background-color:#cfd8ed;color:#000;font-weight:bold;text-align:center'
     $td_style = 'background-color:#E8EEF2;color:#333;'
     $td_x_style = 'background-color:#E8EEF2;color:#1A41A8;text-align:center;'
     $x = '<strong>X</strong>'
     $yes = 'Oui'
     $no = 'Non'
}
<ul>
{foreach $classes as $groupName => $group}
    <li>
        <strong>{$groupName|wash()}</strong>
        <ul>
    {foreach $group as $class}
        <li><a href="#{$class.identifier}">{$class.name|wash()}</a> (<em>{$class.identifier}</em>)</li>
    {/foreach}
        </ul>
    </li>
{/foreach}
</ul>

{foreach $classes as $groupName => $group}
<h2 style="{$h2_style}">{$groupName|wash()}</h2>
    {foreach $group as $class}
<a name="{$class.identifier}"></a>
<h3 style="{$h3_style}">{$class.name|wash()} (<em>{$class.identifier}</em>)</h3>
{if $class.description}<p>{$class.description}.</p>{/if}
<ul>
    <li><strong>Conteneur :</strong> {if $class.is_container}{$yes}{else}{$no}{/if}</li>
    <li><strong>Toujours disponible :</strong> {if $class.always_available}{$yes}{else}{$no}{/if}</li>
</ul>

<table style="{$table_style}">
    <tr>
        <th style="{$th_style}" width="300px">Nom</th>
        <th style="{$th_style}" width="120px">Type</th>
        <th style="{$th_style}" width="50px"><abbr title="Cherchable">Cherch</abbr>.</th>
        <th style="{$th_style}" width="50px">Requis</th>
        <th style="{$th_style}" width="50px"><abbr title="Traduction">Trad</abbr>.</th>
        <th style="{$th_style}" width="50px"><acronym title="Collecteur d'informations">CI</acronym></th>
        <th style="{$th_style}" width="80px">Limite</th>
        <th style="{$th_style}" width="150px"><span title="Valeur par défaut">Défaut</span>.</th>
        <th style="{$th_style}" width="300px">Description</th>
    </tr>
        {foreach $class.data_map as $data_map}
        {*$data_map|attribute(show)}
        {break*}
    <tr>
        <td style="{$td_style}"><strong>{$data_map.name|wash()}</strong> (<em>{$data_map.identifier|wash()}</em>)</td>
        <td style="{$td_style}">{$data_map.data_type_string|wash()}</td>
        <td style="{$td_x_style}">{if $data_map.is_searchable}{$x}{/if}</td>
        <td style="{$td_x_style}">{if $data_map.is_required}{$x}{/if}</td>
        <td style="{$td_x_style}">{if $data_map.can_translate}{$x}{/if}</td>
        <td style="{$td_x_style}">{if $data_map.is_information_collector}{$x}{/if}</td>
        <td style="{$td_style}">
            {if and( $data_map.data_type_string|eq('ezstring'), $data_map.data_int1 )}{$data_map.data_int1|wash()} car.{/if}
            {if and( $data_map.data_type_string|eq('ezimage'), $data_map.data_int1 )}{$data_map.data_int1|wash()} Mo{/if}
        </td>
        <td style="{$td_style}">{if array('ezinisetting','ezpackage')|contains($data_map.data_type_string)|not()}{$data_map.data_text1|wash()}{/if}</td>
        <td style="{$td_style}">{$data_map.description|wash()}</td>
    </tr>
        {/foreach}
</table>
	{/foreach}
{/foreach}
{undef $classes $table_style $th_style $td_x_style $td_style $x}