SD132PT ;ALB/MJK - Patch SD*5.3*132 Post-Init Routine ; 11/5/97
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
EN ; --- main entry point
 S U="^"
 D BMES^XPDUTL("Post-Init Started...")
 ;
 ; -- main driver calls
 D MAS,HL,LOG,ACG,AG,OVER
 ;
 D BMES^XPDUTL("Post-Init Finished.")
 Q
 ;
MAS ; -- delete MAS PARAMETERS (#43) fields and related data
 N SDARY
 ;
 D BMES^XPDUTL("   >>> Deleting MAS PARAMETERS (#43) fields...")
 ;
 ; -- get fields to delete
 D BUILDR(43,.SDARY)
 ;
 IF '$O(SDARY(0)) G MASQ
 ;
 ; -- delete data
 N SDFDA,SDFLD
 S SDFLD=0
 F  S SDFLD=$O(SDARY(SDFLD)) Q:'SDFLD  D
 . S SDFDA(43,"1,",SDFLD)="@"
 D FILE^DIE("S","SDFDA")
 ;
 ; -- delete dds
 D DELDD(43)
MASQ D MES^XPDUTL("   >>> Done.")
 Q
 ;
HL ; -- delete HOSPITIAL LOCATION (#44) fields and related data
 N SDARY
 ;
 D BMES^XPDUTL("   >>> Deleting HOSPITAL LOCATION (#44) fields...")
 ;
 ; -- get fields to delete
 D BUILDR(44,.SDARY)
 ;
 IF '$O(SDARY(0)) G HLQ
 ;
 ; -- delete data
 S SDIEN=0
 F  S SDIEN=$O(^SC(SDIEN)) Q:'SDIEN  D
 . N SDFDA,SDFLD
 . S SDFLD=0
 . F  S SDFLD=$O(SDARY(SDFLD)) Q:'SDFLD  D
 . . S SDFDA(44,SDIEN_",",SDFLD)="@"
 . D FILE^DIE("S","SDFDA")
 ;
 ; -- delete dds
 D DELDD(44)
HLQ D MES^XPDUTL("   >>> Done.")
 Q
 ;
LOG ; -- delete APPOINTMENT STATUS UPDATE LOG (#409.65) fields and related data
 N SDARY
 ;
 D BMES^XPDUTL("   >>> Deleting APPPOINT STATUS UPDATE LOG (409.65) fields...")
 ;
 ; -- get fields to delete
 D BUILDR(409.65,.SDARY)
 ;
 IF '$O(SDARY(0)) G LOGQ
 ;
 ; -- delete data
 S SDIEN=0
 F  S SDIEN=$O(^SDD(409.65,SDIEN)) Q:'SDIEN  D
 . N SDFDA,SDFLD
 . S SDFLD=0
 . F  S SDFLD=$O(SDARY(SDFLD)) Q:'SDFLD  D
 . . S SDFDA(409.65,SDIEN_",",SDFLD)="@"
 . D FILE^DIE("S","SDFDA")
 ;
 ; -- delete dds
 D DELDD(409.65)
LOGQ D MES^XPDUTL("   >>> Done.")
 Q
 ;
ACG ; -- update new computer generated appt type related fields in
 ;    OUTPATIENT ENCOUNTER (#409.68) with data for ^SDV data
 ;
 D BMES^XPDUTL("   >>> Setting 'ACG' cross references...")
 ;
 ; -- scan ^SDV("ACG") for records
 N SDATE,SDCS,SDCS0,SDOE,SDOE0,SDREASON,SDAPPT,SDCG,DR,DA,DIE
 S SDATE=0
 F  S SDATE=$O(^SDV("ACG",SDATE)) Q:'SDATE  D
 . S SDCS=0 F  S SDCS=$O(^SDV("ACG",SDATE,SDCS)) Q:'SDCS  D
 . . S SDCS0=$G(^SDV(SDATE,"CS",SDCS,0))
 . . S SDCG=+$G(^SDV(SDATE,"CS",SDCS,1))
 . . S SDAPPT=$P(SDCS0,U,5)
 . . S SDREASON=$P(SDCS0,U,6)
 . . S SDOE=+$P(SDCS0,U,8)
 . . S SDOE0=$G(^SCE(SDOE,0))
 . . IF SDAPPT=10,SDOE,$P(SDOE0,U,10)=10,$G(^SCE(SDOE,"CG"))="" D
 . . . S DR=".1////10"
 . . . IF SDCG S DR=DR_";201////1"
 . . . IF SDREASON S DR=DR_";202////"_SDREASON
 . . . S DIE="^SCE(",DA=SDOE D ^DIE
 ;
 D MES^XPDUTL("   >>> Done.")
 Q
 ;
AG ; -- queue job to set 'AG' xref and related fields
 N SDUZ,ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSAVE,ZTSK
 S SDUZ=$G(DUZ)
 D BMES^XPDUTL("   >>> Queuing task to set 'AG' cross reference.")
 ; -- disable option
 D OUT^XPDMENU("SDACS CGSCLIST","AG Cross Reference Being Set")
 D MES^XPDUTL("       -> Option 'SDACS CGSCLIST' has been placed out of service.")
 ;
 ; -- queue task
 S ZTIO=""
 S ZTRTN="AGQUE^SD132PT"
 S ZTDESC="Setting 'AG' Cross Reference"
 S ZTDTH=$$NOW^XLFDT()
 F X="SDUZ" S ZTSAVE(X)=""
 D ^%ZTLOAD
 D:$D(ZTSK) MES^XPDUTL("       -> Task: #"_ZTSK)
 D MES^XPDUTL("   >>> Done.")
 Q
 ;
AGQUE ; -- TaskMan entry point to queue 'AG' setting
 ;
 N SDATE,SDCS,SDCS0,SDOE,SDREASON,SDCG,DR,DA,DIE,SDSTOP,SDTOT,SDBEG,SDEND
 ;
 S SDTOT=0
 S SDBEG=$$NOW^XLFDT()
 ;
 ; -- scan ^SDV("AG") for records
 S SDATE=0
 F  S SDATE=$O(^SDV("AG",SDATE)) Q:'SDATE  D  S SDSTOP=$$S^%ZTLOAD Q:SDSTOP
 . S SDCS=0 F  S SDCS=$O(^SDV("AG",SDATE,SDCS)) Q:'SDCS  D
 . . S SDCS0=$G(^SDV(SDATE,"CS",SDCS,0))
 . . S SDCG=+$G(^SDV(SDATE,"CS",SDCS,1))
 . . S SDOE=+$P(SDCS0,U,8)
 . . S SDREASON=$P(SDCS0,U,6)
 . . IF SDOE,$G(^SCE(SDOE,0))]"",$G(^SCE(SDOE,"CG"))="",SDCG D
 . . . S DR="201////1"
 . . . IF SDREASON S DR=DR_";202////"_SDREASON
 . . . S DIE="^SCE(",DA=SDOE D ^DIE
 . . . S SDTOT=SDTOT+1
 ;
 S SDEND=$$NOW^XLFDT()
 ; -- send bulletin and enable option
 D BULL
 Q
 ;
BULL ; -- send message indicating 'AG' xref is set and option enabled
 N SDTEXT,SDCNT,XMSUB,XMN,XMTEXT,XMDUZ,XMY
 S SDCNT=0
 ;
 D LINE("")
 D LINE("  >>>  Task Started: "_$$FMTE^XLFDT(SDBEG))
 D LINE("           Finished: "_$$FMTE^XLFDT(SDEND))
 D LINE("")
 ;
 ; -- build text
 IF SDSTOP D
 . D LINE("   >>> Task stopped by user. <<<")
 ELSE  D
 . ; -- enable option
 . D OUT^XPDMENU("SDACS CGSCLIST","")
 . ;
 . ; -- build text
 . D LINE("   >>> Task Completed.")
 . D LINE("")
 . D LINE("   >>> Option 'SDACS CGSCLIST' is back in service.")
 ;
 D LINE("")
 D LINE("   >>> "_SDTOT_" Records processed.")
 ; -- set xm vars and send message
 S XMSUB="Setting of 'AG' Cross Reference Task Information"
 S XMN=0
 S XMTEXT="SDTEXT("
 S XMDUZ=.5
 S XMY(SDUZ)=""
 D ^XMD
 Q
 ;
OVER ; -- post override flag information
 N SDPKG,SDCNT
 ;
 D BMES^XPDUTL("   >>> Package Override Flag Information")
 ;
 S SDPKG="A",SDCNT=0
 F  S SDPKG=$O(^XTMP("SD*5.3*132 OVERRIDE FLAGS",SDPKG)) Q:SDPKG=""  D
 . D MES^XPDUTL("       -> Override flag set for '"_SDPKG_"'")
 . S SDCNT=SDCNT+1
 ;
 IF 'SDCNT D MES^XPDUTL("       -> No package override flags set.")
 D MES^XPDUTL("   >>> Done.")
 Q
 ;
LINE(TEXT) ; -- add line of text
 S SDCNT=SDCNT+1
 S SDTEXT(SDCNT)=TEXT
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
 ;;43^201^SPEC SURVEY DISP LAST RUN
 ;;43^202^OPC FILE LAST RUN
 ;;43^203^OPC TRANSMISSION LAST RUN
 ;;43^204^GENERATING OPC FILE NOW?
 ;;43^206^AMB PROC INITIALIZATION DATE
 ;;43^206.1^OPC VLR DATE
 ;;43^206.2^OPC MT INCOME DATE
 ;;43^207^OPC STOP CODE CONVERSION DATE
 ;;43^208^OPC GENERATION START DATE
 ;;43^209^OPC GENERATION END DATE
 ;;43^214^GEN OPC W/APPT STATUS UPDATE
 ;;43^221^STOP CODE MAIL GROUP
 ;;43^218^OPC FY93 FORMAT DATE
 ;;43^219^ASK PROVIDER ON DISPOSITION
 ;;43^220^ASK DIAGNOSIS ON DISPOSITION
 ;;43^222^OPC FY94 FORMAT DATE
 ;;43^225^OPC FY95 FORMAT DATE
 ;;44^25^PROCEDURE CHECK-OFF SHEET
 ;;44^26^ASK PROVIDER AT CHECK OUT
 ;;44^27^ASK DIAGNOSIS AT CHECK OUT
 ;;44^28^ASK STOP CODES AT CHECK OUT
 ;;409.65^.06^OPC LAST GENERATED
 ;;409.65^.07^OPC LAST TRANSMITTED
 ;;409.65^.08^OPC LAST GENERATED BY
 ;;409.65^.09^OPC LAST TRANSMITTED BY
 ;;$$END$$
