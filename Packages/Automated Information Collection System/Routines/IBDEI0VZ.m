IBDEI0VZ ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15814,1,2,0)
 ;;=2^20552
 ;;^UTILITY(U,$J,358.3,15814,1,3,0)
 ;;=3^Trigger Point, 1 or 2 muscles
 ;;^UTILITY(U,$J,358.3,15815,0)
 ;;=20553^^99^976^27^^^^1
 ;;^UTILITY(U,$J,358.3,15815,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15815,1,2,0)
 ;;=2^20553
 ;;^UTILITY(U,$J,358.3,15815,1,3,0)
 ;;=3^Trigger Point, 3 or more muscles
 ;;^UTILITY(U,$J,358.3,15816,0)
 ;;=20612^^99^976^14^^^^1
 ;;^UTILITY(U,$J,358.3,15816,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15816,1,2,0)
 ;;=2^20612
 ;;^UTILITY(U,$J,358.3,15816,1,3,0)
 ;;=3^Ganglion Cyst Aspriation/Injection
 ;;^UTILITY(U,$J,358.3,15817,0)
 ;;=64550^^99^976^23^^^^1
 ;;^UTILITY(U,$J,358.3,15817,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15817,1,2,0)
 ;;=2^64550
 ;;^UTILITY(U,$J,358.3,15817,1,3,0)
 ;;=3^TENS Device Training and Issue
 ;;^UTILITY(U,$J,358.3,15818,0)
 ;;=64450^^99^976^16^^^^1
 ;;^UTILITY(U,$J,358.3,15818,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15818,1,2,0)
 ;;=2^64450
 ;;^UTILITY(U,$J,358.3,15818,1,3,0)
 ;;=3^Nerve Block, peripheral nerve
 ;;^UTILITY(U,$J,358.3,15819,0)
 ;;=95990^^99^976^20^^^^1
 ;;^UTILITY(U,$J,358.3,15819,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15819,1,2,0)
 ;;=2^95990
 ;;^UTILITY(U,$J,358.3,15819,1,3,0)
 ;;=3^Refill Spinal Implant Pump
 ;;^UTILITY(U,$J,358.3,15820,0)
 ;;=96402^^99^976^15^^^^1
 ;;^UTILITY(U,$J,358.3,15820,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15820,1,2,0)
 ;;=2^96402
 ;;^UTILITY(U,$J,358.3,15820,1,3,0)
 ;;=3^Injec,IM,anti-neplastic horm
 ;;^UTILITY(U,$J,358.3,15821,0)
 ;;=96372^^99^976^25^^^^1
 ;;^UTILITY(U,$J,358.3,15821,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15821,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,15821,1,3,0)
 ;;=3^Ther/Proph/Diag Inj, SC/IM
 ;;^UTILITY(U,$J,358.3,15822,0)
 ;;=64616^^99^976^9^^^^1
 ;;^UTILITY(U,$J,358.3,15822,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15822,1,2,0)
 ;;=2^64616
 ;;^UTILITY(U,$J,358.3,15822,1,3,0)
 ;;=3^Chemodenervation Neck Muscle            
 ;;^UTILITY(U,$J,358.3,15823,0)
 ;;=64642^^99^976^2^^^^1
 ;;^UTILITY(U,$J,358.3,15823,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15823,1,2,0)
 ;;=2^64642
 ;;^UTILITY(U,$J,358.3,15823,1,3,0)
 ;;=3^Chemodenervation 1 Ext/1-4 Muscles
 ;;^UTILITY(U,$J,358.3,15824,0)
 ;;=64643^^99^976^4^^^^1
 ;;^UTILITY(U,$J,358.3,15824,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15824,1,2,0)
 ;;=2^64643
 ;;^UTILITY(U,$J,358.3,15824,1,3,0)
 ;;=3^Chemodenervation,Ea Addl Ext,1-4 Muscle 
 ;;^UTILITY(U,$J,358.3,15825,0)
 ;;=64644^^99^976^3^^^^1
 ;;^UTILITY(U,$J,358.3,15825,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15825,1,2,0)
 ;;=2^64644
 ;;^UTILITY(U,$J,358.3,15825,1,3,0)
 ;;=3^Chemodenervation 1 Ext 5 or > Muscles
 ;;^UTILITY(U,$J,358.3,15826,0)
 ;;=64645^^99^976^5^^^^1
 ;;^UTILITY(U,$J,358.3,15826,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15826,1,2,0)
 ;;=2^64645
 ;;^UTILITY(U,$J,358.3,15826,1,3,0)
 ;;=3^Chemodenervation,Ea Addl Ext,5 or > Mu
 ;;^UTILITY(U,$J,358.3,15827,0)
 ;;=64646^^99^976^11^^^^1
 ;;^UTILITY(U,$J,358.3,15827,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15827,1,2,0)
 ;;=2^64646
 ;;^UTILITY(U,$J,358.3,15827,1,3,0)
 ;;=3^Chemodenervation Trunk,1-5 Muscles
 ;;^UTILITY(U,$J,358.3,15828,0)
 ;;=64647^^99^976^12^^^^1
 ;;^UTILITY(U,$J,358.3,15828,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15828,1,2,0)
 ;;=2^64647
 ;;^UTILITY(U,$J,358.3,15828,1,3,0)
 ;;=3^Chemodenervation Trunk,6 or > Muscles   
 ;;^UTILITY(U,$J,358.3,15829,0)
 ;;=64615^^99^976^7^^^^1
 ;;^UTILITY(U,$J,358.3,15829,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,15829,1,2,0)
 ;;=2^64615
 ;;^UTILITY(U,$J,358.3,15829,1,3,0)
 ;;=3^Chemodenervation Muscle for Migraine
