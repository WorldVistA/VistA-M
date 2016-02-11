IBDEI0IY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8521,1,4,0)
 ;;=4^J11.1
 ;;^UTILITY(U,$J,358.3,8521,2)
 ;;=^5008158
 ;;^UTILITY(U,$J,358.3,8522,0)
 ;;=K52.9^^55^540^81
 ;;^UTILITY(U,$J,358.3,8522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8522,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis, unspecified
 ;;^UTILITY(U,$J,358.3,8522,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,8522,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,8523,0)
 ;;=K57.32^^55^540^55
 ;;^UTILITY(U,$J,358.3,8523,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8523,1,3,0)
 ;;=3^Dvtrcli of lg int w/o perforation or abscess w/o bleeding
 ;;^UTILITY(U,$J,358.3,8523,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,8523,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,8524,0)
 ;;=K70.10^^55^540^25
 ;;^UTILITY(U,$J,358.3,8524,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8524,1,3,0)
 ;;=3^Alcoholic hepatitis without ascites
 ;;^UTILITY(U,$J,358.3,8524,1,4,0)
 ;;=4^K70.10
 ;;^UTILITY(U,$J,358.3,8524,2)
 ;;=^5008785
 ;;^UTILITY(U,$J,358.3,8525,0)
 ;;=K73.0^^55^540^45
 ;;^UTILITY(U,$J,358.3,8525,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8525,1,3,0)
 ;;=3^Chronic persistent hepatitis, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,8525,1,4,0)
 ;;=4^K73.0
 ;;^UTILITY(U,$J,358.3,8525,2)
 ;;=^5008811
 ;;^UTILITY(U,$J,358.3,8526,0)
 ;;=N12.^^55^540^104
 ;;^UTILITY(U,$J,358.3,8526,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8526,1,3,0)
 ;;=3^Tubulo-interstitial nephritis, not spcf as acute or chronic
 ;;^UTILITY(U,$J,358.3,8526,1,4,0)
 ;;=4^N12.
 ;;^UTILITY(U,$J,358.3,8526,2)
 ;;=^5015575
 ;;^UTILITY(U,$J,358.3,8527,0)
 ;;=N30.90^^55^540^51
 ;;^UTILITY(U,$J,358.3,8527,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8527,1,3,0)
 ;;=3^Cystitis, unspecified without hematuria
 ;;^UTILITY(U,$J,358.3,8527,1,4,0)
 ;;=4^N30.90
 ;;^UTILITY(U,$J,358.3,8527,2)
 ;;=^5015642
 ;;^UTILITY(U,$J,358.3,8528,0)
 ;;=N30.91^^55^540^50
 ;;^UTILITY(U,$J,358.3,8528,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8528,1,3,0)
 ;;=3^Cystitis, unspecified with hematuria
 ;;^UTILITY(U,$J,358.3,8528,1,4,0)
 ;;=4^N30.91
 ;;^UTILITY(U,$J,358.3,8528,2)
 ;;=^5015643
 ;;^UTILITY(U,$J,358.3,8529,0)
 ;;=N34.1^^55^540^83
 ;;^UTILITY(U,$J,358.3,8529,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8529,1,3,0)
 ;;=3^Nonspecific urethritis
 ;;^UTILITY(U,$J,358.3,8529,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,8529,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,8530,0)
 ;;=N39.0^^55^540^107
 ;;^UTILITY(U,$J,358.3,8530,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8530,1,3,0)
 ;;=3^Urinary tract infection, site not specified
 ;;^UTILITY(U,$J,358.3,8530,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,8530,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,8531,0)
 ;;=N41.9^^55^540^74
 ;;^UTILITY(U,$J,358.3,8531,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8531,1,3,0)
 ;;=3^Inflammatory disease of prostate, unspecified
 ;;^UTILITY(U,$J,358.3,8531,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,8531,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,8532,0)
 ;;=N45.1^^55^540^58
 ;;^UTILITY(U,$J,358.3,8532,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8532,1,3,0)
 ;;=3^Epididymitis
 ;;^UTILITY(U,$J,358.3,8532,1,4,0)
 ;;=4^N45.1
 ;;^UTILITY(U,$J,358.3,8532,2)
 ;;=^41396
 ;;^UTILITY(U,$J,358.3,8533,0)
 ;;=N70.93^^55^540^94
 ;;^UTILITY(U,$J,358.3,8533,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8533,1,3,0)
 ;;=3^Salpingitis and oophoritis, unspecified
 ;;^UTILITY(U,$J,358.3,8533,1,4,0)
 ;;=4^N70.93
 ;;^UTILITY(U,$J,358.3,8533,2)
 ;;=^5015808
 ;;^UTILITY(U,$J,358.3,8534,0)
 ;;=N70.91^^55^540^95
 ;;^UTILITY(U,$J,358.3,8534,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8534,1,3,0)
 ;;=3^Salpingitis, unspecified
