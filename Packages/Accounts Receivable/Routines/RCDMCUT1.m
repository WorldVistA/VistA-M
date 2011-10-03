RCDMCUT1 ;HEC/SBW - Utility Functions for Hold Debt to DMC Project ;30/AUG/2007
 ;;4.5;Accounts Receivable;**253**;Mar 20, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
HOLDCHK(IEN,DFN) ;Check if receivable shouldn't be sent to DMC
 ;Dont refer receivables for veterans who are (return 1)
 ;  1. "DMC Debt Valid" field = NULL and
 ;     SC 50% to 100% or in receipt of VA Pension and "DMC Debt Valid"
 ;     For this case only update DMC Debt Valid Field to Pending 
 ;  2. "DMC Debt Valid" is Pending or NO
 ;Refer receivables for veterans who are (return 0)
 ;  1. "DMC Debt Valid" is "YES"
 ;  2. "DMC Debt Valid" is NULL and 
 ;     not SC 50% to 100% and not in receipt of a VA Pensions
 ;
 ;INPUT
 ;  IEN  - Internal Entry Number for Accounts Recievable File
 ;  DFN  - Internal Entry Number to Patient (#2) file
 ;OUTPUT
 ;   1 - Don't sent the Debt to DMC
 ;   0 - Debt can be sent to DMC
 ;
 N OUT,DMCVALID,DMCELIG
 S OUT=0
 ;Quit if invalid IEN or DFN passed
 Q:$G(IEN)'>0!($G(DFN)'>0) OUT
 ;Get DMC Debt Valid field
 S DMCVALID=$$GET1^DIQ(430,+$G(IEN)_",",125,"E")
 ;If DMC Debt Valid is No or Pending don't refer to DMC
 S:DMCVALID="NO"!(DMCVALID="PENDING") OUT=1
 ;If DMC Debt Valid is Yes refer to DMC
 S:DMCVALID="YES" OUT=0
 ;Check if Vet is SC 50% to 100% or in Receipt of VA Pension
 S DMCELIG=+$$DMCELIG^RCDMCUT1(+$G(DFN))
 ;If DMC Debt Valid is Null & SC 50% to 100% or Receiving VA Pension
 ;refer to DMC
 D:DMCVALID=""&(DMCELIG>0)
 . S OUT=1
 . ;Update DMC Valid Indicator to Pending
 . D UPDTDMC^RCDMCUT1(IEN,"P",1)
 ;If DMC Debt Valid is Null & NOT SC 50%to100% & NOT Receiving VA Pension
 ;don't refer to DMC
 S:DMCVALID=""&(DMCELIG'>0) OUT=0
 Q OUT
 ;
DMCELIG(DFN) ;Checks Bill Debtor SC% and Receipt of VA Pension Values
 ;INPUT:
 ;   DFN  - Pointer Value to Patient (#2) file
 ;OUTPUT:
 ;   Returns 0 if not SC 50% to 100% and not receiving a VA Pension
 ;   Returns "1^ SC % ^ VA Pension ^ A&A Benefits ^ Housbound Benefits"
 ;     if SC 50% to 100% or Receiving a VA Pension. 
 ;     Should also consider Vets who are receiving A&A or
 ;     Housebound benefits as Receiving VA a VA Pension.
 ;       The 2nd piece will be the SC % if SC 50% to 100%.
 ;       The 3rd piece will be a 1 if Receiving a VA Pension.
 ;     If not SC 50% to 100% or Receiving a VA Pension then
 ;       The 4th piece will be the A&A Benefits.
 ;       The 5th piece will be the Housebound Benefits.
 ;
 N OUT
 ;Protect the VADPT variables to prevent errors with ^RCDMC90 routine
 N VAHOW,VAROOT,VAERR,VAEL,VAMB,VADM,VASV,VAPA,VATEST,VAOA,VAINDT,VAIN
 N VAIP,VAPD,VARP,VASD,VA,VADMVT
 S OUT=0
 ;Quit if no DFN passed
 Q:$G(DFN)'>0 OUT
 ;Get Eligibility Data
 D ELIG^VADPT
 ;Quit if ^DPT(DFN,0) not defined
 Q:$G(VAERR)>0 OUT
 ;Get monetary benefit data
 D MB^VADPT
 ;SERVICE CONNECTED?  Field- If SC the SC% returned in the 2nd piece.
 S:$P($G(VAEL(3)),U,2)>49 $P(OUT,U,1)=1,$P(OUT,U,2)=$P(VAEL(3),U,2)
 ;RECEIVING A VA PENSION? 
 S:$P($G(VAMB(4)),U,1)>0 $P(OUT,U,1)=1,$P(OUT,U,3)=$P(VAMB(4),U,1)
 D:+OUT'>0
 . ;RECEIVING A&A BENEFITS? 
 . S:$P($G(VAMB(1)),U,1)>0 $P(OUT,U,1)=1,$P(OUT,U,4)=$P(VAMB(1),U,1)
 . ;RECEIVING HOUSEBOUND BENEFITS?
 . S:$P($G(VAMB(2)),U,1)>0 $P(OUT,U,1)=1,$P(OUT,U,5)=$P(VAMB(2),U,1)
 D KVAR^VADPT
 Q OUT
 ;
UPDTDMC(IEN,VAL,DELBY) ;Update the DMC Debt Valid Field
 ;INPUT
 ;  IEN    - Internal Entry Number of Accounts Receivable (#430) file
 ;  VAL   - DMC Debt Valid Value ("P", "Y", "N" or "@"), 
 ;          If "@" pass the field will be deleted
 ;  DELBY - Used to delete the "DMC Debt Valid Edited By" field when
 ;          updated by the Nightly Background Job
 ;Output
 ;  No output
 ;
 N DA,DIE,DR,X,Y
 Q:$G(IEN)'>0
 Q:"^Y^N^P^@^"'[(U_$G(VAL)_U)
 L +^PRCA(430,IEN,12.1):30
 ;Quit if another user is editing this entry
 I '$T Q
 S DA=IEN
 S DIE=430
 S DR="125////"_VAL
 S:$G(DELBY)>0 DR=DR_";126///@"
 D ^DIE
 L -^PRCA(430,IEN,12.1)
 Q
 ;
GETDEM(DFN) ; Get data from Patient (#2) file
 ;INPUT:
 ;   DFN  - Pointer Value to Patient (#2) file
 ;OUTPUT:
 ;   DEM^VADPT VADM array as spelled out in PIMS Technical Manual
 ;
 ;Calling routines needs to New or Kill following Variables by calling
 ;  D KVAR^VADPT
 ; VADM,VAERR,VA
 ;
 N OUT,Y
 S OUT=0
 ;Quit if no DFN passed
 Q:$G(DFN)'>0 OUT
 ;Get Demographic Data
 D DEM^VADPT
 ;Quit if ^DPT(DFN,0) not defined
 Q:$G(VAERR)>0 OUT
 ;Calls Successful
 S OUT=1
 Q OUT
 ;
FIRSTPAR(IEN430) ;Check if this is a First Party bill
 ;INPUT
 ;  IEN430 - Internal Entry Number for Accounts Receivable File
 ;OUTPUT
 ;  Returns a 0 if not First Party Bill
 ;  Returns a 1 if First Party Bill
 ;
 N FLD,FIRST,IEN340
 ;Set default to zero
 S FIRST=0
 S IEN430=+$G(IEN430)
 ;Get DEBTOR Field Value in Account Receivable File
 S IEN340=+$P($G(^PRCA(430,IEN430,0)),U,9)
 ;If .01 field in AR Debtor File points to the Patient file 
 ;then this is a First Party Debt
 S FLD=$P($G(^RCD(340,IEN340,0)),U,1)
 S:FLD["DPT" FIRST=1_U_$P(FLD,";",1)
 Q FIRST
 ;
GETSERDT(BILLNUM) ; Get most recent Outpatient Date, Inpatient Date and RX Date
 ; from the IB Action (#350) file for the corresponding bill
 ;INPUT
 ;   BILLNUM - Bill No. (.01) field in AR (#430) file
 ;OUTPUT
 ;   0 - No data
 ;   1 ^ Outpatient Date ^ Discharge Date ^ RX/Refill Date
 N OUT,IEN
 S OUT=0,IEN=0
 ;Quit if a Bill Number wasn't passed
 Q:$G(BILLNUM)']"" OUT
 F  S IEN=$O(^IB("ABIL",BILLNUM,IEN)) Q:IEN'>0  D
 . N IBDATA,IENS,DFN,ACTTYPE,RESULT,DTBILLFR,BILGROUP,OPDT,DISCHARG,RXDT
 . S IENS=IEN_","
 . D GETS^DIQ(350,IENS,".02;.03;.04;.14","IN","IBDATA")
 . S DFN=$G(IBDATA(350,IENS,.02,"I"))
 . S ACTTYPE=$G(IBDATA(350,IENS,.03,"I"))
 . S RESULT=$G(IBDATA(350,IENS,.04,"I"))
 . S DTBILLFR=$G(IBDATA(350,IENS,.14,"I"))
 . ;
 . ;Child charge. Need to get Parent Charge
 . I $P(RESULT,":",1)=350 D
 . . S IENS=+$P(RESULT,":",2)_","
 . . ;Quit if the entry is the parent
 . . Q:+IENS=IEN
 . . D GETS^DIQ(350,IENS,".02;.03;.04;.14","IN","IBDATA")
 . . S DFN=$G(IBDATA(350,IENS,.02,"I"))
 . . S ACTTYPE=$G(IBDATA(350,IENS,.03,"I"))
 . . S RESULT=$G(IBDATA(350,IENS,.04,"I"))
 . . S DTBILLFR=$G(IBDATA(350,IENS,.14,"I"))
 . Q:$G(DFN)']""
 . ;
 . ;Get Billing Group in the IB Action Type File. If internal Set 
 . ;Code value is 4, then this is an Outpatient Visit (From STMT^IBRFN1)
 . ;and can use Date Billed From for the Outpatient Visit Date
 . S BILGROUP=$$GET1^DIQ(350.1,+ACTTYPE_",",.11,"I")
 . ;
 . ;Outpatient Event
 . I BILGROUP=4!($P(RESULT,":",1)=44)!($P(RESULT,":",1)=409.68) D  Q
 . . I $P(RESULT,":",1)=44 S OPDT=$P($P(RESULT,";",2),":",2)
 . . I $P(RESULT,":",1)=409.68 S OPDT=$$GET1^DIQ(409.68,+$P(RESULT,":",2)_",",.01,"I")
 . . I $G(OPDT)'>0 S OPDT=DTBILLFR
 . . I $G(OPDT)>$P(OUT,U,2) S $P(OUT,U,1)=1,$P(OUT,U,2)=OPDT
 . ;
 . ;Quit if RESULTING FROM field is blank
 . Q:$G(RESULT)']""
 . ;
 . ;Inpatient Event
 . I $P(RESULT,":",1)=405!($P(RESULT,":",1)=45) D  Q
 . . S VAIP("E")=$P($P(RESULT,";",1),":",2)
 . . ;Call to get Inpatient data
 . . D IN5^VADPT
 . . Q:VAERR>0
 . . S DISCHARG=$P($G(VAIP(17,1)),U,1)
 . . ;Ensure get most current Discharge Date
 . . I DISCHARG>$P(OUT,U,3) S $P(OUT,U,1)=1,$P(OUT,U,3)=DISCHARG
 . . D KVAR^VADPT
 . ;
 . ;RX Event
 . I $P(RESULT,":",1)=52 D  Q
 . . N PSOFILE,IENS,FLD
 . . ;Set up for RX Refills
 . . I $P(RESULT,";",2)]"" D
 . . . S PSOFILE=52.1
 . . . S IENS=+$P($P(RESULT,";",2),":",2)_","_+$P($P(RESULT,";",1),":",2)_","
 . . . S FLD=.01
 . . ;Set up for RX Data (No refill)
 . . I $P(RESULT,";",2)']"" D
 . . . S PSOFILE=52
 . . . S IENS=+$P($P(RESULT,";",1),":",2)_","
 . . . S FLD=1
 . . ;Call Pharmacy API to get RX/Refill Date
 . . S RXDT=$$GET1^PSODI(PSOFILE,IENS,FLD,"I")
 . . ;Ensure get most current RX/Refill Date
 . . I RXDT>$P(OUT,U,4) S $P(OUT,U,1)=1,$P(OUT,U,4)=$P(RXDT,U,2)
 Q OUT
 ;
