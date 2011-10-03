SDRRCRR ;10N20/MAH;clinic recall list report; 11/8/2006
 ;;5.3;Scheduling;**536**;Aug 13, 1993;Build 53
STR K DIR,Y,DTOUT,DIROUT,DIRUT,DUOUT,Q,X
 S DIR(0)="SO^1:All Clinics;2:Selected Clinics;3:Selected Team"
 W ! S DIR("A")="Please select what type of Clinic Recall List you are looking for"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)!($D(DIRUT))) QUIT S Q=Y
 I Q=1 K DIR D DATE,EN G QUIT
 I Q=2 K DIR D DATE,EN1 G QUIT
 I Q=3 K DIR D DATE G EN2^SDRRCRR1
DATE ;SETS UP TO FROM DATE AND WILL GROUP BY MONTH IF SELECTED MULTIPLE MONTHS
 S %DT="AEX",%DT("A")="Start with Recall Date First: " D ^%DT G:Y<0 STR S SDT=Y K Y
 S %DT("A")="Recall Date Lasted: " D ^%DT I Y<SDT W $C(7),"  Can't be before Recall Date First - Try Again" G DATE
 Q:Y<0  S EDT=Y K Y
 Q
EN ;all clinics by division
 Q:'$D(SDT)
 W ! S SDEND=1 D ASK2^SDDIV G:Y<0 QUIT
 I VAUTD=1 G ENDIV
 I VAUTD=0 G ONDIV
 Q
ENDIV ;
 W !!,"***This report requires 132 columns",!! S %ZIS="QM" D ^%ZIS G:POP QUIT
 I $D(IO("Q")) S ZTDESC="Print Recall List for Division",ZTRTN="EDIV^SDRRCRR" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
