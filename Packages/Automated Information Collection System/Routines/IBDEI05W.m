IBDEI05W ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2230,1,3,0)
 ;;=3^Strain of muscle, fascia and tendon of lower back, init
 ;;^UTILITY(U,$J,358.3,2230,1,4,0)
 ;;=4^S39.012A
 ;;^UTILITY(U,$J,358.3,2230,2)
 ;;=^5026102
 ;;^UTILITY(U,$J,358.3,2231,0)
 ;;=S16.1XXA^^4^62^242
 ;;^UTILITY(U,$J,358.3,2231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2231,1,3,0)
 ;;=3^Strain of muscle, fascia and tendon at neck level, init
 ;;^UTILITY(U,$J,358.3,2231,1,4,0)
 ;;=4^S16.1XXA
 ;;^UTILITY(U,$J,358.3,2231,2)
 ;;=^5022358
 ;;^UTILITY(U,$J,358.3,2232,0)
 ;;=T69.9XXA^^4^62^56
 ;;^UTILITY(U,$J,358.3,2232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2232,1,3,0)
 ;;=3^Effect of reduced temperature, unspecified, init encntr
 ;;^UTILITY(U,$J,358.3,2232,1,4,0)
 ;;=4^T69.9XXA
 ;;^UTILITY(U,$J,358.3,2232,2)
 ;;=^5053978
 ;;^UTILITY(U,$J,358.3,2233,0)
 ;;=T69.8XXA^^4^62^57
 ;;^UTILITY(U,$J,358.3,2233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2233,1,3,0)
 ;;=3^Effects of Reduced Temperature NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,2233,1,4,0)
 ;;=4^T69.8XXA
 ;;^UTILITY(U,$J,358.3,2233,2)
 ;;=^5053975
 ;;^UTILITY(U,$J,358.3,2234,0)
 ;;=L57.8^^4^62^196
 ;;^UTILITY(U,$J,358.3,2234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2234,1,3,0)
 ;;=3^Skin Changes d/t Chr Expsr to Nonionizing Radiation NEC
 ;;^UTILITY(U,$J,358.3,2234,1,4,0)
 ;;=4^L57.8
 ;;^UTILITY(U,$J,358.3,2234,2)
 ;;=^5009226
 ;;^UTILITY(U,$J,358.3,2235,0)
 ;;=S91.001A^^4^62^165
 ;;^UTILITY(U,$J,358.3,2235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2235,1,3,0)
 ;;=3^Open wnd of right ankle unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,2235,1,4,0)
 ;;=4^S91.001A
 ;;^UTILITY(U,$J,358.3,2235,2)
 ;;=^5044129
 ;;^UTILITY(U,$J,358.3,2236,0)
 ;;=S91.002A^^4^62^155
 ;;^UTILITY(U,$J,358.3,2236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2236,1,3,0)
 ;;=3^Open wnd of left ankle unspec, initial encounter
 ;;^UTILITY(U,$J,358.3,2236,1,4,0)
 ;;=4^S91.002A
 ;;^UTILITY(U,$J,358.3,2236,2)
 ;;=^5044132
 ;;^UTILITY(U,$J,358.3,2237,0)
 ;;=S41.101A^^4^62^174
 ;;^UTILITY(U,$J,358.3,2237,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2237,1,3,0)
 ;;=3^Open wnd of right upper arm unspec, initial enco
 ;;^UTILITY(U,$J,358.3,2237,1,4,0)
 ;;=4^S41.101A
 ;;^UTILITY(U,$J,358.3,2237,2)
 ;;=^5026330
 ;;^UTILITY(U,$J,358.3,2238,0)
 ;;=S41.102A^^4^62^164
 ;;^UTILITY(U,$J,358.3,2238,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2238,1,3,0)
 ;;=3^Open wnd of left upper arm unspec, initial encou
 ;;^UTILITY(U,$J,358.3,2238,1,4,0)
 ;;=4^S41.102A
 ;;^UTILITY(U,$J,358.3,2238,2)
 ;;=^5026333
 ;;^UTILITY(U,$J,358.3,2239,0)
 ;;=S61.200A^^4^62^169
 ;;^UTILITY(U,$J,358.3,2239,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2239,1,3,0)
 ;;=3^Open wnd of right idx fngr w/o damage to nail unspec, init
 ;;^UTILITY(U,$J,358.3,2239,1,4,0)
 ;;=4^S61.200A
 ;;^UTILITY(U,$J,358.3,2239,2)
 ;;=^5032741
 ;;^UTILITY(U,$J,358.3,2240,0)
 ;;=S61.201A^^4^62^159
 ;;^UTILITY(U,$J,358.3,2240,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2240,1,3,0)
 ;;=3^Open wnd of left idx fngr w/o damage to nail unspec, init
 ;;^UTILITY(U,$J,358.3,2240,1,4,0)
 ;;=4^S61.201A
 ;;^UTILITY(U,$J,358.3,2240,2)
 ;;=^5032744
 ;;^UTILITY(U,$J,358.3,2241,0)
 ;;=S61.202A^^4^62^172
 ;;^UTILITY(U,$J,358.3,2241,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2241,1,3,0)
 ;;=3^Open wnd of right mid finger w/o damage to nail unspec, ini
 ;;^UTILITY(U,$J,358.3,2241,1,4,0)
 ;;=4^S61.202A
 ;;^UTILITY(U,$J,358.3,2241,2)
 ;;=^5032747
 ;;^UTILITY(U,$J,358.3,2242,0)
 ;;=S61.203A^^4^62^162
 ;;^UTILITY(U,$J,358.3,2242,1,0)
 ;;=^358.31IA^4^2
