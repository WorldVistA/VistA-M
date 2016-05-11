IBDEI1UM ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31401,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31401,1,2,0)
 ;;=2^Lengthening or shortening of tendon, leg or ankle; single tendon
 ;;^UTILITY(U,$J,358.3,31401,1,3,0)
 ;;=3^27685
 ;;^UTILITY(U,$J,358.3,31402,0)
 ;;=27695^^125^1591^14^^^^1
 ;;^UTILITY(U,$J,358.3,31402,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31402,1,2,0)
 ;;=2^Repair, primary, disrupted ligament, ankle; both collateral ligaments
 ;;^UTILITY(U,$J,358.3,31402,1,3,0)
 ;;=3^27695
 ;;^UTILITY(U,$J,358.3,31403,0)
 ;;=27698^^125^1591^16^^^^1
 ;;^UTILITY(U,$J,358.3,31403,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31403,1,2,0)
 ;;=2^Repair, secondary, disrupted ligament ankle, collateral
 ;;^UTILITY(U,$J,358.3,31403,1,3,0)
 ;;=3^27698
 ;;^UTILITY(U,$J,358.3,31404,0)
 ;;=28200^^125^1591^19^^^^1
 ;;^UTILITY(U,$J,358.3,31404,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31404,1,2,0)
 ;;=2^Repair, tendon, flexor, foot; primary or secondary, without free graft, each tendon
 ;;^UTILITY(U,$J,358.3,31404,1,3,0)
 ;;=3^28200
 ;;^UTILITY(U,$J,358.3,31405,0)
 ;;=28202^^125^1591^20^^^^1
 ;;^UTILITY(U,$J,358.3,31405,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31405,1,2,0)
 ;;=2^Repair, tendon, flexor, foot; secondarywith free graft, each tendon (includes obtaining graft), 
 ;;^UTILITY(U,$J,358.3,31405,1,3,0)
 ;;=3^28202
 ;;^UTILITY(U,$J,358.3,31406,0)
 ;;=28210^^125^1591^18^^^^1
 ;;^UTILITY(U,$J,358.3,31406,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31406,1,2,0)
 ;;=2^Repair, tendon, extensor, foot; secondary with free graft, each tendon (includes obtaining graft) 
 ;;^UTILITY(U,$J,358.3,31406,1,3,0)
 ;;=3^28210
 ;;^UTILITY(U,$J,358.3,31407,0)
 ;;=28208^^125^1591^17^^^^1
 ;;^UTILITY(U,$J,358.3,31407,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31407,1,2,0)
 ;;=2^Repair, tendon, extensor, foot; primary or secondary, each tendon
 ;;^UTILITY(U,$J,358.3,31407,1,3,0)
 ;;=3^28208
 ;;^UTILITY(U,$J,358.3,31408,0)
 ;;=28230^^125^1591^29^^^^1
 ;;^UTILITY(U,$J,358.3,31408,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31408,1,2,0)
 ;;=2^Tenotomy, open, tendon flexor; foot, single or multiple tendon(s)(separate procedure)
 ;;^UTILITY(U,$J,358.3,31408,1,3,0)
 ;;=3^28230
 ;;^UTILITY(U,$J,358.3,31409,0)
 ;;=28232^^125^1591^30^^^^1
 ;;^UTILITY(U,$J,358.3,31409,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31409,1,2,0)
 ;;=2^Tenotomy, open, tendon flexor; toe, single tendon (separate procedure) 
 ;;^UTILITY(U,$J,358.3,31409,1,3,0)
 ;;=3^28232
 ;;^UTILITY(U,$J,358.3,31410,0)
 ;;=28234^^125^1591^28^^^^1
 ;;^UTILITY(U,$J,358.3,31410,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31410,1,2,0)
 ;;=2^Tenotomy, open, extensor, foot or toe, each tendon
 ;;^UTILITY(U,$J,358.3,31410,1,3,0)
 ;;=3^28234
 ;;^UTILITY(U,$J,358.3,31411,0)
 ;;=28270^^125^1591^4^^^^1
 ;;^UTILITY(U,$J,358.3,31411,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31411,1,2,0)
 ;;=2^Capsulotomy; metatarsophalangeal joint, with or without tenorrhaphy, each joint (separate procedure) 
 ;;^UTILITY(U,$J,358.3,31411,1,3,0)
 ;;=3^28270
 ;;^UTILITY(U,$J,358.3,31412,0)
 ;;=28272^^125^1591^3^^^^1
 ;;^UTILITY(U,$J,358.3,31412,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31412,1,2,0)
 ;;=2^Capsulotomy; interphalangeal joint, each joint
 ;;^UTILITY(U,$J,358.3,31412,1,3,0)
 ;;=3^28272
 ;;^UTILITY(U,$J,358.3,31413,0)
 ;;=28285^^125^1591^6^^^^1
 ;;^UTILITY(U,$J,358.3,31413,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31413,1,2,0)
 ;;=2^Correction, hammertoe
 ;;^UTILITY(U,$J,358.3,31413,1,3,0)
 ;;=3^28285
 ;;^UTILITY(U,$J,358.3,31414,0)
 ;;=28288^^125^1591^9^^^^1
 ;;^UTILITY(U,$J,358.3,31414,1,0)
 ;;=^358.31IA^3^2
