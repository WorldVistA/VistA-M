IBDEI0OM ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11061,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,11061,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,11061,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,11062,0)
 ;;=F80.2^^42^505^18
 ;;^UTILITY(U,$J,358.3,11062,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11062,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,11062,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,11062,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,11063,0)
 ;;=F81.2^^42^505^19
 ;;^UTILITY(U,$J,358.3,11063,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11063,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,11063,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,11063,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,11064,0)
 ;;=F81.0^^42^505^20
 ;;^UTILITY(U,$J,358.3,11064,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11064,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,11064,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,11064,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,11065,0)
 ;;=F81.81^^42^505^21
 ;;^UTILITY(U,$J,358.3,11065,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11065,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,11065,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,11065,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,11066,0)
 ;;=F88.^^42^505^22
 ;;^UTILITY(U,$J,358.3,11066,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11066,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,11066,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,11066,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,11067,0)
 ;;=F89.^^42^505^23
 ;;^UTILITY(U,$J,358.3,11067,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11067,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,11067,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,11067,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,11068,0)
 ;;=F95.1^^42^505^24
 ;;^UTILITY(U,$J,358.3,11068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11068,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,11068,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,11068,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,11069,0)
 ;;=F95.0^^42^505^26
 ;;^UTILITY(U,$J,358.3,11069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11069,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,11069,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,11069,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,11070,0)
 ;;=F80.89^^42^505^27
 ;;^UTILITY(U,$J,358.3,11070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11070,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,11070,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,11070,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,11071,0)
 ;;=F80.0^^42^505^28
 ;;^UTILITY(U,$J,358.3,11071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11071,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,11071,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,11071,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,11072,0)
 ;;=F98.4^^42^505^29
 ;;^UTILITY(U,$J,358.3,11072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,11072,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,11072,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,11072,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,11073,0)
 ;;=F95.8^^42^505^32
 ;;^UTILITY(U,$J,358.3,11073,1,0)
 ;;=^358.31IA^4^2
