IBDEI0JF ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24607,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,24607,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,24607,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,24608,0)
 ;;=F91.9^^64^980^3
 ;;^UTILITY(U,$J,358.3,24608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24608,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,24608,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,24608,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,24609,0)
 ;;=F63.81^^64^980^6
 ;;^UTILITY(U,$J,358.3,24609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24609,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,24609,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,24609,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,24610,0)
 ;;=F63.2^^64^980^7
 ;;^UTILITY(U,$J,358.3,24610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24610,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,24610,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,24610,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,24611,0)
 ;;=F91.3^^64^980^8
 ;;^UTILITY(U,$J,358.3,24611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24611,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,24611,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,24611,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,24612,0)
 ;;=F63.1^^64^980^9
 ;;^UTILITY(U,$J,358.3,24612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24612,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,24612,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,24612,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,24613,0)
 ;;=F91.8^^64^980^4
 ;;^UTILITY(U,$J,358.3,24613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24613,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,24613,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,24613,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,24614,0)
 ;;=F91.9^^64^980^5
 ;;^UTILITY(U,$J,358.3,24614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24614,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24614,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,24614,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,24615,0)
 ;;=F98.0^^64^981^6
 ;;^UTILITY(U,$J,358.3,24615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24615,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,24615,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,24615,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,24616,0)
 ;;=F98.1^^64^981^5
 ;;^UTILITY(U,$J,358.3,24616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24616,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,24616,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,24616,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,24617,0)
 ;;=N39.498^^64^981^3
 ;;^UTILITY(U,$J,358.3,24617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24617,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,24617,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,24617,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,24618,0)
 ;;=R15.9^^64^981^1
 ;;^UTILITY(U,$J,358.3,24618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24618,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,24618,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,24618,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,24619,0)
 ;;=R32.^^64^981^4
 ;;^UTILITY(U,$J,358.3,24619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24619,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,24619,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,24619,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,24620,0)
 ;;=R15.9^^64^981^2
 ;;^UTILITY(U,$J,358.3,24620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24620,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,24620,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,24620,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,24621,0)
 ;;=F63.0^^64^982^1
 ;;^UTILITY(U,$J,358.3,24621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24621,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,24621,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,24621,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,24622,0)
 ;;=F99.^^64^983^1
 ;;^UTILITY(U,$J,358.3,24622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24622,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,24622,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,24622,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,24623,0)
 ;;=F06.8^^64^983^3
 ;;^UTILITY(U,$J,358.3,24623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24623,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,24623,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,24623,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,24624,0)
 ;;=F09.^^64^983^4
 ;;^UTILITY(U,$J,358.3,24624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24624,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,24624,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,24624,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,24625,0)
 ;;=F99.^^64^983^2
 ;;^UTILITY(U,$J,358.3,24625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24625,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24625,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,24625,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,24626,0)
 ;;=F84.0^^64^984^7
 ;;^UTILITY(U,$J,358.3,24626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24626,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,24626,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,24626,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,24627,0)
 ;;=F80.9^^64^984^10
 ;;^UTILITY(U,$J,358.3,24627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24627,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24627,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,24627,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,24628,0)
 ;;=F82.^^64^984^11
 ;;^UTILITY(U,$J,358.3,24628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24628,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,24628,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,24628,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,24629,0)
 ;;=F88.^^64^984^12
 ;;^UTILITY(U,$J,358.3,24629,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24629,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,24629,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,24629,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,24630,0)
 ;;=F80.2^^64^984^18
 ;;^UTILITY(U,$J,358.3,24630,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24630,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,24630,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,24630,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,24631,0)
 ;;=F81.2^^64^984^19
 ;;^UTILITY(U,$J,358.3,24631,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24631,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,24631,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,24631,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,24632,0)
 ;;=F81.0^^64^984^20
 ;;^UTILITY(U,$J,358.3,24632,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24632,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,24632,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,24632,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,24633,0)
 ;;=F81.81^^64^984^21
 ;;^UTILITY(U,$J,358.3,24633,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24633,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,24633,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,24633,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,24634,0)
 ;;=F88.^^64^984^22
 ;;^UTILITY(U,$J,358.3,24634,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24634,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,24634,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,24634,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,24635,0)
 ;;=F89.^^64^984^23
 ;;^UTILITY(U,$J,358.3,24635,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24635,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24635,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,24635,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,24636,0)
 ;;=F95.1^^64^984^24
 ;;^UTILITY(U,$J,358.3,24636,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24636,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,24636,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,24636,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,24637,0)
 ;;=F95.0^^64^984^26
 ;;^UTILITY(U,$J,358.3,24637,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24637,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,24637,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,24637,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,24638,0)
 ;;=F80.89^^64^984^27
 ;;^UTILITY(U,$J,358.3,24638,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24638,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,24638,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,24638,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,24639,0)
 ;;=F80.0^^64^984^28
 ;;^UTILITY(U,$J,358.3,24639,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24639,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,24639,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,24639,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,24640,0)
 ;;=F98.4^^64^984^29
 ;;^UTILITY(U,$J,358.3,24640,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24640,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,24640,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,24640,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,24641,0)
 ;;=F95.8^^64^984^32
 ;;^UTILITY(U,$J,358.3,24641,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24641,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,24641,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,24641,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,24642,0)
 ;;=F95.9^^64^984^33
 ;;^UTILITY(U,$J,358.3,24642,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24642,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,24642,1,4,0)
 ;;=4^F95.9
