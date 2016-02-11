IBDEI0WC ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14902,1,3,0)
 ;;=3^Ulcerative Colitis w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,14902,1,4,0)
 ;;=4^K51.914
 ;;^UTILITY(U,$J,358.3,14902,2)
 ;;=^5008698
 ;;^UTILITY(U,$J,358.3,14903,0)
 ;;=K51.918^^85^801^6
 ;;^UTILITY(U,$J,358.3,14903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14903,1,3,0)
 ;;=3^Ulcerative Colitis w/ Oth Complications,Unspec
 ;;^UTILITY(U,$J,358.3,14903,1,4,0)
 ;;=4^K51.918
 ;;^UTILITY(U,$J,358.3,14903,2)
 ;;=^5008699
 ;;^UTILITY(U,$J,358.3,14904,0)
 ;;=K51.911^^85^801^7
 ;;^UTILITY(U,$J,358.3,14904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14904,1,3,0)
 ;;=3^Ulcerative Colitis w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,14904,1,4,0)
 ;;=4^K51.911
 ;;^UTILITY(U,$J,358.3,14904,2)
 ;;=^5008695
 ;;^UTILITY(U,$J,358.3,14905,0)
 ;;=K50.00^^85^802^11
 ;;^UTILITY(U,$J,358.3,14905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14905,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,14905,1,4,0)
 ;;=4^K50.00
 ;;^UTILITY(U,$J,358.3,14905,2)
 ;;=^5008624
 ;;^UTILITY(U,$J,358.3,14906,0)
 ;;=K50.011^^85^802^9
 ;;^UTILITY(U,$J,358.3,14906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14906,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Rectal Bleeding
 ;;^UTILITY(U,$J,358.3,14906,1,4,0)
 ;;=4^K50.011
 ;;^UTILITY(U,$J,358.3,14906,2)
 ;;=^5008625
 ;;^UTILITY(U,$J,358.3,14907,0)
 ;;=K50.012^^85^802^7
 ;;^UTILITY(U,$J,358.3,14907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14907,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Intestinal Obstruction
 ;;^UTILITY(U,$J,358.3,14907,1,4,0)
 ;;=4^K50.012
 ;;^UTILITY(U,$J,358.3,14907,2)
 ;;=^5008626
 ;;^UTILITY(U,$J,358.3,14908,0)
 ;;=K50.013^^85^802^6
 ;;^UTILITY(U,$J,358.3,14908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14908,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Fistula
 ;;^UTILITY(U,$J,358.3,14908,1,4,0)
 ;;=4^K50.013
 ;;^UTILITY(U,$J,358.3,14908,2)
 ;;=^5008627
 ;;^UTILITY(U,$J,358.3,14909,0)
 ;;=K50.014^^85^802^5
 ;;^UTILITY(U,$J,358.3,14909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14909,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Abscess
 ;;^UTILITY(U,$J,358.3,14909,1,4,0)
 ;;=4^K50.014
 ;;^UTILITY(U,$J,358.3,14909,2)
 ;;=^5008628
 ;;^UTILITY(U,$J,358.3,14910,0)
 ;;=K50.018^^85^802^8
 ;;^UTILITY(U,$J,358.3,14910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14910,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Oth Complications
 ;;^UTILITY(U,$J,358.3,14910,1,4,0)
 ;;=4^K50.018
 ;;^UTILITY(U,$J,358.3,14910,2)
 ;;=^5008629
 ;;^UTILITY(U,$J,358.3,14911,0)
 ;;=K50.019^^85^802^10
 ;;^UTILITY(U,$J,358.3,14911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14911,1,3,0)
 ;;=3^Crohn's Disease of Small Intestine w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,14911,1,4,0)
 ;;=4^K50.019
 ;;^UTILITY(U,$J,358.3,14911,2)
 ;;=^5008630
 ;;^UTILITY(U,$J,358.3,14912,0)
 ;;=K50.10^^85^802^4
 ;;^UTILITY(U,$J,358.3,14912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14912,1,3,0)
 ;;=3^Crohn's Disease of Large Intestine w/o Complications
 ;;^UTILITY(U,$J,358.3,14912,1,4,0)
 ;;=4^K50.10
 ;;^UTILITY(U,$J,358.3,14912,2)
 ;;=^5008631
 ;;^UTILITY(U,$J,358.3,14913,0)
 ;;=K50.818^^85^802^12
 ;;^UTILITY(U,$J,358.3,14913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14913,1,3,0)
 ;;=3^Crohn's Disease of Small/Large Intestine w/ Oth Complication
 ;;^UTILITY(U,$J,358.3,14913,1,4,0)
 ;;=4^K50.818
 ;;^UTILITY(U,$J,358.3,14913,2)
 ;;=^5008643
 ;;^UTILITY(U,$J,358.3,14914,0)
 ;;=K50.819^^85^802^13
 ;;^UTILITY(U,$J,358.3,14914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14914,1,3,0)
 ;;=3^Crohn's Disease of Small/Large Intestine w/ Unspec Complications
