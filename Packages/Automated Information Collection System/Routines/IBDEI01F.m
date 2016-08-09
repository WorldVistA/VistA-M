IBDEI01F ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,898,2)
 ;;=^5063245
 ;;^UTILITY(U,$J,358.3,899,0)
 ;;=E10.9^^6^71^35
 ;;^UTILITY(U,$J,358.3,899,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,899,1,3,0)
 ;;=3^Diabetes Type 1 w/o Complications
 ;;^UTILITY(U,$J,358.3,899,1,4,0)
 ;;=4^E10.9
 ;;^UTILITY(U,$J,358.3,899,2)
 ;;=^5002626
 ;;^UTILITY(U,$J,358.3,900,0)
 ;;=E10.65^^6^71^15
 ;;^UTILITY(U,$J,358.3,900,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,900,1,3,0)
 ;;=3^Diabetes Type 1 w/ Hyperglycemia
 ;;^UTILITY(U,$J,358.3,900,1,4,0)
 ;;=4^E10.65
 ;;^UTILITY(U,$J,358.3,900,2)
 ;;=^5002623
 ;;^UTILITY(U,$J,358.3,901,0)
 ;;=E10.21^^6^71^7
 ;;^UTILITY(U,$J,358.3,901,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,901,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Nephropathy
 ;;^UTILITY(U,$J,358.3,901,1,4,0)
 ;;=4^E10.21
 ;;^UTILITY(U,$J,358.3,901,2)
 ;;=^5002589
 ;;^UTILITY(U,$J,358.3,902,0)
 ;;=E10.22^^6^71^4
 ;;^UTILITY(U,$J,358.3,902,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,902,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Chr Kidney Disease
 ;;^UTILITY(U,$J,358.3,902,1,4,0)
 ;;=4^E10.22
 ;;^UTILITY(U,$J,358.3,902,2)
 ;;=^5002590
 ;;^UTILITY(U,$J,358.3,903,0)
 ;;=E10.29^^6^71^23
 ;;^UTILITY(U,$J,358.3,903,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,903,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Diabetic Kidney Complication
 ;;^UTILITY(U,$J,358.3,903,1,4,0)
 ;;=4^E10.29
 ;;^UTILITY(U,$J,358.3,903,2)
 ;;=^5002591
 ;;^UTILITY(U,$J,358.3,904,0)
 ;;=E10.311^^6^71^12
 ;;^UTILITY(U,$J,358.3,904,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,904,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,904,1,4,0)
 ;;=4^E10.311
 ;;^UTILITY(U,$J,358.3,904,2)
 ;;=^5002592
 ;;^UTILITY(U,$J,358.3,905,0)
 ;;=E10.319^^6^71^13
 ;;^UTILITY(U,$J,358.3,905,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,905,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Retinopathy w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,905,1,4,0)
 ;;=4^E10.319
 ;;^UTILITY(U,$J,358.3,905,2)
 ;;=^5002593
 ;;^UTILITY(U,$J,358.3,906,0)
 ;;=E10.321^^6^71^16
 ;;^UTILITY(U,$J,358.3,906,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,906,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,906,1,4,0)
 ;;=4^E10.321
 ;;^UTILITY(U,$J,358.3,906,2)
 ;;=^5002594
 ;;^UTILITY(U,$J,358.3,907,0)
 ;;=E10.329^^6^71^17
 ;;^UTILITY(U,$J,358.3,907,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,907,1,3,0)
 ;;=3^Diabetes Type 1 w/ Mild Nonprlf Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,907,1,4,0)
 ;;=4^E10.329
 ;;^UTILITY(U,$J,358.3,907,2)
 ;;=^5002595
 ;;^UTILITY(U,$J,358.3,908,0)
 ;;=E10.331^^6^71^18
 ;;^UTILITY(U,$J,358.3,908,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,908,1,3,0)
 ;;=3^Diabetes Type 1 w/ Moderate Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,908,1,4,0)
 ;;=4^E10.331
 ;;^UTILITY(U,$J,358.3,908,2)
 ;;=^5002596
 ;;^UTILITY(U,$J,358.3,909,0)
 ;;=E10.339^^6^71^19
 ;;^UTILITY(U,$J,358.3,909,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,909,1,3,0)
 ;;=3^Diabetes Type 1 w/ Moderate Nonprlf Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,909,1,4,0)
 ;;=4^E10.339
 ;;^UTILITY(U,$J,358.3,909,2)
 ;;=^5002597
 ;;^UTILITY(U,$J,358.3,910,0)
 ;;=E10.341^^6^71^32
 ;;^UTILITY(U,$J,358.3,910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,910,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,910,1,4,0)
 ;;=4^E10.341
 ;;^UTILITY(U,$J,358.3,910,2)
 ;;=^5002598
 ;;^UTILITY(U,$J,358.3,911,0)
 ;;=E10.349^^6^71^33
 ;;^UTILITY(U,$J,358.3,911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,911,1,3,0)
 ;;=3^Diabetes Type 1 w/ Severe Nonprlf Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,911,1,4,0)
 ;;=4^E10.349
 ;;^UTILITY(U,$J,358.3,911,2)
 ;;=^5002599
 ;;^UTILITY(U,$J,358.3,912,0)
 ;;=E10.351^^6^71^30
 ;;^UTILITY(U,$J,358.3,912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,912,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diabetic Rtnop w/ Macular Edema
 ;;^UTILITY(U,$J,358.3,912,1,4,0)
 ;;=4^E10.351
 ;;^UTILITY(U,$J,358.3,912,2)
 ;;=^5002600
 ;;^UTILITY(U,$J,358.3,913,0)
 ;;=E10.359^^6^71^31
 ;;^UTILITY(U,$J,358.3,913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,913,1,3,0)
 ;;=3^Diabetes Type 1 w/ Prolif Diabetic Rtnop w/o Macular Edema
 ;;^UTILITY(U,$J,358.3,913,1,4,0)
 ;;=4^E10.359
 ;;^UTILITY(U,$J,358.3,913,2)
 ;;=^5002601
 ;;^UTILITY(U,$J,358.3,914,0)
 ;;=E10.36^^6^71^3
 ;;^UTILITY(U,$J,358.3,914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,914,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Cataract
 ;;^UTILITY(U,$J,358.3,914,1,4,0)
 ;;=4^E10.36
 ;;^UTILITY(U,$J,358.3,914,2)
 ;;=^5002602
 ;;^UTILITY(U,$J,358.3,915,0)
 ;;=E10.39^^6^71^25
 ;;^UTILITY(U,$J,358.3,915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,915,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Diabetic Ophthalmic Complications
 ;;^UTILITY(U,$J,358.3,915,1,4,0)
 ;;=4^E10.39
 ;;^UTILITY(U,$J,358.3,915,2)
 ;;=^5002603
 ;;^UTILITY(U,$J,358.3,916,0)
 ;;=E10.40^^6^71^9
 ;;^UTILITY(U,$J,358.3,916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,916,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathy,Unspec
 ;;^UTILITY(U,$J,358.3,916,1,4,0)
 ;;=4^E10.40
 ;;^UTILITY(U,$J,358.3,916,2)
 ;;=^5002604
 ;;^UTILITY(U,$J,358.3,917,0)
 ;;=E10.41^^6^71^6
 ;;^UTILITY(U,$J,358.3,917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,917,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Mononeuropathy
 ;;^UTILITY(U,$J,358.3,917,1,4,0)
 ;;=4^E10.41
 ;;^UTILITY(U,$J,358.3,917,2)
 ;;=^5002605
 ;;^UTILITY(U,$J,358.3,918,0)
 ;;=E10.42^^6^71^11
 ;;^UTILITY(U,$J,358.3,918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,918,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,918,1,4,0)
 ;;=4^E10.42
 ;;^UTILITY(U,$J,358.3,918,2)
 ;;=^5002606
 ;;^UTILITY(U,$J,358.3,919,0)
 ;;=E10.43^^6^71^2
 ;;^UTILITY(U,$J,358.3,919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,919,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Autonomic Polyneuropathy
 ;;^UTILITY(U,$J,358.3,919,1,4,0)
 ;;=4^E10.43
 ;;^UTILITY(U,$J,358.3,919,2)
 ;;=^5002607
 ;;^UTILITY(U,$J,358.3,920,0)
 ;;=E10.44^^6^71^1
 ;;^UTILITY(U,$J,358.3,920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,920,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Amyotrophy
 ;;^UTILITY(U,$J,358.3,920,1,4,0)
 ;;=4^E10.44
 ;;^UTILITY(U,$J,358.3,920,2)
 ;;=^5002608
 ;;^UTILITY(U,$J,358.3,921,0)
 ;;=E10.49^^6^71^24
 ;;^UTILITY(U,$J,358.3,921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,921,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Diabetic Neurological Complication
 ;;^UTILITY(U,$J,358.3,921,1,4,0)
 ;;=4^E10.49
 ;;^UTILITY(U,$J,358.3,921,2)
 ;;=^5002609
 ;;^UTILITY(U,$J,358.3,922,0)
 ;;=E10.51^^6^71^10
 ;;^UTILITY(U,$J,358.3,922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,922,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Peripheral Angiopathy w/o Gangrene
 ;;^UTILITY(U,$J,358.3,922,1,4,0)
 ;;=4^E10.51
 ;;^UTILITY(U,$J,358.3,922,2)
 ;;=^5002610
 ;;^UTILITY(U,$J,358.3,923,0)
 ;;=E10.59^^6^71^21
 ;;^UTILITY(U,$J,358.3,923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,923,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Circulatory Complications
 ;;^UTILITY(U,$J,358.3,923,1,4,0)
 ;;=4^E10.59
 ;;^UTILITY(U,$J,358.3,923,2)
 ;;=^5002612
 ;;^UTILITY(U,$J,358.3,924,0)
 ;;=E10.610^^6^71^8
 ;;^UTILITY(U,$J,358.3,924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,924,1,3,0)
 ;;=3^Diabetes Type 1 w/ Diabetic Neuropathic Arthropathy
 ;;^UTILITY(U,$J,358.3,924,1,4,0)
 ;;=4^E10.610
 ;;^UTILITY(U,$J,358.3,924,2)
 ;;=^5002613
 ;;^UTILITY(U,$J,358.3,925,0)
 ;;=E10.618^^6^71^22
 ;;^UTILITY(U,$J,358.3,925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,925,1,3,0)
 ;;=3^Diabetes Type 1 w/ Other Diabetic Arthropathy
 ;;^UTILITY(U,$J,358.3,925,1,4,0)
 ;;=4^E10.618
 ;;^UTILITY(U,$J,358.3,925,2)
 ;;=^5002614
 ;;^UTILITY(U,$J,358.3,926,0)
 ;;=E10.620^^6^71^5
