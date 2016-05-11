IBDEI0FP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7247,1,4,0)
 ;;=4^D86.82
 ;;^UTILITY(U,$J,358.3,7247,2)
 ;;=^5002447
 ;;^UTILITY(U,$J,358.3,7248,0)
 ;;=D86.84^^30^406^50
 ;;^UTILITY(U,$J,358.3,7248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7248,1,3,0)
 ;;=3^Sarcoid Pyelonephritis
 ;;^UTILITY(U,$J,358.3,7248,1,4,0)
 ;;=4^D86.84
 ;;^UTILITY(U,$J,358.3,7248,2)
 ;;=^5002449
 ;;^UTILITY(U,$J,358.3,7249,0)
 ;;=D86.85^^30^406^48
 ;;^UTILITY(U,$J,358.3,7249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7249,1,3,0)
 ;;=3^Sarcoid Myocarditis
 ;;^UTILITY(U,$J,358.3,7249,1,4,0)
 ;;=4^D86.85
 ;;^UTILITY(U,$J,358.3,7249,2)
 ;;=^5002450
 ;;^UTILITY(U,$J,358.3,7250,0)
 ;;=D86.83^^30^406^46
 ;;^UTILITY(U,$J,358.3,7250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7250,1,3,0)
 ;;=3^Sarcoid Iridocyclitis
 ;;^UTILITY(U,$J,358.3,7250,1,4,0)
 ;;=4^D86.83
 ;;^UTILITY(U,$J,358.3,7250,2)
 ;;=^5002448
 ;;^UTILITY(U,$J,358.3,7251,0)
 ;;=D84.1^^30^406^20
 ;;^UTILITY(U,$J,358.3,7251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7251,1,3,0)
 ;;=3^Defects in Complement System
 ;;^UTILITY(U,$J,358.3,7251,1,4,0)
 ;;=4^D84.1
 ;;^UTILITY(U,$J,358.3,7251,2)
 ;;=^5002439
 ;;^UTILITY(U,$J,358.3,7252,0)
 ;;=D81.810^^30^406^6
 ;;^UTILITY(U,$J,358.3,7252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7252,1,3,0)
 ;;=3^Biotinidase Deficiency
 ;;^UTILITY(U,$J,358.3,7252,1,4,0)
 ;;=4^D81.810
 ;;^UTILITY(U,$J,358.3,7252,2)
 ;;=^5002422
 ;;^UTILITY(U,$J,358.3,7253,0)
 ;;=E88.01^^30^406^3
 ;;^UTILITY(U,$J,358.3,7253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7253,1,3,0)
 ;;=3^Apha-1 Antitrypsin Deficiency
 ;;^UTILITY(U,$J,358.3,7253,1,4,0)
 ;;=4^E88.01
 ;;^UTILITY(U,$J,358.3,7253,2)
 ;;=^331442
 ;;^UTILITY(U,$J,358.3,7254,0)
 ;;=J09.X1^^30^406^29
 ;;^UTILITY(U,$J,358.3,7254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7254,1,3,0)
 ;;=3^Influenza d/t Indent Novel Influenza A Virus w/ Pneumonia
 ;;^UTILITY(U,$J,358.3,7254,1,4,0)
 ;;=4^J09.X1
 ;;^UTILITY(U,$J,358.3,7254,2)
 ;;=^5008144
 ;;^UTILITY(U,$J,358.3,7255,0)
 ;;=J09.X2^^30^406^30
 ;;^UTILITY(U,$J,358.3,7255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7255,1,3,0)
 ;;=3^Influenza d/t Indent Novel Influenza A Virus w/ Resp Manifest
 ;;^UTILITY(U,$J,358.3,7255,1,4,0)
 ;;=4^J09.X2
 ;;^UTILITY(U,$J,358.3,7255,2)
 ;;=^5008145
 ;;^UTILITY(U,$J,358.3,7256,0)
 ;;=J09.X3^^30^406^31
 ;;^UTILITY(U,$J,358.3,7256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7256,1,3,0)
 ;;=3^Influenza d/t Indent Novel Influenza A Virus w/ GI Manifest
 ;;^UTILITY(U,$J,358.3,7256,1,4,0)
 ;;=4^J09.X3
 ;;^UTILITY(U,$J,358.3,7256,2)
 ;;=^5008146
 ;;^UTILITY(U,$J,358.3,7257,0)
 ;;=J09.X9^^30^406^32
 ;;^UTILITY(U,$J,358.3,7257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7257,1,3,0)
 ;;=3^Influenza d/t Indent Novel Influenza A Virus w/ Oth Manifest
 ;;^UTILITY(U,$J,358.3,7257,1,4,0)
 ;;=4^J09.X9
 ;;^UTILITY(U,$J,358.3,7257,2)
 ;;=^5008147
 ;;^UTILITY(U,$J,358.3,7258,0)
 ;;=J44.9^^30^406^18
 ;;^UTILITY(U,$J,358.3,7258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7258,1,3,0)
 ;;=3^COPD,Unspec
 ;;^UTILITY(U,$J,358.3,7258,1,4,0)
 ;;=4^J44.9
 ;;^UTILITY(U,$J,358.3,7258,2)
 ;;=^5008241
 ;;^UTILITY(U,$J,358.3,7259,0)
 ;;=J44.1^^30^406^16
 ;;^UTILITY(U,$J,358.3,7259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7259,1,3,0)
 ;;=3^COPD w/ Acute Exacerbation
 ;;^UTILITY(U,$J,358.3,7259,1,4,0)
 ;;=4^J44.1
 ;;^UTILITY(U,$J,358.3,7259,2)
 ;;=^5008240
 ;;^UTILITY(U,$J,358.3,7260,0)
 ;;=J42.^^30^406^14
 ;;^UTILITY(U,$J,358.3,7260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7260,1,3,0)
 ;;=3^Bronchitis,Unspec Chronic
 ;;^UTILITY(U,$J,358.3,7260,1,4,0)
 ;;=4^J42.
