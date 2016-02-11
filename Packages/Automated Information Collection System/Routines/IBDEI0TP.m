IBDEI0TP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13662,1,3,0)
 ;;=3^Tributary Retinal Vein Occlusion,Left Eye
 ;;^UTILITY(U,$J,358.3,13662,1,4,0)
 ;;=4^H34.832
 ;;^UTILITY(U,$J,358.3,13662,2)
 ;;=^5005577
 ;;^UTILITY(U,$J,358.3,13663,0)
 ;;=H34.833^^80^763^110
 ;;^UTILITY(U,$J,358.3,13663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13663,1,3,0)
 ;;=3^Tributary Retinal Vein Occlusion,Bilateral
 ;;^UTILITY(U,$J,358.3,13663,1,4,0)
 ;;=4^H34.833
 ;;^UTILITY(U,$J,358.3,13663,2)
 ;;=^5005578
 ;;^UTILITY(U,$J,358.3,13664,0)
 ;;=H35.711^^80^763^14
 ;;^UTILITY(U,$J,358.3,13664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13664,1,3,0)
 ;;=3^Central Serouos Chorioretinopathy,Right Eye
 ;;^UTILITY(U,$J,358.3,13664,1,4,0)
 ;;=4^H35.711
 ;;^UTILITY(U,$J,358.3,13664,2)
 ;;=^5005703
 ;;^UTILITY(U,$J,358.3,13665,0)
 ;;=H35.712^^80^763^13
 ;;^UTILITY(U,$J,358.3,13665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13665,1,3,0)
 ;;=3^Central Serouos Chorioretinopathy,Left Eye
 ;;^UTILITY(U,$J,358.3,13665,1,4,0)
 ;;=4^H35.712
 ;;^UTILITY(U,$J,358.3,13665,2)
 ;;=^5005704
 ;;^UTILITY(U,$J,358.3,13666,0)
 ;;=H35.713^^80^763^12
 ;;^UTILITY(U,$J,358.3,13666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13666,1,3,0)
 ;;=3^Central Serouos Chorioretinopathy,Bilateral
 ;;^UTILITY(U,$J,358.3,13666,1,4,0)
 ;;=4^H35.713
 ;;^UTILITY(U,$J,358.3,13666,2)
 ;;=^5005705
 ;;^UTILITY(U,$J,358.3,13667,0)
 ;;=H35.721^^80^763^102
 ;;^UTILITY(U,$J,358.3,13667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13667,1,3,0)
 ;;=3^Serous Detachment of Retinal Pigment Epithelium,Right Eye
 ;;^UTILITY(U,$J,358.3,13667,1,4,0)
 ;;=4^H35.721
 ;;^UTILITY(U,$J,358.3,13667,2)
 ;;=^5005707
 ;;^UTILITY(U,$J,358.3,13668,0)
 ;;=H35.722^^80^763^103
 ;;^UTILITY(U,$J,358.3,13668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13668,1,3,0)
 ;;=3^Serous Detachment of Retinal Pigment Epithelium,Left Eye
 ;;^UTILITY(U,$J,358.3,13668,1,4,0)
 ;;=4^H35.722
 ;;^UTILITY(U,$J,358.3,13668,2)
 ;;=^5005708
 ;;^UTILITY(U,$J,358.3,13669,0)
 ;;=H35.723^^80^763^104
 ;;^UTILITY(U,$J,358.3,13669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13669,1,3,0)
 ;;=3^Serous Detachment of Retinal Pigment Epithelium,Bilateral
 ;;^UTILITY(U,$J,358.3,13669,1,4,0)
 ;;=4^H35.723
 ;;^UTILITY(U,$J,358.3,13669,2)
 ;;=^5005709
 ;;^UTILITY(U,$J,358.3,13670,0)
 ;;=H35.731^^80^763^46
 ;;^UTILITY(U,$J,358.3,13670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13670,1,3,0)
 ;;=3^Hemorrhagic Detachment of Retinal Pigment Epithelium,Right Eye
 ;;^UTILITY(U,$J,358.3,13670,1,4,0)
 ;;=4^H35.731
 ;;^UTILITY(U,$J,358.3,13670,2)
 ;;=^5005711
 ;;^UTILITY(U,$J,358.3,13671,0)
 ;;=H35.732^^80^763^47
 ;;^UTILITY(U,$J,358.3,13671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13671,1,3,0)
 ;;=3^Hemorrhagic Detachment of Retinal Pigment Epithelium,Left Eye
 ;;^UTILITY(U,$J,358.3,13671,1,4,0)
 ;;=4^H35.732
 ;;^UTILITY(U,$J,358.3,13671,2)
 ;;=^5005712
 ;;^UTILITY(U,$J,358.3,13672,0)
 ;;=H35.341^^80^763^60
 ;;^UTILITY(U,$J,358.3,13672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13672,1,3,0)
 ;;=3^Macular Cyst/Hole/Pseudohole,Right Eye
 ;;^UTILITY(U,$J,358.3,13672,1,4,0)
 ;;=4^H35.341
 ;;^UTILITY(U,$J,358.3,13672,2)
 ;;=^5005650
 ;;^UTILITY(U,$J,358.3,13673,0)
 ;;=H35.342^^80^763^59
 ;;^UTILITY(U,$J,358.3,13673,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13673,1,3,0)
 ;;=3^Macular Cyst/Hole/Pseudohole,Left Eye
 ;;^UTILITY(U,$J,358.3,13673,1,4,0)
 ;;=4^H35.342
 ;;^UTILITY(U,$J,358.3,13673,2)
 ;;=^5005651
 ;;^UTILITY(U,$J,358.3,13674,0)
 ;;=H35.343^^80^763^58
 ;;^UTILITY(U,$J,358.3,13674,1,0)
 ;;=^358.31IA^4^2
