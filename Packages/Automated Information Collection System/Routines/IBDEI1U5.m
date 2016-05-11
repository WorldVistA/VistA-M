IBDEI1U5 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31167,1,4,0)
 ;;=4^F94.2
 ;;^UTILITY(U,$J,358.3,31167,2)
 ;;=^5003706
 ;;^UTILITY(U,$J,358.3,31168,0)
 ;;=F18.10^^123^1565^21
 ;;^UTILITY(U,$J,358.3,31168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31168,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31168,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,31168,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,31169,0)
 ;;=F18.20^^123^1565^22
 ;;^UTILITY(U,$J,358.3,31169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31169,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31169,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,31169,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,31170,0)
 ;;=F18.21^^123^1565^23
 ;;^UTILITY(U,$J,358.3,31170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31170,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,31170,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,31170,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,31171,0)
 ;;=F18.14^^123^1565^24
 ;;^UTILITY(U,$J,358.3,31171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31171,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31171,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,31171,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,31172,0)
 ;;=F18.24^^123^1565^25
 ;;^UTILITY(U,$J,358.3,31172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31172,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31172,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,31172,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,31173,0)
 ;;=F18.121^^123^1565^14
 ;;^UTILITY(U,$J,358.3,31173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31173,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31173,1,4,0)
 ;;=4^F18.121
 ;;^UTILITY(U,$J,358.3,31173,2)
 ;;=^5003382
 ;;^UTILITY(U,$J,358.3,31174,0)
 ;;=F18.221^^123^1565^15
 ;;^UTILITY(U,$J,358.3,31174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31174,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31174,1,4,0)
 ;;=4^F18.221
 ;;^UTILITY(U,$J,358.3,31174,2)
 ;;=^5003395
 ;;^UTILITY(U,$J,358.3,31175,0)
 ;;=F18.921^^123^1565^16
 ;;^UTILITY(U,$J,358.3,31175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31175,1,3,0)
 ;;=3^Inhalant Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31175,1,4,0)
 ;;=4^F18.921
 ;;^UTILITY(U,$J,358.3,31175,2)
 ;;=^5003407
 ;;^UTILITY(U,$J,358.3,31176,0)
 ;;=F18.129^^123^1565^17
 ;;^UTILITY(U,$J,358.3,31176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31176,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31176,1,4,0)
 ;;=4^F18.129
 ;;^UTILITY(U,$J,358.3,31176,2)
 ;;=^5003383
 ;;^UTILITY(U,$J,358.3,31177,0)
 ;;=F18.229^^123^1565^18
 ;;^UTILITY(U,$J,358.3,31177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31177,1,3,0)
 ;;=3^Inhalant Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31177,1,4,0)
 ;;=4^F18.229
 ;;^UTILITY(U,$J,358.3,31177,2)
 ;;=^5003396
 ;;^UTILITY(U,$J,358.3,31178,0)
 ;;=F18.929^^123^1565^19
 ;;^UTILITY(U,$J,358.3,31178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31178,1,3,0)
 ;;=3^Inhalant Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31178,1,4,0)
 ;;=4^F18.929
 ;;^UTILITY(U,$J,358.3,31178,2)
 ;;=^5003408
 ;;^UTILITY(U,$J,358.3,31179,0)
 ;;=F18.180^^123^1565^1
 ;;^UTILITY(U,$J,358.3,31179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31179,1,3,0)
 ;;=3^Inhalant Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31179,1,4,0)
 ;;=4^F18.180
