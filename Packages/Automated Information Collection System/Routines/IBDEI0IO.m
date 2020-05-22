IBDEI0IO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8151,0)
 ;;=C44.629^^65^521^6
 ;;^UTILITY(U,$J,358.3,8151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8151,1,3,0)
 ;;=3^SCC Skin Left Upper Limb
 ;;^UTILITY(U,$J,358.3,8151,1,4,0)
 ;;=4^C44.629
 ;;^UTILITY(U,$J,358.3,8151,2)
 ;;=^5001071
 ;;^UTILITY(U,$J,358.3,8152,0)
 ;;=C44.722^^65^521^14
 ;;^UTILITY(U,$J,358.3,8152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8152,1,3,0)
 ;;=3^SCC Skin Right Lower Limb
 ;;^UTILITY(U,$J,358.3,8152,1,4,0)
 ;;=4^C44.722
 ;;^UTILITY(U,$J,358.3,8152,2)
 ;;=^5001082
 ;;^UTILITY(U,$J,358.3,8153,0)
 ;;=C44.729^^65^521^5
 ;;^UTILITY(U,$J,358.3,8153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8153,1,3,0)
 ;;=3^SCC Skin Left Lower Limb
 ;;^UTILITY(U,$J,358.3,8153,1,4,0)
 ;;=4^C44.729
 ;;^UTILITY(U,$J,358.3,8153,2)
 ;;=^5001083
 ;;^UTILITY(U,$J,358.3,8154,0)
 ;;=C44.82^^65^521^10
 ;;^UTILITY(U,$J,358.3,8154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8154,1,3,0)
 ;;=3^SCC Skin Overlapping Sites
 ;;^UTILITY(U,$J,358.3,8154,1,4,0)
 ;;=4^C44.82
 ;;^UTILITY(U,$J,358.3,8154,2)
 ;;=^5001089
 ;;^UTILITY(U,$J,358.3,8155,0)
 ;;=L57.8^^65^521^36
 ;;^UTILITY(U,$J,358.3,8155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8155,1,3,0)
 ;;=3^Skin Changes d/t Chr Exposure to Nonionizing Radiation
 ;;^UTILITY(U,$J,358.3,8155,1,4,0)
 ;;=4^L57.8
 ;;^UTILITY(U,$J,358.3,8155,2)
 ;;=^5009226
 ;;^UTILITY(U,$J,358.3,8156,0)
 ;;=L27.0^^65^521^37
 ;;^UTILITY(U,$J,358.3,8156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8156,1,3,0)
 ;;=3^Skin Eruption,Generalized d/t Drugs/Meds Taken Internally
 ;;^UTILITY(U,$J,358.3,8156,1,4,0)
 ;;=4^L27.0
 ;;^UTILITY(U,$J,358.3,8156,2)
 ;;=^5009144
 ;;^UTILITY(U,$J,358.3,8157,0)
 ;;=L27.1^^65^521^38
 ;;^UTILITY(U,$J,358.3,8157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8157,1,3,0)
 ;;=3^Skin Eruption,Localized d/t Drugs/Meds Taken Internally
 ;;^UTILITY(U,$J,358.3,8157,1,4,0)
 ;;=4^L27.1
 ;;^UTILITY(U,$J,358.3,8157,2)
 ;;=^5009145
 ;;^UTILITY(U,$J,358.3,8158,0)
 ;;=L51.1^^65^521^44
 ;;^UTILITY(U,$J,358.3,8158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8158,1,3,0)
 ;;=3^Stevens-Johnson Syndrome
 ;;^UTILITY(U,$J,358.3,8158,1,4,0)
 ;;=4^L51.1
 ;;^UTILITY(U,$J,358.3,8158,2)
 ;;=^336636
 ;;^UTILITY(U,$J,358.3,8159,0)
 ;;=L51.3^^65^521^45
 ;;^UTILITY(U,$J,358.3,8159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8159,1,3,0)
 ;;=3^Stevens-Johnson Syndrome-Toxic Epdrml Necrolysis Overlap Syndrome
 ;;^UTILITY(U,$J,358.3,8159,1,4,0)
 ;;=4^L51.3
 ;;^UTILITY(U,$J,358.3,8159,2)
 ;;=^336637
 ;;^UTILITY(U,$J,358.3,8160,0)
 ;;=Z12.83^^65^521^21
 ;;^UTILITY(U,$J,358.3,8160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8160,1,3,0)
 ;;=3^Screening for Malig Neop of Skin
 ;;^UTILITY(U,$J,358.3,8160,1,4,0)
 ;;=4^Z12.83
 ;;^UTILITY(U,$J,358.3,8160,2)
 ;;=^5062696
 ;;^UTILITY(U,$J,358.3,8161,0)
 ;;=Z48.817^^65^521^48
 ;;^UTILITY(U,$J,358.3,8161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8161,1,3,0)
 ;;=3^Surgical Aftercare Following Skin Surgery
 ;;^UTILITY(U,$J,358.3,8161,1,4,0)
 ;;=4^Z48.817
 ;;^UTILITY(U,$J,358.3,8161,2)
 ;;=^5063054
 ;;^UTILITY(U,$J,358.3,8162,0)
 ;;=L94.0^^65^521^20
 ;;^UTILITY(U,$J,358.3,8162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8162,1,3,0)
 ;;=3^Scleroderma,Localized
 ;;^UTILITY(U,$J,358.3,8162,1,4,0)
 ;;=4^L94.0
 ;;^UTILITY(U,$J,358.3,8162,2)
 ;;=^5009470
 ;;^UTILITY(U,$J,358.3,8163,0)
 ;;=D23.9^^65^521^22
 ;;^UTILITY(U,$J,358.3,8163,1,0)
 ;;=^358.31IA^4^2
