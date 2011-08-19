RART ;HISC/CAH,FPT,GJC AISC/MJK,TMP,RMO-Reporting Menu ;11/16/98  15:02
 ;;5.0;Radiology/Nuclear Medicine;**2,5,15,18,43,82,56,97**;Mar 16, 1998;Build 6
 ;Supported IA #1571 ^LEX(757.01
 ;Private IA #4793 CREATE^WVRALINK
 ;Supoprted IA #3544 ^VA(200,"ARC"
 ;;last modification by SS for P18 June 15, 2000
3 ;;Verify a Report
 N I5
 D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 I $D(RANOSCRN) S X=$$DIVLOC^RAUTL7() I X D Q QUIT
 G:$D(^VA(200,"ARC","S",DUZ))!($D(^XUSEC("RA VERIFY",DUZ))) 30
 G:$P(RAMDV,"^",18)=1 30
 G:'$D(^VA(200,"ARC","R",DUZ)) 30
 I $P(RAMDV,"^",18)'=1 W !!,$C(7),"Interpreting Residents are not allowed to verify reports." G Q
30 K RAUP S RAPGM=30,RAREPORT=1 D ^RACNLU G Q:X="^" I '$D(^RARPT(+RARPT,0)) W !!?2,$C(7),"No report available!" G 30
 S I5=$P(^RARPT(+RARPT,0),"^",5) I "^V^EF^"[("^"_I5_"^") W !!?2,$C(7),"Report already ",$S(I5="V":"verified",1:"electronically filed") G 30
SS1 Q:$$VERONLY^RAUTL11=-1  ;P18 case info 
31 S DIE("NO^")="",DA=RARPT,DR="[RA VERIFY REPORT ONLY]",DIE="^RARPT("
 S RAIMGTYI=$P($G(^RADPT(RADFN,"DT",RADTI,0)),U,2),RAIMGTYJ=$P($G(^RA(79.2,+RAIMGTYI,0)),U)
 I RAIMGTYJ']"" W !,"Error: Cannot determine imaging type of exam.",! K RAIMGTYI,RAIMGTYJ G @RAPGM
 ; must lock both report AND case together, so to ensure 
 ; that a verified report has the correct diagnostic codes
 S RAXIT=$$LOCK^RAUTL12(DIE,DA) ; lock Report
 I RAXIT K RAXIT G @RAPGM
 S RASAVDIE="^RADPT("_RADFN_",""DT"","_RADTI_",""P"",",RASAVDA(2)=RADFN,RASAVDA(1)=RADTI,RASAVDA=RACNI
 ; rpt exists & locked, thus no need to lock at "DT" level because users
 ; can only use 'report entry/edit' option to enter dx's for printsets
 S RAXIT=$$LOCK^RAUTL12(RASAVDIE,.RASAVDA) ; lock case before asking REPORT STATUS
 I RAXIT K RAXIT G @RAPGM
 D ^DIE K DE,DQ,DR D UNLOCK^RAUTL12(DIE,DA) ; unlock Report
 K DIE,RAXIT
 S X=+$O(^RA(72,"AA",RAIMGTYJ,9,0)),DA(2)=RADFN,DA(1)=RADTI,DA=RACNI,DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"","
 S DR=13_$S(RACT'="V":"",'$D(^RA(72,X,.1)):"",$P(^(.1),"^",5)'="Y":"",1:"R")_";I $D(^RA(78.3,+X,0)),$P(^(0),""^"",4)=""y"" S RAAB=1 "
 I RACT="V",($P($G(^RA(72,+X,.1)),"^",5)="Y") S DIE("NO^")="BACK"
 D ^DIE
 K DA,DE,DQ,DIE,DR
 I $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13)="" G UNL31
 S DR="50///"_RACN
 S DR(2,70.03)=13.1
 S DR(3,70.14)=.01_";I $D(^RA(78.3,+X,0)),$P(^(0),""^"",4)=""y"" S RAAB=1"
 S DA(1)=RADFN,DA=RADTI,DIE="^RADPT("_DA(1)_",""DT"","
 D ^DIE
UNL31 ; copy then unlock
 N:'$D(RAPRTSET) RAPRTSET N:'$D(RAMEMARR) RAMEMARR
 D EN2^RAUTL20(.RAMEMARR)
 I RAPRTSET S RADRS=1,RAXIT=0 D COPY^RARTE2 ; copy diagnoses
 D UNLOCK^RAUTL12(RASAVDIE,.RASAVDA) ; use params from PrimDiag's lock
 K RASAVDIE,RASAVDA
 K DA,DE,DQ,DIE,DR
32 K RAXIT
 I $G(RAPGM)="GETRPT^RARTVER" I $E(RACT'="V"),($P(^RARPT(RARPT,0),U,14)]"") D RETURN^RARTVER2
PACS I (RACT="V")!(RACT="R") D TASK^RAHLO4
 I "^V^EF^"[("^"_RACT_"^"),$T(CREATE^WVRALINK)]"" D CREATE^WVRALINK(RADFN,RADTI,RACNI) ;women's health
 ;
 I RAPGM="NXT^RABTCH1" G @RAPGM
TIME D:RACT="V"
 .N RAHLTCPB S RAHLTCPB=1 D UPSTAT^RAUTL0 K RAAB
 I $G(RARDX)="S" D
 . D SAVE^RARTVER2
 . I $G(RAPGM)="GETRPT^RARTVER" D
 .. ; for 'On-line Verifying of Reports' default device selection is the
 .. ; "REPORT PRINTER NAME"
 .. S %ZIS("B")=$P($G(RAMLC),"^",10) K:%ZIS("B")']"" %ZIS("B")
 .. Q
 . D Q^RARTR,RESTORE^RARTVER2
 . K:$D(%ZIS("B")) %ZIS("B")
 . Q
 G @RAPGM
Q K %,%DT,%X,C,D,D0,D1,DA,DIC,RACN,RACNI,RACT,RADATE,RADFN,RADTE,RADTI,RADUZ,RAHEAD,RAI,RAIMGTYI,RAIMGTYJ,RANME,RANUM,RAOR,RAPGM,RAPRC,RAQUIT,RAREPORT,RARPT,RASET,RASN,RASSN,RAST,RASTI,RAUP,RAVER,X,Y,^TMP($J,"RAEX")
 K %W,%Y,%Y1,DDER,DI,DIROUT,DIRUT,DLAYGO,DTOUT,DUOUT,RACI,ZTSK,POP,DDH
 Q
OERR1 ; Jump to 'OERR1^RART1' This is necessary to support the reference to
 ; this line label in the OE/RR Notifications file.
 G OERR1^RART1 Q
 ;
PRTDX ; print dx codes on report display (called from RART1)
 N RATMP
 K RAFLG D WAIT^RART1:($Y+6)>IOSL&('$D(RARTVERF))
 Q:X="^"!(X="T")!(X="P")
 S RADXCODE=$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13)
 W !?3,"Primary Diagnostic Code: ",!?2,$S($D(^RA(78.3,+RADXCODE,0)):$P(^(0),U,1),1:"") K RAFLG
 S RATMP=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+RADXCODE,0)),U,6),.01)
 W:RATMP]"" " (",RATMP,")"
 D WAIT^RART1:($Y+6)>IOSL&('$D(RARTVERF)) Q:X="^"!(X="T")!(X="P")
 I '$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0)) W ! Q
 W !!?3,"Secondary Diagnostic Codes: "
 S RADXCODE=0
 F  S RADXCODE=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX","B",RADXCODE)) Q:RADXCODE'>0!('$D(^RA(78.3,+RADXCODE,0)))!($D(RAOOUT))  K RAFLG D WAIT^RART1:($Y+6)>IOSL&('$D(RARTVERF)) Q:X="^"!(X="T")!(X="P")  D
 . W !?2,$P(^RA(78.3,RADXCODE,0),U,1)
 . S RATMP=$$GET1^DIQ(757.01,$P($G(^RA(78.3,+RADXCODE,0)),U,6),.01)
 . W:RATMP]"" " (",RATMP,")"
 W !
 Q
EXIT ; Kill variables created when user prints 'Abnormal Rad/Nuc Med Report
 ; Alert'.  Variables are created when 'PRT^RARTR' is called.
 K %X,%XX,%Y,%YY,A,DDER,DFN,DI,DIR,DIW,DIWI,DIWT,DIWTC,DIWX,DLAYGO
 K DN,RACI,RACN0,RACPT,RACPTNDE,RADTE0,RADTV,RAN,RAOBR4,RAPRCNDE
 K RAPROC,RAPROCIT,RAPRV,RARPT0,VA,VADM,VAERR,X2,ZTSK
 Q
