IBDEI2LC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41353,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41353,1,2,0)
 ;;=2^Electrical Stimulation,Attended,ea 15min
 ;;^UTILITY(U,$J,358.3,41353,1,3,0)
 ;;=3^97032
 ;;^UTILITY(U,$J,358.3,41354,0)
 ;;=97110^^154^2040^47^^^^1
 ;;^UTILITY(U,$J,358.3,41354,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41354,1,2,0)
 ;;=2^Therapeutic Exercises,1 or more Areas,ea 15min
 ;;^UTILITY(U,$J,358.3,41354,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,41355,0)
 ;;=97116^^154^2040^22^^^^1
 ;;^UTILITY(U,$J,358.3,41355,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41355,1,2,0)
 ;;=2^Gait Training Therapy,ea 15min
 ;;^UTILITY(U,$J,358.3,41355,1,3,0)
 ;;=3^97116
 ;;^UTILITY(U,$J,358.3,41356,0)
 ;;=97150^^154^2040^23^^^^1
 ;;^UTILITY(U,$J,358.3,41356,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41356,1,2,0)
 ;;=2^Group Therapeutic Procedures
 ;;^UTILITY(U,$J,358.3,41356,1,3,0)
 ;;=3^97150
 ;;^UTILITY(U,$J,358.3,41357,0)
 ;;=97010^^154^2040^24^^^^1
 ;;^UTILITY(U,$J,358.3,41357,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41357,1,2,0)
 ;;=2^Hot Or Cold Packs Therapy
 ;;^UTILITY(U,$J,358.3,41357,1,3,0)
 ;;=3^97010
 ;;^UTILITY(U,$J,358.3,41358,0)
 ;;=97036^^154^2040^25^^^^1
 ;;^UTILITY(U,$J,358.3,41358,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41358,1,2,0)
 ;;=2^Hydrotherapy (Hubbard Tank),ea 15min
 ;;^UTILITY(U,$J,358.3,41358,1,3,0)
 ;;=3^97036
 ;;^UTILITY(U,$J,358.3,41359,0)
 ;;=97033^^154^2040^18^^^^1
 ;;^UTILITY(U,$J,358.3,41359,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41359,1,2,0)
 ;;=2^Electric Current Therapy,ea 15min
 ;;^UTILITY(U,$J,358.3,41359,1,3,0)
 ;;=3^97033
 ;;^UTILITY(U,$J,358.3,41360,0)
 ;;=97124^^154^2040^30^^^^1
 ;;^UTILITY(U,$J,358.3,41360,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41360,1,2,0)
 ;;=2^Massage Therapy,ea 15min
 ;;^UTILITY(U,$J,358.3,41360,1,3,0)
 ;;=3^97124
 ;;^UTILITY(U,$J,358.3,41361,0)
 ;;=97112^^154^2040^32^^^^1
 ;;^UTILITY(U,$J,358.3,41361,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41361,1,2,0)
 ;;=2^Neuromuscular Reeducation,ea 15min
 ;;^UTILITY(U,$J,358.3,41361,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,41362,0)
 ;;=97018^^154^2040^33^^^^1
 ;;^UTILITY(U,$J,358.3,41362,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41362,1,2,0)
 ;;=2^Paraffin Bath Therapy
 ;;^UTILITY(U,$J,358.3,41362,1,3,0)
 ;;=3^97018
 ;;^UTILITY(U,$J,358.3,41363,0)
 ;;=97750^^154^2040^34^^^^1
 ;;^UTILITY(U,$J,358.3,41363,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41363,1,2,0)
 ;;=2^Physical Performance Test
 ;;^UTILITY(U,$J,358.3,41363,1,3,0)
 ;;=3^97750
 ;;^UTILITY(U,$J,358.3,41364,0)
 ;;=97535^^154^2040^38^^^^1
 ;;^UTILITY(U,$J,358.3,41364,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41364,1,2,0)
 ;;=2^Self Care Mngment Training,ea 15min
 ;;^UTILITY(U,$J,358.3,41364,1,3,0)
 ;;=3^97535
 ;;^UTILITY(U,$J,358.3,41365,0)
 ;;=97530^^154^2040^46^^^^1
 ;;^UTILITY(U,$J,358.3,41365,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41365,1,2,0)
 ;;=2^Therapeutic Dynamic Activities,ea 15min
 ;;^UTILITY(U,$J,358.3,41365,1,3,0)
 ;;=3^97530
 ;;^UTILITY(U,$J,358.3,41366,0)
 ;;=97140^^154^2040^29^^^^1
 ;;^UTILITY(U,$J,358.3,41366,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41366,1,2,0)
 ;;=2^Manual Therapy,ea 15min
 ;;^UTILITY(U,$J,358.3,41366,1,3,0)
 ;;=3^97140
 ;;^UTILITY(U,$J,358.3,41367,0)
 ;;=97012^^154^2040^31^^^^1
 ;;^UTILITY(U,$J,358.3,41367,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,41367,1,2,0)
 ;;=2^Mechanical Traction Therapy
