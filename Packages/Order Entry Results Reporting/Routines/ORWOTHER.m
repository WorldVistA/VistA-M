ORWOTHER ;SLC/AGP - Other Information Panel RPC ;04/15/2020
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**485,377**;Dec 17, 1997;Build 582
 ;
SHWOTHER(RESULT,USER) ;
 S RESULT("otherInfromationPanel","turnedOn")=+$$GET^XPAR("ALL","OR OTHER INFO ON",1,"I")
 S RESULT("otherInfromationPanel","useColor")=+$$GET^XPAR("ALL","OR OTHER INFO USE COLOR",1,"I")
 S RESULT("otherInfromationPanel","reportBoxOn")=+$$GET^XPAR("ALL","OR TURNED ON REPORT BOX",1,"I")
 Q
 ;
DETAIL(RESULT,DFN,TYPE) ;
 N CNT
 S CNT=0
 S RESULT(CNT)="This is dummy text to display when Report box functionality"
 S CNT=CNT+1,RESULT(CNT)="turned on"
 Q
 ;
