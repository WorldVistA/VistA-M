MAGDTR01 ;WOIFO/PMK - Unread List for Consult/Procedure Request ; 20 Sep 2006  9:04 AM
 ;;3.0;IMAGING;**46**;16-February-2007;;Build 1023
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
ENTRY ; entry point from ^MAGDHWC for a consult request
 N GMRCSTS ;-- GMRC request status
 N RESULT ;--- scratch variable
 ;
 ; check for an "OK" order control value in the ORC segment
 I $P(HL7ORC,DEL)="OK" D  Q  ; new order
 . D ADD^MAGDTR03(.RESULT,GMRCIEN,"O") ; add if "on order" is set
 . Q
 ;
 ; check for a discontinued order
 I " CA CR DC DR OC OD "[(" "_$P(HL7ORC,DEL)_" ") D  Q
 . D CANCEL^MAGDTR03 ; record the order as cancelled
 . Q
 ;
 ; check for a FORWARD in the ORC segment
 I $P($P(HL7ORC,DEL,16),DEL2,5)="FORWARD" D  Q
 . D FORWARD^MAGDTR02 ; handle forward for Unread List
 . Q
 ;
 ; drive it off the GMRC request status
 S GMRCSTS=$$GET1^DIQ(123,GMRCIEN,8)
 I (GMRCSTS="PENDING")!(GMRCSTS="ACTIVE") D  Q
 . D ADD^MAGDTR03(.RESULT,GMRCIEN,"O") ; add if "on order" is set
 . Q
 I GMRCSTS="COMPLETE" D  Q
 . D COMPLETE^MAGDTR03 ; tag study as completed
 . Q
 I (GMRCSTS="CANCELLED")!(GMRCSTS="DISCONTINUED") D  Q
 . D CANCEL^MAGDTR03 ; tag study as cancelled
 . Q
 Q
 ;
ORRIN ; entry point for processing IFC responses
 N MAGETLVL,$ET
 S $ET="D ORRINER1^"_$T(+0),MAGETLVL=$ST+1
 D ORRINPRC
 Q
 ;
ORRINER1 ; Log the error
 D ^%ZTER
 S $ET="D ORRINER2^"_$T(+0)
 I $ST>MAGETLVL Q:$Q "" Q
 S $EC=""
 Q
 ;
ORRINER2 ; Unwind
 I $ST>MAGETLVL Q:$Q "" Q
 S $EC=""
 Q
 ;
ORRINPRC ;
 ; this is "piggy-backed" onto the GMRC IFC ORM EVENT protocol
 ; see the RESPONSE PROCESSING ROUTINE for this protocol
 ; the HL7 event handler first invokes ORRIN^GMRCIMSG and then this
 ;
 N GMRCIEN ;-- IEN of consult
 N ORDCTRL ;-- order control code from ORC segment
 N UNREAD ;--- IEN of entry on ^MAG(2006.5849)
 N TIMESTMP ;- FileMan time stamp of unread item
 N LISTDATA ;- unread list info from ^MAG(2006.5849)
 N ACQSITE ;-- acquisition site
 N IPROCIDX ;- procedure index
 N ISPECIDX ;- specialty index
 ;
 D GETHL7A^MAGDTR01(.ORDCTRL,.GMRCIEN) Q:ORDCTRL'="OK"
 Q:'$$FINDLIST^MAGDTR01(GMRCIEN)  ; not in unread list
 S UNREAD=$$UNREAD^MAGDTR02(GMRCIEN) Q:'UNREAD   ; not there yet
 S TIMESTMP=$$TIMESTMP^MAGDTR02(UNREAD) ; update the timestamp
 S LISTDATA=^MAG(2006.5849,UNREAD,0)
 ; record time of IFC response
 S:$P(LISTDATA,"^",6)="" $P(^MAG(2006.5849,UNREAD,0),"^",6)=TIMESTMP
 ; now change status to "Unread", if it was a "Waiting" previously
 I $P(LISTDATA,"^",11)="W" D  ; switch status and update cross reference
 . S $P(^MAG(2006.5849,UNREAD,0),"^",11)="U"
 . S ACQSITE=$P(LISTDATA,"^",2),ISPECIDX=$P(LISTDATA,"^",3)
 . S IPROCIDX=$P(LISTDATA,"^",4)
 . K ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,"W",UNREAD)
 . S ^MAG(2006.5849,"D",ACQSITE,ISPECIDX,IPROCIDX,"U",UNREAD)=""
 . Q
 Q
 ;
