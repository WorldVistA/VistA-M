PXRMARCH ;SLC/PKR/BNT - Clinical Reminder ARCH routines. ;12/09/2011
 ;;2.0;CLINICAL REMINDERS;**20,23**;Feb 04, 2005;Build 3
 ;==========================================================
ELIG(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;Multiple occurrence
 ;computed finding for ARCH eligibility.
 N ARCHDATA,IND,SDIR
 ;DBIA #5619
 S IND=$$ELIG^FBARCH0(DFN,BDT,EDT,.ARCHDATA)
 S SDIR=$S(NGET<0:-1,1:1)
 S NGET=$S(NGET<0:-NGET,1:NGET)
 S IND="",NFOUND=0
 F  S IND=$O(ARCHDATA(IND),SDIR) Q:(IND="")!(NFOUND=NGET)  D
 . S NFOUND=NFOUND+1
 . S TEST(NFOUND)=$P(ARCHDATA(IND),U,1)
 . S DATE(NFOUND)=$P(ARCHDATA(IND),U,2)
 . S TEXT(NFOUND)=""
 Q
 ;
 ;==========================================================
LIST(NGET,BDT,EDT,PLIST,PARAM) ;List computed finding for building a list
 ;of ARCH eligible patients.
 N CNT,DATE,DFN,IND,NL,TEMP
 ;DBIA #5619
 S NL=$$LIST^FBARCH0(BDT,EDT)
 F IND=1:1:NL D
 . S TEMP=^TMP($J,"ARCHFEE",IND)
 .;Check eligibility.
 . I '$P(TEMP,U,2) Q
 . S DFN=$P(TEMP,U,1),DATE=$P(TEMP,U,3)
 . S ^TMP($J,"TLIST",DFN,DATE)=""
 S DFN=""
 F  S DFN=$O(^TMP($J,"TLIST",DFN)) Q:DFN=""  D
 . S CNT=0,DATE=""
 . F  S DATE=$O(^TMP($J,"TLIST",DFN,DATE)) Q:(DATE="")!(CNT=NGET)  D
 .. S CNT=CNT+1,^TMP($J,PLIST,DFN,CNT)=U_DATE
 K ^TMP($J,"ARCHFEE"),^TMP($J,"TLIST")
 Q
 ;
 ;==========================================================
ISDUE(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;Multiple occurrence
 ; computed finding for a Project ARCH Reminder Custom Date Due.
 ; The $$GETDELAY^FBARCH0 API returns a site defined numeric value that represents
 ; the number of days to delay the reminder from being due again after 
 ; being declined or refused through one of the related health factors.
 ;
 ; $$GETDELAY^FBARCH0 Supported by IA 5619
 ;
 N X,HFID,ARCHVHF,ARCHDLAY
 S NFOUND=1
 S ARCHDLAY=$$GETDELAY^FBARCH0()
 S ARCHVHF($P($$NOW^PXRMDATE(),"."))=""
 ; Get DECLINES and REFUSES Health Factor ID and last date created
 F X="DECLINES","REFUSES" S HFID=$O(^AUTTHF("B","ARCH-SERVICE NEEDED THIS VISIT "_X,0)) D
 . Q:'$D(^PXRMINDX(9000010.23,"PI",DFN,HFID))
 . ; Get date and add delay value
 . S ARCHVHF($$FMADD^XLFDT($P($O(^PXRMINDX(9000010.23,"PI",DFN,HFID," "),-1),"."),ARCHDLAY))=""
 S TEST(NFOUND)=1
 S TEXT(NFOUND)=""
 S DATE(NFOUND)=$O(ARCHVHF(" "),-1)
 Q
 ;
