IBDEI0IG ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8049,0)
 ;;=C84.07^^65^517^100
 ;;^UTILITY(U,$J,358.3,8049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8049,1,3,0)
 ;;=3^Mycosis Fungoides,Spleen
 ;;^UTILITY(U,$J,358.3,8049,1,4,0)
 ;;=4^C84.07
 ;;^UTILITY(U,$J,358.3,8049,2)
 ;;=^5001628
 ;;^UTILITY(U,$J,358.3,8050,0)
 ;;=C84.00^^65^517^101
 ;;^UTILITY(U,$J,358.3,8050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8050,1,3,0)
 ;;=3^Mycosis Fungoides,Unspec Site
 ;;^UTILITY(U,$J,358.3,8050,1,4,0)
 ;;=4^C84.00
 ;;^UTILITY(U,$J,358.3,8050,2)
 ;;=^5001621
 ;;^UTILITY(U,$J,358.3,8051,0)
 ;;=C43.122^^65^517^4
 ;;^UTILITY(U,$J,358.3,8051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8051,1,3,0)
 ;;=3^Malig Melanoma of Left Lower Eyelid,Incl Canthus
 ;;^UTILITY(U,$J,358.3,8051,1,4,0)
 ;;=4^C43.122
 ;;^UTILITY(U,$J,358.3,8051,2)
 ;;=^5157252
 ;;^UTILITY(U,$J,358.3,8052,0)
 ;;=C43.121^^65^517^6
 ;;^UTILITY(U,$J,358.3,8052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8052,1,3,0)
 ;;=3^Malig Melanoma of Left Upper Eyelid,Incl Canthus
 ;;^UTILITY(U,$J,358.3,8052,1,4,0)
 ;;=4^C43.121
 ;;^UTILITY(U,$J,358.3,8052,2)
 ;;=^5157251
 ;;^UTILITY(U,$J,358.3,8053,0)
 ;;=C43.112^^65^517^12
 ;;^UTILITY(U,$J,358.3,8053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8053,1,3,0)
 ;;=3^Malig Melanoma of Right Lower Eyelid,Incl Canthus
 ;;^UTILITY(U,$J,358.3,8053,1,4,0)
 ;;=4^C43.112
 ;;^UTILITY(U,$J,358.3,8053,2)
 ;;=^5157250
 ;;^UTILITY(U,$J,358.3,8054,0)
 ;;=C43.111^^65^517^14
 ;;^UTILITY(U,$J,358.3,8054,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8054,1,3,0)
 ;;=3^Malig Melanoma of Right Upper Eyelid,Incl Canthus
 ;;^UTILITY(U,$J,358.3,8054,1,4,0)
 ;;=4^C43.111
 ;;^UTILITY(U,$J,358.3,8054,2)
 ;;=^5157249
 ;;^UTILITY(U,$J,358.3,8055,0)
 ;;=C44.1922^^65^517^30
 ;;^UTILITY(U,$J,358.3,8055,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8055,1,3,0)
 ;;=3^Malig Neop Skin of Right Lower Eyelid,Incl Canthus
 ;;^UTILITY(U,$J,358.3,8055,1,4,0)
 ;;=4^C44.1922
 ;;^UTILITY(U,$J,358.3,8055,2)
 ;;=^5157271
 ;;^UTILITY(U,$J,358.3,8056,0)
 ;;=C44.1921^^65^517^32
 ;;^UTILITY(U,$J,358.3,8056,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8056,1,3,0)
 ;;=3^Malig Neop Skin of Right Upper Eyelid,Incl Canthus
 ;;^UTILITY(U,$J,358.3,8056,1,4,0)
 ;;=4^C44.1921
 ;;^UTILITY(U,$J,358.3,8056,2)
 ;;=^5157270
 ;;^UTILITY(U,$J,358.3,8057,0)
 ;;=C44.1992^^65^517^22
 ;;^UTILITY(U,$J,358.3,8057,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8057,1,3,0)
 ;;=3^Malig Neop Skin of Left Lower Eyelid,Incl Canthus
 ;;^UTILITY(U,$J,358.3,8057,1,4,0)
 ;;=4^C44.1992
 ;;^UTILITY(U,$J,358.3,8057,2)
 ;;=^5157273
 ;;^UTILITY(U,$J,358.3,8058,0)
 ;;=C44.1991^^65^517^24
 ;;^UTILITY(U,$J,358.3,8058,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8058,1,3,0)
 ;;=3^Malig Neop Skin of Left Upper Eyelid,Incl Canthus
 ;;^UTILITY(U,$J,358.3,8058,1,4,0)
 ;;=4^C44.1991
 ;;^UTILITY(U,$J,358.3,8058,2)
 ;;=^5157272
 ;;^UTILITY(U,$J,358.3,8059,0)
 ;;=D22.122^^65^517^39
 ;;^UTILITY(U,$J,358.3,8059,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8059,1,3,0)
 ;;=3^Melanocytic Nevi of Left Lower Eyelid
 ;;^UTILITY(U,$J,358.3,8059,1,4,0)
 ;;=4^D22.122
 ;;^UTILITY(U,$J,358.3,8059,2)
 ;;=^5157289
 ;;^UTILITY(U,$J,358.3,8060,0)
 ;;=D22.121^^65^517^41
 ;;^UTILITY(U,$J,358.3,8060,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8060,1,3,0)
 ;;=3^Melanocytic Nevi of Left Upper Eyelid
 ;;^UTILITY(U,$J,358.3,8060,1,4,0)
 ;;=4^D22.121
 ;;^UTILITY(U,$J,358.3,8060,2)
 ;;=^5157288
