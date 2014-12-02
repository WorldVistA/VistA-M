MAGVUID ;WOIFO/RRB,NST - MAGV Duplicate UID Utilities and RPCs ; 26 Jun 2013 5:30 PM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ;
STUDY(RESULT,DFN,ACNUMB,SITE,INSTR,STUDYUID)  ; RPC - MAGV STUDY UID CHECK
 ;
 N NEWUID,TYPE,UID
 S TYPE="STUDY"
 ;
 ; Check length of incoming UID and reject with fatal error message if >96 characters.
 ; 
 I $L(STUDYUID)>96 S RESULT="-1~Fatal UID > 96 Characters" Q
 ;
 ; Check IMAGING DUPLICATE UID LOG (#2005.66) to determine if the Study UID has been replaced.  
 ; If it has return the replacement UID and quit.  Otherwise, continue with UID checking.
 ;
 S UID=$$UIDLOOK^MAGVRS61(STUDYUID,DFN,ACNUMB,TYPE,STUDYUID)
 I UID'=0 S RESULT="1~LogUIDToUse~"_UID Q
 ;
 ;
 ; Check and replace illegal Study UID
 ; 
 I $L(STUDYUID)>64 D  Q RESULT ; Replace UID having Illegal Length
 . S RESULT="3~Illegal UID Replacement~"
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,STUDYUID,TYPE)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_NEWUID)
 . Q
 ;
 S RESULT=$$UIDCHECK(STUDYUID,TYPE)  ; Check for illegal UID format and characters
 ;
 I RESULT=1 D  Q RESULT ; Replace UID having Illegal format or characters
 . S RESULT="3~Illegal UID Replacement~"
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,STUDYUID,TYPE)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_NEWUID)
 ;
 I RESULT'=0 Q
 ;
 ; Proceed with checking Study UID
 ;
 S RESULT=$$STUDY^MAGVGUID(DFN,ACNUMB,STUDYUID)  ; Check Study UID in ^MAG(2005)
 ;
 I RESULT=1 D  Q  ; Create New Study UID and Quit if duplicate is found in #2005
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,STUDYUID,TYPE)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_"~NewUIDToUse~"_NEWUID)
 . Q
 ;
 S RESULT=$$DUPSTUD^MAGVRS61(DFN,ACNUMB,STUDYUID)  ; Check Study UID in ^MAGV(2005.62)
 ;
 I RESULT=1 D  ; Create New Study UID if duplicate is found in #2005.62
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,STUDYUID,TYPE)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_"~NewUIDToUse~"_NEWUID)
 . Q
 ;
 Q
 ;
SERIES(RESULT,DFN,ACNUMB,SITE,INSTR,STUDYUID,SERIESUID)  ; RPC - MAGV SERIES UID CHECK
 ;
 N NEWUID,TYPE,UID
 S TYPE="SERIES"
 ;
 ; Check length of incoming UID and reject with fatal error message if >96 characters.
 ; 
 I $L(SERIESUID)>96 S RESULT="-1~Fatal UID > 96 Characters" Q
 ;
 ; Check IMAGING DUPLICATE UID LOG (#2005.66) to determine if the Series UID has been replaced.  
 ; If it has return the replacement UID and quit.  Otherwise, continue with UID checking.
 ;
 S UID=$$UIDLOOK^MAGVRS61(SERIESUID,DFN,ACNUMB,TYPE,STUDYUID)
 I UID'=0 S RESULT="1~LogUIDToUse~"_UID Q
 ;
 ; Check and replace illegal Series UID
 ; 
 I $L(SERIESUID)>64 D  Q RESULT ; Replace UID having Illegal Length
 . S RESULT="3~Illegal UID Replacement~"
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,SERIESUID,TYPE,STUDYUID)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_NEWUID)
 . Q
 ;
 S RESULT=$$UIDCHECK(SERIESUID,TYPE)  ; Check for illegal UID format and characters
 ;
 I RESULT=1 D  Q RESULT ; Replace UID having Illegal format or characters
 . S RESULT="3~Illegal UID Replacement~"
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,SERIESUID,TYPE,STUDYUID)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_NEWUID)
 ;
 I RESULT'=0 Q
 ;
 ; Proceed with checking Series UID
 ; 
 S RESULT=$$SERIES^MAGVGUID(DFN,ACNUMB,STUDYUID,SERIESUID)  ; Check Series UID in ^MAG(2005)
 ;
 I RESULT=1 D  Q  ; Create New Series UID and Quit if duplicate is found in #2005
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,SERIESUID,TYPE,STUDYUID)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_"~NewUIDToUse~"_NEWUID)
 . Q
 ;
 S RESULT=$$DUPSER^MAGVRS61(DFN,ACNUMB,STUDYUID,SERIESUID)  ; Check Series UID in ^MAGV(2005.63)
 ;
 I RESULT=1 D  ; Create New Series UID if duplicate is found in #2005.63
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,SERIESUID,TYPE,STUDYUID)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_"~NewUIDToUse~"_NEWUID)
 . Q
 ;
 Q
 ;
