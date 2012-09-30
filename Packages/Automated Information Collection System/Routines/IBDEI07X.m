IBDEI07X ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10612,1,3,0)
 ;;=3^27650
 ;;^UTILITY(U,$J,358.3,10613,0)
 ;;=27686^^84^652^5^^^^1
 ;;^UTILITY(U,$J,358.3,10613,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10613,1,2,0)
 ;;=2^Lengthening or shortening of tendon each, leg or ankle; multiple  tendon
 ;;^UTILITY(U,$J,358.3,10613,1,3,0)
 ;;=3^27686
 ;;^UTILITY(U,$J,358.3,10614,0)
 ;;=27685^^84^652^4^^^^1
 ;;^UTILITY(U,$J,358.3,10614,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10614,1,2,0)
 ;;=2^Lengthening or shortening of tendon, leg or ankle; single tendon
 ;;^UTILITY(U,$J,358.3,10614,1,3,0)
 ;;=3^27685
 ;;^UTILITY(U,$J,358.3,10615,0)
 ;;=27695^^84^652^7^^^^1
 ;;^UTILITY(U,$J,358.3,10615,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10615,1,2,0)
 ;;=2^Repair, primary, disrupted ligament, ankle; both collateral ligaments
 ;;^UTILITY(U,$J,358.3,10615,1,3,0)
 ;;=3^27695
 ;;^UTILITY(U,$J,358.3,10616,0)
 ;;=27698^^84^652^8^^^^1
 ;;^UTILITY(U,$J,358.3,10616,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10616,1,2,0)
 ;;=2^Repair, secondary, disrupted ligament ankle, collateral
 ;;^UTILITY(U,$J,358.3,10616,1,3,0)
 ;;=3^27698
 ;;^UTILITY(U,$J,358.3,10617,0)
 ;;=28200^^84^652^9^^^^1
 ;;^UTILITY(U,$J,358.3,10617,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10617,1,2,0)
 ;;=2^Repair, tendon, flexor, foot; primary or secondary, without free graft, each tendon
 ;;^UTILITY(U,$J,358.3,10617,1,3,0)
 ;;=3^28200
 ;;^UTILITY(U,$J,358.3,10618,0)
 ;;=28202^^84^652^10^^^^1
 ;;^UTILITY(U,$J,358.3,10618,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10618,1,2,0)
 ;;=2^Repair, tendon, flexor, foot; secondarywith free graft, each tendon (includes obtaining graft), 
 ;;^UTILITY(U,$J,358.3,10618,1,3,0)
 ;;=3^28202
 ;;^UTILITY(U,$J,358.3,10619,0)
 ;;=28210^^84^652^12^^^^1
 ;;^UTILITY(U,$J,358.3,10619,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10619,1,2,0)
 ;;=2^Repair, tendon, extensor, foot; secondary with free graft, each tendon (includes obtaining graft) 
 ;;^UTILITY(U,$J,358.3,10619,1,3,0)
 ;;=3^28210
 ;;^UTILITY(U,$J,358.3,10620,0)
 ;;=28208^^84^652^11^^^^1
 ;;^UTILITY(U,$J,358.3,10620,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10620,1,2,0)
 ;;=2^Repair, tendon, extensor, foot; primary or secondary, each tendon
 ;;^UTILITY(U,$J,358.3,10620,1,3,0)
 ;;=3^28208
 ;;^UTILITY(U,$J,358.3,10621,0)
 ;;=28230^^84^652^13^^^^1
 ;;^UTILITY(U,$J,358.3,10621,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10621,1,2,0)
 ;;=2^Tenotomy, open, tendon flexor; foot, single or multiple tendon(s)(separate procedure)
 ;;^UTILITY(U,$J,358.3,10621,1,3,0)
 ;;=3^28230
 ;;^UTILITY(U,$J,358.3,10622,0)
 ;;=28232^^84^652^14^^^^1
 ;;^UTILITY(U,$J,358.3,10622,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10622,1,2,0)
 ;;=2^Tenotomy, open, tendon flexor; toe, single tendon (separate procedure) 
 ;;^UTILITY(U,$J,358.3,10622,1,3,0)
 ;;=3^28232
 ;;^UTILITY(U,$J,358.3,10623,0)
 ;;=28234^^84^652^15^^^^1
 ;;^UTILITY(U,$J,358.3,10623,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10623,1,2,0)
 ;;=2^Tenotomy, open, extensor, foot or toe, each tendon
 ;;^UTILITY(U,$J,358.3,10623,1,3,0)
 ;;=3^28234
 ;;^UTILITY(U,$J,358.3,10624,0)
 ;;=28270^^84^652^16^^^^1
 ;;^UTILITY(U,$J,358.3,10624,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10624,1,2,0)
 ;;=2^Capsulotomy; metatarsophalangeal joint, with or without tenorrhaphy, each joint (separate procedure) 
 ;;^UTILITY(U,$J,358.3,10624,1,3,0)
 ;;=3^28270
 ;;^UTILITY(U,$J,358.3,10625,0)
 ;;=28272^^84^652^17^^^^1
 ;;^UTILITY(U,$J,358.3,10625,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10625,1,2,0)
 ;;=2^Capsulotomy; interphalangeal joint, each joint
 ;;^UTILITY(U,$J,358.3,10625,1,3,0)
 ;;=3^28272
 ;;^UTILITY(U,$J,358.3,10626,0)
 ;;=28285^^84^652^18^^^^1
 ;;^UTILITY(U,$J,358.3,10626,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10626,1,2,0)
 ;;=2^Correction, hammertoe
 ;;^UTILITY(U,$J,358.3,10626,1,3,0)
 ;;=3^28285
 ;;^UTILITY(U,$J,358.3,10627,0)
 ;;=28288^^84^652^19^^^^1
 ;;^UTILITY(U,$J,358.3,10627,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10627,1,2,0)
 ;;=2^Ostectomy, partial, exostectomy or condylectomy, metatarsal head, each metatarsal head
 ;;^UTILITY(U,$J,358.3,10627,1,3,0)
 ;;=3^28288
 ;;^UTILITY(U,$J,358.3,10628,0)
 ;;=28290^^84^652^20^^^^1
 ;;^UTILITY(U,$J,358.3,10628,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10628,1,2,0)
 ;;=2^Correction, hallux valgus, with or without sesamoidectomy; simple exostectomy
 ;;^UTILITY(U,$J,358.3,10628,1,3,0)
 ;;=3^28290
 ;;^UTILITY(U,$J,358.3,10629,0)
 ;;=28292^^84^652^21^^^^1
 ;;^UTILITY(U,$J,358.3,10629,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10629,1,2,0)
 ;;=2^Resection of Joint by Keller Type
 ;;^UTILITY(U,$J,358.3,10629,1,3,0)
 ;;=3^28292
 ;;^UTILITY(U,$J,358.3,10630,0)
 ;;=28293^^84^652^22^^^^1
 ;;^UTILITY(U,$J,358.3,10630,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10630,1,2,0)
 ;;=2^Resection of joint with implant
 ;;^UTILITY(U,$J,358.3,10630,1,3,0)
 ;;=3^28293
 ;;^UTILITY(U,$J,358.3,10631,0)
 ;;=28296^^84^652^23^^^^1
 ;;^UTILITY(U,$J,358.3,10631,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10631,1,2,0)
 ;;=2^Resection of joint with metatarsal osteotomy
 ;;^UTILITY(U,$J,358.3,10631,1,3,0)
 ;;=3^28296
 ;;^UTILITY(U,$J,358.3,10632,0)
 ;;=28298^^84^652^25^^^^1
 ;;^UTILITY(U,$J,358.3,10632,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10632,1,2,0)
 ;;=2^Resection of joint by phalanx osteotomy
 ;;^UTILITY(U,$J,358.3,10632,1,3,0)
 ;;=3^28298
 ;;^UTILITY(U,$J,358.3,10633,0)
 ;;=28299^^84^652^26^^^^1
 ;;^UTILITY(U,$J,358.3,10633,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10633,1,2,0)
 ;;=2^Resection of joint by double osteotomy 
 ;;^UTILITY(U,$J,358.3,10633,1,3,0)
 ;;=3^28299
 ;;^UTILITY(U,$J,358.3,10634,0)
 ;;=28300^^84^652^27^^^^1
 ;;^UTILITY(U,$J,358.3,10634,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10634,1,2,0)
 ;;=2^Resection of joint,Lapidus Type
 ;;^UTILITY(U,$J,358.3,10634,1,3,0)
 ;;=3^28300
 ;;^UTILITY(U,$J,358.3,10635,0)
 ;;=28302^^84^652^28^^^^1
 ;;^UTILITY(U,$J,358.3,10635,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10635,1,2,0)
 ;;=2^Osteotomy; talus
 ;;^UTILITY(U,$J,358.3,10635,1,3,0)
 ;;=3^28302
 ;;^UTILITY(U,$J,358.3,10636,0)
 ;;=28304^^84^652^29^^^^1
 ;;^UTILITY(U,$J,358.3,10636,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10636,1,2,0)
 ;;=2^Osteotomy, tarsal bones, other than calcaneus or talus
 ;;^UTILITY(U,$J,358.3,10636,1,3,0)
 ;;=3^28304
 ;;^UTILITY(U,$J,358.3,10637,0)
 ;;=28306^^84^652^30^^^^1
 ;;^UTILITY(U,$J,358.3,10637,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10637,1,2,0)
 ;;=2^Osteotomy, with or without lengthening, shortening or angular correction, metatarsal; 1st metatarsal
 ;;^UTILITY(U,$J,358.3,10637,1,3,0)
 ;;=3^28306
 ;;^UTILITY(U,$J,358.3,10638,0)
 ;;=28308^^84^652^32^^^^1
 ;;^UTILITY(U,$J,358.3,10638,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10638,1,2,0)
 ;;=2^Osteotomy, with or without lengthening, shortening or angular correction, metatarsal; other than first metatarsal, each
 ;;^UTILITY(U,$J,358.3,10638,1,3,0)
 ;;=3^28308
 ;;^UTILITY(U,$J,358.3,10639,0)
 ;;=28315^^84^652^33^^^^1
 ;;^UTILITY(U,$J,358.3,10639,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10639,1,2,0)
 ;;=2^Sesamoidectomy, first toe
 ;;^UTILITY(U,$J,358.3,10639,1,3,0)
 ;;=3^28315
 ;;^UTILITY(U,$J,358.3,10640,0)
 ;;=28001^^84^653^1^^^^1
 ;;^UTILITY(U,$J,358.3,10640,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10640,1,2,0)
 ;;=2^Incision and Drainage, bursa, foot
 ;;^UTILITY(U,$J,358.3,10640,1,3,0)
 ;;=3^28001
 ;;^UTILITY(U,$J,358.3,10641,0)
 ;;=28002^^84^653^2^^^^1
 ;;^UTILITY(U,$J,358.3,10641,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10641,1,2,0)
 ;;=2^Incision and Drainage below fascia, with/without tendon sheath involvement, foot; single bursal space 
 ;;^UTILITY(U,$J,358.3,10641,1,3,0)
 ;;=3^28002
 ;;^UTILITY(U,$J,358.3,10642,0)
 ;;=28003^^84^653^3^^^^1
 ;;^UTILITY(U,$J,358.3,10642,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10642,1,2,0)
 ;;=2^Incision and Drainage below fascia, with/without tendon sheath involvement, foot; multiple areas 
 ;;^UTILITY(U,$J,358.3,10642,1,3,0)
 ;;=3^28003
 ;;^UTILITY(U,$J,358.3,10643,0)
 ;;=28008^^84^653^4^^^^1
 ;;^UTILITY(U,$J,358.3,10643,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10643,1,2,0)
 ;;=2^Fasciotomy, foot and/or toe
 ;;^UTILITY(U,$J,358.3,10643,1,3,0)
 ;;=3^28008
 ;;^UTILITY(U,$J,358.3,10644,0)
 ;;=28010^^84^653^5^^^^1
 ;;^UTILITY(U,$J,358.3,10644,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10644,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; single tendon
 ;;^UTILITY(U,$J,358.3,10644,1,3,0)
 ;;=3^28010
 ;;^UTILITY(U,$J,358.3,10645,0)
 ;;=28011^^84^653^6^^^^1
 ;;^UTILITY(U,$J,358.3,10645,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10645,1,2,0)
 ;;=2^Tenotomy, percutaneous, toe; multiple tendons
 ;;^UTILITY(U,$J,358.3,10645,1,3,0)
 ;;=3^28011
 ;;^UTILITY(U,$J,358.3,10646,0)
 ;;=28020^^84^653^7^^^^1
 ;;^UTILITY(U,$J,358.3,10646,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10646,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; intertarsal or tarsometatarsal joint
 ;;^UTILITY(U,$J,358.3,10646,1,3,0)
 ;;=3^28020
 ;;^UTILITY(U,$J,358.3,10647,0)
 ;;=28022^^84^653^8^^^^1
 ;;^UTILITY(U,$J,358.3,10647,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10647,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; metatarsophalangeal joint 
 ;;^UTILITY(U,$J,358.3,10647,1,3,0)
 ;;=3^28022
 ;;^UTILITY(U,$J,358.3,10648,0)
 ;;=28024^^84^653^9^^^^1
 ;;^UTILITY(U,$J,358.3,10648,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10648,1,2,0)
 ;;=2^Arthrotomy, including exploration, drainage, or removal of loose or foreign body; interphalangeal joint
 ;;^UTILITY(U,$J,358.3,10648,1,3,0)
 ;;=3^28024
 ;;^UTILITY(U,$J,358.3,10649,0)
 ;;=28035^^84^653^11^^^^1
 ;;^UTILITY(U,$J,358.3,10649,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,10649,1,2,0)
 ;;=2^Release, tarsal tunnel
