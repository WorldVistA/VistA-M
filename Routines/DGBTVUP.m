DGBTVUP ;ALB/MRY-UPDATE LOCAL VENDOR FILE W/ COREFLS VENDORS ;7/15/2003
 ;;1.0;Beneficiary Travel;**2,3**;September 25, 2001
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; the subroutines in this program are part of the Update Vendor 
 ; File event.  It builds a global array of the vendor ids for 
 ; the CoreFLS local vendor file update with CoreFLS Vendor records.
 ; The vendor IDs are passed to CoreFLS via DGBT software so 
 ; retrieval of CoreFLS Vendor records can be done.  The retrieved
 ; records are sent back to VistA for update to the local vendor 
 ; file (#392.31). 
 ;
EN ; entry point for Update Vendor REcords option
 ; build temporary global containing CoreFLS vendor ids
 N X S X="CSLVQ" X ^%ZOSF("TEST") I '$T W !!,"  ** COREFLS Package CSL V1.0 not installed. **" Q
 I '$D(^DGBT(392.31)) W !!,$C(7),"There are no CoreFLS Vendor IDs stored in the CoreFLS Local Vendor File (392.31)",!,"Vendor File Update cannot occur." Q
 W !?5,"Update of the CoreFLS Local Vendor file (#392.31) will begin."
 N DGBTDA,DGBTNUM,DGBTSITE,DGBTDATE
 S DGBTDA=0 F  S DGBTDA=$O(^DGBT(392.31,DGBTDA)) Q:'DGBTDA  D
 . S DGBTNUM=$$GET1^DIQ(392.31,DGBTDA_",",.02,"I") ; site number
 . S DGBTSITE=$$GET1^DIQ(392.31,DGBTDA_",",.03,"I") ; site
 . S DGBTDATE=$$GET1^DIQ(392.31,DGBTDA_",",3.01,"I") ; date of last update
 . I DGBTNUM="",DGBTSITE="" Q
 . S ^TMP("DGBTVUP",$J,DGBTDA)=DGBTNUM_"^"_DGBTSITE_"^"_DGBTDATE
 ; DGBT API is called to pass list of vendor ids for processing
 ; The vendor update operates asynchronously using a callback model
 ; input - 1st argument is Name of an array (local or global) 
 ;         containing ID, Site ID and Date of Last Update for each 
 ;         vendor to be updated
 ;        2nd argument is the entry point for the DGBT software to
 ;        call once CoreFLS returns the vendor records.  This
 ;         entry point belongs to the API that will perform the 
 ;        COREFLS LOCAL VENDOR file (392.31) update.
 D UPDATE^CSLVQ($NA(^TMP("DGBTVUP",$J)),"UPD^DGBTVUP")
 Q
 ;
UPD(DGBTARRY) ;
 ; DGBTARRY is an input and is the name of the global or local arry
 ; containing the vendor record(s) retrieved from the CoreFLS
 ; vendor tables via a request from DGBT software
 ;
 N DGBTFDA,DGBTVDA,DGBTIDX
 S (DGBTIDX,DGBTVDA,DGBTCNT)=0
 F  S DGBTIDX=$O(@DGBTARRY@(DGBTIDX)) Q:'DGBTIDX  D
 . S DGBTVDA=$O(^DGBT(392.31,"BB",@DGBTARRY@(DGBTIDX,"SITE_CODE"),@DGBTARRY@(DGBTIDX,"NUMBER"),""))
 . I 'DGBTVDA S DGBTCNT=DGBTCNT+1,^TMP("DGBTUPDERR",$J,DGBTCNT)="No record entry found for CoreFLS Vendor Number and Vendor Site Name "_@DGBTARRY@(DGBTIDX,"NUMBER")_", "_@DGBTARRY@(DGBTIDX,"SITE_CODE") Q
 . D FILE
 D GETERRM,SMSG
 Q
 ;
FILE ; file into existing entry
 L +^DGBT(392.31,DGBTVDA):30
 I '$T S DGBTCNT=DGBTCNT+1,^TMP("DGBTUPDERR",$J,DGBTCNT)="Record entry "_DGBTVDA_"could not be locked during COREFLS LOCAL VENDOR file update process.  Record entry update with CoreFLS Vendor record not performed." Q
 I $D(@DGBTARRY@(DGBTIDX,"NAME")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",.01)=@DGBTARRY@(DGBTIDX,"NAME")
 I $D(@DGBTARRY@(DGBTIDX,"NUMBER")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",.02)=@DGBTARRY@(DGBTIDX,"NUMBER")
 I $D(@DGBTARRY@(DGBTIDX,"TAXID")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",.04)=@DGBTARRY@(DGBTIDX,"TAXID")
 I $D(@DGBTARRY@(DGBTIDX,"AREA_CODE")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",.05)=@DGBTARRY@(DGBTIDX,"AREA_CODE")
 I $D(@DGBTARRY@(DGBTIDX,"PHONE")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",.06)=@DGBTARRY@(DGBTIDX,"PHONE")
 I $D(@DGBTARRY@(DGBTIDX,"FAX_AREA_CODE")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",.07)=@DGBTARRY@(DGBTIDX,"FAX_AREA_CODE")
 I $D(@DGBTARRY@(DGBTIDX,"FAX")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",.08)=@DGBTARRY@(DGBTIDX,"FAX")
 I $D(@DGBTARRY@(DGBTIDX,"ADDRESS1")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",1.01)=@DGBTARRY@(DGBTIDX,"ADDRESS1")
 I $D(@DGBTARRY@(DGBTIDX,"ADDRESS2")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",1.02)=@DGBTARRY@(DGBTIDX,"ADDRESS2")
 I $D(@DGBTARRY@(DGBTIDX,"ADDRESS3")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",1.03)=@DGBTARRY@(DGBTIDX,"ADDRESS3")
 I $D(@DGBTARRY@(DGBTIDX,"CITY")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",2.01)=@DGBTARRY@(DGBTIDX,"CITY")
 I $D(@DGBTARRY@(DGBTIDX,"STATE")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",2.02)=@DGBTARRY@(DGBTIDX,"STATE")
 I $D(@DGBTARRY@(DGBTIDX,"ZIP")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",2.03)=@DGBTARRY@(DGBTIDX,"ZIP")
 I $D(@DGBTARRY@(DGBTIDX,"SITE_CODE")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",.03)=@DGBTARRY@(DGBTIDX,"SITE_CODE")
 I $D(@DGBTARRY@(DGBTIDX,"LAST_UPDATED")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",3.01)=@DGBTARRY@(DGBTIDX,"LAST_UPDATED")
 I $D(@DGBTARRY@(DGBTIDX,"INACTIVE_DATE")) D
 . S DGBTFDA(1,392.31,DGBTVDA_",",3.02)=@DGBTARRY@(DGBTIDX,"INACTIVE_DATE")
 D FILE^DIE("","DGBTFDA(1)","")
 L -^DGBT(392.31,DGBTVDA)
 Q
 ;
GETERRM ; pull any exceptions from FM output array and assign to ^TMP
 Q:'$D(DIERR)  ; quit if no output array
 N DGBTERRC,DGBTERRT,DGBTERRN,DGBTERRP,DGBTCNT,MSGARRY,DGBTERRM
 S (DGBTERRC,DGBTERRN)=0,DGBTCNT=1
 F  S DGBTERRC=$O(^TMP("DIERR",$J,"E",DGBTERRC)) Q:'DGBTERRC  F  S DGBTERRN=$O(^TMP("DIERR",$J,"E",DGBTERRC,DGBTERRN)) Q:'DGBTERRN  D
 . S DGBTERRP=0 F  S DGBTERRP=$O(^TMP("DIERR",$J,DGBTERRN,"PARAM",DGBTERRP)) Q:DGBTERRP=""  S MSGARRY("PARAM"_DGBTERRP)=DGBTERRP_" "_^(DGBTERRP)
 . S DGBTERRT=0 F  S DGBTERRT=$O(^TMP("DIERR",$J,DGBTERRN,"TEXT",DGBTERRT)) Q:'DGBTERRT  S MSGARRY("TEXT"_DGBTERRT)=^(DGBTERRT)
 . S DGBTERRM="" F  S DGBTERRM=$O(MSGARRY(DGBTERRM)) Q:DGBTERRM=""  S DGBTCNT=DGBTCNT+1,^TMP("DGBTUPDERR",$J,DGBTCNT)=MSGARRY(DGBTERRM)
 ; clean FM error message output array
 D CLEAN^DILF
 Q
 ;
SMSG ; necessary assignment of variables for MAILMAN processing
 N XMDUZ,XMSUB,XMTEXT,XMY,DGBTSITE
 S DGBTSITE=$P($$SITE^VASITE,"^",2)
 S X=$T(+0) X ^%ZOSF("RSUM") S ^TMP("DGBTUPDERR",$J,1)="CoreFLS Local Vendor file update run at "_DGBTSITE_" = "_Y
 S XMY("YORTY.M@MNTVBB.FO-ALBANY.MED.VA.GOV")=""
 S %DT="T",X="NOW" D ^%DT,DD^LRX S DGBTNOW=Y
 S XMSUB="CoreFLS Local Vendor file update at "_DGBTSITE_" at "_DGBTNOW,XMDUZ="UPDATE VENDOR RECORDS post-update message"
 S XMTEXT="^TMP(""DGBTUPDERR"",$J,"
 D ^XMD
 K ^TMP("DGBTUPDERR",$J)
 Q
