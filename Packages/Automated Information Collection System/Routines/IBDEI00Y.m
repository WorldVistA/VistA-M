IBDEI00Y ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,424,1,4,0)
 ;;=4^Z63.0
 ;;^UTILITY(U,$J,358.3,424,2)
 ;;=^5063164
 ;;^UTILITY(U,$J,358.3,425,0)
 ;;=Z63.5^^3^42^2
 ;;^UTILITY(U,$J,358.3,425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,425,1,3,0)
 ;;=3^Disruption of Family by Separation or Divorce
 ;;^UTILITY(U,$J,358.3,425,1,4,0)
 ;;=4^Z63.5
 ;;^UTILITY(U,$J,358.3,425,2)
 ;;=^5063169
 ;;^UTILITY(U,$J,358.3,426,0)
 ;;=Z63.8^^3^42^3
 ;;^UTILITY(U,$J,358.3,426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,426,1,3,0)
 ;;=3^High Expressed Emotion Level w/in Family
 ;;^UTILITY(U,$J,358.3,426,1,4,0)
 ;;=4^Z63.8
 ;;^UTILITY(U,$J,358.3,426,2)
 ;;=^5063174
 ;;^UTILITY(U,$J,358.3,427,0)
 ;;=Z63.4^^3^42^7
 ;;^UTILITY(U,$J,358.3,427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,427,1,3,0)
 ;;=3^Uncomplicated Bereavement
 ;;^UTILITY(U,$J,358.3,427,1,4,0)
 ;;=4^Z63.4
 ;;^UTILITY(U,$J,358.3,427,2)
 ;;=^5063168
 ;;^UTILITY(U,$J,358.3,428,0)
 ;;=Z62.29^^3^42^8
 ;;^UTILITY(U,$J,358.3,428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,428,1,3,0)
 ;;=3^Upbringing Away from Parents
 ;;^UTILITY(U,$J,358.3,428,1,4,0)
 ;;=4^Z62.29
 ;;^UTILITY(U,$J,358.3,428,2)
 ;;=^5063150
 ;;^UTILITY(U,$J,358.3,429,0)
 ;;=F20.9^^3^43^11
 ;;^UTILITY(U,$J,358.3,429,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,429,1,3,0)
 ;;=3^Schizophrenia
 ;;^UTILITY(U,$J,358.3,429,1,4,0)
 ;;=4^F20.9
 ;;^UTILITY(U,$J,358.3,429,2)
 ;;=^5003476
 ;;^UTILITY(U,$J,358.3,430,0)
 ;;=F20.81^^3^43^14
 ;;^UTILITY(U,$J,358.3,430,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,430,1,3,0)
 ;;=3^Schizophreniform Disorder
 ;;^UTILITY(U,$J,358.3,430,1,4,0)
 ;;=4^F20.81
 ;;^UTILITY(U,$J,358.3,430,2)
 ;;=^5003474
 ;;^UTILITY(U,$J,358.3,431,0)
 ;;=F22.^^3^43^5
 ;;^UTILITY(U,$J,358.3,431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,431,1,3,0)
 ;;=3^Delusional Disorder
 ;;^UTILITY(U,$J,358.3,431,1,4,0)
 ;;=4^F22.
 ;;^UTILITY(U,$J,358.3,431,2)
 ;;=^5003478
 ;;^UTILITY(U,$J,358.3,432,0)
 ;;=F23.^^3^43^1
 ;;^UTILITY(U,$J,358.3,432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,432,1,3,0)
 ;;=3^Brief Psychotic Disorder
 ;;^UTILITY(U,$J,358.3,432,1,4,0)
 ;;=4^F23.
 ;;^UTILITY(U,$J,358.3,432,2)
 ;;=^5003479
 ;;^UTILITY(U,$J,358.3,433,0)
 ;;=F25.0^^3^43^9
 ;;^UTILITY(U,$J,358.3,433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,433,1,3,0)
 ;;=3^Schizoaffective Disorder,Bipolar Type
 ;;^UTILITY(U,$J,358.3,433,1,4,0)
 ;;=4^F25.0
 ;;^UTILITY(U,$J,358.3,433,2)
 ;;=^5003480
 ;;^UTILITY(U,$J,358.3,434,0)
 ;;=F25.1^^3^43^10
 ;;^UTILITY(U,$J,358.3,434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,434,1,3,0)
 ;;=3^Schizoaffective Disorder,Depressive Type
 ;;^UTILITY(U,$J,358.3,434,1,4,0)
 ;;=4^F25.1
 ;;^UTILITY(U,$J,358.3,434,2)
 ;;=^5003481
 ;;^UTILITY(U,$J,358.3,435,0)
 ;;=F28.^^3^43^12
 ;;^UTILITY(U,$J,358.3,435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,435,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Oth Specified
 ;;^UTILITY(U,$J,358.3,435,1,4,0)
 ;;=4^F28.
 ;;^UTILITY(U,$J,358.3,435,2)
 ;;=^5003483
 ;;^UTILITY(U,$J,358.3,436,0)
 ;;=F29.^^3^43^13
 ;;^UTILITY(U,$J,358.3,436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,436,1,3,0)
 ;;=3^Schizophrenia Spectrum & Psychotic Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,436,1,4,0)
 ;;=4^F29.
 ;;^UTILITY(U,$J,358.3,436,2)
 ;;=^5003484
 ;;^UTILITY(U,$J,358.3,437,0)
 ;;=F06.1^^3^43^2
 ;;^UTILITY(U,$J,358.3,437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,437,1,3,0)
 ;;=3^Catatonia Associated w/ Another Mental Disorder
 ;;^UTILITY(U,$J,358.3,437,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,437,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,438,0)
 ;;=F06.1^^3^43^4
 ;;^UTILITY(U,$J,358.3,438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,438,1,3,0)
 ;;=3^Catatonic Disorder d/t Another Medical Condition
 ;;^UTILITY(U,$J,358.3,438,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,438,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,439,0)
 ;;=F06.1^^3^43^3
 ;;^UTILITY(U,$J,358.3,439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,439,1,3,0)
 ;;=3^Catatonia,Unspec
 ;;^UTILITY(U,$J,358.3,439,1,4,0)
 ;;=4^F06.1
 ;;^UTILITY(U,$J,358.3,439,2)
 ;;=^5003054
 ;;^UTILITY(U,$J,358.3,440,0)
 ;;=R29.818^^3^43^6
 ;;^UTILITY(U,$J,358.3,440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,440,1,3,0)
 ;;=3^Nervous & Musculoskeletal System Symptoms,Other
 ;;^UTILITY(U,$J,358.3,440,1,4,0)
 ;;=4^R29.818
 ;;^UTILITY(U,$J,358.3,440,2)
 ;;=^5019318
 ;;^UTILITY(U,$J,358.3,441,0)
 ;;=F06.2^^3^43^7
 ;;^UTILITY(U,$J,358.3,441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,441,1,3,0)
 ;;=3^Psychotic Disorder d/t Another Med Cond w/ Delusions
 ;;^UTILITY(U,$J,358.3,441,1,4,0)
 ;;=4^F06.2
 ;;^UTILITY(U,$J,358.3,441,2)
 ;;=^5003055
 ;;^UTILITY(U,$J,358.3,442,0)
 ;;=F06.0^^3^43^8
 ;;^UTILITY(U,$J,358.3,442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,442,1,3,0)
 ;;=3^Psychotic Disorder d/t Another Med Cond w/ Hallucinations
 ;;^UTILITY(U,$J,358.3,442,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,442,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,443,0)
 ;;=F52.32^^3^44^1
 ;;^UTILITY(U,$J,358.3,443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,443,1,3,0)
 ;;=3^Delayed Ejaculation
 ;;^UTILITY(U,$J,358.3,443,1,4,0)
 ;;=4^F52.32
 ;;^UTILITY(U,$J,358.3,443,2)
 ;;=^331927
 ;;^UTILITY(U,$J,358.3,444,0)
 ;;=F52.21^^3^44^2
 ;;^UTILITY(U,$J,358.3,444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,444,1,3,0)
 ;;=3^Erectile Disorder
 ;;^UTILITY(U,$J,358.3,444,1,4,0)
 ;;=4^F52.21
 ;;^UTILITY(U,$J,358.3,444,2)
 ;;=^5003620
 ;;^UTILITY(U,$J,358.3,445,0)
 ;;=F52.31^^3^44^3
 ;;^UTILITY(U,$J,358.3,445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,445,1,3,0)
 ;;=3^Female Orgasmic Disorder
 ;;^UTILITY(U,$J,358.3,445,1,4,0)
 ;;=4^F52.31
 ;;^UTILITY(U,$J,358.3,445,2)
 ;;=^331926
 ;;^UTILITY(U,$J,358.3,446,0)
 ;;=F52.22^^3^44^4
 ;;^UTILITY(U,$J,358.3,446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,446,1,3,0)
 ;;=3^Female Sexual Interest/Arousal Disorder
 ;;^UTILITY(U,$J,358.3,446,1,4,0)
 ;;=4^F52.22
 ;;^UTILITY(U,$J,358.3,446,2)
 ;;=^5003621
 ;;^UTILITY(U,$J,358.3,447,0)
 ;;=F52.6^^3^44^5
 ;;^UTILITY(U,$J,358.3,447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,447,1,3,0)
 ;;=3^Genito-Pelvic Pain/Penetration Disorder
 ;;^UTILITY(U,$J,358.3,447,1,4,0)
 ;;=4^F52.6
 ;;^UTILITY(U,$J,358.3,447,2)
 ;;=^5003623
 ;;^UTILITY(U,$J,358.3,448,0)
 ;;=F52.0^^3^44^6
 ;;^UTILITY(U,$J,358.3,448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,448,1,3,0)
 ;;=3^Male Hypoactive Sexual Desire Disorder
 ;;^UTILITY(U,$J,358.3,448,1,4,0)
 ;;=4^F52.0
 ;;^UTILITY(U,$J,358.3,448,2)
 ;;=^5003618
 ;;^UTILITY(U,$J,358.3,449,0)
 ;;=F52.4^^3^44^7
 ;;^UTILITY(U,$J,358.3,449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,449,1,3,0)
 ;;=3^Premature (Early) Ejaculation
 ;;^UTILITY(U,$J,358.3,449,1,4,0)
 ;;=4^F52.4
 ;;^UTILITY(U,$J,358.3,449,2)
 ;;=^331928
 ;;^UTILITY(U,$J,358.3,450,0)
 ;;=F52.8^^3^44^9
 ;;^UTILITY(U,$J,358.3,450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,450,1,3,0)
 ;;=3^Sexual Dysfuntion,Other
 ;;^UTILITY(U,$J,358.3,450,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,450,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,451,0)
 ;;=F52.9^^3^44^8
 ;;^UTILITY(U,$J,358.3,451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,451,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,451,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,451,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,452,0)
 ;;=G47.09^^3^45^16
 ;;^UTILITY(U,$J,358.3,452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,452,1,3,0)
 ;;=3^Insomnia,Other Specified
 ;;^UTILITY(U,$J,358.3,452,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,452,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,453,0)
 ;;=G47.00^^3^45^17
 ;;^UTILITY(U,$J,358.3,453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,453,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,453,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,453,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,454,0)
 ;;=G47.10^^3^45^14
 ;;^UTILITY(U,$J,358.3,454,1,0)
 ;;=^358.31IA^4^2
