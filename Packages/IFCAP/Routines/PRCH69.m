PRCH69 ;WISC/REW/Revises Vendor ID Nodes Per DBIA 1540 ; [9/25/98 3:54pm]
 ;;5.0;IFCAP;**69**;4/21/95
 ;
 K ^DD(440,0,"ID") S ^("ID","Z")="G START^PRCHID" ; change ID code
 ;
FIX ;Here is the start of correcting file 440.  The corrections are:
 ;   1. Remove all leading spaces from Vendor NAME
 ;   2. Leave only 2 stars (*) in front of INACTIVATED VENDOR NANE
 ;      field.
 ;   3. Remove any REPLACEMENT VENDOR that points to itself.
 ;   4. If a chain of REPLACEMENT VENDORs has one that points
 ;      to a previous entry in the chain, remove that REPLACEMENT
 ;      VENDOR.
 ;
 S LOOP=0  ;This is the place holder for the vendor being checked.
 F  S LOOP=$O(^PRC(440,LOOP))  Q:LOOP'>0  D
 .  ; Remove all stars (*) and leading spaces (' ').
 .  S (ONAME,NAME)=$P($G(^PRC(440,LOOP,0)),U,1)
 .  F  D  Q:'(X1C=32!(X1C=42))
 .  .  S X1=$E(NAME,1)
 .  .  S X1C=$A(X1)
 .  .  I X1C=32!(X1C=42) S NAME=$E(NAME,2,99)
 .  .  Q
 .  S $P(^PRC(440,LOOP,0),U,1)=NAME
 .  ;
 .  ; Now remove old name from "B" x-ref and replace it with new name
 .  ; without stars or leading spaces.
 .  ;
 .  S NNAME=NAME
 .  K ^PRC(440,"B",ONAME,LOOP)
 .  ;
 .  ; If there is nothing in NNAME, report that to the user and skip
 .  ; further processing on this record.
 .  ;
 .  I NNAME="" D  Q
 .  .  S MSG=" "
 .  .  D MES^XPDUTL(MSG)
 .  .  S MSG="After removing leading spaces and/or stars entry "_LOOP_" NAME field"
 .  .  D MES^XPDUTL(MSG)
 .  .  S MSG="has nothing left.  This record needs to be checked out."
 .  .  D MES^XPDUTL(MSG)
 .  .  S MSG=" "
 .  .  D MES^XPDUTL(MSG)
 .  .  Q
 .  ;
 .  S ^PRC(440,"B",NNAME,LOOP)=""
 .  ;
 .  ; Set up sub-loop to check INACTIVATED VENDOR chain.
 .  ;
 .  S CLOOP=LOOP
CLOOP .  S INACT=$P($G(^PRC(440,CLOOP,10)),U,5)
 .  I INACT="" K CHAIN Q
 .  ;
 .  ; Lets add stars to inactive vendor.
 .  ; Add inactive vendor to "B" cross reference with stars.
 .  ; Now the vendor name is in the "B" cross reference with and
 .  ; without leading stars.
 .  ;
 .  I CLOOP=LOOP D
 .  .  S NAME="**"_NAME
 .  .  S $P(^PRC(440,LOOP,0),U,1)=NAME
 .  .  S ^PRC(440,"B",NAME,LOOP)=""
 .  .  Q
 .  ;
 .  ;Now check the replacement vendor.
 .  ;
 .  S REPV=$P($G(^PRC(440,CLOOP,9)),U,1)
 .  I REPV="" K CHAIN Q
 .  I REPV=CLOOP D  Q
 .  .  K ^PRC(440,CLOOP,9)
 .  .  K CHAIN
 .  .  S MSG1(1)="Vendor "_CLOOP_" has its REPLACEMENT VENDOR pointing to itself."
 .  .  S MSG1(2)="The REPLACEMENT VENDOR has been removed from this vendor."
 .  .  D MES^XPDUTL(.MSG1)
 .  .  Q
 .  I $D(CHAIN(REPV))#10=1 D  Q
 .  .  K ^PRC(440,CLOOP,9)
 .  .  K CHAIN
 .  .  S MSG2(1)="Vendor "_CLOOP_" has its REPLACEMENT VENDOR pointing to"
 .  .  S MSG2(2)="a previous vendor in this chain.  The REPLACEMENT VENDOR"
 .  .  S MSG2(3)=REPV_", has been removed from this vendor."
 .  .  D MES^XPDUTL(.MSG2)
 .  .  Q
 .  S CHAIN(CLOOP)=""
 .  S CLOOP=REPV
 .  G CLOOP
 Q
