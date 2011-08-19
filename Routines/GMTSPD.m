GMTSPD ; SLC/JER,KER - Interactive Print-by-Location ; 04/30/2002 [1/26/05 1:50pm]
 ;;2.7;Health Summary;**28,30,47,49,55,70**;Oct 20, 1995;Build 5
 ;
 ; External
 ;    DBIA 10040  ^SC(
 ;    DBIA 10040  ^SC("B"
 ;    DBIA   641  ^SRF("AOR"
 ;    DBIA   185  ^SRS("B"
 ;    DBIA 10039  ^DIC(42
 ;    DBIA   510  ^DISV(
 ;    DBIA 10035  ^DPT("CN"
 ;    DBIA 10000  C^%DTC
 ;    DBIA 10000  NOW^%DTC
 ;    DBIA 10006  ^DIC (file #42 and #44)
 ;    DBIA 10026  ^DIR
 ;    DBIA 10076  ^XUSEC("GMTS VIEW ONLY"
 ;    DBIA 10104  $$UP^XLFSTR
 ;                           
MAIN ; Interactive Print by Location
 N GMPSAP,GMTSCDT,GMTSTYP,GMLOC,GMTSTN,GMTSSC
 S GMTSTYP=0 K DIROUT
 F  D  Q:+GMTSTYP'>0!$D(DIROUT)
 . S GMTSTYP=+($$SELTYP) Q:+GMTSTYP'>0!$D(DIROUT)
 . F  D  Q:+$G(GMTSSC)'>0!$D(DIROUT)!$D(DUOUT)!($D(GMTSSC("ALL")))
 . . K GMTSSC,DUOUT D SELLOC(.GMTSSC) Q:+$G(GMTSSC)'>0!$D(DIROUT)!$D(DUOUT)
 . . D CHKLOC(.GMTSSC) Q:$O(GMTSSC(0))'>0!$D(DIROUT)!$D(DTOUT)!$D(DUOUT)
 . . S GMPSAP=$$RXAP^GMTSPD2 Q:$D(DIROUT)!$D(DUOUT)!$D(DTOUT)
 . . N DIROUT D HSOUT^GMTSPD2 W ! S DUOUT=1
 Q
SELTYP() ; Select Health Summary type
 N DIC,X,Y
 I $D(^DISV(DUZ,"^GMT(142,")),+$G(GMTSTYP)=0 S DIC("B")=$P($G(^GMT(142,+$G(^DISV(DUZ,"^GMT(142,")),0)),U)
 S DIC=142,DIC("A")="Select Health Summary Type: "
 S DIC(0)="AEQM",DIC("S")="I $P(^(0),U)'=""GMTS HS ADHOC OPTION"""
 S Y=$$TYPE^GMTSULT I +Y'>0,X="^^" S DIROUT=1
 I +Y>0,$S($D(^GMT(142,+Y,1,0))=0:1,$O(^(0))'>0:1,1:0) D
 . W !,"This Summary Type includes no components...Please choose another."
 Q Y
SELLOC(GMX) ; Select multiple Hospital Location
 N DIC,LOC,Y,X,DIR,GMTSLC
 S DIC=44,DIC(0)="AEMQZ",DIC("A")="Select Hospital Location: ",GMTSLC=0
 I $D(^XUSEC("GMTS VIEW ONLY",+($G(DUZ)))) S GMTSLC=1
 S DIC("S")="I ""WCOR""[$P(^(0),U,3)"
 F  D  Q:+$G(GMX(+$G(Y)))'>0!$D(DIROUT)!$D(DTOUT)!$D(DUOUT)  Q:GMTSLC<0
 . D:GMTSLC'>0 ASK Q:$D(GMX("ALL"))
 . D:GMTSLC>0 ^DIC S GMTSLC=GMTSLC+1 Q:$G(DIROUT)=1
 . I +Y'>0 S:X="^^" DIROUT=1 Q
 . S GMX(+Y)=$P(Y,U,1,2)_U_$P(Y(0),U,3)
 . S $P(GMX,U)=+Y
 . I "COR"[$P(Y(0),U,3) S $P(GMX,U,3)="COR"
 . S DIC("A")="Select Next Hospital Location: "
 Q
ASK ; Prompt for One or ALL
 N ERR,DIC,DIR,LASTI,LAST
ASK2 S DIR("A")="Select Hospital Location: "
 S LASTI=$G(^DISV(+($G(DUZ)),"^SC(")),LAST=$S(+LASTI>0:$P($G(^SC(+LASTI,0)),"^",1),1:"")
 S DIR(0)="FAO^1:30",DIR("?")="^D A1^GMTSPD",DIR("??")="^D A2^GMTSPD"
 D ^DIR I $L($G(X)),$E($G(X),1)=" ",$L(LAST),+($G(LASTI))>0 D  Q
 . W "  ",LAST S X=LAST,Y=+LASTI_"^"_LAST,Y(0)=$G(^SC(+LASTI,0)),Y(0,0)=LAST Q
 I $$UP^XLFSTR(Y)="ALL" D  Q
 . K GMX S GMX="1^ALL^COR",GMX("ALL")="",GMX(1)="1^ALL^C",GMTSLC=-1
 S ERR=1,DIC=44,DIC(0)="EMZ"
 S DIC("S")="I ""WCOR""[$P(^(0),U,3) S ERR=0"
 D ^DIC
 I $L(X),+($G(ERR))>0 D  W ! G ASK2
 . W " ??",!!,?5,"Not a ward, clinic or operating room"
 I +Y'>0 S:X["^^" DIROUT=1,GMTSEXIT="^^" Q
 Q
A1 ; Single ? Help
 W !,"  Answer with HOSPITAL LOCATION NAME, or ABBREVIATION, TEAM or 'ALL'"
 W !,"  for all hospital locations.  Enter '^' to return to Health Summary"
 W !,"  Type Selection or '^^' to exit."
 Q
A2 ; Double ?? Help
 N GMTSN,GMTSI,GMTSL,GMTSC,GMTSE,GMTSP,GMTSA S GMTSP=+($G(IOSL))-9 S:GMTSP'>0 GMTSP=15
 S (GMTSA,GMTSC,GMTSE)=0,GMTSN="" D A1 W !
 F  S GMTSN=$O(^SC("B",GMTSN)) Q:GMTSN=""  D  Q:GMTSE
 . S GMTSI=0 F  S GMTSI=$O(^SC("B",GMTSN,GMTSI)) Q:GMTSI=""  D  Q:GMTSE
 . . S GMTSL=$P($G(^SC(GMTSI,0)),"^",1) Q:'$L(GMTSL)  S GMTSC=GMTSC+1,GMTSA=GMTSA+1
 . . W:GMTSC=1 !,?3,"Choose from:" W !,?3,GMTSL
 . . I GMTSA'<GMTSP D CONT
 Q
CONT ; Continue Displaying List
 S GMTSP=+($G(IOSL))-1 S:GMTSP'>0 GMTSP=23 S GMTSA=0
 N DIR,DA,X,Y,DTOUT,DUOUT,DIRUT,DIROUT S DIR(0)="E",DIR("A")="   '^' TO STOP",(DIR("?"),DIR("??"))="^D C1^GMTSPD"
 D ^DIR S:+($G(Y))=0 GMTSE=1
 Q
C1 ; Continue Help
 W !,"     Enter ether RETURN or '^'" Q
CHKLOC(LOC) ; Get date range for Clinics/ORs
 I $P($G(LOC),U,3)="COR" D  Q:$D(DIROUT)!$D(DTOUT)!$D(DUOUT)
 . S $P(LOC,U,4)=$$SELDATE
 W ! S GMLOC=0 F  S GMLOC=$O(LOC(GMLOC)) Q:+GMLOC'>0  D
 . I "COR"[$P(LOC(+GMLOC),U,3) S $P(LOC(+GMLOC),U,4)=$P(LOC,U,4,5)
 Q
SELDATE() ; Visit/Surgery date range for Print-by-Clinic
 N %,%H,%I,DIR,DEFDT,X,Y,GMBEG,GMEND
 S (GMBEG,GMEND)=0
 D NOW^%DTC S (X,DT)=$P(%,".") D REGDT4^GMTSU S DEFDT=X
 S DIR(0)="D^::EX",DIR("B")=DEFDT
 S DIR("A")="Please enter the beginning Visit or Surgery date"
 D ^DIR
 I Y="^^" S DIROUT=1
 S GMBEG=Y
 I +GMBEG>0 D
 . S X=$P(GMBEG,".") D REGDT4^GMTSU S DEFDT=X
 . S DIR(0)="DO^::EX",DIR("B")=DEFDT
 . S DIR("A")="Please enter the ending Visit or Surgery date"
 . D ^DIR
 . I Y="^^" S DIROUT=1
 . S GMEND=Y
 Q $S(+GMEND>0&(GMEND>GMBEG):GMBEG_U_GMEND,+GMEND>0&(GMEND<GMBEG):GMEND_U_GMBEG,+GMEND>0&(GMEND=GMBEG):GMBEG,1:0)
CKPAT(LOC) ; Checks for patients at selected location
 N %,%H,%T,LTYPE,X1,X2,X,Y,GMY,GMBEG,GMTSDATE,GMTSCDT,GMTSRES
 S LTYPE=$P(LOC,U,3)
 I LTYPE="W" D
 . S LOC=$P($G(^DIC(42,+$G(^SC(+LOC,42)),0)),U)
 . S GMY=$S($G(LOC)']"":0,$O(^DPT("CN",LOC,0)):1,1:0)
 I $L(LOC,U)=4!($L(LOC,U)=5) D
 . S GMY=0
 . I +$P(LOC,U,5) S X1=$P(LOC,U,5),X2=1 D C^%DTC
 . I +$P(LOC,U,5)'>0 S X1=$P(LOC,U,4),X2=1 D C^%DTC
 . S GMTSCDT=$P(LOC,U,4)
 . D GETPLIST^SDAMA202(+LOC,"1",,GMTSCDT,X,.GMTSRES) Q:GMTSRES=0
 . I GMTSRES<0 D  Q
 . . S GMY=-1
 . . N GMTSERR
 . . S GMTSERR=$O(^TMP($J,"SDAMA202","GETPLIST","ERROR",0))
 . . I 'GMTSERR Q
 . . D MAIL^GMTSMAIL($G(^TMP($J,"SDAMA202","GETPLIST","ERROR",GMTSERR)),"Nightly Job to Queue HS Batch Print-by-Loc")
 . . K ^TMP($J,"SDAMA202","GETPLIST")
 . N GMTSI S GMTSI=0,GMTSDATE=0
 . F  S GMTSI=$O(^TMP($J,"SDAMA202","GETPLIST",GMTSI)) Q:'GMTSI  D
 . . I $G(^TMP($J,"SDAMA202","GETPLIST",GMTSI,1))<X S GMTSDATE=$G(^TMP($J,"SDAMA202","GETPLIST",GMTSI,1))
 . K ^TMP($J,"SDAMA202","GETPLIST")
 . I LTYPE="C",(+GMTSDATE),(+GMTSDATE'>X) S GMY=1
 . I LTYPE="OR" D
 . . N OLOC S GMY=0,OLOC=+$O(^SRS("B",+LOC,0))
 . . I +OLOC,+$P(LOC,U,5)'>0,$O(^SRF("AOR",+OLOC,+$P(LOC,U,4),0)) S GMY=1
 . . I +OLOC,+$P(LOC,U,5) D
 . . . S GMBEG=$P(LOC,U,4)
 . . . F  D  Q:GMBEG>$P(LOC,U,5)!(GMY>0)
 . . . . I $O(^SRF("AOR",+OLOC,+GMBEG,0)) S GMY=1
 . . . . E  S X1=GMBEG,X2=1 D C^%DTC S GMBEG=X
 Q $G(GMY)
