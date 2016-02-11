IBDEI053 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1701,1,3,0)
 ;;=3^Optic Nerve Injury,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,1701,1,4,0)
 ;;=4^S04.012A
 ;;^UTILITY(U,$J,358.3,1701,2)
 ;;=^5020465
 ;;^UTILITY(U,$J,358.3,1702,0)
 ;;=H57.8^^16^167^13
 ;;^UTILITY(U,$J,358.3,1702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1702,1,3,0)
 ;;=3^Eye & Adnexa Disorders
 ;;^UTILITY(U,$J,358.3,1702,1,4,0)
 ;;=4^H57.8
 ;;^UTILITY(U,$J,358.3,1702,2)
 ;;=^269332
 ;;^UTILITY(U,$J,358.3,1703,0)
 ;;=H33.001^^16^167^32
 ;;^UTILITY(U,$J,358.3,1703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1703,1,3,0)
 ;;=3^Retinal Detachment w/ Retinal Break,Right Eye
 ;;^UTILITY(U,$J,358.3,1703,1,4,0)
 ;;=4^H33.001
 ;;^UTILITY(U,$J,358.3,1703,2)
 ;;=^5005490
 ;;^UTILITY(U,$J,358.3,1704,0)
 ;;=H33.002^^16^167^31
 ;;^UTILITY(U,$J,358.3,1704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1704,1,3,0)
 ;;=3^Retinal Detachment w/ Retinal Break,Left Eye
 ;;^UTILITY(U,$J,358.3,1704,1,4,0)
 ;;=4^H33.002
 ;;^UTILITY(U,$J,358.3,1704,2)
 ;;=^5005491
 ;;^UTILITY(U,$J,358.3,1705,0)
 ;;=H33.003^^16^167^30
 ;;^UTILITY(U,$J,358.3,1705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1705,1,3,0)
 ;;=3^Retinal Detachment w/ Retinal Break,Bilateral 
 ;;^UTILITY(U,$J,358.3,1705,1,4,0)
 ;;=4^H33.003
 ;;^UTILITY(U,$J,358.3,1705,2)
 ;;=^5005492
 ;;^UTILITY(U,$J,358.3,1706,0)
 ;;=H34.9^^16^167^33
 ;;^UTILITY(U,$J,358.3,1706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1706,1,3,0)
 ;;=3^Retinal Vascular Occlusion,Unspec
 ;;^UTILITY(U,$J,358.3,1706,1,4,0)
 ;;=4^H34.9
 ;;^UTILITY(U,$J,358.3,1706,2)
 ;;=^5005580
 ;;^UTILITY(U,$J,358.3,1707,0)
 ;;=H31.021^^16^167^37
 ;;^UTILITY(U,$J,358.3,1707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1707,1,3,0)
 ;;=3^Solar Retinopathy,Right Eye
 ;;^UTILITY(U,$J,358.3,1707,1,4,0)
 ;;=4^H31.021
 ;;^UTILITY(U,$J,358.3,1707,2)
 ;;=^5005443
 ;;^UTILITY(U,$J,358.3,1708,0)
 ;;=H31.022^^16^167^36
 ;;^UTILITY(U,$J,358.3,1708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1708,1,3,0)
 ;;=3^Solar Retinopathy,Left Eye
 ;;^UTILITY(U,$J,358.3,1708,1,4,0)
 ;;=4^H31.022
 ;;^UTILITY(U,$J,358.3,1708,2)
 ;;=^5005444
 ;;^UTILITY(U,$J,358.3,1709,0)
 ;;=H31.023^^16^167^35
 ;;^UTILITY(U,$J,358.3,1709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1709,1,3,0)
 ;;=3^Solar Retinopathy,Bilateral
 ;;^UTILITY(U,$J,358.3,1709,1,4,0)
 ;;=4^H31.023
 ;;^UTILITY(U,$J,358.3,1709,2)
 ;;=^5005445
 ;;^UTILITY(U,$J,358.3,1710,0)
 ;;=H47.9^^16^167^38
 ;;^UTILITY(U,$J,358.3,1710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1710,1,3,0)
 ;;=3^Visual Pathway Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,1710,1,4,0)
 ;;=4^H47.9
 ;;^UTILITY(U,$J,358.3,1710,2)
 ;;=^5006178
 ;;^UTILITY(U,$J,358.3,1711,0)
 ;;=Z51.89^^16^167^12
 ;;^UTILITY(U,$J,358.3,1711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1711,1,3,0)
 ;;=3^Encounter for Other Specified Aftercare
 ;;^UTILITY(U,$J,358.3,1711,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,1711,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,1712,0)
 ;;=S04.011D^^16^167^28
 ;;^UTILITY(U,$J,358.3,1712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1712,1,3,0)
 ;;=3^Optic Nerve Injury,Right Eye,Subseq
 ;;^UTILITY(U,$J,358.3,1712,1,4,0)
 ;;=4^S04.011D
 ;;^UTILITY(U,$J,358.3,1712,2)
 ;;=^5020463
 ;;^UTILITY(U,$J,358.3,1713,0)
 ;;=S04.012D^^16^167^25
 ;;^UTILITY(U,$J,358.3,1713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1713,1,3,0)
 ;;=3^Optic Nerve Injury,Left Eye,Subseq
 ;;^UTILITY(U,$J,358.3,1713,1,4,0)
 ;;=4^S04.012D
 ;;^UTILITY(U,$J,358.3,1713,2)
 ;;=^5020466
 ;;^UTILITY(U,$J,358.3,1714,0)
 ;;=S04.011S^^16^167^27
 ;;^UTILITY(U,$J,358.3,1714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1714,1,3,0)
 ;;=3^Optic Nerve Injury,Right Eye,Sequela
