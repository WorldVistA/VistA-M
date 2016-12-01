IBDEI00N ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,274,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,274,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,275,0)
 ;;=S06.2X9S^^3^26^74
 ;;^UTILITY(U,$J,358.3,275,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,275,1,3,0)
 ;;=3^TRAUMATIC BRAIN INJURY,Diffuse w/ Unspec Duration of LOC,Sequela
 ;;^UTILITY(U,$J,358.3,275,1,4,0)
 ;;=4^S06.2X9S
 ;;^UTILITY(U,$J,358.3,275,2)
 ;;=^5020755
 ;;^UTILITY(U,$J,358.3,276,0)
 ;;=F02.81^^3^26^50
 ;;^UTILITY(U,$J,358.3,276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,276,1,3,0)
 ;;=3^Major Neurocog D/O d/t TBI w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,276,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,276,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,277,0)
 ;;=F02.80^^3^26^51
 ;;^UTILITY(U,$J,358.3,277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,277,1,3,0)
 ;;=3^Major Neurocog D/O d/t TBI w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,277,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,277,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,278,0)
 ;;=G31.84^^3^26^64
 ;;^UTILITY(U,$J,358.3,278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,278,1,3,0)
 ;;=3^Mild Neurocog D/O d/t TBI
 ;;^UTILITY(U,$J,358.3,278,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,278,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,279,0)
 ;;=F01.51^^3^26^48
 ;;^UTILITY(U,$J,358.3,279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,279,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/ Behav Disturb
 ;;^UTILITY(U,$J,358.3,279,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,279,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,280,0)
 ;;=F01.50^^3^26^49
 ;;^UTILITY(U,$J,358.3,280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,280,1,3,0)
 ;;=3^Major Neurocog D/O d/t Prob VASCULAR DISEASE w/o Behav Disturb
 ;;^UTILITY(U,$J,358.3,280,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,280,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,281,0)
 ;;=G31.84^^3^26^65
 ;;^UTILITY(U,$J,358.3,281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,281,1,3,0)
 ;;=3^Mild Neurocog D/O d/t VASCULAR DISEASE
 ;;^UTILITY(U,$J,358.3,281,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,281,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,282,0)
 ;;=R41.9^^3^26^68
 ;;^UTILITY(U,$J,358.3,282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,282,1,3,0)
 ;;=3^Neurocognitive Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,282,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,282,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,283,0)
 ;;=F06.31^^3^27^1
 ;;^UTILITY(U,$J,358.3,283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,283,1,3,0)
 ;;=3^Depressive Disorder d/t Another Med Cond w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,283,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,283,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,284,0)
 ;;=F06.32^^3^27^2
 ;;^UTILITY(U,$J,358.3,284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,284,1,3,0)
 ;;=3^Depressive Disorder d/t Another Med Cond w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,284,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,284,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,285,0)
 ;;=F32.9^^3^27^20
 ;;^UTILITY(U,$J,358.3,285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,285,1,3,0)
 ;;=3^MDD,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,285,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,285,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,286,0)
 ;;=F32.0^^3^27^17
 ;;^UTILITY(U,$J,358.3,286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,286,1,3,0)
 ;;=3^MDD,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,286,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,286,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,287,0)
 ;;=F32.1^^3^27^18
 ;;^UTILITY(U,$J,358.3,287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,287,1,3,0)
 ;;=3^MDD,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,287,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,287,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,288,0)
 ;;=F32.2^^3^27^19
 ;;^UTILITY(U,$J,358.3,288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,288,1,3,0)
 ;;=3^MDD,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,288,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,288,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,289,0)
 ;;=F32.3^^3^27^14
 ;;^UTILITY(U,$J,358.3,289,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,289,1,3,0)
 ;;=3^MDD,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,289,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,289,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,290,0)
 ;;=F32.4^^3^27^16
 ;;^UTILITY(U,$J,358.3,290,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,290,1,3,0)
 ;;=3^MDD,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,290,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,290,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,291,0)
 ;;=F32.5^^3^27^15
 ;;^UTILITY(U,$J,358.3,291,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,291,1,3,0)
 ;;=3^MDD,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,291,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,291,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,292,0)
 ;;=F33.9^^3^27^13
 ;;^UTILITY(U,$J,358.3,292,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,292,1,3,0)
 ;;=3^MDD,Recurrent Episode,Unspec
 ;;^UTILITY(U,$J,358.3,292,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,292,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,293,0)
 ;;=F33.0^^3^27^10
 ;;^UTILITY(U,$J,358.3,293,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,293,1,3,0)
 ;;=3^MDD,Recurrent Episode,Mild
 ;;^UTILITY(U,$J,358.3,293,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,293,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,294,0)
 ;;=F33.1^^3^27^11
 ;;^UTILITY(U,$J,358.3,294,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,294,1,3,0)
 ;;=3^MDD,Recurrent Episode,Moderate
 ;;^UTILITY(U,$J,358.3,294,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,294,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,295,0)
 ;;=F33.2^^3^27^12
 ;;^UTILITY(U,$J,358.3,295,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,295,1,3,0)
 ;;=3^MDD,Recurrent Episode,Severe
 ;;^UTILITY(U,$J,358.3,295,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,295,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,296,0)
 ;;=F33.3^^3^27^7
 ;;^UTILITY(U,$J,358.3,296,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,296,1,3,0)
 ;;=3^MDD,Recurrent Episode w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,296,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,296,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,297,0)
 ;;=F33.41^^3^27^9
 ;;^UTILITY(U,$J,358.3,297,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,297,1,3,0)
 ;;=3^MDD,Recurrent Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,297,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,297,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,298,0)
 ;;=F33.42^^3^27^8
 ;;^UTILITY(U,$J,358.3,298,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,298,1,3,0)
 ;;=3^MDD,Recurrent Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,298,1,4,0)
 ;;=4^F33.42
 ;;^UTILITY(U,$J,358.3,298,2)
 ;;=^5003535
 ;;^UTILITY(U,$J,358.3,299,0)
 ;;=F34.8^^3^27^6
 ;;^UTILITY(U,$J,358.3,299,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,299,1,3,0)
 ;;=3^Disruptive Mood Dysregulation Disorder
 ;;^UTILITY(U,$J,358.3,299,1,4,0)
 ;;=4^F34.8
 ;;^UTILITY(U,$J,358.3,299,2)
 ;;=^5003539
 ;;^UTILITY(U,$J,358.3,300,0)
 ;;=F34.1^^3^27^21
 ;;^UTILITY(U,$J,358.3,300,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,300,1,3,0)
 ;;=3^Persistent Depressive Disorder (Dysthmia)
 ;;^UTILITY(U,$J,358.3,300,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,300,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,301,0)
 ;;=N94.3^^3^27^22
 ;;^UTILITY(U,$J,358.3,301,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,301,1,3,0)
 ;;=3^Premenstrual Dysphoric Disorder
 ;;^UTILITY(U,$J,358.3,301,1,4,0)
 ;;=4^N94.3
 ;;^UTILITY(U,$J,358.3,301,2)
 ;;=^5015919
 ;;^UTILITY(U,$J,358.3,302,0)
 ;;=F06.34^^3^27^3
 ;;^UTILITY(U,$J,358.3,302,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,302,1,3,0)
 ;;=3^Depressive Disorder d/t Another Med Cond w/ Mixed Features,Unsp
 ;;^UTILITY(U,$J,358.3,302,1,4,0)
 ;;=4^F06.34
 ;;^UTILITY(U,$J,358.3,302,2)
 ;;=^5003060
 ;;^UTILITY(U,$J,358.3,303,0)
 ;;=F32.8^^3^27^4
 ;;^UTILITY(U,$J,358.3,303,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,303,1,3,0)
 ;;=3^Depressive Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,303,1,4,0)
 ;;=4^F32.8
 ;;^UTILITY(U,$J,358.3,303,2)
 ;;=^5003527
 ;;^UTILITY(U,$J,358.3,304,0)
 ;;=F32.9^^3^27^5
 ;;^UTILITY(U,$J,358.3,304,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,304,1,3,0)
 ;;=3^Depressive Disorder,Unsp
 ;;^UTILITY(U,$J,358.3,304,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,304,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,305,0)
 ;;=F44.81^^3^28^6
 ;;^UTILITY(U,$J,358.3,305,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,305,1,3,0)
 ;;=3^Dissociative Identity Disorder
 ;;^UTILITY(U,$J,358.3,305,1,4,0)
 ;;=4^F44.81
 ;;^UTILITY(U,$J,358.3,305,2)
 ;;=^331909
 ;;^UTILITY(U,$J,358.3,306,0)
 ;;=F44.9^^3^28^5
 ;;^UTILITY(U,$J,358.3,306,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,306,1,3,0)
 ;;=3^Dissociative Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,306,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,306,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,307,0)
 ;;=F44.0^^3^28^2
 ;;^UTILITY(U,$J,358.3,307,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,307,1,3,0)
 ;;=3^Dissociative Amnesia
 ;;^UTILITY(U,$J,358.3,307,1,4,0)
 ;;=4^F44.0
 ;;^UTILITY(U,$J,358.3,307,2)
 ;;=^5003577
 ;;^UTILITY(U,$J,358.3,308,0)
 ;;=F48.1^^3^28^1
 ;;^UTILITY(U,$J,358.3,308,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,308,1,3,0)
 ;;=3^Depersonalization/Derealization Disorder
 ;;^UTILITY(U,$J,358.3,308,1,4,0)
 ;;=4^F48.1
 ;;^UTILITY(U,$J,358.3,308,2)
 ;;=^5003593
 ;;^UTILITY(U,$J,358.3,309,0)
 ;;=F44.89^^3^28^4
 ;;^UTILITY(U,$J,358.3,309,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,309,1,3,0)
 ;;=3^Dissociative Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,309,1,4,0)
 ;;=4^F44.89
 ;;^UTILITY(U,$J,358.3,309,2)
 ;;=^5003583
 ;;^UTILITY(U,$J,358.3,310,0)
 ;;=F44.1^^3^28^3
 ;;^UTILITY(U,$J,358.3,310,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,310,1,3,0)
 ;;=3^Dissociative Amnesia w/ Dissociative Fugue
 ;;^UTILITY(U,$J,358.3,310,1,4,0)
 ;;=4^F44.1
 ;;^UTILITY(U,$J,358.3,310,2)
 ;;=^331908
 ;;^UTILITY(U,$J,358.3,311,0)
 ;;=F50.02^^3^29^1
 ;;^UTILITY(U,$J,358.3,311,1,0)
 ;;=^358.31IA^4^2
