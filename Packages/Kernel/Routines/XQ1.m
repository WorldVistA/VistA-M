XQ1 ; SEA/MJM - DRIVER FOR MENUMAN (PART 2) ;08/28/08  13:20
 ;;8.0;KERNEL;**1,15,59,67,46,151,170,242,446**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 S DIC=19,DIC(0)="AEQM" D ^DIC Q:Y<0  S (XQDIC,XQY)=+Y K DIC,XQUR,Y,^VA(200,DUZ,202.1)
 D INIT^XQ12
 G M^XQ
 ;
KILL K D,D0,D1,DA,DIC,DIE,DIR,DIS,DR,XQI,XQV,XQW,XQZ
 D CLEAN^DILF
 ;
OUT ;Exit point for all option types
 S U="^"
 I $D(XQXFLG("ZEBRA")) L ^XWB("SESSION",XQXFLG("ZEBRA")):15 ;Clear by setting new lock
 E  L  ;Clear the lock table
 ;
 I $D(ZTQUEUED),'$D(XQUIT) D
 .N XQF
 .S XQF=$S('$D(^DIC(19,XQY,15)):0,'$L(^(15)):0,1:1)
 .X:XQF ^(15)
 .Q
 Q:$D(ZTQUEUED)  ;Quit here if it's a Taskman job
 ;
 I '$D(DT)!('$D(DTIME))!('$D(DUZ))!('$D(DUZ(0)))!('$D(DUZ("AG")))!('$D(DUZ("AUTO"))) D DVARS^XQ12
 I $D(DUZ("AUTO")),DUZ("AUTO"),$D(XQY),$D(^DIC(19,+XQY,0))#2,$P(^(0),"^",11)["y" W !!,*7,"Press RETURN to continue..." R %:DTIME
 I $D(^XUTL("XQ",$J,"RBX")) G RBX^XQ73
 I $D(^XUTL("XQ",$J,"T")) I ^("T")<0 S ^("T")=$S($D(^XUTL("XQ",$J,1)):1,1:0)
 I $D(^XUTL("XQ",$J,"T")) S XQY=+^(^("T")),XQT="" S:$D(^DIC(19,+XQY,0)) XQT=$P(^(0),U,4) I '$D(XQUIT),("LOQX"'[XQT),$D(^DIC(19,XQY,15)),$L(^(15)) X ^(15) ;W "  ==> OUT^XQ1"
 Q:'$D(^XUTL("XQ",$J,"T"))
 I $D(^XUTL("XQ",$J,"T")) S XQTT=$S($D(XQUIT):^XUTL("XQ",$J,"T"),1:^XUTL("XQ",$J,"T")-1) K XQUIT
 I XQTT'<1 S ^XUTL("XQ",$J,"T")=XQTT,XQY=^(XQTT),XQY0=$P(XQY,U,2,999),XQPSM=$P(XQY,U,1),XQY=+XQPSM,XQPSM=$P(XQPSM,XQY,2,99),XQABOLD=1
 I XQTT=0 S XQY=-1
 I $P(XQY0,U,4)="M" S XQAA=$P(XQY0,U,2) I $P(XQY0,U,17),$D(^DIC(19,+XQY,26)),$L(^(26)) X ^(26) ;W "  ==> OUT^XQ1"
 K %,X,XQDICNEW,XQF,XQCO,XQEA,XQFLG,XQI,XQJ,XQJS,XQK,XQLOK,XQNOPE,XQOK,XQTT,XQX,XQZ,Y,Z
 G M1^XQ
 ;
A ;ACTION type option entry point
 X:$D(^DIC(19,+XQY,20)) ^(20) ;W "  ==> A^XQ1"
 I $D(XQUIT) S XQUIT=1 D ^XQUIT I $D(XQUIT) K XQUIT G OUT
 I $P(XQY0,U,17),$D(^DIC(19,XQY,26)),$L(^(26)) X ^(26) ;W "  ==> A^XQ1"
 G OUT
 ;
