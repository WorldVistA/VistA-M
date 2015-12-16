IBDEI02H ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,609,2)
 ;;=^5002248
 ;;^UTILITY(U,$J,358.3,610,0)
 ;;=D46.A^^2^25^19
 ;;^UTILITY(U,$J,358.3,610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,610,1,3,0)
 ;;=3^Refractory cytopenia with multilineage dysplasia
 ;;^UTILITY(U,$J,358.3,610,1,4,0)
 ;;=4^D46.A
 ;;^UTILITY(U,$J,358.3,610,2)
 ;;=^5002251
 ;;^UTILITY(U,$J,358.3,611,0)
 ;;=D46.B^^2^25^13
 ;;^UTILITY(U,$J,358.3,611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,611,1,3,0)
 ;;=3^Refract cytopenia w multilin dysplasia and ring sideroblasts
 ;;^UTILITY(U,$J,358.3,611,1,4,0)
 ;;=4^D46.B
 ;;^UTILITY(U,$J,358.3,611,2)
 ;;=^5002252
 ;;^UTILITY(U,$J,358.3,612,0)
 ;;=D46.22^^2^25^16
 ;;^UTILITY(U,$J,358.3,612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,612,1,3,0)
 ;;=3^Refractory anemia with excess of blasts 2
 ;;^UTILITY(U,$J,358.3,612,1,4,0)
 ;;=4^D46.22
 ;;^UTILITY(U,$J,358.3,612,2)
 ;;=^5002249
 ;;^UTILITY(U,$J,358.3,613,0)
 ;;=D46.C^^2^25^3
 ;;^UTILITY(U,$J,358.3,613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,613,1,3,0)
 ;;=3^Myelodysplastic syndrome w isolated del(5q) chromsoml abnlt
 ;;^UTILITY(U,$J,358.3,613,1,4,0)
 ;;=4^D46.C
 ;;^UTILITY(U,$J,358.3,613,2)
 ;;=^5002253
 ;;^UTILITY(U,$J,358.3,614,0)
 ;;=D46.9^^2^25^4
 ;;^UTILITY(U,$J,358.3,614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,614,1,3,0)
 ;;=3^Myelodysplastic syndrome, unspecified
 ;;^UTILITY(U,$J,358.3,614,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,614,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,615,0)
 ;;=D47.1^^2^25^1
 ;;^UTILITY(U,$J,358.3,615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,615,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,615,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,615,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,616,0)
 ;;=D47.Z1^^2^25^12
 ;;^UTILITY(U,$J,358.3,616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,616,1,3,0)
 ;;=3^Post-transplant lymphoproliferative disorder (PTLD)
 ;;^UTILITY(U,$J,358.3,616,1,4,0)
 ;;=4^D47.Z1
 ;;^UTILITY(U,$J,358.3,616,2)
 ;;=^5002261
 ;;^UTILITY(U,$J,358.3,617,0)
 ;;=D48.7^^2^25^8
 ;;^UTILITY(U,$J,358.3,617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,617,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of other specified sites
 ;;^UTILITY(U,$J,358.3,617,1,4,0)
 ;;=4^D48.7
 ;;^UTILITY(U,$J,358.3,617,2)
 ;;=^267779
 ;;^UTILITY(U,$J,358.3,618,0)
 ;;=D48.9^^2^25^11
 ;;^UTILITY(U,$J,358.3,618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,618,1,3,0)
 ;;=3^Neoplasm of uncertain behavior, unspecified
 ;;^UTILITY(U,$J,358.3,618,1,4,0)
 ;;=4^D48.9
 ;;^UTILITY(U,$J,358.3,618,2)
 ;;=^5002269
 ;;^UTILITY(U,$J,358.3,619,0)
 ;;=D49.0^^2^26^8
 ;;^UTILITY(U,$J,358.3,619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,619,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of digestive system
 ;;^UTILITY(U,$J,358.3,619,1,4,0)
 ;;=4^D49.0
 ;;^UTILITY(U,$J,358.3,619,2)
 ;;=^5002270
 ;;^UTILITY(U,$J,358.3,620,0)
 ;;=D49.1^^2^26^12
 ;;^UTILITY(U,$J,358.3,620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,620,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of respiratory system
 ;;^UTILITY(U,$J,358.3,620,1,4,0)
 ;;=4^D49.1
 ;;^UTILITY(U,$J,358.3,620,2)
 ;;=^5002271
 ;;^UTILITY(U,$J,358.3,621,0)
 ;;=D49.2^^2^26^5
 ;;^UTILITY(U,$J,358.3,621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,621,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of bone, soft tissue, and skin
 ;;^UTILITY(U,$J,358.3,621,1,4,0)
 ;;=4^D49.2
 ;;^UTILITY(U,$J,358.3,621,2)
 ;;=^5002272
 ;;^UTILITY(U,$J,358.3,622,0)
 ;;=D49.3^^2^26^7
 ;;^UTILITY(U,$J,358.3,622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,622,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of breast
