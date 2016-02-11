IBDEI0T1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13352,1,3,0)
 ;;=3^Dry Eye Syndrome,Bilateral Lacrimal Glands
 ;;^UTILITY(U,$J,358.3,13352,1,4,0)
 ;;=4^H04.123
 ;;^UTILITY(U,$J,358.3,13352,2)
 ;;=^5004465
 ;;^UTILITY(U,$J,358.3,13353,0)
 ;;=H35.32^^80^759^28
 ;;^UTILITY(U,$J,358.3,13353,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13353,1,3,0)
 ;;=3^Exudative Age-Related Macular Degeneration
 ;;^UTILITY(U,$J,358.3,13353,1,4,0)
 ;;=4^H35.32
 ;;^UTILITY(U,$J,358.3,13353,2)
 ;;=^5005648
 ;;^UTILITY(U,$J,358.3,13354,0)
 ;;=H35.023^^80^759^29
 ;;^UTILITY(U,$J,358.3,13354,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13354,1,3,0)
 ;;=3^Exudative Retinopathy,Bilateral
 ;;^UTILITY(U,$J,358.3,13354,1,4,0)
 ;;=4^H35.023
 ;;^UTILITY(U,$J,358.3,13354,2)
 ;;=^5005588
 ;;^UTILITY(U,$J,358.3,13355,0)
 ;;=H35.022^^80^759^30
 ;;^UTILITY(U,$J,358.3,13355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13355,1,3,0)
 ;;=3^Exudative Retinopathy,Left Eye
 ;;^UTILITY(U,$J,358.3,13355,1,4,0)
 ;;=4^H35.022
 ;;^UTILITY(U,$J,358.3,13355,2)
 ;;=^5005587
 ;;^UTILITY(U,$J,358.3,13356,0)
 ;;=H35.021^^80^759^31
 ;;^UTILITY(U,$J,358.3,13356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13356,1,3,0)
 ;;=3^Exudative Retinopathy,Right Eye
 ;;^UTILITY(U,$J,358.3,13356,1,4,0)
 ;;=4^H35.021
 ;;^UTILITY(U,$J,358.3,13356,2)
 ;;=^5005586
 ;;^UTILITY(U,$J,358.3,13357,0)
 ;;=H40.013^^80^759^32
 ;;^UTILITY(U,$J,358.3,13357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13357,1,3,0)
 ;;=3^Glaucoma Suspect,Open Angle w/ Borderline Findings,Low Risk,Bilateral
 ;;^UTILITY(U,$J,358.3,13357,1,4,0)
 ;;=4^H40.013
 ;;^UTILITY(U,$J,358.3,13357,2)
 ;;=^5005726
 ;;^UTILITY(U,$J,358.3,13358,0)
 ;;=H40.012^^80^759^33
 ;;^UTILITY(U,$J,358.3,13358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13358,1,3,0)
 ;;=3^Glaucoma Suspect,Open Angle w/ Borderline Findings,Low Risk,Left Eye
 ;;^UTILITY(U,$J,358.3,13358,1,4,0)
 ;;=4^H40.012
 ;;^UTILITY(U,$J,358.3,13358,2)
 ;;=^5005725
 ;;^UTILITY(U,$J,358.3,13359,0)
 ;;=H40.011^^80^759^34
 ;;^UTILITY(U,$J,358.3,13359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13359,1,3,0)
 ;;=3^Glaucoma Suspect,Open Angle w/ Borderline Findings,Low Risk,Right Eye
 ;;^UTILITY(U,$J,358.3,13359,1,4,0)
 ;;=4^H40.011
 ;;^UTILITY(U,$J,358.3,13359,2)
 ;;=^5005724
 ;;^UTILITY(U,$J,358.3,13360,0)
 ;;=H52.03^^80^759^41
 ;;^UTILITY(U,$J,358.3,13360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13360,1,3,0)
 ;;=3^Hypermetropia,Bilateral
 ;;^UTILITY(U,$J,358.3,13360,1,4,0)
 ;;=4^H52.03
 ;;^UTILITY(U,$J,358.3,13360,2)
 ;;=^5006262
 ;;^UTILITY(U,$J,358.3,13361,0)
 ;;=H52.02^^80^759^42
 ;;^UTILITY(U,$J,358.3,13361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13361,1,3,0)
 ;;=3^Hypermetropia,Left Eye
 ;;^UTILITY(U,$J,358.3,13361,1,4,0)
 ;;=4^H52.02
 ;;^UTILITY(U,$J,358.3,13361,2)
 ;;=^5006261
 ;;^UTILITY(U,$J,358.3,13362,0)
 ;;=H52.01^^80^759^43
 ;;^UTILITY(U,$J,358.3,13362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13362,1,3,0)
 ;;=3^Hypermetropia,Right Eye
 ;;^UTILITY(U,$J,358.3,13362,1,4,0)
 ;;=4^H52.01
 ;;^UTILITY(U,$J,358.3,13362,2)
 ;;=^5006260
 ;;^UTILITY(U,$J,358.3,13363,0)
 ;;=H59.41^^80^759^44
 ;;^UTILITY(U,$J,358.3,13363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13363,1,3,0)
 ;;=3^Inflammation of Postprocedural Bleb,Stage 1
 ;;^UTILITY(U,$J,358.3,13363,1,4,0)
 ;;=4^H59.41
 ;;^UTILITY(U,$J,358.3,13363,2)
 ;;=^5006426
 ;;^UTILITY(U,$J,358.3,13364,0)
 ;;=H59.42^^80^759^45
 ;;^UTILITY(U,$J,358.3,13364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13364,1,3,0)
 ;;=3^Inflammation of Postprocedural Bleb,Stage 2
 ;;^UTILITY(U,$J,358.3,13364,1,4,0)
 ;;=4^H59.42
