IBDEI0QY ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12340,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,12340,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,12341,0)
 ;;=T69.9XXA^^71^708^56
 ;;^UTILITY(U,$J,358.3,12341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12341,1,3,0)
 ;;=3^Effect of reduced temperature, unspecified, init encntr
 ;;^UTILITY(U,$J,358.3,12341,1,4,0)
 ;;=4^T69.9XXA
 ;;^UTILITY(U,$J,358.3,12341,2)
 ;;=^5053978
 ;;^UTILITY(U,$J,358.3,12342,0)
 ;;=T69.8XXA^^71^708^57
 ;;^UTILITY(U,$J,358.3,12342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12342,1,3,0)
 ;;=3^Effects of Reduced Temperature NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,12342,1,4,0)
 ;;=4^T69.8XXA
 ;;^UTILITY(U,$J,358.3,12342,2)
 ;;=^5053975
 ;;^UTILITY(U,$J,358.3,12343,0)
 ;;=L57.8^^71^708^196
 ;;^UTILITY(U,$J,358.3,12343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12343,1,3,0)
 ;;=3^Skin Changes d/t Chr Expsr to Nonionizing Radiation NEC
 ;;^UTILITY(U,$J,358.3,12343,1,4,0)
 ;;=4^L57.8
 ;;^UTILITY(U,$J,358.3,12343,2)
 ;;=^5009226
 ;;^UTILITY(U,$J,358.3,12344,0)
 ;;=S91.001A^^71^708^165
 ;;^UTILITY(U,$J,358.3,12344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12344,1,3,0)
 ;;=3^Open wnd of right ankle unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,12344,1,4,0)
 ;;=4^S91.001A
 ;;^UTILITY(U,$J,358.3,12344,2)
 ;;=^5044129
 ;;^UTILITY(U,$J,358.3,12345,0)
 ;;=S91.002A^^71^708^155
 ;;^UTILITY(U,$J,358.3,12345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12345,1,3,0)
 ;;=3^Open wnd of left ankle unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,12345,1,4,0)
 ;;=4^S91.002A
 ;;^UTILITY(U,$J,358.3,12345,2)
 ;;=^5044132
 ;;^UTILITY(U,$J,358.3,12346,0)
 ;;=S41.101A^^71^708^174
 ;;^UTILITY(U,$J,358.3,12346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12346,1,3,0)
 ;;=3^Open wnd of right upper arm unspec, initial enco
 ;;^UTILITY(U,$J,358.3,12346,1,4,0)
 ;;=4^S41.101A
 ;;^UTILITY(U,$J,358.3,12346,2)
 ;;=^5026330
 ;;^UTILITY(U,$J,358.3,12347,0)
 ;;=S41.102A^^71^708^164
 ;;^UTILITY(U,$J,358.3,12347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12347,1,3,0)
 ;;=3^Open wnd of left upper arm unspec, initial encou
 ;;^UTILITY(U,$J,358.3,12347,1,4,0)
 ;;=4^S41.102A
 ;;^UTILITY(U,$J,358.3,12347,2)
 ;;=^5026333
 ;;^UTILITY(U,$J,358.3,12348,0)
 ;;=S61.200A^^71^708^169
 ;;^UTILITY(U,$J,358.3,12348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12348,1,3,0)
 ;;=3^Open wnd of right idx fngr w/o damage to nail unspec, init
 ;;^UTILITY(U,$J,358.3,12348,1,4,0)
 ;;=4^S61.200A
 ;;^UTILITY(U,$J,358.3,12348,2)
 ;;=^5032741
 ;;^UTILITY(U,$J,358.3,12349,0)
 ;;=S61.201A^^71^708^159
 ;;^UTILITY(U,$J,358.3,12349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12349,1,3,0)
 ;;=3^Open wnd of left idx fngr w/o damage to nail unspec, init
 ;;^UTILITY(U,$J,358.3,12349,1,4,0)
 ;;=4^S61.201A
 ;;^UTILITY(U,$J,358.3,12349,2)
 ;;=^5032744
 ;;^UTILITY(U,$J,358.3,12350,0)
 ;;=S61.202A^^71^708^172
 ;;^UTILITY(U,$J,358.3,12350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12350,1,3,0)
 ;;=3^Open wnd of right mid finger w/o damage to nail unspec, ini
 ;;^UTILITY(U,$J,358.3,12350,1,4,0)
 ;;=4^S61.202A
 ;;^UTILITY(U,$J,358.3,12350,2)
 ;;=^5032747
 ;;^UTILITY(U,$J,358.3,12351,0)
 ;;=S61.203A^^71^708^162
 ;;^UTILITY(U,$J,358.3,12351,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12351,1,3,0)
 ;;=3^Open wnd of left mid finger w/o damage to nail unspec, ini
 ;;^UTILITY(U,$J,358.3,12351,1,4,0)
 ;;=4^S61.203A
 ;;^UTILITY(U,$J,358.3,12351,2)
 ;;=^5032750
 ;;^UTILITY(U,$J,358.3,12352,0)
 ;;=S61.204A^^71^708^173
 ;;^UTILITY(U,$J,358.3,12352,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12352,1,3,0)
 ;;=3^Open wnd of right rng fngr w/o damage to nail unspec, init
