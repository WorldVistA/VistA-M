MAGT7SB ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build - OBR ; 24 Jul 2013 8:23 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
OBRSEG(SEGELTS,FILE,LRSS,IENS,ACNUMB) ; FUNCTION - main entry point - create an OBR segment
 N LABTEST ; name of lab test
 N SETID S SETID=1 ; set ID value for OBR segment
 N FLDSETID S FLDSETID=1 ; set ID field number
 N FLDPLORDNO S FLDPLORDNO=2 ; placer order number field number
 N FLDUNIVSVCID S FLDUNIVSVCID=4 ; universal service ID field number
 N FLDCOLLECTOR S FLDCOLLECTOR=10 ; name of person who collected the specimen
 N FLDORDPVDR S FLDORDPVDR=16 ; ordering provider field number
 N FLDCALBKPHN S FLDCALBKPHN=17 ; call back phone number field number
 N FLDDXSERVID S FLDDXSERVID=24 ; diagnostic service section id
 N ORDPVDRNO ; ordering provider number
 N ORDPVDRNAM ; ordering provider name
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 K SEGELTS ; always refresh *segment* array (not message array) on entry
 ;
 D SET^HLOAPI(.SEGELTS,"OBR",0) ; segment type
 D  ; set up fields, check exit flag after each
 . D  Q:ERRSTAT  ; OBR-1-set ID
 . . D SET^HLOAPI(.SEGELTS,SETID,FLDSETID)
 . . Q
 . D  Q:ERRSTAT  ; OBR-2-placer order number
 . . D SET^HLOAPI(.SEGELTS,ACNUMB,FLDPLORDNO)
 . . Q
 . D  Q:ERRSTAT  ; OBR-4-universal service ID
 . . D TESTLKUP(LABDATA,.LABTEST)
 . . S LABTEST("SYSTEM")="VISTA60"
 . . D SETCE^HLOAPI4(.SEGELTS,.LABTEST,FLDUNIVSVCID)
 . . Q
 . D  Q:ERRSTAT  ; OBR-10-collector ID
 . . N COLLECTOR ; person who collected the specimen
 . . ; the data type of this field is XCN (extended composite name)
 . . ; unfortunately, the lab package only records it as free text,
 . . ; so it is output in sequence 2 as "Family Name"
 . . S COLLECTOR=$G(@LABDATA@(FILE("0"),IENS,.011,"I"))
 . . D SET^HLOAPI(.SEGELTS,COLLECTOR,FLDCOLLECTOR,2)
 . . Q
 . D  Q:ERRSTAT  ; OBR-16-ordering provider
 . . S ORDPVDRNO=$$GET1^DIQ(FILE(0),IENS,.07,"I")
 . . I 'ORDPVDRNO D SET^HLOAPI(.SEGELTS,"""""",FLDORDPVDR,1) Q  ; no ordering provider
 . . S ERRSTAT=$$NPNAME^MAG7UNM(.ORDPVDRNAM,ORDPVDRNO)
 . . D:'ERRSTAT
 . . . D SET^HLOAPI(.SEGELTS,ORDPVDRNO,FLDORDPVDR,1)
 . . . D SET^HLOAPI(.SEGELTS,$G(ORDPVDRNAM("FAMILY"),""),FLDORDPVDR,2)
 . . . D SET^HLOAPI(.SEGELTS,$G(ORDPVDRNAM("GIVEN"),""),FLDORDPVDR,3)
 . . . D SET^HLOAPI(.SEGELTS,$G(ORDPVDRNAM("MIDDLE"),""),FLDORDPVDR,4)
 . . . Q
 . . Q
 . D  Q:ERRSTAT  ; OBR-17-call back phone number
 . . S ERRSTAT=$$CALLBACK^MAGT7SO(.SEGELTS,ORDPVDRNO,FLDCALBKPHN)
 . . Q
 . D  Q:ERRSTAT  ; OBR-24-diagnostic service section id
 . . N ID
 . . S ID=$P(ACNUMB," ",1) ; VA lab service from file #62.2
 . . ; Note that for cytology (cytopathology) the abbreviation should be CP and not CY
 . . ; We are ignoring that difference because it makes it more complicated for the worklist
 . . ; S ID=$S(ID="CY":"CP",1:ID) ; see HL7 2.5.1 Ch 4 section 4.5.3.24
 . . D SET^HLOAPI(.SEGELTS,ID,FLDDXSERVID)
 . . Q
 . Q
 ;
 Q ERRSTAT
 ;
TESTLKUP(LABDATA,LABTEST) ; lookup the test - called by MAGVIM02 as well
 N IENS
 S IENS=$O(@LABDATA@(FILE("ORDERED TEST"),""))
 I IENS'="" D
 . S LABTEST=$G(@LABDATA@(FILE("ORDERED TEST"),IENS,13,"I"))
 . I LABTEST D
 . . S LABTEST("ID")=LABTEST
 . . S LABTEST("TEXT")=$$GET1^DIQ(60,LABTEST,.01,"E")
 . . Q
 . Q
 I '$D(LABTEST("ID")) D  ; use default test
 . S LABTEST("ID")=FILE("PROCEDURE IEN")
 . S LABTEST("TEXT")=FILE("PROCEDURE NAME")
 . Q
 Q
