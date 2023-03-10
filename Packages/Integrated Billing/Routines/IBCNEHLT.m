IBCNEHLT ;DAOU/ALA - HL7 Process Incoming MFN Messages ; 15 Mar 2016  3:00 PM
 ;;2.0;INTEGRATED BILLING;**184,251,271,300,416,438,506,549,582,601,621,664,668,687,732**;21-MAR-94;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will process incoming MFN messages and
 ;  update the appropriate tables
 ;
EN ;  Entry Point
 ;IB*668/TAZ - Removed STAT and TRUSTED, Added NATIONAL AND AUTOUPDT to NEW Statements
 NEW AIEN,APIEN,APP,AUTOUPDT,D0,D,DESC,DQ,DR,EIV,FILE,FLN,HEDI,ID,IEN
 NEW PEDI,SEG,HCT,NEWID,TSSN,REQSUB,NATIONAL,NAFLG,NPFLG
 NEW IBCNACT,IBCNADT,FSVDY,PSVDY
 NEW CMIEN,DATA,DATAAP,DATABPS,DATACM,DATE,ERROR,FIELDNO,FILENO
 NEW IBSEG,MSG,BUFF
 ;IB*732/CKB&TAZ - Added ISBLUE
 NEW X12TABLE,BADFMT,ISBLUE
 ;
 ; BADFMT is true if a site with patch 300 receives an eIV message in the previous HL7 interface structure (pre-300)
 ;
 ; Build local table of file numbers of DD tables that are updated by FSC for use by the eIV interface
 ;
 ; * Warning: Before adding a new table to be updated by FSC, one must get FSC
 ;            to agree and the eIV ICD documentation has to be updated and 
 ;            approved by the VA HL7 team. Just adding a table number here does
 ;            absolutely nothing without involving the other teams.
 ;
 ;IB*2.0*668/TAZ - Moved the setup of X12TABLE(365.021) to this line.
 F D=11:1:18,21 S X12TABLE("365.0"_D)=""
 ;IB*2.0*668/TAZ - Changed 21 to 22 to match the warning.
 ;F D=22:1:28 S X12TABLE("365.0"_D)=""  ; FSC does not update files #365.022 through #365.028
 ;
 ;S X12TABLE(350.9)=""     ; IB*2.0*506   ; IB*2*664/dw  moved to different array as it is not a X12 file 
 ;S X12TABLE(350.9002)=""  ; IB*2.0*549   ; IB*2*664/dw  moved to different array as it is not a X12 file 
 ;IB*2.0*668/TAZ - removed EIV(365.12) node.  It isn't used.
 ;S EIV(350.9)="",EIV(350.9002)="",EIV(365.12)=""    ; IB*2*664/dw
 S EIV(350.9)="",EIV(350.9002)=""    ; IB*2*668/dw  drop file 365.12 from array, it is handled another way
 ;
 S APP=""
 S HCT=0,ERFLG=0
 ;IB*668/TAZ - Restructured so more readable and can add other lines
 F  S HCT=$O(^TMP($J,"IBCNEHLI",HCT)) Q:HCT=""  D
 . D SPAR^IBCNEHLU
 . I $G(IBSEG(1))="MFI" S FILE=$G(IBSEG(2)),FLN=$P(FILE,$E(HLECH,1),1) Q
 . ;IB*668/TAZ - Added to set APP variable at beginning of routine to be used in the message below
 . I $G(IBSEG(1))="ZPA" S APP=$G(IBSEG(3)) S APP=$S(APP="IIV":"EIV",1:APP) Q
 I FLN=365.12 D
 . S HCT=0,BADFMT=0
 . F  S HCT=$O(^TMP($J,"IBCNEHLI",HCT)) Q:HCT=""  D  Q:(APP="EIV")!BADFMT
 .. D SPAR^IBCNEHLU
 .. I $G(IBSEG(1))="MFE",$P($G(IBSEG(5)),$E(HLECH,1),3)'="" D  Q
 ... S BADFMT=1,APP=""
 ... ;IB*668/TAZ - Changed Remedy to Service in the message.
 ... S MSG(1)="Log a Service Ticket for this issue."
 ... S MSG(2)="Please include in the Service Ticket that the Vista eIV payer tables may be out"
 ... S MSG(3)="of sync with the master list and will need a new copy of the payer table"
 ... S MSG(4)="update message from Austin."
 ... D MSG^IBCNEUT5($$MGRP^IBCNEUT5(),"eIV payer tables may be out of synch with master list","MSG(")
 .. ;I $G(IBSEG(1))="ZPA" S APP="IIV" ; IB*2*664/dw  No longer needed, added 365.12 to the EIV array
 ;I $D(X12TABLE(FLN))!$D(EIV(FLN)) S APP="IIV"    ; IB*2*664/dw
 ;IB*668/TAZ - Quit if not an X12 Table update, and not an EIV update, and not a PAYER Table update
 I '$D(X12TABLE(FLN)),'$D(EIV(FLN)),(FLN'=365.12) Q
 ;
 S HCT=1,NAFLG=0,NPFLG=0,D=""
 F  S HCT=$O(^TMP($J,"IBCNEHLI",HCT)) Q:HCT=""  D  Q:ERFLG
 . D SPAR^IBCNEHLU
 . S SEG=$G(IBSEG(1))
 . ;
 . ;IB*668/TAZ - Removed check on if APP=IIV, not needed. This moved everything up a level in the dot structure
 . I SEG="MFI" D
 .. S FILE=$G(IBSEG(2))
 .. S FLN=$P(FILE,$E(HLECH,1),1)
 . ;
 . I SEG="MFE" D
 .. I $G(FLN)="" S ERFLG=1,MSG(1)="File Number not found in MFN message" Q
 .. I '$$VFILE^DILFD(FLN) S ERFLG=1,MSG(1)="File "_FLN_" not found in the Data Dictionary" Q
 .. ;
 .. I FLN'=365.12 D  Q
 ... S DATA=$G(IBSEG(5))
 ... S ID=$$DECHL7^IBCNEHL2($P(DATA,$E(HLECH,1),1)),DESC=$$DECHL7^IBCNEHL2($P(DATA,$E(HLECH,1),2))
 ... D TFIL
 .. ;
 .. ; Pull the action code
 .. S IBCNACT=$G(IBSEG(2))
 .. ; Effective Date
 .. S IBCNADT=$G(IBSEG(4))
 . ;
 . I SEG="ZP0" D
 .. S ID=$$DECHL7^IBCNEHL2(IBSEG(3)),NEWID=$$DECHL7^IBCNEHL2(IBSEG(4))
 .. S DESC=$$DECHL7^IBCNEHL2(IBSEG(5)),HEDI=$$DECHL7^IBCNEHL2(IBSEG(6)),PEDI=$$DECHL7^IBCNEHL2(IBSEG(7))
 .. S ISBLUE=$S($G(IBSEG(8))="Y":1,1:0)  ;IB*732/CKB&TAZ
 . ;
 . I SEG="ZPA" D
 .. ;IB*668/TAZ - Added APP logic
 .. S APP=$G(IBSEG(3)) S APP=$S(APP="IIV":"EIV",1:APP)
 .. S NATIONAL=$S(IBSEG(4)="Y":1,1:0)
 .. ;IB*668/TAZ - Only set some variables if App is EIV
 .. I APP="EIV" D
 ... S REQSUB=$S(IBSEG(7)="N":0,1:1)
 ... S FSVDY=IBSEG(8),PSVDY=IBSEG(9)
 ... S AUTOUPDT=$S(IBSEG(10)="N":0,1:1)
 .. D PFIL
 Q
 ;
PFIL ;  Payer Table Filer (Updates file #365.12)
 ;  Set the action:
 ;     MAD=Add, MUP=Update, MDC=Deactivate, MAC=Reactivate
 ;IB*668/TAZ - Added OLDNE and OLDAU to New Statement
 N FDA,IENS,OLDNE,OLDAU
 S IBCNADT=$$FMDATE^HLFNC(IBCNADT)
 I IBCNADT="" S IBCNADT=$$NOW^XLFDT()
 ;  If the action is MAD - Add the payer as new
 ;  IB*582/TAZ if the action is MUP and the entry doesn't exist, add the payer as new
 N IBNOK,IBAPP,IBID,IBDESC,IBSTR,IBCNTYPE
 S IBNOK=0,IBAPP=($TR(APP," ")=""),IBID=($TR(ID," ")=""),IBDESC=($TR(DESC," ")=""),IBNOK=IBAPP!IBID!IBDESC
 ;IB*668/TAZ - Check for valid Payer Application and send message if not valid.
 S DIC="^IBE(365.13,",DIC(0)="X",X=APP D ^DIC S AIEN=+Y I AIEN<1 S IBNOK=1  ;Bad PAYER APPLICATION
 ;IB*668/TAZ - Changed Remedy Ticket to Service Ticket in this message.
 I IBNOK D  G PFILX
 . S IBCNTYPE=$S(IBCNACT="MAD":"Add",IBCNACT="MUP":"Update",IBCNACT="MDC":"Deactivate",IBCNACT="MAC":"Reactivate",1:"Unknown")
 . S MSG(1)=IBCNTYPE_" ("_IBCNACT_") action received. Payer and/or Application may be unknown."
 . S MSG(2)=""
 . S MSG(3)="VA National : "_ID
 . S MSG(4)="Payer Name : "_DESC
 . S MSG(5)="Application : "_APP
 . S MSG(6)=""
 . S MSG(7)="Log a Service Ticket for this issue."
 . S MSG(8)=""
 . S MSG(9)="Please include in the Service Ticket that VISTA did not receive the required"
 . S MSG(10)="information or the accurate information to add/update this Payer."
 . D MSG^IBCNEUT5($$MGRP^IBCNEUT5(),"eIV payer tables may be out of synch with master list","MSG(")
 D FND I IEN<0 D MAD(DESC)
 ;
 S DESC=$E(DESC,1,80)    ;restriction of the field in the DD
 S DIC=$$ROOT^DILFD(FLN)
 ;IB*732/CKB&TAZ - Add field .09 to DR string
 S DR=".01///^S X=DESC;.02////^S X=NEWID;.05////^S X=PEDI;.06////^S X=HEDI;.09////^S X=ISBLUE"
 ;
 ;IB*668/TAZ - Moved MDC/MAC logic to new file location
 ;I MDC or MAC
 I IBCNACT="MDC" S DR=DR_";.07///^S X=1;.08////^S X=IBCNADT;",NATIONAL=0
 I IBCNACT="MAC" S DR=DR_";.07///^S X=0;.08///@;"
 ;
 ;  If new payer, add the Date/Time created
 I NPFLG S DR=DR_";.04///^S X=$$NOW^XLFDT()"
 S DIE=DIC,DA=IEN D ^DIE
 ;
 ;IB*687/TAZ - Note:  This adds the application to the Payer
 S APIEN=$O(^IBE(365.12,IEN,1,"B",AIEN,""))
 I APIEN="" D
 . S DLAYGO=365.121,DIC(0)="L",DIC("P")=DLAYGO,DA(1)=IEN,X=AIEN
 . S DIC="^IBE(365.12,"_DA(1)_",1,",DIE=DIC
 . K DD,DO
 . D FILE^DICN
 . K DO
 . S APIEN=+Y,NAFLG=1
 ;
 ;IB*668/TAZ - Updated field names and restructured filing logic for Payer File Application Level
 S IENS=APIEN_","_IEN_","
 ; get current values for NATIONALLY ENABLED and AUTO-UPDATE flags
 S OLDNE=$$GET1^DIQ(365.121,IENS,.02,"I")
 S OLDAU=$$GET1^DIQ(365.121,IENS,4.01,"I")  ;Only applied to EIV Payer Application
 ;
 S FDA(365.121,IENS,.02)=NATIONAL
 S FDA(365.121,IENS,.06)=$$NOW^XLFDT()
 I IBCNACT'="MDC",(APP="EIV") D
 . S FDA(365.121,IENS,4.01)=AUTOUPDT
 . S FDA(365.121,IENS,4.02)=REQSUB
 . S FDA(365.121,IENS,4.03)=FSVDY
 . S FDA(365.121,IENS,4.04)=PSVDY
 I NAFLG D
 . S FDA(365.121,IENS,.13)=$$NOW^XLFDT()
 . ;IB*687/TAZ - Set Locally Enabled to YES for IIU
 . I APP="IIU" S FDA(365.121,IENS,.03)=1
 D FILE^DIE("","FDA")
 ;
 S IBACK="AA"
 ; Update flag logs
 ;IB*668/TAZ - Updated flags and variable names
 I NATIONAL'=OLDNE D UPDLOG("NE",NATIONAL,IEN,APIEN)
 I (APP="EIV"),(AUTOUPDT'=OLDAU) D UPDLOG("AU",AUTOUPDT,IEN,APIEN)
 I IBCNACT="MDC" D MDC Q
PFILX ;
 Q
 ;
TFIL ;  eIV Site Parameter table filer & X12 Code List table filer
 ;     (Updates X12 Code lists - Refer to the X12TABLE array at the top of this routine for file #s)
 ;IB*668/TAZ - Removed reference to IIV
 ;     (Updates file #350.9 & some of its subfiles associated with eIV)
 ; Input: DESC  - Field Number
 ;        ID    - Field Value
 ;        FLN   - File Number
 ;
 ; IB*2*668/DW - In this tag, removed check on if APP=IIV as it is not needed
 N DA,DIC,DIE,DLAYGO,DR,EXTRACT,IEN,MAX,XX,X,Y   ;IB*2.0*549 - Added DA,DIE,DR,EXTRACT,XX
 ;
 ; store the FILENAME, FIELDNAME and VALUE if the APP is IIV and FLN is 350.9.  - IB*2.0*506
 ; For file #350.9, DESC represents the FIELD NUMBER and ID represents the VALUE.
 ;IB*668/TAZ - Removed reference to IIV
 ;I APP="IIV",FLN=350.9 D  Q
 I FLN=350.9 D  Q
 . S DIE=FLN,DA=1,DR=DESC_"///"_ID
 . D ^DIE
 . S IBACK="AA"
 ;
 ; IB*2.0*549 Added if statement 
 ;IB*668/TAZ - Removed reference to IIV
 ;I APP="IIV",FLN=350.9002 D  Q
 I FLN=350.9002 D  Q
 . S EXTRACT=$E(DESC,1,4)                   ; Either "Buff", "Appt" or "EICD"
 . S XX=$S(EXTRACT="Buff":1,EXTRACT="Appt":2,EXTRACT="EICD":4,1:3) ; IB*2.0*621/DM add EICD 
 . S DESC=$E(DESC,5,99)                     ; Field number
 . S DA(1)=1
 . S DA=$O(^IBE(350.9,1,51.17,"B",XX,""))   ; Find correct multiple
 . ;
 . ; File the new value
 . S DIE="^IBE(350.9,1,51.17,"
 . S DR=DESC_"///"_ID
 . D ^DIE
 . S IBACK="AA"
 ;
 ;IB*582/TAZ - Add new entries and update existing entries
 ;
 S DIC(0)="X",X=ID,DIC=$$ROOT^DILFD(FLN)
 D ^DIC S IEN=+Y
 ; don't update existing entries
 ;I IEN>0 Q
 ;Add new entry to table
 I IEN<1 D
 . S DLAYGO=FLN,DIC(0)="L"
 . K DD,DO D FILE^DICN K DO
 ;
 ;Update Description
 ;
 D FIELD^DID(FLN,.02,,"FIELD LENGTH","MAX")
 I MAX("FIELD LENGTH")>0 S DESC=$E(DESC,1,MAX("FIELD LENGTH")) ; restriction of the field in the DD
 ; add new entry to the table
 ;S DLAYGO=FLN,DIC(0)="L",DIC("DR")=".02///"_DESC
 ;S DLAYGO=FLN,DIC(0)="L",DIC("DR")=".02///^S X=DESC"
 ;K DD,DO D FILE^DICN K DO
 ;IB*2*601/HN corrected use of the DR variable 
 ;S DIE=DIC,DA=IEN,DIC("DR")=".02///^S X=DESC" D ^DIE
 S DIE=DIC,DA=IEN,DR=".02///^S X=DESC" D ^DIE
 S IBACK="AA"
 Q
 ;
MAD(X) ;  Add an entry
 ;IB*582/TAZ - Moved check to PFIL MAD is called for any record that is not found in the file.
 ;IB*687/TAZ - Note:  This adds the Payer to the file but does not add the Application
 ;D FND
 ;I IEN>0 G MADX
 NEW DIC,DIE,DA,DLAYGO,Y,DR
 S DIC=$$ROOT^DILFD(FLN)
 S DLAYGO=FLN,DIC(0)="L",DIC("P")=DLAYGO,DIE=DIC
 K DD,DO
 D FILE^DICN
 K DO
 S IEN=+Y,NPFLG=1
MADX ;
 Q
 ;
FND ;  Find an existing Payer entry
 NEW DIC,DIE,X,DA,DLAYGO,Y,DR
 S X=ID,DIC(0)="X",D="C",DIC=$$ROOT^DILFD(FLN)
 ;
 ;  Do a lookup with the "C" cross-reference
 D IX^DIC
 S IEN=+Y
 Q
 ;
MDC ;  Check for active transmissions and cancel
 NEW STA,HIEN,RIEN,TQIEN
 F STA=1,2,4,6 S TQIEN="" D
 . F  S TQIEN=$O(^IBCN(365.1,"AC",STA,TQIEN)) Q:TQIEN=""  D
 .. ;
 .. ;  If the record doesn't match the payer, quit
 .. I $P(^IBCN(365.1,TQIEN,0),U,3)'=IEN Q
 .. ;
 .. ;  Set the status to 'Cancelled'
 .. D SST^IBCNEUT2(TQIEN,7)
 .. ;
 .. ;  If a buffer entry, set to ! (bang)
 .. S BUFF=$P(^IBCN(365.1,TQIEN,0),U,5)
 .. I BUFF'="" D BUFF^IBCNEUT2(BUFF,17)
 .. ;
 .. ;  Change any responses status also
 .. S HIEN=0 F  S HIEN=$O(^IBCN(365.1,TQIEN,2,HIEN)) Q:'HIEN  D
 ... S RIEN=$P(^IBCN(365.1,TQIEN,2,HIEN,0),U,3)
 ... ;  If the Response status is 'Response Received', don't change it
 ... I $P(^IBCN(365,RIEN,0),U,6)=3 Q
 ... D RSP^IBCNEUT2(RIEN,7)
 Q
 ;
UPDLOG(FLAG,VALUE,PIEN,APIEN) ; Update NATIONALLY ENABLED/AUTO-UPDATE flag logs
 ;IB*668/TAZ - Updated to new flag variables
 ; FLAG - "NE" for NATIONALLY ENABLED flag, "AU" for AUTO-UPDATE flag
 ; VALUE - new flag value (0 or 1)
 ; PIEN - ien in PAYER file (365.12)
 ; APIEN - ien in APPLICATION sub-file (365.121)
 ;
 N FILE,IENSTR,UPDT
 I $G(FLAG)=""!($G(VALUE)="") Q
 I +$G(PIEN)=0!(+$G(APIEN)=0) Q
 S FILE=$S(FLAG="NE":"365.1212",FLAG="AU":"365.1213",1:"") I FILE="" Q
 S IENSTR="+1,"_APIEN_","_PIEN_","
 S UPDT(FILE,IENSTR,.01)=$$NOW^XLFDT()
 S UPDT(FILE,IENSTR,.02)=VALUE
 D UPDATE^DIE("E","UPDT")
 Q
