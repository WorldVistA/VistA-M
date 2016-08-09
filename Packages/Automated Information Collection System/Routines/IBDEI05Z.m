IBDEI05Z ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5779,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5779,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,5779,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,5779,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,5780,0)
 ;;=E10.319^^36^407^14
 ;;^UTILITY(U,$J,358.3,5780,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5780,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,5780,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,5780,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,5781,0)
 ;;=E10.351^^36^407^44
 ;;^UTILITY(U,$J,358.3,5781,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5781,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,5781,1,4,0)
 ;;=4^E10.351
 ;;^UTILITY(U,$J,358.3,5781,2)
 ;;=^5002600
 ;;^UTILITY(U,$J,358.3,5782,0)
 ;;=E10.359^^36^407^45
 ;;^UTILITY(U,$J,358.3,5782,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5782,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diab Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,5782,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,5782,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,5783,0)
 ;;=E10.40^^36^407^25
 ;;^UTILITY(U,$J,358.3,5783,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5783,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,5783,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,5783,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,5784,0)
 ;;=E10.41^^36^407^21
 ;;^UTILITY(U,$J,358.3,5784,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5784,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Mononeuropathy
 ;;^UTILITY(U,$J,358.3,5784,1,4,0)
 ;;=4^E10.41
 ;;^UTILITY(U,$J,358.3,5784,2)
 ;;=^5002605
 ;;^UTILITY(U,$J,358.3,5785,0)
 ;;=E10.42^^36^407^29
 ;;^UTILITY(U,$J,358.3,5785,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5785,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,5785,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,5785,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,5786,0)
 ;;=E10.43^^36^407^17
 ;;^UTILITY(U,$J,358.3,5786,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5786,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,5786,1,4,0)
 ;;=4^E10.43
 ;;^UTILITY(U,$J,358.3,5786,2)
 ;;=^5002607
 ;;^UTILITY(U,$J,358.3,5787,0)
 ;;=E10.44^^36^407^15
 ;;^UTILITY(U,$J,358.3,5787,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5787,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,5787,1,4,0)
 ;;=4^E10.44
 ;;^UTILITY(U,$J,358.3,5787,2)
 ;;=^5002608
 ;;^UTILITY(U,$J,358.3,5788,0)
 ;;=E10.49^^36^407^23
 ;;^UTILITY(U,$J,358.3,5788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5788,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neurological Complications NEC
 ;;^UTILITY(U,$J,358.3,5788,1,4,0)
 ;;=4^E10.49
 ;;^UTILITY(U,$J,358.3,5788,2)
 ;;=^5002609
 ;;^UTILITY(U,$J,358.3,5789,0)
 ;;=E10.59^^36^407^11
 ;;^UTILITY(U,$J,358.3,5789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5789,1,3,0)
 ;;=3^Diabetes Type 1 w/ Circulatory Complications NEC
 ;;^UTILITY(U,$J,358.3,5789,1,4,0)
 ;;=4^E10.59
 ;;^UTILITY(U,$J,358.3,5789,2)
 ;;=^5002612
 ;;^UTILITY(U,$J,358.3,5790,0)
 ;;=E10.610^^36^407^24
 ;;^UTILITY(U,$J,358.3,5790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5790,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,5790,1,4,0)
 ;;=4^E10.610
 ;;^UTILITY(U,$J,358.3,5790,2)
 ;;=^5002613
 ;;^UTILITY(U,$J,358.3,5791,0)
 ;;=E10.618^^36^407^16
 ;;^UTILITY(U,$J,358.3,5791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5791,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Arthropathy NEC
 ;;^UTILITY(U,$J,358.3,5791,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,5791,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,5792,0)
 ;;=E10.620^^36^407^19
 ;;^UTILITY(U,$J,358.3,5792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5792,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Dermatitis
 ;;^UTILITY(U,$J,358.3,5792,1,4,0)
 ;;=4^E10.620
 ;;^UTILITY(U,$J,358.3,5792,2)
 ;;=^5002615
 ;;^UTILITY(U,$J,358.3,5793,0)
 ;;=E10.621^^36^407^32
 ;;^UTILITY(U,$J,358.3,5793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5793,1,3,0)
 ;;=3^Diabetes Type 1 w/ Foot Ulcer
 ;;^UTILITY(U,$J,358.3,5793,1,4,0)
 ;;=4^E10.621
 ;;^UTILITY(U,$J,358.3,5793,2)
 ;;=^5002616
 ;;^UTILITY(U,$J,358.3,5794,0)
 ;;=E10.641^^36^407^34
 ;;^UTILITY(U,$J,358.3,5794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5794,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hypoglycemia w/ Coma
 ;;^UTILITY(U,$J,358.3,5794,1,4,0)
 ;;=4^E10.641
 ;;^UTILITY(U,$J,358.3,5794,2)
 ;;=^5002621
 ;;^UTILITY(U,$J,358.3,5795,0)
 ;;=E10.69^^36^407^50
 ;;^UTILITY(U,$J,358.3,5795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5795,1,3,0)
 ;;=3^Diabetes Type 1 w/ Specified Complications NEC
 ;;^UTILITY(U,$J,358.3,5795,1,4,0)
 ;;=4^E10.69
 ;;^UTILITY(U,$J,358.3,5795,2)
 ;;=^5002624
 ;;^UTILITY(U,$J,358.3,5796,0)
 ;;=E10.8^^36^407^12
 ;;^UTILITY(U,$J,358.3,5796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5796,1,3,0)
 ;;=3^Diabetes Type 1 w/ Complications,Unspec
 ;;^UTILITY(U,$J,358.3,5796,1,4,0)
 ;;=4^E10.8
 ;;^UTILITY(U,$J,358.3,5796,2)
 ;;=^5002625
 ;;^UTILITY(U,$J,358.3,5797,0)
 ;;=E11.00^^36^407^70
 ;;^UTILITY(U,$J,358.3,5797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5797,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperosmolarity w/o NKHHC
 ;;^UTILITY(U,$J,358.3,5797,1,4,0)
 ;;=4^E11.00
 ;;^UTILITY(U,$J,358.3,5797,2)
 ;;=^5002627
 ;;^UTILITY(U,$J,358.3,5798,0)
 ;;=E11.01^^36^407^69
 ;;^UTILITY(U,$J,358.3,5798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5798,1,3,0)
 ;;=3^Diabetes Type 2 w/ Hyperosmolarity w/ Coma
 ;;^UTILITY(U,$J,358.3,5798,1,4,0)
 ;;=4^E11.01
 ;;^UTILITY(U,$J,358.3,5798,2)
 ;;=^5002628
 ;;^UTILITY(U,$J,358.3,5799,0)
 ;;=E11.36^^36^407^53
 ;;^UTILITY(U,$J,358.3,5799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5799,1,3,0)
 ;;=3^Diabetes Type 2 w/  Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,5799,1,4,0)
 ;;=4^E11.36
 ;;^UTILITY(U,$J,358.3,5799,2)
 ;;=^5002642
 ;;^UTILITY(U,$J,358.3,5800,0)
 ;;=E11.39^^36^407^65
 ;;^UTILITY(U,$J,358.3,5800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5800,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Ophthalmic Complication NEC
 ;;^UTILITY(U,$J,358.3,5800,1,4,0)
 ;;=4^E11.39
 ;;^UTILITY(U,$J,358.3,5800,2)
 ;;=^5002643
 ;;^UTILITY(U,$J,358.3,5801,0)
 ;;=E11.41^^36^407^63
 ;;^UTILITY(U,$J,358.3,5801,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5801,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Mononueuropathy
 ;;^UTILITY(U,$J,358.3,5801,1,4,0)
 ;;=4^E11.41
 ;;^UTILITY(U,$J,358.3,5801,2)
 ;;=^5002645
 ;;^UTILITY(U,$J,358.3,5802,0)
 ;;=E11.42^^36^407^66
 ;;^UTILITY(U,$J,358.3,5802,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5802,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,5802,1,4,0)
 ;;=4^E11.42
 ;;^UTILITY(U,$J,358.3,5802,2)
 ;;=^5002646
 ;;^UTILITY(U,$J,358.3,5803,0)
 ;;=E11.43^^36^407^62
 ;;^UTILITY(U,$J,358.3,5803,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5803,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,5803,1,4,0)
 ;;=4^E11.43
 ;;^UTILITY(U,$J,358.3,5803,2)
 ;;=^5002647
 ;;^UTILITY(U,$J,358.3,5804,0)
 ;;=E11.44^^36^407^61
 ;;^UTILITY(U,$J,358.3,5804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5804,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,5804,1,4,0)
 ;;=4^E11.44
 ;;^UTILITY(U,$J,358.3,5804,2)
 ;;=^5002648
 ;;^UTILITY(U,$J,358.3,5805,0)
 ;;=E11.49^^36^407^64
 ;;^UTILITY(U,$J,358.3,5805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5805,1,3,0)
 ;;=3^Diabetes Type 2 w/ Diabetic Neurological Complication NEC
 ;;^UTILITY(U,$J,358.3,5805,1,4,0)
 ;;=4^E11.49
 ;;^UTILITY(U,$J,358.3,5805,2)
 ;;=^5002649
 ;;^UTILITY(U,$J,358.3,5806,0)
 ;;=E10.39^^36^407^26
 ;;^UTILITY(U,$J,358.3,5806,1,0)
 ;;=^358.31IA^4^2
