{def $table_style = 'border:1px solid;width: 100%'
     $th_style = 'background-color:#cfd8ed;color:#000;font-weight:bold;text-align:center'
     $td_style = 'background-color:#E8EEF2;color:#333;'
     $td_x_style = 'background-color:#E8EEF2;color:#1A41A8;text-align:center;width: 50px'
     $x = '<strong>X</strong>'
     $yes = 'Oui'
     $no = 'Non'
}
<table style="{$table_style}">
    <tr>
        <th style="{$th_style}">Noms</th>
        <th style="{$th_style}">Modules</th>
        <th style="{$th_style}">Fonctions</th>
        <th style="{$th_style}">Limitations</th>
    </tr>
{foreach $roles as $role}
    <tr>
        <th style="{$th_style}" rowspan={inc(count($role.policies))}>{$role.name|wash}</th>
    {foreach $role.policies as $policy}
        <td style="{$td_style}">{$policy.module_name}</td>
        <td style="{$td_style}">{$policy.function_name}</td>
        <td style="{$td_style}">
        {foreach $policy.limitations as $limit}
            {$limit.identifier}
        {/foreach}
        </td>
    </tr>
    <tr>
        {/foreach}
    </tr>
{/foreach}
</table>
{undef $table_style $th_style $td_x_style $td_style $x}