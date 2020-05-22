IBDEI2DT ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38011,1,3,0)
 ;;=3^Rheumatoid nodule, right Ankle/Foot
 ;;^UTILITY(U,$J,358.3,38011,1,4,0)
 ;;=4^M06.371
 ;;^UTILITY(U,$J,358.3,38011,2)
 ;;=^5010115
 ;;^UTILITY(U,$J,358.3,38012,0)
 ;;=M05.59^^146^1926^9
 ;;^UTILITY(U,$J,358.3,38012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38012,1,3,0)
 ;;=3^Rheum polyneuropathy w/ rheum arthr mult site
 ;;^UTILITY(U,$J,358.3,38012,1,4,0)
 ;;=4^M05.59
 ;;^UTILITY(U,$J,358.3,38012,2)
 ;;=^5009976
 ;;^UTILITY(U,$J,358.3,38013,0)
 ;;=M05.572^^146^1926^8
 ;;^UTILITY(U,$J,358.3,38013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38013,1,3,0)
 ;;=3^Rheum polyneuropathy w/ rheum arthr lft ank/ft
 ;;^UTILITY(U,$J,358.3,38013,1,4,0)
 ;;=4^M05.572
 ;;^UTILITY(U,$J,358.3,38013,2)
 ;;=^5009974
 ;;^UTILITY(U,$J,358.3,38014,0)
 ;;=M05.571^^146^1926^10
 ;;^UTILITY(U,$J,358.3,38014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38014,1,3,0)
 ;;=3^Rheum polyneuropathy w/ rheum arthr rt ank/ft
 ;;^UTILITY(U,$J,358.3,38014,1,4,0)
 ;;=4^M05.571
 ;;^UTILITY(U,$J,358.3,38014,2)
 ;;=^5009973
 ;;^UTILITY(U,$J,358.3,38015,0)
 ;;=M05.471^^146^1926^7
 ;;^UTILITY(U,$J,358.3,38015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38015,1,3,0)
 ;;=3^Rheum myopathy w/ rheum arthr rt ank/ft
 ;;^UTILITY(U,$J,358.3,38015,1,4,0)
 ;;=4^M05.471
 ;;^UTILITY(U,$J,358.3,38015,2)
 ;;=^5009950
 ;;^UTILITY(U,$J,358.3,38016,0)
 ;;=M05.472^^146^1926^6
 ;;^UTILITY(U,$J,358.3,38016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38016,1,3,0)
 ;;=3^Rheum myopathy w/ rheum arthr lft ank/ft
 ;;^UTILITY(U,$J,358.3,38016,1,4,0)
 ;;=4^M05.472
 ;;^UTILITY(U,$J,358.3,38016,2)
 ;;=^5009951
 ;;^UTILITY(U,$J,358.3,38017,0)
 ;;=G90.523^^146^1926^1
 ;;^UTILITY(U,$J,358.3,38017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38017,1,3,0)
 ;;=3^Regional Pain Syndrome,Bliateral Lower Limbs,Complex
 ;;^UTILITY(U,$J,358.3,38017,1,4,0)
 ;;=4^G90.523
 ;;^UTILITY(U,$J,358.3,38017,2)
 ;;=^5004169
 ;;^UTILITY(U,$J,358.3,38018,0)
 ;;=G90.522^^146^1926^2
 ;;^UTILITY(U,$J,358.3,38018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38018,1,3,0)
 ;;=3^Regional Pain Syndrome,Lft Lower Limb,Complex
 ;;^UTILITY(U,$J,358.3,38018,1,4,0)
 ;;=4^G90.522
 ;;^UTILITY(U,$J,358.3,38018,2)
 ;;=^5133371
 ;;^UTILITY(U,$J,358.3,38019,0)
 ;;=G90.521^^146^1926^3
 ;;^UTILITY(U,$J,358.3,38019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38019,1,3,0)
 ;;=3^Regional Pain Syndrome,Rt Lower Limb,Complex
 ;;^UTILITY(U,$J,358.3,38019,1,4,0)
 ;;=4^G90.521
 ;;^UTILITY(U,$J,358.3,38019,2)
 ;;=^5004168
 ;;^UTILITY(U,$J,358.3,38020,0)
 ;;=M06.272^^146^1926^11
 ;;^UTILITY(U,$J,358.3,38020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38020,1,3,0)
 ;;=3^Rheumatoid Bursitis,Lft Ankle/Foot
 ;;^UTILITY(U,$J,358.3,38020,1,4,0)
 ;;=4^M06.272
 ;;^UTILITY(U,$J,358.3,38020,2)
 ;;=^5010092
 ;;^UTILITY(U,$J,358.3,38021,0)
 ;;=M06.271^^146^1926^12
 ;;^UTILITY(U,$J,358.3,38021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38021,1,3,0)
 ;;=3^Rheumatoid Bursitis,Rt Ankle/Foot
 ;;^UTILITY(U,$J,358.3,38021,1,4,0)
 ;;=4^M06.271
 ;;^UTILITY(U,$J,358.3,38021,2)
 ;;=^5010091
 ;;^UTILITY(U,$J,358.3,38022,0)
 ;;=Z47.2^^146^1926^4
 ;;^UTILITY(U,$J,358.3,38022,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38022,1,3,0)
 ;;=3^Removal of Internal Fixation Device
 ;;^UTILITY(U,$J,358.3,38022,1,4,0)
 ;;=4^Z47.2
 ;;^UTILITY(U,$J,358.3,38022,2)
 ;;=^5063026
 ;;^UTILITY(U,$J,358.3,38023,0)
 ;;=Z48.02^^146^1926^5
