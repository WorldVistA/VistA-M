IBDEI2C6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,39242,0)
 ;;=S24.109S^^183^2014^17
 ;;^UTILITY(U,$J,358.3,39242,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39242,1,3,0)
 ;;=3^Injury to unsp level of thoracic spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,39242,1,4,0)
 ;;=4^S24.109S
 ;;^UTILITY(U,$J,358.3,39242,2)
 ;;=^5134384
 ;;^UTILITY(U,$J,358.3,39243,0)
 ;;=S34.139S^^183^2014^14
 ;;^UTILITY(U,$J,358.3,39243,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39243,1,3,0)
 ;;=3^Injury to sacral spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,39243,1,4,0)
 ;;=4^S34.139S
 ;;^UTILITY(U,$J,358.3,39243,2)
 ;;=^5025249
 ;;^UTILITY(U,$J,358.3,39244,0)
 ;;=S34.109S^^183^2014^16
 ;;^UTILITY(U,$J,358.3,39244,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39244,1,3,0)
 ;;=3^Injury to unsp level of lumbar spinal cord, sequela
 ;;^UTILITY(U,$J,358.3,39244,1,4,0)
 ;;=4^S34.109S
 ;;^UTILITY(U,$J,358.3,39244,2)
 ;;=^5134570
 ;;^UTILITY(U,$J,358.3,39245,0)
 ;;=S06.9X9S^^183^2014^19
 ;;^UTILITY(U,$J,358.3,39245,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39245,1,3,0)
 ;;=3^Intracranial injury w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,39245,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,39245,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,39246,0)
 ;;=S15.002A^^183^2014^5
 ;;^UTILITY(U,$J,358.3,39246,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39246,1,3,0)
 ;;=3^Injury of left carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,39246,1,4,0)
 ;;=4^S15.002A
 ;;^UTILITY(U,$J,358.3,39246,2)
 ;;=^5022223
 ;;^UTILITY(U,$J,358.3,39247,0)
 ;;=S15.001A^^183^2014^10
 ;;^UTILITY(U,$J,358.3,39247,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39247,1,3,0)
 ;;=3^Injury of right carotid artery, init encntr
 ;;^UTILITY(U,$J,358.3,39247,1,4,0)
 ;;=4^S15.001A
 ;;^UTILITY(U,$J,358.3,39247,2)
 ;;=^5022220
 ;;^UTILITY(U,$J,358.3,39248,0)
 ;;=I69.91^^183^2015^2
 ;;^UTILITY(U,$J,358.3,39248,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39248,1,3,0)
 ;;=3^Cognitive deficits following unsp cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,39248,1,4,0)
 ;;=4^I69.91
 ;;^UTILITY(U,$J,358.3,39248,2)
 ;;=^5007552
 ;;^UTILITY(U,$J,358.3,39249,0)
 ;;=I69.952^^183^2015^3
 ;;^UTILITY(U,$J,358.3,39249,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39249,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff left dominant side
 ;;^UTILITY(U,$J,358.3,39249,1,4,0)
 ;;=4^I69.952
 ;;^UTILITY(U,$J,358.3,39249,2)
 ;;=^5133586
 ;;^UTILITY(U,$J,358.3,39250,0)
 ;;=I69.954^^183^2015^4
 ;;^UTILITY(U,$J,358.3,39250,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39250,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff left nondom side
 ;;^UTILITY(U,$J,358.3,39250,1,4,0)
 ;;=4^I69.954
 ;;^UTILITY(U,$J,358.3,39250,2)
 ;;=^5133587
 ;;^UTILITY(U,$J,358.3,39251,0)
 ;;=I69.951^^183^2015^5
 ;;^UTILITY(U,$J,358.3,39251,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39251,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff right dominant side
 ;;^UTILITY(U,$J,358.3,39251,1,4,0)
 ;;=4^I69.951
 ;;^UTILITY(U,$J,358.3,39251,2)
 ;;=^5007561
 ;;^UTILITY(U,$J,358.3,39252,0)
 ;;=I69.953^^183^2015^6
 ;;^UTILITY(U,$J,358.3,39252,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39252,1,3,0)
 ;;=3^Hemiplga fol unsp cerebvasc disease aff right nondom side
 ;;^UTILITY(U,$J,358.3,39252,1,4,0)
 ;;=4^I69.953
 ;;^UTILITY(U,$J,358.3,39252,2)
 ;;=^5007562
 ;;^UTILITY(U,$J,358.3,39253,0)
 ;;=I69.942^^183^2015^7
 ;;^UTILITY(U,$J,358.3,39253,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,39253,1,3,0)
 ;;=3^Monoplg low lmb fol unsp cerebvasc dis aff left dom side
 ;;^UTILITY(U,$J,358.3,39253,1,4,0)
 ;;=4^I69.942
 ;;^UTILITY(U,$J,358.3,39253,2)
 ;;=^5133582
