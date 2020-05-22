PXRMCOVID19 ;SLC/PKR - COVID-19 information for CPRS display. ;04/10/2020
 ;;2.0;CLINICAL REMINDERS;**72**;Feb 04, 2005;Build 16
 ;Supports ICR #7146.
 ;===============
STATUS(DFN,DEFINITION) ;Patient status.
 N DEFARR,DEFIEN,DONE,EVALDT,EVALSTATUS,FFIND,FIEVAL,FINUM,IND,JND,KND
 N MRD,TEXT
 I DFN="" Q "-1^COVID-19               Non-existent patient"
 I '$D(^DPT(DFN)) Q "-1^COVID-19               Non-existent patient"
 I +DEFINITION=DEFINITION S DEFIEN=DEFINITION
 E  S DEFIEN=$O(^PXD(811.9,"B",DEFINITION,""))
 I DEFIEN="" Q "-1^COVID-19               Non-existent reminder definition"
 I $D(^PXD(811.9,DEFIEN))<10 Q "-1^COVID-19               Non-existent reminder definition"
 K ^TMP("PXRHM",$J)
 D DEF^PXRMLDR(DEFIEN,.DEFARR)
 S EVALDT=$$NOW^XLFDT
 D EVAL^PXRM(DFN,.DEFARR,5,1,.FIEVAL,EVALDT)
 ;Check the reminder evaluation status.
 S IND=$O(^TMP("PXRHM",$J,DEFIEN,""))
 S EVALSTATUS=$P(^TMP("PXRHM",$J,DEFIEN,IND),U,1)
 I (EVALSTATUS="CNBD")!(EVALSTATUS="ERROR") Q "-1^Reminder evaluation failure, status: "_EVALSTATUS
 ;Determine the COVID-19 status, by finding the true function finding.
 S FFIND="FF",(DONE,MRD)=0
 F  S FFIND=$O(FIEVAL(FFIND)) Q:(DONE)!(FFIND'["FF")  D
 . I FIEVAL(FFIND)=0 Q
 .;Have the true function finding, return the text and the most
 .;recent date of the findings.
 .;Stop at the first true FF.
 . S DONE=1
 . S IND=$P(FFIND,"FF",2)
 . S TEXT=$G(^PXD(811.9,DEFIEN,25,IND,1,1,0))
 . S JND=0,MRD=0
 . F  S JND=$O(^PXD(811.9,DEFIEN,25,IND,5,JND)) Q:JND=""  D
 .. S KND=0
 .. F  S KND=$O(^PXD(811.9,DEFIEN,25,IND,5,JND,20,KND)) Q:KND=""  D
 ... S FINUM=+^PXD(811.9,DEFIEN,25,IND,5,JND,20,KND,0)
 ... I FINUM=0 Q
 ... I $G(FIEVAL(FINUM,"DATE"))>MRD S MRD=FIEVAL(FINUM,"DATE")
 . I MRD>0 S TEXT=TEXT_" "_$$FMTE^XLFDT(MRD,"D")
 K ^TMP("PXRHM",$J)
 I DONE=0 S IND=0,TEXT="COVID-19               Unable to determine status"
 Q IND_U_TEXT
 ;
