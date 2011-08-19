QAMAHO2 ;HISC/GJC-CHECKS SORT DATA FOR FALLOUT FILE ^QA(743.1 ;5/5/93  15:10
 ;;1.0;Clinical Monitoring System;;09/13/1993
 ;
PAT ;BEGINNING/ENDING SORT VALUES FOR PATIENT
 W !!,"Enter the beginning and ending values for PATIENT NAME.",!
 R !,"Start with: First// ",NAME1:DTIME
 I '$T!(NAME1["^") S QAMOUT=1 Q
 I NAME1="" S NAME1=" ",NAME2="~" G PAT3
 I NAME1'?1U.A.",".A!($L(NAME1)>30) W !!,*7,"Names must start in uppercase, with or without a comma. Between 1-30 characters long." G PAT
PAT1 R !,"End with: Last// ",NAME2:DTIME
 I '$T!(NAME2["^") S QAMOUT=1 Q
 I NAME2="" S NAME2="~" G PAT2
 I NAME2'?1U.A.",".A!($L(NAME2)>30) W !!,*7,"Names must start in uppercase, with or without a comma. Between 1-30 characters long." G PAT1
PAT2 I (NAME2']NAME1),(NAME1'=NAME2) W !!,*7,"The beginning name must fall before the ending name in the alphabet." G PAT
PAT3 F LP=0:0 S LP=$O(^QA(743.1,"B",LP)) Q:LP'>0  S PTNT=$P(^DPT(LP,0),U) I ((PTNT]NAME1)!(PTNT=NAME1)),((NAME2=PTNT)!(NAME2]PTNT)) F QAMD0=0:0 S QAMD0=$O(^QA(743.1,"B",LP,QAMD0)) Q:QAMD0'>0  S ^UTILITY($J,"QAM PAT",PTNT,QAMD0)=PTNT
 Q
DLMNT ;SELECT DATA ELEMENT TO SORT BY
 W ! K DIC,DLAYGO S DIC=743.4,DIC(0)="QEAMNZ",DIC("A")="Select DATA ELEMENT: " D ^DIC K DIC
 I +Y=-1 S QAMOUT=1 Q
 S QAMDATA=Y(0,0),QAMDIEN=+Y,QAMTYPE=$S($D(^QA(743.4,QAMDIEN,"DIR0"))#2:$E(^("DIR0")),1:"") S:QAMTYPE']"" QAMOUT=1 Q:QAMOUT
 D DATE^QAMAHO4:QAMTYPE="D",FREE^QAMAHO5:QAMTYPE="F",NUM^QAMAHO4:QAMTYPE="N",POINT^QAMAHO4:QAMTYPE="P",SET^QAMAHO5:QAMTYPE="S"
 Q
MON ;BEGINNING/ENDING SORT VALUES FOR MONITOR
 W !!,"Enter the beginning and ending values for MONITOR CODE.",!
 R !,"Start with: First// ",MON1:DTIME
 I '$T!(MON1["^") S QAMOUT=1 Q
 I MON1="" S MON1=" ",MON2="~" G MON5
 I ((MON1'?1A.E)&(MON1'?1N.E))!($L(MON1)>30) W !!,*7,"Monitors must start in alphanumerics. Between 1-30 characters long." G MON
MON1 R !,"End with: Last// ",MON2:DTIME
 I '$T!(MON2["^") S QAMOUT=1 Q
 I MON2="" S MON2="~" G MON4
 I ((MON2'?1N.E)&(MON2'?1A.E))!($L(MON2)>30) W !!,*7,"Monitors must start in alphanumerics. Between 1-30 characters long." G MON1
MON4 I (MON2']MON1),(MON1'=MON2) W !!,*7,"The beginning Monitor must fall before the ending Monitor." G MON
MON5 F LP=0:0 S LP=$O(^QA(743.1,"AA",LP)) Q:LP'>0  S MONI=$P($G(^QA(743,LP,0)),U) I MONI]"" I ((MONI]MON1)!(MON1=MONI)),((MON2]MONI)!(MON2=MONI)) D MON2
 Q
MON2 ;
 F QAMDT=0:0 S QAMDT=$O(^QA(743.1,"AA",LP,QAMDT)) Q:QAMDT'>0  F QAMPT=0:0 S QAMPT=$O(^QA(743.1,"AA",LP,QAMDT,QAMPT)) Q:QAMPT'>0  F QAMD0=0:0 S QAMD0=$O(^QA(743.1,"AA",LP,QAMDT,QAMPT,QAMD0)) Q:QAMD0'>0  S ^UTILITY($J,"QAM MON",MONI,QAMD0)=MONI
 Q
