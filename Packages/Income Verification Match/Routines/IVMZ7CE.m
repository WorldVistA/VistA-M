IVMZ7CE ;TDM,BAJ,ERC - HL7 Z07 CONSISTENCY CHECKER -- SERVICE SUBROUTINE ; 12/4/07 2:56pm
 ;;2.0;INCOME VERIFICATION MATCH;**105,127,132**;JUL 8,1996;Build 1
 ;
 ; Eligibility Consistency Checks
 ; This routine checks the various elements of service information
 ; prior to building a Z07 record.  Any tests which fail consistency
 ; check will be saved to the ^DGIN(38.6 record for the patient.
 ;
 ; Must be called from entry point
 Q
 ;
EN(DFN,DGP) ; entry point.  Patient DFN is sent from calling routine.
 ; initialize working variables
 N RULE,Y,X,FILERR
 ;
 ; loop through rules in INCONSISTENT DATA ELEMENTS file.
 ; execute only the rules where CHECK/DON'T CHECK and INCLUDE IN Z07
 ; CHECKS fields are turned ON.
 ;
 ; ***NOTE loop boundary (401-413) must be changed if rule numbers
 ; are added ***
 F RULE=401:1:413 I $D(^DGIN(38.6,RULE)) D
 . S Y=^DGIN(38.6,RULE,0)
 . I $P(Y,U,6) D @RULE
 I $D(FILERR) M ^TMP($J,DFN)=FILERR
 Q
 ;
401 ; RATED INCOMPETENT INVALID
 S X=$P(DGP("PAT",.29),U,12) I (X'="")&(X'=0)&(X'=1) S FILERR(RULE)=""
 Q
 ;
402 ; ELIGIBLE FOR MEDICAID INVALID
 S X=$P(DGP("PAT",.38),U) I (X'="")&(X'=0)&(X'=1) S FILERR(RULE)=""
 Q
 ;
403 ; DT MEDICAID LAST ASKED INVALID
 I $P(DGP("PAT",.38),U)=1,$P(DGP("PAT",.38),U,2)<1 S FILERR(RULE)=""
 Q
 ;
404 ; INELIGIBLE REASON INVALID
 ; Note: RULE #15 in IVMZ7CR is a duplicate of this rule
 Q
 ;
405 ; NON VETERAN ELIG CODE INVALID
 ; Note: RULE #60 in IVMZ7CR is a duplicate of this rule
 Q
 ;
406 ; CLAIM FOLDER NUMBER INVALID
 S X=$P(DGP("PAT",.31),U,3)
 I X'="",$P(DGP("PAT",0),U,9)'=X,(($L(X)>8)!($L(X)<7)) S FILERR(RULE)=""
 Q
 ;
407 ; ELIGIBILITY STATUS INVALID
 S X=$P(DGP("PAT",.361),U) I (X'="")&(X'="P")&(X'="R")&(X'="V") S FILERR(RULE)=""
 Q
 ;
408 ; DECLINE TO GIVE INCOME INVALID
 ; This CC removed per customer 05/08/2006 -- BAJ
 ; I $D(DGP("MEANS",0)),$P(DGP("MEANS",0),U,4)<1,$P(DGP("MEANS",0),U,14)'=1 S FILERR(RULE)=""
 Q
 ;
409 ; AGREE TO PAY DEDUCT INVALID
 ; this CC inactivated by DG*5.3*771
 ; 2  PENDING ADJUDICATION     MEANS TEST
 ; 6  MT COPAY REQUIRED     MEANS TEST
 ;16  GMT COPAY REQUIRED     MEANS TEST
 I $D(DGP("MEANS",0)),$P(DGP("MEANS",0),U,11)="" D
 . S X=$P(DGP("MEANS",0),U,3)
 . I (X=2)!(X=6) S FILERR(RULE)="" Q
 . I X=16,'$P(DGP("MEANS",0),U,20) S FILERR(RULE)=""
 Q
 ;
410 ; Note: RULE #404 above is a duplicate of this rule
 Q
 ;
411 ; ENROLLMENT APP DATE INVALID
 I $D(DGP("ENR",0)) S X=$P(DGP("ENR","0"),U) I ($E(X,1,3)<1)!($E(X,4,5)<1)!($E(X,6,7)<1) S FILERR(RULE)=""
 Q
 ;
412 ; POS/ELIG CODE INVALID
 ; Note: RULE #24 in IVMZ7CR is a duplicate of this rule
 Q
 ;
413 ; POS INVALID
 ; Note: RULE #13 in IVMZ7CR is a duplicate of this rule
 Q
