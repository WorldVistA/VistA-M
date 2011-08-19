IVMZ7CS ;TDM,ERC - HL7 Z07 CONSISTENCY CHECKER -- SERVICE SUBROUTINE ; 8/1/08 1:54pm
 ;;2.0;INCOME VERIFICATION MATCH;**105,132,115**;OCT 21,1994;Build 28
 ;
 ; Service Consistency Checks
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
 ; ***NOTE loop boundary (501-517) must be changed if rule numbers
 ; are added ***
 F RULE=501:1:517 I $D(^DGIN(38.6,RULE)) D
 . S Y=^DGIN(38.6,RULE,0)
 . I $P(Y,U,6) D @RULE
 I $D(FILERR) M ^TMP($J,DFN)=FILERR
 Q
 ;
501 ; POW STATUS INVALID
 S X=$P(DGP("PAT",.52),U,5) I (X'="")&(X'="Y")&(X'="N")&(X'="U") S FILERR(RULE)=""
 Q
 ;
502 ; MIL DIS RETIREMENT INVALID
 S X=$P(DGP("PAT",.36),U,12) I (X'="")&(X'=0)&(X'=1) S FILERR(RULE)=""
 Q
 ;
503 ; DISCHARGE DUE TO DISAB INVALID
 S X=$P(DGP("PAT",.36),U,13) I (X'="")&(X'=0)&(X'=1) S FILERR(RULE)=""
 Q
 ;
504 ; AGENT ORANGE EXPOSURE INVALID
 S X=$P(DGP("PAT",.321),U,2) I (X'="")&(X'="Y")&(X'="N")&(X'="U") S FILERR(RULE)=""
 Q
 ;
505 ; RADIATION EXPOSURE INVALID
 S X=$P(DGP("PAT",.321),U,3) I (X'="")&(X'="Y")&(X'="N")&(X'="U") S FILERR(RULE)=""
 Q
 ;
506 ; SW ASIA CONDITIONS INVALID (Name changed from Env Con. DG*5.3*688)
 S X=$P(DGP("PAT",.322),U,13) I (X'="")&(X'="Y")&(X'="N")&(X'="U") S FILERR(RULE)=""
 Q
 ;
507 ; RAD EXPOSURE METHOD INVALID
 I $P(DGP("PAT",.321),U,3)="Y" S X=$P(DGP("PAT",.321),U,12) I X'?1N!(X<2)!(X>7) S FILERR(RULE)=""
 Q
 ;
508 ; MST STATUS INVALID
 S X=$P($G(DGP("MST",0)),U,3) I (X'="")&(X'="Y")&(X'="N")&(X'="D")&(X'="U") S FILERR(RULE)=""
 Q
 ;
509 ; MST STATUS CHANGE DATE MISSING
 S X=$P($G(DGP("MST",0)),U,3) I ((X="Y")!(X="N")!(X="D")!(X="U")),$P(DGP("MST",0),U)<1 S FILERR(RULE)=""
 Q
 ;
510 ; MST STATUS SITE REQUIRED
 S X=$P($G(DGP("MST",0)),U,3) I ((X="Y")!(X="N")!(X="D")!(X="U")),$P(DGP("MST",0),U,6)="" S FILERR(RULE)=""
 Q
 ;
511 ; MST STATUS SITE INVALID
 S X=$P($G(DGP("MST",0)),U,6) I X'="",'$$TF^XUAF4(X) S FILERR(RULE)=""
 Q
 ;
512 ; AO EXPOSURE LOCATION MISSING
 ; Note: RULE #60 in IVMZ7CR is a duplicate of this rule
 Q
 ;
513 ; MS ENTRY DATE REQUIRED
 ; Note: RULE #72 in IVMZ7CR is a duplicate of this rule
 Q
 ;
514 ; MS SEPARATION DATE REQUIRED
 ; Note: RULE #72 in IVMZ7CR is a duplicate of this rule
 Q
 ;
515 ; CONFLICT FROM/TO DATE REQUIRED
 ; Note: RULE #74 in IVMZ7CR is a duplicate of this rule
 Q
 ;
516 ; DOB INVALID-MEXICAN BORDER WAR
 N MBW
 I $D(^DPT(DFN,"E")) D
 . S MBW=$O(^DIC(8,"B","MEXICAN BORDER WAR","")) Q:MBW=""
 . S X=0 F  S X=$O(^DPT(DFN,"E",X)) Q:(X<1)!$D(FILERR(RULE))  D
 . . I $P(^DPT(DFN,"E",X,0),U)=MBW,$P(DGP("PAT",0),U,3)>2061231 S FILERR(RULE)=""
 Q
 ;
517 ; DOB INVALID-WORLD WAR I
 N WWI
 I $D(^DPT(DFN,"E")) D
 . S WWI=$O(^DIC(8,"B","WORLD WAR I","")) Q:WWI=""
 . S X=0 F  S X=$O(^DPT(DFN,"E",X)) Q:(X<1)!$D(FILERR(RULE))  D
 . . I $P(^DPT(DFN,"E",X,0),U)=WWI,$P(DGP("PAT",0),U,3)>2071231 S FILERR(RULE)=""
 Q
YM(X) ; Returns whether date has year & month values: 1=yes, 0=no
 Q ($E(X,1,3)>0)&($E(X,4,5)>0)
 ;
YY(X) ; Returns whether date has year a value: 1=yes, 0=no
 Q ($E(X,1,3)>0)
