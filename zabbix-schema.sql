--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: acknowledges; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.acknowledges (
    acknowledgeid bigint NOT NULL,
    userid bigint NOT NULL,
    eventid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    message character varying(255) DEFAULT ''::character varying NOT NULL,
    action integer DEFAULT 0 NOT NULL,
    old_severity integer DEFAULT 0 NOT NULL,
    new_severity integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.acknowledges OWNER TO zabbix;

--
-- Name: actions; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.actions (
    actionid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    eventsource integer DEFAULT 0 NOT NULL,
    evaltype integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    esc_period character varying(255) DEFAULT '1h'::character varying NOT NULL,
    def_shortdata character varying(255) DEFAULT ''::character varying NOT NULL,
    def_longdata text DEFAULT ''::text NOT NULL,
    r_shortdata character varying(255) DEFAULT ''::character varying NOT NULL,
    r_longdata text DEFAULT ''::text NOT NULL,
    formula character varying(255) DEFAULT ''::character varying NOT NULL,
    pause_suppressed integer DEFAULT 1 NOT NULL,
    ack_shortdata character varying(255) DEFAULT ''::character varying NOT NULL,
    ack_longdata text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.actions OWNER TO zabbix;

--
-- Name: alerts; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.alerts (
    alertid bigint NOT NULL,
    actionid bigint NOT NULL,
    eventid bigint NOT NULL,
    userid bigint,
    clock integer DEFAULT 0 NOT NULL,
    mediatypeid bigint,
    sendto character varying(1024) DEFAULT ''::character varying NOT NULL,
    subject character varying(255) DEFAULT ''::character varying NOT NULL,
    message text DEFAULT ''::text NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    retries integer DEFAULT 0 NOT NULL,
    error character varying(2048) DEFAULT ''::character varying NOT NULL,
    esc_step integer DEFAULT 0 NOT NULL,
    alerttype integer DEFAULT 0 NOT NULL,
    p_eventid bigint,
    acknowledgeid bigint,
    parameters text DEFAULT '{}'::text NOT NULL
);


ALTER TABLE public.alerts OWNER TO zabbix;

--
-- Name: application_discovery; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.application_discovery (
    application_discoveryid bigint NOT NULL,
    applicationid bigint NOT NULL,
    application_prototypeid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    lastcheck integer DEFAULT 0 NOT NULL,
    ts_delete integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.application_discovery OWNER TO zabbix;

--
-- Name: application_prototype; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.application_prototype (
    application_prototypeid bigint NOT NULL,
    itemid bigint NOT NULL,
    templateid bigint,
    name character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.application_prototype OWNER TO zabbix;

--
-- Name: application_template; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.application_template (
    application_templateid bigint NOT NULL,
    applicationid bigint NOT NULL,
    templateid bigint NOT NULL
);


ALTER TABLE public.application_template OWNER TO zabbix;

--
-- Name: applications; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.applications (
    applicationid bigint NOT NULL,
    hostid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    flags integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.applications OWNER TO zabbix;

--
-- Name: auditlog; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.auditlog (
    auditid bigint NOT NULL,
    userid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    action integer DEFAULT 0 NOT NULL,
    resourcetype integer DEFAULT 0 NOT NULL,
    details character varying(128) DEFAULT '0'::character varying NOT NULL,
    ip character varying(39) DEFAULT ''::character varying NOT NULL,
    resourceid bigint DEFAULT '0'::bigint NOT NULL,
    resourcename character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.auditlog OWNER TO zabbix;

--
-- Name: auditlog_details; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.auditlog_details (
    auditdetailid bigint NOT NULL,
    auditid bigint NOT NULL,
    table_name character varying(64) DEFAULT ''::character varying NOT NULL,
    field_name character varying(64) DEFAULT ''::character varying NOT NULL,
    oldvalue text DEFAULT ''::text NOT NULL,
    newvalue text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.auditlog_details OWNER TO zabbix;

--
-- Name: autoreg_host; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.autoreg_host (
    autoreg_hostid bigint NOT NULL,
    proxy_hostid bigint,
    host character varying(128) DEFAULT ''::character varying NOT NULL,
    listen_ip character varying(39) DEFAULT ''::character varying NOT NULL,
    listen_port integer DEFAULT 0 NOT NULL,
    listen_dns character varying(255) DEFAULT ''::character varying NOT NULL,
    host_metadata character varying(255) DEFAULT ''::character varying NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    tls_accepted integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.autoreg_host OWNER TO zabbix;

--
-- Name: conditions; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.conditions (
    conditionid bigint NOT NULL,
    actionid bigint NOT NULL,
    conditiontype integer DEFAULT 0 NOT NULL,
    operator integer DEFAULT 0 NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    value2 character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.conditions OWNER TO zabbix;

--
-- Name: config; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.config (
    configid bigint NOT NULL,
    refresh_unsupported character varying(32) DEFAULT '10m'::character varying NOT NULL,
    work_period character varying(255) DEFAULT '1-5,09:00-18:00'::character varying NOT NULL,
    alert_usrgrpid bigint,
    default_theme character varying(128) DEFAULT 'blue-theme'::character varying NOT NULL,
    authentication_type integer DEFAULT 0 NOT NULL,
    ldap_host character varying(255) DEFAULT ''::character varying NOT NULL,
    ldap_port integer DEFAULT 389 NOT NULL,
    ldap_base_dn character varying(255) DEFAULT ''::character varying NOT NULL,
    ldap_bind_dn character varying(255) DEFAULT ''::character varying NOT NULL,
    ldap_bind_password character varying(128) DEFAULT ''::character varying NOT NULL,
    ldap_search_attribute character varying(128) DEFAULT ''::character varying NOT NULL,
    dropdown_first_entry integer DEFAULT 1 NOT NULL,
    dropdown_first_remember integer DEFAULT 1 NOT NULL,
    discovery_groupid bigint NOT NULL,
    max_in_table integer DEFAULT 50 NOT NULL,
    search_limit integer DEFAULT 1000 NOT NULL,
    severity_color_0 character varying(6) DEFAULT '97AAB3'::character varying NOT NULL,
    severity_color_1 character varying(6) DEFAULT '7499FF'::character varying NOT NULL,
    severity_color_2 character varying(6) DEFAULT 'FFC859'::character varying NOT NULL,
    severity_color_3 character varying(6) DEFAULT 'FFA059'::character varying NOT NULL,
    severity_color_4 character varying(6) DEFAULT 'E97659'::character varying NOT NULL,
    severity_color_5 character varying(6) DEFAULT 'E45959'::character varying NOT NULL,
    severity_name_0 character varying(32) DEFAULT 'Not classified'::character varying NOT NULL,
    severity_name_1 character varying(32) DEFAULT 'Information'::character varying NOT NULL,
    severity_name_2 character varying(32) DEFAULT 'Warning'::character varying NOT NULL,
    severity_name_3 character varying(32) DEFAULT 'Average'::character varying NOT NULL,
    severity_name_4 character varying(32) DEFAULT 'High'::character varying NOT NULL,
    severity_name_5 character varying(32) DEFAULT 'Disaster'::character varying NOT NULL,
    ok_period character varying(32) DEFAULT '5m'::character varying NOT NULL,
    blink_period character varying(32) DEFAULT '2m'::character varying NOT NULL,
    problem_unack_color character varying(6) DEFAULT 'CC0000'::character varying NOT NULL,
    problem_ack_color character varying(6) DEFAULT 'CC0000'::character varying NOT NULL,
    ok_unack_color character varying(6) DEFAULT '009900'::character varying NOT NULL,
    ok_ack_color character varying(6) DEFAULT '009900'::character varying NOT NULL,
    problem_unack_style integer DEFAULT 1 NOT NULL,
    problem_ack_style integer DEFAULT 1 NOT NULL,
    ok_unack_style integer DEFAULT 1 NOT NULL,
    ok_ack_style integer DEFAULT 1 NOT NULL,
    snmptrap_logging integer DEFAULT 1 NOT NULL,
    server_check_interval integer DEFAULT 10 NOT NULL,
    hk_events_mode integer DEFAULT 1 NOT NULL,
    hk_events_trigger character varying(32) DEFAULT '365d'::character varying NOT NULL,
    hk_events_internal character varying(32) DEFAULT '1d'::character varying NOT NULL,
    hk_events_discovery character varying(32) DEFAULT '1d'::character varying NOT NULL,
    hk_events_autoreg character varying(32) DEFAULT '1d'::character varying NOT NULL,
    hk_services_mode integer DEFAULT 1 NOT NULL,
    hk_services character varying(32) DEFAULT '365d'::character varying NOT NULL,
    hk_audit_mode integer DEFAULT 1 NOT NULL,
    hk_audit character varying(32) DEFAULT '365d'::character varying NOT NULL,
    hk_sessions_mode integer DEFAULT 1 NOT NULL,
    hk_sessions character varying(32) DEFAULT '365d'::character varying NOT NULL,
    hk_history_mode integer DEFAULT 1 NOT NULL,
    hk_history_global integer DEFAULT 0 NOT NULL,
    hk_history character varying(32) DEFAULT '90d'::character varying NOT NULL,
    hk_trends_mode integer DEFAULT 1 NOT NULL,
    hk_trends_global integer DEFAULT 0 NOT NULL,
    hk_trends character varying(32) DEFAULT '365d'::character varying NOT NULL,
    default_inventory_mode integer DEFAULT '-1'::integer NOT NULL,
    custom_color integer DEFAULT 0 NOT NULL,
    http_auth_enabled integer DEFAULT 0 NOT NULL,
    http_login_form integer DEFAULT 0 NOT NULL,
    http_strip_domains character varying(2048) DEFAULT ''::character varying NOT NULL,
    http_case_sensitive integer DEFAULT 1 NOT NULL,
    ldap_configured integer DEFAULT 0 NOT NULL,
    ldap_case_sensitive integer DEFAULT 1 NOT NULL,
    db_extension character varying(32) DEFAULT ''::character varying NOT NULL,
    autoreg_tls_accept integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.config OWNER TO zabbix;

--
-- Name: config_autoreg_tls; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.config_autoreg_tls (
    autoreg_tlsid bigint NOT NULL,
    tls_psk_identity character varying(128) DEFAULT ''::character varying NOT NULL,
    tls_psk character varying(512) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.config_autoreg_tls OWNER TO zabbix;

--
-- Name: corr_condition; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.corr_condition (
    corr_conditionid bigint NOT NULL,
    correlationid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.corr_condition OWNER TO zabbix;

--
-- Name: corr_condition_group; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.corr_condition_group (
    corr_conditionid bigint NOT NULL,
    operator integer DEFAULT 0 NOT NULL,
    groupid bigint NOT NULL
);


ALTER TABLE public.corr_condition_group OWNER TO zabbix;

--
-- Name: corr_condition_tag; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.corr_condition_tag (
    corr_conditionid bigint NOT NULL,
    tag character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.corr_condition_tag OWNER TO zabbix;

--
-- Name: corr_condition_tagpair; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.corr_condition_tagpair (
    corr_conditionid bigint NOT NULL,
    oldtag character varying(255) DEFAULT ''::character varying NOT NULL,
    newtag character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.corr_condition_tagpair OWNER TO zabbix;

--
-- Name: corr_condition_tagvalue; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.corr_condition_tagvalue (
    corr_conditionid bigint NOT NULL,
    tag character varying(255) DEFAULT ''::character varying NOT NULL,
    operator integer DEFAULT 0 NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.corr_condition_tagvalue OWNER TO zabbix;

--
-- Name: corr_operation; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.corr_operation (
    corr_operationid bigint NOT NULL,
    correlationid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.corr_operation OWNER TO zabbix;

--
-- Name: correlation; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.correlation (
    correlationid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    evaltype integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    formula character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.correlation OWNER TO zabbix;

--
-- Name: dashboard; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.dashboard (
    dashboardid bigint NOT NULL,
    name character varying(255) NOT NULL,
    userid bigint NOT NULL,
    private integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.dashboard OWNER TO zabbix;

--
-- Name: dashboard_user; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.dashboard_user (
    dashboard_userid bigint NOT NULL,
    dashboardid bigint NOT NULL,
    userid bigint NOT NULL,
    permission integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.dashboard_user OWNER TO zabbix;

--
-- Name: dashboard_usrgrp; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.dashboard_usrgrp (
    dashboard_usrgrpid bigint NOT NULL,
    dashboardid bigint NOT NULL,
    usrgrpid bigint NOT NULL,
    permission integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.dashboard_usrgrp OWNER TO zabbix;

--
-- Name: dbversion; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.dbversion (
    mandatory integer DEFAULT 0 NOT NULL,
    optional integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.dbversion OWNER TO zabbix;

--
-- Name: dchecks; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.dchecks (
    dcheckid bigint NOT NULL,
    druleid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    key_ character varying(512) DEFAULT ''::character varying NOT NULL,
    snmp_community character varying(255) DEFAULT ''::character varying NOT NULL,
    ports character varying(255) DEFAULT '0'::character varying NOT NULL,
    snmpv3_securityname character varying(64) DEFAULT ''::character varying NOT NULL,
    snmpv3_securitylevel integer DEFAULT 0 NOT NULL,
    snmpv3_authpassphrase character varying(64) DEFAULT ''::character varying NOT NULL,
    snmpv3_privpassphrase character varying(64) DEFAULT ''::character varying NOT NULL,
    uniq integer DEFAULT 0 NOT NULL,
    snmpv3_authprotocol integer DEFAULT 0 NOT NULL,
    snmpv3_privprotocol integer DEFAULT 0 NOT NULL,
    snmpv3_contextname character varying(255) DEFAULT ''::character varying NOT NULL,
    host_source integer DEFAULT 1 NOT NULL,
    name_source integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.dchecks OWNER TO zabbix;

--
-- Name: dhosts; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.dhosts (
    dhostid bigint NOT NULL,
    druleid bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    lastup integer DEFAULT 0 NOT NULL,
    lastdown integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.dhosts OWNER TO zabbix;

--
-- Name: drules; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.drules (
    druleid bigint NOT NULL,
    proxy_hostid bigint,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    iprange character varying(2048) DEFAULT ''::character varying NOT NULL,
    delay character varying(255) DEFAULT '1h'::character varying NOT NULL,
    nextcheck integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.drules OWNER TO zabbix;

--
-- Name: dservices; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.dservices (
    dserviceid bigint NOT NULL,
    dhostid bigint NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    port integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    lastup integer DEFAULT 0 NOT NULL,
    lastdown integer DEFAULT 0 NOT NULL,
    dcheckid bigint NOT NULL,
    ip character varying(39) DEFAULT ''::character varying NOT NULL,
    dns character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.dservices OWNER TO zabbix;

--
-- Name: escalations; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.escalations (
    escalationid bigint NOT NULL,
    actionid bigint NOT NULL,
    triggerid bigint,
    eventid bigint,
    r_eventid bigint,
    nextcheck integer DEFAULT 0 NOT NULL,
    esc_step integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    itemid bigint,
    acknowledgeid bigint
);


ALTER TABLE public.escalations OWNER TO zabbix;

--
-- Name: event_recovery; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.event_recovery (
    eventid bigint NOT NULL,
    r_eventid bigint NOT NULL,
    c_eventid bigint,
    correlationid bigint,
    userid bigint
);


ALTER TABLE public.event_recovery OWNER TO zabbix;

--
-- Name: event_suppress; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.event_suppress (
    event_suppressid bigint NOT NULL,
    eventid bigint NOT NULL,
    maintenanceid bigint,
    suppress_until integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.event_suppress OWNER TO zabbix;

--
-- Name: event_tag; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.event_tag (
    eventtagid bigint NOT NULL,
    eventid bigint NOT NULL,
    tag character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.event_tag OWNER TO zabbix;

--
-- Name: events; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.events (
    eventid bigint NOT NULL,
    source integer DEFAULT 0 NOT NULL,
    object integer DEFAULT 0 NOT NULL,
    objectid bigint DEFAULT '0'::bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    value integer DEFAULT 0 NOT NULL,
    acknowledged integer DEFAULT 0 NOT NULL,
    ns integer DEFAULT 0 NOT NULL,
    name character varying(2048) DEFAULT ''::character varying NOT NULL,
    severity integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.events OWNER TO zabbix;

--
-- Name: expressions; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.expressions (
    expressionid bigint NOT NULL,
    regexpid bigint NOT NULL,
    expression character varying(255) DEFAULT ''::character varying NOT NULL,
    expression_type integer DEFAULT 0 NOT NULL,
    exp_delimiter character varying(1) DEFAULT ''::character varying NOT NULL,
    case_sensitive integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.expressions OWNER TO zabbix;

--
-- Name: functions; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.functions (
    functionid bigint NOT NULL,
    itemid bigint NOT NULL,
    triggerid bigint NOT NULL,
    name character varying(12) DEFAULT ''::character varying NOT NULL,
    parameter character varying(255) DEFAULT '0'::character varying NOT NULL
);


ALTER TABLE public.functions OWNER TO zabbix;

--
-- Name: globalmacro; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.globalmacro (
    globalmacroid bigint NOT NULL,
    macro character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.globalmacro OWNER TO zabbix;

--
-- Name: globalvars; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.globalvars (
    globalvarid bigint NOT NULL,
    snmp_lastsize numeric(20,0) DEFAULT '0'::numeric NOT NULL
);


ALTER TABLE public.globalvars OWNER TO zabbix;

--
-- Name: graph_discovery; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.graph_discovery (
    graphid bigint NOT NULL,
    parent_graphid bigint NOT NULL
);


ALTER TABLE public.graph_discovery OWNER TO zabbix;

--
-- Name: graph_theme; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.graph_theme (
    graphthemeid bigint NOT NULL,
    theme character varying(64) DEFAULT ''::character varying NOT NULL,
    backgroundcolor character varying(6) DEFAULT ''::character varying NOT NULL,
    graphcolor character varying(6) DEFAULT ''::character varying NOT NULL,
    gridcolor character varying(6) DEFAULT ''::character varying NOT NULL,
    maingridcolor character varying(6) DEFAULT ''::character varying NOT NULL,
    gridbordercolor character varying(6) DEFAULT ''::character varying NOT NULL,
    textcolor character varying(6) DEFAULT ''::character varying NOT NULL,
    highlightcolor character varying(6) DEFAULT ''::character varying NOT NULL,
    leftpercentilecolor character varying(6) DEFAULT ''::character varying NOT NULL,
    rightpercentilecolor character varying(6) DEFAULT ''::character varying NOT NULL,
    nonworktimecolor character varying(6) DEFAULT ''::character varying NOT NULL,
    colorpalette character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.graph_theme OWNER TO zabbix;

--
-- Name: graphs; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.graphs (
    graphid bigint NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    width integer DEFAULT 900 NOT NULL,
    height integer DEFAULT 200 NOT NULL,
    yaxismin numeric(16,4) DEFAULT '0'::numeric NOT NULL,
    yaxismax numeric(16,4) DEFAULT '100'::numeric NOT NULL,
    templateid bigint,
    show_work_period integer DEFAULT 1 NOT NULL,
    show_triggers integer DEFAULT 1 NOT NULL,
    graphtype integer DEFAULT 0 NOT NULL,
    show_legend integer DEFAULT 1 NOT NULL,
    show_3d integer DEFAULT 0 NOT NULL,
    percent_left numeric(16,4) DEFAULT '0'::numeric NOT NULL,
    percent_right numeric(16,4) DEFAULT '0'::numeric NOT NULL,
    ymin_type integer DEFAULT 0 NOT NULL,
    ymax_type integer DEFAULT 0 NOT NULL,
    ymin_itemid bigint,
    ymax_itemid bigint,
    flags integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.graphs OWNER TO zabbix;

--
-- Name: graphs_items; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.graphs_items (
    gitemid bigint NOT NULL,
    graphid bigint NOT NULL,
    itemid bigint NOT NULL,
    drawtype integer DEFAULT 0 NOT NULL,
    sortorder integer DEFAULT 0 NOT NULL,
    color character varying(6) DEFAULT '009600'::character varying NOT NULL,
    yaxisside integer DEFAULT 0 NOT NULL,
    calc_fnc integer DEFAULT 2 NOT NULL,
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.graphs_items OWNER TO zabbix;

--
-- Name: group_discovery; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.group_discovery (
    groupid bigint NOT NULL,
    parent_group_prototypeid bigint NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    lastcheck integer DEFAULT 0 NOT NULL,
    ts_delete integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.group_discovery OWNER TO zabbix;

--
-- Name: group_prototype; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.group_prototype (
    group_prototypeid bigint NOT NULL,
    hostid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    groupid bigint,
    templateid bigint
);


ALTER TABLE public.group_prototype OWNER TO zabbix;

--
-- Name: history; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.history (
    itemid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    value numeric(16,4) DEFAULT 0.0000 NOT NULL,
    ns integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.history OWNER TO zabbix;

--
-- Name: history_log; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.history_log (
    itemid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    source character varying(64) DEFAULT ''::character varying NOT NULL,
    severity integer DEFAULT 0 NOT NULL,
    value text DEFAULT ''::text NOT NULL,
    logeventid integer DEFAULT 0 NOT NULL,
    ns integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.history_log OWNER TO zabbix;

--
-- Name: history_str; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.history_str (
    itemid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    ns integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.history_str OWNER TO zabbix;

--
-- Name: history_text; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.history_text (
    itemid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    value text DEFAULT ''::text NOT NULL,
    ns integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.history_text OWNER TO zabbix;

--
-- Name: history_uint; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.history_uint (
    itemid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    value numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    ns integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.history_uint OWNER TO zabbix;

--
-- Name: host_discovery; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.host_discovery (
    hostid bigint NOT NULL,
    parent_hostid bigint,
    parent_itemid bigint,
    host character varying(128) DEFAULT ''::character varying NOT NULL,
    lastcheck integer DEFAULT 0 NOT NULL,
    ts_delete integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.host_discovery OWNER TO zabbix;

--
-- Name: host_inventory; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.host_inventory (
    hostid bigint NOT NULL,
    inventory_mode integer DEFAULT 0 NOT NULL,
    type character varying(64) DEFAULT ''::character varying NOT NULL,
    type_full character varying(64) DEFAULT ''::character varying NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    alias character varying(128) DEFAULT ''::character varying NOT NULL,
    os character varying(128) DEFAULT ''::character varying NOT NULL,
    os_full character varying(255) DEFAULT ''::character varying NOT NULL,
    os_short character varying(128) DEFAULT ''::character varying NOT NULL,
    serialno_a character varying(64) DEFAULT ''::character varying NOT NULL,
    serialno_b character varying(64) DEFAULT ''::character varying NOT NULL,
    tag character varying(64) DEFAULT ''::character varying NOT NULL,
    asset_tag character varying(64) DEFAULT ''::character varying NOT NULL,
    macaddress_a character varying(64) DEFAULT ''::character varying NOT NULL,
    macaddress_b character varying(64) DEFAULT ''::character varying NOT NULL,
    hardware character varying(255) DEFAULT ''::character varying NOT NULL,
    hardware_full text DEFAULT ''::text NOT NULL,
    software character varying(255) DEFAULT ''::character varying NOT NULL,
    software_full text DEFAULT ''::text NOT NULL,
    software_app_a character varying(64) DEFAULT ''::character varying NOT NULL,
    software_app_b character varying(64) DEFAULT ''::character varying NOT NULL,
    software_app_c character varying(64) DEFAULT ''::character varying NOT NULL,
    software_app_d character varying(64) DEFAULT ''::character varying NOT NULL,
    software_app_e character varying(64) DEFAULT ''::character varying NOT NULL,
    contact text DEFAULT ''::text NOT NULL,
    location text DEFAULT ''::text NOT NULL,
    location_lat character varying(16) DEFAULT ''::character varying NOT NULL,
    location_lon character varying(16) DEFAULT ''::character varying NOT NULL,
    notes text DEFAULT ''::text NOT NULL,
    chassis character varying(64) DEFAULT ''::character varying NOT NULL,
    model character varying(64) DEFAULT ''::character varying NOT NULL,
    hw_arch character varying(32) DEFAULT ''::character varying NOT NULL,
    vendor character varying(64) DEFAULT ''::character varying NOT NULL,
    contract_number character varying(64) DEFAULT ''::character varying NOT NULL,
    installer_name character varying(64) DEFAULT ''::character varying NOT NULL,
    deployment_status character varying(64) DEFAULT ''::character varying NOT NULL,
    url_a character varying(255) DEFAULT ''::character varying NOT NULL,
    url_b character varying(255) DEFAULT ''::character varying NOT NULL,
    url_c character varying(255) DEFAULT ''::character varying NOT NULL,
    host_networks text DEFAULT ''::text NOT NULL,
    host_netmask character varying(39) DEFAULT ''::character varying NOT NULL,
    host_router character varying(39) DEFAULT ''::character varying NOT NULL,
    oob_ip character varying(39) DEFAULT ''::character varying NOT NULL,
    oob_netmask character varying(39) DEFAULT ''::character varying NOT NULL,
    oob_router character varying(39) DEFAULT ''::character varying NOT NULL,
    date_hw_purchase character varying(64) DEFAULT ''::character varying NOT NULL,
    date_hw_install character varying(64) DEFAULT ''::character varying NOT NULL,
    date_hw_expiry character varying(64) DEFAULT ''::character varying NOT NULL,
    date_hw_decomm character varying(64) DEFAULT ''::character varying NOT NULL,
    site_address_a character varying(128) DEFAULT ''::character varying NOT NULL,
    site_address_b character varying(128) DEFAULT ''::character varying NOT NULL,
    site_address_c character varying(128) DEFAULT ''::character varying NOT NULL,
    site_city character varying(128) DEFAULT ''::character varying NOT NULL,
    site_state character varying(64) DEFAULT ''::character varying NOT NULL,
    site_country character varying(64) DEFAULT ''::character varying NOT NULL,
    site_zip character varying(64) DEFAULT ''::character varying NOT NULL,
    site_rack character varying(128) DEFAULT ''::character varying NOT NULL,
    site_notes text DEFAULT ''::text NOT NULL,
    poc_1_name character varying(128) DEFAULT ''::character varying NOT NULL,
    poc_1_email character varying(128) DEFAULT ''::character varying NOT NULL,
    poc_1_phone_a character varying(64) DEFAULT ''::character varying NOT NULL,
    poc_1_phone_b character varying(64) DEFAULT ''::character varying NOT NULL,
    poc_1_cell character varying(64) DEFAULT ''::character varying NOT NULL,
    poc_1_screen character varying(64) DEFAULT ''::character varying NOT NULL,
    poc_1_notes text DEFAULT ''::text NOT NULL,
    poc_2_name character varying(128) DEFAULT ''::character varying NOT NULL,
    poc_2_email character varying(128) DEFAULT ''::character varying NOT NULL,
    poc_2_phone_a character varying(64) DEFAULT ''::character varying NOT NULL,
    poc_2_phone_b character varying(64) DEFAULT ''::character varying NOT NULL,
    poc_2_cell character varying(64) DEFAULT ''::character varying NOT NULL,
    poc_2_screen character varying(64) DEFAULT ''::character varying NOT NULL,
    poc_2_notes text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.host_inventory OWNER TO zabbix;

--
-- Name: host_tag; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.host_tag (
    hosttagid bigint NOT NULL,
    hostid bigint NOT NULL,
    tag character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.host_tag OWNER TO zabbix;

--
-- Name: hostmacro; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.hostmacro (
    hostmacroid bigint NOT NULL,
    hostid bigint NOT NULL,
    macro character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.hostmacro OWNER TO zabbix;

--
-- Name: hosts; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.hosts (
    hostid bigint NOT NULL,
    proxy_hostid bigint,
    host character varying(128) DEFAULT ''::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    disable_until integer DEFAULT 0 NOT NULL,
    error character varying(2048) DEFAULT ''::character varying NOT NULL,
    available integer DEFAULT 0 NOT NULL,
    errors_from integer DEFAULT 0 NOT NULL,
    lastaccess integer DEFAULT 0 NOT NULL,
    ipmi_authtype integer DEFAULT '-1'::integer NOT NULL,
    ipmi_privilege integer DEFAULT 2 NOT NULL,
    ipmi_username character varying(16) DEFAULT ''::character varying NOT NULL,
    ipmi_password character varying(20) DEFAULT ''::character varying NOT NULL,
    ipmi_disable_until integer DEFAULT 0 NOT NULL,
    ipmi_available integer DEFAULT 0 NOT NULL,
    snmp_disable_until integer DEFAULT 0 NOT NULL,
    snmp_available integer DEFAULT 0 NOT NULL,
    maintenanceid bigint,
    maintenance_status integer DEFAULT 0 NOT NULL,
    maintenance_type integer DEFAULT 0 NOT NULL,
    maintenance_from integer DEFAULT 0 NOT NULL,
    ipmi_errors_from integer DEFAULT 0 NOT NULL,
    snmp_errors_from integer DEFAULT 0 NOT NULL,
    ipmi_error character varying(2048) DEFAULT ''::character varying NOT NULL,
    snmp_error character varying(2048) DEFAULT ''::character varying NOT NULL,
    jmx_disable_until integer DEFAULT 0 NOT NULL,
    jmx_available integer DEFAULT 0 NOT NULL,
    jmx_errors_from integer DEFAULT 0 NOT NULL,
    jmx_error character varying(2048) DEFAULT ''::character varying NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    templateid bigint,
    description text DEFAULT ''::text NOT NULL,
    tls_connect integer DEFAULT 1 NOT NULL,
    tls_accept integer DEFAULT 1 NOT NULL,
    tls_issuer character varying(1024) DEFAULT ''::character varying NOT NULL,
    tls_subject character varying(1024) DEFAULT ''::character varying NOT NULL,
    tls_psk_identity character varying(128) DEFAULT ''::character varying NOT NULL,
    tls_psk character varying(512) DEFAULT ''::character varying NOT NULL,
    proxy_address character varying(255) DEFAULT ''::character varying NOT NULL,
    auto_compress integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.hosts OWNER TO zabbix;

--
-- Name: hosts_groups; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.hosts_groups (
    hostgroupid bigint NOT NULL,
    hostid bigint NOT NULL,
    groupid bigint NOT NULL
);


ALTER TABLE public.hosts_groups OWNER TO zabbix;

--
-- Name: hosts_templates; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.hosts_templates (
    hosttemplateid bigint NOT NULL,
    hostid bigint NOT NULL,
    templateid bigint NOT NULL
);


ALTER TABLE public.hosts_templates OWNER TO zabbix;

--
-- Name: housekeeper; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.housekeeper (
    housekeeperid bigint NOT NULL,
    tablename character varying(64) DEFAULT ''::character varying NOT NULL,
    field character varying(64) DEFAULT ''::character varying NOT NULL,
    value bigint NOT NULL
);


ALTER TABLE public.housekeeper OWNER TO zabbix;

--
-- Name: hstgrp; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.hstgrp (
    groupid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    internal integer DEFAULT 0 NOT NULL,
    flags integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.hstgrp OWNER TO zabbix;

--
-- Name: httpstep; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.httpstep (
    httpstepid bigint NOT NULL,
    httptestid bigint NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    no integer DEFAULT 0 NOT NULL,
    url character varying(2048) DEFAULT ''::character varying NOT NULL,
    timeout character varying(255) DEFAULT '15s'::character varying NOT NULL,
    posts text DEFAULT ''::text NOT NULL,
    required character varying(255) DEFAULT ''::character varying NOT NULL,
    status_codes character varying(255) DEFAULT ''::character varying NOT NULL,
    follow_redirects integer DEFAULT 1 NOT NULL,
    retrieve_mode integer DEFAULT 0 NOT NULL,
    post_type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.httpstep OWNER TO zabbix;

--
-- Name: httpstep_field; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.httpstep_field (
    httpstep_fieldid bigint NOT NULL,
    httpstepid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    value text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.httpstep_field OWNER TO zabbix;

--
-- Name: httpstepitem; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.httpstepitem (
    httpstepitemid bigint NOT NULL,
    httpstepid bigint NOT NULL,
    itemid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.httpstepitem OWNER TO zabbix;

--
-- Name: httptest; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.httptest (
    httptestid bigint NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    applicationid bigint,
    nextcheck integer DEFAULT 0 NOT NULL,
    delay character varying(255) DEFAULT '1m'::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    agent character varying(255) DEFAULT 'Zabbix'::character varying NOT NULL,
    authentication integer DEFAULT 0 NOT NULL,
    http_user character varying(64) DEFAULT ''::character varying NOT NULL,
    http_password character varying(64) DEFAULT ''::character varying NOT NULL,
    hostid bigint NOT NULL,
    templateid bigint,
    http_proxy character varying(255) DEFAULT ''::character varying NOT NULL,
    retries integer DEFAULT 1 NOT NULL,
    ssl_cert_file character varying(255) DEFAULT ''::character varying NOT NULL,
    ssl_key_file character varying(255) DEFAULT ''::character varying NOT NULL,
    ssl_key_password character varying(64) DEFAULT ''::character varying NOT NULL,
    verify_peer integer DEFAULT 0 NOT NULL,
    verify_host integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.httptest OWNER TO zabbix;

--
-- Name: httptest_field; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.httptest_field (
    httptest_fieldid bigint NOT NULL,
    httptestid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    value text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.httptest_field OWNER TO zabbix;

--
-- Name: httptestitem; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.httptestitem (
    httptestitemid bigint NOT NULL,
    httptestid bigint NOT NULL,
    itemid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.httptestitem OWNER TO zabbix;

--
-- Name: icon_map; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.icon_map (
    iconmapid bigint NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    default_iconid bigint NOT NULL
);


ALTER TABLE public.icon_map OWNER TO zabbix;

--
-- Name: icon_mapping; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.icon_mapping (
    iconmappingid bigint NOT NULL,
    iconmapid bigint NOT NULL,
    iconid bigint NOT NULL,
    inventory_link integer DEFAULT 0 NOT NULL,
    expression character varying(64) DEFAULT ''::character varying NOT NULL,
    sortorder integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.icon_mapping OWNER TO zabbix;

--
-- Name: ids; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.ids (
    table_name character varying(64) DEFAULT ''::character varying NOT NULL,
    field_name character varying(64) DEFAULT ''::character varying NOT NULL,
    nextid bigint NOT NULL
);


ALTER TABLE public.ids OWNER TO zabbix;

--
-- Name: images; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.images (
    imageid bigint NOT NULL,
    imagetype integer DEFAULT 0 NOT NULL,
    name character varying(64) DEFAULT '0'::character varying NOT NULL,
    image bytea DEFAULT '\x'::bytea NOT NULL
);


ALTER TABLE public.images OWNER TO zabbix;

--
-- Name: interface; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.interface (
    interfaceid bigint NOT NULL,
    hostid bigint NOT NULL,
    main integer DEFAULT 0 NOT NULL,
    type integer DEFAULT 1 NOT NULL,
    useip integer DEFAULT 1 NOT NULL,
    ip character varying(64) DEFAULT '127.0.0.1'::character varying NOT NULL,
    dns character varying(255) DEFAULT ''::character varying NOT NULL,
    port character varying(64) DEFAULT '10050'::character varying NOT NULL,
    bulk integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.interface OWNER TO zabbix;

--
-- Name: interface_discovery; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.interface_discovery (
    interfaceid bigint NOT NULL,
    parent_interfaceid bigint NOT NULL
);


ALTER TABLE public.interface_discovery OWNER TO zabbix;

--
-- Name: item_application_prototype; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.item_application_prototype (
    item_application_prototypeid bigint NOT NULL,
    application_prototypeid bigint NOT NULL,
    itemid bigint NOT NULL
);


ALTER TABLE public.item_application_prototype OWNER TO zabbix;

--
-- Name: item_condition; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.item_condition (
    item_conditionid bigint NOT NULL,
    itemid bigint NOT NULL,
    operator integer DEFAULT 8 NOT NULL,
    macro character varying(64) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.item_condition OWNER TO zabbix;

--
-- Name: item_discovery; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.item_discovery (
    itemdiscoveryid bigint NOT NULL,
    itemid bigint NOT NULL,
    parent_itemid bigint NOT NULL,
    key_ character varying(255) DEFAULT ''::character varying NOT NULL,
    lastcheck integer DEFAULT 0 NOT NULL,
    ts_delete integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.item_discovery OWNER TO zabbix;

--
-- Name: item_preproc; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.item_preproc (
    item_preprocid bigint NOT NULL,
    itemid bigint NOT NULL,
    step integer DEFAULT 0 NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    params text DEFAULT ''::text NOT NULL,
    error_handler integer DEFAULT 0 NOT NULL,
    error_handler_params character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.item_preproc OWNER TO zabbix;

--
-- Name: item_rtdata; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.item_rtdata (
    itemid bigint NOT NULL,
    lastlogsize numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    state integer DEFAULT 0 NOT NULL,
    mtime integer DEFAULT 0 NOT NULL,
    error character varying(2048) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.item_rtdata OWNER TO zabbix;

--
-- Name: items; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.items (
    itemid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    snmp_community character varying(64) DEFAULT ''::character varying NOT NULL,
    snmp_oid character varying(512) DEFAULT ''::character varying NOT NULL,
    hostid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    key_ character varying(255) DEFAULT ''::character varying NOT NULL,
    delay character varying(1024) DEFAULT '0'::character varying NOT NULL,
    history character varying(255) DEFAULT '90d'::character varying NOT NULL,
    trends character varying(255) DEFAULT '365d'::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    value_type integer DEFAULT 0 NOT NULL,
    trapper_hosts character varying(255) DEFAULT ''::character varying NOT NULL,
    units character varying(255) DEFAULT ''::character varying NOT NULL,
    snmpv3_securityname character varying(64) DEFAULT ''::character varying NOT NULL,
    snmpv3_securitylevel integer DEFAULT 0 NOT NULL,
    snmpv3_authpassphrase character varying(64) DEFAULT ''::character varying NOT NULL,
    snmpv3_privpassphrase character varying(64) DEFAULT ''::character varying NOT NULL,
    formula character varying(255) DEFAULT ''::character varying NOT NULL,
    logtimefmt character varying(64) DEFAULT ''::character varying NOT NULL,
    templateid bigint,
    valuemapid bigint,
    params text DEFAULT ''::text NOT NULL,
    ipmi_sensor character varying(128) DEFAULT ''::character varying NOT NULL,
    authtype integer DEFAULT 0 NOT NULL,
    username character varying(64) DEFAULT ''::character varying NOT NULL,
    password character varying(64) DEFAULT ''::character varying NOT NULL,
    publickey character varying(64) DEFAULT ''::character varying NOT NULL,
    privatekey character varying(64) DEFAULT ''::character varying NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    interfaceid bigint,
    port character varying(64) DEFAULT ''::character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    inventory_link integer DEFAULT 0 NOT NULL,
    lifetime character varying(255) DEFAULT '30d'::character varying NOT NULL,
    snmpv3_authprotocol integer DEFAULT 0 NOT NULL,
    snmpv3_privprotocol integer DEFAULT 0 NOT NULL,
    snmpv3_contextname character varying(255) DEFAULT ''::character varying NOT NULL,
    evaltype integer DEFAULT 0 NOT NULL,
    jmx_endpoint character varying(255) DEFAULT ''::character varying NOT NULL,
    master_itemid bigint,
    timeout character varying(255) DEFAULT '3s'::character varying NOT NULL,
    url character varying(2048) DEFAULT ''::character varying NOT NULL,
    query_fields character varying(2048) DEFAULT ''::character varying NOT NULL,
    posts text DEFAULT ''::text NOT NULL,
    status_codes character varying(255) DEFAULT '200'::character varying NOT NULL,
    follow_redirects integer DEFAULT 1 NOT NULL,
    post_type integer DEFAULT 0 NOT NULL,
    http_proxy character varying(255) DEFAULT ''::character varying NOT NULL,
    headers text DEFAULT ''::text NOT NULL,
    retrieve_mode integer DEFAULT 0 NOT NULL,
    request_method integer DEFAULT 0 NOT NULL,
    output_format integer DEFAULT 0 NOT NULL,
    ssl_cert_file character varying(255) DEFAULT ''::character varying NOT NULL,
    ssl_key_file character varying(255) DEFAULT ''::character varying NOT NULL,
    ssl_key_password character varying(64) DEFAULT ''::character varying NOT NULL,
    verify_peer integer DEFAULT 0 NOT NULL,
    verify_host integer DEFAULT 0 NOT NULL,
    allow_traps integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.items OWNER TO zabbix;

--
-- Name: items_applications; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.items_applications (
    itemappid bigint NOT NULL,
    applicationid bigint NOT NULL,
    itemid bigint NOT NULL
);


ALTER TABLE public.items_applications OWNER TO zabbix;

--
-- Name: lld_macro_path; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.lld_macro_path (
    lld_macro_pathid bigint NOT NULL,
    itemid bigint NOT NULL,
    lld_macro character varying(255) DEFAULT ''::character varying NOT NULL,
    path character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.lld_macro_path OWNER TO zabbix;

--
-- Name: maintenance_tag; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.maintenance_tag (
    maintenancetagid bigint NOT NULL,
    maintenanceid bigint NOT NULL,
    tag character varying(255) DEFAULT ''::character varying NOT NULL,
    operator integer DEFAULT 2 NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.maintenance_tag OWNER TO zabbix;

--
-- Name: maintenances; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.maintenances (
    maintenanceid bigint NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    maintenance_type integer DEFAULT 0 NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    active_since integer DEFAULT 0 NOT NULL,
    active_till integer DEFAULT 0 NOT NULL,
    tags_evaltype integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.maintenances OWNER TO zabbix;

--
-- Name: maintenances_groups; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.maintenances_groups (
    maintenance_groupid bigint NOT NULL,
    maintenanceid bigint NOT NULL,
    groupid bigint NOT NULL
);


ALTER TABLE public.maintenances_groups OWNER TO zabbix;

--
-- Name: maintenances_hosts; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.maintenances_hosts (
    maintenance_hostid bigint NOT NULL,
    maintenanceid bigint NOT NULL,
    hostid bigint NOT NULL
);


ALTER TABLE public.maintenances_hosts OWNER TO zabbix;

--
-- Name: maintenances_windows; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.maintenances_windows (
    maintenance_timeperiodid bigint NOT NULL,
    maintenanceid bigint NOT NULL,
    timeperiodid bigint NOT NULL
);


ALTER TABLE public.maintenances_windows OWNER TO zabbix;

--
-- Name: mappings; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.mappings (
    mappingid bigint NOT NULL,
    valuemapid bigint NOT NULL,
    value character varying(64) DEFAULT ''::character varying NOT NULL,
    newvalue character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.mappings OWNER TO zabbix;

--
-- Name: media; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.media (
    mediaid bigint NOT NULL,
    userid bigint NOT NULL,
    mediatypeid bigint NOT NULL,
    sendto character varying(1024) DEFAULT ''::character varying NOT NULL,
    active integer DEFAULT 0 NOT NULL,
    severity integer DEFAULT 63 NOT NULL,
    period character varying(1024) DEFAULT '1-7,00:00-24:00'::character varying NOT NULL
);


ALTER TABLE public.media OWNER TO zabbix;

--
-- Name: media_type; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.media_type (
    mediatypeid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    name character varying(100) DEFAULT ''::character varying NOT NULL,
    smtp_server character varying(255) DEFAULT ''::character varying NOT NULL,
    smtp_helo character varying(255) DEFAULT ''::character varying NOT NULL,
    smtp_email character varying(255) DEFAULT ''::character varying NOT NULL,
    exec_path character varying(255) DEFAULT ''::character varying NOT NULL,
    gsm_modem character varying(255) DEFAULT ''::character varying NOT NULL,
    username character varying(255) DEFAULT ''::character varying NOT NULL,
    passwd character varying(255) DEFAULT ''::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    smtp_port integer DEFAULT 25 NOT NULL,
    smtp_security integer DEFAULT 0 NOT NULL,
    smtp_verify_peer integer DEFAULT 0 NOT NULL,
    smtp_verify_host integer DEFAULT 0 NOT NULL,
    smtp_authentication integer DEFAULT 0 NOT NULL,
    exec_params character varying(255) DEFAULT ''::character varying NOT NULL,
    maxsessions integer DEFAULT 1 NOT NULL,
    maxattempts integer DEFAULT 3 NOT NULL,
    attempt_interval character varying(32) DEFAULT '10s'::character varying NOT NULL,
    content_type integer DEFAULT 1 NOT NULL,
    script text DEFAULT ''::text NOT NULL,
    timeout character varying(32) DEFAULT '30s'::character varying NOT NULL,
    process_tags integer DEFAULT 0 NOT NULL,
    show_event_menu integer DEFAULT 0 NOT NULL,
    event_menu_url character varying(2048) DEFAULT ''::character varying NOT NULL,
    event_menu_name character varying(255) DEFAULT ''::character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.media_type OWNER TO zabbix;

--
-- Name: media_type_param; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.media_type_param (
    mediatype_paramid bigint NOT NULL,
    mediatypeid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(2048) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.media_type_param OWNER TO zabbix;

--
-- Name: opcommand; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opcommand (
    operationid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    scriptid bigint,
    execute_on integer DEFAULT 0 NOT NULL,
    port character varying(64) DEFAULT ''::character varying NOT NULL,
    authtype integer DEFAULT 0 NOT NULL,
    username character varying(64) DEFAULT ''::character varying NOT NULL,
    password character varying(64) DEFAULT ''::character varying NOT NULL,
    publickey character varying(64) DEFAULT ''::character varying NOT NULL,
    privatekey character varying(64) DEFAULT ''::character varying NOT NULL,
    command text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.opcommand OWNER TO zabbix;

--
-- Name: opcommand_grp; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opcommand_grp (
    opcommand_grpid bigint NOT NULL,
    operationid bigint NOT NULL,
    groupid bigint NOT NULL
);


ALTER TABLE public.opcommand_grp OWNER TO zabbix;

--
-- Name: opcommand_hst; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opcommand_hst (
    opcommand_hstid bigint NOT NULL,
    operationid bigint NOT NULL,
    hostid bigint
);


ALTER TABLE public.opcommand_hst OWNER TO zabbix;

--
-- Name: opconditions; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opconditions (
    opconditionid bigint NOT NULL,
    operationid bigint NOT NULL,
    conditiontype integer DEFAULT 0 NOT NULL,
    operator integer DEFAULT 0 NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.opconditions OWNER TO zabbix;

--
-- Name: operations; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.operations (
    operationid bigint NOT NULL,
    actionid bigint NOT NULL,
    operationtype integer DEFAULT 0 NOT NULL,
    esc_period character varying(255) DEFAULT '0'::character varying NOT NULL,
    esc_step_from integer DEFAULT 1 NOT NULL,
    esc_step_to integer DEFAULT 1 NOT NULL,
    evaltype integer DEFAULT 0 NOT NULL,
    recovery integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.operations OWNER TO zabbix;

--
-- Name: opgroup; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opgroup (
    opgroupid bigint NOT NULL,
    operationid bigint NOT NULL,
    groupid bigint NOT NULL
);


ALTER TABLE public.opgroup OWNER TO zabbix;

--
-- Name: opinventory; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opinventory (
    operationid bigint NOT NULL,
    inventory_mode integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.opinventory OWNER TO zabbix;

--
-- Name: opmessage; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opmessage (
    operationid bigint NOT NULL,
    default_msg integer DEFAULT 0 NOT NULL,
    subject character varying(255) DEFAULT ''::character varying NOT NULL,
    message text DEFAULT ''::text NOT NULL,
    mediatypeid bigint
);


ALTER TABLE public.opmessage OWNER TO zabbix;

--
-- Name: opmessage_grp; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opmessage_grp (
    opmessage_grpid bigint NOT NULL,
    operationid bigint NOT NULL,
    usrgrpid bigint NOT NULL
);


ALTER TABLE public.opmessage_grp OWNER TO zabbix;

--
-- Name: opmessage_usr; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.opmessage_usr (
    opmessage_usrid bigint NOT NULL,
    operationid bigint NOT NULL,
    userid bigint NOT NULL
);


ALTER TABLE public.opmessage_usr OWNER TO zabbix;

--
-- Name: optemplate; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.optemplate (
    optemplateid bigint NOT NULL,
    operationid bigint NOT NULL,
    templateid bigint NOT NULL
);


ALTER TABLE public.optemplate OWNER TO zabbix;

--
-- Name: problem; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.problem (
    eventid bigint NOT NULL,
    source integer DEFAULT 0 NOT NULL,
    object integer DEFAULT 0 NOT NULL,
    objectid bigint DEFAULT '0'::bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    ns integer DEFAULT 0 NOT NULL,
    r_eventid bigint,
    r_clock integer DEFAULT 0 NOT NULL,
    r_ns integer DEFAULT 0 NOT NULL,
    correlationid bigint,
    userid bigint,
    name character varying(2048) DEFAULT ''::character varying NOT NULL,
    acknowledged integer DEFAULT 0 NOT NULL,
    severity integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.problem OWNER TO zabbix;

--
-- Name: problem_tag; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.problem_tag (
    problemtagid bigint NOT NULL,
    eventid bigint NOT NULL,
    tag character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.problem_tag OWNER TO zabbix;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.profiles (
    profileid bigint NOT NULL,
    userid bigint NOT NULL,
    idx character varying(96) DEFAULT ''::character varying NOT NULL,
    idx2 bigint DEFAULT '0'::bigint NOT NULL,
    value_id bigint DEFAULT '0'::bigint NOT NULL,
    value_int integer DEFAULT 0 NOT NULL,
    value_str character varying(255) DEFAULT ''::character varying NOT NULL,
    source character varying(96) DEFAULT ''::character varying NOT NULL,
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.profiles OWNER TO zabbix;

--
-- Name: proxy_autoreg_host; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.proxy_autoreg_host (
    id bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    host character varying(128) DEFAULT ''::character varying NOT NULL,
    listen_ip character varying(39) DEFAULT ''::character varying NOT NULL,
    listen_port integer DEFAULT 0 NOT NULL,
    listen_dns character varying(255) DEFAULT ''::character varying NOT NULL,
    host_metadata character varying(255) DEFAULT ''::character varying NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    tls_accepted integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.proxy_autoreg_host OWNER TO zabbix;

--
-- Name: proxy_autoreg_host_id_seq; Type: SEQUENCE; Schema: public; Owner: zabbix
--

CREATE SEQUENCE public.proxy_autoreg_host_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proxy_autoreg_host_id_seq OWNER TO zabbix;

--
-- Name: proxy_autoreg_host_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zabbix
--

ALTER SEQUENCE public.proxy_autoreg_host_id_seq OWNED BY public.proxy_autoreg_host.id;


--
-- Name: proxy_dhistory; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.proxy_dhistory (
    id bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    druleid bigint NOT NULL,
    ip character varying(39) DEFAULT ''::character varying NOT NULL,
    port integer DEFAULT 0 NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    dcheckid bigint,
    dns character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.proxy_dhistory OWNER TO zabbix;

--
-- Name: proxy_dhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: zabbix
--

CREATE SEQUENCE public.proxy_dhistory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proxy_dhistory_id_seq OWNER TO zabbix;

--
-- Name: proxy_dhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zabbix
--

ALTER SEQUENCE public.proxy_dhistory_id_seq OWNED BY public.proxy_dhistory.id;


--
-- Name: proxy_history; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.proxy_history (
    id bigint NOT NULL,
    itemid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    "timestamp" integer DEFAULT 0 NOT NULL,
    source character varying(64) DEFAULT ''::character varying NOT NULL,
    severity integer DEFAULT 0 NOT NULL,
    value text DEFAULT ''::text NOT NULL,
    logeventid integer DEFAULT 0 NOT NULL,
    ns integer DEFAULT 0 NOT NULL,
    state integer DEFAULT 0 NOT NULL,
    lastlogsize numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    mtime integer DEFAULT 0 NOT NULL,
    flags integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.proxy_history OWNER TO zabbix;

--
-- Name: proxy_history_id_seq; Type: SEQUENCE; Schema: public; Owner: zabbix
--

CREATE SEQUENCE public.proxy_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proxy_history_id_seq OWNER TO zabbix;

--
-- Name: proxy_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: zabbix
--

ALTER SEQUENCE public.proxy_history_id_seq OWNED BY public.proxy_history.id;


--
-- Name: regexps; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.regexps (
    regexpid bigint NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    test_string text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.regexps OWNER TO zabbix;

--
-- Name: rights; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.rights (
    rightid bigint NOT NULL,
    groupid bigint NOT NULL,
    permission integer DEFAULT 0 NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.rights OWNER TO zabbix;

--
-- Name: screen_user; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.screen_user (
    screenuserid bigint NOT NULL,
    screenid bigint NOT NULL,
    userid bigint NOT NULL,
    permission integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.screen_user OWNER TO zabbix;

--
-- Name: screen_usrgrp; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.screen_usrgrp (
    screenusrgrpid bigint NOT NULL,
    screenid bigint NOT NULL,
    usrgrpid bigint NOT NULL,
    permission integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.screen_usrgrp OWNER TO zabbix;

--
-- Name: screens; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.screens (
    screenid bigint NOT NULL,
    name character varying(255) NOT NULL,
    hsize integer DEFAULT 1 NOT NULL,
    vsize integer DEFAULT 1 NOT NULL,
    templateid bigint,
    userid bigint,
    private integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.screens OWNER TO zabbix;

--
-- Name: screens_items; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.screens_items (
    screenitemid bigint NOT NULL,
    screenid bigint NOT NULL,
    resourcetype integer DEFAULT 0 NOT NULL,
    resourceid bigint DEFAULT '0'::bigint NOT NULL,
    width integer DEFAULT 320 NOT NULL,
    height integer DEFAULT 200 NOT NULL,
    x integer DEFAULT 0 NOT NULL,
    y integer DEFAULT 0 NOT NULL,
    colspan integer DEFAULT 1 NOT NULL,
    rowspan integer DEFAULT 1 NOT NULL,
    elements integer DEFAULT 25 NOT NULL,
    valign integer DEFAULT 0 NOT NULL,
    halign integer DEFAULT 0 NOT NULL,
    style integer DEFAULT 0 NOT NULL,
    url character varying(255) DEFAULT ''::character varying NOT NULL,
    dynamic integer DEFAULT 0 NOT NULL,
    sort_triggers integer DEFAULT 0 NOT NULL,
    application character varying(255) DEFAULT ''::character varying NOT NULL,
    max_columns integer DEFAULT 3 NOT NULL
);


ALTER TABLE public.screens_items OWNER TO zabbix;

--
-- Name: scripts; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.scripts (
    scriptid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    command character varying(255) DEFAULT ''::character varying NOT NULL,
    host_access integer DEFAULT 2 NOT NULL,
    usrgrpid bigint,
    groupid bigint,
    description text DEFAULT ''::text NOT NULL,
    confirmation character varying(255) DEFAULT ''::character varying NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    execute_on integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.scripts OWNER TO zabbix;

--
-- Name: service_alarms; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.service_alarms (
    servicealarmid bigint NOT NULL,
    serviceid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    value integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.service_alarms OWNER TO zabbix;

--
-- Name: services; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.services (
    serviceid bigint NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    algorithm integer DEFAULT 0 NOT NULL,
    triggerid bigint,
    showsla integer DEFAULT 0 NOT NULL,
    goodsla numeric(16,4) DEFAULT 99.9 NOT NULL,
    sortorder integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.services OWNER TO zabbix;

--
-- Name: services_links; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.services_links (
    linkid bigint NOT NULL,
    serviceupid bigint NOT NULL,
    servicedownid bigint NOT NULL,
    soft integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.services_links OWNER TO zabbix;

--
-- Name: services_times; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.services_times (
    timeid bigint NOT NULL,
    serviceid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    ts_from integer DEFAULT 0 NOT NULL,
    ts_to integer DEFAULT 0 NOT NULL,
    note character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.services_times OWNER TO zabbix;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sessions (
    sessionid character varying(32) DEFAULT ''::character varying NOT NULL,
    userid bigint NOT NULL,
    lastaccess integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.sessions OWNER TO zabbix;

--
-- Name: slides; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.slides (
    slideid bigint NOT NULL,
    slideshowid bigint NOT NULL,
    screenid bigint NOT NULL,
    step integer DEFAULT 0 NOT NULL,
    delay character varying(32) DEFAULT '0'::character varying NOT NULL
);


ALTER TABLE public.slides OWNER TO zabbix;

--
-- Name: slideshow_user; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.slideshow_user (
    slideshowuserid bigint NOT NULL,
    slideshowid bigint NOT NULL,
    userid bigint NOT NULL,
    permission integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.slideshow_user OWNER TO zabbix;

--
-- Name: slideshow_usrgrp; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.slideshow_usrgrp (
    slideshowusrgrpid bigint NOT NULL,
    slideshowid bigint NOT NULL,
    usrgrpid bigint NOT NULL,
    permission integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.slideshow_usrgrp OWNER TO zabbix;

--
-- Name: slideshows; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.slideshows (
    slideshowid bigint NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    delay character varying(32) DEFAULT '30s'::character varying NOT NULL,
    userid bigint NOT NULL,
    private integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.slideshows OWNER TO zabbix;

--
-- Name: sysmap_element_trigger; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmap_element_trigger (
    selement_triggerid bigint NOT NULL,
    selementid bigint NOT NULL,
    triggerid bigint NOT NULL
);


ALTER TABLE public.sysmap_element_trigger OWNER TO zabbix;

--
-- Name: sysmap_element_url; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmap_element_url (
    sysmapelementurlid bigint NOT NULL,
    selementid bigint NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.sysmap_element_url OWNER TO zabbix;

--
-- Name: sysmap_shape; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmap_shape (
    sysmap_shapeid bigint NOT NULL,
    sysmapid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    x integer DEFAULT 0 NOT NULL,
    y integer DEFAULT 0 NOT NULL,
    width integer DEFAULT 200 NOT NULL,
    height integer DEFAULT 200 NOT NULL,
    text text DEFAULT ''::text NOT NULL,
    font integer DEFAULT 9 NOT NULL,
    font_size integer DEFAULT 11 NOT NULL,
    font_color character varying(6) DEFAULT '000000'::character varying NOT NULL,
    text_halign integer DEFAULT 0 NOT NULL,
    text_valign integer DEFAULT 0 NOT NULL,
    border_type integer DEFAULT 0 NOT NULL,
    border_width integer DEFAULT 1 NOT NULL,
    border_color character varying(6) DEFAULT '000000'::character varying NOT NULL,
    background_color character varying(6) DEFAULT ''::character varying NOT NULL,
    zindex integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.sysmap_shape OWNER TO zabbix;

--
-- Name: sysmap_url; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmap_url (
    sysmapurlid bigint NOT NULL,
    sysmapid bigint NOT NULL,
    name character varying(255) NOT NULL,
    url character varying(255) DEFAULT ''::character varying NOT NULL,
    elementtype integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.sysmap_url OWNER TO zabbix;

--
-- Name: sysmap_user; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmap_user (
    sysmapuserid bigint NOT NULL,
    sysmapid bigint NOT NULL,
    userid bigint NOT NULL,
    permission integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.sysmap_user OWNER TO zabbix;

--
-- Name: sysmap_usrgrp; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmap_usrgrp (
    sysmapusrgrpid bigint NOT NULL,
    sysmapid bigint NOT NULL,
    usrgrpid bigint NOT NULL,
    permission integer DEFAULT 2 NOT NULL
);


ALTER TABLE public.sysmap_usrgrp OWNER TO zabbix;

--
-- Name: sysmaps; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmaps (
    sysmapid bigint NOT NULL,
    name character varying(128) DEFAULT ''::character varying NOT NULL,
    width integer DEFAULT 600 NOT NULL,
    height integer DEFAULT 400 NOT NULL,
    backgroundid bigint,
    label_type integer DEFAULT 2 NOT NULL,
    label_location integer DEFAULT 0 NOT NULL,
    highlight integer DEFAULT 1 NOT NULL,
    expandproblem integer DEFAULT 1 NOT NULL,
    markelements integer DEFAULT 0 NOT NULL,
    show_unack integer DEFAULT 0 NOT NULL,
    grid_size integer DEFAULT 50 NOT NULL,
    grid_show integer DEFAULT 1 NOT NULL,
    grid_align integer DEFAULT 1 NOT NULL,
    label_format integer DEFAULT 0 NOT NULL,
    label_type_host integer DEFAULT 2 NOT NULL,
    label_type_hostgroup integer DEFAULT 2 NOT NULL,
    label_type_trigger integer DEFAULT 2 NOT NULL,
    label_type_map integer DEFAULT 2 NOT NULL,
    label_type_image integer DEFAULT 2 NOT NULL,
    label_string_host character varying(255) DEFAULT ''::character varying NOT NULL,
    label_string_hostgroup character varying(255) DEFAULT ''::character varying NOT NULL,
    label_string_trigger character varying(255) DEFAULT ''::character varying NOT NULL,
    label_string_map character varying(255) DEFAULT ''::character varying NOT NULL,
    label_string_image character varying(255) DEFAULT ''::character varying NOT NULL,
    iconmapid bigint,
    expand_macros integer DEFAULT 0 NOT NULL,
    severity_min integer DEFAULT 0 NOT NULL,
    userid bigint NOT NULL,
    private integer DEFAULT 1 NOT NULL,
    show_suppressed integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.sysmaps OWNER TO zabbix;

--
-- Name: sysmaps_elements; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmaps_elements (
    selementid bigint NOT NULL,
    sysmapid bigint NOT NULL,
    elementid bigint DEFAULT '0'::bigint NOT NULL,
    elementtype integer DEFAULT 0 NOT NULL,
    iconid_off bigint,
    iconid_on bigint,
    label character varying(2048) DEFAULT ''::character varying NOT NULL,
    label_location integer DEFAULT '-1'::integer NOT NULL,
    x integer DEFAULT 0 NOT NULL,
    y integer DEFAULT 0 NOT NULL,
    iconid_disabled bigint,
    iconid_maintenance bigint,
    elementsubtype integer DEFAULT 0 NOT NULL,
    areatype integer DEFAULT 0 NOT NULL,
    width integer DEFAULT 200 NOT NULL,
    height integer DEFAULT 200 NOT NULL,
    viewtype integer DEFAULT 0 NOT NULL,
    use_iconmap integer DEFAULT 1 NOT NULL,
    application character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.sysmaps_elements OWNER TO zabbix;

--
-- Name: sysmaps_link_triggers; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmaps_link_triggers (
    linktriggerid bigint NOT NULL,
    linkid bigint NOT NULL,
    triggerid bigint NOT NULL,
    drawtype integer DEFAULT 0 NOT NULL,
    color character varying(6) DEFAULT '000000'::character varying NOT NULL
);


ALTER TABLE public.sysmaps_link_triggers OWNER TO zabbix;

--
-- Name: sysmaps_links; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.sysmaps_links (
    linkid bigint NOT NULL,
    sysmapid bigint NOT NULL,
    selementid1 bigint NOT NULL,
    selementid2 bigint NOT NULL,
    drawtype integer DEFAULT 0 NOT NULL,
    color character varying(6) DEFAULT '000000'::character varying NOT NULL,
    label character varying(2048) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.sysmaps_links OWNER TO zabbix;

--
-- Name: tag_filter; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.tag_filter (
    tag_filterid bigint NOT NULL,
    usrgrpid bigint NOT NULL,
    groupid bigint NOT NULL,
    tag character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tag_filter OWNER TO zabbix;

--
-- Name: task; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.task (
    taskid bigint NOT NULL,
    type integer NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    ttl integer DEFAULT 0 NOT NULL,
    proxy_hostid bigint
);


ALTER TABLE public.task OWNER TO zabbix;

--
-- Name: task_acknowledge; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.task_acknowledge (
    taskid bigint NOT NULL,
    acknowledgeid bigint NOT NULL
);


ALTER TABLE public.task_acknowledge OWNER TO zabbix;

--
-- Name: task_check_now; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.task_check_now (
    taskid bigint NOT NULL,
    itemid bigint NOT NULL
);


ALTER TABLE public.task_check_now OWNER TO zabbix;

--
-- Name: task_close_problem; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.task_close_problem (
    taskid bigint NOT NULL,
    acknowledgeid bigint NOT NULL
);


ALTER TABLE public.task_close_problem OWNER TO zabbix;

--
-- Name: task_remote_command; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.task_remote_command (
    taskid bigint NOT NULL,
    command_type integer DEFAULT 0 NOT NULL,
    execute_on integer DEFAULT 0 NOT NULL,
    port integer DEFAULT 0 NOT NULL,
    authtype integer DEFAULT 0 NOT NULL,
    username character varying(64) DEFAULT ''::character varying NOT NULL,
    password character varying(64) DEFAULT ''::character varying NOT NULL,
    publickey character varying(64) DEFAULT ''::character varying NOT NULL,
    privatekey character varying(64) DEFAULT ''::character varying NOT NULL,
    command text DEFAULT ''::text NOT NULL,
    alertid bigint,
    parent_taskid bigint NOT NULL,
    hostid bigint NOT NULL
);


ALTER TABLE public.task_remote_command OWNER TO zabbix;

--
-- Name: task_remote_command_result; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.task_remote_command_result (
    taskid bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    parent_taskid bigint NOT NULL,
    info text DEFAULT ''::text NOT NULL
);


ALTER TABLE public.task_remote_command_result OWNER TO zabbix;

--
-- Name: timeperiods; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.timeperiods (
    timeperiodid bigint NOT NULL,
    timeperiod_type integer DEFAULT 0 NOT NULL,
    every integer DEFAULT 1 NOT NULL,
    month integer DEFAULT 0 NOT NULL,
    dayofweek integer DEFAULT 0 NOT NULL,
    day integer DEFAULT 0 NOT NULL,
    start_time integer DEFAULT 0 NOT NULL,
    period integer DEFAULT 0 NOT NULL,
    start_date integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.timeperiods OWNER TO zabbix;

--
-- Name: trends; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.trends (
    itemid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    num integer DEFAULT 0 NOT NULL,
    value_min numeric(16,4) DEFAULT 0.0000 NOT NULL,
    value_avg numeric(16,4) DEFAULT 0.0000 NOT NULL,
    value_max numeric(16,4) DEFAULT 0.0000 NOT NULL
);


ALTER TABLE public.trends OWNER TO zabbix;

--
-- Name: trends_uint; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.trends_uint (
    itemid bigint NOT NULL,
    clock integer DEFAULT 0 NOT NULL,
    num integer DEFAULT 0 NOT NULL,
    value_min numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    value_avg numeric(20,0) DEFAULT '0'::numeric NOT NULL,
    value_max numeric(20,0) DEFAULT '0'::numeric NOT NULL
);


ALTER TABLE public.trends_uint OWNER TO zabbix;

--
-- Name: trigger_depends; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.trigger_depends (
    triggerdepid bigint NOT NULL,
    triggerid_down bigint NOT NULL,
    triggerid_up bigint NOT NULL
);


ALTER TABLE public.trigger_depends OWNER TO zabbix;

--
-- Name: trigger_discovery; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.trigger_discovery (
    triggerid bigint NOT NULL,
    parent_triggerid bigint NOT NULL
);


ALTER TABLE public.trigger_discovery OWNER TO zabbix;

--
-- Name: trigger_tag; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.trigger_tag (
    triggertagid bigint NOT NULL,
    triggerid bigint NOT NULL,
    tag character varying(255) DEFAULT ''::character varying NOT NULL,
    value character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.trigger_tag OWNER TO zabbix;

--
-- Name: triggers; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.triggers (
    triggerid bigint NOT NULL,
    expression character varying(2048) DEFAULT ''::character varying NOT NULL,
    description character varying(255) DEFAULT ''::character varying NOT NULL,
    url character varying(255) DEFAULT ''::character varying NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    value integer DEFAULT 0 NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    lastchange integer DEFAULT 0 NOT NULL,
    comments text DEFAULT ''::text NOT NULL,
    error character varying(2048) DEFAULT ''::character varying NOT NULL,
    templateid bigint,
    type integer DEFAULT 0 NOT NULL,
    state integer DEFAULT 0 NOT NULL,
    flags integer DEFAULT 0 NOT NULL,
    recovery_mode integer DEFAULT 0 NOT NULL,
    recovery_expression character varying(2048) DEFAULT ''::character varying NOT NULL,
    correlation_mode integer DEFAULT 0 NOT NULL,
    correlation_tag character varying(255) DEFAULT ''::character varying NOT NULL,
    manual_close integer DEFAULT 0 NOT NULL,
    opdata character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.triggers OWNER TO zabbix;

--
-- Name: users; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.users (
    userid bigint NOT NULL,
    alias character varying(100) DEFAULT ''::character varying NOT NULL,
    name character varying(100) DEFAULT ''::character varying NOT NULL,
    surname character varying(100) DEFAULT ''::character varying NOT NULL,
    passwd character varying(32) DEFAULT ''::character varying NOT NULL,
    url character varying(255) DEFAULT ''::character varying NOT NULL,
    autologin integer DEFAULT 0 NOT NULL,
    autologout character varying(32) DEFAULT '15m'::character varying NOT NULL,
    lang character varying(5) DEFAULT 'en_GB'::character varying NOT NULL,
    refresh character varying(32) DEFAULT '30s'::character varying NOT NULL,
    type integer DEFAULT 1 NOT NULL,
    theme character varying(128) DEFAULT 'default'::character varying NOT NULL,
    attempt_failed integer DEFAULT 0 NOT NULL,
    attempt_ip character varying(39) DEFAULT ''::character varying NOT NULL,
    attempt_clock integer DEFAULT 0 NOT NULL,
    rows_per_page integer DEFAULT 50 NOT NULL
);


ALTER TABLE public.users OWNER TO zabbix;

--
-- Name: users_groups; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.users_groups (
    id bigint NOT NULL,
    usrgrpid bigint NOT NULL,
    userid bigint NOT NULL
);


ALTER TABLE public.users_groups OWNER TO zabbix;

--
-- Name: usrgrp; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.usrgrp (
    usrgrpid bigint NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL,
    gui_access integer DEFAULT 0 NOT NULL,
    users_status integer DEFAULT 0 NOT NULL,
    debug_mode integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.usrgrp OWNER TO zabbix;

--
-- Name: valuemaps; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.valuemaps (
    valuemapid bigint NOT NULL,
    name character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.valuemaps OWNER TO zabbix;

--
-- Name: widget; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.widget (
    widgetid bigint NOT NULL,
    dashboardid bigint NOT NULL,
    type character varying(255) DEFAULT ''::character varying NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    x integer DEFAULT 0 NOT NULL,
    y integer DEFAULT 0 NOT NULL,
    width integer DEFAULT 1 NOT NULL,
    height integer DEFAULT 2 NOT NULL,
    view_mode integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.widget OWNER TO zabbix;

--
-- Name: widget_field; Type: TABLE; Schema: public; Owner: zabbix
--

CREATE TABLE public.widget_field (
    widget_fieldid bigint NOT NULL,
    widgetid bigint NOT NULL,
    type integer DEFAULT 0 NOT NULL,
    name character varying(255) DEFAULT ''::character varying NOT NULL,
    value_int integer DEFAULT 0 NOT NULL,
    value_str character varying(255) DEFAULT ''::character varying NOT NULL,
    value_groupid bigint,
    value_hostid bigint,
    value_itemid bigint,
    value_graphid bigint,
    value_sysmapid bigint
);


ALTER TABLE public.widget_field OWNER TO zabbix;

--
-- Name: proxy_autoreg_host id; Type: DEFAULT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.proxy_autoreg_host ALTER COLUMN id SET DEFAULT nextval('public.proxy_autoreg_host_id_seq'::regclass);


--
-- Name: proxy_dhistory id; Type: DEFAULT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.proxy_dhistory ALTER COLUMN id SET DEFAULT nextval('public.proxy_dhistory_id_seq'::regclass);


--
-- Name: proxy_history id; Type: DEFAULT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.proxy_history ALTER COLUMN id SET DEFAULT nextval('public.proxy_history_id_seq'::regclass);


--
-- Name: acknowledges acknowledges_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.acknowledges
    ADD CONSTRAINT acknowledges_pkey PRIMARY KEY (acknowledgeid);


--
-- Name: actions actions_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (actionid);


--
-- Name: alerts alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT alerts_pkey PRIMARY KEY (alertid);


--
-- Name: application_discovery application_discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_discovery
    ADD CONSTRAINT application_discovery_pkey PRIMARY KEY (application_discoveryid);


--
-- Name: application_prototype application_prototype_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_prototype
    ADD CONSTRAINT application_prototype_pkey PRIMARY KEY (application_prototypeid);


--
-- Name: application_template application_template_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_template
    ADD CONSTRAINT application_template_pkey PRIMARY KEY (application_templateid);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (applicationid);


--
-- Name: auditlog_details auditlog_details_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.auditlog_details
    ADD CONSTRAINT auditlog_details_pkey PRIMARY KEY (auditdetailid);


--
-- Name: auditlog auditlog_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.auditlog
    ADD CONSTRAINT auditlog_pkey PRIMARY KEY (auditid);


--
-- Name: autoreg_host autoreg_host_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.autoreg_host
    ADD CONSTRAINT autoreg_host_pkey PRIMARY KEY (autoreg_hostid);


--
-- Name: conditions conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.conditions
    ADD CONSTRAINT conditions_pkey PRIMARY KEY (conditionid);


--
-- Name: config_autoreg_tls config_autoreg_tls_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.config_autoreg_tls
    ADD CONSTRAINT config_autoreg_tls_pkey PRIMARY KEY (autoreg_tlsid);


--
-- Name: config config_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT config_pkey PRIMARY KEY (configid);


--
-- Name: corr_condition_group corr_condition_group_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_group
    ADD CONSTRAINT corr_condition_group_pkey PRIMARY KEY (corr_conditionid);


--
-- Name: corr_condition corr_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition
    ADD CONSTRAINT corr_condition_pkey PRIMARY KEY (corr_conditionid);


--
-- Name: corr_condition_tag corr_condition_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_tag
    ADD CONSTRAINT corr_condition_tag_pkey PRIMARY KEY (corr_conditionid);


--
-- Name: corr_condition_tagpair corr_condition_tagpair_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_tagpair
    ADD CONSTRAINT corr_condition_tagpair_pkey PRIMARY KEY (corr_conditionid);


--
-- Name: corr_condition_tagvalue corr_condition_tagvalue_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_tagvalue
    ADD CONSTRAINT corr_condition_tagvalue_pkey PRIMARY KEY (corr_conditionid);


--
-- Name: corr_operation corr_operation_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_operation
    ADD CONSTRAINT corr_operation_pkey PRIMARY KEY (corr_operationid);


--
-- Name: correlation correlation_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.correlation
    ADD CONSTRAINT correlation_pkey PRIMARY KEY (correlationid);


--
-- Name: dashboard dashboard_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT dashboard_pkey PRIMARY KEY (dashboardid);


--
-- Name: dashboard_user dashboard_user_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dashboard_user
    ADD CONSTRAINT dashboard_user_pkey PRIMARY KEY (dashboard_userid);


--
-- Name: dashboard_usrgrp dashboard_usrgrp_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dashboard_usrgrp
    ADD CONSTRAINT dashboard_usrgrp_pkey PRIMARY KEY (dashboard_usrgrpid);


--
-- Name: dchecks dchecks_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dchecks
    ADD CONSTRAINT dchecks_pkey PRIMARY KEY (dcheckid);


--
-- Name: dhosts dhosts_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dhosts
    ADD CONSTRAINT dhosts_pkey PRIMARY KEY (dhostid);


--
-- Name: drules drules_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.drules
    ADD CONSTRAINT drules_pkey PRIMARY KEY (druleid);


--
-- Name: dservices dservices_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dservices
    ADD CONSTRAINT dservices_pkey PRIMARY KEY (dserviceid);


--
-- Name: escalations escalations_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.escalations
    ADD CONSTRAINT escalations_pkey PRIMARY KEY (escalationid);


--
-- Name: event_recovery event_recovery_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_recovery
    ADD CONSTRAINT event_recovery_pkey PRIMARY KEY (eventid);


--
-- Name: event_suppress event_suppress_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_suppress
    ADD CONSTRAINT event_suppress_pkey PRIMARY KEY (event_suppressid);


--
-- Name: event_tag event_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_tag
    ADD CONSTRAINT event_tag_pkey PRIMARY KEY (eventtagid);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (eventid);


--
-- Name: expressions expressions_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.expressions
    ADD CONSTRAINT expressions_pkey PRIMARY KEY (expressionid);


--
-- Name: functions functions_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.functions
    ADD CONSTRAINT functions_pkey PRIMARY KEY (functionid);


--
-- Name: globalmacro globalmacro_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.globalmacro
    ADD CONSTRAINT globalmacro_pkey PRIMARY KEY (globalmacroid);


--
-- Name: globalvars globalvars_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.globalvars
    ADD CONSTRAINT globalvars_pkey PRIMARY KEY (globalvarid);


--
-- Name: graph_discovery graph_discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graph_discovery
    ADD CONSTRAINT graph_discovery_pkey PRIMARY KEY (graphid);


--
-- Name: graph_theme graph_theme_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graph_theme
    ADD CONSTRAINT graph_theme_pkey PRIMARY KEY (graphthemeid);


--
-- Name: graphs_items graphs_items_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graphs_items
    ADD CONSTRAINT graphs_items_pkey PRIMARY KEY (gitemid);


--
-- Name: graphs graphs_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graphs
    ADD CONSTRAINT graphs_pkey PRIMARY KEY (graphid);


--
-- Name: group_discovery group_discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.group_discovery
    ADD CONSTRAINT group_discovery_pkey PRIMARY KEY (groupid);


--
-- Name: group_prototype group_prototype_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.group_prototype
    ADD CONSTRAINT group_prototype_pkey PRIMARY KEY (group_prototypeid);


--
-- Name: host_discovery host_discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.host_discovery
    ADD CONSTRAINT host_discovery_pkey PRIMARY KEY (hostid);


--
-- Name: host_inventory host_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.host_inventory
    ADD CONSTRAINT host_inventory_pkey PRIMARY KEY (hostid);


--
-- Name: host_tag host_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.host_tag
    ADD CONSTRAINT host_tag_pkey PRIMARY KEY (hosttagid);


--
-- Name: hostmacro hostmacro_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hostmacro
    ADD CONSTRAINT hostmacro_pkey PRIMARY KEY (hostmacroid);


--
-- Name: hosts_groups hosts_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts_groups
    ADD CONSTRAINT hosts_groups_pkey PRIMARY KEY (hostgroupid);


--
-- Name: hosts hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT hosts_pkey PRIMARY KEY (hostid);


--
-- Name: hosts_templates hosts_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts_templates
    ADD CONSTRAINT hosts_templates_pkey PRIMARY KEY (hosttemplateid);


--
-- Name: housekeeper housekeeper_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.housekeeper
    ADD CONSTRAINT housekeeper_pkey PRIMARY KEY (housekeeperid);


--
-- Name: hstgrp hstgrp_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hstgrp
    ADD CONSTRAINT hstgrp_pkey PRIMARY KEY (groupid);


--
-- Name: httpstep_field httpstep_field_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httpstep_field
    ADD CONSTRAINT httpstep_field_pkey PRIMARY KEY (httpstep_fieldid);


--
-- Name: httpstep httpstep_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httpstep
    ADD CONSTRAINT httpstep_pkey PRIMARY KEY (httpstepid);


--
-- Name: httpstepitem httpstepitem_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httpstepitem
    ADD CONSTRAINT httpstepitem_pkey PRIMARY KEY (httpstepitemid);


--
-- Name: httptest_field httptest_field_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptest_field
    ADD CONSTRAINT httptest_field_pkey PRIMARY KEY (httptest_fieldid);


--
-- Name: httptest httptest_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptest
    ADD CONSTRAINT httptest_pkey PRIMARY KEY (httptestid);


--
-- Name: httptestitem httptestitem_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptestitem
    ADD CONSTRAINT httptestitem_pkey PRIMARY KEY (httptestitemid);


--
-- Name: icon_map icon_map_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.icon_map
    ADD CONSTRAINT icon_map_pkey PRIMARY KEY (iconmapid);


--
-- Name: icon_mapping icon_mapping_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.icon_mapping
    ADD CONSTRAINT icon_mapping_pkey PRIMARY KEY (iconmappingid);


--
-- Name: ids ids_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.ids
    ADD CONSTRAINT ids_pkey PRIMARY KEY (table_name, field_name);


--
-- Name: images images_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (imageid);


--
-- Name: interface_discovery interface_discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.interface_discovery
    ADD CONSTRAINT interface_discovery_pkey PRIMARY KEY (interfaceid);


--
-- Name: interface interface_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.interface
    ADD CONSTRAINT interface_pkey PRIMARY KEY (interfaceid);


--
-- Name: item_application_prototype item_application_prototype_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_application_prototype
    ADD CONSTRAINT item_application_prototype_pkey PRIMARY KEY (item_application_prototypeid);


--
-- Name: item_condition item_condition_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_condition
    ADD CONSTRAINT item_condition_pkey PRIMARY KEY (item_conditionid);


--
-- Name: item_discovery item_discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_discovery
    ADD CONSTRAINT item_discovery_pkey PRIMARY KEY (itemdiscoveryid);


--
-- Name: item_preproc item_preproc_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_preproc
    ADD CONSTRAINT item_preproc_pkey PRIMARY KEY (item_preprocid);


--
-- Name: item_rtdata item_rtdata_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_rtdata
    ADD CONSTRAINT item_rtdata_pkey PRIMARY KEY (itemid);


--
-- Name: items_applications items_applications_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items_applications
    ADD CONSTRAINT items_applications_pkey PRIMARY KEY (itemappid);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (itemid);


--
-- Name: lld_macro_path lld_macro_path_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.lld_macro_path
    ADD CONSTRAINT lld_macro_path_pkey PRIMARY KEY (lld_macro_pathid);


--
-- Name: maintenance_tag maintenance_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenance_tag
    ADD CONSTRAINT maintenance_tag_pkey PRIMARY KEY (maintenancetagid);


--
-- Name: maintenances_groups maintenances_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_groups
    ADD CONSTRAINT maintenances_groups_pkey PRIMARY KEY (maintenance_groupid);


--
-- Name: maintenances_hosts maintenances_hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_hosts
    ADD CONSTRAINT maintenances_hosts_pkey PRIMARY KEY (maintenance_hostid);


--
-- Name: maintenances maintenances_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances
    ADD CONSTRAINT maintenances_pkey PRIMARY KEY (maintenanceid);


--
-- Name: maintenances_windows maintenances_windows_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_windows
    ADD CONSTRAINT maintenances_windows_pkey PRIMARY KEY (maintenance_timeperiodid);


--
-- Name: mappings mappings_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.mappings
    ADD CONSTRAINT mappings_pkey PRIMARY KEY (mappingid);


--
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (mediaid);


--
-- Name: media_type_param media_type_param_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.media_type_param
    ADD CONSTRAINT media_type_param_pkey PRIMARY KEY (mediatype_paramid);


--
-- Name: media_type media_type_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.media_type
    ADD CONSTRAINT media_type_pkey PRIMARY KEY (mediatypeid);


--
-- Name: opcommand_grp opcommand_grp_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand_grp
    ADD CONSTRAINT opcommand_grp_pkey PRIMARY KEY (opcommand_grpid);


--
-- Name: opcommand_hst opcommand_hst_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand_hst
    ADD CONSTRAINT opcommand_hst_pkey PRIMARY KEY (opcommand_hstid);


--
-- Name: opcommand opcommand_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand
    ADD CONSTRAINT opcommand_pkey PRIMARY KEY (operationid);


--
-- Name: opconditions opconditions_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opconditions
    ADD CONSTRAINT opconditions_pkey PRIMARY KEY (opconditionid);


--
-- Name: operations operations_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.operations
    ADD CONSTRAINT operations_pkey PRIMARY KEY (operationid);


--
-- Name: opgroup opgroup_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opgroup
    ADD CONSTRAINT opgroup_pkey PRIMARY KEY (opgroupid);


--
-- Name: opinventory opinventory_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opinventory
    ADD CONSTRAINT opinventory_pkey PRIMARY KEY (operationid);


--
-- Name: opmessage_grp opmessage_grp_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage_grp
    ADD CONSTRAINT opmessage_grp_pkey PRIMARY KEY (opmessage_grpid);


--
-- Name: opmessage opmessage_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage
    ADD CONSTRAINT opmessage_pkey PRIMARY KEY (operationid);


--
-- Name: opmessage_usr opmessage_usr_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage_usr
    ADD CONSTRAINT opmessage_usr_pkey PRIMARY KEY (opmessage_usrid);


--
-- Name: optemplate optemplate_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.optemplate
    ADD CONSTRAINT optemplate_pkey PRIMARY KEY (optemplateid);


--
-- Name: problem problem_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT problem_pkey PRIMARY KEY (eventid);


--
-- Name: problem_tag problem_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.problem_tag
    ADD CONSTRAINT problem_tag_pkey PRIMARY KEY (problemtagid);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (profileid);


--
-- Name: proxy_autoreg_host proxy_autoreg_host_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.proxy_autoreg_host
    ADD CONSTRAINT proxy_autoreg_host_pkey PRIMARY KEY (id);


--
-- Name: proxy_dhistory proxy_dhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.proxy_dhistory
    ADD CONSTRAINT proxy_dhistory_pkey PRIMARY KEY (id);


--
-- Name: proxy_history proxy_history_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.proxy_history
    ADD CONSTRAINT proxy_history_pkey PRIMARY KEY (id);


--
-- Name: regexps regexps_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.regexps
    ADD CONSTRAINT regexps_pkey PRIMARY KEY (regexpid);


--
-- Name: rights rights_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.rights
    ADD CONSTRAINT rights_pkey PRIMARY KEY (rightid);


--
-- Name: screen_user screen_user_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screen_user
    ADD CONSTRAINT screen_user_pkey PRIMARY KEY (screenuserid);


--
-- Name: screen_usrgrp screen_usrgrp_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screen_usrgrp
    ADD CONSTRAINT screen_usrgrp_pkey PRIMARY KEY (screenusrgrpid);


--
-- Name: screens_items screens_items_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screens_items
    ADD CONSTRAINT screens_items_pkey PRIMARY KEY (screenitemid);


--
-- Name: screens screens_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screens
    ADD CONSTRAINT screens_pkey PRIMARY KEY (screenid);


--
-- Name: scripts scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.scripts
    ADD CONSTRAINT scripts_pkey PRIMARY KEY (scriptid);


--
-- Name: service_alarms service_alarms_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.service_alarms
    ADD CONSTRAINT service_alarms_pkey PRIMARY KEY (servicealarmid);


--
-- Name: services_links services_links_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.services_links
    ADD CONSTRAINT services_links_pkey PRIMARY KEY (linkid);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (serviceid);


--
-- Name: services_times services_times_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.services_times
    ADD CONSTRAINT services_times_pkey PRIMARY KEY (timeid);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sessionid);


--
-- Name: slides slides_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slides
    ADD CONSTRAINT slides_pkey PRIMARY KEY (slideid);


--
-- Name: slideshow_user slideshow_user_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slideshow_user
    ADD CONSTRAINT slideshow_user_pkey PRIMARY KEY (slideshowuserid);


--
-- Name: slideshow_usrgrp slideshow_usrgrp_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slideshow_usrgrp
    ADD CONSTRAINT slideshow_usrgrp_pkey PRIMARY KEY (slideshowusrgrpid);


--
-- Name: slideshows slideshows_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slideshows
    ADD CONSTRAINT slideshows_pkey PRIMARY KEY (slideshowid);


--
-- Name: sysmap_element_trigger sysmap_element_trigger_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_element_trigger
    ADD CONSTRAINT sysmap_element_trigger_pkey PRIMARY KEY (selement_triggerid);


--
-- Name: sysmap_element_url sysmap_element_url_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_element_url
    ADD CONSTRAINT sysmap_element_url_pkey PRIMARY KEY (sysmapelementurlid);


--
-- Name: sysmap_shape sysmap_shape_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_shape
    ADD CONSTRAINT sysmap_shape_pkey PRIMARY KEY (sysmap_shapeid);


--
-- Name: sysmap_url sysmap_url_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_url
    ADD CONSTRAINT sysmap_url_pkey PRIMARY KEY (sysmapurlid);


--
-- Name: sysmap_user sysmap_user_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_user
    ADD CONSTRAINT sysmap_user_pkey PRIMARY KEY (sysmapuserid);


--
-- Name: sysmap_usrgrp sysmap_usrgrp_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_usrgrp
    ADD CONSTRAINT sysmap_usrgrp_pkey PRIMARY KEY (sysmapusrgrpid);


--
-- Name: sysmaps_elements sysmaps_elements_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_elements
    ADD CONSTRAINT sysmaps_elements_pkey PRIMARY KEY (selementid);


--
-- Name: sysmaps_link_triggers sysmaps_link_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_link_triggers
    ADD CONSTRAINT sysmaps_link_triggers_pkey PRIMARY KEY (linktriggerid);


--
-- Name: sysmaps_links sysmaps_links_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_links
    ADD CONSTRAINT sysmaps_links_pkey PRIMARY KEY (linkid);


--
-- Name: sysmaps sysmaps_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps
    ADD CONSTRAINT sysmaps_pkey PRIMARY KEY (sysmapid);


--
-- Name: tag_filter tag_filter_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.tag_filter
    ADD CONSTRAINT tag_filter_pkey PRIMARY KEY (tag_filterid);


--
-- Name: task_acknowledge task_acknowledge_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_acknowledge
    ADD CONSTRAINT task_acknowledge_pkey PRIMARY KEY (taskid);


--
-- Name: task_check_now task_check_now_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_check_now
    ADD CONSTRAINT task_check_now_pkey PRIMARY KEY (taskid);


--
-- Name: task_close_problem task_close_problem_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_close_problem
    ADD CONSTRAINT task_close_problem_pkey PRIMARY KEY (taskid);


--
-- Name: task task_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT task_pkey PRIMARY KEY (taskid);


--
-- Name: task_remote_command task_remote_command_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_remote_command
    ADD CONSTRAINT task_remote_command_pkey PRIMARY KEY (taskid);


--
-- Name: task_remote_command_result task_remote_command_result_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_remote_command_result
    ADD CONSTRAINT task_remote_command_result_pkey PRIMARY KEY (taskid);


--
-- Name: timeperiods timeperiods_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.timeperiods
    ADD CONSTRAINT timeperiods_pkey PRIMARY KEY (timeperiodid);


--
-- Name: trends trends_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trends
    ADD CONSTRAINT trends_pkey PRIMARY KEY (itemid, clock);


--
-- Name: trends_uint trends_uint_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trends_uint
    ADD CONSTRAINT trends_uint_pkey PRIMARY KEY (itemid, clock);


--
-- Name: trigger_depends trigger_depends_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trigger_depends
    ADD CONSTRAINT trigger_depends_pkey PRIMARY KEY (triggerdepid);


--
-- Name: trigger_discovery trigger_discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trigger_discovery
    ADD CONSTRAINT trigger_discovery_pkey PRIMARY KEY (triggerid);


--
-- Name: trigger_tag trigger_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trigger_tag
    ADD CONSTRAINT trigger_tag_pkey PRIMARY KEY (triggertagid);


--
-- Name: triggers triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.triggers
    ADD CONSTRAINT triggers_pkey PRIMARY KEY (triggerid);


--
-- Name: users_groups users_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT users_groups_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: usrgrp usrgrp_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.usrgrp
    ADD CONSTRAINT usrgrp_pkey PRIMARY KEY (usrgrpid);


--
-- Name: valuemaps valuemaps_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.valuemaps
    ADD CONSTRAINT valuemaps_pkey PRIMARY KEY (valuemapid);


--
-- Name: widget_field widget_field_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget_field
    ADD CONSTRAINT widget_field_pkey PRIMARY KEY (widget_fieldid);


--
-- Name: widget widget_pkey; Type: CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget
    ADD CONSTRAINT widget_pkey PRIMARY KEY (widgetid);


--
-- Name: acknowledges_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX acknowledges_1 ON public.acknowledges USING btree (userid);


--
-- Name: acknowledges_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX acknowledges_2 ON public.acknowledges USING btree (eventid);


--
-- Name: acknowledges_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX acknowledges_3 ON public.acknowledges USING btree (clock);


--
-- Name: actions_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX actions_1 ON public.actions USING btree (eventsource, status);


--
-- Name: actions_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX actions_2 ON public.actions USING btree (name);


--
-- Name: alerts_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX alerts_1 ON public.alerts USING btree (actionid);


--
-- Name: alerts_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX alerts_2 ON public.alerts USING btree (clock);


--
-- Name: alerts_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX alerts_3 ON public.alerts USING btree (eventid);


--
-- Name: alerts_4; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX alerts_4 ON public.alerts USING btree (status);


--
-- Name: alerts_5; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX alerts_5 ON public.alerts USING btree (mediatypeid);


--
-- Name: alerts_6; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX alerts_6 ON public.alerts USING btree (userid);


--
-- Name: alerts_7; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX alerts_7 ON public.alerts USING btree (p_eventid);


--
-- Name: application_discovery_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX application_discovery_1 ON public.application_discovery USING btree (applicationid);


--
-- Name: application_discovery_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX application_discovery_2 ON public.application_discovery USING btree (application_prototypeid);


--
-- Name: application_prototype_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX application_prototype_1 ON public.application_prototype USING btree (itemid);


--
-- Name: application_prototype_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX application_prototype_2 ON public.application_prototype USING btree (templateid);


--
-- Name: application_template_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX application_template_1 ON public.application_template USING btree (applicationid, templateid);


--
-- Name: application_template_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX application_template_2 ON public.application_template USING btree (templateid);


--
-- Name: applications_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX applications_2 ON public.applications USING btree (hostid, name);


--
-- Name: auditlog_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX auditlog_1 ON public.auditlog USING btree (userid, clock);


--
-- Name: auditlog_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX auditlog_2 ON public.auditlog USING btree (clock);


--
-- Name: auditlog_details_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX auditlog_details_1 ON public.auditlog_details USING btree (auditid);


--
-- Name: autoreg_host_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX autoreg_host_1 ON public.autoreg_host USING btree (host);


--
-- Name: autoreg_host_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX autoreg_host_2 ON public.autoreg_host USING btree (proxy_hostid);


--
-- Name: conditions_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX conditions_1 ON public.conditions USING btree (actionid);


--
-- Name: config_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX config_1 ON public.config USING btree (alert_usrgrpid);


--
-- Name: config_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX config_2 ON public.config USING btree (discovery_groupid);


--
-- Name: config_autoreg_tls_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX config_autoreg_tls_1 ON public.config_autoreg_tls USING btree (tls_psk_identity);


--
-- Name: corr_condition_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX corr_condition_1 ON public.corr_condition USING btree (correlationid);


--
-- Name: corr_condition_group_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX corr_condition_group_1 ON public.corr_condition_group USING btree (groupid);


--
-- Name: corr_operation_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX corr_operation_1 ON public.corr_operation USING btree (correlationid);


--
-- Name: correlation_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX correlation_1 ON public.correlation USING btree (status);


--
-- Name: correlation_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX correlation_2 ON public.correlation USING btree (name);


--
-- Name: dashboard_user_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX dashboard_user_1 ON public.dashboard_user USING btree (dashboardid, userid);


--
-- Name: dashboard_usrgrp_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX dashboard_usrgrp_1 ON public.dashboard_usrgrp USING btree (dashboardid, usrgrpid);


--
-- Name: dchecks_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX dchecks_1 ON public.dchecks USING btree (druleid, host_source, name_source);


--
-- Name: dhosts_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX dhosts_1 ON public.dhosts USING btree (druleid);


--
-- Name: drules_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX drules_1 ON public.drules USING btree (proxy_hostid);


--
-- Name: drules_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX drules_2 ON public.drules USING btree (name);


--
-- Name: dservices_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX dservices_1 ON public.dservices USING btree (dcheckid, ip, port);


--
-- Name: dservices_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX dservices_2 ON public.dservices USING btree (dhostid);


--
-- Name: escalations_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX escalations_1 ON public.escalations USING btree (triggerid, itemid, escalationid);


--
-- Name: escalations_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX escalations_2 ON public.escalations USING btree (eventid);


--
-- Name: escalations_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX escalations_3 ON public.escalations USING btree (nextcheck);


--
-- Name: event_recovery_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX event_recovery_1 ON public.event_recovery USING btree (r_eventid);


--
-- Name: event_recovery_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX event_recovery_2 ON public.event_recovery USING btree (c_eventid);


--
-- Name: event_suppress_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX event_suppress_1 ON public.event_suppress USING btree (eventid, maintenanceid);


--
-- Name: event_suppress_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX event_suppress_2 ON public.event_suppress USING btree (suppress_until);


--
-- Name: event_suppress_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX event_suppress_3 ON public.event_suppress USING btree (maintenanceid);


--
-- Name: event_tag_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX event_tag_1 ON public.event_tag USING btree (eventid);


--
-- Name: events_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX events_1 ON public.events USING btree (source, object, objectid, clock);


--
-- Name: events_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX events_2 ON public.events USING btree (source, object, clock);


--
-- Name: expressions_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX expressions_1 ON public.expressions USING btree (regexpid);


--
-- Name: functions_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX functions_1 ON public.functions USING btree (triggerid);


--
-- Name: functions_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX functions_2 ON public.functions USING btree (itemid, name, parameter);


--
-- Name: globalmacro_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX globalmacro_1 ON public.globalmacro USING btree (macro);


--
-- Name: graph_discovery_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX graph_discovery_1 ON public.graph_discovery USING btree (parent_graphid);


--
-- Name: graph_theme_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX graph_theme_1 ON public.graph_theme USING btree (theme);


--
-- Name: graphs_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX graphs_1 ON public.graphs USING btree (name);


--
-- Name: graphs_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX graphs_2 ON public.graphs USING btree (templateid);


--
-- Name: graphs_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX graphs_3 ON public.graphs USING btree (ymin_itemid);


--
-- Name: graphs_4; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX graphs_4 ON public.graphs USING btree (ymax_itemid);


--
-- Name: graphs_items_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX graphs_items_1 ON public.graphs_items USING btree (itemid);


--
-- Name: graphs_items_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX graphs_items_2 ON public.graphs_items USING btree (graphid);


--
-- Name: group_prototype_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX group_prototype_1 ON public.group_prototype USING btree (hostid);


--
-- Name: history_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX history_1 ON public.history USING btree (itemid, clock);


--
-- Name: history_log_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX history_log_1 ON public.history_log USING btree (itemid, clock);


--
-- Name: history_str_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX history_str_1 ON public.history_str USING btree (itemid, clock);


--
-- Name: history_text_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX history_text_1 ON public.history_text USING btree (itemid, clock);


--
-- Name: history_uint_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX history_uint_1 ON public.history_uint USING btree (itemid, clock);


--
-- Name: host_tag_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX host_tag_1 ON public.host_tag USING btree (hostid);


--
-- Name: hostmacro_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX hostmacro_1 ON public.hostmacro USING btree (hostid, macro);


--
-- Name: hosts_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX hosts_1 ON public.hosts USING btree (host);


--
-- Name: hosts_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX hosts_2 ON public.hosts USING btree (status);


--
-- Name: hosts_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX hosts_3 ON public.hosts USING btree (proxy_hostid);


--
-- Name: hosts_4; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX hosts_4 ON public.hosts USING btree (name);


--
-- Name: hosts_5; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX hosts_5 ON public.hosts USING btree (maintenanceid);


--
-- Name: hosts_groups_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX hosts_groups_1 ON public.hosts_groups USING btree (hostid, groupid);


--
-- Name: hosts_groups_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX hosts_groups_2 ON public.hosts_groups USING btree (groupid);


--
-- Name: hosts_templates_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX hosts_templates_1 ON public.hosts_templates USING btree (hostid, templateid);


--
-- Name: hosts_templates_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX hosts_templates_2 ON public.hosts_templates USING btree (templateid);


--
-- Name: hstgrp_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX hstgrp_1 ON public.hstgrp USING btree (name);


--
-- Name: httpstep_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX httpstep_1 ON public.httpstep USING btree (httptestid);


--
-- Name: httpstep_field_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX httpstep_field_1 ON public.httpstep_field USING btree (httpstepid);


--
-- Name: httpstepitem_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX httpstepitem_1 ON public.httpstepitem USING btree (httpstepid, itemid);


--
-- Name: httpstepitem_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX httpstepitem_2 ON public.httpstepitem USING btree (itemid);


--
-- Name: httptest_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX httptest_1 ON public.httptest USING btree (applicationid);


--
-- Name: httptest_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX httptest_2 ON public.httptest USING btree (hostid, name);


--
-- Name: httptest_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX httptest_3 ON public.httptest USING btree (status);


--
-- Name: httptest_4; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX httptest_4 ON public.httptest USING btree (templateid);


--
-- Name: httptest_field_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX httptest_field_1 ON public.httptest_field USING btree (httptestid);


--
-- Name: httptestitem_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX httptestitem_1 ON public.httptestitem USING btree (httptestid, itemid);


--
-- Name: httptestitem_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX httptestitem_2 ON public.httptestitem USING btree (itemid);


--
-- Name: icon_map_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX icon_map_1 ON public.icon_map USING btree (name);


--
-- Name: icon_map_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX icon_map_2 ON public.icon_map USING btree (default_iconid);


--
-- Name: icon_mapping_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX icon_mapping_1 ON public.icon_mapping USING btree (iconmapid);


--
-- Name: icon_mapping_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX icon_mapping_2 ON public.icon_mapping USING btree (iconid);


--
-- Name: images_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX images_1 ON public.images USING btree (name);


--
-- Name: interface_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX interface_1 ON public.interface USING btree (hostid, type);


--
-- Name: interface_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX interface_2 ON public.interface USING btree (ip, dns);


--
-- Name: item_application_prototype_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX item_application_prototype_1 ON public.item_application_prototype USING btree (application_prototypeid, itemid);


--
-- Name: item_application_prototype_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX item_application_prototype_2 ON public.item_application_prototype USING btree (itemid);


--
-- Name: item_condition_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX item_condition_1 ON public.item_condition USING btree (itemid);


--
-- Name: item_discovery_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX item_discovery_1 ON public.item_discovery USING btree (itemid, parent_itemid);


--
-- Name: item_discovery_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX item_discovery_2 ON public.item_discovery USING btree (parent_itemid);


--
-- Name: item_preproc_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX item_preproc_1 ON public.item_preproc USING btree (itemid, step);


--
-- Name: items_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX items_1 ON public.items USING btree (hostid, key_);


--
-- Name: items_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX items_3 ON public.items USING btree (status);


--
-- Name: items_4; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX items_4 ON public.items USING btree (templateid);


--
-- Name: items_5; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX items_5 ON public.items USING btree (valuemapid);


--
-- Name: items_6; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX items_6 ON public.items USING btree (interfaceid);


--
-- Name: items_7; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX items_7 ON public.items USING btree (master_itemid);


--
-- Name: items_applications_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX items_applications_1 ON public.items_applications USING btree (applicationid, itemid);


--
-- Name: items_applications_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX items_applications_2 ON public.items_applications USING btree (itemid);


--
-- Name: lld_macro_path_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX lld_macro_path_1 ON public.lld_macro_path USING btree (itemid, lld_macro);


--
-- Name: maintenance_tag_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX maintenance_tag_1 ON public.maintenance_tag USING btree (maintenanceid);


--
-- Name: maintenances_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX maintenances_1 ON public.maintenances USING btree (active_since, active_till);


--
-- Name: maintenances_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX maintenances_2 ON public.maintenances USING btree (name);


--
-- Name: maintenances_groups_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX maintenances_groups_1 ON public.maintenances_groups USING btree (maintenanceid, groupid);


--
-- Name: maintenances_groups_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX maintenances_groups_2 ON public.maintenances_groups USING btree (groupid);


--
-- Name: maintenances_hosts_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX maintenances_hosts_1 ON public.maintenances_hosts USING btree (maintenanceid, hostid);


--
-- Name: maintenances_hosts_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX maintenances_hosts_2 ON public.maintenances_hosts USING btree (hostid);


--
-- Name: maintenances_windows_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX maintenances_windows_1 ON public.maintenances_windows USING btree (maintenanceid, timeperiodid);


--
-- Name: maintenances_windows_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX maintenances_windows_2 ON public.maintenances_windows USING btree (timeperiodid);


--
-- Name: mappings_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX mappings_1 ON public.mappings USING btree (valuemapid);


--
-- Name: media_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX media_1 ON public.media USING btree (userid);


--
-- Name: media_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX media_2 ON public.media USING btree (mediatypeid);


--
-- Name: media_type_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX media_type_1 ON public.media_type USING btree (name);


--
-- Name: media_type_param_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX media_type_param_1 ON public.media_type_param USING btree (mediatypeid);


--
-- Name: opcommand_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opcommand_1 ON public.opcommand USING btree (scriptid);


--
-- Name: opcommand_grp_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opcommand_grp_1 ON public.opcommand_grp USING btree (operationid);


--
-- Name: opcommand_grp_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opcommand_grp_2 ON public.opcommand_grp USING btree (groupid);


--
-- Name: opcommand_hst_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opcommand_hst_1 ON public.opcommand_hst USING btree (operationid);


--
-- Name: opcommand_hst_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opcommand_hst_2 ON public.opcommand_hst USING btree (hostid);


--
-- Name: opconditions_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opconditions_1 ON public.opconditions USING btree (operationid);


--
-- Name: operations_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX operations_1 ON public.operations USING btree (actionid);


--
-- Name: opgroup_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX opgroup_1 ON public.opgroup USING btree (operationid, groupid);


--
-- Name: opgroup_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opgroup_2 ON public.opgroup USING btree (groupid);


--
-- Name: opmessage_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opmessage_1 ON public.opmessage USING btree (mediatypeid);


--
-- Name: opmessage_grp_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX opmessage_grp_1 ON public.opmessage_grp USING btree (operationid, usrgrpid);


--
-- Name: opmessage_grp_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opmessage_grp_2 ON public.opmessage_grp USING btree (usrgrpid);


--
-- Name: opmessage_usr_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX opmessage_usr_1 ON public.opmessage_usr USING btree (operationid, userid);


--
-- Name: opmessage_usr_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX opmessage_usr_2 ON public.opmessage_usr USING btree (userid);


--
-- Name: optemplate_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX optemplate_1 ON public.optemplate USING btree (operationid, templateid);


--
-- Name: optemplate_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX optemplate_2 ON public.optemplate USING btree (templateid);


--
-- Name: problem_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX problem_1 ON public.problem USING btree (source, object, objectid);


--
-- Name: problem_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX problem_2 ON public.problem USING btree (r_clock);


--
-- Name: problem_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX problem_3 ON public.problem USING btree (r_eventid);


--
-- Name: problem_tag_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX problem_tag_1 ON public.problem_tag USING btree (eventid, tag, value);


--
-- Name: profiles_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX profiles_1 ON public.profiles USING btree (userid, idx, idx2);


--
-- Name: profiles_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX profiles_2 ON public.profiles USING btree (userid, profileid);


--
-- Name: proxy_autoreg_host_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX proxy_autoreg_host_1 ON public.proxy_autoreg_host USING btree (clock);


--
-- Name: proxy_dhistory_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX proxy_dhistory_1 ON public.proxy_dhistory USING btree (clock);


--
-- Name: proxy_dhistory_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX proxy_dhistory_2 ON public.proxy_dhistory USING btree (druleid);


--
-- Name: proxy_history_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX proxy_history_1 ON public.proxy_history USING btree (clock);


--
-- Name: regexps_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX regexps_1 ON public.regexps USING btree (name);


--
-- Name: rights_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX rights_1 ON public.rights USING btree (groupid);


--
-- Name: rights_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX rights_2 ON public.rights USING btree (id);


--
-- Name: screen_user_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX screen_user_1 ON public.screen_user USING btree (screenid, userid);


--
-- Name: screen_usrgrp_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX screen_usrgrp_1 ON public.screen_usrgrp USING btree (screenid, usrgrpid);


--
-- Name: screens_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX screens_1 ON public.screens USING btree (templateid);


--
-- Name: screens_items_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX screens_items_1 ON public.screens_items USING btree (screenid);


--
-- Name: scripts_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX scripts_1 ON public.scripts USING btree (usrgrpid);


--
-- Name: scripts_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX scripts_2 ON public.scripts USING btree (groupid);


--
-- Name: scripts_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX scripts_3 ON public.scripts USING btree (name);


--
-- Name: service_alarms_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX service_alarms_1 ON public.service_alarms USING btree (serviceid, clock);


--
-- Name: service_alarms_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX service_alarms_2 ON public.service_alarms USING btree (clock);


--
-- Name: services_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX services_1 ON public.services USING btree (triggerid);


--
-- Name: services_links_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX services_links_1 ON public.services_links USING btree (servicedownid);


--
-- Name: services_links_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX services_links_2 ON public.services_links USING btree (serviceupid, servicedownid);


--
-- Name: services_times_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX services_times_1 ON public.services_times USING btree (serviceid, type, ts_from, ts_to);


--
-- Name: sessions_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sessions_1 ON public.sessions USING btree (userid, status, lastaccess);


--
-- Name: slides_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX slides_1 ON public.slides USING btree (slideshowid);


--
-- Name: slides_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX slides_2 ON public.slides USING btree (screenid);


--
-- Name: slideshow_user_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX slideshow_user_1 ON public.slideshow_user USING btree (slideshowid, userid);


--
-- Name: slideshow_usrgrp_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX slideshow_usrgrp_1 ON public.slideshow_usrgrp USING btree (slideshowid, usrgrpid);


--
-- Name: slideshows_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX slideshows_1 ON public.slideshows USING btree (name);


--
-- Name: sysmap_element_trigger_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX sysmap_element_trigger_1 ON public.sysmap_element_trigger USING btree (selementid, triggerid);


--
-- Name: sysmap_element_url_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX sysmap_element_url_1 ON public.sysmap_element_url USING btree (selementid, name);


--
-- Name: sysmap_shape_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmap_shape_1 ON public.sysmap_shape USING btree (sysmapid);


--
-- Name: sysmap_url_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX sysmap_url_1 ON public.sysmap_url USING btree (sysmapid, name);


--
-- Name: sysmap_user_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX sysmap_user_1 ON public.sysmap_user USING btree (sysmapid, userid);


--
-- Name: sysmap_usrgrp_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX sysmap_usrgrp_1 ON public.sysmap_usrgrp USING btree (sysmapid, usrgrpid);


--
-- Name: sysmaps_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX sysmaps_1 ON public.sysmaps USING btree (name);


--
-- Name: sysmaps_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_2 ON public.sysmaps USING btree (backgroundid);


--
-- Name: sysmaps_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_3 ON public.sysmaps USING btree (iconmapid);


--
-- Name: sysmaps_elements_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_elements_1 ON public.sysmaps_elements USING btree (sysmapid);


--
-- Name: sysmaps_elements_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_elements_2 ON public.sysmaps_elements USING btree (iconid_off);


--
-- Name: sysmaps_elements_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_elements_3 ON public.sysmaps_elements USING btree (iconid_on);


--
-- Name: sysmaps_elements_4; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_elements_4 ON public.sysmaps_elements USING btree (iconid_disabled);


--
-- Name: sysmaps_elements_5; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_elements_5 ON public.sysmaps_elements USING btree (iconid_maintenance);


--
-- Name: sysmaps_link_triggers_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX sysmaps_link_triggers_1 ON public.sysmaps_link_triggers USING btree (linkid, triggerid);


--
-- Name: sysmaps_link_triggers_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_link_triggers_2 ON public.sysmaps_link_triggers USING btree (triggerid);


--
-- Name: sysmaps_links_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_links_1 ON public.sysmaps_links USING btree (sysmapid);


--
-- Name: sysmaps_links_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_links_2 ON public.sysmaps_links USING btree (selementid1);


--
-- Name: sysmaps_links_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX sysmaps_links_3 ON public.sysmaps_links USING btree (selementid2);


--
-- Name: task_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX task_1 ON public.task USING btree (status, proxy_hostid);


--
-- Name: trigger_depends_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX trigger_depends_1 ON public.trigger_depends USING btree (triggerid_down, triggerid_up);


--
-- Name: trigger_depends_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX trigger_depends_2 ON public.trigger_depends USING btree (triggerid_up);


--
-- Name: trigger_discovery_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX trigger_discovery_1 ON public.trigger_discovery USING btree (parent_triggerid);


--
-- Name: trigger_tag_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX trigger_tag_1 ON public.trigger_tag USING btree (triggerid);


--
-- Name: triggers_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX triggers_1 ON public.triggers USING btree (status);


--
-- Name: triggers_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX triggers_2 ON public.triggers USING btree (value, lastchange);


--
-- Name: triggers_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX triggers_3 ON public.triggers USING btree (templateid);


--
-- Name: users_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX users_1 ON public.users USING btree (alias);


--
-- Name: users_groups_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX users_groups_1 ON public.users_groups USING btree (usrgrpid, userid);


--
-- Name: users_groups_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX users_groups_2 ON public.users_groups USING btree (userid);


--
-- Name: usrgrp_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX usrgrp_1 ON public.usrgrp USING btree (name);


--
-- Name: valuemaps_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE UNIQUE INDEX valuemaps_1 ON public.valuemaps USING btree (name);


--
-- Name: widget_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX widget_1 ON public.widget USING btree (dashboardid);


--
-- Name: widget_field_1; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX widget_field_1 ON public.widget_field USING btree (widgetid);


--
-- Name: widget_field_2; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX widget_field_2 ON public.widget_field USING btree (value_groupid);


--
-- Name: widget_field_3; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX widget_field_3 ON public.widget_field USING btree (value_hostid);


--
-- Name: widget_field_4; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX widget_field_4 ON public.widget_field USING btree (value_itemid);


--
-- Name: widget_field_5; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX widget_field_5 ON public.widget_field USING btree (value_graphid);


--
-- Name: widget_field_6; Type: INDEX; Schema: public; Owner: zabbix
--

CREATE INDEX widget_field_6 ON public.widget_field USING btree (value_sysmapid);


--
-- Name: acknowledges c_acknowledges_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.acknowledges
    ADD CONSTRAINT c_acknowledges_1 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: acknowledges c_acknowledges_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.acknowledges
    ADD CONSTRAINT c_acknowledges_2 FOREIGN KEY (eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: alerts c_alerts_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT c_alerts_1 FOREIGN KEY (actionid) REFERENCES public.actions(actionid) ON DELETE CASCADE;


--
-- Name: alerts c_alerts_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT c_alerts_2 FOREIGN KEY (eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: alerts c_alerts_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT c_alerts_3 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: alerts c_alerts_4; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT c_alerts_4 FOREIGN KEY (mediatypeid) REFERENCES public.media_type(mediatypeid) ON DELETE CASCADE;


--
-- Name: alerts c_alerts_5; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT c_alerts_5 FOREIGN KEY (p_eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: alerts c_alerts_6; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.alerts
    ADD CONSTRAINT c_alerts_6 FOREIGN KEY (acknowledgeid) REFERENCES public.acknowledges(acknowledgeid) ON DELETE CASCADE;


--
-- Name: application_discovery c_application_discovery_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_discovery
    ADD CONSTRAINT c_application_discovery_1 FOREIGN KEY (applicationid) REFERENCES public.applications(applicationid) ON DELETE CASCADE;


--
-- Name: application_discovery c_application_discovery_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_discovery
    ADD CONSTRAINT c_application_discovery_2 FOREIGN KEY (application_prototypeid) REFERENCES public.application_prototype(application_prototypeid) ON DELETE CASCADE;


--
-- Name: application_prototype c_application_prototype_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_prototype
    ADD CONSTRAINT c_application_prototype_1 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: application_prototype c_application_prototype_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_prototype
    ADD CONSTRAINT c_application_prototype_2 FOREIGN KEY (templateid) REFERENCES public.application_prototype(application_prototypeid) ON DELETE CASCADE;


--
-- Name: application_template c_application_template_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_template
    ADD CONSTRAINT c_application_template_1 FOREIGN KEY (applicationid) REFERENCES public.applications(applicationid) ON DELETE CASCADE;


--
-- Name: application_template c_application_template_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.application_template
    ADD CONSTRAINT c_application_template_2 FOREIGN KEY (templateid) REFERENCES public.applications(applicationid) ON DELETE CASCADE;


--
-- Name: applications c_applications_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT c_applications_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: auditlog c_auditlog_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.auditlog
    ADD CONSTRAINT c_auditlog_1 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: auditlog_details c_auditlog_details_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.auditlog_details
    ADD CONSTRAINT c_auditlog_details_1 FOREIGN KEY (auditid) REFERENCES public.auditlog(auditid) ON DELETE CASCADE;


--
-- Name: autoreg_host c_autoreg_host_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.autoreg_host
    ADD CONSTRAINT c_autoreg_host_1 FOREIGN KEY (proxy_hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: conditions c_conditions_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.conditions
    ADD CONSTRAINT c_conditions_1 FOREIGN KEY (actionid) REFERENCES public.actions(actionid) ON DELETE CASCADE;


--
-- Name: config c_config_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT c_config_1 FOREIGN KEY (alert_usrgrpid) REFERENCES public.usrgrp(usrgrpid);


--
-- Name: config c_config_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.config
    ADD CONSTRAINT c_config_2 FOREIGN KEY (discovery_groupid) REFERENCES public.hstgrp(groupid);


--
-- Name: corr_condition c_corr_condition_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition
    ADD CONSTRAINT c_corr_condition_1 FOREIGN KEY (correlationid) REFERENCES public.correlation(correlationid) ON DELETE CASCADE;


--
-- Name: corr_condition_group c_corr_condition_group_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_group
    ADD CONSTRAINT c_corr_condition_group_1 FOREIGN KEY (corr_conditionid) REFERENCES public.corr_condition(corr_conditionid) ON DELETE CASCADE;


--
-- Name: corr_condition_group c_corr_condition_group_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_group
    ADD CONSTRAINT c_corr_condition_group_2 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid);


--
-- Name: corr_condition_tag c_corr_condition_tag_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_tag
    ADD CONSTRAINT c_corr_condition_tag_1 FOREIGN KEY (corr_conditionid) REFERENCES public.corr_condition(corr_conditionid) ON DELETE CASCADE;


--
-- Name: corr_condition_tagpair c_corr_condition_tagpair_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_tagpair
    ADD CONSTRAINT c_corr_condition_tagpair_1 FOREIGN KEY (corr_conditionid) REFERENCES public.corr_condition(corr_conditionid) ON DELETE CASCADE;


--
-- Name: corr_condition_tagvalue c_corr_condition_tagvalue_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_condition_tagvalue
    ADD CONSTRAINT c_corr_condition_tagvalue_1 FOREIGN KEY (corr_conditionid) REFERENCES public.corr_condition(corr_conditionid) ON DELETE CASCADE;


--
-- Name: corr_operation c_corr_operation_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.corr_operation
    ADD CONSTRAINT c_corr_operation_1 FOREIGN KEY (correlationid) REFERENCES public.correlation(correlationid) ON DELETE CASCADE;


--
-- Name: dashboard c_dashboard_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dashboard
    ADD CONSTRAINT c_dashboard_1 FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: dashboard_user c_dashboard_user_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dashboard_user
    ADD CONSTRAINT c_dashboard_user_1 FOREIGN KEY (dashboardid) REFERENCES public.dashboard(dashboardid) ON DELETE CASCADE;


--
-- Name: dashboard_user c_dashboard_user_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dashboard_user
    ADD CONSTRAINT c_dashboard_user_2 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: dashboard_usrgrp c_dashboard_usrgrp_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dashboard_usrgrp
    ADD CONSTRAINT c_dashboard_usrgrp_1 FOREIGN KEY (dashboardid) REFERENCES public.dashboard(dashboardid) ON DELETE CASCADE;


--
-- Name: dashboard_usrgrp c_dashboard_usrgrp_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dashboard_usrgrp
    ADD CONSTRAINT c_dashboard_usrgrp_2 FOREIGN KEY (usrgrpid) REFERENCES public.usrgrp(usrgrpid) ON DELETE CASCADE;


--
-- Name: dchecks c_dchecks_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dchecks
    ADD CONSTRAINT c_dchecks_1 FOREIGN KEY (druleid) REFERENCES public.drules(druleid) ON DELETE CASCADE;


--
-- Name: dhosts c_dhosts_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dhosts
    ADD CONSTRAINT c_dhosts_1 FOREIGN KEY (druleid) REFERENCES public.drules(druleid) ON DELETE CASCADE;


--
-- Name: drules c_drules_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.drules
    ADD CONSTRAINT c_drules_1 FOREIGN KEY (proxy_hostid) REFERENCES public.hosts(hostid);


--
-- Name: dservices c_dservices_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dservices
    ADD CONSTRAINT c_dservices_1 FOREIGN KEY (dhostid) REFERENCES public.dhosts(dhostid) ON DELETE CASCADE;


--
-- Name: dservices c_dservices_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.dservices
    ADD CONSTRAINT c_dservices_2 FOREIGN KEY (dcheckid) REFERENCES public.dchecks(dcheckid) ON DELETE CASCADE;


--
-- Name: event_recovery c_event_recovery_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_recovery
    ADD CONSTRAINT c_event_recovery_1 FOREIGN KEY (eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: event_recovery c_event_recovery_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_recovery
    ADD CONSTRAINT c_event_recovery_2 FOREIGN KEY (r_eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: event_recovery c_event_recovery_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_recovery
    ADD CONSTRAINT c_event_recovery_3 FOREIGN KEY (c_eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: event_suppress c_event_suppress_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_suppress
    ADD CONSTRAINT c_event_suppress_1 FOREIGN KEY (eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: event_suppress c_event_suppress_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_suppress
    ADD CONSTRAINT c_event_suppress_2 FOREIGN KEY (maintenanceid) REFERENCES public.maintenances(maintenanceid) ON DELETE CASCADE;


--
-- Name: event_tag c_event_tag_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.event_tag
    ADD CONSTRAINT c_event_tag_1 FOREIGN KEY (eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: expressions c_expressions_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.expressions
    ADD CONSTRAINT c_expressions_1 FOREIGN KEY (regexpid) REFERENCES public.regexps(regexpid) ON DELETE CASCADE;


--
-- Name: functions c_functions_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.functions
    ADD CONSTRAINT c_functions_1 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: functions c_functions_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.functions
    ADD CONSTRAINT c_functions_2 FOREIGN KEY (triggerid) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: graph_discovery c_graph_discovery_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graph_discovery
    ADD CONSTRAINT c_graph_discovery_1 FOREIGN KEY (graphid) REFERENCES public.graphs(graphid) ON DELETE CASCADE;


--
-- Name: graph_discovery c_graph_discovery_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graph_discovery
    ADD CONSTRAINT c_graph_discovery_2 FOREIGN KEY (parent_graphid) REFERENCES public.graphs(graphid);


--
-- Name: graphs c_graphs_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graphs
    ADD CONSTRAINT c_graphs_1 FOREIGN KEY (templateid) REFERENCES public.graphs(graphid) ON DELETE CASCADE;


--
-- Name: graphs c_graphs_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graphs
    ADD CONSTRAINT c_graphs_2 FOREIGN KEY (ymin_itemid) REFERENCES public.items(itemid);


--
-- Name: graphs c_graphs_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graphs
    ADD CONSTRAINT c_graphs_3 FOREIGN KEY (ymax_itemid) REFERENCES public.items(itemid);


--
-- Name: graphs_items c_graphs_items_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graphs_items
    ADD CONSTRAINT c_graphs_items_1 FOREIGN KEY (graphid) REFERENCES public.graphs(graphid) ON DELETE CASCADE;


--
-- Name: graphs_items c_graphs_items_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.graphs_items
    ADD CONSTRAINT c_graphs_items_2 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: group_discovery c_group_discovery_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.group_discovery
    ADD CONSTRAINT c_group_discovery_1 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid) ON DELETE CASCADE;


--
-- Name: group_discovery c_group_discovery_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.group_discovery
    ADD CONSTRAINT c_group_discovery_2 FOREIGN KEY (parent_group_prototypeid) REFERENCES public.group_prototype(group_prototypeid);


--
-- Name: group_prototype c_group_prototype_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.group_prototype
    ADD CONSTRAINT c_group_prototype_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: group_prototype c_group_prototype_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.group_prototype
    ADD CONSTRAINT c_group_prototype_2 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid);


--
-- Name: group_prototype c_group_prototype_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.group_prototype
    ADD CONSTRAINT c_group_prototype_3 FOREIGN KEY (templateid) REFERENCES public.group_prototype(group_prototypeid) ON DELETE CASCADE;


--
-- Name: host_discovery c_host_discovery_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.host_discovery
    ADD CONSTRAINT c_host_discovery_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: host_discovery c_host_discovery_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.host_discovery
    ADD CONSTRAINT c_host_discovery_2 FOREIGN KEY (parent_hostid) REFERENCES public.hosts(hostid);


--
-- Name: host_discovery c_host_discovery_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.host_discovery
    ADD CONSTRAINT c_host_discovery_3 FOREIGN KEY (parent_itemid) REFERENCES public.items(itemid);


--
-- Name: host_inventory c_host_inventory_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.host_inventory
    ADD CONSTRAINT c_host_inventory_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: host_tag c_host_tag_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.host_tag
    ADD CONSTRAINT c_host_tag_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: hostmacro c_hostmacro_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hostmacro
    ADD CONSTRAINT c_hostmacro_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: hosts c_hosts_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT c_hosts_1 FOREIGN KEY (proxy_hostid) REFERENCES public.hosts(hostid);


--
-- Name: hosts c_hosts_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT c_hosts_2 FOREIGN KEY (maintenanceid) REFERENCES public.maintenances(maintenanceid);


--
-- Name: hosts c_hosts_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT c_hosts_3 FOREIGN KEY (templateid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: hosts_groups c_hosts_groups_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts_groups
    ADD CONSTRAINT c_hosts_groups_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: hosts_groups c_hosts_groups_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts_groups
    ADD CONSTRAINT c_hosts_groups_2 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid) ON DELETE CASCADE;


--
-- Name: hosts_templates c_hosts_templates_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts_templates
    ADD CONSTRAINT c_hosts_templates_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: hosts_templates c_hosts_templates_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.hosts_templates
    ADD CONSTRAINT c_hosts_templates_2 FOREIGN KEY (templateid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: httpstep c_httpstep_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httpstep
    ADD CONSTRAINT c_httpstep_1 FOREIGN KEY (httptestid) REFERENCES public.httptest(httptestid) ON DELETE CASCADE;


--
-- Name: httpstep_field c_httpstep_field_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httpstep_field
    ADD CONSTRAINT c_httpstep_field_1 FOREIGN KEY (httpstepid) REFERENCES public.httpstep(httpstepid) ON DELETE CASCADE;


--
-- Name: httpstepitem c_httpstepitem_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httpstepitem
    ADD CONSTRAINT c_httpstepitem_1 FOREIGN KEY (httpstepid) REFERENCES public.httpstep(httpstepid) ON DELETE CASCADE;


--
-- Name: httpstepitem c_httpstepitem_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httpstepitem
    ADD CONSTRAINT c_httpstepitem_2 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: httptest c_httptest_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptest
    ADD CONSTRAINT c_httptest_1 FOREIGN KEY (applicationid) REFERENCES public.applications(applicationid);


--
-- Name: httptest c_httptest_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptest
    ADD CONSTRAINT c_httptest_2 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: httptest c_httptest_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptest
    ADD CONSTRAINT c_httptest_3 FOREIGN KEY (templateid) REFERENCES public.httptest(httptestid) ON DELETE CASCADE;


--
-- Name: httptest_field c_httptest_field_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptest_field
    ADD CONSTRAINT c_httptest_field_1 FOREIGN KEY (httptestid) REFERENCES public.httptest(httptestid) ON DELETE CASCADE;


--
-- Name: httptestitem c_httptestitem_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptestitem
    ADD CONSTRAINT c_httptestitem_1 FOREIGN KEY (httptestid) REFERENCES public.httptest(httptestid) ON DELETE CASCADE;


--
-- Name: httptestitem c_httptestitem_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.httptestitem
    ADD CONSTRAINT c_httptestitem_2 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: icon_map c_icon_map_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.icon_map
    ADD CONSTRAINT c_icon_map_1 FOREIGN KEY (default_iconid) REFERENCES public.images(imageid);


--
-- Name: icon_mapping c_icon_mapping_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.icon_mapping
    ADD CONSTRAINT c_icon_mapping_1 FOREIGN KEY (iconmapid) REFERENCES public.icon_map(iconmapid) ON DELETE CASCADE;


--
-- Name: icon_mapping c_icon_mapping_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.icon_mapping
    ADD CONSTRAINT c_icon_mapping_2 FOREIGN KEY (iconid) REFERENCES public.images(imageid);


--
-- Name: interface c_interface_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.interface
    ADD CONSTRAINT c_interface_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: interface_discovery c_interface_discovery_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.interface_discovery
    ADD CONSTRAINT c_interface_discovery_1 FOREIGN KEY (interfaceid) REFERENCES public.interface(interfaceid) ON DELETE CASCADE;


--
-- Name: interface_discovery c_interface_discovery_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.interface_discovery
    ADD CONSTRAINT c_interface_discovery_2 FOREIGN KEY (parent_interfaceid) REFERENCES public.interface(interfaceid) ON DELETE CASCADE;


--
-- Name: item_application_prototype c_item_application_prototype_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_application_prototype
    ADD CONSTRAINT c_item_application_prototype_1 FOREIGN KEY (application_prototypeid) REFERENCES public.application_prototype(application_prototypeid) ON DELETE CASCADE;


--
-- Name: item_application_prototype c_item_application_prototype_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_application_prototype
    ADD CONSTRAINT c_item_application_prototype_2 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: item_condition c_item_condition_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_condition
    ADD CONSTRAINT c_item_condition_1 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: item_discovery c_item_discovery_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_discovery
    ADD CONSTRAINT c_item_discovery_1 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: item_discovery c_item_discovery_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_discovery
    ADD CONSTRAINT c_item_discovery_2 FOREIGN KEY (parent_itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: item_preproc c_item_preproc_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_preproc
    ADD CONSTRAINT c_item_preproc_1 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: item_rtdata c_item_rtdata_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.item_rtdata
    ADD CONSTRAINT c_item_rtdata_1 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: items c_items_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT c_items_1 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: items c_items_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT c_items_2 FOREIGN KEY (templateid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: items c_items_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT c_items_3 FOREIGN KEY (valuemapid) REFERENCES public.valuemaps(valuemapid);


--
-- Name: items c_items_4; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT c_items_4 FOREIGN KEY (interfaceid) REFERENCES public.interface(interfaceid);


--
-- Name: items c_items_5; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT c_items_5 FOREIGN KEY (master_itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: items_applications c_items_applications_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items_applications
    ADD CONSTRAINT c_items_applications_1 FOREIGN KEY (applicationid) REFERENCES public.applications(applicationid) ON DELETE CASCADE;


--
-- Name: items_applications c_items_applications_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.items_applications
    ADD CONSTRAINT c_items_applications_2 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: lld_macro_path c_lld_macro_path_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.lld_macro_path
    ADD CONSTRAINT c_lld_macro_path_1 FOREIGN KEY (itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: maintenance_tag c_maintenance_tag_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenance_tag
    ADD CONSTRAINT c_maintenance_tag_1 FOREIGN KEY (maintenanceid) REFERENCES public.maintenances(maintenanceid) ON DELETE CASCADE;


--
-- Name: maintenances_groups c_maintenances_groups_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_groups
    ADD CONSTRAINT c_maintenances_groups_1 FOREIGN KEY (maintenanceid) REFERENCES public.maintenances(maintenanceid) ON DELETE CASCADE;


--
-- Name: maintenances_groups c_maintenances_groups_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_groups
    ADD CONSTRAINT c_maintenances_groups_2 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid) ON DELETE CASCADE;


--
-- Name: maintenances_hosts c_maintenances_hosts_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_hosts
    ADD CONSTRAINT c_maintenances_hosts_1 FOREIGN KEY (maintenanceid) REFERENCES public.maintenances(maintenanceid) ON DELETE CASCADE;


--
-- Name: maintenances_hosts c_maintenances_hosts_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_hosts
    ADD CONSTRAINT c_maintenances_hosts_2 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: maintenances_windows c_maintenances_windows_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_windows
    ADD CONSTRAINT c_maintenances_windows_1 FOREIGN KEY (maintenanceid) REFERENCES public.maintenances(maintenanceid) ON DELETE CASCADE;


--
-- Name: maintenances_windows c_maintenances_windows_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.maintenances_windows
    ADD CONSTRAINT c_maintenances_windows_2 FOREIGN KEY (timeperiodid) REFERENCES public.timeperiods(timeperiodid) ON DELETE CASCADE;


--
-- Name: mappings c_mappings_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.mappings
    ADD CONSTRAINT c_mappings_1 FOREIGN KEY (valuemapid) REFERENCES public.valuemaps(valuemapid) ON DELETE CASCADE;


--
-- Name: media c_media_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT c_media_1 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: media c_media_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT c_media_2 FOREIGN KEY (mediatypeid) REFERENCES public.media_type(mediatypeid) ON DELETE CASCADE;


--
-- Name: media_type_param c_media_type_param_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.media_type_param
    ADD CONSTRAINT c_media_type_param_1 FOREIGN KEY (mediatypeid) REFERENCES public.media_type(mediatypeid) ON DELETE CASCADE;


--
-- Name: opcommand c_opcommand_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand
    ADD CONSTRAINT c_opcommand_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: opcommand c_opcommand_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand
    ADD CONSTRAINT c_opcommand_2 FOREIGN KEY (scriptid) REFERENCES public.scripts(scriptid);


--
-- Name: opcommand_grp c_opcommand_grp_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand_grp
    ADD CONSTRAINT c_opcommand_grp_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: opcommand_grp c_opcommand_grp_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand_grp
    ADD CONSTRAINT c_opcommand_grp_2 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid);


--
-- Name: opcommand_hst c_opcommand_hst_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand_hst
    ADD CONSTRAINT c_opcommand_hst_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: opcommand_hst c_opcommand_hst_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opcommand_hst
    ADD CONSTRAINT c_opcommand_hst_2 FOREIGN KEY (hostid) REFERENCES public.hosts(hostid);


--
-- Name: opconditions c_opconditions_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opconditions
    ADD CONSTRAINT c_opconditions_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: operations c_operations_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.operations
    ADD CONSTRAINT c_operations_1 FOREIGN KEY (actionid) REFERENCES public.actions(actionid) ON DELETE CASCADE;


--
-- Name: opgroup c_opgroup_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opgroup
    ADD CONSTRAINT c_opgroup_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: opgroup c_opgroup_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opgroup
    ADD CONSTRAINT c_opgroup_2 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid);


--
-- Name: opinventory c_opinventory_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opinventory
    ADD CONSTRAINT c_opinventory_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: opmessage c_opmessage_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage
    ADD CONSTRAINT c_opmessage_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: opmessage c_opmessage_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage
    ADD CONSTRAINT c_opmessage_2 FOREIGN KEY (mediatypeid) REFERENCES public.media_type(mediatypeid);


--
-- Name: opmessage_grp c_opmessage_grp_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage_grp
    ADD CONSTRAINT c_opmessage_grp_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: opmessage_grp c_opmessage_grp_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage_grp
    ADD CONSTRAINT c_opmessage_grp_2 FOREIGN KEY (usrgrpid) REFERENCES public.usrgrp(usrgrpid);


--
-- Name: opmessage_usr c_opmessage_usr_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage_usr
    ADD CONSTRAINT c_opmessage_usr_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: opmessage_usr c_opmessage_usr_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.opmessage_usr
    ADD CONSTRAINT c_opmessage_usr_2 FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: optemplate c_optemplate_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.optemplate
    ADD CONSTRAINT c_optemplate_1 FOREIGN KEY (operationid) REFERENCES public.operations(operationid) ON DELETE CASCADE;


--
-- Name: optemplate c_optemplate_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.optemplate
    ADD CONSTRAINT c_optemplate_2 FOREIGN KEY (templateid) REFERENCES public.hosts(hostid);


--
-- Name: problem c_problem_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT c_problem_1 FOREIGN KEY (eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: problem c_problem_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.problem
    ADD CONSTRAINT c_problem_2 FOREIGN KEY (r_eventid) REFERENCES public.events(eventid) ON DELETE CASCADE;


--
-- Name: problem_tag c_problem_tag_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.problem_tag
    ADD CONSTRAINT c_problem_tag_1 FOREIGN KEY (eventid) REFERENCES public.problem(eventid) ON DELETE CASCADE;


--
-- Name: profiles c_profiles_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT c_profiles_1 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: rights c_rights_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.rights
    ADD CONSTRAINT c_rights_1 FOREIGN KEY (groupid) REFERENCES public.usrgrp(usrgrpid) ON DELETE CASCADE;


--
-- Name: rights c_rights_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.rights
    ADD CONSTRAINT c_rights_2 FOREIGN KEY (id) REFERENCES public.hstgrp(groupid) ON DELETE CASCADE;


--
-- Name: screen_user c_screen_user_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screen_user
    ADD CONSTRAINT c_screen_user_1 FOREIGN KEY (screenid) REFERENCES public.screens(screenid) ON DELETE CASCADE;


--
-- Name: screen_user c_screen_user_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screen_user
    ADD CONSTRAINT c_screen_user_2 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: screen_usrgrp c_screen_usrgrp_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screen_usrgrp
    ADD CONSTRAINT c_screen_usrgrp_1 FOREIGN KEY (screenid) REFERENCES public.screens(screenid) ON DELETE CASCADE;


--
-- Name: screen_usrgrp c_screen_usrgrp_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screen_usrgrp
    ADD CONSTRAINT c_screen_usrgrp_2 FOREIGN KEY (usrgrpid) REFERENCES public.usrgrp(usrgrpid) ON DELETE CASCADE;


--
-- Name: screens c_screens_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screens
    ADD CONSTRAINT c_screens_1 FOREIGN KEY (templateid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: screens c_screens_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screens
    ADD CONSTRAINT c_screens_3 FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: screens_items c_screens_items_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.screens_items
    ADD CONSTRAINT c_screens_items_1 FOREIGN KEY (screenid) REFERENCES public.screens(screenid) ON DELETE CASCADE;


--
-- Name: scripts c_scripts_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.scripts
    ADD CONSTRAINT c_scripts_1 FOREIGN KEY (usrgrpid) REFERENCES public.usrgrp(usrgrpid);


--
-- Name: scripts c_scripts_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.scripts
    ADD CONSTRAINT c_scripts_2 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid);


--
-- Name: service_alarms c_service_alarms_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.service_alarms
    ADD CONSTRAINT c_service_alarms_1 FOREIGN KEY (serviceid) REFERENCES public.services(serviceid) ON DELETE CASCADE;


--
-- Name: services c_services_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT c_services_1 FOREIGN KEY (triggerid) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: services_links c_services_links_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.services_links
    ADD CONSTRAINT c_services_links_1 FOREIGN KEY (serviceupid) REFERENCES public.services(serviceid) ON DELETE CASCADE;


--
-- Name: services_links c_services_links_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.services_links
    ADD CONSTRAINT c_services_links_2 FOREIGN KEY (servicedownid) REFERENCES public.services(serviceid) ON DELETE CASCADE;


--
-- Name: services_times c_services_times_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.services_times
    ADD CONSTRAINT c_services_times_1 FOREIGN KEY (serviceid) REFERENCES public.services(serviceid) ON DELETE CASCADE;


--
-- Name: sessions c_sessions_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT c_sessions_1 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: slides c_slides_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slides
    ADD CONSTRAINT c_slides_1 FOREIGN KEY (slideshowid) REFERENCES public.slideshows(slideshowid) ON DELETE CASCADE;


--
-- Name: slides c_slides_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slides
    ADD CONSTRAINT c_slides_2 FOREIGN KEY (screenid) REFERENCES public.screens(screenid) ON DELETE CASCADE;


--
-- Name: slideshow_user c_slideshow_user_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slideshow_user
    ADD CONSTRAINT c_slideshow_user_1 FOREIGN KEY (slideshowid) REFERENCES public.slideshows(slideshowid) ON DELETE CASCADE;


--
-- Name: slideshow_user c_slideshow_user_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slideshow_user
    ADD CONSTRAINT c_slideshow_user_2 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: slideshow_usrgrp c_slideshow_usrgrp_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slideshow_usrgrp
    ADD CONSTRAINT c_slideshow_usrgrp_1 FOREIGN KEY (slideshowid) REFERENCES public.slideshows(slideshowid) ON DELETE CASCADE;


--
-- Name: slideshow_usrgrp c_slideshow_usrgrp_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slideshow_usrgrp
    ADD CONSTRAINT c_slideshow_usrgrp_2 FOREIGN KEY (usrgrpid) REFERENCES public.usrgrp(usrgrpid) ON DELETE CASCADE;


--
-- Name: slideshows c_slideshows_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.slideshows
    ADD CONSTRAINT c_slideshows_3 FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: sysmap_element_trigger c_sysmap_element_trigger_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_element_trigger
    ADD CONSTRAINT c_sysmap_element_trigger_1 FOREIGN KEY (selementid) REFERENCES public.sysmaps_elements(selementid) ON DELETE CASCADE;


--
-- Name: sysmap_element_trigger c_sysmap_element_trigger_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_element_trigger
    ADD CONSTRAINT c_sysmap_element_trigger_2 FOREIGN KEY (triggerid) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: sysmap_element_url c_sysmap_element_url_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_element_url
    ADD CONSTRAINT c_sysmap_element_url_1 FOREIGN KEY (selementid) REFERENCES public.sysmaps_elements(selementid) ON DELETE CASCADE;


--
-- Name: sysmap_shape c_sysmap_shape_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_shape
    ADD CONSTRAINT c_sysmap_shape_1 FOREIGN KEY (sysmapid) REFERENCES public.sysmaps(sysmapid) ON DELETE CASCADE;


--
-- Name: sysmap_url c_sysmap_url_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_url
    ADD CONSTRAINT c_sysmap_url_1 FOREIGN KEY (sysmapid) REFERENCES public.sysmaps(sysmapid) ON DELETE CASCADE;


--
-- Name: sysmap_user c_sysmap_user_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_user
    ADD CONSTRAINT c_sysmap_user_1 FOREIGN KEY (sysmapid) REFERENCES public.sysmaps(sysmapid) ON DELETE CASCADE;


--
-- Name: sysmap_user c_sysmap_user_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_user
    ADD CONSTRAINT c_sysmap_user_2 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: sysmap_usrgrp c_sysmap_usrgrp_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_usrgrp
    ADD CONSTRAINT c_sysmap_usrgrp_1 FOREIGN KEY (sysmapid) REFERENCES public.sysmaps(sysmapid) ON DELETE CASCADE;


--
-- Name: sysmap_usrgrp c_sysmap_usrgrp_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmap_usrgrp
    ADD CONSTRAINT c_sysmap_usrgrp_2 FOREIGN KEY (usrgrpid) REFERENCES public.usrgrp(usrgrpid) ON DELETE CASCADE;


--
-- Name: sysmaps c_sysmaps_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps
    ADD CONSTRAINT c_sysmaps_1 FOREIGN KEY (backgroundid) REFERENCES public.images(imageid);


--
-- Name: sysmaps c_sysmaps_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps
    ADD CONSTRAINT c_sysmaps_2 FOREIGN KEY (iconmapid) REFERENCES public.icon_map(iconmapid);


--
-- Name: sysmaps c_sysmaps_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps
    ADD CONSTRAINT c_sysmaps_3 FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- Name: sysmaps_elements c_sysmaps_elements_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_elements
    ADD CONSTRAINT c_sysmaps_elements_1 FOREIGN KEY (sysmapid) REFERENCES public.sysmaps(sysmapid) ON DELETE CASCADE;


--
-- Name: sysmaps_elements c_sysmaps_elements_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_elements
    ADD CONSTRAINT c_sysmaps_elements_2 FOREIGN KEY (iconid_off) REFERENCES public.images(imageid);


--
-- Name: sysmaps_elements c_sysmaps_elements_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_elements
    ADD CONSTRAINT c_sysmaps_elements_3 FOREIGN KEY (iconid_on) REFERENCES public.images(imageid);


--
-- Name: sysmaps_elements c_sysmaps_elements_4; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_elements
    ADD CONSTRAINT c_sysmaps_elements_4 FOREIGN KEY (iconid_disabled) REFERENCES public.images(imageid);


--
-- Name: sysmaps_elements c_sysmaps_elements_5; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_elements
    ADD CONSTRAINT c_sysmaps_elements_5 FOREIGN KEY (iconid_maintenance) REFERENCES public.images(imageid);


--
-- Name: sysmaps_link_triggers c_sysmaps_link_triggers_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_link_triggers
    ADD CONSTRAINT c_sysmaps_link_triggers_1 FOREIGN KEY (linkid) REFERENCES public.sysmaps_links(linkid) ON DELETE CASCADE;


--
-- Name: sysmaps_link_triggers c_sysmaps_link_triggers_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_link_triggers
    ADD CONSTRAINT c_sysmaps_link_triggers_2 FOREIGN KEY (triggerid) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: sysmaps_links c_sysmaps_links_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_links
    ADD CONSTRAINT c_sysmaps_links_1 FOREIGN KEY (sysmapid) REFERENCES public.sysmaps(sysmapid) ON DELETE CASCADE;


--
-- Name: sysmaps_links c_sysmaps_links_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_links
    ADD CONSTRAINT c_sysmaps_links_2 FOREIGN KEY (selementid1) REFERENCES public.sysmaps_elements(selementid) ON DELETE CASCADE;


--
-- Name: sysmaps_links c_sysmaps_links_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.sysmaps_links
    ADD CONSTRAINT c_sysmaps_links_3 FOREIGN KEY (selementid2) REFERENCES public.sysmaps_elements(selementid) ON DELETE CASCADE;


--
-- Name: tag_filter c_tag_filter_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.tag_filter
    ADD CONSTRAINT c_tag_filter_1 FOREIGN KEY (usrgrpid) REFERENCES public.usrgrp(usrgrpid) ON DELETE CASCADE;


--
-- Name: tag_filter c_tag_filter_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.tag_filter
    ADD CONSTRAINT c_tag_filter_2 FOREIGN KEY (groupid) REFERENCES public.hstgrp(groupid) ON DELETE CASCADE;


--
-- Name: task c_task_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task
    ADD CONSTRAINT c_task_1 FOREIGN KEY (proxy_hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: task_acknowledge c_task_acknowledge_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_acknowledge
    ADD CONSTRAINT c_task_acknowledge_1 FOREIGN KEY (taskid) REFERENCES public.task(taskid) ON DELETE CASCADE;


--
-- Name: task_check_now c_task_check_now_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_check_now
    ADD CONSTRAINT c_task_check_now_1 FOREIGN KEY (taskid) REFERENCES public.task(taskid) ON DELETE CASCADE;


--
-- Name: task_close_problem c_task_close_problem_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_close_problem
    ADD CONSTRAINT c_task_close_problem_1 FOREIGN KEY (taskid) REFERENCES public.task(taskid) ON DELETE CASCADE;


--
-- Name: task_remote_command c_task_remote_command_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_remote_command
    ADD CONSTRAINT c_task_remote_command_1 FOREIGN KEY (taskid) REFERENCES public.task(taskid) ON DELETE CASCADE;


--
-- Name: task_remote_command_result c_task_remote_command_result_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.task_remote_command_result
    ADD CONSTRAINT c_task_remote_command_result_1 FOREIGN KEY (taskid) REFERENCES public.task(taskid) ON DELETE CASCADE;


--
-- Name: trigger_depends c_trigger_depends_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trigger_depends
    ADD CONSTRAINT c_trigger_depends_1 FOREIGN KEY (triggerid_down) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: trigger_depends c_trigger_depends_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trigger_depends
    ADD CONSTRAINT c_trigger_depends_2 FOREIGN KEY (triggerid_up) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: trigger_discovery c_trigger_discovery_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trigger_discovery
    ADD CONSTRAINT c_trigger_discovery_1 FOREIGN KEY (triggerid) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: trigger_discovery c_trigger_discovery_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trigger_discovery
    ADD CONSTRAINT c_trigger_discovery_2 FOREIGN KEY (parent_triggerid) REFERENCES public.triggers(triggerid);


--
-- Name: trigger_tag c_trigger_tag_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.trigger_tag
    ADD CONSTRAINT c_trigger_tag_1 FOREIGN KEY (triggerid) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: triggers c_triggers_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.triggers
    ADD CONSTRAINT c_triggers_1 FOREIGN KEY (templateid) REFERENCES public.triggers(triggerid) ON DELETE CASCADE;


--
-- Name: users_groups c_users_groups_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT c_users_groups_1 FOREIGN KEY (usrgrpid) REFERENCES public.usrgrp(usrgrpid) ON DELETE CASCADE;


--
-- Name: users_groups c_users_groups_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.users_groups
    ADD CONSTRAINT c_users_groups_2 FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: widget c_widget_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget
    ADD CONSTRAINT c_widget_1 FOREIGN KEY (dashboardid) REFERENCES public.dashboard(dashboardid) ON DELETE CASCADE;


--
-- Name: widget_field c_widget_field_1; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget_field
    ADD CONSTRAINT c_widget_field_1 FOREIGN KEY (widgetid) REFERENCES public.widget(widgetid) ON DELETE CASCADE;


--
-- Name: widget_field c_widget_field_2; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget_field
    ADD CONSTRAINT c_widget_field_2 FOREIGN KEY (value_groupid) REFERENCES public.hstgrp(groupid) ON DELETE CASCADE;


--
-- Name: widget_field c_widget_field_3; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget_field
    ADD CONSTRAINT c_widget_field_3 FOREIGN KEY (value_hostid) REFERENCES public.hosts(hostid) ON DELETE CASCADE;


--
-- Name: widget_field c_widget_field_4; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget_field
    ADD CONSTRAINT c_widget_field_4 FOREIGN KEY (value_itemid) REFERENCES public.items(itemid) ON DELETE CASCADE;


--
-- Name: widget_field c_widget_field_5; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget_field
    ADD CONSTRAINT c_widget_field_5 FOREIGN KEY (value_graphid) REFERENCES public.graphs(graphid) ON DELETE CASCADE;


--
-- Name: widget_field c_widget_field_6; Type: FK CONSTRAINT; Schema: public; Owner: zabbix
--

ALTER TABLE ONLY public.widget_field
    ADD CONSTRAINT c_widget_field_6 FOREIGN KEY (value_sysmapid) REFERENCES public.sysmaps(sysmapid) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
