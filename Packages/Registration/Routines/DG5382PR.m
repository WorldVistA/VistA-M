DG5382PR ; ALBANY/GTS - DG*5.3*82 PRE-INIT; 2/01/96-10:15AM
 ;;5.3;Registration;**82**;Jan 30, 1996
 ;
MAIN ;
 D RMVENT ;** Remove LINE multiple from EMBOSSED CARD TYPE file
 Q
 ;
RMVENT ;** Remove LINE NUMBERs from WRISTBAND Entry in EMBOSSED CARD TYPE File
 N DGECDA,DGECLNDA
 S DIC="^DIC(39.1,",DIC(0)="M",X="WRISTBAND"
 D ^DIC ;** Get WRISTBAND DA from file 39.1
 S DGECDA=+Y
 K DIC,X,Y
 I DGECDA DO
 .S DGECLNDA=0
 .F  S DGECLNDA=$O(^DIC(39.1,DGECDA,1,DGECLNDA)) Q:'DGECLNDA  DO
 ..S DA=DGECLNDA,DA(1)=DGECDA,DIK="^DIC(39.1,"_DA(1)_",1,"
 ..D ^DIK
 ..K DIK,DA
 Q