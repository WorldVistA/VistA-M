SYNDHP58 ; HC/art - HealthConcourse - get care team data ;07/24/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 ;The authoratative source for VHA care team data is PCMM Web. (currently no connection is available.)
 ; PCMM Web updates VistA files on a regular basis.
 ;
 QUIT
 ;
GETTEAMS(RETSTA,FRDAT,TODAT,RETJSON) ;get all care teams
 ;input: FRDAT   - from date (inclusive), optional, compared to Current Activation Date
 ;       TODAT   - to date (inclusive), optional, compared to Current Activation Date
 ;       RETJSON - J = Return JSON
 ;                 F = Return FHIR
 ;                 0 or null = Return TEAMS string (default)
 ;returns: RETSTA - delimited string or JSON or FHIR string
 ;                  field delimiter |
 ;                  team delimiter ^
 ;                  resourceId | teamName | teamPurpose | institution | serviceDept | currentStatus | fhirTeamType | currentActivationDate | currentInactivationDate | current#Patients | resourceType ^ ...
 ;                or care team data in JSON format
 ;
 S FRDAT=$S($G(FRDAT):$$HL7TFM^XLFDT(FRDAT),1:1000101)
 S TODAT=$S($G(TODAT):$$HL7TFM^XLFDT(TODAT),1:9991231)
 I $G(DEBUG) W !,"FRDAT: ",FRDAT,"   TODAT: ",TODAT,!
 I FRDAT>TODAT S RETSTA="-1^From date is greater than to date" QUIT
 ;
 S RETSTA=""
 N P S P="|"
 N TEAMS
 N TEAMIEN S TEAMIEN=0
 F  S TEAMIEN=$O(^SCTM(404.51,TEAMIEN)) QUIT:+TEAMIEN=0  D
 . I $G(DEBUG) W !,"-------------------------------------------------------------",!
 . N TEAM,TEAMJ
 . D GET1TEAM^SYNDHP18(.TEAM,TEAMIEN,0)
 . I $D(TEAM("Team","ERROR")) M TEAMS("Teams",TEAMIEN)=TEAM QUIT
 . QUIT:'$$RANGECK^SYNDHPUTL(TEAM("Team","currentActivationDateCFM"),FRDAT,TODAT)  ;quit if outside of requested date range
 . M TEAMS("Teams",TEAMIEN)=TEAM
 . I $G(RETJSON)'="J",$G(RETJSON)'="F" D
 . . S RETSTA=RETSTA_TEAM("Team","resourceId")_P_TEAM("Team","teamName")_P_TEAM("Team","teamPurpose")_P_TEAM("Team","institution")_P_TEAM("Team","serviceDept")_P
 . . S RETSTA=RETSTA_TEAM("Team","currentStatusC")_P_"longitudinal"_P_TEAM("Team","currentActivationDateCHL7")_P_TEAM("Team","currentInactivationDateCHL7")_P
 . . S RETSTA=RETSTA_TEAM("Team","current#PatientsC")_P_TEAM("Team","resourceType")_U
 . . I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TEAM")
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TEAMS")
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.TEAMS,.RETSTA)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("RETSTA")
 ;
 QUIT
 ;
GETTEAM(RETSTA,TEAMID,RETJSON) ;get one care team
 ;input: TEAMID - Team Name or IEN
 ;       RETJSON - J = Return JSON
 ;                 F = Return FHIR
 ;                 0 or null = Return TEAMS string (default)
 ;returns: RETSTA - delimited string or JSON or FHIR string
 ;                  resourceId | teamName | teamPurpose | institution | serviceDept | currentStatus | fhirTeamType | currentActivationDate | currentInactivationDate | current#Patients | resourceType
 ;                or care team data in JSON format
 ;         -1^What team?
 ;         -1^Team not found
 ;
 I $G(TEAMID)="" S RETSTA="-1^What team?" QUIT
 N TEAMIEN,ERR
 S TEAMIEN=$$FIND1^DIC(404.51,"","BO",TEAMID,"","","ERR")
 I $G(DEBUG),$D(ERR) W ! W $$ZW^SYNDHPUTL("ERR")
 I TEAMIEN=0,+TEAMID,'$D(^SCTM(404.51,+TEAMID)) S RETSTA="-1^Team not found" QUIT
 I $D(^SCTM(404.51,+TEAMID,0)) S TEAMIEN=TEAMID
 I TEAMIEN=0 S RETSTA="-1^Team not found" QUIT
 ;
 I $G(DEBUG) W !,"---------------------------- care team ---------------------------------",!
 N P S P="|"
 S RETSTA=""
 N TEAM,TEAMJ,TEAMS
 DO
 . D GET1TEAM^SYNDHP18(.TEAM,TEAMIEN,0)
 . M TEAMS("Teams",TEAMIEN)=TEAM
 . QUIT:$D(TEAM("Team","ERROR"))
 . I $G(RETJSON)'="J",$G(RETJSON)'="F" D
 . . S RETSTA=RETSTA_TEAM("Team","resourceId")_P_TEAM("Team","teamName")_P_TEAM("Team","teamPurpose")_P_TEAM("Team","institution")_P_TEAM("Team","serviceDept")_P
 . . S RETSTA=RETSTA_TEAM("Team","currentStatusC")_P_"longitudinal"_P_TEAM("Team","currentActivationDateCHL7")_P_TEAM("Team","currentInactivationDateCHL7")_P
 . . S RETSTA=RETSTA_TEAM("Team","current#PatientsC")_P_TEAM("Team","resourceType")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TEAM")
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("TEAMS") W !
 ;
 ;I $G(RETJSON)="F" D xxx  ;create array for FHIR
 ;
 I $G(RETJSON)="J"!($G(RETJSON)="F") D
 . S RETSTA=""
 . D TOJASON^SYNDHPUTL(.TEAMS,.RETSTA)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("RETSTA") W !
 ;
 QUIT
 ;
 ; ----------- Unit Test -----------
T1 ;
 N TEAMID S TEAMID="RED"
 N JSON S JSON=""
 N RETSTA
 D GETTEAM(.RETSTA,TEAMID,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T2 ;
 N TEAMID S TEAMID=3
 N JSON S JSON="J"
 N RETSTA
 D GETTEAM(.RETSTA,TEAMID,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T3 ;
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON=""
 N RETSTA
 D GETTEAMS(.RETSTA,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T4 ;
 N FRDAT S FRDAT=20121231
 N TODAT S TODAT=20141231
 N JSON S JSON=""
 N RETSTA
 D GETTEAMS(.RETSTA,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
T5 ;
 N FRDAT S FRDAT=""
 N TODAT S TODAT=""
 N JSON S JSON="J"
 N RETSTA
 D GETTEAMS(.RETSTA,FRDAT,TODAT,JSON)
 W $$ZW^SYNDHPUTL("RETSTA")
 QUIT
 ;
