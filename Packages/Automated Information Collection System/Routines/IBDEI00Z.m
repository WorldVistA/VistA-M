IBDEI00Z ; ; 09-FEB-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,955,1,3,0)
 ;;=3^Other Spec Degenerative Diseases of Nervous System
 ;;^UTILITY(U,$J,358.3,955,1,4,0)
 ;;=4^G31.89
 ;;^UTILITY(U,$J,358.3,955,2)
 ;;=^5003814
 ;;^UTILITY(U,$J,358.3,956,0)
 ;;=G31.9^^3^25^5
 ;;^UTILITY(U,$J,358.3,956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,956,1,3,0)
 ;;=3^Degenerative Diseases of Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,956,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,956,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,957,0)
 ;;=G23.8^^3^25^16
 ;;^UTILITY(U,$J,358.3,957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,957,1,3,0)
 ;;=3^Other Spec Degenerative Diseases of Basal Ganglia
 ;;^UTILITY(U,$J,358.3,957,1,4,0)
 ;;=4^G23.8
 ;;^UTILITY(U,$J,358.3,957,2)
 ;;=^5003782
 ;;^UTILITY(U,$J,358.3,958,0)
 ;;=G10.^^3^25^13
 ;;^UTILITY(U,$J,358.3,958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,958,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Huntington's Disease w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,958,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,958,2)
 ;;=^5003751^F02.81
 ;;^UTILITY(U,$J,358.3,959,0)
 ;;=G10.^^3^25^14
 ;;^UTILITY(U,$J,358.3,959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,959,1,3,0)
 ;;=3^Major Neurocognitive Disorder d/t Huntington's Disease w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,959,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,959,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,960,0)
 ;;=G31.09^^3^25^10
 ;;^UTILITY(U,$J,358.3,960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,960,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/ Behavioral Disturbance
 ;;^UTILITY(U,$J,358.3,960,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,960,2)
 ;;=^329916^F02.81
 ;;^UTILITY(U,$J,358.3,961,0)
 ;;=G31.09^^3^25^11
 ;;^UTILITY(U,$J,358.3,961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,961,1,3,0)
 ;;=3^Major Frontotemporal Neurocognitive Disorder w/o Behavorial Disturbance
 ;;^UTILITY(U,$J,358.3,961,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,961,2)
 ;;=^329916^F02.80
 ;;^UTILITY(U,$J,358.3,962,0)
 ;;=F06.30^^3^26^1
 ;;^UTILITY(U,$J,358.3,962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,962,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition,Unspec
 ;;^UTILITY(U,$J,358.3,962,1,4,0)
 ;;=4^F06.30
 ;;^UTILITY(U,$J,358.3,962,2)
 ;;=^5003056
 ;;^UTILITY(U,$J,358.3,963,0)
 ;;=F06.31^^3^26^2
 ;;^UTILITY(U,$J,358.3,963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,963,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Depressive Features
 ;;^UTILITY(U,$J,358.3,963,1,4,0)
 ;;=4^F06.31
 ;;^UTILITY(U,$J,358.3,963,2)
 ;;=^5003057
 ;;^UTILITY(U,$J,358.3,964,0)
 ;;=F06.32^^3^26^3
 ;;^UTILITY(U,$J,358.3,964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,964,1,3,0)
 ;;=3^Depressive Disorder d/t Another Medical Condition w/ Major Depressive-Like Episode
 ;;^UTILITY(U,$J,358.3,964,1,4,0)
 ;;=4^F06.32
 ;;^UTILITY(U,$J,358.3,964,2)
 ;;=^5003058
 ;;^UTILITY(U,$J,358.3,965,0)
 ;;=F32.9^^3^26^12
 ;;^UTILITY(U,$J,358.3,965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,965,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Unspec
 ;;^UTILITY(U,$J,358.3,965,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,965,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,966,0)
 ;;=F32.0^^3^26^13
 ;;^UTILITY(U,$J,358.3,966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,966,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Mild
 ;;^UTILITY(U,$J,358.3,966,1,4,0)
 ;;=4^F32.0
 ;;^UTILITY(U,$J,358.3,966,2)
 ;;=^5003521
 ;;^UTILITY(U,$J,358.3,967,0)
 ;;=F32.1^^3^26^14
 ;;^UTILITY(U,$J,358.3,967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,967,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Moderate
 ;;^UTILITY(U,$J,358.3,967,1,4,0)
 ;;=4^F32.1
 ;;^UTILITY(U,$J,358.3,967,2)
 ;;=^5003522
 ;;^UTILITY(U,$J,358.3,968,0)
 ;;=F32.2^^3^26^15
 ;;^UTILITY(U,$J,358.3,968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,968,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,Severe
 ;;^UTILITY(U,$J,358.3,968,1,4,0)
 ;;=4^F32.2
 ;;^UTILITY(U,$J,358.3,968,2)
 ;;=^5003523
 ;;^UTILITY(U,$J,358.3,969,0)
 ;;=F32.3^^3^26^16
 ;;^UTILITY(U,$J,358.3,969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,969,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode w Psychotic Features
 ;;^UTILITY(U,$J,358.3,969,1,4,0)
 ;;=4^F32.3
 ;;^UTILITY(U,$J,358.3,969,2)
 ;;=^5003524
 ;;^UTILITY(U,$J,358.3,970,0)
 ;;=F32.4^^3^26^17
 ;;^UTILITY(U,$J,358.3,970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,970,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Partial Remission
 ;;^UTILITY(U,$J,358.3,970,1,4,0)
 ;;=4^F32.4
 ;;^UTILITY(U,$J,358.3,970,2)
 ;;=^5003525
 ;;^UTILITY(U,$J,358.3,971,0)
 ;;=F32.5^^3^26^18
 ;;^UTILITY(U,$J,358.3,971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,971,1,3,0)
 ;;=3^Major Depressive Disorder,Single Episode,In Full Remission
 ;;^UTILITY(U,$J,358.3,971,1,4,0)
 ;;=4^F32.5
 ;;^UTILITY(U,$J,358.3,971,2)
 ;;=^5003526
 ;;^UTILITY(U,$J,358.3,972,0)
 ;;=F33.9^^3^26^11
 ;;^UTILITY(U,$J,358.3,972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,972,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Unspec
 ;;^UTILITY(U,$J,358.3,972,1,4,0)
 ;;=4^F33.9
 ;;^UTILITY(U,$J,358.3,972,2)
 ;;=^5003537
 ;;^UTILITY(U,$J,358.3,973,0)
 ;;=F33.0^^3^26^8
 ;;^UTILITY(U,$J,358.3,973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,973,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Mild
 ;;^UTILITY(U,$J,358.3,973,1,4,0)
 ;;=4^F33.0
 ;;^UTILITY(U,$J,358.3,973,2)
 ;;=^5003529
 ;;^UTILITY(U,$J,358.3,974,0)
 ;;=F33.1^^3^26^9
 ;;^UTILITY(U,$J,358.3,974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,974,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Moderate
 ;;^UTILITY(U,$J,358.3,974,1,4,0)
 ;;=4^F33.1
 ;;^UTILITY(U,$J,358.3,974,2)
 ;;=^5003530
 ;;^UTILITY(U,$J,358.3,975,0)
 ;;=F33.2^^3^26^10
 ;;^UTILITY(U,$J,358.3,975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,975,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,Severe
 ;;^UTILITY(U,$J,358.3,975,1,4,0)
 ;;=4^F33.2
 ;;^UTILITY(U,$J,358.3,975,2)
 ;;=^5003531
 ;;^UTILITY(U,$J,358.3,976,0)
 ;;=F33.3^^3^26^5
 ;;^UTILITY(U,$J,358.3,976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,976,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent w/ Psychotic Features
 ;;^UTILITY(U,$J,358.3,976,1,4,0)
 ;;=4^F33.3
 ;;^UTILITY(U,$J,358.3,976,2)
 ;;=^5003532
 ;;^UTILITY(U,$J,358.3,977,0)
 ;;=F33.41^^3^26^6
 ;;^UTILITY(U,$J,358.3,977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,977,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Partial Remission
 ;;^UTILITY(U,$J,358.3,977,1,4,0)
 ;;=4^F33.41
 ;;^UTILITY(U,$J,358.3,977,2)
 ;;=^5003534
 ;;^UTILITY(U,$J,358.3,978,0)
 ;;=F33.42^^3^26^7
 ;;^UTILITY(U,$J,358.3,978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,978,1,3,0)
 ;;=3^Major Depressive Disorder,Recurrent,In Full Remission
 ;;^UTILITY(U,$J,358.3,978,1,4,0)
 ;;=4^F33.42
 ;;^UTILITY(U,$J,358.3,978,2)
 ;;=^5003535
 ;;^UTILITY(U,$J,358.3,979,0)
 ;;=F34.8^^3^26^4
 ;;^UTILITY(U,$J,358.3,979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,979,1,3,0)
 ;;=3^Disruptive Mood Dysregulation Disorder
 ;;^UTILITY(U,$J,358.3,979,1,4,0)
 ;;=4^F34.8
 ;;^UTILITY(U,$J,358.3,979,2)
 ;;=^5003539
 ;;^UTILITY(U,$J,358.3,980,0)
 ;;=F32.8^^3^26^19
 ;;^UTILITY(U,$J,358.3,980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,980,1,3,0)
 ;;=3^Other Spec Depressive Disorder
 ;;^UTILITY(U,$J,358.3,980,1,4,0)
 ;;=4^F32.8
 ;;^UTILITY(U,$J,358.3,980,2)
 ;;=^5003527
 ;;^UTILITY(U,$J,358.3,981,0)
 ;;=F34.1^^3^26^20
 ;;^UTILITY(U,$J,358.3,981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,981,1,3,0)
 ;;=3^Persistent Depressive Disorder (Dysthymic)
 ;;^UTILITY(U,$J,358.3,981,1,4,0)
 ;;=4^F34.1
 ;;^UTILITY(U,$J,358.3,981,2)
 ;;=^331913
 ;;^UTILITY(U,$J,358.3,982,0)
 ;;=F32.9^^3^26^22
 ;;^UTILITY(U,$J,358.3,982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,982,1,3,0)
 ;;=3^Unspec Depressive Disorder
 ;;^UTILITY(U,$J,358.3,982,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,982,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,983,0)
 ;;=N94.3^^3^26^21
 ;;^UTILITY(U,$J,358.3,983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,983,1,3,0)
 ;;=3^Premenstrual Dysphoric Disorder
 ;;^UTILITY(U,$J,358.3,983,1,4,0)
 ;;=4^N94.3
 ;;^UTILITY(U,$J,358.3,983,2)
 ;;=^5015919
 ;;^UTILITY(U,$J,358.3,984,0)
 ;;=F44.81^^3^27^3
 ;;^UTILITY(U,$J,358.3,984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,984,1,3,0)
 ;;=3^Dissociative Identity Disorder
 ;;^UTILITY(U,$J,358.3,984,1,4,0)
 ;;=4^F44.81
 ;;^UTILITY(U,$J,358.3,984,2)
 ;;=^331909
 ;;^UTILITY(U,$J,358.3,985,0)
 ;;=F44.9^^3^27^5
 ;;^UTILITY(U,$J,358.3,985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,985,1,3,0)
 ;;=3^Unspec Dissociative Disorder
 ;;^UTILITY(U,$J,358.3,985,1,4,0)
 ;;=4^F44.9
 ;;^UTILITY(U,$J,358.3,985,2)
 ;;=^5003584
 ;;^UTILITY(U,$J,358.3,986,0)
 ;;=F44.0^^3^27^2
 ;;^UTILITY(U,$J,358.3,986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,986,1,3,0)
 ;;=3^Dissociative Amnesia
 ;;^UTILITY(U,$J,358.3,986,1,4,0)
 ;;=4^F44.0
 ;;^UTILITY(U,$J,358.3,986,2)
 ;;=^5003577
 ;;^UTILITY(U,$J,358.3,987,0)
 ;;=F48.1^^3^27^1
 ;;^UTILITY(U,$J,358.3,987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,987,1,3,0)
 ;;=3^Depersonalization/Derealization Disorder
 ;;^UTILITY(U,$J,358.3,987,1,4,0)
 ;;=4^F48.1
 ;;^UTILITY(U,$J,358.3,987,2)
 ;;=^5003593
 ;;^UTILITY(U,$J,358.3,988,0)
 ;;=F44.89^^3^27^4
 ;;^UTILITY(U,$J,358.3,988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,988,1,3,0)
 ;;=3^Other Spec Dissociative Disorder
 ;;^UTILITY(U,$J,358.3,988,1,4,0)
 ;;=4^F44.89
 ;;^UTILITY(U,$J,358.3,988,2)
 ;;=^5003583
 ;;^UTILITY(U,$J,358.3,989,0)
 ;;=F50.02^^3^28^1
 ;;^UTILITY(U,$J,358.3,989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,989,1,3,0)
 ;;=3^Anorexia Nervosa,Binge-Eating/Purging Type
 ;;^UTILITY(U,$J,358.3,989,1,4,0)
 ;;=4^F50.02
 ;;^UTILITY(U,$J,358.3,989,2)
 ;;=^5003599
 ;;^UTILITY(U,$J,358.3,990,0)
 ;;=F50.01^^3^28^2
 ;;^UTILITY(U,$J,358.3,990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,990,1,3,0)
 ;;=3^Anorexia Nervosa,Restricting Type
