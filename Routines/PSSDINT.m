PSSDINT ;BIR/DMA - ENTER/EDIT INTERACTIONS ; 03/15/01 12:53
 ;;1.0;PHARMACY DATA MANAGEMENT;**17,20,43**;9/30/97
 ;
 ;Reference to $$KSP^XUPARAM("INST") supported by DBIA #2541
 ;Reference to ^PS(56 supported by DBIA #2133
 ;
GO W !!
 S PSNDF=1 K PSN,PSN1,PSN2,PSNN,PSNNN
 S DIC=50.416,DIC(0)="AEMQZ",DIC("A")="Choose first ingredient ",DIC("S")="I '$P(^(0),""^"",2)" D ^DIC G OUT:Y<0 S PSN1=+Y,PSNN($P(Y(0),"^"))=""
 S DIC("A")="Choose second ingredient ",DIC("S")=DIC("S")_",+Y'=PSN1" D ^DIC G OUT:Y<0 S PSN2=+Y,PSNN($P(Y(0),"^"))=""
 S DA=$O(^PS(56,"AE",PSN1,PSN2,0)) I DA S PSN=^PS(56,DA,0),PSNL=$G(^PS(56,DA,"L")) D  G GO
 .I DA<15000,$P(PSN,"^",4)=1,'PSNL W !!,"That interaction is nationally entered and may not be edited." Q
 .S DIR(0)="Y",DIR("A")="That interaction already exists.  Do you wish to edit it" D ^DIR Q:'Y  K DIR S DIR(0)="56,3"
 .D ^DIR Q:'Y  S DIE="^PS(56,",DR="3////"_Y_";6////1;" S:DA'<15000 DR=DR_"7;" D ^DIE D SEVMSG Q
 S PSNNN=$O(PSNN(""))_"/"_$O(PSNN($O(PSNN(""))))
 K DA,DIR S DIR(0)="56,3" D ^DIR G OUT:$D(DTOUT)!$D(DUOUT) S PSN=Y
 W !,PSNNN,"   Severity : ",Y(0)
 S DIR(0)="Y",DIR("A")="OK to add " D ^DIR G OUT:$D(DTOUT)!$D(DUOUT) I 'Y K PSNN,PSNNN G GO
 F  L +^PS(56):3 Q:$T
 S DINUM=$O(^PS(56," "),-1)+1 I DINUM<15000 S DINUM=15000
 S DIC("DR")="1////"_PSN1_";2////"_PSN2_";3////"_PSN_";6////1",DIC="^PS(56,",DIC(0)="L",X=PSNNN K DD,DO D FILE^DICN L -^PS(56) D ADDMSG
 K PSN,PSN1,PSN2,PSNN,PSNNN G GO
 ;
OUT K PSN,PSN1,PSN2,PSNDF,PSNL,PSNN,PSNNN,DA,DIC,DIR,DIRUT,DR,X,Y,PSNIFN,PSNSEV,PSSFLTY,PSSIIEN,XMDUZ,XMSUB,XMTEXT,XMY
 K ^TMP($J,"PSS")
 Q
 ;
SEVMSG ;If change in severity nationally; send mail message.
 Q:$G(PSNL)  S PSNIFN=^PS(56,DA,0) Q:$P(PSNIFN,U,4)=2
 D HEADER S XMSUB="Drug Interaction Severity Change from "_PSSFLTY_"."
 S ^TMP($J,"PSS",1)="The severity of a nationally entered drug interaction has been edited."
 S ^TMP($J,"PSS",2)="" S ^TMP($J,"PSS",3)=""_$P(PSNIFN,U)_" Drug Interaction severity"
 S ^TMP($J,"PSS",4)="changed from SIGNIFICANT to CRITICAL."
 S XMTEXT="^TMP($J,""PSS""," D ^XMD
 Q
 ;
ADDMSG ;If adding new local interaction; send mail message.
 D HEADER S XMSUB="Local Drug Interaction Added from "_PSSFLTY_"."
 S ^TMP($J,"PSS",1)="Local "_PSNNN_" Drug Interaction"
 S ^TMP($J,"PSS",2)="with a severity of "_$S($P(^PS(56,+Y,0),U,4)=2:"SIGNIFICANT",1:"CRITICAL")_" has been added."
 S XMTEXT="^TMP($J,""PSS""," D ^XMD
 Q
 ;
HEADER ;Message header; facility name
 S PSSIIEN=$$KSP^XUPARAM("INST"),PSSFLTY=$$GET1^DIQ(4,PSSIIEN,.01)
 S XMDUZ=DUZ,XMY("G.NDF SUPPORT@ISCPNDF.ISC-BIRM.VA.GOV")=""
 Q
