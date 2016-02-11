IBDEI0C7 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5263,1,3,0)
 ;;=3^Crohn's Disease of Small/Large Intestine w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,5263,1,4,0)
 ;;=4^K50.819
 ;;^UTILITY(U,$J,358.3,5263,2)
 ;;=^5008644
 ;;^UTILITY(U,$J,358.3,5264,0)
 ;;=K50.912^^40^360^17
 ;;^UTILITY(U,$J,358.3,5264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5264,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,5264,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,5264,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,5265,0)
 ;;=K50.918^^40^360^18
 ;;^UTILITY(U,$J,358.3,5265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5265,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complications,Unspec
 ;;^UTILITY(U,$J,358.3,5265,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,5265,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,5266,0)
 ;;=K50.919^^40^360^20
 ;;^UTILITY(U,$J,358.3,5266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5266,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,5266,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,5266,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,5267,0)
 ;;=K50.911^^40^360^19
 ;;^UTILITY(U,$J,358.3,5267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5267,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,5267,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,5267,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,5268,0)
 ;;=K50.90^^40^360^21
 ;;^UTILITY(U,$J,358.3,5268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5268,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,5268,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,5268,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,5269,0)
 ;;=K50.913^^40^360^16
 ;;^UTILITY(U,$J,358.3,5269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5269,1,3,0)
 ;;=3^Crohn's Disease w/ Fistual,Unspec
 ;;^UTILITY(U,$J,358.3,5269,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,5269,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,5270,0)
 ;;=K50.914^^40^360^15
 ;;^UTILITY(U,$J,358.3,5270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5270,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,5270,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,5270,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,5271,0)
 ;;=K50.114^^40^360^1
 ;;^UTILITY(U,$J,358.3,5271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5271,1,3,0)
 ;;=3^Crohn's Disease of Large Intestine w/ Abscess
 ;;^UTILITY(U,$J,358.3,5271,1,4,0)
 ;;=4^K50.114
 ;;^UTILITY(U,$J,358.3,5271,2)
 ;;=^5008635
 ;;^UTILITY(U,$J,358.3,5272,0)
 ;;=K50.814^^40^360^14
 ;;^UTILITY(U,$J,358.3,5272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5272,1,3,0)
 ;;=3^Crohn's Disease of Small/Large Intestine w/ Abscess
 ;;^UTILITY(U,$J,358.3,5272,1,4,0)
 ;;=4^K50.814
 ;;^UTILITY(U,$J,358.3,5272,2)
 ;;=^5008642
 ;;^UTILITY(U,$J,358.3,5273,0)
 ;;=K50.111^^40^360^2
 ;;^UTILITY(U,$J,358.3,5273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5273,1,3,0)
 ;;=3^Crohn's Disease of Large Intestine w/ Rectal Bleeding
 ;;^UTILITY(U,$J,358.3,5273,1,4,0)
 ;;=4^K50.111
 ;;^UTILITY(U,$J,358.3,5273,2)
 ;;=^5008632
 ;;^UTILITY(U,$J,358.3,5274,0)
 ;;=K50.119^^40^360^3
 ;;^UTILITY(U,$J,358.3,5274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5274,1,3,0)
 ;;=3^Crohn's Disease of Large Intestine w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,5274,1,4,0)
 ;;=4^K50.119
 ;;^UTILITY(U,$J,358.3,5274,2)
 ;;=^5008637
 ;;^UTILITY(U,$J,358.3,5275,0)
 ;;=K57.20^^40^361^3
 ;;^UTILITY(U,$J,358.3,5275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5275,1,3,0)
 ;;=3^Diverticulitis of Large Intestine w/ Perforation/Abscess w/o Bleeding
