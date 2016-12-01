IBDEI0K3 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25426,0)
 ;;=F95.2^^66^1030^34
 ;;^UTILITY(U,$J,358.3,25426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25426,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,25426,1,4,0)
 ;;=4^F95.2
 ;;^UTILITY(U,$J,358.3,25426,2)
 ;;=^331942
 ;;^UTILITY(U,$J,358.3,25427,0)
 ;;=F98.5^^66^1030^1
 ;;^UTILITY(U,$J,358.3,25427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25427,1,3,0)
 ;;=3^Adult-Onset Fluency Disorder
 ;;^UTILITY(U,$J,358.3,25427,1,4,0)
 ;;=4^F98.5
 ;;^UTILITY(U,$J,358.3,25427,2)
 ;;=^5003717
 ;;^UTILITY(U,$J,358.3,25428,0)
 ;;=F90.2^^66^1030^2
 ;;^UTILITY(U,$J,358.3,25428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25428,1,3,0)
 ;;=3^Attention Deficit Disorder,Combined Presentation
 ;;^UTILITY(U,$J,358.3,25428,1,4,0)
 ;;=4^F90.2
 ;;^UTILITY(U,$J,358.3,25428,2)
 ;;=^5003694
 ;;^UTILITY(U,$J,358.3,25429,0)
 ;;=F90.1^^66^1030^3
 ;;^UTILITY(U,$J,358.3,25429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25429,1,3,0)
 ;;=3^Attention Deficit Disorder,Hyperactive/Impulsive Presentation
 ;;^UTILITY(U,$J,358.3,25429,1,4,0)
 ;;=4^F90.1
 ;;^UTILITY(U,$J,358.3,25429,2)
 ;;=^5003693
 ;;^UTILITY(U,$J,358.3,25430,0)
 ;;=F90.0^^66^1030^4
 ;;^UTILITY(U,$J,358.3,25430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25430,1,3,0)
 ;;=3^Attention Deficit Disorder,Predominantly Inattentive Presentation
 ;;^UTILITY(U,$J,358.3,25430,1,4,0)
 ;;=4^F90.0
 ;;^UTILITY(U,$J,358.3,25430,2)
 ;;=^5003692
 ;;^UTILITY(U,$J,358.3,25431,0)
 ;;=F06.1^^66^1030^8
 ;;^UTILITY(U,$J,358.3,25431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25431,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,25431,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,25431,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,25432,0)
 ;;=F80.81^^66^1030^9
 ;;^UTILITY(U,$J,358.3,25432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25432,1,3,0)
 ;;=3^Child-Onset Fluency Disorder (Stuttering)
 ;;^UTILITY(U,$J,358.3,25432,1,4,0)
 ;;=4^F80.81
 ;;^UTILITY(U,$J,358.3,25432,2)
 ;;=^5003676
 ;;^UTILITY(U,$J,358.3,25433,0)
 ;;=F70.^^66^1030^13
 ;;^UTILITY(U,$J,358.3,25433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25433,1,3,0)
 ;;=3^Intellectual Disability,Mild
 ;;^UTILITY(U,$J,358.3,25433,1,4,0)
 ;;=4^F70.
 ;;^UTILITY(U,$J,358.3,25433,2)
 ;;=^5003668
 ;;^UTILITY(U,$J,358.3,25434,0)
 ;;=F71.^^66^1030^14
 ;;^UTILITY(U,$J,358.3,25434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25434,1,3,0)
 ;;=3^Intellectual Disability,Moderate
 ;;^UTILITY(U,$J,358.3,25434,1,4,0)
 ;;=4^F71.
 ;;^UTILITY(U,$J,358.3,25434,2)
 ;;=^5003669
 ;;^UTILITY(U,$J,358.3,25435,0)
 ;;=F73.^^66^1030^15
 ;;^UTILITY(U,$J,358.3,25435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25435,1,3,0)
 ;;=3^Intellectual Disability,Profound
 ;;^UTILITY(U,$J,358.3,25435,1,4,0)
 ;;=4^F73.
 ;;^UTILITY(U,$J,358.3,25435,2)
 ;;=^5003671
 ;;^UTILITY(U,$J,358.3,25436,0)
 ;;=F72.^^66^1030^16
 ;;^UTILITY(U,$J,358.3,25436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25436,1,3,0)
 ;;=3^Intellectual Disability,Severe
 ;;^UTILITY(U,$J,358.3,25436,1,4,0)
 ;;=4^F72.
 ;;^UTILITY(U,$J,358.3,25436,2)
 ;;=^5003670
 ;;^UTILITY(U,$J,358.3,25437,0)
 ;;=F90.8^^66^1030^5
 ;;^UTILITY(U,$J,358.3,25437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25437,1,3,0)
 ;;=3^Attention Deficit/Hyperactivity Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,25437,1,4,0)
 ;;=4^F90.8
 ;;^UTILITY(U,$J,358.3,25437,2)
 ;;=^5003695
 ;;^UTILITY(U,$J,358.3,25438,0)
 ;;=F95.1^^66^1030^25
 ;;^UTILITY(U,$J,358.3,25438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25438,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Vocal Tics Only
 ;;^UTILITY(U,$J,358.3,25438,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,25438,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,25439,0)
 ;;=F98.4^^66^1030^30
 ;;^UTILITY(U,$J,358.3,25439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25439,1,3,0)
 ;;=3^Stereotypic Movement D/O w/ Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,25439,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,25439,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,25440,0)
 ;;=F98.4^^66^1030^31
 ;;^UTILITY(U,$J,358.3,25440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25440,1,3,0)
 ;;=3^Stereotypic Movement D/O w/o Self-Injurious Behavior
 ;;^UTILITY(U,$J,358.3,25440,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,25440,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,25441,0)
 ;;=F90.9^^66^1030^6
 ;;^UTILITY(U,$J,358.3,25441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25441,1,3,0)
 ;;=3^Attention Deficit/Hyperativity Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25441,1,4,0)
 ;;=4^F90.9
 ;;^UTILITY(U,$J,358.3,25441,2)
 ;;=^5003696
 ;;^UTILITY(U,$J,358.3,25442,0)
 ;;=F79.^^66^1030^17
 ;;^UTILITY(U,$J,358.3,25442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25442,1,3,0)
 ;;=3^Intellectual Disability,Unspec
 ;;^UTILITY(U,$J,358.3,25442,1,4,0)
 ;;=4^F79.
 ;;^UTILITY(U,$J,358.3,25442,2)
 ;;=^5003673
 ;;^UTILITY(U,$J,358.3,25443,0)
 ;;=F15.929^^66^1031^7
 ;;^UTILITY(U,$J,358.3,25443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25443,1,3,0)
 ;;=3^Caffeine Intoxication
 ;;^UTILITY(U,$J,358.3,25443,1,4,0)
 ;;=4^F15.929
 ;;^UTILITY(U,$J,358.3,25443,2)
 ;;=^5003314
 ;;^UTILITY(U,$J,358.3,25444,0)
 ;;=F15.93^^66^1031^8
 ;;^UTILITY(U,$J,358.3,25444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25444,1,3,0)
 ;;=3^Caffeine Withdrawal
 ;;^UTILITY(U,$J,358.3,25444,1,4,0)
 ;;=4^F15.93
 ;;^UTILITY(U,$J,358.3,25444,2)
 ;;=^5003315
 ;;^UTILITY(U,$J,358.3,25445,0)
 ;;=F15.180^^66^1031^1
 ;;^UTILITY(U,$J,358.3,25445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25445,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25445,1,4,0)
 ;;=4^F15.180
 ;;^UTILITY(U,$J,358.3,25445,2)
 ;;=^5003291
 ;;^UTILITY(U,$J,358.3,25446,0)
 ;;=F15.280^^66^1031^2
 ;;^UTILITY(U,$J,358.3,25446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25446,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25446,1,4,0)
 ;;=4^F15.280
 ;;^UTILITY(U,$J,358.3,25446,2)
 ;;=^5003306
 ;;^UTILITY(U,$J,358.3,25447,0)
 ;;=F15.980^^66^1031^3
 ;;^UTILITY(U,$J,358.3,25447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25447,1,3,0)
 ;;=3^Caffeine Induced Anxiety Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25447,1,4,0)
 ;;=4^F15.980
 ;;^UTILITY(U,$J,358.3,25447,2)
 ;;=^5003320
 ;;^UTILITY(U,$J,358.3,25448,0)
 ;;=F15.182^^66^1031^4
 ;;^UTILITY(U,$J,358.3,25448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25448,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,25448,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,25448,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,25449,0)
 ;;=F15.282^^66^1031^5
 ;;^UTILITY(U,$J,358.3,25449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25449,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/ Mod/Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,25449,1,4,0)
 ;;=4^F15.282
 ;;^UTILITY(U,$J,358.3,25449,2)
 ;;=^5003308
 ;;^UTILITY(U,$J,358.3,25450,0)
 ;;=F15.982^^66^1031^6
 ;;^UTILITY(U,$J,358.3,25450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25450,1,3,0)
 ;;=3^Caffeine Induced Sleep Disorder w/o Use Disorder
 ;;^UTILITY(U,$J,358.3,25450,1,4,0)
 ;;=4^F15.982
 ;;^UTILITY(U,$J,358.3,25450,2)
 ;;=^5003322
 ;;^UTILITY(U,$J,358.3,25451,0)
 ;;=F15.99^^66^1031^9
 ;;^UTILITY(U,$J,358.3,25451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25451,1,3,0)
 ;;=3^Caffeinie Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25451,1,4,0)
 ;;=4^F15.99
 ;;^UTILITY(U,$J,358.3,25451,2)
 ;;=^5133358
 ;;^UTILITY(U,$J,358.3,25452,0)
 ;;=R45.851^^66^1032^1
 ;;^UTILITY(U,$J,358.3,25452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25452,1,3,0)
 ;;=3^Suicidal Ideations
 ;;^UTILITY(U,$J,358.3,25452,1,4,0)
 ;;=4^R45.851
 ;;^UTILITY(U,$J,358.3,25452,2)
 ;;=^5019474
 ;;^UTILITY(U,$J,358.3,25453,0)
 ;;=F19.14^^66^1033^1
 ;;^UTILITY(U,$J,358.3,25453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25453,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25453,1,4,0)
 ;;=4^F19.14
 ;;^UTILITY(U,$J,358.3,25453,2)
 ;;=^5003421
 ;;^UTILITY(U,$J,358.3,25454,0)
 ;;=F19.24^^66^1033^2
 ;;^UTILITY(U,$J,358.3,25454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25454,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25454,1,4,0)
 ;;=4^F19.24
 ;;^UTILITY(U,$J,358.3,25454,2)
 ;;=^5003441
 ;;^UTILITY(U,$J,358.3,25455,0)
 ;;=F19.94^^66^1033^3
 ;;^UTILITY(U,$J,358.3,25455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25455,1,3,0)
 ;;=3^Other/Unknown Substance Induced Depressive D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25455,1,4,0)
 ;;=4^F19.94
 ;;^UTILITY(U,$J,358.3,25455,2)
 ;;=^5003460
 ;;^UTILITY(U,$J,358.3,25456,0)
 ;;=F19.17^^66^1033^4
 ;;^UTILITY(U,$J,358.3,25456,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25456,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25456,1,4,0)
 ;;=4^F19.17
 ;;^UTILITY(U,$J,358.3,25456,2)
 ;;=^5003426
 ;;^UTILITY(U,$J,358.3,25457,0)
 ;;=F19.27^^66^1033^5
 ;;^UTILITY(U,$J,358.3,25457,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25457,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/ Mod-Sev Use D/O
 ;;^UTILITY(U,$J,358.3,25457,1,4,0)
 ;;=4^F19.27
 ;;^UTILITY(U,$J,358.3,25457,2)
 ;;=^5003446
 ;;^UTILITY(U,$J,358.3,25458,0)
 ;;=F19.97^^66^1033^6
 ;;^UTILITY(U,$J,358.3,25458,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25458,1,3,0)
 ;;=3^Other/Unknown Substance Induced Maj Neurocog D/O w/o Use D/O
 ;;^UTILITY(U,$J,358.3,25458,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,25458,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,25459,0)
 ;;=F19.188^^66^1033^7
 ;;^UTILITY(U,$J,358.3,25459,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25459,1,3,0)
 ;;=3^Other/Unknown Substance Induced Mild Neurocog D/O w/ Mild Use D/O
 ;;^UTILITY(U,$J,358.3,25459,1,4,0)
 ;;=4^F19.188
