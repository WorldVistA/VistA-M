QANUTL0 ;HISC/GJC-Utility for Incident Record Manipulation ;9/16/93  08:58
 ;;2.0;Incident Reporting;**1,20**;08/07/1992
 ;
EN ;Choose your patient.
 N QANINCD,QANXIT S QANXIT=0
 S DIC=742,DIC(0)="QEAMZ",DIC("A")="Select Patient: ",DIC("W")="D EN1^QANUTL0"
 D ^DIC K DIC Q:+Y'>0
 S QANDFN=+Y
 W @IOF D HDR
 S PAT2=^DPT($P(^QA(742,QANDFN,0),U),0) W !,"Patient: "_$P(PAT2,U),?40," Social Security Number: "_$P(PAT2,U,9)
 S QANIEN=$P(^QA(742,QANDFN,0),U,3),QAN0=$G(^QA(742.4,QANIEN,0))
 I QAN0']"" W !!,*7,"The incident global is incomplete, contact you site manager." G KILL
 S Y=$P(QAN0,U,2),C=$P(^DD(742.4,.02,0),U,2) D Y^DIQ S QANINC=$S(Y]"":Y,1:"")
 S Y=$P(QAN0,U,3),C=$P(^DD(742.4,.03,0),U,2) D Y^DIQ S QANDATE=$S(Y]"":Y,1:"")
 W !,"Incident: "_QANINC_" on date "_QANDATE_".",!
 S QANLSTA=+$P(QAN0,U,8)
 K DIR S DIR("B")=$S("13"[QANLSTA:"OPEN",QANLSTA=2:"DELETED",1:"CLOSED"),DIR("A")="Local Case Status: ",DIR(0)="SO^1:OPEN;0:CLOSED;-1:DELETED" D ^DIR K DIR
 I $D(DUOUT)!($D(DTOUT))!($D(DIROUT)) W !!,*7,"No action taken, premature exit action encountered." G KILL
 S QAN("Y")=Y
 S DIE="^QA(742.4,",DA=QANIEN,DR=$S(QAN("Y")=1:".09///^S X=""1""",QAN("Y")=0:".09///^S X=""0""",1:".09///^S X=""2""") D ^DIE K DA,DIE,DR
 K QAUDIT S QAUDIT("FILE")="742.4^50",QAUDIT("DA")=QANIEN,QAUDIT("ACTION")=$S(QAN("Y")=1:"o",QAN("Y")=0:"c",1:"d"),QAUDIT("COMMENT")=$S(QAN("Y")=1:"Open ",QAN("Y")=0:"Close ",1:"Delete ")_"an incident record" D ^QAQAUDIT
EN0 S QAN0=$G(^QA(742.4,QANIEN,0)),QANACT=+$P(QAN0,U,8)
 I QANLSTA'=QANACT S DIE="^QA(742.4,",DA=QANIEN,DR=".21///@" D ^DIE
 S QANMSS(0)="W !!,*7,""Appropriate Patient(s) records now being marked as deleted!"""
 S QANMSS(1)="W !!,*7,""Appropriate Patient(s) records now being marked as closed!"""
 S QANMSS(2)="W !!,*7,""Appropriate Patient(s) records now being marked as open!"""
 X $S(QANACT=2:QANMSS(0),QANACT=0:QANMSS(1),1:QANMSS(2))
 K DIE,DR S DIE="^QA(742,",DR=$S(QANACT=2:".13///^S X=""-1""",QANACT=0:".13///^S X=""0""",1:".13///^S X=""1""")
 S QANSLEV=+$P(^QA(742,QANDFN,0),U,10),QANNCDNT=$P(QAN0,U,2)
 S QANNCDNT=$P($G(^QA(742.1,QANNCDNT,0)),U)
 S QANINCD=$$UP^XLFSTR(QANNCDNT)
 F QAN=0:0 S QAN=$O(^QA(742,"BCS",QANIEN,QAN)) Q:QAN'>0  S DA=QAN D AUDIT
 S QANOK=0 D INCK^QANFULL0 ;Is the incident reportable???
 I QANOK,(QAN("Y")=1) S DIE="^QA(742.4,",DA=QANIEN,DR=".17///"_1 D ^DIE
 I 'QANOK S DIE="^QA(742.4,",DA=QANIEN,DR=".17///@" D ^DIE
KILL K C,D,DD,DIC,DIE,DIR,DR,DTOUT,DUOUT,PAT2,QAN,QAN0,QAN7424,QANDATE,QANIEN
 K %,D0,DI,DA,QANOK,QANACT,QANINC,QANDFN,QANSLEV,QANLSTA,QANMSS,TEMPY,X,Y
 K QANNCDNT
 Q
EN1 ;
 S TEMPY=Y
 S QANIEN=$O(^QA(742.4,"ACN",+TEMPY,0)) Q:+QANIEN'>0
 S QAN7424=$G(^QA(742.4,QANIEN,0)) Q:QAN7424']""
 S Y=$P(QAN7424,U,2),C=$P(^DD(742.4,.02,0),U,2) D Y^DIQ S QANINC=$S(Y]"":Y,1:"")
 S Y=$P(QAN7424,U,3),C=$P(^DD(742.4,.03,0),U,2) D Y^DIQ S QANDATE=$S(Y]"":Y,1:"")
 W " "_$P(^DPT($P(^QA(742,+TEMPY,0),U),0),U,9)_" "_QANINC_" "_QANDATE_" "
 S Y=TEMPY
 Q
HDH ;
 I $E(IOST,1)="C" K DIR S DIR(0)="E" D ^DIR K DIR S:+Y=0 QANXIT=1
 Q:QANXIT
 W @IOF D HDR
 Q
HDR ;
 W !!,"This option will allow the user to open, close, or delete a record at the local level.",!,"The appropriate patient(s) records are marked to reflect the change for ",!,"incident: "_QANINC_" on date "_QANDATE_".",!
 Q
AUDIT ;File changes in the QA Audit File.
 K QAUDIT S QAUDIT("FILE")="742^50",QAUDIT("DA")=QAN,QAUDIT("ACTION")=$S(QANACT=2:"d",QANACT=0:"c",1:"o"),QAUDIT("COMMENT")=$S(QANACT=2:"Delete ",QANACT=0:"Close ",1:"Open ")_"a patient record" D ^QAQAUDIT
 D ^DIE
 Q
