YSGAF ;ALB/ASF-GLOBAL ASSESSMENT OF FUNCTIONING ;11/10/97  16:17
 ;;5.01;MENTAL HEALTH;**33,37,40,42,43,51,49**;Dec 30, 1994
 Q
CLENT ;
 N %DT,DA,DIE,DIR,DIRUT,DLAYGO,DR,K,VA,VADM,X,X1,X2,Y,YSCLIN,YSCNAME,YSDA,YSDATE,YSDAYS,YSDD,YSDXEG,YSDXEL,YSDXEN,YSG,YSGAFLC,YSGAFLD,YSGAFLN,YSGC,YSGD,YSGN,YSGR,YSGT,YSLINE,YSN,YSONLY,YSOUT,YSPAGE,YSPTN,YSRULE,YSSTOP,YSGAFER
 W @IOF,"Clinic Entry: Global Assessment of Functioning",!
 D ONELOC^YSGAF1 Q:YSCLIN=""
 D DATE^YSGAF1 Q:YSDATE<1
 S YSDAYS=90
 D ONLYREQ^YSGAF1 Q:YSONLY=""
 D LP1^YSGAF1
 I '$D(^TMP("YSGAF",$J)) W !,"No GAF's to enter" Q
CE1 S YSN="",YSOUT=0 F  S YSN=$O(^TMP("YSGAF",$J,"A",YSN)) Q:YSN=""!(YSOUT)  S DFN=0 F  S DFN=$O(^TMP("YSGAF",$J,"A",YSN,DFN)) Q:DFN'>0  D
 .D RULE Q:('YSRULE)&(YSONLY)
 .W !
 .D DISP5,ADD5
 Q
RULE ;business rule for need dx
 S YSRULE=0
 D CK
 I YSGAFLD'?7N.E  S YSRULE=1 Q
 S X1=DT,X2=YSGAFLD D ^%DTC
 S:X>YSDAYS YSRULE=1
 Q
CK ;check last Axis 5
 S (YSGAFLN,YSGAFLD,YSGAFLC,YSGAFER)=""
 S YSDXEL=$O(^YSD(627.8,"AX5",DFN,-1))
 Q:YSDXEL<1
 S YSDXEN=$O(^YSD(627.8,"AX5",DFN,YSDXEL,-1))
 Q:YSDXEN<1
 S YSDXEG=$G(^YSD(627.8,YSDXEN,0))
 S YSGAFLD=$P(YSDXEG,U,3),YSGAFLC=$P(YSDXEG,U,4)
 S YSDXEG=$G(^YSD(627.8,YSDXEN,60))
 S YSGAFLN=$P(YSDXEG,U,3)
 S YSGAFER=$G(^YSD(627.8,YSDXEN,80,1,0))
 Q
PRINT ;
 N %DT,DA,DIE,DIR,DIRUT,DLAYGO,DR,K,VA,VADM,X,X1,X2,Y,YSCLIN,YSCNAME,YSDA,YSDATE,YSDAYS,YSDD,YSDXEG,YSDXEL,YSDXEN,YSG,YSGAFLC,YSGAFLD,YSGAFLN,YSGC,YSGD,YSGN,YSGR,YSGT,YSLINE,YSN,YSONLY,YSOUT,YSPAGE,YSPTN,YSRULE,YSSTOP
 S YSDAYS=90
 D ONELOC^YSGAF1 Q:YSCLIN=""
 D DATE^YSGAF1 Q:YSDATE<1
 D ONLYREQ^YSGAF1 Q:YSONLY=""
 ;ASK DEVICE 
 S %ZIS="QM"
 D ^%ZIS
 Q:$G(POP)
 I $D(IO("Q")) D  Q
 .N ZTRTN,ZTDESC,ZTSAVE
 .S ZTRTN="QPRT^YSGAF"
 .S ZTDESC="YSGAF PRINT"
 .F ZZ="YSONLY","YSDAYS","YSCLIN","YSCNAME","YSDATE" S ZTSAVE(ZZ)=""
 .D ^%ZTLOAD
 .D HOME^%ZIS
 .Q
 U IO
QPRT ;Queued Task Entry Point
 S:$D(ZTQUEUED) ZTREQ="@"
 D LP1^YSGAF1
 S YSPAGE=0 D TOP
 I '$D(^TMP("YSGAF",$J)) W !,"No appointments found" Q
PR1 S YSN="",YSOUT=1 F  S YSN=$O(^TMP("YSGAF",$J,"A",YSN)) Q:YSN=""  S DFN=0 F  S DFN=$O(^TMP("YSGAF",$J,"A",YSN,DFN)) Q:DFN'>0  D  D:$Y+4>IOSL BOT Q:YSOUT<1
 . D CK,RULE
 .Q:('YSRULE)&(YSONLY)
 . D DEM^VADPT
 .W !,$E(YSN,1,25),?26,VA("BID"),?32,$S($L(YSGAFER):"Er",YSGAFLN:YSGAFLN,1:"--")," ",$S(YSGAFLD:$$FMTE^XLFDT(YSGAFLD,"5ZD"),1:"            ")
 . W "  "_$S(YSRULE:"**",1:"  ")_"______    __________________"
 D ^%ZISC
 Q
TOP ;print header
 S YSPAGE=YSPAGE+1
 I '$D(YSLINE) S YSLINE="",$P(YSLINE,"-",79)=""
 W @IOF,"GAF List   Clinic: ",YSCNAME,"    **= > than ",YSDAYS," days"
 W !,"Appointment Date: ",$$FMTE^XLFDT(YSDATE,"5ZD")
 W ?32,"Last GAF        New",?65,"page: ",YSPAGE
 W !?32,"GAF  Date       GAF       Clinician",!,YSLINE
 Q
BOT ;page end
 K DIR S YSOUT=1 I IOST'?1"C".E D TOP Q
 W !! S DIR(0)="E" D ^DIR
 S YSOUT=Y D:Y=1 TOP
 Q
PTENT ;patient entry
 N %DT,DA,DIE,DIR,DIRUT,DLAYGO,DR,K,VA,VADM,X,X1,X2,Y,YSCLIN,YSCNAME,YSDA,YSDATE,YSDAYS,YSDD,YSDXEG,YSDXEL,YSDXEN,YSG,YSGAFLC,YSGAFLD,YSGAFLN,YSGC,YSGD,YSGN,YSGR,YSGT,YSLINE,YSN,YSONLY,YSOUT,YSPAGE,YSPTN,YSRULE,YSSTOP,YSGAFER
 W @IOF,"Global Assessment of functioning"
 F  K DFN W ! D ^YSLRP Q:'$D(DFN)  D DISP5,ADD5
 Q
DISP5 ;display last axis5
 Q:'$D(DFN)
 D DEM^VADPT
 W !,VADM(1),?35,"SSN: ",VA("PID"),?55,"DOB: ",$P(VADM(3),U,2)
DISP51 D CK
 I YSGAFLN D
 . W !?4,"Last GAF: ",YSGAFLN," on: "
 . S Y=YSGAFLD X ^DD("DD") W Y
 . W "  by: ",$S(+$G(YSGAFLC):$P(^VA(200,YSGAFLC,0),U),1:"--> No provider entered for this GAF score")
 . I $L(YSGAFER)>1 W !,YSGAFER
 I YSGAFLN<1 W !?4,"no previous GAF"
 Q
ADD5 ;add axis 5 dx
 W !!
 K DIR S DIR(0)="N^1:100:0",DIR("A")="GAF Score",DIR("?")="Enter the Global Assessment of Functioning : 1 to 100",DIR("??")="YS-GAF SCALE"
 ;I $D(YSGAFLN) S:YSGAFLN?1N.N DIR("B")=YSGAFLN
 D ^DIR S YSGN=Y S:X?1"^^".E YSOUT=1
 I $D(DIRUT) W !,"No GAF will be entered. Enter ^^ to end loop.",$C(7) Q
 K DIR S DIR(0)="DA^2961001:NOW:TX",DIR("A")="Diagnosis date/time: ",DIR("B")="NOW"
 D ^DIR S:Y>0 YSGD=Y
 I $D(DIRUT) W !,"No GAF will be entered",$C(7) Q
 K DIR,DIC S DIC="^VA(200,",DIC(0)="AEM",DIC("A")="Assessing Clinician: ",DIC("B")=$P(^VA(200,DUZ,0),U)
 D ^DIC K DIC S:Y>0 YSGC=+Y
 I Y<1 W !,"No GAF will be entered",$C(7) Q
 K DD,DO,DA,DINUM
 S X="NOW",%DT="TR" D ^%DT S X=Y
 S DIC="^YSD(627.8,",DIC(0)="L",DLAYGO=627.8 D FILE^DICN Q:Y'>0  S YSDA=+Y
 D PATSTAT^YSDX3B
 S DIE="^YSD(627.8,",DA=YSDA,DR=".02////"_DFN_";.03////"_YSGD_";.04////"_YSGC_";.05////"_DUZ_";65////"_YSGN_";66////"_YSSTAT
 L +^YSD(627.8,YSDA):9999 Q:'$T
 D ^DIE
 L -^YSD(627.8,YSDA)
 D EN^YSGAFOBX(YSDA)
 Q
 ;
RET(YSX) ;This extrinsic returns the most recent GAF score, GAF
 ;diagnosis date and physician/provider performing the diagnosis, 
 ;for the internal entry number given (via variable YSX.)  If no
 ;GAF score data is on file for this internal entry number, -1 is
 ;returned.
 N YSHOLD
 S (YSHOLD)=""
 S YSHOLD=$O(^YSD(627.8,"C",YSX,""),-1)
 IF YSHOLD D
 .S YSZ=$P($G(^YSD(627.8,YSHOLD,60)),"^",3)
 .S YSZ=YSZ_"^"_$P($G(^YSD(627.8,YSHOLD,0)),"^",3)
 .S YSZ=YSZ_"^"_$P($G(^YSD(627.8,YSHOLD,0)),"^",4)
 ELSE  S YSZ=-1
 Q YSZ
 ;
UPD(YSPN,YSGN,YSGD,YSGC,YSPT) ;Update GAF information
 ; YSPN - Patient Name
 ; YSGN - GAF Score (Axis 5)
 ; YSGD - Date/Time of Diagnosis
 ; YSGC - Diagnosis By
 ; YSPT - Patient Type ('I'npatient or 'O'utpatient)
 S YSERR=0
 I '$G(YSPN) D
 .W !,"  The Patient IEN is required!!!",!
 .S YSERR=1
 .Q
 ;
 I '$G(YSGN) D
 .W !,"  The GAF Score is required!!!",!
 .S YSERR=1
 .Q
 ;
 I '$G(YSGD) D
 .W "  The Observation Date/Time is required!!!",!
 .S YSERR=1
 .Q
 ;
 I '$G(YSGC) D
 .W "  The Provider is required!!!",!
 .S YSERR=1
 .Q
 ;
 QUIT:YSERR  ;---->
 ;
 K DD,DO,DA,DINUM
 S DLAYGO=627.8,X="NOW",%DT="TR" D ^%DT S X=Y
 S DIC="^YSD(627.8,",DIC(0)="L"
 D FILE^DICN Q:Y'>0  S YSDA=+Y
 S DFN=+YSPN
 D PATSTAT^YSDX3B
 S DIE="^YSD(627.8,",DA=YSDA
 S DR=".02////"_YSPN_";.03////"_YSGD_";.04////"_YSGC_";.05////"_DUZ
 S DR=DR_";65////"_YSGN_";66////"_YSSTAT
 L +^YSD(627.8,YSDA):9999 Q:'$T
 D ^DIE
 L -^YSD(627.8,YSDA)
 D EN^YSGAFOBX(YSDA)
 K %DT,DA,DIC,DIE,DLAYGO,DR,X,Y,YSDA,YSPN,YSGN,YSGD,YSGC,YSSTAT
 Q
