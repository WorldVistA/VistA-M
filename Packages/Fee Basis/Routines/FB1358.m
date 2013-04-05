FB1358 ;WOIFO/SAB - IFCAP 1358 OBLIGATION UTILITIES ;3/13/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
CHK1358(FBAAOB) ; Determine if 1358 obligation is available for posting
 ; input
 ;   FBAAOB - (required) full obligation number including station
 ;            (e.g. 500-C20001)
 ; returns a value
 ;   = 1 if 1358 is available for posting
 ;   = 0^message if 1358 is not available for posting
 ;   
 N FBRET,PRCS,X,Y
 S FBRET="0^1358 number not provided!"
 I $G(FBAAOB)'="" D
 . S PRCS("X")=FBAAOB
 . S PRCS("TYPE")="FB"
 . D EN3^PRCS58
 . I Y=-1 S FBRET="0^1358 not available for posting!"
 . E  S FBRET=1
 ;
 Q FBRET
 ;   
FND424(FB424ID) ; Find File 424 IEN
 ; input
 ;   FB424ID - (required) INTERFACE ID value of entry in file 424
 ; returns file 424 internal entry number or null value if not found
 ;
 Q $S($G(FB424ID)]"":$O(^PRC(424,"E",FB424ID,0)),1:"")
 ;
POSTBAT(FBN,FBAAMT,FBACT,FBSKIP) ; Post to 1358 obligation by batch
 ; This API is called to update an existing IFCAP authorization on a
 ; 1358 obligation when the IFCAP authorization is by fee batch.
 ; input
 ;   FBN - (required) Batch IEN, file 161.7
 ;   FBAAMT - (required) dollar amount
 ;   FBACT - (required) action, value of "R" or "D"
 ;           = "R" if called when payment flagged as rejected
 ;           = "D" if called when reject flag is deleted
 ;   FBSKIP (optional) =1 to skip control point access check
 ; returns value
 ;   = 1 if success
 ;   = 0^message if unsuccessful
 ;
 N FB424,FBAAB,FBAAON,FBAASN,FBRET
 S FBRET=1 ; initialize return value
 ;
 ; verify inputs
 I $G(FBN)="" S FBRET="0^Batch IEN was not provided."
 I $G(FBAAMT)="" S FBRET="0^Amount was not provided."
 I "^R^D^"'[(U_$G(FBACT)_U) S FBRET="0^Invalid action code."
 ;
 ; get data from batch file
 I FBRET D
 . N FBX
 . S FBX=$G(^FBAA(161.7,FBN,0))
 . S FBAAB=$P(FBX,U,1) ; NUMBER
 . S FBAAON=$P(FBX,U,2) ; OBLIGATION NUMBER
 . S FBAASN=$P(FBX,U,8) ; STATION NUMBER
 . I FBAAB=""!(FBAAON="")!(FBAASN="") S FBRET="0^Invalid Batch Data for IEN "_FBN
 ;
 ; check if 1358 available for posting
 I FBRET D
 . N FBX
 . S FBX=$$CHK1358(FBAASN_"-"_FBAAON)
 . I 'FBX S FBRET=FBX
 ;
 ; determine 1358 daily record entry to update
 I FBRET D
 . S FB424=$$FND424(FBN)
 . I FB424="" S FBRET="0^File 424 entry not found."
 ;
 ; post amount to IFCAP
 I FBRET D
 . N FBCOMM,PRCSX,Y
 . ; determine comment
 . I FBACT="R" S FBCOMM="Rejected items from batch "_FBAAB
 . I FBACT="D" S FBCOMM="Deleted reject flags from batch "_FBAAB
 . ; if action is reject then make amount negative to add dollars back
 . I FBACT="R",FBAAMT>0 S FBAAMT=-FBAAMT
 . ;
 . S PRCSX=FB424_"^"_$$NOW^XLFDT_"^"_FBAAMT_"^"_$G(FBCOMM)_"^1"
 . I $G(FBSKIP)=1 S $P(PRCSX,"^",7)="1"
 . D ^PRCS58CC
 . I Y'=1 S FBRET="0^"_$P(Y,"^",2)_"."
 ;
 Q FBRET
 ;
