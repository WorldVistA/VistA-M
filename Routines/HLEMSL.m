HLEMSL ;ALB/CJM -List Manager Screen for Event List;12 JUN 1997 10:00 am
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13,1995
 ;
EN ;Entry point to viewing the HL7 Monitor Event Log
 ;
 N IDX,SITE,PROFILE
 S PROFILE=$$PROFILE
 Q:'PROFILE
 I PROFILE S PROFILE=$$GET^HLEMP(PROFILE,.PROFILE)
 ;
 S IDX="^TMP(""HLEM"",$J,""EVENTS"")"
 D WAIT^DICD
 D EN^VALM("HLEM DISPLAY EVENTS")
 Q
 ;
PROFILE() ;returns the profile to use in building the display.
 ;  1)First checks if there is a default profile, if so,returns it
 ;  2)If no default profile, but the user has exactly 1 profile, ruturs that
 ;  3) If multiple profiles, asks the user to select one.
 ;  4) If the user has no profile, he is asked to create one.
 ;Input:  DUZ must be defined
 ;Output: function returns profile's ien, or "" if not successful
 ;
 N PROFILE
 ;get the user's profile
 I '$G(DUZ) W !,"** Your DUZ is not defined, please report this to your IRM!" Q ""
 S PROFILE=$$FDEFAULT^HLEMP(DUZ)
 I 'PROFILE D
 .;there is no default profile, check for others
 .S PROFILE=$$SELECT^HLEMP1($G(DUZ),10)
 I 'PROFILE,$$ASKYESNO^HLEMU("You need a profile before viewing the HL7 Monitor Event Log,would you like to  create a new profile now","YES") D
 .N NAME,I
 .F I=1:1:20 I '$D(^HLEV(776.5,"C",DUZ,"NEW PROFILE"_I)) S NAME="NEW PROFILE"_I Q
 .S:$D(NAME) PROFILE=$$CREATE^HLEMP(DUZ,NAME)
 .I PROFILE,'$$EDIT^HLEMP(PROFILE) D
 ..I '$$DELETE^HLEMP(PROFILE) W !,"Incomplete profile couln't be deleted!"
 ..S PROFILE=""
 Q PROFILE
 ;
HDR ;Header code
 S VALMHDR(1)="#    TYPE        DT/TM         APP             MSG      REVIEW         CNT"
 Q
 ;
INIT ;Init variables and list array
 D BLD
 S VALMSG="USER PROFILE: "_PROFILE("NAME")
 D HDR
 S VALMBCK="R"
 Q
 ;
BLD ;Build event log screen
 D CLEAN^VALM10
 N SITE,TIME,TYPE,STATUS,COUNT
 K @IDX,VALMHDR
 S VALMBG=1,(COUNT,VALMCNT)=0
 ;
 ;Build header
 D HDR
 ;
 ;Build list area
 ;what sites to include? Put in alphabetical order
 S SITE="" F  S SITE=$O(^HLEV(776.4,"D",SITE)) Q:'SITE  D
 .I 'PROFILE("ALL SITES"),'$D(PROFILE("SITES",SITE)) Q
 .N STATION
 .S STATION=$$STATION^HLEMSU(SITE) S:$L($P(STATION,"^")) SITE($P(STATION,"^"))=SITE
 ;
 S SITE=""
 F  S SITE=$O(SITE(SITE)) Q:'$L(SITE)  D
 .N FIRST
 .S FIRST=1
 .S TYPE=0
 .F  S TYPE=$O(^HLEV(776.4,"D",SITE(SITE),TYPE)) Q:'TYPE  D:(PROFILE("ALL TYPES"))!($D(PROFILE("TYPES",TYPE)))
 ..;maintain an index for the event type
 ..S @IDX@("SITE",SITE(SITE),"TYPE",TYPE)=VALMCNT
 ..S TIME=PROFILE("START")
 ..F  S TIME=$O(^HLEV(776.4,"D",SITE(SITE),TYPE,TIME)) Q:'TIME  D
 ...S STATUS=""
 ...S STATUS=$O(^HLEV(776.4,"D",SITE(SITE),TYPE,TIME,STATUS)) Q:'$L(STATUS)  D
 ....N EVENTIEN
 ....S EVENTIEN=0
 ....F  S EVENTIEN=$O(^HLEV(776.4,"D",SITE(SITE),TYPE,TIME,STATUS,EVENTIEN)) Q:'EVENTIEN  D
 .....N EVENT
 .....Q:'$$GET^HLEME(EVENTIEN,.EVENT)
 .....I PROFILE("URGENT"),'EVENT("URGENT") Q
 .....I 'PROFILE("ALL APPS") Q:'$L(EVENT("APPLICATION"))  Q:'$D(PROFILE(EVENT("APPLICATION")))
 .....;
 .....;if this is the first event for this site,display a header
 .....I FIRST D  S FIRST=0
 ......;S VALMCNT=$$SET^HLEMSU($$INC^HLEMU(.VALMCNT),$$CENTER^HLEMSU("SITE: "_SITE_"   STATION #: "_$P($$STATION^HLEMSU(SITE(SITE)),"^",2)),1,"RUH")
 ......I $$SET^HLEMSU(VALMCNT,$$LJ^XLFSTR($E($G(@IDX@(VALMCNT,0)),4,80),77),4,"U")
 ......S VALMCNT=$$SET^HLEMSU($$INC^HLEMU(.VALMCNT),SITE_"   STATION #: "_$P($$STATION^HLEMSU(SITE(SITE)),"^",2),1,"H")
 ......;also, maintain an index for searching
 ......S @IDX@("SITE",SITE(SITE))=VALMCNT
 ......S @IDX@("SITE",SITE)=VALMCNT
 .....;
 .....;display the event
 .....D DISPLAY(.EVENT,.VALMCNT,.COUNT)
 Q
 ;
DISPLAY(EVENT,VALMCNT,COUNT) ;
 ;Adds one line for an event to the list, increments the counts of lines and events, and maintains the search index for events on the list
 ;
 N CODE,TIME
 S @IDX@("EVENT",$$INC^HLEMU(.COUNT))=EVENT("IEN")
 S VALMCNT=$$SET^HLEMSU($$INC^HLEMU(.VALMCNT),COUNT,1,"R")
 S VALMCNT=$$SET^HLEMSU(VALMCNT,$$CODE^HLEMT(EVENT("TYPE")),6)
 S VALMCNT=$$SET^HLEMSU(VALMCNT,$$FMTE^XLFDT($E(EVENT("DT/TM"),1,12),2),17)
 S VALMCNT=$$SET^HLEMSU(VALMCNT,$E(EVENT("APPLICATION"),1,15),32)
 I $L(EVENT("MSG TYPE")) S VALMCNT=$$SET^HLEMSU(VALMCNT,EVENT("MSG TYPE")_"~"_EVENT("MSG EVENT"),48)
 S VALMCNT=$$SET^HLEMSU(VALMCNT,$E($$EXTERNAL^DILFD(776.4,.06,"F",EVENT("REVIEW STATUS")),1,15),57)
 I EVENT("COUNT")>1 S VALNCNT=$$SET^HLEMSU(VALMCNT,EVENT("COUNT"),72)
 I EVENT("URGENT") S VALMCNT=$$SET^HLEMSU(VALMCNT,"*",79,"BRH")
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K @IDX
 Q
 ;
EXPND ;Expand code
 Q
