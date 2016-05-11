IBDEI06I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2717,1,3,0)
 ;;=3^Anemia in Neoplastic Disease
 ;;^UTILITY(U,$J,358.3,2717,1,4,0)
 ;;=4^D63.0
 ;;^UTILITY(U,$J,358.3,2717,2)
 ;;=^321978
 ;;^UTILITY(U,$J,358.3,2718,0)
 ;;=D63.8^^18^207^4
 ;;^UTILITY(U,$J,358.3,2718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2718,1,3,0)
 ;;=3^Anemia in Chronic Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,2718,1,4,0)
 ;;=4^D63.8
 ;;^UTILITY(U,$J,358.3,2718,2)
 ;;=^5002343
 ;;^UTILITY(U,$J,358.3,2719,0)
 ;;=D59.9^^18^207^5
 ;;^UTILITY(U,$J,358.3,2719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2719,1,3,0)
 ;;=3^Anemia,Acquired Hemolytic,Unspec
 ;;^UTILITY(U,$J,358.3,2719,1,4,0)
 ;;=4^D59.9
 ;;^UTILITY(U,$J,358.3,2719,2)
 ;;=^5002330
 ;;^UTILITY(U,$J,358.3,2720,0)
 ;;=D62.^^18^207^6
 ;;^UTILITY(U,$J,358.3,2720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2720,1,3,0)
 ;;=3^Anemia,Acute Posthemorrhagic
 ;;^UTILITY(U,$J,358.3,2720,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,2720,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,2721,0)
 ;;=D61.9^^18^207^7
 ;;^UTILITY(U,$J,358.3,2721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2721,1,3,0)
 ;;=3^Anemia,Aplastic,Unspec
 ;;^UTILITY(U,$J,358.3,2721,1,4,0)
 ;;=4^D61.9
 ;;^UTILITY(U,$J,358.3,2721,2)
 ;;=^5002342
 ;;^UTILITY(U,$J,358.3,2722,0)
 ;;=D52.9^^18^207^8
 ;;^UTILITY(U,$J,358.3,2722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2722,1,3,0)
 ;;=3^Anemia,Folate Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,2722,1,4,0)
 ;;=4^D52.9
 ;;^UTILITY(U,$J,358.3,2722,2)
 ;;=^5002293
 ;;^UTILITY(U,$J,358.3,2723,0)
 ;;=D58.9^^18^207^9
 ;;^UTILITY(U,$J,358.3,2723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2723,1,3,0)
 ;;=3^Anemia,Herediatary Hemolytic,Unspec
 ;;^UTILITY(U,$J,358.3,2723,1,4,0)
 ;;=4^D58.9
 ;;^UTILITY(U,$J,358.3,2723,2)
 ;;=^5002322
 ;;^UTILITY(U,$J,358.3,2724,0)
 ;;=D50.0^^18^207^10
 ;;^UTILITY(U,$J,358.3,2724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2724,1,3,0)
 ;;=3^Anemia,Iron Deficiency,Secondary to Blood Loss
 ;;^UTILITY(U,$J,358.3,2724,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,2724,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,2725,0)
 ;;=D50.9^^18^207^11
 ;;^UTILITY(U,$J,358.3,2725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2725,1,3,0)
 ;;=3^Anemia,Iron Deficiency,Unspec
 ;;^UTILITY(U,$J,358.3,2725,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,2725,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,2726,0)
 ;;=D53.9^^18^207^12
 ;;^UTILITY(U,$J,358.3,2726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2726,1,3,0)
 ;;=3^Anemia,Nutritional,Unspec
 ;;^UTILITY(U,$J,358.3,2726,1,4,0)
 ;;=4^D53.9
 ;;^UTILITY(U,$J,358.3,2726,2)
 ;;=^5002298
 ;;^UTILITY(U,$J,358.3,2727,0)
 ;;=D51.0^^18^207^13
 ;;^UTILITY(U,$J,358.3,2727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2727,1,3,0)
 ;;=3^Anemia,Pernicious (Vitamin B12 Defic)
 ;;^UTILITY(U,$J,358.3,2727,1,4,0)
 ;;=4^D51.0
 ;;^UTILITY(U,$J,358.3,2727,2)
 ;;=^5002284
 ;;^UTILITY(U,$J,358.3,2728,0)
 ;;=D46.4^^18^207^14
 ;;^UTILITY(U,$J,358.3,2728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2728,1,3,0)
 ;;=3^Anemia,Refractory,Unspec
 ;;^UTILITY(U,$J,358.3,2728,1,4,0)
 ;;=4^D46.4
 ;;^UTILITY(U,$J,358.3,2728,2)
 ;;=^5002250
 ;;^UTILITY(U,$J,358.3,2729,0)
 ;;=D57.419^^18^207^15
 ;;^UTILITY(U,$J,358.3,2729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2729,1,3,0)
 ;;=3^Anemia,Sickle-Cell Thalassemia w/ Crisis,Unspec
 ;;^UTILITY(U,$J,358.3,2729,1,4,0)
 ;;=4^D57.419
 ;;^UTILITY(U,$J,358.3,2729,2)
 ;;=^5002316
 ;;^UTILITY(U,$J,358.3,2730,0)
 ;;=D57.40^^18^207^16
 ;;^UTILITY(U,$J,358.3,2730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2730,1,3,0)
 ;;=3^Anemia,Sickle-Cell Thalassemia w/o Crisis
