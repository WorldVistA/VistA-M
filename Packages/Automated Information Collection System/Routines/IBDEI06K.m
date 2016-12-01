IBDEI06K ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8181,1,3,0)
 ;;=3^Asthma,Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,8181,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,8181,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,8182,0)
 ;;=K52.9^^29^438^30
 ;;^UTILITY(U,$J,358.3,8182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8182,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis, unspecified
 ;;^UTILITY(U,$J,358.3,8182,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,8182,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,8183,0)
 ;;=M25.511^^29^438^39
 ;;^UTILITY(U,$J,358.3,8183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8183,1,3,0)
 ;;=3^Pain in right shoulder
 ;;^UTILITY(U,$J,358.3,8183,1,4,0)
 ;;=4^M25.511
 ;;^UTILITY(U,$J,358.3,8183,2)
 ;;=^5011602
 ;;^UTILITY(U,$J,358.3,8184,0)
 ;;=M25.512^^29^438^36
 ;;^UTILITY(U,$J,358.3,8184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8184,1,3,0)
 ;;=3^Pain in left shoulder
 ;;^UTILITY(U,$J,358.3,8184,1,4,0)
 ;;=4^M25.512
 ;;^UTILITY(U,$J,358.3,8184,2)
 ;;=^5011603
 ;;^UTILITY(U,$J,358.3,8185,0)
 ;;=M25.551^^29^438^37
 ;;^UTILITY(U,$J,358.3,8185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8185,1,3,0)
 ;;=3^Pain in right hip
 ;;^UTILITY(U,$J,358.3,8185,1,4,0)
 ;;=4^M25.551
 ;;^UTILITY(U,$J,358.3,8185,2)
 ;;=^5011611
 ;;^UTILITY(U,$J,358.3,8186,0)
 ;;=M25.552^^29^438^34
 ;;^UTILITY(U,$J,358.3,8186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8186,1,3,0)
 ;;=3^Pain in left hip
 ;;^UTILITY(U,$J,358.3,8186,1,4,0)
 ;;=4^M25.552
 ;;^UTILITY(U,$J,358.3,8186,2)
 ;;=^5011612
 ;;^UTILITY(U,$J,358.3,8187,0)
 ;;=M25.561^^29^438^38
 ;;^UTILITY(U,$J,358.3,8187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8187,1,3,0)
 ;;=3^Pain in right knee
 ;;^UTILITY(U,$J,358.3,8187,1,4,0)
 ;;=4^M25.561
 ;;^UTILITY(U,$J,358.3,8187,2)
 ;;=^5011614
 ;;^UTILITY(U,$J,358.3,8188,0)
 ;;=M25.562^^29^438^35
 ;;^UTILITY(U,$J,358.3,8188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8188,1,3,0)
 ;;=3^Pain in left knee
 ;;^UTILITY(U,$J,358.3,8188,1,4,0)
 ;;=4^M25.562
 ;;^UTILITY(U,$J,358.3,8188,2)
 ;;=^5011615
 ;;^UTILITY(U,$J,358.3,8189,0)
 ;;=M54.2^^29^438^9
 ;;^UTILITY(U,$J,358.3,8189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8189,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,8189,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,8189,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,8190,0)
 ;;=M54.5^^29^438^23
 ;;^UTILITY(U,$J,358.3,8190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8190,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,8190,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,8190,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,8191,0)
 ;;=M54.9^^29^438^15
 ;;^UTILITY(U,$J,358.3,8191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8191,1,3,0)
 ;;=3^Dorsalgia, unspecified
 ;;^UTILITY(U,$J,358.3,8191,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,8191,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,8192,0)
 ;;=R51.^^29^438^19
 ;;^UTILITY(U,$J,358.3,8192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8192,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,8192,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,8192,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,8193,0)
 ;;=R05.^^29^438^14
 ;;^UTILITY(U,$J,358.3,8193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8193,1,3,0)
 ;;=3^Cough
 ;;^UTILITY(U,$J,358.3,8193,1,4,0)
 ;;=4^R05.
 ;;^UTILITY(U,$J,358.3,8193,2)
 ;;=^5019179
 ;;^UTILITY(U,$J,358.3,8194,0)
 ;;=R07.9^^29^438^10
 ;;^UTILITY(U,$J,358.3,8194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8194,1,3,0)
 ;;=3^Chest pain, unspecified
 ;;^UTILITY(U,$J,358.3,8194,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,8194,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,8195,0)
 ;;=R10.9^^29^438^1
 ;;^UTILITY(U,$J,358.3,8195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8195,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,8195,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,8195,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,8196,0)
 ;;=R76.11^^29^438^32
 ;;^UTILITY(U,$J,358.3,8196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8196,1,3,0)
 ;;=3^Nonspecific reaction to skin test w/o active tuberculosis
 ;;^UTILITY(U,$J,358.3,8196,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,8196,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,8197,0)
 ;;=R76.12^^29^438^31
 ;;^UTILITY(U,$J,358.3,8197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8197,1,3,0)
 ;;=3^Nonspec reaction to gamma intrfrn respns w/o actv tubrclosis
 ;;^UTILITY(U,$J,358.3,8197,1,4,0)
 ;;=4^R76.12
 ;;^UTILITY(U,$J,358.3,8197,2)
 ;;=^5019571
 ;;^UTILITY(U,$J,358.3,8198,0)
 ;;=R03.0^^29^438^16
 ;;^UTILITY(U,$J,358.3,8198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8198,1,3,0)
 ;;=3^Elevated blood-pressure reading, w/o diagnosis of htn
 ;;^UTILITY(U,$J,358.3,8198,1,4,0)
 ;;=4^R03.0
 ;;^UTILITY(U,$J,358.3,8198,2)
 ;;=^5019171
 ;;^UTILITY(U,$J,358.3,8199,0)
 ;;=M25.50^^29^438^33
 ;;^UTILITY(U,$J,358.3,8199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8199,1,3,0)
 ;;=3^Pain in Joint,Unspec
 ;;^UTILITY(U,$J,358.3,8199,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,8199,2)
 ;;=^5011601
 ;;^UTILITY(U,$J,358.3,8200,0)
 ;;=Z23.^^29^438^17
 ;;^UTILITY(U,$J,358.3,8200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8200,1,3,0)
 ;;=3^Encounter for Immunization(s)
 ;;^UTILITY(U,$J,358.3,8200,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,8200,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,8201,0)
 ;;=Z02.71^^29^439^3
 ;;^UTILITY(U,$J,358.3,8201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8201,1,3,0)
 ;;=3^Disability determination
 ;;^UTILITY(U,$J,358.3,8201,1,4,0)
 ;;=4^Z02.71
 ;;^UTILITY(U,$J,358.3,8201,2)
 ;;=^5062640
 ;;^UTILITY(U,$J,358.3,8202,0)
 ;;=Z02.79^^29^439^9
 ;;^UTILITY(U,$J,358.3,8202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8202,1,3,0)
 ;;=3^Medical Certificate Issues NEC
 ;;^UTILITY(U,$J,358.3,8202,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,8202,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,8203,0)
 ;;=Z00.00^^29^439^8
 ;;^UTILITY(U,$J,358.3,8203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8203,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,8203,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,8203,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,8204,0)
 ;;=Z02.83^^29^439^2
 ;;^UTILITY(U,$J,358.3,8204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8204,1,3,0)
 ;;=3^Blood-alcohol and blood-drug test
 ;;^UTILITY(U,$J,358.3,8204,1,4,0)
 ;;=4^Z02.83
 ;;^UTILITY(U,$J,358.3,8204,2)
 ;;=^5062644
 ;;^UTILITY(U,$J,358.3,8205,0)
 ;;=Z02.81^^29^439^10
 ;;^UTILITY(U,$J,358.3,8205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8205,1,3,0)
 ;;=3^Paternity Testing
 ;;^UTILITY(U,$J,358.3,8205,1,4,0)
 ;;=4^Z02.81
 ;;^UTILITY(U,$J,358.3,8205,2)
 ;;=^5062642
 ;;^UTILITY(U,$J,358.3,8206,0)
 ;;=Z02.3^^29^439^12
 ;;^UTILITY(U,$J,358.3,8206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8206,1,3,0)
 ;;=3^Recruitment to Armed Forces Exam
 ;;^UTILITY(U,$J,358.3,8206,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,8206,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,8207,0)
 ;;=Z02.1^^29^439^11
 ;;^UTILITY(U,$J,358.3,8207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8207,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,8207,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,8207,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,8208,0)
 ;;=Z02.89^^29^439^1
 ;;^UTILITY(U,$J,358.3,8208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8208,1,3,0)
 ;;=3^Administrative Exam NEC
 ;;^UTILITY(U,$J,358.3,8208,1,4,0)
 ;;=4^Z02.89
 ;;^UTILITY(U,$J,358.3,8208,2)
 ;;=^5062645
 ;;^UTILITY(U,$J,358.3,8209,0)
 ;;=Z01.00^^29^439^6
 ;;^UTILITY(U,$J,358.3,8209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8209,1,3,0)
 ;;=3^Eyes/Vision Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,8209,1,4,0)
 ;;=4^Z01.00
 ;;^UTILITY(U,$J,358.3,8209,2)
 ;;=^5062612
 ;;^UTILITY(U,$J,358.3,8210,0)
 ;;=Z01.01^^29^439^5
 ;;^UTILITY(U,$J,358.3,8210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8210,1,3,0)
 ;;=3^Eyes/Vision Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,8210,1,4,0)
 ;;=4^Z01.01
 ;;^UTILITY(U,$J,358.3,8210,2)
 ;;=^5062613
 ;;^UTILITY(U,$J,358.3,8211,0)
 ;;=Z11.1^^29^439^13
 ;;^UTILITY(U,$J,358.3,8211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8211,1,3,0)
 ;;=3^Respiratory Tuberculosis Screen
 ;;^UTILITY(U,$J,358.3,8211,1,4,0)
 ;;=4^Z11.1
 ;;^UTILITY(U,$J,358.3,8211,2)
 ;;=^5062670
 ;;^UTILITY(U,$J,358.3,8212,0)
 ;;=Z00.01^^29^439^7
 ;;^UTILITY(U,$J,358.3,8212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8212,1,3,0)
 ;;=3^General Adult Med Exam w/ Abnormal Findings
 ;;^UTILITY(U,$J,358.3,8212,1,4,0)
 ;;=4^Z00.01
 ;;^UTILITY(U,$J,358.3,8212,2)
 ;;=^5062600
 ;;^UTILITY(U,$J,358.3,8213,0)
 ;;=Z23.^^29^439^4
 ;;^UTILITY(U,$J,358.3,8213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8213,1,3,0)
 ;;=3^Encounter for Immunization(s)
 ;;^UTILITY(U,$J,358.3,8213,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,8213,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,8214,0)
 ;;=Z09.^^29^440^1
 ;;^UTILITY(U,$J,358.3,8214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8214,1,3,0)
 ;;=3^F/U Exam after Trtmt for Conditions Oth Than Malig Neop
 ;;^UTILITY(U,$J,358.3,8214,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,8214,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,8215,0)
 ;;=Z08.^^29^440^2
 ;;^UTILITY(U,$J,358.3,8215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8215,1,3,0)
 ;;=3^F/U Exam after Trtmt for Malig Neop
 ;;^UTILITY(U,$J,358.3,8215,1,4,0)
 ;;=4^Z08.
 ;;^UTILITY(U,$J,358.3,8215,2)
 ;;=^5062667
 ;;^UTILITY(U,$J,358.3,8216,0)
 ;;=Z23.^^29^441^1
 ;;^UTILITY(U,$J,358.3,8216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8216,1,3,0)
 ;;=3^Encounter for immunization
 ;;^UTILITY(U,$J,358.3,8216,1,4,0)
 ;;=4^Z23.
 ;;^UTILITY(U,$J,358.3,8216,2)
 ;;=^5062795
 ;;^UTILITY(U,$J,358.3,8217,0)
 ;;=Y93.A1^^29^442^1
 ;;^UTILITY(U,$J,358.3,8217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8217,1,3,0)
 ;;=3^Activity Exercise Machines Primarily Cardiovascular Conditioning
 ;;^UTILITY(U,$J,358.3,8217,1,4,0)
 ;;=4^Y93.A1
 ;;^UTILITY(U,$J,358.3,8217,2)
 ;;=^5062545
 ;;^UTILITY(U,$J,358.3,8218,0)
 ;;=Z71.89^^29^443^1
 ;;^UTILITY(U,$J,358.3,8218,1,0)
 ;;=^358.31IA^4^2
