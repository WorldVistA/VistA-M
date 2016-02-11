IBDEI0BS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5059,1,2,0)
 ;;=2^Insert PICC Line
 ;;^UTILITY(U,$J,358.3,5059,1,4,0)
 ;;=4^36569
 ;;^UTILITY(U,$J,358.3,5060,0)
 ;;=36000^^39^345^7^^^^1
 ;;^UTILITY(U,$J,358.3,5060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5060,1,2,0)
 ;;=2^Intro Needle or Intracath,Vein
 ;;^UTILITY(U,$J,358.3,5060,1,4,0)
 ;;=4^36000
 ;;^UTILITY(U,$J,358.3,5061,0)
 ;;=99195^^39^345^9^^^^1
 ;;^UTILITY(U,$J,358.3,5061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5061,1,2,0)
 ;;=2^Phlebotomy
 ;;^UTILITY(U,$J,358.3,5061,1,4,0)
 ;;=4^99195
 ;;^UTILITY(U,$J,358.3,5062,0)
 ;;=4066F^^39^345^3^^^^1
 ;;^UTILITY(U,$J,358.3,5062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5062,1,2,0)
 ;;=2^ECT Provided
 ;;^UTILITY(U,$J,358.3,5062,1,4,0)
 ;;=4^4066F
 ;;^UTILITY(U,$J,358.3,5063,0)
 ;;=P9047^^39^346^3^^^^1
 ;;^UTILITY(U,$J,358.3,5063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5063,1,2,0)
 ;;=2^Inf Albumin(Human),25%,50ml
 ;;^UTILITY(U,$J,358.3,5063,1,4,0)
 ;;=4^P9047
 ;;^UTILITY(U,$J,358.3,5064,0)
 ;;=P9010^^39^346^6^^^^1
 ;;^UTILITY(U,$J,358.3,5064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5064,1,2,0)
 ;;=2^Whole Blood for Transfusion,per unit
 ;;^UTILITY(U,$J,358.3,5064,1,4,0)
 ;;=4^P9010
 ;;^UTILITY(U,$J,358.3,5065,0)
 ;;=P9017^^39^346^2^^^^1
 ;;^UTILITY(U,$J,358.3,5065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5065,1,2,0)
 ;;=2^Frh Frz Plasma 1 Donor w/in 8hr,per unit
 ;;^UTILITY(U,$J,358.3,5065,1,4,0)
 ;;=4^P9017
 ;;^UTILITY(U,$J,358.3,5066,0)
 ;;=P9020^^39^346^4^^^^1
 ;;^UTILITY(U,$J,358.3,5066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5066,1,2,0)
 ;;=2^Platelet,Rich Plasma,per unit
 ;;^UTILITY(U,$J,358.3,5066,1,4,0)
 ;;=4^P9020
 ;;^UTILITY(U,$J,358.3,5067,0)
 ;;=P9021^^39^346^5^^^^1
 ;;^UTILITY(U,$J,358.3,5067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5067,1,2,0)
 ;;=2^Red Blood Cells,per unit
 ;;^UTILITY(U,$J,358.3,5067,1,4,0)
 ;;=4^P9021
 ;;^UTILITY(U,$J,358.3,5068,0)
 ;;=36430^^39^346^1^^^^1
 ;;^UTILITY(U,$J,358.3,5068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5068,1,2,0)
 ;;=2^Blood Transfusion Service
 ;;^UTILITY(U,$J,358.3,5068,1,4,0)
 ;;=4^36430
 ;;^UTILITY(U,$J,358.3,5069,0)
 ;;=96360^^39^347^1^^^^1
 ;;^UTILITY(U,$J,358.3,5069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5069,1,2,0)
 ;;=2^Hydration IV Inf,Init,31-60 mins
 ;;^UTILITY(U,$J,358.3,5069,1,4,0)
 ;;=4^96360
 ;;^UTILITY(U,$J,358.3,5070,0)
 ;;=96361^^39^347^2^^^^1
 ;;^UTILITY(U,$J,358.3,5070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5070,1,2,0)
 ;;=2^Hydration IV Inf,Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,5070,1,4,0)
 ;;=4^96361
 ;;^UTILITY(U,$J,358.3,5071,0)
 ;;=96365^^39^347^3^^^^1
 ;;^UTILITY(U,$J,358.3,5071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5071,1,2,0)
 ;;=2^IV Inf Ther/Proph/Diag Init Hr
 ;;^UTILITY(U,$J,358.3,5071,1,4,0)
 ;;=4^96365
 ;;^UTILITY(U,$J,358.3,5072,0)
 ;;=96366^^39^347^4^^^^1
 ;;^UTILITY(U,$J,358.3,5072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5072,1,2,0)
 ;;=2^IV Inf Ther/Proph/Diag Ea Addl Hr
 ;;^UTILITY(U,$J,358.3,5072,1,4,0)
 ;;=4^96366
 ;;^UTILITY(U,$J,358.3,5073,0)
 ;;=J1750^^39^348^13^^^^1
 ;;^UTILITY(U,$J,358.3,5073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5073,1,2,0)
 ;;=2^Iron Dextran Inj 50mg
 ;;^UTILITY(U,$J,358.3,5073,1,4,0)
 ;;=4^J1750
 ;;^UTILITY(U,$J,358.3,5074,0)
 ;;=J1756^^39^348^14^^^^1
 ;;^UTILITY(U,$J,358.3,5074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5074,1,2,0)
 ;;=2^Iron Sucrose Inj 1mg/ml
 ;;^UTILITY(U,$J,358.3,5074,1,4,0)
 ;;=4^J1756
 ;;^UTILITY(U,$J,358.3,5075,0)
 ;;=J2323^^39^348^17^^^^1
 ;;^UTILITY(U,$J,358.3,5075,1,0)
 ;;=^358.31IA^4^2
