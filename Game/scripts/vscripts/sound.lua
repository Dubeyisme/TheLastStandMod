-- Variable Controls

if SoundController == nil then
    DebugPrint( '[TLS] creating sound controller' )
    _G.SoundController = class({})
end

-- Responses after being revived
SOUND_HERO_REVIVED_RESPONSE = {
	RIK = {"riki_riki_thanks_01","riki_riki_thanks_02"},
	PNG = {"pangolin_pangolin_respawn_05","pangolin_pangolin_thanks_01"},
	SNI = {"sniper_snip_thanks_01","sniper_snip_thanks_02"},
	TEC = {"techies_tech_respawn_11","techies_noba_tech_thanks_03"},
	LIN = {"lina_lina_respawn_02","lina_lina_thanks_03"},
	FUR = {"furion_furi_thanks_01","furion_furi_thanks_02"},
	WWY = {"winter_wyvern_winwyv_thanks_03","winter_wyvern_winwyv_thanks_02"},
	KUN = {"kunkka_kunk_respawn_01","kunkka_kunk_thanks_03"},
	BMA = {"beastmaster_beas_thanks_02","beastmaster_beas_thanks_01"},
	OMN = {"omniknight_omni_thanks_02","omniknight_omni_respawn_04"}
 }

-- Hero might say at the start of round
SOUND_HERO_WAVE_START_RESPONSE = {
    RIK = {"riki_riki_cast_01", "riki_riki_cast_02", "riki_riki_cast_04"},
    PNG = {"pangolin_pangolin_cast_02", "pangolin_pangolin_cast_03", "pangolin_pangolin_rival_144"},
    SNI = {"sniper_snip_cast_01", "sniper_snip_cast_02", "sniper_snip_respawn_04"},
    TEC = {"techies_tech_ally_03", "techies_tech_cast_02", "techies_tech_fastressuicide_01"},
    LIN = {"announcer_dlc_lina_announcer_followup_neg_progress_04", "lina_lina_cast_01", "lina_lina_drop_medium_01"},
    FUR = {"furion_furi_cast_01", "furion_furi_cast_03", "furion_furi_kill_03"},
    WWY = {"winter_wyvern_winwyv_rare_01", "winter_wyvern_winwyv_respawn_03", "winter_wyvern_winwyv_rival_01"},
    KUN = {"kunkka_kunk_rare_01", "kunkka_kunk_rare_02", "kunkka_kunk_cast_03"},
    BMA = {"omniknight_omni_cast_01", "omniknight_omni_cast_02", "omniknight_omni_respawn_07"},
    OMN = {"beastmaster_beas_respawn_09", "beastmaster_beas_cast_02", "beastmaster_beas_cast_05"}
}

-- Responses after killing a villain
SOUND_HERO_KILLED_BOSS_RESPONSE = {
  TRN = {
  	PNG = "pangolin_pangolin_rival_196",
  	LIN = "lina_lina_rival_01",
  	FUR = "furion_furi_rival_01"

  },
  LON = {
  	PNG = "pangolin_pangolin_rival_99",
  	FUR = "furion_furi_kill_10",
  	WWY = "winter_wyvern_winwyv_rival_17"

  },
  DKW = {
  	PNG = "pangolin_pangolin_rival_40",
  	SNI = "sniper_snip_ability_assass_05",
  	TEC = "techies_tech_rival_13"

  },
  DOM = {
  	PNG = "pangolin_pangolin_rival_150",
  	LIN = "lina_lina_rival_16",
  	TEC = "techies_tech_rival_11",
  	KUN = "kunkka_kunk_rival_30",
  	OMN = "omniknight_omni_rival_03"

  },
  EAS = {
  	PNG = "pangolin_pangolin_rival_55",
  	SNI = "sniper_snip_kill_06"

  },
  ELT = {
  	PNG = "pangolin_pangolin_rival_59",
  	LIN = "lina_lina_rival_18",
  	FUR = "furion_furi_kill_11"

  },
  NEV = {
  	PNG = "pangolin_pangolin_rival_202",
  	SNI = "sniper_snip_kill_01",
  	KUN = "kunkka_kunk_rival_31",
  	OMN = "omniknight_omni_rival_11"

  },
  SHD = {
  	PNG = "pangolin_pangolin_rival_139",
  	KUN = "kunkka_kunk_rival_32"

  }, 
  HUS = {
  	PNG = "pangolin_pangolin_rival_74",
  	SNI = "sniper_snip_kill_arrow_06"

  },
  WDO = {
  	PNG = "pangolin_pangolin_rival_197",
  	LIN = "lina_lina_rival_12"

  },
  MEE = {
  	PNG = "pangolin_pangolin_rival_110",
  	TEC = "techies_tech_kill_02",
  	WWY = "winter_wyvern_winwyv_kill_10"

  },
  URS = {
  	PNG = "pangolin_pangolin_rival_205",
  	SNI = "sniper_snip_kill_08",
  	BMA = "beastmaster_beas_kill_03"

  },
  CEN = {
  	PNG = "pangolin_pangolin_rival_29",
  	SNI = "sniper_snip_kill_blade_03"

  },
  ABY = {
  	PNG = "pangolin_pangolin_rival_201",
  	FUR = "furion_furi_kill_12",
  	OMN = "omniknight_omni_kill_10"

  },
  SKY = {
  	PNG = "pangolin_pangolin_rival_222",
  	LIN = "lina_lina_rival_20",
  	TEC = "techies_tech_kill_03",
  	KUN = "kunkka_kunk_kill_06"
  },
  JAK = {
  	PNG = "pangolin_pangolin_rival_51",
  	LIN = "lina_lina_rival_04",
  	WWY = "winter_wyvern_winwyv_rival_10"

  },
  UND = {
  	RIK = "riki_riki_kill_14",
  	PNG = "pangolin_pangolin_rival_204",
  	KUN = "kunkka_kunk_kill_01",
  	BMA = "beastmaster_beas_kill_07"
  },
  NEC = {
  	RIK = "riki_riki_kill_12",
  	PNG = "pangolin_pangolin_rival_210",
  	FUR = "furion_furi_kill_08",
  	OMN = "omniknight_omni_kill_02"
  }	
}

-- Villain response to being killed
SOUND_BOSS_FALLEN_RESPONSE = {
  TRN = {"treant_treant_death_15", "treant_treant_death_16"},
  LON = {"lone_druid_lone_druid_death_07", "lone_druid_lone_druid_death_10"},
  DKW = {"dark_willow_sylph_death_01", "dark_willow_sylph_death_03"},
  DOM = {"doom_bringer_doom_death_02", "doom_bringer_doom_death_09"},
  EAS = {"earth_spirit_earthspi_death_03", "earth_spirit_earthspi_death_10"},
  ELT = {"elder_titan_elder_death_11", "elder_titan_elder_death_14"},
  NEV = {"nevermore_nev_death_15", "nevermore_nev_death_12"},
  SHD = {"shadow_demon_shadow_demon_death_08", "shadow_demon_shadow_demon_death_03"}, 
  HUS = {"huskar_husk_death_06", "huskar_husk_death_08"},
  WDO = {"witchdoctor_wdoc_death_04", "witchdoctor_wdoc_death_11"},
  MEE = {"meepo_meepo_death_09", "meepo_meepo_death_06"},
  URS = {"ursa_ursa_death_11", "ursa_ursa_death_02"},
  CEN = {"centaur_cent_death_09", "centaur_cent_death_10"},
  ABY = {"abyssal_underlord_abys_death_10", "abyssal_underlord_abys_death_03"},
  SKY = {"skywrath_mage_drag_death_10", "skywrath_mage_drag_death_02"},
  JAK = {"jakiro_jak_death_02", "jakiro_jak_death_08"},
  UND = {"undying_undying_death_08", "undying_undying_death_11"},
  NEC = {"necrolyte_necr_death_02", "necrolyte_necr_death_06"}
}

-- Villain response to hitting 75% and 25% HP
SOUND_BOSS_HP_REDUCED_RESPONSE = {
  TRN = {"treant_treant_cast_01", "treant_treant_cast_03"},
  LON = {"lone_druid_lone_druid_level_09", "lone_druid_lone_druid_death_12"},
  DKW = {"dark_willow_sylph_taunt_01", "dark_willow_sylph_respawn_06"},
  DOM = {"doom_bringer_doom_level_01", "doom_bringer_doom_notyet_01"},
  EAS = {"earth_spirit_earthspi_attack_08", "earth_spirit_earthspi_respawn_10"},
  ELT = {"elder_titan_elder_deny_09", "elder_titan_elder_death_15"},
  NEV = {"nevermore_nev_respawn_02", "nevermore_nev_respawn_08"},
  SHD = {"shadow_demon_shadow_demon_kill_10", "shadow_demon_shadow_demon_kill_06"}, 
  HUS = {"huskar_husk_respawn_08", "huskar_husk_respawn_10"},
  WDO = {"witchdoctor_wdoc_respawn_11", "witchdoctor_wdoc_respawn_09"},
  MEE = {"meepo_meepo_kill_23", "meepo_meepo_respawn_03"},
  URS = {"ursa_ursa_immort_02", "ursa_ursa_spawn_04"},
  CEN = {"centaur_cent_underattack_01", "centaur_cent_death_12"},
  ABY = {"abyssal_underlord_abys_kill_13", "abyssal_underlord_abys_death_08"},
  SKY = {"skywrath_mage_drag_respawn_01", "skywrath_mage_drag_cast_01"},
  JAK = {"jakiro_jak_ability_failure_07", "jakiro_jak_kill_08"},
  UND = {"undying_undying_levelup_05", "undying_undying_levelup_07"},
  NEC = {"necrolyte_necr_breath_01", "necrolyte_necr_immort_02"}
}

