IBDEI098 ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9175,1,3,0)
 ;;=3^Chronic pansinusitis
 ;;^UTILITY(U,$J,358.3,9175,1,4,0)
 ;;=4^J32.4
 ;;^UTILITY(U,$J,358.3,9175,2)
 ;;=^5008206
 ;;^UTILITY(U,$J,358.3,9176,0)
 ;;=J32.8^^45^534^11
 ;;^UTILITY(U,$J,358.3,9176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9176,1,3,0)
 ;;=3^Chronic Sinusitis NEC
 ;;^UTILITY(U,$J,358.3,9176,1,4,0)
 ;;=4^J32.8
 ;;^UTILITY(U,$J,358.3,9176,2)
 ;;=^269890
 ;;^UTILITY(U,$J,358.3,9177,0)
 ;;=J30.9^^45^534^4
 ;;^UTILITY(U,$J,358.3,9177,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9177,1,3,0)
 ;;=3^Allergic rhinitis, unspecified
 ;;^UTILITY(U,$J,358.3,9177,1,4,0)
 ;;=4^J30.9
 ;;^UTILITY(U,$J,358.3,9177,2)
 ;;=^5008205
 ;;^UTILITY(U,$J,358.3,9178,0)
 ;;=J40.^^45^534^8
 ;;^UTILITY(U,$J,358.3,9178,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9178,1,3,0)
 ;;=3^Bronchitis, not specified as acute or chronic
 ;;^UTILITY(U,$J,358.3,9178,1,4,0)
 ;;=4^J40.
 ;;^UTILITY(U,$J,358.3,9178,2)
 ;;=^17164
 ;;^UTILITY(U,$J,358.3,9179,0)
 ;;=J45.909^^45^534^7
 ;;^UTILITY(U,$J,358.3,9179,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9179,1,3,0)
 ;;=3^Asthma,Uncomplicated,Unspec
 ;;^UTILITY(U,$J,358.3,9179,1,4,0)
 ;;=4^J45.909
 ;;^UTILITY(U,$J,358.3,9179,2)
 ;;=^5008256
 ;;^UTILITY(U,$J,358.3,9180,0)
 ;;=K52.9^^45^534^29
 ;;^UTILITY(U,$J,358.3,9180,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9180,1,3,0)
 ;;=3^Noninfective gastroenteritis and colitis, unspecified
 ;;^UTILITY(U,$J,358.3,9180,1,4,0)
 ;;=4^K52.9
 ;;^UTILITY(U,$J,358.3,9180,2)
 ;;=^5008704
 ;;^UTILITY(U,$J,358.3,9181,0)
 ;;=M25.511^^45^534^38
 ;;^UTILITY(U,$J,358.3,9181,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9181,1,3,0)
 ;;=3^Pain in right shoulder
 ;;^UTILITY(U,$J,358.3,9181,1,4,0)
 ;;=4^M25.511
 ;;^UTILITY(U,$J,358.3,9181,2)
 ;;=^5011602
 ;;^UTILITY(U,$J,358.3,9182,0)
 ;;=M25.512^^45^534^35
 ;;^UTILITY(U,$J,358.3,9182,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9182,1,3,0)
 ;;=3^Pain in left shoulder
 ;;^UTILITY(U,$J,358.3,9182,1,4,0)
 ;;=4^M25.512
 ;;^UTILITY(U,$J,358.3,9182,2)
 ;;=^5011603
 ;;^UTILITY(U,$J,358.3,9183,0)
 ;;=M25.551^^45^534^36
 ;;^UTILITY(U,$J,358.3,9183,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9183,1,3,0)
 ;;=3^Pain in right hip
 ;;^UTILITY(U,$J,358.3,9183,1,4,0)
 ;;=4^M25.551
 ;;^UTILITY(U,$J,358.3,9183,2)
 ;;=^5011611
 ;;^UTILITY(U,$J,358.3,9184,0)
 ;;=M25.552^^45^534^33
 ;;^UTILITY(U,$J,358.3,9184,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9184,1,3,0)
 ;;=3^Pain in left hip
 ;;^UTILITY(U,$J,358.3,9184,1,4,0)
 ;;=4^M25.552
 ;;^UTILITY(U,$J,358.3,9184,2)
 ;;=^5011612
 ;;^UTILITY(U,$J,358.3,9185,0)
 ;;=M25.561^^45^534^37
 ;;^UTILITY(U,$J,358.3,9185,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9185,1,3,0)
 ;;=3^Pain in right knee
 ;;^UTILITY(U,$J,358.3,9185,1,4,0)
 ;;=4^M25.561
 ;;^UTILITY(U,$J,358.3,9185,2)
 ;;=^5011614
 ;;^UTILITY(U,$J,358.3,9186,0)
 ;;=M25.562^^45^534^34
 ;;^UTILITY(U,$J,358.3,9186,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9186,1,3,0)
 ;;=3^Pain in left knee
 ;;^UTILITY(U,$J,358.3,9186,1,4,0)
 ;;=4^M25.562
 ;;^UTILITY(U,$J,358.3,9186,2)
 ;;=^5011615
 ;;^UTILITY(U,$J,358.3,9187,0)
 ;;=M54.2^^45^534^9
 ;;^UTILITY(U,$J,358.3,9187,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9187,1,3,0)
 ;;=3^Cervicalgia
 ;;^UTILITY(U,$J,358.3,9187,1,4,0)
 ;;=4^M54.2
 ;;^UTILITY(U,$J,358.3,9187,2)
 ;;=^5012304
 ;;^UTILITY(U,$J,358.3,9188,0)
 ;;=M54.5^^45^534^22
 ;;^UTILITY(U,$J,358.3,9188,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9188,1,3,0)
 ;;=3^Low back pain
 ;;^UTILITY(U,$J,358.3,9188,1,4,0)
 ;;=4^M54.5
 ;;^UTILITY(U,$J,358.3,9188,2)
 ;;=^5012311
 ;;^UTILITY(U,$J,358.3,9189,0)
 ;;=M54.9^^45^534^15
 ;;^UTILITY(U,$J,358.3,9189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9189,1,3,0)
 ;;=3^Dorsalgia, unspecified
 ;;^UTILITY(U,$J,358.3,9189,1,4,0)
 ;;=4^M54.9
 ;;^UTILITY(U,$J,358.3,9189,2)
 ;;=^5012314
 ;;^UTILITY(U,$J,358.3,9190,0)
 ;;=R51.^^45^534^18
 ;;^UTILITY(U,$J,358.3,9190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9190,1,3,0)
 ;;=3^Headache
 ;;^UTILITY(U,$J,358.3,9190,1,4,0)
 ;;=4^R51.
 ;;^UTILITY(U,$J,358.3,9190,2)
 ;;=^5019513
 ;;^UTILITY(U,$J,358.3,9191,0)
 ;;=R05.^^45^534^14
 ;;^UTILITY(U,$J,358.3,9191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9191,1,3,0)
 ;;=3^Cough
 ;;^UTILITY(U,$J,358.3,9191,1,4,0)
 ;;=4^R05.
 ;;^UTILITY(U,$J,358.3,9191,2)
 ;;=^5019179
 ;;^UTILITY(U,$J,358.3,9192,0)
 ;;=R07.9^^45^534^10
 ;;^UTILITY(U,$J,358.3,9192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9192,1,3,0)
 ;;=3^Chest pain, unspecified
 ;;^UTILITY(U,$J,358.3,9192,1,4,0)
 ;;=4^R07.9
 ;;^UTILITY(U,$J,358.3,9192,2)
 ;;=^5019201
 ;;^UTILITY(U,$J,358.3,9193,0)
 ;;=R10.9^^45^534^1
 ;;^UTILITY(U,$J,358.3,9193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9193,1,3,0)
 ;;=3^Abdominal Pain,Unspec
 ;;^UTILITY(U,$J,358.3,9193,1,4,0)
 ;;=4^R10.9
 ;;^UTILITY(U,$J,358.3,9193,2)
 ;;=^5019230
 ;;^UTILITY(U,$J,358.3,9194,0)
 ;;=R76.11^^45^534^31
 ;;^UTILITY(U,$J,358.3,9194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9194,1,3,0)
 ;;=3^Nonspecific reaction to skin test w/o active tuberculosis
 ;;^UTILITY(U,$J,358.3,9194,1,4,0)
 ;;=4^R76.11
 ;;^UTILITY(U,$J,358.3,9194,2)
 ;;=^5019570
 ;;^UTILITY(U,$J,358.3,9195,0)
 ;;=R76.12^^45^534^30
 ;;^UTILITY(U,$J,358.3,9195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9195,1,3,0)
 ;;=3^Nonspec reaction to gamma intrfrn respns w/o actv tubrclosis
 ;;^UTILITY(U,$J,358.3,9195,1,4,0)
 ;;=4^R76.12
 ;;^UTILITY(U,$J,358.3,9195,2)
 ;;=^5019571
 ;;^UTILITY(U,$J,358.3,9196,0)
 ;;=R03.0^^45^534^16
 ;;^UTILITY(U,$J,358.3,9196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9196,1,3,0)
 ;;=3^Elevated blood-pressure reading, w/o diagnosis of htn
 ;;^UTILITY(U,$J,358.3,9196,1,4,0)
 ;;=4^R03.0
 ;;^UTILITY(U,$J,358.3,9196,2)
 ;;=^5019171
 ;;^UTILITY(U,$J,358.3,9197,0)
 ;;=M25.50^^45^534^32
 ;;^UTILITY(U,$J,358.3,9197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9197,1,3,0)
 ;;=3^Pain in Joint,Unspec
 ;;^UTILITY(U,$J,358.3,9197,1,4,0)
 ;;=4^M25.50
 ;;^UTILITY(U,$J,358.3,9197,2)
 ;;=^5011601
 ;;^UTILITY(U,$J,358.3,9198,0)
 ;;=Z02.71^^45^535^3
 ;;^UTILITY(U,$J,358.3,9198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9198,1,3,0)
 ;;=3^Disability determination
 ;;^UTILITY(U,$J,358.3,9198,1,4,0)
 ;;=4^Z02.71
 ;;^UTILITY(U,$J,358.3,9198,2)
 ;;=^5062640
 ;;^UTILITY(U,$J,358.3,9199,0)
 ;;=Z02.79^^45^535^8
 ;;^UTILITY(U,$J,358.3,9199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9199,1,3,0)
 ;;=3^Medical Certificate Issues NEC
 ;;^UTILITY(U,$J,358.3,9199,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,9199,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,9200,0)
 ;;=Z00.00^^45^535^7
 ;;^UTILITY(U,$J,358.3,9200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9200,1,3,0)
 ;;=3^General Adult Med Exam w/o Abnormal Findings
 ;;^UTILITY(U,$J,358.3,9200,1,4,0)
 ;;=4^Z00.00
 ;;^UTILITY(U,$J,358.3,9200,2)
 ;;=^5062599
 ;;^UTILITY(U,$J,358.3,9201,0)
 ;;=Z02.83^^45^535^2
 ;;^UTILITY(U,$J,358.3,9201,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9201,1,3,0)
 ;;=3^Blood-alcohol and blood-drug test
 ;;^UTILITY(U,$J,358.3,9201,1,4,0)
 ;;=4^Z02.83
 ;;^UTILITY(U,$J,358.3,9201,2)
 ;;=^5062644
 ;;^UTILITY(U,$J,358.3,9202,0)
 ;;=Z02.81^^45^535^9
 ;;^UTILITY(U,$J,358.3,9202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9202,1,3,0)
 ;;=3^Paternity Testing
 ;;^UTILITY(U,$J,358.3,9202,1,4,0)
 ;;=4^Z02.81
 ;;^UTILITY(U,$J,358.3,9202,2)
 ;;=^5062642
 ;;^UTILITY(U,$J,358.3,9203,0)
 ;;=Z02.3^^45^535^11
 ;;^UTILITY(U,$J,358.3,9203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9203,1,3,0)
 ;;=3^Recruitment to Armed Forces Exam
 ;;^UTILITY(U,$J,358.3,9203,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,9203,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,9204,0)
 ;;=Z02.1^^45^535^10
 ;;^UTILITY(U,$J,358.3,9204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,9204,1,3,0)
 ;;=3^Pre-Employment Exam
 ;;^UTILITY(U,$J,358.3,9204,1,4,0)
 ;;=4^Z02.1
