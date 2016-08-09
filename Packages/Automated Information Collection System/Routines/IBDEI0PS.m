IBDEI0PS ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,25929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25929,1,3,0)
 ;;=3^Somatic Symptom Disorder
 ;;^UTILITY(U,$J,358.3,25929,1,4,0)
 ;;=4^F45.1
 ;;^UTILITY(U,$J,358.3,25929,2)
 ;;=^5003585
 ;;^UTILITY(U,$J,358.3,25930,0)
 ;;=F44.4^^97^1229^2
 ;;^UTILITY(U,$J,358.3,25930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25930,1,3,0)
 ;;=3^Conversion Disorder w/ Abnormal Movement
 ;;^UTILITY(U,$J,358.3,25930,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25930,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25931,0)
 ;;=F44.6^^97^1229^3
 ;;^UTILITY(U,$J,358.3,25931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25931,1,3,0)
 ;;=3^Conversion Disorder w/ Anesthesia or Sensory Loss
 ;;^UTILITY(U,$J,358.3,25931,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,25931,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,25932,0)
 ;;=F44.5^^97^1229^4
 ;;^UTILITY(U,$J,358.3,25932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25932,1,3,0)
 ;;=3^Conversion Disorder w/ Attacks or Seizures
 ;;^UTILITY(U,$J,358.3,25932,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,25932,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,25933,0)
 ;;=F44.7^^97^1229^5
 ;;^UTILITY(U,$J,358.3,25933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25933,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,25933,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,25933,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,25934,0)
 ;;=F68.10^^97^1229^10
 ;;^UTILITY(U,$J,358.3,25934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25934,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,25934,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,25934,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,25935,0)
 ;;=F54.^^97^1229^12
 ;;^UTILITY(U,$J,358.3,25935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25935,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,25935,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,25935,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,25936,0)
 ;;=F44.6^^97^1229^6
 ;;^UTILITY(U,$J,358.3,25936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25936,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,25936,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,25936,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,25937,0)
 ;;=F44.4^^97^1229^7
 ;;^UTILITY(U,$J,358.3,25937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25937,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,25937,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25937,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25938,0)
 ;;=F44.4^^97^1229^8
 ;;^UTILITY(U,$J,358.3,25938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25938,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,25938,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25938,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25939,0)
 ;;=F44.4^^97^1229^9
 ;;^UTILITY(U,$J,358.3,25939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25939,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,25939,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,25939,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,25940,0)
 ;;=F45.21^^97^1229^11
 ;;^UTILITY(U,$J,358.3,25940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25940,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,25940,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,25940,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,25941,0)
 ;;=F91.2^^97^1230^1
 ;;^UTILITY(U,$J,358.3,25941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25941,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,25941,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,25941,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,25942,0)
 ;;=F91.1^^97^1230^2
 ;;^UTILITY(U,$J,358.3,25942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25942,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,25942,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,25942,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,25943,0)
 ;;=F91.9^^97^1230^3
 ;;^UTILITY(U,$J,358.3,25943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25943,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,25943,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,25943,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,25944,0)
 ;;=F63.81^^97^1230^6
 ;;^UTILITY(U,$J,358.3,25944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25944,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,25944,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,25944,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,25945,0)
 ;;=F63.2^^97^1230^7
 ;;^UTILITY(U,$J,358.3,25945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25945,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,25945,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,25945,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,25946,0)
 ;;=F91.3^^97^1230^8
 ;;^UTILITY(U,$J,358.3,25946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25946,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,25946,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,25946,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,25947,0)
 ;;=F63.1^^97^1230^9
 ;;^UTILITY(U,$J,358.3,25947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25947,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,25947,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,25947,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,25948,0)
 ;;=F91.8^^97^1230^4
 ;;^UTILITY(U,$J,358.3,25948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25948,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,25948,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,25948,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,25949,0)
 ;;=F91.9^^97^1230^5
 ;;^UTILITY(U,$J,358.3,25949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25949,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,25949,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,25949,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,25950,0)
 ;;=F98.0^^97^1231^6
 ;;^UTILITY(U,$J,358.3,25950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25950,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,25950,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,25950,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,25951,0)
 ;;=F98.1^^97^1231^5
 ;;^UTILITY(U,$J,358.3,25951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25951,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,25951,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,25951,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,25952,0)
 ;;=N39.498^^97^1231^3
 ;;^UTILITY(U,$J,358.3,25952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25952,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,25952,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,25952,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,25953,0)
 ;;=R15.9^^97^1231^1
 ;;^UTILITY(U,$J,358.3,25953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25953,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,25953,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,25953,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,25954,0)
 ;;=R32.^^97^1231^4
 ;;^UTILITY(U,$J,358.3,25954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25954,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,25954,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,25954,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,25955,0)
 ;;=R15.9^^97^1231^2
 ;;^UTILITY(U,$J,358.3,25955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25955,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,25955,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,25955,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,25956,0)
 ;;=F63.0^^97^1232^1
 ;;^UTILITY(U,$J,358.3,25956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,25956,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,25956,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,25956,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,25957,0)
 ;;=F99.^^97^1233^1
