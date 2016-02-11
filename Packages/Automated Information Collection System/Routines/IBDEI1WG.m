IBDEI1WG ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31808,0)
 ;;=F43.10^^138^1460^12
 ;;^UTILITY(U,$J,358.3,31808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31808,1,3,0)
 ;;=3^PTSD,Unspec
 ;;^UTILITY(U,$J,358.3,31808,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,31808,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,31809,0)
 ;;=F43.8^^138^1460^13
 ;;^UTILITY(U,$J,358.3,31809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31809,1,3,0)
 ;;=3^Reaction to Severe Stress,Other
 ;;^UTILITY(U,$J,358.3,31809,1,4,0)
 ;;=4^F43.8
 ;;^UTILITY(U,$J,358.3,31809,2)
 ;;=^5003575
 ;;^UTILITY(U,$J,358.3,31810,0)
 ;;=F43.9^^138^1460^14
 ;;^UTILITY(U,$J,358.3,31810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31810,1,3,0)
 ;;=3^Reaction to Severe Stress,Unspec
 ;;^UTILITY(U,$J,358.3,31810,1,4,0)
 ;;=4^F43.9
 ;;^UTILITY(U,$J,358.3,31810,2)
 ;;=^5003576
 ;;^UTILITY(U,$J,358.3,31811,0)
 ;;=F18.10^^138^1461^1
 ;;^UTILITY(U,$J,358.3,31811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31811,1,3,0)
 ;;=3^Inhalant Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,31811,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,31811,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,31812,0)
 ;;=F18.20^^138^1461^2
 ;;^UTILITY(U,$J,358.3,31812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31812,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,31812,1,4,0)
 ;;=4^F18.20
 ;;^UTILITY(U,$J,358.3,31812,2)
 ;;=^5003392
 ;;^UTILITY(U,$J,358.3,31813,0)
 ;;=F18.21^^138^1461^3
 ;;^UTILITY(U,$J,358.3,31813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31813,1,3,0)
 ;;=3^Inhalant Use Disorder,Moderate-Severe,In Remission
 ;;^UTILITY(U,$J,358.3,31813,1,4,0)
 ;;=4^F18.21
 ;;^UTILITY(U,$J,358.3,31813,2)
 ;;=^5003393
 ;;^UTILITY(U,$J,358.3,31814,0)
 ;;=F18.14^^138^1461^4
 ;;^UTILITY(U,$J,358.3,31814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31814,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,31814,1,4,0)
 ;;=4^F18.14
 ;;^UTILITY(U,$J,358.3,31814,2)
 ;;=^5003384
 ;;^UTILITY(U,$J,358.3,31815,0)
 ;;=F18.24^^138^1461^5
 ;;^UTILITY(U,$J,358.3,31815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31815,1,3,0)
 ;;=3^Inhalant-Induced Depressive Disorder w/ Moderate to Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,31815,1,4,0)
 ;;=4^F18.24
 ;;^UTILITY(U,$J,358.3,31815,2)
 ;;=^5003397
 ;;^UTILITY(U,$J,358.3,31816,0)
 ;;=F70.^^138^1462^1
 ;;^UTILITY(U,$J,358.3,31816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31816,1,3,0)
 ;;=3^Intellectual Disabilities,Mild
 ;;^UTILITY(U,$J,358.3,31816,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,31816,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,31817,0)
 ;;=F71.^^138^1462^2
 ;;^UTILITY(U,$J,358.3,31817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31817,1,3,0)
 ;;=3^Intellectual Disabilities,Moderate
 ;;^UTILITY(U,$J,358.3,31817,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,31817,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,31818,0)
 ;;=F72.^^138^1462^3
 ;;^UTILITY(U,$J,358.3,31818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31818,1,3,0)
 ;;=3^Intellectual Disabilities,Severe
 ;;^UTILITY(U,$J,358.3,31818,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,31818,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,31819,0)
 ;;=F73.^^138^1462^4
 ;;^UTILITY(U,$J,358.3,31819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31819,1,3,0)
 ;;=3^Intellectual Disabilities,Profound
 ;;^UTILITY(U,$J,358.3,31819,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,31819,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,31820,0)
 ;;=F78.^^138^1462^5
 ;;^UTILITY(U,$J,358.3,31820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31820,1,3,0)
 ;;=3^Intellectual Disabilities,Oth Specified
 ;;^UTILITY(U,$J,358.3,31820,1,4,0)
 ;;=4^F78.
