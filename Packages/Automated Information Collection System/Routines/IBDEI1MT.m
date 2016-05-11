IBDEI1MT ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,27697,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27697,1,2,0)
 ;;=2^61796
 ;;^UTILITY(U,$J,358.3,27697,1,3,0)
 ;;=3^SRS Cranial Lesion,Simple
 ;;^UTILITY(U,$J,358.3,27698,0)
 ;;=61797^^108^1378^2^^^^1
 ;;^UTILITY(U,$J,358.3,27698,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27698,1,2,0)
 ;;=2^61797
 ;;^UTILITY(U,$J,358.3,27698,1,3,0)
 ;;=3^SRS Cranial Lesion,Simple,Addl Lesion
 ;;^UTILITY(U,$J,358.3,27699,0)
 ;;=61800^^108^1378^3^^^^1
 ;;^UTILITY(U,$J,358.3,27699,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27699,1,2,0)
 ;;=2^61800
 ;;^UTILITY(U,$J,358.3,27699,1,3,0)
 ;;=3^Apply SRS Headframe,Add-On
 ;;^UTILITY(U,$J,358.3,27700,0)
 ;;=98960^^108^1379^1^^^^1
 ;;^UTILITY(U,$J,358.3,27700,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27700,1,2,0)
 ;;=2^98960
 ;;^UTILITY(U,$J,358.3,27700,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,1 Pt
 ;;^UTILITY(U,$J,358.3,27701,0)
 ;;=98961^^108^1379^2^^^^1
 ;;^UTILITY(U,$J,358.3,27701,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27701,1,2,0)
 ;;=2^98961
 ;;^UTILITY(U,$J,358.3,27701,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,2-4 Pts
 ;;^UTILITY(U,$J,358.3,27702,0)
 ;;=98962^^108^1379^3^^^^1
 ;;^UTILITY(U,$J,358.3,27702,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27702,1,2,0)
 ;;=2^98962
 ;;^UTILITY(U,$J,358.3,27702,1,3,0)
 ;;=3^Self-Mgmt Ed/Train,5-8 Pts
 ;;^UTILITY(U,$J,358.3,27703,0)
 ;;=95971^^108^1380^2^^^^1
 ;;^UTILITY(U,$J,358.3,27703,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27703,1,2,0)
 ;;=2^95971
 ;;^UTILITY(U,$J,358.3,27703,1,3,0)
 ;;=3^Analyze Neurostim,Simple
 ;;^UTILITY(U,$J,358.3,27704,0)
 ;;=95972^^108^1380^1^^^^1
 ;;^UTILITY(U,$J,358.3,27704,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27704,1,2,0)
 ;;=2^95972
 ;;^UTILITY(U,$J,358.3,27704,1,3,0)
 ;;=3^Analyze Neurostim,Complex,up to 1hr
 ;;^UTILITY(U,$J,358.3,27705,0)
 ;;=95974^^108^1380^3^^^^1
 ;;^UTILITY(U,$J,358.3,27705,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27705,1,2,0)
 ;;=2^95974
 ;;^UTILITY(U,$J,358.3,27705,1,3,0)
 ;;=3^Cranial Neurostim,Complex,1st Hr
 ;;^UTILITY(U,$J,358.3,27706,0)
 ;;=95975^^108^1380^4^^^^1
 ;;^UTILITY(U,$J,358.3,27706,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,27706,1,2,0)
 ;;=2^95975
 ;;^UTILITY(U,$J,358.3,27706,1,3,0)
 ;;=3^Cranial Neurostim,Complex,Ea Addl 30 Min
 ;;^UTILITY(U,$J,358.3,27707,0)
 ;;=G40.A01^^109^1381^3
 ;;^UTILITY(U,$J,358.3,27707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27707,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27707,1,4,0)
 ;;=4^G40.A01
 ;;^UTILITY(U,$J,358.3,27707,2)
 ;;=^5003868
 ;;^UTILITY(U,$J,358.3,27708,0)
 ;;=G40.A09^^109^1381^4
 ;;^UTILITY(U,$J,358.3,27708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27708,1,3,0)
 ;;=3^Absence Seizures Not Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27708,1,4,0)
 ;;=4^G40.A09
 ;;^UTILITY(U,$J,358.3,27708,2)
 ;;=^5003869
 ;;^UTILITY(U,$J,358.3,27709,0)
 ;;=G40.A11^^109^1381^1
 ;;^UTILITY(U,$J,358.3,27709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27709,1,3,0)
 ;;=3^Absence Seizures Intractable w/ Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27709,1,4,0)
 ;;=4^G40.A11
 ;;^UTILITY(U,$J,358.3,27709,2)
 ;;=^5003870
 ;;^UTILITY(U,$J,358.3,27710,0)
 ;;=G40.A19^^109^1381^2
 ;;^UTILITY(U,$J,358.3,27710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27710,1,3,0)
 ;;=3^Absence Seizures Intractable w/o Status Epilepticus
 ;;^UTILITY(U,$J,358.3,27710,1,4,0)
 ;;=4^G40.A19
 ;;^UTILITY(U,$J,358.3,27710,2)
 ;;=^5003871
 ;;^UTILITY(U,$J,358.3,27711,0)
 ;;=G40.309^^109^1381^17
 ;;^UTILITY(U,$J,358.3,27711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,27711,1,3,0)
 ;;=3^Generalized Seizures Not Intractable w/o Status Epilepticus
