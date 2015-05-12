IBDEI01W ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2140,2)
 ;;=^5063221
 ;;^UTILITY(U,$J,358.3,2141,0)
 ;;=Z68.44^^9^92^25
 ;;^UTILITY(U,$J,358.3,2141,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2141,1,3,0)
 ;;=3^Body Mass Index (BMI) 60.0-69.9
 ;;^UTILITY(U,$J,358.3,2141,1,4,0)
 ;;=4^Z68.44
 ;;^UTILITY(U,$J,358.3,2141,2)
 ;;=^5063222
 ;;^UTILITY(U,$J,358.3,2142,0)
 ;;=Z68.45^^9^92^26
 ;;^UTILITY(U,$J,358.3,2142,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2142,1,3,0)
 ;;=3^Body Mass Index (BMI) 70 or Greater
 ;;^UTILITY(U,$J,358.3,2142,1,4,0)
 ;;=4^Z68.45
 ;;^UTILITY(U,$J,358.3,2142,2)
 ;;=^5063223
 ;;^UTILITY(U,$J,358.3,2143,0)
 ;;=Z71.9^^9^93^3
 ;;^UTILITY(U,$J,358.3,2143,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2143,1,3,0)
 ;;=3^Counseling,Unspec
 ;;^UTILITY(U,$J,358.3,2143,1,4,0)
 ;;=4^Z71.9
 ;;^UTILITY(U,$J,358.3,2143,2)
 ;;=^5063254
 ;;^UTILITY(U,$J,358.3,2144,0)
 ;;=Z71.89^^9^93^2
 ;;^UTILITY(U,$J,358.3,2144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2144,1,3,0)
 ;;=3^Counseling,Other Spec
 ;;^UTILITY(U,$J,358.3,2144,1,4,0)
 ;;=4^Z71.89
 ;;^UTILITY(U,$J,358.3,2144,2)
 ;;=^5063253
 ;;^UTILITY(U,$J,358.3,2145,0)
 ;;=Z71.41^^9^93^1
 ;;^UTILITY(U,$J,358.3,2145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2145,1,3,0)
 ;;=3^Alcohol Abuse Counseling
 ;;^UTILITY(U,$J,358.3,2145,1,4,0)
 ;;=4^Z71.41
 ;;^UTILITY(U,$J,358.3,2145,2)
 ;;=^5063246
 ;;^UTILITY(U,$J,358.3,2146,0)
 ;;=Z71.7^^9^93^5
 ;;^UTILITY(U,$J,358.3,2146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2146,1,3,0)
 ;;=3^HIV Counseling
 ;;^UTILITY(U,$J,358.3,2146,1,4,0)
 ;;=4^Z71.7
 ;;^UTILITY(U,$J,358.3,2146,2)
 ;;=^5063251
 ;;^UTILITY(U,$J,358.3,2147,0)
 ;;=Z72.4^^9^93^4
 ;;^UTILITY(U,$J,358.3,2147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2147,1,3,0)
 ;;=3^Diet and Eating Habit Counseling
 ;;^UTILITY(U,$J,358.3,2147,1,4,0)
 ;;=4^Z72.4
 ;;^UTILITY(U,$J,358.3,2147,2)
 ;;=^5063257
 ;;^UTILITY(U,$J,358.3,2148,0)
 ;;=Z72.3^^9^93^8
 ;;^UTILITY(U,$J,358.3,2148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2148,1,3,0)
 ;;=3^Physical Exercise Counseling
 ;;^UTILITY(U,$J,358.3,2148,1,4,0)
 ;;=4^Z72.3
 ;;^UTILITY(U,$J,358.3,2148,2)
 ;;=^5063256
 ;;^UTILITY(U,$J,358.3,2149,0)
 ;;=Z72.51^^9^93^6
 ;;^UTILITY(U,$J,358.3,2149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2149,1,3,0)
 ;;=3^High Risk Heterosexual Behavior Counseling
 ;;^UTILITY(U,$J,358.3,2149,1,4,0)
 ;;=4^Z72.51
 ;;^UTILITY(U,$J,358.3,2149,2)
 ;;=^5063258
 ;;^UTILITY(U,$J,358.3,2150,0)
 ;;=Z72.9^^9^93^7
 ;;^UTILITY(U,$J,358.3,2150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2150,1,3,0)
 ;;=3^Lifestyle Counseling
 ;;^UTILITY(U,$J,358.3,2150,1,4,0)
 ;;=4^Z72.9
 ;;^UTILITY(U,$J,358.3,2150,2)
 ;;=^5063267
 ;;^UTILITY(U,$J,358.3,2151,0)
 ;;=Z00.00^^9^94^3
 ;;^UTILITY(U,$J,358.3,2151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2151,1,3,0)
 ;;=3^General Medical Exam w/ Normal Findings
 ;;^UTILITY(U,$J,358.3,2151,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,2151,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,2152,0)
 ;;=Z00.8^^9^94^2
 ;;^UTILITY(U,$J,358.3,2152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2152,1,3,0)
 ;;=3^General Exam,Other
 ;;^UTILITY(U,$J,358.3,2152,1,4,0)
 ;;=4^Z00.8
 ;;^UTILITY(U,$J,358.3,2152,2)
 ;;=^5062611
 ;;^UTILITY(U,$J,358.3,2153,0)
 ;;=Z02.89^^9^94^1
 ;;^UTILITY(U,$J,358.3,2153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2153,1,3,0)
 ;;=3^Administrative Examination
 ;;^UTILITY(U,$J,358.3,2153,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,2153,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,2154,0)
 ;;=Z02.1^^9^94^7
 ;;^UTILITY(U,$J,358.3,2154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2154,1,3,0)
 ;;=3^Pre-Employment Examination
 ;;^UTILITY(U,$J,358.3,2154,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,2154,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,2155,0)
 ;;=Z02.3^^9^94^8
 ;;^UTILITY(U,$J,358.3,2155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2155,1,3,0)
 ;;=3^Recruitment to Armed Forces Examination
 ;;^UTILITY(U,$J,358.3,2155,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,2155,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,2156,0)
 ;;=Z00.5^^9^94^6
 ;;^UTILITY(U,$J,358.3,2156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2156,1,3,0)
 ;;=3^Potential Organ/Tissue Donor Examination
 ;;^UTILITY(U,$J,358.3,2156,1,4,0)
 ;;=4^Z00.5
 ;;^UTILITY(U,$J,358.3,2156,2)
 ;;=^5062607
 ;;^UTILITY(U,$J,358.3,2157,0)
 ;;=Z01.419^^9^94^5
 ;;^UTILITY(U,$J,358.3,2157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2157,1,3,0)
 ;;=3^Gyn Exam w/ Normal Findings
 ;;^UTILITY(U,$J,358.3,2157,1,4,0)
 ;;=4^Z01.419
 ;;^UTILITY(U,$J,358.3,2157,2)
 ;;=^5062623
 ;;^UTILITY(U,$J,358.3,2158,0)
 ;;=Z01.411^^9^94^4
 ;;^UTILITY(U,$J,358.3,2158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2158,1,3,0)
 ;;=3^Gyn Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,2158,1,4,0)
 ;;=4^Z01.411
 ;;^UTILITY(U,$J,358.3,2158,2)
 ;;=^5062622
 ;;^UTILITY(U,$J,358.3,2159,0)
 ;;=Z85.43^^9^95^51
 ;;^UTILITY(U,$J,358.3,2159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2159,1,3,0)
 ;;=3^Personal Hx of Malig Neop Ovary
 ;;^UTILITY(U,$J,358.3,2159,1,4,0)
 ;;=4^Z85.43
 ;;^UTILITY(U,$J,358.3,2159,2)
 ;;=^5063420
 ;;^UTILITY(U,$J,358.3,2160,0)
 ;;=Z85.46^^9^95^52
 ;;^UTILITY(U,$J,358.3,2160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2160,1,3,0)
 ;;=3^Personal Hx of Malig Neop Prostate
 ;;^UTILITY(U,$J,358.3,2160,1,4,0)
 ;;=4^Z85.46
 ;;^UTILITY(U,$J,358.3,2160,2)
 ;;=^5063423
 ;;^UTILITY(U,$J,358.3,2161,0)
 ;;=Z85.6^^9^95^49
 ;;^UTILITY(U,$J,358.3,2161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2161,1,3,0)
 ;;=3^Personal Hx of Leukemia
 ;;^UTILITY(U,$J,358.3,2161,1,4,0)
 ;;=4^Z85.6
 ;;^UTILITY(U,$J,358.3,2161,2)
 ;;=^5063434
 ;;^UTILITY(U,$J,358.3,2162,0)
 ;;=Z85.71^^9^95^47
 ;;^UTILITY(U,$J,358.3,2162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2162,1,3,0)
 ;;=3^Personal Hx of Hodgkin Lymphoma
 ;;^UTILITY(U,$J,358.3,2162,1,4,0)
 ;;=4^Z85.71
 ;;^UTILITY(U,$J,358.3,2162,2)
 ;;=^5063435
 ;;^UTILITY(U,$J,358.3,2163,0)
 ;;=Z85.820^^9^95^50
 ;;^UTILITY(U,$J,358.3,2163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2163,1,3,0)
 ;;=3^Personal Hx of Malig Melanoma of SKin
 ;;^UTILITY(U,$J,358.3,2163,1,4,0)
 ;;=4^Z85.820
 ;;^UTILITY(U,$J,358.3,2163,2)
 ;;=^5063441
 ;;^UTILITY(U,$J,358.3,2164,0)
 ;;=Z85.828^^9^95^53
 ;;^UTILITY(U,$J,358.3,2164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2164,1,3,0)
 ;;=3^Personal Hx of Malig Neop Skin
 ;;^UTILITY(U,$J,358.3,2164,1,4,0)
 ;;=4^Z85.828
 ;;^UTILITY(U,$J,358.3,2164,2)
 ;;=^5063443
 ;;^UTILITY(U,$J,358.3,2165,0)
 ;;=Z65.8^^9^95^58
 ;;^UTILITY(U,$J,358.3,2165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2165,1,3,0)
 ;;=3^Personal Hx of Psychosocial Circumstance Problems
 ;;^UTILITY(U,$J,358.3,2165,1,4,0)
 ;;=4^Z65.8
 ;;^UTILITY(U,$J,358.3,2165,2)
 ;;=^5063185
 ;;^UTILITY(U,$J,358.3,2166,0)
 ;;=Z86.718^^9^95^61
 ;;^UTILITY(U,$J,358.3,2166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2166,1,3,0)
 ;;=3^Personal Hx of Venous Thrombosis & Embolism
 ;;^UTILITY(U,$J,358.3,2166,1,4,0)
 ;;=4^Z86.718
 ;;^UTILITY(U,$J,358.3,2166,2)
 ;;=^5063475
 ;;^UTILITY(U,$J,358.3,2167,0)
 ;;=Z86.73^^9^95^60
 ;;^UTILITY(U,$J,358.3,2167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2167,1,3,0)
 ;;=3^Personal Hx of TIA
 ;;^UTILITY(U,$J,358.3,2167,1,4,0)
 ;;=4^Z86.73
 ;;^UTILITY(U,$J,358.3,2167,2)
 ;;=^5063477
 ;;^UTILITY(U,$J,358.3,2168,0)
 ;;=Z86.79^^9^95^43
 ;;^UTILITY(U,$J,358.3,2168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2168,1,3,0)
 ;;=3^Personal Hx of Circulatory System Diseases
 ;;^UTILITY(U,$J,358.3,2168,1,4,0)
 ;;=4^Z86.79
 ;;^UTILITY(U,$J,358.3,2168,2)
 ;;=^5063479
 ;;^UTILITY(U,$J,358.3,2169,0)
 ;;=Z87.11^^9^95^57
 ;;^UTILITY(U,$J,358.3,2169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2169,1,3,0)
 ;;=3^Personal Hx of Peptic Ulcer Disease
 ;;^UTILITY(U,$J,358.3,2169,1,4,0)
 ;;=4^Z87.11
 ;;^UTILITY(U,$J,358.3,2169,2)
 ;;=^5063482
 ;;^UTILITY(U,$J,358.3,2170,0)
 ;;=Z86.010^^9^95^44
 ;;^UTILITY(U,$J,358.3,2170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2170,1,3,0)
 ;;=3^Personal Hx of Colonic Polyps
 ;;^UTILITY(U,$J,358.3,2170,1,4,0)
 ;;=4^Z86.010
 ;;^UTILITY(U,$J,358.3,2170,2)
 ;;=^5063456
 ;;^UTILITY(U,$J,358.3,2171,0)
 ;;=Z87.39^^9^95^54
 ;;^UTILITY(U,$J,358.3,2171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2171,1,3,0)
 ;;=3^Personal Hx of Musculoskeletal System Diseases
 ;;^UTILITY(U,$J,358.3,2171,1,4,0)
 ;;=4^Z87.39
 ;;^UTILITY(U,$J,358.3,2171,2)
 ;;=^5063488
 ;;^UTILITY(U,$J,358.3,2172,0)
 ;;=Z92.3^^9^95^48
 ;;^UTILITY(U,$J,358.3,2172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2172,1,3,0)
 ;;=3^Personal Hx of Irradiation
 ;;^UTILITY(U,$J,358.3,2172,1,4,0)
 ;;=4^Z92.3
 ;;^UTILITY(U,$J,358.3,2172,2)
 ;;=^5063637
 ;;^UTILITY(U,$J,358.3,2173,0)
 ;;=Z87.820^^9^95^59
 ;;^UTILITY(U,$J,358.3,2173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2173,1,3,0)
 ;;=3^Personal Hx of TBI
 ;;^UTILITY(U,$J,358.3,2173,1,4,0)
 ;;=4^Z87.820
 ;;^UTILITY(U,$J,358.3,2173,2)
 ;;=^5063514
 ;;^UTILITY(U,$J,358.3,2174,0)
 ;;=Z87.891^^9^95^55
 ;;^UTILITY(U,$J,358.3,2174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2174,1,3,0)
 ;;=3^Personal Hx of Nicotine Dependence
 ;;^UTILITY(U,$J,358.3,2174,1,4,0)
 ;;=4^Z87.891
 ;;^UTILITY(U,$J,358.3,2174,2)
 ;;=^5063518
 ;;^UTILITY(U,$J,358.3,2175,0)
 ;;=Z77.090^^9^95^45
 ;;^UTILITY(U,$J,358.3,2175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2175,1,3,0)
 ;;=3^Personal Hx of Contact With & Exposure to Asbestos
 ;;^UTILITY(U,$J,358.3,2175,1,4,0)
 ;;=4^Z77.090
 ;;^UTILITY(U,$J,358.3,2175,2)
 ;;=^5063312
 ;;^UTILITY(U,$J,358.3,2176,0)
 ;;=Z57.8^^9^95^56
 ;;^UTILITY(U,$J,358.3,2176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2176,1,3,0)
 ;;=3^Personal Hx of Occupational Exposure to Other Risk Factors
 ;;^UTILITY(U,$J,358.3,2176,1,4,0)
 ;;=4^Z57.8
 ;;^UTILITY(U,$J,358.3,2176,2)
 ;;=^5063127
 ;;^UTILITY(U,$J,358.3,2177,0)
 ;;=Z91.81^^9^95^46
 ;;^UTILITY(U,$J,358.3,2177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,2177,1,3,0)
 ;;=3^Personal Hx of Falling
