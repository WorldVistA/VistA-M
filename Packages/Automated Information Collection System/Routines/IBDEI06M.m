IBDEI06M ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8720,1,5,0)
 ;;=5^Psychiatric Examination
 ;;^UTILITY(U,$J,358.3,8720,2)
 ;;=^295592
 ;;^UTILITY(U,$J,358.3,8721,0)
 ;;=V61.21^^63^487^4
 ;;^UTILITY(U,$J,358.3,8721,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8721,1,2,0)
 ;;=2^V61.21
 ;;^UTILITY(U,$J,358.3,8721,1,5,0)
 ;;=5^Child Abuse Victim Couns
 ;;^UTILITY(U,$J,358.3,8721,2)
 ;;=^304301
 ;;^UTILITY(U,$J,358.3,8722,0)
 ;;=296.20^^63^488^14
 ;;^UTILITY(U,$J,358.3,8722,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8722,1,2,0)
 ;;=2^296.20
 ;;^UTILITY(U,$J,358.3,8722,1,5,0)
 ;;=5^MDD, Single, NOS
 ;;^UTILITY(U,$J,358.3,8722,2)
 ;;=^73311
 ;;^UTILITY(U,$J,358.3,8723,0)
 ;;=296.21^^63^488^12
 ;;^UTILITY(U,$J,358.3,8723,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8723,1,2,0)
 ;;=2^296.21
 ;;^UTILITY(U,$J,358.3,8723,1,5,0)
 ;;=5^MDD, Single, Mild
 ;;^UTILITY(U,$J,358.3,8723,2)
 ;;=^268110
 ;;^UTILITY(U,$J,358.3,8724,0)
 ;;=296.22^^63^488^13
 ;;^UTILITY(U,$J,358.3,8724,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8724,1,2,0)
 ;;=2^296.22
 ;;^UTILITY(U,$J,358.3,8724,1,5,0)
 ;;=5^MDD, Single, Moderate
 ;;^UTILITY(U,$J,358.3,8724,2)
 ;;=^268111
 ;;^UTILITY(U,$J,358.3,8725,0)
 ;;=296.23^^63^488^5
 ;;^UTILITY(U,$J,358.3,8725,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8725,1,2,0)
 ;;=2^296.23
 ;;^UTILITY(U,$J,358.3,8725,1,5,0)
 ;;=5^MDD Sing, Sev w/o Psychosis
 ;;^UTILITY(U,$J,358.3,8725,2)
 ;;=^268112
 ;;^UTILITY(U,$J,358.3,8726,0)
 ;;=296.24^^63^488^4
 ;;^UTILITY(U,$J,358.3,8726,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8726,1,2,0)
 ;;=2^296.24
 ;;^UTILITY(U,$J,358.3,8726,1,5,0)
 ;;=5^MDD Sing, Sev w/Psychosis
 ;;^UTILITY(U,$J,358.3,8726,2)
 ;;=^268113
 ;;^UTILITY(U,$J,358.3,8727,0)
 ;;=296.25^^63^488^15
 ;;^UTILITY(U,$J,358.3,8727,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8727,1,2,0)
 ;;=2^296.25
 ;;^UTILITY(U,$J,358.3,8727,1,5,0)
 ;;=5^MDD, Single, Part Remiss
 ;;^UTILITY(U,$J,358.3,8727,2)
 ;;=^268114
 ;;^UTILITY(U,$J,358.3,8728,0)
 ;;=296.30^^63^488^9
 ;;^UTILITY(U,$J,358.3,8728,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8728,1,2,0)
 ;;=2^296.30
 ;;^UTILITY(U,$J,358.3,8728,1,5,0)
 ;;=5^MDD, Recur, NOS
 ;;^UTILITY(U,$J,358.3,8728,2)
 ;;=^268116
 ;;^UTILITY(U,$J,358.3,8729,0)
 ;;=296.31^^63^488^7
 ;;^UTILITY(U,$J,358.3,8729,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8729,1,2,0)
 ;;=2^296.31
 ;;^UTILITY(U,$J,358.3,8729,1,5,0)
 ;;=5^MDD, Recur, Mild
 ;;^UTILITY(U,$J,358.3,8729,2)
 ;;=^268117
 ;;^UTILITY(U,$J,358.3,8730,0)
 ;;=296.32^^63^488^8
 ;;^UTILITY(U,$J,358.3,8730,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8730,1,2,0)
 ;;=2^296.32
 ;;^UTILITY(U,$J,358.3,8730,1,5,0)
 ;;=5^MDD, Recur, Moderate
 ;;^UTILITY(U,$J,358.3,8730,2)
 ;;=^268118
 ;;^UTILITY(U,$J,358.3,8731,0)
 ;;=296.33^^63^488^3
 ;;^UTILITY(U,$J,358.3,8731,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8731,1,2,0)
 ;;=2^296.33
 ;;^UTILITY(U,$J,358.3,8731,1,5,0)
 ;;=5^MDD Recur, Sev w/o Psychosis
 ;;^UTILITY(U,$J,358.3,8731,2)
 ;;=^268119
 ;;^UTILITY(U,$J,358.3,8732,0)
 ;;=296.34^^63^488^2
 ;;^UTILITY(U,$J,358.3,8732,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8732,1,2,0)
 ;;=2^296.34
 ;;^UTILITY(U,$J,358.3,8732,1,5,0)
 ;;=5^MDD Recur, Sev w/Psychosis
 ;;^UTILITY(U,$J,358.3,8732,2)
 ;;=^268120
 ;;^UTILITY(U,$J,358.3,8733,0)
 ;;=296.35^^63^488^10
 ;;^UTILITY(U,$J,358.3,8733,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8733,1,2,0)
 ;;=2^296.35
 ;;^UTILITY(U,$J,358.3,8733,1,5,0)
 ;;=5^MDD, Recur, Part Remiss
 ;;^UTILITY(U,$J,358.3,8733,2)
 ;;=^268121
 ;;^UTILITY(U,$J,358.3,8734,0)
 ;;=296.36^^63^488^6
 ;;^UTILITY(U,$J,358.3,8734,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8734,1,2,0)
 ;;=2^296.36
 ;;^UTILITY(U,$J,358.3,8734,1,5,0)
 ;;=5^MDD, Recur, Full Remiss
 ;;^UTILITY(U,$J,358.3,8734,2)
 ;;=^268122
 ;;^UTILITY(U,$J,358.3,8735,0)
 ;;=311.^^63^488^1
 ;;^UTILITY(U,$J,358.3,8735,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8735,1,2,0)
 ;;=2^311.
 ;;^UTILITY(U,$J,358.3,8735,1,5,0)
 ;;=5^Depression, NOS
 ;;^UTILITY(U,$J,358.3,8735,2)
 ;;=^35603
 ;;^UTILITY(U,$J,358.3,8736,0)
 ;;=296.26^^63^488^11
 ;;^UTILITY(U,$J,358.3,8736,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8736,1,2,0)
 ;;=2^296.26
 ;;^UTILITY(U,$J,358.3,8736,1,5,0)
 ;;=5^MDD, Single, Full Remiss
 ;;^UTILITY(U,$J,358.3,8736,2)
 ;;=^268115
 ;;^UTILITY(U,$J,358.3,8737,0)
 ;;=301.13^^63^489^1
 ;;^UTILITY(U,$J,358.3,8737,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8737,1,2,0)
 ;;=2^301.13
 ;;^UTILITY(U,$J,358.3,8737,1,5,0)
 ;;=5^Cyclothymic Disorder
 ;;^UTILITY(U,$J,358.3,8737,2)
 ;;=^30028
 ;;^UTILITY(U,$J,358.3,8738,0)
 ;;=300.4^^63^489^2
 ;;^UTILITY(U,$J,358.3,8738,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8738,1,2,0)
 ;;=2^300.4
 ;;^UTILITY(U,$J,358.3,8738,1,5,0)
 ;;=5^Dysthymia
 ;;^UTILITY(U,$J,358.3,8738,2)
 ;;=^303478
 ;;^UTILITY(U,$J,358.3,8739,0)
 ;;=295.12^^63^490^1
 ;;^UTILITY(U,$J,358.3,8739,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8739,1,2,0)
 ;;=2^295.12
 ;;^UTILITY(U,$J,358.3,8739,1,5,0)
 ;;=5^Disorganized Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,8739,2)
 ;;=^268051
 ;;^UTILITY(U,$J,358.3,8740,0)
 ;;=295.14^^63^490^2
 ;;^UTILITY(U,$J,358.3,8740,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8740,1,2,0)
 ;;=2^295.14
 ;;^UTILITY(U,$J,358.3,8740,1,5,0)
 ;;=5^Disorganized Schizophrenia,Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,8740,2)
 ;;=^268053
 ;;^UTILITY(U,$J,358.3,8741,0)
 ;;=295.52^^63^490^3
 ;;^UTILITY(U,$J,358.3,8741,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8741,1,2,0)
 ;;=2^295.52
 ;;^UTILITY(U,$J,358.3,8741,1,5,0)
 ;;=5^Latent Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,8741,2)
 ;;=Latent Schizophrenia, Chronic^268073
 ;;^UTILITY(U,$J,358.3,8742,0)
 ;;=295.54^^63^490^4
 ;;^UTILITY(U,$J,358.3,8742,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8742,1,2,0)
 ;;=2^295.54
 ;;^UTILITY(U,$J,358.3,8742,1,5,0)
 ;;=5^Latent Schizophrenia, Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,8742,2)
 ;;=^268075
 ;;^UTILITY(U,$J,358.3,8743,0)
 ;;=295.32^^63^490^5
 ;;^UTILITY(U,$J,358.3,8743,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8743,1,2,0)
 ;;=2^295.32
 ;;^UTILITY(U,$J,358.3,8743,1,5,0)
 ;;=5^Paranoid Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,8743,2)
 ;;=Paranoid Schizophrenia, Chronic^268061
 ;;^UTILITY(U,$J,358.3,8744,0)
 ;;=295.34^^63^490^6
 ;;^UTILITY(U,$J,358.3,8744,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8744,1,2,0)
 ;;=2^295.34
 ;;^UTILITY(U,$J,358.3,8744,1,5,0)
 ;;=5^Paranoid, Schizophrenia Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,8744,2)
 ;;=^268063
 ;;^UTILITY(U,$J,358.3,8745,0)
 ;;=295.62^^63^490^14
 ;;^UTILITY(U,$J,358.3,8745,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8745,1,2,0)
 ;;=2^295.62
 ;;^UTILITY(U,$J,358.3,8745,1,5,0)
 ;;=5^Undifferentiated Schizophrenia, Chr
 ;;^UTILITY(U,$J,358.3,8745,2)
 ;;=^268078
 ;;^UTILITY(U,$J,358.3,8746,0)
 ;;=295.72^^63^490^8
 ;;^UTILITY(U,$J,358.3,8746,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8746,1,2,0)
 ;;=2^295.72
 ;;^UTILITY(U,$J,358.3,8746,1,5,0)
 ;;=5^Schizoaffective Disorder, Chr
 ;;^UTILITY(U,$J,358.3,8746,2)
 ;;=^268083
 ;;^UTILITY(U,$J,358.3,8747,0)
 ;;=295.74^^63^490^9
 ;;^UTILITY(U,$J,358.3,8747,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8747,1,2,0)
 ;;=2^295.74
 ;;^UTILITY(U,$J,358.3,8747,1,5,0)
 ;;=5^Schizoaffective Disorder, w/Exacerb.
 ;;^UTILITY(U,$J,358.3,8747,2)
 ;;=^268085
 ;;^UTILITY(U,$J,358.3,8748,0)
 ;;=295.42^^63^490^10
 ;;^UTILITY(U,$J,358.3,8748,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8748,1,2,0)
 ;;=2^295.42
 ;;^UTILITY(U,$J,358.3,8748,1,5,0)
 ;;=5^Schizophreniform Disorder, Chr
 ;;^UTILITY(U,$J,358.3,8748,2)
 ;;=^268068
 ;;^UTILITY(U,$J,358.3,8749,0)
 ;;=295.44^^63^490^11
 ;;^UTILITY(U,$J,358.3,8749,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8749,1,2,0)
 ;;=2^295.44
 ;;^UTILITY(U,$J,358.3,8749,1,5,0)
 ;;=5^Schizophreniform Disorderw/Exacerb.
 ;;^UTILITY(U,$J,358.3,8749,2)
 ;;=^268070
 ;;^UTILITY(U,$J,358.3,8750,0)
 ;;=295.02^^63^490^12
 ;;^UTILITY(U,$J,358.3,8750,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8750,1,2,0)
 ;;=2^295.02
 ;;^UTILITY(U,$J,358.3,8750,1,5,0)
 ;;=5^Simple Schizophrenia, Chronic
 ;;^UTILITY(U,$J,358.3,8750,2)
 ;;=Simple Schizophrenia, Chronic^268046
 ;;^UTILITY(U,$J,358.3,8751,0)
 ;;=295.04^^63^490^13
 ;;^UTILITY(U,$J,358.3,8751,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8751,1,2,0)
 ;;=2^295.04
 ;;^UTILITY(U,$J,358.3,8751,1,5,0)
 ;;=5^Simple Schizophrenia,  Chr w/Exacerbation
 ;;^UTILITY(U,$J,358.3,8751,2)
 ;;=^268048
 ;;^UTILITY(U,$J,358.3,8752,0)
 ;;=295.92^^63^490^15
 ;;^UTILITY(U,$J,358.3,8752,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8752,1,2,0)
 ;;=2^295.92
 ;;^UTILITY(U,$J,358.3,8752,1,5,0)
 ;;=5^Schizophrenia, NOS, Chronic
 ;;^UTILITY(U,$J,358.3,8752,2)
 ;;=Schizophrenia, NOS, Chronic^268093
 ;;^UTILITY(U,$J,358.3,8753,0)
 ;;=295.94^^63^490^16
 ;;^UTILITY(U,$J,358.3,8753,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8753,1,2,0)
 ;;=2^295.94
 ;;^UTILITY(U,$J,358.3,8753,1,5,0)
 ;;=5^Schizophrenia, NOS, Chronic w/Exacerbation
 ;;^UTILITY(U,$J,358.3,8753,2)
 ;;=^268095
 ;;^UTILITY(U,$J,358.3,8754,0)
 ;;=300.11^^63^491^1
 ;;^UTILITY(U,$J,358.3,8754,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8754,1,2,0)
 ;;=2^300.11
 ;;^UTILITY(U,$J,358.3,8754,1,5,0)
 ;;=5^Conversion Disorder
 ;;^UTILITY(U,$J,358.3,8754,2)
 ;;=^28139
 ;;^UTILITY(U,$J,358.3,8755,0)
 ;;=300.7^^63^491^2
 ;;^UTILITY(U,$J,358.3,8755,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8755,1,2,0)
 ;;=2^300.7
 ;;^UTILITY(U,$J,358.3,8755,1,5,0)
 ;;=5^Hyponchondriasis
 ;;^UTILITY(U,$J,358.3,8755,2)
 ;;=^60556
 ;;^UTILITY(U,$J,358.3,8756,0)
 ;;=300.81^^63^491^3
 ;;^UTILITY(U,$J,358.3,8756,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8756,1,2,0)
 ;;=2^300.81
 ;;^UTILITY(U,$J,358.3,8756,1,5,0)
 ;;=5^Somatization Disorder
 ;;^UTILITY(U,$J,358.3,8756,2)
 ;;=^112280
 ;;^UTILITY(U,$J,358.3,8757,0)
 ;;=307.1^^63^492^1
 ;;^UTILITY(U,$J,358.3,8757,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8757,1,2,0)
 ;;=2^307.1
