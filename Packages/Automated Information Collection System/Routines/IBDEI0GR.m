IBDEI0GR ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16820,1,3,0)
 ;;=3^Anemia,Vitamin B12 Deficiency
 ;;^UTILITY(U,$J,358.3,16820,1,4,0)
 ;;=4^D51.9
 ;;^UTILITY(U,$J,358.3,16820,2)
 ;;=^5002289
 ;;^UTILITY(U,$J,358.3,16821,0)
 ;;=F43.20^^73^844^4
 ;;^UTILITY(U,$J,358.3,16821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16821,1,3,0)
 ;;=3^Adjustment disorder, unspec
 ;;^UTILITY(U,$J,358.3,16821,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,16821,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,16822,0)
 ;;=F43.21^^73^844^3
 ;;^UTILITY(U,$J,358.3,16822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16822,1,3,0)
 ;;=3^Adjustment disorder w/ depressed mood
 ;;^UTILITY(U,$J,358.3,16822,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,16822,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,16823,0)
 ;;=F43.22^^73^844^1
 ;;^UTILITY(U,$J,358.3,16823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16823,1,3,0)
 ;;=3^Adjustment Disorder w/ Anxiety
 ;;^UTILITY(U,$J,358.3,16823,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,16823,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,16824,0)
 ;;=F43.23^^73^844^2
 ;;^UTILITY(U,$J,358.3,16824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16824,1,3,0)
 ;;=3^Adjustment Disorder w/ Mixed Anxiety and Depressed Mood
 ;;^UTILITY(U,$J,358.3,16824,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,16824,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,16825,0)
 ;;=F41.9^^73^845^4
 ;;^UTILITY(U,$J,358.3,16825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16825,1,3,0)
 ;;=3^Anxiety disorder, unspec
 ;;^UTILITY(U,$J,358.3,16825,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,16825,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,16826,0)
 ;;=F41.0^^73^845^6
 ;;^UTILITY(U,$J,358.3,16826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16826,1,3,0)
 ;;=3^Panic disorder w/o agoraphobia [episodic paroxysmal anxiety]
 ;;^UTILITY(U,$J,358.3,16826,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,16826,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,16827,0)
 ;;=F41.1^^73^845^3
 ;;^UTILITY(U,$J,358.3,16827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16827,1,3,0)
 ;;=3^Anxiety disorder, generalized
 ;;^UTILITY(U,$J,358.3,16827,1,4,0)
 ;;=4^F41.1
 ;;^UTILITY(U,$J,358.3,16827,2)
 ;;=^50059
 ;;^UTILITY(U,$J,358.3,16828,0)
 ;;=F40.01^^73^845^1
 ;;^UTILITY(U,$J,358.3,16828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16828,1,3,0)
 ;;=3^Agoraphobia w/ panic disorder
 ;;^UTILITY(U,$J,358.3,16828,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,16828,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,16829,0)
 ;;=F40.02^^73^845^2
 ;;^UTILITY(U,$J,358.3,16829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16829,1,3,0)
 ;;=3^Agoraphobia w/o panic disorder
 ;;^UTILITY(U,$J,358.3,16829,1,4,0)
 ;;=4^F40.02
 ;;^UTILITY(U,$J,358.3,16829,2)
 ;;=^5003543
 ;;^UTILITY(U,$J,358.3,16830,0)
 ;;=F42.^^73^845^5
 ;;^UTILITY(U,$J,358.3,16830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16830,1,3,0)
 ;;=3^Obsessive-compulsive disorder
 ;;^UTILITY(U,$J,358.3,16830,1,4,0)
 ;;=4^F42.
 ;;^UTILITY(U,$J,358.3,16830,2)
 ;;=^5003568
 ;;^UTILITY(U,$J,358.3,16831,0)
 ;;=F43.10^^73^845^8
 ;;^UTILITY(U,$J,358.3,16831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16831,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspec
 ;;^UTILITY(U,$J,358.3,16831,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,16831,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,16832,0)
 ;;=F43.12^^73^845^7
 ;;^UTILITY(U,$J,358.3,16832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16832,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,16832,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,16832,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,16833,0)
 ;;=E53.8^^73^846^1
 ;;^UTILITY(U,$J,358.3,16833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16833,1,3,0)
 ;;=3^B Vitamin Deficiency
 ;;^UTILITY(U,$J,358.3,16833,1,4,0)
 ;;=4^E53.8
 ;;^UTILITY(U,$J,358.3,16833,2)
 ;;=^5002797
 ;;^UTILITY(U,$J,358.3,16834,0)
 ;;=R00.1^^73^846^8
 ;;^UTILITY(U,$J,358.3,16834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16834,1,3,0)
 ;;=3^Bradycardia, unspec
 ;;^UTILITY(U,$J,358.3,16834,1,4,0)
 ;;=4^R00.1
 ;;^UTILITY(U,$J,358.3,16834,2)
 ;;=^5019164
 ;;^UTILITY(U,$J,358.3,16835,0)
 ;;=J20.9^^73^846^9
 ;;^UTILITY(U,$J,358.3,16835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16835,1,3,0)
 ;;=3^Bronchitis,Acute,Unspec
 ;;^UTILITY(U,$J,358.3,16835,1,4,0)
 ;;=4^J20.9
 ;;^UTILITY(U,$J,358.3,16835,2)
 ;;=^5008195
 ;;^UTILITY(U,$J,358.3,16836,0)
 ;;=N32.0^^73^846^7
 ;;^UTILITY(U,$J,358.3,16836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16836,1,3,0)
 ;;=3^Bladder-neck obstruction
 ;;^UTILITY(U,$J,358.3,16836,1,4,0)
 ;;=4^N32.0
 ;;^UTILITY(U,$J,358.3,16836,2)
 ;;=^5015649
 ;;^UTILITY(U,$J,358.3,16837,0)
 ;;=N40.0^^73^846^3
 ;;^UTILITY(U,$J,358.3,16837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16837,1,3,0)
 ;;=3^BPH w/o lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,16837,1,4,0)
 ;;=4^N40.0
 ;;^UTILITY(U,$J,358.3,16837,2)
 ;;=^5015689
 ;;^UTILITY(U,$J,358.3,16838,0)
 ;;=N40.1^^73^846^2
 ;;^UTILITY(U,$J,358.3,16838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16838,1,3,0)
 ;;=3^BPH w/ lower urinary tract symptoms
 ;;^UTILITY(U,$J,358.3,16838,1,4,0)
 ;;=4^N40.1
 ;;^UTILITY(U,$J,358.3,16838,2)
 ;;=^5015690
 ;;^UTILITY(U,$J,358.3,16839,0)
 ;;=M71.50^^73^846^10
 ;;^UTILITY(U,$J,358.3,16839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16839,1,3,0)
 ;;=3^Bursitis, Site Unspec NEC
 ;;^UTILITY(U,$J,358.3,16839,1,4,0)
 ;;=4^M71.50
 ;;^UTILITY(U,$J,358.3,16839,2)
 ;;=^5013190
 ;;^UTILITY(U,$J,358.3,16840,0)
 ;;=S39.012A^^73^846^6
 ;;^UTILITY(U,$J,358.3,16840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16840,1,3,0)
 ;;=3^Back strain, lower, unspec, init encntr
 ;;^UTILITY(U,$J,358.3,16840,1,4,0)
 ;;=4^S39.012A
 ;;^UTILITY(U,$J,358.3,16840,2)
 ;;=^5026102
 ;;^UTILITY(U,$J,358.3,16841,0)
 ;;=M54.9^^73^846^4
 ;;^UTILITY(U,$J,358.3,16841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16841,1,3,0)
 ;;=3^Back Pain,Generalized
 ;;^UTILITY(U,$J,358.3,16841,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,16841,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,16842,0)
 ;;=M54.5^^73^846^5
 ;;^UTILITY(U,$J,358.3,16842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16842,1,3,0)
 ;;=3^Back Pain,Lower
 ;;^UTILITY(U,$J,358.3,16842,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,16842,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,16843,0)
 ;;=F31.10^^73^847^1
 ;;^UTILITY(U,$J,358.3,16843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16843,1,3,0)
 ;;=3^Bipolar disord, crnt episode manic w/o psych features, unspec
 ;;^UTILITY(U,$J,358.3,16843,1,4,0)
 ;;=4^F31.10
 ;;^UTILITY(U,$J,358.3,16843,2)
 ;;=^5003495
 ;;^UTILITY(U,$J,358.3,16844,0)
 ;;=F31.30^^73^847^2
 ;;^UTILITY(U,$J,358.3,16844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16844,1,3,0)
 ;;=3^Bipolar disord, crnt epsd depress, mild or mod severt, unspec
 ;;^UTILITY(U,$J,358.3,16844,1,4,0)
 ;;=4^F31.30
 ;;^UTILITY(U,$J,358.3,16844,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,16845,0)
 ;;=F31.60^^73^847^3
 ;;^UTILITY(U,$J,358.3,16845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16845,1,3,0)
 ;;=3^Bipolar disorder, current episode mixed, unspec
 ;;^UTILITY(U,$J,358.3,16845,1,4,0)
 ;;=4^F31.60
 ;;^UTILITY(U,$J,358.3,16845,2)
 ;;=^5003505
 ;;^UTILITY(U,$J,358.3,16846,0)
 ;;=F31.9^^73^847^4
 ;;^UTILITY(U,$J,358.3,16846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16846,1,3,0)
 ;;=3^Bipolar disorder, unspec
 ;;^UTILITY(U,$J,358.3,16846,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,16846,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,16847,0)
 ;;=C15.9^^73^848^6
 ;;^UTILITY(U,$J,358.3,16847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16847,1,3,0)
 ;;=3^Malig Neop of esophagus, unspec
 ;;^UTILITY(U,$J,358.3,16847,1,4,0)
 ;;=4^C15.9
 ;;^UTILITY(U,$J,358.3,16847,2)
 ;;=^5000919
 ;;^UTILITY(U,$J,358.3,16848,0)
 ;;=C18.9^^73^848^5
 ;;^UTILITY(U,$J,358.3,16848,1,0)
 ;;=^358.31IA^4^2
