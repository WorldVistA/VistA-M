IBDEI27B ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36950,1,3,0)
 ;;=3^Refract cytopenia w multilin dysplasia and ring sideroblasts
 ;;^UTILITY(U,$J,358.3,36950,1,4,0)
 ;;=4^D46.B
 ;;^UTILITY(U,$J,358.3,36950,2)
 ;;=^5002252
 ;;^UTILITY(U,$J,358.3,36951,0)
 ;;=D46.22^^169^1863^16
 ;;^UTILITY(U,$J,358.3,36951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36951,1,3,0)
 ;;=3^Refractory anemia with excess of blasts 2
 ;;^UTILITY(U,$J,358.3,36951,1,4,0)
 ;;=4^D46.22
 ;;^UTILITY(U,$J,358.3,36951,2)
 ;;=^5002249
 ;;^UTILITY(U,$J,358.3,36952,0)
 ;;=D46.C^^169^1863^3
 ;;^UTILITY(U,$J,358.3,36952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36952,1,3,0)
 ;;=3^Myelodysplastic syndrome w isolated del(5q) chromsoml abnlt
 ;;^UTILITY(U,$J,358.3,36952,1,4,0)
 ;;=4^D46.C
 ;;^UTILITY(U,$J,358.3,36952,2)
 ;;=^5002253
 ;;^UTILITY(U,$J,358.3,36953,0)
 ;;=D46.9^^169^1863^4
 ;;^UTILITY(U,$J,358.3,36953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36953,1,3,0)
 ;;=3^Myelodysplastic syndrome, unspecified
 ;;^UTILITY(U,$J,358.3,36953,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,36953,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,36954,0)
 ;;=D47.1^^169^1863^1
 ;;^UTILITY(U,$J,358.3,36954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36954,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,36954,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,36954,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,36955,0)
 ;;=D47.Z1^^169^1863^12
 ;;^UTILITY(U,$J,358.3,36955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36955,1,3,0)
 ;;=3^Post-transplant lymphoproliferative disorder (PTLD)
 ;;^UTILITY(U,$J,358.3,36955,1,4,0)
 ;;=4^D47.Z1
 ;;^UTILITY(U,$J,358.3,36955,2)
 ;;=^5002261
 ;;^UTILITY(U,$J,358.3,36956,0)
 ;;=D48.7^^169^1863^8
 ;;^UTILITY(U,$J,358.3,36956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36956,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of other specified sites
 ;;^UTILITY(U,$J,358.3,36956,1,4,0)
 ;;=4^D48.7
 ;;^UTILITY(U,$J,358.3,36956,2)
 ;;=^267779
 ;;^UTILITY(U,$J,358.3,36957,0)
 ;;=D48.9^^169^1863^11
 ;;^UTILITY(U,$J,358.3,36957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36957,1,3,0)
 ;;=3^Neoplasm of uncertain behavior, unspecified
 ;;^UTILITY(U,$J,358.3,36957,1,4,0)
 ;;=4^D48.9
 ;;^UTILITY(U,$J,358.3,36957,2)
 ;;=^5002269
 ;;^UTILITY(U,$J,358.3,36958,0)
 ;;=D49.0^^169^1864^8
 ;;^UTILITY(U,$J,358.3,36958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36958,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of digestive system
 ;;^UTILITY(U,$J,358.3,36958,1,4,0)
 ;;=4^D49.0
 ;;^UTILITY(U,$J,358.3,36958,2)
 ;;=^5002270
 ;;^UTILITY(U,$J,358.3,36959,0)
 ;;=D49.1^^169^1864^12
 ;;^UTILITY(U,$J,358.3,36959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36959,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of respiratory system
 ;;^UTILITY(U,$J,358.3,36959,1,4,0)
 ;;=4^D49.1
 ;;^UTILITY(U,$J,358.3,36959,2)
 ;;=^5002271
 ;;^UTILITY(U,$J,358.3,36960,0)
 ;;=D49.2^^169^1864^5
 ;;^UTILITY(U,$J,358.3,36960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36960,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of bone, soft tissue, and skin
 ;;^UTILITY(U,$J,358.3,36960,1,4,0)
 ;;=4^D49.2
 ;;^UTILITY(U,$J,358.3,36960,2)
 ;;=^5002272
 ;;^UTILITY(U,$J,358.3,36961,0)
 ;;=D49.3^^169^1864^7
 ;;^UTILITY(U,$J,358.3,36961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36961,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of breast
 ;;^UTILITY(U,$J,358.3,36961,1,4,0)
 ;;=4^D49.3
 ;;^UTILITY(U,$J,358.3,36961,2)
 ;;=^5002273
 ;;^UTILITY(U,$J,358.3,36962,0)
 ;;=D49.4^^169^1864^4
 ;;^UTILITY(U,$J,358.3,36962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36962,1,3,0)
 ;;=3^Neoplasm of unspecified behavior of bladder
