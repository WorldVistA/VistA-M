PRCHLO ;WOIFO/RLL-EXTRACT ROUTINE CLO REPORT SERVER ;12/30/10  14:34
 ;;5.1;IFCAP;**83,104,130,154**;Oct 20, 2000;Build 5
 ; Per VHA Directive 2004-038, this routine should not be modified
 ; 
 ; PRCHLO* routines are used to build the extract files from
 ; file 410, 424, and 442 for the clinical logistics report server.
 ; PRCHLO thru PRCHLO6 perform the following:
 ; 1. Initialize environment
 ; 2. Get parameters for the month being run
 ; 3. Pull data from file 410, 424, and 442 for month being run
 ; 4. Create multiple "^" delimited flat files for report server
 ; 5. At the completion of extracts FTP files to report server
 ; 6. Clean up / remove any temp files
 ; 7. logout
 ; CALC is the programmer entry point used to test the extract
 ; options for the first iteration of coding
 ;
 Q
INIT ; Initialize environment
 ;
 K ^TMP($J)
 ; 
 ; Get todays date
 N %
 S %=$P(($$NOW^XLFDT),".",1)
 ; (old logic)
 ; Always start from the 1st of the month to the end of month
 ; and at least 45 days prior to todays date
 ;
 ; (new logic)
 ; Always start from the beginning of the Fiscal Year and run
 ; the extract up until the Date of the extract run (NOW)
 ;
 ; The CALC entry point is used for testing from programmer mode
 ; and allows the programmer to pass a specific date
 ; in the variable %=FM date format
 ;
CALC ;test entry point, set %I to FM date
 ;
 N CLO1,CLO2,CLO2B,CLO2E,CLO3,CLOBGN,CLOEND,CLO1A
 N MTHRUN,YRRUN,PYRRUN
 S CLO1=$E(%,1,3)
 ;
 S CLO2=$E(%,4,5)
 S YRRUN=+(CLO1)
 S PYRRUN=YRRUN-1  ; previous Year Run
 S MTHRUN=+(CLO2)
 I +CLO2>2  D
 . S CLO2B=CLO2-2
 . I $L(CLO2B)<2 S CLO2B=0_CLO2B
 . S CLO2E=CLO2-1
 . I $L(CLO2E)<2 S CLO2E=0_CLO2E
 . S CLOBGN=+(CLO1_(CLO2B)_"00")
 . S CLOEND=+(CLO1_(CLO2E)_"01")
 . Q
 ;
 ; check for January run, and Feb run
 I +CLO2=1  D
 . S CLO1=CLO1-1
 . S CLOBGN=+(CLO1_11_"00")  ; Start date is Nov 1st
 . S CLOEND=+(CLO1_12_"01")  ; End date is   Dec 1st
 . Q
 I +CLO2=2  D
 . S CLO1A=CLO1-1  ; Need to get Dec, previous year
 . S CLOBGN=+(CLO1A_12_"00")  ; Start date is Dec 1st
 . S CLOEND=+(CLO1_"01"_"01")  ; End date is  Jan 1st
 . Q
 ;
 ; (Begin new logic)
FYRNOW ; Changes added 07/31/06 RLL for new extract date range.
 ; CLOBGN will always be the beginning of the Fiscal Year (Oct 1st)
 ; This will be the start range for each extract.
 ; This routine is called through the option :
 ; [PRCHLO CLO PROCUREMENT] which is queued to run in TaskMan
 ; This option should be queued to run 2 hours AFTER
 ; [PRCHLO GIP OPTION] and should be run on the same day
 ; (after midnight) as the [PRCHLO GIP OPTION]. As an example:
 ; 1.  Que [PRCHLO GIP OPTION] to run 12:00am the 1st of the month
 ; 2.  Que [PRCHLO CLO PROCUREMENT] to run 1:00am the 1st of the month
 ;
 ;
 ; The following new Variables were added to the CALC entry point:
 ; YRRUN  ; year option run
 ; PYRRUN  ; previous year option run
 ; MTHRUN  ; MONTHRUN
 ; listed below are 3 examples:
 ;
 ; Month Option Run  |  Date Range for Run       | # of months of data
 ; Dec 1st, 2005    | Oct 1, 2005 to Dec 1st 2005|       2
 ; Apr 1st, 2006    | Oct 1, 2005 to Apr 1st 2006|       6
 ; Oct 1st, 2006    | Oct 1, 2005 to Oct 1st 2006|      12
 ;
STCLOBGN ; Set CLOBGN to Beginning of Fiscal Year (Oct. 1)
 ; 
 I MTHRUN=12!(MTHRUN=11)  D
 . ; For Nov or Dec, CLOBGN set to Begin of FY(Oct 1st) in same year
 . S CLOBGN=+(YRRUN_"10"_"00")
 . S CLOEND=%  ; CLOEND is Date Extract Run
 . Q
 I (MTHRUN<11)  D  ; (CLOBGN set to Prev FY for all other conditions)
 . S CLOBGN=+(PYRRUN_"10"_"00")
 . S CLOEND=%  ; CLOEND is Date Extract Run
 . Q
 ; (End new logic)
 ;
DEBUGFY ; Debug Fiscal Year logic by uncommenting code below 7/31/06 RLL
 ;
 D GPARM
 ; Make sure ^TMP($J) is set with data, otherwise return error
 N CKTP
 S CKTP=$O(^TMP($J,0))
 I CKTP=""  D
 . S CLRSERR=1  ; error flag indicates no data in ^TMP($J)
 . Q
 Q
 ;
GPARM ; Get parameters for monthly extract
 ;
 ; need to set monthyear for data file
 ;
 N MNTHYR,FMDT1,MYRVAL
 S FMDT1=$P(($$NOW^XLFDT),".",1)
 S MYRVAL=$$FMTE^XLFDT(FMDT1)
 S MNTHYR=$P(MYRVAL," ",1)_","_$P(MYRVAL," ",3)
 ;
 ; $O through the "AB" x-ref based on CLOBGN and CLOEND
 ;
 S CLO1=CLOBGN,CLO2="",CLO3=""
 F  S CLO1=$O(^PRC(442,"AB",CLO1)) Q:CLO1=""  D
 . F  S CLO2=$O(^PRC(442,"AB",CLO1,CLO2)) Q:CLO2=""  D
 . . Q:CLO1>(CLOEND-1)
 . . D GKEY
 . . Q
 . Q
 ;     PRC*5.1*130 begin
 D GET410^PRCHLO6
 D GET424^PRCHLO6
 ;     PRC*5.1*130 end
 D INVCOMPL^PRCHLO7 ;Compile Invoice Tracking
 Q
EXTR ; Extract the data, create files
 ;
GKEY ; get key for all tables
 N POID,POCRDAT
 S POID=CLO2
 S POCRDAT=CLO1  ; PO Date from x-ref value
 D GPOMAST^PRCHLO1  ;
 Q
