IBDEI0H0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7600,0)
 ;;=K52.9^^52^509^2
 ;;^UTILITY(U,$J,358.3,7600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7600,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective,Unspec
 ;;^UTILITY(U,$J,358.3,7600,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,7600,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,7601,0)
 ;;=N12.^^52^509^7
 ;;^UTILITY(U,$J,358.3,7601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7601,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,7601,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,7601,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,7602,0)
 ;;=L97.509^^52^509^4
 ;;^UTILITY(U,$J,358.3,7602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7602,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Unspec Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,7602,1,4,0)
 ;;=4^L97.509
 ;;^UTILITY(U,$J,358.3,7602,2)
 ;;=^5009544
 ;;^UTILITY(U,$J,358.3,7603,0)
 ;;=M86.10^^52^509^5
 ;;^UTILITY(U,$J,358.3,7603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7603,1,3,0)
 ;;=3^Osteomylitis,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,7603,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,7603,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,7604,0)
 ;;=E85.9^^52^510^1
 ;;^UTILITY(U,$J,358.3,7604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7604,1,3,0)
 ;;=3^Amyloidosis,Unspec
 ;;^UTILITY(U,$J,358.3,7604,1,4,0)
 ;;=4^E85.9
 ;;^UTILITY(U,$J,358.3,7604,2)
 ;;=^334185
 ;;^UTILITY(U,$J,358.3,7605,0)
 ;;=N00.9^^52^510^3
 ;;^UTILITY(U,$J,358.3,7605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7605,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Acute
 ;;^UTILITY(U,$J,358.3,7605,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,7605,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,7606,0)
 ;;=N08.^^52^510^2
 ;;^UTILITY(U,$J,358.3,7606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7606,1,3,0)
 ;;=3^Glomerular Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,7606,1,4,0)
 ;;=4^N08.
 ;;^UTILITY(U,$J,358.3,7606,2)
 ;;=^5015569
 ;;^UTILITY(U,$J,358.3,7607,0)
 ;;=N03.9^^52^510^4
 ;;^UTILITY(U,$J,358.3,7607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7607,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Chronic
 ;;^UTILITY(U,$J,358.3,7607,1,4,0)
 ;;=4^N03.9
 ;;^UTILITY(U,$J,358.3,7607,2)
 ;;=^5015530
 ;;^UTILITY(U,$J,358.3,7608,0)
 ;;=N05.8^^52^511^1
 ;;^UTILITY(U,$J,358.3,7608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7608,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Unspec
 ;;^UTILITY(U,$J,358.3,7608,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,7608,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,7609,0)
 ;;=M30.0^^52^512^2
 ;;^UTILITY(U,$J,358.3,7609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7609,1,3,0)
 ;;=3^Polyarteritis Nodosa
 ;;^UTILITY(U,$J,358.3,7609,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,7609,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,7610,0)
 ;;=N04.9^^52^512^1
 ;;^UTILITY(U,$J,358.3,7610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7610,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Morphologic Changes
 ;;^UTILITY(U,$J,358.3,7610,1,4,0)
 ;;=4^N04.9
 ;;^UTILITY(U,$J,358.3,7610,2)
 ;;=^5015540
 ;;^UTILITY(U,$J,358.3,7611,0)
 ;;=N13.30^^52^513^2
 ;;^UTILITY(U,$J,358.3,7611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7611,1,3,0)
 ;;=3^Hydronephrosis,Unspec
 ;;^UTILITY(U,$J,358.3,7611,1,4,0)
 ;;=4^N13.30
 ;;^UTILITY(U,$J,358.3,7611,2)
 ;;=^5015578
 ;;^UTILITY(U,$J,358.3,7612,0)
 ;;=N13.9^^52^513^12
 ;;^UTILITY(U,$J,358.3,7612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7612,1,3,0)
 ;;=3^Uropathy,Obstructive & Reflux,Unspec
 ;;^UTILITY(U,$J,358.3,7612,1,4,0)
 ;;=4^N13.9
 ;;^UTILITY(U,$J,358.3,7612,2)
 ;;=^5015589
 ;;^UTILITY(U,$J,358.3,7613,0)
 ;;=N40.1^^52^513^1
