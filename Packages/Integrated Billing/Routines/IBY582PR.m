IBY582PR ;EDE/TAZ - Pre-Installation for IB patch 582 ;
 ;;2.0;INTEGRATED BILLING;**582**;21-MAR-94;Build 77
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
INC200(Y) ; function to determine if entry in NEW PERSON FILE (200) should be included in the build
 ; Y - ien to file
 N DATA,ENTRY,LN,OK,TAG
 S OK=0,ENTRY=U_$P($G(^VA(200,Y,0)),U,1)_U
 F LN=2:1 S TAG="ENT200+"_LN,DATA=$P($T(@TAG),";;",2) Q:DATA=""  I $F(DATA,ENTRY) S OK=1 Q
 Q OK
 ;
ENT200 ;Entries in VA(200) to be included.
 ;
 ;;^INTERFACE,IB EIV^
 ;
 ;-----------------------------------------------------------------------
