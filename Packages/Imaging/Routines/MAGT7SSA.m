MAGT7SSA ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build - set up OBXs for each SPM ; 03 Jul 2013 4:08 PM
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
SPMANC(MSG,FILE,IENSX,LRSS,IX) ; FUNCTION - main entry point - create ancillary OBX segments
 N BLKTYPSTGSTR ; block type/stage string
 N BLKTYPSTG ; block type/stage
 N BLKTYPSTGIX ; block type/stage index
 N BLOCKDATA ; block information
 N BLOCKFILE ; Fileman file number for block
 N BLOCKNAME ; name of block
 N BLOCKSS2 ; ss2 in LABDATA for block
 N ERRSTAT S ERRSTAT=0 ; assume nothing to report
 S BLOCKNAME=""
 F  S BLOCKNAME=$O(FILE("SPECIMEN",BLOCKNAME)) Q:BLOCKNAME=""  D
 . S BLOCKFILE=FILE("SPECIMEN",BLOCKNAME) Q:'$D(@LABDATA@(BLOCKFILE))
 . S BLOCKSS2="" F  S BLOCKSS2=$O(@LABDATA@(BLOCKFILE,BLOCKSS2)) Q:BLOCKSS2=""  D
 . . I $P(BLOCKSS2,",",2,999)=IENSX S BLOCKDATA(BLOCKNAME,BLOCKSS2)=""
 . . Q
 . Q
 I '$D(BLOCKDATA) Q ERRSTAT ; no blocks found
 ;
 ; one or more block(s) were found
 D  ; make OBX segments, bail if a problem arises
 . D  Q:ERRSTAT  ;subspecialty
 . . S ERRSTAT=$$OBXSEG^MAGT7SX(.MSG,"SUBSPECIALTY","ST",FILE("NAME"))
 . . Q
 . D  Q:ERRSTAT  ;block type/stage
 . . S BLOCKNAME=""
 . . F  S BLOCKNAME=$O(BLOCKDATA(BLOCKNAME)) Q:BLOCKNAME=""  D
 . . . S BLOCKSS2=""
 . . . F  S BLOCKSS2=$O(BLOCKDATA(BLOCKNAME,BLOCKSS2)) Q:BLOCKSS2=""  D  Q:ERRSTAT
 . . . .  S ERRSTAT=$$BLOCK(.MSG,.FILE,LRSS,BLOCKNAME,BLOCKSS2)
 . . . . Q
 . . . Q
 . . Q 
 . Q
 Q ERRSTAT
 ;
BLOCK(MSG,FILE,LRSS,BLOCKNAME,BLOCKSS2) ; output the block information
 N BLOCKFILE ; Fileman file number for block
 N TIMESTAMP ; date/time for OBX segment
 N STAINFILE ; Fileman file number for stain
 N STAINNAME ; name of stain
 N STAINSS2 ; ss2 in LABDATA for stain
 N VALUE ; value of attribute in OBX segment
 N ERRSTAT S ERRSTAT=0 ; assume nothing to report
 ;
 S BLOCKFILE=FILE("SPECIMEN",BLOCKNAME)
 S STAINNAME=$O(FILE("SPECIMEN",BLOCKNAME,""))
 S STAINFILE=FILE("SPECIMEN",BLOCKNAME,STAINNAME)
 D  Q:ERRSTAT  ; block type/stage
 . S ERRSTAT=$$OBXSEG^MAGT7SX(.MSG,"BLOCK TYPE/STAGE","ST",BLOCKNAME) Q:ERRSTAT
 . S VALUE=$G(@LABDATA@(BLOCKFILE,BLOCKSS2,.01,"I")) ; block/stage id
 . S TIMESTAMP=$G(@LABDATA@(BLOCKFILE,BLOCKSS2,.02,"I")) ; date/time block prepared
 . S ERRSTAT=$$OBXSEG^MAGT7SX(.MSG,"BLOCK INDEX","ST",VALUE,TIMESTAMP)
 . S STAINSS2=""
 . F  S STAINSS2=$O(@LABDATA@(STAINFILE,STAINSS2)) Q:STAINSS2=""  D  Q:ERRSTAT
 . . I $P(STAINSS2,",",2,999)=BLOCKSS2 D  Q:ERRSTAT
 . . . S ERRSTAT=$$STAIN(.MSG,.FILE,LRSS,STAINFILE,STAINSS2)
 . . . Q
 . . Q
 . Q
 Q ERRSTAT
 ;
