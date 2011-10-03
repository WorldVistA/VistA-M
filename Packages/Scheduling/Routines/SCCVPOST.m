SCCVPOST ;ALB/MJK - Patch SD*5.3*201 Post-Install Routine ; 11/5/97
 ;;5.3;Scheduling;**211**,Aug 13, 1993
 ;
EN ; --- main entry point
 S U="^"
 D BMES^XPDUTL("Post-Install Started...")
 ;
 ; -- main driver calls
 D RES,LOGDATA
 ;
 D BMES^XPDUTL("Post-Install Finished.")
 Q
 ;
RES ; -- set up resource device
 N NAME,SLOTS,DESC
 D BMES^XPDUTL("   >>> SCCV RESOURCE device setup...")
 S NAME="SCCV RESOURCE"
 S SLOTS=1
 S DESC="Scheduling Conversion Resource Device"
 ;
 ; -- check to see if device already exists
 IF $D(^%ZIS(1,"B",NAME)) D  G RESQ
 . D MES^XPDUTL("         ...Device already exists.")
 ;
 ; -- create device
 IF $$RES^XUDHSET(NAME,,SLOTS,DESC)>0 D  G RESQ
 . D MES^XPDUTL("         ...Resource device successfully created.")
 ;
 ; -- indicate device creation failed
 D MES^XPDUTL("         ...Unable to create resource device!")
RESQ Q
 ;
LOGDATA ; -- queue job to transfer 'edited by' & 'date entry made' data
 N SDUZ,ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSAVE,ZTSK
 ;
 ; -- quit if pre-test
 IF '$$OK^SCCVU(0) Q
 ;
 S SDUZ=$G(DUZ)
 D BMES^XPDUTL("   >>> Queuing task to transfer log data from Scheduling Visits file")
 ;
 ; -- following line in for interactive testing
 ;D LOGQUE Q
 ;
 ; -- has data already been xfer'd
 IF $P($G(^SD(404.91,1,"CNV")),U,8) D  G LOGDATAQ
 . D MES^XPDUTL("         o  Data already has been transferred.")
 . D MES^XPDUTL("            (No task queued.)")
 . D MES^XPDUTL("   >>> Done.")
 ;
 ; -- queue task
 S ZTIO=""
 S ZTRTN="LOGQUE^SCCVPOST"
 S ZTDESC="Transferring log data from Scheduling Visits file"
 S ZTDTH=$$NOW^XLFDT()
 F X="SDUZ" S ZTSAVE(X)=""
 D ^%ZTLOAD
 D:$D(ZTSK) MES^XPDUTL("       -> Task: #"_ZTSK)
 D MES^XPDUTL("   >>> Done.")
LOGDATAQ Q
 ;
LOGQUE ; -- TaskMan entry point to queue log data transfer
 ;
 N SDATE,SDOE,DR,DA,DIE,SDSTOP,SDTOT,SDBEG,SDEND,SDDR,SDFIN
 ;
 ; -- quit if pre-test
 IF '$$OK^SCCVU(0) Q
 ;
 S SDTOT=0
 S SDBEG=$$NOW^XLFDT()
 ;
 ; -- get date ACRP started on target system ; use as loop start date
 S SDATE=$P($G(^SD(404.91,1,"AMB")),U,2)
 ;
 ; -- get date of last a/e ; use as finish date
 S SDFIN=$P($O(^SDV("A"),-1),".")_".24"
 ;
 ; -- scan ^SCE records
 F  S SDATE=$O(^SCE("B",SDATE)) Q:'SDATE!(SDATE>SDFIN)  D  S SDSTOP=$$S^%ZTLOAD Q:SDSTOP
 . S SDOE=0 F  S SDOE=$O(^SCE("B",SDATE,SDOE)) Q:'SDOE  D
 . . S SDDR=$$BUILDR(.SDOE)
 . . IF SDDR]"" D
 . . . S DIE="^SCE(",DA=SDOE,DR=SDDR D ^DIE
 . . . S SDTOT=SDTOT+1
 ;
 S SDEND=$$NOW^XLFDT()
 ;
 ; -- send bulletin
 D BULL
 ;
 ; -- set completion flag
 S DA=1,DR="908////"_SDEND,DIE="^SD(404.91," D ^DIE
 ;
 Q
 ;
BUILDR(SDOE) ; -- build DR string
 ;
 N SDDR
 N SDOE0,SDOECNV,SDOEUSER,SDORG,SCEUSR,SCECRE,DFN
 N SDT,SDCS,SDCS0,SDVUSR,SDVCRE,SDVOE
 S SDDR=""
 ;
 ; -- get sce data
 S SDOE0=$G(^SCE(SDOE,0))
 S SDOECNV=$G(^SCE(SDOE,"CNV"))
 S SDOEUSER=$G(^SCE(SDOE,"USER"))
 S SDORG=+$P(SDOE0,U,8)
 S SCEUSR=+SDOEUSER
 S SCECRE=+$P(SDOECNV,U,2)
 ;
 ; -- quit if not an add/edit
 IF SDORG'=2 G BUILDRQ
 ;
 ; -- get sdv data
 S DFN=+$P(SDOE0,U,2)
 S SDT=$$SDVIEN^SCCVU(DFN,+SDOE0)
 S SDCS=$P(SDOE0,U,9)
 S SDCS0=$G(^SDV(+SDT,"CS",+SDCS,0))
 S SDVUSR=$P(SDCS0,U,2)
 S SDVCRE=$P(SDCS0,U,7)
 S SDVOE=+$P(SDCS0,U,8)
 ;
 ; -- quit if cs node not found
 IF SDCS0="" G BUILDRQ
 ;
 ; -- quit if ien numbers don't match
 IF SDOE'=SDVOE G BUILDRQ
 ;
 ; -- compare sce and sdv data and set DR string accordingly
 IF 'SCEUSR,SDVUSR S SDDR="101////"_SDVUSR
 IF 'SCECRE,SDVCRE S SDDR=SDDR_$S(SDDR]"":";",1:"")_"902////"_SDVCRE
 ;
BUILDRQ Q SDDR
 ;
BULL ; -- send message indicating transfer of log data complete or stopped
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
 . ; -- build text
 . D LINE("   >>> Task Completed.")
 ;
 D LINE("")
 D LINE("   >>> "_SDTOT_" Records processed.")
 ;
 ; -- set xm vars and send message
 S XMSUB="Transfer of Scheduling Visits Log Data - Task Information"
 S XMN=0
 S XMTEXT="SDTEXT("
 S XMDUZ=.5
 S XMY(SDUZ)=""
 D ^XMD
 Q
 ;
LINE(TEXT) ; -- add line of text
 S SDCNT=SDCNT+1
 S SDTEXT(SDCNT)=TEXT
 Q
 ;
