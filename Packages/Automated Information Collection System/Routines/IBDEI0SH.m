IBDEI0SH ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,37596,1,4,0)
 ;;=4^S06.0X3S
 ;;^UTILITY(U,$J,358.3,37596,2)
 ;;=^5020677
 ;;^UTILITY(U,$J,358.3,37597,0)
 ;;=S06.0X1S^^106^1592^4
 ;;^UTILITY(U,$J,358.3,37597,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37597,1,3,0)
 ;;=3^Concussion w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37597,1,4,0)
 ;;=4^S06.0X1S
 ;;^UTILITY(U,$J,358.3,37597,2)
 ;;=^5020671
 ;;^UTILITY(U,$J,358.3,37598,0)
 ;;=S06.0X2S^^106^1592^5
 ;;^UTILITY(U,$J,358.3,37598,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37598,1,3,0)
 ;;=3^Concussion w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,37598,1,4,0)
 ;;=4^S06.0X2S
 ;;^UTILITY(U,$J,358.3,37598,2)
 ;;=^5020674
 ;;^UTILITY(U,$J,358.3,37599,0)
 ;;=S06.0X4S^^106^1592^6
 ;;^UTILITY(U,$J,358.3,37599,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37599,1,3,0)
 ;;=3^Concussion w LOC of 6 hours to 24 hours, sequela
 ;;^UTILITY(U,$J,358.3,37599,1,4,0)
 ;;=4^S06.0X4S
 ;;^UTILITY(U,$J,358.3,37599,2)
 ;;=^5020680
 ;;^UTILITY(U,$J,358.3,37600,0)
 ;;=S06.0X9S^^106^1592^7
 ;;^UTILITY(U,$J,358.3,37600,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37600,1,3,0)
 ;;=3^Concussion w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,37600,1,4,0)
 ;;=4^S06.0X9S
 ;;^UTILITY(U,$J,358.3,37600,2)
 ;;=^5020695
 ;;^UTILITY(U,$J,358.3,37601,0)
 ;;=S06.0X0S^^106^1592^8
 ;;^UTILITY(U,$J,358.3,37601,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37601,1,3,0)
 ;;=3^Concussion w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,37601,1,4,0)
 ;;=4^S06.0X0S
 ;;^UTILITY(U,$J,358.3,37601,2)
 ;;=^5020668
 ;;^UTILITY(U,$J,358.3,37602,0)
 ;;=S06.335S^^106^1592^9
 ;;^UTILITY(U,$J,358.3,37602,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37602,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,37602,1,4,0)
 ;;=4^S06.335S
 ;;^UTILITY(U,$J,358.3,37602,2)
 ;;=^5020863
 ;;^UTILITY(U,$J,358.3,37603,0)
 ;;=S06.336S^^106^1592^10
 ;;^UTILITY(U,$J,358.3,37603,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37603,1,3,0)
 ;;=3^Contus/lac cereb, w LOC >24 hr w/o ret consc w surv, sequela
 ;;^UTILITY(U,$J,358.3,37603,1,4,0)
 ;;=4^S06.336S
 ;;^UTILITY(U,$J,358.3,37603,2)
 ;;=^5020866
 ;;^UTILITY(U,$J,358.3,37604,0)
 ;;=S06.333S^^106^1592^11
 ;;^UTILITY(U,$J,358.3,37604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37604,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,37604,1,4,0)
 ;;=4^S06.333S
 ;;^UTILITY(U,$J,358.3,37604,2)
 ;;=^5020857
 ;;^UTILITY(U,$J,358.3,37605,0)
 ;;=S06.331S^^106^1592^12
 ;;^UTILITY(U,$J,358.3,37605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37605,1,3,0)
 ;;=3^Contus/lac cereb, w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37605,1,4,0)
 ;;=4^S06.331S
 ;;^UTILITY(U,$J,358.3,37605,2)
 ;;=^5020851
 ;;^UTILITY(U,$J,358.3,37606,0)
 ;;=S06.325S^^106^1592^13
 ;;^UTILITY(U,$J,358.3,37606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37606,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,37606,1,4,0)
 ;;=4^S06.325S
 ;;^UTILITY(U,$J,358.3,37606,2)
 ;;=^5020833
 ;;^UTILITY(U,$J,358.3,37607,0)
 ;;=S06.326S^^106^1592^14
 ;;^UTILITY(U,$J,358.3,37607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37607,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,37607,1,4,0)
 ;;=4^S06.326S
 ;;^UTILITY(U,$J,358.3,37607,2)
 ;;=^5020836
 ;;^UTILITY(U,$J,358.3,37608,0)
 ;;=S06.323S^^106^1592^15
 ;;^UTILITY(U,$J,358.3,37608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37608,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,37608,1,4,0)
 ;;=4^S06.323S
 ;;^UTILITY(U,$J,358.3,37608,2)
 ;;=^5020827
 ;;^UTILITY(U,$J,358.3,37609,0)
 ;;=S06.321S^^106^1592^16
 ;;^UTILITY(U,$J,358.3,37609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37609,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37609,1,4,0)
 ;;=4^S06.321S
 ;;^UTILITY(U,$J,358.3,37609,2)
 ;;=^5020821
 ;;^UTILITY(U,$J,358.3,37610,0)
 ;;=S06.322S^^106^1592^17
 ;;^UTILITY(U,$J,358.3,37610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37610,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,37610,1,4,0)
 ;;=4^S06.322S
 ;;^UTILITY(U,$J,358.3,37610,2)
 ;;=^5020824
 ;;^UTILITY(U,$J,358.3,37611,0)
 ;;=S06.324S^^106^1592^18
 ;;^UTILITY(U,$J,358.3,37611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37611,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,37611,1,4,0)
 ;;=4^S06.324S
 ;;^UTILITY(U,$J,358.3,37611,2)
 ;;=^5020830
 ;;^UTILITY(U,$J,358.3,37612,0)
 ;;=S06.329S^^106^1592^19
 ;;^UTILITY(U,$J,358.3,37612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37612,1,3,0)
 ;;=3^Contus/lac left cerebrum w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,37612,1,4,0)
 ;;=4^S06.329S
 ;;^UTILITY(U,$J,358.3,37612,2)
 ;;=^5020845
 ;;^UTILITY(U,$J,358.3,37613,0)
 ;;=S06.320S^^106^1592^20
 ;;^UTILITY(U,$J,358.3,37613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37613,1,3,0)
 ;;=3^Contus/lac left cerebrum w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,37613,1,4,0)
 ;;=4^S06.320S
 ;;^UTILITY(U,$J,358.3,37613,2)
 ;;=^5020818
 ;;^UTILITY(U,$J,358.3,37614,0)
 ;;=S06.315S^^106^1592^21
 ;;^UTILITY(U,$J,358.3,37614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37614,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,37614,1,4,0)
 ;;=4^S06.315S
 ;;^UTILITY(U,$J,358.3,37614,2)
 ;;=^5020803
 ;;^UTILITY(U,$J,358.3,37615,0)
 ;;=S06.316S^^106^1592^22
 ;;^UTILITY(U,$J,358.3,37615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37615,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,37615,1,4,0)
 ;;=4^S06.316S
 ;;^UTILITY(U,$J,358.3,37615,2)
 ;;=^5020806
 ;;^UTILITY(U,$J,358.3,37616,0)
 ;;=S06.313S^^106^1592^23
 ;;^UTILITY(U,$J,358.3,37616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37616,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,37616,1,4,0)
 ;;=4^S06.313S
 ;;^UTILITY(U,$J,358.3,37616,2)
 ;;=^5020797
 ;;^UTILITY(U,$J,358.3,37617,0)
 ;;=S06.311S^^106^1592^24
 ;;^UTILITY(U,$J,358.3,37617,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37617,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37617,1,4,0)
 ;;=4^S06.311S
 ;;^UTILITY(U,$J,358.3,37617,2)
 ;;=^5020791
 ;;^UTILITY(U,$J,358.3,37618,0)
 ;;=S06.312S^^106^1592^25
 ;;^UTILITY(U,$J,358.3,37618,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37618,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,37618,1,4,0)
 ;;=4^S06.312S
 ;;^UTILITY(U,$J,358.3,37618,2)
 ;;=^5020794
 ;;^UTILITY(U,$J,358.3,37619,0)
 ;;=S06.314S^^106^1592^26
 ;;^UTILITY(U,$J,358.3,37619,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37619,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,37619,1,4,0)
 ;;=4^S06.314S
 ;;^UTILITY(U,$J,358.3,37619,2)
 ;;=^5020800
 ;;^UTILITY(U,$J,358.3,37620,0)
 ;;=S06.319S^^106^1592^27
 ;;^UTILITY(U,$J,358.3,37620,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37620,1,3,0)
 ;;=3^Contus/lac right cerebrum w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,37620,1,4,0)
 ;;=4^S06.319S
 ;;^UTILITY(U,$J,358.3,37620,2)
 ;;=^5020815
 ;;^UTILITY(U,$J,358.3,37621,0)
 ;;=S06.310S^^106^1592^28
 ;;^UTILITY(U,$J,358.3,37621,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37621,1,3,0)
 ;;=3^Contus/lac right cerebrum w/o LOC, sequela
 ;;^UTILITY(U,$J,358.3,37621,1,4,0)
 ;;=4^S06.310S
 ;;^UTILITY(U,$J,358.3,37621,2)
 ;;=^5020788
 ;;^UTILITY(U,$J,358.3,37622,0)
 ;;=S06.385S^^106^1592^29
 ;;^UTILITY(U,$J,358.3,37622,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37622,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC >24 hr w ret consc lev, sequela
 ;;^UTILITY(U,$J,358.3,37622,1,4,0)
 ;;=4^S06.385S
 ;;^UTILITY(U,$J,358.3,37622,2)
 ;;=^5021013
 ;;^UTILITY(U,$J,358.3,37623,0)
 ;;=S06.386S^^106^1592^30
 ;;^UTILITY(U,$J,358.3,37623,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37623,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC >24 hr w/o ret consc w surv, sqla
 ;;^UTILITY(U,$J,358.3,37623,1,4,0)
 ;;=4^S06.386S
 ;;^UTILITY(U,$J,358.3,37623,2)
 ;;=^5021016
 ;;^UTILITY(U,$J,358.3,37624,0)
 ;;=S06.383S^^106^1592^31
 ;;^UTILITY(U,$J,358.3,37624,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37624,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of 1-5 hrs 59 min, sequela
 ;;^UTILITY(U,$J,358.3,37624,1,4,0)
 ;;=4^S06.383S
 ;;^UTILITY(U,$J,358.3,37624,2)
 ;;=^5021007
 ;;^UTILITY(U,$J,358.3,37625,0)
 ;;=S06.381S^^106^1592^32
 ;;^UTILITY(U,$J,358.3,37625,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37625,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of 30 minutes or less, sequela
 ;;^UTILITY(U,$J,358.3,37625,1,4,0)
 ;;=4^S06.381S
 ;;^UTILITY(U,$J,358.3,37625,2)
 ;;=^5021001
 ;;^UTILITY(U,$J,358.3,37626,0)
 ;;=S06.382S^^106^1592^33
 ;;^UTILITY(U,$J,358.3,37626,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37626,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of 31-59 min, sequela
 ;;^UTILITY(U,$J,358.3,37626,1,4,0)
 ;;=4^S06.382S
 ;;^UTILITY(U,$J,358.3,37626,2)
 ;;=^5021004
 ;;^UTILITY(U,$J,358.3,37627,0)
 ;;=S06.384S^^106^1592^34
 ;;^UTILITY(U,$J,358.3,37627,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37627,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of 6-24 hrs, sequela
 ;;^UTILITY(U,$J,358.3,37627,1,4,0)
 ;;=4^S06.384S
 ;;^UTILITY(U,$J,358.3,37627,2)
 ;;=^5021010
 ;;^UTILITY(U,$J,358.3,37628,0)
 ;;=S06.389S^^106^1592^35
 ;;^UTILITY(U,$J,358.3,37628,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,37628,1,3,0)
 ;;=3^Contus/lac/hem brnst w LOC of unsp duration, sequela
 ;;^UTILITY(U,$J,358.3,37628,1,4,0)
 ;;=4^S06.389S
 ;;^UTILITY(U,$J,358.3,37628,2)
 ;;=^5021025
 ;;^UTILITY(U,$J,358.3,37629,0)
 ;;=S06.380S^^106^1592^36
