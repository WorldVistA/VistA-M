IBDEI0HQ ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8580,1,4,0)
 ;;=4^V60.0
 ;;^UTILITY(U,$J,358.3,8580,2)
 ;;=^295539
 ;;^UTILITY(U,$J,358.3,8581,0)
 ;;=V65.5^^52^582^13
 ;;^UTILITY(U,$J,358.3,8581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8581,1,3,0)
 ;;=3^Condition Not Found
 ;;^UTILITY(U,$J,358.3,8581,1,4,0)
 ;;=4^V65.5
 ;;^UTILITY(U,$J,358.3,8581,2)
 ;;=^295564
 ;;^UTILITY(U,$J,358.3,8582,0)
 ;;=V67.51^^52^582^12
 ;;^UTILITY(U,$J,358.3,8582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8582,1,3,0)
 ;;=3^Completed Trmt of High Risk Med
 ;;^UTILITY(U,$J,358.3,8582,1,4,0)
 ;;=4^V67.51
 ;;^UTILITY(U,$J,358.3,8582,2)
 ;;=^295577
 ;;^UTILITY(U,$J,358.3,8583,0)
 ;;=V87.39^^52^582^15
 ;;^UTILITY(U,$J,358.3,8583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8583,1,3,0)
 ;;=3^Cont/Exp Hazard Sub NEC
 ;;^UTILITY(U,$J,358.3,8583,1,4,0)
 ;;=4^V87.39
 ;;^UTILITY(U,$J,358.3,8583,2)
 ;;=^336815
 ;;^UTILITY(U,$J,358.3,8584,0)
 ;;=369.05^^52^582^76
 ;;^UTILITY(U,$J,358.3,8584,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8584,1,3,0)
 ;;=3^One Eye-Profound,Oth Eye-NOS
 ;;^UTILITY(U,$J,358.3,8584,1,4,0)
 ;;=4^369.05
 ;;^UTILITY(U,$J,358.3,8584,2)
 ;;=^268865
 ;;^UTILITY(U,$J,358.3,8585,0)
 ;;=365.11^^52^583^20
 ;;^UTILITY(U,$J,358.3,8585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8585,1,3,0)
 ;;=3^Glaucoma,Open Angle
 ;;^UTILITY(U,$J,358.3,8585,1,4,0)
 ;;=4^365.11
 ;;^UTILITY(U,$J,358.3,8585,2)
 ;;=Open Angle Glaucoma^51203
 ;;^UTILITY(U,$J,358.3,8586,0)
 ;;=365.12^^52^583^16
 ;;^UTILITY(U,$J,358.3,8586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8586,1,3,0)
 ;;=3^Glaucoma,Low Tension
 ;;^UTILITY(U,$J,358.3,8586,1,4,0)
 ;;=4^365.12
 ;;^UTILITY(U,$J,358.3,8586,2)
 ;;=Low Tension Glaucoma^265223
 ;;^UTILITY(U,$J,358.3,8587,0)
 ;;=365.63^^52^583^19
 ;;^UTILITY(U,$J,358.3,8587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8587,1,3,0)
 ;;=3^Glaucoma,Neovascular
 ;;^UTILITY(U,$J,358.3,8587,1,4,0)
 ;;=4^365.63
 ;;^UTILITY(U,$J,358.3,8587,2)
 ;;=Neovascular Glaucoma^268778
 ;;^UTILITY(U,$J,358.3,8588,0)
 ;;=365.10^^52^583^22
 ;;^UTILITY(U,$J,358.3,8588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8588,1,3,0)
 ;;=3^Glaucoma,Open Angle Unspec
 ;;^UTILITY(U,$J,358.3,8588,1,4,0)
 ;;=4^365.10
 ;;^UTILITY(U,$J,358.3,8588,2)
 ;;=^51206
 ;;^UTILITY(U,$J,358.3,8589,0)
 ;;=365.13^^52^583^25
 ;;^UTILITY(U,$J,358.3,8589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8589,1,3,0)
 ;;=3^Glaucoma,Pigmentary
 ;;^UTILITY(U,$J,358.3,8589,1,4,0)
 ;;=4^365.13
 ;;^UTILITY(U,$J,358.3,8589,2)
 ;;=Pigmentary Glaucoma^51211
 ;;^UTILITY(U,$J,358.3,8590,0)
 ;;=365.20^^52^583^26
 ;;^UTILITY(U,$J,358.3,8590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8590,1,3,0)
 ;;=3^Glaucoma,Prim Angle Closure
 ;;^UTILITY(U,$J,358.3,8590,1,4,0)
 ;;=4^365.20
 ;;^UTILITY(U,$J,358.3,8590,2)
 ;;=^51195
 ;;^UTILITY(U,$J,358.3,8591,0)
 ;;=365.52^^52^583^27
 ;;^UTILITY(U,$J,358.3,8591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8591,1,3,0)
 ;;=3^Glaucoma,Pseudoexfoliation
 ;;^UTILITY(U,$J,358.3,8591,1,4,0)
 ;;=4^365.52
 ;;^UTILITY(U,$J,358.3,8591,2)
 ;;=Pseudoexfoliation Glaucoma^268771
 ;;^UTILITY(U,$J,358.3,8592,0)
 ;;=365.15^^52^583^29
 ;;^UTILITY(U,$J,358.3,8592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8592,1,3,0)
 ;;=3^Glaucoma,Residual Open Angle
 ;;^UTILITY(U,$J,358.3,8592,1,4,0)
 ;;=4^365.15
 ;;^UTILITY(U,$J,358.3,8592,2)
 ;;=Residual Open Angle Glaucoma^268751
 ;;^UTILITY(U,$J,358.3,8593,0)
 ;;=365.31^^52^583^32
 ;;^UTILITY(U,$J,358.3,8593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8593,1,3,0)
 ;;=3^Glaucoma,Steroid Induced
 ;;^UTILITY(U,$J,358.3,8593,1,4,0)
 ;;=4^365.31
 ;;^UTILITY(U,$J,358.3,8593,2)
 ;;=Steroid Induced Glaucoma^268761
