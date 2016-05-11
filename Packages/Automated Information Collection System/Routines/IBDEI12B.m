IBDEI12B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18052,1,2,0)
 ;;=2^Angiography,Brachial,Retrograd,Rad S&I
 ;;^UTILITY(U,$J,358.3,18052,1,4,0)
 ;;=4^75658
 ;;^UTILITY(U,$J,358.3,18053,0)
 ;;=75705^^77^863^14^^^^1
 ;;^UTILITY(U,$J,358.3,18053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18053,1,2,0)
 ;;=2^Angiography,Spinal Seletive
 ;;^UTILITY(U,$J,358.3,18053,1,4,0)
 ;;=4^75705
 ;;^UTILITY(U,$J,358.3,18054,0)
 ;;=75710^^77^863^16^^^^1
 ;;^UTILITY(U,$J,358.3,18054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18054,1,2,0)
 ;;=2^Angiography,UE/LE Unilateral
 ;;^UTILITY(U,$J,358.3,18054,1,4,0)
 ;;=4^75710
 ;;^UTILITY(U,$J,358.3,18055,0)
 ;;=75716^^77^863^15^^^^1
 ;;^UTILITY(U,$J,358.3,18055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18055,1,2,0)
 ;;=2^Angiography,UE/LE Bilateral
 ;;^UTILITY(U,$J,358.3,18055,1,4,0)
 ;;=4^75716
 ;;^UTILITY(U,$J,358.3,18056,0)
 ;;=75726^^77^863^17^^^^1
 ;;^UTILITY(U,$J,358.3,18056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18056,1,2,0)
 ;;=2^Angiography,Visceral Selective
 ;;^UTILITY(U,$J,358.3,18056,1,4,0)
 ;;=4^75726
 ;;^UTILITY(U,$J,358.3,18057,0)
 ;;=75731^^77^863^5^^^^1
 ;;^UTILITY(U,$J,358.3,18057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18057,1,2,0)
 ;;=2^Angiography,Adrenal Unilat Selective
 ;;^UTILITY(U,$J,358.3,18057,1,4,0)
 ;;=4^75731
 ;;^UTILITY(U,$J,358.3,18058,0)
 ;;=75733^^77^863^4^^^^1
 ;;^UTILITY(U,$J,358.3,18058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18058,1,2,0)
 ;;=2^Angiography,Adrenal Bilat Selective
 ;;^UTILITY(U,$J,358.3,18058,1,4,0)
 ;;=4^75733
 ;;^UTILITY(U,$J,358.3,18059,0)
 ;;=75736^^77^863^9^^^^1
 ;;^UTILITY(U,$J,358.3,18059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18059,1,2,0)
 ;;=2^Angiography,Pelvic,Selective/Supraselective
 ;;^UTILITY(U,$J,358.3,18059,1,4,0)
 ;;=4^75736
 ;;^UTILITY(U,$J,358.3,18060,0)
 ;;=75741^^77^863^12^^^^1
 ;;^UTILITY(U,$J,358.3,18060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18060,1,2,0)
 ;;=2^Angiography,Pulmonary Unilat Selective
 ;;^UTILITY(U,$J,358.3,18060,1,4,0)
 ;;=4^75741
 ;;^UTILITY(U,$J,358.3,18061,0)
 ;;=75743^^77^863^10^^^^1
 ;;^UTILITY(U,$J,358.3,18061,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18061,1,2,0)
 ;;=2^Angiography,Pulmonary Bilat Selective
 ;;^UTILITY(U,$J,358.3,18061,1,4,0)
 ;;=4^75743
 ;;^UTILITY(U,$J,358.3,18062,0)
 ;;=75746^^77^863^11^^^^1
 ;;^UTILITY(U,$J,358.3,18062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18062,1,2,0)
 ;;=2^Angiography,Pulmonary By Nonselective
 ;;^UTILITY(U,$J,358.3,18062,1,4,0)
 ;;=4^75746
 ;;^UTILITY(U,$J,358.3,18063,0)
 ;;=75756^^77^863^8^^^^1
 ;;^UTILITY(U,$J,358.3,18063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18063,1,2,0)
 ;;=2^Angiography,Internal Mammary
 ;;^UTILITY(U,$J,358.3,18063,1,4,0)
 ;;=4^75756
 ;;^UTILITY(U,$J,358.3,18064,0)
 ;;=75774^^77^863^13^^^^1
 ;;^UTILITY(U,$J,358.3,18064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18064,1,2,0)
 ;;=2^Angiography,Selective,Ea Addl Vessel
 ;;^UTILITY(U,$J,358.3,18064,1,4,0)
 ;;=4^75774
 ;;^UTILITY(U,$J,358.3,18065,0)
 ;;=75791^^77^863^6^^^^1
 ;;^UTILITY(U,$J,358.3,18065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18065,1,2,0)
 ;;=2^Angiography,Arteriovenous Shunt
 ;;^UTILITY(U,$J,358.3,18065,1,4,0)
 ;;=4^75791
 ;;^UTILITY(U,$J,358.3,18066,0)
 ;;=75962^^77^863^18^^^^1
 ;;^UTILITY(U,$J,358.3,18066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18066,1,2,0)
 ;;=2^Angioplasty,Translum Ball Peripheral Artery
 ;;^UTILITY(U,$J,358.3,18066,1,4,0)
 ;;=4^75962
 ;;^UTILITY(U,$J,358.3,18067,0)
 ;;=75964^^77^863^19^^^^1
 ;;^UTILITY(U,$J,358.3,18067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,18067,1,2,0)
 ;;=2^Angioplasty,Translum Ball,Ea Addl Artery
