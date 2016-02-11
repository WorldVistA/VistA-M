IBDEI33M ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,51999,0)
 ;;=Z02.71^^233^2552^7
 ;;^UTILITY(U,$J,358.3,51999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,51999,1,3,0)
 ;;=3^Disability determination
 ;;^UTILITY(U,$J,358.3,51999,1,4,0)
 ;;=4^Z02.71
 ;;^UTILITY(U,$J,358.3,51999,2)
 ;;=^5062640
 ;;^UTILITY(U,$J,358.3,52000,0)
 ;;=Z04.8^^233^2552^8
 ;;^UTILITY(U,$J,358.3,52000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52000,1,3,0)
 ;;=3^Exam and observation for oth reasons
 ;;^UTILITY(U,$J,358.3,52000,1,4,0)
 ;;=4^Z04.8
 ;;^UTILITY(U,$J,358.3,52000,2)
 ;;=^5062665
 ;;^UTILITY(U,$J,358.3,52001,0)
 ;;=Z02.0^^233^2552^9
 ;;^UTILITY(U,$J,358.3,52001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52001,1,3,0)
 ;;=3^Exam for admission to educational institution
 ;;^UTILITY(U,$J,358.3,52001,1,4,0)
 ;;=4^Z02.0
 ;;^UTILITY(U,$J,358.3,52001,2)
 ;;=^5062633
 ;;^UTILITY(U,$J,358.3,52002,0)
 ;;=Z02.2^^233^2552^10
 ;;^UTILITY(U,$J,358.3,52002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52002,1,3,0)
 ;;=3^Exam for admission to residential institution
 ;;^UTILITY(U,$J,358.3,52002,1,4,0)
 ;;=4^Z02.2
 ;;^UTILITY(U,$J,358.3,52002,2)
 ;;=^5062635
 ;;^UTILITY(U,$J,358.3,52003,0)
 ;;=Z02.4^^233^2552^11
 ;;^UTILITY(U,$J,358.3,52003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52003,1,3,0)
 ;;=3^Exam for driving license
 ;;^UTILITY(U,$J,358.3,52003,1,4,0)
 ;;=4^Z02.4
 ;;^UTILITY(U,$J,358.3,52003,2)
 ;;=^5062637
 ;;^UTILITY(U,$J,358.3,52004,0)
 ;;=Z02.6^^233^2552^12
 ;;^UTILITY(U,$J,358.3,52004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52004,1,3,0)
 ;;=3^Exam for insurance purposes
 ;;^UTILITY(U,$J,358.3,52004,1,4,0)
 ;;=4^Z02.6
 ;;^UTILITY(U,$J,358.3,52004,2)
 ;;=^5062639
 ;;^UTILITY(U,$J,358.3,52005,0)
 ;;=Z02.5^^233^2552^13
 ;;^UTILITY(U,$J,358.3,52005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52005,1,3,0)
 ;;=3^Exam for participation in sport
 ;;^UTILITY(U,$J,358.3,52005,1,4,0)
 ;;=4^Z02.5
 ;;^UTILITY(U,$J,358.3,52005,2)
 ;;=^5062638
 ;;^UTILITY(U,$J,358.3,52006,0)
 ;;=Z02.3^^233^2552^14
 ;;^UTILITY(U,$J,358.3,52006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52006,1,3,0)
 ;;=3^Exam for recruitment to armed forces
 ;;^UTILITY(U,$J,358.3,52006,1,4,0)
 ;;=4^Z02.3
 ;;^UTILITY(U,$J,358.3,52006,2)
 ;;=^5062636
 ;;^UTILITY(U,$J,358.3,52007,0)
 ;;=Z44.8^^233^2552^17
 ;;^UTILITY(U,$J,358.3,52007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52007,1,3,0)
 ;;=3^Fit/adjst of external prosthetic devices
 ;;^UTILITY(U,$J,358.3,52007,1,4,0)
 ;;=4^Z44.8
 ;;^UTILITY(U,$J,358.3,52007,2)
 ;;=^5062992
 ;;^UTILITY(U,$J,358.3,52008,0)
 ;;=Z44.9^^233^2552^18
 ;;^UTILITY(U,$J,358.3,52008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52008,1,3,0)
 ;;=3^Fit/adjst of unsp external prosthetic device
 ;;^UTILITY(U,$J,358.3,52008,1,4,0)
 ;;=4^Z44.9
 ;;^UTILITY(U,$J,358.3,52008,2)
 ;;=^5062993
 ;;^UTILITY(U,$J,358.3,52009,0)
 ;;=Z09.^^233^2552^16
 ;;^UTILITY(U,$J,358.3,52009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52009,1,3,0)
 ;;=3^F/U exam aft trtmt for cond oth than malig neoplm
 ;;^UTILITY(U,$J,358.3,52009,1,4,0)
 ;;=4^Z09.
 ;;^UTILITY(U,$J,358.3,52009,2)
 ;;=^5062668
 ;;^UTILITY(U,$J,358.3,52010,0)
 ;;=Z02.79^^233^2552^19
 ;;^UTILITY(U,$J,358.3,52010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52010,1,3,0)
 ;;=3^Issue of other medical certificate
 ;;^UTILITY(U,$J,358.3,52010,1,4,0)
 ;;=4^Z02.79
 ;;^UTILITY(U,$J,358.3,52010,2)
 ;;=^5062641
 ;;^UTILITY(U,$J,358.3,52011,0)
 ;;=Z51.89^^233^2552^31
 ;;^UTILITY(U,$J,358.3,52011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52011,1,3,0)
 ;;=3^Specified aftercare NEC
 ;;^UTILITY(U,$J,358.3,52011,1,4,0)
 ;;=4^Z51.89
