IBDEI1NT ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,29831,1,3,0)
 ;;=3^Crohn's Disease w/ Intestinal Obstruction,Unspec
 ;;^UTILITY(U,$J,358.3,29831,1,4,0)
 ;;=4^K50.912
 ;;^UTILITY(U,$J,358.3,29831,2)
 ;;=^5008647
 ;;^UTILITY(U,$J,358.3,29832,0)
 ;;=K50.918^^189^1898^16
 ;;^UTILITY(U,$J,358.3,29832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29832,1,3,0)
 ;;=3^Crohn's Disease w/ Oth Complications,Unspec
 ;;^UTILITY(U,$J,358.3,29832,1,4,0)
 ;;=4^K50.918
 ;;^UTILITY(U,$J,358.3,29832,2)
 ;;=^5008650
 ;;^UTILITY(U,$J,358.3,29833,0)
 ;;=K50.919^^189^1898^18
 ;;^UTILITY(U,$J,358.3,29833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29833,1,3,0)
 ;;=3^Crohn's Disease w/ Unspec Complications,Unspec
 ;;^UTILITY(U,$J,358.3,29833,1,4,0)
 ;;=4^K50.919
 ;;^UTILITY(U,$J,358.3,29833,2)
 ;;=^5008651
 ;;^UTILITY(U,$J,358.3,29834,0)
 ;;=K50.911^^189^1898^17
 ;;^UTILITY(U,$J,358.3,29834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29834,1,3,0)
 ;;=3^Crohn's Disease w/ Rectal Bleeding,Unspec
 ;;^UTILITY(U,$J,358.3,29834,1,4,0)
 ;;=4^K50.911
 ;;^UTILITY(U,$J,358.3,29834,2)
 ;;=^5008646
 ;;^UTILITY(U,$J,358.3,29835,0)
 ;;=K50.90^^189^1898^19
 ;;^UTILITY(U,$J,358.3,29835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29835,1,3,0)
 ;;=3^Crohn's Disease w/o Complications,Unspec
 ;;^UTILITY(U,$J,358.3,29835,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,29835,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,29836,0)
 ;;=K50.913^^189^1898^14
 ;;^UTILITY(U,$J,358.3,29836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29836,1,3,0)
 ;;=3^Crohn's Disease w/ Fistual,Unspec
 ;;^UTILITY(U,$J,358.3,29836,1,4,0)
 ;;=4^K50.913
 ;;^UTILITY(U,$J,358.3,29836,2)
 ;;=^5008648
 ;;^UTILITY(U,$J,358.3,29837,0)
 ;;=K50.914^^189^1898^13
 ;;^UTILITY(U,$J,358.3,29837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29837,1,3,0)
 ;;=3^Crohn's Disease w/ Abscess,Unspec
 ;;^UTILITY(U,$J,358.3,29837,1,4,0)
 ;;=4^K50.914
 ;;^UTILITY(U,$J,358.3,29837,2)
 ;;=^5008649
 ;;^UTILITY(U,$J,358.3,29838,0)
 ;;=K50.114^^189^1898^1
 ;;^UTILITY(U,$J,358.3,29838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29838,1,3,0)
 ;;=3^Crohn's Disease of Large Intestine w/ Abscess
 ;;^UTILITY(U,$J,358.3,29838,1,4,0)
 ;;=4^K50.114
 ;;^UTILITY(U,$J,358.3,29838,2)
 ;;=^5008635
 ;;^UTILITY(U,$J,358.3,29839,0)
 ;;=K50.814^^189^1898^12
 ;;^UTILITY(U,$J,358.3,29839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29839,1,3,0)
 ;;=3^Crohn's Disease of Small/Large Intestine w/ Abscess
 ;;^UTILITY(U,$J,358.3,29839,1,4,0)
 ;;=4^K50.814
 ;;^UTILITY(U,$J,358.3,29839,2)
 ;;=^5008642
 ;;^UTILITY(U,$J,358.3,29840,0)
 ;;=K57.20^^189^1899^3
 ;;^UTILITY(U,$J,358.3,29840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29840,1,3,0)
 ;;=3^Diverticulitis of Large Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,29840,1,4,0)
 ;;=4^K57.20
 ;;^UTILITY(U,$J,358.3,29840,2)
 ;;=^5008721
 ;;^UTILITY(U,$J,358.3,29841,0)
 ;;=K57.92^^189^1899^2
 ;;^UTILITY(U,$J,358.3,29841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29841,1,3,0)
 ;;=3^Diverticulitis of Intestine w/o Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,29841,1,4,0)
 ;;=4^K57.92
 ;;^UTILITY(U,$J,358.3,29841,2)
 ;;=^5008737
 ;;^UTILITY(U,$J,358.3,29842,0)
 ;;=K57.80^^189^1899^1
 ;;^UTILITY(U,$J,358.3,29842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29842,1,3,0)
 ;;=3^Diverticulitis of Intestine w/ Perforation/Abscess w/o Bleeding
 ;;^UTILITY(U,$J,358.3,29842,1,4,0)
 ;;=4^K57.80
 ;;^UTILITY(U,$J,358.3,29842,2)
 ;;=^5008733
 ;;^UTILITY(U,$J,358.3,29843,0)
 ;;=K57.52^^189^1899^5
 ;;^UTILITY(U,$J,358.3,29843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,29843,1,3,0)
 ;;=3^Diverticulitis of Small/Large Intestine w/o Perforation/Abscess w/o Bleeding
