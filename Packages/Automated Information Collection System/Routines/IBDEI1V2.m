IBDEI1V2 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31622,1,2,0)
 ;;=2^Removal of implant; superficial (eg, buried wire, pin or rod)
 ;;^UTILITY(U,$J,358.3,31622,1,3,0)
 ;;=3^20670
 ;;^UTILITY(U,$J,358.3,31623,0)
 ;;=20680^^125^1601^9^^^^1
 ;;^UTILITY(U,$J,358.3,31623,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31623,1,2,0)
 ;;=2^Removal of implant; deep (eg, buried wire, pin, screw, metal band, nail, rod or plate)
 ;;^UTILITY(U,$J,358.3,31623,1,3,0)
 ;;=3^20680
 ;;^UTILITY(U,$J,358.3,31624,0)
 ;;=S0630^^125^1601^3^^^^1
 ;;^UTILITY(U,$J,358.3,31624,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31624,1,2,0)
 ;;=2^Removal of Sutures
 ;;^UTILITY(U,$J,358.3,31624,1,3,0)
 ;;=3^S0630
 ;;^UTILITY(U,$J,358.3,31625,0)
 ;;=28805^^125^1602^1^^^^1
 ;;^UTILITY(U,$J,358.3,31625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31625,1,2,0)
 ;;=2^Amputation, foot; transmetatarsal
 ;;^UTILITY(U,$J,358.3,31625,1,3,0)
 ;;=3^28805
 ;;^UTILITY(U,$J,358.3,31626,0)
 ;;=28810^^125^1602^2^^^^1
 ;;^UTILITY(U,$J,358.3,31626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31626,1,2,0)
 ;;=2^Amputation, metatarsal, with toe, single
 ;;^UTILITY(U,$J,358.3,31626,1,3,0)
 ;;=3^28810
 ;;^UTILITY(U,$J,358.3,31627,0)
 ;;=28820^^125^1602^4^^^^1
 ;;^UTILITY(U,$J,358.3,31627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31627,1,2,0)
 ;;=2^Amputation, toe; metatarsophalangeal joint
 ;;^UTILITY(U,$J,358.3,31627,1,3,0)
 ;;=3^28820
 ;;^UTILITY(U,$J,358.3,31628,0)
 ;;=28825^^125^1602^3^^^^1
 ;;^UTILITY(U,$J,358.3,31628,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31628,1,2,0)
 ;;=2^Amputation, toe; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,31628,1,3,0)
 ;;=3^28825
 ;;^UTILITY(U,$J,358.3,31629,0)
 ;;=15271^^125^1602^5^^^^1
 ;;^UTILITY(U,$J,358.3,31629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31629,1,2,0)
 ;;=2^Skin Sub Graft Trnk/Arm/Leg,1st 25 sq cm
 ;;^UTILITY(U,$J,358.3,31629,1,3,0)
 ;;=3^15271
 ;;^UTILITY(U,$J,358.3,31630,0)
 ;;=15272^^125^1602^6^^^^1
 ;;^UTILITY(U,$J,358.3,31630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31630,1,2,0)
 ;;=2^Skin Sub Graft Trnk/Arm/Leg,Ea Addl 25 sq cm
 ;;^UTILITY(U,$J,358.3,31630,1,3,0)
 ;;=3^15272
 ;;^UTILITY(U,$J,358.3,31631,0)
 ;;=15275^^125^1603^1^^^^1
 ;;^UTILITY(U,$J,358.3,31631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31631,1,2,0)
 ;;=2^Skin Sub Graft FN/HF/G 1st 25 sq cm
 ;;^UTILITY(U,$J,358.3,31631,1,3,0)
 ;;=3^15275
 ;;^UTILITY(U,$J,358.3,31632,0)
 ;;=15276^^125^1603^2^^^^1
 ;;^UTILITY(U,$J,358.3,31632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31632,1,2,0)
 ;;=2^Skin Sub Graft FN/HF/G Ea Addl 25 sq cm
 ;;^UTILITY(U,$J,358.3,31632,1,3,0)
 ;;=3^15276
 ;;^UTILITY(U,$J,358.3,31633,0)
 ;;=Q4106^^125^1603^3^^^^1
 ;;^UTILITY(U,$J,358.3,31633,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31633,1,2,0)
 ;;=2^Dermagraft per sq cm
 ;;^UTILITY(U,$J,358.3,31633,1,3,0)
 ;;=3^Q4106
 ;;^UTILITY(U,$J,358.3,31634,0)
 ;;=I70.201^^126^1604^63
 ;;^UTILITY(U,$J,358.3,31634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31634,1,3,0)
 ;;=3^Athscl Native Arteries of Extr, rt leg, unsp
 ;;^UTILITY(U,$J,358.3,31634,1,4,0)
 ;;=4^I70.201
 ;;^UTILITY(U,$J,358.3,31634,2)
 ;;=^5007573
 ;;^UTILITY(U,$J,358.3,31635,0)
 ;;=I70.202^^126^1604^62
 ;;^UTILITY(U,$J,358.3,31635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31635,1,3,0)
 ;;=3^Athscl Native Arteries of Extr, lft leg, unsp
 ;;^UTILITY(U,$J,358.3,31635,1,4,0)
 ;;=4^I70.202
 ;;^UTILITY(U,$J,358.3,31635,2)
 ;;=^5007574
 ;;^UTILITY(U,$J,358.3,31636,0)
 ;;=I70.203^^126^1604^61
 ;;^UTILITY(U,$J,358.3,31636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31636,1,3,0)
 ;;=3^Athscl Native Arteries of Extr, biltrl legs, unsp
