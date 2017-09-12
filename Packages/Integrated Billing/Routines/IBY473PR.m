IBY473PR ;ALB/BI - Pre-Installation for IB patch 473 ;2-Feb-2012
 ;;2.0;INTEGRATED BILLING;**473**;2-FEB-12;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
INCLUDE(FILE,Y) ; function to determine if O.F. entry should be included in the build
 ; FILE=5,6,7 indicating file 364.x
 ; Y=ien to file
 NEW OK,LN,TAG,DATA
 S OK=0
 F LN=2:1 S TAG="ENT"_FILE_"+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,U_Y_U) S OK=1 Q
 Q OK
 ;-----------------------------------------------------------------------
 ; 364.5 entries modified:
 ; 125 - OI1.8 (Other Payer Paid Amt)
 ;
ENT5 ; O.F. entries in file 364.5 to be included
 ;
 ;;^125^
 ;
 ;-----------------------------------------------------------------------
 ; 364.6 entries modified:
 ; 2228 - Remaining Liability Qualifier
 ; 2229 - Remaining Liability
 ;
ENT6 ; O.F. entries in file 364.6 to be included
 ;
 ;;^2228^2229^
 ;
 ;-----------------------------------------------------------------------
 ; 364.7 entries modified:
 ; 164 - OI1.8
 ; 957 - LCOB.4
 ; 1928 - LCOB.16 (Remaining Liability Qualifier)
 ; 1929 - LCOB.17 (Remaining Liability)
 ;
ENT7 ; O.F. entries in file 364.7 to be included
 ;
 ;;^164^957^1928^1929^
 ;
INC3508(Y) ; function to determine if entry in IB ERROR file (350.8) should be included in the build
 ; Y - ien to file
 N DATA,ENTRY,LN,OK,TAG
 S OK=0,ENTRY=U_$P($G(^IBE(350.8,Y,0)),U,3)_U
 F LN=2:1 S TAG="ENT3508+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,ENTRY) S OK=1 Q
 Q OK
 ;
ENT3508 ; entries in file 350.8 to be included
 ;
 ;;^IB350^IB351^
 ;;
 Q
