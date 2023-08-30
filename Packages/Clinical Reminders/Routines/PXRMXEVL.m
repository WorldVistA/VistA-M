PXRMXEVL ;SLC/AGP - Reports Reminder Evaluation routine ;Jan 12, 2023@17:59
 ;;2.0;CLINICAL REMINDERS;**4,12,26,47,42,84**;Feb 04, 2005;Build 2
 ;
 ; Called by label from PXRMXSE1
 ;
 ;Detailed report
EVAL(SUB,REMINDER) ;
 N CNT,DFN,DEFARR,FIEV,ITEM,LIT
 S CNT=0
 K ^TMP("PXRHM",$J)
 F  S CNT=$O(REMINDER(CNT)) Q:CNT'>0  D
 . S ITEM=$P(REMINDER(CNT),U,1),LIT=$P(REMINDER(CNT),U,4)
 . I LIT="" S LIT=$P(REMINDER(CNT),U,2)
 . I $P($G(^PXD(811.9,ITEM,0)),U,6)=1 Q
 . D DEF^PXRMLDR(ITEM,.DEFARR)
 .;Make sure the definition exists.
 . I $D(DEFARR("DNE")) Q
 . S DFN=0
 . F  S DFN=$O(^TMP($J,SUB,DFN)) Q:DFN'>0!(ZTSTOP=1)  D
 .. D NOTIFY^PXRMXBSY("Evaluating Reminders",.BUSY)
 .. K FIEV
 ..;Evaluate the reminder for the patient and save the results.
 .. D EVAL^PXRM(DFN,.DEFARR,1,1,.FIEV,PXRMSDT)
 .. S ^TMP($J,SUB,DFN,ITEM)=$G(^TMP("PXRHM",$J,ITEM,LIT))
 .. K ^TMP("PXRHM",$J)
 Q
 ;
