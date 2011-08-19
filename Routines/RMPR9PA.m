RMPR9PA ;HOIFO/SPS - GUI 2319 TAB 2 PENDING APPOINTMENTS  ;3/26/07  07:27
 ;;3.0;PROSTHETICS;**59,88**;Feb 09, 1996;Build 2
 ;DDA 6 MAR 07 - Patch 88 - Added Scheduling Encapsulation database check
 ; for SDA^VADPT call and ^UTILITY("VASD", usage.
 ; Variable RMPRSDER will equal 2 if the COTS database is unavailable.
 ;
A1(IEN) G A2
EN(RESULTS,IEN) ;broker entry point
A2 ;
 S DFN=$P($G(^RMPR(668,IEN,0)),U,2)
 I DFN="" S RESULTS(0)="NOTHING TO REPORT" G EXIT
 ;Pending Appointments
 D SDA^VADPT S RMPRSDER=VAERR
 I RMPRSDER=2!'$D(^UTILITY("VASD",$J)) G EXIT
 S CNT=0,RO=0 F  S RO=$O(^UTILITY("VASD",$J,RO)) Q:RO'>0  D
 . I CNT>0 S CNT=CNT+1
 . S RESULTS(CNT)=$P(^UTILITY("VASD",$J,RO,"E"),U,1)_"^"_$P(^UTILITY("VASD",$J,RO,"E"),U,2)_"^"_$P(^UTILITY("VASD",$J,RO,"E"),U,3)_"^"_$P(^UTILITY("VASD",$J,RO,"E"),U,4)
 . S CNT=CNT+1
EXIT ;common exit point
 I RMPRSDER=2 S RESULTS(0)="Fatal RSA error. See SDAM RSA ERROR LOG file."
 I '$D(RESULTS) S RESULTS(0)="NOTHING TO REPORT"
 K CNT,DFN,RMPRSDER,RO,^UTILITY("VASD",$J)
 ;END
