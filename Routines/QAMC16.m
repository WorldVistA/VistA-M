QAMC16 ;HISC/DAD-CONDITION: REGISTRATION ;9/3/93  13:19
 ;;1.0;Clinical Monitoring System;;09/13/1993
EN1 ; *** CONDITION CODE
 S STATUS(0)=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P1"))#2:^("P1"),1:"")
 S BENEFIT(0)=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P2"))#2:^("P2"),1:"")
 S CARE(0)=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P3"))#2:^("P3"),1:"")
 S QAMDISP(0)=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P4"))#2:+^("P4"),1:0)
 F QAMREGDT=(QAMTODAY-.0000001):0 S QAMREGDT=$O(^DPT("ADIS",QAMREGDT)) Q:(QAMREGDT'>0)!(QAMREGDT\1'?7N)!(QAMREGDT>(QAMTODAY+.9999999))  F QAMDFN=0:0 S QAMDFN=$O(^DPT("ADIS",QAMREGDT,QAMDFN)) Q:QAMDFN'>0  D LOOP1
 K STATUS,BENEFIT,CARE,QAMREGDT,QAMDISP
 Q
LOOP1 S QAM=$S($D(^DPT(QAMDFN,"DIS",9999999-QAMREGDT,0))#2:^(0),1:""),STATUS=$P(QAM,"^",2),BENEFIT=$P(QAM,"^",3),CARE=$P(QAM,"^",11),QAMDISP=+$P(QAM,"^",7)
 I STATUS(0)]"" Q:(STATUS="")!(STATUS(0)'[STATUS)
 I BENEFIT(0)]"" Q:(BENEFIT="")!(BENEFIT(0)'[BENEFIT)
 I CARE(0)]"" Q:(CARE="")!(CARE(0)'[CARE)
 I QAMDISP(0) Q:$O(^QA(743.5,QAMDISP(0),"GRP","AB",QAMDISP,0))'>0
 S ^UTILITY($J,"QAM CONDITION",QAMD1,QAMDFN)="",^(QAMDFN,QAMREGDT)=QAMDFN_"^"_(9999999-QAMREGDT)
 Q
EN2 ; *** PARAMETER CODE
 K DIR S DIR(0)="LO^0:2^K:X[""."" X",DIR("A")="STATUS",DIR("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P1"))#2:^("P1"),1:"") K:DIR("B")="" DIR("B")
 S DIR("?",1)="  0  10/10 VISIT",DIR("?",2)="  1  UNSCHEDULED",DIR("?",3)="  2  APPLICATION WITHOUT EXAM",DIR("?",4)="Choose any or all that you wish to monitor, e.g. 0,1 or 0-2, etc.",DIR("?")="Press RETURN for all status types."
 S QAMPARAM="P1" D EN3^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P1")=$S($E(Y,$L(Y))=",":$E(Y,1,$L(Y)-1),1:Y)
21 K DIR S DIR(0)="LO^1:5^K:X[""."" X",DIR("A")="TYPE OF BENEFIT APPLIED FOR",DIR("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P2"))#2:^("P2"),1:"") K:DIR("B")="" DIR("B")
 S DIR("?",1)="  1  HOSPITAL",DIR("?",2)="  2  DOMICILIARY",DIR("?",3)="  3  OUTPATIENT MEDICAL",DIR("?",4)="  4  OUTPATIENT DENTAL",DIR("?",5)="  5  NURSING HOME CARE"
 S DIR("?",6)="Choose any or all that you wish to monitor, e.g. 1,3,5 or 2-4, etc.",DIR("?")="Press RETURN for all benefit types."
 S QAMPARAM="P2" D EN3^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P2")=$S($E(Y,$L(Y))=",":$E(Y,1,$L(Y)-1),1:Y)
22 K DIR S DIR(0)="LO^1:5^K:X[""."" X",DIR("A")="TYPE OF CARE APPLIED FOR",DIR("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P3"))#2:^("P3"),1:"") K:DIR("B")="" DIR("B")
 S DIR("?",1)="  1  DENTAL",DIR("?",2)="  2  PLASTIC SURGERY",DIR("?",3)="  3  STERILIZATION",DIR("?",4)="  4  PREGNANCY",DIR("?",5)="  5  ALL OTHER"
 S DIR("?",6)="Choose any or all that you wish to monitor, e.g. 1,3,5 or 2-4, etc.",DIR("?")="Press RETURN for all care types."
 S QAMPARAM="P3" D EN3^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P3")=$S($E(Y,$L(Y))=",":$E(Y,1,$L(Y)-1),1:Y)
23 K DIC,DIR,DIRUT S DIC=743.5,DIC(0)="EMNQZ",DIC("S")="I $P(^(0),""^"",2)=37",DIC("A")="DISPOSITION GROUP: ",DIC("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P4"))#2:$P(^("P4"),"^",2),1:"") K:DIC("B")="" DIC("B")
 S DIR("?",1)="Enter a GROUP name that contains MAS disposition types.",DIR("?")="press 'RETURN' for all disposition types."
 S QAMPARAM="P4" D EN2^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P4")=+Y_"^"_Y(0,0)
EXIT K Y
 K QAMPARAM
Y Q