-- Villain response to killing a hero
SOUND_BOSS_HERO_KILLED_RESPONSE = {
  TRN = {"treant_treant_deny_14", "treant_treant_tango_01", "treant_treant_tango_03", "treant_treant_tango_02", "treant_treant_attack_11"},
  LON = {"lone_druid_lone_druid_laugh_04", "lone_druid_lone_druid_laugh_06", "lone_druid_lone_druid_lasthit_01", "lone_druid_lone_druid_deny_06", "lone_druid_lone_druid_deny_10"},
  DKW = {"dark_willow_sylph_ability2_06", "dark_willow_sylph_ability3_02", "dark_willow_sylph_kill_02", "dark_willow_sylph_ability3_07", "dark_willow_sylph_laugh_02"},
  DOM = {"doom_bringer_doom_level_07", "doom_bringer_doom_level_08", "doom_bringer_doom_kill_01", "doom_bringer_doom_level_03", "doom_bringer_doom_kill_02"},
  EAS = {"earth_spirit_earthspi_lasthit_03", "earth_spirit_earthspi_kill_08", "earth_spirit_earthspi_kill_09", "earth_spirit_earthspi_kill_11", "earth_spirit_earthspi_kill_05"},
  ELT = {"elder_titan_elder_kill_05", "elder_titan_elder_kill_10", "elder_titan_elder_kill_09", "elder_titan_elder_earthsplitter_06", "elder_titan_elder_kill_02"},
  NEV = {"nevermore_nev_kill_01", "nevermore_nev_lasthit_01", "nevermore_nev_kill_07", "nevermore_nev_lasthit_06", "nevermore_nev_kill_09"},
  SHD = {"shadow_demon_shadow_demon_lasthit_07", "shadow_demon_shadow_demon_lasthit_09", "shadow_demon_shadow_demon_lasthit_10", "shadow_demon_shadow_demon_laugh_01", "shadow_demon_shadow_demon_laugh_03"}, 
  HUS = {"huskar_husk_lasthit_02", "huskar_husk_lasthit_03", "huskar_husk_lasthit_08", "huskar_husk_kill_10", "huskar_husk_kill_12"},
  WDO = {"witchdoctor_wdoc_kill_02", "witchdoctor_wdoc_laugh_04", "witchdoctor_wdoc_lasthit_06", "witchdoctor_wdoc_lasthit_09", "witchdoctor_wdoc_laugh_05"},
  MEE = {"meepo_meepo_kill_03", "meepo_meepo_kill_07", "meepo_meepo_kill_15", "meepo_meepo_kill_20", "meepo_meepo_lasthit_10"},
  URS = {"ursa_ursa_kill_02", "ursa_ursa_kill_14", "ursa_ursa_lasthit_03", "ursa_ursa_lasthit_04", "ursa_ursa_laugh_07"},
  CEN = {"centaur_cent_lasthit_09", "centaur_cent_kill_03", "centaur_cent_kill_04", "centaur_cent_kill_01", "centaur_cent_kill_12"},
  ABY = {"abyssal_underlord_abys_kill_01", "abyssal_underlord_abys_kill_04", "abyssal_underlord_abys_kill_23", "abyssal_underlord_abys_kill_10", "abyssal_underlord_abys_lasthit_06"},
  SKY = {"skywrath_mage_drag_lasthit_02", "skywrath_mage_drag_lasthit_06", "skywrath_mage_drag_kill_11", "skywrath_mage_drag_kill_09", "skywrath_mage_drag_laugh_01"},
  JAK = {"jakiro_jak_kill_01", "jakiro_jak_kill_04", "jakiro_jak_laugh_01", "jakiro_jak_kill_15", "jakiro_jak_brother_02"},
  UND = {"undying_undying_lasthit_02", "undying_undying_lasthit_03", "undying_undying_lasthit_04", "undying_undying_kill_03", "undying_undying_kill_10"},
  NEC = {"necrolyte_necr_lasthit_03", "necrolyte_necr_kill_01", "necrolyte_necr_kill_04", "necrolyte_necr_kill_05", "necrolyte_necr_lasthit_02"}
}

-- Villain response to using an ability
SOUND_BOSS_ABILITY_RESPONSE = {
  TRN = {
	  {"treant_treant_deny_07", "treant_treant_deny_04", "treant_treant_deny_03"}, 
	  {"treant_treant_ability_leechseed_02", "treant_treant_ability_leechseed_04", "treant_treant_ability_leechseed_05"}, 
	  {"treant_treant_ability_overgrowth_05", "treant_treant_ability_overgrowth_06", "treant_treant_ability_overgrowth_09"}
  },
  LON = {
	  {"lone_druid_lone_druid_ability_rabid_02", "lone_druid_lone_druid_ability_battlecry_03", "lone_druid_lone_druid_cast_02"}, 
	  {"", "", ""}, 
	  {"lone_druid_lone_druid_kill_09", "lone_druid_lone_druid_kill_03", "lone_druid_lone_druid_kill_02"}
  },
  DKW = {
	  {"dark_willow_sylph_attack_14", "dark_willow_sylph_ability1_13", "dark_willow_sylph_ability2_04"}, 
	  {"dark_willow_sylph_ability1_01", "dark_willow_sylph_ability1_02", "dark_willow_sylph_ability1_03"}, 
	  {"dark_willow_sylph_ability2_03", "dark_willow_sylph_ability2_07", "dark_willow_sylph_ability2_12"}
  },
  DOM = {
	  {"doom_bringer_doom_ability_lvldeath_01", "doom_bringer_doom_ability_lvldeath_03", "doom_bringer_doom_ability_fail_02"}, 
	  {"doom_bringer_doom_ability_scorched_01", "doom_bringer_doom_ability_scorched_02", "doom_bringer_doom_ability_scorched_03"}, 
	  {"doom_bringer_doom_ability_doom_01", "doom_bringer_doom_ability_doom_05", "doom_bringer_doom_ability_doom_03"}
  },
  EAS = {
	  {"earth_spirit_earthspi_bouldersmash_02", "earth_spirit_earthspi_bouldersmash_03", "earth_spirit_earthspi_bouldersmash_01"}, 
	  {"earth_spirit_earthspi_magnetize_03", "earth_spirit_earthspi_magnetize_01", "earth_spirit_earthspi_magnetize_02"}, 
	  {"earth_spirit_earthspi_geomagnetic_01", "earth_spirit_earthspi_geomagnetic_04", "earth_spirit_earthspi_geomagnetic_06"}
  },
  ELT = {
	  {"elder_titan_elder_ancestralspirit_01", "elder_titan_elder_ancestralspirit_06", "elder_titan_elder_ancestralspirit_03"}, 
	  {"elder_titan_elder_earthsplitter_02", "elder_titan_elder_earthsplitter_03", "elder_titan_elder_earthsplitter_05"}, 
	  {"elder_titan_elder_echostomp_01", "elder_titan_elder_echostomp_02", "elder_titan_elder_echostomp_08"}
  },
  NEV = {
	  {"nevermore_nev_ability_requiem_01", "nevermore_nev_ability_requiem_08", "nevermore_nev_attack_01"}, 
	  {"nevermore_nev_kill_04", "nevermore_nev_kill_05", "nevermore_nev_kill_13"}, 
	  {"nevermore_nev_cast_01", "nevermore_nev_cast_02", "nevermore_nev_cast_03"}
  },
  SHD = {
	  {"shadow_demon_shadow_demon_ability_disruption_05", "shadow_demon_shadow_demon_ability_disruption_06", "shadow_demon_shadow_demon_ability_disruption_14"}, 
	  {"shadow_demon_shadow_demon_ability_soul_catcher_01", "shadow_demon_shadow_demon_ability_soul_catcher_02", "shadow_demon_shadow_demon_ability_soul_catcher_03"}, 
	  {"shadow_demon_shadow_demon_ability_demonic_purge_03", "shadow_demon_shadow_demon_ability_demonic_purge_04", "shadow_demon_shadow_demon_ability_demonic_purge_05"}
  }, 
  HUS = {
	  {"huskar_husk_healthup_01", "huskar_husk_ability_innervit_10", "huskar_husk_ability_innervit_03"}, 
	  {"huskar_husk_ability_lifebrk_06", "huskar_husk_ability_lifebrk_02", "huskar_husk_ability_brskrblood_03"}, 
	  {"huskar_husk_ability_brskrblood_01", "huskar_husk_ability_brnspear_01", "huskar_husk_ability_brskrblood_02"}
  },
  WDO = {
	  {"witchdoctor_wdoc_ability_cask_01", "witchdoctor_wdoc_ability_cask_03", "witchdoctor_wdoc_ability_cask_07"}, 
	  {"witchdoctor_wdoc_ability_maledict_01", "witchdoctor_wdoc_ability_maledict_02", "witchdoctor_wdoc_killspecial_01"}, 
	  {"witchdoctor_wdoc_ability_voodoo_01", "witchdoctor_wdoc_ability_voodoo_02", "witchdoctor_wdoc_ability_voodoo_03"}
  },
  MEE = {
	  {"meepo_meepo_earthbind_01", "meepo_meepo_earthbind_02", "meepo_meepo_earthbind_04"}, 
	  {"meepo_meepo_poof_06", "meepo_meepo_poof_08", "meepo_meepo_poof_02"}, 
	  {"meepo_meepo_lasthit_06", "meepo_meepo_lasthit_07", "meepo_meepo_lasthit_05"}
  },
  URS = {
	  {"ursa_ursa_overpower_03", "ursa_ursa_overpower_05", "ursa_ursa_enrage_06"}, 
	  {"ursa_ursa_earthshock_01", "ursa_ursa_earthshock_03", "ursa_ursa_earthshock_05"}, 
	  {"ursa_ursa_levelup_04", "ursa_ursa_respawn_05", "ursa_ursa_spawn_02"}
  },
  CEN = {
	  {"centaur_cent_doub_edge_05", "centaur_cent_doub_edge_06", "centaur_cent_doub_edge_07"}, 
	  {"centaur_cent_hoof_stomp_01", "centaur_cent_hoof_stomp_04", "centaur_cent_hoof_stomp_02"}, 
	  {"centaur_cent_move_08", "centaur_cent_move_10", "centaur_cent_move_18"}
  },
  ABY = {
	  {"abyssal_underlord_abys_firestrorm_01", "abyssal_underlord_abys_firestrorm_04", "abyssal_underlord_abys_firestrorm_06"}, 
	  {"abyssal_underlord_abys_pitofmalice_03", "abyssal_underlord_abys_pitofmalice_04", "abyssal_underlord_abys_pitofmalice_06"}, 
	  {"abyssal_underlord_abys_darkrift_05", "abyssal_underlord_abys_move_10", "abyssal_underlord_abys_darkrift_04"}
  },
  SKY = {
	  {"skywrath_mage_drag_arcanebolt_01", "skywrath_mage_drag_arcanebolt_02", "skywrath_mage_drag_arcanebolt_03"}, 
	  {"skywrath_mage_drag_ancient_seal_01", "skywrath_mage_drag_ancient_seal_02", "skywrath_mage_drag_ancient_seal_03"}, 
	  {"skywrath_mage_drag_mystic_flare_01", "skywrath_mage_drag_mystic_flare_02", "skywrath_mage_drag_mystic_flare_03"}
  },
  JAK = {
	  {"jakiro_jak_ability_dual_01", "jakiro_jak_ability_dual_02", "jakiro_jak_ability_dual_03"}, 
	  {"jakiro_jak_ability_icepath_01", "jakiro_jak_ability_icepath_02", "jakiro_jak_ability_icepath_03"}, 
	  {"jakiro_jak_ability_macro_01", "jakiro_jak_ability_macro_02", "jakiro_jak_ability_macro_04"}
  },
  UND = {
	  {"undying_undying_tombstone_01", "undying_undying_tombstone_02", "undying_undying_tombstone_06"}, 
	  {"undying_undying_decay_01", "undying_undying_decay_03", "undying_undying_decay_05"}, 
	  {"undying_undying_soulrip_01", "undying_undying_soulrip_03", "undying_undying_soulrip_02"}
  },
  NEC = {
	  {"necrolyte_necr_ability_tox_01", "necrolyte_necr_ability_tox_02", "necrolyte_necr_ability_tox_03"}, 
	  {"necrolyte_necr_deny_08", "necrolyte_necr_deny_05", "necrolyte_necr_deny_03"}, 
	  {"necrolyte_necr_ability_reap_01", "necrolyte_necr_ability_reap_02", "necrolyte_necr_ability_reap_03"}
  }
}


