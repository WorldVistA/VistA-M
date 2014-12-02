IBDEI0H1 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8273,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8273,1,3,0)
 ;;=3^Cranial Nerve Neopl,Malignant
 ;;^UTILITY(U,$J,358.3,8273,1,4,0)
 ;;=4^192.0
 ;;^UTILITY(U,$J,358.3,8273,2)
 ;;=Mal Neoplasm, Cranial Nerve^267290
 ;;^UTILITY(U,$J,358.3,8274,0)
 ;;=225.1^^58^608^20
 ;;^UTILITY(U,$J,358.3,8274,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8274,1,3,0)
 ;;=3^Cerebral Nerve Neopl,Benign
 ;;^UTILITY(U,$J,358.3,8274,1,4,0)
 ;;=4^225.1
 ;;^UTILITY(U,$J,358.3,8274,2)
 ;;=Benign Neoplasm Cranial Nerve^13298
 ;;^UTILITY(U,$J,358.3,8275,0)
 ;;=346.90^^58^608^47
 ;;^UTILITY(U,$J,358.3,8275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8275,1,3,0)
 ;;=3^Headache,Migraine
 ;;^UTILITY(U,$J,358.3,8275,1,4,0)
 ;;=4^346.90
 ;;^UTILITY(U,$J,358.3,8275,2)
 ;;=Headache, Migraine^293880
 ;;^UTILITY(U,$J,358.3,8276,0)
 ;;=784.0^^58^608^46
 ;;^UTILITY(U,$J,358.3,8276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8276,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,8276,1,4,0)
 ;;=4^784.0
 ;;^UTILITY(U,$J,358.3,8276,2)
 ;;=Headache^54133
 ;;^UTILITY(U,$J,358.3,8277,0)
 ;;=V41.0^^58^608^105
 ;;^UTILITY(U,$J,358.3,8277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8277,1,3,0)
 ;;=3^Problems with Sight
 ;;^UTILITY(U,$J,358.3,8277,1,4,0)
 ;;=4^V41.0
 ;;^UTILITY(U,$J,358.3,8277,2)
 ;;=Problem with sight^295427
 ;;^UTILITY(U,$J,358.3,8278,0)
 ;;=348.2^^58^608^56
 ;;^UTILITY(U,$J,358.3,8278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8278,1,3,0)
 ;;=3^Intracranial Hypertension
 ;;^UTILITY(U,$J,358.3,8278,1,4,0)
 ;;=4^348.2
 ;;^UTILITY(U,$J,358.3,8278,2)
 ;;=Intracranial Hypertension^100293
 ;;^UTILITY(U,$J,358.3,8279,0)
 ;;=378.50^^58^608^78
 ;;^UTILITY(U,$J,358.3,8279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8279,1,3,0)
 ;;=3^Ophthalmoplegia,Unspec
 ;;^UTILITY(U,$J,358.3,8279,1,4,0)
 ;;=4^378.50
 ;;^UTILITY(U,$J,358.3,8279,2)
 ;;=Opthalmoplegia, Unspec^265442
 ;;^UTILITY(U,$J,358.3,8280,0)
 ;;=351.8^^58^608^49
 ;;^UTILITY(U,$J,358.3,8280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8280,1,3,0)
 ;;=3^Hemifacial Spasm
 ;;^UTILITY(U,$J,358.3,8280,1,4,0)
 ;;=4^351.8
 ;;^UTILITY(U,$J,358.3,8280,2)
 ;;=Hemifacial Spasm^87589
 ;;^UTILITY(U,$J,358.3,8281,0)
 ;;=446.5^^58^608^121
 ;;^UTILITY(U,$J,358.3,8281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8281,1,3,0)
 ;;=3^Temporal Arteritis
 ;;^UTILITY(U,$J,358.3,8281,1,4,0)
 ;;=4^446.5
 ;;^UTILITY(U,$J,358.3,8281,2)
 ;;=Giant Cell Arteritis^117658
 ;;^UTILITY(U,$J,358.3,8282,0)
 ;;=378.73^^58^608^75
 ;;^UTILITY(U,$J,358.3,8282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8282,1,3,0)
 ;;=3^Ocular Myasthenia Gravis
 ;;^UTILITY(U,$J,358.3,8282,1,4,0)
 ;;=4^378.73
 ;;^UTILITY(U,$J,358.3,8282,2)
 ;;=Ocular Myasthenia Gravis^269274
 ;;^UTILITY(U,$J,358.3,8283,0)
 ;;=377.24^^58^608^106
 ;;^UTILITY(U,$J,358.3,8283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8283,1,3,0)
 ;;=3^Pseudopapilledema
 ;;^UTILITY(U,$J,358.3,8283,1,4,0)
 ;;=4^377.24
 ;;^UTILITY(U,$J,358.3,8283,2)
 ;;=Pseudopapilledema^269224
 ;;^UTILITY(U,$J,358.3,8284,0)
 ;;=781.0^^58^608^3
 ;;^UTILITY(U,$J,358.3,8284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8284,1,3,0)
 ;;=3^Abnormal Involuntary Movements
 ;;^UTILITY(U,$J,358.3,8284,1,4,0)
 ;;=4^781.0
 ;;^UTILITY(U,$J,358.3,8284,2)
 ;;=Lid Myokymia^23827
 ;;^UTILITY(U,$J,358.3,8285,0)
 ;;=088.81^^58^608^57
 ;;^UTILITY(U,$J,358.3,8285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8285,1,3,0)
 ;;=3^Lyme Anthropoed Borne Disease
 ;;^UTILITY(U,$J,358.3,8285,1,4,0)
 ;;=4^088.81
 ;;^UTILITY(U,$J,358.3,8285,2)
 ;;=^72315
 ;;^UTILITY(U,$J,358.3,8286,0)
 ;;=227.3^^58^608^103
