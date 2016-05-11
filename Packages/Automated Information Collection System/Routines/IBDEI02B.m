IBDEI02B ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,588,1,3,0)
 ;;=3^PTSD,Chronic
 ;;^UTILITY(U,$J,358.3,588,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,588,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,589,0)
 ;;=F43.10^^3^58^11
 ;;^UTILITY(U,$J,358.3,589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,589,1,3,0)
 ;;=3^PTSD,Unspec
 ;;^UTILITY(U,$J,358.3,589,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,589,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,590,0)
 ;;=F43.8^^3^58^12
 ;;^UTILITY(U,$J,358.3,590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,590,1,3,0)
 ;;=3^Reaction to Severe Stress,Other
 ;;^UTILITY(U,$J,358.3,590,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,590,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,591,0)
 ;;=F43.9^^3^58^13
 ;;^UTILITY(U,$J,358.3,591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,591,1,3,0)
 ;;=3^Reaction to Severe Stress,Unspec
 ;;^UTILITY(U,$J,358.3,591,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,591,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,592,0)
 ;;=F94.1^^3^58^14
 ;;^UTILITY(U,$J,358.3,592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,592,1,3,0)
 ;;=3^Reactive Attachment Disorder
 ;;^UTILITY(U,$J,358.3,592,1,4,0)
 ;;=4^F94.1
 ;;^UTILITY(U,$J,358.3,592,2)
 ;;=^5003705
 ;;^UTILITY(U,$J,358.3,593,0)
 ;;=F94.2^^3^58^8
 ;;^UTILITY(U,$J,358.3,593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,593,1,3,0)
 ;;=3^Disinhibited Social Engagement Disorder
 ;;^UTILITY(U,$J,358.3,593,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,593,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,594,0)
 ;;=F18.10^^3^59^21
 ;;^UTILITY(U,$J,358.3,594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,594,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,594,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,594,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,595,0)
 ;;=F18.20^^3^59^22
 ;;^UTILITY(U,$J,358.3,595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,595,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,595,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,595,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,596,0)
 ;;=F18.21^^3^59^23
 ;;^UTILITY(U,$J,358.3,596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,596,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,596,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,596,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,597,0)
 ;;=F18.14^^3^59^24
 ;;^UTILITY(U,$J,358.3,597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,597,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,597,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,597,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,598,0)
 ;;=F18.24^^3^59^25
 ;;^UTILITY(U,$J,358.3,598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,598,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,598,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,598,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,599,0)
 ;;=F18.121^^3^59^14
 ;;^UTILITY(U,$J,358.3,599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,599,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,599,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,599,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,600,0)
 ;;=F18.221^^3^59^15
 ;;^UTILITY(U,$J,358.3,600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,600,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,600,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,600,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,601,0)
 ;;=F18.921^^3^59^16
 ;;^UTILITY(U,$J,358.3,601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,601,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
