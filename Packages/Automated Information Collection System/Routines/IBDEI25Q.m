IBDEI25Q ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36174,2)
 ;;=^5016098
 ;;^UTILITY(U,$J,358.3,36175,0)
 ;;=O36.80X0^^166^1834^3
 ;;^UTILITY(U,$J,358.3,36175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36175,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, unsp
 ;;^UTILITY(U,$J,358.3,36175,1,4,0)
 ;;=4^O36.80X0
 ;;^UTILITY(U,$J,358.3,36175,2)
 ;;=^5017082
 ;;^UTILITY(U,$J,358.3,36176,0)
 ;;=O36.80X1^^166^1834^4
 ;;^UTILITY(U,$J,358.3,36176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36176,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 1
 ;;^UTILITY(U,$J,358.3,36176,1,4,0)
 ;;=4^O36.80X1
 ;;^UTILITY(U,$J,358.3,36176,2)
 ;;=^5017083
 ;;^UTILITY(U,$J,358.3,36177,0)
 ;;=O36.80X2^^166^1834^5
 ;;^UTILITY(U,$J,358.3,36177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36177,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 2
 ;;^UTILITY(U,$J,358.3,36177,1,4,0)
 ;;=4^O36.80X2
 ;;^UTILITY(U,$J,358.3,36177,2)
 ;;=^5017084
 ;;^UTILITY(U,$J,358.3,36178,0)
 ;;=O36.80X3^^166^1834^6
 ;;^UTILITY(U,$J,358.3,36178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36178,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 3
 ;;^UTILITY(U,$J,358.3,36178,1,4,0)
 ;;=4^O36.80X3
 ;;^UTILITY(U,$J,358.3,36178,2)
 ;;=^5017085
 ;;^UTILITY(U,$J,358.3,36179,0)
 ;;=O36.80X4^^166^1834^7
 ;;^UTILITY(U,$J,358.3,36179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36179,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 4
 ;;^UTILITY(U,$J,358.3,36179,1,4,0)
 ;;=4^O36.80X4
 ;;^UTILITY(U,$J,358.3,36179,2)
 ;;=^5017086
 ;;^UTILITY(U,$J,358.3,36180,0)
 ;;=O36.80X5^^166^1834^8
 ;;^UTILITY(U,$J,358.3,36180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36180,1,3,0)
 ;;=3^Pregnancy with inconclusive fetal viability, fetus 5
 ;;^UTILITY(U,$J,358.3,36180,1,4,0)
 ;;=4^O36.80X5
 ;;^UTILITY(U,$J,358.3,36180,2)
 ;;=^5017087
 ;;^UTILITY(U,$J,358.3,36181,0)
 ;;=Z39.0^^166^1834^2
 ;;^UTILITY(U,$J,358.3,36181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36181,1,3,0)
 ;;=3^Care and exam of mother immediately after del
 ;;^UTILITY(U,$J,358.3,36181,1,4,0)
 ;;=4^Z39.0
 ;;^UTILITY(U,$J,358.3,36181,2)
 ;;=^5062904
 ;;^UTILITY(U,$J,358.3,36182,0)
 ;;=Z39.1^^166^1834^1
 ;;^UTILITY(U,$J,358.3,36182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36182,1,3,0)
 ;;=3^Care and exam of lactating mother
 ;;^UTILITY(U,$J,358.3,36182,1,4,0)
 ;;=4^Z39.1
 ;;^UTILITY(U,$J,358.3,36182,2)
 ;;=^5062905
 ;;^UTILITY(U,$J,358.3,36183,0)
 ;;=Z39.2^^166^1834^10
 ;;^UTILITY(U,$J,358.3,36183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36183,1,3,0)
 ;;=3^Routine postpartum follow-up
 ;;^UTILITY(U,$J,358.3,36183,1,4,0)
 ;;=4^Z39.2
 ;;^UTILITY(U,$J,358.3,36183,2)
 ;;=^5062906
 ;;^UTILITY(U,$J,358.3,36184,0)
 ;;=A63.0^^166^1835^16
 ;;^UTILITY(U,$J,358.3,36184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36184,1,3,0)
 ;;=3^Anogenital (venereal) warts
 ;;^UTILITY(U,$J,358.3,36184,1,4,0)
 ;;=4^A63.0
 ;;^UTILITY(U,$J,358.3,36184,2)
 ;;=^5000360
 ;;^UTILITY(U,$J,358.3,36185,0)
 ;;=A56.02^^166^1835^28
 ;;^UTILITY(U,$J,358.3,36185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36185,1,3,0)
 ;;=3^Chlamydial vulvovaginitis
 ;;^UTILITY(U,$J,358.3,36185,1,4,0)
 ;;=4^A56.02
 ;;^UTILITY(U,$J,358.3,36185,2)
 ;;=^5000340
 ;;^UTILITY(U,$J,358.3,36186,0)
 ;;=B37.3^^166^1835^22
 ;;^UTILITY(U,$J,358.3,36186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36186,1,3,0)
 ;;=3^Candidiasis of vulva and vagina
 ;;^UTILITY(U,$J,358.3,36186,1,4,0)
 ;;=4^B37.3
 ;;^UTILITY(U,$J,358.3,36186,2)
 ;;=^5000615
 ;;^UTILITY(U,$J,358.3,36187,0)
 ;;=A59.01^^166^1835^99
 ;;^UTILITY(U,$J,358.3,36187,1,0)
 ;;=^358.31IA^4^2
