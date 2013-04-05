ORY309 ;;SLCOIFO - Pre and Post-init for patch OR*3*309
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**309**;;Build 26
 ;
PRE ;Pre-Init Entry Point
 D PARVAL
 Q
POST ;Post-Init Entry Point
 Q
PARVAL ;Set Param Val
 N X
 S X=$$GET^XPAR("PKG.ORDER ENTRY/RESULTS REPORTING","OR VBECS LEGACY REPORT",1)
 I X'="0" D EN^XPAR("PKG.ORDER ENTRY/RESULTS REPORTING","OR VBECS LEGACY REPORT",1,"1")
 Q
SENDDLG(ANAME) ; Return true if the current order dialog should be sent
 I ANAME="VBEC BLOOD BANK" Q 1
 Q 0
