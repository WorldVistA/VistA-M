IBDEI0EE ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6185,1,2,0)
 ;;=2^99404
 ;;^UTILITY(U,$J,358.3,6185,1,3,0)
 ;;=3^Preventive Counseling,60 min
 ;;^UTILITY(U,$J,358.3,6186,0)
 ;;=99411^^52^400^5^^^^1
 ;;^UTILITY(U,$J,358.3,6186,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6186,1,2,0)
 ;;=2^99411
 ;;^UTILITY(U,$J,358.3,6186,1,3,0)
 ;;=3^Preventive Counseling,Grp Setting,30 Min
 ;;^UTILITY(U,$J,358.3,6187,0)
 ;;=99412^^52^400^6^^^^1
 ;;^UTILITY(U,$J,358.3,6187,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6187,1,2,0)
 ;;=2^99412
 ;;^UTILITY(U,$J,358.3,6187,1,3,0)
 ;;=3^Preventive Counseling,Grp Setting,60 Min
 ;;^UTILITY(U,$J,358.3,6188,0)
 ;;=99152^^52^401^1^^^^1
 ;;^UTILITY(U,$J,358.3,6188,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6188,1,2,0)
 ;;=2^99152
 ;;^UTILITY(U,$J,358.3,6188,1,3,0)
 ;;=3^MS by Same/Supr MD/QHCP,1st 15 min
 ;;^UTILITY(U,$J,358.3,6189,0)
 ;;=99153^^52^401^2^^^^1
 ;;^UTILITY(U,$J,358.3,6189,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6189,1,2,0)
 ;;=2^99153
 ;;^UTILITY(U,$J,358.3,6189,1,3,0)
 ;;=3^MS by Same/Supr MD/QHCP,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,6190,0)
 ;;=99156^^52^401^3^^^^1
 ;;^UTILITY(U,$J,358.3,6190,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6190,1,2,0)
 ;;=2^99156
 ;;^UTILITY(U,$J,358.3,6190,1,3,0)
 ;;=3^MS by Oth MD/QHCP,1st 15 min
 ;;^UTILITY(U,$J,358.3,6191,0)
 ;;=99157^^52^401^4^^^^1
 ;;^UTILITY(U,$J,358.3,6191,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6191,1,2,0)
 ;;=2^99157
 ;;^UTILITY(U,$J,358.3,6191,1,3,0)
 ;;=3^MS by Oth MD/QHCP,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,6192,0)
 ;;=33990^^52^402^2^^^^1
 ;;^UTILITY(U,$J,358.3,6192,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6192,1,2,0)
 ;;=2^33990
 ;;^UTILITY(U,$J,358.3,6192,1,3,0)
 ;;=3^Insert VAD,Percut,Arterial Access,Rad S&I
 ;;^UTILITY(U,$J,358.3,6193,0)
 ;;=33991^^52^402^1^^^^1
 ;;^UTILITY(U,$J,358.3,6193,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6193,1,2,0)
 ;;=2^33991
 ;;^UTILITY(U,$J,358.3,6193,1,3,0)
 ;;=3^Insert VAD,Percut,Art&Ven Access,Rad S&I
 ;;^UTILITY(U,$J,358.3,6194,0)
 ;;=33992^^52^402^5^^^^1
 ;;^UTILITY(U,$J,358.3,6194,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6194,1,2,0)
 ;;=2^33992
 ;;^UTILITY(U,$J,358.3,6194,1,3,0)
 ;;=3^Remove VAD @ Diff Session from Insert
 ;;^UTILITY(U,$J,358.3,6195,0)
 ;;=33993^^52^402^6^^^^1
 ;;^UTILITY(U,$J,358.3,6195,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6195,1,2,0)
 ;;=2^33993
 ;;^UTILITY(U,$J,358.3,6195,1,3,0)
 ;;=3^Reposition VAD @ Diff Session from Insert
 ;;^UTILITY(U,$J,358.3,6196,0)
 ;;=33999^^52^402^3^^^^1
 ;;^UTILITY(U,$J,358.3,6196,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6196,1,2,0)
 ;;=2^33999
 ;;^UTILITY(U,$J,358.3,6196,1,3,0)
 ;;=3^Insertion of Impella
 ;;^UTILITY(U,$J,358.3,6197,0)
 ;;=34812^^52^402^4^^^^1
 ;;^UTILITY(U,$J,358.3,6197,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6197,1,2,0)
 ;;=2^34812
 ;;^UTILITY(U,$J,358.3,6197,1,3,0)
 ;;=3^Open Fem Artery Exposure for Deliv of Endo Prosth
 ;;^UTILITY(U,$J,358.3,6198,0)
 ;;=92960^^52^403^1^^^^1
 ;;^UTILITY(U,$J,358.3,6198,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6198,1,2,0)
 ;;=2^92960
 ;;^UTILITY(U,$J,358.3,6198,1,3,0)
 ;;=3^Cardioversion,External
 ;;^UTILITY(U,$J,358.3,6199,0)
 ;;=92961^^52^403^2^^^^1
 ;;^UTILITY(U,$J,358.3,6199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6199,1,2,0)
 ;;=2^92961
 ;;^UTILITY(U,$J,358.3,6199,1,3,0)
 ;;=3^Cardioversion,Internal
 ;;^UTILITY(U,$J,358.3,6200,0)
 ;;=I44.2^^53^404^3
