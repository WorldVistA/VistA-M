MAGT7SV ;WOIFO/MLH/PMK - telepathology - create HL7 message to DPS - segment build - PV1 ; 17 Jul 2013 12:07 PM
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
PV1SEG(SEGELTS,DFN) ; FUNCTION - main entry point - create a PV1 segment
 N VAERR ; error code returned by VADPT calls
 N VAHOW ; how to return data from VADPT calls - default numeric subscripts
 N VAIP ; inpatient data array from IN5^VADPT call
 N VAIN ; inpatient data array from INP^VADPT call
 N ROOMBED ; room and bed from VAIP()
 N EMPSENSFLAG ; employee / sensitive flag
 N VISITNO ; visit number
 N FLDPCLAS S FLDPCLAS=2 ; patient class field
 N FLDPLOC S FLDPLOC=3 ; patient location field
 N FLDVIPFLAG S FLDVIPFLAG=16 ; VIP flag field
 N FLDVNUM S FLDVNUM=19 ; visit number field
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 K SEGELTS ; always refresh *segment* array (not message array) on entry
 ;
 D SET^HLOAPI(.SEGELTS,"PV1",0) ; segment type
 D  ; PV1-2-patient class
 . D IN5^VADPT ; get inpatient data - returns VAIP()
 . D SET^HLOAPI(.SEGELTS,$S(VAIP(13):"I",1:"O"),FLDPCLAS)
 . Q
 D:VAIP(13)  ; PV1-3-patient location (inpatient only)
 . N WARDIX,WARDNAM,WARDREC ; ward working variables
 . S WARDREC=$G(VAIP(5)),WARDIX=$P(WARDREC,U,1),WARDNAM=$P(WARDREC,U,2)
 . D SET^HLOAPI(.SEGELTS,WARDNAM,FLDPLOC,1,1,1) ; component 1 = ward
 . S ROOMBED=$P(VAIP(6),"^",2)
 . D SET^HLOAPI(.SEGELTS,$P(ROOMBED,"-",1),FLDPLOC,2,1,1) ; component 2 = room
 . D SET^HLOAPI(.SEGELTS,$P(ROOMBED,"-",2),FLDPLOC,3,1,1) ; component 3 = bed
 . D SET^HLOAPI(.SEGELTS,$$FACILIX^MAGDHLSV(WARDIX,"W"),FLDPLOC,4,1,1) ; component 4 = facility
 . Q
 D  ; PV1-16-VIP flag
 . ; ICR #3646: employee flag
 . S:$$EMPL^DGSEC4(DFN)=1 EMPSENSFLAG=$G(EMPSENSFLAG)_"E"
 . ; ICR #767: sensitive flag
 . S:$P($G(^DGSL(38.1,DFN,0)),"^",2)=1 EMPSENSFLAG=$G(EMPSENSFLAG)_"S"
 . D:$D(EMPSENSFLAG) SET^HLOAPI(.SEGELTS,EMPSENSFLAG,FLDVIPFLAG)
 . Q
 D  ; PV1-19-visit number
 . D INP^VADPT ; get inpatient data - returns VAIN()
 . S VISITNO=$S($G(VAIN(1))'="":"I"_VAIN(1),1:"O"_($$HTFM^XLFDT($H,1)+17000000))
 . D SET^HLOAPI(.SEGELTS,VISITNO,FLDVNUM)
 . Q
 Q ERRSTAT
