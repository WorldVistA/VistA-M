IBDEI04U ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1949,1,3,0)
 ;;=3^Neck Sprain/Strain
 ;;^UTILITY(U,$J,358.3,1949,1,4,0)
 ;;=4^847.0
 ;;^UTILITY(U,$J,358.3,1949,2)
 ;;=^81735
 ;;^UTILITY(U,$J,358.3,1950,0)
 ;;=847.1^^17^168^5
 ;;^UTILITY(U,$J,358.3,1950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1950,1,3,0)
 ;;=3^Thoracic Sprain/Strain
 ;;^UTILITY(U,$J,358.3,1950,1,4,0)
 ;;=4^847.1
 ;;^UTILITY(U,$J,358.3,1950,2)
 ;;=^274526
 ;;^UTILITY(U,$J,358.3,1951,0)
 ;;=847.2^^17^168^2
 ;;^UTILITY(U,$J,358.3,1951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1951,1,3,0)
 ;;=3^Lumbar Sprain/Strain
 ;;^UTILITY(U,$J,358.3,1951,1,4,0)
 ;;=4^847.2
 ;;^UTILITY(U,$J,358.3,1951,2)
 ;;=^274527
 ;;^UTILITY(U,$J,358.3,1952,0)
 ;;=847.3^^17^168^4
 ;;^UTILITY(U,$J,358.3,1952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1952,1,3,0)
 ;;=3^Sacrum Sprain/Strain
 ;;^UTILITY(U,$J,358.3,1952,1,4,0)
 ;;=4^847.3
 ;;^UTILITY(U,$J,358.3,1952,2)
 ;;=^274528
 ;;^UTILITY(U,$J,358.3,1953,0)
 ;;=847.4^^17^168^1
 ;;^UTILITY(U,$J,358.3,1953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1953,1,3,0)
 ;;=3^Coccyx Sprain/Strain
 ;;^UTILITY(U,$J,358.3,1953,1,4,0)
 ;;=4^847.4
 ;;^UTILITY(U,$J,358.3,1953,2)
 ;;=^274529
 ;;^UTILITY(U,$J,358.3,1954,0)
 ;;=97014^^18^169^2^^^^1
 ;;^UTILITY(U,$J,358.3,1954,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1954,1,2,0)
 ;;=2^Electric Stimulation Therapy,Unattended
 ;;^UTILITY(U,$J,358.3,1954,1,3,0)
 ;;=3^97014
 ;;^UTILITY(U,$J,358.3,1955,0)
 ;;=97032^^18^169^3^^^^1
 ;;^UTILITY(U,$J,358.3,1955,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1955,1,2,0)
 ;;=2^Electrical Stimulation,1+ Areas,Ea 15min
 ;;^UTILITY(U,$J,358.3,1955,1,3,0)
 ;;=3^97032
 ;;^UTILITY(U,$J,358.3,1956,0)
 ;;=97010^^18^169^4^^^^1
 ;;^UTILITY(U,$J,358.3,1956,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1956,1,2,0)
 ;;=2^Hot Or Cold Packs Therapy
 ;;^UTILITY(U,$J,358.3,1956,1,3,0)
 ;;=3^97010
 ;;^UTILITY(U,$J,358.3,1957,0)
 ;;=97036^^18^169^5^^^^1
 ;;^UTILITY(U,$J,358.3,1957,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1957,1,2,0)
 ;;=2^Hubbard Tank,Ea 15min
 ;;^UTILITY(U,$J,358.3,1957,1,3,0)
 ;;=3^97036
 ;;^UTILITY(U,$J,358.3,1958,0)
 ;;=97124^^18^169^7^^^^1
 ;;^UTILITY(U,$J,358.3,1958,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1958,1,2,0)
 ;;=2^Massage Therapy
 ;;^UTILITY(U,$J,358.3,1958,1,3,0)
 ;;=3^97124
 ;;^UTILITY(U,$J,358.3,1959,0)
 ;;=64550^^18^169^1^^^^1
 ;;^UTILITY(U,$J,358.3,1959,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1959,1,2,0)
 ;;=2^Apply Neurostimulator
 ;;^UTILITY(U,$J,358.3,1959,1,3,0)
 ;;=3^64550
 ;;^UTILITY(U,$J,358.3,1960,0)
 ;;=97012^^18^169^8^^^^1
 ;;^UTILITY(U,$J,358.3,1960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1960,1,2,0)
 ;;=2^Mechanical Traction Therapy 
 ;;^UTILITY(U,$J,358.3,1960,1,3,0)
 ;;=3^97012
 ;;^UTILITY(U,$J,358.3,1961,0)
 ;;=97035^^18^169^11^^^^1
 ;;^UTILITY(U,$J,358.3,1961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1961,1,2,0)
 ;;=2^Ultrasound Therapy,Ea 15min
 ;;^UTILITY(U,$J,358.3,1961,1,3,0)
 ;;=3^97035
 ;;^UTILITY(U,$J,358.3,1962,0)
 ;;=97028^^18^169^12^^^^1
 ;;^UTILITY(U,$J,358.3,1962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1962,1,2,0)
 ;;=2^Ultraviolet Therapy
 ;;^UTILITY(U,$J,358.3,1962,1,3,0)
 ;;=3^97028
 ;;^UTILITY(U,$J,358.3,1963,0)
 ;;=97110^^18^169^10^^^^1
 ;;^UTILITY(U,$J,358.3,1963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1963,1,2,0)
 ;;=2^Therapeutic Exercises,Ea 15min
 ;;^UTILITY(U,$J,358.3,1963,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,1964,0)
 ;;=97112^^18^169^9^^^^1
 ;;^UTILITY(U,$J,358.3,1964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1964,1,2,0)
 ;;=2^Neuromuscular Re-Education
