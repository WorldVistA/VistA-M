IBDEI160 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19812,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,19812,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,19812,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,19813,0)
 ;;=K57.30^^84^924^42
 ;;^UTILITY(U,$J,358.3,19813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19813,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19813,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,19813,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,19814,0)
 ;;=K57.50^^84^924^43
 ;;^UTILITY(U,$J,358.3,19814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19814,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19814,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,19814,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,19815,0)
 ;;=K57.90^^84^924^41
 ;;^UTILITY(U,$J,358.3,19815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19815,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19815,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,19815,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,19816,0)
 ;;=K57.20^^84^924^37
 ;;^UTILITY(U,$J,358.3,19816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19816,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19816,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,19816,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,19817,0)
 ;;=K57.92^^84^924^36
 ;;^UTILITY(U,$J,358.3,19817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19817,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19817,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,19817,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,19818,0)
 ;;=K57.80^^84^924^35
 ;;^UTILITY(U,$J,358.3,19818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19818,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19818,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,19818,2)
 ;;=^5008733
 ;;^UTILITY(U,$J,358.3,19819,0)
 ;;=K57.52^^84^924^40
 ;;^UTILITY(U,$J,358.3,19819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19819,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19819,1,4,0)
 ;;=4^K57.52
 ;;^UTILITY(U,$J,358.3,19819,2)
 ;;=^5008731
 ;;^UTILITY(U,$J,358.3,19820,0)
 ;;=K57.40^^84^924^39
 ;;^UTILITY(U,$J,358.3,19820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19820,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19820,1,4,0)
 ;;=4^K57.40
 ;;^UTILITY(U,$J,358.3,19820,2)
 ;;=^5008727
 ;;^UTILITY(U,$J,358.3,19821,0)
 ;;=K57.32^^84^924^38
 ;;^UTILITY(U,$J,358.3,19821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19821,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,19821,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,19821,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,19822,0)
 ;;=K59.00^^84^924^20
 ;;^UTILITY(U,$J,358.3,19822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19822,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,19822,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,19822,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,19823,0)
 ;;=K58.9^^84^924^70
 ;;^UTILITY(U,$J,358.3,19823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,19823,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,19823,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,19823,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,19824,0)
 ;;=K58.0^^84^924^69
