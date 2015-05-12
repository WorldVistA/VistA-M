IBDEI020 ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2287,2)
 ;;=^5003500
 ;;^UTILITY(U,$J,358.3,2288,0)
 ;;=F31.60^^10^102^14
 ;;^UTILITY(U,$J,358.3,2288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2288,1,3,0)
 ;;=3^Bipolar Disorder,Mixed,Unspec
 ;;^UTILITY(U,$J,358.3,2288,1,4,0)
 ;;=4^F31.60
 ;;^UTILITY(U,$J,358.3,2288,2)
 ;;=^5003505
 ;;^UTILITY(U,$J,358.3,2289,0)
 ;;=F31.9^^10^102^15
 ;;^UTILITY(U,$J,358.3,2289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2289,1,3,0)
 ;;=3^Bipolar Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2289,1,4,0)
 ;;=4^F31.9
 ;;^UTILITY(U,$J,358.3,2289,2)
 ;;=^331892
 ;;^UTILITY(U,$J,358.3,2290,0)
 ;;=F22.^^10^102^21
 ;;^UTILITY(U,$J,358.3,2290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2290,1,3,0)
 ;;=3^Delusional Disorders
 ;;^UTILITY(U,$J,358.3,2290,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,2290,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,2291,0)
 ;;=F41.0^^10^102^39
 ;;^UTILITY(U,$J,358.3,2291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2291,1,3,0)
 ;;=3^Panic Disorder w/o Agoraphobia
 ;;^UTILITY(U,$J,358.3,2291,1,4,0)
 ;;=4^F41.0
 ;;^UTILITY(U,$J,358.3,2291,2)
 ;;=^5003564
 ;;^UTILITY(U,$J,358.3,2292,0)
 ;;=F40.01^^10^102^2
 ;;^UTILITY(U,$J,358.3,2292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2292,1,3,0)
 ;;=3^Agoraphobia w/ Panic Disorder
 ;;^UTILITY(U,$J,358.3,2292,1,4,0)
 ;;=4^F40.01
 ;;^UTILITY(U,$J,358.3,2292,2)
 ;;=^331911
 ;;^UTILITY(U,$J,358.3,2293,0)
 ;;=F41.9^^10^102^9
 ;;^UTILITY(U,$J,358.3,2293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2293,1,3,0)
 ;;=3^Anxiety Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2293,1,4,0)
 ;;=4^F41.9
 ;;^UTILITY(U,$J,358.3,2293,2)
 ;;=^5003567
 ;;^UTILITY(U,$J,358.3,2294,0)
 ;;=F60.5^^10^102^35
 ;;^UTILITY(U,$J,358.3,2294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2294,1,3,0)
 ;;=3^Obsessive-Compulsive Personality Disorder
 ;;^UTILITY(U,$J,358.3,2294,1,4,0)
 ;;=4^F60.5
 ;;^UTILITY(U,$J,358.3,2294,2)
 ;;=^331918
 ;;^UTILITY(U,$J,358.3,2295,0)
 ;;=F60.7^^10^102^23
 ;;^UTILITY(U,$J,358.3,2295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2295,1,3,0)
 ;;=3^Dependent Personality Disorder
 ;;^UTILITY(U,$J,358.3,2295,1,4,0)
 ;;=4^F60.7
 ;;^UTILITY(U,$J,358.3,2295,2)
 ;;=^5003637
 ;;^UTILITY(U,$J,358.3,2296,0)
 ;;=F60.2^^10^102^8
 ;;^UTILITY(U,$J,358.3,2296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2296,1,3,0)
 ;;=3^Antisocial Personality Disorder
 ;;^UTILITY(U,$J,358.3,2296,1,4,0)
 ;;=4^F60.2
 ;;^UTILITY(U,$J,358.3,2296,2)
 ;;=^9066
 ;;^UTILITY(U,$J,358.3,2297,0)
 ;;=F60.6^^10^102^11
 ;;^UTILITY(U,$J,358.3,2297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2297,1,3,0)
 ;;=3^Avoidant Personality Disorder
 ;;^UTILITY(U,$J,358.3,2297,1,4,0)
 ;;=4^F60.6
 ;;^UTILITY(U,$J,358.3,2297,2)
 ;;=^331920
 ;;^UTILITY(U,$J,358.3,2298,0)
 ;;=F60.3^^10^102^16
 ;;^UTILITY(U,$J,358.3,2298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2298,1,3,0)
 ;;=3^Borderline Personality Disorder
 ;;^UTILITY(U,$J,358.3,2298,1,4,0)
 ;;=4^F60.3
 ;;^UTILITY(U,$J,358.3,2298,2)
 ;;=^331921
 ;;^UTILITY(U,$J,358.3,2299,0)
 ;;=F10.229^^10^102^4
 ;;^UTILITY(U,$J,358.3,2299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2299,1,3,0)
 ;;=3^Alcohol Dependence w/ Intoxication,Unspec
 ;;^UTILITY(U,$J,358.3,2299,1,4,0)
 ;;=4^F10.229
 ;;^UTILITY(U,$J,358.3,2299,2)
 ;;=^5003085
 ;;^UTILITY(U,$J,358.3,2300,0)
 ;;=F10.20^^10^102^5
 ;;^UTILITY(U,$J,358.3,2300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2300,1,3,0)
 ;;=3^Alcohol Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2300,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,2300,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,2301,0)
 ;;=F11.29^^10^102^37
 ;;^UTILITY(U,$J,358.3,2301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2301,1,3,0)
 ;;=3^Opioid Dependence w/ Unspec Opioid-Induced Disorder
 ;;^UTILITY(U,$J,358.3,2301,1,4,0)
 ;;=4^F11.29
 ;;^UTILITY(U,$J,358.3,2301,2)
 ;;=^5003141
 ;;^UTILITY(U,$J,358.3,2302,0)
 ;;=F13.20^^10^102^49
 ;;^UTILITY(U,$J,358.3,2302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2302,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2302,1,4,0)
 ;;=4^F13.20
 ;;^UTILITY(U,$J,358.3,2302,2)
 ;;=^5003202
 ;;^UTILITY(U,$J,358.3,2303,0)
 ;;=F14.29^^10^102^20
 ;;^UTILITY(U,$J,358.3,2303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2303,1,3,0)
 ;;=3^Cocaine Dependence w/ Unspec Cocaine-Induced Disorder
 ;;^UTILITY(U,$J,358.3,2303,1,4,0)
 ;;=4^F14.29
 ;;^UTILITY(U,$J,358.3,2303,2)
 ;;=^5003268
 ;;^UTILITY(U,$J,358.3,2304,0)
 ;;=F12.29^^10^102^18
 ;;^UTILITY(U,$J,358.3,2304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2304,1,3,0)
 ;;=3^Cannabis Dependence w/ Unspec Cannabis-Induced Disorder
 ;;^UTILITY(U,$J,358.3,2304,1,4,0)
 ;;=4^F12.29
 ;;^UTILITY(U,$J,358.3,2304,2)
 ;;=^5003177
 ;;^UTILITY(U,$J,358.3,2305,0)
 ;;=F16.20^^10^102^26
 ;;^UTILITY(U,$J,358.3,2305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2305,1,3,0)
 ;;=3^Hallucinogen Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2305,1,4,0)
 ;;=4^F16.20
 ;;^UTILITY(U,$J,358.3,2305,2)
 ;;=^5003336
 ;;^UTILITY(U,$J,358.3,2306,0)
 ;;=F19.20^^10^102^41
 ;;^UTILITY(U,$J,358.3,2306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2306,1,3,0)
 ;;=3^Psychoactive Substance Dependence,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2306,1,4,0)
 ;;=4^F19.20
 ;;^UTILITY(U,$J,358.3,2306,2)
 ;;=^5003431
 ;;^UTILITY(U,$J,358.3,2307,0)
 ;;=F10.10^^10^102^3
 ;;^UTILITY(U,$J,358.3,2307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2307,1,3,0)
 ;;=3^Alcohol Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2307,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,2307,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,2308,0)
 ;;=F12.10^^10^102^17
 ;;^UTILITY(U,$J,358.3,2308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2308,1,3,0)
 ;;=3^Cannabis Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2308,1,4,0)
 ;;=4^F12.10
 ;;^UTILITY(U,$J,358.3,2308,2)
 ;;=^5003155
 ;;^UTILITY(U,$J,358.3,2309,0)
 ;;=F16.10^^10^102^25
 ;;^UTILITY(U,$J,358.3,2309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2309,1,3,0)
 ;;=3^Hallucinogen Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2309,1,4,0)
 ;;=4^F16.10
 ;;^UTILITY(U,$J,358.3,2309,2)
 ;;=^5003323
 ;;^UTILITY(U,$J,358.3,2310,0)
 ;;=F13.10^^10^102^48
 ;;^UTILITY(U,$J,358.3,2310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2310,1,3,0)
 ;;=3^Sedative/Hypnotic/Anxiolytic Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2310,1,4,0)
 ;;=4^F13.10
 ;;^UTILITY(U,$J,358.3,2310,2)
 ;;=^5003189
 ;;^UTILITY(U,$J,358.3,2311,0)
 ;;=F11.10^^10^102^36
 ;;^UTILITY(U,$J,358.3,2311,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2311,1,3,0)
 ;;=3^Opioid Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2311,1,4,0)
 ;;=4^F11.10
 ;;^UTILITY(U,$J,358.3,2311,2)
 ;;=^5003114
 ;;^UTILITY(U,$J,358.3,2312,0)
 ;;=F14.10^^10^102^19
 ;;^UTILITY(U,$J,358.3,2312,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2312,1,3,0)
 ;;=3^Cocaine Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2312,1,4,0)
 ;;=4^F14.10
 ;;^UTILITY(U,$J,358.3,2312,2)
 ;;=^5003239
 ;;^UTILITY(U,$J,358.3,2313,0)
 ;;=F18.10^^10^102^27
 ;;^UTILITY(U,$J,358.3,2313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2313,1,3,0)
 ;;=3^Inhalant Abuse,Uncomplicated
 ;;^UTILITY(U,$J,358.3,2313,1,4,0)
 ;;=4^F18.10
 ;;^UTILITY(U,$J,358.3,2313,2)
 ;;=^5003380
 ;;^UTILITY(U,$J,358.3,2314,0)
 ;;=F45.41^^10^102^38
 ;;^UTILITY(U,$J,358.3,2314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2314,1,3,0)
 ;;=3^Pain Disorder Related to Psychological Factors
 ;;^UTILITY(U,$J,358.3,2314,1,4,0)
 ;;=4^F45.41
 ;;^UTILITY(U,$J,358.3,2314,2)
 ;;=^5003590
 ;;^UTILITY(U,$J,358.3,2315,0)
 ;;=F43.20^^10^102^1
 ;;^UTILITY(U,$J,358.3,2315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2315,1,3,0)
 ;;=3^Adjustment Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,2315,1,4,0)
 ;;=4^F43.20
 ;;^UTILITY(U,$J,358.3,2315,2)
 ;;=^5003573
 ;;^UTILITY(U,$J,358.3,2316,0)
 ;;=F07.0^^10^102^40
 ;;^UTILITY(U,$J,358.3,2316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2316,1,3,0)
 ;;=3^Personality Change d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,2316,1,4,0)
 ;;=4^F07.0
 ;;^UTILITY(U,$J,358.3,2316,2)
 ;;=^5003063
 ;;^UTILITY(U,$J,358.3,2317,0)
 ;;=F32.9^^10^102^32
 ;;^UTILITY(U,$J,358.3,2317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2317,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,2317,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,2317,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,2318,0)
 ;;=F63.81^^10^102^28
 ;;^UTILITY(U,$J,358.3,2318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2318,1,3,0)
 ;;=3^Intermittent Explosive Disorder
 ;;^UTILITY(U,$J,358.3,2318,1,4,0)
 ;;=4^F63.81
 ;;^UTILITY(U,$J,358.3,2318,2)
 ;;=^5003644
 ;;^UTILITY(U,$J,358.3,2319,0)
 ;;=F90.8^^10^102^10
 ;;^UTILITY(U,$J,358.3,2319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2319,1,3,0)
 ;;=3^Attention-Deficit Hyperactivity Disorder
 ;;^UTILITY(U,$J,358.3,2319,1,4,0)
 ;;=4^F90.8
 ;;^UTILITY(U,$J,358.3,2319,2)
 ;;=^5003695
 ;;^UTILITY(U,$J,358.3,2320,0)
 ;;=H54.8^^10^102^29
 ;;^UTILITY(U,$J,358.3,2320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2320,1,3,0)
 ;;=3^Legal Blindness,as Defined in USA
 ;;^UTILITY(U,$J,358.3,2320,1,4,0)
 ;;=4^H54.8
 ;;^UTILITY(U,$J,358.3,2320,2)
 ;;=^5006369
 ;;^UTILITY(U,$J,358.3,2321,0)
 ;;=R53.1^^10^102^51
 ;;^UTILITY(U,$J,358.3,2321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2321,1,3,0)
 ;;=3^Weakness
 ;;^UTILITY(U,$J,358.3,2321,1,4,0)
 ;;=4^R53.1
 ;;^UTILITY(U,$J,358.3,2321,2)
 ;;=^5019516
 ;;^UTILITY(U,$J,358.3,2322,0)
 ;;=R68.89^^10^102^24
 ;;^UTILITY(U,$J,358.3,2322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2322,1,3,0)
 ;;=3^General Symptoms & Signs
 ;;^UTILITY(U,$J,358.3,2322,1,4,0)
 ;;=4^R68.89
 ;;^UTILITY(U,$J,358.3,2322,2)
 ;;=^5019557
 ;;^UTILITY(U,$J,358.3,2323,0)
 ;;=Z03.89^^10^102^33
 ;;^UTILITY(U,$J,358.3,2323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2323,1,3,0)
 ;;=3^Mental Condition,Suspected Disease
 ;;^UTILITY(U,$J,358.3,2323,1,4,0)
 ;;=4^Z03.89
 ;;^UTILITY(U,$J,358.3,2323,2)
 ;;=^5062656
 ;;^UTILITY(U,$J,358.3,2324,0)
 ;;=Z51.89^^11^103^1
