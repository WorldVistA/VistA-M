IBDEI0BI ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5201,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,5201,2)
 ;;=^5000555
 ;;^UTILITY(U,$J,358.3,5202,0)
 ;;=J18.9^^27^335^6
 ;;^UTILITY(U,$J,358.3,5202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5202,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,5202,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,5202,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,5203,0)
 ;;=J10.1^^27^335^1
 ;;^UTILITY(U,$J,358.3,5203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5203,1,3,0)
 ;;=3^Flu w/ Respiratory Manifestations
 ;;^UTILITY(U,$J,358.3,5203,1,4,0)
 ;;=4^J10.1
 ;;^UTILITY(U,$J,358.3,5203,2)
 ;;=^5008151
 ;;^UTILITY(U,$J,358.3,5204,0)
 ;;=K52.9^^27^335^2
 ;;^UTILITY(U,$J,358.3,5204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5204,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective,Unspec
 ;;^UTILITY(U,$J,358.3,5204,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,5204,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,5205,0)
 ;;=N12.^^27^335^7
 ;;^UTILITY(U,$J,358.3,5205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5205,1,3,0)
 ;;=3^Tubulo-Interstitial Nephritis
 ;;^UTILITY(U,$J,358.3,5205,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,5205,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,5206,0)
 ;;=L97.509^^27^335^4
 ;;^UTILITY(U,$J,358.3,5206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5206,1,3,0)
 ;;=3^Non-Pressure Chr Ulcer Unspec Foot w/ Unspec Severity
 ;;^UTILITY(U,$J,358.3,5206,1,4,0)
 ;;=4^L97.509
 ;;^UTILITY(U,$J,358.3,5206,2)
 ;;=^5009544
 ;;^UTILITY(U,$J,358.3,5207,0)
 ;;=M86.10^^27^335^5
 ;;^UTILITY(U,$J,358.3,5207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5207,1,3,0)
 ;;=3^Osteomylitis,Acute,Unspec Site
 ;;^UTILITY(U,$J,358.3,5207,1,4,0)
 ;;=4^M86.10
 ;;^UTILITY(U,$J,358.3,5207,2)
 ;;=^5014521
 ;;^UTILITY(U,$J,358.3,5208,0)
 ;;=E85.9^^27^336^1
 ;;^UTILITY(U,$J,358.3,5208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5208,1,3,0)
 ;;=3^Amyloidosis,Unspec
 ;;^UTILITY(U,$J,358.3,5208,1,4,0)
 ;;=4^E85.9
 ;;^UTILITY(U,$J,358.3,5208,2)
 ;;=^334185
 ;;^UTILITY(U,$J,358.3,5209,0)
 ;;=N00.9^^27^336^3
 ;;^UTILITY(U,$J,358.3,5209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5209,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Acute
 ;;^UTILITY(U,$J,358.3,5209,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,5209,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,5210,0)
 ;;=N08.^^27^336^2
 ;;^UTILITY(U,$J,358.3,5210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5210,1,3,0)
 ;;=3^Glomerular Disorders in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,5210,1,4,0)
 ;;=4^N08.
 ;;^UTILITY(U,$J,358.3,5210,2)
 ;;=^5015569
 ;;^UTILITY(U,$J,358.3,5211,0)
 ;;=N03.9^^27^336^4
 ;;^UTILITY(U,$J,358.3,5211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5211,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Chronic
 ;;^UTILITY(U,$J,358.3,5211,1,4,0)
 ;;=4^N03.9
 ;;^UTILITY(U,$J,358.3,5211,2)
 ;;=^5015530
 ;;^UTILITY(U,$J,358.3,5212,0)
 ;;=N05.8^^27^337^1
 ;;^UTILITY(U,$J,358.3,5212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5212,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Unspec
 ;;^UTILITY(U,$J,358.3,5212,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,5212,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,5213,0)
 ;;=M30.0^^27^338^2
 ;;^UTILITY(U,$J,358.3,5213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5213,1,3,0)
 ;;=3^Polyarteritis Nodosa
 ;;^UTILITY(U,$J,358.3,5213,1,4,0)
 ;;=4^M30.0
 ;;^UTILITY(U,$J,358.3,5213,2)
 ;;=^5011738
 ;;^UTILITY(U,$J,358.3,5214,0)
 ;;=N04.9^^27^338^1
 ;;^UTILITY(U,$J,358.3,5214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5214,1,3,0)
 ;;=3^Nephrotic Syndrome w/ Morphologic Changes
 ;;^UTILITY(U,$J,358.3,5214,1,4,0)
 ;;=4^N04.9