SOP(RESULT,DFN,ACNUMB,SITE,INSTR,STUDYUID,SERIESUID,SOPUID)  ; RPC - MAGV SOP UID CHECK
 ;
 N NEWUID,TYPE,UID
 S TYPE="SOP"
 ;
 ; Check length of incoming UID and reject with fatal error message if >96 characters.
 ; 
 I $L(SOPUID)>96 S RESULT="-1~Fatal UID > 96 Characters" Q
 ;
 ;
 ; Check IMAGING DUPLICATE UID LOG (#2005.66) to determine if the Series UID has been replaced.  
 ; If it has return the replacement UID and quit.  Otherwise, continue with UID checking.
 ;
 S UID=$$UIDLOOK^MAGVRS61(SOPUID,DFN,ACNUMB,TYPE,STUDYUID,SERIESUID)
 I UID'=0 S RESULT="2~RERUNLog~" Q
 ;
 ; Check and replace illegal SOP UID
 ; 
 I $L(SOPUID)>64 D  Q RESULT ; Replace UID having Illegal Length
 . S RESULT="3~Illegal UID Replacement~"
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,SOPUID,TYPE,STUDYUID,SERIESUID)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_NEWUID)
 . Q
 ;
 S RESULT=$$UIDCHECK(SOPUID,TYPE)  ; Check for illegal UID format and characters
 ;
 I RESULT=1 D  Q RESULT ; Replace UID having Illegal format or characters
 . S RESULT="3~Illegal UID Replacement~"
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,SOPUID,TYPE,STUDYUID,SERIESUID)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_NEWUID)
 ;
 I RESULT'=0 Q
 ;
 ; Proceed with checking SOP UID
 ; 
 S RESULT=$$SOP^MAGVGUID(DFN,ACNUMB,STUDYUID,SERIESUID,SOPUID)  ; Check SOP UID in ^MAG(2005)
 ;
 I RESULT=1 D  Q  ; Create New SOP UID and Quit if duplicate is found in #2005
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,SOPUID,TYPE,STUDYUID,SERIESUID)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_"~NewUIDToUse~"_NEWUID)
 . Q
 ;
 I RESULT=2 S RESULT=RESULT_"~RERUN" Q  ; Quit with RERUN message if on file and not duplicate UID
 ;
 S RESULT=$$DUPSOP^MAGVRS61(DFN,ACNUMB,STUDYUID,SERIESUID,SOPUID)  ; Check Series UID in ^MAGV(2005.64)
 ;
 I RESULT=1 D  ; Create New SOP UID if duplicate is found in #2005.64
 . S NEWUID=$$NEWUID(DFN,ACNUMB,SITE,INSTR,SOPUID,TYPE,STUDYUID,SERIESUID)
 . S RESULT=$S(+NEWUID=-1:NEWUID,1:RESULT_"~NewUIDToUse~"_NEWUID)
 . Q
 ;
 I RESULT=2 S RESULT=RESULT_"~RERUN"  ; Return RERUN message if on file and not duplicate UId
 ;
 Q
 ;
UIDCHECK(UIDCHK,TYPE)  ; Check UID for invalid UIDs
 ;
 N I,X
 S RESULT=0
 ;
 ; Check for Illegal Characters
 ; 
 F I=1:1:$L(UIDCHK,".") S X=$P(UIDCHK,".",I) D  I RESULT'=0 Q 
 . I $L(X)>1,$E(X,1)=0 S RESULT=1 Q
 . I X'?1.N S RESULT=1 Q
 . Q
 ;
 Q RESULT
 ;
NEWUID(DFN,ACNUMB,SITE,INSTR,OUID,TYPE,STUDYUID,SERIESUID)  ; Utility to Generate new UID for TYPE
 ;
 Q:SITE="" "-1~Invalid Site Number"
 ;
 N UID
 ;
 S STUDYUID=$G(STUDYUID),SERIESUID=$G(SERIESUID)
 ;
 S UID=$$GENUID^MAGVUID2(ACNUMB,SITE,INSTR,TYPE)  ; Generate a new UID
 ;
 ; Log duplicate UID error
 ; 
 ;
 D LOGDUP^MAGVRS61(OUID,.UID,ACNUMB,DFN,TYPE,STUDYUID,SERIESUID)  ; Log duplicate UID and adjust new UID to be unique if already logged
 ;
 Q UID  ; Return new UID to use
 ;
