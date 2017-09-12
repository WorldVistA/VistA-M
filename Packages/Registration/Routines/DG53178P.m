DG53178P ;ALB/ABR - RESTORE NAME TO ICD (DRG) GLOBAL - AUG 9 1996
 ;;5.3;Registration;**178**;Aug 13, 1993
 ;This routine will restore the .01 name value in file 80.2
 ;
EN ;
 N X,Y,DA,DIK,XPDIDTOT,TEXT,DRG,NODE
 D BMES^XPDUTL(">> Restoring 0-node in DRG file.")
 S DA=0,XPDIDTOT=500
 S DIK="^ICD(",DIK(1)=".01^B"
 F DA=1:1:503 I $D(^ICD(DA)) D
 . S TEXT=DA_"^DG53178"_$S(DA>340:"C",DA>170:"B",1:"A"),NODE=$T(@(TEXT))
 . Q:NODE=""
 . S $P(^ICD(DA,0),U,1,8)=$P(NODE,";;",2)
 . D EN1^DIK
 . I '(DA#50) D UPDATE^XPDID(DA)
 D MES^XPDUTL(">> DONE!")
 Q
