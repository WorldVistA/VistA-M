IBDEI1RX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30148,0)
 ;;=D57.20^^118^1501^17
 ;;^UTILITY(U,$J,358.3,30148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30148,1,3,0)
 ;;=3^Sickle-cell/Hb-C disease without crisis
 ;;^UTILITY(U,$J,358.3,30148,1,4,0)
 ;;=4^D57.20
 ;;^UTILITY(U,$J,358.3,30148,2)
 ;;=^330080
 ;;^UTILITY(U,$J,358.3,30149,0)
 ;;=D57.811^^118^1501^10
 ;;^UTILITY(U,$J,358.3,30149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30149,1,3,0)
 ;;=3^Sickle-Cell Disorders w/ Acute Chest Syndrome NEC
 ;;^UTILITY(U,$J,358.3,30149,1,4,0)
 ;;=4^D57.811
 ;;^UTILITY(U,$J,358.3,30149,2)
 ;;=^5002318
 ;;^UTILITY(U,$J,358.3,30150,0)
 ;;=D57.812^^118^1501^11
 ;;^UTILITY(U,$J,358.3,30150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30150,1,3,0)
 ;;=3^Sickle-Cell Disorders w/ Splenic Sequestration
 ;;^UTILITY(U,$J,358.3,30150,1,4,0)
 ;;=4^D57.812
 ;;^UTILITY(U,$J,358.3,30150,2)
 ;;=^5002319
 ;;^UTILITY(U,$J,358.3,30151,0)
 ;;=D57.819^^118^1501^12
 ;;^UTILITY(U,$J,358.3,30151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30151,1,3,0)
 ;;=3^Sickle-Cell Disorders w/ Unspec Crisis NEC
 ;;^UTILITY(U,$J,358.3,30151,1,4,0)
 ;;=4^D57.819
 ;;^UTILITY(U,$J,358.3,30151,2)
 ;;=^5002320
 ;;^UTILITY(U,$J,358.3,30152,0)
 ;;=D58.8^^118^1501^9
 ;;^UTILITY(U,$J,358.3,30152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30152,1,3,0)
 ;;=3^Hereditary Hemolytic Anemias NEC
 ;;^UTILITY(U,$J,358.3,30152,1,4,0)
 ;;=4^D58.8
 ;;^UTILITY(U,$J,358.3,30152,2)
 ;;=^267984
 ;;^UTILITY(U,$J,358.3,30153,0)
 ;;=D58.2^^118^1501^8
 ;;^UTILITY(U,$J,358.3,30153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30153,1,3,0)
 ;;=3^Hemoglobinopathies NEC
 ;;^UTILITY(U,$J,358.3,30153,1,4,0)
 ;;=4^D58.2
 ;;^UTILITY(U,$J,358.3,30153,2)
 ;;=^87629
 ;;^UTILITY(U,$J,358.3,30154,0)
 ;;=C83.10^^118^1502^52
 ;;^UTILITY(U,$J,358.3,30154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30154,1,3,0)
 ;;=3^Mantle cell lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,30154,1,4,0)
 ;;=4^C83.10
 ;;^UTILITY(U,$J,358.3,30154,2)
 ;;=^5001561
 ;;^UTILITY(U,$J,358.3,30155,0)
 ;;=C83.19^^118^1502^51
 ;;^UTILITY(U,$J,358.3,30155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30155,1,3,0)
 ;;=3^Mantle cell lymphoma, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,30155,1,4,0)
 ;;=4^C83.19
 ;;^UTILITY(U,$J,358.3,30155,2)
 ;;=^5001570
 ;;^UTILITY(U,$J,358.3,30156,0)
 ;;=C83.50^^118^1502^45
 ;;^UTILITY(U,$J,358.3,30156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30156,1,3,0)
 ;;=3^Lymphoblastic (diffuse) lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,30156,1,4,0)
 ;;=4^C83.50
 ;;^UTILITY(U,$J,358.3,30156,2)
 ;;=^5001581
 ;;^UTILITY(U,$J,358.3,30157,0)
 ;;=C83.59^^118^1502^46
 ;;^UTILITY(U,$J,358.3,30157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30157,1,3,0)
 ;;=3^Lymphoblastic lymphoma, extrnod and solid organ sites
 ;;^UTILITY(U,$J,358.3,30157,1,4,0)
 ;;=4^C83.59
 ;;^UTILITY(U,$J,358.3,30157,2)
 ;;=^5001590
 ;;^UTILITY(U,$J,358.3,30158,0)
 ;;=C83.70^^118^1502^12
 ;;^UTILITY(U,$J,358.3,30158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30158,1,3,0)
 ;;=3^Burkitt lymphoma, unspecified site
 ;;^UTILITY(U,$J,358.3,30158,1,4,0)
 ;;=4^C83.70
 ;;^UTILITY(U,$J,358.3,30158,2)
 ;;=^5001591
 ;;^UTILITY(U,$J,358.3,30159,0)
 ;;=C83.79^^118^1502^11
 ;;^UTILITY(U,$J,358.3,30159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30159,1,3,0)
 ;;=3^Burkitt lymphoma, extranodal and solid organ sites
 ;;^UTILITY(U,$J,358.3,30159,1,4,0)
 ;;=4^C83.79
 ;;^UTILITY(U,$J,358.3,30159,2)
 ;;=^5001600
 ;;^UTILITY(U,$J,358.3,30160,0)
 ;;=C81.00^^118^1502^61
 ;;^UTILITY(U,$J,358.3,30160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30160,1,3,0)
 ;;=3^Nodular lymphocyte predominant Hodgkin lymphoma, unsp site
