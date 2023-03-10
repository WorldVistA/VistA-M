PSO562PRE ;AITC/PD - Pre-install for PSO*7.0*562 ; 9/1/20
 ;;7.0;OUTPATIENT PHARMACY;**562**;DEC 1997;Build 19
 ;
 Q
 ;
PRE ; Pre-install functions are coded here
 ;
 D MES^XPDUTL(" Starting pre-install of PSO*7*562")
 ;
 ; Remove RRR Reject Code 943 from EPHARMACY SITE PARAMETERS (#52.86)
 D RRR
 ;
 D MES^XPDUTL(" Finished pre-install of PSO*7*562")
 Q
 ;
RRR ; Remove RRR Reject Code 943 from EPHARMACY SITE PARAMETERS
 ;
 N CNT,DA,DIK,PSODIV,REJIEN,RRRIEN
 ;
 S REJIEN=$O(^BPSF(9002313.93,"B",943,""))
 I REJIEN="" Q
 ;
 S CNT=0
 ;
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" - Updating EPHARMACY SITE PARAMETERS")
 ;
 S PSODIV=0
 F  S PSODIV=$O(^PS(52.86,PSODIV)) Q:'PSODIV  D
 . I '$D(^PS(52.86,PSODIV,5,"B",REJIEN)) Q
 . S RRRIEN=$O(^PS(52.86,PSODIV,5,"B",REJIEN,""))
 . I RRRIEN="" Q
 . ;
 . S DIK="^PS(52.86,"_PSODIV_",5,"
 . S DA(1)=PSODIV
 . S DA=RRRIEN
 . D ^DIK
 . S CNT=CNT+1
 ;
 D MES^XPDUTL("   - "_CNT_" entries updated")
 D MES^XPDUTL(" - Done with EPHARMACY SITE PARAMETERS")
 D MES^XPDUTL(" ")
 ;
 Q
