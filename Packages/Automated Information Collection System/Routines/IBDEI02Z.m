IBDEI02Z ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,963,0)
 ;;=93283^^10^103^10^^^^1
 ;;^UTILITY(U,$J,358.3,963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,963,1,2,0)
 ;;=2^93283
 ;;^UTILITY(U,$J,358.3,963,1,3,0)
 ;;=3^ICD Device Progr Eval,Dual
 ;;^UTILITY(U,$J,358.3,964,0)
 ;;=93284^^10^103^11^^^^1
 ;;^UTILITY(U,$J,358.3,964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,964,1,2,0)
 ;;=2^93284
 ;;^UTILITY(U,$J,358.3,964,1,3,0)
 ;;=3^ICD Device Progr Eval,Multi
 ;;^UTILITY(U,$J,358.3,965,0)
 ;;=93281^^10^103^33^^^^1
 ;;^UTILITY(U,$J,358.3,965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,965,1,2,0)
 ;;=2^93281
 ;;^UTILITY(U,$J,358.3,965,1,3,0)
 ;;=3^PM Device Progr Eval,Multi
 ;;^UTILITY(U,$J,358.3,966,0)
 ;;=33227^^10^103^50^^^^1
 ;;^UTILITY(U,$J,358.3,966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,966,1,2,0)
 ;;=2^33227
 ;;^UTILITY(U,$J,358.3,966,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,967,0)
 ;;=33228^^10^103^48^^^^1
 ;;^UTILITY(U,$J,358.3,967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,967,1,2,0)
 ;;=2^33228
 ;;^UTILITY(U,$J,358.3,967,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,968,0)
 ;;=33229^^10^103^49^^^^1
 ;;^UTILITY(U,$J,358.3,968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,968,1,2,0)
 ;;=2^33229
 ;;^UTILITY(U,$J,358.3,968,1,3,0)
 ;;=3^Remove PM Pulse Gen w/Replc PM Gen,Mult
 ;;^UTILITY(U,$J,358.3,969,0)
 ;;=33230^^10^103^19^^^^1
 ;;^UTILITY(U,$J,358.3,969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,969,1,2,0)
 ;;=2^33230
 ;;^UTILITY(U,$J,358.3,969,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Single
 ;;^UTILITY(U,$J,358.3,970,0)
 ;;=33231^^10^103^18^^^^1
 ;;^UTILITY(U,$J,358.3,970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,970,1,2,0)
 ;;=2^33231
 ;;^UTILITY(U,$J,358.3,970,1,3,0)
 ;;=3^Insert ICD Gen Only,Existing Mult
 ;;^UTILITY(U,$J,358.3,971,0)
 ;;=33233^^10^103^44^^^^1
 ;;^UTILITY(U,$J,358.3,971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,971,1,2,0)
 ;;=2^33233
 ;;^UTILITY(U,$J,358.3,971,1,3,0)
 ;;=3^Removal of PM Generator Only
 ;;^UTILITY(U,$J,358.3,972,0)
 ;;=33262^^10^103^54^^^^1
 ;;^UTILITY(U,$J,358.3,972,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,972,1,2,0)
 ;;=2^33262
 ;;^UTILITY(U,$J,358.3,972,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Single
 ;;^UTILITY(U,$J,358.3,973,0)
 ;;=33263^^10^103^52^^^^1
 ;;^UTILITY(U,$J,358.3,973,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,973,1,2,0)
 ;;=2^33263
 ;;^UTILITY(U,$J,358.3,973,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Dual
 ;;^UTILITY(U,$J,358.3,974,0)
 ;;=33264^^10^103^53^^^^1
 ;;^UTILITY(U,$J,358.3,974,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,974,1,2,0)
 ;;=2^33264
 ;;^UTILITY(U,$J,358.3,974,1,3,0)
 ;;=3^Remv ICD Gen w/Replc PM Gen,Multiple
 ;;^UTILITY(U,$J,358.3,975,0)
 ;;=93286^^10^103^40^^^^1
 ;;^UTILITY(U,$J,358.3,975,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,975,1,2,0)
 ;;=2^93286
 ;;^UTILITY(U,$J,358.3,975,1,3,0)
 ;;=3^Pre-Op PM Device Eval w/Review&Rpt
 ;;^UTILITY(U,$J,358.3,976,0)
 ;;=93287^^10^103^39^^^^1
 ;;^UTILITY(U,$J,358.3,976,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,976,1,2,0)
 ;;=2^93287
 ;;^UTILITY(U,$J,358.3,976,1,3,0)
 ;;=3^Pre-Op ICD Device Eval
 ;;^UTILITY(U,$J,358.3,977,0)
 ;;=93290^^10^103^12^^^^1
 ;;^UTILITY(U,$J,358.3,977,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,977,1,2,0)
 ;;=2^93290
 ;;^UTILITY(U,$J,358.3,977,1,3,0)
 ;;=3^ICM Device Eval
 ;;^UTILITY(U,$J,358.3,978,0)
 ;;=93293^^10^103^35^^^^1
 ;;^UTILITY(U,$J,358.3,978,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,978,1,2,0)
 ;;=2^93293
 ;;^UTILITY(U,$J,358.3,978,1,3,0)
 ;;=3^PM Phone R-Strip Device Eval
