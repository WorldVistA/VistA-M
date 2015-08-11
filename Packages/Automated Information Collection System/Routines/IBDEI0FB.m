IBDEI0FB ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7367,2)
 ;;=Mal Neoplasm, Cranial Nerve^267290
 ;;^UTILITY(U,$J,358.3,7368,0)
 ;;=225.1^^49^557^20
 ;;^UTILITY(U,$J,358.3,7368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7368,1,3,0)
 ;;=3^Cerebral Nerve Neopl,Benign
 ;;^UTILITY(U,$J,358.3,7368,1,4,0)
 ;;=4^225.1
 ;;^UTILITY(U,$J,358.3,7368,2)
 ;;=Benign Neoplasm Cranial Nerve^13298
 ;;^UTILITY(U,$J,358.3,7369,0)
 ;;=346.90^^49^557^47
 ;;^UTILITY(U,$J,358.3,7369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7369,1,3,0)
 ;;=3^Headache,Migraine
 ;;^UTILITY(U,$J,358.3,7369,1,4,0)
 ;;=4^346.90
 ;;^UTILITY(U,$J,358.3,7369,2)
 ;;=Headache, Migraine^293880
 ;;^UTILITY(U,$J,358.3,7370,0)
 ;;=784.0^^49^557^46
 ;;^UTILITY(U,$J,358.3,7370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7370,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,7370,1,4,0)
 ;;=4^784.0
 ;;^UTILITY(U,$J,358.3,7370,2)
 ;;=Headache^54133
 ;;^UTILITY(U,$J,358.3,7371,0)
 ;;=V41.0^^49^557^105
 ;;^UTILITY(U,$J,358.3,7371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7371,1,3,0)
 ;;=3^Problems with Sight
 ;;^UTILITY(U,$J,358.3,7371,1,4,0)
 ;;=4^V41.0
 ;;^UTILITY(U,$J,358.3,7371,2)
 ;;=Problem with sight^295427
 ;;^UTILITY(U,$J,358.3,7372,0)
 ;;=348.2^^49^557^56
 ;;^UTILITY(U,$J,358.3,7372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7372,1,3,0)
 ;;=3^Intracranial Hypertension
 ;;^UTILITY(U,$J,358.3,7372,1,4,0)
 ;;=4^348.2
 ;;^UTILITY(U,$J,358.3,7372,2)
 ;;=Intracranial Hypertension^100293
 ;;^UTILITY(U,$J,358.3,7373,0)
 ;;=378.50^^49^557^78
 ;;^UTILITY(U,$J,358.3,7373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7373,1,3,0)
 ;;=3^Ophthalmoplegia,Unspec
 ;;^UTILITY(U,$J,358.3,7373,1,4,0)
 ;;=4^378.50
 ;;^UTILITY(U,$J,358.3,7373,2)
 ;;=Opthalmoplegia, Unspec^265442
 ;;^UTILITY(U,$J,358.3,7374,0)
 ;;=351.8^^49^557^49
 ;;^UTILITY(U,$J,358.3,7374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7374,1,3,0)
 ;;=3^Hemifacial Spasm
 ;;^UTILITY(U,$J,358.3,7374,1,4,0)
 ;;=4^351.8
 ;;^UTILITY(U,$J,358.3,7374,2)
 ;;=Hemifacial Spasm^87589
 ;;^UTILITY(U,$J,358.3,7375,0)
 ;;=446.5^^49^557^121
 ;;^UTILITY(U,$J,358.3,7375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7375,1,3,0)
 ;;=3^Temporal Arteritis
 ;;^UTILITY(U,$J,358.3,7375,1,4,0)
 ;;=4^446.5
 ;;^UTILITY(U,$J,358.3,7375,2)
 ;;=Giant Cell Arteritis^117658
 ;;^UTILITY(U,$J,358.3,7376,0)
 ;;=378.73^^49^557^75
 ;;^UTILITY(U,$J,358.3,7376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7376,1,3,0)
 ;;=3^Ocular Myasthenia Gravis
 ;;^UTILITY(U,$J,358.3,7376,1,4,0)
 ;;=4^378.73
 ;;^UTILITY(U,$J,358.3,7376,2)
 ;;=Ocular Myasthenia Gravis^269274
 ;;^UTILITY(U,$J,358.3,7377,0)
 ;;=377.24^^49^557^106
 ;;^UTILITY(U,$J,358.3,7377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7377,1,3,0)
 ;;=3^Pseudopapilledema
 ;;^UTILITY(U,$J,358.3,7377,1,4,0)
 ;;=4^377.24
 ;;^UTILITY(U,$J,358.3,7377,2)
 ;;=Pseudopapilledema^269224
 ;;^UTILITY(U,$J,358.3,7378,0)
 ;;=781.0^^49^557^3
 ;;^UTILITY(U,$J,358.3,7378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7378,1,3,0)
 ;;=3^Abnormal Involuntary Movements
 ;;^UTILITY(U,$J,358.3,7378,1,4,0)
 ;;=4^781.0
 ;;^UTILITY(U,$J,358.3,7378,2)
 ;;=Lid Myokymia^23827
 ;;^UTILITY(U,$J,358.3,7379,0)
 ;;=088.81^^49^557^57
 ;;^UTILITY(U,$J,358.3,7379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7379,1,3,0)
 ;;=3^Lyme Anthropoed Borne Disease
 ;;^UTILITY(U,$J,358.3,7379,1,4,0)
 ;;=4^088.81
 ;;^UTILITY(U,$J,358.3,7379,2)
 ;;=^72315
 ;;^UTILITY(U,$J,358.3,7380,0)
 ;;=227.3^^49^557^103
 ;;^UTILITY(U,$J,358.3,7380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7380,1,3,0)
 ;;=3^Pituitary/Craniopharyngeal Neopl,Benign
 ;;^UTILITY(U,$J,358.3,7380,1,4,0)
 ;;=4^227.3
