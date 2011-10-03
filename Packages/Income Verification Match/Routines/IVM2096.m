IVM2096 ;ALB/GN IVM BILLING TRANSMISSION ATR XREF CONVERSION; 03/03/03 ; 12/22/03 3:13pm
 ;;2.0;INCOME VERIFICATION MATCH;**96**;21-OCT-94
 ;
 ; This post-install will convert the ATR cross-reference from the
 ; old format to the new format, providing any are currently set.
 ;
 ;   OLD Format: ^IVM(301.5,"ATR",DFN,IEN)
 ;   NEW Format: ^IVM(301.5,"ATR",Income Year,DFN,IEN)
 ;
EN ;
 D BMES^XPDUTL(" >>Beginning conversion process "_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 N DATA,IVMIEN,ERR,DA,DIK
 S DFN=0
 F  S DFN=$O(^IVM(301.61,"ATR",DFN)) Q:'DFN  D
 . S IVMIEN=0
 . F  S IVMIEN=$O(^IVM(301.61,"ATR",DFN,IVMIEN)) Q:'IVMIEN  D
 . . K ^IVM(301.61,"ATR",DFN,IVMIEN)
 . . S DA=IVMIEN,DIK="^IVM(301.61,"
 . . D IX1^DIK                                    ;re-index this ien 
 ;
 D MES^XPDUTL(" >>Conversion process completed:"_$$FMTE^XLFDT($$NOW^XLFDT))
 ;
 Q
