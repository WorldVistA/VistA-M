IBDEI02Y ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,946,1,3,0)
 ;;=3^Temp Gradient Studies
 ;;^UTILITY(U,$J,358.3,947,0)
 ;;=33234^^10^103^43^^^^1
 ;;^UTILITY(U,$J,358.3,947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,947,1,2,0)
 ;;=2^33234
 ;;^UTILITY(U,$J,358.3,947,1,3,0)
 ;;=3^Rem Transv Elec Atria/Vent(Sgl)
 ;;^UTILITY(U,$J,358.3,948,0)
 ;;=33235^^10^103^42^^^^1
 ;;^UTILITY(U,$J,358.3,948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,948,1,2,0)
 ;;=2^33235
 ;;^UTILITY(U,$J,358.3,948,1,3,0)
 ;;=3^Rem Transv Elec Atria/Vent(Dual)
 ;;^UTILITY(U,$J,358.3,949,0)
 ;;=33240^^10^103^22^^^^1
 ;;^UTILITY(U,$J,358.3,949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,949,1,2,0)
 ;;=2^33240
 ;;^UTILITY(U,$J,358.3,949,1,3,0)
 ;;=3^Insert Single/Dual Pulse Gen
 ;;^UTILITY(U,$J,358.3,950,0)
 ;;=33241^^10^103^60^^^^1
 ;;^UTILITY(U,$J,358.3,950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,950,1,2,0)
 ;;=2^33241
 ;;^UTILITY(U,$J,358.3,950,1,3,0)
 ;;=3^Subq Remove Sgl/Dual Pulse Gen
 ;;^UTILITY(U,$J,358.3,951,0)
 ;;=33244^^10^103^64^^^^1
 ;;^UTILITY(U,$J,358.3,951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,951,1,2,0)
 ;;=2^33244
 ;;^UTILITY(U,$J,358.3,951,1,3,0)
 ;;=3^Transv Remove Sgl/Dual Elec
 ;;^UTILITY(U,$J,358.3,952,0)
 ;;=33249^^10^103^16^^^^1
 ;;^UTILITY(U,$J,358.3,952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,952,1,2,0)
 ;;=2^33249
 ;;^UTILITY(U,$J,358.3,952,1,3,0)
 ;;=3^Ins/Reposit Lead, Insert Pulse Gen
 ;;^UTILITY(U,$J,358.3,953,0)
 ;;=93285^^10^103^13^^^^1
 ;;^UTILITY(U,$J,358.3,953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,953,1,2,0)
 ;;=2^93285
 ;;^UTILITY(U,$J,358.3,953,1,3,0)
 ;;=3^ILR Device Eval Progr
 ;;^UTILITY(U,$J,358.3,954,0)
 ;;=93291^^10^103^15^^^^1
 ;;^UTILITY(U,$J,358.3,954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,954,1,2,0)
 ;;=2^93291
 ;;^UTILITY(U,$J,358.3,954,1,3,0)
 ;;=3^ILR Device Interrogate
 ;;^UTILITY(U,$J,358.3,955,0)
 ;;=93294^^10^103^31^^^^1
 ;;^UTILITY(U,$J,358.3,955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,955,1,2,0)
 ;;=2^93294
 ;;^UTILITY(U,$J,358.3,955,1,3,0)
 ;;=3^PM Device Interrogate Remote
 ;;^UTILITY(U,$J,358.3,956,0)
 ;;=93280^^10^103^32^^^^1
 ;;^UTILITY(U,$J,358.3,956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,956,1,2,0)
 ;;=2^93280
 ;;^UTILITY(U,$J,358.3,956,1,3,0)
 ;;=3^PM Device Progr Eval,Dual
 ;;^UTILITY(U,$J,358.3,957,0)
 ;;=93288^^10^103^30^^^^1
 ;;^UTILITY(U,$J,358.3,957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,957,1,2,0)
 ;;=2^93288
 ;;^UTILITY(U,$J,358.3,957,1,3,0)
 ;;=3^PM Device Eval in Person
 ;;^UTILITY(U,$J,358.3,958,0)
 ;;=93279^^10^103^34^^^^1
 ;;^UTILITY(U,$J,358.3,958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,958,1,2,0)
 ;;=2^93279
 ;;^UTILITY(U,$J,358.3,958,1,3,0)
 ;;=3^PM Device Progr Eval,Sngl
 ;;^UTILITY(U,$J,358.3,959,0)
 ;;=93282^^10^103^9^^^^1
 ;;^UTILITY(U,$J,358.3,959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,959,1,2,0)
 ;;=2^93282
 ;;^UTILITY(U,$J,358.3,959,1,3,0)
 ;;=3^ICD Device Prog Eval,1 Sngl
 ;;^UTILITY(U,$J,358.3,960,0)
 ;;=93289^^10^103^7^^^^1
 ;;^UTILITY(U,$J,358.3,960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,960,1,2,0)
 ;;=2^93289
 ;;^UTILITY(U,$J,358.3,960,1,3,0)
 ;;=3^ICD Device Interrogatate
 ;;^UTILITY(U,$J,358.3,961,0)
 ;;=93292^^10^103^66^^^^1
 ;;^UTILITY(U,$J,358.3,961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,961,1,2,0)
 ;;=2^93292
 ;;^UTILITY(U,$J,358.3,961,1,3,0)
 ;;=3^WCD Device Interrogate
 ;;^UTILITY(U,$J,358.3,962,0)
 ;;=93295^^10^103^8^^^^1
 ;;^UTILITY(U,$J,358.3,962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,962,1,2,0)
 ;;=2^93295
 ;;^UTILITY(U,$J,358.3,962,1,3,0)
 ;;=3^ICD Device Interrogate Remote
