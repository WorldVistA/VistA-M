IBCNRXI2 ;BHAM ISC/DMB - Post-Installation procedure ;30-SEP-2005
 ;;2.0;INTEGRATED BILLING;**276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description:
 ; This is a part of the IB*2.0*276 post-installation procedure.
 ; Its purpose is to review all PLAN file entries.
 ; If PLAN APPLICATION sub-file, LOCAL ACTIVE? = 1 (active)
 ;    ,USER EDITED LOCAL = 61230, and DATE/TIME LOCAL EDITTED is before
 ;    5/28/2004, then change the USER EDITED LOCAL to 'INTERFACE,IB IIV'.
 ;
 ; The reason for this is that the Plans were sent out as part of the
 ;    dormant build with the USER EDITED LOCAL = 62130, which was the  
 ;    IEN for 'INTERFACE,IB IIV' from the source environment, but this 
 ;    IEN was updated by the build to be the IEN for this user at the
 ;    destination sites.
 ;
 ; Applicable files, sub-files, and fields:
 ; 366.033 = PLAN APPLICATION sub-file
 ;    .03  = LOCAL ACTIVE? (piece 3)
 ;    .04  = USER EDITED LOCAL (piece 4)
 ;    .05  = DATE/TIME LOCAL EDITED (piece 5)
 ;
 Q
EN ;
 ; Initialize local variables
 N HL7DUZ,IEN1,IEN2,X
 I '$D(U) S U="^"
 S HL7DUZ=$$FIND1^DIC(200,"","X","INTERFACE,IB IIV")
 I HL7DUZ="" Q
 ;
 ; Get PLAN file (#366.03) IEN
 S IEN1=0 F  S IEN1=$O(^IBCNR(366.03,IEN1)) Q:+IEN1=0  D
 . ;
 . ; Get PLAN APPLICATION sub-file (# 366.033) IEN
 . S IEN2=0 F  S IEN2=$O(^IBCNR(366.03,IEN1,3,IEN2)) Q:+IEN2=0  D
 .. ;
 .. ; Check PLAN APPLICATION sub-file fields
 .. ; Local Active flag needs to be Active (1)
 .. ; User needs to be set to 61230
 .. ; Date needs to be before 6/28/2004 (dormant release date)
 .. S X=$G(^IBCNR(366.03,IEN1,3,IEN2,0))
 .. I $P(X,U,3)'=1 Q
 .. I $P(X,U,4)'=62130 Q
 .. I $P(X,U,5)>3040628 Q
 .. S $P(^IBCNR(366.03,IEN1,3,IEN2,0),"^",4)=HL7DUZ
 Q
