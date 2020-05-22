IBDEI0GH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7138,0)
 ;;=R51.^^58^469^8
 ;;^UTILITY(U,$J,358.3,7138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7138,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,7138,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,7138,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,7139,0)
 ;;=R52.^^58^469^15
 ;;^UTILITY(U,$J,358.3,7139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7139,1,3,0)
 ;;=3^Pain,Unspec
 ;;^UTILITY(U,$J,358.3,7139,1,4,0)
 ;;=4^R52.
 ;;^UTILITY(U,$J,358.3,7139,2)
 ;;=^5019514
 ;;^UTILITY(U,$J,358.3,7140,0)
 ;;=R53.82^^58^469^4
 ;;^UTILITY(U,$J,358.3,7140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7140,1,3,0)
 ;;=3^Chronic Fatigue,Unspec
 ;;^UTILITY(U,$J,358.3,7140,1,4,0)
 ;;=4^R53.82
 ;;^UTILITY(U,$J,358.3,7140,2)
 ;;=^5019519
 ;;^UTILITY(U,$J,358.3,7141,0)
 ;;=R68.84^^58^469^10
 ;;^UTILITY(U,$J,358.3,7141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7141,1,3,0)
 ;;=3^Jaw Pain
 ;;^UTILITY(U,$J,358.3,7141,1,4,0)
 ;;=4^R68.84
 ;;^UTILITY(U,$J,358.3,7141,2)
 ;;=^5019556
 ;;^UTILITY(U,$J,358.3,7142,0)
 ;;=F10.10^^58^470^2
 ;;^UTILITY(U,$J,358.3,7142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7142,1,3,0)
 ;;=3^Alcohol Abuse,Mild,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7142,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,7142,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,7143,0)
 ;;=F10.14^^58^470^8
 ;;^UTILITY(U,$J,358.3,7143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7143,1,3,0)
 ;;=3^Alcohol Induced Mood D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,7143,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,7143,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,7144,0)
 ;;=F10.20^^58^470^7
 ;;^UTILITY(U,$J,358.3,7144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7144,1,3,0)
 ;;=3^Alcohol Dependence,Mod/Sev,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7144,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,7144,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,7145,0)
 ;;=F10.230^^58^470^5
 ;;^UTILITY(U,$J,358.3,7145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7145,1,3,0)
 ;;=3^Alcohol Dependence,Mod/Sev w/ Withdrawal,Uncomplicated
 ;;^UTILITY(U,$J,358.3,7145,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,7145,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,7146,0)
 ;;=F10.239^^58^470^6
 ;;^UTILITY(U,$J,358.3,7146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7146,1,3,0)
 ;;=3^Alcohol Dependence,Mod/Sev w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,7146,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,7146,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,7147,0)
 ;;=F10.24^^58^470^3
 ;;^UTILITY(U,$J,358.3,7147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7147,1,3,0)
 ;;=3^Alcohol Dependence,Mod/Sev w/ Alcohol-Induced Mood D/O
 ;;^UTILITY(U,$J,358.3,7147,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,7147,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,7148,0)
 ;;=F10.288^^58^470^4
 ;;^UTILITY(U,$J,358.3,7148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7148,1,3,0)
 ;;=3^Alcohol Dependence,Mod/Sev w/ Oth Alcohol-Induced D/O
 ;;^UTILITY(U,$J,358.3,7148,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,7148,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,7149,0)
 ;;=F10.94^^58^470^9
 ;;^UTILITY(U,$J,358.3,7149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7149,1,3,0)
 ;;=3^Alcohol Induced Mood D/O w/ Unspec Alcohol Use
 ;;^UTILITY(U,$J,358.3,7149,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,7149,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,7150,0)
 ;;=F11.20^^58^470^16
 ;;^UTILITY(U,$J,358.3,7150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7150,1,3,0)
 ;;=3^Opioid Dependence,Mod/Sev,Uncomplicated
