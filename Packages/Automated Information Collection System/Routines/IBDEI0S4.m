IBDEI0S4 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13186,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,13186,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,13186,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,13187,0)
 ;;=K57.30^^53^588^42
 ;;^UTILITY(U,$J,358.3,13187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13187,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13187,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,13187,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,13188,0)
 ;;=K57.50^^53^588^43
 ;;^UTILITY(U,$J,358.3,13188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13188,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13188,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,13188,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,13189,0)
 ;;=K57.90^^53^588^41
 ;;^UTILITY(U,$J,358.3,13189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13189,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13189,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,13189,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,13190,0)
 ;;=K57.20^^53^588^37
 ;;^UTILITY(U,$J,358.3,13190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13190,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13190,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,13190,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,13191,0)
 ;;=K57.92^^53^588^36
 ;;^UTILITY(U,$J,358.3,13191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13191,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13191,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,13191,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,13192,0)
 ;;=K57.80^^53^588^35
 ;;^UTILITY(U,$J,358.3,13192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13192,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13192,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,13192,2)
 ;;=^5008733
 ;;^UTILITY(U,$J,358.3,13193,0)
 ;;=K57.52^^53^588^40
 ;;^UTILITY(U,$J,358.3,13193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13193,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13193,1,4,0)
 ;;=4^K57.52
 ;;^UTILITY(U,$J,358.3,13193,2)
 ;;=^5008731
 ;;^UTILITY(U,$J,358.3,13194,0)
 ;;=K57.40^^53^588^39
 ;;^UTILITY(U,$J,358.3,13194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13194,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13194,1,4,0)
 ;;=4^K57.40
 ;;^UTILITY(U,$J,358.3,13194,2)
 ;;=^5008727
 ;;^UTILITY(U,$J,358.3,13195,0)
 ;;=K57.32^^53^588^38
 ;;^UTILITY(U,$J,358.3,13195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13195,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,13195,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,13195,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,13196,0)
 ;;=K59.00^^53^588^20
 ;;^UTILITY(U,$J,358.3,13196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13196,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,13196,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,13196,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,13197,0)
 ;;=K58.9^^53^588^70
 ;;^UTILITY(U,$J,358.3,13197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13197,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,13197,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,13197,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,13198,0)
 ;;=K58.0^^53^588^69
