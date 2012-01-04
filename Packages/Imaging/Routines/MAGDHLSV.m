MAGDHLSV ;WOIFO/MLH - IHE-based ADT interface for PACS - PV1 segment ; 13 Aug 2009 9:15 AM
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
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
PV1 ; GOTO entry point from MAGDHLS - patient visit - NOT FOR DIRECT ENTRY
 ; input:  XDFN      internal entry number of the patient on global ^DPT/^RADPT
 ;         XEVN      event type of this message
 ;         XEVNDT    event date/time (FileMan format)
 ;         XYMSG     name of array to which to add message elts
 ; output: @XYMSG    input array plus new subtree containing PV1 elts
 ;         function return   0 (success) always
 ;
 N SEGIX ; ----- segment index on array @XYMSG
 N MAGNME ; ---- array for HL7-formatted name lookup info
 N I ; --------- loop index for $Piece calls
 N BDT ; ----- beginning date for call to EN1^RAO7PC1
 N EDT ; ----- ending date for call to EN1^RAO7PC1
 N EXN ; ----- max # of exams for call to EN1^RAO7PC1
 N DTCS ; ---- date/case index from RAO7PC1 lookup
 N RVDT ; ---- reverse date time entry on global ^RADPT
 N CSIX ; ---- case number index under RVDT on global ^RADPT
 N VAIP ; ---- patient data array from call to IN5^VADPT
 N RAXSET ; -- exam set data from ^RADPT
 N RAXWRD ; -- exam ward (entry in File 42)
 N RASCIX ; -- ward location service/section index (entry in File 44)
 N RASVC ; --- service/section name from File 44
 N RAORIX ; -- order index on ^RAO(75.1)
 N RAORDR ; -- order data from ^RAO(75.1)
 N ERPTSS ; -- element repetition subscript
 N RAXPRT ; -- transport mode from RAORDR
 N VAIN ; ---- inpatient data array from call to INP^VADPT
 N RESULT ; -- return array from entry point PTSEG^DGSEC4
 N VISNO ; --- visit number
 ;
 ; set up the PV1 segment
 S SEGIX=$O(@XYMSG@(" "),-1)+1 ; segment index
 S @XYMSG@(SEGIX,0)="PV1"
 I '$D(XDFN) S @XYMSG@(SEGIX,2,1,1,1)="N" Q 0 ; no DFN, can't get IP/OP info
 S DFN=XDFN D IN5^VADPT ; supported PIMS call - get IP info if any into VAIP()
 D @$S($G(VAIP(13)):"IN",1:"OUT") ;inpatient/outpatient
 D  ; insert admit date/time from current status date @ 0000H
 . N VAINDT ; -- date/time of status
 . S VAINDT=XEVNDT\1 D INP^VADPT ; inpt info into VAIN()
 . S:VAIN(7) @XYMSG@(SEGIX,44,1,1,1)=$$FMTHL7^XLFDT($P(VAIN(7),"^",1))
 . Q
 ; IA #3646:  employee flag
 S:$$EMPL^DGSEC4(XDFN)=1 @XYMSG@(SEGIX,16,1,1,1)="E"
 ; IA #767:  sensitive flag
 S:$P($G(^DGSL(38.1,XDFN,0)),"^",2)=1 @XYMSG@(SEGIX,16,1,1,1)=$G(@XYMSG@(SEGIX,16,1,1,1))_"S"
 ; insert visit number <- admission number (IP) or date (OP)
 S VISNO=$S($G(VAIN(1))'="":"I"_VAIN(1),1:"O"_($$HTFM^XLFDT($H,1)+17000000))
 S @XYMSG@(SEGIX,19,1,1,1)=VISNO
 S:XEVN="A11" @XYMSG@(SEGIX,2,1,1,1)="N" ; cancel an admit - IP/OP doesn't apply in PV1-2
 Q 0
 ;
IN ; SUBROUTINE - patient is now an inpatient
 ;
 N ROOMBED ; --- patient's room and bed
 N ATTPHYIX ; -- patient's attending physician index on NEW PERSON (#200)
 N ATTPHY ; ---- patient's attending physician information
 N ADMPHYIX ; -- patient's admitting physician index on NEW PERSON
 N ADMPHY ; ---- patient's admitting physician information
 N RADSVCIX ; -- patient's service/section associated with Rad order - index
 N SVC ; ------- service/section name
 N TMP ; ------- scratch variable
 N WARDREC ; --- ward record from VAIP(5)
 N WARDIX ; ---- ward index on WARD LOCATION File (#44)
 N WARDNAM ; --- name of ward
 ;
 ; fetch information
 S ROOMBED=$P($G(VAIP(6)),U,2) ; patient's room and bed
 S ATTPHYIX=+$G(VAIP(18)),ATTPHY="" ; attending physician
 I ATTPHYIX D
 . S MAGNME("FILE")=200,MAGNME("IENS")=ATTPHYIX,MAGNME("FIELD")=.01
 . S ATTPHY=ATTPHYIX_U_$$HLNAME^XLFNAME(.MAGNME,"S",U)
 . Q
 S ADMPHYIX=+$G(VAIP(13,5)),ADMPHY="" ; admitting physician
 I ADMPHYIX D
 . S MAGNME("FILE")=200,MAGNME("IENS")=ADMPHYIX,MAGNME("FIELD")=.01
 . S ADMPHY=ADMPHYIX_U_$$HLNAME^XLFNAME(.MAGNME,"S",U)
 . Q
 ; populate message array
 S @XYMSG@(SEGIX,2,1,1,1)="I" ; patient class
 S WARDREC=$G(VAIP(5)),WARDIX=$P(WARDREC,U,1),WARDNAM=$P(WARDREC,U,2)
 S @XYMSG@(SEGIX,3,1,1,1)=WARDNAM ; patient location - ward
 S @XYMSG@(SEGIX,3,1,2,1)=$P(ROOMBED,"-",1) ; patient location - room
 S @XYMSG@(SEGIX,3,1,3,1)=$P(ROOMBED,"-",2) ; patient location - bed
 S:WARDNAM'="" @XYMSG@(SEGIX,3,1,4,1)=$$FACILIX(WARDIX) ; pt loc - facility
 I XEVN="A02" D  ; transfer -> get previous location
 . S TMP=$G(VAIP(15)) Q:'TMP  K VAIP
 . S VAIP("E")=TMP D IN5^VADPT
 . S ROOMBED=$P($G(VAIP(6)),U,2) ; previous room and bed
 . S WARDREC=$G(VAIP(5)),WARDIX=$P(WARDREC,U,1),WARDNAM=$P(WARDREC,U,2)
 . S @XYMSG@(SEGIX,6,1,1,1)=WARDNAM ; previous location - ward
 . S @XYMSG@(SEGIX,6,1,2,1)=$P(ROOMBED,"-",1) ; previous location - room
 . S @XYMSG@(SEGIX,6,1,3,1)=$P(ROOMBED,"-",2) ; previous location - bed
 . S:WARDNAM'="" @XYMSG@(SEGIX,6,1,4,1)=$$FACILIX(WARDIX) ; prev loc - facility
 . Q
 F I=1:1:$L(ATTPHY,U) S @XYMSG@(SEGIX,7,1,I,1)=$P(ATTPHY,U,I) ; attending physician
 S @XYMSG@(SEGIX,10,1,1,1)=$P(VAIP(8),"^",2) ; hospital service <- treating specialty
 F I=1:1:$L(ADMPHY,U) S @XYMSG@(SEGIX,8,1,I,1)=$P(ADMPHY,U,I) ; referring = admitting physician
 F I=1:1:$L(ADMPHY,U) S @XYMSG@(SEGIX,17,1,I,1)=$P(ADMPHY,U,I) ; admitting physician
 Q
 ;
OUT ; SUBROUTINE - patient is now an outpatient
 ;
 N REFPHYIX ; -- referring/requesting physician index on NEW PERSON
 N REFPHY ; ---- referring/requesting physician information
 ;
 S @XYMSG@(SEGIX,2,1,1,1)="O" ; patient class
 S:XEVN="A03" @XYMSG@(SEGIX,45,1,1,1)=$$FMTHL7^XLFDT(XEVNDT) ; discharge date/time
 ; insert admit date/time as appropriate
 Q
 ;
FACILIX(XWARDIX) ; FUNCTION - return the facility associated with a ward, if any,
 ;   otherwise return user's default facility
 ;   
 ; input:      XWARDIX = IEN of the ward in WARD LOCATION File (#42))
 ;
 ; function return:    <facility code>_"_"_<facility name>
 ;   
 N DA,DIC,DR,X ;  FileMan work variables
 N WARDIX ; ----- IEN of ward in WARD LOCATION File (#42)
 N HOSPLOCIX ; -- IEN of hospital location in HOSPITAL LOCATION File (#44)
 N FACILIX ; ---- IEN of facility on INSTITUTION File (#4)
 N FACILNAM ; --- name of facility on INSTITUTION File (#4)
 N MAGLOC ; ----- work array for FileMan search results
 ;
 D:$G(XWARDIX)
 . Q:XWARDIX'=+XWARDIX
 . S HOSPLOCIX=$P($G(^DIC(42,XWARDIX,44)),U,1) ; look up hospital location - ICR 10039
 . Q:HOSPLOCIX'>0  Q:'$D(^SC(HOSPLOCIX))  ; hospital location not on file
 . S FACILIX=$P($G(^SC(HOSPLOCIX,0)),"^",4) ; look up facility - ICR 10040
 . Q
 S:'$G(FACILIX) FACILIX=$G(DUZ(2))
 D:FACILIX  ; get facility name - ICR 10090
 . S DIC=4,DR=.01,DA=FACILIX,DIQ="MAGLOC",DIQ(0)="E"
 . D EN^DIQ1 S FACILNAM=$G(MAGLOC(4,FACILIX,.01,"E"))
 . Q
 Q $S(FACILIX:FACILIX_"_"_$G(FACILNAM),1:"")
