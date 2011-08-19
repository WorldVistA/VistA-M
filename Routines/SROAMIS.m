SROAMIS ;BIR/MAM - ANESTHESIA AMIS REPORT ;11/26/07
 ;;3.0; Surgery ;**22,34,38,77,50,86,166**;24 Jun 93;Build 6
UTL ; set up ^TMP("SROAMIS",$J
 S PRIN=$P($G(^SRF(SRDFN,.3)),"^",8) I PRIN="" S PRIN="O"
 S PROC=$S($D(^SRF(SRDFN,31)):$P(^(31),"^",9),1:""),DEATH=""
 S:PRIN="O" TECH="L" I TECH="L",PRIN'="O" S TECH="O"
 S S(0)=^SRF(SRDFN,0),DFN=$P(S(0),"^") S DEATH=$S('$D(^DPT(DFN,.35)):"",$P(^DPT(DFN,.35),"^")="":"",1:$P(^(.35),"^"))
 I +DEATH S:$D(^TMP("SRTN",$J,DFN)) DEATH="" I +DEATH D DEAD
 S $P(^TMP("SROAMIS",$J,"T",TECH),"^")=^TMP("SROAMIS",$J,"T",TECH)+1 I DEATH'="" S $P(^(TECH),"^",2)=$P(^(TECH),"^",2)+1
 I PROC'="Y" S $P(^TMP("SROAMIS",$J,"P","SURG",PRIN),"^")=$P(^TMP("SROAMIS",$J,"P","SURG",PRIN),"^")+1 S:DEATH'="" $P(^(PRIN),"^",2)=$P(^(PRIN),"^",2)+1
 I PROC="Y" S $P(^TMP("SROAMIS",$J,"P","DIAG",PRIN),"^")=$P(^TMP("SROAMIS",$J,"P","DIAG",PRIN),"^")+1 S:DEATH'="" $P(^(PRIN),"^",2)=$P(^(PRIN),"^",2)+1
 Q
SET ; get anesthesia info from ^SRF(SRDFN,6
 K SRTECH S (SRCNT,SRT,SRZ)=0,SRTN=SRDFN F  S SRT=$O(^SRF(SRDFN,6,SRT)) Q:SRT=""!(SRZ)  D ^SROPRIN S SRCNT=SRCNT+1
 I '$D(SRTECH),SRCNT=1 S SRT=$O(^SRF(SRTN,6,0)),SRTECH=$P(^SRF(SRTN,6,SRT,0),"^")
 K SRTN I $D(SRTECH) Q:SRTECH="N"  S TECH=SRTECH D UTL
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,!,?57,"ANESTHESIA SERVICE",?100,"REVIEWED BY: ",!,?58,"ANESTHESIA AMIS",?100,"DATE REVIEWED: "
 W !,?(132-$L(SRFRTO)\2),SRFRTO,?100,SRPRINT
 W !!!!! F I=1:1:IOM W "="
 W !,?38,"ANESTHETICS ADMINISTERED BY PRINCIPAL TECHNIQUE USED",! F I=1:1:IOM W "-"
 W !,"TOTAL NO OF ANES-       |             |             |             |             |             |"
 W !,"THETICS ADMINISTERED    |   GENERAL   |   MAC       |   SPINAL    |   EPIDURAL  |   OTHER     |   LOCAL",! F I=1:1:IOM W "-"
 Q
END W:$E(IOST)="P" @IOF K ^TMP("SROAMIS",$J),^TMP("SRTN",$J) I $D(ZTQUEUED) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 D ^%ZISC,^SRSKILL W @IOF
 Q
DEAD ; check for death within 24 hrs.
 S OPDATE=$S($D(^SRF(SRDFN,.2)):$P(^(.2),"^"),1:"") S:OPDATE="" OPDATE=$P(^SRF(SRDFN,0),"^",9) S X1=OPDATE,X2=1 D C^%DTC S OPONE=X S DEATH=$S(DEATH<(OPONE+.0001):1,1:"")
 I DEATH S ^TMP("SRTN",$J,DFN)=""
 Q
EN ; entry for SROAMIS option
 W @IOF,!,"Anesthesia AMIS",!!,"This report is no longer available.",!
 K DIR S DIR(0)="E" D ^DIR K DIR D END
 Q
DATE D DATE^SROUTL(.SDATE,.EDATE,.SRSOUT) G:SRSOUT END S SRD=SDATE-.0001
 N SRINSTP S SRINST=$$INST^SROUTL0() G:SRINST="^" END S SRINSTP=$P(SRINST,U),SRINST=$S(SRINST["ALL DIVISIONS":SRINST,1:$P(SRINST,U,2))
 W !!!,"This report is designed to use a 132 column format, and must be run",!,"on a printer.",!!
PTR K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Select Printer: ",%ZIS="QM" D ^%ZIS G:POP END W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" PTR
 I $D(IO("Q")) K IO("Q") S ZTDESC="ANESTHESIA AMIS",ZTRTN="1^SROAMIS",(ZTSAVE("EDATE"),ZTSAVE("SDATE"),ZTSAVE("SRD"),ZTSAVE("SRINST"),ZTSAVE("SRINSTP"))="" D ^%ZTLOAD G END
1 ; entry when queued
 U IO N SRFRTO K ^TMP("SROAMIS",$J),^TMP("SRTN",$J) S SRSOUT=0,Y=DT X ^DD("DD") S SRPRINT="DATE PRINTED: "_Y
 S Y=SDATE X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: ",Y=EDATE X ^DD("DD") S SRFRTO=SRFRTO_Y
 F I="G","M","S","E","O","L" S ^TMP("SROAMIS",$J,"T",I)=0 F I="A","N","O" S ^TMP("SROAMIS",$J,"P","DIAG",I)=0,^TMP("SROAMIS",$J,"P","SURG",I)=0 K I
 S SRDFN=0,Z=SRD F  S Z=$O(^SRF("AC",Z)) Q:Z>(EDATE+.9999)!(Z="")  F  S SRDFN=$O(^SRF("AC",Z,SRDFN)) Q:SRDFN=""  D
 .I $D(^SRF(SRDFN,0)),$P($G(^SRF(SRDFN,.2)),"^",12)'=""!($P($G(^SRF(SRDFN,"NON")),"^")="Y"),$$MANDIV^SROUTL0(SRINSTP,SRDFN) D SET
 D HDR G:SRSOUT END D PRINT^SROAMIS1
 G END
