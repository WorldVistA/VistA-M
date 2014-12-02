IBDEI0GK ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8043,2)
 ;;=Benign Neoplasm Conjunctiva^267673
 ;;^UTILITY(U,$J,358.3,8044,0)
 ;;=370.40^^58^605^67
 ;;^UTILITY(U,$J,358.3,8044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8044,1,3,0)
 ;;=3^Keratoconjunctivitis
 ;;^UTILITY(U,$J,358.3,8044,1,4,0)
 ;;=4^370.40
 ;;^UTILITY(U,$J,358.3,8044,2)
 ;;=^66777
 ;;^UTILITY(U,$J,358.3,8045,0)
 ;;=694.5^^58^605^95
 ;;^UTILITY(U,$J,358.3,8045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8045,1,3,0)
 ;;=3^Pemphigoid
 ;;^UTILITY(U,$J,358.3,8045,1,4,0)
 ;;=4^694.5
 ;;^UTILITY(U,$J,358.3,8045,2)
 ;;=Pemphigoid^91108
 ;;^UTILITY(U,$J,358.3,8046,0)
 ;;=364.10^^58^605^54
 ;;^UTILITY(U,$J,358.3,8046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8046,1,3,0)
 ;;=3^Iridocyclitis, Chronic
 ;;^UTILITY(U,$J,358.3,8046,1,4,0)
 ;;=4^364.10
 ;;^UTILITY(U,$J,358.3,8046,2)
 ;;=Iridocyclitis, Chronic^24398
 ;;^UTILITY(U,$J,358.3,8047,0)
 ;;=054.44^^58^605^55
 ;;^UTILITY(U,$J,358.3,8047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8047,1,3,0)
 ;;=3^Iridocyclitis, H Simplex
 ;;^UTILITY(U,$J,358.3,8047,1,4,0)
 ;;=4^054.44
 ;;^UTILITY(U,$J,358.3,8047,2)
 ;;=Iridocyclitis, H Simplex^266565
 ;;^UTILITY(U,$J,358.3,8048,0)
 ;;=053.22^^58^605^56
 ;;^UTILITY(U,$J,358.3,8048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8048,1,3,0)
 ;;=3^Iridocyclitis, H Zoster
 ;;^UTILITY(U,$J,358.3,8048,1,4,0)
 ;;=4^053.22
 ;;^UTILITY(U,$J,358.3,8048,2)
 ;;=Iridocyclitis, H Zoster^266554
 ;;^UTILITY(U,$J,358.3,8049,0)
 ;;=364.42^^58^605^111
 ;;^UTILITY(U,$J,358.3,8049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8049,1,3,0)
 ;;=3^Rubeosis Iridis
 ;;^UTILITY(U,$J,358.3,8049,1,4,0)
 ;;=4^364.42
 ;;^UTILITY(U,$J,358.3,8049,2)
 ;;=Rubeosis Iridis^268716
 ;;^UTILITY(U,$J,358.3,8050,0)
 ;;=364.59^^58^605^59
 ;;^UTILITY(U,$J,358.3,8050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8050,1,3,0)
 ;;=3^Iris Atrophy,Other
 ;;^UTILITY(U,$J,358.3,8050,1,4,0)
 ;;=4^364.59
 ;;^UTILITY(U,$J,358.3,8050,2)
 ;;=Iris Atrophy^268731
 ;;^UTILITY(U,$J,358.3,8051,0)
 ;;=224.0^^58^605^11
 ;;^UTILITY(U,$J,358.3,8051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8051,1,3,0)
 ;;=3^Benign Neopl of Iris
 ;;^UTILITY(U,$J,358.3,8051,1,4,0)
 ;;=4^224.0
 ;;^UTILITY(U,$J,358.3,8051,2)
 ;;=^267670
 ;;^UTILITY(U,$J,358.3,8052,0)
 ;;=364.72^^58^605^6
 ;;^UTILITY(U,$J,358.3,8052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8052,1,3,0)
 ;;=3^Anterior Synechiae
 ;;^UTILITY(U,$J,358.3,8052,1,4,0)
 ;;=4^364.72
 ;;^UTILITY(U,$J,358.3,8052,2)
 ;;=Anterior Synechiae^265517
 ;;^UTILITY(U,$J,358.3,8053,0)
 ;;=364.71^^58^605^102
 ;;^UTILITY(U,$J,358.3,8053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8053,1,3,0)
 ;;=3^Posterior Synechiae
 ;;^UTILITY(U,$J,358.3,8053,1,4,0)
 ;;=4^364.71
 ;;^UTILITY(U,$J,358.3,8053,2)
 ;;=Posterior Synechiae^265519
 ;;^UTILITY(U,$J,358.3,8054,0)
 ;;=364.00^^58^605^57
 ;;^UTILITY(U,$J,358.3,8054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8054,1,3,0)
 ;;=3^Iridocyclitis,Acute/Subacute,Unspec
 ;;^UTILITY(U,$J,358.3,8054,1,4,0)
 ;;=4^364.00
 ;;^UTILITY(U,$J,358.3,8054,2)
 ;;=Iridocyclitis, Acute^268703
 ;;^UTILITY(U,$J,358.3,8055,0)
 ;;=379.40^^58^605^106
 ;;^UTILITY(U,$J,358.3,8055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8055,1,3,0)
 ;;=3^Pupil, Abnormal function
 ;;^UTILITY(U,$J,358.3,8055,1,4,0)
 ;;=4^379.40
 ;;^UTILITY(U,$J,358.3,8055,2)
 ;;=Pupil, Abnormal function^101288
 ;;^UTILITY(U,$J,358.3,8056,0)
 ;;=190.0^^58^605^84
 ;;^UTILITY(U,$J,358.3,8056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8056,1,3,0)
 ;;=3^Malig Neopl of Eyeball,Iris
 ;;^UTILITY(U,$J,358.3,8056,1,4,0)
 ;;=4^190.0
 ;;^UTILITY(U,$J,358.3,8056,2)
 ;;=Malig Neopl of Iris^267271
