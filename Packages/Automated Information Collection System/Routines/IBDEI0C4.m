IBDEI0C4 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15361,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,15361,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,15361,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,15362,0)
 ;;=F63.81^^45^687^6
 ;;^UTILITY(U,$J,358.3,15362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15362,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,15362,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,15362,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,15363,0)
 ;;=F63.2^^45^687^7
 ;;^UTILITY(U,$J,358.3,15363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15363,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,15363,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,15363,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,15364,0)
 ;;=F91.3^^45^687^8
 ;;^UTILITY(U,$J,358.3,15364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15364,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,15364,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,15364,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,15365,0)
 ;;=F63.1^^45^687^9
 ;;^UTILITY(U,$J,358.3,15365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15365,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,15365,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,15365,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,15366,0)
 ;;=F91.8^^45^687^4
 ;;^UTILITY(U,$J,358.3,15366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15366,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,15366,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,15366,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,15367,0)
 ;;=F91.9^^45^687^5
 ;;^UTILITY(U,$J,358.3,15367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15367,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15367,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,15367,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,15368,0)
 ;;=F98.0^^45^688^6
 ;;^UTILITY(U,$J,358.3,15368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15368,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,15368,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,15368,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,15369,0)
 ;;=F98.1^^45^688^5
 ;;^UTILITY(U,$J,358.3,15369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15369,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,15369,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,15369,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,15370,0)
 ;;=N39.498^^45^688^3
 ;;^UTILITY(U,$J,358.3,15370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15370,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,15370,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,15370,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,15371,0)
 ;;=R15.9^^45^688^1
 ;;^UTILITY(U,$J,358.3,15371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15371,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,15371,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,15371,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,15372,0)
 ;;=R32.^^45^688^4
 ;;^UTILITY(U,$J,358.3,15372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15372,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,15372,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,15372,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,15373,0)
 ;;=R15.9^^45^688^2
 ;;^UTILITY(U,$J,358.3,15373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15373,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,15373,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,15373,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,15374,0)
 ;;=F63.0^^45^689^1
 ;;^UTILITY(U,$J,358.3,15374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15374,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,15374,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,15374,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,15375,0)
 ;;=F99.^^45^690^1
 ;;^UTILITY(U,$J,358.3,15375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15375,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,15375,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,15375,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,15376,0)
 ;;=F06.8^^45^690^3
 ;;^UTILITY(U,$J,358.3,15376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15376,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,15376,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,15376,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,15377,0)
 ;;=F09.^^45^690^4
 ;;^UTILITY(U,$J,358.3,15377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15377,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,15377,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,15377,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,15378,0)
 ;;=F99.^^45^690^2
 ;;^UTILITY(U,$J,358.3,15378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15378,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15378,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,15378,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,15379,0)
 ;;=F84.0^^45^691^7
 ;;^UTILITY(U,$J,358.3,15379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15379,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,15379,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,15379,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,15380,0)
 ;;=F80.9^^45^691^10
 ;;^UTILITY(U,$J,358.3,15380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15380,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15380,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,15380,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,15381,0)
 ;;=F82.^^45^691^11
 ;;^UTILITY(U,$J,358.3,15381,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15381,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,15381,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,15381,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,15382,0)
 ;;=F88.^^45^691^12
 ;;^UTILITY(U,$J,358.3,15382,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15382,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,15382,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,15382,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,15383,0)
 ;;=F80.2^^45^691^18
 ;;^UTILITY(U,$J,358.3,15383,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15383,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,15383,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,15383,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,15384,0)
 ;;=F81.2^^45^691^19
 ;;^UTILITY(U,$J,358.3,15384,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15384,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,15384,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,15384,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,15385,0)
 ;;=F81.0^^45^691^20
 ;;^UTILITY(U,$J,358.3,15385,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15385,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,15385,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,15385,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,15386,0)
 ;;=F81.81^^45^691^21
 ;;^UTILITY(U,$J,358.3,15386,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15386,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,15386,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,15386,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,15387,0)
 ;;=F88.^^45^691^22
 ;;^UTILITY(U,$J,358.3,15387,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15387,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,15387,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,15387,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,15388,0)
 ;;=F89.^^45^691^23
 ;;^UTILITY(U,$J,358.3,15388,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15388,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15388,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,15388,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,15389,0)
 ;;=F95.1^^45^691^24
 ;;^UTILITY(U,$J,358.3,15389,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15389,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,15389,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,15389,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,15390,0)
 ;;=F95.0^^45^691^26
 ;;^UTILITY(U,$J,358.3,15390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15390,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,15390,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,15390,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,15391,0)
 ;;=F80.89^^45^691^27
 ;;^UTILITY(U,$J,358.3,15391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15391,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,15391,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,15391,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,15392,0)
 ;;=F80.0^^45^691^28
 ;;^UTILITY(U,$J,358.3,15392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15392,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,15392,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,15392,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,15393,0)
 ;;=F98.4^^45^691^29
 ;;^UTILITY(U,$J,358.3,15393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15393,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,15393,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,15393,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,15394,0)
 ;;=F95.8^^45^691^32
 ;;^UTILITY(U,$J,358.3,15394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15394,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,15394,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,15394,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,15395,0)
 ;;=F95.9^^45^691^33
 ;;^UTILITY(U,$J,358.3,15395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15395,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,15395,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,15395,2)
 ;;=^5003710
 ;;^UTILITY(U,$J,358.3,15396,0)
 ;;=F95.2^^45^691^34
 ;;^UTILITY(U,$J,358.3,15396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15396,1,3,0)
 ;;=3^Tourette's Disorder
 ;;^UTILITY(U,$J,358.3,15396,1,4,0)
 ;;=4^F95.2
