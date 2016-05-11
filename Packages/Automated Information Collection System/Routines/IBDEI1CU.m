IBDEI1CU ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23026,1,3,0)
 ;;=3^Migraine,Not Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,23026,1,4,0)
 ;;=4^G43.809
 ;;^UTILITY(U,$J,358.3,23026,2)
 ;;=^5003901
 ;;^UTILITY(U,$J,358.3,23027,0)
 ;;=G43.B0^^87^988^30
 ;;^UTILITY(U,$J,358.3,23027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23027,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Not Intractable
 ;;^UTILITY(U,$J,358.3,23027,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,23027,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,23028,0)
 ;;=G43.C0^^87^988^17
 ;;^UTILITY(U,$J,358.3,23028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23028,1,3,0)
 ;;=3^Headache Syndromes,Periodic Not Intractable
 ;;^UTILITY(U,$J,358.3,23028,1,4,0)
 ;;=4^G43.C0
 ;;^UTILITY(U,$J,358.3,23028,2)
 ;;=^5003916
 ;;^UTILITY(U,$J,358.3,23029,0)
 ;;=G43.A0^^87^988^8
 ;;^UTILITY(U,$J,358.3,23029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23029,1,3,0)
 ;;=3^Cyclical Vomiting Not Intractable
 ;;^UTILITY(U,$J,358.3,23029,1,4,0)
 ;;=4^G43.A0
 ;;^UTILITY(U,$J,358.3,23029,2)
 ;;=^5003912
 ;;^UTILITY(U,$J,358.3,23030,0)
 ;;=G43.C1^^87^988^16
 ;;^UTILITY(U,$J,358.3,23030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23030,1,3,0)
 ;;=3^Headache Syndromes,Periodic Intractable
 ;;^UTILITY(U,$J,358.3,23030,1,4,0)
 ;;=4^G43.C1
 ;;^UTILITY(U,$J,358.3,23030,2)
 ;;=^5003917
 ;;^UTILITY(U,$J,358.3,23031,0)
 ;;=G43.B1^^87^988^29
 ;;^UTILITY(U,$J,358.3,23031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23031,1,3,0)
 ;;=3^Migraine,Ophthalmoplegic Intractable
 ;;^UTILITY(U,$J,358.3,23031,1,4,0)
 ;;=4^G43.B1
 ;;^UTILITY(U,$J,358.3,23031,2)
 ;;=^5003915
 ;;^UTILITY(U,$J,358.3,23032,0)
 ;;=G43.A1^^87^988^7
 ;;^UTILITY(U,$J,358.3,23032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23032,1,3,0)
 ;;=3^Cyclical Vomiting Intractable
 ;;^UTILITY(U,$J,358.3,23032,1,4,0)
 ;;=4^G43.A1
 ;;^UTILITY(U,$J,358.3,23032,2)
 ;;=^5003913
 ;;^UTILITY(U,$J,358.3,23033,0)
 ;;=G43.819^^87^988^25
 ;;^UTILITY(U,$J,358.3,23033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23033,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Other
 ;;^UTILITY(U,$J,358.3,23033,1,4,0)
 ;;=4^G43.819
 ;;^UTILITY(U,$J,358.3,23033,2)
 ;;=^5003903
 ;;^UTILITY(U,$J,358.3,23034,0)
 ;;=G43.909^^87^988^27
 ;;^UTILITY(U,$J,358.3,23034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23034,1,3,0)
 ;;=3^Migraine Not Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,23034,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,23034,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,23035,0)
 ;;=G43.919^^87^988^26
 ;;^UTILITY(U,$J,358.3,23035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23035,1,3,0)
 ;;=3^Migraine Intractable w/o Status Migrainosus,Unspec
 ;;^UTILITY(U,$J,358.3,23035,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,23035,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,23036,0)
 ;;=G51.0^^87^988^5
 ;;^UTILITY(U,$J,358.3,23036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23036,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,23036,1,4,0)
 ;;=4^G51.0
 ;;^UTILITY(U,$J,358.3,23036,2)
 ;;=^13238
 ;;^UTILITY(U,$J,358.3,23037,0)
 ;;=G57.10^^87^988^22
 ;;^UTILITY(U,$J,358.3,23037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23037,1,3,0)
 ;;=3^Meralgia Paresthetica Lower Limb,Unspec
 ;;^UTILITY(U,$J,358.3,23037,1,4,0)
 ;;=4^G57.10
 ;;^UTILITY(U,$J,358.3,23037,2)
 ;;=^5004041
 ;;^UTILITY(U,$J,358.3,23038,0)
 ;;=G57.12^^87^988^23
 ;;^UTILITY(U,$J,358.3,23038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23038,1,3,0)
 ;;=3^Meralgia Paresthetica,Left Lower Limb
 ;;^UTILITY(U,$J,358.3,23038,1,4,0)
 ;;=4^G57.12
