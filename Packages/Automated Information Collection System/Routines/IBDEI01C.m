IBDEI01C ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,70,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,70,1,3,0)
 ;;=3^Atrophic nonflaccid tympanic membrane, bilateral
 ;;^UTILITY(U,$J,358.3,70,1,4,0)
 ;;=4^H73.823
 ;;^UTILITY(U,$J,358.3,70,2)
 ;;=^5006786
 ;;^UTILITY(U,$J,358.3,71,0)
 ;;=H73.822^^1^5^5
 ;;^UTILITY(U,$J,358.3,71,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,71,1,3,0)
 ;;=3^Atrophic nonflaccid tympanic membrane, left ear
 ;;^UTILITY(U,$J,358.3,71,1,4,0)
 ;;=4^H73.822
 ;;^UTILITY(U,$J,358.3,71,2)
 ;;=^5006785
 ;;^UTILITY(U,$J,358.3,72,0)
 ;;=H73.821^^1^5^6
 ;;^UTILITY(U,$J,358.3,72,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,72,1,3,0)
 ;;=3^Atrophic nonflaccid tympanic membrane, right ear
 ;;^UTILITY(U,$J,358.3,72,1,4,0)
 ;;=4^H73.821
 ;;^UTILITY(U,$J,358.3,72,2)
 ;;=^5006784
 ;;^UTILITY(U,$J,358.3,73,0)
 ;;=H72.13^^1^5^7
 ;;^UTILITY(U,$J,358.3,73,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,73,1,3,0)
 ;;=3^Attic perforation of tympanic membrane, bilateral
 ;;^UTILITY(U,$J,358.3,73,1,4,0)
 ;;=4^H72.13
 ;;^UTILITY(U,$J,358.3,73,2)
 ;;=^5006749
 ;;^UTILITY(U,$J,358.3,74,0)
 ;;=H72.12^^1^5^8
 ;;^UTILITY(U,$J,358.3,74,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,74,1,3,0)
 ;;=3^Attic perforation of tympanic membrane, left ear
 ;;^UTILITY(U,$J,358.3,74,1,4,0)
 ;;=4^H72.12
 ;;^UTILITY(U,$J,358.3,74,2)
 ;;=^5006748
 ;;^UTILITY(U,$J,358.3,75,0)
 ;;=H72.11^^1^5^9
 ;;^UTILITY(U,$J,358.3,75,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,75,1,3,0)
 ;;=3^Attic perforation of tympanic membrane, right ear
 ;;^UTILITY(U,$J,358.3,75,1,4,0)
 ;;=4^H72.11
 ;;^UTILITY(U,$J,358.3,75,2)
 ;;=^5006747
 ;;^UTILITY(U,$J,358.3,76,0)
 ;;=H51.0^^1^5^10
 ;;^UTILITY(U,$J,358.3,76,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,76,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,76,1,4,0)
 ;;=4^H51.0
 ;;^UTILITY(U,$J,358.3,76,2)
 ;;=^5006250
 ;;^UTILITY(U,$J,358.3,77,0)
 ;;=H72.03^^1^5^11
 ;;^UTILITY(U,$J,358.3,77,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,77,1,3,0)
 ;;=3^Central perforation of tympanic membrane, bilateral
 ;;^UTILITY(U,$J,358.3,77,1,4,0)
 ;;=4^H72.03
 ;;^UTILITY(U,$J,358.3,77,2)
 ;;=^5006745
 ;;^UTILITY(U,$J,358.3,78,0)
 ;;=H72.02^^1^5^12
 ;;^UTILITY(U,$J,358.3,78,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,78,1,3,0)
 ;;=3^Central perforation of tympanic membrane, left ear
 ;;^UTILITY(U,$J,358.3,78,1,4,0)
 ;;=4^H72.02
 ;;^UTILITY(U,$J,358.3,78,2)
 ;;=^5006744
 ;;^UTILITY(U,$J,358.3,79,0)
 ;;=H72.01^^1^5^13
 ;;^UTILITY(U,$J,358.3,79,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,79,1,3,0)
 ;;=3^Central perforation of tympanic membrane, right ear
 ;;^UTILITY(U,$J,358.3,79,1,4,0)
 ;;=4^H72.01
 ;;^UTILITY(U,$J,358.3,79,2)
 ;;=^5006743
 ;;^UTILITY(U,$J,358.3,80,0)
 ;;=H61.23^^1^5^20
 ;;^UTILITY(U,$J,358.3,80,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,80,1,3,0)
 ;;=3^Impacted cerumen, bilateral
 ;;^UTILITY(U,$J,358.3,80,1,4,0)
 ;;=4^H61.23
 ;;^UTILITY(U,$J,358.3,80,2)
 ;;=^5006533
 ;;^UTILITY(U,$J,358.3,81,0)
 ;;=H61.22^^1^5^21
 ;;^UTILITY(U,$J,358.3,81,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,81,1,3,0)
 ;;=3^Impacted cerumen, left ear
 ;;^UTILITY(U,$J,358.3,81,1,4,0)
 ;;=4^H61.22
 ;;^UTILITY(U,$J,358.3,81,2)
 ;;=^5006532
 ;;^UTILITY(U,$J,358.3,82,0)
 ;;=H61.21^^1^5^22
 ;;^UTILITY(U,$J,358.3,82,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,82,1,3,0)
 ;;=3^Impacted cerumen, right ear
 ;;^UTILITY(U,$J,358.3,82,1,4,0)
 ;;=4^H61.21
 ;;^UTILITY(U,$J,358.3,82,2)
 ;;=^5006531
 ;;^UTILITY(U,$J,358.3,83,0)
 ;;=H72.813^^1^5^26
 ;;^UTILITY(U,$J,358.3,83,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,83,1,3,0)
 ;;=3^Multiple perforations of tympanic membrane, bilateral
