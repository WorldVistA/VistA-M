IBDEI0GT ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8131,0)
 ;;=694.5^^52^578^95
 ;;^UTILITY(U,$J,358.3,8131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8131,1,3,0)
 ;;=3^Pemphigoid
 ;;^UTILITY(U,$J,358.3,8131,1,4,0)
 ;;=4^694.5
 ;;^UTILITY(U,$J,358.3,8131,2)
 ;;=Pemphigoid^91108
 ;;^UTILITY(U,$J,358.3,8132,0)
 ;;=364.10^^52^578^54
 ;;^UTILITY(U,$J,358.3,8132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8132,1,3,0)
 ;;=3^Iridocyclitis, Chronic
 ;;^UTILITY(U,$J,358.3,8132,1,4,0)
 ;;=4^364.10
 ;;^UTILITY(U,$J,358.3,8132,2)
 ;;=Iridocyclitis, Chronic^24398
 ;;^UTILITY(U,$J,358.3,8133,0)
 ;;=054.44^^52^578^55
 ;;^UTILITY(U,$J,358.3,8133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8133,1,3,0)
 ;;=3^Iridocyclitis, H Simplex
 ;;^UTILITY(U,$J,358.3,8133,1,4,0)
 ;;=4^054.44
 ;;^UTILITY(U,$J,358.3,8133,2)
 ;;=Iridocyclitis, H Simplex^266565
 ;;^UTILITY(U,$J,358.3,8134,0)
 ;;=053.22^^52^578^56
 ;;^UTILITY(U,$J,358.3,8134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8134,1,3,0)
 ;;=3^Iridocyclitis, H Zoster
 ;;^UTILITY(U,$J,358.3,8134,1,4,0)
 ;;=4^053.22
 ;;^UTILITY(U,$J,358.3,8134,2)
 ;;=Iridocyclitis, H Zoster^266554
 ;;^UTILITY(U,$J,358.3,8135,0)
 ;;=364.42^^52^578^111
 ;;^UTILITY(U,$J,358.3,8135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8135,1,3,0)
 ;;=3^Rubeosis Iridis
 ;;^UTILITY(U,$J,358.3,8135,1,4,0)
 ;;=4^364.42
 ;;^UTILITY(U,$J,358.3,8135,2)
 ;;=Rubeosis Iridis^268716
 ;;^UTILITY(U,$J,358.3,8136,0)
 ;;=364.59^^52^578^59
 ;;^UTILITY(U,$J,358.3,8136,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8136,1,3,0)
 ;;=3^Iris Atrophy,Other
 ;;^UTILITY(U,$J,358.3,8136,1,4,0)
 ;;=4^364.59
 ;;^UTILITY(U,$J,358.3,8136,2)
 ;;=Iris Atrophy^268731
 ;;^UTILITY(U,$J,358.3,8137,0)
 ;;=224.0^^52^578^11
 ;;^UTILITY(U,$J,358.3,8137,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8137,1,3,0)
 ;;=3^Benign Neopl of Iris
 ;;^UTILITY(U,$J,358.3,8137,1,4,0)
 ;;=4^224.0
 ;;^UTILITY(U,$J,358.3,8137,2)
 ;;=^267670
 ;;^UTILITY(U,$J,358.3,8138,0)
 ;;=364.72^^52^578^6
 ;;^UTILITY(U,$J,358.3,8138,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8138,1,3,0)
 ;;=3^Anterior Synechiae
 ;;^UTILITY(U,$J,358.3,8138,1,4,0)
 ;;=4^364.72
 ;;^UTILITY(U,$J,358.3,8138,2)
 ;;=Anterior Synechiae^265517
 ;;^UTILITY(U,$J,358.3,8139,0)
 ;;=364.71^^52^578^102
 ;;^UTILITY(U,$J,358.3,8139,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8139,1,3,0)
 ;;=3^Posterior Synechiae
 ;;^UTILITY(U,$J,358.3,8139,1,4,0)
 ;;=4^364.71
 ;;^UTILITY(U,$J,358.3,8139,2)
 ;;=Posterior Synechiae^265519
 ;;^UTILITY(U,$J,358.3,8140,0)
 ;;=364.00^^52^578^57
 ;;^UTILITY(U,$J,358.3,8140,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8140,1,3,0)
 ;;=3^Iridocyclitis,Acute/Subacute,Unspec
 ;;^UTILITY(U,$J,358.3,8140,1,4,0)
 ;;=4^364.00
 ;;^UTILITY(U,$J,358.3,8140,2)
 ;;=Iridocyclitis, Acute^268703
 ;;^UTILITY(U,$J,358.3,8141,0)
 ;;=379.40^^52^578^106
 ;;^UTILITY(U,$J,358.3,8141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8141,1,3,0)
 ;;=3^Pupil, Abnormal function
 ;;^UTILITY(U,$J,358.3,8141,1,4,0)
 ;;=4^379.40
 ;;^UTILITY(U,$J,358.3,8141,2)
 ;;=Pupil, Abnormal function^101288
 ;;^UTILITY(U,$J,358.3,8142,0)
 ;;=190.0^^52^578^84
 ;;^UTILITY(U,$J,358.3,8142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8142,1,3,0)
 ;;=3^Malig Neopl of Eyeball,Iris
 ;;^UTILITY(U,$J,358.3,8142,1,4,0)
 ;;=4^190.0
 ;;^UTILITY(U,$J,358.3,8142,2)
 ;;=Malig Neopl of Iris^267271
 ;;^UTILITY(U,$J,358.3,8143,0)
 ;;=190.3^^52^578^83
 ;;^UTILITY(U,$J,358.3,8143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8143,1,3,0)
 ;;=3^Malig Neopl Conjunctiva
 ;;^UTILITY(U,$J,358.3,8143,1,4,0)
 ;;=4^190.3
 ;;^UTILITY(U,$J,358.3,8143,2)
 ;;=Malig Neopl Conjunctiva^267274
