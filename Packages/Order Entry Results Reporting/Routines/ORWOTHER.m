ORWOTHER ;SLC/AGP - Other Information Panel RPC ;06/03/2020
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**485,377,531**;Dec 17, 1997;Build 17
 ;
 ;
 ; Reference to ^PXRMCOVID19 supported by ICR #7146
 ;
 ;
SHWOTHER(RESULT,USER) ;
 I $$PATCH^XPDUTL("OR*3.0*377") D  Q
 .S RESULT("otherInfromationPanel","turnedOn")=+$$GET^XPAR("ALL","OR OTHER INFO ON",1,"I")
 .S RESULT("otherInfromationPanel","useColor")=+$$GET^XPAR("ALL","OR OTHER INFO USE COLOR",1,"I")
 .S RESULT("otherInfromationPanel","reportBoxOn")=+$$GET^XPAR("ALL","OR TURNED ON REPORT BOX",1,"I")
 S RESULT=+$$GET^XPAR("ALL","OR OTHER INFO ON",1,"I")
 S RESULT=RESULT_U_+$$GET^XPAR("ALL","OR OTHER INFO USE COLOR",1,"I")
 S RESULT=RESULT_U_+$$GET^XPAR("ALL","OR TURNED ON REPORT BOX",1,"I")
 Q
 ;
DETAIL(RESULT,DFN,TYPE) ;
 N RIEN,SUB,TEMP
 S SUB="ORWOTHER DETAILS"
 K ^TMP(SUB,$J)
 S RESULT=$NA(^TMP(SUB,$J))
 S RIEN=+$$GET^XPAR("ALL","OR OTHER INFO REMINDER",1,"I")
 ;
 I RIEN=0 S ^TMP(SUB,$J,1,0)="No Reminder definition is defined" Q
 I TYPE<1 S ^TMP(SUB,$J,1,0)="No identifer defined" Q
 I DFN<1 S ^TMP(SUB,$J,1,0)="Non-existent patient" Q
 I '$D(^DPT(DFN)) S ^TMP(SUB,$J,1,0)="Non-existent patient" Q
 S TEMP=$$CLICKTEXT^PXRMCOVID19(SUB,RIEN,DFN,TYPE)
 I TEMP'=1 S ^TMP(SUB,$J,1,0)=$P(TEMP,U,2) Q
 Q
 ;
