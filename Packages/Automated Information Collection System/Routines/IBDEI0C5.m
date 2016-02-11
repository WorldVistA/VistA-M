IBDEI0C5 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5237,1,4,0)
 ;;=4^K70.30
 ;;^UTILITY(U,$J,358.3,5237,2)
 ;;=^5008788
 ;;^UTILITY(U,$J,358.3,5238,0)
 ;;=K70.31^^40^358^1
 ;;^UTILITY(U,$J,358.3,5238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5238,1,3,0)
 ;;=3^Alcoholic Cirrhosis of Liver w/ Ascites
 ;;^UTILITY(U,$J,358.3,5238,1,4,0)
 ;;=4^K70.31
 ;;^UTILITY(U,$J,358.3,5238,2)
 ;;=^5008789
 ;;^UTILITY(U,$J,358.3,5239,0)
 ;;=K74.60^^40^358^5
 ;;^UTILITY(U,$J,358.3,5239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5239,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,5239,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,5239,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,5240,0)
 ;;=K74.69^^40^358^4
 ;;^UTILITY(U,$J,358.3,5240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5240,1,3,0)
 ;;=3^Cirrhosis of Liver NEC
 ;;^UTILITY(U,$J,358.3,5240,1,4,0)
 ;;=4^K74.69
 ;;^UTILITY(U,$J,358.3,5240,2)
 ;;=^5008823
 ;;^UTILITY(U,$J,358.3,5241,0)
 ;;=K70.2^^40^358^3
 ;;^UTILITY(U,$J,358.3,5241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5241,1,3,0)
 ;;=3^Alcoholic Fibrosis/Sclerosis of Liver
 ;;^UTILITY(U,$J,358.3,5241,1,4,0)
 ;;=4^K70.2
 ;;^UTILITY(U,$J,358.3,5241,2)
 ;;=^5008787
 ;;^UTILITY(U,$J,358.3,5242,0)
 ;;=K74.0^^40^358^6
 ;;^UTILITY(U,$J,358.3,5242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5242,1,3,0)
 ;;=3^Hepatic Fibrosis
 ;;^UTILITY(U,$J,358.3,5242,1,4,0)
 ;;=4^K74.0
 ;;^UTILITY(U,$J,358.3,5242,2)
 ;;=^5008816
 ;;^UTILITY(U,$J,358.3,5243,0)
 ;;=K74.2^^40^358^7
 ;;^UTILITY(U,$J,358.3,5243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5243,1,3,0)
 ;;=3^Hepatic Fibrosis w/ Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,5243,1,4,0)
 ;;=4^K74.2
 ;;^UTILITY(U,$J,358.3,5243,2)
 ;;=^5008818
 ;;^UTILITY(U,$J,358.3,5244,0)
 ;;=K74.1^^40^358^8
 ;;^UTILITY(U,$J,358.3,5244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5244,1,3,0)
 ;;=3^Hepatic Sclerosis
 ;;^UTILITY(U,$J,358.3,5244,1,4,0)
 ;;=4^K74.1
 ;;^UTILITY(U,$J,358.3,5244,2)
 ;;=^5008817
 ;;^UTILITY(U,$J,358.3,5245,0)
 ;;=K52.2^^40^359^1
 ;;^UTILITY(U,$J,358.3,5245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5245,1,3,0)
 ;;=3^Allergic/Dietetic Gastroenteritis/Colitis
 ;;^UTILITY(U,$J,358.3,5245,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,5245,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,5246,0)
 ;;=K52.89^^40^359^2
 ;;^UTILITY(U,$J,358.3,5246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5246,1,3,0)
 ;;=3^Noninfective Gastroenteritis/Colitis NEC
 ;;^UTILITY(U,$J,358.3,5246,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,5246,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,5247,0)
 ;;=K51.90^^40^359^9
 ;;^UTILITY(U,$J,358.3,5247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5247,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,5247,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,5247,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,5248,0)
 ;;=K51.919^^40^359^8
 ;;^UTILITY(U,$J,358.3,5248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5248,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,5248,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,5248,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,5249,0)
 ;;=K51.912^^40^359^5
 ;;^UTILITY(U,$J,358.3,5249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5249,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,5249,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,5249,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,5250,0)
 ;;=K51.913^^40^359^4
 ;;^UTILITY(U,$J,358.3,5250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5250,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,5250,1,4,0)
 ;;=4^K51.913
