MAGT7SS ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build - SPM ; 17 Jul 2013 12:07 PM
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
SPMSEG(SEGELTS,FILE,IENS,IENSX,ACNUMB,IX) ; FUNCTION - main entry point - create an SPM segment
 N SPCID ; specimen ID = accession number + specimen number (IX)
 N SPCDESC ; specimen description
 N SPCTYPEE,SPCTYPEI ; specimen type - topography
 N TIMESTAMP ; date/time for specimen collection/received events
 N FLDSETID S FLDSETID=1 ; set ID field number in SPM segment
 N FLDSPCID S FLDSPCID=2 ; specimen ID field number
 N FLDSPTYPE S FLDSPTYPE=4 ; specimen type
 N FLDSPCDESC S FLDSPCDESC=14 ; specimen description
 N FLDSPCCLTDT S FLDSPCCLTDT=17 ; specimen collection date/time
 N FLDSPCRCVDT S FLDSPCRCVDT=18 ; specimen received date/time
 N FLDSPCCOUNT S FLDSPCCOUNT=26 ; number of specimen containers
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 K SEGELTS ; always refresh *segment* array (not message array) on entry
 ;
 D SET^HLOAPI(.SEGELTS,"SPM",0) ; segment type
 D  ; set up fields, check exit flag after each
 . D  Q:ERRSTAT  ; SPM-1-set ID
 . . S SETID=$G(SETID("SPM"))+1,SETID("SPM")=SETID
 . . D SET^HLOAPI(.SEGELTS,SETID,FLDSETID)
 . . Q
 . D  Q:ERRSTAT  ; SPM-2-specimen ID
 . . N UID
 . . S SPCID=ACNUMB_" "_IX
 . . S UID=$$UID^MAGT7SI(DFN,ACNUMB,"SPECIMEN",IX)
 . . D SET^HLOAPI(.SEGELTS,SPCID,FLDSPCID,1) ; subcomponent #1 - entity identifier
 . . D SET^HLOAPI(.SEGELTS,$S($$ISIHS^MAGSPID():"USIHS",1:"USVHA"),FLDSPCID,2) ; subcomponent #2 - namespace id
 . . D SET^HLOAPI(.SEGELTS,UID,FLDSPCID,3) ; subcomponent #3 - UID
 . . Q
 . D  Q:ERRSTAT  ; SPM-4-specimen type
 . . S SPCTYPEI=$G(@LABDATA@(FILE("SPECIMEN"),IENSX,.06,"I"))
 . . S SPCTYPEE="" I SPCTYPEI S SPCTYPEE=$$GET1^DIQ(61,SPCTYPEI,.01)
 . . D SET^HLOAPI(.SEGELTS,SPCTYPEI,FLDSPTYPE,1) ; subcomponent #1 - identifier
 . . D SET^HLOAPI(.SEGELTS,SPCTYPEE,FLDSPTYPE,2) ; subcomponent #2 - text
 . . D SET^HLOAPI(.SEGELTS,"VISTA61",FLDSPTYPE,3) ; subcomponent #3 - name of coding system
 . . Q
 . D  Q:ERRSTAT  ; SPM-14-specimen description
 . . S SPCDESC=$G(@LABDATA@(FILE("SPECIMEN"),IENSX,.01,"I"))
 . . D:SPCDESC'="" SET^HLOAPI(.SEGELTS,SPCDESC,FLDSPCDESC)
 . . Q
 . D  Q:ERRSTAT  ; SPM-17-specimen collection date/time
 . . S TIMESTAMP=$G(@LABDATA@(FILE(0),IENS,.01,"I"))
 . . D:TIMESTAMP SETTS^HLOAPI4(.SEGELTS,TIMESTAMP,FLDSPCCLTDT)
 . . Q
 . D  Q:ERRSTAT  ; SPM-18-specimen received date/time of transaction
 . . S TIMESTAMP=$G(@LABDATA@(FILE(0),IENS,.1,"I"))
 . . D:TIMESTAMP SETTS^HLOAPI4(.SEGELTS,TIMESTAMP,FLDSPCRCVDT)
 . . Q
 . D  Q:ERRSTAT  ; SPM-26-Number of specimen containers
 . . N COUNT
 . . S COUNT=$$COUNT^MAGT7SS(.FILE,IENSX)
 . . D SET^HLOAPI(.SEGELTS,COUNT,FLDSPCCOUNT)
 . . Q
 . Q
 Q ERRSTAT
 ;
COUNT(FILE,IENSX) ; return the number of specimen containers (slides or sections)
 N BLOCKNAME ; name of block in LAB DATA file (#63)
 N COUNT ; count of number of specimen containers
 N STAINFILE ; Fileman file number for stain
 N STAINNAME ; name of stain
 N STAINSS2 ; ss2 in LABDATA for stain
 ;
 ; count the number of slides/sections prepared for each block for each stain
 ;
 S COUNT=0
 S BLOCKNAME=""
 F  S BLOCKNAME=$O(FILE("SPECIMEN",BLOCKNAME)) Q:BLOCKNAME=""  D
 . S STAINNAME=""
 . F  S STAINNAME=$O(FILE("SPECIMEN",BLOCKNAME,STAINNAME)) Q:STAINNAME=""  D
 . . S STAINFILE=FILE("SPECIMEN",BLOCKNAME,STAINNAME)
 . . S STAINSS2=""
 . . F  S STAINSS2=$O(@LABDATA@(STAINFILE,STAINSS2)) Q:STAINSS2=""  D
 . . . I $P(STAINSS2,",",3,999)=IENSX D  ; got this specimen
 . . . . S COUNT=COUNT+$G(@LABDATA@(STAINFILE,STAINSS2,.02,"I"))
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q COUNT
