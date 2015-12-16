MAGT7SO ;WOIFO/MLH/PMK/JSL - telepathology - create HL7 message to DPS - segment build - ORC ; 3 Jan 2015 4:15 PM
 ;;3.0;IMAGING;**138,156**;Mar 19, 2002;Build 10;Jan 3, 2015
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
 Q
 ;
ORCSEG(SEGELTS,FILE,STATE,IENS,ACNUMB) ; FUNCTION - main entry point - create an ORC segment
 N I ; scratch loop index
 N X ; scratch return from extrinsic functions
 N ENTBY ; entered by name
 N ORDPVDRNO ; ordering provider number
 N MAGNAMLKUPELTS ; attribute array for new person name retrieval call to $$HLNAME^XLFNAME
 N ORDPVDRNAM ; ordering provider name
 N DIQRET ; return array from GETS^DIQ
 N ENTORG ; entering organization
 N FLDORCTRLCD S FLDORCTRLCD=1 ; order control code field
 N FLDPLORDNO S FLDPLORDNO=2 ; placer order number field
 N FLDORSTATUS S FLDORSTATUS=5 ; order status code field
 N FLDDTXACT S FLDDTXACT=9 ; date/time of transaction field
 N FLDENTBY S FLDENTBY=10 ; entered by field
 N FLDORDPVDR S FLDORDPVDR=12 ; ordering provider field
 N FLDCALBKPHN S FLDCALBKPHN=14 ; call back phone number field
 N FLDORCTRLRSN S FLDORCTRLRSN=16 ; order control code reason field
 N FLDENTORG S FLDENTORG=17 ; entering organization field
 N FLDORDFACNAM S FLDORDFACNAM=21 ; ordering facility name field
 N ORCTRL,ORSTATUS,ORREASON ; order control, status, and reason fields
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 K SEGELTS ; always refresh *segment* array (not message array) on entry
 ;
 D SET^HLOAPI(.SEGELTS,"ORC",0) ; segment type
 I STATE="NEW" S ORCTRL="NW",ORREASON="NEWORDR" ; "NW" = new order
 E  I STATE="EDIT" S ORCTRL="XO",ORSTATUS="IP",ORREASON="CHANGEORDR"
 E  I STATE="COMPLETED" S ORCTRL="SC",ORSTATUS="CM",ORREASON="INTCMPLT"
 E  I STATE="CANCELLED" S ORCTRL="CA",ORSTATUS="CA",ORREASON="CANCELLED"
 D
 . D  Q:ERRSTAT  ; ORC-1-order control code
 . . D SET^HLOAPI(.SEGELTS,ORCTRL,FLDORCTRLCD) ; IA #4716
 . . Q
 . D  Q:ERRSTAT  ; ORC-2-placer order number
 . . D SET^HLOAPI(.SEGELTS,ACNUMB,FLDPLORDNO) ; IA #4716
 . . Q
 . I $D(ORSTATUS) D  Q:ERRSTAT  ; ORC-5-order status code
 . . D SET^HLOAPI(.SEGELTS,ORSTATUS,FLDORSTATUS) ; IA #4716
 . . Q
 . D  Q:ERRSTAT  ; ORC-9-date/time of transaction
 . . D SETTS^HLOAPI4(.SEGELTS,$$NOW^XLFDT,FLDDTXACT) ; IA #4853
 . . Q
 . D  Q:ERRSTAT  ; ORC-10-entered by
 . . S ERRSTAT=$$NPNAME^MAG7UNM(.ENTBY,DUZ)
 . . D:'ERRSTAT
 . . . D SET^HLOAPI(.SEGELTS,DUZ,FLDENTBY,1) ; IA #4716
 . . . D SET^HLOAPI(.SEGELTS,$G(ENTBY("FAMILY")),FLDENTBY,2) ; IA #4716
 . . . D SET^HLOAPI(.SEGELTS,$G(ENTBY("GIVEN")),FLDENTBY,3) ; IA #4716
 . . . D SET^HLOAPI(.SEGELTS,$G(ENTBY("MIDDLE")),FLDENTBY,4) ; IA #4716
 . . . Q
 . . Q
 . D  Q:ERRSTAT  ; ORC-12-ordering provider
 . . S ORDPVDRNO=$$GET1^DIQ(FILE(0),IENS,.07,"I")
 . . I 'ORDPVDRNO D SET^HLOAPI(.SEGELTS,"""""",FLDORDPVDR,1) Q  ; no ordering provider
 . . S ERRSTAT=$$NPNAME^MAG7UNM(.ORDPVDRNAM,ORDPVDRNO)
 . . D:'ERRSTAT
 . . . D SET^HLOAPI(.SEGELTS,ORDPVDRNO,FLDORDPVDR,1) ; IA #4716 
 . . . D SET^HLOAPI(.SEGELTS,$G(ORDPVDRNAM("FAMILY")),FLDORDPVDR,2) ; IA #4716
 . . . D SET^HLOAPI(.SEGELTS,$G(ORDPVDRNAM("GIVEN")),FLDORDPVDR,3) ; IA #4716
 . . . D SET^HLOAPI(.SEGELTS,$G(ORDPVDRNAM("MIDDLE")),FLDORDPVDR,4) ; IA #4716
 . . . Q
 . . Q
 . D  Q:ERRSTAT  ; ORC-14-call back phone number
 . . S ERRSTAT=$$CALLBACK^MAGT7SO(.SEGELTS,ORDPVDRNO,FLDCALBKPHN)
 . . Q
 . I $D(ORREASON) D  Q:ERRSTAT  ; ORC-16-order control code reason>  <-- SUGGEST DROPPING
 . . D SET^HLOAPI(.SEGELTS,ORREASON,FLDORCTRLRSN)
 . . Q
 . D  Q:ERRSTAT  ; ORC-17-entering organization ; ICR # 10060
 . . K ERRMSG
 . . D GETS^DIQ(200,$G(DUZ)_",",29,"EI","DIQRET","ERRMSG")
 . . D:$G(ERRMSG)  ; error in GETS^DIQ call
 . . . S ERRSTAT="-21`FileMan error ("_$G(ERRMSG(1))_":"_$G(ERRMSG(1,"TEXT",1))_")"
 . . . Q
 . . D:'ERRSTAT
 . . . S ENTORG("ID")=$G(DIQRET(200,$G(DUZ)_",",29,"I"))
 . . . S ENTORG("TEXT")=$G(DIQRET(200,$G(DUZ)_",",29,"E"))
 . . . S ENTORG("SYSTEM")="VISTA49"
 . . . D SETCE^HLOAPI4(.SEGELTS,.ENTORG,FLDENTORG)
 . . . Q
 . . Q
 . D  Q:ERRSTAT  ; ORC-21-ordering facility name
 . . N LOCATION,NAME
 . . S LOCATION=$$KSP^XUPARAM("INST")
 . . S NAME=$$GET1^DIQ(4,LOCATION,.01)
 . . D SET^HLOAPI(.SEGELTS,NAME,FLDORDFACNAM,1) ; organization name - IA #4716
 . . D SET^HLOAPI(.SEGELTS,LOCATION,FLDORDFACNAM,3) ; organization identifier (DIVISION ien) - IA #4716
 . . D SET^HLOAPI(.SEGELTS,"FI",FLDORDFACNAM,7) ; abbreviation for facility id - IA #4716
 . . D SET^HLOAPI(.SEGELTS,$$STATNUMB^MAGDFCNV(),FLDORDFACNAM,10) ; organization identifier (Station Number) - IA #4716
 . . Q
 . Q
 Q ERRSTAT
 ;
CALLBACK(SEGELTS,ORDPVDRNO,FLDCALBKPHN) ; call back phone number (in both ORC and OBR segments)
 N CALBAKFON ; call back phone array
 N IREP
 ;
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 Q:'ORDPVDRNO ERRSTAT ; ignore situations where the ordering provider is unknown
 ;
 S ERRSTAT=$$NPFON^MAG7UFO("CALBAKFON",ORDPVDRNO)
 F IREP=1:1:8 D:$D(CALBAKFON(IREP))  ; allow up to 8 phone numbers
 . D SET^HLOAPI(.SEGELTS,CALBAKFON(IREP,2,1),FLDCALBKPHN,2,1,IREP) ; IA #4716
 . D SET^HLOAPI(.SEGELTS,CALBAKFON(IREP,3,1),FLDCALBKPHN,3,1,IREP) ; IA #4716
 . D SET^HLOAPI(.SEGELTS,CALBAKFON(IREP,1,1),FLDCALBKPHN,12,1,IREP) ; IA #4716
 . Q
 Q ERRSTAT
