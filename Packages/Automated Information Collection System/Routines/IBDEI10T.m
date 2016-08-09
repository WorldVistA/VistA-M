IBDEI10T ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37024,1,4,0)
 ;;=4^F44.5
 ;;^UTILITY(U,$J,358.3,37024,2)
 ;;=^5003580
 ;;^UTILITY(U,$J,358.3,37025,0)
 ;;=F44.7^^135^1829^5
 ;;^UTILITY(U,$J,358.3,37025,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37025,1,3,0)
 ;;=3^Conversion Disorder w/ Mixed Symptoms
 ;;^UTILITY(U,$J,358.3,37025,1,4,0)
 ;;=4^F44.7
 ;;^UTILITY(U,$J,358.3,37025,2)
 ;;=^5003582
 ;;^UTILITY(U,$J,358.3,37026,0)
 ;;=F68.10^^135^1829^10
 ;;^UTILITY(U,$J,358.3,37026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37026,1,3,0)
 ;;=3^Factitious Disorder
 ;;^UTILITY(U,$J,358.3,37026,1,4,0)
 ;;=4^F68.10
 ;;^UTILITY(U,$J,358.3,37026,2)
 ;;=^5003663
 ;;^UTILITY(U,$J,358.3,37027,0)
 ;;=F54.^^135^1829^12
 ;;^UTILITY(U,$J,358.3,37027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37027,1,3,0)
 ;;=3^Psychological Factors Affecting Other Med Conditions
 ;;^UTILITY(U,$J,358.3,37027,1,4,0)
 ;;=4^F54.
 ;;^UTILITY(U,$J,358.3,37027,2)
 ;;=^5003627
 ;;^UTILITY(U,$J,358.3,37028,0)
 ;;=F44.6^^135^1829^6
 ;;^UTILITY(U,$J,358.3,37028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37028,1,3,0)
 ;;=3^Conversion Disorder w/ Special Sensory Symptom
 ;;^UTILITY(U,$J,358.3,37028,1,4,0)
 ;;=4^F44.6
 ;;^UTILITY(U,$J,358.3,37028,2)
 ;;=^5003581
 ;;^UTILITY(U,$J,358.3,37029,0)
 ;;=F44.4^^135^1829^7
 ;;^UTILITY(U,$J,358.3,37029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37029,1,3,0)
 ;;=3^Conversion Disorder w/ Speech Symptom
 ;;^UTILITY(U,$J,358.3,37029,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,37029,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,37030,0)
 ;;=F44.4^^135^1829^8
 ;;^UTILITY(U,$J,358.3,37030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37030,1,3,0)
 ;;=3^Conversion Disorder w/ Swallowing Symptom
 ;;^UTILITY(U,$J,358.3,37030,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,37030,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,37031,0)
 ;;=F44.4^^135^1829^9
 ;;^UTILITY(U,$J,358.3,37031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37031,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,37031,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,37031,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,37032,0)
 ;;=F45.21^^135^1829^11
 ;;^UTILITY(U,$J,358.3,37032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37032,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,37032,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,37032,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,37033,0)
 ;;=F91.2^^135^1830^1
 ;;^UTILITY(U,$J,358.3,37033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37033,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,37033,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,37033,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,37034,0)
 ;;=F91.1^^135^1830^2
 ;;^UTILITY(U,$J,358.3,37034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37034,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,37034,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,37034,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,37035,0)
 ;;=F91.9^^135^1830^3
 ;;^UTILITY(U,$J,358.3,37035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37035,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,37035,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,37035,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,37036,0)
 ;;=F63.81^^135^1830^6
 ;;^UTILITY(U,$J,358.3,37036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37036,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,37036,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,37036,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,37037,0)
 ;;=F63.2^^135^1830^7
 ;;^UTILITY(U,$J,358.3,37037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37037,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,37037,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,37037,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,37038,0)
 ;;=F91.3^^135^1830^8
 ;;^UTILITY(U,$J,358.3,37038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37038,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,37038,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,37038,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,37039,0)
 ;;=F63.1^^135^1830^9
 ;;^UTILITY(U,$J,358.3,37039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37039,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,37039,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,37039,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,37040,0)
 ;;=F91.8^^135^1830^4
 ;;^UTILITY(U,$J,358.3,37040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37040,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,37040,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,37040,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,37041,0)
 ;;=F91.9^^135^1830^5
 ;;^UTILITY(U,$J,358.3,37041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37041,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,37041,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,37041,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,37042,0)
 ;;=F98.0^^135^1831^6
 ;;^UTILITY(U,$J,358.3,37042,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37042,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,37042,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,37042,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,37043,0)
 ;;=F98.1^^135^1831^5
 ;;^UTILITY(U,$J,358.3,37043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37043,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,37043,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,37043,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,37044,0)
 ;;=N39.498^^135^1831^3
 ;;^UTILITY(U,$J,358.3,37044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37044,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,37044,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,37044,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,37045,0)
 ;;=R15.9^^135^1831^1
 ;;^UTILITY(U,$J,358.3,37045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37045,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,37045,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,37045,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,37046,0)
 ;;=R32.^^135^1831^4
 ;;^UTILITY(U,$J,358.3,37046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37046,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,37046,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,37046,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,37047,0)
 ;;=R15.9^^135^1831^2
 ;;^UTILITY(U,$J,358.3,37047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37047,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,37047,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,37047,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,37048,0)
 ;;=F63.0^^135^1832^1
 ;;^UTILITY(U,$J,358.3,37048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37048,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,37048,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,37048,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,37049,0)
 ;;=F99.^^135^1833^1
 ;;^UTILITY(U,$J,358.3,37049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37049,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,37049,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,37049,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,37050,0)
 ;;=F06.8^^135^1833^3
 ;;^UTILITY(U,$J,358.3,37050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37050,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,37050,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,37050,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,37051,0)
 ;;=F09.^^135^1833^4
 ;;^UTILITY(U,$J,358.3,37051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37051,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,37051,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,37051,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,37052,0)
 ;;=F99.^^135^1833^2
 ;;^UTILITY(U,$J,358.3,37052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37052,1,3,0)
 ;;=3^Mental Disorder,Unspec
