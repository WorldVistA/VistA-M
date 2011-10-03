IVM2074 ;ALB/RMM IVM PATIENT ATR XREF Cleanup; 03/03/03
 ;;2.0;INCOME VERIFICATION MATCH;**74**;21-OCT-94
 ;
 ; This post-install will convert the ATR cross-reference from the
 ; old format to the new format.
 ;
 ;   OLD Format: ^IVM(301.5,"ATR",0,IVM Patient IEN)
 ;   NEW Format: ^IVM(301.5,"ATR",0,Income Year,IVM Patient IEN)
EN ;
 D BMES^XPDUTL(" >>Beginning cleanup process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 N DATA,IVMIEN,ERR
 S (IVMIEN,DATA(.03))=0
 F  S IVMIEN=$O(^IVM(301.5,"ATR",0,IVMIEN)) Q:'IVMIEN  D
 .Q:'$D(^IVM(301.5,IVMIEN,0))
 .I $$UPD^DGENDBS(301.5,IVMIEN,.DATA,.ERR) K ^IVM(301.5,"ATR",0,IVMIEN)
 ;
 D MES^XPDUTL(" >>Cleanup process completed:"_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 Q
