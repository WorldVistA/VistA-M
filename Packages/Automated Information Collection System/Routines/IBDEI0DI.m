IBDEI0DI ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13495,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,13495,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,13496,0)
 ;;=F91.9^^58^705^5
 ;;^UTILITY(U,$J,358.3,13496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13496,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13496,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,13496,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,13497,0)
 ;;=F98.0^^58^706^6
 ;;^UTILITY(U,$J,358.3,13497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13497,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,13497,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,13497,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,13498,0)
 ;;=F98.1^^58^706^5
 ;;^UTILITY(U,$J,358.3,13498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13498,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,13498,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,13498,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,13499,0)
 ;;=N39.498^^58^706^3
 ;;^UTILITY(U,$J,358.3,13499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13499,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,13499,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,13499,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,13500,0)
 ;;=R15.9^^58^706^1
 ;;^UTILITY(U,$J,358.3,13500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13500,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,13500,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,13500,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,13501,0)
 ;;=R32.^^58^706^4
 ;;^UTILITY(U,$J,358.3,13501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13501,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,13501,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,13501,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,13502,0)
 ;;=R15.9^^58^706^2
 ;;^UTILITY(U,$J,358.3,13502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13502,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,13502,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,13502,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,13503,0)
 ;;=F63.0^^58^707^1
 ;;^UTILITY(U,$J,358.3,13503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13503,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,13503,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,13503,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,13504,0)
 ;;=F99.^^58^708^1
 ;;^UTILITY(U,$J,358.3,13504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13504,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,13504,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,13504,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,13505,0)
 ;;=F06.8^^58^708^3
 ;;^UTILITY(U,$J,358.3,13505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13505,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,13505,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,13505,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,13506,0)
 ;;=F09.^^58^708^4
 ;;^UTILITY(U,$J,358.3,13506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13506,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,13506,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,13506,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,13507,0)
 ;;=F99.^^58^708^2
 ;;^UTILITY(U,$J,358.3,13507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13507,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13507,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,13507,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,13508,0)
 ;;=F84.0^^58^709^7
 ;;^UTILITY(U,$J,358.3,13508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13508,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,13508,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,13508,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,13509,0)
 ;;=F80.9^^58^709^10
 ;;^UTILITY(U,$J,358.3,13509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13509,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13509,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,13509,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,13510,0)
 ;;=F82.^^58^709^11
 ;;^UTILITY(U,$J,358.3,13510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13510,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,13510,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,13510,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,13511,0)
 ;;=F88.^^58^709^12
 ;;^UTILITY(U,$J,358.3,13511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13511,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,13511,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,13511,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,13512,0)
 ;;=F80.2^^58^709^18
 ;;^UTILITY(U,$J,358.3,13512,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13512,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,13512,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,13512,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,13513,0)
 ;;=F81.2^^58^709^19
 ;;^UTILITY(U,$J,358.3,13513,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13513,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,13513,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,13513,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,13514,0)
 ;;=F81.0^^58^709^20
 ;;^UTILITY(U,$J,358.3,13514,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13514,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,13514,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,13514,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,13515,0)
 ;;=F81.81^^58^709^21
 ;;^UTILITY(U,$J,358.3,13515,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13515,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,13515,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,13515,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,13516,0)
 ;;=F88.^^58^709^22
 ;;^UTILITY(U,$J,358.3,13516,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13516,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,13516,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,13516,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,13517,0)
 ;;=F89.^^58^709^23
 ;;^UTILITY(U,$J,358.3,13517,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13517,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13517,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,13517,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,13518,0)
 ;;=F95.1^^58^709^24
 ;;^UTILITY(U,$J,358.3,13518,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13518,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,13518,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,13518,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,13519,0)
 ;;=F95.0^^58^709^26
 ;;^UTILITY(U,$J,358.3,13519,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13519,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,13519,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,13519,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,13520,0)
 ;;=F80.89^^58^709^27
 ;;^UTILITY(U,$J,358.3,13520,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13520,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,13520,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,13520,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,13521,0)
 ;;=F80.0^^58^709^28
 ;;^UTILITY(U,$J,358.3,13521,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13521,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,13521,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,13521,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,13522,0)
 ;;=F98.4^^58^709^29
 ;;^UTILITY(U,$J,358.3,13522,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13522,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,13522,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,13522,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,13523,0)
 ;;=F95.8^^58^709^32
 ;;^UTILITY(U,$J,358.3,13523,1,0)
 ;;=^358.31IA^4^2
