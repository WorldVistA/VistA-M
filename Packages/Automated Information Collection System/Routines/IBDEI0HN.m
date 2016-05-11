IBDEI0HN ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8161,0)
 ;;=S83.422A^^33^431^201
 ;;^UTILITY(U,$J,358.3,8161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8161,1,3,0)
 ;;=3^Sprain of lateral collateral ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,8161,1,4,0)
 ;;=4^S83.422A
 ;;^UTILITY(U,$J,358.3,8161,2)
 ;;=^5043121
 ;;^UTILITY(U,$J,358.3,8162,0)
 ;;=S83.501A^^33^431^236
 ;;^UTILITY(U,$J,358.3,8162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8162,1,3,0)
 ;;=3^Sprain of unsp cruciate ligament of right knee, init encntr
 ;;^UTILITY(U,$J,358.3,8162,1,4,0)
 ;;=4^S83.501A
 ;;^UTILITY(U,$J,358.3,8162,2)
 ;;=^5043127
 ;;^UTILITY(U,$J,358.3,8163,0)
 ;;=S83.502A^^33^431^235
 ;;^UTILITY(U,$J,358.3,8163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8163,1,3,0)
 ;;=3^Sprain of unsp cruciate ligament of left knee, init encntr
 ;;^UTILITY(U,$J,358.3,8163,1,4,0)
 ;;=4^S83.502A
 ;;^UTILITY(U,$J,358.3,8163,2)
 ;;=^5043130
 ;;^UTILITY(U,$J,358.3,8164,0)
 ;;=S83.511A^^33^431^197
 ;;^UTILITY(U,$J,358.3,8164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8164,1,3,0)
 ;;=3^Sprain of anterior cruciate ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,8164,1,4,0)
 ;;=4^S83.511A
 ;;^UTILITY(U,$J,358.3,8164,2)
 ;;=^5043133
 ;;^UTILITY(U,$J,358.3,8165,0)
 ;;=S83.512A^^33^431^198
 ;;^UTILITY(U,$J,358.3,8165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8165,1,3,0)
 ;;=3^Sprain of anterior cruciate ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,8165,1,4,0)
 ;;=4^S83.512A
 ;;^UTILITY(U,$J,358.3,8165,2)
 ;;=^5043136
 ;;^UTILITY(U,$J,358.3,8166,0)
 ;;=S83.521A^^33^431^219
 ;;^UTILITY(U,$J,358.3,8166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8166,1,3,0)
 ;;=3^Sprain of posterior cruciate ligament of right knee, init
 ;;^UTILITY(U,$J,358.3,8166,1,4,0)
 ;;=4^S83.521A
 ;;^UTILITY(U,$J,358.3,8166,2)
 ;;=^5043142
 ;;^UTILITY(U,$J,358.3,8167,0)
 ;;=S83.522A^^33^431^220
 ;;^UTILITY(U,$J,358.3,8167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8167,1,3,0)
 ;;=3^Sprain of posterior cruciate ligament of left knee, init
 ;;^UTILITY(U,$J,358.3,8167,1,4,0)
 ;;=4^S83.522A
 ;;^UTILITY(U,$J,358.3,8167,2)
 ;;=^5043145
 ;;^UTILITY(U,$J,358.3,8168,0)
 ;;=S76.111A^^33^431^244
 ;;^UTILITY(U,$J,358.3,8168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8168,1,3,0)
 ;;=3^Strain of right quadriceps muscle, fascia and tendon, init
 ;;^UTILITY(U,$J,358.3,8168,1,4,0)
 ;;=4^S76.111A
 ;;^UTILITY(U,$J,358.3,8168,2)
 ;;=^5039546
 ;;^UTILITY(U,$J,358.3,8169,0)
 ;;=S76.112A^^33^431^241
 ;;^UTILITY(U,$J,358.3,8169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8169,1,3,0)
 ;;=3^Strain of left quadriceps muscle, fascia and tendon, init
 ;;^UTILITY(U,$J,358.3,8169,1,4,0)
 ;;=4^S76.112A
 ;;^UTILITY(U,$J,358.3,8169,2)
 ;;=^5039549
 ;;^UTILITY(U,$J,358.3,8170,0)
 ;;=S33.5XXA^^33^431^215
 ;;^UTILITY(U,$J,358.3,8170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8170,1,3,0)
 ;;=3^Sprain of ligaments of lumbar spine, initial encounter
 ;;^UTILITY(U,$J,358.3,8170,1,4,0)
 ;;=4^S33.5XXA
 ;;^UTILITY(U,$J,358.3,8170,2)
 ;;=^5025172
 ;;^UTILITY(U,$J,358.3,8171,0)
 ;;=S13.9XXA^^33^431^199
 ;;^UTILITY(U,$J,358.3,8171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8171,1,3,0)
 ;;=3^Sprain of joints and ligaments of unsp parts of neck, init
 ;;^UTILITY(U,$J,358.3,8171,1,4,0)
 ;;=4^S13.9XXA
 ;;^UTILITY(U,$J,358.3,8171,2)
 ;;=^5022037
 ;;^UTILITY(U,$J,358.3,8172,0)
 ;;=S43.401A^^33^431^230
 ;;^UTILITY(U,$J,358.3,8172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8172,1,3,0)
 ;;=3^Sprain of right shoulder joint unspec, init encntr
 ;;^UTILITY(U,$J,358.3,8172,1,4,0)
 ;;=4^S43.401A
 ;;^UTILITY(U,$J,358.3,8172,2)
 ;;=^5027864
