IBDEI1DE ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24569,1,3,0)
 ;;=3^RMVL DEVITAL TIS < 21CM
 ;;^UTILITY(U,$J,358.3,24570,0)
 ;;=97598^^160^1580^12^^^^1
 ;;^UTILITY(U,$J,358.3,24570,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24570,1,2,0)
 ;;=2^97598
 ;;^UTILITY(U,$J,358.3,24570,1,3,0)
 ;;=3^RMVL DEVITAL TIS EA ADDL 20CM
 ;;^UTILITY(U,$J,358.3,24571,0)
 ;;=97602^^160^1580^17^^^^1
 ;;^UTILITY(U,$J,358.3,24571,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24571,1,2,0)
 ;;=2^97602
 ;;^UTILITY(U,$J,358.3,24571,1,3,0)
 ;;=3^WOUND(S) CARE NON-SELECTIVE
 ;;^UTILITY(U,$J,358.3,24572,0)
 ;;=97605^^160^1580^9^^^^1
 ;;^UTILITY(U,$J,358.3,24572,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24572,1,2,0)
 ;;=2^97605
 ;;^UTILITY(U,$J,358.3,24572,1,3,0)
 ;;=3^NEG PRESS WOUND TX < 50 CM
 ;;^UTILITY(U,$J,358.3,24573,0)
 ;;=97606^^160^1580^10^^^^1
 ;;^UTILITY(U,$J,358.3,24573,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24573,1,2,0)
 ;;=2^97606
 ;;^UTILITY(U,$J,358.3,24573,1,3,0)
 ;;=3^NEG PRESS WOUND TX > 50 CM
 ;;^UTILITY(U,$J,358.3,24574,0)
 ;;=11042^^160^1580^4^^^^1
 ;;^UTILITY(U,$J,358.3,24574,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24574,1,2,0)
 ;;=2^11042
 ;;^UTILITY(U,$J,358.3,24574,1,3,0)
 ;;=3^DEB SUBQ TISSUE < 21 SQ CM
 ;;^UTILITY(U,$J,358.3,24575,0)
 ;;=11045^^160^1580^5^^^^1
 ;;^UTILITY(U,$J,358.3,24575,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24575,1,2,0)
 ;;=2^11045
 ;;^UTILITY(U,$J,358.3,24575,1,3,0)
 ;;=3^DEB SUBQ TISSUE EA ADDL 20 SQ CM
 ;;^UTILITY(U,$J,358.3,24576,0)
 ;;=11055^^160^1580^13^^^^1
 ;;^UTILITY(U,$J,358.3,24576,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24576,1,2,0)
 ;;=2^11055
 ;;^UTILITY(U,$J,358.3,24576,1,3,0)
 ;;=3^TRIM SKIN LESION,SINGLE
 ;;^UTILITY(U,$J,358.3,24577,0)
 ;;=11056^^160^1580^14^^^^1
 ;;^UTILITY(U,$J,358.3,24577,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24577,1,2,0)
 ;;=2^11056
 ;;^UTILITY(U,$J,358.3,24577,1,3,0)
 ;;=3^TRIM SKIN LESIONS 2 TO 4
 ;;^UTILITY(U,$J,358.3,24578,0)
 ;;=11057^^160^1580^15^^^^1
 ;;^UTILITY(U,$J,358.3,24578,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24578,1,2,0)
 ;;=2^11057
 ;;^UTILITY(U,$J,358.3,24578,1,3,0)
 ;;=3^TRIM SKIN LESIONS OVER 4
 ;;^UTILITY(U,$J,358.3,24579,0)
 ;;=51701^^160^1580^6^^^^1
 ;;^UTILITY(U,$J,358.3,24579,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24579,1,2,0)
 ;;=2^51701
 ;;^UTILITY(U,$J,358.3,24579,1,3,0)
 ;;=3^INSERT NON-DWELLING BLADDER CATH
 ;;^UTILITY(U,$J,358.3,24580,0)
 ;;=51702^^160^1580^7^^^^1
 ;;^UTILITY(U,$J,358.3,24580,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24580,1,2,0)
 ;;=2^51702
 ;;^UTILITY(U,$J,358.3,24580,1,3,0)
 ;;=3^INSERT TEMP INDWELLING BLADDER CATH
 ;;^UTILITY(U,$J,358.3,24581,0)
 ;;=43760^^160^1580^2^^^^1
 ;;^UTILITY(U,$J,358.3,24581,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24581,1,2,0)
 ;;=2^43760
 ;;^UTILITY(U,$J,358.3,24581,1,3,0)
 ;;=3^CHANGE GASTROSTOMY TUBE
 ;;^UTILITY(U,$J,358.3,24582,0)
 ;;=29580^^160^1580^1^^^^1
 ;;^UTILITY(U,$J,358.3,24582,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24582,1,2,0)
 ;;=2^29580
 ;;^UTILITY(U,$J,358.3,24582,1,3,0)
 ;;=3^APPLICATION OF UNNA BOOT
 ;;^UTILITY(U,$J,358.3,24583,0)
 ;;=97610^^160^1580^8^^^^1
 ;;^UTILITY(U,$J,358.3,24583,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24583,1,2,0)
 ;;=2^97610
 ;;^UTILITY(U,$J,358.3,24583,1,3,0)
 ;;=3^LOW FRQ NON CONTACT/NON THERMAL US & WND ASSMT
 ;;^UTILITY(U,$J,358.3,24584,0)
 ;;=569.60^^161^1581^5
 ;;^UTILITY(U,$J,358.3,24584,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,24584,1,1,0)
 ;;=1^569.60
 ;;^UTILITY(U,$J,358.3,24584,1,2,0)
 ;;=2^COLOST & ENTEROS COMPL,NOS
 ;;^UTILITY(U,$J,358.3,24584,2)
 ;;=^270297