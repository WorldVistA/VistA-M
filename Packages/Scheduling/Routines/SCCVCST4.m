SCCVCST4 ;ALB/TMP - Scheduling Conversion Template Utilities - CST; APR 20, 1998
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
RESULT ; Display conversion results message 
 ;
 N DIR,Y,Z
 I $D(SCERRMSG)!'$G(SCTOT("OK")) D
 . I '$O(SCERRMSG("")) S SCERRMSG(1)="UNKNOWN ERROR"
 . S DIR("A",1)=$S(SCCVEVT=1:"",1:"RE")_"CONVERSION ENCOUNTERED THE FOLLOWING ERROR(S): ",DIR("A",2)=" "
 . S Z=0 F  S Z=$O(SCERRMSG(Z)) Q:'Z  S DIR("A",Z+2)="  "_SCERRMSG(Z)
 E  S DIR("A",1)=$S(SCCVEVT=1:"",1:"RE")_"CONVERSION WAS SUCCESSFUL"
 S DIR(0)="EA",DIR("A")="PRESS RETURN "
 D ^DIR K DIR
 Q
 ;
NOENT(SCCVTYPN,SCCVDFN,SCDTM) ;No entry was found for date/time/pt
 ;
 N DIR,X,Y
 S DIR(0)="EA"
 S DIR("A",1)="No valid "_SCCVTYPN_" was found for "
 S DIR("A",2)="  "_$P($G(^DPT(SCCVDFN,0)),U)_" ("_SCCVDFN_") on "_$$FMTE^XLFDT(SCDTM),DIR("A")="Press RETURN to continue: " D ^DIR K DIR
 Q
 ;
DISPERR(SCERR,SCF) ; Display error
 N DIR,Y,X,Z,CT
 I $G(SCERR) S SCERR(SCERR)=""
 S Z=$O(SCERR(0)) Q:'Z
 S DIR(0)="EA",DIR("A",1)="INVALID SELECTION: "_$P($T(SCERR+Z),";;",3)
 S CT=1 F  S Z=$O(SCERR(Z)) Q:'Z  S CT=CT+1,DIR("A",CT)=$J("",19)_$P($T(SCERR+Z),";;",3)
 I SCF["SDV",'$D(SCERR(1)) S DIR("A",CT+1)="(Th"_$S(CT>1:"ese errors",1:"is error")_" may apply to one or more of the ADD/EDIT's entries)"
 S DIR("A")="PRESS RETURN TO CONTINUE "
 D ^DIR K DIR
 W !
 Q
 ;
DISP1(SCCVTYPN,SCFILE1,SCCVDA) ; Display selected entry
 N DIC,DR,DIQ,DA,DIR,Y
 W !,SCCVTYPN_" #: "_SCCVDA
 I SCFILE1["SCE" S SCFILE1="^SCE("
 S DIC=SCFILE1,DIQ(0)="R",DA=SCCVDA
 D EN^DIQ
 S DIR(0)="YA",DIR("A")="IS THIS THE CORRECT ENTRY?: ",DIR("B")="NO"
 S DIR("?")="If you say YES here, this entry will be converted"
 D ^DIR K DIR
 W !
 Q $P(Y,U)
 ;
CONV1(SCCVEVT,SCFILE,SCCVDFN,SCDTM,SCCVDA) ;Convert one entry (appt/disp/add-edit/enctr)
 ; Conversion will include any child encounters
 N SCF,DATA,SCTOT,SCERRMSG,SCCVERRH,SCSTOPF,SCCS
 S SCF=SCFILE
 ;
 I SCFILE["SCE" D  ; Encounter - set file for specific origin
 . N SCORG,DATA
 . S DATA=$G(@SCF@(+$G(SCCVDA),0)),SCORG=$P(DATA,U,8)
 . S SCF=$S(SCORG=1:"^DPT("_$P(DATA,U,2)_",""S"")",SCORG=2:"^SDV",SCORG=3:"^DPT("_$P(DATA,U,2)_",""DIS"")",1:"")
 . S (SCCVDA,SCDTM)=+DATA
 . S:SCORG=2 SCCS=+$P(DATA,U,9),SCTOT("A/E")=1
 . S:SCORG=3 SCCVDA=9999999-SCCVDA
 ;
 I SCF["""S""" D  G CONVQ ; Appointment
 . S DATA=$G(@SCF@(SCDTM,0)),SCTOT("OK")=""
 . I DATA D
 .. W !,$P("Converting^Reconverting",U,SCCVEVT),"..."
 .. D ZERO^SCCVEAP(SCCVDFN)
 .. D EN^SCCVEAP1(SCCVEVT,SCCVDFN,SCDTM,+DATA,"","")
 . D RESULT
 ;
 I SCF["""DIS""" D  G CONVQ ; Disposition
 . S DATA=$G(@SCF@(+$G(SCCVDA),0)),SCTOT("OK")=0
 . I DATA D
 .. W !,$P("Converting^Reconverting",U,SCCVEVT),"..."
 .. D ZERO^SCCVEDI(SCCVDFN)
 .. D EN^SCCVEDI1(SCCVEVT,SCCVDFN,SCDTM,"")
 . D RESULT
 ;
 I SCF["SDV" D  G CONVQ ; Add/edit
 . I SCF=SCFILE D  Q  ; Convert whole add/edit
 .. S DATA=$G(@SCF@(SCDTM,0)),SCTOT("OK")=0
 .. I DATA D
 ... W !,$P("Converting^Reconverting",U,SCCVEVT),"..."
 ... D STOPS^SCCVEAE(SCCVEVT,SCDTM,"","","")
 .. D RESULT
 . ;
 . I SCF'=SCFILE D  ; Convert one add/edit clinic stop (chosen by enctr)
 .. S DATA=$G(@SCF@(SCDTM,"CS",SCCS,0)),SCTOT("OK")=0
 .. I DATA'="" D
 ... W !,$P("Converting^Reconverting",U,SCCVEVT),"..."
 ... D ZERO^SCCVEAE(SCDTM)
 ... D EN^SCCVEAE1(SCCVEVT,SCDTM,SCCS,"","")
 .. D RESULT
CONVQ Q
 ;
 ;
SCERR ; Invalid reasons
 ;;1;;THE ENTRY REQUESTED COULD NOT BE FOUND
 ;;2;;DATE OF THE ENTRY MUST BE BEFORE 10/1/96
 ;;3;;ALREADY HAS A VISIT
 ;;4;;ENTRY IS A 'CHILD'
 ;;5;;ENTRY DOES NOT HAVE A VALID DISPOSITION
 ;;6;;APPOINTMENT STATUS IS NOT VALID
 ;;7;;APPOINTMENT IS NOT FOR A VALID CLINIC
 ;;8;;ENTRY WAS NOT PREVIOUSLY CONVERTED
 ;;9;;ENCOUNTER NOT CHECKED OUT
 ;
