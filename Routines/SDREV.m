SDREV ;ALB/TMP - Enter Review Date for Clinic Enrollment Re-evaluation ; 23-DEC-85
 ;;5.3;Scheduling;**79**;Aug 13, 1993
 S U="^" D:'$D(DT) DT^SDUTL
CL W ! K DIC S DIC="^SC(",DIC(0)="AEMQ",DIC("A")="Select CLINIC NAME: ",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS"")),$S('$D(^(""I"")):1,+^(""I"")=0:1,+^(""I"")>DT:1,+$P(^(""I""),U,2)'>DT&(+$P(^(""I""),U,2)'=0):1,1:0)"
 D ^DIC K DIC("A"),DIC("S") G:X["^"!(X="") END S SC=+Y
PAT S SDOK=0,DIC="^DPT(",DIC(0)="AEMQ" D ^DIC Q:X["^"  G:X="" CL S DFN=+Y
 S SDENR=0 I $D(^DPT(DFN,"DE","B",SC)) S SDEN=$N(^DPT(DFN,"DE","B",SC,0)) I $D(^DPT(DFN,"DE",SDEN,0)),$P(^(0),U,2)'["I" F SDACT=0:0 S SDACT=$N(^DPT(DFN,"DE",SDEN,1,SDACT)) Q:SDACT'>0  D ACT
 I 'SDENR W !,*7,"Patient is not currently enrolled in this clinic!!",! G PAT
 G PAT
ACT S SDENR=1 Q:$P(^DPT(DFN,"DE",SDEN,1,SDACT,0),"^",3)]""
 S SDOK=0,SDEC=$S($D(^DPT(DFN,.36)):$P(^(.36),U,1),1:"") I SDEC']"" W !,"Invalid eligibility code" Q
 D SET S SDSTAT="" I $S('$D(^DIC(8,SDEC,0)):0,$P(^(0),U,5)'="Y":0,$P(^(0),U,4)=4:1,$P(^(0),U,4)=5:1,1:0),$P(^DPT(DFN,"DE",SDEN,1,SDACT,0),U,2)="O" S SDSTAT=1
 I 'SDSTAT!($S('SDREV&(DT-SDEDT'<10000):0,SDREV&(DT-SDREV'<10000):0,1:1)) S SDOK=0 D OK Q
 Q:'SDOK  S SDOK=0,DA=SDACT,DA(1)=SDEN,DA(2)=DFN,DIE="^DPT("_DA(2)_",""DE"","_DA(1)_",1,",DR="5;S:X]"""" SDOK=1" D ^DIE
 I 'SDOK W !,"No review date entered",! Q
 W " ... OK",! Q
OK W !,*7,"Patient doesn't need a review date" I SDREV W " .. current review date on file is " S Y=SDREV D DTS^SDUTL W Y,! Q
 I SDSTAT W " ... only enrolled since " S Y=$P(SDEDT,".") D DTS^SDUTL W Y,! Q
 W:'SDSTAT " ... enrollment status is not OPT/NSC",! Q
SET S SDOK=1,SDEDT=$P($P(^DPT(DFN,"DE",SDEN,1,SDACT,0),U,1),"."),SDREV=$P(^(0),U,5) Q
END K DA,DR,SDOK,SDENR,SDEN,SDACT,SDREV,SDEDT,SDSTAT,DFN,SC,SDEC,DIE Q
