IBDEI1SE ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30357,0)
 ;;=D46.1^^118^1506^17
 ;;^UTILITY(U,$J,358.3,30357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30357,1,3,0)
 ;;=3^Refractory anemia with ring sideroblasts
 ;;^UTILITY(U,$J,358.3,30357,1,4,0)
 ;;=4^D46.1
 ;;^UTILITY(U,$J,358.3,30357,2)
 ;;=^5002246
 ;;^UTILITY(U,$J,358.3,30358,0)
 ;;=D46.20^^118^1506^14
 ;;^UTILITY(U,$J,358.3,30358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30358,1,3,0)
 ;;=3^Refractory anemia with excess of blasts, unspecified
 ;;^UTILITY(U,$J,358.3,30358,1,4,0)
 ;;=4^D46.20
 ;;^UTILITY(U,$J,358.3,30358,2)
 ;;=^5002247
 ;;^UTILITY(U,$J,358.3,30359,0)
 ;;=D46.21^^118^1506^15
 ;;^UTILITY(U,$J,358.3,30359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30359,1,3,0)
 ;;=3^Refractory anemia with excess of blasts 1
 ;;^UTILITY(U,$J,358.3,30359,1,4,0)
 ;;=4^D46.21
 ;;^UTILITY(U,$J,358.3,30359,2)
 ;;=^5002248
 ;;^UTILITY(U,$J,358.3,30360,0)
 ;;=D46.A^^118^1506^19
 ;;^UTILITY(U,$J,358.3,30360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30360,1,3,0)
 ;;=3^Refractory cytopenia with multilineage dysplasia
 ;;^UTILITY(U,$J,358.3,30360,1,4,0)
 ;;=4^D46.A
 ;;^UTILITY(U,$J,358.3,30360,2)
 ;;=^5002251
 ;;^UTILITY(U,$J,358.3,30361,0)
 ;;=D46.B^^118^1506^13
 ;;^UTILITY(U,$J,358.3,30361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30361,1,3,0)
 ;;=3^Refract cytopenia w multilin dysplasia and ring sideroblasts
 ;;^UTILITY(U,$J,358.3,30361,1,4,0)
 ;;=4^D46.B
 ;;^UTILITY(U,$J,358.3,30361,2)
 ;;=^5002252
 ;;^UTILITY(U,$J,358.3,30362,0)
 ;;=D46.22^^118^1506^16
 ;;^UTILITY(U,$J,358.3,30362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30362,1,3,0)
 ;;=3^Refractory anemia with excess of blasts 2
 ;;^UTILITY(U,$J,358.3,30362,1,4,0)
 ;;=4^D46.22
 ;;^UTILITY(U,$J,358.3,30362,2)
 ;;=^5002249
 ;;^UTILITY(U,$J,358.3,30363,0)
 ;;=D46.C^^118^1506^3
 ;;^UTILITY(U,$J,358.3,30363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30363,1,3,0)
 ;;=3^Myelodysplastic syndrome w isolated del(5q) chromsoml abnlt
 ;;^UTILITY(U,$J,358.3,30363,1,4,0)
 ;;=4^D46.C
 ;;^UTILITY(U,$J,358.3,30363,2)
 ;;=^5002253
 ;;^UTILITY(U,$J,358.3,30364,0)
 ;;=D46.9^^118^1506^4
 ;;^UTILITY(U,$J,358.3,30364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30364,1,3,0)
 ;;=3^Myelodysplastic syndrome, unspecified
 ;;^UTILITY(U,$J,358.3,30364,1,4,0)
 ;;=4^D46.9
 ;;^UTILITY(U,$J,358.3,30364,2)
 ;;=^334031
 ;;^UTILITY(U,$J,358.3,30365,0)
 ;;=D47.1^^118^1506^1
 ;;^UTILITY(U,$J,358.3,30365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30365,1,3,0)
 ;;=3^Chronic myeloproliferative disease
 ;;^UTILITY(U,$J,358.3,30365,1,4,0)
 ;;=4^D47.1
 ;;^UTILITY(U,$J,358.3,30365,2)
 ;;=^5002256
 ;;^UTILITY(U,$J,358.3,30366,0)
 ;;=D47.Z1^^118^1506^12
 ;;^UTILITY(U,$J,358.3,30366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30366,1,3,0)
 ;;=3^Post-transplant lymphoproliferative disorder (PTLD)
 ;;^UTILITY(U,$J,358.3,30366,1,4,0)
 ;;=4^D47.Z1
 ;;^UTILITY(U,$J,358.3,30366,2)
 ;;=^5002261
 ;;^UTILITY(U,$J,358.3,30367,0)
 ;;=D48.7^^118^1506^8
 ;;^UTILITY(U,$J,358.3,30367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30367,1,3,0)
 ;;=3^Neoplasm of uncertain behavior of other specified sites
 ;;^UTILITY(U,$J,358.3,30367,1,4,0)
 ;;=4^D48.7
 ;;^UTILITY(U,$J,358.3,30367,2)
 ;;=^267779
 ;;^UTILITY(U,$J,358.3,30368,0)
 ;;=D48.9^^118^1506^11
 ;;^UTILITY(U,$J,358.3,30368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30368,1,3,0)
 ;;=3^Neoplasm of uncertain behavior, unspecified
 ;;^UTILITY(U,$J,358.3,30368,1,4,0)
 ;;=4^D48.9
 ;;^UTILITY(U,$J,358.3,30368,2)
 ;;=^5002269
 ;;^UTILITY(U,$J,358.3,30369,0)
 ;;=D49.0^^118^1507^8
 ;;^UTILITY(U,$J,358.3,30369,1,0)
 ;;=^358.31IA^4^2
