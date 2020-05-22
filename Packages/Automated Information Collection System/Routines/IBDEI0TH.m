IBDEI0TH ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13124,0)
 ;;=R41.843^^83^806^12
 ;;^UTILITY(U,$J,358.3,13124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13124,1,3,0)
 ;;=3^Cognitive Decline,Psychomotor Deficit
 ;;^UTILITY(U,$J,358.3,13124,1,4,0)
 ;;=4^R41.843
 ;;^UTILITY(U,$J,358.3,13124,2)
 ;;=^5019446
 ;;^UTILITY(U,$J,358.3,13125,0)
 ;;=R41.9^^83^806^13
 ;;^UTILITY(U,$J,358.3,13125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13125,1,3,0)
 ;;=3^Cognitive Decline,Unspec
 ;;^UTILITY(U,$J,358.3,13125,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,13125,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,13126,0)
 ;;=R41.842^^83^806^14
 ;;^UTILITY(U,$J,358.3,13126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13126,1,3,0)
 ;;=3^Cognitive Decline,Visuospatial Deficit
 ;;^UTILITY(U,$J,358.3,13126,1,4,0)
 ;;=4^R41.842
 ;;^UTILITY(U,$J,358.3,13126,2)
 ;;=^5019445
 ;;^UTILITY(U,$J,358.3,13127,0)
 ;;=G31.84^^83^806^15
 ;;^UTILITY(U,$J,358.3,13127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13127,1,3,0)
 ;;=3^Cognitive Impairment,Mild
 ;;^UTILITY(U,$J,358.3,13127,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,13127,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,13128,0)
 ;;=G31.83^^83^806^19
 ;;^UTILITY(U,$J,358.3,13128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13128,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,13128,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,13128,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,13129,0)
 ;;=G31.2^^83^806^22
 ;;^UTILITY(U,$J,358.3,13129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13129,1,3,0)
 ;;=3^Dementia,Alcohol-Related
 ;;^UTILITY(U,$J,358.3,13129,1,4,0)
 ;;=4^G31.2
 ;;^UTILITY(U,$J,358.3,13129,2)
 ;;=^5003810
 ;;^UTILITY(U,$J,358.3,13130,0)
 ;;=A81.09^^83^806^25
 ;;^UTILITY(U,$J,358.3,13130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13130,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,13130,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,13130,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,13131,0)
 ;;=A81.00^^83^806^26
 ;;^UTILITY(U,$J,358.3,13131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13131,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,13131,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,13131,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,13132,0)
 ;;=A81.01^^83^806^27
 ;;^UTILITY(U,$J,358.3,13132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13132,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,13132,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,13132,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,13133,0)
 ;;=G31.9^^83^806^28
 ;;^UTILITY(U,$J,358.3,13133,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13133,1,3,0)
 ;;=3^Dementia,Degenerative Disease Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,13133,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,13133,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,13134,0)
 ;;=G10.^^83^806^45
 ;;^UTILITY(U,$J,358.3,13134,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13134,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,13134,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,13134,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,13135,0)
 ;;=G94.^^83^806^24
 ;;^UTILITY(U,$J,358.3,13135,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13135,1,3,0)
 ;;=3^Dementia,Brain Disorder in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,13135,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,13135,2)
 ;;=^5004187
