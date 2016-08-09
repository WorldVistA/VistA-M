IBDEI018 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,701,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,702,0)
 ;;=F44.4^^3^55^9
 ;;^UTILITY(U,$J,358.3,702,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,702,1,3,0)
 ;;=3^Conversion Disorder w/ Weakness or Paralysis
 ;;^UTILITY(U,$J,358.3,702,1,4,0)
 ;;=4^F44.4
 ;;^UTILITY(U,$J,358.3,702,2)
 ;;=^5003579
 ;;^UTILITY(U,$J,358.3,703,0)
 ;;=F45.21^^3^55^11
 ;;^UTILITY(U,$J,358.3,703,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,703,1,3,0)
 ;;=3^Illness Anxiety Disorder
 ;;^UTILITY(U,$J,358.3,703,1,4,0)
 ;;=4^F45.21
 ;;^UTILITY(U,$J,358.3,703,2)
 ;;=^5003587
 ;;^UTILITY(U,$J,358.3,704,0)
 ;;=F91.2^^3^56^1
 ;;^UTILITY(U,$J,358.3,704,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,704,1,3,0)
 ;;=3^Conduct Disorder,Adolescent-Onset Type
 ;;^UTILITY(U,$J,358.3,704,1,4,0)
 ;;=4^F91.2
 ;;^UTILITY(U,$J,358.3,704,2)
 ;;=^5003699
 ;;^UTILITY(U,$J,358.3,705,0)
 ;;=F91.1^^3^56^2
 ;;^UTILITY(U,$J,358.3,705,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,705,1,3,0)
 ;;=3^Conduct Disorder,Childhood-Onset Type
 ;;^UTILITY(U,$J,358.3,705,1,4,0)
 ;;=4^F91.1
 ;;^UTILITY(U,$J,358.3,705,2)
 ;;=^5003698
 ;;^UTILITY(U,$J,358.3,706,0)
 ;;=F91.9^^3^56^3
 ;;^UTILITY(U,$J,358.3,706,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,706,1,3,0)
 ;;=3^Conduct Disorder,Unspec-Onset Type
 ;;^UTILITY(U,$J,358.3,706,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,706,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,707,0)
 ;;=F63.81^^3^56^6
 ;;^UTILITY(U,$J,358.3,707,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,707,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,707,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,707,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,708,0)
 ;;=F63.2^^3^56^7
 ;;^UTILITY(U,$J,358.3,708,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,708,1,3,0)
 ;;=3^Kleptomania
 ;;^UTILITY(U,$J,358.3,708,1,4,0)
 ;;=4^F63.2
 ;;^UTILITY(U,$J,358.3,708,2)
 ;;=^5003642
 ;;^UTILITY(U,$J,358.3,709,0)
 ;;=F91.3^^3^56^8
 ;;^UTILITY(U,$J,358.3,709,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,709,1,3,0)
 ;;=3^Oppositional Defiant Disorder
 ;;^UTILITY(U,$J,358.3,709,1,4,0)
 ;;=4^F91.3
 ;;^UTILITY(U,$J,358.3,709,2)
 ;;=^331955
 ;;^UTILITY(U,$J,358.3,710,0)
 ;;=F63.1^^3^56^9
 ;;^UTILITY(U,$J,358.3,710,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,710,1,3,0)
 ;;=3^Pyromania
 ;;^UTILITY(U,$J,358.3,710,1,4,0)
 ;;=4^F63.1
 ;;^UTILITY(U,$J,358.3,710,2)
 ;;=^5003641
 ;;^UTILITY(U,$J,358.3,711,0)
 ;;=F91.8^^3^56^4
 ;;^UTILITY(U,$J,358.3,711,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,711,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,711,1,4,0)
 ;;=4^F91.8
 ;;^UTILITY(U,$J,358.3,711,2)
 ;;=^5003700
 ;;^UTILITY(U,$J,358.3,712,0)
 ;;=F91.9^^3^56^5
 ;;^UTILITY(U,$J,358.3,712,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,712,1,3,0)
 ;;=3^Disruptive,Impulse-Control & Conduct Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,712,1,4,0)
 ;;=4^F91.9
 ;;^UTILITY(U,$J,358.3,712,2)
 ;;=^5003701
 ;;^UTILITY(U,$J,358.3,713,0)
 ;;=F98.0^^3^57^6
 ;;^UTILITY(U,$J,358.3,713,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,713,1,3,0)
 ;;=3^Enuresis
 ;;^UTILITY(U,$J,358.3,713,1,4,0)
 ;;=4^F98.0
 ;;^UTILITY(U,$J,358.3,713,2)
 ;;=^5003711
 ;;^UTILITY(U,$J,358.3,714,0)
 ;;=F98.1^^3^57^5
 ;;^UTILITY(U,$J,358.3,714,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,714,1,3,0)
 ;;=3^Encopresis
 ;;^UTILITY(U,$J,358.3,714,1,4,0)
 ;;=4^F98.1
 ;;^UTILITY(U,$J,358.3,714,2)
 ;;=^5003712
 ;;^UTILITY(U,$J,358.3,715,0)
 ;;=N39.498^^3^57^3
 ;;^UTILITY(U,$J,358.3,715,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,715,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Oth Specified
 ;;^UTILITY(U,$J,358.3,715,1,4,0)
 ;;=4^N39.498
 ;;^UTILITY(U,$J,358.3,715,2)
 ;;=^5015686
 ;;^UTILITY(U,$J,358.3,716,0)
 ;;=R15.9^^3^57^1
 ;;^UTILITY(U,$J,358.3,716,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,716,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Other Specified
 ;;^UTILITY(U,$J,358.3,716,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,716,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,717,0)
 ;;=R32.^^3^57^4
 ;;^UTILITY(U,$J,358.3,717,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,717,1,3,0)
 ;;=3^Elimination Disorder w/ Urinary Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,717,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,717,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,718,0)
 ;;=R15.9^^3^57^2
 ;;^UTILITY(U,$J,358.3,718,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,718,1,3,0)
 ;;=3^Elimination Disorder w/ Fecal Symptoms,Unspec
 ;;^UTILITY(U,$J,358.3,718,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,718,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,719,0)
 ;;=F63.0^^3^58^1
 ;;^UTILITY(U,$J,358.3,719,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,719,1,3,0)
 ;;=3^Gambling Disorder
 ;;^UTILITY(U,$J,358.3,719,1,4,0)
 ;;=4^F63.0
 ;;^UTILITY(U,$J,358.3,719,2)
 ;;=^5003640
 ;;^UTILITY(U,$J,358.3,720,0)
 ;;=F99.^^3^59^1
 ;;^UTILITY(U,$J,358.3,720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,720,1,3,0)
 ;;=3^Mental Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,720,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,720,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,721,0)
 ;;=F06.8^^3^59^3
 ;;^UTILITY(U,$J,358.3,721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,721,1,3,0)
 ;;=3^Mental Disorders,Oth Specified,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,721,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,721,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,722,0)
 ;;=F09.^^3^59^4
 ;;^UTILITY(U,$J,358.3,722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,722,1,3,0)
 ;;=3^Mental Disorders,Unspec,d/t Another Med Condition
 ;;^UTILITY(U,$J,358.3,722,1,4,0)
 ;;=4^F09.
 ;;^UTILITY(U,$J,358.3,722,2)
 ;;=^5003067
 ;;^UTILITY(U,$J,358.3,723,0)
 ;;=F99.^^3^59^2
 ;;^UTILITY(U,$J,358.3,723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,723,1,3,0)
 ;;=3^Mental Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,723,1,4,0)
 ;;=4^F99.
 ;;^UTILITY(U,$J,358.3,723,2)
 ;;=^5003720
 ;;^UTILITY(U,$J,358.3,724,0)
 ;;=F84.0^^3^60^7
 ;;^UTILITY(U,$J,358.3,724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,724,1,3,0)
 ;;=3^Autism Spectrum Disorder Assoc w/ a Known Med/Genetic Cond or Environ Factor
 ;;^UTILITY(U,$J,358.3,724,1,4,0)
 ;;=4^F84.0
 ;;^UTILITY(U,$J,358.3,724,2)
 ;;=^5003684
 ;;^UTILITY(U,$J,358.3,725,0)
 ;;=F80.9^^3^60^10
 ;;^UTILITY(U,$J,358.3,725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,725,1,3,0)
 ;;=3^Communication Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,725,1,4,0)
 ;;=4^F80.9
 ;;^UTILITY(U,$J,358.3,725,2)
 ;;=^5003678
 ;;^UTILITY(U,$J,358.3,726,0)
 ;;=F82.^^3^60^11
 ;;^UTILITY(U,$J,358.3,726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,726,1,3,0)
 ;;=3^Developmental Coordination Disorder
 ;;^UTILITY(U,$J,358.3,726,1,4,0)
 ;;=4^F82.
 ;;^UTILITY(U,$J,358.3,726,2)
 ;;=^5003683
 ;;^UTILITY(U,$J,358.3,727,0)
 ;;=F88.^^3^60^12
 ;;^UTILITY(U,$J,358.3,727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,727,1,3,0)
 ;;=3^Global Developmental Delay
 ;;^UTILITY(U,$J,358.3,727,1,4,0)
 ;;=4^F88.
 ;;^UTILITY(U,$J,358.3,727,2)
 ;;=^5003690
 ;;^UTILITY(U,$J,358.3,728,0)
 ;;=F80.2^^3^60^18
 ;;^UTILITY(U,$J,358.3,728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,728,1,3,0)
 ;;=3^Language Disorder
 ;;^UTILITY(U,$J,358.3,728,1,4,0)
 ;;=4^F80.2
 ;;^UTILITY(U,$J,358.3,728,2)
 ;;=^331959
 ;;^UTILITY(U,$J,358.3,729,0)
 ;;=F81.2^^3^60^19
 ;;^UTILITY(U,$J,358.3,729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,729,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Mathematics
 ;;^UTILITY(U,$J,358.3,729,1,4,0)
 ;;=4^F81.2
 ;;^UTILITY(U,$J,358.3,729,2)
 ;;=^331957
 ;;^UTILITY(U,$J,358.3,730,0)
 ;;=F81.0^^3^60^20
 ;;^UTILITY(U,$J,358.3,730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,730,1,3,0)
 ;;=3^Learning Disorder w/ Impairment in Reading
 ;;^UTILITY(U,$J,358.3,730,1,4,0)
 ;;=4^F81.0
 ;;^UTILITY(U,$J,358.3,730,2)
 ;;=^5003679
 ;;^UTILITY(U,$J,358.3,731,0)
 ;;=F81.81^^3^60^21
