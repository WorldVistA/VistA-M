IBDEI20Z ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33939,0)
 ;;=L97.509^^154^1713^4
 ;;^UTILITY(U,$J,358.3,33939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33939,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Unspec Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,33939,1,4,0)
 ;;=4^L97.509
 ;;^UTILITY(U,$J,358.3,33939,2)
 ;;=^5009544
 ;;^UTILITY(U,$J,358.3,33940,0)
 ;;=M86.10^^154^1713^5
 ;;^UTILITY(U,$J,358.3,33940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33940,1,3,0)
 ;;=3^Osteomylitis,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,33940,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,33940,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,33941,0)
 ;;=E85.9^^154^1714^1
 ;;^UTILITY(U,$J,358.3,33941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33941,1,3,0)
 ;;=3^Amyloidosis,Unspec
 ;;^UTILITY(U,$J,358.3,33941,1,4,0)
 ;;=4^E85.9
 ;;^UTILITY(U,$J,358.3,33941,2)
 ;;=^334185
 ;;^UTILITY(U,$J,358.3,33942,0)
 ;;=N00.9^^154^1714^3
 ;;^UTILITY(U,$J,358.3,33942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33942,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Acute
 ;;^UTILITY(U,$J,358.3,33942,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,33942,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,33943,0)
 ;;=N08.^^154^1714^2
 ;;^UTILITY(U,$J,358.3,33943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33943,1,3,0)
 ;;=3^Glomerular Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,33943,1,4,0)
 ;;=4^N08.
 ;;^UTILITY(U,$J,358.3,33943,2)
 ;;=^5015569
 ;;^UTILITY(U,$J,358.3,33944,0)
 ;;=N03.9^^154^1714^4
 ;;^UTILITY(U,$J,358.3,33944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33944,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Chronic
 ;;^UTILITY(U,$J,358.3,33944,1,4,0)
 ;;=4^N03.9
 ;;^UTILITY(U,$J,358.3,33944,2)
 ;;=^5015530
 ;;^UTILITY(U,$J,358.3,33945,0)
 ;;=N05.8^^154^1715^1
 ;;^UTILITY(U,$J,358.3,33945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33945,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Unspec
 ;;^UTILITY(U,$J,358.3,33945,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,33945,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,33946,0)
 ;;=M30.0^^154^1716^2
 ;;^UTILITY(U,$J,358.3,33946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33946,1,3,0)
 ;;=3^Polyarteritis Nodosa
 ;;^UTILITY(U,$J,358.3,33946,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,33946,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,33947,0)
 ;;=N04.9^^154^1716^1
 ;;^UTILITY(U,$J,358.3,33947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33947,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Morphologic Changes
 ;;^UTILITY(U,$J,358.3,33947,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,33947,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,33948,0)
 ;;=N13.30^^154^1717^2
 ;;^UTILITY(U,$J,358.3,33948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33948,1,3,0)
 ;;=3^Hydronephrosis,Unspec
 ;;^UTILITY(U,$J,358.3,33948,1,4,0)
 ;;=4^N13.30
 ;;^UTILITY(U,$J,358.3,33948,2)
 ;;=^5015578
 ;;^UTILITY(U,$J,358.3,33949,0)
 ;;=N13.9^^154^1717^12
 ;;^UTILITY(U,$J,358.3,33949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33949,1,3,0)
 ;;=3^Uropathy,Obstructive & Reflux,Unspec
 ;;^UTILITY(U,$J,358.3,33949,1,4,0)
 ;;=4^N13.9
 ;;^UTILITY(U,$J,358.3,33949,2)
 ;;=^5015589
 ;;^UTILITY(U,$J,358.3,33950,0)
 ;;=N40.1^^154^1717^1
 ;;^UTILITY(U,$J,358.3,33950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33950,1,3,0)
 ;;=3^Enlarged Prostate w/ LUTS
 ;;^UTILITY(U,$J,358.3,33950,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,33950,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,33951,0)
 ;;=R39.14^^154^1717^3
 ;;^UTILITY(U,$J,358.3,33951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33951,1,3,0)
 ;;=3^Incomplete Bladder Emptying
 ;;^UTILITY(U,$J,358.3,33951,1,4,0)
 ;;=4^R39.14
