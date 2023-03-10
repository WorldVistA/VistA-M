IBDEI0IG ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8302,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8302,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,8302,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,8303,0)
 ;;=K57.50^^39^397^48
 ;;^UTILITY(U,$J,358.3,8303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8303,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8303,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,8303,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,8304,0)
 ;;=K57.90^^39^397^46
 ;;^UTILITY(U,$J,358.3,8304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8304,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8304,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,8304,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,8305,0)
 ;;=K57.20^^39^397^42
 ;;^UTILITY(U,$J,358.3,8305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8305,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8305,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,8305,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,8306,0)
 ;;=K57.92^^39^397^41
 ;;^UTILITY(U,$J,358.3,8306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8306,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8306,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,8306,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,8307,0)
 ;;=K57.80^^39^397^40
 ;;^UTILITY(U,$J,358.3,8307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8307,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8307,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,8307,2)
 ;;=^5008733
 ;;^UTILITY(U,$J,358.3,8308,0)
 ;;=K57.52^^39^397^45
 ;;^UTILITY(U,$J,358.3,8308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8308,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8308,1,4,0)
 ;;=4^K57.52
 ;;^UTILITY(U,$J,358.3,8308,2)
 ;;=^5008731
 ;;^UTILITY(U,$J,358.3,8309,0)
 ;;=K57.40^^39^397^44
 ;;^UTILITY(U,$J,358.3,8309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8309,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8309,1,4,0)
 ;;=4^K57.40
 ;;^UTILITY(U,$J,358.3,8309,2)
 ;;=^5008727
 ;;^UTILITY(U,$J,358.3,8310,0)
 ;;=K57.32^^39^397^43
 ;;^UTILITY(U,$J,358.3,8310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8310,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,8310,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,8310,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,8311,0)
 ;;=K59.00^^39^397^22
 ;;^UTILITY(U,$J,358.3,8311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8311,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,8311,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,8311,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,8312,0)
 ;;=K58.9^^39^397^79
 ;;^UTILITY(U,$J,358.3,8312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8312,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,8312,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,8312,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,8313,0)
 ;;=K58.0^^39^397^78
 ;;^UTILITY(U,$J,358.3,8313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8313,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/ Diarrhea
