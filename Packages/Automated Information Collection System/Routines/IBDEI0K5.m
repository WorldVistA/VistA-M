IBDEI0K5 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9065,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Hip
 ;;^UTILITY(U,$J,358.3,9065,1,4,0)
 ;;=4^M05.752
 ;;^UTILITY(U,$J,358.3,9065,2)
 ;;=^5010014
 ;;^UTILITY(U,$J,358.3,9066,0)
 ;;=M05.761^^39^407^158
 ;;^UTILITY(U,$J,358.3,9066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9066,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Knee
 ;;^UTILITY(U,$J,358.3,9066,1,4,0)
 ;;=4^M05.761
 ;;^UTILITY(U,$J,358.3,9066,2)
 ;;=^5010016
 ;;^UTILITY(U,$J,358.3,9067,0)
 ;;=M05.762^^39^407^151
 ;;^UTILITY(U,$J,358.3,9067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9067,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Knee
 ;;^UTILITY(U,$J,358.3,9067,1,4,0)
 ;;=4^M05.762
 ;;^UTILITY(U,$J,358.3,9067,2)
 ;;=^5010017
 ;;^UTILITY(U,$J,358.3,9068,0)
 ;;=M05.771^^39^407^155
 ;;^UTILITY(U,$J,358.3,9068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9068,1,3,0)
 ;;=3^Rheumatoid Arthritis of Right Ankle
 ;;^UTILITY(U,$J,358.3,9068,1,4,0)
 ;;=4^M05.771
 ;;^UTILITY(U,$J,358.3,9068,2)
 ;;=^5010019
 ;;^UTILITY(U,$J,358.3,9069,0)
 ;;=M05.772^^39^407^148
 ;;^UTILITY(U,$J,358.3,9069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9069,1,3,0)
 ;;=3^Rheumatoid Arthritis of Left Ankle
 ;;^UTILITY(U,$J,358.3,9069,1,4,0)
 ;;=4^M05.772
 ;;^UTILITY(U,$J,358.3,9069,2)
 ;;=^5010020
 ;;^UTILITY(U,$J,358.3,9070,0)
 ;;=M05.79^^39^407^154
 ;;^UTILITY(U,$J,358.3,9070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9070,1,3,0)
 ;;=3^Rheumatoid Arthritis of Multiple Sites
 ;;^UTILITY(U,$J,358.3,9070,1,4,0)
 ;;=4^M05.79
 ;;^UTILITY(U,$J,358.3,9070,2)
 ;;=^5010022
 ;;^UTILITY(U,$J,358.3,9071,0)
 ;;=M06.00^^39^407^161
 ;;^UTILITY(U,$J,358.3,9071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9071,1,3,0)
 ;;=3^Rheumatoid Arthritis w/o Rhematoid Factor,Unspec Site
 ;;^UTILITY(U,$J,358.3,9071,1,4,0)
 ;;=4^M06.00
 ;;^UTILITY(U,$J,358.3,9071,2)
 ;;=^5010047
 ;;^UTILITY(U,$J,358.3,9072,0)
 ;;=M06.30^^39^407^164
 ;;^UTILITY(U,$J,358.3,9072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9072,1,3,0)
 ;;=3^Rheumatoid Nodule,Unspec Site
 ;;^UTILITY(U,$J,358.3,9072,1,4,0)
 ;;=4^M06.30
 ;;^UTILITY(U,$J,358.3,9072,2)
 ;;=^5010096
 ;;^UTILITY(U,$J,358.3,9073,0)
 ;;=M06.4^^39^407^51
 ;;^UTILITY(U,$J,358.3,9073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9073,1,3,0)
 ;;=3^Inflammatory Polyarthropathy
 ;;^UTILITY(U,$J,358.3,9073,1,4,0)
 ;;=4^M06.4
 ;;^UTILITY(U,$J,358.3,9073,2)
 ;;=^5010120
 ;;^UTILITY(U,$J,358.3,9074,0)
 ;;=M06.39^^39^407^163
 ;;^UTILITY(U,$J,358.3,9074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9074,1,3,0)
 ;;=3^Rheumatoid Nodule,Mult Sites
 ;;^UTILITY(U,$J,358.3,9074,1,4,0)
 ;;=4^M06.39
 ;;^UTILITY(U,$J,358.3,9074,2)
 ;;=^5010119
 ;;^UTILITY(U,$J,358.3,9075,0)
 ;;=M15.0^^39^407^127
 ;;^UTILITY(U,$J,358.3,9075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9075,1,3,0)
 ;;=3^Primary Generalized Osteoarthritis
 ;;^UTILITY(U,$J,358.3,9075,1,4,0)
 ;;=4^M15.0
 ;;^UTILITY(U,$J,358.3,9075,2)
 ;;=^5010762
 ;;^UTILITY(U,$J,358.3,9076,0)
 ;;=M06.9^^39^407^162
 ;;^UTILITY(U,$J,358.3,9076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9076,1,3,0)
 ;;=3^Rheumatoid Arthritis,Unspec
 ;;^UTILITY(U,$J,358.3,9076,1,4,0)
 ;;=4^M06.9
 ;;^UTILITY(U,$J,358.3,9076,2)
 ;;=^5010145
 ;;^UTILITY(U,$J,358.3,9077,0)
 ;;=M16.0^^39^407^130
 ;;^UTILITY(U,$J,358.3,9077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9077,1,3,0)
 ;;=3^Primary Osteoarthritis of Hip,Bilateral
