IBDEI0N0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10508,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,10508,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,10508,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,10509,0)
 ;;=K52.89^^68^670^54
 ;;^UTILITY(U,$J,358.3,10509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10509,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,10509,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,10509,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,10510,0)
 ;;=K52.9^^68^670^53
 ;;^UTILITY(U,$J,358.3,10510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10510,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,10510,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,10510,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,10511,0)
 ;;=K57.30^^68^670^42
 ;;^UTILITY(U,$J,358.3,10511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10511,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10511,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,10511,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,10512,0)
 ;;=K57.50^^68^670^43
 ;;^UTILITY(U,$J,358.3,10512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10512,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10512,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,10512,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,10513,0)
 ;;=K57.90^^68^670^41
 ;;^UTILITY(U,$J,358.3,10513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10513,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10513,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,10513,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,10514,0)
 ;;=K57.20^^68^670^37
 ;;^UTILITY(U,$J,358.3,10514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10514,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/ Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10514,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,10514,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,10515,0)
 ;;=K57.92^^68^670^36
 ;;^UTILITY(U,$J,358.3,10515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10515,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10515,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,10515,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,10516,0)
 ;;=K57.80^^68^670^35
 ;;^UTILITY(U,$J,358.3,10516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10516,1,3,0)
 ;;=3^Diverticulitis of Intestine,Unspec w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10516,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,10516,2)
 ;;=^5008733
 ;;^UTILITY(U,$J,358.3,10517,0)
 ;;=K57.52^^68^670^40
 ;;^UTILITY(U,$J,358.3,10517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10517,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10517,1,4,0)
 ;;=4^K57.52
 ;;^UTILITY(U,$J,358.3,10517,2)
 ;;=^5008731
 ;;^UTILITY(U,$J,358.3,10518,0)
 ;;=K57.40^^68^670^39
 ;;^UTILITY(U,$J,358.3,10518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10518,1,3,0)
 ;;=3^Diverticulitis of Sm & Lg Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10518,1,4,0)
 ;;=4^K57.40
 ;;^UTILITY(U,$J,358.3,10518,2)
 ;;=^5008727
 ;;^UTILITY(U,$J,358.3,10519,0)
 ;;=K57.32^^68^670^38
 ;;^UTILITY(U,$J,358.3,10519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10519,1,3,0)
 ;;=3^Diverticulitis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,10519,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,10519,2)
 ;;=^5008725
