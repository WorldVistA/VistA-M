SD599PT ;ALB/RJS - Patch SD*5.3*599 Post-Init Routine ; 8/13/12 11:08am
 ;;5.3;Scheduling;**599**;Aug 13, 1993;Build 11
 ;
 Q
 ;
EN ; --- main entry point
 S U="^"
 D BMES^XPDUTL("Post-Init Started...")
 ;
 ; -- main driver calls
 D HL
 ;
 D BMES^XPDUTL("Post-Init Finished.")
 Q
 ;
HL ; -- delete HOSPITIAL LOCATION (#44) fields and related data
 N SDARY,SDIEN
 ;
 D BMES^XPDUTL("   >>> Deleting HOSPITAL LOCATION (#44) fields...")
 ;
 ; -- get fields to delete
 D BUILDR(44,.SDARY)
 ;
 IF '$O(SDARY(0)) D MES^XPDUTL("       -> Fields already deleted.") Q
 ;
 ; -- delete data
 S SDIEN=0
 F  S SDIEN=$O(^SC(SDIEN)) Q:'SDIEN  D
 . N SDFDA,SDFLD
 . S SDFLD=0
 . F  S SDFLD=$O(SDARY(SDFLD)) Q:'SDFLD  D
 . . I SDFLD=25,$D(^SC("AE",1,SDIEN)) D  Q  ;Re file data associated with field 2802 global position 25
 . . . S SDFDA(44,SDIEN_",",SDFLD)=1
 . . . D FILE^DIE("S","SDFDA")
 . . S SDFDA(44,SDIEN_",",SDFLD)="@"
 . D FILE^DIE("S","SDFDA")
 I $D(^SC("AF")) K ^("AF") ;if "AF" xref still exists after file edit. Delete entire xref.
 ;
 ; -- delete dds
 D DELDD(44)
 D MES^XPDUTL("   >>> Done.")
 Q
 ;
BUILDR(SDD,SDARY) ; -- build array of fields to delete
 N SDI,SDX,SDENDFLG
 S SDENDFLG="$$END$$"
 ;
 F SDI=1:1 S SDX=$P($T(FLDS+SDI),";;",2) Q:SDX=SDENDFLG  D
 . N SDFILE,SDFLD
 . S SDFILE=+SDX
 . S SDFLD=+$P(SDX,U,2)
 . S SDNAME=$P(SDX,U,3)
 . IF SDD=SDFILE,$$LABEL(SDFILE,SDFLD)=SDNAME D
 . . S SDARY(SDFLD)=""
 Q
 ;
DELDD(SDD) ; -- tool to delete fields dd
 ; -- delete dd
 N SDI,SDX,SDENDFLG,SDCNT
 S SDENDFLG="$$END$$"
 S SDCNT=0
 ;
 ; -- delete dds
 F SDI=1:1 S SDX=$P($T(FLDS+SDI),";;",2) Q:SDX=SDENDFLG  D
 . N SDFILE,SDFLD,SDNAME
 . S SDFILE=+SDX
 . S SDFLD=+$P(SDX,U,2)
 . S SDNAME=$P(SDX,U,3)
 . ;
 . ; -- make sure field is not reused before deleting
 . IF SDD=SDFILE,$$LABEL(SDFILE,SDFLD)=SDNAME D
 . . N DIK,DA
 . . S DIK="^DD("_SDD_",",DA=SDFLD,DA(1)=SDD D ^DIK
 . . D MSG(SDFLD,SDNAME)
 . . S SDCNT=SDCNT+1
 ;
 IF 'SDCNT D MES^XPDUTL("       -> Fields already deleted.")
 Q
 ;
LABEL(SDFILE,SDFLD) ; -- get label if not deleted
 N SDY
 D FIELD^DID(SDFILE,SDFLD,"N","LABEL","SDY")
 Q $G(SDY("LABEL"))
 ;
MSG(SDFLD,SDNAME) ; -- tell user (use kids call??) 
 D MES^XPDUTL("       -> Field '"_SDFLD_" - "_SDNAME_"' deleted.")
 Q
 ;
FLDS ; -- fields to be deleted [ file# ^ field# ^ field label ]
 ;;44^25^PROCEDURE CHECK-OFF SHEET
 ;;44^26^ASK PROVIDER AT CHECK OUT
 ;;44^27^ASK DIAGNOSIS AT CHECK OUT
 ;;44^28^ASK STOP CODES AT CHECK OUT
 ;;$$END$$
