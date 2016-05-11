IBDEI1UN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31414,1,2,0)
 ;;=2^Ostectomy, partial, exostectomy or condylectomy, metatarsal head, each metatarsal head
 ;;^UTILITY(U,$J,358.3,31414,1,3,0)
 ;;=3^28288
 ;;^UTILITY(U,$J,358.3,31415,0)
 ;;=28290^^125^1591^5^^^^1
 ;;^UTILITY(U,$J,358.3,31415,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31415,1,2,0)
 ;;=2^Correction, hallux valgus, with or without sesamoidectomy; simple exostectomy
 ;;^UTILITY(U,$J,358.3,31415,1,3,0)
 ;;=3^28290
 ;;^UTILITY(U,$J,358.3,31416,0)
 ;;=28292^^125^1591^22^^^^1
 ;;^UTILITY(U,$J,358.3,31416,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31416,1,2,0)
 ;;=2^Resection of joint by Keller Type
 ;;^UTILITY(U,$J,358.3,31416,1,3,0)
 ;;=3^28292
 ;;^UTILITY(U,$J,358.3,31417,0)
 ;;=28293^^125^1591^25^^^^1
 ;;^UTILITY(U,$J,358.3,31417,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31417,1,2,0)
 ;;=2^Resection of joint with implant
 ;;^UTILITY(U,$J,358.3,31417,1,3,0)
 ;;=3^28293
 ;;^UTILITY(U,$J,358.3,31418,0)
 ;;=28296^^125^1591^26^^^^1
 ;;^UTILITY(U,$J,358.3,31418,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31418,1,2,0)
 ;;=2^Resection of joint with metatarsal osteotomy
 ;;^UTILITY(U,$J,358.3,31418,1,3,0)
 ;;=3^28296
 ;;^UTILITY(U,$J,358.3,31419,0)
 ;;=28298^^125^1591^24^^^^1
 ;;^UTILITY(U,$J,358.3,31419,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31419,1,2,0)
 ;;=2^Resection of joint by Phalanx Osteotomy
 ;;^UTILITY(U,$J,358.3,31419,1,3,0)
 ;;=3^28298
 ;;^UTILITY(U,$J,358.3,31420,0)
 ;;=28299^^125^1591^21^^^^1
 ;;^UTILITY(U,$J,358.3,31420,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31420,1,2,0)
 ;;=2^Resection of joint by Double Osteotomy 
 ;;^UTILITY(U,$J,358.3,31420,1,3,0)
 ;;=3^28299
 ;;^UTILITY(U,$J,358.3,31421,0)
 ;;=28300^^125^1591^23^^^^1
 ;;^UTILITY(U,$J,358.3,31421,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31421,1,2,0)
 ;;=2^Resection of joint by Lapidus Type
 ;;^UTILITY(U,$J,358.3,31421,1,3,0)
 ;;=3^28300
 ;;^UTILITY(U,$J,358.3,31422,0)
 ;;=28302^^125^1591^13^^^^1
 ;;^UTILITY(U,$J,358.3,31422,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31422,1,2,0)
 ;;=2^Osteotomy; talus
 ;;^UTILITY(U,$J,358.3,31422,1,3,0)
 ;;=3^28302
 ;;^UTILITY(U,$J,358.3,31423,0)
 ;;=28304^^125^1591^10^^^^1
 ;;^UTILITY(U,$J,358.3,31423,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31423,1,2,0)
 ;;=2^Osteotomy, tarsal bones, other than calcaneus or talus
 ;;^UTILITY(U,$J,358.3,31423,1,3,0)
 ;;=3^28304
 ;;^UTILITY(U,$J,358.3,31424,0)
 ;;=28306^^125^1591^11^^^^1
 ;;^UTILITY(U,$J,358.3,31424,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31424,1,2,0)
 ;;=2^Osteotomy, with or without lengthening, shortening or angular correction, metatarsal; 1st metatarsal
 ;;^UTILITY(U,$J,358.3,31424,1,3,0)
 ;;=3^28306
 ;;^UTILITY(U,$J,358.3,31425,0)
 ;;=28308^^125^1591^12^^^^1
 ;;^UTILITY(U,$J,358.3,31425,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31425,1,2,0)
 ;;=2^Osteotomy, with or without lengthening, shortening or angular correction, metatarsal; other than first metatarsal, each
 ;;^UTILITY(U,$J,358.3,31425,1,3,0)
 ;;=3^28308
 ;;^UTILITY(U,$J,358.3,31426,0)
 ;;=28315^^125^1591^27^^^^1
 ;;^UTILITY(U,$J,358.3,31426,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31426,1,2,0)
 ;;=2^Sesamoidectomy, first toe
 ;;^UTILITY(U,$J,358.3,31426,1,3,0)
 ;;=3^28315
 ;;^UTILITY(U,$J,358.3,31427,0)
 ;;=28001^^125^1592^1^^^^1
 ;;^UTILITY(U,$J,358.3,31427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,31427,1,2,0)
 ;;=2^Incision and Drainage, bursa, foot
 ;;^UTILITY(U,$J,358.3,31427,1,3,0)
 ;;=3^28001
 ;;^UTILITY(U,$J,358.3,31428,0)
 ;;=28002^^125^1592^2^^^^1
 ;;^UTILITY(U,$J,358.3,31428,1,0)
 ;;=^358.31IA^3^2
