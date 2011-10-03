GMRAPET0 ;HIRMFO/RM-VERIFIED ALLERGY TASKS ;11/17/06  10:27
 ;;4.0;Adverse Reaction Tracking;**6,17,21,20,38**;Mar 29, 1996;Build 2
EN1(GMRADFN,GMRAPA,GMRACT,GMRAOUT) ;
 ; ENTRY TO PERFORM ALL OF THE TASKS NECESSARY FOR
 ;                 A PROGRESS NOTE TO BE ENTERED BY ART
 ;     INPUT:
 ;           GMRADFN = PATIENT IEN IN THE PATIENT FILE
 ;           GMRAPA  = THE IEN IN THE PATIENT ALLERGY FILE
 ;           GMRACT  = THE ACTION TO BE ENTERED FOR THIS REACTION
 ;                   = "V" VERIFICATION OF A REACTION
 ;                   = "S" SIGN OFF OF A REACTION
 ;                   = "M" MEDWATCH FORM ENTERD
 ;                   = "E" REACTION ENERED IN ERROR
 ;      OUTPUT:
 ;           GMRAOUT = REACTION ALL WAS PASSED
 ;                   = 1 USER ABORT OR PN FAIL IN SOME WAY
 ;                   = 0 PASSED
 ;
 ;      VARABLE LIST
 ;        GMRACW = IS THE PROGRESS NOTE TITLE
 ;       GMRALOC = IS THE LOCATION OF THE PATIENT
 ;      GMRAHLOC = IS THE LOCATION IN FILE 44
 ;       GMRADFN = IS THE PATIENT IEN
 ;        GMRADT = IS THE DATE THE EVENT TOOK PLACE
 ;       GMRADUZ = IS THE USER WHO ENTERED THE INFORMATION
 ;        GMRAPN = IS THE IEN OF THE PROGRESS NOTE THAT WAS ENTERED
 ;
 ;CHECKING FOR A VALID TITLE
 K ^TMP("TIUP",$J),GMRAPN
 N GMRACW,GMRALOC,GMRAHLOC,GMRAXBOS ;21
 S GMRAPN=-1,GMRAXBOS=$$BROKER^XWBLIB ;21 Got GUI?
 I "VSME"'[GMRACT S GMRAOUT=1 D EXIT Q
 ; The following lines of code which reference Progress Notes files and
 ; routines will have to change when TIU replaces Progress Notes.
 ;S GMRACW=0 F  S GMRACW=$O(^GMR(121.2,"B","ADVERSE REACTION/ALLERGY",GMRACW)) Q:GMRACW<1  I $P($G(^GMR(121.1,$P($G(^GMR(121.2,GMRACW,0)),U,2),0)),U)="GENERAL NOTE" Q
 ;-----ADDED BY VAUGHN 1/13/97 FOR TIU REPLACES LINE ABOVE----
 S GMRACW=+$$WHATITLE^TIUPUTU("ADVERSE REACTION/ALLERGY")
 ;------END---
 ;-----CHANGED BY VAUGHN 1/13/97 FOR TIU---
 I GMRACW<1!($T(NEW^TIUPNAPI)']"")!('$$CANPICK^TIULP(GMRACW)) S GMRAOUT=1 D EXIT Q  ;21
 ;I GMRACW<1!($T(PN^GMRPART)']"") S GMRAOUT=1 D EXIT Q
 ;-----END----
 D @GMRACT I GMRAOUT D EXIT Q  ; THIS TELL'S THE PROGRAM WHERE TO GO
 S GMRALOC=""
 D VAD^GMRAUTL1(GMRADFN,"",.GMRALOC,"","","")
 I GMRALOC'="" S GMRAHLOC=+$G(^DIC(42,GMRALOC,44))
 ;E  I '$G(GMRAXBOS) D ASK ;20
 ; Call to Progress Notes
 ; vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
 ;S:'GMRAOUT GMRAPN=+$$PN^GMRPART(GMRADFN,GMRADUZ,GMRADT,GMRACW,GMRAHLOC)
 ;---REPLACED LINE ABOVE WITH LINE BELOW;1/13/97 VAUGHN---
 I 'GMRAOUT D
 .S GMRAPN=0 D NEW^TIUPNAPI(.GMRAPN,GMRADFN,GMRADUZ,GMRADT,GMRACW,$G(GMRAHLOC),$S($G(GMRAXBOS):0,1:1)) ;17,21 Allow editing if not in GUI
 ;----------END-------
 I GMRAPN=-1,'$G(GMRAXBOS) S GMRAOUT=1 W !,"No Progress Note was created." ;21
 I GMRAPN=0,'$G(GMRAXBOS) W !,"Progress note has not been signed." ;21
 D EXIT
 Q
EXIT ; Clean up of variables
 K ^TMP("TIUP",$J),GMRALOC,GMRAHLOC,GMRADUZ ;38 Removed variable GMRAPN from list of variables to kill
 Q
ASK ; Simple file manager query for a location in file 44
 N DIC
 S X=""
 S DIC=44,DIC(0)="AEQ",DIC("A")="Select a Hospital Location: ",DIC("S")="I ""CMW""[$P(^(0),U,3)" ;20
 W !,"A progress note is being created because you "_$S(GMRACT="V":"verified",GMRACT="E":"inactivated",GMRACT="S":"activated",1:"entered a medwatch form for"),!,$P($G(^GMR(120.8,GMRAPA,0)),U,2),"." ;20
 W !,"Enter a hospital location to be associated with this note." ;20
 D ^DIC
 I $D(DTOUT)!($D(DUOUT)) S GMRAOUT=1 Q
 S GMRAHLOC=+Y
 Q
V ; Verified Reaction
 N GMRAI ;21
 S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0))
 S GMRADT=$P(GMRAPA(0),U,17),GMRADUZ=$P(GMRAPA(0),U,18)
 S:GMRADUZ="" GMRADUZ=DUZ ; Autoverified reaction being reverified
 S ^TMP("TIUP",$J,1,0)="This patient has had an "_$S($P(GMRAPA(0),"^",14)="P":"adverse reaction reported for ",1:"allergy to ")_$P(GMRAPA(0),"^",2)
 S ^TMP("TIUP",$J,2,0)="verified on "_$$FMTE^XLFDT(GMRADT,1)_"."
 S GMRAI=2 D ADDCOM("V",.GMRAI) ;21
 S ^TMP("TIUP",$J,0)=U_U_GMRAI_U_GMRAI_U_GMRADT_"^^^" ;21
 Q
