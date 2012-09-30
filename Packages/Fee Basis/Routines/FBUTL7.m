FBUTL7 ;WIOFO/SAB - FEE BASIS UTILITY FOR CONTRACT ;9/24/2009
 ;;3.5;FEE BASIS;**108**;JAN 30, 1995;Build 115
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
EDCNTRA(FBDFN,FBAUTH) ; determine if CONTRACT can be edited
 ; Input
 ;   FBDFN   = IEN of patient in file 161 (and file 2) 
 ;   FBAUTH  = IEN of authorization in sub-file 161.01
 ; Returns a string value flag^message where
 ;   flag    = 1 if contract field in sub-file 161.01 can be edited
 ;           = 0 if it cannot be edited
 ;   message = optional text that if present should be displayed
 ;
 N FBPAY,FBRET,FBY
 S FBRET=0
 ;
 ; check inputs
 I '$G(FBDFN) G EDCNTRAX ; missing patient IEN
 I '$G(FBAUTH) G EDCNTRAX ; missing authorization IEN
 S FBY=$G(^FBAAA(FBDFN,1,FBAUTH,0))
 I FBY']"" G EDCNTRAX ; no authorization data
 ;
 ; check if contract is applicable to the authorization type
 ;   must be outpatient or civil hospital fee program
 I "^2^6^"'[("^"_$P(FBY,"^",3)_"^") G EDCNTRAX
 ;   must not be an unauthorized claim
 I $P(FBY,"^",9)["FB583" G EDCNTRAX
 ;
 ; check if any existing payments on file
 S FBPAY=0
 I $P(FBY,"^",3)=2 S FBPAY=$$OUTPA(FBDFN,FBAUTH) ; check outpatient
 I $P(FBY,"^",9)["FB7078" S FBPAY=$$PAY^FBUCUTL(+$P(FBY,"^",9),$P($P(FBY,"^",9),";",2)) ; check using the associated 7078
 I FBPAY=1 D  G EDCNTRAX
 . N FBX
 . S FBX="Can't change contract ("
 . S FBX=FBX_$S($P(FBY,"^",22):$$GET1^DIQ(161.43,$P(FBY,"^",22)_",",.01),1:"")
 . S FBX=FBX_") because payments exist."
 . S $P(FBRET,"^",2)=FBX
 ;
 ;passed all checks - OK to edit field
 S FBRET=1
 ;
EDCNTRAX ; EDCNTRA exit
 Q FBRET
 ;
OUTPA(FBDFN,FBAUTH) ; Outpatient Authorization Has Payments?
 ; input
 ;   patient IEN
 ;   authorization IEN
 ; output
 ;   FBPAY = 1 or 0, =1 if any payments on file for the authorization
 N FBPAY,FBVEN
 S FBPAY=0
 ;
 S FBVEN=+$P($G(^FBAAA(FBDFN,1,FBAUTH,0)),"^",4) ; vendor on auth
 I FBVEN D OUTPAV
 E  F  S FBVEN=$O(^FBAAC(FBDFN,1,FBVEN)) Q:'FBVEN  D OUTPAV  Q:FBPAY
 Q FBPAY
 ;
OUTPAV ; 
 N FBDTI
 S FBDTI=0
 F  S FBDTI=$O(^FBAAC(FBDFN,1,FBVEN,1,FBDTI)) Q:'FBDTI  D  Q:FBPAY
 . Q:$P($G(^FBAAC(FBDFN,1,FBVEN,1,FBDTI,0)),"^",4)'=FBAUTH
 . Q:'$O(^FBAAC(FBDFN,1,FBVEN,1,FBDTI,1,0))
 . S FBPAY=1
 Q
CNTRPTR(FBDA) ; Contract pointed-to
 ; input FBDA = ien of contract in file 161.43
 ; result 0 or 1, =1 if contract is pointed-to
 N FBRET
 S FBRET=0
 ; check fee basis patient (authorizations)
 I $D(^FBAAA("ACN",FBDA)) S FBRET=1
 ; check fee basis payment
 I 'FBRET,$D(^FBAAC("ACN",FBDA)) S FBRET=1
 ; check fee basis invoice
 I 'FBRET,$D(^FBAAI("ACN",FBDA)) S FBRET=1
 Q FBRET
 ;
 ;
UCFA(FBVENI,FBVENA,FBCNTRA) ; Use Contract From Authorization
 ; input
 ;   FBVENI = vendor IEN for invoice/payment
 ;   FBVENA = vendor IEN for associated authorization
 ;   FBCNTRA = contract IEN for associated authorization
 ; returns 0 or 1
 ;   = 1 if invoice must have same contract as associated authorization
 N FBAR,FBI,FBRET
 S FBRET=0
 ; if authorization has a contract
 I FBCNTRA D
 . ; does the vendor being paid match the vendor on the authorizaton
 . I FBVENI=FBVENA S FBRET=1
 . Q:FBRET=1
 . ; build a list of linked vendors for the vendor being paid
 . I FBVENI D  ; build list of linked vendors in FBAR(
 . . N DA,FBA,FBDA,FBJ
 . . S DA=FBVENI
 . . S FBAR(DA)=""
 . . D ^FBAACO4
 . ; loop thru linked vendors to see if any match
 . S FBI=0 F  S FBI=$O(FBAR(FBI)) Q:'FBI  D  Q:FBRET
 . . I FBI=FBVENA S FBRET=1
 Q FBRET
 ;
CNTRSCR(FBDFN,FBAUT,FBCNTRA) ; contract screen
 ; called by 161.01 CONTRACT field screen
 ; input
 ;   FEE BASIS PATIENT ien
 ;   AUTHORIZATION ien
 ;   CONTRACT ien
 ; return 0 or 1, =1 if contract passes screen
 N FBRET,FBVEN
 S FBRET=1
 ; check status of contract
 I $G(DIUTIL)'="VERIFY FIELDS",$P($G(^FBAA(161.43,FBCNTRA,0)),"^",2)'="A" S FBRET=0
 ; if authorization iens provided, then screen on vendor
 I FBRET,$G(FBDFN),$G(FBAUT) D
 . S FBVEN=$P($G(^FBAAA(FBDFN,1,FBAUT,0)),"^",4)
 . I FBVEN'>0 S FBRET=0 Q
 . S FBRET=$$VCNTR(FBVEN,FBCNTRA)
 Q FBRET
 ;
VCNTR(FBV,FBC) ; vendor applicable for the contract
 ; input
 ;   FBV = IEN of vendor (FEE BASIS VENDOR file)
 ;   FBC = IEN on contract (FEE BASIS CONTRACT file)
 ; returns 0 or 1
 ;         =1 if vendor is applicable for the contract
 N FBAR,FBI,FBRET
 S FBRET=0
 I $G(FBV),$G(FBC) D
 . ; is vendor applicable?
 . I $D(^FBAA(161.43,"AV",FBV,FBC)) S FBRET=1
 . Q:FBRET=1
 . ; try linked vendors (if any)
 . D  ; build list of linked vendors in FBAR(
 . . N DA,FBA,FBDA,FBJ
 . . S DA=FBV
 . . S FBAR(DA)=""
 . . D ^FBAACO4
 . ; loop thru linked vendors to see if any are applicable
 . S FBI=0 F  S FBI=$O(FBAR(FBI)) Q:'FBI  D  Q:FBRET
 . . I $D(^FBAA(161.43,"AV",FBI,FBC)) S FBRET=1
 Q FBRET
 ;
 ;FBUTL7
