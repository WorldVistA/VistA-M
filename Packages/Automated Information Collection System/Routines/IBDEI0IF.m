IBDEI0IF ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8290,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,8290,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,8290,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,8291,0)
 ;;=K50.913^^39^397^26
 ;;^UTILITY(U,$J,358.3,8291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8291,1,3,0)
 ;;=3^Crohn's Disease w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,8291,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,8291,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,8292,0)
 ;;=K50.918^^39^397^28
 ;;^UTILITY(U,$J,358.3,8292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8292,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,8292,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,8292,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,8293,0)
 ;;=K51.90^^39^397^91
 ;;^UTILITY(U,$J,358.3,8293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8293,1,3,0)
 ;;=3^Ulcerative Colitis w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,8293,1,4,0)
 ;;=4^K51.90
 ;;^UTILITY(U,$J,358.3,8293,2)
 ;;=^5008694
 ;;^UTILITY(U,$J,358.3,8294,0)
 ;;=K51.919^^39^397^90
 ;;^UTILITY(U,$J,358.3,8294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8294,1,3,0)
 ;;=3^Ulcerative Colitis w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,8294,1,4,0)
 ;;=4^K51.919
 ;;^UTILITY(U,$J,358.3,8294,2)
 ;;=^5008700
 ;;^UTILITY(U,$J,358.3,8295,0)
 ;;=K51.918^^39^397^88
 ;;^UTILITY(U,$J,358.3,8295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8295,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complication,Unspec
 ;;^UTILITY(U,$J,358.3,8295,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,8295,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,8296,0)
 ;;=K51.914^^39^397^85
 ;;^UTILITY(U,$J,358.3,8296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8296,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,8296,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,8296,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,8297,0)
 ;;=K51.913^^39^397^86
 ;;^UTILITY(U,$J,358.3,8297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8297,1,3,0)
 ;;=3^Ulcerative Colitis w/ Fistula,Unspec
 ;;^UTILITY(U,$J,358.3,8297,1,4,0)
 ;;=4^K51.913
 ;;^UTILITY(U,$J,358.3,8297,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,8298,0)
 ;;=K51.912^^39^397^87
 ;;^UTILITY(U,$J,358.3,8298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8298,1,3,0)
 ;;=3^Ulcerative Colitis w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,8298,1,4,0)
 ;;=4^K51.912
 ;;^UTILITY(U,$J,358.3,8298,2)
 ;;=^5008696
 ;;^UTILITY(U,$J,358.3,8299,0)
 ;;=K51.911^^39^397^89
 ;;^UTILITY(U,$J,358.3,8299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8299,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,8299,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,8299,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,8300,0)
 ;;=K52.89^^39^397^62
 ;;^UTILITY(U,$J,358.3,8300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8300,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Oth Spec Noninfective
 ;;^UTILITY(U,$J,358.3,8300,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,8300,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,8301,0)
 ;;=K52.9^^39^397^61
 ;;^UTILITY(U,$J,358.3,8301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8301,1,3,0)
 ;;=3^Gastroenteritis & Colitis,Noninfective Unspec
 ;;^UTILITY(U,$J,358.3,8301,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,8301,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,8302,0)
 ;;=K57.30^^39^397^47
 ;;^UTILITY(U,$J,358.3,8302,1,0)
 ;;=^358.31IA^4^2
