FBXIP165 ;OIPD/SAB - PATCH INSTALL ROUTINE ;12/28/2015
 ;;3.5;FEE BASIS;**165**;JAN 30, 1995;Build 7
 ;;Per VA Directive 6402, this routine should not be modified.
 ; 
 ; ICRs
 ;  #2053   FILE^DIE
 ;  #2056   $$GET1^DIQ
 ;  #10103  $$FMADD^XLFDT, $$FMTE^XLFDT
 ;  #10141  BMES^XPDUTL, MES^XPDUTL, $$NEWCP^XPDUTL
 ;
PS ; post-install entry point
 ; create KIDS checkpoints with call backs
 N FBX,Y
 F FBX="DELREJ","RMVPAY" D
 . S Y=$$NEWCP^XPDUTL(FBX,FBX_"^FBXIP165")
 . I 'Y D BMES^XPDUTL("ERROR Creating "_FBX_" Checkpoint.")
 Q
 ;
RMVPAY ; remove payments that are paid or cancelled from in-process batch
 G IN^FBXI165A
 Q
 ;
DELREJ ; delete inappropriate reject flags from old payments
 N DA,DIERR,FBBAT,FBC,FBCKNUM,FBDT132,FBDTC,FBDTF,FBDTP
 N FBFILE,FBIENS,FBX
 D BMES^XPDUTL("    Deleting inappropriate reject flags on payments. This may take some time.")
 ;
 ;
 S FBDT132=3130307 ; patch FB*3.5*132 compliance date
 ;
 ; set header for XTMP with purge date in 180 days
 S ^XTMP("FB*3.5*165",0)=$$FMADD^XLFDT(DT,180)_"^"_DT_"^From patch FB*3.5*165 post init."
 ;
 D MES^XPDUTL("      processing sub-file 162.03...")
 D INITCNT
 S FBFILE=162.03
 ; loop thru rejected payments using x-ref on OLD BATCH NUMBER
 ; loop thru old batch number
 S FBBAT=0 F  S FBBAT=$O(^FBAAC("AH",FBBAT)) Q:'FBBAT  D
 . ; loop thru patient
 . N DA
 . S DA(3)=0 F  S DA(3)=$O(^FBAAC("AH",FBBAT,DA(3))) Q:'DA(3)  D
 . . ; loop thru vendor
 . . S DA(2)=0 F  S DA(2)=$O(^FBAAC("AH",FBBAT,DA(3),DA(2))) Q:'DA(2)  D
 . . . ; loop thru initial treatment date
 . . . S DA(1)=0
 . . . F  S DA(1)=$O(^FBAAC("AH",FBBAT,DA(3),DA(2),DA(1))) Q:'DA(1)  D
 . . . . ; loop thru service provided
 . . . . S DA=0
 . . . . F  S DA=$O(^FBAAC("AH",FBBAT,DA(3),DA(2),DA(1),DA)) Q:'DA  D
 . . . . . S FBDTP=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0)),U,14) ; paid
 . . . . . S FBDTC=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,2)),U,4) ; canc
 . . . . . S FBCKNUM=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,2)),U,3)
 . . . . . Q:'$$OKDEL
 . . . . . ;
 . . . . . S FBIENS=DA_","_DA(1)_","_DA(2)_","_DA(3)_","
 . . . . . ;
 . . . . . ; save current reject data to XTMP
 . . . . . M ^XTMP("FB*3.5*165","DELREJ",FBFILE,FBBAT,FBIENS,"FBREJ")=^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,"FBREJ")
 . . . . . M ^XTMP("FB*3.5*165","DELREJ",FBFILE,FBBAT,FBIENS,"FBREJC")=^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,"FBREJC")
 . . . . . ;
 . . . . . ; delete reject flag
 . . . . . S FBX=$$DELREJ^FBAARR3(FBFILE,FBIENS)
 . . . . . I 'FBX D MES^XPDUTL("  Problem encountered while deleting reject flag for record with IENS "_FBIENS)
 . . . . . I 'FBX,$P(FBX,U,2)'="" D MES^XPDUTL("    "_$P(FBX,U,2))
 . . . . . ;
 . . . . . ; populate payment date finalized using value from batch
 . . . . . I FBDTF?7N D
 . . . . . . N FBFDA,DIERR
 . . . . . . S FBFDA(162.03,FBIENS,5)=FBDTF
 . . . . . . D FILE^DIE("","FBFDA")
 . . . . . . I $G(DIERR)'="" D MES^XPDUTL("  Error updating date finalized for record with IENS "_FBIENS)
 D SHOWCNT
 ;
 D MES^XPDUTL("      processing file 162.5...")
 D INITCNT
 S FBFILE=162.5
 ; loop thru rejected payments using x-ref on OLD BATCH NUMBER
 ; loop thru old batch number
 S FBBAT=0 F  S FBBAT=$O(^FBAAI("AH",FBBAT)) Q:'FBBAT  D
 . ; loop thru invoice
 . N DA
 . S DA=0 F  S DA=$O(^FBAAI("AH",FBBAT,DA)) Q:'DA  D
 . . S FBDTP=$P($G(^FBAAI(DA,2)),U,1) ; paid
 . . S FBDTC=$P($G(^FBAAI(DA,2)),U,5) ; canc
 . . Q:'$$OKDEL
 . . ;
 . . S FBIENS=DA_","
 . . ;
 . . ; save current reject data to XTMP
 . . M ^XTMP("FB*3.5*165","DELREJ",FBFILE,FBBAT,FBIENS,"FBREJ")=^FBAAI(DA,"FBREJ")
 . . M ^XTMP("FB*3.5*165","DELREJ",FBFILE,FBBAT,FBIENS,"FBREJC")=^FBAAI(DA,"FBREJC")
 . . ;
 . . ; delete reject flag
 . . S FBX=$$DELREJ^FBAARR3(FBFILE,FBIENS)
 . . I 'FBX D MES^XPDUTL("  Problem encountered while deleting reject flag for record with IENS "_FBIENS)
 . . I 'FBX,$P(FBX,U,2)'="" D MES^XPDUTL("    "_$P(FBX,U,2))
 . . ;
 . . ; populate payment date finalized using value from batch
 . . I FBDTF?7N D
 . . . N FBFDA,DIERR
 . . . S FBFDA(162.5,FBIENS,19)=FBDTF
 . . . D FILE^DIE("","FBFDA")
 . . . I $G(DIERR)'="" D MES^XPDUTL("  Error updating date finalized for record with IENS "_FBIENS)
 D SHOWCNT
 ;
 D MES^XPDUTL("      processing sub-file 162.04...")
 D INITCNT
 S FBFILE=162.04
 ; loop thru rejected payments using x-ref on OLD BATCH NUMBER
 ; loop thru old batch number
 S FBBAT=0 F  S FBBAT=$O(^FBAAC("AG",FBBAT)) Q:'FBBAT  D
 . ; loop thru patient
 . N DA
 . S DA(1)=0 F  S DA(1)=$O(^FBAAC("AG",FBBAT,DA(1))) Q:'DA(1)  D
 . . ; loop thru travel payment date
 . . S DA=0 F  S DA=$O(^FBAAC("AG",FBBAT,DA(1),DA)) Q:'DA  D
 . . . S FBDTP=$P($G(^FBAAC(DA(1),3,DA,0)),U,6) ; paid
 . . . S FBDTC=$P($G(^FBAAC(DA(1),3,DA,0)),U,8) ; canc
 . . . Q:'$$OKDEL
 . . . ;
 . . . S FBIENS=DA_","_DA(1)_","
 . . . ;
 . . . ; save current reject data to XTMP
 . . . M ^XTMP("FB*3.5*165","DELREJ",FBFILE,FBBAT,FBIENS,"FBREJ")=^FBAAC(DA(1),3,DA,"FBREJ")
 . . . M ^XTMP("FB*3.5*165","DELREJ",FBFILE,FBBAT,FBIENS,"FBREJC")=^FBAAC(DA(1),3,DA,"FBREJC")
 . . . ;
 . . . ; delete reject flag
 . . . S FBX=$$DELREJ^FBAARR3(FBFILE,FBIENS)
 . . . I 'FBX D MES^XPDUTL("  Problem encountered while deleting reject flag for record with IENS "_FBIENS)
 . . . I 'FBX,$P(FBX,U,2)'="" D MES^XPDUTL("    "_$P(FBX,U,2))
 D SHOWCNT
 ;
 D MES^XPDUTL("      processing sub-file 162.11...")
 D INITCNT
 S FBFILE=162.11
 ; loop thru rejected payments using x-ref on OLD BATCH NUMBER
 ; loop thru old batch number
 S FBBAT=0 F  S FBBAT=$O(^FBAA(162.1,"AF",FBBAT)) Q:'FBBAT  D
 . ; loop thru invoice
 . N DA
 . S DA(1)=0 F  S DA(1)=$O(^FBAA(162.1,"AF",FBBAT,DA(1))) Q:'DA(1)  D
 . . ; loop thru prescription
 . . S DA=0 F  S DA=$O(^FBAA(162.1,"AF",FBBAT,DA(1),DA)) Q:'DA  D
 . . . S FBDTP=$P($G(^FBAA(162.1,DA(1),"RX",DA,2)),U,8) ; paid
 . . . S FBDTC=$P($G(^FBAA(162.1,DA(1),"RX",DA,2)),U,11) ; canc
 . . . Q:'$$OKDEL
 . . . ;
 . . . S FBIENS=DA_","_DA(1)_","
 . . . ;
 . . . ; save current reject data to XTMP
 . . . M ^XTMP("FB*3.5*165","DELREJ",FBFILE,FBBAT,FBIENS,"FBREJ")=^FBAA(162.1,DA(1),"RX",DA,"FBREJ")
 . . . M ^XTMP("FB*3.5*165","DELREJ",FBFILE,FBBAT,FBIENS,"FBREJC")=^FBAA(162.1,DA(1),"RX",DA,"FBREJC")
 . . . ;
 . . . ; delete reject flag
 . . . S FBX=$$DELREJ^FBAARR3(FBFILE,FBIENS)
 . . . I 'FBX D MES^XPDUTL("  Problem encountered while deleting reject flag for record with IENS "_FBIENS)
 . . . I 'FBX,$P(FBX,U,2)'="" D MES^XPDUTL("    "_$P(FBX,U,2))
 D SHOWCNT
 ;
 D MES^XPDUTL("    Done deleting inappropriate reject flags.")
 Q
