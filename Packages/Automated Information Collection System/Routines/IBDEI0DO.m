IBDEI0DO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6279,0)
 ;;=K51.90^^30^391^83
 ;;^UTILITY(U,$J,358.3,6279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6279,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,6279,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,6279,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,6280,0)
 ;;=K51.919^^30^391^82
 ;;^UTILITY(U,$J,358.3,6280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6280,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,6280,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,6280,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,6281,0)
 ;;=K51.918^^30^391^80
 ;;^UTILITY(U,$J,358.3,6281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6281,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,6281,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,6281,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,6282,0)
 ;;=K51.914^^30^391^77
 ;;^UTILITY(U,$J,358.3,6282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6282,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,6282,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,6282,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,6283,0)
 ;;=K51.913^^30^391^78
 ;;^UTILITY(U,$J,358.3,6283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6283,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,6283,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,6283,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,6284,0)
 ;;=K51.912^^30^391^79
 ;;^UTILITY(U,$J,358.3,6284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6284,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,6284,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,6284,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,6285,0)
 ;;=K51.911^^30^391^81
 ;;^UTILITY(U,$J,358.3,6285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6285,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,6285,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,6285,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,6286,0)
 ;;=K52.89^^30^391^55
 ;;^UTILITY(U,$J,358.3,6286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6286,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,6286,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,6286,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,6287,0)
 ;;=K52.9^^30^391^54
 ;;^UTILITY(U,$J,358.3,6287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6287,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,6287,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,6287,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,6288,0)
 ;;=K57.30^^30^391^42
 ;;^UTILITY(U,$J,358.3,6288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6288,1,3,0)
 ;;=3^Diverticulosis of Lg Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6288,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,6288,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,6289,0)
 ;;=K57.50^^30^391^43
 ;;^UTILITY(U,$J,358.3,6289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6289,1,3,0)
 ;;=3^Diverticulosis of Sm & Lg Intestine w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6289,1,4,0)
 ;;=4^K57.50
 ;;^UTILITY(U,$J,358.3,6289,2)
 ;;=^5008729
 ;;^UTILITY(U,$J,358.3,6290,0)
 ;;=K57.90^^30^391^41
 ;;^UTILITY(U,$J,358.3,6290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6290,1,3,0)
 ;;=3^Diverticulosis of Intestine,Unspec w/o Performation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,6290,1,4,0)
 ;;=4^K57.90
 ;;^UTILITY(U,$J,358.3,6290,2)
 ;;=^5008735
 ;;^UTILITY(U,$J,358.3,6291,0)
 ;;=K57.20^^30^391^37
 ;;^UTILITY(U,$J,358.3,6291,1,0)
 ;;=^358.31IA^4^2
