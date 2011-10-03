HLEMSL1 ;ALB/CJM,ALB/BRM - Actions for the HL7 Monitor Event Log; 2/27/01 1:25pm
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
SELECT ;Allows the user to change profiles, then rebuilds the Events Log
 N PROF
 D FULL^VALM1
 S PROF=$$SELECT^HLEMP1($G(DUZ),20)
 I PROF,PROF'=$G(PROFILE) D
 .S PROFILE=$$GET^HLEMP(PROF,.PROFILE)
 .D INIT^HLEMSL
 S VALMBCK="R"
 Q
 ;
EDIT ;Allows the user to select a profile & edit it, then rebuilds the Events Log
 N PROF
 D FULL^VALM1
 S PROF=$$SELECT^HLEMP1($G(DUZ),20)
 I PROF D
 .I $$EDIT^HLEMP(PROF)
 .S PROFILE=$$GET^HLEMP(PROF,.PROFILE)
 .D INIT^HLEMSL
 S VALMBCK="R"
 Q
 ;
NEW ;Allows the user to create a new profile, then rebuilds the Events Log
 N PROF,NAME,I
 D FULL^VALM1
 F I=1:1:20 I '$D(^HLEV(776.5,"C",DUZ,"NEW PROFILE"_I)) S NAME="NEW PROFILE"_I Q
 S:$D(NAME) PROF=$$CREATE^HLEMP(DUZ,NAME)
 I PROF,'$$EDIT^HLEMP(PROF) D
 .I '$$DELETE^HLEMP(PROFILE) W !,"Incomplete profile couln't be deleted!"
 .S PROFILE=""
 I PROF,PROF'=$G(PROFILE) D
 .S PROFILE=$$GET^HLEMP(PROF,.PROFILE)
 .D INIT^HLEMSL
 S VALMBCK="R"
 Q
 ;
GOSITE ;Allows the user to select a site and jump the display to it.
 N SITE,START
 S START=0
 D FULL^VALM1
 I $$PROMPT^HLEMU(776.4,.03,"",.SITE,1) D
 .S START=$G(@IDX@("SITE",SITE)) Q:START
 .S SITE=$P($G(^DIC(4,SITE,0)),"^",1)
 .Q:'$L(SITE)
 .S START=$G(@IDX@("SITE",SITE)) Q:START
 .S SITE=$O(@IDX@("SITE",SITE),-1)
 .I $L(SITE) S START=$G(@IDX@("SITE",SITE))
 I START S VALMBG=START
 S VALMBCK="R"
 Q
 ;
CNTSITES() ;
 N SITE,COUNT
 Q:'$D(IDX) 0
 S (COUNT,SITE)=""
 F  S SITE=$O(@IDX@("SITE",SITE)) Q:SITE=""  S COUNT=COUNT+1
 S COUNT=COUNT\2
 Q COUNT
 ;
SELECTE ;Allows the user to select a single event for display and editing.
 K DIR
 S DIR("A")="Enter the number of the event to display"
 S DIR(0)="N^1:"_$O(@IDX@("EVENT",9999999),-1)_":0"
 D ^DIR K DIR I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 D EN^HLEMSE($G(@IDX@("EVENT",Y)))
 S VALMBCK="R"
 Q
