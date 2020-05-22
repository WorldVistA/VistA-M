PSO544POST ;AITC/PD - Post install for PSO*7.0*544 ;11/22/19
 ;;7.0;OUTPATIENT PHARMACY;**544**;;Build 19
 ;
 Q
 ;
POST ; Post-install functions are coded here.
 ;
 D MES^XPDUTL(" Starting post-install of PSO*7.0*544")
 ;
 ; Add RRR Reject Code 943 to EPHARMACY SITE PARAMETERS (#52.86)
 D RRR
 ;
 D MES^XPDUTL(" Finished post-install of PSO*7.0*544")
 Q
 ;
RRR ; Add RRR Reject Code 943 to EPHARMACY SITE PARAMETERS
 ;
 N CNT,PSOBPSDV,REJIEN,RRR943
 ;
 S REJIEN=$O(^BPSF(9002313.93,"B",943,""))
 I REJIEN="" Q
 ;
 S CNT=0
 ;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("    - Updating EPHARMACY SITE PARAMETERS")
 ;
 S PSOBPSDV=0
 F  S PSOBPSDV=$O(^PS(52.86,PSOBPSDV)) Q:'PSOBPSDV  D
 . I $D(^PS(52.86,PSOBPSDV,5,"B",REJIEN)) Q
 . S RRR943(52.865,"+1,"_PSOBPSDV_",",.01)=REJIEN
 . S RRR943(52.865,"+1,"_PSOBPSDV_",",.02)=0
 . S RRR943(52.865,"+1,"_PSOBPSDV_",",.03)=.5
 . D UPDATE^DIE(,"RRR943")
 . S CNT=CNT+1
 ;
 D MES^XPDUTL("      - "_CNT_" entries updated")
 D MES^XPDUTL("    - Done with EPHARMACY SITE PARAMETERS")
 D MES^XPDUTL(" ")
 ;
 Q
