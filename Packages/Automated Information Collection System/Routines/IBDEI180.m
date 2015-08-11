IBDEI180 ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21885,0)
 ;;=64632^^124^1305^14^^^^1
 ;;^UTILITY(U,$J,358.3,21885,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21885,1,2,0)
 ;;=2^Destr Common Digital Nerve
 ;;^UTILITY(U,$J,358.3,21885,1,4,0)
 ;;=4^64632
 ;;^UTILITY(U,$J,358.3,21886,0)
 ;;=64642^^124^1305^5^^^^1
 ;;^UTILITY(U,$J,358.3,21886,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21886,1,2,0)
 ;;=2^Chemodenervation 1 Ext,1-4 Muscles
 ;;^UTILITY(U,$J,358.3,21886,1,4,0)
 ;;=4^64642
 ;;^UTILITY(U,$J,358.3,21887,0)
 ;;=64643^^124^1305^6^^^^1
 ;;^UTILITY(U,$J,358.3,21887,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21887,1,2,0)
 ;;=2^Chemodenervation Ea Addl Ext,1-4 Muscles
 ;;^UTILITY(U,$J,358.3,21887,1,4,0)
 ;;=4^64643
 ;;^UTILITY(U,$J,358.3,21888,0)
 ;;=64644^^124^1305^7^^^^1
 ;;^UTILITY(U,$J,358.3,21888,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21888,1,2,0)
 ;;=2^Chemodenervation 1 Ext,5 or > Muscles
 ;;^UTILITY(U,$J,358.3,21888,1,4,0)
 ;;=4^64644
 ;;^UTILITY(U,$J,358.3,21889,0)
 ;;=64645^^124^1305^8^^^^1
 ;;^UTILITY(U,$J,358.3,21889,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21889,1,2,0)
 ;;=2^Chemodenerv Ea Addl Ext,5 or > Muscles
 ;;^UTILITY(U,$J,358.3,21889,1,4,0)
 ;;=4^64645
 ;;^UTILITY(U,$J,358.3,21890,0)
 ;;=64646^^124^1305^11^^^^1
 ;;^UTILITY(U,$J,358.3,21890,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21890,1,2,0)
 ;;=2^Chemodenervation Trunk Muscles,1-5
 ;;^UTILITY(U,$J,358.3,21890,1,4,0)
 ;;=4^64646
 ;;^UTILITY(U,$J,358.3,21891,0)
 ;;=64647^^124^1305^12^^^^1
 ;;^UTILITY(U,$J,358.3,21891,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21891,1,2,0)
 ;;=2^Chemodenervation Trunk Muscles 6 or >
 ;;^UTILITY(U,$J,358.3,21891,1,4,0)
 ;;=4^64647
 ;;^UTILITY(U,$J,358.3,21892,0)
 ;;=64550^^124^1306^6^^^^1
 ;;^UTILITY(U,$J,358.3,21892,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21892,1,2,0)
 ;;=2^TENS Device Training & Issue
 ;;^UTILITY(U,$J,358.3,21892,1,4,0)
 ;;=4^64550
 ;;^UTILITY(U,$J,358.3,21893,0)
 ;;=64553^^124^1306^2^^^^1
 ;;^UTILITY(U,$J,358.3,21893,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21893,1,2,0)
 ;;=2^Percut Neuroelectrodes,Cranial Nerve
 ;;^UTILITY(U,$J,358.3,21893,1,4,0)
 ;;=4^64553
 ;;^UTILITY(U,$J,358.3,21894,0)
 ;;=64555^^124^1306^3^^^^1
 ;;^UTILITY(U,$J,358.3,21894,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21894,1,2,0)
 ;;=2^Percut Neuroelectrodes,Peripheral Nerve
 ;;^UTILITY(U,$J,358.3,21894,1,4,0)
 ;;=4^64555
 ;;^UTILITY(U,$J,358.3,21895,0)
 ;;=64561^^124^1306^4^^^^1
 ;;^UTILITY(U,$J,358.3,21895,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21895,1,2,0)
 ;;=2^Percut Neuroelectrodes,Sacral Nerve
 ;;^UTILITY(U,$J,358.3,21895,1,4,0)
 ;;=4^64561
 ;;^UTILITY(U,$J,358.3,21896,0)
 ;;=64575^^124^1306^1^^^^1
 ;;^UTILITY(U,$J,358.3,21896,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21896,1,2,0)
 ;;=2^Implant Neuroelectrodes
 ;;^UTILITY(U,$J,358.3,21896,1,4,0)
 ;;=4^64575
 ;;^UTILITY(U,$J,358.3,21897,0)
 ;;=64585^^124^1306^5^^^^1
 ;;^UTILITY(U,$J,358.3,21897,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21897,1,2,0)
 ;;=2^Revise/Remove Neuroelectrode
 ;;^UTILITY(U,$J,358.3,21897,1,4,0)
 ;;=4^64585
 ;;^UTILITY(U,$J,358.3,21898,0)
 ;;=20552^^124^1307^8^^^^1
 ;;^UTILITY(U,$J,358.3,21898,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21898,1,2,0)
 ;;=2^Trigger Point,1-2 Muscles
 ;;^UTILITY(U,$J,358.3,21898,1,4,0)
 ;;=4^20552
 ;;^UTILITY(U,$J,358.3,21899,0)
 ;;=20553^^124^1307^9^^^^1
 ;;^UTILITY(U,$J,358.3,21899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21899,1,2,0)
 ;;=2^Trigger Point,3 or more Muscles
 ;;^UTILITY(U,$J,358.3,21899,1,4,0)
 ;;=4^20553
 ;;^UTILITY(U,$J,358.3,21900,0)
 ;;=20612^^124^1307^1^^^^1
