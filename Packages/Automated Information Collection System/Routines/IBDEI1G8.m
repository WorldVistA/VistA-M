IBDEI1G8 ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23171,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,23171,1,4,0)
 ;;=4^K25.9
 ;;^UTILITY(U,$J,358.3,23171,2)
 ;;=^5008522
 ;;^UTILITY(U,$J,358.3,23172,0)
 ;;=K27.9^^105^1169^32
 ;;^UTILITY(U,$J,358.3,23172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23172,1,3,0)
 ;;=3^Peptic Ulcer w/o Hemorrhage/Perforation
 ;;^UTILITY(U,$J,358.3,23172,1,4,0)
 ;;=4^K27.9
 ;;^UTILITY(U,$J,358.3,23172,2)
 ;;=^5008536
 ;;^UTILITY(U,$J,358.3,23173,0)
 ;;=K29.70^^105^1169^16
 ;;^UTILITY(U,$J,358.3,23173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23173,1,3,0)
 ;;=3^Gastritis w/o Bleeding
 ;;^UTILITY(U,$J,358.3,23173,1,4,0)
 ;;=4^K29.70
 ;;^UTILITY(U,$J,358.3,23173,2)
 ;;=^5008552
 ;;^UTILITY(U,$J,358.3,23174,0)
 ;;=K50.90^^105^1169^5
 ;;^UTILITY(U,$J,358.3,23174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23174,1,3,0)
 ;;=3^Crohn's Disease w/o Complications
 ;;^UTILITY(U,$J,358.3,23174,1,4,0)
 ;;=4^K50.90
 ;;^UTILITY(U,$J,358.3,23174,2)
 ;;=^5008645
 ;;^UTILITY(U,$J,358.3,23175,0)
 ;;=K52.89^^105^1169^29
 ;;^UTILITY(U,$J,358.3,23175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23175,1,3,0)
 ;;=3^Noninfective Gastroenteritis NEC & Colitis
 ;;^UTILITY(U,$J,358.3,23175,1,4,0)
 ;;=4^K52.89
 ;;^UTILITY(U,$J,358.3,23175,2)
 ;;=^5008703
 ;;^UTILITY(U,$J,358.3,23176,0)
 ;;=K52.9^^105^1169^28
 ;;^UTILITY(U,$J,358.3,23176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23176,1,3,0)
 ;;=3^Noninfective Gastroenteritis & Colitis,Unspec
 ;;^UTILITY(U,$J,358.3,23176,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,23176,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,23177,0)
 ;;=K57.30^^105^1169^8
 ;;^UTILITY(U,$J,358.3,23177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23177,1,3,0)
 ;;=3^Diverticulosis Lg Intestine w/o Abscess or Bleeding
 ;;^UTILITY(U,$J,358.3,23177,1,4,0)
 ;;=4^K57.30
 ;;^UTILITY(U,$J,358.3,23177,2)
 ;;=^5008723
 ;;^UTILITY(U,$J,358.3,23178,0)
 ;;=K57.32^^105^1169^6
 ;;^UTILITY(U,$J,358.3,23178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23178,1,3,0)
 ;;=3^Diverticulitis Lg Intestine w/o Abscess or Bleeding
 ;;^UTILITY(U,$J,358.3,23178,1,4,0)
 ;;=4^K57.32
 ;;^UTILITY(U,$J,358.3,23178,2)
 ;;=^5008725
 ;;^UTILITY(U,$J,358.3,23179,0)
 ;;=K57.31^^105^1169^9
 ;;^UTILITY(U,$J,358.3,23179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23179,1,3,0)
 ;;=3^Diverticulosis Lg Intestine w/o Abscess w/ Bleeding
 ;;^UTILITY(U,$J,358.3,23179,1,4,0)
 ;;=4^K57.31
 ;;^UTILITY(U,$J,358.3,23179,2)
 ;;=^5008724
 ;;^UTILITY(U,$J,358.3,23180,0)
 ;;=K57.33^^105^1169^7
 ;;^UTILITY(U,$J,358.3,23180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23180,1,3,0)
 ;;=3^Diverticulitis Lg Intestine w/o Abscess w/ Bleeding
 ;;^UTILITY(U,$J,358.3,23180,1,4,0)
 ;;=4^K57.33
 ;;^UTILITY(U,$J,358.3,23180,2)
 ;;=^5008726
 ;;^UTILITY(U,$J,358.3,23181,0)
 ;;=K59.00^^105^1169^4
 ;;^UTILITY(U,$J,358.3,23181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23181,1,3,0)
 ;;=3^Constipation,Unspec
 ;;^UTILITY(U,$J,358.3,23181,1,4,0)
 ;;=4^K59.00
 ;;^UTILITY(U,$J,358.3,23181,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,23182,0)
 ;;=K74.60^^105^1169^3
 ;;^UTILITY(U,$J,358.3,23182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23182,1,3,0)
 ;;=3^Cirrhosis of Liver,Unspec
 ;;^UTILITY(U,$J,358.3,23182,1,4,0)
 ;;=4^K74.60
 ;;^UTILITY(U,$J,358.3,23182,2)
 ;;=^5008822
 ;;^UTILITY(U,$J,358.3,23183,0)
 ;;=K76.0^^105^1169^13