C ;ScreenMan type options
 D DIC G:DA=-1 KILL S XQZ="DR,DDSFILE,DDSFILE(1)",XQW=39 D SET
 S DDSPAGE=$P($G(^DIC(19,+XQY,43)),U) K:DDSPAGE="" DDSPAGE
 S DDSPARM=$P($G(^DIC(19,+XQY,43)),U,2) K:DDSPARM="" DDSPARM
 I DDSFILE["(",DDSFILE'[U S DDSFILE=U_DDSFILE
 I $D(DDSFILE(1)),DDSFILE(1)["(",DDSFILE(1)'[U S DDSFILE(1)=U_DDSFILE(1)
 D ^DDS K DDSFILE G C
 ;
P ;PRINT type option
 S XQZ="DIC,PG,L,FLDS,BY,FR,TO,DHD,DCOPIES,DIS(0),IOP,DHIT,DIOBEG,DIOEND",XQW=59 D SET
 I $D(DIS(0))#2 F XQI=1:1:3 Q:'$D(^DIC(19,+XQY,69+(XQI/10)))  Q:^(69+(XQI/10))=""  S DIS(XQI)=^(69+(XQI/10))
 S:$D(XQIOP) IOP=XQIOP
 S XQI=$G(^DIC(19,XQY,79)) S:XQI>0 DIASKHD="" S:$P(XQI,U,2) DISUPNO=1 S:$P(XQI,U,3) DIPCRIT=1
 D D1,EN1^DIP K IOP,DIOBEG,DIS,DP G OUT
 ;
I ;INQUIRE type option
I1 D DIC G KILL:DA=-1 S DI=DIC,XQZ="DIC,DR,DIQ(0)",XQW=79 D SET,D1 S:$D(DIC)[0 DIC=DI
 I $D(^DIC(19,+XQY,63)),$L(^(63)) S FLDS=^(63)
 E  S FLDS="[CAPTIONED]"
 I $G(^DIC(19,+XQY,83))["Y" S IOP="HOME"
I2 ;
 W ! S XQZ="DHD",XQW=66 D SET K ^UTILITY($J),^(U,$J) S ^($J,1,DA)="",@("L=+$P("_DI_"0),U,2)"),DPP(1)=L_"^^^@",L=0,C=",",Q="""",DPP=1,DPP(1,"IX")="^UTILITY(U,$J,"_DI_"^2" D N^DIP1 S Y=XQY G I1
 ;
E ;EDIT type option entry point
E1 D DIC G KILL:DA=-1 K DIE,DIC S XQZ="DIE,DR",XQW=49 D SET S XQZ="DIE(""W"")",XQW=53 D SET
 I $D(^DIC(19,XQY,53)),$L(^(53)) S %=^(53),DIE("NO^")=$S(%="N":"",1:%)
 ;S:DIE["(" DIE=U_DIE
 ;
 ;DIE does not lock so we do it here
 ;
 S XQLOK="",XQNOPE=0
 I DIE["(" D
 .S DIE=U_DIE
 .S XQLOK=DIE_DA_")" L +@XQLOK:2
 .I '$T S XQNOPE=1 W !,"Someone else is editing this data.  Try later."
 .Q
 ;
 I DIE=+DIE D
 .N %
 .S %=$$ROOT^DILFD(DIE)
 .I %'="" S XQLOK=%_DA_")" L +@XQLOK:2
 .I '$T S XQNOPE=1 W !,"Someone else is editing this data.  Try later."
 .Q
 ;
 G:XQNOPE E1  ;Node is being edited right now, skip DIE
 D ^DIE S Y=XQY
 I XQLOK'="" L -@XQLOK
 G E1
 ;
 ;
DIC ;Get FileMan parameters from Option File and do look up
 W ! K DIC S XQZ="DIC,DIC(0),DIC(""A""),DIC(""B""),DIC(""S""),DIC(""W""),D",XQW=29 D SET,D1
 I '$D(D) D ^DIC
 I $D(D) S:D="" D="B" D IX^DIC
 I $D(Y),Y>0,$P(Y,U,3) S XQDICNEW=Y
 S DA=+Y,Y=XQY
 Q
 ;
D1 S:DIC["(" DIC=U_DIC Q
 ;
SET F XQI=1:1 S XQV=$P(XQZ,",",XQI) Q:XQV=""  K @XQV I $D(^DIC(19,+XQY,XQW+XQI)),^(XQW+XQI)]"" S @XQV=^(XQW+XQI)
 I $D(DIC("A")),DIC("A")]"" S DIC("A")=DIC("A")_" "
 K XQI,J
 Q
 ;
R ;RUN ROUTINE type option entry point
 G:'$D(^DIC(19,XQY,25)) OUT:$D(ZTQUEUED),M1^XQ S XQZ=^(25) G:'$L(XQZ) M1^XQ S:XQZ'[U XQZ=U_XQZ I XQZ["[" D DO^%XUCI G OUT
 D @XQZ G OUT
 ;
W ;Window type option entry point
 S XQOK=1
 I $D(^DIC(19,XQY,25)),$L(^(25)) D  G OUT ;Routine type
 .S XQZ=^DIC(19,XQY,25)
 .S:XQZ'[U XQZ=U_XQZ
 .I XQZ["[" D DO^%XUCI Q
 .D @XQZ
 .Q
 ;
 ;I $D(^DIC(19,XQY,24)),$L(^(24)) D  G:XQOK OUT ;Pointer type
 ;.S XQZ=^DIC(19,XQY,24)
 ;.S XQZ=$P($G(^XTV(8995,XQZ,0)),U) I XQZ="" S XQOK=0 Q
 ;.D PREP^XG
 ;.S XQWIN=$$NEXTNM^XGCLOAD("XQWIN")
 ;.D GET^XGCLOAD(XQZ,XQWIN,"^TMP($J)")
 ;.D GET^XGCLOAD(XQZ,$NA(^TMP($J,XQWIN)))
 ;.D M^XG(XQWIN,$NA(^TMP($J,XQWIN)))
 ;.D ESTA^XG() ;Send it off to window land
 ;.;
 ;.D K^XG(XQWIN) ;Return here after the ESTOP
 ;.;I $D(^%ZOSF("OS")),^%ZOSF("OS")["MSM" ZSTOP
 ;.Q
 ;
 G M1^XQ ;Window failed
 ;
Z ;Window suite option
 G EN^XQSUITE
 ;
S ;Server-type option pseudo entry-point can't be invoked from Meun System
 G OUT
 ;
B ;Client/Server option can't be run from menu system
 G OUT
 ;
L ;OE/RR Limited option
O ;OE/RR Protocol (orderables) type option entry point
X ;OE/RR Extended Action type option (Subset of Protocol type)
Q ;OE/RR Protocol Menu type option entry point
 S XQOR=+XQY,XQOR(1)=XQT D XQ^XQOR K XQOR G OUT
 ;
ZTSK ;Task Manager entry point
 S U="^" G:$G(XQSCH)'>0 ZTSK2 ;No reschedule
 S %=$$S^%ZTLOAD("Reschedule Task")
 S XQ=$G(^DIC(19.2,XQSCH,0)),XQY=+XQ Q:XQY'>0
 K ZTQPARAM ;Build params from schedule in case we delete it.
 I $D(^DIC(19.2,XQSCH,3)),$L(^(3)) S ZTQPARAM=^(3)
 I $D(^DIC(19.2,XQSCH,2)) D  ;Build other symbols
 . N X1,X2 S X2=XQSCH N XQSCH,XQY,XQ
 . F X1=0:0 S X1=$O(^DIC(19.2,X2,2,X1)) Q:X1'>0  S X=^(X1,0),@($P(X,U)_"="_$P(X,U,2))
 . Q
 ;
 S X=$P($G(^DIC(19.2,XQSCH,1.1)),U) I X>0 D DUZ^XUP(X) ;User to run job ;p446
REQ D  ;Set the user and Requeue
 . N DA,DIE,DR,X,X1,X2
 . S X1=$P(XQ,U,2),X2=$P(XQ,U,6) ;Get params for new schedule
 . S DA=XQSCH,DIE="^DIC(19.2,",DR=$S((X2="")&($P(XQ,U,9)=""):".01///@",X2="":"2///@",1:"2////"_$$SCH^XLFDT(X2,+X1,1))
 . L +^%ZTSK(ZTSK,0):15 D ^DIE L -^%ZTSK(ZTSK,0) ;File new schedule
 . Q
 ;ZTREQ is set by TM.
ZTSK2 I '$D(XQY) K ZTREQ Q  ;Leave task
 D UI^XQ12
 Q:'$D(^DIC(19,XQY,0))  S XQY0=^(0),XQT=$P(XQY0,U,4) Q:XQT'="A"&(XQT'="P")&(XQT'="R")
 ;Kernel no longer supports reseting priority
 ;S X=$P(XQY0,U,8) I X>0,X<11 X ^%ZOSF("PRIORITY")
 I $P(XQY0,U,3)]""!($D(XQUIT)) S XQT="KILL"
 ;
 S %=$$S^%ZTLOAD("Run Task")
RUN S:XQT="P"&$L(IO) XQIOP=ION_";"_IOST_";"_IOM_";"_IOSL G @XQT
 Q
