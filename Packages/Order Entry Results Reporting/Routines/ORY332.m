ORY332 ;;SLCOIFO - Pre and Post-init for patch OR*3*332
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**332**;;Build 44
 ;
PRE ;Pre-Init Entry Point
 D PARVAL
 Q
POST ;Post-Init Entry Point
 Q
PARVAL ;Set Param Val
 Q
SENDDLG(ANAME) ; Return true if the current order dialog should be sent
 I ANAME="VBEC BLOOD BANK" Q 1
 Q 0
