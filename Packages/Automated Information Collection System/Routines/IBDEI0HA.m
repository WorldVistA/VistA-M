IBDEI0HA ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8359,2)
 ;;=Mal Neoplasm, Cranial Nerve^267290
 ;;^UTILITY(U,$J,358.3,8360,0)
 ;;=225.1^^52^581^20
 ;;^UTILITY(U,$J,358.3,8360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8360,1,3,0)
 ;;=3^Cerebral Nerve Neopl,Benign
 ;;^UTILITY(U,$J,358.3,8360,1,4,0)
 ;;=4^225.1
 ;;^UTILITY(U,$J,358.3,8360,2)
 ;;=Benign Neoplasm Cranial Nerve^13298
 ;;^UTILITY(U,$J,358.3,8361,0)
 ;;=346.90^^52^581^47
 ;;^UTILITY(U,$J,358.3,8361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8361,1,3,0)
 ;;=3^Headache,Migraine
 ;;^UTILITY(U,$J,358.3,8361,1,4,0)
 ;;=4^346.90
 ;;^UTILITY(U,$J,358.3,8361,2)
 ;;=Headache, Migraine^293880
 ;;^UTILITY(U,$J,358.3,8362,0)
 ;;=784.0^^52^581^46
 ;;^UTILITY(U,$J,358.3,8362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8362,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,8362,1,4,0)
 ;;=4^784.0
 ;;^UTILITY(U,$J,358.3,8362,2)
 ;;=Headache^54133
 ;;^UTILITY(U,$J,358.3,8363,0)
 ;;=V41.0^^52^581^105
 ;;^UTILITY(U,$J,358.3,8363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8363,1,3,0)
 ;;=3^Problems with Sight
 ;;^UTILITY(U,$J,358.3,8363,1,4,0)
 ;;=4^V41.0
 ;;^UTILITY(U,$J,358.3,8363,2)
 ;;=Problem with sight^295427
 ;;^UTILITY(U,$J,358.3,8364,0)
 ;;=348.2^^52^581^56
 ;;^UTILITY(U,$J,358.3,8364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8364,1,3,0)
 ;;=3^Intracranial Hypertension
 ;;^UTILITY(U,$J,358.3,8364,1,4,0)
 ;;=4^348.2
 ;;^UTILITY(U,$J,358.3,8364,2)
 ;;=Intracranial Hypertension^100293
 ;;^UTILITY(U,$J,358.3,8365,0)
 ;;=378.50^^52^581^78
 ;;^UTILITY(U,$J,358.3,8365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8365,1,3,0)
 ;;=3^Ophthalmoplegia,Unspec
 ;;^UTILITY(U,$J,358.3,8365,1,4,0)
 ;;=4^378.50
 ;;^UTILITY(U,$J,358.3,8365,2)
 ;;=Opthalmoplegia, Unspec^265442
 ;;^UTILITY(U,$J,358.3,8366,0)
 ;;=351.8^^52^581^49
 ;;^UTILITY(U,$J,358.3,8366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8366,1,3,0)
 ;;=3^Hemifacial Spasm
 ;;^UTILITY(U,$J,358.3,8366,1,4,0)
 ;;=4^351.8
 ;;^UTILITY(U,$J,358.3,8366,2)
 ;;=Hemifacial Spasm^87589
 ;;^UTILITY(U,$J,358.3,8367,0)
 ;;=446.5^^52^581^121
 ;;^UTILITY(U,$J,358.3,8367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8367,1,3,0)
 ;;=3^Temporal Arteritis
 ;;^UTILITY(U,$J,358.3,8367,1,4,0)
 ;;=4^446.5
 ;;^UTILITY(U,$J,358.3,8367,2)
 ;;=Giant Cell Arteritis^117658
 ;;^UTILITY(U,$J,358.3,8368,0)
 ;;=378.73^^52^581^75
 ;;^UTILITY(U,$J,358.3,8368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8368,1,3,0)
 ;;=3^Ocular Myasthenia Gravis
 ;;^UTILITY(U,$J,358.3,8368,1,4,0)
 ;;=4^378.73
 ;;^UTILITY(U,$J,358.3,8368,2)
 ;;=Ocular Myasthenia Gravis^269274
 ;;^UTILITY(U,$J,358.3,8369,0)
 ;;=377.24^^52^581^106
 ;;^UTILITY(U,$J,358.3,8369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8369,1,3,0)
 ;;=3^Pseudopapilledema
 ;;^UTILITY(U,$J,358.3,8369,1,4,0)
 ;;=4^377.24
 ;;^UTILITY(U,$J,358.3,8369,2)
 ;;=Pseudopapilledema^269224
 ;;^UTILITY(U,$J,358.3,8370,0)
 ;;=781.0^^52^581^3
 ;;^UTILITY(U,$J,358.3,8370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8370,1,3,0)
 ;;=3^Abnormal Involuntary Movements
 ;;^UTILITY(U,$J,358.3,8370,1,4,0)
 ;;=4^781.0
 ;;^UTILITY(U,$J,358.3,8370,2)
 ;;=Lid Myokymia^23827
 ;;^UTILITY(U,$J,358.3,8371,0)
 ;;=088.81^^52^581^57
 ;;^UTILITY(U,$J,358.3,8371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8371,1,3,0)
 ;;=3^Lyme Anthropoed Borne Disease
 ;;^UTILITY(U,$J,358.3,8371,1,4,0)
 ;;=4^088.81
 ;;^UTILITY(U,$J,358.3,8371,2)
 ;;=^72315
 ;;^UTILITY(U,$J,358.3,8372,0)
 ;;=227.3^^52^581^103
 ;;^UTILITY(U,$J,358.3,8372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8372,1,3,0)
 ;;=3^Pituitary/Craniopharyngeal Neopl,Benign
 ;;^UTILITY(U,$J,358.3,8372,1,4,0)
 ;;=4^227.3
