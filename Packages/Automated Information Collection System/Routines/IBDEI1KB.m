IBDEI1KB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26120,1,3,0)
 ;;=3^Streptococcus in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26120,1,4,0)
 ;;=4^B95.5
 ;;^UTILITY(U,$J,358.3,26120,2)
 ;;=^5000840
 ;;^UTILITY(U,$J,358.3,26121,0)
 ;;=B95.0^^127^1272^95
 ;;^UTILITY(U,$J,358.3,26121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26121,1,3,0)
 ;;=3^Streptococcus,Group A,in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26121,1,4,0)
 ;;=4^B95.0
 ;;^UTILITY(U,$J,358.3,26121,2)
 ;;=^5000835
 ;;^UTILITY(U,$J,358.3,26122,0)
 ;;=B95.1^^127^1272^96
 ;;^UTILITY(U,$J,358.3,26122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26122,1,3,0)
 ;;=3^Streptococcus,Group B,in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26122,1,4,0)
 ;;=4^B95.1
 ;;^UTILITY(U,$J,358.3,26122,2)
 ;;=^5000836
 ;;^UTILITY(U,$J,358.3,26123,0)
 ;;=B95.4^^127^1272^94
 ;;^UTILITY(U,$J,358.3,26123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26123,1,3,0)
 ;;=3^Streptococcus in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,26123,1,4,0)
 ;;=4^B95.4
 ;;^UTILITY(U,$J,358.3,26123,2)
 ;;=^5000839
 ;;^UTILITY(U,$J,358.3,26124,0)
 ;;=B95.2^^127^1272^48
 ;;^UTILITY(U,$J,358.3,26124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26124,1,3,0)
 ;;=3^Enterococcus in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26124,1,4,0)
 ;;=4^B95.2
 ;;^UTILITY(U,$J,358.3,26124,2)
 ;;=^5000837
 ;;^UTILITY(U,$J,358.3,26125,0)
 ;;=B95.8^^127^1272^92
 ;;^UTILITY(U,$J,358.3,26125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26125,1,3,0)
 ;;=3^Staphylococcus,Unspec,in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26125,1,4,0)
 ;;=4^B95.8
 ;;^UTILITY(U,$J,358.3,26125,2)
 ;;=^5000844
 ;;^UTILITY(U,$J,358.3,26126,0)
 ;;=B95.61^^127^1272^77
 ;;^UTILITY(U,$J,358.3,26126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26126,1,3,0)
 ;;=3^Methicillin Suscept Staph Infct in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26126,1,4,0)
 ;;=4^B95.61
 ;;^UTILITY(U,$J,358.3,26126,2)
 ;;=^5000841
 ;;^UTILITY(U,$J,358.3,26127,0)
 ;;=B95.62^^127^1272^76
 ;;^UTILITY(U,$J,358.3,26127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26127,1,3,0)
 ;;=3^Methicillin Resist Staph Infct in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26127,1,4,0)
 ;;=4^B95.62
 ;;^UTILITY(U,$J,358.3,26127,2)
 ;;=^5000842
 ;;^UTILITY(U,$J,358.3,26128,0)
 ;;=B95.7^^127^1272^91
 ;;^UTILITY(U,$J,358.3,26128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26128,1,3,0)
 ;;=3^Staphylococcus in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26128,1,4,0)
 ;;=4^B95.7
 ;;^UTILITY(U,$J,358.3,26128,2)
 ;;=^5000843
 ;;^UTILITY(U,$J,358.3,26129,0)
 ;;=B96.1^^127^1272^70
 ;;^UTILITY(U,$J,358.3,26129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26129,1,3,0)
 ;;=3^Klebsiella Pneumoniae in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,26129,1,4,0)
 ;;=4^B96.1
 ;;^UTILITY(U,$J,358.3,26129,2)
 ;;=^5000846
 ;;^UTILITY(U,$J,358.3,26130,0)
 ;;=B96.20^^127^1272^49
 ;;^UTILITY(U,$J,358.3,26130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26130,1,3,0)
 ;;=3^Escherichia Coli in Diseases Classified Elsewhere,Unspec
 ;;^UTILITY(U,$J,358.3,26130,1,4,0)
 ;;=4^B96.20
 ;;^UTILITY(U,$J,358.3,26130,2)
 ;;=^5000847
 ;;^UTILITY(U,$J,358.3,26131,0)
 ;;=B96.29^^127^1272^50
 ;;^UTILITY(U,$J,358.3,26131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26131,1,3,0)
 ;;=3^Escherichia Coli in Diseases Classified Elsewhere NEC
 ;;^UTILITY(U,$J,358.3,26131,1,4,0)
 ;;=4^B96.29
 ;;^UTILITY(U,$J,358.3,26131,2)
 ;;=^5000851
 ;;^UTILITY(U,$J,358.3,26132,0)
 ;;=B20.^^127^1272^58
 ;;^UTILITY(U,$J,358.3,26132,1,0)
 ;;=^358.31IA^4^2