S ; Signed Reaction
 N GMRAI,GMRAREAC ;21
 D NOW^%DTC
 S GMRADT=%,GMRADUZ=DUZ
 S GMRAREAC=0,GMRAI=3 F  S GMRAREAC=$O(GMRAPA(GMRAREAC)) Q:GMRAREAC<1  S GMRAI=GMRAI+1,^TMP("TIUP",$J,GMRAI,0)=$P($G(^GMR(120.8,GMRAREAC,0)),U,2) S GMRAPA=GMRAREAC D  ;21
 .D ADDCOM("O",.GMRAI) ;21
 .S GMRAI=GMRAI+1,^TMP("TIUP",$J,GMRAI,0)="" ;21
 S ^TMP("TIUP",$J,1,0)="This patient has had the following reaction"_$S(GMRAI=3:" ",1:"s ")
 S ^TMP("TIUP",$J,2,0)="signed-off on "_$$FMTE^XLFDT(GMRADT,1)_"."
 S ^TMP("TIUP",$J,3,0)="" ;21
 S ^TMP("TIUP",$J,0)=U_U_GMRAI_U_GMRAI_U_GMRADT_"^^^"
 Q
M ; MedWATCH data entered
 N X
 S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0))
 D NOW^%DTC
 S GMRADT=%,GMRADUZ=DUZ
 S ^TMP("TIUP",$J,1,0)="This patient has had a MEDWatch report completed on "_$$FMTE^XLFDT(GMRADT,1)_" for"
 S ^TMP("TIUP",$J,2,0)=$S($P(GMRAPA(0),"^",14)="P":"an adverse reaction to ",1:"allergy to ")_$P(GMRAPA(0),"^",2)_"."
 S ^TMP("TIUP",$J,0)=U_U_"2"_U_"2"_U_GMRADT_"^^^"
 Q
E ; Reaction Entered in Error
 N GMRAER,GMRAI ;21
 S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0))
 S GMRAER=$G(^GMR(120.8,GMRAPA,"ER")) I GMRAER="" S GMRAOUT=1 Q
 S GMRADT=$P(GMRAER,U,2),GMRADUZ=$P(GMRAER,U,3)
 S ^TMP("TIUP",$J,1,0)="The "_$S($P(GMRAPA(0),"^",14)="P":"adverse reaction ",1:"allergy ")_"to "_$P(GMRAPA(0),"^",2)_" was removed on "_$$FMTE^XLFDT($P(GMRADT,"."),2)_"." ;20
 S ^TMP("TIUP",$J,2,0)="This reaction was either an erroneous entry or was found" ;20
 S ^TMP("TIUP",$J,3,0)="to no longer be a true "_$S($P(GMRAPA(0),"^",14)="P":"adverse reaction",1:"allergy")_"." ;20
 S GMRAI=3 D ADDCOM("E",.GMRAI) ;21,20
 S ^TMP("TIUP",$J,0)=U_U_GMRAI_U_GMRAI_U_GMRADT_"^^^" ;21
 Q
 ;
ADDCOM(TYPE,CNT) ;Add any comments to progress note - section added in patch 21
 N SUB,ENTRY
 S ENTRY=$O(^GMR(120.8,GMRAPA,26,"AVER",TYPE,0)) Q:'+ENTRY
 S CNT=CNT+1,^TMP("TIUP",$J,CNT,0)="",CNT=CNT+1,^TMP("TIUP",$J,CNT,0)="Author's comments:"
 S CNT=CNT+1,^TMP("TIUP",$J,CNT,0)=""
 S SUB=0 F  S SUB=$O(^GMR(120.8,GMRAPA,26,ENTRY,2,SUB)) Q:'+SUB  S CNT=CNT+1,^TMP("TIUP",$J,CNT,0)=^GMR(120.8,GMRAPA,26,ENTRY,2,SUB,0)
 Q
