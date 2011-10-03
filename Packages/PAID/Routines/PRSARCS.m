PRSARCS ;;WOIFO/JAH - Recess Tracking Functions ;02-MAR-2007
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
EN ;
 S PRSHDR="9 Mo. AWS Recess Summary for "_$P(PRSFSCYR,U,2)_"  AWS Start Date: "_$P(PRSFY,U,10)_" (pp "_$P(PRSFY,U,12)_")"
 S PRSHDR2=$G(VALMHDR(2))
 D EN^VALM("PRSA RECESS SUMMARY")
 S VALMBCK="R"
 Q
HDR ; -- header code
 S VALMHDR(1)=PRSHDR
 S VALMHDR(2)=PRSHDR2
 Q
 ;
INIT ; -- init variables and list array
 ; hours based on 25% of AWS schedule--total assigned and available hrs
 ; and hours available to be assigned to weeks.
 ;
 N TRWA,TRHA,RRHA,OUT,RCNT,ED1,TEXT,WD1,WK,HRSWK,HRSUSED,TOTWKS,HRSPOST
 N HRSPSTOT,DEC
 S (WK,HRSUSED,RCNT,HRSPSTOT)=0
 S VALMCNT=0
 F  S WK=$O(^TMP("PRSRW",$J,WK)) Q:WK'>0  D
 . ; Get item out of recess weeks items index
 .   S VALMCNT=VALMCNT+1
 .   S WD1=$G(WKSFM(WK)),ED1=$E(WD1,4,5)_"/"_$E(WD1,6,7)_"/"_$E(WD1,2,3)
 .   S HRSWK=$P(^TMP("PRSRW",$J,WK),U,2)
 .   I HRSWK>0 S RCNT=RCNT+1
 .   S HRSPOST=$P(^TMP("PRSRW",$J,WK),U,5)
 .   S HRSPSTOT=HRSPSTOT+HRSPOST
 .   S HRSUSED=HRSUSED+HRSWK
 .   S DEC=$S($P(HRSWK,".",2)>0:1,1:0)
 .   S TEXT=$J(WK,5,0)_"   "_ED1_$J(HRSWK,18,2)_$J(HRSPOST,19,2)
 .   D SET^VALM10(VALMCNT,TEXT)
 I RCNT=0 D 
 .  S VALMCNT=VALMCNT+1
 .  D SET^VALM10(VALMCNT,"  There are no weeks scheduled with recess hours.")
 S PRSRWHRS=$$GETAVHRS^PRSARC04(.FMWKS,PRSDT)
 S TOTWKS=$P($G(PRSRWHRS),U)
 S TRHA=$P($G(PRSRWHRS),U,2)
 S TRWA=$P($G(PRSRWHRS),U,3)
 S RRHA=TRHA-HRSUSED
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"                            ======             ======")
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT," Total Recess.   Scheduled:"_$J(HRSUSED,7,2)_"     Posted:"_$J(HRSPSTOT,7,2))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT,"")
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT," Total Weeks in AWS FY Schedule: "_$J(TOTWKS,5,2))
 S VALMCNT=VALMCNT+1
 D SET^VALM10(VALMCNT," Total available FY recess hrs: "_$J(TRHA,6,2)_" ("_TRWA_" weeks)")
 S VALMCNT=VALMCNT+1
 I RRHA<0 D
 .  D SET^VALM10(VALMCNT," WARNING--Recess hours over scheduled: "_$J(RRHA,6,2))
 .  S VALMSG="WARNING--Recess hours are over scheduled: "_$J(RRHA,6,2)
 E  D
 .  I RRHA>0 D
 ..    D SET^VALM10(VALMCNT," WARNING--Recess hours under scheduled: "_$J(RRHA,6,2))
 ..  S VALMSG="WARNING--Recess hours are under scheduled: "_$J(RRHA,6,2)
 .  E  D
 ..    D SET^VALM10(VALMCNT," Scheduled recess hours match hours available for recess.")
 S VALMBCK="Q"
 Q
VALIDRS ; valid recess schedule?
 ; hours based on 25% of AWS schedule--total assigned and available hrs
 ; and hours available to be assigned to weeks.
 ;
 ; if quitting (PRSOUT=1) check the file, otherwise check what is 
 ; being saved from the PRSRW array.
 ;
 N TRHA,RRHA,OUT,CNT,ED1,WD1,WK,HRSWK,HRSUSED,OUT
 I '$G(PRSOUT) D
 . S (WK,HRSUSED)=0
 . F  S WK=$O(^TMP("PRSRW",$J,WK)) Q:WK'>0  D
 .. ; Get item out of recess weeks items index
 ..   S HRSWK=$P(^TMP("PRSRW",$J,WK),U,2)
 ..   S HRSUSED=HRSUSED+HRSWK
 E  D
 .  S HRSUSED=$$HRSFILED^PRSARC03($P($G(PRSFY),U,9))
 S PRSRWHRS=$$GETAVHRS^PRSARC04(.FMWKS,PRSDT)
 S TRHA=$P($G(PRSRWHRS),U,2)
 S RRHA=TRHA-HRSUSED
 I RRHA<0 D
 .  W !,"WARNING--Recess hours are over scheduled: "_$J(-RRHA,6,2)
 E  D
 .  I RRHA>0 D
 ..   W !,"WARNING--Recess hours are under scheduled: "_$J(-RRHA,6,2)
 .  E  D
 ..   W !,"Scheduled recess hours match hours available for recess."
 S OUT=$$ASK^PRSLIB00(1)
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 K PRSHDR,PRSHDR2
 Q
 ;
EXPND ; -- expand code
 Q
 ;
