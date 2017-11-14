PSN536E ;BIR/DMA-environment check for data updates ; 13 Oct 2017  10:17 AM
 ;;4.0;NATIONAL DRUG FILE;**536**; 30 Oct 98;Build 131
 ;
E ;environment check for data updates
 N PSNF,PSNLEG
 S (PSNF,PSNLEG)="",PSNLEG=$$GET1^DIQ(57.23,1,45)
 I PSNLEG="NO" S PSNF=1 D  Q:PSNF
 .W !,"Pharmacy Product System - National (PPS-N) Update process must be used for"
 .W !,"National Drug File (NDF) updates.  Go to the National Drug File Menu and"
 .W !,"select the PPS-N Menu [PSN PPS MENU] option for retrieving and installing"
 .W !,"NDF updates from PPS-N.",!
 .R !!,"Press enter to continue...",PSENTER:120
 .S XPDQUIT=2
 ;
 I $D(DUZ)#2 N DIC,X,Y S DIC=200,DIC(0)="N",X="`"_DUZ D ^DIC I Y>0
 E  W !!,"You must be a valid user." S XPDQUIT=2
 I $$PATCH^XPDUTL(XPDNM) W !!,"This patch has already been installed." S XPDQUIT=1 Q
 Q
