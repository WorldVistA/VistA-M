IBDEI00F ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,41,0)
 ;;=294.8^^1^5^6
 ;;^UTILITY(U,$J,358.3,41,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,41,1,2,0)
 ;;=2^294.8
 ;;^UTILITY(U,$J,358.3,41,1,5,0)
 ;;=5^Dementia Due to Brain Tumor
 ;;^UTILITY(U,$J,358.3,41,2)
 ;;=^31655^191.9
 ;;^UTILITY(U,$J,358.3,42,0)
 ;;=340.^^1^5^17
 ;;^UTILITY(U,$J,358.3,42,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,42,1,2,0)
 ;;=2^340.
 ;;^UTILITY(U,$J,358.3,42,1,5,0)
 ;;=5^MS Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,42,2)
 ;;=MS Dementia w/o Behav Disturb^79761^294.10
 ;;^UTILITY(U,$J,358.3,43,0)
 ;;=294.8^^1^5^8
 ;;^UTILITY(U,$J,358.3,43,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,43,1,2,0)
 ;;=2^294.8
 ;;^UTILITY(U,$J,358.3,43,1,5,0)
 ;;=5^Dementia NOS
 ;;^UTILITY(U,$J,358.3,43,2)
 ;;=^31655
 ;;^UTILITY(U,$J,358.3,44,0)
 ;;=331.82^^1^5^19
 ;;^UTILITY(U,$J,358.3,44,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,44,1,2,0)
 ;;=2^331.82
 ;;^UTILITY(U,$J,358.3,44,1,5,0)
 ;;=5^Parkins Demen w/Behav Dist
 ;;^UTILITY(U,$J,358.3,44,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,45,0)
 ;;=331.82^^1^5^20
 ;;^UTILITY(U,$J,358.3,45,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,45,1,2,0)
 ;;=2^331.82
 ;;^UTILITY(U,$J,358.3,45,1,5,0)
 ;;=5^Parkins w/oBehav Dist
 ;;^UTILITY(U,$J,358.3,45,2)
 ;;=^329888^294.10
 ;;^UTILITY(U,$J,358.3,46,0)
 ;;=042.^^1^5^14
 ;;^UTILITY(U,$J,358.3,46,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,46,1,2,0)
 ;;=2^042.
 ;;^UTILITY(U,$J,358.3,46,1,5,0)
 ;;=5^HIV Demen w/Behav Disturb
 ;;^UTILITY(U,$J,358.3,46,2)
 ;;=^266500^294.11
 ;;^UTILITY(U,$J,358.3,47,0)
 ;;=042.^^1^5^15
 ;;^UTILITY(U,$J,358.3,47,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,47,1,2,0)
 ;;=2^042.
 ;;^UTILITY(U,$J,358.3,47,1,5,0)
 ;;=5^HIV Demen w/oBehav Disturb
 ;;^UTILITY(U,$J,358.3,47,2)
 ;;=^266500^294.10
 ;;^UTILITY(U,$J,358.3,48,0)
 ;;=331.0^^1^5^4
 ;;^UTILITY(U,$J,358.3,48,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,48,1,2,0)
 ;;=2^331.0
 ;;^UTILITY(U,$J,358.3,48,1,5,0)
 ;;=5^Alzheimers w/Behav Disturb
 ;;^UTILITY(U,$J,358.3,48,2)
 ;;=Alzheimers w/Behav Disturb^5679^294.11
 ;;^UTILITY(U,$J,358.3,49,0)
 ;;=331.0^^1^5^5
 ;;^UTILITY(U,$J,358.3,49,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,49,1,2,0)
 ;;=2^331.0
 ;;^UTILITY(U,$J,358.3,49,1,5,0)
 ;;=5^Alzheimers w/oBehav Disturb
 ;;^UTILITY(U,$J,358.3,49,2)
 ;;=Alzheimers w/oBehav Disturb^5679^294.10
 ;;^UTILITY(U,$J,358.3,50,0)
 ;;=340.^^1^5^16
 ;;^UTILITY(U,$J,358.3,50,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,50,1,2,0)
 ;;=2^340.
 ;;^UTILITY(U,$J,358.3,50,1,5,0)
 ;;=5^MS Dementia w/Behav Disturb
 ;;^UTILITY(U,$J,358.3,50,2)
 ;;=MS Dementia w/Behav Disturb^79761^294.11
 ;;^UTILITY(U,$J,358.3,51,0)
 ;;=294.11^^1^5^10
 ;;^UTILITY(U,$J,358.3,51,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,51,1,2,0)
 ;;=2^294.11
 ;;^UTILITY(U,$J,358.3,51,1,5,0)
 ;;=5^Dementia w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,51,2)
 ;;=^321982
 ;;^UTILITY(U,$J,358.3,52,0)
 ;;=294.20^^1^5^13
 ;;^UTILITY(U,$J,358.3,52,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,52,1,2,0)
 ;;=2^294.20
 ;;^UTILITY(U,$J,358.3,52,1,5,0)
 ;;=5^Dementia w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,52,2)
 ;;=^340607
 ;;^UTILITY(U,$J,358.3,53,0)
 ;;=294.21^^1^5^9
 ;;^UTILITY(U,$J,358.3,53,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,53,1,2,0)
 ;;=2^294.21
 ;;^UTILITY(U,$J,358.3,53,1,5,0)
 ;;=5^Dementia w Behav Distur NOS
 ;;^UTILITY(U,$J,358.3,53,2)
 ;;=^340505
 ;;^UTILITY(U,$J,358.3,54,0)
 ;;=331.83^^1^5^18
 ;;^UTILITY(U,$J,358.3,54,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,54,1,2,0)
 ;;=2^331.83
 ;;^UTILITY(U,$J,358.3,54,1,5,0)
 ;;=5^Mild Cognitive Impairment
 ;;^UTILITY(U,$J,358.3,54,2)
 ;;=^334065
 ;;^UTILITY(U,$J,358.3,55,0)
 ;;=293.0^^1^6^1
 ;;^UTILITY(U,$J,358.3,55,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,55,1,2,0)
 ;;=2^293.0
 ;;^UTILITY(U,$J,358.3,55,1,5,0)
 ;;=5^Acute Delirium
 ;;^UTILITY(U,$J,358.3,55,2)
 ;;=Acute Delirium^268035
 ;;^UTILITY(U,$J,358.3,56,0)
 ;;=291.0^^1^6^3
 ;;^UTILITY(U,$J,358.3,56,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,56,1,2,0)
 ;;=2^291.0
 ;;^UTILITY(U,$J,358.3,56,1,5,0)
 ;;=5^Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,56,2)
 ;;=Withdrawal Delirium^4589
 ;;^UTILITY(U,$J,358.3,57,0)
 ;;=292.81^^1^6^2
 ;;^UTILITY(U,$J,358.3,57,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,57,1,2,0)
 ;;=2^292.81
 ;;^UTILITY(U,$J,358.3,57,1,5,0)
 ;;=5^Drug Induced Delirium
 ;;^UTILITY(U,$J,358.3,57,2)
 ;;=Drug Induced Delirium^268022
 ;;^UTILITY(U,$J,358.3,58,0)
 ;;=296.50^^1^7^7
 ;;^UTILITY(U,$J,358.3,58,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,58,1,2,0)
 ;;=2^296.50
 ;;^UTILITY(U,$J,358.3,58,1,5,0)
 ;;=5^Bipolar Depressed, Unspec
 ;;^UTILITY(U,$J,358.3,58,2)
 ;;=Bipolar Depressed, Unspec^268130
 ;;^UTILITY(U,$J,358.3,59,0)
 ;;=296.51^^1^7^4
 ;;^UTILITY(U,$J,358.3,59,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,59,1,2,0)
 ;;=2^296.51
 ;;^UTILITY(U,$J,358.3,59,1,5,0)
 ;;=5^Bipolar Depressed, Mild
 ;;^UTILITY(U,$J,358.3,59,2)
 ;;=Bipolar Depressed, Mild^303620
 ;;^UTILITY(U,$J,358.3,60,0)
 ;;=296.52^^1^7^5
 ;;^UTILITY(U,$J,358.3,60,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,60,1,2,0)
 ;;=2^296.52
 ;;^UTILITY(U,$J,358.3,60,1,5,0)
 ;;=5^Bipolar Depressed, Moderate
 ;;^UTILITY(U,$J,358.3,60,2)
 ;;=Bipolar Depressed, Moderate^303621
 ;;^UTILITY(U,$J,358.3,61,0)
 ;;=296.53^^1^7^2
 ;;^UTILITY(U,$J,358.3,61,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,61,1,2,0)
 ;;=2^296.53
 ;;^UTILITY(U,$J,358.3,61,1,5,0)
 ;;=5^Bipolar Depress Severe w/o Psychosis
 ;;^UTILITY(U,$J,358.3,61,2)
 ;;=^303622
 ;;^UTILITY(U,$J,358.3,62,0)
 ;;=296.54^^1^7^1
 ;;^UTILITY(U,$J,358.3,62,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,62,1,2,0)
 ;;=2^296.54
 ;;^UTILITY(U,$J,358.3,62,1,5,0)
 ;;=5^Bipolar Depress Severe w/Psychosis
 ;;^UTILITY(U,$J,358.3,62,2)
 ;;=^303623
 ;;^UTILITY(U,$J,358.3,63,0)
 ;;=296.55^^1^7^6
 ;;^UTILITY(U,$J,358.3,63,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,63,1,2,0)
 ;;=2^296.55
 ;;^UTILITY(U,$J,358.3,63,1,5,0)
 ;;=5^Bipolar Depressed, Partial Remiss
 ;;^UTILITY(U,$J,358.3,63,2)
 ;;=Bipolar Depressed, Partial Remiss^303624
 ;;^UTILITY(U,$J,358.3,64,0)
 ;;=296.56^^1^7^3
 ;;^UTILITY(U,$J,358.3,64,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,64,1,2,0)
 ;;=2^296.56
 ;;^UTILITY(U,$J,358.3,64,1,5,0)
 ;;=5^Bipolar Depressed, Full Remission
 ;;^UTILITY(U,$J,358.3,64,2)
 ;;=^303625
 ;;^UTILITY(U,$J,358.3,65,0)
 ;;=296.40^^1^7^14
 ;;^UTILITY(U,$J,358.3,65,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,65,1,2,0)
 ;;=2^296.40
 ;;^UTILITY(U,$J,358.3,65,1,5,0)
 ;;=5^Bipolar Manic, Unspec
 ;;^UTILITY(U,$J,358.3,65,2)
 ;;=Bipolar Manic, Unspec^303607
 ;;^UTILITY(U,$J,358.3,66,0)
 ;;=296.41^^1^7^9
 ;;^UTILITY(U,$J,358.3,66,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,66,1,2,0)
 ;;=2^296.41
 ;;^UTILITY(U,$J,358.3,66,1,5,0)
 ;;=5^Bipolar Manic, Mild
 ;;^UTILITY(U,$J,358.3,66,2)
 ;;=Bipolar Manic, Mild^303608
 ;;^UTILITY(U,$J,358.3,67,0)
 ;;=296.42^^1^7^10
 ;;^UTILITY(U,$J,358.3,67,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,67,1,2,0)
 ;;=2^296.42
 ;;^UTILITY(U,$J,358.3,67,1,5,0)
 ;;=5^Bipolar Manic, Mod
 ;;^UTILITY(U,$J,358.3,67,2)
 ;;=Bipolar Manic, Mod^303609
 ;;^UTILITY(U,$J,358.3,68,0)
 ;;=296.43^^1^7^13
 ;;^UTILITY(U,$J,358.3,68,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,68,1,2,0)
 ;;=2^296.43
 ;;^UTILITY(U,$J,358.3,68,1,5,0)
 ;;=5^Bipolar Manic, Severe w/o Psychosis
 ;;^UTILITY(U,$J,358.3,68,2)
 ;;=^303610
 ;;^UTILITY(U,$J,358.3,69,0)
 ;;=296.44^^1^7^12
 ;;^UTILITY(U,$J,358.3,69,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,69,1,2,0)
 ;;=2^296.44
 ;;^UTILITY(U,$J,358.3,69,1,5,0)
 ;;=5^Bipolar Manic, Severe w/Psychosis
 ;;^UTILITY(U,$J,358.3,69,2)
 ;;=^303611
 ;;^UTILITY(U,$J,358.3,70,0)
 ;;=296.45^^1^7^11
 ;;^UTILITY(U,$J,358.3,70,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,70,1,2,0)
 ;;=2^296.45
 ;;^UTILITY(U,$J,358.3,70,1,5,0)
 ;;=5^Bipolar Manic, Partial Remiss
 ;;^UTILITY(U,$J,358.3,70,2)
 ;;=Bipolar Manic, Partial Remiss^303612
 ;;^UTILITY(U,$J,358.3,71,0)
 ;;=296.46^^1^7^8
 ;;^UTILITY(U,$J,358.3,71,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,71,1,2,0)
 ;;=2^296.46
 ;;^UTILITY(U,$J,358.3,71,1,5,0)
 ;;=5^Bipolar Manic, Full Remission
 ;;^UTILITY(U,$J,358.3,71,2)
 ;;=^303618
 ;;^UTILITY(U,$J,358.3,72,0)
 ;;=296.60^^1^7^21
 ;;^UTILITY(U,$J,358.3,72,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,72,1,2,0)
 ;;=2^296.60
 ;;^UTILITY(U,$J,358.3,72,1,5,0)
 ;;=5^Bipolar Mixed, Unspec
 ;;^UTILITY(U,$J,358.3,72,2)
 ;;=Bipolar Mixed, Unspec^303626
 ;;^UTILITY(U,$J,358.3,73,0)
 ;;=296.61^^1^7^16
 ;;^UTILITY(U,$J,358.3,73,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,73,1,2,0)
 ;;=2^296.61
 ;;^UTILITY(U,$J,358.3,73,1,5,0)
 ;;=5^Bipolar Mixed, Mild
 ;;^UTILITY(U,$J,358.3,73,2)
 ;;=Bipolar Mixed, Mild^303627
 ;;^UTILITY(U,$J,358.3,74,0)
 ;;=296.62^^1^7^17
 ;;^UTILITY(U,$J,358.3,74,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,74,1,2,0)
 ;;=2^296.62
 ;;^UTILITY(U,$J,358.3,74,1,5,0)
 ;;=5^Bipolar Mixed, Moderate
 ;;^UTILITY(U,$J,358.3,74,2)
 ;;=^303628
 ;;^UTILITY(U,$J,358.3,75,0)
 ;;=296.63^^1^7^20
 ;;^UTILITY(U,$J,358.3,75,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,75,1,2,0)
 ;;=2^296.63
 ;;^UTILITY(U,$J,358.3,75,1,5,0)
 ;;=5^Bipolar Mixed, Severe w/o Psychosis
 ;;^UTILITY(U,$J,358.3,75,2)
 ;;=^303629
 ;;^UTILITY(U,$J,358.3,76,0)
 ;;=296.64^^1^7^19
 ;;^UTILITY(U,$J,358.3,76,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,76,1,2,0)
 ;;=2^296.64
 ;;^UTILITY(U,$J,358.3,76,1,5,0)
 ;;=5^Bipolar Mixed, Severe W/Psychosis
 ;;^UTILITY(U,$J,358.3,76,2)
 ;;=^303630
 ;;^UTILITY(U,$J,358.3,77,0)
 ;;=296.65^^1^7^18
 ;;^UTILITY(U,$J,358.3,77,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,77,1,2,0)
 ;;=2^296.65
 ;;^UTILITY(U,$J,358.3,77,1,5,0)
 ;;=5^Bipolar Mixed, Part Remission
 ;;^UTILITY(U,$J,358.3,77,2)
 ;;=Bipolar Mixed, Part Remission^303631
 ;;^UTILITY(U,$J,358.3,78,0)
 ;;=296.66^^1^7^15
 ;;^UTILITY(U,$J,358.3,78,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,78,1,2,0)
 ;;=2^296.66
