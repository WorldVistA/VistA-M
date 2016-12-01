IBDEI0OS ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31418,0)
 ;;=F44.6^^91^1366^3
 ;;^UTILITY(U,$J,358.3,31418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31418,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,31418,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,31418,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,31419,0)
 ;;=F44.5^^91^1366^4
 ;;^UTILITY(U,$J,358.3,31419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31419,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,31419,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,31419,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,31420,0)
 ;;=F44.7^^91^1366^5
 ;;^UTILITY(U,$J,358.3,31420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31420,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,31420,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,31420,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,31421,0)
 ;;=F68.10^^91^1366^10
 ;;^UTILITY(U,$J,358.3,31421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31421,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,31421,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,31421,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,31422,0)
 ;;=F54.^^91^1366^12
 ;;^UTILITY(U,$J,358.3,31422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31422,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,31422,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,31422,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,31423,0)
 ;;=F44.6^^91^1366^6
 ;;^UTILITY(U,$J,358.3,31423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31423,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,31423,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,31423,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,31424,0)
 ;;=F44.4^^91^1366^7
 ;;^UTILITY(U,$J,358.3,31424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31424,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,31424,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,31424,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,31425,0)
 ;;=F44.4^^91^1366^8
 ;;^UTILITY(U,$J,358.3,31425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31425,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,31425,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,31425,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,31426,0)
 ;;=F44.4^^91^1366^9
 ;;^UTILITY(U,$J,358.3,31426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31426,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,31426,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,31426,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,31427,0)
 ;;=F45.21^^91^1366^11
 ;;^UTILITY(U,$J,358.3,31427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31427,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,31427,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,31427,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,31428,0)
 ;;=F91.2^^91^1367^1
 ;;^UTILITY(U,$J,358.3,31428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31428,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,31428,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,31428,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,31429,0)
 ;;=F91.1^^91^1367^2
 ;;^UTILITY(U,$J,358.3,31429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31429,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,31429,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,31429,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,31430,0)
 ;;=F91.9^^91^1367^3
 ;;^UTILITY(U,$J,358.3,31430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31430,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,31430,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,31430,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,31431,0)
 ;;=F63.81^^91^1367^6
 ;;^UTILITY(U,$J,358.3,31431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31431,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,31431,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,31431,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,31432,0)
 ;;=F63.2^^91^1367^7
 ;;^UTILITY(U,$J,358.3,31432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31432,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,31432,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,31432,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,31433,0)
 ;;=F91.3^^91^1367^8
 ;;^UTILITY(U,$J,358.3,31433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31433,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,31433,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,31433,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,31434,0)
 ;;=F63.1^^91^1367^9
 ;;^UTILITY(U,$J,358.3,31434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31434,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,31434,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,31434,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,31435,0)
 ;;=F91.8^^91^1367^4
 ;;^UTILITY(U,$J,358.3,31435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31435,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,31435,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,31435,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,31436,0)
 ;;=F91.9^^91^1367^5
 ;;^UTILITY(U,$J,358.3,31436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31436,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31436,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,31436,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,31437,0)
 ;;=F98.0^^91^1368^6
 ;;^UTILITY(U,$J,358.3,31437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31437,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,31437,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,31437,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,31438,0)
 ;;=F98.1^^91^1368^5
 ;;^UTILITY(U,$J,358.3,31438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31438,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,31438,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,31438,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,31439,0)
 ;;=N39.498^^91^1368^3
 ;;^UTILITY(U,$J,358.3,31439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31439,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,31439,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,31439,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,31440,0)
 ;;=R15.9^^91^1368^1
 ;;^UTILITY(U,$J,358.3,31440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31440,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,31440,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,31440,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,31441,0)
 ;;=R32.^^91^1368^4
 ;;^UTILITY(U,$J,358.3,31441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31441,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,31441,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,31441,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,31442,0)
 ;;=R15.9^^91^1368^2
 ;;^UTILITY(U,$J,358.3,31442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31442,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,31442,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,31442,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,31443,0)
 ;;=F63.0^^91^1369^1
 ;;^UTILITY(U,$J,358.3,31443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31443,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,31443,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,31443,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,31444,0)
 ;;=F99.^^91^1370^1
 ;;^UTILITY(U,$J,358.3,31444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31444,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,31444,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,31444,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,31445,0)
 ;;=F06.8^^91^1370^3
 ;;^UTILITY(U,$J,358.3,31445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31445,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,31445,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,31445,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,31446,0)
 ;;=F09.^^91^1370^4
 ;;^UTILITY(U,$J,358.3,31446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31446,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,31446,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,31446,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,31447,0)
 ;;=F99.^^91^1370^2
 ;;^UTILITY(U,$J,358.3,31447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31447,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31447,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,31447,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,31448,0)
 ;;=F84.0^^91^1371^7
 ;;^UTILITY(U,$J,358.3,31448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31448,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,31448,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,31448,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,31449,0)
 ;;=F80.9^^91^1371^10
 ;;^UTILITY(U,$J,358.3,31449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31449,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,31449,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,31449,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,31450,0)
 ;;=F82.^^91^1371^11
 ;;^UTILITY(U,$J,358.3,31450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31450,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,31450,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,31450,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,31451,0)
 ;;=F88.^^91^1371^12
 ;;^UTILITY(U,$J,358.3,31451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31451,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,31451,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,31451,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,31452,0)
 ;;=F80.2^^91^1371^18
 ;;^UTILITY(U,$J,358.3,31452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31452,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,31452,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,31452,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,31453,0)
 ;;=F81.2^^91^1371^19
 ;;^UTILITY(U,$J,358.3,31453,1,0)
 ;;=^358.31IA^4^2
