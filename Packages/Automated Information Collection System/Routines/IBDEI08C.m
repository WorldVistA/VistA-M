IBDEI08C ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3766,1,2,0)
 ;;=2^V82.0
 ;;^UTILITY(U,$J,358.3,3766,1,5,0)
 ;;=5^Spec Scr for Skin Cond
 ;;^UTILITY(U,$J,358.3,3766,2)
 ;;=^295694
 ;;^UTILITY(U,$J,358.3,3767,0)
 ;;=V76.43^^31^343^2
 ;;^UTILITY(U,$J,358.3,3767,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3767,1,2,0)
 ;;=2^V76.43
 ;;^UTILITY(U,$J,358.3,3767,1,5,0)
 ;;=5^Screen for Malignant Skin Neoplasm
 ;;^UTILITY(U,$J,358.3,3767,2)
 ;;=^295657
 ;;^UTILITY(U,$J,358.3,3768,0)
 ;;=173.00^^31^344^1
 ;;^UTILITY(U,$J,358.3,3768,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3768,1,2,0)
 ;;=2^173.00
 ;;^UTILITY(U,$J,358.3,3768,1,5,0)
 ;;=5^Malig Neopl Lip NOS
 ;;^UTILITY(U,$J,358.3,3768,2)
 ;;=^340596
 ;;^UTILITY(U,$J,358.3,3769,0)
 ;;=173.01^^31^344^2
 ;;^UTILITY(U,$J,358.3,3769,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3769,1,2,0)
 ;;=2^173.01
 ;;^UTILITY(U,$J,358.3,3769,1,5,0)
 ;;=5^BCC of skin of lip
 ;;^UTILITY(U,$J,358.3,3769,2)
 ;;=^340464
 ;;^UTILITY(U,$J,358.3,3770,0)
 ;;=173.02^^31^344^3
 ;;^UTILITY(U,$J,358.3,3770,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3770,1,2,0)
 ;;=2^173.02
 ;;^UTILITY(U,$J,358.3,3770,1,5,0)
 ;;=5^SCC of skin of lip
 ;;^UTILITY(U,$J,358.3,3770,2)
 ;;=^340465
 ;;^UTILITY(U,$J,358.3,3771,0)
 ;;=173.09^^31^344^4
 ;;^UTILITY(U,$J,358.3,3771,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3771,1,2,0)
 ;;=2^173.09
 ;;^UTILITY(U,$J,358.3,3771,1,5,0)
 ;;=5^Other specified neoplasm of lip
 ;;^UTILITY(U,$J,358.3,3771,2)
 ;;=^340466
 ;;^UTILITY(U,$J,358.3,3772,0)
 ;;=173.10^^31^344^5
 ;;^UTILITY(U,$J,358.3,3772,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3772,1,2,0)
 ;;=2^173.10
 ;;^UTILITY(U,$J,358.3,3772,1,5,0)
 ;;=5^Malig neoplasm of eyelid NOS
 ;;^UTILITY(U,$J,358.3,3772,2)
 ;;=^340597
 ;;^UTILITY(U,$J,358.3,3773,0)
 ;;=173.11^^31^344^6
 ;;^UTILITY(U,$J,358.3,3773,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3773,1,2,0)
 ;;=2^173.11
 ;;^UTILITY(U,$J,358.3,3773,1,5,0)
 ;;=5^BCC of skin of eyelid/canthus
 ;;^UTILITY(U,$J,358.3,3773,2)
 ;;=^340467
 ;;^UTILITY(U,$J,358.3,3774,0)
 ;;=173.12^^31^344^7
 ;;^UTILITY(U,$J,358.3,3774,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3774,1,2,0)
 ;;=2^173.12
 ;;^UTILITY(U,$J,358.3,3774,1,5,0)
 ;;=5^SCC of skin of eyelid/canthus
 ;;^UTILITY(U,$J,358.3,3774,2)
 ;;=^340468
 ;;^UTILITY(U,$J,358.3,3775,0)
 ;;=173.19^^31^344^8
 ;;^UTILITY(U,$J,358.3,3775,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3775,1,2,0)
 ;;=2^173.19
 ;;^UTILITY(U,$J,358.3,3775,1,5,0)
 ;;=5^Other specified neoplasm eyelid
 ;;^UTILITY(U,$J,358.3,3775,2)
 ;;=^340469
 ;;^UTILITY(U,$J,358.3,3776,0)
 ;;=173.20^^31^344^9
 ;;^UTILITY(U,$J,358.3,3776,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3776,1,2,0)
 ;;=2^173.20
 ;;^UTILITY(U,$J,358.3,3776,1,5,0)
 ;;=5^Malig neoplasm skin, ear/ear canal NOS
 ;;^UTILITY(U,$J,358.3,3776,2)
 ;;=^340598
 ;;^UTILITY(U,$J,358.3,3777,0)
 ;;=173.21^^31^344^10
 ;;^UTILITY(U,$J,358.3,3777,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3777,1,2,0)
 ;;=2^173.21
 ;;^UTILITY(U,$J,358.3,3777,1,5,0)
 ;;=5^BCC of skin of ear/ear canal
 ;;^UTILITY(U,$J,358.3,3777,2)
 ;;=^340470
 ;;^UTILITY(U,$J,358.3,3778,0)
 ;;=173.22^^31^344^11
 ;;^UTILITY(U,$J,358.3,3778,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3778,1,2,0)
 ;;=2^173.22
 ;;^UTILITY(U,$J,358.3,3778,1,5,0)
 ;;=5^SCC of skin of ear/ear canal
 ;;^UTILITY(U,$J,358.3,3778,2)
 ;;=^340471
 ;;^UTILITY(U,$J,358.3,3779,0)
 ;;=173.29^^31^344^12
 ;;^UTILITY(U,$J,358.3,3779,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3779,1,2,0)
 ;;=2^173.29
 ;;^UTILITY(U,$J,358.3,3779,1,5,0)
 ;;=5^Other spec neoplasm skin, ear/ear canal
 ;;^UTILITY(U,$J,358.3,3779,2)
 ;;=^340472
