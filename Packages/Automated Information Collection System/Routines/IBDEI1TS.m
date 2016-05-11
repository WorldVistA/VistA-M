IBDEI1TS ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31010,0)
 ;;=F10.21^^123^1555^29
 ;;^UTILITY(U,$J,358.3,31010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31010,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,31010,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,31010,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,31011,0)
 ;;=F10.230^^123^1555^30
 ;;^UTILITY(U,$J,358.3,31011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31011,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,31011,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,31011,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,31012,0)
 ;;=F10.231^^123^1555^31
 ;;^UTILITY(U,$J,358.3,31012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31012,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,31012,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,31012,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,31013,0)
 ;;=F10.232^^123^1555^32
 ;;^UTILITY(U,$J,358.3,31013,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31013,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31013,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,31013,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,31014,0)
 ;;=F10.239^^123^1555^33
 ;;^UTILITY(U,$J,358.3,31014,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31014,1,3,0)
 ;;=3^Alcohol Withdrawal w/o Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,31014,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,31014,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,31015,0)
 ;;=F10.24^^123^1555^35
 ;;^UTILITY(U,$J,358.3,31015,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31015,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31015,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,31015,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,31016,0)
 ;;=F10.29^^123^1555^37
 ;;^UTILITY(U,$J,358.3,31016,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31016,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31016,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,31016,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,31017,0)
 ;;=F10.180^^123^1555^1
 ;;^UTILITY(U,$J,358.3,31017,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31017,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31017,1,4,0)
 ;;=4^F10.180
 ;;^UTILITY(U,$J,358.3,31017,2)
 ;;=^5003076
 ;;^UTILITY(U,$J,358.3,31018,0)
 ;;=F10.280^^123^1555^2
 ;;^UTILITY(U,$J,358.3,31018,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31018,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/ Moderate/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31018,1,4,0)
 ;;=4^F10.280
 ;;^UTILITY(U,$J,358.3,31018,2)
 ;;=^5003096
 ;;^UTILITY(U,$J,358.3,31019,0)
 ;;=F10.980^^123^1555^3
 ;;^UTILITY(U,$J,358.3,31019,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31019,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31019,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,31019,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,31020,0)
 ;;=F10.94^^123^1555^4
 ;;^UTILITY(U,$J,358.3,31020,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31020,1,3,0)
 ;;=3^Alcohol Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31020,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,31020,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,31021,0)
 ;;=F10.26^^123^1555^7
 ;;^UTILITY(U,$J,358.3,31021,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31021,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31021,1,4,0)
 ;;=4^F10.26