OKDEL() ; check reject for inappropriate reject flag
 ; Input
 ;   FBDT132 - compiance date for FB*3.5*132
 ;   FBDTP   - DATE PAID
 ;   FBDTC   - CANCELLATION DATE
 ;   FBBAT   - OLD BATCH NUMBER
 ;   FBC(    - counters
 ;   FBFILE  - file or sub-file number
 ;   FBCKNUM - FBCKNUM only defined when FBFILE = 162.03
 ; Output
 ;   FBDTF  - DATE FINALIZED for batch FBBAT
 ;   FBC(   - counters
 ; Return value
 ;   0 or 1, true (=1) if reject flag should be deleted
 ;
 N FBOLD
 ;
 ; increment count of rejects
 S FBC("REJ")=FBC("REJ")+1
 ;
 ; Skip if line item not confirmed or cancelled
 I 'FBDTP,'FBDTC Q 0
 ;   if outp/anc, not cancelled, date paid exists but < 1/1/2011 and
 ;   check number is blank then don't treat as a confirmed payment.
 ;   Prior to version 3.5 the DATE PAID was populated by transmission
 ;   to Central FEE instead of a value returned by Central FEE.
 ;   CHECK NUMBER is better indicator of actual payment except for
 ;   0 dollar line items which were not transmitted to Central FEE until
 ;   patch FB*3.5*116.  Earliest install of FB*3.5*116 is Jan 7, 2011.
 I FBFILE=162.03,'FBDTC,FBDTP,FBDTP<3110107,FBCKNUM="" Q 0
 ;
 ; increment count of rejects with payment confirmation/cancellation
 S FBC("REJC")=FBC("REJC")+1
 ;
 ; don't delete if batch status is not vouchered
 I $S(FBBAT:$$GET1^DIQ(161.7,FBBAT_",",11,"I"),1:"")'="V" D  Q 0
 . S FBC("NVOU")=FBC("NVOU")+1
 ;
 ; determine if is an old payment
 S FBOLD=0
 S FBDTF=$S(FBBAT:$$GET1^DIQ(161.7,FBBAT_",",13,"I"),1:"") ; finalized
 I FBDTF,FBDTF<FBDT132 S FBOLD=1
 I 'FBOLD,FBDTP,FBDTP<FBDT132 S FBOLD=1
 I 'FBOLD,FBDTC,FBDTC<FBDT132 S FBOLD=1
 ; don't delete if not an old payment
 I 'FBOLD S FBC("NOLD")=FBC("NOLD")+1 Q 0
 ;
 ; passed all checks to delete the reject flag
 S FBC("DELR")=FBC("DELR")+1
 Q 1
 ;
INITCNT ; initalize counters for file/sub-file
 S FBC("REJ")=0 ; count of line items flagged as rejected
 S FBC("REJC")=0 ; count of rejected line items with pay conf/canc
 S FBC("NVOU")=0 ; count of inapp. rejects not vouchered so not deleted
 S FBC("NOLD")=0 ; count of inapp. rejects not old so not deleted
 S FBC("DELR")=0 ; count of reject flags deleted
 Q
SHOWCNT ; show counts for file/sub-file
 N FBTYPE,FBX
 I FBFILE=162.03 S FBTYPE="outpatient/ancillary"
 I FBFILE=162.04 S FBTYPE="travel"
 I FBFILE=162.11 S FBTYPE="pharmacy"
 I FBFILE=162.5 S FBTYPE="inpatient"
 S FBX=$J($FN(FBC("REJ"),","),10)_" "_FBTYPE_" payment lines were flagged as rejected."
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBC("REJC"),","),10)_" of these rejects are inappropriate because the payment line"
 D MES^XPDUTL(FBX)
 S FBX="           also has payment confirmation or payment cancellation data."
 D MES^XPDUTL(FBX)
 S FBX=$J($FN(FBC("DELR"),","),10)_" of the inappropriate reject flags were deleted."
 D MES^XPDUTL(FBX)
 I FBC("NVOU")>0 D
 . S FBX=$J($FN(FBC("NVOU"),","),10)_" of the inappropriate reject flags could not be deleted"
 . D MES^XPDUTL(FBX)
 . S FBX="           because the batch status is not vouchered."
 . D MES^XPDUTL(FBX)
 I FBC("NOLD")>0 D
 . S FBX=$J($FN(FBC("NOLD"),","),10)_" of the inappropriate reject flags could not be deleted"
 . D MES^XPDUTL(FBX)
 . S FBX="           because the payment is not prior to "_$$FMTE^XLFDT(FBDT132)_"."
 . D MES^XPDUTL(FBX)
 Q
 ;
 ;FBXIP165
