IBDEI0IS ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23817,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,23817,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,23818,0)
 ;;=F80.2^^61^932^18
 ;;^UTILITY(U,$J,358.3,23818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23818,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,23818,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,23818,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,23819,0)
 ;;=F81.2^^61^932^19
 ;;^UTILITY(U,$J,358.3,23819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23819,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,23819,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,23819,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,23820,0)
 ;;=F81.0^^61^932^20
 ;;^UTILITY(U,$J,358.3,23820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23820,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,23820,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,23820,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,23821,0)
 ;;=F81.81^^61^932^21
 ;;^UTILITY(U,$J,358.3,23821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23821,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,23821,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,23821,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,23822,0)
 ;;=F88.^^61^932^22
 ;;^UTILITY(U,$J,358.3,23822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23822,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,23822,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,23822,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,23823,0)
 ;;=F89.^^61^932^23
 ;;^UTILITY(U,$J,358.3,23823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23823,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23823,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,23823,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,23824,0)
 ;;=F95.1^^61^932^24
 ;;^UTILITY(U,$J,358.3,23824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23824,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,23824,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,23824,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,23825,0)
 ;;=F95.0^^61^932^26
 ;;^UTILITY(U,$J,358.3,23825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23825,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,23825,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,23825,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,23826,0)
 ;;=F80.89^^61^932^27
 ;;^UTILITY(U,$J,358.3,23826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23826,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,23826,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,23826,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,23827,0)
 ;;=F80.0^^61^932^28
 ;;^UTILITY(U,$J,358.3,23827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23827,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,23827,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,23827,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,23828,0)
 ;;=F98.4^^61^932^29
 ;;^UTILITY(U,$J,358.3,23828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23828,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,23828,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,23828,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,23829,0)
 ;;=F95.8^^61^932^32
 ;;^UTILITY(U,$J,358.3,23829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23829,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,23829,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,23829,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,23830,0)
 ;;=F95.9^^61^932^33
 ;;^UTILITY(U,$J,358.3,23830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23830,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23830,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,23830,2)
 ;;=^5003710
 ;;^UTILITY(U,$J,358.3,23831,0)
 ;;=F95.2^^61^932^34
 ;;^UTILITY(U,$J,358.3,23831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23831,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,23831,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,23831,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,23832,0)
 ;;=F98.5^^61^932^1
 ;;^UTILITY(U,$J,358.3,23832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23832,1,3,0)
 ;;=3^Adult-Onset Fluency Disorder
 ;;^UTILITY(U,$J,358.3,23832,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,23832,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,23833,0)
 ;;=F90.2^^61^932^2
 ;;^UTILITY(U,$J,358.3,23833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23833,1,3,0)
 ;;=3^Attention Deficit Disorder,Combined Presentation
 ;;^UTILITY(U,$J,358.3,23833,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,23833,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,23834,0)
 ;;=F90.1^^61^932^3
 ;;^UTILITY(U,$J,358.3,23834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23834,1,3,0)
 ;;=3^Attention Deficit Disorder,Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,23834,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,23834,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,23835,0)
 ;;=F90.0^^61^932^4
 ;;^UTILITY(U,$J,358.3,23835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23835,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,23835,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,23835,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,23836,0)
 ;;=F06.1^^61^932^8
 ;;^UTILITY(U,$J,358.3,23836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23836,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,23836,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,23836,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,23837,0)
 ;;=F80.81^^61^932^9
 ;;^UTILITY(U,$J,358.3,23837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23837,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
 ;;^UTILITY(U,$J,358.3,23837,1,4,0)
 ;;=4^F80.81
 ;;^UTILITY(U,$J,358.3,23837,2)
 ;;=^5003676
 ;;^UTILITY(U,$J,358.3,23838,0)
 ;;=F70.^^61^932^13
 ;;^UTILITY(U,$J,358.3,23838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23838,1,3,0)
 ;;=3^Intellectual Disability,Mild
 ;;^UTILITY(U,$J,358.3,23838,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,23838,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,23839,0)
 ;;=F71.^^61^932^14
 ;;^UTILITY(U,$J,358.3,23839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23839,1,3,0)
 ;;=3^Intellectual Disability,Moderate
 ;;^UTILITY(U,$J,358.3,23839,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,23839,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,23840,0)
 ;;=F73.^^61^932^15
 ;;^UTILITY(U,$J,358.3,23840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23840,1,3,0)
 ;;=3^Intellectual Disability,Profound
 ;;^UTILITY(U,$J,358.3,23840,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,23840,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,23841,0)
 ;;=F72.^^61^932^16
 ;;^UTILITY(U,$J,358.3,23841,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23841,1,3,0)
 ;;=3^Intellectual Disability,Severe
 ;;^UTILITY(U,$J,358.3,23841,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,23841,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,23842,0)
 ;;=F90.8^^61^932^5
 ;;^UTILITY(U,$J,358.3,23842,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23842,1,3,0)
 ;;=3^Attention Deficit/Hyperactivity Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,23842,1,4,0)
 ;;=4^F90.8
 ;;^UTILITY(U,$J,358.3,23842,2)
 ;;=^5003695
 ;;^UTILITY(U,$J,358.3,23843,0)
 ;;=F95.1^^61^932^25
 ;;^UTILITY(U,$J,358.3,23843,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23843,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Vocal Tics Only
 ;;^UTILITY(U,$J,358.3,23843,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,23843,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,23844,0)
 ;;=F98.4^^61^932^30
 ;;^UTILITY(U,$J,358.3,23844,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23844,1,3,0)
 ;;=3^Stereotypic Movement D/O w/ Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,23844,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,23844,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,23845,0)
 ;;=F98.4^^61^932^31
 ;;^UTILITY(U,$J,358.3,23845,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23845,1,3,0)
 ;;=3^Stereotypic Movement D/O w/o Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,23845,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,23845,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,23846,0)
 ;;=F90.9^^61^932^6
 ;;^UTILITY(U,$J,358.3,23846,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23846,1,3,0)
 ;;=3^Attention Deficit/Hyperativity Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23846,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,23846,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,23847,0)
 ;;=F79.^^61^932^17
 ;;^UTILITY(U,$J,358.3,23847,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23847,1,3,0)
 ;;=3^Intellectual Disability,Unspec
 ;;^UTILITY(U,$J,358.3,23847,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,23847,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,23848,0)
 ;;=F15.929^^61^933^7
 ;;^UTILITY(U,$J,358.3,23848,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23848,1,3,0)
 ;;=3^Caffeine Intoxication
 ;;^UTILITY(U,$J,358.3,23848,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,23848,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,23849,0)
 ;;=F15.93^^61^933^8
 ;;^UTILITY(U,$J,358.3,23849,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23849,1,3,0)
 ;;=3^Caffeine Withdrawal
 ;;^UTILITY(U,$J,358.3,23849,1,4,0)
 ;;=4^F15.93
 ;;^UTILITY(U,$J,358.3,23849,2)
 ;;=^5003315
 ;;^UTILITY(U,$J,358.3,23850,0)
 ;;=F15.180^^61^933^1
 ;;^UTILITY(U,$J,358.3,23850,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23850,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,23850,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,23850,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,23851,0)
 ;;=F15.280^^61^933^2
 ;;^UTILITY(U,$J,358.3,23851,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23851,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,23851,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,23851,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,23852,0)
 ;;=F15.980^^61^933^3
 ;;^UTILITY(U,$J,358.3,23852,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23852,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/o Use Disorder
