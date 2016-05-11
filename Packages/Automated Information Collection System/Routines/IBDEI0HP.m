IBDEI0HP ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8185,1,3,0)
 ;;=3^Strain of muscle, fascia and tendon at neck level, init
 ;;^UTILITY(U,$J,358.3,8185,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,8185,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,8186,0)
 ;;=T69.9XXA^^33^431^56
 ;;^UTILITY(U,$J,358.3,8186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8186,1,3,0)
 ;;=3^Effect of reduced temperature, unspecified, init encntr
 ;;^UTILITY(U,$J,358.3,8186,1,4,0)
 ;;=4^T69.9XXA
 ;;^UTILITY(U,$J,358.3,8186,2)
 ;;=^5053978
 ;;^UTILITY(U,$J,358.3,8187,0)
 ;;=T69.8XXA^^33^431^57
 ;;^UTILITY(U,$J,358.3,8187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8187,1,3,0)
 ;;=3^Effects of Reduced Temperature NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,8187,1,4,0)
 ;;=4^T69.8XXA
 ;;^UTILITY(U,$J,358.3,8187,2)
 ;;=^5053975
 ;;^UTILITY(U,$J,358.3,8188,0)
 ;;=L57.8^^33^431^196
 ;;^UTILITY(U,$J,358.3,8188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8188,1,3,0)
 ;;=3^Skin Changes d/t Chr Expsr to Nonionizing Radiation NEC
 ;;^UTILITY(U,$J,358.3,8188,1,4,0)
 ;;=4^L57.8
 ;;^UTILITY(U,$J,358.3,8188,2)
 ;;=^5009226
 ;;^UTILITY(U,$J,358.3,8189,0)
 ;;=S91.001A^^33^431^165
 ;;^UTILITY(U,$J,358.3,8189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8189,1,3,0)
 ;;=3^Open wnd of right ankle unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,8189,1,4,0)
 ;;=4^S91.001A
 ;;^UTILITY(U,$J,358.3,8189,2)
 ;;=^5044129
 ;;^UTILITY(U,$J,358.3,8190,0)
 ;;=S91.002A^^33^431^155
 ;;^UTILITY(U,$J,358.3,8190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8190,1,3,0)
 ;;=3^Open wnd of left ankle unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,8190,1,4,0)
 ;;=4^S91.002A
 ;;^UTILITY(U,$J,358.3,8190,2)
 ;;=^5044132
 ;;^UTILITY(U,$J,358.3,8191,0)
 ;;=S41.101A^^33^431^174
 ;;^UTILITY(U,$J,358.3,8191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8191,1,3,0)
 ;;=3^Open wnd of right upper arm unspec, initial enco
 ;;^UTILITY(U,$J,358.3,8191,1,4,0)
 ;;=4^S41.101A
 ;;^UTILITY(U,$J,358.3,8191,2)
 ;;=^5026330
 ;;^UTILITY(U,$J,358.3,8192,0)
 ;;=S41.102A^^33^431^164
 ;;^UTILITY(U,$J,358.3,8192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8192,1,3,0)
 ;;=3^Open wnd of left upper arm unspec, initial encou
 ;;^UTILITY(U,$J,358.3,8192,1,4,0)
 ;;=4^S41.102A
 ;;^UTILITY(U,$J,358.3,8192,2)
 ;;=^5026333
 ;;^UTILITY(U,$J,358.3,8193,0)
 ;;=S61.200A^^33^431^169
 ;;^UTILITY(U,$J,358.3,8193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8193,1,3,0)
 ;;=3^Open wnd of right idx fngr w/o damage to nail unspec, init
 ;;^UTILITY(U,$J,358.3,8193,1,4,0)
 ;;=4^S61.200A
 ;;^UTILITY(U,$J,358.3,8193,2)
 ;;=^5032741
 ;;^UTILITY(U,$J,358.3,8194,0)
 ;;=S61.201A^^33^431^159
 ;;^UTILITY(U,$J,358.3,8194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8194,1,3,0)
 ;;=3^Open wnd of left idx fngr w/o damage to nail unspec, init
 ;;^UTILITY(U,$J,358.3,8194,1,4,0)
 ;;=4^S61.201A
 ;;^UTILITY(U,$J,358.3,8194,2)
 ;;=^5032744
 ;;^UTILITY(U,$J,358.3,8195,0)
 ;;=S61.202A^^33^431^172
 ;;^UTILITY(U,$J,358.3,8195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8195,1,3,0)
 ;;=3^Open wnd of right mid finger w/o damage to nail unspec, ini
 ;;^UTILITY(U,$J,358.3,8195,1,4,0)
 ;;=4^S61.202A
 ;;^UTILITY(U,$J,358.3,8195,2)
 ;;=^5032747
 ;;^UTILITY(U,$J,358.3,8196,0)
 ;;=S61.203A^^33^431^162
 ;;^UTILITY(U,$J,358.3,8196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8196,1,3,0)
 ;;=3^Open wnd of left mid finger w/o damage to nail unspec, ini
 ;;^UTILITY(U,$J,358.3,8196,1,4,0)
 ;;=4^S61.203A
 ;;^UTILITY(U,$J,358.3,8196,2)
 ;;=^5032750
 ;;^UTILITY(U,$J,358.3,8197,0)
 ;;=S61.204A^^33^431^173
 ;;^UTILITY(U,$J,358.3,8197,1,0)
 ;;=^358.31IA^4^2
