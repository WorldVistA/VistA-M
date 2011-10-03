RAUTL0 ;HISC/CAH,FPT,GJC-Utility Routine ;11/5/99  13:19
 ;;5.0;Radiology/Nuclear Medicine;**2,13,10,71**;Mar 16, 1998;Build 10
 ; 07/05/2006 BAY/KAM Remedy Call 124379 Patch RA*5*71
UPSTAT ;QUEUE ONE REPORT TO UPDATE STATUS
 ;07/05/2006 BAY/KAM/GJC If RAHLTCPB is defined, do not broadcast ORM messages. RAHLTCPB is referenced in UP2^RAUTL1
 ;which is called from UP1^RAUTL1
 N RAIO S RAIO=+$P($G(^RA(79,+RAMDIV,"RDEV")),"^") ; Resource Device?
 S ZTRTN="STAT^RAUTL0",ZTIO=$S(RAIO>0:$$GET1^DIQ(3.5,RAIO_",",.01),1:"")
 S ZTDTH=$H,ZTDESC="Rad/Nuc Med UPDATE STATUS OF ONE REPORT" S SDUZ=$G(RADUZ) S:'SDUZ SDUZ=DUZ F I="RAMDIV","RAMDV","RARPT","RAONLINE","RAAB","RAMLC","RAIMGTY","SDUZ" S ZTSAVE(I)=""
 S:$G(RADUZ) ZTSAVE("RADUZ")="" ;rpt may be verified by voice
 ; 07/05/2006 BAY/KAM Added next line
 S:$G(RAHLTCPB) ZTSAVE("RAHLTCPB")="" ;rpt v'fied by VR; do not broadcast ORM messages.
 D ^%ZTLOAD K SDUZ
 I $D(ZTSK),'$D(RAQUEUED) W !,?5,"Status update queued!",! R X:2
 Q
 ;
 ;Set off a series of actions as a result of report update:    ;ch
 ; patient loc updated in Rpt Distrib file #74.4
 ; can also cause rec to be added to file 74.4 (depending on category
 ;   of exam
 ; update status of exam if possible and do accompanying actions (such
 ;   as update of status log if specified in div params, notify OE/RR,
 ;   change order status if necessary, can also cause alerts to be
 ;   fired off)
STAT ;TASKMAN ENTRY POINT TO UPDATE STATUS OF ONE REPORT
 N RASAVE ; array to save off RADFN, RADTI & RACNI
 S RAF1=1,Y=RARPT D RASET^RAUTL2,UP1^RAUTL1,STUFF^RARTST
 S RASAVE("RADFN")=RADFN,RASAVE("RADTI")=RADTI,RASAVE("RACNI")=RACNI
 S:$$ORVR^RAORDU()=2.5 ORVP=RADFN_";DPT(",ORBXDATA=RARPT
 S RAEXFLD="ALL",D0=RARPT
 D ^RARTFLDS,OENOTE^RAUTL00 ; OENOTE replaces STAT1
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
UPSTATM ;QUEUE MULTIPLE REPORTS TO UPDATE STATUSES
 N RAIO S RAIO=+$P($G(^RA(79,+RAMDIV,"RDEV")),"^") ; Resource Device?
 S ZTRTN="STATM^RAUTL0",ZTIO=$S(RAIO>0:$$GET1^DIQ(3.5,RAIO_",",.01),1:"")
 S ZTDTH=$H,ZTDESC="Rad/Nuc Med UPDATE STATUSES OF MULTIPLE REPORTS" S SDUZ=$G(RADUZ) S:'SDUZ SDUZ=DUZ F I="^TMP($J,""RA"",""DT"",","RAMDV","RAMDIV","RAONLINE","RAMLC","RAIMGTY","SDUZ" S ZTSAVE(I)=""
 D ^%ZTLOAD K SDUZ I $D(ZTSK) W !,?5,"Status updates queued!",!
 Q
 ;
STATM ;TASKMAN ENTRY POINT TO UPDATE STATUSES OF MULTIPLE REPORTS
 S RAF1=1 F RARTDT=0:0 S RARTDT=$O(^TMP($J,"RA","DT",RARTDT)) Q:RARTDT'>0  F RA1=0:0 S RA1=$O(^TMP($J,"RA","DT",RARTDT,RA1)) Q:RA1'>0  S (RARPT,Y)=RA1 D RASET^RAUTL2,UP1^RAUTL1,STUFF^RARTST,STATM1
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
STATM1 ; Update statuses of multiple reports
 N RASAVE ; array to save off RADFN, RADTI & RACNI
 S:^TMP($J,"RA","DT",RARTDT,RA1) RAAB=1
 S RASAVE("RADFN")=RADFN,RASAVE("RADTI")=RADTI,RASAVE("RACNI")=RACNI
 S:$$ORVR^RAORDU()=2.5 ORVP=RADFN_";DPT(",ORBXDATA=RARPT
 S RAEXFLD="ALL",D0=RARPT D ^RARTFLDS
 D OENOTE^RAUTL00 K RAAB,ORIFN,ORNOTE
 Q
 ;
EN ;Entry point to credit x-ray clinic stops
 I $$PCE^RAWORK Q
 S RASDC="" I '$D(RAMDIV)!'$D(RADTE)!'$D(RADFN)!'$D(RAPRIT)!'$D(RAMLC) G NOGO
 S SDIV=RAMDIV,SDATE=$P(RADTE,"."),DFN=RADFN,SDC="",SDMSG="S"
 G NOGO:'$D(^RAMIS(71,+RAPRIT,0)) S X=+$P(^(0),"^",9)
 S X=$S(X="":"",1:$P($$NAMCODE^RACPTMSC(X,DT),"^"))
 I X S X1=$S($D(^RA(79.1,+RAMLC,"PC")):^("PC"),1:"") G NOGO:'X1 S SDCPT(1)="900^"_X1_"^"_X
 I $O(^RAMIS(71,RAPRIT,"STOP",0)) F I=0:0 S I=$O(^RAMIS(71,RAPRIT,"STOP",I)) Q:I'>0  I $D(^RAMIS(71,RAPRIT,"STOP",I,0)) S J=+^(0) D CON
 S SDCTYPE=$S($D(SDCPT(1)):"B",1:"S") W:'$D(ZTQUEUED) !!?5,"Attempting to credit a clinic stop.",! D EN3^SDACS I SDERR=1 G NOGO
 S $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",24)="Y" W:'$D(ZTQUEUED) !?5,"Clinic Stop credited." G EXIT
 ;
CON S K=$S($D(^DIC(40.7,+J,0)):$P(^(0),"^",2),1:"") I K S:SDC'[K SDC=K_"^"_SDC S RASDC=SDC
 Q
 ;
NOGO W:'$D(ZTQUEUED) *7,!?5,"Unable to credit a clinic stop!",!
 I $D(RASDC),($D(DUZ)#2),($D(RADFN)),($D(RADTI)),($D(RACNI)) D
 . D STPCDE(RASDC,DUZ,RADFN,RADTI,RACNI) ; Stop Code Error bulletin
 . Q
EXIT K I,J,K,RAPR,RASDC,SDC,SDCPT,SDCTYPE,SDERR,SDATE,SDIV,X,X1 Q
 ;
STPCDE(RA0,RA1,RA2,RA3,RA4) ; Bulletin for Stop Code Credit error
 ; RA0 -> stop code numbers seperated by "^"'s (if not null)
 ; RA1 -> Rad/Nuc Med user (DUZ)     RA2 -> Patient   (RADFN)
 ; RA3 -> Inverse Xam D/T  (RADTI)   RA4 -> Exam node (RACNI)
 Q:'$D(^VA(200,RA1,0))#2  ; invalid user info
 Q:'$D(^RADPT(RA2,"DT",RA3,"P",RA4,0))#2  ; exam info incomplete
 N RACASE,RADFN,RACPT,RALENFLG,RAI,RAPAT,RAPROC,RAREGX,RASSN,RASTOP
 N RAUSER,RAXAM,RAXDT,XMB S RALENFLG=0
 S RAUSER=$P($G(^VA(200,RA1,0)),"^"),RADFN=RA2
 S RASSN=$$SSN^RAUTL(),RAREGX=$G(^RADPT(RA2,"DT",RA3,0))
 S RAXAM=$G(^RADPT(RA2,"DT",RA3,"P",RA4,0)),RACASE=$P(RAXAM,"^")
 S RAXDT=$P(RAREGX,"^"),RAPAT=$P($G(^DPT(RA2,0)),"^")
 S RAPROC(0)=$G(^RAMIS(71,+$P(RAXAM,"^",2),0))
 ;S RACPT(0)=$G(^ICPT(+$P(RAPROC(0),"^",9),0)),RACPT=$P(RACPT(0),"^")
 ;S RACPT(4)=+$P(RACPT(0),"^",4),RACPT=$S(RACPT]"":RACPT,1:"Unknown")
 ;I RACPT(4),(RACPT]"") S RACPT=RACPT_" (invalid)"
 S RACPT(0)=+$P(RAPROC(0),"^",9) ;ien to file 81
 S RACPT=$P($$NAMCODE^RACPTMSC(RACPT(0),RAXDT),"^") ;.01 value file 81
 S RACPT(4)=$$ACTCODE^RACPTMSC(RACPT(0),RAXDT) ;1=active,0=inactive
 I RACPT']"" S RACPT="Unknown"
 I 'RACPT(4),(RACPT'="Unknown") S RACPT=RACPT_" (invalid)"
 S RAPROC=$E($P(RAPROC(0),"^"),1,45)
 S RAPROC=$S(RAPROC]"":RAPROC,1:"Unknown")
 I RA0']""!(RA0?1."^") D
 . N RAPC S RAPC=+$P($G(^RA(79.1,+RAMLC,"PC")),"^")
 . S:RAPC RASTOP="Missing STOP CODE data"
 . S:'RAPC RASTOP="No Principal Clinic entered for '"_$P($G(^SC(+$P($G(^RA(79.1,+RAMLC,0)),"^"),0)),"^")_"'."
 . Q
 E  D
 . S RASTOP="" F RAI=1:1:$L(RA0,"^") D  Q:RALENFLG
 .. S RASTOP(2)=$P(RA0,"^",RAI) Q:RASTOP(2)']""
 .. S RASTOP(1)=$P($G(^DIC(40.7,+$O(^DIC(40.7,"C",RASTOP(2),0)),0)),"^")
 .. S RASTOP(3)=RASTOP(2)_" "_RASTOP(1)_",  "
 .. I ($L(RASTOP)+$L(RASTOP(3)))>512 S RALENFLG=1 Q:RALENFLG
 .. S RASTOP=RASTOP_RASTOP(3)
 .. Q
 . I $P(RASTOP,",  ",$L(RASTOP,",  "))']"" D
 .. S RASTOP=$P(RASTOP,",  ",1,$L(RASTOP,",  ")-1)
 .. Q
 . Q
 ; XMB(1) -> Full patient name          XMB(2) -> patient SSN
 ; XMB(3) -> Examination Date           XMB(4) -> Case Number
 ; XMB(5) -> Procedure                  XMB(6) -> CPT Code
 ; XMB(7) -> Stop Code(s)               XMB(8) -> Rad/Nuc Med user
 S XMB(1)=RAPAT,XMB(2)=RASSN,XMB(3)=$$FMTE^XLFDT(RAXDT),XMB(4)=RACASE
 S XMB(5)=RAPROC,XMB(6)=RACPT,XMB(7)=RASTOP,XMB(8)=RAUSER
 S XMB="RAD/NUC MED CREDIT STOP ERROR"
 D ^XMB:$D(^XMB(3.6,"B",XMB))
 K XMB0,XMC0,XMDT,XMM,XMMG
 Q
