IBDEI07N ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3006,1,3,0)
 ;;=3^Personal Hx of PUD
 ;;^UTILITY(U,$J,358.3,3006,1,4,0)
 ;;=4^Z87.11
 ;;^UTILITY(U,$J,358.3,3006,2)
 ;;=^5063482
 ;;^UTILITY(U,$J,358.3,3007,0)
 ;;=D73.9^^28^245^70
 ;;^UTILITY(U,$J,358.3,3007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3007,1,3,0)
 ;;=3^Spleen Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3007,1,4,0)
 ;;=4^D73.9
 ;;^UTILITY(U,$J,358.3,3007,2)
 ;;=^5002386
 ;;^UTILITY(U,$J,358.3,3008,0)
 ;;=K26.7^^28^245^71
 ;;^UTILITY(U,$J,358.3,3008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3008,1,3,0)
 ;;=3^Ulcer,Chronic Duodenal w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,3008,1,4,0)
 ;;=4^K26.7
 ;;^UTILITY(U,$J,358.3,3008,2)
 ;;=^5008526
 ;;^UTILITY(U,$J,358.3,3009,0)
 ;;=K25.7^^28^245^72
 ;;^UTILITY(U,$J,358.3,3009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3009,1,3,0)
 ;;=3^Ulcer,Chronic Gastric w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,3009,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,3009,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,3010,0)
 ;;=K27.7^^28^245^73
 ;;^UTILITY(U,$J,358.3,3010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3010,1,3,0)
 ;;=3^Ulcer,Chronic Peptic w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,3010,1,4,0)
 ;;=4^K27.7
 ;;^UTILITY(U,$J,358.3,3010,2)
 ;;=^5008535
 ;;^UTILITY(U,$J,358.3,3011,0)
 ;;=D55.9^^28^246^1
 ;;^UTILITY(U,$J,358.3,3011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3011,1,3,0)
 ;;=3^Anemia d/t Enzyme Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3011,1,4,0)
 ;;=4^D55.9
 ;;^UTILITY(U,$J,358.3,3011,2)
 ;;=^5002304
 ;;^UTILITY(U,$J,358.3,3012,0)
 ;;=D63.1^^28^246^2
 ;;^UTILITY(U,$J,358.3,3012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3012,1,3,0)
 ;;=3^Anemia in Chronic Kidney Disease
 ;;^UTILITY(U,$J,358.3,3012,1,4,0)
 ;;=4^D63.1
 ;;^UTILITY(U,$J,358.3,3012,2)
 ;;=^332908
 ;;^UTILITY(U,$J,358.3,3013,0)
 ;;=D63.0^^28^246^3
 ;;^UTILITY(U,$J,358.3,3013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3013,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,3013,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,3013,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,3014,0)
 ;;=D63.8^^28^246^4
 ;;^UTILITY(U,$J,358.3,3014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3014,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,3014,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,3014,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,3015,0)
 ;;=D59.9^^28^246^5
 ;;^UTILITY(U,$J,358.3,3015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3015,1,3,0)
 ;;=3^Anemia,Acquired Hemolytic,Unspec
 ;;^UTILITY(U,$J,358.3,3015,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,3015,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,3016,0)
 ;;=D62.^^28^246^6
 ;;^UTILITY(U,$J,358.3,3016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3016,1,3,0)
 ;;=3^Anemia,Acute Posthemorrhagic
 ;;^UTILITY(U,$J,358.3,3016,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,3016,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,3017,0)
 ;;=D61.9^^28^246^7
 ;;^UTILITY(U,$J,358.3,3017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3017,1,3,0)
 ;;=3^Anemia,Aplastic,Unspec
 ;;^UTILITY(U,$J,358.3,3017,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,3017,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,3018,0)
 ;;=D52.9^^28^246^8
 ;;^UTILITY(U,$J,358.3,3018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3018,1,3,0)
 ;;=3^Anemia,Folate Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,3018,1,4,0)
 ;;=4^D52.9
 ;;^UTILITY(U,$J,358.3,3018,2)
 ;;=^5002293
 ;;^UTILITY(U,$J,358.3,3019,0)
 ;;=D58.9^^28^246^9
 ;;^UTILITY(U,$J,358.3,3019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3019,1,3,0)
 ;;=3^Anemia,Herediatary Hemolytic,Unspec
