PSODEART ;FO-OAKAND/REM - EPCS Utilities and Reports; [5/7/02 5:53am] ;10/5/21  09:42
 ;;7.0;OUTPATIENT PHARMACY;**667**;DEC 1997;Build 18
 ;External reference to KEYS sub-file (#200.051) is supported by DBIA 7054
 ;
 Q
 ;
PRESCBR(PSOSD0) ;called from print option - PSO EPCS PRIVS
 ;PSOSD0 is D0
 ; screening for prescribers with DEA# or VA#
 N PSOSPS
 S PSOSPS=$G(^VA(200,PSOSD0,"PS"))
 ;Q:($$PRDEA^XUSER(PSOSD0))!($P(PSOSPS,U,3)'="") 1
 Q 0
 ;
PRIVS(PSOSD0) ;called from print option - PSO EPCS PRIVS 
 ;PSOSD0 is D0
 ;user with controlled substance privileges? 
 ;based on 6 sub-schedules, PS3 node, pieces 1-6
 N PSOSPS3
 ;S PSOSPS3=$$PRSCH^XUSER(PSOSD0)
 Q:($P(PSOSPS3,U,1,6)[1) 1 ; yes, if at least one explicit Yes
 Q:($P(PSOSPS3,U,1,6)[0) 0 ; no, if explicit No
 Q 1 ; default, when all NULL
 ;
XT30(PSOSD0,ACT) ;called from print option - PSO EPCS XDATE EXPIRES
 ;chk user ACTIVE,with DEA# and xdate expires in 30 days
 ;PSOSD0=IEN, ACT=(1 or 0) active user of not
 N XDT,DT30,DEA,CNT
 S CNT=0
 ;S XDT=$$PRXDT^XUSER(PSOSD0),DT30=$$FMADD^XLFDT(DT,30),DEA=$$PRDEA^XUSER(PSOSD0)
 I (DEA'=""),(XDT'>DT30),(XDT'<DT) S CNT=CNT+1
 I ACT D
 .I $$ACTIVE^XUSER(PSOSD0) S CNT=CNT+1
 I 'ACT D
 .I '$$ACTIVE^XUSER(PSOSD0) S CNT=CNT+1
 I CNT=2 Q 1
 Q 0
 ;
RPT1 ;ePCS report - setting or modifing to logical access controls.
 ;called from option - PSO EPCS LOGICAL ACCESS
 ;Only runs if data has changed from previous day.
 ;FLG=records exist for previous day.
 ;Generate report & Mail message to PSDMGR key holders
 N BDT,LD,EDT,FLG,DEV,FN,PSONS,ZPR,FSP,RHD,RT,PSORPT,OPT,X1,X2,FE S PSORPT=1 D INIT
 D NOW^%DTC S X1=X,X2="-1" D C^%DTC S (BDT,LD)=X,EDT=X_".999999" ;Get the previous day date
 F  S LD=$O(^XTV(FN,"DT",LD)) Q:LD=""!(FLG=1)  D
 . S:LD<EDT FLG=1
 D:$G(ZPR) AUTPRT D GMAIL
EXIT K ^TMP(PSONS,$J),^XTMP(PSONS,$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
RPT2 ;ePCS report - allocation history for PSDRPH key
 ;called from option - PSO DEA PSDRPH AUDIT
 ;Only runs if data has changed from previous day.
 ;FLG=records exist for previous day
 ;Generate report & Mail message to PSDMGR key holders
 N BDT,ST,EDT,FLG,DEV,FN,PSONS,ZPR,RHD,RT,PSORPT,OPT,X1,X2,FE S PSORPT=2 D INIT Q:'FN
 D NOW^%DTC S X1=X,X2="-1" D C^%DTC S (BDT,ST)=X,EDT=X_".999999" ;Get the previous day date
 F  S ST=$O(^XTV(FN,"DT",ST)) Q:ST=""!(FLG=1)  D
 . S:ST<EDT FLG=1
 D:$G(ZPR) AUTPRT D GMAIL
 D EXIT
 Q
 ;
PSDKEY ;Allocated/de-allocate the PSDRPH key option
 ;called from option - PSO EPCS PSDRPH KEY
 N PSOBOSS,PSODA,PSOKEY,PSORET,PSONAME,PSONS,OK,NOW,IEN,MSG,INPUT,NOW,DA
 S PSOKEY=$$LKUP^XPDKEY("PSDRPH")
 I PSOKEY="" W !,"PSDRPH key does not exist" Q
 S PSOBOSS=0
 ;PSDRPH KEY check - delegate & holders
 S PSONS=$$GET1^DIQ(200.052,PSOKEY_","_DUZ_",",".01","",,"MSG")
 S:PSONS="PSDRPH" PSOBOSS=2 K PSONS,MSG
 S:(DUZ(0)["@"!($D(^XUSEC("XUMGR",DUZ)))!($D(^XUSEC("PSDRPH",DUZ)))) PSOBOSS=1
 I 'PSOBOSS W !,"You don't have privileges.  See your package coordinator or site manager." Q
 K DIC S DIC="^VA(200,",DIC(0)="AEMQZ",DIC("A")="Enter User Name: " D ^DIC Q:Y<0
 I PSOBOSS=2,(DUZ=+Y) W !!,$C(7),"==> Sorry, you can't give yourself keys.  See your IRM staff." Q
 S PSODA=+Y,PSONAME=$P(Y,U,2)
 D OWNSKEY^XUSRB(.PSONS,"PSDRPH",PSODA) S PSORET=PSONS(0) ;chk if user had key
 S OK=$$ASK(PSORET,PSONAME) I 'OK W !,"Nothing done..." Q
 ;De-allocate key
 I PSORET K DIK S DIK="^VA(200,PSODA,51,",DA(1)=PSODA,DA=PSOKEY D ^DIK
 ;Allocate key
 I 'PSORET S FDA(200.051,"+1,"_PSODA_",",.01)="PSDRPH" D UPDATE^DIE("E","FDA","IEN","MSG")
 ;Set and record audit data
 S NOW=$P($$HTE^XLFDT($H),":",1,2)
 S INPUT="`"_PSODA_"^"_"`"_$G(DUZ)_"^"_$S(PSORET:0,1:1) D RECORD(INPUT,NOW)
 Q
 ;
ASK(TYPE,NAME,DELEG) ;Ask user if Allocate/De-allocate or Delegate/Un-delegate - returns y/n
 ;TYPE - flag weather Allocate/De-allocate or Delegate/Un-delegate
 ;Name - user's name
 N DIR,Y
 S DELEG=$G(DELEG,"")
 I DELEG S DIR("A")=$S(TYPE=1:"Un-delegate",1:"Delegate")_" PSDRPH for "_NAME
 I 'DELEG S DIR("A")=$S(TYPE=1:"De-allocate",1:"Allocate")_" PSDRPH for "_NAME
 S DIR("B")="Y"
 S DIR(0)="Y" D ^DIR K DIR
 Q Y
RECORD(LINE,NOW) ;Record the edited data into audit file #8991.7
 N FDA,VALUE,IEN,MSG,I
 F I=1:1:3 S VALUE=$P(LINE,U,I),FDA(8991.7,"+1,",(I/100))=VALUE
 S FDA(8991.7,"+1,",.04)=NOW
 D UPDATE^DIE("E","FDA","IEN","MSG")
 Q
 ;
VUSER1(PSOSD0,ACT) ;called from option - PSO EPCS DISUSER EXP DATE,PSO EPCS EXP DATE
 ;chk user ACTIVE, with DEA# and null DEA Exp Date
 ;PSOSD0=IEN, ACT=(1 or 0) active user or not
 N CNT
 S CNT=0
 ;I $$PRDEA^XUSER(PSOSD0)'="" S CNT=CNT+1
 ;I $$PRXDT^XUSER(PSOSD0)="" S CNT=CNT+1
 I ACT D
 .I $$ACTIVE^XUSER(PSOSD0) S CNT=CNT+1
 I 'ACT D
 .I '$$ACTIVE^XUSER(PSOSD0) S CNT=CNT+1
 I CNT=3 Q 1
 Q 0
 ;
VUSER2(PSOSD0,ACT) ;called from option - PSO EPCS PRIVS,PSO EPCS DISUSER PRIVS
 ;chk user ACTIVE, with DEA# or VA# with privilages - sch II-V
 ;PSOSD0=IEN, ACT=(1 or 0) active user or not
 N CNT
 S CNT=0
 ;I $$PRESCBR^PSODEART(PSOSD0) S CNT=CNT+1
 ;I $$PRIVS^PSODEART(PSOSD0) S CNT=CNT+1
 I ACT D
 .I $$ACTIVE^XUSER(PSOSD0) S CNT=CNT+1
 I 'ACT D
 .I '$$ACTIVE^XUSER(PSOSD0) S CNT=CNT+1
 I CNT=3 Q CNT
 Q 0
 ;
INIT ;
 S PSONS="PSODEA",$P(FSP," ",25)=""
 S FLG=0,FN=$S(PSORPT=1:8991.6,1:8991.7)
 S RHD=$S(PSORPT=1:"SETTING OR CHANGES TO DEA PRESCRIBING PRIVILEGES",1:"PSDRPH KEY AUDIT LIST")
 S OPT=$S(PSORPT=1:"PSO EPCS LOGICAL ACCESS",1:"PSO EPCS PHARMACIST ACCESS")
 S ZPR=$$GET^XPAR("SYS",$S(PSORPT=1:"PSOEPCS LOGICAL ACC REPORT DEV",1:"PSOEPCS PHARM ACC RPT DEVICE",1:""),1,"I")
 S RT=$$NOW^XLFDT
 K ^XTMP(PSONS,$J),^TMP(PSONS,$J)
 Q
 ;
GMAIL ;
 N LC,ND,DAT,ARR,I,J,P1,P2,P3,P4,P5,P6,P6L,P6S,RT,XTV,DV,P8L,P8S D INIT
 S LD=BDT F  S LD=$O(^XTV(FN,"DT",LD))  Q:'LD!(LD>EDT)  D
 . S ND=0 F  S ND=$O(^XTV(FN,"DT",LD,ND)) Q:'ND  D
 .. Q:'$D(^XTV(FN,ND,0))
 .. S DAT=^XTV(FN,ND,0)
 .. S IEN=$P(DAT,"^")
 .. ;S DV=$O(^VA(200,IEN,2,0)) S:'DV DV=999999
 .. ;S ^XTMP(PSONS,$J,DV,LD,ND)=""
 .. ;S:$O(^VA(200,IEN,2,DV)) ^XTMP(PSONS,$J,"Z",IEN)=""
 .. S (DV,DVS)=0 F  S DV=$O(^VA(200,IEN,2,DV)) Q:('DV)&(DVS>0)  S:'DV DV=999999 D
 ... S DVS=DVS+1
 ... S ^XTMP(PSONS,$J,DV,LD,ND)=""
 ... S:$O(^VA(200,IEN,2,DV)) ^XTMP(PSONS,$J,"Z",IEN)=""
SMAIL ;
 S XMSUB="PSO EPCS "_$S(PSORPT=1:"LOGICAL",1:"PHARMACIST")_" ACCESS REPORT",XMDUZ=.5
 S LC=1,^TMP(PSONS,$J,LC)=RHD,$E(^TMP(PSONS,$J,LC),60)=$$UP^XLFSTR($$FMTE^XLFDT(RT,"M")),LC=LC+1
 I '$D(^XTMP(PSONS,$J)) D  G MGRP
 . S ^TMP(PSONS,$J,LC)="",LC=LC+1
 . S ^TMP(PSONS,$J,LC)="          ***************  NO MATCHING DATA  ***************",LC=LC+1
 . S ^TMP(PSONS,$J,LC)="",LC=LC+1
 I PSORPT=1 D
 . S ^TMP(PSONS,$J,LC)="NAME",$E(^TMP(PSONS,$J,LC),28)="EDITED BY",$E(^TMP(PSONS,$J,LC),55)="FIELD EDITED",LC=LC+1
 E  D
 . S ^TMP(PSONS,$J,LC)="NAME",$E(^TMP(PSONS,$J,LC),48)="ALLOCATION",LC=LC+1
 . S $E(^TMP(PSONS,$J,LC),24)="EDITED BY",$E(^TMP(PSONS,$J,LC),48)="STATUS",$E(^TMP(PSONS,$J,LC),60)="DATE/TIME EDITED",LC=LC+1
 S $P(^TMP(PSONS,$J,LC),"-",79)="",LC=LC+1
 S DV="" F  S DV=$O(^XTMP(PSONS,$J,DV)) Q:'DV  D
 . K ARR
 . S ^TMP(PSONS,$J,LC)="",LC=LC+1
 . S ^TMP(PSONS,$J,LC)="Division: "_$S(DV=999999:"NO DIVISION",1:$$GET1^DIQ(4,DV,.01)),LEN=$L(^TMP(PSONS,$J,LC))+1,LC=LC+1
 . S $P(^TMP(PSONS,$J,LC),"-",LEN)="",LC=LC+1
 . S LD=0 F  S LD=$O(^XTMP(PSONS,$J,DV,LD)) Q:'LD  D
 .. S ND=0 F  S ND=$O(^XTMP(PSONS,$J,DV,LD,ND)) Q:'ND  D BMAIL
 . S J=0 F  S J=$O(ARR(J)) Q:'J  D:$D(^XTMP(PSONS,$J,"Z",J)) MFT
MGRP ;
 N XMY,MDUZ
 I PSORPT=1 S DEV=$$GET^XPAR("SYS","PSOEPCS LOGICAL ACC RPT EMAIL",1,"E")
 E  S DEV=$$GET^XPAR("SYS","PSOEPCS PHARM ACC REPORT EMAIL",1,"E")
 I DEV]"" S XMY("G."_DEV)=""
 E  D
 . S MDUZ=0
 . I $D(^XUSEC("PSDMGR")) D
 .. F  S MDUZ=$O(^XUSEC("PSDMGR",MDUZ)) Q:MDUZ'>0  S XMY(MDUZ)=""
 S:'$O(XMY(0)) XMY(DUZ)=""
 S XMTEXT="^TMP(PSONS,$J," N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;
BMAIL ;
 S DAT=^XTV(FN,ND,0),IEN=$P(DAT,"^"),ARR(IEN)=""
 D GETS^DIQ(FN,ND,".01;.02;.04;.05;.06;.08","E","XTV")
 D GETS^DIQ(FN,ND,".03","IE","XTV")
 S P1=$G(XTV(FN,ND_",",.01,"E"))_FSP
 S P2=$G(XTV(FN,ND_",",.02,"E"))_FSP
 S FE=$G(XTV(FN,ND_",",.03,"I"))
 I PSORPT=1 S P3=$P($G(^DD($S(FE>50:200,1:8991.9),FE,0)),U)
 I PSORPT=2 S P3=$G(XTV(FN,ND_",",.03,"E"))_FSP
 S P4=$G(XTV(FN,ND_",",.04,"E"))
 S P5=$G(XTV(FN,ND_",",.05,"E"))
 S P6=$G(XTV(FN,ND_",",.06,"E")),P6=$P(P6,"@",1)
 I PSORPT=1 D
 . I $L(P4)=7 S Y=P4 D DT^DIO2 S P4=Y,Y=P5 D DT^DIO2 S P5=Y
 . I $L(P4)<7  D
 .. S P4=$S($G(XTV(FN,ND_",",.04,"E"))="True":1,$G(XTV(FN,ND_",",.04,"E"))="False":0,1:$G(XTV(FN,ND_",",.04,"E")))
 .. S P5=$S($G(XTV(FN,ND_",",.05,"E"))="True":1,$G(XTV(FN,ND_",",.05,"E"))="False":0,1:$G(XTV(FN,ND_",",.05,"E")))
 . S ^TMP(PSONS,$J,LC)=$E(P1,1,28)_$E(P2,1,26)_$E(P3_FSP,1,24),LC=LC+1
 . S ^TMP(PSONS,$J,LC)="   ORIGINAL DATA: "_P4
 . I $G(XTV(FN,ND_",",.08,"E"))]"" D  ;1749***
 .. S P8L=$L(^TMP(PSONS,$J,LC)) ;1749***
 .. S P8S=$E(FSP_FSP,1,56-P8L) ;1749***
 .. S ^TMP(PSONS,$J,LC)=^TMP(PSONS,$J,LC)_P8S_"For DEA#: "_$G(XTV(FN,ND_",",.08,"E")) ;1749***
 . S LC=LC+1
 . S ^TMP(PSONS,$J,LC)="     EDITED DATA: "_P5_$S(FE>50:" (Source: File #200)",1:"")
 . S P6L=$L(^TMP(PSONS,$J,LC))
 . S P6S=$E(FSP_FSP,1,60-P6L)
 . S ^TMP(PSONS,$J,LC)=^TMP(PSONS,$J,LC)_P6S_"DATE: "_P6 S LC=LC+1
 E  S ^TMP(PSONS,$J,LC)=$E(P1,1,22)_" "_$E(P2,1,22)_" "_$E(P3,1,12)_" "_P4,LC=LC+1
 Q
 ;
MFT ;
 S ^TMP(PSONS,$J,LC)="",LC=LC+1
 S ^TMP(PSONS,$J,LC)="**Note: This user is defined under these divisions",LEN=$L(^TMP(PSONS,$J,LC))+1,LC=LC+1
 S $P(^TMP(PSONS,$J,LC),"-",LEN)="",LC=LC+1
 S (DAT,ND)=0 F  S ND=$O(^VA(200,J,2,ND)) Q:'ND  D
 . S DAT=DAT+1 S:DAT=1 ^TMP(PSONS,$J,LC)=$$GET1^DIQ(200,J,.01) S $E(^TMP(PSONS,$J,LC),32)=$$GET1^DIQ(4,ND,.01),LC=LC+1
 Q
 ;
ODRPT ;
 ;ePCS on demand report - setting or modifing to logical access controls/allocation history for PSDRPH key
 ;called from option - PSO EPCS LOGICAL ACCESS/PSO EPCS PSDRPH AUDIT
 ;provide a date range
 N BDT,EDT,FLG,ST,FN,PSONS,POD,RHD,RT,OPT,PSOION,PSOOUT,PSOTYP D INIT K %DT,DTOUT,ZPR
 W ! S %DT(0)=-DT,%DT("A")="Beginning Date: ",%DT="APE" D ^%DT I Y<0!($D(DTOUT)) G EXIT
 S POD=1,(%DT(0),BDT)=Y
 W ! S %DT("A")="Ending Date: " D ^%DT I Y<0!($D(DTOUT)) G EXIT
 S EDT=Y_".9999"
 S ST=BDT,FLG=0 F  S ST=$O(^XTV(FN,"DT",ST)) Q:ST=""!(FLG=1)  D
  . S:ST<EDT FLG=1
 I FLG=0 W !!?18,"**********   NO DATA TO PRINT   **********" H 2 G EXIT
 I PSORPT=1 D  G:$G(PSOTYP)="D" EXIT G:$G(PSOOUT) EXIT
 . D TYPE^PSODEARU I $G(PSOOUT) Q
 . I $G(PSOTYP)="D" D DL^PSODEARU I $G(PSOOUT) Q
 . I $G(PSOTYP)="D" D OENDL^PSODEARU(PSONS,BDT,EDT,FN)
 K IOP,%ZIS,POP S PSOION=ION,%ZIS="MQ" D ^%ZIS I POP S IOP=PSOION D ^%ZIS G EXIT
AUTPRT ;
 I $G(ZPR)!$D(IO("Q")) D  G EXIT
 . N ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTDTH,ZTSK,ZTREQ,ZTQUEUED
 . S:$G(ZPR) ZTIO="`"_ZPR,ZTDTH=$H S ZTRTN="OEN^PSODEART",ZTDESC=OPT,ZTSAVE("BDT")="",ZTSAVE("EDT")="",ZTSAVE("PSORPT")="",ZTSAVE("POD")=""
 . S ZTSAVE("FN")="",ZTSAVE("PSONS")="",ZTSAVE("FLG")="",ZTSAVE("RHD")="",ZTSAVE("OPT")="",ZTSAVE("RT")="",ZTSAVE("FSP")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!"
OEN ;
 U IO
 N PAGE,LINE,LEN,XTV,ARR,I,J,RHD,HCL,FSP,RDT,DV,FE
 N DV,ND,DAT,IEN,DVS K DIRUT
 K ^XTMP(PSONS,$J)
 S LD=BDT F  S LD=$O(^XTV(FN,"DT",LD))  Q:'LD!(LD>EDT)  D
 . S ND=0 F  S ND=$O(^XTV(FN,"DT",LD,ND)) Q:'ND  D
 .. Q:'$D(^XTV(FN,ND,0))
 .. S DAT=^XTV(FN,ND,0)
 .. S IEN=$P(DAT,"^")
 .. S (DV,DVS)=0 F  S DV=$O(^VA(200,IEN,2,DV)) Q:('DV)&(DVS>0)  S:'DV DV=999999 D
 ... S DVS=DVS+1
 ... S ^XTMP(PSONS,$J,DV,LD,ND)=""
 ... S:$O(^VA(200,IEN,2,DV)) ^XTMP(PSONS,$J,"Z",IEN)=""
 S RHD=$S(PSORPT=1:"SETTING OR CHANGES TO DEA PRESCRIBING PRIVILEGES",1:"PSDRPH KEY AUDIT LIST")
 S HCL=(80-$L(RHD))\2,RDT=$$FMTE^XLFDT($$NOW^XLFDT,"1M")
 S PAGE=1,$P(LINE,"-",79)="",$P(FSP," ",25)=""
 D HD
 I '$D(^XTMP(PSONS,$J)) D  G QT
 . W !!,"          ***************  NO MATCHING DATA  ***************",!!
 S DV="" F  S DV=$O(^XTMP(PSONS,$J,DV)) Q:'DV  D  G:$D(DIRUT) QT
 . K ARR S LEN="Division: "_$S(DV=999999:"NO DIVISION",1:$$GET1^DIQ(4,DV,.01))
 . W !!,LEN,! F I=1:1:$L(LEN) W "-"
 . S LD=0 F  S LD=$O(^XTMP(PSONS,$J,DV,LD)) Q:'LD  D  Q:$D(DIRUT)
 .. S ND=0 F  S ND=$O(^XTMP(PSONS,$J,DV,LD,ND)) Q:'ND  D  Q:$D(DIRUT)
 ... S DAT=^XTV(FN,ND,0),IEN=$P(DAT,"^"),FE=$P(DAT,"^",3)
 ... D GETS^DIQ(FN,ND,".01;.02;.03;.04;.05;.06;.08","E","XTV")
 ... S ARR(IEN)=""
 ... I PSORPT=1 D
 .... W !,$E($G(XTV(FN,ND_",",.01,"E"))_FSP,1,25),?28,$E($G(XTV(FN,ND_",",.02,"E"))_FSP,1,25),?55,$E($P($G(^DD($S(FE>50:200,1:8991.9),FE,0)),U)_FSP,1,24)
 .... W !,?3,"ORIGINAL DATA: "
 .... I FE=.04 S Y=$P(DAT,"^",4) D DT^DIO2 I $G(XTV(FN,ND_",",.08,"E"))]"" D  ;1749 ***
 ..... W ?58,"For DEA#: ",$G(XTV(FN,ND_",",.08,"E")) ;1749 ***
 .... I FE'=.04 W $S($G(XTV(FN,ND_",",.04,"E"))="True":1,$G(XTV(FN,ND_",",.04,"E"))="False":0,1:$G(XTV(FN,ND_",",.04,"E"))) I $G(XTV(FN,ND_",",.08,"E"))]"" D  ;1749 ***
 ..... W ?58,"For DEA#: ",$G(XTV(FN,ND_",",.08,"E")) ;1749 ***
 .... W !,?3,"  EDITED DATA: "
 .... I FE=.04 S Y=$P(DAT,"^",5) D DT^DIO2
 .... I FE'=.04 W $S($G(XTV(FN,ND_",",.05,"E"))="True":1,$G(XTV(FN,ND_",",.05,"E"))="False":0,1:$G(XTV(FN,ND_",",.05,"E")))_$S(FE>50:" (Source: File #200)",1:"")
 .... S Y=$P($P(DAT,"^",6),".",1) W ?62,"DATE: " D DT^DIO2
 ... I PSORPT'=1 W !,$G(XTV(FN,ND_",",.01,"E")),?24,$G(XTV(FN,ND_",",.02,"E")),?48,$G(XTV(FN,ND_",",.03,"E")),?61,$G(XTV(FN,ND_",",.04,"E"))
 ... S ARR(IEN)=""
 ... D:($Y+4)>IOSL HD
 . S J=0 F  S J=$O(ARR(J)) Q:'J  D:$D(^XTMP(PSONS,$J,"Z",J)) FT
QT ;
 K DIR,DTOUT,DUOUT,DIRUT
 D EXIT
 Q
 ;
GUI ; Entry point for ePCS GUI Report
 N PSORPT,PSONS,FLG,FN,OPT,ZPR,RT,PSOSCR,BDT,EDT,PSOION
 S PSORPT=1               ; Tells the INIT section to set FN to '8991.6'
 D INIT K %DT,DTOUT,ZPR
 ;
 S PSOSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 ;
 S BDT=EPCSSD S EDT=EPCSED       ; Set the date values based on input parameters
 I $G(EPCSPTYP)="E" D EXPORT^PSODEARU(PSONS,BDT,EDT,FN) Q  ;,^EPCSKILL Q  ; This report will be exported
 ;I $G(EPCSPTYP)="E" D EXPORT^PSODEARU Q
 D OEN                           ; Run Report
 ;I $D(EPCSGUI) D ^EPCSKILL Q    // Kill variables...
 Q
 ;
HD ;
 I PAGE>1,$E(IOST)="C" S DIR(0)="E",DIR("A")=" Press Return to Continue or ^ to Exit" D ^DIR K DIR
 Q:$D(DIRUT)
 W @IOF
 I $G(POD) D
 . W !,?HCL,RHD,!,"For the Period: " S Y=BDT D DT^DIO2
 . W " to " S Y=$E(EDT,1,7) D DT^DIO2 W "     Run Date: " S Y=DT D DT^DIO2 W ?72,"Page "_PAGE,! S PAGE=PAGE+1
 E  W !,RHD,?50,RDT,?72,"Page "_PAGE,! S PAGE=PAGE+1
 I PSORPT=1 W !,"NAME",?28,"EDITED BY",?55,"FIELD EDITED"
 I PSORPT=2 W !,"NAME",?48,"ALLOCATION",!,?24,"EDITED BY",?48,"STATUS",?61,"DATE/TIME EDITED"
 W !,LINE
 Q
 ;
FT ; Find Divisions for specific user
 S LEN="**Note: This user is defined under these divisions"
 W !!,LEN
 W ! F I=1:1:$L(LEN) W "-"
 S (DAT,ND)=0 F  S ND=$O(^VA(200,J,2,ND)) Q:'ND  D
 . S DAT=DAT+1 W ! W:DAT=1 $$GET1^DIQ(200,J,.01) W ?32,$$GET1^DIQ(4,ND,.01)
 I $E(IOST)="C" S DIR(0)="E" D ^DIR K DIR
 Q
 ;
PARAM ;Allow user to edit parameters
 N DIR,Y
 S VALMBCK="R" D FULL^VALM1
 F  D  Q:'Y
 .S DIR(0)="SO^1:PSOEPCS LOGICAL ACC REPORT DEV;2:PSOEPCS LOGICAL ACC RPT EMAIL;3:PSOEPCS PHARM ACC RPT DEVICE;4:PSOEPCS PHARM ACC REPORT EMAIL"
 .S DIR("A")="Select parameter to edit"
 .D ^DIR K DIR Q:'Y
 .D EDITPAR^XPAREDIT(Y(0))
 Q
 ;
FAIL ; Failover parameter edit
 D EDITPAR^XPAREDIT("PSOEPCS EXPIRED DEA FAILOVER")
 Q
 ;
MBM ; Pharmacy Operating Mode
 N DIR,Y,X,PSOFDA,PSOERR
 S DIR(0)="SAO^MBM:MEDS BY MAIL;VAMC:VA MEDICAL CENTER"
 S DIR("A")="PHARMACY OPERATING MODE: "
 S DIR("?",1)="Choose Pharmacy Operating Mode as VAMC to utilize business rules appropriate"
 S DIR("?",2)="to the traditional VA pharmacy setting. Choose Pharmacy Operating Mode as MBM"
 S DIR("?",3)="to utilize business rules specific and appropriate for the Meds by Mail pharmacy"
 S DIR("?",4)="setting only. VistA behavior will follow the rules of the VAMC Operating Mode"
 S DIR("?")="if this value is not set."
 S DIR("B")=$$GET1^DIQ(59.7,1_",",102,"E")
 D ^DIR K DIR
 I Y="MBM"!(Y="VAMC") D  Q
 . S PSOFDA(59.7,1_",",102)=Y D FILE^DIE("","PSOFDA","PSOERR")
 I X="@" S (X,Y)="" D  Q
 .N DIR S DIR(0)="Y",DIR("A")="SURE YOU WANT TO DELETE"
 .D ^DIR Q:'$G(Y)
 .S PSOFDA(59.7,1_",",102)="" D FILE^DIE("","PSOFDA","PSOERR")
 Q
 ;
FOM() ; Failover Message
 Q:'$D(DIR("B"))
 I DIR("B")="YES",Y=0 D
 . W !!,"***************************** WARNING ******************************************"
 . W !,"A value of NO prevents providers with an expired DEA number from prescribing"
 . W !,"controlled substances.  A provider without a DEA number will still be able to"
 . W !,"prescribe controlled substances if they have a VA number entered in VistA.",!
 Q
 ;
PRIVSRT ; Print Prescribers with Privileges report
 N DIS,FLDS,L,BY
 S DIC="^VA(200,",L=0,BY="[PSO DEA DIV SORT]",FLDS="[PSO DEA PRIVS PRINT]"
 S DIS(0)="I $$VUSER2^PSODEART(D0,1)"
 S IOP=";80;9999"
 D EN1^DIP
 Q
 ;
PRIVSDRT ; Print Prescribers with Privileges report
 N DIS,FLDS,L,BY
 S DIC="^VA(200,",L=0,BY="[PSO DEA DISUSER2 SORT]",FLDS="[PSO DEA DISUSER PRIVS PRINT]"
 S DIS(0)="I $$VUSER2^PSODEART(D0,0)"
 S IOP=";80;9999"
 D EN1^DIP
 Q
