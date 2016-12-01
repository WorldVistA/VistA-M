IBDEI0K2 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25390,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,25390,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,25391,0)
 ;;=F91.9^^66^1026^3
 ;;^UTILITY(U,$J,358.3,25391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25391,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,25391,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,25391,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,25392,0)
 ;;=F63.81^^66^1026^6
 ;;^UTILITY(U,$J,358.3,25392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25392,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,25392,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,25392,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,25393,0)
 ;;=F63.2^^66^1026^7
 ;;^UTILITY(U,$J,358.3,25393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25393,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,25393,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,25393,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,25394,0)
 ;;=F91.3^^66^1026^8
 ;;^UTILITY(U,$J,358.3,25394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25394,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,25394,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,25394,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,25395,0)
 ;;=F63.1^^66^1026^9
 ;;^UTILITY(U,$J,358.3,25395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25395,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,25395,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,25395,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,25396,0)
 ;;=F91.8^^66^1026^4
 ;;^UTILITY(U,$J,358.3,25396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25396,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,25396,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,25396,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,25397,0)
 ;;=F91.9^^66^1026^5
 ;;^UTILITY(U,$J,358.3,25397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25397,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25397,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,25397,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,25398,0)
 ;;=F98.0^^66^1027^6
 ;;^UTILITY(U,$J,358.3,25398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25398,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,25398,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,25398,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,25399,0)
 ;;=F98.1^^66^1027^5
 ;;^UTILITY(U,$J,358.3,25399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25399,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,25399,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,25399,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,25400,0)
 ;;=N39.498^^66^1027^3
 ;;^UTILITY(U,$J,358.3,25400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25400,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,25400,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,25400,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,25401,0)
 ;;=R15.9^^66^1027^1
 ;;^UTILITY(U,$J,358.3,25401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25401,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,25401,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,25401,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,25402,0)
 ;;=R32.^^66^1027^4
 ;;^UTILITY(U,$J,358.3,25402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25402,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,25402,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,25402,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,25403,0)
 ;;=R15.9^^66^1027^2
 ;;^UTILITY(U,$J,358.3,25403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25403,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,25403,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,25403,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,25404,0)
 ;;=F63.0^^66^1028^1
 ;;^UTILITY(U,$J,358.3,25404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25404,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,25404,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,25404,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,25405,0)
 ;;=F99.^^66^1029^1
 ;;^UTILITY(U,$J,358.3,25405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25405,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25405,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,25405,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,25406,0)
 ;;=F06.8^^66^1029^3
 ;;^UTILITY(U,$J,358.3,25406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25406,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,25406,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,25406,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,25407,0)
 ;;=F09.^^66^1029^4
 ;;^UTILITY(U,$J,358.3,25407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25407,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,25407,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,25407,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,25408,0)
 ;;=F99.^^66^1029^2
 ;;^UTILITY(U,$J,358.3,25408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25408,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25408,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,25408,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,25409,0)
 ;;=F84.0^^66^1030^7
 ;;^UTILITY(U,$J,358.3,25409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25409,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,25409,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,25409,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,25410,0)
 ;;=F80.9^^66^1030^10
 ;;^UTILITY(U,$J,358.3,25410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25410,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25410,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,25410,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,25411,0)
 ;;=F82.^^66^1030^11
 ;;^UTILITY(U,$J,358.3,25411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25411,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,25411,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,25411,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,25412,0)
 ;;=F88.^^66^1030^12
 ;;^UTILITY(U,$J,358.3,25412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25412,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,25412,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,25412,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,25413,0)
 ;;=F80.2^^66^1030^18
 ;;^UTILITY(U,$J,358.3,25413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25413,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,25413,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,25413,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,25414,0)
 ;;=F81.2^^66^1030^19
 ;;^UTILITY(U,$J,358.3,25414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25414,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,25414,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,25414,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,25415,0)
 ;;=F81.0^^66^1030^20
 ;;^UTILITY(U,$J,358.3,25415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25415,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,25415,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,25415,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,25416,0)
 ;;=F81.81^^66^1030^21
 ;;^UTILITY(U,$J,358.3,25416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25416,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Written Expression
 ;;^UTILITY(U,$J,358.3,25416,1,4,0)
 ;;=4^F81.81
 ;;^UTILITY(U,$J,358.3,25416,2)
 ;;=^5003680
 ;;^UTILITY(U,$J,358.3,25417,0)
 ;;=F88.^^66^1030^22
 ;;^UTILITY(U,$J,358.3,25417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25417,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25417,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,25417,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,25418,0)
 ;;=F89.^^66^1030^23
 ;;^UTILITY(U,$J,358.3,25418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25418,1,3,0)
 ;;=3^Neurodevelopmental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25418,1,4,0)
 ;;=4^F89.
 ;;^UTILITY(U,$J,358.3,25418,2)
 ;;=^5003691
 ;;^UTILITY(U,$J,358.3,25419,0)
 ;;=F95.1^^66^1030^24
 ;;^UTILITY(U,$J,358.3,25419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25419,1,3,0)
 ;;=3^Persistent (Chronic) Motor or Vocal Tic Disorder w/ Motor Tics Only
 ;;^UTILITY(U,$J,358.3,25419,1,4,0)
 ;;=4^F95.1
 ;;^UTILITY(U,$J,358.3,25419,2)
 ;;=^331941
 ;;^UTILITY(U,$J,358.3,25420,0)
 ;;=F95.0^^66^1030^26
 ;;^UTILITY(U,$J,358.3,25420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25420,1,3,0)
 ;;=3^Provisional Tic Disorder
 ;;^UTILITY(U,$J,358.3,25420,1,4,0)
 ;;=4^F95.0
 ;;^UTILITY(U,$J,358.3,25420,2)
 ;;=^331940
 ;;^UTILITY(U,$J,358.3,25421,0)
 ;;=F80.89^^66^1030^27
 ;;^UTILITY(U,$J,358.3,25421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25421,1,3,0)
 ;;=3^Social (Pragmatic) Communication Disorder
 ;;^UTILITY(U,$J,358.3,25421,1,4,0)
 ;;=4^F80.89
 ;;^UTILITY(U,$J,358.3,25421,2)
 ;;=^5003677
 ;;^UTILITY(U,$J,358.3,25422,0)
 ;;=F80.0^^66^1030^28
 ;;^UTILITY(U,$J,358.3,25422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25422,1,3,0)
 ;;=3^Speech Sound Disorder
 ;;^UTILITY(U,$J,358.3,25422,1,4,0)
 ;;=4^F80.0
 ;;^UTILITY(U,$J,358.3,25422,2)
 ;;=^5003674
 ;;^UTILITY(U,$J,358.3,25423,0)
 ;;=F98.4^^66^1030^29
 ;;^UTILITY(U,$J,358.3,25423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25423,1,3,0)
 ;;=3^Stereotypic Movement D/O Assoc w/ Known Med/Gene Cond/Neurod D/O or Environ Factor
 ;;^UTILITY(U,$J,358.3,25423,1,4,0)
 ;;=4^F98.4
 ;;^UTILITY(U,$J,358.3,25423,2)
 ;;=^5003716
 ;;^UTILITY(U,$J,358.3,25424,0)
 ;;=F95.8^^66^1030^32
 ;;^UTILITY(U,$J,358.3,25424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25424,1,3,0)
 ;;=3^Tic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,25424,1,4,0)
 ;;=4^F95.8
 ;;^UTILITY(U,$J,358.3,25424,2)
 ;;=^5003709
 ;;^UTILITY(U,$J,358.3,25425,0)
 ;;=F95.9^^66^1030^33
 ;;^UTILITY(U,$J,358.3,25425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25425,1,3,0)
 ;;=3^Tic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25425,1,4,0)
 ;;=4^F95.9
 ;;^UTILITY(U,$J,358.3,25425,2)
 ;;=^5003710
