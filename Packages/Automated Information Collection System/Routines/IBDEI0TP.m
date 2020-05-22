IBDEI0TP ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13221,1,3,0)
 ;;=3^Complication of Enterostomy,Unspec
 ;;^UTILITY(U,$J,358.3,13221,1,4,0)
 ;;=4^K94.10
 ;;^UTILITY(U,$J,358.3,13221,2)
 ;;=^5008923
 ;;^UTILITY(U,$J,358.3,13222,0)
 ;;=K94.30^^83^808^15
 ;;^UTILITY(U,$J,358.3,13222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13222,1,3,0)
 ;;=3^Complication of Esophagostomy,Unspec
 ;;^UTILITY(U,$J,358.3,13222,1,4,0)
 ;;=4^K94.30
 ;;^UTILITY(U,$J,358.3,13222,2)
 ;;=^5008933
 ;;^UTILITY(U,$J,358.3,13223,0)
 ;;=K94.20^^83^808^16
 ;;^UTILITY(U,$J,358.3,13223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13223,1,3,0)
 ;;=3^Complication of Gastrostomy,Unspec
 ;;^UTILITY(U,$J,358.3,13223,1,4,0)
 ;;=4^K94.20
 ;;^UTILITY(U,$J,358.3,13223,2)
 ;;=^5008928
 ;;^UTILITY(U,$J,358.3,13224,0)
 ;;=K59.00^^83^808^17
 ;;^UTILITY(U,$J,358.3,13224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13224,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,13224,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,13224,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,13225,0)
 ;;=K50.00^^83^808^18
 ;;^UTILITY(U,$J,358.3,13225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13225,1,3,0)
 ;;=3^Crohn's Disease,Small Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,13225,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,13225,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,13226,0)
 ;;=K92.9^^83^808^19
 ;;^UTILITY(U,$J,358.3,13226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13226,1,3,0)
 ;;=3^Digestive System Disease,Unspec
 ;;^UTILITY(U,$J,358.3,13226,1,4,0)
 ;;=4^K92.9
 ;;^UTILITY(U,$J,358.3,13226,2)
 ;;=^5008917
 ;;^UTILITY(U,$J,358.3,13227,0)
 ;;=K57.93^^83^808^22
 ;;^UTILITY(U,$J,358.3,13227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13227,1,3,0)
 ;;=3^Dvtrcli of Intest w/o Perf/Abscess w/ Bleeding
 ;;^UTILITY(U,$J,358.3,13227,1,4,0)
 ;;=4^K57.93
 ;;^UTILITY(U,$J,358.3,13227,2)
 ;;=^5008738
 ;;^UTILITY(U,$J,358.3,13228,0)
 ;;=K57.92^^83^808^23
 ;;^UTILITY(U,$J,358.3,13228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13228,1,3,0)
 ;;=3^Dvtrcli of Intest w/o Perf/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13228,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,13228,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,13229,0)
 ;;=K57.91^^83^808^20
 ;;^UTILITY(U,$J,358.3,13229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13229,1,3,0)
 ;;=3^Dvrtclos of Intest w/o Perf/Abscess w/ Bleed
 ;;^UTILITY(U,$J,358.3,13229,1,4,0)
 ;;=4^K57.91
 ;;^UTILITY(U,$J,358.3,13229,2)
 ;;=^5008736
 ;;^UTILITY(U,$J,358.3,13230,0)
 ;;=K57.90^^83^808^21
 ;;^UTILITY(U,$J,358.3,13230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13230,1,3,0)
 ;;=3^Dvrtclos of Intest w/o Perf/Abscess w/o Bleed
 ;;^UTILITY(U,$J,358.3,13230,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,13230,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,13231,0)
 ;;=K30.^^83^808^24
 ;;^UTILITY(U,$J,358.3,13231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13231,1,3,0)
 ;;=3^Dyspepsia,Functional
 ;;^UTILITY(U,$J,358.3,13231,1,4,0)
 ;;=4^K30.
 ;;^UTILITY(U,$J,358.3,13231,2)
 ;;=^5008558
 ;;^UTILITY(U,$J,358.3,13232,0)
 ;;=K08.109^^83^808^25
 ;;^UTILITY(U,$J,358.3,13232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13232,1,3,0)
 ;;=3^Edentulous
 ;;^UTILITY(U,$J,358.3,13232,1,4,0)
 ;;=4^K08.109
 ;;^UTILITY(U,$J,358.3,13232,2)
 ;;=^5008410
 ;;^UTILITY(U,$J,358.3,13233,0)
 ;;=K22.9^^83^808^26
 ;;^UTILITY(U,$J,358.3,13233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13233,1,3,0)
 ;;=3^Esophagus Disease,Unspec
