IBCNEBF ;DAOU/ALA - Create an Entry in the Buffer File ;20-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,361,371,416,438,497,621,743**;21-MAR-94;Build 18
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ;**Program Description**
 ;  This program will create a Buffer entry based upon input values
 ;
 Q
 ;
PT(DFN,IRIEN,SYMBOL,OVRRIDE,ADD,IBERROR) ;  Get data
 ;   from a specific patient and insurance record entry
 ;
 ;  Input Parameters
 ;    DFN = Patient IEN
 ;    IRIEN = Patient Insurance Record IEN
 ;    SYMBOL = eIV Symbol IEN
 ;    OVRRIDE = Override flag for ins. buffer record  (0 or 1)
 ;    ADD = If defined, then it will add a new Buffer entry
 ;    IBERROR = If defined, then it will be updated with error info.
 ;              OPTIONALLY PASSED BY REFERENCE
 ;
 I DFN=""!(IRIEN="") Q   ; * do not require SYMBOL or OVRRIDE
 ;
 ;
 N VBUF,IDATA0,IDATA3,IDATA7,IEN,INAME,PNAME,IIEN,GNUMB,GNAME,SUBID,PPHONE,PATID
 N BPHONE,EFFDT,EXPDT,WHO,REL,IDOB,ISSN,COB,TQIEN,RDATA,ISEX,NAME
 N MSG,XMSUB,MSGP,INSDATA,PCE,BFD,BFN,INSPCE,ESGHPARR
 N SUBADDR1,SUBADDR2,SUBCITY,SUBSTATE,SUBZIP,SUBCNTRY,SUBCNDIV
 ;
 S IDATA0=$G(^DPT(DFN,.312,IRIEN,0)),IDATA3=$G(^DPT(DFN,.312,IRIEN,3))
 S IDATA7=$G(^DPT(DFN,.312,IRIEN,7))
 S IIEN=$P(IDATA0,U,1),INAME=$$GET1^DIQ(36,IIEN,.01,"E")
 S PPHONE=$P($G(^DIC(36,IIEN,.13)),U,3),BPHONE=$P($G(^DIC(36,IIEN,.13)),U,2)
 S NAME=$P(IDATA7,U,1),SUBID=$P(IDATA7,U,2)
 S PATID=$P($G(^DPT(DFN,.312,IRIEN,5)),U,1)
 S WHO=$P(IDATA0,U,6),COB=$P(IDATA0,U,20)
 S IDOB=$P(IDATA3,U,1),ISSN=$P(IDATA3,U,5),ISEX=$P(IDATA3,U,12)
 S EFFDT=$P(IDATA0,U,8),EXPDT=$P(IDATA0,U,4)
 S REL=$P($G(^DPT(DFN,.312,IRIEN,4)),U,3)
 S SUBADDR1=$P(IDATA3,U,6),SUBADDR2=$P(IDATA3,U,7)
 S SUBCITY=$P(IDATA3,U,8),SUBSTATE=$P(IDATA3,U,9),SUBZIP=$P(IDATA3,U,10)
 S SUBCNTRY=$P(IDATA3,U,13),SUBCNDIV=$P(IDATA3,U,14)
 ;
 S IENS=IRIEN_","_DFN_","
 S GNUMB=$$GET1^DIQ(2.312,IENS,21,"E")
 S GNAME=$$GET1^DIQ(2.312,IENS,20,"E")
 ;
 ; Capture the employer sponsored insurance fields into array
 ;   ESGHPARR(buffer field number) = data
 ;
 S INSDATA=$G(^DPT(DFN,.312,IRIEN,2)),PCE=0
 F BFD=5:1:12,2,1,3,4 S PCE=PCE+1,BFN=BFD/100+61,INSPCE=$P(INSDATA,U,PCE) I INSPCE'="" S ESGHPARR(BFN)=INSPCE
 ;
 D FIL
 K ADD
 Q
 ;
