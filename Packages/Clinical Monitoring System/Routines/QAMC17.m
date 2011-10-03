QAMC17 ;HISC/DAD-CONDITION: APPOINTMENT ;9/3/93  13:23
 ;;1.0;Clinical Monitoring System;;09/13/1993
EN1 ; *** CONDITION CODE
 S CLINIC(0)=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P1"))#2:+^("P1"),1:0)
 S STATUS(0)=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P2"))#2:^("P2"),1:"")
 S PURPOSE(0)=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P3"))#2:^("P3"),1:"")
 S TYPE(0)=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P4"))#2:+^("P4"),1:0)
 S LOOKBACK=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P5"))#2:+^("P5"),1:0)
 S X1=QAMTODAY,X2=-LOOKBACK D C^%DTC S QAMSTDT=X
 F QAM44D0=0:0 S QAM44D0=$O(^SC(QAM44D0)) Q:QAM44D0'>0  D LOOP1
 K QAM44D0,QAM44D1,QAM44D2,CLINIC,STATUS,PURPOSE,TYPE,QAMAPTDT,QAMSTDT
 Q
LOOP1 I CLINIC(0) Q:$O(^QA(743.5,CLINIC(0),"GRP","AB",QAM44D0,0))'>0
 F QAM44D1=(QAMSTDT-.0000001):0 S QAM44D1=$O(^SC(QAM44D0,"S",QAM44D1)) Q:(QAM44D1'>0)!(QAM44D1\1'?7N)!(QAM44D1>(QAMTODAY+.9999999))  F QAM44D2=0:0 S QAM44D2=$O(^SC(QAM44D0,"S",QAM44D1,1,QAM44D2)) Q:QAM44D2'>0  D LOOP2
 Q
LOOP2 S QAMDFN=+^SC(QAM44D0,"S",QAM44D1,1,QAM44D2,0),QAM=$S($D(^DPT(QAMDFN,"S",QAM44D1,0))#2:^(0),1:"") Q:QAM44D0'=+QAM  S STATUS=$P(QAM,"^",2),PURPOSE=$P(QAM,"^",7),TYPE=+$P(QAM,"^",16)
 I STATUS(0)]"" Q:(STATUS="")!(STATUS(0)'[$L($P("N^C^NA^CA^I^PC^PCA",STATUS),"^"))
 I PURPOSE(0)]"" Q:(PURPOSE="")!(PURPOSE(0)'[PURPOSE)
 I TYPE(0) Q:$O(^QA(743.5,TYPE(0),"GRP","AB",TYPE,0))'>0
 S ^UTILITY($J,"QAM CONDITION",QAMD1,QAMDFN)="",^(QAMDFN,QAM44D1)=QAMDFN_"^"_QAM44D1
 Q
EN2 ; *** PARAMETER CODE
 K DIC,DIR,DIRUT S DIC=743.5,DIC(0)="EMNQZ",DIC("S")="I $P(^(0),""^"",2)=44",DIC("A")="CLINIC GROUP: ",DIC("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P1"))#2:$P(^("P1"),"^",2),1:"") K:DIC("B")="" DIC("B")
 S DIR("?",1)="Enter a GROUP name that contains MAS clinics.",DIR("?")="Press 'RETURN' for all clinics."
 S QAMPARAM="P1" D EN2^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P1")=+Y_"^"_Y(0,0)
21 K DIR S DIR(0)="LO^1:7^K:X[""."" X",DIR("A")="STATUS",DIR("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P2"))#2:^("P2"),1:"") K:DIR("B")="" DIR("B")
 S DIR("?",1)="  1  N    NO-SHOW",DIR("?",2)="  2  C    CANCELLED BY CLINIC",DIR("?",3)="  3  NA   NO-SHOW & AUTO RE-BOOK",DIR("?",4)="  4  CA   CANCELLED BY CLINIC & AUTO RE-BOOK",DIR("?",5)="  5  I    INPATIENT APPOINTMENT"
 S DIR("?",6)="  6  PC   CANCELLED BY PATIENT",DIR("?",7)="  7  PCA  CANCELLED BY PATIENT & AUTO RE-BOOK",DIR("?",8)="Choose any or all that you wish to monitor, e.g. 1,3,5 or 2-5,7, etc.",DIR("?")="Press RETURN for all status types."
 S QAMPARAM="P2" D EN3^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P2")=$S($E(Y,$L(Y))=",":$E(Y,1,$L(Y)-1),1:Y)
22 K DIR S DIR(0)="LO^1:4^K:X[""."" X",DIR("A")="PURPOSE OF VISIT",DIR("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P3"))#2:^("P3"),1:"") K:DIR("B")="" DIR("B")
 S DIR("?",1)="  1  C&P",DIR("?",2)="  2  10-10",DIR("?",3)="  3  SCHEDULED VISIT",DIR("?",4)="  4  UNSCHEDULED VISIT"
 S DIR("?",5)="Choose any or all that you wish to monitor, e.g. 2,4 or 1-3, etc.",DIR("?")="Press RETURN for all purpose of visit types."
 S QAMPARAM="P3" D EN3^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P3")=$S($E(Y,$L(Y))=",":$E(Y,1,$L(Y)-1),1:Y)
23 K DIC,DIR,DIRUT S DIC=743.5,DIC(0)="EMNQZ",DIC("S")="I $P(^(0),""^"",2)=409.1",DIC("A")="APPOINTMENT TYPE GROUP: ",DIC("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P4"))#2:$P(^("P4"),"^",2),1:"") K:DIC("B")="" DIC("B")
 S DIR("?",1)="Enter a GROUP name that contains MAS appointment types.",DIR("?")="Press 'RETURN' for all appointment types."
 S QAMPARAM="P4" D EN2^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P4")=+Y_"^"_Y(0,0)
24 K DIR,DIRUT S DIR(0)="NO^1:365:0",DIR("A")="LOOK BACK DAYS",DIR("B")=$S($D(^QA(743,QAMD0,"COND",QAMD1,"P5"))#2:^("P5"),1:"") K:DIR("B")="" DIR("B")
 S DIR("?",1)="Enter the number of days the condition should 'look back'",DIR("?")="while trying to find a fall out for this monitor."
 S QAMPARAM="P5" D EN3^QAMUTL1 I $D(DIRUT) S Y=-1 G Y
 S:Y]"" ^QA(743,QAMD0,"COND",QAMD1,"P5")=+Y
EXIT K Y
 K QAMPARAM
Y Q
