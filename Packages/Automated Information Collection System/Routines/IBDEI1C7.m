IBDEI1C7 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23978,1,3,0)
 ;;=3^27698
 ;;^UTILITY(U,$J,358.3,23979,0)
 ;;=28200^^142^1493^9^^^^1
 ;;^UTILITY(U,$J,358.3,23979,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23979,1,2,0)
 ;;=2^Repair, tendon, flexor, foot; primary or secondary, without free graft, each tendon
 ;;^UTILITY(U,$J,358.3,23979,1,3,0)
 ;;=3^28200
 ;;^UTILITY(U,$J,358.3,23980,0)
 ;;=28202^^142^1493^10^^^^1
 ;;^UTILITY(U,$J,358.3,23980,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23980,1,2,0)
 ;;=2^Repair, tendon, flexor, foot; secondarywith free graft, each tendon (includes obtaining graft), 
 ;;^UTILITY(U,$J,358.3,23980,1,3,0)
 ;;=3^28202
 ;;^UTILITY(U,$J,358.3,23981,0)
 ;;=28210^^142^1493^12^^^^1
 ;;^UTILITY(U,$J,358.3,23981,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23981,1,2,0)
 ;;=2^Repair, tendon, extensor, foot; secondary with free graft, each tendon (includes obtaining graft) 
 ;;^UTILITY(U,$J,358.3,23981,1,3,0)
 ;;=3^28210
 ;;^UTILITY(U,$J,358.3,23982,0)
 ;;=28208^^142^1493^11^^^^1
 ;;^UTILITY(U,$J,358.3,23982,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23982,1,2,0)
 ;;=2^Repair, tendon, extensor, foot; primary or secondary, each tendon
 ;;^UTILITY(U,$J,358.3,23982,1,3,0)
 ;;=3^28208
 ;;^UTILITY(U,$J,358.3,23983,0)
 ;;=28230^^142^1493^13^^^^1
 ;;^UTILITY(U,$J,358.3,23983,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23983,1,2,0)
 ;;=2^Tenotomy, open, tendon flexor; foot, single or multiple tendon(s)(separate procedure)
 ;;^UTILITY(U,$J,358.3,23983,1,3,0)
 ;;=3^28230
 ;;^UTILITY(U,$J,358.3,23984,0)
 ;;=28232^^142^1493^14^^^^1
 ;;^UTILITY(U,$J,358.3,23984,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23984,1,2,0)
 ;;=2^Tenotomy, open, tendon flexor; toe, single tendon (separate procedure) 
 ;;^UTILITY(U,$J,358.3,23984,1,3,0)
 ;;=3^28232
 ;;^UTILITY(U,$J,358.3,23985,0)
 ;;=28234^^142^1493^15^^^^1
 ;;^UTILITY(U,$J,358.3,23985,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23985,1,2,0)
 ;;=2^Tenotomy, open, extensor, foot or toe, each tendon
 ;;^UTILITY(U,$J,358.3,23985,1,3,0)
 ;;=3^28234
 ;;^UTILITY(U,$J,358.3,23986,0)
 ;;=28270^^142^1493^16^^^^1
 ;;^UTILITY(U,$J,358.3,23986,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23986,1,2,0)
 ;;=2^Capsulotomy; metatarsophalangeal joint, with or without tenorrhaphy, each joint (separate procedure) 
 ;;^UTILITY(U,$J,358.3,23986,1,3,0)
 ;;=3^28270
 ;;^UTILITY(U,$J,358.3,23987,0)
 ;;=28272^^142^1493^17^^^^1
 ;;^UTILITY(U,$J,358.3,23987,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23987,1,2,0)
 ;;=2^Capsulotomy; interphalangeal joint, each joint
 ;;^UTILITY(U,$J,358.3,23987,1,3,0)
 ;;=3^28272
 ;;^UTILITY(U,$J,358.3,23988,0)
 ;;=28285^^142^1493^18^^^^1
 ;;^UTILITY(U,$J,358.3,23988,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23988,1,2,0)
 ;;=2^Correction, hammertoe
 ;;^UTILITY(U,$J,358.3,23988,1,3,0)
 ;;=3^28285
 ;;^UTILITY(U,$J,358.3,23989,0)
 ;;=28288^^142^1493^19^^^^1
 ;;^UTILITY(U,$J,358.3,23989,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23989,1,2,0)
 ;;=2^Ostectomy, partial, exostectomy or condylectomy, metatarsal head, each metatarsal head
 ;;^UTILITY(U,$J,358.3,23989,1,3,0)
 ;;=3^28288
 ;;^UTILITY(U,$J,358.3,23990,0)
 ;;=28290^^142^1493^20^^^^1
 ;;^UTILITY(U,$J,358.3,23990,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23990,1,2,0)
 ;;=2^Correction, hallux valgus, with or without sesamoidectomy; simple exostectomy
 ;;^UTILITY(U,$J,358.3,23990,1,3,0)
 ;;=3^28290
 ;;^UTILITY(U,$J,358.3,23991,0)
 ;;=28292^^142^1493^21^^^^1
 ;;^UTILITY(U,$J,358.3,23991,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,23991,1,2,0)
 ;;=2^Resection of Joint by Keller Type