STAIN(MSG,FILE,LRSS,STAINFILE,STAINSS2) ; output the stain/procedure information
 N DATATYPE ; HL7 datatype for the OBX segment
 N FIELDNUMBER ; field in stain file
 N LABSECTION ; CY, EM, and/or SP
 N NAME ; name of attribute in OBX segment
 N PTRFLAG ; indicator for lab file #60 dictionary lookup
 N VALUE ; value of attribute in OBX segment
 N TIMESTAMP ; date/time for OBX segment - one of these three DTTM* values
 N DTTMSTNPREP ; date/time slides stained or sections prepared
 N DTTMEXAM ; date/time slides/sections examined
 N DTTMPRMADE ; date/time prints made
 N I,X
 N ERRSTAT S ERRSTAT=0 ; assume nothing to report
 ;
 S DTTMSTNPREP=$G(@LABDATA@(STAINFILE,STAINSS2,.04,"I")) ; date/time slides stained or sections prepared
 S DTTMEXAM=$G(@LABDATA@(STAINFILE,STAINSS2,.05,"I")) ; date/time slides/sections examined
 S DTTMPRMADE=$G(@LABDATA@(STAINFILE,STAINSS2,.11,"I")) ; date/time prints made
 F I=2:1 S X=$P($T(FIELDS+I),";;",2) Q:"end"[X  D  Q:ERRSTAT
 . S LABSECTION=$P(X,"^",3) I LABSECTION'[LRSS Q
 . S FIELDNUMBER=$P(X,"^",1),PTRFLAG=$P(X,"^",2)
 . S NAME=$P(X,"^",4),DATATYPE=$P(X,"^",5),TIMESTAMP=$P(X,"^",6)
 . S VALUE=$G(@LABDATA@(STAINFILE,STAINSS2,FIELDNUMBER,"I"))
 . I PTRFLAG="P",VALUE S VALUE=$$GET1^DIQ(60,VALUE,.01) ; get procedure
 . I VALUE="" Q  ; don't output null values 
 . S TIMESTAMP=$S(TIMESTAMP="S":DTTMSTNPREP,TIMESTAMP="P":DTTMSTNPREP,TIMESTAMP="E":DTTMEXAM)
 . S ERRSTAT=$$OBXSEG^MAGT7SX(.MSG,NAME,DATATYPE,VALUE,TIMESTAMP)
 . Q
 Q ERRSTAT
 ;
FIELDS ; fields to output
 ;;field #^pointer file^lab section^title^datatype^timestamp^comment
 ;;.01^P^CY/EM/SP^PROCEDURE DESCRIPTION^ST^S^stain/procedure
 ;;.02^^EM^SECTIONS PREPARED^NM^S
 ;;.02^^CY/SP^SLIDES PREPARED^NM^S
 ;;.03^^EM^CONTROL SECTIONS^NM^S
 ;;.03^^CY/SP^CONTROL SLIDES^NM^S
 ;;.06^^EM^SECTIONS COUNTED"^NM^E
 ;;.06^^CY/SP^SLIDES COUNTED"^NM^E
 ;;.07^^EM^NEW SECTIONS^NM^S
 ;;.07^^CY/SP^LABELS TO PRINTS^NM^S
 ;;.08^^CY^SLIDES SCREENED^NM^E
 ;;.08^^EM^SECTIONS EXAMINED^NM^E
 ;;.08^^SP^SLIDES EXAMINED^NM^E^free
 ;;.09^^CY/EM/SP^NON-CONTROL SLIDES COUNTED^NM^E
 ;;.1^^EM^PRINTS MADE^NM^P
 ;;.12^^EM^PRINTS COUNTED^NM^P
 ;;.13^^EM^EXAMINIATION SECTIONS COUNTED^NM^P
 ;;end
