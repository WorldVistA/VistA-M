IBDEI1XH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30798,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,30798,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,30799,0)
 ;;=K52.9^^123^1588^2
 ;;^UTILITY(U,$J,358.3,30799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30799,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective,Unspec
 ;;^UTILITY(U,$J,358.3,30799,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,30799,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,30800,0)
 ;;=N12.^^123^1588^7
 ;;^UTILITY(U,$J,358.3,30800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30800,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,30800,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,30800,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,30801,0)
 ;;=L97.509^^123^1588^4
 ;;^UTILITY(U,$J,358.3,30801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30801,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Unspec Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,30801,1,4,0)
 ;;=4^L97.509
 ;;^UTILITY(U,$J,358.3,30801,2)
 ;;=^5009544
 ;;^UTILITY(U,$J,358.3,30802,0)
 ;;=M86.10^^123^1588^5
 ;;^UTILITY(U,$J,358.3,30802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30802,1,3,0)
 ;;=3^Osteomylitis,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,30802,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,30802,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,30803,0)
 ;;=E85.9^^123^1589^1
 ;;^UTILITY(U,$J,358.3,30803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30803,1,3,0)
 ;;=3^Amyloidosis,Unspec
 ;;^UTILITY(U,$J,358.3,30803,1,4,0)
 ;;=4^E85.9
 ;;^UTILITY(U,$J,358.3,30803,2)
 ;;=^334185
 ;;^UTILITY(U,$J,358.3,30804,0)
 ;;=N00.9^^123^1589^3
 ;;^UTILITY(U,$J,358.3,30804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30804,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Acute
 ;;^UTILITY(U,$J,358.3,30804,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,30804,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,30805,0)
 ;;=N08.^^123^1589^2
 ;;^UTILITY(U,$J,358.3,30805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30805,1,3,0)
 ;;=3^Glomerular Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,30805,1,4,0)
 ;;=4^N08.
 ;;^UTILITY(U,$J,358.3,30805,2)
 ;;=^5015569
 ;;^UTILITY(U,$J,358.3,30806,0)
 ;;=N03.9^^123^1589^4
 ;;^UTILITY(U,$J,358.3,30806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30806,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Chronic
 ;;^UTILITY(U,$J,358.3,30806,1,4,0)
 ;;=4^N03.9
 ;;^UTILITY(U,$J,358.3,30806,2)
 ;;=^5015530
 ;;^UTILITY(U,$J,358.3,30807,0)
 ;;=N05.8^^123^1590^1
 ;;^UTILITY(U,$J,358.3,30807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30807,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Unspec
 ;;^UTILITY(U,$J,358.3,30807,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,30807,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,30808,0)
 ;;=M30.0^^123^1591^2
 ;;^UTILITY(U,$J,358.3,30808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30808,1,3,0)
 ;;=3^Polyarteritis Nodosa
 ;;^UTILITY(U,$J,358.3,30808,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,30808,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,30809,0)
 ;;=N04.9^^123^1591^1
 ;;^UTILITY(U,$J,358.3,30809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30809,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Morphologic Changes
 ;;^UTILITY(U,$J,358.3,30809,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,30809,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,30810,0)
 ;;=N13.30^^123^1592^2
 ;;^UTILITY(U,$J,358.3,30810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30810,1,3,0)
 ;;=3^Hydronephrosis,Unspec
 ;;^UTILITY(U,$J,358.3,30810,1,4,0)
 ;;=4^N13.30
