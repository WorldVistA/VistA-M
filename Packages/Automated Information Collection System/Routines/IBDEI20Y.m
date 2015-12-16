IBDEI20Y ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,35389,1,3,0)
 ;;=3^Exam for insurance purposes
 ;;^UTILITY(U,$J,358.3,35389,1,4,0)
 ;;=4^Z02.6
 ;;^UTILITY(U,$J,358.3,35389,2)
 ;;=^5062639
 ;;^UTILITY(U,$J,358.3,35390,0)
 ;;=Z02.5^^186^2037^13
 ;;^UTILITY(U,$J,358.3,35390,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35390,1,3,0)
 ;;=3^Exam for participation in sport
 ;;^UTILITY(U,$J,358.3,35390,1,4,0)
 ;;=4^Z02.5
 ;;^UTILITY(U,$J,358.3,35390,2)
 ;;=^5062638
 ;;^UTILITY(U,$J,358.3,35391,0)
 ;;=Z02.3^^186^2037^14
 ;;^UTILITY(U,$J,358.3,35391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35391,1,3,0)
 ;;=3^Exam for recruitment to armed forces
 ;;^UTILITY(U,$J,358.3,35391,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,35391,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,35392,0)
 ;;=Z44.8^^186^2037^17
 ;;^UTILITY(U,$J,358.3,35392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35392,1,3,0)
 ;;=3^Fit/adjst of external prosthetic devices
 ;;^UTILITY(U,$J,358.3,35392,1,4,0)
 ;;=4^Z44.8
 ;;^UTILITY(U,$J,358.3,35392,2)
 ;;=^5062992
 ;;^UTILITY(U,$J,358.3,35393,0)
 ;;=Z44.9^^186^2037^18
 ;;^UTILITY(U,$J,358.3,35393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35393,1,3,0)
 ;;=3^Fit/adjst of unsp external prosthetic device
 ;;^UTILITY(U,$J,358.3,35393,1,4,0)
 ;;=4^Z44.9
 ;;^UTILITY(U,$J,358.3,35393,2)
 ;;=^5062993
 ;;^UTILITY(U,$J,358.3,35394,0)
 ;;=Z09.^^186^2037^16
 ;;^UTILITY(U,$J,358.3,35394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35394,1,3,0)
 ;;=3^F/U exam aft trtmt for cond oth than malig neoplm
 ;;^UTILITY(U,$J,358.3,35394,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,35394,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,35395,0)
 ;;=Z02.79^^186^2037^19
 ;;^UTILITY(U,$J,358.3,35395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35395,1,3,0)
 ;;=3^Issue of other medical certificate
 ;;^UTILITY(U,$J,358.3,35395,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,35395,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,35396,0)
 ;;=Z51.89^^186^2037^31
 ;;^UTILITY(U,$J,358.3,35396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35396,1,3,0)
 ;;=3^Specified aftercare NEC
 ;;^UTILITY(U,$J,358.3,35396,1,4,0)
 ;;=4^Z51.89
 ;;^UTILITY(U,$J,358.3,35396,2)
 ;;=^5063065
 ;;^UTILITY(U,$J,358.3,35397,0)
 ;;=Z02.1^^186^2037^25
 ;;^UTILITY(U,$J,358.3,35397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35397,1,3,0)
 ;;=3^Pre-employment examination
 ;;^UTILITY(U,$J,358.3,35397,1,4,0)
 ;;=4^Z02.1
 ;;^UTILITY(U,$J,358.3,35397,2)
 ;;=^5062634
 ;;^UTILITY(U,$J,358.3,35398,0)
 ;;=Z13.5^^186^2037^15
 ;;^UTILITY(U,$J,358.3,35398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35398,1,3,0)
 ;;=3^Eye and Ear Disorder Screening
 ;;^UTILITY(U,$J,358.3,35398,1,4,0)
 ;;=4^Z13.5
 ;;^UTILITY(U,$J,358.3,35398,2)
 ;;=^5062706
 ;;^UTILITY(U,$J,358.3,35399,0)
 ;;=Z13.850^^186^2037^32
 ;;^UTILITY(U,$J,358.3,35399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35399,1,3,0)
 ;;=3^Traumatic Brain Injury Screening
 ;;^UTILITY(U,$J,358.3,35399,1,4,0)
 ;;=4^Z13.850
 ;;^UTILITY(U,$J,358.3,35399,2)
 ;;=^5062717
 ;;^UTILITY(U,$J,358.3,35400,0)
 ;;=Z85.841^^186^2037^20
 ;;^UTILITY(U,$J,358.3,35400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35400,1,3,0)
 ;;=3^Personal history of malignant neoplasm of brain
 ;;^UTILITY(U,$J,358.3,35400,1,4,0)
 ;;=4^Z85.841
 ;;^UTILITY(U,$J,358.3,35400,2)
 ;;=^5063447
 ;;^UTILITY(U,$J,358.3,35401,0)
 ;;=Z85.21^^186^2037^21
 ;;^UTILITY(U,$J,358.3,35401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,35401,1,3,0)
 ;;=3^Personal history of malignant neoplasm of larynx
 ;;^UTILITY(U,$J,358.3,35401,1,4,0)
 ;;=4^Z85.21
 ;;^UTILITY(U,$J,358.3,35401,2)
 ;;=^5063411
 ;;^UTILITY(U,$J,358.3,35402,0)
 ;;=Z85.22^^186^2037^22
