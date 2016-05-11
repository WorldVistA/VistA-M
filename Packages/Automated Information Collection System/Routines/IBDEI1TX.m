IBDEI1TX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31070,0)
 ;;=F12.99^^123^1557^15
 ;;^UTILITY(U,$J,358.3,31070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31070,1,3,0)
 ;;=3^Cannabis Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31070,1,4,0)
 ;;=4^F12.99
 ;;^UTILITY(U,$J,358.3,31070,2)
 ;;=^5003188
 ;;^UTILITY(U,$J,358.3,31071,0)
 ;;=F16.10^^123^1558^17
 ;;^UTILITY(U,$J,358.3,31071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31071,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31071,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,31071,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,31072,0)
 ;;=F16.20^^123^1558^18
 ;;^UTILITY(U,$J,358.3,31072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31072,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31072,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,31072,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,31073,0)
 ;;=F16.21^^123^1558^19
 ;;^UTILITY(U,$J,358.3,31073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31073,1,3,0)
 ;;=3^Phencyclidine Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,31073,1,4,0)
 ;;=4^F16.21
 ;;^UTILITY(U,$J,358.3,31073,2)
 ;;=^5003337
 ;;^UTILITY(U,$J,358.3,31074,0)
 ;;=F16.983^^123^1558^16
 ;;^UTILITY(U,$J,358.3,31074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31074,1,3,0)
 ;;=3^Hallucinogen Persisting Perception Disorder
 ;;^UTILITY(U,$J,358.3,31074,1,4,0)
 ;;=4^F16.983
 ;;^UTILITY(U,$J,358.3,31074,2)
 ;;=^5003358
 ;;^UTILITY(U,$J,358.3,31075,0)
 ;;=F16.121^^123^1558^10
 ;;^UTILITY(U,$J,358.3,31075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31075,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31075,1,4,0)
 ;;=4^F16.121
 ;;^UTILITY(U,$J,358.3,31075,2)
 ;;=^5003325
 ;;^UTILITY(U,$J,358.3,31076,0)
 ;;=F16.221^^123^1558^11
 ;;^UTILITY(U,$J,358.3,31076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31076,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31076,1,4,0)
 ;;=4^F16.221
 ;;^UTILITY(U,$J,358.3,31076,2)
 ;;=^5003339
 ;;^UTILITY(U,$J,358.3,31077,0)
 ;;=F16.921^^123^1558^12
 ;;^UTILITY(U,$J,358.3,31077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31077,1,3,0)
 ;;=3^Hallucinogen Intoxication Delirium w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31077,1,4,0)
 ;;=4^F16.921
 ;;^UTILITY(U,$J,358.3,31077,2)
 ;;=^5003351
 ;;^UTILITY(U,$J,358.3,31078,0)
 ;;=F16.129^^123^1558^13
 ;;^UTILITY(U,$J,358.3,31078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31078,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31078,1,4,0)
 ;;=4^F16.129
 ;;^UTILITY(U,$J,358.3,31078,2)
 ;;=^5003327
 ;;^UTILITY(U,$J,358.3,31079,0)
 ;;=F16.229^^123^1558^14
 ;;^UTILITY(U,$J,358.3,31079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31079,1,3,0)
 ;;=3^Hallucinogen Intoxication w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31079,1,4,0)
 ;;=4^F16.229
 ;;^UTILITY(U,$J,358.3,31079,2)
 ;;=^5003340
 ;;^UTILITY(U,$J,358.3,31080,0)
 ;;=F16.929^^123^1558^15
 ;;^UTILITY(U,$J,358.3,31080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31080,1,3,0)
 ;;=3^Hallucinogen Intoxication w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,31080,1,4,0)
 ;;=4^F16.929
 ;;^UTILITY(U,$J,358.3,31080,2)
 ;;=^5003352
 ;;^UTILITY(U,$J,358.3,31081,0)
 ;;=F16.180^^123^1558^1
 ;;^UTILITY(U,$J,358.3,31081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31081,1,3,0)
 ;;=3^Hallucinogen Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31081,1,4,0)
 ;;=4^F16.180
 ;;^UTILITY(U,$J,358.3,31081,2)
 ;;=^5003332
 ;;^UTILITY(U,$J,358.3,31082,0)
 ;;=F16.280^^123^1558^2
