IBDEI11R ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,18760,0)
 ;;=28288^^122^1201^19^^^^1
 ;;^UTILITY(U,$J,358.3,18760,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18760,1,2,0)
 ;;=2^Ostectomy, partial, exostectomy or condylectomy, metatarsal head, each metatarsal head
 ;;^UTILITY(U,$J,358.3,18760,1,3,0)
 ;;=3^28288
 ;;^UTILITY(U,$J,358.3,18761,0)
 ;;=28290^^122^1201^20^^^^1
 ;;^UTILITY(U,$J,358.3,18761,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18761,1,2,0)
 ;;=2^Correction, hallux valgus, with or without sesamoidectomy; simple exostectomy
 ;;^UTILITY(U,$J,358.3,18761,1,3,0)
 ;;=3^28290
 ;;^UTILITY(U,$J,358.3,18762,0)
 ;;=28292^^122^1201^21^^^^1
 ;;^UTILITY(U,$J,358.3,18762,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18762,1,2,0)
 ;;=2^Resection of Joint by Keller Type
 ;;^UTILITY(U,$J,358.3,18762,1,3,0)
 ;;=3^28292
 ;;^UTILITY(U,$J,358.3,18763,0)
 ;;=28293^^122^1201^22^^^^1
 ;;^UTILITY(U,$J,358.3,18763,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18763,1,2,0)
 ;;=2^Resection of joint with implant
 ;;^UTILITY(U,$J,358.3,18763,1,3,0)
 ;;=3^28293
 ;;^UTILITY(U,$J,358.3,18764,0)
 ;;=28296^^122^1201^23^^^^1
 ;;^UTILITY(U,$J,358.3,18764,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18764,1,2,0)
 ;;=2^Resection of joint with metatarsal osteotomy
 ;;^UTILITY(U,$J,358.3,18764,1,3,0)
 ;;=3^28296
 ;;^UTILITY(U,$J,358.3,18765,0)
 ;;=28298^^122^1201^25^^^^1
 ;;^UTILITY(U,$J,358.3,18765,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18765,1,2,0)
 ;;=2^Resection of joint by phalanx osteotomy
 ;;^UTILITY(U,$J,358.3,18765,1,3,0)
 ;;=3^28298
 ;;^UTILITY(U,$J,358.3,18766,0)
 ;;=28299^^122^1201^26^^^^1
 ;;^UTILITY(U,$J,358.3,18766,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18766,1,2,0)
 ;;=2^Resection of joint by double osteotomy 
 ;;^UTILITY(U,$J,358.3,18766,1,3,0)
 ;;=3^28299
 ;;^UTILITY(U,$J,358.3,18767,0)
 ;;=28300^^122^1201^27^^^^1
 ;;^UTILITY(U,$J,358.3,18767,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18767,1,2,0)
 ;;=2^Resection of joint,Lapidus Type
 ;;^UTILITY(U,$J,358.3,18767,1,3,0)
 ;;=3^28300
 ;;^UTILITY(U,$J,358.3,18768,0)
 ;;=28302^^122^1201^28^^^^1
 ;;^UTILITY(U,$J,358.3,18768,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18768,1,2,0)
 ;;=2^Osteotomy; talus
 ;;^UTILITY(U,$J,358.3,18768,1,3,0)
 ;;=3^28302
 ;;^UTILITY(U,$J,358.3,18769,0)
 ;;=28304^^122^1201^29^^^^1
 ;;^UTILITY(U,$J,358.3,18769,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18769,1,2,0)
 ;;=2^Osteotomy, tarsal bones, other than calcaneus or talus
 ;;^UTILITY(U,$J,358.3,18769,1,3,0)
 ;;=3^28304
 ;;^UTILITY(U,$J,358.3,18770,0)
 ;;=28306^^122^1201^30^^^^1
 ;;^UTILITY(U,$J,358.3,18770,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18770,1,2,0)
 ;;=2^Osteotomy, with or without lengthening, shortening or angular correction, metatarsal; 1st metatarsal
 ;;^UTILITY(U,$J,358.3,18770,1,3,0)
 ;;=3^28306
 ;;^UTILITY(U,$J,358.3,18771,0)
 ;;=28308^^122^1201^32^^^^1
 ;;^UTILITY(U,$J,358.3,18771,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18771,1,2,0)
 ;;=2^Osteotomy, with or without lengthening, shortening or angular correction, metatarsal; other than first metatarsal, each
 ;;^UTILITY(U,$J,358.3,18771,1,3,0)
 ;;=3^28308
 ;;^UTILITY(U,$J,358.3,18772,0)
 ;;=28315^^122^1201^33^^^^1
 ;;^UTILITY(U,$J,358.3,18772,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18772,1,2,0)
 ;;=2^Sesamoidectomy, first toe
 ;;^UTILITY(U,$J,358.3,18772,1,3,0)
 ;;=3^28315
 ;;^UTILITY(U,$J,358.3,18773,0)
 ;;=28001^^122^1202^1^^^^1
 ;;^UTILITY(U,$J,358.3,18773,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,18773,1,2,0)
 ;;=2^Incision and Drainage, bursa, foot
 ;;^UTILITY(U,$J,358.3,18773,1,3,0)
 ;;=3^28001
