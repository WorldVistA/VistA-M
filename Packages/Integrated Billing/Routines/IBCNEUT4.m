IBCNEUT4 ;DAOU/ESG - eIV MISC. UTILITIES ;17-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,345,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Can't be called from the top
 Q
 ;
 ;
ACTIVE(INSDA) ; Is this insurance company currently active?  1:yes or 0:no
 ; Insurance company name returned in the second piece.
 ; Input:  INSDA - insurance company ien
 NEW ACTFLG,INSDATA
 S ACTFLG=0                                  ; default inactive
 I '$G(INSDA) G ACTIVEX                      ; bad data passed in
 S INSDATA=$G(^DIC(36,INSDA,0))              ; zero node of File 36
 I INSDATA="" G ACTIVEX                      ; bad record
 I $P(INSDATA,U,5) G ACTIVEX                 ; INACTIVE flag is true
 I $P($G(^DIC(36,INSDA,5)),U,1) G ACTIVEX    ; SCHEDULED FOR DELETION flag is true
 S ACTFLG=1                                  ; Otherwise, its active
ACTIVEX ;
 Q ACTFLG_U_$P($G(^DIC(36,+$G(INSDA),0)),U,1)
 ;
 ;
EXCLUDE(NAME) ; This function determines if we should exclude the insurance
 ; company based on the name.
 ; This function returns 1 if we should exclude the insurance company.
 ; This function returns 0 if we should not exclude it (i.e. include it)
 ;
 ; Initialize flag; default to not exclude it
 NEW EXCL
 S EXCL=0
 ;
 ; Screen out bad data
 I $G(NAME)="" S EXCL=1 G EXCLUDX
 ;
 ; Screen out MEDICAID ins co
 I NAME["MEDICAID" S EXCL=1
EXCLUDX ;
 Q EXCL
 ;
 ;
CLEAR(DA,EDITED,FORCE) ; This procedure will clear the eIV status field from an
 ; Insurance Buffer entry (pass in the internal entry number of the
 ; buffer entry).  If the FORCE variable is not passed then the eIV
 ; status will only be cleared if the existing status is an error status
 ;
 ; Parameters
 ;        DA - required input parameter; buffer ien
 ;    EDITED - optional output parameter; this will tell you if the
 ;             buffer symbol was cleared
 ;     FORCE - optional input parameter; if this is set to 1 then the
 ;             eIV status field will be cleared regardless of the
 ;             current status 
 NEW DIE,DR,D,D0,DI,DIC,DISYS,DQ,X,%
 I '$G(DA) G CLEARX
 I '$D(FORCE) S FORCE=0
 I 'FORCE,$$SYMBOL^IBCNBLL(DA)'="!" G CLEARX
 S DIE=355.33,DR=".12///@"
 D ^DIE
 S EDITED=1
CLEARX ;
 Q
 ;
 ;
INFO(IBBUFDA) ; Return original and current buffer data
 ; This procedure will retrieve the following data from the buffer and
 ; from the transmission queue file.  The buffer holds the current data
 ; and the TQ file holds the original buffer data.
 ; Input
 ;    IBBUFDA - buffer internal entry number
 ; Output
 ;    a pieced string as follows
 ;    [1]  Has this buffer entry been transmitted? 1/0
 ;    [2]  Current buffer source of information (external)
 ;    [3]  Current buffer source of information (internal)
 ;    [4]  Current buffer insurance company name
 ;    [5]  Current buffer group number
 ;    [6]  Current buffer group name
 ;    [7]  Current buffer subscriber ID
 ;    [8]  Original buffer insurance company name
 ;    [9]  Original buffer group number
 ;   [10]  Original buffer group name
 ;   [11]  Original buffer subscriber ID
 ;
 NEW IB0,IB20,IB40,IB60,DATA,RESPIEN,FOUND,TQIEN,TQDATA,TQDATA1,DISYS
 S DATA=""
 I '$G(IBBUFDA) G INFOX
 I '$D(^IBA(355.33,IBBUFDA)) G INFOX
 S IB0=$G(^IBA(355.33,IBBUFDA,0))
 S IB20=$G(^IBA(355.33,IBBUFDA,20))
 S IB40=$G(^IBA(355.33,IBBUFDA,40))
 S IB60=$G(^IBA(355.33,IBBUFDA,60))
 S $P(DATA,U,1)=0    ; default to not been transmitted
 S $P(DATA,U,2)=$$EXTERNAL^DILFD(355.33,.03,"",$P(IB0,U,3))  ; source
 S $P(DATA,U,3)=$P(IB0,U,3)     ; internal source
 S $P(DATA,U,4)=$P(IB20,U,1)    ; insurance company name
 S $P(DATA,U,5)=$P(IB40,U,3)    ; group number
 S $P(DATA,U,6)=$P(IB40,U,2)    ; group name
 S $P(DATA,U,7)=$P(IB60,U,4)    ; subscriber id
 ;
 ; Look at the response file and the transmission queue file.  Since
 ; we're trying to get the original data look at the oldest data first.
 S RESPIEN=0,FOUND=0
 F  S RESPIEN=$O(^IBCN(365,"AF",IBBUFDA,RESPIEN)) Q:'RESPIEN  D  Q:FOUND
 . S TQIEN=$P($G(^IBCN(365,RESPIEN,0)),U,5)
 . I 'TQIEN Q
 . S TQDATA=$G(^IBCN(365.1,TQIEN,0))
 . S TQDATA1=$G(^IBCN(365.1,TQIEN,1))
 . I TQDATA="" Q
 . S $P(DATA,U,8)=$P(TQDATA1,U,2)    ; insurance company name
 . S $P(DATA,U,9)=$P(TQDATA1,U,3)    ; group number
 . S $P(DATA,U,10)=$P(TQDATA1,U,4)    ; group name
 . S $P(DATA,U,11)=$P(TQDATA1,U,5)    ; subscriber id
 . S FOUND=1                          ; Stop once we have some data
 . Q
 ;
 I FOUND S $P(DATA,U,1)=1
INFOX ;
 Q DATA
 ;
 ;
VALID(INSIEN,PAYIEN,PAYID,SYMIEN) ; Validate an Ins Co IEN
 ; Input parameter: INSIEN - Ins co IEN, passed by value
 ; Output parameters: PAYIEN, PAYID, SYMIEN, passed by reference
 N APPDATA,APPIEN,INSNAME
 ; Retrieve the Ins Co name
 S INSNAME=$P($G(^DIC(36,INSIEN,0)),U,1)
 I INSNAME="" S SYMIEN=$$ERROR^IBCNEUT8("B9","Insurance company IEN "_INSIEN_" doesn't have a name on file.") G VALIDX
 ; Screen out MEDICAID ins co
 I $$EXCLUDE(INSNAME) S SYMIEN=$$ERROR^IBCNEUT8("B11","Insurance company "_INSNAME_" contains MEDICAID in the name.  Electronic inquiries cannot be made to this insurance company.") G VALIDX
 ; Retrieve the Payer IEN associated with this ins co
 S PAYIEN=$P($G(^DIC(36,INSIEN,3)),U,10)
 I PAYIEN="" S SYMIEN=$$ERROR^IBCNEUT8("B4","Insurance company "_INSNAME_" is not linked to a Payer.") G VALIDX
 D VALPYR(INSNAME) ; Payer val'n
VALIDX ;
 Q
 ;
PAYER(PAYIEN) ;
 ; Entry pt for Most Pop Payer (called by POP^IBCNEDE4)
 N SYMIEN,PAYID
 N APPDATA,APPIEN ; Set within tag VALPYR these variables are never
 ;                  killed. Using tag VALID's method of NEWing variables
 ;                  first will allow them to be killed appropriately.
 N ARRAY ; This is an array that is set by ERROR^IBCNEUT8 but never
 ;         killed.  When there is a most popular payer that is not
 ;         eligible for inquiries, ARRAY would continue to grow.
 S (SYMIEN,PAYID)=""
 D VALPYR("")
 Q SYMIEN_U_PAYID
 ;
VALPYR(INSNM) ;
 ; Payer Val'n - note: PAYIEN (payer IEN) must be set
 ; If INSNM="" val'n is for Most Pop Payer
 N PAYNM
 ;
 S INSNM=$G(INSNM) ; Init variable if not passed
 ; Retrieve the National ID(Payer ID) for this Payer IEN
 S PAYID=$P($G(^IBE(365.12,PAYIEN,0)),U,2)
 I PAYID="" S SYMIEN=$$ERROR^IBCNEUT8("B9","Payer IEN "_PAYIEN_" does not have a Payer.") Q
 ; Retrieve payer name
 S PAYNM=$P($G(^IBE(365.12,PAYIEN,0)),U,1)
 ; Retrieve the IEN of the eIV Application
 S APPIEN=$$PYRAPP^IBCNEUT5("IIV",PAYIEN)
 I APPIEN="" S SYMIEN=$$ERROR^IBCNEUT8("B9","The eIV Payer Application has not been created for this site.") Q
 ; Verify the existence of the application for this Payer
 I '$D(^IBE(365.12,PAYIEN,1,APPIEN)) S SYMIEN=$$ERROR^IBCNEUT8("B7","Insurance company "_INSNM_" is linked to Payer "_PAYNM_" which is not set up to accept electronic insurance eligibility requests.") Q
 ; Retrieve the eIV-specific application data for this Payer
 S APPDATA=$G(^IBE(365.12,PAYIEN,1,APPIEN,0))
 ; Check if the Payer doesn't have either an active national or an
 ; active local connection and return one or, if applicable, BOTH errors
 I '$P(APPDATA,U,3) S SYMIEN=$$ERROR^IBCNEUT8("B6","Insurance company "_INSNM_" is linked to Payer "_PAYNM_" which is not locally active for eIV.")
 I '$P(APPDATA,U,2) S SYMIEN=$$ERROR^IBCNEUT8("B5","Insurance company "_INSNM_" is linked to Payer "_PAYNM_" which is not nationally active for eIV.")
 ; Check if the Payer has been deactivated, if so report it
 I $P(APPDATA,U,11) S SYMIEN=$$ERROR^IBCNEUT8("B14","Insurance company "_INSNM_" is linked to Payer "_PAYNM_" which has been deactivated as of "_$$FMTE^XLFDT($P(APPDATA,U,12),"5Z")_".")
 Q
 ;
MULTNAME(TEXT,LIST) ; Function to return an error message with a list of multiple names
 ; Input parameters:
 ;  TEXT - Error text to display
 ;  LIST - List of items, can be either a list of ins co
 ;         names or National ID names
 ; Output parameter: Function value - Formatted list of items in 1 string
 N COLIST,I,NAME,TOOLONG
 S NAME="",COLIST=TEXT,TOOLONG=0
 F I=1:1 S NAME=$O(LIST(NAME)) Q:NAME=""  D  Q:TOOLONG
 . ; Add this name to the list of found names
 . I I=1 S COLIST=COLIST_": "_NAME
 . E  S COLIST=COLIST_", "_NAME
 . ; check if the list of items may cause a MAXSTRING error
 . I $L(COLIST)<450 Q
 . S COLIST=COLIST_" (Too many items to display)",TOOLONG=1
 ;
 Q COLIST_"."
 ;
