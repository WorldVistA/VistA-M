IBDEI06D ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2650,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2650,1,3,0)
 ;;=3^Burping-Belching
 ;;^UTILITY(U,$J,358.3,2650,1,4,0)
 ;;=4^R14.2
 ;;^UTILITY(U,$J,358.3,2650,2)
 ;;=^5019242
 ;;^UTILITY(U,$J,358.3,2651,0)
 ;;=K90.0^^18^206^10
 ;;^UTILITY(U,$J,358.3,2651,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2651,1,3,0)
 ;;=3^Celiac Disease
 ;;^UTILITY(U,$J,358.3,2651,1,4,0)
 ;;=4^K90.0
 ;;^UTILITY(U,$J,358.3,2651,2)
 ;;=^20828
 ;;^UTILITY(U,$J,358.3,2652,0)
 ;;=K51.00^^18^206^12
 ;;^UTILITY(U,$J,358.3,2652,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2652,1,3,0)
 ;;=3^Colitis,Ulcerative
 ;;^UTILITY(U,$J,358.3,2652,1,4,0)
 ;;=4^K51.00
 ;;^UTILITY(U,$J,358.3,2652,2)
 ;;=^5008652
 ;;^UTILITY(U,$J,358.3,2653,0)
 ;;=K94.00^^18^206^13
 ;;^UTILITY(U,$J,358.3,2653,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2653,1,3,0)
 ;;=3^Complication of Colostomy,Unspec
 ;;^UTILITY(U,$J,358.3,2653,1,4,0)
 ;;=4^K94.00
 ;;^UTILITY(U,$J,358.3,2653,2)
 ;;=^5008918
 ;;^UTILITY(U,$J,358.3,2654,0)
 ;;=K94.10^^18^206^14
 ;;^UTILITY(U,$J,358.3,2654,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2654,1,3,0)
 ;;=3^Complication of Enterostomy,Unspec
 ;;^UTILITY(U,$J,358.3,2654,1,4,0)
 ;;=4^K94.10
 ;;^UTILITY(U,$J,358.3,2654,2)
 ;;=^5008923
 ;;^UTILITY(U,$J,358.3,2655,0)
 ;;=K94.30^^18^206^15
 ;;^UTILITY(U,$J,358.3,2655,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2655,1,3,0)
 ;;=3^Complication of Esophagostomy,Unspec
 ;;^UTILITY(U,$J,358.3,2655,1,4,0)
 ;;=4^K94.30
 ;;^UTILITY(U,$J,358.3,2655,2)
 ;;=^5008933
 ;;^UTILITY(U,$J,358.3,2656,0)
 ;;=K94.20^^18^206^16
 ;;^UTILITY(U,$J,358.3,2656,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2656,1,3,0)
 ;;=3^Complication of Gastrostomy,Unspec
 ;;^UTILITY(U,$J,358.3,2656,1,4,0)
 ;;=4^K94.20
 ;;^UTILITY(U,$J,358.3,2656,2)
 ;;=^5008928
 ;;^UTILITY(U,$J,358.3,2657,0)
 ;;=K59.00^^18^206^17
 ;;^UTILITY(U,$J,358.3,2657,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2657,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,2657,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,2657,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,2658,0)
 ;;=K50.00^^18^206^18
 ;;^UTILITY(U,$J,358.3,2658,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2658,1,3,0)
 ;;=3^Crohn's Disease,Small Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,2658,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,2658,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,2659,0)
 ;;=K92.9^^18^206^19
 ;;^UTILITY(U,$J,358.3,2659,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2659,1,3,0)
 ;;=3^Digestive System Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2659,1,4,0)
 ;;=4^K92.9
 ;;^UTILITY(U,$J,358.3,2659,2)
 ;;=^5008917
 ;;^UTILITY(U,$J,358.3,2660,0)
 ;;=K57.93^^18^206^22
 ;;^UTILITY(U,$J,358.3,2660,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2660,1,3,0)
 ;;=3^Dvtrcli of Intest w/o Perf/Abscess w/ Bleeding
 ;;^UTILITY(U,$J,358.3,2660,1,4,0)
 ;;=4^K57.93
 ;;^UTILITY(U,$J,358.3,2660,2)
 ;;=^5008738
 ;;^UTILITY(U,$J,358.3,2661,0)
 ;;=K57.92^^18^206^23
 ;;^UTILITY(U,$J,358.3,2661,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2661,1,3,0)
 ;;=3^Dvtrcli of Intest w/o Perf/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,2661,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,2661,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,2662,0)
 ;;=K57.91^^18^206^20
 ;;^UTILITY(U,$J,358.3,2662,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2662,1,3,0)
 ;;=3^Dvrtclos of Intest w/o Perf/Abscess w/ Bleed
 ;;^UTILITY(U,$J,358.3,2662,1,4,0)
 ;;=4^K57.91
 ;;^UTILITY(U,$J,358.3,2662,2)
 ;;=^5008736
 ;;^UTILITY(U,$J,358.3,2663,0)
 ;;=K57.90^^18^206^21
 ;;^UTILITY(U,$J,358.3,2663,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2663,1,3,0)
 ;;=3^Dvrtclos of Intest w/o Perf/Abscess w/o Bleed
