ORWDXVB3 ;;slc/dcm - Order dialog utilities for Blood Bank Cont. ;3/17/10  08:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**280**;Dec 17 1997;Build 85
DIAGORD(OROOT) ;Get sequence order of Diagnostic tests
 N ORLIST,I,X
 D GETLST^XPAR(.ORLIST,"ALL","OR VBECS DIAGNOSTIC TEST ORDER")
 S I=0 F  S I=$O(ORLIST(I)) Q:'I  S X=ORLIST(I) I $D(^ORD(101.43,$P(X,"^",2),0)) S OROOT(I)=$P(X,"^",2)_"^"_$P(^(0),"^",1)_"^"_$P(^(0),"^",1)
 Q
COLLTIM(OROOT) ;Get Collection Time Default Parameter Value
 S OROOT=+$$GET^XPAR("ALL","OR VBECS REMOVE COLL TIME",1,"I")
 Q
SWPANEL(OROOT) ;Switch the location of the Diagnostic and Component panels on VBECS Order Dialog
 S OROOT=+$$GET^XPAR("ALL","OR VBECS DIAGNOSTIC PANEL 1ST",1,"I")
 Q
