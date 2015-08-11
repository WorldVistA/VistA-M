IBDEI01V ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,358,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,358,1,2,0)
 ;;=2^V58.62
 ;;^UTILITY(U,$J,358.3,358,1,5,0)
 ;;=5^L/T (Current) Antibiotics Use
 ;;^UTILITY(U,$J,358.3,358,2)
 ;;=^321546
 ;;^UTILITY(U,$J,358.3,359,0)
 ;;=V58.63^^3^36^24
 ;;^UTILITY(U,$J,358.3,359,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,359,1,2,0)
 ;;=2^V58.63
 ;;^UTILITY(U,$J,358.3,359,1,5,0)
 ;;=5^L/T (Current) Antiplts/Antithrmbtcs
 ;;^UTILITY(U,$J,358.3,359,2)
 ;;=^329978
 ;;^UTILITY(U,$J,358.3,360,0)
 ;;=V58.64^^3^36^28
 ;;^UTILITY(U,$J,358.3,360,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,360,1,2,0)
 ;;=2^V58.64
 ;;^UTILITY(U,$J,358.3,360,1,5,0)
 ;;=5^L/T (Current) NSAIDS Use
 ;;^UTILITY(U,$J,358.3,360,2)
 ;;=^329979
 ;;^UTILITY(U,$J,358.3,361,0)
 ;;=V58.65^^3^36^30
 ;;^UTILITY(U,$J,358.3,361,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,361,1,2,0)
 ;;=2^V58.65
 ;;^UTILITY(U,$J,358.3,361,1,5,0)
 ;;=5^L/T (Current) Steroids Use
 ;;^UTILITY(U,$J,358.3,361,2)
 ;;=^329980
 ;;^UTILITY(U,$J,358.3,362,0)
 ;;=V58.66^^3^36^25
 ;;^UTILITY(U,$J,358.3,362,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,362,1,2,0)
 ;;=2^V58.66
 ;;^UTILITY(U,$J,358.3,362,1,5,0)
 ;;=5^L/T (Current) Aspirin Use
 ;;^UTILITY(U,$J,358.3,362,2)
 ;;=^331584
 ;;^UTILITY(U,$J,358.3,363,0)
 ;;=V58.67^^3^36^27
 ;;^UTILITY(U,$J,358.3,363,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,363,1,2,0)
 ;;=2^V58.67
 ;;^UTILITY(U,$J,358.3,363,1,5,0)
 ;;=5^L/T (Current) Insulin Use
 ;;^UTILITY(U,$J,358.3,363,2)
 ;;=^331585
 ;;^UTILITY(U,$J,358.3,364,0)
 ;;=V58.68^^3^36^26
 ;;^UTILITY(U,$J,358.3,364,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,364,1,2,0)
 ;;=2^V58.68
 ;;^UTILITY(U,$J,358.3,364,1,5,0)
 ;;=5^L/T (Current) Bisphos Use
 ;;^UTILITY(U,$J,358.3,364,2)
 ;;=^340624
 ;;^UTILITY(U,$J,358.3,365,0)
 ;;=V58.69^^3^36^29
 ;;^UTILITY(U,$J,358.3,365,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,365,1,2,0)
 ;;=2^V58.69
 ;;^UTILITY(U,$J,358.3,365,1,5,0)
 ;;=5^L/T (Current) Other Meds Use
 ;;^UTILITY(U,$J,358.3,365,2)
 ;;=^303460
 ;;^UTILITY(U,$J,358.3,366,0)
 ;;=V58.83^^3^36^50
 ;;^UTILITY(U,$J,358.3,366,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,366,1,2,0)
 ;;=2^V58.83
 ;;^UTILITY(U,$J,358.3,366,1,5,0)
 ;;=5^Therapeutic Drug Monitoring
 ;;^UTILITY(U,$J,358.3,366,2)
 ;;=^322076
 ;;^UTILITY(U,$J,358.3,367,0)
 ;;=V62.5^^3^36^32
 ;;^UTILITY(U,$J,358.3,367,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,367,1,2,0)
 ;;=2^V62.5
 ;;^UTILITY(U,$J,358.3,367,1,5,0)
 ;;=5^Legal Circumstances
 ;;^UTILITY(U,$J,358.3,367,2)
 ;;=^175799
 ;;^UTILITY(U,$J,358.3,368,0)
 ;;=V79.1^^3^37^1
 ;;^UTILITY(U,$J,358.3,368,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,368,1,2,0)
 ;;=2^V79.1
 ;;^UTILITY(U,$J,358.3,368,1,5,0)
 ;;=5^Alcohol Screen
 ;;^UTILITY(U,$J,358.3,368,2)
 ;;=^295678
 ;;^UTILITY(U,$J,358.3,369,0)
 ;;=V61.21^^3^37^8
 ;;^UTILITY(U,$J,358.3,369,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,369,1,2,0)
 ;;=2^V61.21
 ;;^UTILITY(U,$J,358.3,369,1,5,0)
 ;;=5^Victim Child Abuse Counseling
 ;;^UTILITY(U,$J,358.3,369,2)
 ;;=^304301
 ;;^UTILITY(U,$J,358.3,370,0)
 ;;=V65.40^^3^37^2
 ;;^UTILITY(U,$J,358.3,370,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,370,1,2,0)
 ;;=2^V65.40
 ;;^UTILITY(U,$J,358.3,370,1,5,0)
 ;;=5^Counseling NOS
 ;;^UTILITY(U,$J,358.3,370,2)
 ;;=^87449
 ;;^UTILITY(U,$J,358.3,371,0)
 ;;=V65.42^^3^37^7
 ;;^UTILITY(U,$J,358.3,371,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,371,1,2,0)
 ;;=2^V65.42
 ;;^UTILITY(U,$J,358.3,371,1,5,0)
 ;;=5^Substance Use/Abuse Counseling
 ;;^UTILITY(U,$J,358.3,371,2)
 ;;=^303467
 ;;^UTILITY(U,$J,358.3,372,0)
 ;;=V65.44^^3^37^3
 ;;^UTILITY(U,$J,358.3,372,1,0)
 ;;=^358.31IA^5^2
