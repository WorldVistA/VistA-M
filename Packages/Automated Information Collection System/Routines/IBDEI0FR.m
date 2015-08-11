IBDEI0FR ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7588,1,4,0)
 ;;=4^V60.0
 ;;^UTILITY(U,$J,358.3,7588,2)
 ;;=^295539
 ;;^UTILITY(U,$J,358.3,7589,0)
 ;;=V65.5^^49^558^13
 ;;^UTILITY(U,$J,358.3,7589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7589,1,3,0)
 ;;=3^Condition Not Found
 ;;^UTILITY(U,$J,358.3,7589,1,4,0)
 ;;=4^V65.5
 ;;^UTILITY(U,$J,358.3,7589,2)
 ;;=^295564
 ;;^UTILITY(U,$J,358.3,7590,0)
 ;;=V67.51^^49^558^12
 ;;^UTILITY(U,$J,358.3,7590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7590,1,3,0)
 ;;=3^Completed Trmt of High Risk Med
 ;;^UTILITY(U,$J,358.3,7590,1,4,0)
 ;;=4^V67.51
 ;;^UTILITY(U,$J,358.3,7590,2)
 ;;=^295577
 ;;^UTILITY(U,$J,358.3,7591,0)
 ;;=V87.39^^49^558^15
 ;;^UTILITY(U,$J,358.3,7591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7591,1,3,0)
 ;;=3^Cont/Exp Hazard Sub NEC
 ;;^UTILITY(U,$J,358.3,7591,1,4,0)
 ;;=4^V87.39
 ;;^UTILITY(U,$J,358.3,7591,2)
 ;;=^336815
 ;;^UTILITY(U,$J,358.3,7592,0)
 ;;=369.05^^49^558^76
 ;;^UTILITY(U,$J,358.3,7592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7592,1,3,0)
 ;;=3^One Eye-Profound,Oth Eye-NOS
 ;;^UTILITY(U,$J,358.3,7592,1,4,0)
 ;;=4^369.05
 ;;^UTILITY(U,$J,358.3,7592,2)
 ;;=^268865
 ;;^UTILITY(U,$J,358.3,7593,0)
 ;;=365.11^^49^559^20
 ;;^UTILITY(U,$J,358.3,7593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7593,1,3,0)
 ;;=3^Glaucoma,Open Angle
 ;;^UTILITY(U,$J,358.3,7593,1,4,0)
 ;;=4^365.11
 ;;^UTILITY(U,$J,358.3,7593,2)
 ;;=Open Angle Glaucoma^51203
 ;;^UTILITY(U,$J,358.3,7594,0)
 ;;=365.12^^49^559^16
 ;;^UTILITY(U,$J,358.3,7594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7594,1,3,0)
 ;;=3^Glaucoma,Low Tension
 ;;^UTILITY(U,$J,358.3,7594,1,4,0)
 ;;=4^365.12
 ;;^UTILITY(U,$J,358.3,7594,2)
 ;;=Low Tension Glaucoma^265223
 ;;^UTILITY(U,$J,358.3,7595,0)
 ;;=365.63^^49^559^19
 ;;^UTILITY(U,$J,358.3,7595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7595,1,3,0)
 ;;=3^Glaucoma,Neovascular
 ;;^UTILITY(U,$J,358.3,7595,1,4,0)
 ;;=4^365.63
 ;;^UTILITY(U,$J,358.3,7595,2)
 ;;=Neovascular Glaucoma^268778
 ;;^UTILITY(U,$J,358.3,7596,0)
 ;;=365.10^^49^559^22
 ;;^UTILITY(U,$J,358.3,7596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7596,1,3,0)
 ;;=3^Glaucoma,Open Angle Unspec
 ;;^UTILITY(U,$J,358.3,7596,1,4,0)
 ;;=4^365.10
 ;;^UTILITY(U,$J,358.3,7596,2)
 ;;=^51206
 ;;^UTILITY(U,$J,358.3,7597,0)
 ;;=365.13^^49^559^25
 ;;^UTILITY(U,$J,358.3,7597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7597,1,3,0)
 ;;=3^Glaucoma,Pigmentary
 ;;^UTILITY(U,$J,358.3,7597,1,4,0)
 ;;=4^365.13
 ;;^UTILITY(U,$J,358.3,7597,2)
 ;;=Pigmentary Glaucoma^51211
 ;;^UTILITY(U,$J,358.3,7598,0)
 ;;=365.20^^49^559^26
 ;;^UTILITY(U,$J,358.3,7598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7598,1,3,0)
 ;;=3^Glaucoma,Prim Angle Closure
 ;;^UTILITY(U,$J,358.3,7598,1,4,0)
 ;;=4^365.20
 ;;^UTILITY(U,$J,358.3,7598,2)
 ;;=^51195
 ;;^UTILITY(U,$J,358.3,7599,0)
 ;;=365.52^^49^559^27
 ;;^UTILITY(U,$J,358.3,7599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7599,1,3,0)
 ;;=3^Glaucoma,Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,7599,1,4,0)
 ;;=4^365.52
 ;;^UTILITY(U,$J,358.3,7599,2)
 ;;=Pseudoexfoliation Glaucoma^268771
 ;;^UTILITY(U,$J,358.3,7600,0)
 ;;=365.15^^49^559^29
 ;;^UTILITY(U,$J,358.3,7600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7600,1,3,0)
 ;;=3^Glaucoma,Residual Open Angle
 ;;^UTILITY(U,$J,358.3,7600,1,4,0)
 ;;=4^365.15
 ;;^UTILITY(U,$J,358.3,7600,2)
 ;;=Residual Open Angle Glaucoma^268751
 ;;^UTILITY(U,$J,358.3,7601,0)
 ;;=365.31^^49^559^32
 ;;^UTILITY(U,$J,358.3,7601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7601,1,3,0)
 ;;=3^Glaucoma,Steroid Induced
 ;;^UTILITY(U,$J,358.3,7601,1,4,0)
 ;;=4^365.31
 ;;^UTILITY(U,$J,358.3,7601,2)
 ;;=Steroid Induced Glaucoma^268761
