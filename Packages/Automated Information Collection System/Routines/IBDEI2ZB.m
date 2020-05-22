IBDEI2ZB ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,47571,1,4,0)
 ;;=4^R41.9
 ;;^UTILITY(U,$J,358.3,47571,2)
 ;;=^5019449
 ;;^UTILITY(U,$J,358.3,47572,0)
 ;;=R41.842^^185^2408^14
 ;;^UTILITY(U,$J,358.3,47572,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47572,1,3,0)
 ;;=3^Cognitive Decline,Visuospatial Deficit
 ;;^UTILITY(U,$J,358.3,47572,1,4,0)
 ;;=4^R41.842
 ;;^UTILITY(U,$J,358.3,47572,2)
 ;;=^5019445
 ;;^UTILITY(U,$J,358.3,47573,0)
 ;;=G31.84^^185^2408^15
 ;;^UTILITY(U,$J,358.3,47573,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47573,1,3,0)
 ;;=3^Cognitive Impairment,Mild
 ;;^UTILITY(U,$J,358.3,47573,1,4,0)
 ;;=4^G31.84
 ;;^UTILITY(U,$J,358.3,47573,2)
 ;;=^5003813
 ;;^UTILITY(U,$J,358.3,47574,0)
 ;;=G31.83^^185^2408^19
 ;;^UTILITY(U,$J,358.3,47574,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47574,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,47574,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,47574,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,47575,0)
 ;;=G31.2^^185^2408^22
 ;;^UTILITY(U,$J,358.3,47575,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47575,1,3,0)
 ;;=3^Dementia,Alcohol-Related
 ;;^UTILITY(U,$J,358.3,47575,1,4,0)
 ;;=4^G31.2
 ;;^UTILITY(U,$J,358.3,47575,2)
 ;;=^5003810
 ;;^UTILITY(U,$J,358.3,47576,0)
 ;;=A81.09^^185^2408^25
 ;;^UTILITY(U,$J,358.3,47576,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47576,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Other
 ;;^UTILITY(U,$J,358.3,47576,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,47576,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,47577,0)
 ;;=A81.00^^185^2408^26
 ;;^UTILITY(U,$J,358.3,47577,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47577,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,47577,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,47577,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,47578,0)
 ;;=A81.01^^185^2408^27
 ;;^UTILITY(U,$J,358.3,47578,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47578,1,3,0)
 ;;=3^Dementia,Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,47578,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,47578,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,47579,0)
 ;;=G31.9^^185^2408^28
 ;;^UTILITY(U,$J,358.3,47579,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47579,1,3,0)
 ;;=3^Dementia,Degenerative Disease Nervous System,Unspec
 ;;^UTILITY(U,$J,358.3,47579,1,4,0)
 ;;=4^G31.9
 ;;^UTILITY(U,$J,358.3,47579,2)
 ;;=^5003815
 ;;^UTILITY(U,$J,358.3,47580,0)
 ;;=G10.^^185^2408^45
 ;;^UTILITY(U,$J,358.3,47580,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47580,1,3,0)
 ;;=3^Huntington's Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,47580,1,4,0)
 ;;=4^G10.
 ;;^UTILITY(U,$J,358.3,47580,2)
 ;;=^5003751^F02.80
 ;;^UTILITY(U,$J,358.3,47581,0)
 ;;=G94.^^185^2408^24
 ;;^UTILITY(U,$J,358.3,47581,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47581,1,3,0)
 ;;=3^Dementia,Brain Disorder in Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,47581,1,4,0)
 ;;=4^G94.
 ;;^UTILITY(U,$J,358.3,47581,2)
 ;;=^5004187
 ;;^UTILITY(U,$J,358.3,47582,0)
 ;;=G31.09^^185^2408^29
 ;;^UTILITY(U,$J,358.3,47582,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47582,1,3,0)
 ;;=3^Dementia,Frontotemporal,Other
 ;;^UTILITY(U,$J,358.3,47582,1,4,0)
 ;;=4^G31.09
 ;;^UTILITY(U,$J,358.3,47582,2)
 ;;=^329916
 ;;^UTILITY(U,$J,358.3,47583,0)
 ;;=G23.8^^185^2408^23
 ;;^UTILITY(U,$J,358.3,47583,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,47583,1,3,0)
 ;;=3^Dementia,Basal Ganglia Degenerative Diseases
