IBDEI2UT ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47892,1,3,0)
 ;;=3^Malig Neop of Left Central Portion of Breast
 ;;^UTILITY(U,$J,358.3,47892,1,4,0)
 ;;=4^C50.122
 ;;^UTILITY(U,$J,358.3,47892,2)
 ;;=^5001169
 ;;^UTILITY(U,$J,358.3,47893,0)
 ;;=C50.221^^209^2360^11
 ;;^UTILITY(U,$J,358.3,47893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47893,1,3,0)
 ;;=3^Malig Neop of Right Upper-Inner Quadrant of Breast
 ;;^UTILITY(U,$J,358.3,47893,1,4,0)
 ;;=4^C50.221
 ;;^UTILITY(U,$J,358.3,47893,2)
 ;;=^5001174
 ;;^UTILITY(U,$J,358.3,47894,0)
 ;;=C50.222^^209^2360^5
 ;;^UTILITY(U,$J,358.3,47894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47894,1,3,0)
 ;;=3^Malig Neop of Left Upper-Inner Quadrant of Breast
 ;;^UTILITY(U,$J,358.3,47894,1,4,0)
 ;;=4^C50.222
 ;;^UTILITY(U,$J,358.3,47894,2)
 ;;=^5001175
 ;;^UTILITY(U,$J,358.3,47895,0)
 ;;=C50.321^^209^2360^9
 ;;^UTILITY(U,$J,358.3,47895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47895,1,3,0)
 ;;=3^Malig Neop of Right Lower-Inner Quadrant of Breast
 ;;^UTILITY(U,$J,358.3,47895,1,4,0)
 ;;=4^C50.321
 ;;^UTILITY(U,$J,358.3,47895,2)
 ;;=^5001178
 ;;^UTILITY(U,$J,358.3,47896,0)
 ;;=C50.322^^209^2360^3
 ;;^UTILITY(U,$J,358.3,47896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47896,1,3,0)
 ;;=3^Malig Neop of Left Lower-Inner Quadrant of Breast
 ;;^UTILITY(U,$J,358.3,47896,1,4,0)
 ;;=4^C50.322
 ;;^UTILITY(U,$J,358.3,47896,2)
 ;;=^5133334
 ;;^UTILITY(U,$J,358.3,47897,0)
 ;;=C50.421^^209^2360^12
 ;;^UTILITY(U,$J,358.3,47897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47897,1,3,0)
 ;;=3^Malig Neop of Right Upper-Outer Quadrant of Breast
 ;;^UTILITY(U,$J,358.3,47897,1,4,0)
 ;;=4^C50.421
 ;;^UTILITY(U,$J,358.3,47897,2)
 ;;=^5001180
 ;;^UTILITY(U,$J,358.3,47898,0)
 ;;=C50.422^^209^2360^6
 ;;^UTILITY(U,$J,358.3,47898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47898,1,3,0)
 ;;=3^Malig Neop of Left Upper-Outer Quadrant of Breast
 ;;^UTILITY(U,$J,358.3,47898,1,4,0)
 ;;=4^C50.422
 ;;^UTILITY(U,$J,358.3,47898,2)
 ;;=^5133336
 ;;^UTILITY(U,$J,358.3,47899,0)
 ;;=C50.521^^209^2360^10
 ;;^UTILITY(U,$J,358.3,47899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47899,1,3,0)
 ;;=3^Malig Neop of Right Lower-Outer Quadrant of Breast
 ;;^UTILITY(U,$J,358.3,47899,1,4,0)
 ;;=4^C50.521
 ;;^UTILITY(U,$J,358.3,47899,2)
 ;;=^5001182
 ;;^UTILITY(U,$J,358.3,47900,0)
 ;;=C50.522^^209^2360^4
 ;;^UTILITY(U,$J,358.3,47900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47900,1,3,0)
 ;;=3^Malig Neop of Left Lower-Outer Quadrant of Breast
 ;;^UTILITY(U,$J,358.3,47900,1,4,0)
 ;;=4^C50.522
 ;;^UTILITY(U,$J,358.3,47900,2)
 ;;=^5133338
 ;;^UTILITY(U,$J,358.3,47901,0)
 ;;=C50.921^^209^2360^7
 ;;^UTILITY(U,$J,358.3,47901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47901,1,3,0)
 ;;=3^Malig Neop of Right Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,47901,1,4,0)
 ;;=4^C50.921
 ;;^UTILITY(U,$J,358.3,47901,2)
 ;;=^5001198
 ;;^UTILITY(U,$J,358.3,47902,0)
 ;;=C50.922^^209^2360^1
 ;;^UTILITY(U,$J,358.3,47902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47902,1,3,0)
 ;;=3^Malig Neop of Left Breast,Unspec Site
 ;;^UTILITY(U,$J,358.3,47902,1,4,0)
 ;;=4^C50.922
 ;;^UTILITY(U,$J,358.3,47902,2)
 ;;=^5133340
 ;;^UTILITY(U,$J,358.3,47903,0)
 ;;=C60.9^^209^2361^5
 ;;^UTILITY(U,$J,358.3,47903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47903,1,3,0)
 ;;=3^Malig Neop of Penis,Unspec
 ;;^UTILITY(U,$J,358.3,47903,1,4,0)
 ;;=4^C60.9
 ;;^UTILITY(U,$J,358.3,47903,2)
 ;;=^5001229
 ;;^UTILITY(U,$J,358.3,47904,0)
 ;;=C61.^^209^2361^6
 ;;^UTILITY(U,$J,358.3,47904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47904,1,3,0)
 ;;=3^Malig Neop of Prostate
