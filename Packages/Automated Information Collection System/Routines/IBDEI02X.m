IBDEI02X ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,992,1,3,0)
 ;;=3^HA,Digital Analog,Monaural,Behind Ear
 ;;^UTILITY(U,$J,358.3,993,0)
 ;;=V5248^^12^109^4^^^^1
 ;;^UTILITY(U,$J,358.3,993,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,993,1,2,0)
 ;;=2^V5248
 ;;^UTILITY(U,$J,358.3,993,1,3,0)
 ;;=3^HA,Analog,Binaural,CIC
 ;;^UTILITY(U,$J,358.3,994,0)
 ;;=V5249^^12^109^5^^^^1
 ;;^UTILITY(U,$J,358.3,994,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,994,1,2,0)
 ;;=2^V5249
 ;;^UTILITY(U,$J,358.3,994,1,3,0)
 ;;=3^HA,Analog,Binaural,ITC
 ;;^UTILITY(U,$J,358.3,995,0)
 ;;=V5250^^12^109^19^^^^1
 ;;^UTILITY(U,$J,358.3,995,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,995,1,2,0)
 ;;=2^V5250
 ;;^UTILITY(U,$J,358.3,995,1,3,0)
 ;;=3^HA,Digital Analog,Binaural,CIC
 ;;^UTILITY(U,$J,358.3,996,0)
 ;;=V5253^^12^109^21^^^^1
 ;;^UTILITY(U,$J,358.3,996,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,996,1,2,0)
 ;;=2^V5253
 ;;^UTILITY(U,$J,358.3,996,1,3,0)
 ;;=3^HA,Digital Analog,Monaural,CIC
 ;;^UTILITY(U,$J,358.3,997,0)
 ;;=V5254^^12^109^25^^^^1
 ;;^UTILITY(U,$J,358.3,997,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,997,1,2,0)
 ;;=2^V5254
 ;;^UTILITY(U,$J,358.3,997,1,3,0)
 ;;=3^HA,Digital,Monaural,CIC
 ;;^UTILITY(U,$J,358.3,998,0)
 ;;=V5258^^12^109^23^^^^1
 ;;^UTILITY(U,$J,358.3,998,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,998,1,2,0)
 ;;=2^V5258
 ;;^UTILITY(U,$J,358.3,998,1,3,0)
 ;;=3^HA,Digital,Binaural,CIC
 ;;^UTILITY(U,$J,358.3,999,0)
 ;;=V5259^^12^109^24^^^^1
 ;;^UTILITY(U,$J,358.3,999,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,999,1,2,0)
 ;;=2^V5259
 ;;^UTILITY(U,$J,358.3,999,1,3,0)
 ;;=3^HA,Digital,Binaural,ITC
 ;;^UTILITY(U,$J,358.3,1000,0)
 ;;=V5262^^12^109^27^^^^1
 ;;^UTILITY(U,$J,358.3,1000,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1000,1,2,0)
 ;;=2^V5262
 ;;^UTILITY(U,$J,358.3,1000,1,3,0)
 ;;=3^HA,Disposable,Monaural
 ;;^UTILITY(U,$J,358.3,1001,0)
 ;;=V5263^^12^109^26^^^^1
 ;;^UTILITY(U,$J,358.3,1001,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1001,1,2,0)
 ;;=2^V5263
 ;;^UTILITY(U,$J,358.3,1001,1,3,0)
 ;;=3^HA,Disposable,Binaural
 ;;^UTILITY(U,$J,358.3,1002,0)
 ;;=V5266^^12^109^34^^^^1
 ;;^UTILITY(U,$J,358.3,1002,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1002,1,2,0)
 ;;=2^V5266
 ;;^UTILITY(U,$J,358.3,1002,1,3,0)
 ;;=3^Hearing Aid Battery
 ;;^UTILITY(U,$J,358.3,1003,0)
 ;;=V5274^^12^109^1^^^^1
 ;;^UTILITY(U,$J,358.3,1003,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1003,1,2,0)
 ;;=2^V5274
 ;;^UTILITY(U,$J,358.3,1003,1,3,0)
 ;;=3^Assistive Listening Device
 ;;^UTILITY(U,$J,358.3,1004,0)
 ;;=92626^^12^110^3^^^^1
 ;;^UTILITY(U,$J,358.3,1004,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1004,1,2,0)
 ;;=2^92626
 ;;^UTILITY(U,$J,358.3,1004,1,3,0)
 ;;=3^Eval of Auditory Rehab Status,1st Hr
 ;;^UTILITY(U,$J,358.3,1005,0)
 ;;=92627^^12^110^4^^^^1
 ;;^UTILITY(U,$J,358.3,1005,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1005,1,2,0)
 ;;=2^92627
 ;;^UTILITY(U,$J,358.3,1005,1,3,0)
 ;;=3^Eval of Auditory Rehab Status,Ea Addl 15min
 ;;^UTILITY(U,$J,358.3,1006,0)
 ;;=92630^^12^110^1^^^^1
 ;;^UTILITY(U,$J,358.3,1006,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1006,1,2,0)
 ;;=2^92630
 ;;^UTILITY(U,$J,358.3,1006,1,3,0)
 ;;=3^Auditory Rehab;Prelingual Hearing Loss
 ;;^UTILITY(U,$J,358.3,1007,0)
 ;;=92633^^12^110^2^^^^1
 ;;^UTILITY(U,$J,358.3,1007,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1007,1,2,0)
 ;;=2^92633
 ;;^UTILITY(U,$J,358.3,1007,1,3,0)
 ;;=3^Auditory Rehab;Postlingual Hearing Loss
 ;;^UTILITY(U,$J,358.3,1008,0)
 ;;=92625^^12^110^5^^^^1
 ;;^UTILITY(U,$J,358.3,1008,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,1008,1,2,0)
 ;;=2^92625
