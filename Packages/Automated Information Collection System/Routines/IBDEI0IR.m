IBDEI0IR ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23782,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,23782,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,23782,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,23783,0)
 ;;=F44.4^^61^927^2
 ;;^UTILITY(U,$J,358.3,23783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23783,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,23783,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,23783,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,23784,0)
 ;;=F44.6^^61^927^3
 ;;^UTILITY(U,$J,358.3,23784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23784,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,23784,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,23784,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,23785,0)
 ;;=F44.5^^61^927^4
 ;;^UTILITY(U,$J,358.3,23785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23785,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,23785,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,23785,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,23786,0)
 ;;=F44.7^^61^927^5
 ;;^UTILITY(U,$J,358.3,23786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23786,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,23786,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,23786,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,23787,0)
 ;;=F68.10^^61^927^10
 ;;^UTILITY(U,$J,358.3,23787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23787,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,23787,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,23787,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,23788,0)
 ;;=F54.^^61^927^12
 ;;^UTILITY(U,$J,358.3,23788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23788,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,23788,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,23788,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,23789,0)
 ;;=F44.6^^61^927^6
 ;;^UTILITY(U,$J,358.3,23789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23789,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,23789,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,23789,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,23790,0)
 ;;=F44.4^^61^927^7
 ;;^UTILITY(U,$J,358.3,23790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23790,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,23790,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,23790,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,23791,0)
 ;;=F44.4^^61^927^8
 ;;^UTILITY(U,$J,358.3,23791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23791,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,23791,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,23791,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,23792,0)
 ;;=F44.4^^61^927^9
 ;;^UTILITY(U,$J,358.3,23792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23792,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,23792,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,23792,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,23793,0)
 ;;=F45.21^^61^927^11
 ;;^UTILITY(U,$J,358.3,23793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23793,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,23793,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,23793,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,23794,0)
 ;;=F91.2^^61^928^1
 ;;^UTILITY(U,$J,358.3,23794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23794,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,23794,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,23794,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,23795,0)
 ;;=F91.1^^61^928^2
 ;;^UTILITY(U,$J,358.3,23795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23795,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,23795,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,23795,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,23796,0)
 ;;=F91.9^^61^928^3
 ;;^UTILITY(U,$J,358.3,23796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23796,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,23796,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,23796,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,23797,0)
 ;;=F63.81^^61^928^6
 ;;^UTILITY(U,$J,358.3,23797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23797,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,23797,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,23797,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,23798,0)
 ;;=F63.2^^61^928^7
 ;;^UTILITY(U,$J,358.3,23798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23798,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,23798,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,23798,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,23799,0)
 ;;=F91.3^^61^928^8
 ;;^UTILITY(U,$J,358.3,23799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23799,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,23799,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,23799,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,23800,0)
 ;;=F63.1^^61^928^9
 ;;^UTILITY(U,$J,358.3,23800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23800,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,23800,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,23800,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,23801,0)
 ;;=F91.8^^61^928^4
 ;;^UTILITY(U,$J,358.3,23801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23801,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,23801,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,23801,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,23802,0)
 ;;=F91.9^^61^928^5
 ;;^UTILITY(U,$J,358.3,23802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23802,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23802,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,23802,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,23803,0)
 ;;=F98.0^^61^929^6
 ;;^UTILITY(U,$J,358.3,23803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23803,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,23803,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,23803,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,23804,0)
 ;;=F98.1^^61^929^5
 ;;^UTILITY(U,$J,358.3,23804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23804,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,23804,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,23804,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,23805,0)
 ;;=N39.498^^61^929^3
 ;;^UTILITY(U,$J,358.3,23805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23805,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,23805,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,23805,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,23806,0)
 ;;=R15.9^^61^929^1
 ;;^UTILITY(U,$J,358.3,23806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23806,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,23806,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,23806,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,23807,0)
 ;;=R32.^^61^929^4
 ;;^UTILITY(U,$J,358.3,23807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23807,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,23807,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,23807,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,23808,0)
 ;;=R15.9^^61^929^2
 ;;^UTILITY(U,$J,358.3,23808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23808,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,23808,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,23808,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,23809,0)
 ;;=F63.0^^61^930^1
 ;;^UTILITY(U,$J,358.3,23809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23809,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,23809,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,23809,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,23810,0)
 ;;=F99.^^61^931^1
 ;;^UTILITY(U,$J,358.3,23810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23810,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,23810,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,23810,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,23811,0)
 ;;=F06.8^^61^931^3
 ;;^UTILITY(U,$J,358.3,23811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23811,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,23811,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,23811,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,23812,0)
 ;;=F09.^^61^931^4
 ;;^UTILITY(U,$J,358.3,23812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23812,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,23812,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,23812,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,23813,0)
 ;;=F99.^^61^931^2
 ;;^UTILITY(U,$J,358.3,23813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23813,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23813,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,23813,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,23814,0)
 ;;=F84.0^^61^932^7
 ;;^UTILITY(U,$J,358.3,23814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23814,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,23814,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,23814,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,23815,0)
 ;;=F80.9^^61^932^10
 ;;^UTILITY(U,$J,358.3,23815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23815,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,23815,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,23815,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,23816,0)
 ;;=F82.^^61^932^11
 ;;^UTILITY(U,$J,358.3,23816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23816,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,23816,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,23816,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,23817,0)
 ;;=F88.^^61^932^12
 ;;^UTILITY(U,$J,358.3,23817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23817,1,3,0)
 ;;=3^Global Developmental Delay
