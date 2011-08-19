RABWIBB ;HOIFO/MDM - Radiology Billing Awareness ;12/20/04 12:55am
 ;;5.0;Radiology/Nuclear Medicine;**57**;Mar 16, 1998
 ; $$SWSTAT^IBBAPI uses DBIA #4663
 ; 
 Q
FB(RAOIFN) ; called by ACC^RAO7OKS and FILEDX^RABWORD
 ; Functional Requirement 12
 ; Check PFSS Master Switch and quit if it is not on.
 I '$$SWSTAT^IBBAPI() Q
 ;
 ; Initialize relevent variables
 ; IBBARFN = Account Reference Number
 ; IBBEVENT = HL7 Event Code 
 S IBBARFN="",IBBEVENT="A05"
 ; Calling routine
 S IBBAPLR="FB^RABWIBB"
 ;
 ; Define remaining (Required) IBB Variables and Arrays
 D GA^RABWIBB2(RAOIFN)
 ;
 ; Functional Requirement 5
 D STOR751^RABWIBB2(RAOIFN)
 Q
PV1 ; (called by RAO7UTL) Front Door 
 ; OR EVSEND -> RA RECEIVE -> RAO7RO -> RAO7UTL
 ;
 I '$$SWSTAT^IBBAPI() Q   ; PFSS is not turned on so stop
 I $G(RACCOUNT)="" Q  ; Needed data is missing so stop
 ;
 ; set RAPF to include PV1.50
 ; $$STR(n) returns n delimiters.
 S RAPF="PV1"_$$STR^RAO7UTL(2)_RA("PV1",2)_RAHLFS_RA("PV1",3)_$$STR^RAO7UTL(47)_RACCOUNT
 ;
 Q
DC(RAOIFN) ; called by EXMCAN^RAORDC
 ;
 I '$$SWSTAT^IBBAPI() Q   ; PFSS is not turned on so stop
 S RACCOUNT=$P(^RAO(75.1,RAOIFN,0),U,28) ; Get Account Reference
 S IBBARFN=RACCOUNT
 S IBBEVENT="A38"
 ; Calling routine
 S IBBAPLR="DC^RABWIBB"
 D GA^RABWIBB2(RAOIFN)
 ;
 Q
GETDEPT ; called by PROC^RAPCE
 S RAOIMG=$P($G(^RAO(75.1,RAOIFN,0)),U,3),RACCOUNT=$P($G(^RAO(75.1,RAOIFN,0)),U,28)
 S RAIDPT=$P($G(^RA(79.2,RAOIMG,0)),U,6)
 S ^TMP("RAPXAPI",$J,"PROCEDURE",X,"DEPARTMENT")=RAIDPT ; Requirement 11
 Q
