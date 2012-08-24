PXRMMATH ;SLC/PKR - Math utility routines. ;07/30/2010
 ;;2.0;CLINICAL REMINDERS;**18**;Feb 04, 2005;Build 152
 ;
 ;=================================
RANDOM(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;
 ;VA-RANDOM NUMBER computed finding.
 N DIV,IND,LB,OFFSET,NDD,NOW,RANGE,UB
 S LB=+$P(TEST,U,1),UB=+$P(TEST,U,2),NDD=+$P(TEST,U,3)
 I (LB[".")!(UB[".") S NFOUND=0 Q
 I UB<LB S NFOUND=0 Q
 S NOW=$$NOW^PXRMDATE
 S NFOUND=NGET
 S OFFSET=-LB
 S DIV=10**NDD
 S RANGE=DIV*(UB+OFFSET)+1
 S TEXT(1)="Lower bound = "_LB_" Upper bound = "_UB_", "_NDD_" decimal digits"
 F IND=1:1:NGET D
 . S TEST(IND)=1
 . S DATA(IND,"VALUE")=($R(RANGE)/DIV)-OFFSET
 . S DATE(IND)=NOW
 Q
 ;
