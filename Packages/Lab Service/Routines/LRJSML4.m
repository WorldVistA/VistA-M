LRJSML4 ;ALB/GTS - Lab Vista Hospital Location Pre-Patch Utilities;02/24/2010 14:01:37
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
 ;
EXTHL(LRES) ;** Create HL output array
 ;Create array of active Hospital Locations of type Clinic, Ward, Operating Room
 ;Add associated Ward Location to the array
 ;Find Room-Beds assocated with the Ward Location
 ;
 ;INPUT:
 ;      LRES - Node for array of active locations and room-beds
 ;
 ;OUTPUT:
 ;      LRES - List Array of active hospital locations (Clinic, Ward, OR)
 ;
 ;Set LRES array in the following format:
 ;^TMP(545954627,"LRJ SYS",#)=NEW^LOCATION^HL IEN^HL Name^HL Type^Institution^Division^InActive Dt (NULL)^Active Dt(NULL)^Person making change^Chnge Dt/Tm
 ;^TMP(545954627,"LRJ SYS",#+1)=NEW^ROOM^HL IEN^HL Name^HL Type^Institution^Division^Room^
 ;^TMP(545954627,"LRJ SYS",#+2)=NEW^BED^HL IEN^HL Name^HL Type^Institution^Division^Room^Bed
 ;^TMP(545954627,"LRJ SYS",#+3)=NEW^BED^HL IEN^HL Name^HL Type^Institution^Division^Room^Bed
 ;
 ;IA #10040 allows reference the following fields:
 ; Hospital Location #44, Field #.01  [NAME]  (LRHLNAME)                     [FILEMAN]
 ; Hospital Location #44, Field #2    [TYPE]  (LRHLTYPE)                     [FILEMAN]
 ; Hospital Location #44, Field #3    [INSTITUTION]  (LRHLINST)              [FILEMAN]
 ; Hospital Location #44, Field #3.5  [DIVISION]  (LRHLDIV)                  [FILEMAN]
 ; Hospital Location #44, Field #42   [WARD LOCATION FILE POINTER]  (LRWPTR) [DIRECT GLOBAL ACCESS]
 ; Hospital Location #44, Field #2505 [INACTIVE DATE]  (LRINACT)             [FILEMAN]
 ; Hospital Location #44, Field #2506 [REACTIVATION DATE]  (LRREACT)         [FILEMAN]
 ;
 ;IA #1380 allows reference to Room-Bed file:
 ; Room-Bed #405.4, Field #.01        [NAME]  (LRRMBD)                       [DIRECT GLOBAL ACCESS]
 ; X-Ref on Wards Which Can Assign multiple in Room-Bed file (405.4^W)
 ;                                    [^DG(405.4,"W",$E(X,1,30),DA(1),DA)]   [DIRECT GLOBAL ACCESS]
 ;
 NEW LRHLIEN,LRTYPEIN,LRINACTI,LRREACTI,LRNODE,LRNOW
 NEW LRLP,LRCHAR
 ;Loop HL file screening TYPE and INACTIVE/REACTIVATION dates
 ;QUESTION: Does the HLCMS system report items that are not inactive but have future dates?
 ;ANSWER: HLCMS reports changes to inactive/active dates.
 ; Want to report locations that are now active or will become active in the future.
 ;   If INACT=NULL then report
 ;   If INACT'=NULL then...
 ;     IF ACT>NOW then report [If (INACT<NOW,ACT>NOW)!(INACT>NOW,ACT>NOW)]
 ;     If INACT>NOW,ACT<NOW then report
 ;     If INACT<NOW,ACT<NOW,ACT>INACT then report
 ;
 ;Pull Name, Type, Institution, Division, WL PTR, Inactivation Date, ReActivation Date from file 44
 ;Find Room-Beds that have the same WL PTR, check for OOS dates and report if in-service.
 DO IOXY^XGF(IOSL-1,53)
 WRITE "[Extract Locations..."
 SET LRHLIEN=""
 SET (LRHLIEN,LRNODE,LRCHAR)=0
 D NOW^%DTC
 SET LRNOW=%
 KILL %,%H,%I,X
 FOR  SET LRHLIEN=$O(^SC(LRHLIEN)) QUIT:+LRHLIEN'>0  DO
 .D HANGCHAR^LRJSMLU(.LRCHAR)
 .SET (LRTYPEIN,LRINACTI,LRREACTI)=""
 .SET LRTYPEIN=$$GET1^DIQ(44,LRHLIEN_",",2,"I")   ;HL Type (INT)
 .;
 .;IF TYPE IS 'CLINIC', 'WARD', 'OPERATING ROOM'
 .IF (LRTYPEIN="C")!(LRTYPEIN="W")!(LRTYPEIN="OR") DO
 ..SET LRINACTI=$$GET1^DIQ(44,LRHLIEN_",",2505,"I")  ;HL Inact Dte (INT)
 ..SET LRREACTI=$$GET1^DIQ(44,LRHLIEN_",",2506,"I")  ;HL React Dte (INT)
 ..IF LRINACTI="" DO SETARRY(.LRES,.LRNODE,LRHLIEN,LRNOW)
 ..IF LRINACTI'="" DO
 ...IF LRREACTI>LRNOW DO SETARRY(.LRES,.LRNODE,LRHLIEN,LRNOW)
 ...IF LRINACTI>LRNOW,LRREACTI<LRNOW DO SETARRY(.LRES,.LRNODE,LRHLIEN,LRNOW)
 ...IF LRINACTI<LRNOW,LRREACTI<LRNOW,LRREACTI>LRINACTI DO SETARRY(.LRES,.LRNODE,LRHLIEN,LRNOW)
 QUIT
 ;
SETARRY(LRES,LRNODE,LRHLIEN,LRNOW) ;Set Location Array
 ;INPUT:
 ;     LRES    - Array to create and return
 ;     LRNODE  - Last node # added to array
 ;     LRHLIEN - Hospital Location (#44) IEN
 ;     LRNOW   - Date/Time creating array
 ;
 ;OUTPUT:
 ;     LRES    - Array with Location/Room/Bed nodes added
 ;
 NEW LRHLNAME,LRHLTYPE,LRINST,LRDIV,LRRMBD,LRINACT,LRREACT,LRWPTR,LRRMBDPT,LRRMOLD,LRBED,LRROOM
 SET (LRHLNAME,LRHLTYPE,LRINST,LRDIV,LRRMBD,LRINACT,LRREACT,LRWPTR,LRRMBDPT,LRRMOLD)=""
 SET LRNODE=LRNODE+1
 SET LRINACT=$$GET1^DIQ(44,LRHLIEN_",",2505) ;HL Inact Dte (EXT)
 SET LRREACT=$$GET1^DIQ(44,LRHLIEN_",",2506) ;HL React Dte (EXT)
 SET LRHLTYPE=$$GET1^DIQ(44,LRHLIEN_",",2)   ;HL Type (EXT)
 SET LRHLNAME=$$GET1^DIQ(44,LRHLIEN_",",.01) ;HL Name (EXT)
 SET LRINST=$$GET1^DIQ(44,LRHLIEN_",",3)     ;HL Inst (EXT)
 SET LRDIV=$$GET1^DIQ(44,LRHLIEN_",",3.5)    ;HL Div (EXT)
 SET LRWPTR=+$P($G(^SC(LRHLIEN,42)),"^")     ;Ward Loc PTR (EXT)
 SET @LRES@(LRNODE)="NEW^LOCATION^"_LRHLIEN_"^"_LRHLNAME_"^"_LRHLTYPE_"^"_LRINST_"^"_LRDIV_"^"_LRINACT_"^"_LRREACT_"^"_"ADT ADMINISTRATOR <UNKNOWN>"_"^"_LRNOW
 FOR  SET LRRMBDPT=$O(^DG(405.4,"W",LRWPTR,LRRMBDPT))  QUIT:+LRRMBDPT=0  DO
 .SET LRNODE=LRNODE+1
 .SET LRRMBD=$P(^DG(405.4,LRRMBDPT,0),"^")
 .SET LRROOM=$P(LRRMBD,"-")
 .IF LRROOM'=LRRMOLD DO
 ..SET @LRES@(LRNODE)="NEW^ROOM^"_LRHLIEN_"^"_LRHLNAME_"^"_LRHLTYPE_"^"_LRINST_"^"_LRDIV_"^"_LRROOM_"^"
 ..SET LRRMOLD=LRROOM
 ..SET LRNODE=LRNODE+1
 .SET LRBED=$P(LRRMBD,"-",2,10)
 .SET @LRES@(LRNODE)="NEW^BED^"_LRHLIEN_"^"_LRHLNAME_"^"_LRHLTYPE_"^"_LRINST_"^"_LRDIV_"^"_LRROOM_"^"_LRBED
 QUIT
 ;
CDRNG ;Protocol: LRJ SYS MAP HL AUDIT QUERY to select the report type
 D FULL^VALM1
 NEW LRTYPE
 SET LRTYPE=$$TYPESEL()
 ;
 ;Reset screen display
 IF LRTYPE'=-1 DO
 .DO:LRTYPE="C" INIT
 .DO:LRTYPE="I" INIT^LRJSML1
 IF LRTYPE=-1 D MSG^LRJSML SET VALMBCK="R"
 QUIT
 ;
INIT ;* init variables and list array
 N LRFROM,LRTO
 K ^TMP($J,"LRJ SYS"),^TMP("LRJ SYS USER MANAGER - DATES",$JOB)
 K ^TMP("LRJ SYS USER MANAGER - INIT",$JOB)
 DO IOXY^XGF(IOSL-1,53)
 WRITE "[Extract Locations..."
 D CREATRPT(.LRFROM,.LRTO,"^TMP($J,""LRJ SYS"")")
 I (+$G(LRFROM)'>0)!(+$G(LRTO)'>0) DO
 . S VALMBCK="R"
 . S VALMBG=1
 I (+$G(LRFROM)>0),(+$G(LRTO)>0) DO
 . D CLEAR(LRFROM,LRTO,"^TMP($J,""LRJ SYS"")")
 . D HDR^LRJSML
 . D MSG^LRJSML
 QUIT
 ;
CREATRPT(LRFROM,LRTO,LRHLARY) ;Create array of HL changes between selected dates
 N DIR
 ;
 W !!,"  Enter Hospital Location Extract Date Range...",!
 ;
 S LRFROM=$$DATEENT("Select Start date: ",,"-NOW")
 Q:+LRFROM<1
 S LRTO=$$DATEENT("  Select End date: ",LRFROM,"-NOW")
 Q:+LRTO<1
 SET ^TMP("LRJ SYS USER MANAGER - INIT",$JOB)=0
 D HDR^LRJSML
 D MSG^LRJSML
 ;
 ;Call Report API
 D BLDREC^LRJSMLA(LRFROM,LRTO,LRHLARY)
 ;
 Q
 ;
DATEENT(LRPRMPT,LRBD,LRED) ;Prompt for extract date
 ;INPUT
 ; LRPRMPT - Prompt displayed to user
 ; LRBD    - Begin date of range
 ; LRED    - End date of range
 ;
 ;RETURN
 ; LRDT
 ;  SUCCESS: FILEMAN INTERNALLY FORMATED DATE
 ;  FAILURE: -1
 ;
 N LRDT,LRGOOD
 S LRGOOD=0
 S:+$G(LRED)>0 %DT(0)=LRED
 S:$G(LRED)["NOW" %DT(0)=LRED
 S %DT("A")=LRPRMPT
 S %DT("B")="TODAY" ;Default for [Start] date entry
 S %DT="AEPST"
 D:LRPRMPT["Start" ^%DT ;Prompt for Start date
 ;
 ;Prompt for End date with conditions
 I LRPRMPT["End" DO
 . F  Q:LRGOOD  DO
 . . S %DT("B")="NOW" ;Change default for End Date entry
 . . D ^%DT
 . . W:((Y<LRBD)&(X'="^")&('$D(DTOUT))) " ??",!,"   End date must follow Begin date!",!
 . . S:((Y>LRBD)!(Y=LRBD)!($D(DTOUT))!(X="^")) LRGOOD=1
 S LRDT=Y
 K Y,%DT
 Q LRDT
 ;
CLEAR(LRFROM,LRTO,LRHLARY) ;* clean up entries
 DO REFRESH(LRFROM,LRTO,LRHLARY)
 QUIT
 ;
REFRESH(LRFROM,LRTO,LRHLARY) ;* refresh display
 DO BUILD(LRFROM,LRTO,LRHLARY)
 D MSG^LRJSML
 SET VALMBCK="R"
 SET VALMBG=1
 QUIT
 ;
BUILD(LRFROM,LRTO,LRHLARY) ; -- build display array
 ;
 ;INPUT
 ; LRFROM  - Start report date (Optional)
 ; LRTO    - End report date (Optional)
 ; LRHLARY - Array of raw data extract (Required)
 ;
 QUIT:'$D(LRHLARY)  ;QUIT if LRHLARY is not defined)
 ;
 NEW LRSTATUS,LRJERRCT,LRX
 DO KILL
 DO KILL^VALM10()
 SET VALMCNT=0
 S LRX=" VistA Hospital Location changes"_$S($D(LRFROM):" from "_LRFROM,1:"")_$S($D(LRTO):" to "_LRTO,1:"")
 D ADD^LRJSMLU(.VALMCNT,LRX)
 DO CNTRL^VALM10(VALMCNT,1,$LENGTH(LRX)-1,IOUON,IOUOFF_IOINORM)
 ;
 D KILL
 SET ^TMP("LRJ SYS USER MANAGER - DATES",$JOB)=LRFROM_"^"_LRTO
 D LISTHL^LRJSML(LRFROM,LRTO,LRHLARY)
 ;
 ;;D GETLINK^LRJSML1(.VALMCNT,$$GETLINK())  ;;If add function to send HL MFN message, see if can check link here.
 Q
 ;
KILL ; -- kill off display data array
 KILL ^TMP("LRJ SYS MAP HL INIT MGR",$JOB)
 QUIT
 ;
TYPESEL() ;Select type of report
 ;OUTPUT
 ;   LRJRSLT : "I" - Initialization Extract
 ;           : "C" - Change Audit Extract
 ;           : "P" - Inactive Location Extract
 ;           :  -1 - Abort
 NEW LRJRSLT
 SET LRJRSLT=-1
 NEW DIR
 SET DIR("A")="  Enter Extract Report Type"
 SET DIR(0)="SO^I:Initialization Rpt;C:Location Change Rpt"
 SET DIR("?")="^D PROHELP^LRJSML4"
 SET DIR("L",1)="  Select one of the following:"
 SET DIR("L",2)="    I :   Initialization/Current Location Report"
 SET DIR("L")="    C :   Location Change Report"
 DO ^DIR
 SET:"ICP"[Y LRJRSLT=Y
 SET:($D(DTOUT)!$D(DUOUT)!(Y="")) LRJRSLT=-1
 SET:"ICP"'[Y LRJRSLT=-1
 KILL DIR,X,Y,DTOUT,DIRUT,DUOUT
 QUIT LRJRSLT
 ;
PROHELP ;Help with type of report prompt
 WRITE !,"Enter 'I' to extract all currently active locations."
 WRITE !,"Enter 'C' to extract the location changes for a selected date range."
 QUIT
