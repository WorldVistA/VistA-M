IBDEI0FI ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6684,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6684,1,1,0)
 ;;=1^Comprehensive, Moderate
 ;;^UTILITY(U,$J,358.3,6684,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,6685,0)
 ;;=99245^^54^433^5
 ;;^UTILITY(U,$J,358.3,6685,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,6685,1,1,0)
 ;;=1^Comprehensive, High
 ;;^UTILITY(U,$J,358.3,6685,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,6686,0)
 ;;=97014^^55^434^3^^^^1
 ;;^UTILITY(U,$J,358.3,6686,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6686,1,2,0)
 ;;=2^Electric Stimulation Therapy (TENS),Unattended
 ;;^UTILITY(U,$J,358.3,6686,1,3,0)
 ;;=3^97014
 ;;^UTILITY(U,$J,358.3,6687,0)
 ;;=97032^^55^434^4^^^^1
 ;;^UTILITY(U,$J,358.3,6687,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6687,1,2,0)
 ;;=2^Electrical Stimulation (TENS),1+ Areas,Ea 15min
 ;;^UTILITY(U,$J,358.3,6687,1,3,0)
 ;;=3^97032
 ;;^UTILITY(U,$J,358.3,6688,0)
 ;;=97010^^55^434^5^^^^1
 ;;^UTILITY(U,$J,358.3,6688,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6688,1,2,0)
 ;;=2^Hot Or Cold Packs Therapy
 ;;^UTILITY(U,$J,358.3,6688,1,3,0)
 ;;=3^97010
 ;;^UTILITY(U,$J,358.3,6689,0)
 ;;=97036^^55^434^6^^^^1
 ;;^UTILITY(U,$J,358.3,6689,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6689,1,2,0)
 ;;=2^Hubbard Tank,Ea 15min
 ;;^UTILITY(U,$J,358.3,6689,1,3,0)
 ;;=3^97036
 ;;^UTILITY(U,$J,358.3,6690,0)
 ;;=97124^^55^434^9^^^^1
 ;;^UTILITY(U,$J,358.3,6690,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6690,1,2,0)
 ;;=2^Massage Therapy
 ;;^UTILITY(U,$J,358.3,6690,1,3,0)
 ;;=3^97124
 ;;^UTILITY(U,$J,358.3,6691,0)
 ;;=97012^^55^434^10^^^^1
 ;;^UTILITY(U,$J,358.3,6691,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6691,1,2,0)
 ;;=2^Mechanical Traction Therapy 
 ;;^UTILITY(U,$J,358.3,6691,1,3,0)
 ;;=3^97012
 ;;^UTILITY(U,$J,358.3,6692,0)
 ;;=97035^^55^434^20^^^^1
 ;;^UTILITY(U,$J,358.3,6692,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6692,1,2,0)
 ;;=2^Ultrasound Therapy,Ea 15min
 ;;^UTILITY(U,$J,358.3,6692,1,3,0)
 ;;=3^97035
 ;;^UTILITY(U,$J,358.3,6693,0)
 ;;=97028^^55^434^21^^^^1
 ;;^UTILITY(U,$J,358.3,6693,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6693,1,2,0)
 ;;=2^Ultraviolet Therapy
 ;;^UTILITY(U,$J,358.3,6693,1,3,0)
 ;;=3^97028
 ;;^UTILITY(U,$J,358.3,6694,0)
 ;;=97110^^55^434^19^^^^1
 ;;^UTILITY(U,$J,358.3,6694,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6694,1,2,0)
 ;;=2^Therapeutic Exercises,1 or more regions,Ea 15min
 ;;^UTILITY(U,$J,358.3,6694,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,6695,0)
 ;;=97112^^55^434^11^^^^1
 ;;^UTILITY(U,$J,358.3,6695,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6695,1,2,0)
 ;;=2^Neuromuscular Re-Education
 ;;^UTILITY(U,$J,358.3,6695,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,6696,0)
 ;;=97140^^55^434^8^^^^1
 ;;^UTILITY(U,$J,358.3,6696,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6696,1,2,0)
 ;;=2^Manual Therapy,1 or more regions,Ea 15min
 ;;^UTILITY(U,$J,358.3,6696,1,3,0)
 ;;=3^97140
 ;;^UTILITY(U,$J,358.3,6697,0)
 ;;=97039^^55^434^1^^^^1
 ;;^UTILITY(U,$J,358.3,6697,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6697,1,2,0)
 ;;=2^Cold Laser Therapy
 ;;^UTILITY(U,$J,358.3,6697,1,3,0)
 ;;=3^97039
 ;;^UTILITY(U,$J,358.3,6698,0)
 ;;=97026^^55^434^7^^^^1
 ;;^UTILITY(U,$J,358.3,6698,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6698,1,2,0)
 ;;=2^Infrared Heat to 1 or more areas
 ;;^UTILITY(U,$J,358.3,6698,1,3,0)
 ;;=3^97026
 ;;^UTILITY(U,$J,358.3,6699,0)
 ;;=29540^^55^434^12^^^^1
