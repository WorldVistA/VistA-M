ORLPREML ;ISP/LMT - List Manager CPRS Team List from a Reminder Patient List ;11/13/17  12:55
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**377**;Dec 17, 1997;Build 582
 ;
 ;
EN ; -- main entry point for ORLP TEAM LIST FROM REM
 D EN^VALM("ORLP TEAM LIST FROM REM")
 Q
 ;
HDR ; -- header code
 ;
 ; ZEXCEPT: VALMHDR
 N ORTASK
 ;
 S ORTASK=$$GETTASK
 I ORTASK="" D  Q
 . S VALMHDR(1)=" << Option ORLP TEAM LIST FROM REM is not scheduled in TaskMan! >>"
 ;
 S VALMHDR(1)=" << Option ORLP TEAM LIST FROM REM is next scheduled to run: "_$$FMTE^XLFDT($P(ORTASK,U,2),"2M")_". >>"
 ;
 Q
 ;
INIT ; -- init variables and list array
 ;
 ; ZEXCEPT: VALMAR,VALMCNT
 N ORCNT,ORDIV,ORENT,ORENTCNT,ORENTNM,ORFREQ,ORLASTRUN,ORLASTUPD,ORLINE,ORLINEVAR,ORLST
 N ORLSTNM,ORNEXTRUN,ORNODE,OROVER,ORREM,ORREMNM
 ;
 K ^TMP("ORLPREM",$J)
 K ^TMP("ORLPREM-MAP",$J)
 ;
 D GETAPARS("E")
 ;
 S ORCNT=0
 S ORLINE=0
 ;
 I '$D(^TMP("ORLPREM",$J)) D
 . S ORLINE=ORLINE+1
 . S ORLINEVAR=""
 . S ORLINEVAR=$$SETFLD^VALM1(">> There are currently no mappings.",ORLINEVAR,"ERROR")
 . D SET^VALM10(ORLINE,ORLINEVAR)
 ;
 S ORREMNM=""
 F  S ORREMNM=$O(^TMP("ORLPREM",$J,ORREMNM)) Q:ORREMNM=""  D
 . S ORCNT=ORCNT+1
 . S ORREM=$G(^TMP("ORLPREM",$J,ORREMNM))
 . S ^TMP("ORLPREM-MAP",$J,ORCNT)=ORREM
 . S ORLASTRUN=$$GETLAST(ORREM)
 . S ORFREQ=$$GETFREQ(ORREM)
 . S OROVER=$$GETOVER(ORREM)
 . S OROVER=$S(OROVER=0:"NO",1:"YES")
 . ;
 . S ORENTCNT=0
 . S ORENT=""
 . F  S ORENT=$O(^TMP("ORLPREM",$J,ORREMNM,ORENT)) Q:ORENT=""  D
 . . S ORENTCNT=ORENTCNT+1
 . . S ORNODE=$G(^TMP("ORLPREM",$J,ORREMNM,ORENT))
 . . S ORLST=$P(ORNODE,U,1)
 . . S ORLSTNM=$P(ORNODE,U,2)
 . . I ORENT="SYS",ORENTCNT=1 S ORDIV="All"
 . . I ORENT="SYS",ORENTCNT'=1 S ORDIV="Catch-All"
 . . I ORENT S ORDIV=$$STA^XUAF4(ORENT)
 . . ;
 . . S ORLINE=ORLINE+1
 . . S ORLINEVAR=""
 . . I ORENTCNT=1 D
 . . . S ORLINEVAR=$$SETFLD^VALM1(ORCNT,ORLINEVAR,"NUM")
 . . . S ORLINEVAR=$$SETFLD^VALM1(ORREMNM,ORLINEVAR,"REM")
 . . . S ORLINEVAR=$$SETFLD^VALM1($$FMTE^XLFDT(ORLASTRUN,"2M"),ORLINEVAR,"LASTRUN")
 . . . S ORLINEVAR=$$SETFLD^VALM1(ORFREQ_$S(ORFREQ:"D",1:""),ORLINEVAR,"FREQ")
 . . ;
 . . S ORLINEVAR=$$SETFLD^VALM1(ORDIV,ORLINEVAR,"DIV")
 . . S ORLINEVAR=$$SETFLD^VALM1(ORLSTNM,ORLINEVAR,"LIST")
 . . S ORLASTUPD=$$LASTUPD(ORLST)
 . . S ORLASTUPD=$$FMTE^XLFDT(ORLASTUPD,"2M")
 . . S ORLINEVAR=$$SETFLD^VALM1(ORLASTUPD,ORLINEVAR,"LASTUPD")
 . . I ORENTCNT=1 D
 . . . S ORNEXTRUN=$P($$GETSCHED(ORREM),U,3)
 . . . I ORNEXTRUN S ORNEXTRUN=$$FMTE^XLFDT(ORNEXTRUN,"2M")
 . . . S ORLINEVAR=$$SETFLD^VALM1(ORNEXTRUN,ORLINEVAR,"NEXTRUN")
 . . . S ORLINEVAR=$$SETFLD^VALM1(OROVER,ORLINEVAR,"OVER")
 . . D SET^VALM10(ORLINE,ORLINEVAR,ORCNT)
 ;
 S VALMCNT=ORLINE
 ;
 K ^TMP("ORLPREM",$J)
 ;
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 K ^TMP("ORLPREM-MAP",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
KEYS ;
 ;
 ; ZEXCEPT: XQORM
 N ORI,ORPROT
 ;
 K XQORM("KEY") ;TODO - IS THIS NECESSARY?
 S ORPROT=$O(^ORD(101,"B","ORLPREM EDIT ENTRY",0))
 I 'ORPROT Q
 ;
 S ORI=0
 F  S ORI=$O(^TMP("ORLPREM-MAP",$J,ORI)) Q:'ORI  D
 . S XQORM("KEY",ORI)=ORPROT_"^1"
 ;
 Q
 ;
SELECT(ORACTION) ;
 ;
 ; ZEXCEPT: XQORNOD
 N DIR,DIRUT,ORREM,X,Y
 ;
 D FULL^VALM1
 ;
 I '$O(^TMP("ORLPREM-MAP",$J,0)) D  Q 0
 . W !,"There are no items to "_ORACTION_".",!
 . H 5
 ;
 S Y=+$P(XQORNOD(0),"^",3)
 ;
 I 'Y D
 . S DIR(0)="NO^1:"_$O(^TMP("ORLPREM-MAP",$J,""),-1)_":0"
 . S DIR("A")="Select Entry"
 . D ^DIR
 I $D(DIRUT) Q 0
 I Y'>0 Q 0
 ;
 S ORREM=$G(^TMP("ORLPREM-MAP",$J,Y))
 I 'ORREM D  Q 0
 . W !,"This entry does not have a list rule mapping to "_ORACTION_".",!
 . H 5
 ;
 Q ORREM
 ;
ADDENT ; Add an Entry
 ;
 D FULL^VALM1
 ;
 D PAR
 ;
 ;I $G(VALMAR)'="" K @VALMAR
 D REFRESH
 ;
 Q
 ;
EDITENT ; Edit an Entry
 ;
 N ORREM
 ;
 S ORREM=$$SELECT("edit")
 I 'ORREM Q
 ;
 D PAR(ORREM)
 ;
 D REFRESH
 ;
 Q
 ;
DELENT ; Delete an Entry
 ;
 ; ZEXCEPT: XQORNOD
 N DIR,DIRUT,ORENT,ORLST,ORREM,X,Y
 ;
 S ORREM=$$SELECT("delete")
 I 'ORREM Q
 ;
 S DIR(0)="Y"
 S DIR("A")="Are you sure you want to delete the mappings for "_$P($G(^PXRM(810.4,+ORREM,0)),U,1)
 S DIR("?",1)="If you select 'Yes', it will delete the team list mappings and defined"
 S DIR("?")="frequency for this reminder list rule."
 S DIR("B")="NO"
 D ^DIR
 I $G(DIRUT)!(Y'=1) Q
 ;
 D DEL^XPAR("SYS","ORLP TEAM LIST FROM REM FREQ","`"_ORREM)
 D DEL^XPAR("SYS","ORLP TEAM LIST FROM REM OVER","`"_ORREM)
 ;
 D GETPARS(.ORLST,ORREM)
 S ORENT=""
 F  S ORENT=$O(ORLST(ORENT)) Q:ORENT=""  D
 . I ORENT="SYS" D  Q
 . . D DEL^XPAR("SYS","ORLP TEAM LIST FROM REM","`"_ORREM)
 . I ORENT D  Q
 . . D DEL^XPAR(ORENT_";DIC(4,","ORLP TEAM LIST FROM REM","`"_ORREM)
 ;
 D REFRESH
 ;
 Q
 ;
RUNNOW ; Run one of the List Rules now
 ;
 N DIR,DIRUT,ORARR,ORLSTMAP,ORREM,ORREMNM,ORTSK,ORVAR,X,Y
 ;
 D FULL^VALM1
 ;
 I '$O(^TMP("ORLPREM-MAP",$J,0)) D  Q
 . W !,"There are no items to select from.",!
 . H 5
 ;
 S DIR(0)="NO^1:"_$O(^TMP("ORLPREM-MAP",$J,""),-1)_":0"
 S DIR("A")="Select Entry"
 D ^DIR
 I $D(DIRUT) Q
 I Y'>0 Q
 ;
 S ORREM=$G(^TMP("ORLPREM-MAP",$J,Y))
 I 'ORREM D  Q
 . W !,"This entry does not have a list rule mapping to run.",!
 . H 5
 ;
 D GETPARS^ORLPREML(.ORLSTMAP,ORREM)
 I '$D(ORLSTMAP) D  Q
 . W !,"This entry is not mapped to any Team Lists.",!
 . H 5
 ;
 S ORREMNM=$P($G(^PXRM(810.4,+ORREM,0)),U,1)
 ;
 K DIR,Y,X
 S DIR(0)="Y"
 S DIR("B")="NO"
 S DIR("A")="Do you want to run "_ORREMNM_" now"
 D ^DIR
 I $D(DIRUT) Q
 I Y'=1 Q
 ;
 D EN^XPAR("SYS","ORLP TEAM LIST FROM REM LAST","`"_ORREM,"@")
 S ORVAR="ORREM;ORLSTMAP("
 S ORARR("ZTDTH")=$H
 S ORTSK=$$NODEV^XUTMDEVQ("ENONE^ORLPREM","Run List Rule to Update Team List",ORVAR,.ORARR,0)
 W !!,"Task #"_ORTSK_" queued.",!!
 H 2
 ;
 D REFRESH
 ;
 Q
 ;
REFRESH ; Refresh List
 D CLEAN^VALM10
 D INIT
 Q
 ;
ENPAR ; Configure paramaters - loop till exit
 ;
 N ORPAR
 ;
 S ORPAR=""
 F  D  Q:ORPAR<0
 . S ORPAR=$$PAR
 ;
 Q
 ;
PAR(ORREM) ; configure paramaters. Add/Edit Entry
 ;
 N ORFILTER,ORFLAG,ORFREQ,OROVER,ORPARDEF,ORPARS,ORREQ
 ;
 I '$G(ORREM) S ORREM=$$SELREM
 I ORREM<1 Q -1
 ;
 S ORPARDEF=$$GETPARS(.ORPARS,ORREM)
 ;
 S ORFILTER=0
 I ORPARDEF=2 S ORFILTER=1
 ; ask if nothing already set for list rule
 I ORPARDEF<1 S ORFILTER=$$SELFLTR
 I ORFILTER<0!(ORFILTER="") Q ORFILTER
 ;
 S ORFLAG=1
 W !
 ;
 I ORFILTER D
 . W !!,?3,">> First, you will need to select a team list to be used in cases"
 . W !,?3,">> where it cannot be determined which division a patient belongs to."
 . W !
 . S ORREQ=0
 . I ORPARDEF=2 S ORREQ=1
 . S ORFLAG=$$PARSYS(ORREM,.ORPARS,ORREQ)
 . I ORFLAG<1 Q
 . ;
 . W !!,?3,">> Now, you can select the team lists to be used for each division."
 . S ORFLAG=$$PARDIV(ORREM,.ORPARS)
 ;
 I 'ORFILTER S ORFLAG=$$PARSYS(ORREM,.ORPARS)
 ;
 K ORPARS
 S ORPARDEF=$$GETPARS(.ORPARS,ORREM)
 I ORPARDEF D
 . S ORFREQ=$$SELFREQ(ORREM)
 . I ORFREQ<0 S ORFLAG=-1 Q
 . S OROVER=$$SELOVER(ORREM)
 . I OROVER<0 S ORFLAG=-1 Q
 . W !
 ;I 'ORPARDEF D
 ;. D EN^XPAR("SYS","ORLP TEAM LIST FROM REM FREQ","`"_ORREM,"@",.ORERR)
 ;
 Q ORFLAG
 ;
PARDIV(ORREM,ORPARS) ; Configure ORLP TEAM LIST FROM REM at the div level
 ;
 N ORDIV,ORERR,ORFLAG,ORLST,ORLSTSCR
 ;
 S ORFLAG=1
 S ORDIV=""
 S ORLST=""
 D LSTSCR(.ORLSTSCR,ORREM)
 ;
 F  D  Q:((ORDIV<1)!(ORLST<1))
 . W !
 . S ORDIV=$$SELDIV
 . I ORDIV<1 Q
 . S ORLST=$G(ORPARS(ORDIV))
 . S ORLST=$$SELLST(ORLST,.ORLSTSCR)
 . I $G(ORPARS(ORDIV)),'ORLST S ORLST="@"
 . I ORLST<1,ORLST'="@" Q
 . D EN^XPAR(ORDIV_";DIC(4,","ORLP TEAM LIST FROM REM","`"_ORREM,$S(ORLST="@":"",1:"`")_ORLST,.ORERR)
 . I $P($G(ORERR),U,2)'="" W !,"Error: "_$P(ORERR,U,2),!
 ;
 I ((ORDIV<0)!(ORLST<0)) S ORFLAG=-1
 ;
 Q ORFLAG
 ;
PARSYS(ORREM,ORPARS,ORREQ) ; Configure ORLP TEAM LIST FROM REM at the sys level
 ;
 N ORERR,ORFLAG,ORLST,ORLSTSCR
 ;
 S ORFLAG=1
 D LSTSCR(.ORLSTSCR,ORREM)
 ;
 S ORLST=$G(ORPARS("SYS"))
 S ORLST=$$SELLST(ORLST,.ORLSTSCR,$G(ORREQ))
 I $G(ORPARS("SYS")),'ORLST S ORLST="@"
 I ORLST<1,ORLST'="@" Q ORLST
 D EN^XPAR("SYS","ORLP TEAM LIST FROM REM","`"_ORREM,$S(ORLST="@":"",1:"`")_ORLST,.ORERR)
 I $P($G(ORERR),U,2)'="" W !,"Error: "_$P(ORERR,U,2),!
 ;
 I ORLST<0 S ORFLAG=-1
 ;
 Q ORFLAG
 ;
SELFLTR() ; Ask user if they want to filter by div
 ;
 N DIR,DIRUT,ORFILTER,X,Y
 ;
 W !
 S DIR(0)="YO"
 S DIR("B")="NO"
 S DIR("A")="Do you want to filter patients by Division"
 S DIR("?",1)="If you want to filter the patients by division, for example, to have patients"
 S DIR("?",2)="from division A added to one team list and patients from division B"
 S DIR("?")="added to another team list, enter YES."
 D ^DIR
 I $D(DIRUT) Q -1
 S ORFILTER=Y
 W !
 ;
 Q ORFILTER
 ;
SELDIV() ; prompt for div
 ;
 N DIC,DINUM,DLAYGO,DTOUT,DUOUT,ORDIV,X,Y
 ;
 S ORDIV=""
 ;
 S DIC=4
 S DIC(0)="AEMNQO"
 S DIC("A")="Select DIVISION: "
 D ^DIC
 I $D(DTOUT)!($D(DUOUT)) Q -1
 S ORDIV=+Y
 I ORDIV<0 S ORDIV=""
 ;
 Q ORDIV
 ;
SELREM() ; prompt for reminder list rule
 ;
 N DIC,DINUM,DLAYGO,DTOUT,DUOUT,ORREM,X,Y
 ;
 S DIC=810.4
 S DIC(0)="AEMNQO"
 S DIC("S")="I $P(^(0),U,3)=3"
 D ^DIC
 I $D(DTOUT)!($D(DUOUT)) Q -1
 S ORREM=+Y
 I ORREM<0 S ORREM=""
 ;
 Q ORREM
 ;
SELLST(ORDEF,ORLSTSCR,ORREQ) ; prompt for OE/RR List
 ;
 ; ORDEF = Default 100.21 Entry
 ; ORLSTSCR = don't allow user to select entries in this array
 ; ORREQ = Should user be forced to select an entry
 ;
 N DIR,DIRUT,DTOUT,DUOUT,ORLST,X,Y
 ;
 S DIR(0)="PO^100.21:QEM"
 I $G(ORREQ) S DIR(0)="P^100.21:QEM"
 I $G(ORDEF) S DIR("B")=$P($G(^OR(100.21,ORDEF,0)),U,1)
 S DIR("S")="I '$D(ORLSTSCR(Y))"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 S ORLST=+Y
 I ORLST<0 S ORLST=""
 ;
 Q ORLST
 ;
LSTSCR(ORRET,ORREM) ; return array of 100.21 entries that should be used for screening
 ;
 N ORENT,ORLST,ORPARS,ORREM2
 ;
 D ENVAL^XPAR(.ORPARS,"ORLP TEAM LIST FROM REM")
 S ORENT=""
 F  S ORENT=$O(ORPARS(ORENT)) Q:ORENT=""  D
 . S ORREM2=0
 . F  S ORREM2=$O(ORPARS(ORENT,ORREM2)) Q:'ORREM2  D
 . . I ORREM=ORREM2 Q
 . . S ORLST=$G(ORPARS(ORENT,ORREM2))
 . . I ORLST="" Q
 . . I '$D(^OR(100.21,ORLST)) Q
 . . S ORRET(ORLST)=""
 ;
 Q
 ;
SELFREQ(ORREM) ; Configure ORLP TEAM LIST FROM REM FREQ
 ;
 N DIR,DIRUT,DTOUT,DUOUT,ORFREQ,ORERR,X,Y
 ;
 S ORFREQ=$$GET^XPAR("SYS","ORLP TEAM LIST FROM REM FREQ","`"_ORREM)
 ;
 W !
 ;
 S DIR(0)="NO^1:365:0"
 I ORFREQ>0 S DIR("B")=ORFREQ
 S DIR("A")="Enter the frequency (in days) the team list should be updated"
 S DIR("?",1)="Enter how often (in days) the reminder list rule should run"
 S DIR("?")="in order to update the team list"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 S ORFREQ=Y
 ;
 I ORFREQ>0!(ORFREQ="") D
 . D EN^XPAR("SYS","ORLP TEAM LIST FROM REM FREQ","`"_ORREM,$S(ORFREQ="":"@",1:ORFREQ),.ORERR)
 . ;I $P($G(ORERR),U,2)'="" W !,"Error: "_$P(ORERR,U,2),!
 ;
 Q ORFREQ
 ;
SELOVER(ORREM) ; Configure ORLP TEAM LIST FROM REM OVER
 ;
 N DIR,DIRUT,DTOUT,DUOUT,OROVER,ORERR,X,Y
 ;
 S OROVER=$$GET^XPAR("SYS","ORLP TEAM LIST FROM REM OVER","`"_ORREM)
 ;
 W !
 ;
 S DIR(0)="YO"
 S DIR("B")="YES"
 I OROVER'="" S DIR("B")=$S(OROVER=0:"NO",1:"YES")
 S DIR("A")="Should the Rem Patient List be overwritten when updating a Team List"
 S DIR("?",1)="Enter 'NO' if you want the previous Reminder Patient List not to be overwritten"
 S DIR("?")="when updating a Team List"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) Q -1
 S OROVER=Y
 ;
 I OROVER=1!(OROVER=0)!(OROVER="") D
 . D EN^XPAR("SYS","ORLP TEAM LIST FROM REM OVER","`"_ORREM,$S(OROVER="":"@",1:OROVER),.ORERR)
 . ;I $P($G(ORERR),U,2)'="" W !,"Error: "_$P(ORERR,U,2),!
 ;
 Q OROVER
 ;
GETPARS(ORRET,ORREM) ; Get team maapping for one list rule
 ;
 N ORLST,ORPAR,ORPARDEF,ORPARS
 ;
 S ORPARDEF=0
 ;
 D ENVAL^XPAR(.ORPARS,"ORLP TEAM LIST FROM REM","`"_ORREM)
 S ORPAR=""
 F  S ORPAR=$O(ORPARS(ORPAR)) Q:ORPAR=""  D
 . S ORLST=$G(ORPARS(ORPAR,ORREM))
 . I ORLST="" Q
 . I '$D(^OR(100.21,ORLST)) Q
 . I ORPAR[";DIC(4.2," D
 . . S ORRET("SYS")=ORLST
 . . I ORPARDEF'=2 S ORPARDEF=1
 . I ORPAR[";DIC(4," D
 . . S ORRET(+ORPAR)=ORLST
 . . S ORPARDEF=2
 ;
 Q ORPARDEF
 ;
GETAPARS(ORFORMAT) ; Get team maapping for all list rules
 ;
 N ORENT,ORENTNM,ORLST,ORLSTNM,ORPARS,ORREM,ORREMNM
 ;
 I $G(ORFORMAT)'="E" S ORFORMAT="I"
 ;
 D ENVAL^XPAR(.ORPARS,"ORLP TEAM LIST FROM REM")
 S ORENT=""
 F  S ORENT=$O(ORPARS(ORENT)) Q:ORENT=""  D
 . S ORREM=0
 . F  S ORREM=$O(ORPARS(ORENT,ORREM)) Q:'ORREM  D
 . . S ORREMNM=$P($G(^PXRM(810.4,+ORREM,0)),U,1)
 . . I ORREMNM="" Q  ;TODO - delete this par
 . . S ORLST=$G(ORPARS(ORENT,ORREM))
 . . S ORLSTNM=$P($G(^OR(100.21,+ORLST,0)),U,1)
 . . I ORLSTNM="" Q  ;TODO - delete this par
 . . I ORFORMAT="E" D
 . . . S ^TMP("ORLPREM",$J,ORREMNM)=ORREM
 . . S ORENTNM=""
 . . I ORENT[";DIC(4.2," D
 . . . S ORENTNM="SYS"
 . . I ORENT[";DIC(4," D
 . . . S ORENTNM=+ORENT
 . . I ORENTNM="" Q  ;TODO - delete this par
 . . I ORFORMAT="E" D
 . . . S ^TMP("ORLPREM",$J,ORREMNM,ORENTNM)=ORLST_U_ORLSTNM
 . . I ORFORMAT="I" D
 . . . S ^TMP("ORLPREM",$J,ORREM,ORENTNM)=ORLST
 ;
 Q
 ;
GETSCHED(ORREM) ;
 ;
 ; Returns: Last time the List rule was ran to update the OE/RR List
 ;          ^ Frequency (in days) that it runs
 ;          ^ Next scheduled run time
 ;
 N ORFREQ,ORLASTRUN,ORNEXTRUN,ORPARS,ORPARDEF,ORTASK,ORTASKDT
 ;
 S ORLASTRUN=$$GETLAST(ORREM)
 S ORFREQ=$$GETFREQ(ORREM)
 S ORNEXTRUN=""
 S ORTASK=$$GETTASK
 S ORTASKDT=$P(ORTASK,U,2)
 S ORPARDEF=$$GETPARS(.ORPARS,ORREM)
 I ORTASKDT,ORFREQ,ORPARDEF D
 . I 'ORLASTRUN D  Q
 . . S ORNEXTRUN=ORTASKDT
 . S ORNEXTRUN=$P(ORLASTRUN,".",1)_"."_$P(ORTASKDT,".",2)
 . S ORNEXTRUN=$$FMADD^XLFDT(ORNEXTRUN,ORFREQ)
 ;
 Q ORLASTRUN_U_ORFREQ_U_ORNEXTRUN
 ;
GETLAST(ORREM) ; returns ORLP TEAM LIST FROM REM LAST par
 Q $$GET^XPAR("SYS","ORLP TEAM LIST FROM REM LAST","`"_ORREM)
 ;
GETFREQ(ORREM) ; returns ORLP TEAM LIST FROM REM FREQ par
 Q $$GET^XPAR("SYS","ORLP TEAM LIST FROM REM FREQ","`"_ORREM)
 ;
GETOVER(ORREM) ; returns ORLP TEAM LIST FROM REM OVER par
 N OROVER
 S OROVER=$$GET^XPAR("SYS","ORLP TEAM LIST FROM REM OVER","`"_ORREM)
 I OROVER'=0 S OROVER=1
 Q OROVER
 ;
GETTASK() ;
 ;
 ; returns task number^scheduled time^reschedule freq^special queuing flag
 ; of ORLP TEAM LIST FROM REM task
 ;
 N ORLST,ORRET,ORX
 ;
 S ORRET=""
 D OPTSTAT^XUTMOPT("ORLP TEAM LIST FROM REM",.ORLST)
 S ORX=$O(ORLST(0))
 I ORX,$P($G(ORLST(ORX)),U,1)'="" D
 . S ORRET=$G(ORLST(ORX))
 ;
 Q ORRET
 ;
LASTUPD(ORLST) ; Returns Last Updated D/T (100.21, 12.1) for a given list
 Q $P($G(^OR(100.21,+$G(ORLST),12)),U,1)
