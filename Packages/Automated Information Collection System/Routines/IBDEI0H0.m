IBDEI0H0 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8259,2)
 ;;=Optic Neuropathy, Ischemic^269231
 ;;^UTILITY(U,$J,358.3,8260,0)
 ;;=377.21^^58^608^33
 ;;^UTILITY(U,$J,358.3,8260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8260,1,3,0)
 ;;=3^Drusen (ONH)
 ;;^UTILITY(U,$J,358.3,8260,1,4,0)
 ;;=4^377.21
 ;;^UTILITY(U,$J,358.3,8260,2)
 ;;=^269221
 ;;^UTILITY(U,$J,358.3,8261,0)
 ;;=377.10^^58^608^79
 ;;^UTILITY(U,$J,358.3,8261,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8261,1,3,0)
 ;;=3^Optic Atrophy
 ;;^UTILITY(U,$J,358.3,8261,1,4,0)
 ;;=4^377.10
 ;;^UTILITY(U,$J,358.3,8261,2)
 ;;=^85926
 ;;^UTILITY(U,$J,358.3,8262,0)
 ;;=377.30^^58^608^90
 ;;^UTILITY(U,$J,358.3,8262,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8262,1,3,0)
 ;;=3^Optic Neuritis,Unspec
 ;;^UTILITY(U,$J,358.3,8262,1,4,0)
 ;;=4^377.30
 ;;^UTILITY(U,$J,358.3,8262,2)
 ;;=^86002
 ;;^UTILITY(U,$J,358.3,8263,0)
 ;;=377.01^^58^608^96
 ;;^UTILITY(U,$J,358.3,8263,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8263,1,3,0)
 ;;=3^Papilledema
 ;;^UTILITY(U,$J,358.3,8263,1,4,0)
 ;;=4^377.01
 ;;^UTILITY(U,$J,358.3,8263,2)
 ;;=Papilledema Associated with Increased Intracranial Pressure^269212
 ;;^UTILITY(U,$J,358.3,8264,0)
 ;;=379.40^^58^608^107
 ;;^UTILITY(U,$J,358.3,8264,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8264,1,3,0)
 ;;=3^Pupil, Abnormal Function
 ;;^UTILITY(U,$J,358.3,8264,1,4,0)
 ;;=4^379.40
 ;;^UTILITY(U,$J,358.3,8264,2)
 ;;=Pupil, Abnormal Function^101288
 ;;^UTILITY(U,$J,358.3,8265,0)
 ;;=362.34^^58^608^6
 ;;^UTILITY(U,$J,358.3,8265,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8265,1,3,0)
 ;;=3^Amaurosis Fugax
 ;;^UTILITY(U,$J,358.3,8265,1,4,0)
 ;;=4^362.34
 ;;^UTILITY(U,$J,358.3,8265,2)
 ;;=Amaurosis Fugax^268622
 ;;^UTILITY(U,$J,358.3,8266,0)
 ;;=351.0^^58^608^12
 ;;^UTILITY(U,$J,358.3,8266,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8266,1,3,0)
 ;;=3^Bell's Palsy
 ;;^UTILITY(U,$J,358.3,8266,1,4,0)
 ;;=4^351.0
 ;;^UTILITY(U,$J,358.3,8266,2)
 ;;=Bell's Palsy^13238
 ;;^UTILITY(U,$J,358.3,8267,0)
 ;;=333.81^^58^608^13
 ;;^UTILITY(U,$J,358.3,8267,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8267,1,3,0)
 ;;=3^Blepharospasm
 ;;^UTILITY(U,$J,358.3,8267,1,4,0)
 ;;=4^333.81
 ;;^UTILITY(U,$J,358.3,8267,2)
 ;;=Blepharospasm^15293
 ;;^UTILITY(U,$J,358.3,8268,0)
 ;;=437.9^^58^608^21
 ;;^UTILITY(U,$J,358.3,8268,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8268,1,3,0)
 ;;=3^Cerebrovascular Dis
 ;;^UTILITY(U,$J,358.3,8268,1,4,0)
 ;;=4^437.9
 ;;^UTILITY(U,$J,358.3,8268,2)
 ;;=Cerebrovascular Dis^21803
 ;;^UTILITY(U,$J,358.3,8269,0)
 ;;=368.2^^58^608^29
 ;;^UTILITY(U,$J,358.3,8269,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8269,1,3,0)
 ;;=3^Diplopia
 ;;^UTILITY(U,$J,358.3,8269,1,4,0)
 ;;=4^368.2
 ;;^UTILITY(U,$J,358.3,8269,2)
 ;;=Diplopia^35208
 ;;^UTILITY(U,$J,358.3,8270,0)
 ;;=350.9^^58^608^38
 ;;^UTILITY(U,$J,358.3,8270,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8270,1,3,0)
 ;;=3^Fifth Nerve Paresis
 ;;^UTILITY(U,$J,358.3,8270,1,4,0)
 ;;=4^350.9
 ;;^UTILITY(U,$J,358.3,8270,2)
 ;;=Fifth Nerve Palsy^265329
 ;;^UTILITY(U,$J,358.3,8271,0)
 ;;=379.50^^58^608^72
 ;;^UTILITY(U,$J,358.3,8271,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8271,1,3,0)
 ;;=3^Nystagmus,Unspec
 ;;^UTILITY(U,$J,358.3,8271,1,4,0)
 ;;=4^379.50
 ;;^UTILITY(U,$J,358.3,8271,2)
 ;;=Nystagmus^84761
 ;;^UTILITY(U,$J,358.3,8272,0)
 ;;=802.6^^58^608^95
 ;;^UTILITY(U,$J,358.3,8272,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8272,1,3,0)
 ;;=3^Orbital Floor Fracture
 ;;^UTILITY(U,$J,358.3,8272,1,4,0)
 ;;=4^802.6
 ;;^UTILITY(U,$J,358.3,8272,2)
 ;;=Orbital Floor Fracture^273684
 ;;^UTILITY(U,$J,358.3,8273,0)
 ;;=192.0^^58^608^26
