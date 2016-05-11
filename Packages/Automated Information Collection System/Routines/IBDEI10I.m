IBDEI10I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,17171,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,17171,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,17172,0)
 ;;=F43.23^^73^821^2
 ;;^UTILITY(U,$J,358.3,17172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17172,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety and Depressed Mood
 ;;^UTILITY(U,$J,358.3,17172,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,17172,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,17173,0)
 ;;=F41.9^^73^822^4
 ;;^UTILITY(U,$J,358.3,17173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17173,1,3,0)
 ;;=3^Anxiety disorder, unspec
 ;;^UTILITY(U,$J,358.3,17173,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,17173,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,17174,0)
 ;;=F41.0^^73^822^6
 ;;^UTILITY(U,$J,358.3,17174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17174,1,3,0)
 ;;=3^Panic disorder w/o agoraphobia [episodic paroxysmal anxiety]
 ;;^UTILITY(U,$J,358.3,17174,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,17174,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,17175,0)
 ;;=F41.1^^73^822^3
 ;;^UTILITY(U,$J,358.3,17175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17175,1,3,0)
 ;;=3^Anxiety disorder, generalized
 ;;^UTILITY(U,$J,358.3,17175,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,17175,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,17176,0)
 ;;=F40.01^^73^822^1
 ;;^UTILITY(U,$J,358.3,17176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17176,1,3,0)
 ;;=3^Agoraphobia w/ panic disorder
 ;;^UTILITY(U,$J,358.3,17176,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,17176,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,17177,0)
 ;;=F40.02^^73^822^2
 ;;^UTILITY(U,$J,358.3,17177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17177,1,3,0)
 ;;=3^Agoraphobia w/o panic disorder
 ;;^UTILITY(U,$J,358.3,17177,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,17177,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,17178,0)
 ;;=F42.^^73^822^5
 ;;^UTILITY(U,$J,358.3,17178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17178,1,3,0)
 ;;=3^Obsessive-compulsive disorder
 ;;^UTILITY(U,$J,358.3,17178,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,17178,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,17179,0)
 ;;=F43.10^^73^822^8
 ;;^UTILITY(U,$J,358.3,17179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17179,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspec
 ;;^UTILITY(U,$J,358.3,17179,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,17179,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,17180,0)
 ;;=F43.12^^73^822^7
 ;;^UTILITY(U,$J,358.3,17180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17180,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,17180,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,17180,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,17181,0)
 ;;=E53.8^^73^823^1
 ;;^UTILITY(U,$J,358.3,17181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17181,1,3,0)
 ;;=3^B Vitamin Deficiency
 ;;^UTILITY(U,$J,358.3,17181,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,17181,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,17182,0)
 ;;=R00.1^^73^823^6
 ;;^UTILITY(U,$J,358.3,17182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17182,1,3,0)
 ;;=3^Bradycardia, unspec
 ;;^UTILITY(U,$J,358.3,17182,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,17182,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,17183,0)
 ;;=J20.9^^73^823^7
 ;;^UTILITY(U,$J,358.3,17183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17183,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,17183,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,17183,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,17184,0)
 ;;=N32.0^^73^823^5
 ;;^UTILITY(U,$J,358.3,17184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,17184,1,3,0)
 ;;=3^Bladder-neck obstruction
 ;;^UTILITY(U,$J,358.3,17184,1,4,0)
 ;;=4^N32.0
