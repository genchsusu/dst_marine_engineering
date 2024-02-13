local function e_or_z(en, zh)
	return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = e_or_z("Marine Engineering", "海上工程")
author = 'OpenSource'
version = '1.0.4'
description = e_or_z(
    [[
Enhance your seafaring experience with customizable options.
- Toggle Button: Synchronize the lifting of all nearby masts or anchors through buttons.
- Anchor Falling Speed: Adjust the speed at which the anchor drops.
- Mast Falling Speed: Adjust the speed at which the Mast drops.
- Rudder Control: Improve the maneuverability of your rudder.
- Mast Efficiency: Enhance the efficiency of your mast.
- Anchor Strength: Boost the anchoring power of your ship.
- Fish Visualization: Display fish near your ship when the player holds a fishing rod.
- Spawn Fish: Spawn fish around your ship.
- No Boat Leak: Ensure your boat never leaks.
    ]],
    [[
通过可定制的选项增强您的航海体验。
- 按钮开关：靠近船舵和船帆时出现可拖拽的按钮，按钮可同步升降船舵或者船帆。
- 船锚升降速度：提升船锚升降的速度。
- 船帆升降速度：提升船帆升降的速度。
- 船舵转速：提高船舵的操控性。
- 船帆速度：提升船帆的效率。
- 船锚力量：加强船只的锚定能力。
- 显示鱼群：当玩家手持海钓竿会在船附近显示鱼群。
- 召唤鱼群：在船周围生成鱼群。
- 船永不沉没：确保您的船永远不会漏水。
    ]]
)

forumthread = ""
	
api_version = 10

icon_atlas = "images/modicon.xml"
icon = "modicon.tex"

dst_compatible = true
client_only_mod = false
all_clients_require_mod = true

priority = 0.1

local function AddConfig(label, name, hover, options, default)
	return {
		label = label,
		name = name,
		hover = hover or '',
		options = options or {
			{description = e_or_z("On", "开启"), data = true},
			{description = e_or_z("Off", "关闭"), data = false},
		},
		default = default
	}
end

configuration_options = 
{
    AddConfig(e_or_z('Button', '按钮'), 'boat_button', e_or_z("On or off button", "开启或者关闭按钮"), nil, true),
    AddConfig(e_or_z('Anchor falling speed', '船锚升降速度'), 'anchor_speed', e_or_z("Adjust the speed of the anchor falling", "调整船锚升降速度"), {
        {description = e_or_z('Faster', '加快'), data = true},
        {description = e_or_z('Default', '默认'), data = false},
    }, true),
    AddConfig(e_or_z('Anchor power', '船锚力量'), 'power_anchor', e_or_z("Enhance anchor anchoring capability", "强化船锚锚定能力"), nil, true),
    AddConfig(e_or_z('msat falling speed', '船帆升降速度'), 'mast_speed', e_or_z("Adjust the speed of the mast falling", "调整船帆升降速度"), {
        {description = e_or_z('Faster', '加快'), data = true},
        {description = e_or_z('Default', '默认'), data = false},
    }, true),
    AddConfig(e_or_z('Mast speed', '船帆速度'), 'power_mast', e_or_z("Enhance mast propulsion capability", "强化船桅推进能力"), nil, true),
    AddConfig(e_or_z('Rudder speed', '船舵转速'), 'power_rudder', e_or_z("Enhance rudder control capability", "强化船舵操纵能力"), nil, true),
    AddConfig(e_or_z('Show fish', '显示鱼群'), 'show_fish', e_or_z("Show fish", "显示鱼群"), nil, true),
    AddConfig(e_or_z('Spawn fish', '召唤鱼群'), 'create_fish', e_or_z("Spawn fish near the ship", "在船旁边生成鱼群"), nil, true),
    AddConfig(e_or_z('No boat leak', '船永不沉没'), 'no_boat_leak', e_or_z("No boat leak", "船永不沉没"), nil, true),
}