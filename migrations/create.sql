--postgres user by default connects to postgres db
ALTER USER postgres WITH PASSWORD 'postgres';
--default schema is public
drop schema public cascade;
create schema public;

CREATE TABLE matches (
  match_id bigint PRIMARY KEY,
  match_seq_num bigint,
  radiant_win boolean,
  start_time bigint,
  duration integer,
  tower_status_radiant integer,
  tower_status_dire integer,
  barracks_status_radiant integer,
  barracks_status_dire integer,
  cluster integer,
  first_blood_time integer,
  lobby_type integer,
  human_players integer,
  leagueid integer,
  positive_votes integer,
  negative_votes integer,
  game_mode integer,
  engine integer,
  --radiant_team_name varchar(255),
  --dire_team_name varchar(255),
  --parsed data
  parse_status integer,
  url varchar(255),
  chat JSONB,
  objectives JSONB,
  radiant_gold_adv JSONB,
  radiant_xp_adv JSONB,
  teamfights JSONB,
  version integer,
  --from skill api
  skill integer
  );

CREATE TABLE players (
  account_id bigint PRIMARY KEY,
  steamid varchar(255),
  avatar varchar(255),
  personaname varchar(255),
  last_login timestamp with time zone,
  full_history_time timestamp with time zone,
  cheese bigint,
  fh_unavailable boolean
  /*
    "avatarfull" : "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/88/883f2697f5b2dc4affda2d47eedc1cbec8cfb657_full.jpg",
    "avatarmedium" : "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/avatars/88/883f2697f5b2dc4affda2d47eedc1cbec8cfb657_medium.jpg",
    "communityvisibilitystate" : 3,
    "lastlogoff" : 1426020853,
    "loccityid" : 44807,
    "loccountrycode" : "TR",
    "locstatecode" : "16",
    "personastate" : 0,
    "personastateflags" : 0,
    "primaryclanid" : "103582791433775490",
    "profilestate" : 1,
    "profileurl" : "http://steamcommunity.com/profiles/76561198060610657/",
    "realname" : "Alper",
    "timecreated" : 1332289262,
  */
);

CREATE TABLE player_matches (
  PRIMARY KEY(match_id, player_slot),
      match_id bigint,
      account_id bigint,
      player_slot integer,
      hero_id integer,
      item_0 integer,
      item_1 integer,
      item_2 integer,
      item_3 integer,
      item_4 integer,
      item_5 integer,
      kills integer,
      deaths integer,
      assists integer,
      leaver_status integer,
      gold integer,
      last_hits integer,
      denies integer,
      gold_per_min integer,
      xp_per_min integer,
      gold_spent integer,
      hero_damage integer,
      tower_damage integer,
      hero_healing integer,
      level integer,
      ability_upgrades JSONB,
      --parsed fields below
      stuns real,
      max_hero_hit JSONB,
      times JSONB,
      gold_t JSONB,
      lh_t JSONB,
      xp_t JSONB,
      obs_log JSONB,
      sen_log JSONB,
      purchase_log JSONB,
      kills_log JSONB,
      buyback_log JSONB,
      lane_pos JSONB,
      obs JSONB,
      sen JSONB,
      actions JSONB,
      pings JSONB,
      purchase JSONB,
      gold_reasons JSONB,
      xp_reasons JSONB,
      killed JSONB,
      item_uses JSONB,
      ability_uses JSONB,
      hero_hits JSONB,
      damage JSONB,
      damage_taken JSONB,
      damage_inflictor JSONB,
      runes JSONB,
      killed_by JSONB,
      modifier_applied JSONB,
      kill_streaks JSONB,
      multi_kills JSONB,
      healing JSONB,
      kill_streaks_log JSONB, --an array of kill streak values
      multi_kill_id_vals JSONB --an array of multi kill values (the length of each multi kill)
);

CREATE TABLE player_ratings (
  PRIMARY KEY(account_id, match_id),
  account_id integer,
  match_id integer,
  solo_competitive_rank integer,
  competitive_rank integer, 
  time timestamp with time zone
);

CREATE INDEX on player_matches(account_id);
CREATE INDEX on matches(version);
CREATE INDEX on players(full_history_time);
CREATE INDEX on players(cheese);
CREATE INDEX on player_ratings(account_id, time);