POSTINV(FBN,FBI,FBACT,FBSKIP) ; Post to 1358 obligation by invoice
 ; This API is called to update an existing IFCAP authorization on a
 ; 1358 obligation when the IFCAP authorization is posted by invoice.
 ; input
 ;   FBN - (required) Batch IEN, file 161.7
 ;   FBI - (required) Invoice IEN, file 162.5
 ;   FBACT - (required) action, value of "R" or "D"
 ;           = "R" if called when payment flagged as rejected
 ;           = "D" if called when reject flag is deleted
 ;   FBSKIP (optional) =1 to skip control point access check
 ; returns value
 ;   = 1 if success
 ;   = 0^message if unsuccessful
 ;
 N FB424,FBAAB,FBAAMT,FBAAON,FBAASN,FBDFN,FBII78,FBMM,FBPROG,FBRET
 S FBRET=1 ; initialize return value
 ;
 ; verify inputs
 I $G(FBN)="" S FBRET="0^Batch IEN was not provided."
 I $G(FBI)="" S FBRET="0^Invoice IEN was not provided."
 I "^R^D^"'[(U_$G(FBACT)_U) S FBRET="0^Invalid action code."
 ;
 ; get data from batch file
 I FBRET D
 . N FBX
 . S FBX=$G(^FBAA(161.7,FBN,0))
 . S FBAAB=$P(FBX,U,1) ; NUMBER
 . S FBAASN=$P(FBX,U,8) ; STATION NUMBER
 . S FBAAON=$P(FBX,U,2) ; OBLIGATION NUMBER
 . I FBAAB=""!(FBAAON="")!(FBAASN="") S FBRET="0^Invalid Batch Data for IEN "_FBN
 ;
 ; check if 1358 available for posting
 I FBRET D
 . N FBX
 . S FBX=$$CHK1358(FBAASN_"-"_FBAAON)
 . I 'FBX S FBRET=FBX
 ;
 ; get invoice data
 I FBRET D
 . N FBX
 . S FBX=$G(^FBAAI(FBI,0))
 . S FBDFN=$P(FBX,"^",4) ; VETERAN
 . S FBPROG=$P(FBX,"^",12) ; FEE PROGRAM
 . S FBAAMT=$P(FBX,"^",9) ; AMOUNT PAID
 . S FBII78=$P(FBX,"^",5) ; ASSOCIATED 7078/583
 . I FBDFN=""!(FBPROG="")!(FBAAMT="")!(FBII78="") S FBRET="0^Invalid invoice data for IEN "_FBI
 . ; if nursing home invoice get month
 . I FBRET,FBPROG=7 D
 . . S FBMM=$E($P(FBX,"^",7),4,5) ; 2 digit month from TREATMENT TO DATE 
 . . I FBMM="" S FBRET="0^Invalid invoice data for IEN "_FBI
 ;
 I FBRET,FBII78["FB583" D
 . S FBRET="0^Invoice is associated with an unauthorized claim."
 ;
 ; determine 1358 daily record entry to update
 I FBRET D
 . N FBX
 . ; build interface ID
 . S FBX=FBDFN_";"_+FBII78_";"_FBAAON
 . I FBPROG=7 S FBX=FBX_";"_FBMM
 . S FB424=$$FND424(FBX)
 . I FB424="" S FBRET="0^File 424 entry not found."
 ;
 ; post amount to IFCAP
 I FBRET D
 . N FBCOMM,PRCSX,Y
 . ; determine comment
 . I FBACT="R" S FBCOMM="Rejected items from batch "_FBAAB
 . I FBACT="D" S FBCOMM="Deleted reject flags from batch "_FBAAB
 . ; if action is reject then make amount negative to add dollars back
 . I FBACT="R",FBAAMT>0 S FBAAMT=-FBAAMT
 . ;
 . S PRCSX=FB424_"^"_$$NOW^XLFDT_"^"_FBAAMT_"^"_$G(FBCOMM)_"^1"
 . I $G(FBSKIP)=1 S $P(PRCSX,"^",7)="1"
 . D ^PRCS58CC
 . I Y'=1 S FBRET="0^"_$P(Y,"^",2)_"."
 ;
 Q FBRET
 ;
 ;FB1358
