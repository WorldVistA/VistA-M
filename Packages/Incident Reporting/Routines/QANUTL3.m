QANUTL3 ;HISC/GJC-UTILITIES FOR AN INCIDENT REPORT ;4/22/91
 ;;2.0;Incident Reporting;**27,26,29**;08/07/1992
 ;
BULL ;Generate the bulletin.
 I $P(^QA(740,1,"QAN"),U)="" W !!,$C(7),"*** MAILGROUP NOT SPECIFIED, REPORT TO YOUR QA COORDINATOR ***",!!,$C(7) S QANXIT=1 Q
 I $P(^QA(740,1,"QAN"),U,2)="" W !!,$C(7),"*** MAILGROUP BULLETIN NOT SENT, REPORT TO YOUR QA COORDINATOR ***",!!,$C(7) S QANXIT=1 Q
 D KILL^XM S QANAFRM=+$S($D(^QA(740,1,"QAN"))#2:$P(^("QAN"),U,2),1:"")
 S QANMIEN=+$S($D(^QA(740,1,"QAN"))#2:$P(^("QAN"),U),1:"") Q:QANAFRM'>0!(QANMIEN'>0)
 S QANMAIL="G."_$P(^XMB(3.8,QANMIEN,0),U),QANSITE=$P(^DIC(4.2,$P(^XMB(1,1,0),U),0),U)
 I QANSITE']"" W !!,$C(7),"*** MAILGROUP BULLETIN NOT SENT, REPORT TO YOUR QA COORDINATOR, DOMAIN INFORMATION MISSING ***",!!,$C(7) S QANXIT=1 Q
 S XMY(QANMAIL_"@"_QANSITE)=""
 S XMSUB=^DD("SITE")_" ("_^DD("SITE",1)_") QAN INCIDENT EVENT",XMDUZ=.5
 I $D(DUZ)#2,DUZ>0,$D(^VA(200,DUZ,0)) S X=$P($P(^(0),U),",",2)_" "_$P($P(^(0),U),",") S QANMAIL(1)=X
 S X=$S($D(^QA(742.4,QANIEN,0))#2:$P(^(0),U,6),1:"") S:X]"" QANMAIL(2)=$P(^DIC(3.1,X,0),U) S:X']"" QANMAIL(2)=""
 S QANMAIL(3)=$S($D(^QA(742.4,QANIEN,0))#2:$P(^(0),U),1:"")
 S X=$S($D(^QA(742.4,QANIEN,0))#2:$P(^(0),U,2),1:"") S:X]"" QANMAIL(4)=$P(^QA(742.1,X,0),U) S:X']"" QANMAIL(4)=""
 S Y=DT X ^DD("DD") S X=Y,QANMAIL(5)=X
 S X=$S($D(^QA(742.4,QANIEN,0))#2:$P(^(0),U,3),1:"")
 S Y=X X ^DD("DD") S X=Y,QANMAIL(6)=X
 S QANMAIL(7)=$S($D(QANAME):QANAME,1:"")
 S QANMAIL(8)=$S($D(QANSSN):QANSSN,1:"")
 S QANWORD=$S($G(QANEDFLG)=1:"edited",1:"entered")
 S ^UTILITY($J,"QAN PAT",1)="On "_QANMAIL(5)_" User "_QANMAIL(1)_" ("_QANMAIL(2)_") "_QANWORD_" Incident"
 S ^UTILITY($J,"QAN PAT",2)="case number "_QANMAIL(3)_" involving an incident, type "_QANMAIL(4)_"."
 S ^UTILITY($J,"QAN PAT",3)="Date of Incident: "_QANMAIL(6)
 I $D(QANMAIL(7)) S ^UTILITY($J,"QAN PAT",4)="Patient: "_QANMAIL(7)
 I $D(QANMAIL(8)) S ^UTILITY($J,"QAN PAT",4)=^UTILITY($J,"QAN PAT",4)_"    SSN: "_QANMAIL(8)
 S XMTEXT="^UTILITY($J,""QAN PAT""," D ^XMD,KILL^XM K X,Y,XMB,QANMAIL,QANAFRM,QANMIEN,QANSITE,XMHOLD,XMANS
 Q
EN1 ;Incident location enter/edit.
 D KDIC S (DIC,DIE)="^QA(742.5,",DLAYGO=742.5,DIC("A")="Select an Incident Location: ",DIC(0)="QEAMNLZ",DIC("W")="W ""  ""_$S($P(^(0),U,2)=1:""ACTIVE"",1:""INACTIVE"")"
 D ^DIC
 I Y=-1 D KDIC Q
 S DA=+Y L +^QA(742.5,DA,0):5 I '$T W !!?16,$C(7),"Another person is editing this entry." D KDIC Q
 S DR=".01 Incident:" D ^DIE
 I $D(Y) D KDIC Q
 S DR=".02 Incident Location Status:" D ^DIE
 D KDIC
 Q
KDIC ;
 I $D(DA) L -^QA(752.5,DA,0)
 K C,D,DA,DIC,DIE,DLAYGO,DINUM,DR,X,Y
 Q