RP(IEN,ADD,BUFF) ;  Get data from a specific response record
 ;
 ;  Input Parameter
 ;    IEN  = Internal entry number of the Response
 ;    ADD  = If defined, then it will add a new Buffer entry
 ;    BUFF = IEN of the Buffer Entry to be updated (optional)
 ;
 S BUFF=$G(BUFF) ; Initialize optional parameter
 ;
 N BPHONE,COB,DFN,EFFDT,EXPDT,GNAME,GNUMB,IBSOURCE,IDOB,IIEN,INAME,IRIEN,ISEX,ISSN,NAME
 N PATID,PIEN,PNAME,PPHONE,RDATA,RDATA5,RDATA13,RDATA14,REL,RSTYPE,SUBID,TQIEN,WHO
 N SUBADDR1,SUBADDR2,SUBCITY,SUBSTATE,SUBZIP,SUBCNTRY,SUBCNDIV
 ;
 S DFN=$P(^IBCN(365,IEN,0),U,2),TQIEN=$P(^IBCN(365,IEN,0),U,5)
 S PIEN=$P(^IBCN(365,IEN,0),U,3),RSTYPE=$P(^(0),U,10)
 I PIEN'="" S PNAME=$P(^IBE(365.12,PIEN,0),U,1)
 I TQIEN'="" S IRIEN=$P($G(^IBCN(365.1,TQIEN,0)),U,13),IBSOURCE=$$GET1^DIQ(365.1,TQIEN_",",3.02,"I") ; IB*2.0*621 IBSOURCE
 I $G(IRIEN)'="" S INAME="" D
 . S IIEN=$P($G(^DPT(DFN,.312,IRIEN,0)),U,1)
 . I IIEN="" Q
 . S INAME=$P(^DIC(36,IIEN,0),U,1)
 S RDATA=$G(^IBCN(365,IEN,1)),RDATA5=$G(^IBCN(365,IEN,5))
 S RDATA13=$G(^IBCN(365,IEN,13)),RDATA14=$G(^IBCN(365,IEN,14))
 S NAME=$P(RDATA13,U,1)
 S INAME=$S($G(INAME)'=""&(RSTYPE="O"):INAME,1:$G(PNAME))
 S IDOB=$P(RDATA,U,2)
 S ISSN=$P(RDATA,U,3)
 S ISEX=$P(RDATA,U,4)
 S COB=$P(RDATA,U,13)
 S SUBID=$P(RDATA13,U,2)
 S PATID=$P(RDATA,U,18)
 S GNAME=$P(RDATA14,U,1)
 S GNUMB=$P(RDATA14,U,2)
 S WHO=$P(RDATA,U,8)
 S REL=$$PREL^IBCNEHLU(355.33,60.14,$$GET1^DIQ(365,IEN,8.01))  ; IB*2*497  VALUE FROM 365,8.01 needs evaluation and possible conversion 
 S EFFDT=$P(RDATA,U,11)
 S EXPDT=$P(RDATA,U,12)
 S SUBADDR1=$P(RDATA5,U),SUBADDR2=$P(RDATA5,U,2),SUBCITY=$P(RDATA5,U,3)
 S SUBSTATE=$P(RDATA5,U,4),SUBZIP=$P(RDATA5,U,5),SUBCNTRY=$P(RDATA5,U,6)
 S SUBCNDIV=$P(RDATA5,U,7)
 S PPHONE="",BPHONE=""
 ;
 D FIL
 K DFN,VBUF,IEN,IRIEN,INAME,PNAME,IIEN,GNUMB,GNAME,SUBID,PPHONE,PATID
 K BPHONE,EFFDT,EXPDT,WHO,REL,IDOB,ISSN,COB,TQIEN,RDATA,ISEX,NAME
 K ADD,%DT,D0,DG,DIC,DISYS,DIW,IENS,IBEISTC
 Q
 ;
FIL ;  File Buffer Data
 ;
 S MSGP=$$MGRP^IBCNEUT5()
 ;
 ; Variable IDUZ is optionally set by the calling routine.  If it is
 ; not defined, it will be set to the specific, non-human user.
 ;
 I $G(IDUZ)="" S IDUZ=$$FIND1^DIC(200,"","X","INTERFACE,IB EIV")
 ;
 I $G(ADD) S VBUF(.02)=IDUZ  ; Entered By
 S VBUF(.12)=$G(SYMBOL)   ; Buffer Symbol
 S VBUF(.13)=$G(OVRRIDE) ; Override freshness flag
 S VBUF(.18)=$G(IBELIGDT) ; eligibility date, only comes from ^IBCNEQU (real time eIV inquiry)
 I '$G(ERACT) D  ; Only file if not an error
 . S VBUF(20.01)=INAME  ; Insurance Company/Payer Name
 . S VBUF(60.01)=DFN  ; Patient IEN
 . S VBUF(90.02)=GNUMB  ; Group Number
 . S VBUF(90.01)=GNAME  ; Group Name
 . S VBUF(91.01)=NAME  ; Name of Insured
 . S VBUF(90.03)=SUBID  ; Subscriber ID
 . S VBUF(62.01)=PATID  ; Patient/Member ID
 . S VBUF(20.04)=PPHONE  ; Precertification Phone
 . S VBUF(20.03)=BPHONE  ; Billing Phone
 . S VBUF(60.02)=EFFDT  ; Effective Date
 . S VBUF(60.03)=EXPDT  ; Expiration Date
 . S VBUF(60.05)=WHO  ; Whose Insurance
 . S VBUF(60.14)=REL  ;  Patient Relationship
 . S VBUF(60.08)=IDOB  ;  Insured's DOB
 . S VBUF(60.09)=ISSN  ;  Insured's SSN
 . S VBUF(60.12)=COB  ;  Coordination of Benefits
 . S VBUF(60.13)=ISEX  ;  Insured's Sex
 . S VBUF(62.02)=SUBADDR1 ; Subscriber address line 1
 . S VBUF(62.03)=SUBADDR2 ; Subscriber address line 2
 . S VBUF(62.04)=SUBCITY ; Subscriber address city
 . S VBUF(62.05)=SUBSTATE ; Subscriber address state
 . S VBUF(62.06)=SUBZIP ; Subscriber address zip code
 . S VBUF(62.07)=SUBCNTRY ; Subscriber address country code
 . S VBUF(62.08)=SUBCNDIV ; Subscriber address country subdivision code
 . ;
 . ; Define Service Type Code (STC) to be sent with Insurance Inquiry
 . ; IBEISTC contains the STC defined by User using option EI, otherwise default is sent
 . I +$G(IBEISTC) S VBUF(80.01)=IBEISTC
 . K IBEISTC
 . ;
 . ; If the employer sponsored insurance array exists, then merge it in
 . I $D(ESGHPARR) M VBUF=ESGHPARR
 ;
 ; Do not overwrite the existing insurance co. name if it already exists
 I $G(ADD)="",$G(BUFF)'="" K VBUF(20.01)
 ;
 ; ** initialize IBERROR
 S IBERROR=""
 ;
 ;  If need to add a new Buffer entry ...
 ;
 ;  Variable IBFDA is returned to the calling routine as the IEN of
 ;  the buffer entry that was just added.
 ;
 I $G(ADD) D
 . S IBSOURCE=$G(IBSOURCE,5) ; IB*2.0*621 Added IBSOURCE to replace hard coded eIV
 . ;IB*743/CKB - calling $$ADDSTF below in order to Lock/Unlock buffer entry
 . S IBFDA=$$ADDSTF(IBSOURCE,DFN,.VBUF)
 . ; Error Message is 2nd piece of result
 . S IBERROR=$P(IBFDA,U,2)
 . S IBFDA=$P(IBFDA,U,1)
 ;
 ;  If an error, send an email message
 I IBERROR'="" D  Q
 . S MSG(1)="Error returned by $$ADDSTF^IBCNBES:"
 . S MSG(2)=IBERROR
 . S MSG(3)="Values:"
 . S MSG(4)=" Patient DFN = "_$G(DFN)
 . S MSG(5)=" Pt Ins Record IEN = "_$G(IRIEN)
 . S MSG(6)="Please log a Remedy Ticket for this problem."
 . S XMSUB="Error creating Buffer Entry."
 . D MSG^IBCNEUT5(MSGP,XMSUB,"MSG(")
 . K MSGP,MSG,XMSUB,IBERR
 ;
 ;  If need to update a new Buffer Entry ...
 ;
 ;  Variable BUFF is passed into this routine whenever the buffer
 ;  entry is known and the ADD flag is off.  The existing buffer entry
 ;  is edited in this case.
 ;
 I $G(ADD)="" D EDITSTF^IBCNBES(BUFF,.VBUF)
 ;
 ;  If an error occurred in EDITSTF, the error array is not returned
 ;
 Q
 ;
 ;IB*743/CKB - the code below was copied from ADDSTF^IBCNBES to address the locking of the
 ; buffer without impacting other existing software
ADDSTF(IBSOURCE,DFN,IBDATA) ;  add new entry to Insurance Buffer file (355.33) and stuff the data passed in, no user interaction
 ;  IBSOURCE = source of information             (required)
 ;             1 = interview           2 = data match
 ;             3 = ivm                 4 = pre-registration
 ;             5 = eIV etc., refer to file #365.12 for full list of sources
 ;  DFN      = patient's ifn in file 2           (required)
 ;  IBDATA   = data to file in Buffer in an array subscripted by field number of the data field in 355.33
 ;             ex:  IBDATA(20.01)="Insurance Company Name", etc,
 ;  returns ien of new entry or 0 followed by error if entry not added
 ;
 ;  example of call: $$ADDBUF^IBCNBES(2,DFN,.IBDATA)   where IBDATA(field #) = value
 ;
 N X,Y,BUFLOCK,IBBUFDA,IBERROR
 ;
 ;  verify source of information and data exists to store
 I $G(IBSOURCE)="" S IBERROR="SOURCE OF INFORMATION INCORRECT" G EXIT
 I $G(^DPT(+$G(DFN),0))="" S IBERROR="NO PATIENT DEFINED" G EXIT
 I $D(IBDATA)<10 S IBERROR="NO DATA TO STORE" G EXIT
 ;
 ;  add new entry to Buffer file (355.33)
 S IBBUFDA=+$$ADD^IBCNBEE(IBSOURCE) I 'IBBUFDA S IBERROR="COULD NOT CREATE A NEW BUFFER ENTRY" G EXIT
 ;
 ; Lock the buffer entry
 S BUFLOCK=$$BUFLOCK^IBCNEHL6(IBBUFDA,1)
 ;
 S IBDATA(60.01)=+DFN
 ;
 ; Set up DUZ (interface user) so 60.01 field check can find 'valid reason' for sensitive
 ; patients and not set 60.01 to '0' with an error in tag FLDCHK
 I '$G(DUZ) D DUZ^XUP(.5)
 ;
 D EDITSTF^IBCNBES(+IBBUFDA,.IBDATA)
 ;
 ; Unlock buffer entry
 I BUFLOCK,$$BUFLOCK^IBCNEHL6(IBBUFDA,0)
 ;
 ; delete leftover ESGHP data if ESGHP? is not Yes
 I +$G(IBBUFDA),$D(^IBA(355.33,$G(IBBUFDA),61)),'$G(^IBA(355.33,$G(IBBUFDA),61)) D DELEMP^IBCNBEE($G(IBBUFDA))
 ;
EXIT Q +$G(IBBUFDA)_"^"_$G(IBERROR)
