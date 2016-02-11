IBDEI0C6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5250,2)
 ;;=^5008697
 ;;^UTILITY(U,$J,358.3,5251,0)
 ;;=K51.914^^40^359^3
 ;;^UTILITY(U,$J,358.3,5251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5251,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,5251,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,5251,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,5252,0)
 ;;=K51.918^^40^359^6
 ;;^UTILITY(U,$J,358.3,5252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5252,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complications,Unspec
 ;;^UTILITY(U,$J,358.3,5252,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,5252,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,5253,0)
 ;;=K51.911^^40^359^7
 ;;^UTILITY(U,$J,358.3,5253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5253,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,5253,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,5253,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,5254,0)
 ;;=K50.00^^40^360^11
 ;;^UTILITY(U,$J,358.3,5254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5254,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,5254,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,5254,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,5255,0)
 ;;=K50.011^^40^360^9
 ;;^UTILITY(U,$J,358.3,5255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5255,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Rectal Bleeding
 ;;^UTILITY(U,$J,358.3,5255,1,4,0)
 ;;=4^K50.011
 ;;^UTILITY(U,$J,358.3,5255,2)
 ;;=^5008625
 ;;^UTILITY(U,$J,358.3,5256,0)
 ;;=K50.012^^40^360^7
 ;;^UTILITY(U,$J,358.3,5256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5256,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,5256,1,4,0)
 ;;=4^K50.012
 ;;^UTILITY(U,$J,358.3,5256,2)
 ;;=^5008626
 ;;^UTILITY(U,$J,358.3,5257,0)
 ;;=K50.013^^40^360^6
 ;;^UTILITY(U,$J,358.3,5257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5257,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Fistula
 ;;^UTILITY(U,$J,358.3,5257,1,4,0)
 ;;=4^K50.013
 ;;^UTILITY(U,$J,358.3,5257,2)
 ;;=^5008627
 ;;^UTILITY(U,$J,358.3,5258,0)
 ;;=K50.014^^40^360^5
 ;;^UTILITY(U,$J,358.3,5258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5258,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Abscess
 ;;^UTILITY(U,$J,358.3,5258,1,4,0)
 ;;=4^K50.014
 ;;^UTILITY(U,$J,358.3,5258,2)
 ;;=^5008628
 ;;^UTILITY(U,$J,358.3,5259,0)
 ;;=K50.018^^40^360^8
 ;;^UTILITY(U,$J,358.3,5259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5259,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Oth Complications
 ;;^UTILITY(U,$J,358.3,5259,1,4,0)
 ;;=4^K50.018
 ;;^UTILITY(U,$J,358.3,5259,2)
 ;;=^5008629
 ;;^UTILITY(U,$J,358.3,5260,0)
 ;;=K50.019^^40^360^10
 ;;^UTILITY(U,$J,358.3,5260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5260,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,5260,1,4,0)
 ;;=4^K50.019
 ;;^UTILITY(U,$J,358.3,5260,2)
 ;;=^5008630
 ;;^UTILITY(U,$J,358.3,5261,0)
 ;;=K50.10^^40^360^4
 ;;^UTILITY(U,$J,358.3,5261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5261,1,3,0)
 ;;=3^Crohn's Disease of Large Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,5261,1,4,0)
 ;;=4^K50.10
 ;;^UTILITY(U,$J,358.3,5261,2)
 ;;=^5008631
 ;;^UTILITY(U,$J,358.3,5262,0)
 ;;=K50.818^^40^360^12
 ;;^UTILITY(U,$J,358.3,5262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5262,1,3,0)
 ;;=3^Crohn's Disease of Small/Large Intestine w/ Oth Complication
 ;;^UTILITY(U,$J,358.3,5262,1,4,0)
 ;;=4^K50.818
 ;;^UTILITY(U,$J,358.3,5262,2)
 ;;=^5008643
 ;;^UTILITY(U,$J,358.3,5263,0)
 ;;=K50.819^^40^360^13
