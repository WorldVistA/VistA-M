IBDEI0FH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7140,2)
 ;;=^5013351
 ;;^UTILITY(U,$J,358.3,7141,0)
 ;;=M54.9^^30^402^8
 ;;^UTILITY(U,$J,358.3,7141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7141,1,3,0)
 ;;=3^Backache/Dorsalgia
 ;;^UTILITY(U,$J,358.3,7141,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,7141,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,7142,0)
 ;;=M48.52XG^^30^402^19
 ;;^UTILITY(U,$J,358.3,7142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7142,1,3,0)
 ;;=3^Collapsed Vertabra,Cervical Region,Subs Encntr,Del Healing
 ;;^UTILITY(U,$J,358.3,7142,1,4,0)
 ;;=4^M48.52XG
 ;;^UTILITY(U,$J,358.3,7142,2)
 ;;=^5012169
 ;;^UTILITY(U,$J,358.3,7143,0)
 ;;=M48.52XS^^30^402^20
 ;;^UTILITY(U,$J,358.3,7143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7143,1,3,0)
 ;;=3^Collapsed Vertabra,Cervical Region,Subs Encntr,Sequela
 ;;^UTILITY(U,$J,358.3,7143,1,4,0)
 ;;=4^M48.52XS
 ;;^UTILITY(U,$J,358.3,7143,2)
 ;;=^5012170
 ;;^UTILITY(U,$J,358.3,7144,0)
 ;;=M48.57XG^^30^402^27
 ;;^UTILITY(U,$J,358.3,7144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7144,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Del Healing
 ;;^UTILITY(U,$J,358.3,7144,1,4,0)
 ;;=4^M48.57XG
 ;;^UTILITY(U,$J,358.3,7144,2)
 ;;=^5012189
 ;;^UTILITY(U,$J,358.3,7145,0)
 ;;=M48.57XS^^30^402^28
 ;;^UTILITY(U,$J,358.3,7145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7145,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Sequela
 ;;^UTILITY(U,$J,358.3,7145,1,4,0)
 ;;=4^M48.57XS
 ;;^UTILITY(U,$J,358.3,7145,2)
 ;;=^5012190
 ;;^UTILITY(U,$J,358.3,7146,0)
 ;;=M48.54XD^^30^402^29
 ;;^UTILITY(U,$J,358.3,7146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7146,1,3,0)
 ;;=3^Collapsed Vertebra,Thoracic Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,7146,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,7146,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,7147,0)
 ;;=M48.57XG^^30^402^30
 ;;^UTILITY(U,$J,358.3,7147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7147,1,3,0)
 ;;=3^Collapsed Vertebra,Thoracic Region,Subs Encntr,Del Healing
 ;;^UTILITY(U,$J,358.3,7147,1,4,0)
 ;;=4^M48.57XG
 ;;^UTILITY(U,$J,358.3,7147,2)
 ;;=^5012189
 ;;^UTILITY(U,$J,358.3,7148,0)
 ;;=M48.54XS^^30^402^31
 ;;^UTILITY(U,$J,358.3,7148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7148,1,3,0)
 ;;=3^Collapsed Vertebra,Thoracic Region,Subs Encntr,Sequela
 ;;^UTILITY(U,$J,358.3,7148,1,4,0)
 ;;=4^M48.54XS
 ;;^UTILITY(U,$J,358.3,7148,2)
 ;;=^5012178
 ;;^UTILITY(U,$J,358.3,7149,0)
 ;;=M62.830^^30^402^59
 ;;^UTILITY(U,$J,358.3,7149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7149,1,3,0)
 ;;=3^Muscle Spasm of Back
 ;;^UTILITY(U,$J,358.3,7149,1,4,0)
 ;;=4^M62.830
 ;;^UTILITY(U,$J,358.3,7149,2)
 ;;=^5012680
 ;;^UTILITY(U,$J,358.3,7150,0)
 ;;=M19.92^^30^402^111
 ;;^UTILITY(U,$J,358.3,7150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7150,1,3,0)
 ;;=3^Post-Traumatic Osteoarthritis,Unspec Site
 ;;^UTILITY(U,$J,358.3,7150,1,4,0)
 ;;=4^M19.92
 ;;^UTILITY(U,$J,358.3,7150,2)
 ;;=^5010855
 ;;^UTILITY(U,$J,358.3,7151,0)
 ;;=M79.632^^30^402^84
 ;;^UTILITY(U,$J,358.3,7151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7151,1,3,0)
 ;;=3^Pain in Left Forearm
 ;;^UTILITY(U,$J,358.3,7151,1,4,0)
 ;;=4^M79.632
 ;;^UTILITY(U,$J,358.3,7151,2)
 ;;=^5013336
 ;;^UTILITY(U,$J,358.3,7152,0)
 ;;=M79.662^^30^402^89
 ;;^UTILITY(U,$J,358.3,7152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7152,1,3,0)
 ;;=3^Pain in Left Lower Leg
 ;;^UTILITY(U,$J,358.3,7152,1,4,0)
 ;;=4^M79.662
 ;;^UTILITY(U,$J,358.3,7152,2)
 ;;=^5013348
 ;;^UTILITY(U,$J,358.3,7153,0)
 ;;=M79.652^^30^402^91
 ;;^UTILITY(U,$J,358.3,7153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7153,1,3,0)
 ;;=3^Pain in Left Thigh
