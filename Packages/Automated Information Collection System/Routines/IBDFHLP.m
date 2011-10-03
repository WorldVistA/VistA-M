IBDFHLP ;MAF/ALB - HELP CODE FOR SPECIAL INSTRUCTIONS  ; 06-OCT-1994
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
EN ; -- main entry point for IBDF EF HELP SPEC INSTR.
 D EN^VALM("IBDF EF HELP SPEC INSTR.")
 Q
 ;
HDR ; -- header code
 Q
 ;
INIT ; -- init variables and list array
 S (VALMCNT,IBJCNT,IBJCNT1,IBJCOUNT)=0
 K ^TMP("IBDFHP",$J)
 F IBJX=1:1 S IBJVAL=$P($T(DISP+IBJX),";;",2) Q:IBJVAL="END"  S X="",X=$$SETSTR^VALM1(IBJVAL,X,5,75) D TMP
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBDFHP",$J),^TMP("HPIDX",$J) Q
 ;
EXPND ; -- expand code
 Q
 ;
DISP ;Help frame for Special Instructions
 ;;  The choices for Special Instructions are:
 ;;
 ;;                R - Run Regardless
 ;;                I - Ignore both Weekends and Holidays
 ;;                W - Ignore Weekends
 ;;                H - Ignore Holidays
 ;;                T - Today
 ;;                N - Not Active
 ;;
 ;;
 ;; R - Run Regardless ... The print job will run daily at the scheduled time.
 ;;
 ;; I - Ignore Weekends and Holidays... The print job will not run at it's
 ;;     daily scheduled time if the day is a holiday or a weekend day.
 ;;
 ;; W - Ignore Weekends... The print job will not run at it's daily scheduled
 ;;     time if the day is a weekend day.
 ;;
 ;; H - Ignore Holidays... The print job will not run at it's daily scheduled 
 ;;     time if the day is a holiday.
 ;;
 ;; T - Today... The job will run today.
 ;;
 ;; N - Not Active... The job is considered inactive and the encounter forms
 ;;     will not be printed.
 ;;END
TMP S IBJCNT=IBJCNT+1,IBJCNT1=IBJCNT1+1,VALMCNT=VALMCNT+1 S ^TMP("IBDFHP",$J,IBJCNT,0)=X,^TMP("IBDFHP",$J,"IDX",VALMCNT,IBJCNT)=""
 S ^TMP("HPIDX",$J,IBJCNT)=VALMCNT
 Q
