VAQADM23 ;ALB/JRP - MESSAGE ADMINISTRATION;13-SEP-93
 ;;1.5;PATIENT DATA EXCHANGE;;NOV 17, 1993
MAXCHCK(SEGARR,OUTARR) ;CHECK SEGMENTS AGAINST MAXIMUM LIMITS FOR AUTO PROC.
 ;INPUT  : SEGARR - Array of pointers to VAQ - DATA SEGMENT file
 ;                  set equal to the time & occurrence values requested
 ;                  (full global reference)
 ;                    SEGARR(Pointer)=Time^Occurr
 ;         OUTARR - Array to store output in (full global reference)
 ;                  [See OUPUT for format of OUTARR]
 ;OUTPUT : 0 - All segments OK for automatic processing
 ;               OUTARR will have no entries
 ;         X - Number of segments that can not be automatically processed
 ;               OUTARR(SEGPTR)=MaxTime^MaxOccur^Time^Occur
 ;        -1 - Bad input or error
 ;NOTES  : It is the responsibility of the programmer to ensure that
 ;         OUTARR is killed before and after this call
 ;
 ;CHECK INPUT
 Q:($G(SEGARR)="") ""
 Q:('$D(@SEGARR))
 Q:($G(OUTARR)="") ""
 ;DECLARE VARIABLES
 N TMP,POINTER,REQTIM,REQOCC,COUNT,OVERMAX
 ;LOOP THROUGH SEGMENTS
 S POINTER=""
 S COUNT=0
 F  S POINTER=+$O(@SEGARR@(POINTER)) Q:('POINTER)  D
 .;NOT A VALID SEGMENT POINTER - IGNORE
 .Q:('$D(^VAT(394.71,POINTER)))
 .;GET REQUESTED LIMITS
 .S TMP=$G(@SEGARR@(POINTER))
 .S REQTIM=$P(TMP,"^",1)
 .S REQOCC=$P(TMP,"^",2)
 .;CHECK LIMITS AGAINST MAX ALLOWED
 .S OVERMAX=$$CHCKSEG(POINTER,REQTIM,REQOCC)
 .;OVER ALLOWED LIMITS - INCREMENT COUNT & STORE MAX LIMITS
 .I (OVERMAX) D
 ..S COUNT=COUNT+1
 ..S TMP=$$SEGHLTH^VAQDBIH1(POINTER,0)
 ..S @OUTARR@(POINTER)=($P(TMP,"^",2,3)_"^"_REQTIM_"^"_REQOCC)
 ;RETURN NUMBER OF SEGMENTS OVER MAX ALLOWED
 Q COUNT
 ;
CHCKSEG(SEGPTR,TIME,OCCUR) ;CHECK SEGMENT LIMITS AGAINST ALLOWED VALUES
 ;INPUT  : SEGPTR - Pointer to VAQ - DATA SEGMENT file (segment to check)
 ;         TIME - Time limit being requested
 ;         OCCUR - Occurrence limit being requested
 ;OUTPUT : 0 - Segment OK for automatic processing
 ;         1 - Segment can not be automatically processed
 ;        -1 - Bad input
 ;
 ;CHECK INPUT
 Q:($G(SEGPTR)="") -1
 Q:('$D(^VAT(394.71,SEGPTR))) -1
 S TIME=$G(TIME)
 S OCCUR=$G(OCCUR)
 I (TIME'="") Q:($$VALOCC^VAQDBIH2(TIME,0)) -1
 I (OCCUR'="") Q:($$VALOCC^VAQDBIH2(OCCUR,1)) -1
 ;DECLARE VARIABLES
 N TIMLIM,OCCLIM,TMP
 ;GET ALLOWABLE LIMITS FOR SEGMENT
 S TMP=$$SEGHLTH^VAQDBIH1(SEGPTR)
 ;SEGMENT NOT HEALTH SUMMARY COMPONENT (AUTOMATIC PROCESSING ALLOWED)
 Q:('TMP) 0
 S TIMLIM=$P(TMP,"^",2)
 S OCCLIM=$P(TMP,"^",3)
 ;CHECK TIME LIMIT
 I ((TIMLIM'="")&(TIMLIM'="@")) D  Q:(TMP) 1
 .;CONVERT TIME LIMIT REQUESTED TO DAYS
 .S TMP=$$TIMECHNG(TIME)
 .I ((TMP="")&(TIME'="")) S TMP=1 Q
 .S TIME=TMP
 .;CONVERT ALLOWABLE TIME LIMIT TO DAYS
 .S TIMLIM=$$TIMECHNG(TIMLIM)
 .I (TIMLIM="") S TMP=1 Q
 .;CHECK
 .I (TIME="") S TMP=1 Q
 .I (TIME>TIMLIM) S TMP=1 Q
 .S TMP=0
 ;CHECK OCCURRENCE LIMIT
 I ((OCCLIM'="")&(OCCLIM'="@")) D  Q:(TMP) 1
 .S TMP=0
 .S:(OCCUR>OCCLIM) TMP=1
 .S:(OCCUR="") TMP=1
 ;AUTOMATIC PROCESSING ALLOWED
 Q 0
 ;
TIMECHNG(INTIME) ;CONVERT TIME LIMIT TO DAYS
 ;INPUT  : INTIME - Valid time limit to convert
 ;OUTPUT : X - INTIME in days (ex: '1Y' results in '365')
 ;         NULL will be returned on error
 ;NOTES  : The following assumptions are made
 ;           1) There are 365 days in a year
 ;           2) There are 30 days in a month
 ;
 ;CHECK INPUT
 Q:($$VALOCC^VAQDBIH2($G(INTIME),0)) ""
 ;DECLARE VARIABLES
 N TYPE,VALUE
 ;BREAK LIMIT INTO IT'S VALUE AND TYPE
 S VALUE=$E(INTIME,1,($L(INTIME)-1))
 S TYPE=$E(INTIME,$L(INTIME))
 ;INTIME ALREADY IN DAYS
 Q:(TYPE="D") (+INTIME)
 ;CONVERT YEARS TO DAYS
 Q:(TYPE="Y") (VALUE*365)
 ;CONVERT MONTHS TO DAYS
 Q:(TYPE="M") (VALUE*30)
 ;ERROR
 Q ("")
