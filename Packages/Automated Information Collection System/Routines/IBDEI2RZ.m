IBDEI2RZ ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46590,1,4,0)
 ;;=4^H60.592
 ;;^UTILITY(U,$J,358.3,46590,2)
 ;;=^5133527
 ;;^UTILITY(U,$J,358.3,46591,0)
 ;;=H60.591^^206^2304^66
 ;;^UTILITY(U,$J,358.3,46591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46591,1,3,0)
 ;;=3^Noninfective AC Otitis Externa,Right Ear NEC
 ;;^UTILITY(U,$J,358.3,46591,1,4,0)
 ;;=4^H60.591
 ;;^UTILITY(U,$J,358.3,46591,2)
 ;;=^5006490
 ;;^UTILITY(U,$J,358.3,46592,0)
 ;;=J18.8^^206^2304^73
 ;;^UTILITY(U,$J,358.3,46592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46592,1,3,0)
 ;;=3^Pneumonia,Unspec Organism NEC
 ;;^UTILITY(U,$J,358.3,46592,1,4,0)
 ;;=4^J18.8
 ;;^UTILITY(U,$J,358.3,46592,2)
 ;;=^5008185
 ;;^UTILITY(U,$J,358.3,46593,0)
 ;;=B44.1^^206^2304^76
 ;;^UTILITY(U,$J,358.3,46593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46593,1,3,0)
 ;;=3^Pulmonary Aspergillosis NEC
 ;;^UTILITY(U,$J,358.3,46593,1,4,0)
 ;;=4^B44.1
 ;;^UTILITY(U,$J,358.3,46593,2)
 ;;=^5000664
 ;;^UTILITY(U,$J,358.3,46594,0)
 ;;=B48.4^^206^2304^68
 ;;^UTILITY(U,$J,358.3,46594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46594,1,3,0)
 ;;=3^Penicillosis
 ;;^UTILITY(U,$J,358.3,46594,1,4,0)
 ;;=4^B48.4
 ;;^UTILITY(U,$J,358.3,46594,2)
 ;;=^5000688
 ;;^UTILITY(U,$J,358.3,46595,0)
 ;;=J14.^^206^2304^69
 ;;^UTILITY(U,$J,358.3,46595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46595,1,3,0)
 ;;=3^Pneumonia d/t Hemophilus Influenzae
 ;;^UTILITY(U,$J,358.3,46595,1,4,0)
 ;;=4^J14.
 ;;^UTILITY(U,$J,358.3,46595,2)
 ;;=^5008171
 ;;^UTILITY(U,$J,358.3,46596,0)
 ;;=J13.^^206^2304^70
 ;;^UTILITY(U,$J,358.3,46596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46596,1,3,0)
 ;;=3^Pneumonia d/t Streptococcus Pneumoniae
 ;;^UTILITY(U,$J,358.3,46596,1,4,0)
 ;;=4^J13.
 ;;^UTILITY(U,$J,358.3,46596,2)
 ;;=^5008170
 ;;^UTILITY(U,$J,358.3,46597,0)
 ;;=J17.^^206^2304^71
 ;;^UTILITY(U,$J,358.3,46597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46597,1,3,0)
 ;;=3^Pneumonia in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,46597,1,4,0)
 ;;=4^J17.
 ;;^UTILITY(U,$J,358.3,46597,2)
 ;;=^5008181
 ;;^UTILITY(U,$J,358.3,46598,0)
 ;;=J18.9^^206^2304^72
 ;;^UTILITY(U,$J,358.3,46598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46598,1,3,0)
 ;;=3^Pneumonia,Unspec Organism
 ;;^UTILITY(U,$J,358.3,46598,1,4,0)
 ;;=4^J18.9
 ;;^UTILITY(U,$J,358.3,46598,2)
 ;;=^95632
 ;;^UTILITY(U,$J,358.3,46599,0)
 ;;=A15.7^^206^2304^74
 ;;^UTILITY(U,$J,358.3,46599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46599,1,3,0)
 ;;=3^Primary Respiratory TB
 ;;^UTILITY(U,$J,358.3,46599,1,4,0)
 ;;=4^A15.7
 ;;^UTILITY(U,$J,358.3,46599,2)
 ;;=^5000065
 ;;^UTILITY(U,$J,358.3,46600,0)
 ;;=A42.0^^206^2304^75
 ;;^UTILITY(U,$J,358.3,46600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46600,1,3,0)
 ;;=3^Pulmonary Actinomycosis
 ;;^UTILITY(U,$J,358.3,46600,1,4,0)
 ;;=4^A42.0
 ;;^UTILITY(U,$J,358.3,46600,2)
 ;;=^5000215
 ;;^UTILITY(U,$J,358.3,46601,0)
 ;;=B40.2^^206^2304^77
 ;;^UTILITY(U,$J,358.3,46601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46601,1,3,0)
 ;;=3^Pulmonary Blastomycosis,Unspec
 ;;^UTILITY(U,$J,358.3,46601,1,4,0)
 ;;=4^B40.2
 ;;^UTILITY(U,$J,358.3,46601,2)
 ;;=^5000641
 ;;^UTILITY(U,$J,358.3,46602,0)
 ;;=B38.2^^206^2304^78
 ;;^UTILITY(U,$J,358.3,46602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46602,1,3,0)
 ;;=3^Pulmonary Coccidiodomycosis,Unspec
 ;;^UTILITY(U,$J,358.3,46602,1,4,0)
 ;;=4^B38.2
 ;;^UTILITY(U,$J,358.3,46602,2)
 ;;=^295703
 ;;^UTILITY(U,$J,358.3,46603,0)
 ;;=B45.0^^206^2304^79
 ;;^UTILITY(U,$J,358.3,46603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46603,1,3,0)
 ;;=3^Pulmonary Cryptococcosis
 ;;^UTILITY(U,$J,358.3,46603,1,4,0)
 ;;=4^B45.0