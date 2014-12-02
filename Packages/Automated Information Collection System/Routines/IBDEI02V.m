IBDEI02V ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,960,0)
 ;;=92541^^12^106^8^^^^1
 ;;^UTILITY(U,$J,358.3,960,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,960,1,2,0)
 ;;=2^92541
 ;;^UTILITY(U,$J,358.3,960,1,3,0)
 ;;=3^Spontaneous Nystagmus Test W/Recording
 ;;^UTILITY(U,$J,358.3,961,0)
 ;;=92540^^12^106^1^^^^1
 ;;^UTILITY(U,$J,358.3,961,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,961,1,2,0)
 ;;=2^92540
 ;;^UTILITY(U,$J,358.3,961,1,3,0)
 ;;=3^Basic Vestibular Eval w/Recordings
 ;;^UTILITY(U,$J,358.3,962,0)
 ;;=92531^^12^107^1^^^^1
 ;;^UTILITY(U,$J,358.3,962,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,962,1,2,0)
 ;;=2^92531
 ;;^UTILITY(U,$J,358.3,962,1,3,0)
 ;;=3^Spontaneous Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,963,0)
 ;;=92532^^12^107^2^^^^1
 ;;^UTILITY(U,$J,358.3,963,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,963,1,2,0)
 ;;=2^92532
 ;;^UTILITY(U,$J,358.3,963,1,3,0)
 ;;=3^Positional Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,964,0)
 ;;=92533^^12^107^3^^^^1
 ;;^UTILITY(U,$J,358.3,964,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,964,1,2,0)
 ;;=2^92533
 ;;^UTILITY(U,$J,358.3,964,1,3,0)
 ;;=3^Caloric Vestibular Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,965,0)
 ;;=92534^^12^107^4^^^^1
 ;;^UTILITY(U,$J,358.3,965,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,965,1,2,0)
 ;;=2^92534
 ;;^UTILITY(U,$J,358.3,965,1,3,0)
 ;;=3^Opokinetic Nystagmus Test, W/O Recording
 ;;^UTILITY(U,$J,358.3,966,0)
 ;;=98960^^12^108^1^^^^1
 ;;^UTILITY(U,$J,358.3,966,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,966,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,966,1,3,0)
 ;;=3^Education & Training, Individual
 ;;^UTILITY(U,$J,358.3,967,0)
 ;;=98961^^12^108^2^^^^1
 ;;^UTILITY(U,$J,358.3,967,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,967,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,967,1,3,0)
 ;;=3^Education & Training,2-4 Patients
 ;;^UTILITY(U,$J,358.3,968,0)
 ;;=98962^^12^108^3^^^^1
 ;;^UTILITY(U,$J,358.3,968,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,968,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,968,1,3,0)
 ;;=3^Education & Training,5-8 Patients
 ;;^UTILITY(U,$J,358.3,969,0)
 ;;=V5011^^12^108^4^^^^1
 ;;^UTILITY(U,$J,358.3,969,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,969,1,2,0)
 ;;=2^V5011
 ;;^UTILITY(U,$J,358.3,969,1,3,0)
 ;;=3^Hearing Aid Fitting/Checking
 ;;^UTILITY(U,$J,358.3,970,0)
 ;;=V5030^^12^109^29^^^^1
 ;;^UTILITY(U,$J,358.3,970,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,970,1,2,0)
 ;;=2^V5030
 ;;^UTILITY(U,$J,358.3,970,1,3,0)
 ;;=3^HA,Monaural,Body Worn
 ;;^UTILITY(U,$J,358.3,971,0)
 ;;=V5040^^12^109^30^^^^1
 ;;^UTILITY(U,$J,358.3,971,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,971,1,2,0)
 ;;=2^V5040
 ;;^UTILITY(U,$J,358.3,971,1,3,0)
 ;;=3^HA,Monaural,Body Worn,Bone Conduction
 ;;^UTILITY(U,$J,358.3,972,0)
 ;;=V5050^^12^109^32^^^^1
 ;;^UTILITY(U,$J,358.3,972,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,972,1,2,0)
 ;;=2^V5050
 ;;^UTILITY(U,$J,358.3,972,1,3,0)
 ;;=3^HA,Monaural,In Ear
 ;;^UTILITY(U,$J,358.3,973,0)
 ;;=V5060^^12^109^28^^^^1
 ;;^UTILITY(U,$J,358.3,973,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,973,1,2,0)
 ;;=2^V5060
 ;;^UTILITY(U,$J,358.3,973,1,3,0)
 ;;=3^HA,Monaural,Behind Ear
 ;;^UTILITY(U,$J,358.3,974,0)
 ;;=V5100^^12^109^11^^^^1
 ;;^UTILITY(U,$J,358.3,974,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,974,1,2,0)
 ;;=2^V5100
 ;;^UTILITY(U,$J,358.3,974,1,3,0)
 ;;=3^HA,Bilateral,Body Worn
 ;;^UTILITY(U,$J,358.3,975,0)
 ;;=V5120^^12^109^13^^^^1
 ;;^UTILITY(U,$J,358.3,975,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,975,1,2,0)
 ;;=2^V5120
 ;;^UTILITY(U,$J,358.3,975,1,3,0)
 ;;=3^HA,Binaural,Body Worn