GETHL7A(STATUS,GMRCIEN) ; get data from HL7 message - called from above
 ; input:  none
 ; output:  PERSON     name of person ordering the consult
 ;          LOCATION   IEN of the location from which the consult is ordered
 ;
 N HL7PARSE ;- name of parsed HL7 array defined by GETHL7
 N HL7RAW ;--- name of raw HL7 array defined by GETHL7
 N HL7SEGNO ;- segment number index returned by $$GETSEG^MAGDHRC0
 ;
 D GETHL7
 S (STATUS,GMRCIEN)=""
 S HL7SEGNO=$$GETSEG^MAGDHRC0("ORC")
 I HL7SEGNO D
 . S STATUS=$$GETDATA^MAGDHRC0(1)
 . S GMRCIEN=$$GETDATA^MAGDHRC0(2,1,1)
 . Q
 K @HL7PARSE
 Q
 ;
GETHL7B(PERSON,LOCATION) ; get data from HL7 message - call from ^MAGDTR03
 ; input:  none
 ; output:  PERSON     name of person ordering the consult
 ;          LOCATION   IEN of the location from which the consult is ordered
 ;
 N HL7PARSE ;- name of parsed HL7 array defined by GETHL7
 N HL7RAW ;--- name of raw HL7 array defined by GETHL7
 N HL7SEGNO ;- segment number index returned by $$GETSEG^MAGDHRC0
 N IPERSON ;-- field number in ORC segment that contains responsible/entered-by person
 ;
 D GETHL7
 K PERSON S LOCATION=""
 S HL7SEGNO=$$GETSEG^MAGDHRC0("ORC")
 ; get "responsible person" from ORC-12 or "entered by" person from ORC-10
 S IPERSON=$S($$GETDATA^MAGDHRC0(12)="":10,1:12)
 S PERSON("FAMILY")=$$GETDATA^MAGDHRC0(IPERSON,1,1)
 S PERSON("GIVEN")=$$GETDATA^MAGDHRC0(IPERSON,1,2)
 S PERSON("MIDDLE")=$$GETDATA^MAGDHRC0(IPERSON,1,3)
 S PERSON("SUFFIX")=$$GETDATA^MAGDHRC0(IPERSON,1,4)
 S PERSON=PERSON("FAMILY")
 I PERSON("GIVEN")'="" S PERSON=PERSON_","_PERSON("GIVEN")
 I PERSON("MIDDLE")'="" S PERSON=PERSON_" "_PERSON("MIDDLE")
 I PERSON("SUFFIX")'="" S PERSON=PERSON_" "_PERSON("SUFFIX")
 ; location of the consult is in OBX-5.3(?)
 S HL7SEGNO=$$GETSEG^MAGDHRC0("OBX")
 S:HL7SEGNO LOCATION=$$IEN^XUAF4($$GETDATA^MAGDHRC0(5,1,3))
 K @HL7PARSE
 Q
 ;
GETHL7 ; get data from HL7 message
 ; called from above and also called from ^MAGDTR03
 ;
 ; returns: HL7PARSE (name of parsed HL7 array)
 ;          HL7RAW   (name of array of unparsed HL7 segments)
 ;
 N HLNODE ;--- a full HL7 segment returned by X HLNEXT
 N I ;-------- scratch array index
 N X ;-------- dummy status return from $$PARSE^MAG7UP
 ;
 S HL7PARSE=$NAME(^TMP("MAG",$J,"HL7","PARSED"))
 S HL7RAW="HL7RAW"
 K @HL7PARSE ; initialize the destination global
 ; copy HL7 message from ^TMP to HL7RAW global array
 F I=1:1 X HLNEXT Q:HLQUIT'>0  S @HL7RAW@(I)=HLNODE
 S X=$$PARSE^MAG7UP(HL7RAW,HL7PARSE) ; build the parsed HL7 array
 Q
 ;
FINDLIST(GMRCIEN,ISPECIDX,IPROCIDX,ACQSITE,TRIGGER,TIUNOTE,ALTSERV) ;
 ; find the read/unread list for this consult
 N CONSPROC,PROC,TOSERV,X,XREF
 S (ISPECIDX,IPROCIDX,ACQSITE,TRIGGER,TIUNOTE)=""
 Q:'$G(GMRCIEN) 0
 S TOSERV=$G(ALTSERV) ; optional argument
 I TOSERV="" S TOSERV=+$$GET1^DIQ(123,GMRCIEN,1,"I")
 S CONSPROC=$$GET1^DIQ(123,GMRCIEN,13,"I")
 S PROC=$S(CONSPROC="C":"",1:$$GET1^DIQ(123,GMRCIEN,4,"I"))
 S XREF=$O(^MAG(2006.5841,"AC",TOSERV,+PROC,""))
 I 'XREF Q 0 ; no read/unread list
 S X=$G(^MAG(2006.5841,XREF,0))
 S ISPECIDX=$P(X,"^",3),IPROCIDX=$P(X,"^",4),ACQSITE=$P(X,"^",5)
 S TRIGGER=$P(X,"^",6),TIUNOTE=$P(X,"^",7)
 Q XREF
 ;
