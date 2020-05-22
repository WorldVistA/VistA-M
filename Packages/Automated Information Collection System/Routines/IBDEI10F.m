IBDEI10F ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16239,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,16239,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,16239,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,16240,0)
 ;;=K57.92^^88^875^41
 ;;^UTILITY(U,$J,358.3,16240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16240,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,16240,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,16240,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,16241,0)
 ;;=K57.80^^88^875^40
 ;;^UTILITY(U,$J,358.3,16241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16241,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,16241,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,16241,2)
 ;;=^5008733
 ;;^UTILITY(U,$J,358.3,16242,0)
 ;;=K57.52^^88^875^45
 ;;^UTILITY(U,$J,358.3,16242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16242,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,16242,1,4,0)
 ;;=4^K57.52
 ;;^UTILITY(U,$J,358.3,16242,2)
 ;;=^5008731
 ;;^UTILITY(U,$J,358.3,16243,0)
 ;;=K57.40^^88^875^44
 ;;^UTILITY(U,$J,358.3,16243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16243,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,16243,1,4,0)
 ;;=4^K57.40
 ;;^UTILITY(U,$J,358.3,16243,2)
 ;;=^5008727
 ;;^UTILITY(U,$J,358.3,16244,0)
 ;;=K57.32^^88^875^43
 ;;^UTILITY(U,$J,358.3,16244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16244,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,16244,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,16244,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,16245,0)
 ;;=K59.00^^88^875^22
 ;;^UTILITY(U,$J,358.3,16245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16245,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,16245,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,16245,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,16246,0)
 ;;=K58.9^^88^875^78
 ;;^UTILITY(U,$J,358.3,16246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16246,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/o Diarrhea
 ;;^UTILITY(U,$J,358.3,16246,1,4,0)
 ;;=4^K58.9
 ;;^UTILITY(U,$J,358.3,16246,2)
 ;;=^5008740
 ;;^UTILITY(U,$J,358.3,16247,0)
 ;;=K58.0^^88^875^77
 ;;^UTILITY(U,$J,358.3,16247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16247,1,3,0)
 ;;=3^Irritable Bowel Syndrome w/ Diarrhea
 ;;^UTILITY(U,$J,358.3,16247,1,4,0)
 ;;=4^K58.0
 ;;^UTILITY(U,$J,358.3,16247,2)
 ;;=^5008739
 ;;^UTILITY(U,$J,358.3,16248,0)
 ;;=K59.1^^88^875^37
 ;;^UTILITY(U,$J,358.3,16248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16248,1,3,0)
 ;;=3^Diarrhea,Functional
 ;;^UTILITY(U,$J,358.3,16248,1,4,0)
 ;;=4^K59.1
 ;;^UTILITY(U,$J,358.3,16248,2)
 ;;=^270281
 ;;^UTILITY(U,$J,358.3,16249,0)
 ;;=K61.4^^88^875^4
 ;;^UTILITY(U,$J,358.3,16249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16249,1,3,0)
 ;;=3^Abscess,Intrasphincteric
 ;;^UTILITY(U,$J,358.3,16249,1,4,0)
 ;;=4^K61.4
 ;;^UTILITY(U,$J,358.3,16249,2)
 ;;=^5008752
 ;;^UTILITY(U,$J,358.3,16250,0)
 ;;=K61.0^^88^875^2
 ;;^UTILITY(U,$J,358.3,16250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16250,1,3,0)
 ;;=3^Abscess,Anal
 ;;^UTILITY(U,$J,358.3,16250,1,4,0)
 ;;=4^K61.0
 ;;^UTILITY(U,$J,358.3,16250,2)
 ;;=^5008749
