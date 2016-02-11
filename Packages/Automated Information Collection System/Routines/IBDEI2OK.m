IBDEI2OK ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44982,1,3,0)
 ;;=3^Collapsed Vertabra,Cervical Region,Subs Encntr,Sequela
 ;;^UTILITY(U,$J,358.3,44982,1,4,0)
 ;;=4^M48.52XS
 ;;^UTILITY(U,$J,358.3,44982,2)
 ;;=^5012170
 ;;^UTILITY(U,$J,358.3,44983,0)
 ;;=M48.57XG^^200^2234^27
 ;;^UTILITY(U,$J,358.3,44983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44983,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Del Healing
 ;;^UTILITY(U,$J,358.3,44983,1,4,0)
 ;;=4^M48.57XG
 ;;^UTILITY(U,$J,358.3,44983,2)
 ;;=^5012189
 ;;^UTILITY(U,$J,358.3,44984,0)
 ;;=M48.57XS^^200^2234^28
 ;;^UTILITY(U,$J,358.3,44984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44984,1,3,0)
 ;;=3^Collapsed Vertebra,Lumbosacral Region,Subs Encntr,Sequela
 ;;^UTILITY(U,$J,358.3,44984,1,4,0)
 ;;=4^M48.57XS
 ;;^UTILITY(U,$J,358.3,44984,2)
 ;;=^5012190
 ;;^UTILITY(U,$J,358.3,44985,0)
 ;;=M48.54XD^^200^2234^29
 ;;^UTILITY(U,$J,358.3,44985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44985,1,3,0)
 ;;=3^Collapsed Vertebra,Thoracic Region,Subs Encntr,Rt Healing
 ;;^UTILITY(U,$J,358.3,44985,1,4,0)
 ;;=4^M48.54XD
 ;;^UTILITY(U,$J,358.3,44985,2)
 ;;=^5012176
 ;;^UTILITY(U,$J,358.3,44986,0)
 ;;=M48.57XG^^200^2234^30
 ;;^UTILITY(U,$J,358.3,44986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44986,1,3,0)
 ;;=3^Collapsed Vertebra,Thoracic Region,Subs Encntr,Del Healing
 ;;^UTILITY(U,$J,358.3,44986,1,4,0)
 ;;=4^M48.57XG
 ;;^UTILITY(U,$J,358.3,44986,2)
 ;;=^5012189
 ;;^UTILITY(U,$J,358.3,44987,0)
 ;;=M48.54XS^^200^2234^31
 ;;^UTILITY(U,$J,358.3,44987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44987,1,3,0)
 ;;=3^Collapsed Vertebra,Thoracic Region,Subs Encntr,Sequela
 ;;^UTILITY(U,$J,358.3,44987,1,4,0)
 ;;=4^M48.54XS
 ;;^UTILITY(U,$J,358.3,44987,2)
 ;;=^5012178
 ;;^UTILITY(U,$J,358.3,44988,0)
 ;;=M62.830^^200^2234^59
 ;;^UTILITY(U,$J,358.3,44988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44988,1,3,0)
 ;;=3^Muscle Spasm of Back
 ;;^UTILITY(U,$J,358.3,44988,1,4,0)
 ;;=4^M62.830
 ;;^UTILITY(U,$J,358.3,44988,2)
 ;;=^5012680
 ;;^UTILITY(U,$J,358.3,44989,0)
 ;;=M19.92^^200^2234^103
 ;;^UTILITY(U,$J,358.3,44989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44989,1,3,0)
 ;;=3^Post-Traumatic Osteoarthritis,Unspec Site
 ;;^UTILITY(U,$J,358.3,44989,1,4,0)
 ;;=4^M19.92
 ;;^UTILITY(U,$J,358.3,44989,2)
 ;;=^5010855
 ;;^UTILITY(U,$J,358.3,44990,0)
 ;;=B02.0^^200^2235^41
 ;;^UTILITY(U,$J,358.3,44990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44990,1,3,0)
 ;;=3^Zoster Encephalitis
 ;;^UTILITY(U,$J,358.3,44990,1,4,0)
 ;;=4^B02.0
 ;;^UTILITY(U,$J,358.3,44990,2)
 ;;=^5000488
 ;;^UTILITY(U,$J,358.3,44991,0)
 ;;=B02.29^^200^2235^34
 ;;^UTILITY(U,$J,358.3,44991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44991,1,3,0)
 ;;=3^Postherpetic Nervous System Involvement,Other
 ;;^UTILITY(U,$J,358.3,44991,1,4,0)
 ;;=4^B02.29
 ;;^UTILITY(U,$J,358.3,44991,2)
 ;;=^5000492
 ;;^UTILITY(U,$J,358.3,44992,0)
 ;;=F03.90^^200^2235^10
 ;;^UTILITY(U,$J,358.3,44992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44992,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,44992,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,44992,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,44993,0)
 ;;=F03.91^^200^2235^9
 ;;^UTILITY(U,$J,358.3,44993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44993,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,44993,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,44993,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,44994,0)
 ;;=F01.50^^200^2235^12
 ;;^UTILITY(U,$J,358.3,44994,1,0)
 ;;=^358.31IA^4^2
