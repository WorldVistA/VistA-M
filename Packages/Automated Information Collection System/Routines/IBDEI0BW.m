IBDEI0BW ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5120,1,3,0)
 ;;=3^Aftercare Following Digestive System Surgery
 ;;^UTILITY(U,$J,358.3,5120,1,4,0)
 ;;=4^Z48.815
 ;;^UTILITY(U,$J,358.3,5120,2)
 ;;=^5063052
 ;;^UTILITY(U,$J,358.3,5121,0)
 ;;=Z48.816^^40^353^3
 ;;^UTILITY(U,$J,358.3,5121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5121,1,3,0)
 ;;=3^Aftercare Following GU System Surgery
 ;;^UTILITY(U,$J,358.3,5121,1,4,0)
 ;;=4^Z48.816
 ;;^UTILITY(U,$J,358.3,5121,2)
 ;;=^5063053
 ;;^UTILITY(U,$J,358.3,5122,0)
 ;;=Z48.817^^40^353^8
 ;;^UTILITY(U,$J,358.3,5122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5122,1,3,0)
 ;;=3^Aftercare Following Skin Surgery
 ;;^UTILITY(U,$J,358.3,5122,1,4,0)
 ;;=4^Z48.817
 ;;^UTILITY(U,$J,358.3,5122,2)
 ;;=^5063054
 ;;^UTILITY(U,$J,358.3,5123,0)
 ;;=Z48.89^^40^353^9
 ;;^UTILITY(U,$J,358.3,5123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5123,1,3,0)
 ;;=3^Aftercare Following Surgery NEC
 ;;^UTILITY(U,$J,358.3,5123,1,4,0)
 ;;=4^Z48.89
 ;;^UTILITY(U,$J,358.3,5123,2)
 ;;=^5063055
 ;;^UTILITY(U,$J,358.3,5124,0)
 ;;=Z09.^^40^353^11
 ;;^UTILITY(U,$J,358.3,5124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5124,1,3,0)
 ;;=3^Aftercare Following Treatment for Condition Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,5124,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,5124,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,5125,0)
 ;;=Z48.1^^40^353^14
 ;;^UTILITY(U,$J,358.3,5125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5125,1,3,0)
 ;;=3^Planned Postproc Wound Closure
 ;;^UTILITY(U,$J,358.3,5125,1,4,0)
 ;;=4^Z48.1
 ;;^UTILITY(U,$J,358.3,5125,2)
 ;;=^5063037
 ;;^UTILITY(U,$J,358.3,5126,0)
 ;;=Z48.03^^40^353^15
 ;;^UTILITY(U,$J,358.3,5126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5126,1,3,0)
 ;;=3^Removal of Drains
 ;;^UTILITY(U,$J,358.3,5126,1,4,0)
 ;;=4^Z48.03
 ;;^UTILITY(U,$J,358.3,5126,2)
 ;;=^5063036
 ;;^UTILITY(U,$J,358.3,5127,0)
 ;;=D23.0^^40^354^11
 ;;^UTILITY(U,$J,358.3,5127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5127,1,3,0)
 ;;=3^Benign Neop of Skin of Lip
 ;;^UTILITY(U,$J,358.3,5127,1,4,0)
 ;;=4^D23.0
 ;;^UTILITY(U,$J,358.3,5127,2)
 ;;=^5002059
 ;;^UTILITY(U,$J,358.3,5128,0)
 ;;=D22.0^^40^354^20
 ;;^UTILITY(U,$J,358.3,5128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5128,1,3,0)
 ;;=3^Melanocytic Nevi of Lip
 ;;^UTILITY(U,$J,358.3,5128,1,4,0)
 ;;=4^D22.0
 ;;^UTILITY(U,$J,358.3,5128,2)
 ;;=^5002041
 ;;^UTILITY(U,$J,358.3,5129,0)
 ;;=D22.12^^40^354^17
 ;;^UTILITY(U,$J,358.3,5129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5129,1,3,0)
 ;;=3^Melanocytic Nevi of Left Eyelid
 ;;^UTILITY(U,$J,358.3,5129,1,4,0)
 ;;=4^D22.12
 ;;^UTILITY(U,$J,358.3,5129,2)
 ;;=^5002044
 ;;^UTILITY(U,$J,358.3,5130,0)
 ;;=D23.11^^40^354^7
 ;;^UTILITY(U,$J,358.3,5130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5130,1,3,0)
 ;;=3^Benign Neop of Right Eyelid
 ;;^UTILITY(U,$J,358.3,5130,1,4,0)
 ;;=4^D23.11
 ;;^UTILITY(U,$J,358.3,5130,2)
 ;;=^5002061
 ;;^UTILITY(U,$J,358.3,5131,0)
 ;;=D23.12^^40^354^3
 ;;^UTILITY(U,$J,358.3,5131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5131,1,3,0)
 ;;=3^Benign Neop of Left Eyelid
 ;;^UTILITY(U,$J,358.3,5131,1,4,0)
 ;;=4^D23.12
 ;;^UTILITY(U,$J,358.3,5131,2)
 ;;=^5002062
 ;;^UTILITY(U,$J,358.3,5132,0)
 ;;=D22.11^^40^354^22
 ;;^UTILITY(U,$J,358.3,5132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5132,1,3,0)
 ;;=3^Melanocytic Nevi of Right Eyelid
 ;;^UTILITY(U,$J,358.3,5132,1,4,0)
 ;;=4^D22.11
 ;;^UTILITY(U,$J,358.3,5132,2)
 ;;=^5002043
 ;;^UTILITY(U,$J,358.3,5133,0)
 ;;=D23.21^^40^354^6
 ;;^UTILITY(U,$J,358.3,5133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5133,1,3,0)
 ;;=3^Benign Neop of Right Ear/External Auric Canal
