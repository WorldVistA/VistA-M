IBDEI2WP ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,48792,1,4,0)
 ;;=4^S06.325S
 ;;^UTILITY(U,$J,358.3,48792,2)
 ;;=^5020833
 ;;^UTILITY(U,$J,358.3,48793,0)
 ;;=S06.326S^^216^2412^14
 ;;^UTILITY(U,$J,358.3,48793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48793,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,48793,1,4,0)
 ;;=4^S06.326S
 ;;^UTILITY(U,$J,358.3,48793,2)
 ;;=^5020836
 ;;^UTILITY(U,$J,358.3,48794,0)
 ;;=S06.323S^^216^2412^15
 ;;^UTILITY(U,$J,358.3,48794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48794,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,48794,1,4,0)
 ;;=4^S06.323S
 ;;^UTILITY(U,$J,358.3,48794,2)
 ;;=^5020827
 ;;^UTILITY(U,$J,358.3,48795,0)
 ;;=S06.321S^^216^2412^16
 ;;^UTILITY(U,$J,358.3,48795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48795,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,48795,1,4,0)
 ;;=4^S06.321S
 ;;^UTILITY(U,$J,358.3,48795,2)
 ;;=^5020821
 ;;^UTILITY(U,$J,358.3,48796,0)
 ;;=S06.322S^^216^2412^17
 ;;^UTILITY(U,$J,358.3,48796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48796,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,48796,1,4,0)
 ;;=4^S06.322S
 ;;^UTILITY(U,$J,358.3,48796,2)
 ;;=^5020824
 ;;^UTILITY(U,$J,358.3,48797,0)
 ;;=S06.324S^^216^2412^18
 ;;^UTILITY(U,$J,358.3,48797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48797,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,48797,1,4,0)
 ;;=4^S06.324S
 ;;^UTILITY(U,$J,358.3,48797,2)
 ;;=^5020830
 ;;^UTILITY(U,$J,358.3,48798,0)
 ;;=S06.329S^^216^2412^19
 ;;^UTILITY(U,$J,358.3,48798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48798,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,48798,1,4,0)
 ;;=4^S06.329S
 ;;^UTILITY(U,$J,358.3,48798,2)
 ;;=^5020845
 ;;^UTILITY(U,$J,358.3,48799,0)
 ;;=S06.320S^^216^2412^20
 ;;^UTILITY(U,$J,358.3,48799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48799,1,3,0)
 ;;=3^Contus/lac left cerebrum w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,48799,1,4,0)
 ;;=4^S06.320S
 ;;^UTILITY(U,$J,358.3,48799,2)
 ;;=^5020818
 ;;^UTILITY(U,$J,358.3,48800,0)
 ;;=S06.315S^^216^2412^21
 ;;^UTILITY(U,$J,358.3,48800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48800,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,48800,1,4,0)
 ;;=4^S06.315S
 ;;^UTILITY(U,$J,358.3,48800,2)
 ;;=^5020803
 ;;^UTILITY(U,$J,358.3,48801,0)
 ;;=S06.316S^^216^2412^22
 ;;^UTILITY(U,$J,358.3,48801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48801,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,48801,1,4,0)
 ;;=4^S06.316S
 ;;^UTILITY(U,$J,358.3,48801,2)
 ;;=^5020806
 ;;^UTILITY(U,$J,358.3,48802,0)
 ;;=S06.313S^^216^2412^23
 ;;^UTILITY(U,$J,358.3,48802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48802,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,48802,1,4,0)
 ;;=4^S06.313S
 ;;^UTILITY(U,$J,358.3,48802,2)
 ;;=^5020797
 ;;^UTILITY(U,$J,358.3,48803,0)
 ;;=S06.311S^^216^2412^24
 ;;^UTILITY(U,$J,358.3,48803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,48803,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,48803,1,4,0)
 ;;=4^S06.311S
 ;;^UTILITY(U,$J,358.3,48803,2)
 ;;=^5020791
 ;;^UTILITY(U,$J,358.3,48804,0)
 ;;=S06.312S^^216^2412^25
 ;;^UTILITY(U,$J,358.3,48804,1,0)
 ;;=^358.31IA^4^2