-- Villain response to the start of the round
SOUND_BOSS_START_RESPONSE = {
  TRN = {"treant_treant_ability_leechseed_03", "treant_treant_respawn_12"},
  LON = {"lone_druid_lone_druid_ability_battlecry_01", "lone_druid_lone_druid_attack_10"},
  DKW = {"dark_willow_sylph_hero_intro_02", "dark_willow_sylph_illus_03"},
  DOM = {"doom_bringer_doom_respawn_01", "doom_bringer_doom_respawn_10"},
  EAS = {"earth_spirit_earthspi_spawn_06", "earth_spirit_earthspi_battlebegins_02"},
  ELT = {"elder_titan_elder_attack_07", "elder_titan_elder_attack_06"},
  NEV = {"nevermore_nev_ability_presence_01", "nevermore_nev_ability_presence_02"},
  SHD = {"shadow_demon_shadow_demon_spawn_02", "shadow_demon_shadow_demon_battlebegins_01"}, 
  HUS = {"huskar_husk_cast_03", "huskar_husk_cast_02"},
  WDO = {"witchdoctor_wdoc_respawn_10", "witchdoctor_wdoc_move_06"},
  MEE = {"meepo_meepo_begin_01", "meepo_meepo_begin_02"},
  URS = {"ursa_ursa_begin_01", "ursa_ursa_move_17"},
  CEN = {"centaur_cent_battlebegins_01", "centaur_cent_respawn_10"},
  ABY = {"abyssal_underlord_abys_move_15", "abyssal_underlord_abys_move_14"},
  SKY = {"skywrath_mage_drag_move_05", "skywrath_mage_drag_cast_02"},
  JAK = {"jakiro_jak_battlebegins_01", "jakiro_jak_battlebegins_02"},
  UND = {"undying_undying_spawn_04", "undying_undying_spawn_02"},
  NEC = {"necrolyte_necr_spawn_02", "necrolyte_necr_respawn_14"}
}

-- Villain response to defeating the heroes
SOUND_BOSS_VICTORY_RESPONSE = {
  TRN = {"treant_treant_win_04"},
  LON = {"lone_druid_lone_druid_deny_09"},
  DKW = {"dark_willow_sylph_win_05"},
  DOM = {"doom_bringer_doom_kill_06"},
  EAS = {"earth_spirit_earthspi_kill_14"},
  ELT = {"elder_titan_elder_failure_02"},
  NEV = {"nevermore_nev_rare_03"},
  SHD = {"shadow_demon_shadow_demon_immort_02"}, 
  HUS = {"huskar_husk_kill_04"},
  WDO = {"witchdoctor_wdoc_win_04"},
  MEE = {"meepo_meepo_win_05"},
  URS = {"ursa_ursa_kill_08"},
  CEN = {"centaur_cent_kill_08"},
  ABY = {"abyssal_underlord_abys_firstblood_02"},
  SKY = {"skywrath_mage_drag_kill_07"},
  JAK = {"jakiro_jak_win_03"},
  UND = {"undying_undying_win_05"},
  NEC = {"necrolyte_necr_kill_10"}
}

