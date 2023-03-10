IBDEI16V ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,19291,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,19291,1,1,0)
 ;;=1^Detailed Hx/PE & Low Complex MDM
 ;;^UTILITY(U,$J,358.3,19291,1,2,0)
 ;;=2^99243
 ;;^UTILITY(U,$J,358.3,19292,0)
 ;;=99244^^65^857^4
 ;;^UTILITY(U,$J,358.3,19292,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,19292,1,1,0)
 ;;=1^Comprehensive Hx/PE & Moderate Complex MDM
 ;;^UTILITY(U,$J,358.3,19292,1,2,0)
 ;;=2^99244
 ;;^UTILITY(U,$J,358.3,19293,0)
 ;;=99245^^65^857^5
 ;;^UTILITY(U,$J,358.3,19293,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,19293,1,1,0)
 ;;=1^Comprehensive Hx/PE & High Complex MDM
 ;;^UTILITY(U,$J,358.3,19293,1,2,0)
 ;;=2^99245
 ;;^UTILITY(U,$J,358.3,19294,0)
 ;;=97014^^66^858^17^^^^1
 ;;^UTILITY(U,$J,358.3,19294,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19294,1,2,0)
 ;;=2^Electric Stimulation Therapy (Unattended)
 ;;^UTILITY(U,$J,358.3,19294,1,3,0)
 ;;=3^97014
 ;;^UTILITY(U,$J,358.3,19295,0)
 ;;=97032^^66^858^18^^^^1
 ;;^UTILITY(U,$J,358.3,19295,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19295,1,2,0)
 ;;=2^Electrical Stimulation,Attended,ea 15min
 ;;^UTILITY(U,$J,358.3,19295,1,3,0)
 ;;=3^97032
 ;;^UTILITY(U,$J,358.3,19296,0)
 ;;=97110^^66^858^44^^^^1
 ;;^UTILITY(U,$J,358.3,19296,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19296,1,2,0)
 ;;=2^Therapeutic Exercises,1 or more Areas,ea 15min
 ;;^UTILITY(U,$J,358.3,19296,1,3,0)
 ;;=3^97110
 ;;^UTILITY(U,$J,358.3,19297,0)
 ;;=97116^^66^858^20^^^^1
 ;;^UTILITY(U,$J,358.3,19297,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19297,1,2,0)
 ;;=2^Gait Training Therapy,ea 15min
 ;;^UTILITY(U,$J,358.3,19297,1,3,0)
 ;;=3^97116
 ;;^UTILITY(U,$J,358.3,19298,0)
 ;;=97150^^66^858^21^^^^1
 ;;^UTILITY(U,$J,358.3,19298,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19298,1,2,0)
 ;;=2^Group Therapeutic Procedures
 ;;^UTILITY(U,$J,358.3,19298,1,3,0)
 ;;=3^97150
 ;;^UTILITY(U,$J,358.3,19299,0)
 ;;=97010^^66^858^22^^^^1
 ;;^UTILITY(U,$J,358.3,19299,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19299,1,2,0)
 ;;=2^Hot Or Cold Packs Therapy
 ;;^UTILITY(U,$J,358.3,19299,1,3,0)
 ;;=3^97010
 ;;^UTILITY(U,$J,358.3,19300,0)
 ;;=97036^^66^858^23^^^^1
 ;;^UTILITY(U,$J,358.3,19300,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19300,1,2,0)
 ;;=2^Hydrotherapy (Hubbard Tank),ea 15min
 ;;^UTILITY(U,$J,358.3,19300,1,3,0)
 ;;=3^97036
 ;;^UTILITY(U,$J,358.3,19301,0)
 ;;=97033^^66^858^16^^^^1
 ;;^UTILITY(U,$J,358.3,19301,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19301,1,2,0)
 ;;=2^Electric Current Therapy,ea 15min
 ;;^UTILITY(U,$J,358.3,19301,1,3,0)
 ;;=3^97033
 ;;^UTILITY(U,$J,358.3,19302,0)
 ;;=97124^^66^858^28^^^^1
 ;;^UTILITY(U,$J,358.3,19302,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19302,1,2,0)
 ;;=2^Massage Therapy,ea 15min
 ;;^UTILITY(U,$J,358.3,19302,1,3,0)
 ;;=3^97124
 ;;^UTILITY(U,$J,358.3,19303,0)
 ;;=97112^^66^858^30^^^^1
 ;;^UTILITY(U,$J,358.3,19303,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19303,1,2,0)
 ;;=2^Neuromuscular Reeducation,ea 15min
 ;;^UTILITY(U,$J,358.3,19303,1,3,0)
 ;;=3^97112
 ;;^UTILITY(U,$J,358.3,19304,0)
 ;;=97018^^66^858^31^^^^1
 ;;^UTILITY(U,$J,358.3,19304,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19304,1,2,0)
 ;;=2^Paraffin Bath Therapy
 ;;^UTILITY(U,$J,358.3,19304,1,3,0)
 ;;=3^97018
 ;;^UTILITY(U,$J,358.3,19305,0)
 ;;=97750^^66^858^32^^^^1
 ;;^UTILITY(U,$J,358.3,19305,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,19305,1,2,0)
 ;;=2^Physical Performance Test
