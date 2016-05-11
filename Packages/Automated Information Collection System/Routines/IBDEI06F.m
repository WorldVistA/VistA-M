IBDEI06F ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2677,1,3,0)
 ;;=3^Hemorrhoidal Skin Tags,Residual
 ;;^UTILITY(U,$J,358.3,2677,1,4,0)
 ;;=4^K64.4
 ;;^UTILITY(U,$J,358.3,2677,2)
 ;;=^269834
 ;;^UTILITY(U,$J,358.3,2678,0)
 ;;=K64.8^^18^206^37
 ;;^UTILITY(U,$J,358.3,2678,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2678,1,3,0)
 ;;=3^Hemorrhoids,Other
 ;;^UTILITY(U,$J,358.3,2678,1,4,0)
 ;;=4^K64.8
 ;;^UTILITY(U,$J,358.3,2678,2)
 ;;=^5008774
 ;;^UTILITY(U,$J,358.3,2679,0)
 ;;=K64.5^^18^206^38
 ;;^UTILITY(U,$J,358.3,2679,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2679,1,3,0)
 ;;=3^Hemorrhoids,Perianal Venous Thrombosis
 ;;^UTILITY(U,$J,358.3,2679,1,4,0)
 ;;=4^K64.5
 ;;^UTILITY(U,$J,358.3,2679,2)
 ;;=^5008773
 ;;^UTILITY(U,$J,358.3,2680,0)
 ;;=K70.9^^18^206^46
 ;;^UTILITY(U,$J,358.3,2680,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2680,1,3,0)
 ;;=3^Hepatic Liver Disease,Alcoholic,Unspec
 ;;^UTILITY(U,$J,358.3,2680,1,4,0)
 ;;=4^K70.9
 ;;^UTILITY(U,$J,358.3,2680,2)
 ;;=^5008792
 ;;^UTILITY(U,$J,358.3,2681,0)
 ;;=K75.9^^18^206^47
 ;;^UTILITY(U,$J,358.3,2681,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2681,1,3,0)
 ;;=3^Hepatic Liver Disease,Inflammatory,Unspec
 ;;^UTILITY(U,$J,358.3,2681,1,4,0)
 ;;=4^K75.9
 ;;^UTILITY(U,$J,358.3,2681,2)
 ;;=^5008830
 ;;^UTILITY(U,$J,358.3,2682,0)
 ;;=K71.9^^18^206^48
 ;;^UTILITY(U,$J,358.3,2682,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2682,1,3,0)
 ;;=3^Hepatic Liver Disease,Toxic,Unspec
 ;;^UTILITY(U,$J,358.3,2682,1,4,0)
 ;;=4^K71.9
 ;;^UTILITY(U,$J,358.3,2682,2)
 ;;=^5008804
 ;;^UTILITY(U,$J,358.3,2683,0)
 ;;=K76.9^^18^206^49
 ;;^UTILITY(U,$J,358.3,2683,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2683,1,3,0)
 ;;=3^Hepatic Liver Disease,Unspec
 ;;^UTILITY(U,$J,358.3,2683,1,4,0)
 ;;=4^K76.9
 ;;^UTILITY(U,$J,358.3,2683,2)
 ;;=^5008836
 ;;^UTILITY(U,$J,358.3,2684,0)
 ;;=K74.60^^18^206^39
 ;;^UTILITY(U,$J,358.3,2684,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2684,1,3,0)
 ;;=3^Hepatic Cirrhosis,Unspec
 ;;^UTILITY(U,$J,358.3,2684,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,2684,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,2685,0)
 ;;=K72.01^^18^206^40
 ;;^UTILITY(U,$J,358.3,2685,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2685,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/ Coma
 ;;^UTILITY(U,$J,358.3,2685,1,4,0)
 ;;=4^K72.01
 ;;^UTILITY(U,$J,358.3,2685,2)
 ;;=^5008806
 ;;^UTILITY(U,$J,358.3,2686,0)
 ;;=K72.00^^18^206^41
 ;;^UTILITY(U,$J,358.3,2686,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2686,1,3,0)
 ;;=3^Hepatic Failure,Acute/Subacute w/o Coma
 ;;^UTILITY(U,$J,358.3,2686,1,4,0)
 ;;=4^K72.00
 ;;^UTILITY(U,$J,358.3,2686,2)
 ;;=^5008805
 ;;^UTILITY(U,$J,358.3,2687,0)
 ;;=K72.11^^18^206^42
 ;;^UTILITY(U,$J,358.3,2687,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2687,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/ Coma
 ;;^UTILITY(U,$J,358.3,2687,1,4,0)
 ;;=4^K72.11
 ;;^UTILITY(U,$J,358.3,2687,2)
 ;;=^5008808
 ;;^UTILITY(U,$J,358.3,2688,0)
 ;;=K72.10^^18^206^43
 ;;^UTILITY(U,$J,358.3,2688,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2688,1,3,0)
 ;;=3^Hepatic Failure,Chronic w/o Coma
 ;;^UTILITY(U,$J,358.3,2688,1,4,0)
 ;;=4^K72.10
 ;;^UTILITY(U,$J,358.3,2688,2)
 ;;=^5008807
 ;;^UTILITY(U,$J,358.3,2689,0)
 ;;=K72.91^^18^206^44
 ;;^UTILITY(U,$J,358.3,2689,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2689,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/ Coma
 ;;^UTILITY(U,$J,358.3,2689,1,4,0)
 ;;=4^K72.91
 ;;^UTILITY(U,$J,358.3,2689,2)
 ;;=^5008810
 ;;^UTILITY(U,$J,358.3,2690,0)
 ;;=K72.90^^18^206^45
 ;;^UTILITY(U,$J,358.3,2690,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2690,1,3,0)
 ;;=3^Hepatic Failure,Unspec w/o Coma
