IBDEI0CE ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5354,1,4,0)
 ;;=4^I70.362
 ;;^UTILITY(U,$J,358.3,5354,2)
 ;;=^5007642
 ;;^UTILITY(U,$J,358.3,5355,0)
 ;;=I70.363^^40^365^13
 ;;^UTILITY(U,$J,358.3,5355,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5355,1,3,0)
 ;;=3^Athscl of Unspec Bypass,Bilateral Legs w/ Gangrene
 ;;^UTILITY(U,$J,358.3,5355,1,4,0)
 ;;=4^I70.363
 ;;^UTILITY(U,$J,358.3,5355,2)
 ;;=^5007643
 ;;^UTILITY(U,$J,358.3,5356,0)
 ;;=E10.52^^40^365^16
 ;;^UTILITY(U,$J,358.3,5356,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5356,1,3,0)
 ;;=3^DM Type 1 w/ Diabetic Prph Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,5356,1,4,0)
 ;;=4^E10.52
 ;;^UTILITY(U,$J,358.3,5356,2)
 ;;=^5002611
 ;;^UTILITY(U,$J,358.3,5357,0)
 ;;=E11.52^^40^365^17
 ;;^UTILITY(U,$J,358.3,5357,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5357,1,3,0)
 ;;=3^DM Type 2 w/ Diabetic Prph Angiopathy w/ Gangrene
 ;;^UTILITY(U,$J,358.3,5357,1,4,0)
 ;;=4^E11.52
 ;;^UTILITY(U,$J,358.3,5357,2)
 ;;=^5002651
 ;;^UTILITY(U,$J,358.3,5358,0)
 ;;=R13.19^^40^366^33
 ;;^UTILITY(U,$J,358.3,5358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5358,1,3,0)
 ;;=3^Dysphagia NEC
 ;;^UTILITY(U,$J,358.3,5358,1,4,0)
 ;;=4^R13.19
 ;;^UTILITY(U,$J,358.3,5358,2)
 ;;=^335280
 ;;^UTILITY(U,$J,358.3,5359,0)
 ;;=R15.9^^40^366^40
 ;;^UTILITY(U,$J,358.3,5359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5359,1,3,0)
 ;;=3^Full Incontinence of Feces
 ;;^UTILITY(U,$J,358.3,5359,1,4,0)
 ;;=4^R15.9
 ;;^UTILITY(U,$J,358.3,5359,2)
 ;;=^5019247
 ;;^UTILITY(U,$J,358.3,5360,0)
 ;;=D50.0^^40^366^51
 ;;^UTILITY(U,$J,358.3,5360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5360,1,3,0)
 ;;=3^Iron Deficiency Anemia d/t Blood Loss
 ;;^UTILITY(U,$J,358.3,5360,1,4,0)
 ;;=4^D50.0
 ;;^UTILITY(U,$J,358.3,5360,2)
 ;;=^267971
 ;;^UTILITY(U,$J,358.3,5361,0)
 ;;=D50.9^^40^366^52
 ;;^UTILITY(U,$J,358.3,5361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5361,1,3,0)
 ;;=3^Iron Deficiency Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,5361,1,4,0)
 ;;=4^D50.9
 ;;^UTILITY(U,$J,358.3,5361,2)
 ;;=^5002283
 ;;^UTILITY(U,$J,358.3,5362,0)
 ;;=D62.^^40^366^5
 ;;^UTILITY(U,$J,358.3,5362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5362,1,3,0)
 ;;=3^Acute Posthemorrhagic Anemia
 ;;^UTILITY(U,$J,358.3,5362,1,4,0)
 ;;=4^D62.
 ;;^UTILITY(U,$J,358.3,5362,2)
 ;;=^267986
 ;;^UTILITY(U,$J,358.3,5363,0)
 ;;=D64.9^^40^366^11
 ;;^UTILITY(U,$J,358.3,5363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5363,1,3,0)
 ;;=3^Anemia,Unspec
 ;;^UTILITY(U,$J,358.3,5363,1,4,0)
 ;;=4^D64.9
 ;;^UTILITY(U,$J,358.3,5363,2)
 ;;=^5002351
 ;;^UTILITY(U,$J,358.3,5364,0)
 ;;=E10.9^^40^366^27
 ;;^UTILITY(U,$J,358.3,5364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5364,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,5364,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,5364,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,5365,0)
 ;;=E11.9^^40^366^28
 ;;^UTILITY(U,$J,358.3,5365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5365,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,5365,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,5365,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,5366,0)
 ;;=E13.9^^40^366^29
 ;;^UTILITY(U,$J,358.3,5366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5366,1,3,0)
 ;;=3^Diabetes w/o Complications NEC
 ;;^UTILITY(U,$J,358.3,5366,1,4,0)
 ;;=4^E13.9
 ;;^UTILITY(U,$J,358.3,5366,2)
 ;;=^5002704
 ;;^UTILITY(U,$J,358.3,5367,0)
 ;;=F03.90^^40^366^26
 ;;^UTILITY(U,$J,358.3,5367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5367,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,5367,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,5367,2)
 ;;=^5003050
