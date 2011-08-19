MCPOS08 ;HIRMFO/DAD-PUT CARDIOLOGY CODE INTO MULT IN 695 ;4/26/96  14:51
 ;;2.3;Medicine;;09/13/1996
 ;
 N MCD0,MCDATA,DD,DIC,DINUM,DO
 ;
 S MCDATA(1)=""
 S MCDATA(2)="Adding the cardiology code to the Medical Package Use"
 S MCDATA(3)="multiple in the Medication file (#695)"
 D MES^XPDUTL(.MCDATA)
 ;
 I $D(^MCAR(695,"C")) Q
 ;
 S MCD0=0
 F  S MCD0=$O(^MCAR(695,MCD0)) Q:MCD0'>0  D
 . I $O(^MCAR(695,"C","C",MCD0,0)) Q
 . K DD,DIC,DINUM,DO
 . S DIC="^MCAR(695,"_MCD0_",1,",DIC(0)="L"
 . S DIC("P")=$$GET1^DID(695,1,"","SPECIFIER")
 . S DLAYGO=695,(D0,DA(1))=MCD0,X="C"
 . D FILE^DICN
 . Q
 Q
