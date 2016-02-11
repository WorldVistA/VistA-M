IBDEI2KP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43156,1,3,0)
 ;;=3^Benign paroxysmal vertigo, bilateral
 ;;^UTILITY(U,$J,358.3,43156,1,4,0)
 ;;=4^H81.13
 ;;^UTILITY(U,$J,358.3,43156,2)
 ;;=^5006867
 ;;^UTILITY(U,$J,358.3,43157,0)
 ;;=H81.11^^195^2169^6
 ;;^UTILITY(U,$J,358.3,43157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43157,1,3,0)
 ;;=3^Benign paroxysmal vertigo, right ear
 ;;^UTILITY(U,$J,358.3,43157,1,4,0)
 ;;=4^H81.11
 ;;^UTILITY(U,$J,358.3,43157,2)
 ;;=^5006865
 ;;^UTILITY(U,$J,358.3,43158,0)
 ;;=H81.12^^195^2169^5
 ;;^UTILITY(U,$J,358.3,43158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43158,1,3,0)
 ;;=3^Benign paroxysmal vertigo, left ear
 ;;^UTILITY(U,$J,358.3,43158,1,4,0)
 ;;=4^H81.12
 ;;^UTILITY(U,$J,358.3,43158,2)
 ;;=^5006866
 ;;^UTILITY(U,$J,358.3,43159,0)
 ;;=G30.0^^195^2169^1
 ;;^UTILITY(U,$J,358.3,43159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43159,1,3,0)
 ;;=3^Alzheimer's disease w/ early onset
 ;;^UTILITY(U,$J,358.3,43159,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,43159,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,43160,0)
 ;;=G30.1^^195^2169^2
 ;;^UTILITY(U,$J,358.3,43160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43160,1,3,0)
 ;;=3^Alzheimer's disease w/ late onset
 ;;^UTILITY(U,$J,358.3,43160,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,43160,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,43161,0)
 ;;=G43.B0^^195^2170^4
 ;;^UTILITY(U,$J,358.3,43161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43161,1,3,0)
 ;;=3^Ophthalmoplegic migraine, not intractable
 ;;^UTILITY(U,$J,358.3,43161,1,4,0)
 ;;=4^G43.B0
 ;;^UTILITY(U,$J,358.3,43161,2)
 ;;=^5003914
 ;;^UTILITY(U,$J,358.3,43162,0)
 ;;=R51.^^195^2170^1
 ;;^UTILITY(U,$J,358.3,43162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43162,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,43162,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,43162,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,43163,0)
 ;;=G43.909^^195^2170^3
 ;;^UTILITY(U,$J,358.3,43163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43163,1,3,0)
 ;;=3^Migraine, unsp, not intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,43163,1,4,0)
 ;;=4^G43.909
 ;;^UTILITY(U,$J,358.3,43163,2)
 ;;=^5003909
 ;;^UTILITY(U,$J,358.3,43164,0)
 ;;=G43.919^^195^2170^2
 ;;^UTILITY(U,$J,358.3,43164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43164,1,3,0)
 ;;=3^Migraine, unsp, intractable, without status migrainosus
 ;;^UTILITY(U,$J,358.3,43164,1,4,0)
 ;;=4^G43.919
 ;;^UTILITY(U,$J,358.3,43164,2)
 ;;=^5003911
 ;;^UTILITY(U,$J,358.3,43165,0)
 ;;=G44.209^^195^2170^5
 ;;^UTILITY(U,$J,358.3,43165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43165,1,3,0)
 ;;=3^Tension-type headache, unspecified, not intractable
 ;;^UTILITY(U,$J,358.3,43165,1,4,0)
 ;;=4^G44.209
 ;;^UTILITY(U,$J,358.3,43165,2)
 ;;=^5003936
 ;;^UTILITY(U,$J,358.3,43166,0)
 ;;=Z65.5^^195^2171^1
 ;;^UTILITY(U,$J,358.3,43166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43166,1,3,0)
 ;;=3^Exposure to disaster, war and other hostilities
 ;;^UTILITY(U,$J,358.3,43166,1,4,0)
 ;;=4^Z65.5
 ;;^UTILITY(U,$J,358.3,43166,2)
 ;;=^5063184
 ;;^UTILITY(U,$J,358.3,43167,0)
 ;;=Z87.820^^195^2171^2
 ;;^UTILITY(U,$J,358.3,43167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43167,1,3,0)
 ;;=3^Personal history of traumatic brain injury
 ;;^UTILITY(U,$J,358.3,43167,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,43167,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,43168,0)
 ;;=G89.21^^195^2172^11
 ;;^UTILITY(U,$J,358.3,43168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43168,1,3,0)
 ;;=3^Chronic pain due to trauma
 ;;^UTILITY(U,$J,358.3,43168,1,4,0)
 ;;=4^G89.21
 ;;^UTILITY(U,$J,358.3,43168,2)
 ;;=^5004155
