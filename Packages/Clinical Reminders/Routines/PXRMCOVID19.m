PXRMCOVID19 ;SLC/PKR - COVID-19 information for CPRS display. ;05/19/2020
 ;;2.0;CLINICAL REMINDERS;**72,46**;Feb 04, 2005;Build 236
 ;Supports ICR #7146.
 ;===============
CLICKTEXT(SUB,DEFIEN,DFN,TRUEFF) ;
 N IND,STATUS
 K ^TMP(SUB,$J)
 S STATUS=1
 I '$D(^TMP("PXRMCOVID19",$J,DEFIEN,DFN,TRUEFF)) D
 . S STATUS=$$STATUS^PXRMCOVID19(DFN,DEFIEN)
 I $P(STATUS,U,1)=-1 Q "-1^Error loading click text."
 S IND=0
 F  S IND=$O(^TMP("PXRMCOVID19",$J,DEFIEN,DFN,TRUEFF,IND)) Q:IND=""  D
 . S ^TMP(SUB,$J,IND,0)=^TMP("PXRMCOVID19",$J,DEFIEN,DFN,TRUEFF,IND)
 Q 1
 ;
 ;===============
STATUS(DFN,DEFINITION) ;Patient status.
 N BANNERTEXT,DEFARR,DEFIEN,DONE,EVALDT,EVALSTATUS
 N FFBYNUM,FFIND,FFTRUE,FIEVAL,FINUM,IFIEVAL,IND,NLINES
 N PXRMITEM,PXRMRM,TEXTA,TRUEFF
 I DFN="" Q "-1^COVID-19               Non-existent patient"
 I '$D(^DPT(DFN)) Q "-1^COVID-19               Non-existent patient"
 I +DEFINITION=DEFINITION S DEFIEN=DEFINITION
 E  S DEFIEN=$O(^PXD(811.9,"B",DEFINITION,""))
 I DEFIEN="" Q "-1^COVID-19               Non-existent reminder definition"
 I $D(^PXD(811.9,DEFIEN))<10 Q "-1^COVID-19               Non-existent reminder definition"
 K ^TMP("PXRMCOVID19",$J,DEFIEN,DFN),^TMP("PXRHM",$J)
 D DEF^PXRMLDR(DEFIEN,.DEFARR)
 S EVALDT=$$NOW^XLFDT
 D EVAL^PXRM(DFN,.DEFARR,5,1,.FIEVAL,EVALDT)
 ;Check the reminder evaluation status.
 S IND=$O(^TMP("PXRHM",$J,DEFIEN,""))
 S EVALSTATUS=$P(^TMP("PXRHM",$J,DEFIEN,IND),U,1)
 K ^TMP("PXRHM",$J)
 I (EVALSTATUS="CNBD")!(EVALSTATUS="ERROR") Q "-1^Reminder evaluation failure, status: "_EVALSTATUS
 ;Determine the COVID-19 status, by finding the first true function
 ;finding in numerical order.
 S FFIND="FF"
 F  S FFIND=$O(FIEVAL(FFIND)) Q:FFIND'["FF"  D
 . S IND=+$P(FFIND,"FF",2),FFBYNUM(IND)=""
 S (DONE,IND,TRUEFF)=0
 F  S IND=$O(FFBYNUM(IND)) Q:(DONE)!(IND="")  D
 . S FFIND="FF"_IND
 . I FIEVAL(FFIND)=1 S TRUEFF=IND,DONE=1
 I DONE=0 D  Q TRUEFF_U_BANNERTEXT
 . S TRUEFF=0,BANNERTEXT="COVID-19               Unable to determine status"
 ;
 ;Have the true function finding, process the objects in the
 ;found text.
 S PXRMRM=80
 S FFTRUE="FF"_TRUEFF,NLINES=0,PXRMITEM=DEFIEN
 M IFIEVAL=FIEVAL("FF"_TRUEFF)
 D FINDING^PXRMFNFT(DFN,FFTRUE,.FIEVAL,.IFIEVAL,.NLINES,.TEXTA)
 ;Return the first line of text for the CPRS banner, the remaining
 ;lines are the click text.
 S BANNERTEXT=TEXTA(1)
 F IND=2:1:NLINES S ^TMP("PXRMCOVID19",$J,DEFIEN,DFN,TRUEFF,IND-1)=TEXTA(IND)
 Q TRUEFF_U_BANNERTEXT
 ;
