IBDEI035 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1059,1,3,0)
 ;;=3^Carotid, Cervical, Unilat
 ;;^UTILITY(U,$J,358.3,1060,0)
 ;;=75705^^10^106^6^^^^1
 ;;^UTILITY(U,$J,358.3,1060,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1060,1,2,0)
 ;;=2^75705
 ;;^UTILITY(U,$J,358.3,1060,1,3,0)
 ;;=3^Angiography,Spinal Selective,S&I
 ;;^UTILITY(U,$J,358.3,1061,0)
 ;;=75710^^10^106^5^^^^1
 ;;^UTILITY(U,$J,358.3,1061,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1061,1,2,0)
 ;;=2^75710
 ;;^UTILITY(U,$J,358.3,1061,1,3,0)
 ;;=3^Angiography,Extremity,Unilateral,S&I
 ;;^UTILITY(U,$J,358.3,1062,0)
 ;;=75716^^10^106^62^^^^1
 ;;^UTILITY(U,$J,358.3,1062,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1062,1,2,0)
 ;;=2^75716
 ;;^UTILITY(U,$J,358.3,1062,1,3,0)
 ;;=3^Ue/Le Bilat
 ;;^UTILITY(U,$J,358.3,1063,0)
 ;;=75726^^10^106^66^^^^1
 ;;^UTILITY(U,$J,358.3,1063,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1063,1,2,0)
 ;;=2^75726
 ;;^UTILITY(U,$J,358.3,1063,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,1064,0)
 ;;=75731^^10^106^3^^^^1
 ;;^UTILITY(U,$J,358.3,1064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1064,1,2,0)
 ;;=2^75731
 ;;^UTILITY(U,$J,358.3,1064,1,3,0)
 ;;=3^Adrenal Unilat Selective
 ;;^UTILITY(U,$J,358.3,1065,0)
 ;;=75733^^10^106^2^^^^1
 ;;^UTILITY(U,$J,358.3,1065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1065,1,2,0)
 ;;=2^75733
 ;;^UTILITY(U,$J,358.3,1065,1,3,0)
 ;;=3^Adrenal Bilat Selective
 ;;^UTILITY(U,$J,358.3,1066,0)
 ;;=75736^^10^106^28^^^^1
 ;;^UTILITY(U,$J,358.3,1066,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1066,1,2,0)
 ;;=2^75736
 ;;^UTILITY(U,$J,358.3,1066,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,1067,0)
 ;;=75741^^10^106^35^^^^1
 ;;^UTILITY(U,$J,358.3,1067,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1067,1,2,0)
 ;;=2^75741
 ;;^UTILITY(U,$J,358.3,1067,1,3,0)
 ;;=3^Pulmonary Unilat Selective
 ;;^UTILITY(U,$J,358.3,1068,0)
 ;;=75743^^10^106^33^^^^1
 ;;^UTILITY(U,$J,358.3,1068,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1068,1,2,0)
 ;;=2^75743
 ;;^UTILITY(U,$J,358.3,1068,1,3,0)
 ;;=3^Pulmonary Bilat Selective
 ;;^UTILITY(U,$J,358.3,1069,0)
 ;;=75746^^10^106^34^^^^1
 ;;^UTILITY(U,$J,358.3,1069,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1069,1,2,0)
 ;;=2^75746
 ;;^UTILITY(U,$J,358.3,1069,1,3,0)
 ;;=3^Pulmonary By Nonselective
 ;;^UTILITY(U,$J,358.3,1070,0)
 ;;=75756^^10^106^25^^^^1
 ;;^UTILITY(U,$J,358.3,1070,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1070,1,2,0)
 ;;=2^75756
 ;;^UTILITY(U,$J,358.3,1070,1,3,0)
 ;;=3^Internal Mammary
 ;;^UTILITY(U,$J,358.3,1071,0)
 ;;=37250^^10^106^26^^^^1
 ;;^UTILITY(U,$J,358.3,1071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1071,1,2,0)
 ;;=2^37250
 ;;^UTILITY(U,$J,358.3,1071,1,3,0)
 ;;=3^Intravas Us,Non/Cor,Diag/Thera Interv, Each Ves
 ;;^UTILITY(U,$J,358.3,1072,0)
 ;;=35475^^10^106^29^^^^1
 ;;^UTILITY(U,$J,358.3,1072,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1072,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,1072,1,3,0)
 ;;=3^Perc Angioplasty, Brachioceph Trunk/Branch, Each
 ;;^UTILITY(U,$J,358.3,1073,0)
 ;;=35471^^10^106^30^^^^1
 ;;^UTILITY(U,$J,358.3,1073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1073,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,1073,1,3,0)
 ;;=3^Perc Angioplasty, Renal/Visc
 ;;^UTILITY(U,$J,358.3,1074,0)
 ;;=36215^^10^106^42^^^^1
 ;;^UTILITY(U,$J,358.3,1074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1074,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,1074,1,3,0)
 ;;=3^Select Cath Arterial 1st Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,1075,0)
 ;;=36011^^10^106^43^^^^1
 ;;^UTILITY(U,$J,358.3,1075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1075,1,2,0)
 ;;=2^36011
