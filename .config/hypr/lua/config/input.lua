-- [[ Input Settings ]]
--
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input for more

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		force_no_accel = 1,
		follow_mouse = 1,
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = true,
		},
	},
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "razer-razer-deathadder-v3",
	accel_profile = "flat",
	sensitivity = -0.5,
})
