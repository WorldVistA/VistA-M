IBDEI0GR ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8104,1,4,0)
 ;;=4^370.34
 ;;^UTILITY(U,$J,358.3,8104,2)
 ;;=Exposure Keratoconjunctivitis^268932
 ;;^UTILITY(U,$J,358.3,8105,0)
 ;;=370.21^^52^578^105
 ;;^UTILITY(U,$J,358.3,8105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8105,1,3,0)
 ;;=3^Punctate Keratitis
 ;;^UTILITY(U,$J,358.3,8105,1,4,0)
 ;;=4^370.21
 ;;^UTILITY(U,$J,358.3,8105,2)
 ;;=Keratitis, Punctate^268920
 ;;^UTILITY(U,$J,358.3,8106,0)
 ;;=054.42^^52^578^63
 ;;^UTILITY(U,$J,358.3,8106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8106,1,3,0)
 ;;=3^Keratitis, Dendritic (HSV)
 ;;^UTILITY(U,$J,358.3,8106,1,4,0)
 ;;=4^054.42
 ;;^UTILITY(U,$J,358.3,8106,2)
 ;;=Dendritic Keratitis^66763
 ;;^UTILITY(U,$J,358.3,8107,0)
 ;;=370.62^^52^578^94
 ;;^UTILITY(U,$J,358.3,8107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8107,1,3,0)
 ;;=3^Pannus
 ;;^UTILITY(U,$J,358.3,8107,1,4,0)
 ;;=4^370.62
 ;;^UTILITY(U,$J,358.3,8107,2)
 ;;=^268949
 ;;^UTILITY(U,$J,358.3,8108,0)
 ;;=053.21^^52^578^69
 ;;^UTILITY(U,$J,358.3,8108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8108,1,3,0)
 ;;=3^Keratoconjunctivits, H Zoster
 ;;^UTILITY(U,$J,358.3,8108,1,4,0)
 ;;=4^053.21
 ;;^UTILITY(U,$J,358.3,8108,2)
 ;;=Herp Zost Keratoconjunctivitis^266553
 ;;^UTILITY(U,$J,358.3,8109,0)
 ;;=V42.5^^52^578^24
 ;;^UTILITY(U,$J,358.3,8109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8109,1,3,0)
 ;;=3^Corneal Transplant
 ;;^UTILITY(U,$J,358.3,8109,1,4,0)
 ;;=4^V42.5
 ;;^UTILITY(U,$J,358.3,8109,2)
 ;;=Corneal Transplant^174117
 ;;^UTILITY(U,$J,358.3,8110,0)
 ;;=996.51^^52^578^109
 ;;^UTILITY(U,$J,358.3,8110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8110,1,3,0)
 ;;=3^Reject/Failure, Corneal Transp
 ;;^UTILITY(U,$J,358.3,8110,1,4,0)
 ;;=4^996.51
 ;;^UTILITY(U,$J,358.3,8110,2)
 ;;=Rejection/Failure, Corneal Transplant^276277^V42.5
 ;;^UTILITY(U,$J,358.3,8111,0)
 ;;=918.1^^52^578^1
 ;;^UTILITY(U,$J,358.3,8111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8111,1,3,0)
 ;;=3^Abrasion, Cornea
 ;;^UTILITY(U,$J,358.3,8111,1,4,0)
 ;;=4^918.1
 ;;^UTILITY(U,$J,358.3,8111,2)
 ;;=Corneal Abrasion^115829
 ;;^UTILITY(U,$J,358.3,8112,0)
 ;;=370.49^^52^578^110
 ;;^UTILITY(U,$J,358.3,8112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8112,1,3,0)
 ;;=3^Rosacea Keratitis
 ;;^UTILITY(U,$J,358.3,8112,1,4,0)
 ;;=4^370.49
 ;;^UTILITY(U,$J,358.3,8112,2)
 ;;=^87674^695.3
 ;;^UTILITY(U,$J,358.3,8113,0)
 ;;=371.41^^52^578^7
 ;;^UTILITY(U,$J,358.3,8113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8113,1,3,0)
 ;;=3^Arcus, Corneal
 ;;^UTILITY(U,$J,358.3,8113,1,4,0)
 ;;=4^371.41
 ;;^UTILITY(U,$J,358.3,8113,2)
 ;;=Corneal Arcus^109206
 ;;^UTILITY(U,$J,358.3,8114,0)
 ;;=371.10^^52^578^17
 ;;^UTILITY(U,$J,358.3,8114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8114,1,3,0)
 ;;=3^Cornea Dep/Amoid
 ;;^UTILITY(U,$J,358.3,8114,1,4,0)
 ;;=4^371.10
 ;;^UTILITY(U,$J,358.3,8114,2)
 ;;=Toxic Keratopathy, Due to med^276846
 ;;^UTILITY(U,$J,358.3,8115,0)
 ;;=370.60^^52^578^87
 ;;^UTILITY(U,$J,358.3,8115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8115,1,3,0)
 ;;=3^Neovascularization, Corneal
 ;;^UTILITY(U,$J,358.3,8115,1,4,0)
 ;;=4^370.60
 ;;^UTILITY(U,$J,358.3,8115,2)
 ;;=Corneal Neovascularization^184274
 ;;^UTILITY(U,$J,358.3,8116,0)
 ;;=371.20^^52^578^37
 ;;^UTILITY(U,$J,358.3,8116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8116,1,3,0)
 ;;=3^Edema, Cornea
 ;;^UTILITY(U,$J,358.3,8116,1,4,0)
 ;;=4^371.20
 ;;^UTILITY(U,$J,358.3,8116,2)
 ;;=Edema, Cornea^28394
 ;;^UTILITY(U,$J,358.3,8117,0)
 ;;=371.00^^52^578^90
 ;;^UTILITY(U,$J,358.3,8117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8117,1,3,0)
 ;;=3^Opacity, Corneal
