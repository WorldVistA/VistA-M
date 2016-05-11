IBDEI0E8 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6543,2)
 ;;=^5002357
 ;;^UTILITY(U,$J,358.3,6544,0)
 ;;=C22.2^^30^396^83
 ;;^UTILITY(U,$J,358.3,6544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6544,1,3,0)
 ;;=3^Hepatoblastoma
 ;;^UTILITY(U,$J,358.3,6544,1,4,0)
 ;;=4^C22.2
 ;;^UTILITY(U,$J,358.3,6544,2)
 ;;=^5000935
 ;;^UTILITY(U,$J,358.3,6545,0)
 ;;=D58.9^^30^396^85
 ;;^UTILITY(U,$J,358.3,6545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6545,1,3,0)
 ;;=3^Hereditary Hemolytic Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,6545,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,6545,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,6546,0)
 ;;=C81.99^^30^396^86
 ;;^UTILITY(U,$J,358.3,6546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6546,1,3,0)
 ;;=3^Hodgkin Lymphoma,Extranodal/Solid Organ Sites
 ;;^UTILITY(U,$J,358.3,6546,1,4,0)
 ;;=4^C81.99
 ;;^UTILITY(U,$J,358.3,6546,2)
 ;;=^5001460
 ;;^UTILITY(U,$J,358.3,6547,0)
 ;;=C81.90^^30^396^87
 ;;^UTILITY(U,$J,358.3,6547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6547,1,3,0)
 ;;=3^Hodgkin Lymphoma,Unspec Site
 ;;^UTILITY(U,$J,358.3,6547,1,4,0)
 ;;=4^C81.90
 ;;^UTILITY(U,$J,358.3,6547,2)
 ;;=^5001451
 ;;^UTILITY(U,$J,358.3,6548,0)
 ;;=D89.2^^30^396^88
 ;;^UTILITY(U,$J,358.3,6548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6548,1,3,0)
 ;;=3^Hypergammaglobulenemia,Unspec
 ;;^UTILITY(U,$J,358.3,6548,1,4,0)
 ;;=4^D89.2
 ;;^UTILITY(U,$J,358.3,6548,2)
 ;;=^5002455
 ;;^UTILITY(U,$J,358.3,6549,0)
 ;;=D05.12^^30^396^89
 ;;^UTILITY(U,$J,358.3,6549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6549,1,3,0)
 ;;=3^Intraductal Carcinoma in Situ,Left Breast
 ;;^UTILITY(U,$J,358.3,6549,1,4,0)
 ;;=4^D05.12
 ;;^UTILITY(U,$J,358.3,6549,2)
 ;;=^5001931
 ;;^UTILITY(U,$J,358.3,6550,0)
 ;;=D05.11^^30^396^90
 ;;^UTILITY(U,$J,358.3,6550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6550,1,3,0)
 ;;=3^Intraductal Carcinoma in Situ,Right Breast
 ;;^UTILITY(U,$J,358.3,6550,1,4,0)
 ;;=4^D05.11
 ;;^UTILITY(U,$J,358.3,6550,2)
 ;;=^5001930
 ;;^UTILITY(U,$J,358.3,6551,0)
 ;;=D05.10^^30^396^91
 ;;^UTILITY(U,$J,358.3,6551,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6551,1,3,0)
 ;;=3^Intraductal Carcinoma in Situ,Unspec Breast
 ;;^UTILITY(U,$J,358.3,6551,1,4,0)
 ;;=4^D05.10
 ;;^UTILITY(U,$J,358.3,6551,2)
 ;;=^5001929
 ;;^UTILITY(U,$J,358.3,6552,0)
 ;;=D50.0^^30^396^92
 ;;^UTILITY(U,$J,358.3,6552,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6552,1,3,0)
 ;;=3^Iron Deficiency Anemia Secondary to Blood Loss
 ;;^UTILITY(U,$J,358.3,6552,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,6552,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,6553,0)
 ;;=D50.9^^30^396^93
 ;;^UTILITY(U,$J,358.3,6553,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6553,1,3,0)
 ;;=3^Iron Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,6553,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,6553,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,6554,0)
 ;;=C46.9^^30^396^94
 ;;^UTILITY(U,$J,358.3,6554,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6554,1,3,0)
 ;;=3^Kaposi's Sarcoma,Unspec
 ;;^UTILITY(U,$J,358.3,6554,1,4,0)
 ;;=4^C46.9
 ;;^UTILITY(U,$J,358.3,6554,2)
 ;;=^5001108
 ;;^UTILITY(U,$J,358.3,6555,0)
 ;;=C22.0^^30^396^95
 ;;^UTILITY(U,$J,358.3,6555,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6555,1,3,0)
 ;;=3^Liver Cell Carcinoma
 ;;^UTILITY(U,$J,358.3,6555,1,4,0)
 ;;=4^C22.0
 ;;^UTILITY(U,$J,358.3,6555,2)
 ;;=^5000933
 ;;^UTILITY(U,$J,358.3,6556,0)
 ;;=D05.02^^30^396^96
 ;;^UTILITY(U,$J,358.3,6556,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6556,1,3,0)
 ;;=3^Lobular Carcinoma in Situ,Left Breast
 ;;^UTILITY(U,$J,358.3,6556,1,4,0)
 ;;=4^D05.02
 ;;^UTILITY(U,$J,358.3,6556,2)
 ;;=^5001928
 ;;^UTILITY(U,$J,358.3,6557,0)
 ;;=D05.01^^30^396^97
