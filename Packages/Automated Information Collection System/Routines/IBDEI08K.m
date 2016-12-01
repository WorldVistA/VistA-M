IBDEI08K ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10800,1,3,0)
 ;;=3^Encounter for Preproc Exam,Unspec
 ;;^UTILITY(U,$J,358.3,10800,1,4,0)
 ;;=4^Z01.818
 ;;^UTILITY(U,$J,358.3,10800,2)
 ;;=^5062628
 ;;^UTILITY(U,$J,358.3,10801,0)
 ;;=Z01.811^^37^561^5
 ;;^UTILITY(U,$J,358.3,10801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10801,1,3,0)
 ;;=3^Encounter for Preproc Respiratory Exam
 ;;^UTILITY(U,$J,358.3,10801,1,4,0)
 ;;=4^Z01.811
 ;;^UTILITY(U,$J,358.3,10801,2)
 ;;=^5062626
 ;;^UTILITY(U,$J,358.3,10802,0)
 ;;=K40.00^^37^562^15
 ;;^UTILITY(U,$J,358.3,10802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10802,1,3,0)
 ;;=3^Bil Inguinal Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10802,1,4,0)
 ;;=4^K40.00
 ;;^UTILITY(U,$J,358.3,10802,2)
 ;;=^5008581
 ;;^UTILITY(U,$J,358.3,10803,0)
 ;;=K40.01^^37^562^16
 ;;^UTILITY(U,$J,358.3,10803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10803,1,3,0)
 ;;=3^Bil Inguinal Hernia w/ Obs w/o Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10803,1,4,0)
 ;;=4^K40.01
 ;;^UTILITY(U,$J,358.3,10803,2)
 ;;=^5008582
 ;;^UTILITY(U,$J,358.3,10804,0)
 ;;=K40.10^^37^562^13
 ;;^UTILITY(U,$J,358.3,10804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10804,1,3,0)
 ;;=3^Bil Inguinal Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,10804,1,4,0)
 ;;=4^K40.10
 ;;^UTILITY(U,$J,358.3,10804,2)
 ;;=^5008583
 ;;^UTILITY(U,$J,358.3,10805,0)
 ;;=K40.11^^37^562^14
 ;;^UTILITY(U,$J,358.3,10805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10805,1,3,0)
 ;;=3^Bil Inguinal Hernia w/ Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10805,1,4,0)
 ;;=4^K40.11
 ;;^UTILITY(U,$J,358.3,10805,2)
 ;;=^5008584
 ;;^UTILITY(U,$J,358.3,10806,0)
 ;;=K40.20^^37^562^17
 ;;^UTILITY(U,$J,358.3,10806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10806,1,3,0)
 ;;=3^Bil Inguinal Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,10806,1,4,0)
 ;;=4^K40.20
 ;;^UTILITY(U,$J,358.3,10806,2)
 ;;=^5008585
 ;;^UTILITY(U,$J,358.3,10807,0)
 ;;=K40.21^^37^562^18
 ;;^UTILITY(U,$J,358.3,10807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10807,1,3,0)
 ;;=3^Bil Inguinal Hernia w/o Obs or Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10807,1,4,0)
 ;;=4^K40.21
 ;;^UTILITY(U,$J,358.3,10807,2)
 ;;=^5008586
 ;;^UTILITY(U,$J,358.3,10808,0)
 ;;=K40.30^^37^562^39
 ;;^UTILITY(U,$J,358.3,10808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10808,1,3,0)
 ;;=3^Unil Inguinal Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10808,1,4,0)
 ;;=4^K40.30
 ;;^UTILITY(U,$J,358.3,10808,2)
 ;;=^5008587
 ;;^UTILITY(U,$J,358.3,10809,0)
 ;;=K40.31^^37^562^40
 ;;^UTILITY(U,$J,358.3,10809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10809,1,3,0)
 ;;=3^Unil Inguinal Hernia w/ Obs w/o Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10809,1,4,0)
 ;;=4^K40.31
 ;;^UTILITY(U,$J,358.3,10809,2)
 ;;=^5008588
 ;;^UTILITY(U,$J,358.3,10810,0)
 ;;=K40.40^^37^562^37
 ;;^UTILITY(U,$J,358.3,10810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10810,1,3,0)
 ;;=3^Unil Inguinal Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,10810,1,4,0)
 ;;=4^K40.40
 ;;^UTILITY(U,$J,358.3,10810,2)
 ;;=^5008589
 ;;^UTILITY(U,$J,358.3,10811,0)
 ;;=K40.41^^37^562^38
 ;;^UTILITY(U,$J,358.3,10811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10811,1,3,0)
 ;;=3^Unil Inguinal Hernia w/ Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10811,1,4,0)
 ;;=4^K40.41
 ;;^UTILITY(U,$J,358.3,10811,2)
 ;;=^5008590
 ;;^UTILITY(U,$J,358.3,10812,0)
 ;;=K40.90^^37^562^41
 ;;^UTILITY(U,$J,358.3,10812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10812,1,3,0)
 ;;=3^Unil Inguinal Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,10812,1,4,0)
 ;;=4^K40.90
 ;;^UTILITY(U,$J,358.3,10812,2)
 ;;=^5008591
 ;;^UTILITY(U,$J,358.3,10813,0)
 ;;=K40.91^^37^562^42
 ;;^UTILITY(U,$J,358.3,10813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10813,1,3,0)
 ;;=3^Unil Inguinal Hernia w/o Obs or Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10813,1,4,0)
 ;;=4^K40.91
 ;;^UTILITY(U,$J,358.3,10813,2)
 ;;=^5008592
 ;;^UTILITY(U,$J,358.3,10814,0)
 ;;=K41.00^^37^562^9
 ;;^UTILITY(U,$J,358.3,10814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10814,1,3,0)
 ;;=3^Bil Femoral Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10814,1,4,0)
 ;;=4^K41.00
 ;;^UTILITY(U,$J,358.3,10814,2)
 ;;=^5008593
 ;;^UTILITY(U,$J,358.3,10815,0)
 ;;=K41.01^^37^562^10
 ;;^UTILITY(U,$J,358.3,10815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10815,1,3,0)
 ;;=3^Bil Femoral Hernia w/ Obs w/o Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10815,1,4,0)
 ;;=4^K41.01
 ;;^UTILITY(U,$J,358.3,10815,2)
 ;;=^5008594
 ;;^UTILITY(U,$J,358.3,10816,0)
 ;;=K41.10^^37^562^7
 ;;^UTILITY(U,$J,358.3,10816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10816,1,3,0)
 ;;=3^Bil Femoral Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,10816,1,4,0)
 ;;=4^K41.10
 ;;^UTILITY(U,$J,358.3,10816,2)
 ;;=^5008595
 ;;^UTILITY(U,$J,358.3,10817,0)
 ;;=K41.11^^37^562^8
 ;;^UTILITY(U,$J,358.3,10817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10817,1,3,0)
 ;;=3^Bil Femoral Hernia w/ Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10817,1,4,0)
 ;;=4^K41.11
 ;;^UTILITY(U,$J,358.3,10817,2)
 ;;=^5008596
 ;;^UTILITY(U,$J,358.3,10818,0)
 ;;=K41.20^^37^562^11
 ;;^UTILITY(U,$J,358.3,10818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10818,1,3,0)
 ;;=3^Bil Femoral Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,10818,1,4,0)
 ;;=4^K41.20
 ;;^UTILITY(U,$J,358.3,10818,2)
 ;;=^5008597
 ;;^UTILITY(U,$J,358.3,10819,0)
 ;;=K41.21^^37^562^12
 ;;^UTILITY(U,$J,358.3,10819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10819,1,3,0)
 ;;=3^Bil Femoral Hernia w/o Obs or Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10819,1,4,0)
 ;;=4^K41.21
 ;;^UTILITY(U,$J,358.3,10819,2)
 ;;=^5008598
 ;;^UTILITY(U,$J,358.3,10820,0)
 ;;=K41.30^^37^562^33
 ;;^UTILITY(U,$J,358.3,10820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10820,1,3,0)
 ;;=3^Unil Femoral Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10820,1,4,0)
 ;;=4^K41.30
 ;;^UTILITY(U,$J,358.3,10820,2)
 ;;=^5008599
 ;;^UTILITY(U,$J,358.3,10821,0)
 ;;=K41.31^^37^562^34
 ;;^UTILITY(U,$J,358.3,10821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10821,1,3,0)
 ;;=3^Unil Femoral Hernia w/ Obs w/o Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10821,1,4,0)
 ;;=4^K41.31
 ;;^UTILITY(U,$J,358.3,10821,2)
 ;;=^5008600
 ;;^UTILITY(U,$J,358.3,10822,0)
 ;;=K41.40^^37^562^31
 ;;^UTILITY(U,$J,358.3,10822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10822,1,3,0)
 ;;=3^Unil Femoral Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,10822,1,4,0)
 ;;=4^K41.40
 ;;^UTILITY(U,$J,358.3,10822,2)
 ;;=^5008601
 ;;^UTILITY(U,$J,358.3,10823,0)
 ;;=K41.41^^37^562^32
 ;;^UTILITY(U,$J,358.3,10823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10823,1,3,0)
 ;;=3^Unil Femoral Hernia w/ Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10823,1,4,0)
 ;;=4^K41.41
 ;;^UTILITY(U,$J,358.3,10823,2)
 ;;=^5008602
 ;;^UTILITY(U,$J,358.3,10824,0)
 ;;=K41.90^^37^562^35
 ;;^UTILITY(U,$J,358.3,10824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10824,1,3,0)
 ;;=3^Unil Femoral Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,10824,1,4,0)
 ;;=4^K41.90
 ;;^UTILITY(U,$J,358.3,10824,2)
 ;;=^5008603
 ;;^UTILITY(U,$J,358.3,10825,0)
 ;;=K41.91^^37^562^36
 ;;^UTILITY(U,$J,358.3,10825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10825,1,3,0)
 ;;=3^Unil Femoral Hernia w/o Obs or Gangrene,Recurrent
 ;;^UTILITY(U,$J,358.3,10825,1,4,0)
 ;;=4^K41.91
 ;;^UTILITY(U,$J,358.3,10825,2)
 ;;=^5008604
 ;;^UTILITY(U,$J,358.3,10826,0)
 ;;=K42.0^^37^562^29
 ;;^UTILITY(U,$J,358.3,10826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10826,1,3,0)
 ;;=3^Umbilical Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10826,1,4,0)
 ;;=4^K42.0
 ;;^UTILITY(U,$J,358.3,10826,2)
 ;;=^5008605
 ;;^UTILITY(U,$J,358.3,10827,0)
 ;;=K42.1^^37^562^28
 ;;^UTILITY(U,$J,358.3,10827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10827,1,3,0)
 ;;=3^Umbilical Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,10827,1,4,0)
 ;;=4^K42.1
 ;;^UTILITY(U,$J,358.3,10827,2)
 ;;=^270220
 ;;^UTILITY(U,$J,358.3,10828,0)
 ;;=K42.9^^37^562^30
 ;;^UTILITY(U,$J,358.3,10828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10828,1,3,0)
 ;;=3^Umbilical Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,10828,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,10828,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,10829,0)
 ;;=K43.0^^37^562^23
 ;;^UTILITY(U,$J,358.3,10829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10829,1,3,0)
 ;;=3^Incisional Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10829,1,4,0)
 ;;=4^K43.0
 ;;^UTILITY(U,$J,358.3,10829,2)
 ;;=^5008607
 ;;^UTILITY(U,$J,358.3,10830,0)
 ;;=K43.1^^37^562^22
 ;;^UTILITY(U,$J,358.3,10830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10830,1,3,0)
 ;;=3^Incisional Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,10830,1,4,0)
 ;;=4^K43.1
 ;;^UTILITY(U,$J,358.3,10830,2)
 ;;=^5008608
 ;;^UTILITY(U,$J,358.3,10831,0)
 ;;=K43.2^^37^562^24
 ;;^UTILITY(U,$J,358.3,10831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10831,1,3,0)
 ;;=3^Incisional Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,10831,1,4,0)
 ;;=4^K43.2
 ;;^UTILITY(U,$J,358.3,10831,2)
 ;;=^5008609
 ;;^UTILITY(U,$J,358.3,10832,0)
 ;;=K43.3^^37^562^26
 ;;^UTILITY(U,$J,358.3,10832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10832,1,3,0)
 ;;=3^Parastomal Hernia w/ Obs w/o Gangrene
 ;;^UTILITY(U,$J,358.3,10832,1,4,0)
 ;;=4^K43.3
 ;;^UTILITY(U,$J,358.3,10832,2)
 ;;=^5008610
 ;;^UTILITY(U,$J,358.3,10833,0)
 ;;=K43.4^^37^562^25
 ;;^UTILITY(U,$J,358.3,10833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10833,1,3,0)
 ;;=3^Parastomal Hernia w/ Gangrene
 ;;^UTILITY(U,$J,358.3,10833,1,4,0)
 ;;=4^K43.4
 ;;^UTILITY(U,$J,358.3,10833,2)
 ;;=^5008611
 ;;^UTILITY(U,$J,358.3,10834,0)
 ;;=K43.5^^37^562^27
 ;;^UTILITY(U,$J,358.3,10834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10834,1,3,0)
 ;;=3^Parastomal Hernia w/o Obs or Gangrene
 ;;^UTILITY(U,$J,358.3,10834,1,4,0)
 ;;=4^K43.5
 ;;^UTILITY(U,$J,358.3,10834,2)
 ;;=^5008612
 ;;^UTILITY(U,$J,358.3,10835,0)
 ;;=K43.6^^37^562^44
