IBCNRXI1 ;BHAM ISC/DMK - Post-Installation procedure ;25-AUG-2004
 ;;2.0;INTEGRATED BILLING;**276**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Description:
 ; This is a part of the IB*2.0*276 post-installation procedure.
 ; Its purpose is to review all PLAN file entries.
 ; If PLAN APPLICATION sub-file, LOCAL ACTIVE? = 1 (active)
 ; and USER EDITED LOCAL = "dummy" HL7 interface user, then
 ; reinitialize LOCAL ACTIVE = 0.
 ; Initial requirements called for initialization to 1, but this
 ; has changed.
 ;
 ; Applicable files, sub-files, and fields:
 ; 366.033 = PLAN APPLICATION sub-file
 ;    .03  = LOCAL ACTIVE?
 ;    .04  = USER EDITED LOCAL
 ;    .05  = DATE/TIME LOCAL EDITED
 ;
1000 ; Control
 ;
 ; Call IBCNRXI2 to fix the USER EDITED LOCAL user
 D EN^IBCNRXI2
 ;
 ; Compile List of plans that are being used
 K ^TMP("IBCNRXI1",$J)
 D COMPILE
 ;
 ; Initialization
 N DATE,HL7DUZ,IEN,S
 ; 
 D INIT
 I HL7DUZ="" Q
 ;
 D GET1
 K ^TMP("IBCNRXI1",$J)
 Q
 ;
GET1 ; Get PLAN file (#366.03) IEN
 S IEN(366.03)=0 F  S IEN(366.03)=$O(^IBCNR(366.03,IEN(366.03))) Q:'IEN(366.03)  D GET2
 Q
 ;
GET2 ; Get PLAN APPLICATION sub-file (# 366.033) IEN
 S IEN(366.033)=0 F  S IEN(366.033)=$O(^IBCNR(366.03,IEN(366.03),3,IEN(366.033))) Q:'IEN(366.033)  D GET3
 Q
 ;
GET3 ; Check PLAN APPLICATION sub-file fields
 S S=$G(^IBCNR(366.03,IEN(366.03),3,IEN(366.033),0))
 I $P(S,U,3)=1,$P(S,U,4)=HL7DUZ,'$D(^TMP("IBCNRXI1",$J,IEN(366.03))) D FIX
 Q
 ;
INIT ; Initialize local variables
 I '$D(U) S U="^"
 S HL7DUZ=$$FIND1^DIC(200,"","X","INTERFACE,IB IIV") Q:'HL7DUZ
 S DATE("NOW")=$$NOW^XLFDT()
 Q
 ;
FIX ; Reinitialize (fix) PLAN APPLICATION sub-file fields
 S $P(S,U,3)=0
 S $P(S,U,5)=DATE("NOW")
 S ^IBCNR(366.03,IEN(366.03),3,IEN(366.033),0)=S
 Q
 ;
COMPILE ; Build list of plans that are in use
 N IEN02,GRP,PL
 S IEN02=0  F  S IEN02=$O(^BPSC(IEN02)) Q:+IEN02=0  D
 . S GRP=$P($G(^BPSC(IEN02,1)),"^",4)
 . I GRP="" Q
 . S PL=$P($G(^IBA(355.3,GRP,6)),"^",1)
 . I PL="" Q
 . S ^TMP("IBCNRXI1",$J,PL)=""
 Q
