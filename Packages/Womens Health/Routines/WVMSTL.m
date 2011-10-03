WVMSTL ;HCIOFO/FT-List WH Sexual Trauma Data ;3/27/01  11:12
 ;;1.0;WOMEN'S HEALTH;**11,14**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #2716 - $$GETSTAT^DGMSTAPI (supported)
 ;
BEGIN ;EP
 S WVE="",(WVMGR,WVPOP)=0
 D CMGR G:WVPOP EXIT
 D DEVICE G:WVPOP EXIT
 D START
EXIT ; Exit and clean up
 K ^TMP($J)
 D ^%ZISC
 K DIR,DIRUT,DIROUT,DTOUT,DUOUT
 K WVCRT,WVCST,WVDATE,WVDFN,WVDG,WVDGMST,WVDGMSTC,WVE,WVEC,WVLINE,WVLINL,WVMGR,WVMGRN,WVMGRO,WVMSTN,WVNAME
 K WVNODE,WVPAGE,WVPOP,WVPROV,WVSORT,WVSSN,WVST,WVSV,WVTAB,WVTITLE,WVUSER,WVVET,WVZSTOP
 K X,Y,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE
 Q
CMGR ;EP
 ;---> SELECT ONE CASE MANAGER OR ALL.
 W !!?3,"Show data for all patients for ONE particular Case Manager,"
 W !?3,"or all patients for ALL Case Managers?"
 N DIR,DIRUT,Y
 S DIR("A")="   Select ONE or ALL: ",DIR("B")="ONE",WVMGR=""
 S DIR(0)="SAM^o:ONE;a:ALL" D HELP1^WVMSTL
 D ^DIR K DIR
 I Y=-1!($D(DIRUT)) S WVPOP=1 Q
 ;---> IF ALL CASE MANAGERS, S WVE=1 AND QUIT.
 I Y="a" S WVE=1 Q
 D DIC^WVFMAN(790.01,"QEMA",.Y,"   Select CASE MANAGER: ")
 I Y<0 S WVPOP=1 Q
 ;---> FOR ONE CASE MANAGER, SET WVE=0 AND WVMGR=^VA(200 DFN, QUIT.
 S WVMGR=+Y,WVE=0
 Q
DEVICE ;EP
 ;---> GET DEVICE AND POSSIBLY QUEUE TO TASKMAN.
 S ZTRTN="DEQUEUE^WVMSTL"
 S ZTDESC="List Sexual Trauma Data"
 F WVSV="E","MGR" D
 .I $D(@("WV"_WVSV)) S ZTSAVE("WV"_WVSV)=""
 D ZIS^WVUTL2(.WVPOP,1,"HOME")
 Q
START ; Start data gathering
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 Q:$G(WVE)=""
 S (WVDFN,WVZSTOP)=0
 ; all case managers
 I WVE=1 F  S WVDFN=$O(^WV(790,WVDFN)) Q:'WVDFN!($G(ZTSTOP)=1)  D SET
 ; one case manager
 I WVE=0,WVMGR F  S WVDFN=$O(^WV(790,"C",WVMGR,WVDFN)) Q:'WVDFN!($G(ZTSTOP)=1)  D SET
 Q:$G(ZTSTOP)=1
 D PRINT^WVMSTL1
 Q
SET ; Set temp global
 S WVZSTOP=WVZSTOP+1
 ; if a background task, check if user requested to stop the task 
 I $D(ZTQUEUED),WVZSTOP#100=0 D STOPCHK^WVUTL10(0) Q:$G(ZTSTOP)=1
 Q:$$DECEASED^WVUTL1(WVDFN)  ;deceased
 S WVNODE=$G(^WV(790,WVDFN,0)) Q:WVNODE=""
 I $P(WVNODE,U,24)>0,$P(WVNODE,U,24)<DT Q  ;inactive date before today
 S WVVET=$$VET^WVUTL1A(WVDFN) ;veterans status
 S WVEC=$$ELIG^WVUTL9(WVDFN),WVEC=$P(WVEC,U,2) ;primary eligibility code
 S WVPROV=$$PROVI^WVUTL1A(WVDFN) ;primary provider
 S WVMGR=$P(WVNODE,U,10) ;case manager ien
 S WVDGMST="<N/A Not a Veteran>"
 S WVDGMSTC=""
 I $E(WVVET)="Y" D
 .; $$GETSTAT^DGMSTAPI supported API - IA #2716
 .S WVDGMST=$$GETSTAT^DGMSTAPI(WVDFN) ;get MST value from Registration
 .S WVDGMSTC=$P(WVDGMST,U,2) ;mst status code
 .S WVDGMST=$P(WVDGMST,U,6) ;mst status text
 .S:WVDGMST="" WVDGMST="Unknown, not screened"
 .Q
 S WVMSTN=$S(WVDGMSTC="Y":1,WVDGMSTC="N":2,WVDGMSTC="D":3,WVDGMSTC="U":4,1:5)
 S WVMGRN=$$PERSON^WVUTL1(WVMGR) ;case manager name
 S WVNAME=$$NAME^WVUTL1(WVDFN) ;patient name
 S WVSSN=$$SSN^WVUTL1(WVDFN) ;patient ssn
 S WVCST=$$CST^WVUTL1A(WVDFN) ;Civilian Sexual Trauma
 S:WVCST="" WVCST="<no value>"
 S:'$D(WVDG(WVMSTN)) WVDG(WVMSTN)=WVDGMST
 S ^TMP($J,"WVST",WVMGRN,WVMGR,WVMSTN,WVNAME,WVDFN)=WVSSN_U_WVPROV_U_WVVET_U_WVEC_U_WVCST_U_WVDGMST
 Q
DEQUEUE ; WVE and WVMGR variables must be set.
 D START,EXIT
 Q
HELP1 ;EP
 ;;Answer "ONE" to list patients for ONE particular Case Manager.
 ;;Answer "ALL" to list patients for ALL Case Managers.
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
HELPTX ;EP
 ;---> CREATES DIR ARRAY FOR DIR.  REQUIRED VARIABLES: WVTAB,WVLINL.
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
