ICD14PST ;SSI/ALA-POST INSTALL FOR DRG GROUPER ;[ 05/28/97  6:43 PM ]
 ;;14.0;DRG Grouper;;Apr 03, 1997
 ;
EN ; Entry Point for DRG Post Init
 D DRG,DXN,PRC
 D DELETE
 K I,T1
 F DIK="^ICM(","^ICD(" D IXALL^DIK
 F I=80,80.1 F J="DD","DEL","LAYGO","WR" S ^DIC(I,0,J)="@"
 F I=80,80.1 S ^DIC(I,0,"RD")="d"
 K CT,I,J,DA,DIK,%X,%Y,FL
 Q
DRG ; Update DRG information from file #80.9
 S (I,CT)=0
 F  S I=$O(^ICDYZ(80.9,I)) Q:'I  D  S CT=CT+1 W:CT#25=0 "."
 . S $P(^ICD(I,0),U)=$P(^ICDYZ(80.9,I,0),U)
 . S $P(^ICD(I,0),U,5)=$P(^ICDYZ(80.9,I,0),U,5)
 . S $P(^ICD(I,0),U,6)=$P(^ICDYZ(80.9,I,0),U,6)
 . I '$D(^ICD(I,1,0)) S ^ICD(I,1,0)="^80.21A^^"
 . S T1=0
 . F  S T1=$O(^ICDYZ(80.9,I,1,T1)) Q:'T1  S ^ICD(I,1,T1,0)=^ICDYZ(80.9,I,1,T1,0),$P(^ICD(I,1,0),"^",3,4)=T1_"^"_T1
 . S:$D(^ICDYZ(80.9,I,"MC1")) ^ICD(I,"MC1")=^ICDYZ(80.9,I,"MC1")
 . S DA=I,DIK="^ICD(" D IX1^DIK
 Q
DXN ;  Update Diagnosis File #80
 S (DA,CT)=0,DIK="^ICD9("
 F  S DA=$O(^ICDYZ(80.7,DA)) Q:'DA  D  S CT=CT+1 W:CT#25=0 "."
 . D ^DIK
 . S %X="^ICDYZ(80.7,"_DA_",",%Y="^ICD9("_DA_","
 . D %XY^%RCR
 . I $D(^ICD9(DA,"N")) S $P(^ICD9(DA,"N",0),U,2)="80.01P"
 . I $D(^ICD9(DA,"R")) S $P(^ICD9(DA,"R",0),U,2)="80.02P"
 . I $D(^ICD9(DA,2)) S $P(^ICD9(DA,2,0),U,2)="80.03P"
 . D IX1^DIK
 Q
PRC ;  Update Procedure File #80.1
 S (DA,CT)=0,DIK="^ICD0("
 F  S DA=$O(^ICDYZ(80.8,DA)) Q:'DA  D  S CT=CT+1 W:CT#25=0 "."
 . D ^DIK
 . S %X="^ICDYZ(80.8,"_DA_",",%Y="^ICD0("_DA_","
 . D %XY^%RCR
 . I $D(^ICD0(DA,"MDC")) S $P(^ICD0(DA,"MDC",0),U,2)="80.12PA"
 . D IX1^DIK
 Q
DELETE ; Delete Temporary Files #80.7,#80.8,#80.9
 F FL=80.7,80.8,80.9 S I=0 D
 . F  S I=$O(^ICDYZ(FL,I)) Q:I=""  K ^ICDYZ(FL,I)
 . S $P(^ICDYZ(FL,0),U,3,4)="0^0"
 Q
