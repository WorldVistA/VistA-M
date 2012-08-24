IBDEI011 ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,930,1,3,0)
 ;;=3^Carotid, Cerebral, Unilat
 ;;^UTILITY(U,$J,358.3,931,0)
 ;;=75671^^11^71^35^^^^1
 ;;^UTILITY(U,$J,358.3,931,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,931,1,2,0)
 ;;=2^75671
 ;;^UTILITY(U,$J,358.3,931,1,3,0)
 ;;=3^Carotid, Cerebral, Bilat
 ;;^UTILITY(U,$J,358.3,932,0)
 ;;=75676^^11^71^36^^^^1
 ;;^UTILITY(U,$J,358.3,932,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,932,1,2,0)
 ;;=2^75676
 ;;^UTILITY(U,$J,358.3,932,1,3,0)
 ;;=3^Carotid, Cervical, Unilat
 ;;^UTILITY(U,$J,358.3,933,0)
 ;;=75680^^11^71^37^^^^1
 ;;^UTILITY(U,$J,358.3,933,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,933,1,2,0)
 ;;=2^75680
 ;;^UTILITY(U,$J,358.3,933,1,3,0)
 ;;=3^Carotid, Cervical, Bilat
 ;;^UTILITY(U,$J,358.3,934,0)
 ;;=75685^^11^71^38^^^^1
 ;;^UTILITY(U,$J,358.3,934,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,934,1,2,0)
 ;;=2^75685
 ;;^UTILITY(U,$J,358.3,934,1,3,0)
 ;;=3^Vertral Cervical
 ;;^UTILITY(U,$J,358.3,935,0)
 ;;=75705^^11^71^39^^^^1
 ;;^UTILITY(U,$J,358.3,935,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,935,1,2,0)
 ;;=2^75705
 ;;^UTILITY(U,$J,358.3,935,1,3,0)
 ;;=3^Spinal Selective
 ;;^UTILITY(U,$J,358.3,936,0)
 ;;=75710^^11^71^40^^^^1
 ;;^UTILITY(U,$J,358.3,936,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,936,1,2,0)
 ;;=2^75710
 ;;^UTILITY(U,$J,358.3,936,1,3,0)
 ;;=3^Ue/Le Unilat
 ;;^UTILITY(U,$J,358.3,937,0)
 ;;=75716^^11^71^41^^^^1
 ;;^UTILITY(U,$J,358.3,937,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,937,1,2,0)
 ;;=2^75716
 ;;^UTILITY(U,$J,358.3,937,1,3,0)
 ;;=3^Ue/Le Bilat
 ;;^UTILITY(U,$J,358.3,938,0)
 ;;=75722^^11^71^42^^^^1
 ;;^UTILITY(U,$J,358.3,938,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,938,1,2,0)
 ;;=2^75722
 ;;^UTILITY(U,$J,358.3,938,1,3,0)
 ;;=3^Renal Unilat Selective
 ;;^UTILITY(U,$J,358.3,939,0)
 ;;=75724^^11^71^43^^^^1
 ;;^UTILITY(U,$J,358.3,939,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,939,1,2,0)
 ;;=2^75724
 ;;^UTILITY(U,$J,358.3,939,1,3,0)
 ;;=3^Renal, Bilat Selective
 ;;^UTILITY(U,$J,358.3,940,0)
 ;;=75726^^11^71^44^^^^1
 ;;^UTILITY(U,$J,358.3,940,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,940,1,2,0)
 ;;=2^75726
 ;;^UTILITY(U,$J,358.3,940,1,3,0)
 ;;=3^Visceral Selective
 ;;^UTILITY(U,$J,358.3,941,0)
 ;;=75731^^11^71^45^^^^1
 ;;^UTILITY(U,$J,358.3,941,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,941,1,2,0)
 ;;=2^75731
 ;;^UTILITY(U,$J,358.3,941,1,3,0)
 ;;=3^Adrenal Unilat Selective
 ;;^UTILITY(U,$J,358.3,942,0)
 ;;=75733^^11^71^46^^^^1
 ;;^UTILITY(U,$J,358.3,942,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,942,1,2,0)
 ;;=2^75733
 ;;^UTILITY(U,$J,358.3,942,1,3,0)
 ;;=3^Adrenal Bilat Selective
 ;;^UTILITY(U,$J,358.3,943,0)
 ;;=75736^^11^71^47^^^^1
 ;;^UTILITY(U,$J,358.3,943,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,943,1,2,0)
 ;;=2^75736
 ;;^UTILITY(U,$J,358.3,943,1,3,0)
 ;;=3^Pelvic Selective
 ;;^UTILITY(U,$J,358.3,944,0)
 ;;=75741^^11^71^48^^^^1
 ;;^UTILITY(U,$J,358.3,944,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,944,1,2,0)
 ;;=2^75741
 ;;^UTILITY(U,$J,358.3,944,1,3,0)
 ;;=3^Pulmonary Unilat Selective
 ;;^UTILITY(U,$J,358.3,945,0)
 ;;=75743^^11^71^49^^^^1
 ;;^UTILITY(U,$J,358.3,945,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,945,1,2,0)
 ;;=2^75743
 ;;^UTILITY(U,$J,358.3,945,1,3,0)
 ;;=3^Pulmonary Bilat Selective
 ;;^UTILITY(U,$J,358.3,946,0)
 ;;=75746^^11^71^50^^^^1
 ;;^UTILITY(U,$J,358.3,946,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,946,1,2,0)
 ;;=2^75746
 ;;^UTILITY(U,$J,358.3,946,1,3,0)
 ;;=3^Pulmonary By Nonselective
 ;;^UTILITY(U,$J,358.3,947,0)
 ;;=75756^^11^71^51^^^^1
 ;;^UTILITY(U,$J,358.3,947,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,947,1,2,0)
 ;;=2^75756
 ;;^UTILITY(U,$J,358.3,947,1,3,0)
 ;;=3^Internal Mammary
 ;;^UTILITY(U,$J,358.3,948,0)
 ;;=75774^^11^71^52^^^^1
 ;;^UTILITY(U,$J,358.3,948,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,948,1,2,0)
 ;;=2^75774
 ;;^UTILITY(U,$J,358.3,948,1,3,0)
 ;;=3^Selective Ea Addl Vessel W/Above
 ;;^UTILITY(U,$J,358.3,949,0)
 ;;=75940^^11^71^54^^^^1
 ;;^UTILITY(U,$J,358.3,949,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,949,1,2,0)
 ;;=2^75940
 ;;^UTILITY(U,$J,358.3,949,1,3,0)
 ;;=3^Greenfield Filter (W/37620)
 ;;^UTILITY(U,$J,358.3,950,0)
 ;;=92980^^11^71^58^^^^1
 ;;^UTILITY(U,$J,358.3,950,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,950,1,2,0)
 ;;=2^92980
 ;;^UTILITY(U,$J,358.3,950,1,3,0)
 ;;=3^Stent Placemnt Intrcoronary
 ;;^UTILITY(U,$J,358.3,951,0)
 ;;=92981^^11^71^59^^^^1
 ;;^UTILITY(U,$J,358.3,951,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,951,1,2,0)
 ;;=2^92981
 ;;^UTILITY(U,$J,358.3,951,1,3,0)
 ;;=3^   Each Add Vessel (W/92980)
 ;;^UTILITY(U,$J,358.3,952,0)
 ;;=37250^^11^71^26^^^^1
 ;;^UTILITY(U,$J,358.3,952,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,952,1,2,0)
 ;;=2^37250
 ;;^UTILITY(U,$J,358.3,952,1,3,0)
 ;;=3^Intravas Us,Non/Cor,Diag/Thera Interv, Each Ves
 ;;^UTILITY(U,$J,358.3,953,0)
 ;;=35475^^11^71^2^^^^1
 ;;^UTILITY(U,$J,358.3,953,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,953,1,2,0)
 ;;=2^35475
 ;;^UTILITY(U,$J,358.3,953,1,3,0)
 ;;=3^Perc Angioplasty, Brachioceph Trunk/Branch, Each
 ;;^UTILITY(U,$J,358.3,954,0)
 ;;=35471^^11^71^1^^^^1
 ;;^UTILITY(U,$J,358.3,954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,954,1,2,0)
 ;;=2^35471
 ;;^UTILITY(U,$J,358.3,954,1,3,0)
 ;;=3^Perc Angioplasty, Renal/Visc
 ;;^UTILITY(U,$J,358.3,955,0)
 ;;=36215^^11^71^4^^^^1
 ;;^UTILITY(U,$J,358.3,955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,955,1,2,0)
 ;;=2^36215
 ;;^UTILITY(U,$J,358.3,955,1,3,0)
 ;;=3^Select Cath Arterial 1St Order Thor/Brachiocephalic
 ;;^UTILITY(U,$J,358.3,956,0)
 ;;=36011^^11^71^3^^^^1
 ;;^UTILITY(U,$J,358.3,956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,956,1,2,0)
 ;;=2^36011
 ;;^UTILITY(U,$J,358.3,956,1,3,0)
 ;;=3^Select Cath Venous 1St Order (Renal Jugular)
 ;;^UTILITY(U,$J,358.3,957,0)
 ;;=36245^^11^71^5^^^^1
 ;;^UTILITY(U,$J,358.3,957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,957,1,2,0)
 ;;=2^36245
 ;;^UTILITY(U,$J,358.3,957,1,3,0)
 ;;=3^Select Cath 1St Order Abd/Pelv/Le Artery
 ;;^UTILITY(U,$J,358.3,958,0)
 ;;=36246^^11^71^6^^^^1
 ;;^UTILITY(U,$J,358.3,958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,958,1,2,0)
 ;;=2^36246
 ;;^UTILITY(U,$J,358.3,958,1,3,0)
 ;;=3^Select Cath 2Nd Order Abd/Pelv/Le Artery
 ;;^UTILITY(U,$J,358.3,959,0)
 ;;=36247^^11^71^7^^^^1
 ;;^UTILITY(U,$J,358.3,959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,959,1,2,0)
 ;;=2^36247
 ;;^UTILITY(U,$J,358.3,959,1,3,0)
 ;;=3^Select Cath 3Rd Order Abd/Pelv/Le Artery
 ;;^UTILITY(U,$J,358.3,960,0)
 ;;=37205^^11^71^8^^^^1
 ;;^UTILITY(U,$J,358.3,960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,960,1,2,0)
 ;;=2^37205
 ;;^UTILITY(U,$J,358.3,960,1,3,0)
 ;;=3^Stent Place, Non/Coronary,Percutaneous,Each Vess
 ;;^UTILITY(U,$J,358.3,961,0)
 ;;=37206^^11^71^9^^^^1
 ;;^UTILITY(U,$J,358.3,961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,961,1,2,0)
 ;;=2^37206
 ;;^UTILITY(U,$J,358.3,961,1,3,0)
 ;;=3^     Each Add Artery (W/37205)
 ;;^UTILITY(U,$J,358.3,962,0)
 ;;=75960^^11^71^55^^^^1
 ;;^UTILITY(U,$J,358.3,962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,962,1,2,0)
 ;;=2^75960
 ;;^UTILITY(U,$J,358.3,962,1,3,0)
 ;;=3^Transcath Intro/Stens(S) Rad S&I Each Vessel
 ;;^UTILITY(U,$J,358.3,963,0)
 ;;=75962^^11^71^56^^^^1
 ;;^UTILITY(U,$J,358.3,963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,963,1,2,0)
 ;;=2^75962
 ;;^UTILITY(U,$J,358.3,963,1,3,0)
 ;;=3^Translum Ball Angioplasty,Peripheral Artery, Rad S&I
 ;;^UTILITY(U,$J,358.3,964,0)
 ;;=75964^^11^71^57^^^^1
 ;;^UTILITY(U,$J,358.3,964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,964,1,2,0)
 ;;=2^75964
 ;;^UTILITY(U,$J,358.3,964,1,3,0)
 ;;=3^     Each Add Artery (W/75962)
 ;;^UTILITY(U,$J,358.3,965,0)
 ;;=75791^^11^71^53^^^^1
 ;;^UTILITY(U,$J,358.3,965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,965,1,2,0)
 ;;=2^75791
 ;;^UTILITY(U,$J,358.3,965,1,3,0)
 ;;=3^Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,966,0)
 ;;=37220^^11^71^10^^^^1
 ;;^UTILITY(U,$J,358.3,966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,966,1,2,0)
 ;;=2^37220
 ;;^UTILITY(U,$J,358.3,966,1,3,0)
 ;;=3^Iliac Revasc,Unilat,1st Vessel
 ;;^UTILITY(U,$J,358.3,967,0)
 ;;=37221^^11^71^11^^^^1
 ;;^UTILITY(U,$J,358.3,967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,967,1,2,0)
 ;;=2^37221
 ;;^UTILITY(U,$J,358.3,967,1,3,0)
 ;;=3^Iliac Revasc w/Stent
 ;;^UTILITY(U,$J,358.3,968,0)
 ;;=37222^^11^71^12^^^^1
 ;;^UTILITY(U,$J,358.3,968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,968,1,2,0)
 ;;=2^37222
 ;;^UTILITY(U,$J,358.3,968,1,3,0)
 ;;=3^Iliac Revasc,ea add Vessel
 ;;^UTILITY(U,$J,358.3,969,0)
 ;;=37223^^11^71^13^^^^1
 ;;^UTILITY(U,$J,358.3,969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,969,1,2,0)
 ;;=2^37223
 ;;^UTILITY(U,$J,358.3,969,1,3,0)
 ;;=3^Iliac Revasc w/Stent,Add-on
 ;;^UTILITY(U,$J,358.3,970,0)
 ;;=37224^^11^71^14^^^^1
 ;;^UTILITY(U,$J,358.3,970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,970,1,2,0)
 ;;=2^37224
 ;;^UTILITY(U,$J,358.3,970,1,3,0)
 ;;=3^Fem/Popl Revas w/TLA 1st Vessel
 ;;^UTILITY(U,$J,358.3,971,0)
 ;;=37225^^11^71^15^^^^1
 ;;^UTILITY(U,$J,358.3,971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,971,1,2,0)
 ;;=2^37225
 ;;^UTILITY(U,$J,358.3,971,1,3,0)
 ;;=3^Fem/Popl Revas w/Ather
 ;;^UTILITY(U,$J,358.3,972,0)
 ;;=37226^^11^71^16^^^^1
 ;;^UTILITY(U,$J,358.3,972,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,972,1,2,0)
 ;;=2^37226
 ;;^UTILITY(U,$J,358.3,972,1,3,0)
 ;;=3^Fem/Popl Revasc w/Stent
 ;;^UTILITY(U,$J,358.3,973,0)
 ;;=37227^^11^71^17^^^^1
 ;;^UTILITY(U,$J,358.3,973,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,973,1,2,0)
 ;;=2^37227
 ;;^UTILITY(U,$J,358.3,973,1,3,0)
 ;;=3^Fem/Popl Revasc w/Stent & Ather
 ;;^UTILITY(U,$J,358.3,974,0)
 ;;=37228^^11^71^18^^^^1
 ;;^UTILITY(U,$J,358.3,974,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,974,1,2,0)
 ;;=2^37228
 ;;^UTILITY(U,$J,358.3,974,1,3,0)
 ;;=3^TIB/Per Revasc w/TLA,1st Vessel
 ;;^UTILITY(U,$J,358.3,975,0)
 ;;=37229^^11^71^19^^^^1
