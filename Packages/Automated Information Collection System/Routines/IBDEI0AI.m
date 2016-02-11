IBDEI0AI ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4391,0)
 ;;=F06.8^^30^273^4
 ;;^UTILITY(U,$J,358.3,4391,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4391,1,3,0)
 ;;=3^Mental Disorders d/t Physiological Condition
 ;;^UTILITY(U,$J,358.3,4391,1,4,0)
 ;;=4^F06.8
 ;;^UTILITY(U,$J,358.3,4391,2)
 ;;=^5003062
 ;;^UTILITY(U,$J,358.3,4392,0)
 ;;=F06.0^^30^273^7
 ;;^UTILITY(U,$J,358.3,4392,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4392,1,3,0)
 ;;=3^Psychotic Disorder w/ Hallucinations d/t Physiol Condition
 ;;^UTILITY(U,$J,358.3,4392,1,4,0)
 ;;=4^F06.0
 ;;^UTILITY(U,$J,358.3,4392,2)
 ;;=^5003053
 ;;^UTILITY(U,$J,358.3,4393,0)
 ;;=E05.90^^30^274^14
 ;;^UTILITY(U,$J,358.3,4393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4393,1,3,0)
 ;;=3^Thyrotoxicosis,Unspec
 ;;^UTILITY(U,$J,358.3,4393,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,4393,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,4394,0)
 ;;=E03.9^^30^274^9
 ;;^UTILITY(U,$J,358.3,4394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4394,1,3,0)
 ;;=3^Hypothyroidism,Unspec
 ;;^UTILITY(U,$J,358.3,4394,1,4,0)
 ;;=4^E03.9
 ;;^UTILITY(U,$J,358.3,4394,2)
 ;;=^5002476
 ;;^UTILITY(U,$J,358.3,4395,0)
 ;;=E11.9^^30^274^6
 ;;^UTILITY(U,$J,358.3,4395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4395,1,3,0)
 ;;=3^Diabetes Type 2 w/o Complications
 ;;^UTILITY(U,$J,358.3,4395,1,4,0)
 ;;=4^E11.9
 ;;^UTILITY(U,$J,358.3,4395,2)
 ;;=^5002666
 ;;^UTILITY(U,$J,358.3,4396,0)
 ;;=E10.9^^30^274^1
 ;;^UTILITY(U,$J,358.3,4396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4396,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,4396,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,4396,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,4397,0)
 ;;=E11.65^^30^274^4
 ;;^UTILITY(U,$J,358.3,4397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4397,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,4397,1,4,0)
 ;;=4^E11.65
 ;;^UTILITY(U,$J,358.3,4397,2)
 ;;=^5002663
 ;;^UTILITY(U,$J,358.3,4398,0)
 ;;=E11.29^^30^274^2
 ;;^UTILITY(U,$J,358.3,4398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4398,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,4398,1,4,0)
 ;;=4^E11.29
 ;;^UTILITY(U,$J,358.3,4398,2)
 ;;=^5002631
 ;;^UTILITY(U,$J,358.3,4399,0)
 ;;=E11.40^^30^274^3
 ;;^UTILITY(U,$J,358.3,4399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4399,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neuropathy
 ;;^UTILITY(U,$J,358.3,4399,1,4,0)
 ;;=4^E11.40
 ;;^UTILITY(U,$J,358.3,4399,2)
 ;;=^5002644
 ;;^UTILITY(U,$J,358.3,4400,0)
 ;;=E11.8^^30^274^5
 ;;^UTILITY(U,$J,358.3,4400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4400,1,3,0)
 ;;=3^Diabetes Type 2 w/ Unspec Complications
 ;;^UTILITY(U,$J,358.3,4400,1,4,0)
 ;;=4^E11.8
 ;;^UTILITY(U,$J,358.3,4400,2)
 ;;=^5002665
 ;;^UTILITY(U,$J,358.3,4401,0)
 ;;=E78.0^^30^274^13
 ;;^UTILITY(U,$J,358.3,4401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4401,1,3,0)
 ;;=3^Pure Hypercholesterolemia
 ;;^UTILITY(U,$J,358.3,4401,1,4,0)
 ;;=4^E78.0
 ;;^UTILITY(U,$J,358.3,4401,2)
 ;;=^5002966
 ;;^UTILITY(U,$J,358.3,4402,0)
 ;;=E78.2^^30^274^12
 ;;^UTILITY(U,$J,358.3,4402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4402,1,3,0)
 ;;=3^Mixed Hyperlipidemia
 ;;^UTILITY(U,$J,358.3,4402,1,4,0)
 ;;=4^E78.2
 ;;^UTILITY(U,$J,358.3,4402,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,4403,0)
 ;;=E78.5^^30^274^8
 ;;^UTILITY(U,$J,358.3,4403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,4403,1,3,0)
 ;;=3^Hyperlipidemia,Unspec
 ;;^UTILITY(U,$J,358.3,4403,1,4,0)
 ;;=4^E78.5
 ;;^UTILITY(U,$J,358.3,4403,2)
 ;;=^5002969
 ;;^UTILITY(U,$J,358.3,4404,0)
 ;;=M10.9^^30^274^7
 ;;^UTILITY(U,$J,358.3,4404,1,0)
 ;;=^358.31IA^4^2
