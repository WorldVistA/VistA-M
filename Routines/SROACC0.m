SROACC0 ;BIR/MAM - CPT ACCURACY SORT BY SPECIALTY ;05/13/99  2:33 PM
 ;;3.0; Surgery ;**50,88,142**;24 Jun 93
DEV W !!,"This report is designed to use a 132 column format.",!!
 K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Select Device: ",%ZIS="QM" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTRTN="EN^SROACC0",(ZTSAVE("SRSS"),ZTSAVE("SDATE*"),ZTSAVE("EDATE*"),ZTSAVE("SRCPT"),ZTSAVE("SRFLG"),ZTSAVE("SRSITE*"))="",ZTDESC="REPORT TO CHECK CPT CODING ACCURACY" D ^%ZTLOAD G END
EN ; entry when queued
 K ^TMP("SR",$J) U IO S SRSOUT=0,SRPAGE=1,SRINST=SRSITE("SITE")
 N SRFRTO S Y=SDATE X ^DD("DD") S SRFRTO="FROM: "_Y_"  TO: " S Y=EDATE X ^DD("DD") S SRFRTO=SRFRTO_Y
 I SRCPT="ALL",SRSS="ALL" D ^SROACC1 G END
 I SRCPT="ALL",SRSS D ^SROACC2 G END
 I SRCPT,SRSS="ALL" D ^SROACC3 G END
 D ^SROACC4
END W:$E(IOST)="P" @IOF I $D(ZTQUEUED) K ^TMP("SR",$J) Q:$G(ZTSTOP)  S ZTREQ="@" Q
 I 'SRSOUT,$E(IOST)'="P" W !!,"Press RETURN to continue  " R X:DTIME
 D ^%ZISC W @IOF K SRTN D ^SRSKILL
 Q
HDR ; print heading
 I SRHDR,$E(IOST)'="P" W !!,"Press RETURN to continue, or '^' to quit:  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?126,"PAGE",!,?58,"SURGICAL SERVICE",?126,$J(SRPAGE,4),!,?51,"REPORT OF CPT CODING ACCURACY",?100,"REVIEWED BY:"
 W ! W:SRSS'="" ?(132-$L("FOR "_SRSS)\2),"FOR "_SRSS W ?100,"DATE REVIEWED:"
 W !,?(132-$L(SRFRTO)\2),SRFRTO
 W !,$S(SRFLG=1:"O.R. SURGICAL PROCEDURES",SRFLG=2:"NON-O.R. PROCEDURES",1:"O.R. SURGICAL PROCEDURES AND NON-O.R. PROCEDURES")
 W !!,?1,"PROCEDURE DATE",?20,"PATIENT",?60,"PROCEDURES",?111,"SURGEON/PROVIDER",!,?3,"CASE #",?22,"ID#",?111,"ATTEND SURG/PROV"
 S SRHDR=1,SRPAGE=SRPAGE+1 Q
SPEC W !!!,"Do you want to print the Report to Check Coding Accuracy for all",!,"Surgical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to print the report for all specialties, or 'NO'",!,"to select a specific Surgical Specialty.",!!,"Press RETURN to continue  " R X:DTIME G SPEC
 S SRSS="ALL" I "Nn"[SRYN W !! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the Coding Accuracy Report for which Surgical Specialty ?  " D ^DIC S:Y<0 SRSOUT=1 G:Y<0 END S SRSS=+Y
 D DEV Q
MSP I SRFLG=3 S SRSS="ALL" G DEV
 W !!!,"Do you want to print the Report to Check Coding Accuracy for all",!,"Medical Specialties ?  YES//  " R SRYN:DTIME I '$T!(SRYN["^") S SRSOUT=1 G END
 S SRYN=$E(SRYN) S:SRYN="" SRYN="Y"
 I "YyNn"'[SRYN W !!,"Enter RETURN if you want to print the report for all specialties, or 'NO'",!,"to select a specific Medical Specialty.",!!,"Press RETURN to continue  " R X:DTIME G MSP
 S SRSS="ALL" I "Nn"[SRYN W !! K DIC S DIC=723,DIC(0)="QEAMZ",DIC("A")="Print the Coding Accuracy Report for which Medical Specialty ?  " D ^DIC S:Y<0 SRSOUT=1 G:Y<0 END S SRSS=+Y
 D DEV
 Q
OPER N CPT,SRCPT K SROPERS,SRCPTT S SRX=^SRF(SRTN,"OP"),SROPER=$P(SRX,"^")
 I $O(^SRF(SRTN,13,0)) S SROPER=SROPER_",  OTHER OPERATIONS: " S OTH=0 F  S OTH=$O(^SRF(SRTN,13,OTH)) Q:'OTH  D OTHER
OPERT ; patch SR*3*142 changes
 S CPT=$P($G(^SRO(136,SRTN,0)),"^",2),SRCPT=$S(CPT:$P($$CPT^ICPTCOD(CPT),"^",2),1:"CPT NOT ENTERED") S SRCPTT="CPT Codes: "_SRCPT I CPT D PMOD
 I $O(^SRO(136,SRTN,3,0)) S OTH=0 F  S OTH=$O(^SRO(136,SRTN,3,OTH)) Q:'OTH  D OTHERT
 Q
OTHER ; other procedures
 S SRLONG=1,SROPERS=$P(^SRF(SRTN,13,OTH,0),"^")
 I $L(SROPER)+$L(SROPERS)>250 S SROPER=SROPER_" ...",OTH=999 Q
 S SROPER=SROPER_$S(OTH=1:" ",1:", ")_SROPERS
 Q
OTHERT ; other procedures - file #136
 S SRLONG=1,CPT=$P($G(^SRO(136,SRTN,3,OTH,0)),"^"),SRCPT=$S(CPT:$P($$CPT^ICPTCOD(CPT),"^",2),1:"CPT NOT ENTERED") I CPT S SRCPTT=SRCPTT_", "_SRCPT D OMOD
 Q
OMOD ; Other procedure CPT modifiers - file #136
 N SRCMOD,SRCOMMA,X I $O(^SRO(136,SRTN,3,OTH,1,0)) D
 .S (SRCOMMA,SRI)=0,SRCMOD="",SRCPTT=SRCPTT_"-" F  S SRI=$O(^SRO(136,SRTN,3,OTH,1,SRI)) Q:'SRI  D
 ..S SRM=$P(^SRO(136,SRTN,3,OTH,1,SRI,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRM,"I"),"^",2)
 ..S SRCPTT=SRCPTT_$S(SRCOMMA:",",1:"")_SRCMOD,SRCOMMA=1
 Q
PMOD ; principle procedure CPT modifiers - file #136
 N SRCMOD,SRCOMMA,X I $O(^SRO(136,SRTN,1,0)) D
 .S (SRCOMMA,SRI)=0,SRCMOD="",SRCPTT=SRCPTT_"-" F  S SRI=$O(^SRO(136,SRTN,1,SRI)) Q:'SRI  D
 ..S SRM=$P(^SRO(136,SRTN,1,SRI,0),"^"),SRCMOD=$P($$MOD^ICPTMOD(SRM,"I"),"^",2)
 ..S SRCPTT=SRCPTT_$S(SRCOMMA:",",1:"")_SRCMOD,SRCOMMA=1
 Q
LOOP ; break CPT line greater than 50 characters
 S SROPT(M)="" F LOOP=1:1 S MM=$P(SRCPTT," "),MMM=$P(SRCPTT," ",2,200) Q:MMM=""  Q:$L(SROPT(M))+$L(MM)'<50  S SROPT(M)=SROPT(M)_MM_" ",SRCPTT=MMM
 Q
