IBCNEDE7 ;DAOU/DAC - eIV DATA EXTRACTS ;04-JUN-2002
 ;;2.0;INTEGRATED BILLING;**271,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q    ; no direct calls allowed
 ; 
SETTINGS(EXTNUM) ; Check site parameter settings for the extracts
 ; Input Parameter:
 ;
 ; EXTNUM is either 1, 2, 3 to represent the different extracts
 ; 1 - Insurance Buffer extract
 ; 2 - Pre-Reg (appointments)
 ; 3 - Non Verified
 ;        IB*2*416 removed extract#4 for No Insurance
 ;
 ; Output:
 ; Returns a "^" delimited string passing back:
 ;    A flag of whether to consider the extract active
 ;    Number of days to look back in the past when extracting data
 ;    STALEDYS - "stale days": number of days from today to determine the
 ;          freshness this is only used for the non-verified and no 
 ;          insurance extract.  The other two extracts pull their days
 ;          from the IB SITE PARAMETER file within their specific 
 ;          extract routine.
 ;    Max Number of entries you are allowed to set into the eIV 
 ;          Transmission Queue file.  If null, # of entries allowed is
 ;          unlimited.
 ;    Suppress Buffer Flag - Either '0' (No) or '1' (Yes)
 ;          1 will suppress the creation of buffer entries
 ;          0 will not
 ;          Applies to extracts 2 (Pre Reg) and 3 (Non verified)
 ;
 N DIC,DISYS,DA,X,Y,EACTIVE,XDAYS,STALEDYS,MAXCNT,OK,SUPPBUFF
 S EACTIVE=0,(XDAYS,STALEDYS,MAXCNT)=""
 S OK=$S(EXTNUM=1:1,EXTNUM=2:1,EXTNUM=3:1,1:0)
 I 'OK G EXIT
 S DA=1,DIC="^IBE(350.9,"_DA_",51.17,",DIC(0)="X",X=EXTNUM D ^DIC
 ;
 I Y<1 G EXIT  ; extract not defined in the IB Site Parameter
 ;
 S EACTIVE=$G(^IBE(350.9,1,51.17,+Y,0))
 S XDAYS=$P(EACTIVE,U,3)
 S STALEDYS=$P(EACTIVE,U,4)
 S MAXCNT=$P(EACTIVE,U,5)
 S SUPPBUFF=$P(EACTIVE,U,6)
 I SUPPBUFF="" S SUPPBUFF=0
 S EACTIVE=$P(EACTIVE,U,2)
EXIT ;
 I EXTNUM=2,(XDAYS="") S EACTIVE=0  ; missing required data
 I EXTNUM=3 D
 . I XDAYS=""!(STALEDYS="") S EACTIVE=0   ; missing required data
 Q EACTIVE_U_XDAYS_U_STALEDYS_U_MAXCNT_U_SUPPBUFF
 ;
