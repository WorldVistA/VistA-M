PSO7E545 ;WILM/BDB - Environment routine for patch PSO*7*545 ;12/3/2018
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ;
ENV ;
 N HANDPSO,TITLE,MISTART,MIEXP
 S XPDABORT=$$KRNCHK Q:$G(XPDABORT)
 S HANDPSO="PSO70684-INSTALL"
 S MISTART=$P($G(^XTMP(HANDPSO,0)),"^",2),MIEXP=0
 I MISTART,($$FMDIFF^XLFDT($$DT^XLFDT,MISTART)>7) S MIEXP=1
 S TITLE="REFRESH DOJ/DEA MIGRATION DATA"
 L +^XTMP(HANDPSO):0 I '$T D  Q
 . D BMES^XPDUTL(TITLE_" job is still running.  Halting...")
 . D MES^XPDUTL("")
 . S XPDABORT=1  ; Do not install this transport global and KILL it from ^XTMP.
 I $$PATCH^XPDUTL("PSO*7.0*545") D  Q  ; Don't require DEA migration if previously installed
 . L -^XTMP(HANDPSO)
 I '$D(^XTMP(HANDPSO))!($G(^XTMP(HANDPSO,"STATUS"))'="Install Completed")!$G(MIEXP) D  L -^XTMP(HANDPSO) Q
 . D BMES^XPDUTL("**************************** WARNING ****************************")
 . D BMES^XPDUTL("  The DEA Migration has not run to completion within the last 7")
 . D BMES^XPDUTL("   days. Please run the DEA Migration using the DEA Migration ")
 . D BMES^XPDUTL("   Report [PSO DEA MIGRATION REPORT] option and entering 'YES'")
 . D BMES^XPDUTL("    at the prompt 'Do you want to re-run the DEA Migration?'")
 . D BMES^XPDUTL("               >>>> Installation aborted <<<<")
 . D BMES^XPDUTL("*****************************************************************")
 . S XPDABORT=1  ; Do not install this transport global and KILL it from ^XTMP.
 ;
 L -^XTMP(HANDPSO)
 Q
 ;
KRNCHK() ; Is PRDEA^XUSER routine present?
 S XPDABORT=0
 I $L($T(PRDEA^XUSER))<2 S XPDABORT=1 D
 . D MES^XPDUTL("Patch XU*8.0*689 is required.")
 . D BMES^XPDUTL("Please install XU*8.0*689 before installing this patch.")
 Q XPDABORT
