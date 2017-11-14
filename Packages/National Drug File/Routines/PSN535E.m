PSN535E ;BHM/LE-NDF PMI Data Updates ; 13 Oct 2017  10:16 AM
 ;;4.0;NATIONAL DRUG FILE;**535**; 30 Oct 98;Build 127
 ;
E ;Environment Check for PMI data updates
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
 E  W !,"You must be a valid user."
 Q