SETTQ(DATA1,DATA2,ORIG,OVERRIDE) ;Set extract data in TQ file 365.1
 ;
 ; DATA1, DATA2, & ORIG are "^" delimited variables containing the data
 ; listed below
 ;
 ; OVERRIDE - flag indicates that this entry is a result of the 
 ;         'Request Re-Verification' menu option.
 ;
 N FDA,IENARRAY,ERROR,TRANSNO,DFN
 ; do not allow "NO PAYER" entries
 I $P(DATA1,U,2)=$$FIND1^DIC(365.12,"","X","~NO PAYER") Q
 ;
 S TRANSNO=$P($G(^IBCN(365.1,0)),U,3)+1
 S FDA(365.1,"+1,",.01)=TRANSNO             ; Transaction #
 ;
 S DFN=$P(DATA1,U)
 S FDA(365.1,"+1,",.02)=DFN                 ; patient DFN
 S FDA(365.1,"+1,",.03)=$P(DATA1,U,2)       ; ien of payer
 S FDA(365.1,"+1,",.04)=$P(DATA1,U,3)       ; ien of transmission status
 S FDA(365.1,"+1,",.15)=DT                  ; trans status date
 S FDA(365.1,"+1,",.05)=$P(DATA1,U,4)       ; ien of buffer
 ;
 S FDA(365.1,"+1,",.06)=$$NOW^XLFDT         ; creation date/time
 S FDA(365.1,"+1,",.07)=0                   ; transmission retries
 S FDA(365.1,"+1,",.08)=0                   ; number of retries
 I $D(OVERRIDE) S FDA(365.1,"+1,",.14)=OVERRIDE  ; override flag
 S FDA(365.1,"+1,",.16)=$P(DATA1,U,5)        ; Sub. ID
 S FDA(365.1,"+1,",.17)=$P(DATA1,U,6)        ; Freshness Date
 S FDA(365.1,"+1,",.18)=$P(DATA1,U,7)        ; Pass Buffer ien?
 S FDA(365.1,"+1,",.19)=$P(DATA1,U,8)        ; Patient ID
 ;
 I $D(DATA2) D
 . S FDA(365.1,"+1,",.1)=$P(DATA2,U)          ; which extract (ien)
 . S FDA(365.1,"+1,",.11)=$P(DATA2,U,2)       ; query flag
 . S FDA(365.1,"+1,",.12)=$P(DATA2,U,3)       ; service date
 . S FDA(365.1,"+1,",.13)=$P(DATA2,U,4)       ; patient insur. ien
 ;
 I $D(ORIG) D
 . S FDA(365.1,"+1,",1.02)=$P(ORIG,U)   ; original ins co (in buffer)
 . S FDA(365.1,"+1,",1.03)=$P(ORIG,U,2)   ; original grp # (in buffer)
 . S FDA(365.1,"+1,",1.04)=$P(ORIG,U,3)   ; original grp name (in buffer)
 . S FDA(365.1,"+1,",1.05)=$P(ORIG,U,4)   ; original subscriber ID
 ;
 D UPDATE^DIE("","FDA","IENARRAY","ERROR")
 ;
 I $D(ERROR) D  ; MailMan msg
 . NEW MGRP,XMSUB,MSG
 . KILL MSG
 . ;
 . ; Set to IB site parameter MAILGROUP
 . S MGRP=$$MGRP^IBCNEUT5()
 . ;
 . S XMSUB="eIV Problem: Trouble setting entry in File 365.1"
 . S MSG(1)="Tried to create an entry in the eIV Transmission Queue File #365.1 without"
 . S MSG(2)="success."
 . S MSG(3)=""
 . S MSG(4)="Error encountered: "_$G(ERROR("DIERR",1,"TEXT",1))
 . S MSG(5)=""
 . S MSG(6)="The data that was to be stored is as follows:"
 . S MSG(7)=""
 . S MSG(8)="Transaction #: "_TRANSNO
 . S MSG(9)="Patient: "_$P($G(^DPT(DFN,0)),U)_$$SSN^IBCNEDEQ(DFN)
 . S MSG(10)="Extract: "_$G(FDA(365.1,"+1,",.1))
 . S MSG(11)="Payer: "_$P($G(^IBE(365.12,FDA(365.1,"+1,",.03),0)),U,1)
 . S MSG(12)="Please call the Help Desk about this problem."
 . D MSG^IBCNEUT5(MGRP,XMSUB,"MSG(")
 ;
 Q $G(IENARRAY(1))
 ;
PYRACTV(PIEN) ; check if given payer is nationally active for eIV
 ; returns 1 if payer is nationally active, 0 otherwise
 N APPIEN,RES
 S RES=0
 I +$G(PIEN)'>0 G PYRACTVX
 S APPIEN=$$PYRAPP^IBCNEUT5("IIV",PIEN)
 I +$G(APPIEN)'>0 G PYRACTVX
 I $P($G(^IBE(365.12,PIEN,1,APPIEN,0)),U,2)=1 S RES=1
PYRACTVX ;
 Q RES