-- At the start of a wave, pick a hero from the pool of heroes and potentially make them speak
function SoundController:Hero_WaveStart(herolist)
  local i
  local available_list = {}
  local chance = RandomInt(1,5)
  local herochoice = RandomInt(1,#herolist)
  local voiceline = RandomInt(1,3)
  for i=1, #herolist do
    table.insert(available_list,SoundController:ParseVar(SOUND_HERO_WAVE_START_RESPONSE, herolist[i]))
  end
  if(chance==5)then
    EmitAnnouncerSoundForTeam(available_list[herochoice][voiceline], DOTA_TEAM_GOODGUYS)
  end
end

-- Make this hero announce he killed the villain if he has a specific line for doing so
function SoundController:Hero_VillainKilled(hero,villain)
  Timers:CreateTimer({
          endTime = 3,
        callback = function()
          local villain_repose = SoundController:ParseVar(SOUND_HERO_KILLED_BOSS_RESPONSE, villain)
          local response = SoundController:ParseVar(villain_repose, hero)
          if(response~=nil)then
            EmitAnnouncerSoundForTeam(response[1], DOTA_TEAM_GOODGUYS)
          end
        end
      })  
end

-- Make this hero say thanks for being revived
function SoundController:Hero_Revived(hero)
  local voiceline = RandomInt(1,2)
  local response = SoundController:ParseVar(SOUND_HERO_REVIVED_RESPONSE, hero)
  EmitAnnouncerSoundForTeam(response[voiceline], DOTA_TEAM_GOODGUYS)
end

-- Make this villain announce he is using an ability
function SoundController:Villain_AbilityUsed(villain, ability_number)
  local voiceline = RandomInt(1,3)
  local response = SoundController:ParseVar(SOUND_BOSS_ABILITY_RESPONSE, villain)
  EmitAnnouncerSoundForTeam(response[ability_number][voiceline], DOTA_TEAM_GOODGUYS)
end

-- Make this villain announce he is hurt at 75% or 25% hp
function SoundController:Villain_Hurt(villain, one_or_two)
  local response = SoundController:ParseVar(SOUND_BOSS_HP_REDUCED_RESPONSE, villain)
  EmitAnnouncerSoundForTeam(response[one_or_two], DOTA_TEAM_GOODGUYS)
end

-- Make this villain announce he has won
function SoundController:Villain_Victory(villain)
  local response = SoundController:ParseVar(SOUND_BOSS_VICTORY_RESPONSE, villain)
  EmitAnnouncerSoundForTeam(response[1], DOTA_TEAM_GOODGUYS)
end

-- Make this villain announce he killed a hero
function SoundController:Villain_HeroKilled(villain)
  local voiceline = RandomInt(1,5)
  local response = SoundController:ParseVar(SOUND_BOSS_HERO_KILLED_RESPONSE, villain)
  EmitAnnouncerSoundForTeam(response[voiceline], DOTA_TEAM_GOODGUYS)
end

-- Make this villain the start of battle
function SoundController:Villain_BattleStart(villain)
  local voiceline = RandomInt(1,2)
  local response = SoundController:ParseVar(SOUND_BOSS_START_RESPONSE, villain)
  EmitAnnouncerSoundForTeam(response[voiceline], DOTA_TEAM_GOODGUYS)
end

-- Make this villain announce his demise
function SoundController:Villain_Defeated(villain)
  local voiceline = RandomInt(1,2)
  local response = SoundController:ParseVar(SOUND_BOSS_FALLEN_RESPONSE, villain)
  EmitAnnouncerSoundForTeam(response[voiceline], DOTA_TEAM_GOODGUYS)
end

function SoundController:RespawnStinger(hero)

  EmitAnnouncerSoundForPlayer("dsadowski_01.stinger.respawn", hero:GetOwner():GetPlayerID())
end

-- Takes a variable and a hero or villain and parses which item was needed from the variable
function SoundController:ParseVar(var, unit)
  --DebugPrint(unit:GetName())
  --DebugPrint(unit:GetUnitLabel())
  local name = unit:GetName()
  if(name=="npc_dota_hero")then name = unit:GetUnitLabel() end
  -- Heroes
  if(name == "npc_dota_hero_riki") then return var.OMN end
  if(name == "npc_dota_hero_pangolier") then return var.PNG end
  if(name == "npc_dota_hero_sniper") then return var.SNI end
  if(name == "npc_dota_hero_techies") then return var.TEC end
  if(name == "npc_dota_hero_lina") then return var.LIN end
  if(name == "npc_dota_hero_furion") then return var.FUR end
  if(name == "npc_dota_hero_winter_wyvern") then return var.WWY end
  if(name == "npc_dota_hero_kunkka") then return var.KUN end
  if(name == "npc_dota_hero_beastmaster") then return var.BMA end
  if(name == "npc_dota_hero_omniknight") then return var.OMN end
  -- Villains
  if(name == "npc_dota_hero_treant") then return var.TRN end
  if(name == "npc_dota_hero_lone_druid") then return var.LON end
  if(name == "npc_dota_hero_dark_willow") then return var.DKW end
  if(name == "npc_dota_hero_doom_bringer") then return var.DOM end
  if(name == "npc_dota_hero_earth_spirit") then return var.EAS end
  if(name == "npc_dota_hero_elder_titan") then return var.ELT end
  if(name == "npc_dota_hero_nevermore") then return var.NEV end
  if(name == "npc_dota_hero_shadow_demon") then return var.SHD end
  if(name == "npc_dota_hero_huskar") then return var.HUS end
  if(name == "npc_dota_hero_witch_doctor") then return var.WDO end
  if(name == "npc_dota_hero_meepo") then return var.MEE end
  if(name == "npc_dota_hero_ursa") then return var.URS end
  if(name == "npc_dota_hero_centaur") then return var.CEN end
  if(name == "npc_dota_hero_abyssal_underlord") then return var.ABY end
  if(name == "npc_dota_hero_skywrath_mage") then return var.SKY end
  if(name == "npc_dota_hero_jakiro") then return var.JAK end
  if(name == "npc_dota_hero_undying") then return var.UND end
  if(name == "npc_dota_hero_necrolyte") then return var.NEC end
end

-- Precache all the sounds, called from addon_game_mode during precache
function SoundController:PrecacheSounds( context )

  DebugPrint("[TLS] Performing pre-load sound precache")
  -- Wave Start/Finish Stingers

  -- Generic Wave Finish Sounds
  	-- Wave Clear Start and End
  	PrecacheResource("soundfile","sounds/ui/npe_objective_complete.vsnd", context) -- ui.npe_objective_complete
  	PrecacheResource("soundfile","sounds/ui/npe_objective_given.vsnd", context) -- ui.npe_objective_given

  -- Hero Revivals
  --------------------------------------------------------------------------------------------------------------------------
  -- Rikimaru
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/riki/riki_cast_01.vsnd", context) -- riki_riki_cast_01
  PrecacheResource("soundfile", "sounds/vo/riki/riki_cast_02.vsnd", context) -- riki_riki_cast_02
  PrecacheResource("soundfile", "sounds/vo/riki/riki_cast_04.vsnd", context) -- riki_riki_cast_04

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/riki/riki_thanks_01.vsnd", context) -- riki_riki_thanks_01
  PrecacheResource("soundfile", "sounds/vo/riki/riki_thanks_02.vsnd", context) -- riki_riki_thanks_02

  -- Kill Necrophos
  PrecacheResource("soundfile", "sounds/vo/riki/riki_kill_12.vsnd", context) -- riki_riki_kill_12

  -- Kill Undying
  PrecacheResource("soundfile", "sounds/vo/riki/riki_kill_14.vsnd", context) -- riki_riki_kill_14
  --------------------------------------------------------------------------------------------------------------------------
  -- Pangolier
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_cast_02.vsnd", context) -- pangolin_pangolin_cast_02
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_cast_03.vsnd", context) -- pangolin_pangolin_cast_03
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_144.vsnd", context) -- pangolin_pangolin_rival_144

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_respawn_05.vsnd", context) -- pangolin_pangolin_respawn_05
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_thanks_01.vsnd", context) -- pangolin_pangolin_thanks_01

  -- Kill Skywrath
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_222.vsnd", context) -- pangolin_pangolin_rival_222

  -- Kill Earth Spirit
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_55.vsnd", context) -- pangolin_pangolin_rival_55

  -- Kill Elder Titan
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_59.vsnd", context) -- pangolin_pangolin_rival_59

  -- Kill Doom
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_150.vsnd", context) -- pangolin_pangolin_rival_150

  -- Kill Jakiro
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_51.vsnd", context) -- pangolin_pangolin_rival_51

  -- Kill Dark Willow
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_40.vsnd", context) -- pangolin_pangolin_rival_40

  -- Kill Centaur
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_29.vsnd", context) -- pangolin_pangolin_rival_29

  -- Kill Huskar
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_74.vsnd", context) -- pangolin_pangolin_rival_74

  -- Kill Lone Druid
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_99.vsnd", context) -- pangolin_pangolin_rival_99

  -- Kill Necrophos
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_210.vsnd", context) -- pangolin_pangolin_rival_210

  -- Kill Meepo
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_110.vsnd", context) -- pangolin_pangolin_rival_110

  -- Kill Shadow Fiend
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_202.vsnd", context) -- pangolin_pangolin_rival_202

  -- Kill Shadow Demon
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_139.vsnd", context) -- pangolin_pangolin_rival_139

  -- Kill Treant
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_196.vsnd", context) -- pangolin_pangolin_rival_196

  -- Kill Underlord
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_201.vsnd", context) -- pangolin_pangolin_rival_201

  -- Kill Undying
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_204.vsnd", context) -- pangolin_pangolin_rival_204

  -- Kill Ursa
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_205.vsnd", context) --pangolin_pangolin_rival_205

  -- Kill Witchdoctor
  PrecacheResource("soundfile", "sounds/vo/pangolin/pangolin_rival_197.vsnd", context) -- pangolin_pangolin_rival_197
  --------------------------------------------------------------------------------------------------------------------------
  -- Sniper
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_cast_01.vsnd", context) -- sniper_snip_cast_01
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_cast_02.vsnd", context) -- sniper_snip_cast_02
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_respawn_04.vsnd", context) -- sniper_snip_respawn_04

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_thanks_01.vsnd", context) -- sniper_snip_thanks_01
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_thanks_02.vsnd", context) -- sniper_snip_thanks_02

  -- Kill Centaur
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_kill_blade_03.vsnd", context) -- sniper_snip_kill_blade_03

  -- Kill Huskar
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_kill_arrow_06.vsnd", context) -- sniper_snip_kill_arrow_06

  -- Kill Dark Willow
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_ability_assass_05.vsnd", context) -- sniper_snip_ability_assass_05

  -- Kill Earth Spirit
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_kill_06.vsnd", context) -- sniper_snip_kill_06

  -- Kill Shadow Fiend
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_kill_01.vsnd", context) -- sniper_snip_kill_01

  -- Kill Ursa
  PrecacheResource("soundfile", "sounds/vo/sniper/snip_kill_08.vsnd", context) -- sniper_snip_kill_08
  --------------------------------------------------------------------------------------------------------------------------
  -- Lina
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/announcer_dlc_lina/announcer_followup_neg_progress_04.vsnd", context) -- announcer_dlc_lina_announcer_followup_neg_progress_04
  PrecacheResource("soundfile", "sounds/vo/lina/lina_cast_01.vsnd", context) -- lina_lina_cast_01
  PrecacheResource("soundfile", "sounds/vo/lina/lina_drop_medium_01.vsnd", context) -- lina_lina_drop_medium_01

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/lina/lina_respawn_02.vsnd", context) -- lina_lina_respawn_02
  PrecacheResource("soundfile", "sounds/vo/lina/lina_thanks_03.vsnd", context) -- lina_lina_thanks_03

  -- Kill treant
  PrecacheResource("soundfile", "sounds/vo/lina/lina_rival_01.vsnd", context) -- lina_lina_rival_01

  -- Kill Jakiro
  PrecacheResource("soundfile", "sounds/vo/lina/lina_rival_04.vsnd", context) -- lina_lina_rival_04

  -- Kill Doom
  PrecacheResource("soundfile", "sounds/vo/lina/lina_rival_16.vsnd", context) -- lina_lina_rival_16

  -- Kill Skywrath
  PrecacheResource("soundfile", "sounds/vo/lina/lina_rival_20.vsnd", context) -- lina_lina_rival_20

  -- Kill Witchdoctor
  PrecacheResource("soundfile", "sounds/vo/lina/lina_rival_12.vsnd", context) -- lina_lina_rival_12

  -- Kill Elder Titan
  PrecacheResource("soundfile", "sounds/vo/lina/lina_rival_18.vsnd", context) -- lina_lina_rival_18
  --------------------------------------------------------------------------------------------------------------------------
  -- Furion
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/furion/furi_cast_01.vsnd", context) -- furion_furi_cast_01
  PrecacheResource("soundfile", "sounds/vo/furion/furi_cast_03.vsnd", context) -- furion_furi_cast_03
  PrecacheResource("soundfile", "sounds/vo/furion/furi_kill_03.vsnd", context) -- furion_furi_kill_03

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/furion/furi_thanks_01.vsnd", context) -- furion_furi_thanks_01
  PrecacheResource("soundfile", "sounds/vo/furion/furi_thanks_02.vsnd", context) -- furion_furi_thanks_02

  -- Kill treant
  PrecacheResource("soundfile", "sounds/vo/furion/furi_rival_01.vsnd", context) -- furion_furi_rival_01

  -- Kill Necrophos
  PrecacheResource("soundfile", "sounds/vo/furion/furi_kill_08.vsnd", context) -- furion_furi_kill_08

  -- Kill Lone Druid
  PrecacheResource("soundfile", "sounds/vo/furion/furi_kill_10.vsnd", context) -- furion_furi_kill_10

  -- Kill Elder Titan
  PrecacheResource("soundfile", "sounds/vo/furion/furi_kill_11.vsnd", context) -- furion_furi_kill_11

  -- Kill Underlord
  PrecacheResource("soundfile", "sounds/vo/furion/furi_kill_12.vsnd", context) -- furion_furi_kill_12
  --------------------------------------------------------------------------------------------------------------------------
  -- Techies
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/techies/tech_ally_03.vsnd", context) -- techies_tech_ally_03
  PrecacheResource("soundfile", "sounds/vo/techies/tech_cast_02.vsnd", context) -- techies_tech_cast_02
  PrecacheResource("soundfile", "sounds/vo/techies/tech_fastressuicide_01.vsnd", context) -- techies_tech_fastressuicide_01

  --Revived
  PrecacheResource("soundfile", "sounds/vo/techies/tech_respawn_11.vsnd", context) -- techies_tech_respawn_11
  PrecacheResource("soundfile", "sounds/vo/techies/tech_thanks_03.vsnd", context) -- techies_noba_tech_thanks_03

  -- Kill Doom
  PrecacheResource("soundfile", "sounds/vo/techies/tech_rival_11.vsnd", context) -- techies_tech_rival_11

  -- Kill Darkwillow
  PrecacheResource("soundfile", "sounds/vo/techies/tech_rival_13.vsnd", context) -- techies_tech_rival_13

  -- Kill Meepo
  PrecacheResource("soundfile", "sounds/vo/techies/tech_kill_02.vsnd", context) -- techies_tech_kill_02

  -- Kill Skywrath
  PrecacheResource("soundfile", "sounds/vo/techies/tech_kill_03.vsnd", context) -- techies_tech_kill_03
  --------------------------------------------------------------------------------------------------------------------------
  -- Winter Wyvern
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/winter_wyvern/winwyv_rare_01.vsnd", context) -- winter_wyvern_winwyv_rare_01
  PrecacheResource("soundfile", "sounds/vo/winter_wyvern/winwyv_respawn_03.vsnd", context) -- winter_wyvern_winwyv_respawn_03
  PrecacheResource("soundfile", "sounds/vo/winter_wyvern/winwyv_rival_01.vsnd", context) -- winter_wyvern_winwyv_rival_01

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/winter_wyvern/winwyv_thanks_03.vsnd", context) -- winter_wyvern_winwyv_thanks_03
  PrecacheResource("soundfile", "sounds/vo/winter_wyvern/winwyv_thanks_02.vsnd", context) --winter_wyvern_winwyv_thanks_02

  -- Kill Lone Druid
  PrecacheResource("soundfile", "sounds/vo/winter_wyvern/winwyv_rival_17.vsnd", context) -- winter_wyvern_winwyv_rival_17

  -- Kill Jakiro
  PrecacheResource("soundfile", "sounds/vo/winter_wyvern/winwyv_rival_10.vsnd", context) -- winter_wyvern_winwyv_rival_10

  -- Kill Meepo
  PrecacheResource("soundfile", "sounds/vo/winter_wyvern/winwyv_kill_10.vsnd", context) -- winter_wyvern_winwyv_kill_10
  --------------------------------------------------------------------------------------------------------------------------
  -- Kunkka
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_rare_01.vsnd", context) -- kunkka_kunk_rare_01
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_rare_02.vsnd", context) -- kunkka_kunk_rare_02
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_cast_03.vsnd", context) -- kunkka_kunk_cast_03

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_respawn_01.vsnd", context) -- kunkka_kunk_respawn_01
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_thanks_03.vsnd", context) -- kunkka_kunk_thanks_03

  -- Kill Doom
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_rival_30.vsnd", context) -- kunkka_kunk_rival_30

  -- Kill Shadow Fiend
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_rival_31.vsnd", context) -- kunkka_kunk_rival_31

  -- Kill Shadow Demon
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_rival_32.vsnd", context) -- kunkka_kunk_rival_32

  -- Kill Skywrath
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_kill_06.vsnd", context) -- kunkka_kunk_kill_06

  -- Kill Undying
  PrecacheResource("soundfile", "sounds/vo/kunkka/kunk_kill_01.vsnd", context) -- kunkka_kunk_kill_01
  --------------------------------------------------------------------------------------------------------------------------
  -- Omniknight
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_cast_01.vsnd", context) -- omniknight_omni_cast_01
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_cast_02.vsnd", context) -- omniknight_omni_cast_02
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_respawn_07.vsnd", context) -- omniknight_omni_respawn_07

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_thanks_02.vsnd", context) -- omniknight_omni_thanks_02
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_respawn_04.vsnd", context) -- omniknight_omni_respawn_04

  -- Kill Doom
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_rival_03.vsnd", context) -- omniknight_omni_rival_03

  -- Kill Shadow Fiend
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_rival_11.vsnd", context) -- omniknight_omni_rival_11

  -- Kill Underlord
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_kill_10.vsnd", context) -- omniknight_omni_kill_10

  -- Kill Necrophos
  PrecacheResource("soundfile", "sounds/vo/omniknight/omni_kill_02.vsnd", context) -- omniknight_omni_kill_02
  --------------------------------------------------------------------------------------------------------------------------
  -- Beastmaster
  --------------------------------------------------------------------------------------------------------------------------
  -- Start of Wave
  PrecacheResource("soundfile", "sounds/vo/beastmaster/beas_respawn_09.vsnd", context) -- beastmaster_beas_respawn_09
  PrecacheResource("soundfile", "sounds/vo/beastmaster/beas_cast_02.vsnd", context) -- beastmaster_beas_cast_02
  PrecacheResource("soundfile", "sounds/vo/beastmaster/beas_cast_05.vsnd", context) -- beastmaster_beas_cast_05

  -- Revived
  PrecacheResource("soundfile", "sounds/vo/beastmaster/beas_thanks_02.vsnd", context) -- beastmaster_beas_thanks_02
  PrecacheResource("soundfile", "sounds/vo/beastmaster/beas_thanks_01.vsnd", context) -- beastmaster_beas_thanks_01

  -- Kill Ursa
  PrecacheResource("soundfile", "sounds/vo/beastmaster/beas_kill_03.vsnd", context) -- beastmaster_beas_kill_03

  -- Kill Undying
  PrecacheResource("soundfile", "sounds/vo/beastmaster/beas_kill_07.vsnd", context) -- beastmaster_beas_kill_07


  -- Boss Responses

  --------------------------------------------------------------------------------------------------------------------------
  --Treant Protector
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/treant/treant_ability_leechseed_03.vsnd", context) -- treant_treant_ability_leechseed_03
  PrecacheResource("soundfile", "sounds/vo/treant/treant_respawn_12.vsnd", context) -- treant_treant_respawn_12

  -- Silencing a hero mid cast
  PrecacheResource("soundfile", "sounds/vo/treant/treant_deny_07.vsnd", context) -- treant_treant_deny_07
  PrecacheResource("soundfile", "sounds/vo/treant/treant_deny_04.vsnd", context) -- treant_treant_deny_04
  PrecacheResource("soundfile", "sounds/vo/treant/treant_deny_03.vsnd", context) -- treant_treant_deny_03

  -- Leech Seed
  PrecacheResource("soundfile", "sounds/vo/treant/treant_ability_leechseed_02.vsnd", context) -- treant_treant_ability_leechseed_02
  PrecacheResource("soundfile", "sounds/vo/treant/treant_ability_leechseed_04.vsnd", context) -- treant_treant_ability_leechseed_04
  PrecacheResource("soundfile", "sounds/vo/treant/treant_ability_leechseed_05.vsnd", context) -- treant_treant_ability_leechseed_05

  -- Entangling a Hero
  PrecacheResource("soundfile", "sounds/vo/treant/treant_ability_overgrowth_05.vsnd", context) -- treant_treant_ability_overgrowth_05
  PrecacheResource("soundfile", "sounds/vo/treant/treant_ability_overgrowth_06.vsnd", context) -- treant_treant_ability_overgrowth_06
  PrecacheResource("soundfile", "sounds/vo/treant/treant_ability_overgrowth_09.vsnd", context) -- treant_treant_ability_overgrowth_09

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/treant/treant_deny_14.vsnd", context) -- treant_treant_deny_14
  PrecacheResource("soundfile", "sounds/vo/treant/treant_tango_01.vsnd", context) -- treant_treant_tango_01
  PrecacheResource("soundfile", "sounds/vo/treant/treant_tango_03.vsnd", context) -- treant_treant_tango_03
  PrecacheResource("soundfile", "sounds/vo/treant/treant_laugh_02.vsnd", context) -- treant_treant_tango_02
  PrecacheResource("soundfile", "sounds/vo/treant/treant_attack_11.vsnd", context) -- treant_treant_attack_11

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/treant/treant_cast_01.vsnd", context) -- treant_treant_cast_01

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/treant/treant_cast_03.vsnd", context) -- treant_treant_cast_03

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/treant/treant_death_15.vsnd", context) -- treant_treant_death_15
  PrecacheResource("soundfile", "sounds/vo/treant/treant_death_16.vsnd", context) -- treant_treant_death_16

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/treant/treant_win_04.vsnd", context) -- treant_treant_win_04


  --------------------------------------------------------------------------------------------------------------------------
  --Dark Willow
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_hero_intro_02.vsnd", context) -- dark_willow_sylph_hero_intro_02
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_illus_03.vsnd", context) -- dark_willow_sylph_illus_03

  -- Creating Labrynthe
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_attack_14.vsnd", context) -- dark_willow_sylph_attack_14
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability1_13.vsnd", context) -- dark_willow_sylph_ability1_13
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability2_04.vsnd", context) -- dark_willow_sylph_ability2_04

  -- Entangling a hero
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability1_01.vsnd", context) -- dark_willow_sylph_ability1_01
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability1_02.vsnd", context) -- dark_willow_sylph_ability1_02
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability1_03.vsnd", context) -- dark_willow_sylph_ability1_03

  -- Going invisible
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability2_03.vsnd", context) -- dark_willow_sylph_ability2_03
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability2_07.vsnd", context) -- dark_willow_sylph_ability2_07
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability2_12.vsnd", context) -- dark_willow_sylph_ability2_12

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability2_06.vsnd", context) -- dark_willow_sylph_ability2_06
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability3_02.vsnd", context) -- dark_willow_sylph_ability3_02
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_kill_02.vsnd", context) -- dark_willow_sylph_kill_02
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_ability3_07.vsnd", context) -- dark_willow_sylph_ability3_07
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_laugh_02.vsnd", context) -- dark_willow_sylph_laugh_02

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_taunt_01.vsnd", context) -- dark_willow_sylph_taunt_01

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_respawn_06.vsnd", context) -- dark_willow_sylph_respawn_06

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_death_01.vsnd", context) -- dark_willow_sylph_death_01
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_death_03.vsnd", context) -- dark_willow_sylph_death_03

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/dark_willow/sylph_win_05.vsnd", context) -- dark_willow_sylph_win_05

  --------------------------------------------------------------------------------------------------------------------------
  --Lone Druid
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_ability_battlecry_01.vsnd", context) -- lone_druid_lone_druid_ability_battlecry_01
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_attack_10.vsnd", context) -- lone_druid_lone_druid_attack_10

  -- Buff Bear
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_ability_rabid_02.vsnd", context) -- lone_druid_lone_druid_ability_rabid_02
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_ability_battlecry_03.vsnd", context) -- lone_druid_lone_druid_ability_battlecry_03
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_cast_02.vsnd", context) -- lone_druid_lone_druid_cast_02

  -- True Form
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_ability_trueform_03.vsnd", context) -- ???
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_ability_trueform_02.vsnd", context) -- ???
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_ability_trueform_05.vsnd", context) -- ???

  -- Trap Sprung
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_kill_09.vsnd", context) -- lone_druid_lone_druid_kill_09
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_kill_03.vsnd", context) -- lone_druid_lone_druid_kill_03
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_kill_02.vsnd", context) -- lone_druid_lone_druid_kill_02

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_laugh_04.vsnd", context) -- lone_druid_lone_druid_laugh_04
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_laugh_06.vsnd", context) -- lone_druid_lone_druid_laugh_06
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_lasthit_01.vsnd", context) -- lone_druid_lone_druid_lasthit_01
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_deny_06.vsnd", context) -- lone_druid_lone_druid_deny_06
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_deny_10.vsnd", context) -- lone_druid_lone_druid_deny_10

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_level_09.vsnd", context) -- lone_druid_lone_druid_level_09

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_death_12.vsnd", context) -- lone_druid_lone_druid_death_12

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_death_07.vsnd", context) -- lone_druid_lone_druid_death_07
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_death_10.vsnd", context) -- lone_druid_lone_druid_death_10

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/lone_druid/lone_druid_deny_09.vsnd", context) -- lone_druid_lone_druid_deny_09

  --------------------------------------------------------------------------------------------------------------------------
  -- Doom
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_respawn_01.vsnd", context) -- doom_bringer_doom_respawn_01
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_respawn_10.vsnd", context) -- doom_bringer_doom_respawn_10

  -- New Ability
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_lvldeath_01.vsnd", context) -- doom_bringer_doom_ability_lvldeath_01
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_lvldeath_03.vsnd", context) -- doom_bringer_doom_ability_lvldeath_03
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_fail_02.vsnd", context) -- doom_bringer_doom_ability_fail_02

  -- Scorched Earth
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_scorched_01.vsnd", context) -- doom_bringer_doom_ability_scorched_01
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_scorched_02.vsnd", context) -- doom_bringer_doom_ability_scorched_02
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_scorched_03.vsnd", context) -- doom_bringer_doom_ability_scorched_03

  -- Doom
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_doom_01.vsnd", context) -- doom_bringer_doom_ability_doom_01
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_doom_05.vsnd", context) -- doom_bringer_doom_ability_doom_05
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_ability_doom_03.vsnd", context) -- doom_bringer_doom_ability_doom_03

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_level_07.vsnd", context) -- doom_bringer_doom_level_07
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_deny_08.vsnd", context) -- doom_bringer_doom_level_08
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_kill_01.vsnd", context) -- doom_bringer_doom_kill_01
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_laugh_03.vsnd", context) -- doom_bringer_doom_level_03
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_kill_02.vsnd", context) -- doom_bringer_doom_kill_02

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_level_01.vsnd", context) -- doom_bringer_doom_level_01

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_notyet_01.vsnd", context) -- doom_bringer_doom_notyet_01

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_death_02.vsnd", context) -- doom_bringer_doom_death_02
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_death_09.vsnd", context) -- doom_bringer_doom_death_09

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/doom_bringer/doom_kill_06.vsnd", context) -- doom_bringer_doom_kill_06

  --------------------------------------------------------------------------------------------------------------------------
  -- Meepo
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_begin_01.vsnd", context) -- meepo_meepo_begin_01
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_begin_02.vsnd", context) -- meepo_meepo_begin_02

  -- Earthbind
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_earthbind_01.vsnd", context) -- meepo_meepo_earthbind_01
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_earthbind_02.vsnd", context) -- meepo_meepo_earthbind_02
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_earthbind_04.vsnd", context) -- meepo_meepo_earthbind_04

  -- Poof away
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_poof_06.vsnd", context) -- meepo_meepo_poof_06
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_poof_08.vsnd", context) -- meepo_meepo_poof_08
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_poof_02.vsnd", context) -- meepo_meepo_poof_02

  -- Stealing Money
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_lasthit_06.vsnd", context) -- meepo_meepo_lasthit_06
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_lasthit_07.vsnd", context) -- meepo_meepo_lasthit_07
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_lasthit_05.vsnd", context) -- meepo_meepo_lasthit_05

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_kill_03.vsnd", context) -- meepo_meepo_kill_03
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_kill_07.vsnd", context) -- meepo_meepo_kill_07
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_kill_15.vsnd", context) -- meepo_meepo_kill_15
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_kill_20.vsnd", context) -- meepo_meepo_kill_20
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_lasthit_10.vsnd", context) -- meepo_meepo_lasthit_10

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_kill_23.vsnd", context) -- meepo_meepo_kill_23

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_respawn_03.vsnd", context) -- meepo_meepo_respawn_03

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_death_09.vsnd", context) -- meepo_meepo_death_09
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_death_06.vsnd", context) -- meepo_meepo_death_06

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/meepo/meepo_win_05.vsnd", context) -- meepo_meepo_win_05

  --------------------------------------------------------------------------------------------------------------------------
  -- Ursa
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_begin_01.vsnd", context) -- ursa_ursa_begin_01
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_move_17.vsnd", context) -- ursa_ursa_move_17

  -- Overpower
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_overpower_03.vsnd", context) -- ursa_ursa_overpower_03
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_overpower_05.vsnd", context) -- ursa_ursa_overpower_05
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_enrage_06.vsnd", context) -- ursa_ursa_enrage_06

  -- Earthshock
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_earthshock_01.vsnd", context) -- ursa_ursa_earthshock_01
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_earthshock_03.vsnd", context) -- ursa_ursa_earthshock_03
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_earthshock_05.vsnd", context) -- ursa_ursa_earthshock_05

  -- Magic Immune
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_levelup_04.vsnd", context) -- ursa_ursa_levelup_04
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_respawn_05.vsnd", context) -- ursa_ursa_respawn_05
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_spawn_02.vsnd", context) -- ursa_ursa_spawn_02

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_kill_02.vsnd", context) -- ursa_ursa_kill_02
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_kill_14.vsnd", context) -- ursa_ursa_kill_14
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_lasthit_03.vsnd", context) -- ursa_ursa_lasthit_03
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_lasthit_04.vsnd", context) -- ursa_ursa_lasthit_04
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_laugh_07.vsnd", context) -- ursa_ursa_laugh_07

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_immort_02.vsnd", context) -- ursa_ursa_immort_02

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_spawn_04.vsnd", context) -- ursa_ursa_spawn_04

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_death_11.vsnd", context) -- ursa_ursa_death_11
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_death_02.vsnd", context) -- ursa_ursa_death_02

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/ursa/ursa_kill_08.vsnd", context) -- ursa_ursa_kill_08

  --------------------------------------------------------------------------------------------------------------------------
  --Huskar
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_cast_03.vsnd", context) -- huskar_husk_cast_03
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_cast_02.vsnd", context) -- huskar_husk_cast_02

  -- Healing
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_healthup_01.vsnd", context) -- huskar_husk_healthup_01
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_ability_innervit_10.vsnd", context) -- huskar_husk_ability_innervit_10
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_ability_innervit_03.vsnd", context) -- huskar_husk_ability_innervit_03

  -- Lifebreak
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_ability_lifebrk_06.vsnd", context) -- huskar_husk_ability_lifebrk_06
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_ability_lifebrk_02.vsnd", context) -- huskar_husk_ability_lifebrk_02
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_ability_brskrblood_03.vsnd", context) -- huskar_husk_ability_brskrblood_03

  -- Beserker's Blood
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_ability_brskrblood_01.vsnd", context) -- huskar_husk_ability_brskrblood_01
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_ability_brnspear_01.vsnd", context) -- huskar_husk_ability_brnspear_01
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_ability_brskrblood_02.vsnd", context) -- huskar_husk_ability_brskrblood_02

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_lasthit_02.vsnd", context) -- huskar_husk_lasthit_02
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_lasthit_03.vsnd", context) -- huskar_husk_lasthit_03
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_lasthit_08.vsnd", context) -- huskar_husk_lasthit_08
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_kill_10.vsnd", context) -- huskar_husk_kill_10
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_kill_12.vsnd", context) -- huskar_husk_kill_12

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_respawn_08.vsnd", context) -- huskar_husk_respawn_08

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_respawn_10.vsnd", context) -- huskar_husk_respawn_10

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_death_06.vsnd", context) -- huskar_husk_death_06
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_death_08.vsnd", context) -- huskar_husk_death_08

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/huskar/husk_kill_04.vsnd", context) -- huskar_husk_kill_04

  --------------------------------------------------------------------------------------------------------------------------
  --Witch Doctor
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_respawn_10.vsnd", context) -- witchdoctor_wdoc_respawn_10
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_move_06.vsnd", context) -- witchdoctor_wdoc_move_06

  -- Cask
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_ability_cask_01.vsnd", context) -- witchdoctor_wdoc_ability_cask_01
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_ability_cask_03.vsnd", context) -- witchdoctor_wdoc_ability_cask_03
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_ability_cask_07.vsnd", context) -- witchdoctor_wdoc_ability_cask_07

  -- Maledict
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_ability_maledict_01.vsnd", context) -- witchdoctor_wdoc_ability_maledict_01
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_ability_maledict_02.vsnd", context) -- witchdoctor_wdoc_ability_maledict_02
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_killspecial_01.vsnd", context) -- witchdoctor_wdoc_killspecial_01

  -- Death Ward
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_ability_voodoo_01.vsnd", context) -- witchdoctor_wdoc_ability_voodoo_01
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_ability_voodoo_02.vsnd", context) -- witchdoctor_wdoc_ability_voodoo_02
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_ability_voodoo_03.vsnd", context) -- witchdoctor_wdoc_ability_voodoo_03

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_kill_02.vsnd", context) -- witchdoctor_wdoc_kill_02
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_laugh_04.vsnd", context) -- witchdoctor_wdoc_laugh_04
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_lasthit_06.vsnd", context) -- witchdoctor_wdoc_lasthit_06
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_lasthit_09.vsnd", context) -- witchdoctor_wdoc_lasthit_09
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_laugh_05.vsnd", context) -- witchdoctor_wdoc_laugh_05

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_respawn_11.vsnd", context) -- witchdoctor_wdoc_respawn_11

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_respawn_09.vsnd", context) -- witchdoctor_wdoc_respawn_09

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_death_04.vsnd", context) -- witchdoctor_wdoc_death_04
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_death_11.vsnd", context) -- witchdoctor_wdoc_death_11

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/witchdoctor/wdoc_win_04.vsnd", context) -- witchdoctor_wdoc_win_04

  --------------------------------------------------------------------------------------------------------------------------
  --Earth Spirit
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_spawn_06.vsnd", context) -- earth_spirit_earthspi_spawn_06
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_battlebegins_02.vsnd", context) -- earth_spirit_earthspi_battlebegins_02

  -- Bouldersmash
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_bouldersmash_02.vsnd", context) -- earth_spirit_earthspi_bouldersmash_02
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_bouldersmash_03.vsnd", context) -- earth_spirit_earthspi_bouldersmash_03
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_bouldersmash_01.vsnd", context) -- earth_spirit_earthspi_bouldersmash_01

  -- 
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_magnetize_03.vsnd", context) -- earth_spirit_earthspi_magnetize_03
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_magnetize_01.vsnd", context) -- earth_spirit_earthspi_magnetize_01
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_magnetize_02.vsnd", context) -- earth_spirit_earthspi_magnetize_02

  -- Geomagnetic Pull
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_geomagnetic_01.vsnd", context) -- earth_spirit_earthspi_geomagnetic_01
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_geomagnetic_04.vsnd", context) -- earth_spirit_earthspi_geomagnetic_04
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_geomagnetic_06.vsnd", context) -- earth_spirit_earthspi_geomagnetic_06

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_lasthit_03.vsnd", context) -- earth_spirit_earthspi_lasthit_03
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_kill_08.vsnd", context) -- earth_spirit_earthspi_kill_08
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_kill_09.vsnd", context) -- earth_spirit_earthspi_kill_09
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_kill_11.vsnd", context) -- earth_spirit_earthspi_kill_11
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_kill_05.vsnd", context) -- earth_spirit_earthspi_kill_05

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_attack_08.vsnd", context) -- earth_spirit_earthspi_attack_08

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_respawn_10.vsnd", context) -- earth_spirit_earthspi_respawn_10

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_death_03.vsnd", context) -- earth_spirit_earthspi_death_03
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_death_10.vsnd", context) -- earth_spirit_earthspi_death_10

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/earth_spirit/earthspi_kill_14.vsnd", context) -- earth_spirit_earthspi_kill_14

  --------------------------------------------------------------------------------------------------------------------------
  --Elder Titan
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_attack_07.vsnd", context) -- elder_titan_elder_attack_07
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_attack_06.vsnd", context) -- elder_titan_elder_attack_06

  -- Astral Spirit
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_ancestralspirit_01.vsnd", context) -- elder_titan_elder_ancestralspirit_01
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_ancestralspirit_06.vsnd", context) --elder_titan_elder_ancestralspirit_06
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_ancestralspirit_03.vsnd", context) -- elder_titan_elder_ancestralspirit_03

  -- Earth Splitter
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_earthsplitter_02.vsnd", context) -- elder_titan_elder_earthsplitter_02
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_earthsplitter_03.vsnd", context) -- elder_titan_elder_earthsplitter_03
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_earthsplitter_05.vsnd", context) -- elder_titan_elder_earthsplitter_05

  -- Echo Stomp
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_echostomp_01.vsnd", context) -- elder_titan_elder_echostomp_01
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_echostomp_02.vsnd", context) -- elder_titan_elder_echostomp_02
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_echostomp_08.vsnd", context) -- elder_titan_elder_echostomp_08

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_kill_05.vsnd", context) --elder_titan_elder_kill_05
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_kill_10.vsnd", context) -- elder_titan_elder_kill_10
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_kill_09.vsnd", context) -- elder_titan_elder_kill_09
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_earthsplitter_06.vsnd", context) -- elder_titan_elder_earthsplitter_06
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_kill_02.vsnd", context) -- elder_titan_elder_kill_02

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_deny_09.vsnd", context) -- elder_titan_elder_deny_09

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_death_15.vsnd", context) -- elder_titan_elder_death_15

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_death_11.vsnd", context) -- elder_titan_elder_death_11
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_death_14.vsnd", context) -- elder_titan_elder_death_14

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/elder_titan/elder_failure_02.vsnd", context) -- elder_titan_elder_failure_02

  --------------------------------------------------------------------------------------------------------------------------
  --Shadow Fiend
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_ability_presence_01.vsnd", context) -- nevermore_nev_ability_presence_01
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_ability_presence_02.vsnd", context) -- nevermore_nev_ability_presence_02

  -- Requiem
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_ability_requiem_01.vsnd", context) -- nevermore_nev_ability_requiem_01
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_ability_requiem_08.vsnd", context) -- nevermore_nev_ability_requiem_08
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_attack_01.vsnd", context) -- nevermore_nev_attack_01

  -- Take control
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_kill_04.vsnd", context) -- nevermore_nev_kill_04
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_kill_05.vsnd", context) -- nevermore_nev_kill_05
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_kill_13.vsnd", context) -- nevermore_nev_kill_13

  -- 
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_cast_01.vsnd", context) -- nevermore_nev_cast_01
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_cast_02.vsnd", context) -- nevermore_nev_cast_02
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_cast_03.vsnd", context) -- nevermore_nev_cast_03

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_kill_01.vsnd", context) -- nevermore_nev_kill_01
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_lasthit_01.vsnd", context) -- nevermore_nev_lasthit_01
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_kill_07.vsnd", context) -- nevermore_nev_kill_07
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_lasthit_06.vsnd", context) -- nevermore_nev_lasthit_06
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_kill_09.vsnd", context) -- nevermore_nev_kill_09

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_respawn_02.vsnd", context) -- nevermore_nev_respawn_02

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_respawn_08.vsnd", context) -- nevermore_nev_respawn_08

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_death_15.vsnd", context) -- nevermore_nev_death_15
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_death_12.vsnd", context) -- nevermore_nev_death_12

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/nevermore/nev_rare_03.vsnd", context) -- nevermore_nev_rare_03

  --------------------------------------------------------------------------------------------------------------------------
  -- Shadow Demon
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_spawn_02.vsnd", context) -- shadow_demon_shadow_demon_spawn_02
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_battlebegins_01.vsnd", context) -- shadow_demon_shadow_demon_battlebegins_01

  -- Creating Illusions of Heroes
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_disruption_05.vsnd", context) -- shadow_demon_shadow_demon_ability_disruption_05
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_disruption_06.vsnd", context) -- shadow_demon_shadow_demon_ability_disruption_06
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_disruption_14.vsnd", context) -- shadow_demon_shadow_demon_ability_disruption_14

  -- Soul catcher
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_soul_catcher_01.vsnd", context) -- shadow_demon_shadow_demon_ability_soul_catcher_01
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_soul_catcher_02.vsnd", context) -- shadow_demon_shadow_demon_ability_soul_catcher_02
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_soul_catcher_03.vsnd", context) -- shadow_demon_shadow_demon_ability_soul_catcher_03

  -- Purged and split apart
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_demonic_purge_03.vsnd", context) -- shadow_demon_shadow_demon_ability_demonic_purge_03
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_demonic_purge_04.vsnd", context) -- shadow_demon_shadow_demon_ability_demonic_purge_04
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_ability_demonic_purge_05.vsnd", context) -- shadow_demon_shadow_demon_ability_demonic_purge_05

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_lasthit_07.vsnd", context) -- shadow_demon_shadow_demon_lasthit_07
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_lasthit_09.vsnd", context) -- shadow_demon_shadow_demon_lasthit_09
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_lasthit_10.vsnd", context) -- shadow_demon_shadow_demon_lasthit_10
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_laugh_01.vsnd", context) -- shadow_demon_shadow_demon_laugh_01
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_laugh_03.vsnd", context) -- shadow_demon_shadow_demon_laugh_03

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_kill_10.vsnd", context) -- shadow_demon_shadow_demon_kill_10

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_kill_06.vsnd", context) -- shadow_demon_shadow_demon_kill_06

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_death_08.vsnd", context) -- shadow_demon_shadow_demon_death_08
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_death_03.vsnd", context) -- shadow_demon_shadow_demon_death_03

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/shadow_demon/shadow_demon_immort_02.vsnd", context) -- shadow_demon_shadow_demon_immort_02

  --------------------------------------------------------------------------------------------------------------------------
  --Centaur
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_battlebegins_01.vsnd", context) -- centaur_cent_battlebegins_01
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_respawn_10.vsnd", context) -- centaur_cent_respawn_10

  -- Double Edge
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_doub_edge_05.vsnd", context) -- centaur_cent_doub_edge_05
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_doub_edge_06.vsnd", context) -- centaur_cent_doub_edge_06
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_doub_edge_07.vsnd", context) -- centaur_cent_doub_edge_07

  -- Hoof Stomp
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_hoof_stomp_01.vsnd", context) -- centaur_cent_hoof_stomp_01
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_hoof_stomp_04.vsnd", context) -- centaur_cent_hoof_stomp_04
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_hoof_stomp_02.vsnd", context) -- centaur_cent_hoof_stomp_02

  -- Charge
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_move_08.vsnd", context) -- centaur_cent_move_08
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_move_10.vsnd", context) -- centaur_cent_move_10
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_move_18.vsnd", context) -- centaur_cent_move_18

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_lasthit_09.vsnd", context) -- centaur_cent_lasthit_09
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_kill_03.vsnd", context) -- centaur_cent_kill_03
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_kill_04.vsnd", context) -- centaur_cent_kill_04
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_kill_01.vsnd", context) -- centaur_cent_kill_01
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_kill_12.vsnd", context) -- centaur_cent_kill_12

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_underattack_01.vsnd", context) -- centaur_cent_underattack_01

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_death_12.vsnd", context) -- centaur_cent_death_12

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_death_09.vsnd", context) -- centaur_cent_death_09
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_death_10.vsnd", context) -- centaur_cent_death_10

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/centaur/cent_kill_08.vsnd", context) -- centaur_cent_kill_08

  --------------------------------------------------------------------------------------------------------------------------
  --Underlord
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_move_15.vsnd", context) -- abyssal_underlord_abys_move_15
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_move_14.vsnd", context) -- abyssal_underlord_abys_move_14

  -- Firestorm
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_firestrorm_01.vsnd", context) -- abyssal_underlord_abys_firestrorm_01
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_firestrorm_04.vsnd", context) -- abyssal_underlord_abys_firestrorm_04
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_firestrorm_06.vsnd", context) -- abyssal_underlord_abys_firestrorm_06

  -- Pit of Malice
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_pitofmalice_03.vsnd", context) -- abyssal_underlord_abys_pitofmalice_03
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_pitofmalice_04.vsnd", context) -- abyssal_underlord_abys_pitofmalice_04
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_pitofmalice_06.vsnd", context) -- abyssal_underlord_abys_pitofmalice_06

  -- Teleport
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_darkrift_05.vsnd", context) -- abyssal_underlord_abys_darkrift_05
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_move_10.vsnd", context) -- abyssal_underlord_abys_move_10
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_darkrift_04.vsnd", context) -- abyssal_underlord_abys_darkrift_04

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_kill_01.vsnd", context) -- abyssal_underlord_abys_kill_01
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_kill_04.vsnd", context) -- abyssal_underlord_abys_kill_04
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_kill_23.vsnd", context) -- abyssal_underlord_abys_kill_23
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_kill_10.vsnd", context) -- abyssal_underlord_abys_kill_10
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_lasthit_06.vsnd", context) -- abyssal_underlord_abys_lasthit_06

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_kill_13.vsnd", context) -- abyssal_underlord_abys_kill_13

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_death_08.vsnd", context) -- abyssal_underlord_abys_death_08

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_death_10.vsnd", context) -- abyssal_underlord_abys_death_10
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_death_03.vsnd", context) -- abyssal_underlord_abys_death_03

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/abyssal_underlord/abys_firstblood_02.vsnd", context) -- abyssal_underlord_abys_firstblood_02

  --------------------------------------------------------------------------------------------------------------------------
  --Skywrath Mage
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_move_05.vsnd", context) -- skywrath_mage_drag_move_05
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_cast_02.vsnd", context) -- skywrath_mage_drag_cast_02

  -- Arcane bolt
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_arcanebolt_01.vsnd", context) -- skywrath_mage_drag_arcanebolt_01
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_arcanebolt_02.vsnd", context) -- skywrath_mage_drag_arcanebolt_02
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_arcanebolt_03.vsnd", context) -- skywrath_mage_drag_arcanebolt_03

  -- Ancient seal
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_ancient_seal_01.vsnd", context) -- skywrath_mage_drag_ancient_seal_01
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_ancient_seal_02.vsnd", context) -- skywrath_mage_drag_ancient_seal_02
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_ancient_seal_03.vsnd", context) -- skywrath_mage_drag_ancient_seal_03

  -- Mystic flare
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_mystic_flare_01.vsnd", context) -- skywrath_mage_drag_mystic_flare_01
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_mystic_flare_02.vsnd", context) -- skywrath_mage_drag_mystic_flare_02
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_mystic_flare_03.vsnd", context) -- skywrath_mage_drag_mystic_flare_03

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_lasthit_02.vsnd", context) -- skywrath_mage_drag_lasthit_02
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_lasthit_06.vsnd", context) -- skywrath_mage_drag_lasthit_06
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_kill_11.vsnd", context) -- skywrath_mage_drag_kill_11
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_kill_09.vsnd", context) -- skywrath_mage_drag_kill_09
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_laugh_01.vsnd", context) -- skywrath_mage_drag_laugh_01

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_respawn_01.vsnd", context) -- skywrath_mage_drag_respawn_01

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_cast_01.vsnd", context) -- skywrath_mage_drag_cast_01

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_death_10.vsnd", context) -- skywrath_mage_drag_death_10
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_death_02.vsnd", context) -- skywrath_mage_drag_death_02

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/skywrath_mage/drag_kill_07.vsnd", context) -- skywrath_mage_drag_kill_07

  --------------------------------------------------------------------------------------------------------------------------
  --Jakiro
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_battlebegins_01.vsnd", context) -- jakiro_jak_battlebegins_01
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_battlebegins_02.vsnd", context) -- jakiro_jak_battlebegins_02

  -- Dual breath
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_dual_01.vsnd", context) -- jakiro_jak_ability_dual_01
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_dual_02.vsnd", context) -- jakiro_jak_ability_dual_02
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_dual_03.vsnd", context) -- jakiro_jak_ability_dual_03

  -- Ice Path
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_icepath_01.vsnd", context) -- jakiro_jak_ability_icepath_01
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_icepath_02.vsnd", context) -- jakiro_jak_ability_icepath_02
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_icepath_03.vsnd", context) -- jakiro_jak_ability_icepath_03

  -- Macropyre
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_macro_01.vsnd", context) -- jakiro_jak_ability_macro_01
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_macro_02.vsnd", context) -- jakiro_jak_ability_macro_02
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_macro_04.vsnd", context) -- jakiro_jak_ability_macro_04

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_kill_01.vsnd", context) -- jakiro_jak_kill_01
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_kill_04.vsnd", context) -- jakiro_jak_kill_04
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_laugh_01.vsnd", context) -- jakiro_jak_laugh_01
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_kill_15.vsnd", context) -- jakiro_jak_kill_15
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_brother_02.vsnd", context) -- jakiro_jak_brother_02

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_ability_failure_07.vsnd", context) -- jakiro_jak_ability_failure_07

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_kill_08.vsnd", context) -- jakiro_jak_kill_08

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_death_02.vsnd", context) -- jakiro_jak_death_02
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_death_08.vsnd", context) -- jakiro_jak_death_08

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/jakiro/jak_win_03.vsnd", context) -- jakiro_jak_win_03

  --------------------------------------------------------------------------------------------------------------------------
  -- Undying
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/undying/undying_spawn_04.vsnd", context) -- undying_undying_spawn_04
  PrecacheResource("soundfile", "sounds/vo/undying/undying_spawn_02.vsnd", context) -- undying_undying_spawn_02

  -- Summon zombies
  PrecacheResource("soundfile", "sounds/vo/undying/undying_tombstone_01.vsnd", context) -- undying_undying_tombstone_01
  PrecacheResource("soundfile", "sounds/vo/undying/undying_tombstone_02.vsnd", context) -- undying_undying_tombstone_02
  PrecacheResource("soundfile", "sounds/vo/undying/undying_tombstone_06.vsnd", context) -- undying_undying_tombstone_06

  -- Decay
  PrecacheResource("soundfile", "sounds/vo/undying/undying_decay_01.vsnd", context) -- undying_undying_decay_01
  PrecacheResource("soundfile", "sounds/vo/undying/undying_decay_03.vsnd", context) -- undying_undying_decay_03
  PrecacheResource("soundfile", "sounds/vo/undying/undying_decay_05.vsnd", context) -- undying_undying_decay_05

  -- Soul rip
  PrecacheResource("soundfile", "sounds/vo/undying/undying_soulrip_01.vsnd", context) -- undying_undying_soulrip_01
  PrecacheResource("soundfile", "sounds/vo/undying/undying_soulrip_03.vsnd", context) -- undying_undying_soulrip_03
  PrecacheResource("soundfile", "sounds/vo/undying/undying_soulrip_02.vsnd", context) -- undying_undying_soulrip_02

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/undying/undying_lasthit_02.vsnd", context) -- undying_undying_lasthit_02
  PrecacheResource("soundfile", "sounds/vo/undying/undying_lasthit_03.vsnd", context) -- undying_undying_lasthit_03
  PrecacheResource("soundfile", "sounds/vo/undying/undying_lasthit_04.vsnd", context) -- undying_undying_lasthit_04
  PrecacheResource("soundfile", "sounds/vo/undying/undying_kill_03.vsnd", context) -- undying_undying_kill_03
  PrecacheResource("soundfile", "sounds/vo/undying/undying_kill_10.vsnd", context) -- undying_undying_kill_10

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/undying/undying_levelup_05.vsnd", context) -- undying_undying_levelup_05

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/undying/undying_levelup_07.vsnd", context) -- undying_undying_levelup_07

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/undying/undying_death_08.vsnd", context) -- undying_undying_death_08
  PrecacheResource("soundfile", "sounds/vo/undying/undying_death_11.vsnd", context) -- undying_undying_death_11

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/undying/undying_win_05.vsnd", context) -- undying_undying_win_05

  --------------------------------------------------------------------------------------------------------------------------
  --Necrophos
  --------------------------------------------------------------------------------------------------------------------------

  -- Start of battle
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_spawn_02.vsnd", context) -- necrolyte_necr_spawn_02
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_respawn_14.vsnd", context) -- necrolyte_necr_respawn_14

  -- Death pulse
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_ability_tox_01.vsnd", context) -- necrolyte_necr_ability_tox_01
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_ability_tox_02.vsnd", context) -- necrolyte_necr_ability_tox_02
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_ability_tox_03.vsnd", context) -- necrolyte_necr_ability_tox_03

  -- Ghost Shroud
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_deny_08.vsnd", context) -- necrolyte_necr_deny_08
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_deny_05.vsnd", context) -- necrolyte_necr_deny_05
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_deny_03.vsnd", context) -- necrolyte_necr_deny_03

  -- Reaper's Scythe
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_ability_reap_01.vsnd", context) -- necrolyte_necr_ability_reap_01
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_ability_reap_02.vsnd", context) -- necrolyte_necr_ability_reap_02
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_ability_reap_03.vsnd", context) -- necrolyte_necr_ability_reap_03

  -- Hero dies
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_lasthit_03.vsnd", context) -- necrolyte_necr_lasthit_03
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_kill_01.vsnd", context) -- necrolyte_necr_kill_01
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_kill_04.vsnd", context) -- necrolyte_necr_kill_04
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_kill_05.vsnd", context) -- necrolyte_necr_kill_05
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_lasthit_02.vsnd", context) -- necrolyte_necr_lasthit_02

  -- 75% HP
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_breath_01.vsnd", context) -- necrolyte_necr_breath_01

  -- 25% HP
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_immort_02.vsnd", context) -- necrolyte_necr_immort_02

  -- Defeat
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_death_02.vsnd", context) -- necrolyte_necr_death_02
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_death_06.vsnd", context) -- necrolyte_necr_death_06

  -- All heroes dead
  PrecacheResource("soundfile", "sounds/vo/necrolyte/necr_kill_10.vsnd", context) -- necrolyte_necr_kill_10
end

DebugPrint('[---------------------------------------------------------------------] boss responses!\n\n')