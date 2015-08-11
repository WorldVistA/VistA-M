IBDEI03M ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1330,1,2,0)
 ;;=2^93799
 ;;^UTILITY(U,$J,358.3,1330,1,3,0)
 ;;=3^Unlisted Cardiovascular Procedure
 ;;^UTILITY(U,$J,358.3,1331,0)
 ;;=93015^^10^119^1^^^^1
 ;;^UTILITY(U,$J,358.3,1331,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1331,1,2,0)
 ;;=2^93015
 ;;^UTILITY(U,$J,358.3,1331,1,3,0)
 ;;=3^Cardiovascular Stress Test
 ;;^UTILITY(U,$J,358.3,1332,0)
 ;;=93016^^10^119^5^^^^1
 ;;^UTILITY(U,$J,358.3,1332,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1332,1,2,0)
 ;;=2^93016
 ;;^UTILITY(U,$J,358.3,1332,1,3,0)
 ;;=3^Stress Test, Phy Super Only No Report
 ;;^UTILITY(U,$J,358.3,1333,0)
 ;;=93017^^10^119^6^^^^1
 ;;^UTILITY(U,$J,358.3,1333,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1333,1,2,0)
 ;;=2^93017
 ;;^UTILITY(U,$J,358.3,1333,1,3,0)
 ;;=3^Stress Test, Tracing Only
 ;;^UTILITY(U,$J,358.3,1334,0)
 ;;=93018^^10^119^4^^^^1
 ;;^UTILITY(U,$J,358.3,1334,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1334,1,2,0)
 ;;=2^93018
 ;;^UTILITY(U,$J,358.3,1334,1,3,0)
 ;;=3^Stress Test, Interr & Report Only
 ;;^UTILITY(U,$J,358.3,1335,0)
 ;;=78451^^10^119^2^^^^1
 ;;^UTILITY(U,$J,358.3,1335,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1335,1,2,0)
 ;;=2^78451
 ;;^UTILITY(U,$J,358.3,1335,1,3,0)
 ;;=3^SPECT,Single Study
 ;;^UTILITY(U,$J,358.3,1336,0)
 ;;=93350^^10^119^3^^^^1
 ;;^UTILITY(U,$J,358.3,1336,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1336,1,2,0)
 ;;=2^93350
 ;;^UTILITY(U,$J,358.3,1336,1,3,0)
 ;;=3^Stress TTE Only
 ;;^UTILITY(U,$J,358.3,1337,0)
 ;;=410.01^^11^120^13
 ;;^UTILITY(U,$J,358.3,1337,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1337,1,4,0)
 ;;=4^410.01
 ;;^UTILITY(U,$J,358.3,1337,1,5,0)
 ;;=5^Acute MI, Anterolateral, Initial
 ;;^UTILITY(U,$J,358.3,1337,2)
 ;;=Acute MI, Anterolateral, Initial^269639
 ;;^UTILITY(U,$J,358.3,1338,0)
 ;;=410.02^^11^120^6
 ;;^UTILITY(U,$J,358.3,1338,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1338,1,4,0)
 ;;=4^410.02
 ;;^UTILITY(U,$J,358.3,1338,1,5,0)
 ;;=5^Acute MI Anterolateral, Subsequent
 ;;^UTILITY(U,$J,358.3,1338,2)
 ;;=Acute MI Anterolateral, Subsequent^269640
 ;;^UTILITY(U,$J,358.3,1339,0)
 ;;=410.11^^11^120^11
 ;;^UTILITY(U,$J,358.3,1339,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1339,1,4,0)
 ;;=4^410.11
 ;;^UTILITY(U,$J,358.3,1339,1,5,0)
 ;;=5^Acute MI, Anterior, Initial
 ;;^UTILITY(U,$J,358.3,1339,2)
 ;;=Acute MI, Anterior, Initial^269643
 ;;^UTILITY(U,$J,358.3,1340,0)
 ;;=410.12^^11^120^12
 ;;^UTILITY(U,$J,358.3,1340,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1340,1,4,0)
 ;;=4^410.12
 ;;^UTILITY(U,$J,358.3,1340,1,5,0)
 ;;=5^Acute MI, Anterior, Subsequent
 ;;^UTILITY(U,$J,358.3,1340,2)
 ;;=Acute MI, Anterior, Subsequent^269644
 ;;^UTILITY(U,$J,358.3,1341,0)
 ;;=410.21^^11^120^15
 ;;^UTILITY(U,$J,358.3,1341,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1341,1,4,0)
 ;;=4^410.21
 ;;^UTILITY(U,$J,358.3,1341,1,5,0)
 ;;=5^Acute MI, Inferolateral, Initial
 ;;^UTILITY(U,$J,358.3,1341,2)
 ;;=Acute MI, Inferolateral, Initial^269647
 ;;^UTILITY(U,$J,358.3,1342,0)
 ;;=410.22^^11^120^14
 ;;^UTILITY(U,$J,358.3,1342,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1342,1,4,0)
 ;;=4^410.22
 ;;^UTILITY(U,$J,358.3,1342,1,5,0)
 ;;=5^Acute MI, Inferior, Subsequent
 ;;^UTILITY(U,$J,358.3,1342,2)
 ;;=Acute MI, Inferior, Subsequent^269648
 ;;^UTILITY(U,$J,358.3,1343,0)
 ;;=410.31^^11^120^17
 ;;^UTILITY(U,$J,358.3,1343,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,1343,1,4,0)
 ;;=4^410.31
 ;;^UTILITY(U,$J,358.3,1343,1,5,0)
 ;;=5^Acute MI, Inferopostior, Initial
 ;;^UTILITY(U,$J,358.3,1343,2)
 ;;=Acute MI, Inferopostior, Initial^269651
 ;;^UTILITY(U,$J,358.3,1344,0)
 ;;=410.32^^11^120^16
