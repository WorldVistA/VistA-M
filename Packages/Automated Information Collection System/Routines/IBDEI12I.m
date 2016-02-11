IBDEI12I ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17810,0)
 ;;=K58.9^^91^882^41
 ;;^UTILITY(U,$J,358.3,17810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17810,1,3,0)
 ;;=3^Irritable bowel syndrome without diarrhea
 ;;^UTILITY(U,$J,358.3,17810,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,17810,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,17811,0)
 ;;=K60.0^^91^882^1
 ;;^UTILITY(U,$J,358.3,17811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17811,1,3,0)
 ;;=3^Acute anal fissure
 ;;^UTILITY(U,$J,358.3,17811,1,4,0)
 ;;=4^K60.0
 ;;^UTILITY(U,$J,358.3,17811,2)
 ;;=^5008745
 ;;^UTILITY(U,$J,358.3,17812,0)
 ;;=K60.2^^91^882^3
 ;;^UTILITY(U,$J,358.3,17812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17812,1,3,0)
 ;;=3^Anal fissure, unspecified
 ;;^UTILITY(U,$J,358.3,17812,1,4,0)
 ;;=4^K60.2
 ;;^UTILITY(U,$J,358.3,17812,2)
 ;;=^5008747
 ;;^UTILITY(U,$J,358.3,17813,0)
 ;;=K62.5^^91^882^36
 ;;^UTILITY(U,$J,358.3,17813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17813,1,3,0)
 ;;=3^Hemorrhage of anus and rectum
 ;;^UTILITY(U,$J,358.3,17813,1,4,0)
 ;;=4^K62.5
 ;;^UTILITY(U,$J,358.3,17813,2)
 ;;=^5008755
 ;;^UTILITY(U,$J,358.3,17814,0)
 ;;=K55.20^^91^882^6
 ;;^UTILITY(U,$J,358.3,17814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17814,1,3,0)
 ;;=3^Angiodysplasia of colon without hemorrhage
 ;;^UTILITY(U,$J,358.3,17814,1,4,0)
 ;;=4^K55.20
 ;;^UTILITY(U,$J,358.3,17814,2)
 ;;=^5008707
 ;;^UTILITY(U,$J,358.3,17815,0)
 ;;=K74.3^^91^882^46
 ;;^UTILITY(U,$J,358.3,17815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17815,1,3,0)
 ;;=3^Primary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,17815,1,4,0)
 ;;=4^K74.3
 ;;^UTILITY(U,$J,358.3,17815,2)
 ;;=^5008819
 ;;^UTILITY(U,$J,358.3,17816,0)
 ;;=K74.4^^91^882^48
 ;;^UTILITY(U,$J,358.3,17816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17816,1,3,0)
 ;;=3^Secondary biliary cirrhosis
 ;;^UTILITY(U,$J,358.3,17816,1,4,0)
 ;;=4^K74.4
 ;;^UTILITY(U,$J,358.3,17816,2)
 ;;=^5008820
 ;;^UTILITY(U,$J,358.3,17817,0)
 ;;=K92.1^^91^882^43
 ;;^UTILITY(U,$J,358.3,17817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17817,1,3,0)
 ;;=3^Melena
 ;;^UTILITY(U,$J,358.3,17817,1,4,0)
 ;;=4^K92.1
 ;;^UTILITY(U,$J,358.3,17817,2)
 ;;=^5008914
 ;;^UTILITY(U,$J,358.3,17818,0)
 ;;=K92.2^^91^882^34
 ;;^UTILITY(U,$J,358.3,17818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17818,1,3,0)
 ;;=3^Gastrointestinal hemorrhage, unspecified
 ;;^UTILITY(U,$J,358.3,17818,1,4,0)
 ;;=4^K92.2
 ;;^UTILITY(U,$J,358.3,17818,2)
 ;;=^5008915
 ;;^UTILITY(U,$J,358.3,17819,0)
 ;;=K90.1^^91^882^49
 ;;^UTILITY(U,$J,358.3,17819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17819,1,3,0)
 ;;=3^Tropical sprue
 ;;^UTILITY(U,$J,358.3,17819,1,4,0)
 ;;=4^K90.1
 ;;^UTILITY(U,$J,358.3,17819,2)
 ;;=^5008894
 ;;^UTILITY(U,$J,358.3,17820,0)
 ;;=K90.9^^91^882^39
 ;;^UTILITY(U,$J,358.3,17820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17820,1,3,0)
 ;;=3^Intestinal malabsorption, unspecified
 ;;^UTILITY(U,$J,358.3,17820,1,4,0)
 ;;=4^K90.9
 ;;^UTILITY(U,$J,358.3,17820,2)
 ;;=^5008899
 ;;^UTILITY(U,$J,358.3,17821,0)
 ;;=K52.2^^91^882^2
 ;;^UTILITY(U,$J,358.3,17821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17821,1,3,0)
 ;;=3^Allergic and dietetic gastroenteritis and colitis
 ;;^UTILITY(U,$J,358.3,17821,1,4,0)
 ;;=4^K52.2
 ;;^UTILITY(U,$J,358.3,17821,2)
 ;;=^5008701
 ;;^UTILITY(U,$J,358.3,17822,0)
 ;;=K52.89^^91^882^44
 ;;^UTILITY(U,$J,358.3,17822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17822,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis NEC
 ;;^UTILITY(U,$J,358.3,17822,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,17822,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,17823,0)
 ;;=K64.9^^91^882^37
