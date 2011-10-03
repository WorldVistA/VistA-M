MAGUTL03 ;WOIFO/SG - DATE/TIME UTILITIES ; 3/9/09 12:53pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; This routine uses the following ICRs:
 ;
 ; #10038        Read file #40.5 (supported)
 ;
 Q
 ;
 ;##### ENSURES THAT THE DATE/TIME IS IN INTERNAL FORMAT
 ;
 ; X             Date/time in internal (FileMan) or external format
 ;
 ; [%DT]         Flags for the ^%DT (see the FileMan Programmer
 ;               manual for details)
 ; 
 ; Return Values
 ; =============
 ;           -1  Invalid date
 ;           >0  Date/time in internal FileMan format
 ;
DTI(X,%DT) ;
 N Y
 Q:X?7N.1(1"."1.N) X
 S %DT=$TR($G(%DT),"AE")  D ^%DT
 Q Y
 ;
 ;##### "NORMALIZES" THE DATE RANGE
 ; 
 ; .FROMDATE(    Reference to a local variable that stores the
 ;               beginning date of the date range. The time part of
 ;               the value is ignored.
 ;
 ;               After a successful call, this variable contains
 ;               the internal FileMan value of the date. In case of
 ;               error(s), the input value is returned.
 ;
 ;   0)          Standard external date value is returned here.
 ;               In case of error(s), this node is not defined.
 ;
 ; .TODATE(      Reference to a local variable that stores the
 ;               end date of the date range. The time part of
 ;               the value is ignored.
 ;
 ;               After a successful call, this variable contains
 ;               the internal FileMan value of the date. In case of
 ;               error(s), the input value is returned.
 ;
 ;   0)          Standard external date value is returned here.
 ;               In case of error(s), this node is not defined.
 ; 
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;
 ; Notes
 ; =====
 ;
 ; If the FROMDATE is after the TODATE, then the dates are swapped.
 ;
DTRANGE(FROMDATE,TODATE) ;
 N RC,TMP
 ;
 ;=== Validate the dates
 S RC=0  D  I RC<0  K FROMDATE(0),TODATE(0)  Q RC
 . ;--- Beginning of the date range
 . I $G(FROMDATE)'=""  D  Q:RC<0
 . . S TMP=$$DTI(FROMDATE,"TS")
 . . I TMP<0  S RC=$$IPVE^MAGUERR("FROMDATE")  Q
 . . S FROMDATE=TMP\1,FROMDATE(0)=$$FMTE^XLFDT(FROMDATE)
 . . Q
 . E  S FROMDATE=0,FROMDATE(0)=""
 . ;--- End of the date range
 . I $G(TODATE)'=""  D  Q:RC<0
 . . S TMP=$$DTI(TODATE,"TS")
 . . I TMP<0  S RC=$$IPVE^MAGUERR("TODATE")  Q
 . . S TODATE=TMP\1,TODATE(0)=$$FMTE^XLFDT(TODATE)
 . . Q
 . E  S TODATE=9999999,TODATE(0)=""
 . Q
 ;
 ;=== Swap the dates if necessary
 K TMP
 M:FROMDATE>TODATE TMP=FROMDATE,FROMDATE=TODATE,TODATE=TMP
 ;
 ;=== Success
 Q 0
 ;
 ;##### CHECKS IF THE DATE IS A WORKING DAY
 ;
 ; DATE          The date to be checked
 ;
 ; Return Values
 ; =============
 ;        0  Weekend or Holiday
 ;        1  Working day
 ;
WDCHK(DATE) ;
 N DOW,MAGMSG
 ;--- Return zero if Saturday (6) or Sunday (0)
 S DOW=$$DOW^XLFDT(DATE,1)
 Q:DOW<0 $$IPVE^MAGUERR("DATE")
 Q:'DOW!(DOW>5) 0
 ;--- Return 1 if cannot be found in the HOLIDAY file
 Q $$FIND1^DIC(40.5,,"QX",DATE\1,"B",,"MAGMSG")'>0
 ;
 ;##### RETURNS THE NEXT WORKING DAY DATE
 ;
 ; DATE          The source date
 ;
 ; The function returns the date of the next working day.
 ;
WDNEXT(DATE) ;
 N DOW,MAGMSG
 F  D  Q:$$FIND1^DIC(40.5,,"QX",DATE,"B",,"MAGMSG")'>0
 . S DOW=$$DOW^XLFDT(DATE,1)  S:'DOW DOW=7
 . ;--- Get the next day and skip a weekend if necessary
 . S DATE=$$FMADD^XLFDT(DATE,$S(DOW<5:1,1:8-DOW))
 . Q
 Q DATE
