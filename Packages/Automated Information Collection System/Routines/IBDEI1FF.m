IBDEI1FF ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24249,1,3,0)
 ;;=3^Alcohol Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24249,1,4,0)
 ;;=4^F10.980
 ;;^UTILITY(U,$J,358.3,24249,2)
 ;;=^5003110
 ;;^UTILITY(U,$J,358.3,24250,0)
 ;;=F10.94^^90^1061^4
 ;;^UTILITY(U,$J,358.3,24250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24250,1,3,0)
 ;;=3^Alcohol Induced Depressive Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24250,1,4,0)
 ;;=4^F10.94
 ;;^UTILITY(U,$J,358.3,24250,2)
 ;;=^5003104
 ;;^UTILITY(U,$J,358.3,24251,0)
 ;;=F10.26^^90^1061^7
 ;;^UTILITY(U,$J,358.3,24251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24251,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24251,1,4,0)
 ;;=4^F10.26
 ;;^UTILITY(U,$J,358.3,24251,2)
 ;;=^5003094
 ;;^UTILITY(U,$J,358.3,24252,0)
 ;;=F10.96^^90^1061^8
 ;;^UTILITY(U,$J,358.3,24252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24252,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Amnestic Cofabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24252,1,4,0)
 ;;=4^F10.96
 ;;^UTILITY(U,$J,358.3,24252,2)
 ;;=^5003108
 ;;^UTILITY(U,$J,358.3,24253,0)
 ;;=F10.27^^90^1061^9
 ;;^UTILITY(U,$J,358.3,24253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24253,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type,w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24253,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,24253,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,24254,0)
 ;;=F10.97^^90^1061^10
 ;;^UTILITY(U,$J,358.3,24254,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24254,1,3,0)
 ;;=3^Alcohol Induced Neurocog Disorder,Nonamnestic Confabul Type w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24254,1,4,0)
 ;;=4^F10.97
 ;;^UTILITY(U,$J,358.3,24254,2)
 ;;=^5003109
 ;;^UTILITY(U,$J,358.3,24255,0)
 ;;=F10.288^^90^1061^5
 ;;^UTILITY(U,$J,358.3,24255,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24255,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24255,1,4,0)
 ;;=4^F10.288
 ;;^UTILITY(U,$J,358.3,24255,2)
 ;;=^5003099
 ;;^UTILITY(U,$J,358.3,24256,0)
 ;;=F10.988^^90^1061^6
 ;;^UTILITY(U,$J,358.3,24256,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24256,1,3,0)
 ;;=3^Alcohol Induced Mild Neurocog Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24256,1,4,0)
 ;;=4^F10.988
 ;;^UTILITY(U,$J,358.3,24256,2)
 ;;=^5003113
 ;;^UTILITY(U,$J,358.3,24257,0)
 ;;=F10.159^^90^1061^11
 ;;^UTILITY(U,$J,358.3,24257,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24257,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24257,1,4,0)
 ;;=4^F10.159
 ;;^UTILITY(U,$J,358.3,24257,2)
 ;;=^5003075
 ;;^UTILITY(U,$J,358.3,24258,0)
 ;;=F10.259^^90^1061^12
 ;;^UTILITY(U,$J,358.3,24258,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24258,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,24258,1,4,0)
 ;;=4^F10.259
 ;;^UTILITY(U,$J,358.3,24258,2)
 ;;=^5003093
 ;;^UTILITY(U,$J,358.3,24259,0)
 ;;=F10.959^^90^1061^13
 ;;^UTILITY(U,$J,358.3,24259,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24259,1,3,0)
 ;;=3^Alcohol Induced Psychotic Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,24259,1,4,0)
 ;;=4^F10.959
 ;;^UTILITY(U,$J,358.3,24259,2)
 ;;=^5003107
 ;;^UTILITY(U,$J,358.3,24260,0)
 ;;=F10.181^^90^1061^14
 ;;^UTILITY(U,$J,358.3,24260,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24260,1,3,0)
 ;;=3^Alcohol Induced Sexual Dysfunction w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,24260,1,4,0)
 ;;=4^F10.181