EDIV K ^TMP($J,"ENDIV")
 S (PRO,PRO1,PRO2,RDT,CDT,CDT1,PAT,PHONE,CLINIC,COMMENT)=""
 S ZPR=0 F  S ZPR=$O(^SD(403.5,"C",ZPR)) Q:ZPR=""  S DIV=$P($G(^SD(403.54,ZPR,0)),"^",3) S D0=0 F  S D0=$O(^SD(403.5,"C",ZPR,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S RDT=$P($G(DTA),"^",6) Q:RDT=""
 .Q:RDT<SDT!(RDT>EDT)
 .S MONTH=$E(RDT,4,5),YR=$E(RDT,2,3)
 .S CLINIC=$P($G(DTA),"^",2) I CLINIC'="" S CLINIC=$$GET1^DIQ(44,CLINIC_",",.01)
 .I CLINIC="" S CLINIC="Unknown Clinic"  ;CLINIC
 .S Y=RDT D DD^%DT S DATE=Y K Y  ;RECALL DATE
 .S PAT=$P($G(DTA),"^",1)
 .Q:$$TESTPAT^VADPT(PAT)
 .S DFN=PAT
 .D ADD^VADPT,DEM^VADPT
 .S LN=$E(VADM(1),1)_$P(VA("BID"),U)
 .S PAT1=$P(VADM(1),U)
 .S (CDT,CDT1)="",Y=$P($G(DTA),"^",10) I Y'="" D DD^%DT S CDT=Y K Y D
 ..S Z=$P($G(DTA),"^",13) I Z'=""
 ..S CDT1="*"_CDT K Z
 ..I CDT1'="" S CDT=CDT1
 .I CDT="" S CDT="NotSent"
 .S PHONE=$P(VAPA(8),U)
 .I PHONE="" S PHONE="Unk. Phone"  ;phone
 .S COMMENT=$P($G(DTA),"^",7)
 .S PRO=$P($G(DTA),"^",5) I PRO'="" S PRO1=$P($G(^SD(403.54,PRO,0)),"^",1)
 .I PRO1'="" S PRO2=$$NAME^XUSER(PRO1,"F")
 .I PRO="" S PRO2="Unk. Provider"
 .S USER=$P($G(DTA),"^",11) I USER'="" S USER1=$$NAME^XUSER(USER)
 .I USER="" S USER1="Unk. User"
 .S ^TMP($J,"ENDIV",DIV,CLINIC,PRO2,MONTH,RDT,PAT1)=CLINIC_"^"_PRO2_"^"_DATE_"^"_CDT_"^"_PAT1_"^"_PHONE_"^"_COMMENT_"^"_USER1_"^"_LN
 .K CLINIC,USER,PRO,PAT,RDT,CDT,CDT1
 D PRT1^SDRRCRRP
 D ^%ZISC
 G QUIT
ONDIV ;
 W !!,"***This report requires 132 columns",!! S %ZIS="QM" D ^%ZIS G:POP QUIT
 I $D(IO("Q")) S ZTIO=ION,ZTDESC="Print Recall List for Division",ZTRTN="ONDIV1^SDRRCRR" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
ONDIV1 ;
 K ^TMP($J,"ONDIV")
 U IO
 S (PRO,RDT,CDT,CDT1,PAT,PHONE,CLINIC,COMMENT)=""
 S DIV=0
 F  S DIV=$O(VAUTD(DIV)) Q:DIV=""  D
 .S ZPR=0 F  S ZPR=$O(^SD(403.5,"C",ZPR)) Q:ZPR=""  I $P($G(^SD(403.54,ZPR,0)),"^",3)=DIV S D0=0 F  S D0=$O(^SD(403.5,"C",ZPR,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 ..S RDT=$P($G(DTA),"^",6) Q:RDT=""
 ..Q:RDT<SDT!(RDT>EDT)
 ..S MONTH=$E(RDT,4,5),YR=$E(RDT,2,3)
 ..S CLINIC=$P($G(DTA),"^",2) I CLINIC'="" S CLINIC=$$GET1^DIQ(44,CLINIC_",",.01)
 ..I CLINIC="" S CLINIC="Unknown Clinic"  ;CLINIC
 ..S Y=RDT D DD^%DT S DATE=Y K Y  ;RECALL DATE
 ..S PAT=$P($G(DTA),"^",1)
 ..Q:$$TESTPAT^VADPT(PAT)
 ..S DFN=PAT
 ..D ADD^VADPT,DEM^VADPT
 ..S LN=$E(VADM(1),1)_$P(VA("BID"),U)
 ..S PAT1=$P(VADM(1),U)
 ..S (CDT,CDT1)="",Y=$P($G(DTA),"^",10) I Y'="" D DD^%DT S CDT=Y K Y
 ..S Z=$P($G(DTA),"^",13) I Z'="" S CDT1="*"_CDT K Z D
 ...I CDT1'="" S CDT=CDT1
 .. I CDT="" S CDT="NotSent"
 ..S PHONE=$P(VAPA(8),U)
 ..I PHONE="" S PHONE="Unk. Phone"  ;phone
 ..S COMMENT=$P($G(DTA),"^",7)
 ..S PRO=$P($G(DTA),"^",5) I PRO'="" S PRO1=$P($G(^SD(403.54,PRO,0)),"^",1),PRO2=$$NAME^XUSER(PRO1,"F")
 ..I PRO="" S PRO2="Unk. Provider"
 ..S USER=$P($G(DTA),"^",11) I USER'="" S USER1=$$NAME^XUSER(USER)
 ..I USER="" S USER1="Unk. User"
 ..S ^TMP($J,"ONDIV",DIV,CLINIC,PRO2,MONTH,RDT,PAT1)=CLINIC_"^"_PRO2_"^"_DATE_"^"_CDT_"^"_PAT1_"^"_PHONE_"^"_COMMENT_"^"_USER1_"^"_LN
 ..K CLINIC,USER,PRO,PAT,RDT,CDT,CDT1
 D PRT^SDRRCRRP
 D ^%ZISC
 G QUIT
EN1 ;BY CLINIC SELECTED CLINIC
 Q:'$D(SDT)
 N VAUTSTR,VAUTVB
 S DIC="^SC(",VAUTVB="VAUTC",VAUTSTR="clinic",VAUTNI="1"     ;G FIRST^VAUTOMA
 S DIC(0)="EQMNZ",DIC("A")="Select "_VAUTSTR_": " K @VAUTVB S (@VAUTVB,Y)=0
REDO N VAERR,VAI,VAUTNALL,VAUTX
 W !,DIC("A") W:'$D(VAUTNALL) "ALL// " R X:DTIME G QUIT:(X="^")!'$T D:X["?" QQ I X="" G:$D(VAUTNALL) QUIT S @VAUTVB=1 G CLIN
 S DIC("A")="Select another "_VAUTSTR_": " D ^DIC G:Y'>0 REDO D SET
 F VAI=1:0:19 W !,DIC("A") R X:DTIME G QUIT:(X="^")!'$T K Y Q:X=""  D QQ:X["?" S:$E(X)="-" VAUTX=X,X=$E(VAUTX,2,999) D ^DIC I Y>0 D SET G:VAX REDO S:'VAERR VAI=VAI+1
CLIN ;
 I VAUTC=1 G ENCLIN
 I VAUTC=0 G ONCLIN
 Q
QQ W !!,"Please select up to 20 clinics that you would like to print"
 Q
ONCLIN  W !!,"***This report requires 132 columns",!! S %ZIS="QM" D ^%ZIS G:POP QUIT
 I $D(IO("Q")) S ZTIO=ION,ZTDESC="Print Recall List for Clinics",ZTRTN="ONCLIN1^SDRRCRR" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
ONCLIN1 ;
 K ^TMP($J,"ONCLIN")
 S (PRO,RDT,CDT,CDT1,PAT,PHONE,CLINIC,COMMENT)=""
 S DIV=0
 F  S DIV=$O(VAUTC(DIV)) Q:DIV=""  S ZPR=$P(VAUTC(DIV),"^",1) D
 .S D0=0 F  S D0=$O(^SD(403.5,"E",ZPR,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 ..S RDT=$P($G(DTA),"^",6) Q:RDT=""
 ..Q:RDT<SDT!(RDT>EDT)
 ..S MONTH=$E(RDT,4,5),YR=$E(RDT,2,3)
 ..S CLINIC=$P($G(DTA),"^",2) Q:CLINIC'=ZPR  I CLINIC'="" S CLINIC=$$GET1^DIQ(44,CLINIC_",",.01)
 ..I CLINIC="" S CLINIC="Unknown Clinic"  ;CLINIC
 ..S Y=RDT D DD^%DT S DATE=Y K Y  ;RECALL DATE
 ..S PAT=$P($G(DTA),"^",1)
 ..Q:$$TESTPAT^VADPT(PAT)
 ..S DFN=PAT
 ..D ADD^VADPT,DEM^VADPT
 ..S LN=$E(VADM(1),1)_$P(VA("BID"),U)
 ..S PAT1=$P(VADM(1),U)
 ..S CDT="",Y=$P($G(DTA),"^",10) I Y'="" D DD^%DT S CDT=Y K Y
 ..S Z=$P($G(DTA),"^",13) I Z'="" S CDT1="*"_CDT K Z D
 ...I CDT1'="" S CDT=CDT1
 ..I CDT="" S CDT="NotSent"
 ..S PHONE=$P(VAPA(8),U)
 ..I PHONE="" S PHONE="Unk. Phone"  ;phone
 ..S COMMENT=$P($G(DTA),"^",7)
 ..S PRO=$P($G(DTA),"^",5) I PRO'="" S PRO1=$P($G(^SD(403.54,PRO,0)),"^",1),PRO2=$$NAME^XUSER(PRO1,"F")
 ..I PRO="" S PRO2="Unk. Provider"
 ..S USER=$P($G(DTA),"^",11) I USER'="" S USER1=$$NAME^XUSER(USER)
 ..I USER="" S USER1="Unk. User"
 ..S ^TMP($J,"ONCLIN",DIV,CLINIC,PRO2,MONTH,RDT,PAT1)=CLINIC_"^"_PRO2_"^"_DATE_"^"_CDT_"^"_PAT1_"^"_PHONE_"^"_COMMENT_"^"_USER1_"^"_LN
 ..K CLINIC,USER,PRO,PAT,RDT,CDT,CDT1
 D PRT2^SDRRCRRP
 D ^%ZISC
 G QUIT
 ;by division works fine
ENCLIN  W !!,"***This report requires 132 columns",!! S %ZIS="QM" D ^%ZIS Q:POP 
 I $D(IO("Q")) D ^%ZIS G:POP QUIT S ZTIO=ION,ZTDESC="Print Recall List for Clinics",ZTRTN="ENCLIN1^SDRRCRR" S ZTSAVE("*")="" D ^%ZTLOAD G QUIT
ENCLIN1 ;
 K ^TMP($J,"ENCLIN")
 S (PRO,RDT,CDT,CDT1,PAT,PHONE,CLINIC,COMMENT)=""
 S ZPR=0 F  S ZPR=$O(^SD(403.5,"E",ZPR)) Q:ZPR=""  S D0=0 F  S D0=$O(^SD(403.5,"E",ZPR,D0)) Q:D0=""  S DTA=$G(^SD(403.5,D0,0)) D:DTA]""
 .S RDT=$P($G(DTA),"^",6) Q:RDT=""
 .Q:RDT<SDT!(RDT>EDT)
 .S MONTH=$E(RDT,4,5),YR=$E(RDT,2,3)
 .S CLINIC=$P($G(DTA),"^",2),DIV=CLINIC I CLINIC'="" S CLINIC=$$GET1^DIQ(44,CLINIC_",",.01)
 .I DIV="" S DIV="Unknown"
 .I CLINIC="" S CLINIC="Unknown Clinic"  ;CLINIC
 .S Y=RDT D DD^%DT S DATE=Y K Y  ;RECALL DATE
 .S PAT=$P($G(DTA),"^",1)
 .Q:$$TESTPAT^VADPT(PAT)
 .S DFN=PAT
 .D ADD^VADPT,DEM^VADPT
 .S LN=$E(VADM(1),1)_$P(VA("BID"),U)
 .S PAT1=$P(VADM(1),U)
 .S (CDT,CDT1)="",Y=$P($G(DTA),"^",10) I Y'="" D DD^%DT S CDT=Y K Y
 .S Z=$P($G(DTA),"^",13) I Z'="" S CDT1="*"_CDT K Z D
 ..I CDT1'="" S CDT=CDT1
 .I CDT="" S CDT="NotSent"
 .S PHONE=$P(VAPA(8),U)
 .I PHONE="" S PHONE="Unk. Phone"  ;phone
 .S COMMENT=$P($G(DTA),"^",7)
 .S PRO=$P($G(DTA),"^",5) I PRO'="" S PRO1=$P($G(^SD(403.54,PRO,0)),"^",1),PRO2=$$NAME^XUSER(PRO1,"F")
 .I PRO="" S PRO2="Unk. Provider"
 .S USER=$P($G(DTA),"^",11) I USER'="" S USER1=$$NAME^XUSER(USER)
 .I USER="" S USER1="Unk. User"
 .S ^TMP($J,"ENCLIN",DIV,CLINIC,PRO2,MONTH,RDT,PAT1)=CLINIC_"^"_PRO2_"^"_DATE_"^"_CDT_"^"_PAT1_"^"_PHONE_"^"_COMMENT_"^"_USER1_"^"_LN
 .K CLINIC,USER,PRO,PAT,RDT,CDT,CDT1
 D PRT3^SDRRCRRP
 D ^%ZISC
  G QUIT
 ;BY CLINICS WORK FINE
SET S VAX=0 I $D(VAUTX) S J=$S(VAUTNI=2:+Y,1:$P(Y(0),"^")) K VAUTX S VAERR=$S($D(@VAUTVB@(J)):0,1:1) W $S('VAERR:"...removed from list...",1:"...not on list...can't remove") Q:VAERR  S VAI=VAI-1 K @VAUTVB@(J) S:$O(@VAUTVB@(0))']"" VAX=1 Q
 S VAERR=0 I $S($D(@VAUTVB@($P(Y(0),U))):1,$D(@VAUTVB@(+Y)):1,1:0) W !?3,*7,"You have already selected that ",VAUTSTR,".  Try again." S VAERR=1
 I VAUTNI=1 S @VAUTVB@($P(Y(0),U))=+Y Q
 I VAUTNI=3 S @VAUTVB@($P(Y(0,0),U))=+Y Q
 S @VAUTVB@(+Y)=$P(Y(0),U) Q
QUIT K DIR,Y,SDT,EDT,X,D0,COMMENT,DATE,DIC,I,DTA,DIV,J,LN,MONTH,PAT1,PHONE,POP,PRO1,PRO2,Q,SDEND,SSN,USER1,%,VAUTC,VAUTD,VA,YR,ZPR,VAUTNI
 K ZTDESC,ZTIO,ZTRTN,ZTSAVE,%DT,%ZIS,DFN,VAX,VADM,VAPA
 D KVAR^VADPT
 Q
