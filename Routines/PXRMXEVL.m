PXRMXEVL ; SLC/AGP - Reports Reminder Evaluation routine;02/12/2009
 ;;2.0;CLINICAL REMINDERS;**4,12**;Feb 04, 2005;Build 73
 ;
 ; Called by label from PXRMXSE1
 ;
 ;Detailed report
EVAL(SUB,REMINDER) ;
 N CNT,DFN,DEFARR,FIEV,ITEM,LIT,PXRMDATE
 S CNT=0 F  S CNT=$O(REMINDER(CNT)) Q:CNT'>0  D
 .S ITEM=$P(REMINDER(CNT),U,1),LIT=$P(REMINDER(CNT),U,4)
 .I LIT="" S LIT=$P(REMINDER(CNT),U,2)
 .I $P($G(^PXD(811.9,ITEM,0)),U,6)=1 Q
 .D DEF^PXRMLDR(ITEM,.DEFARR)
 .S DFN=0 F  S DFN=$O(^TMP($J,SUB,DFN)) Q:DFN'>0!(ZTSTOP=1)  D
 ..D NOTIFY^PXRMXBSY("Evaluating Reminders",.BUSY)
 ..;Check if due and/or applicable (active reminder for live patient)
 ..K FIEV
 ..S PXRMDATE=PXRMSDT D EVAL^PXRM(DFN,.DEFARR,1,1,.FIEV,PXRMDATE)
 ..;Quit if nothing returned
 ..S ^TMP($J,SUB,DFN,ITEM)=$G(^TMP("PXRHM",$J,ITEM,LIT))
 ..K ^TMP("PXRHM",$J)
 Q
 ;
