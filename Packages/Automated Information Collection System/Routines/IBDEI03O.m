IBDEI03O ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,4625,2)
 ;;=Abdominal Pain, Mult Sites^303325
 ;;^UTILITY(U,$J,358.3,4626,0)
 ;;=789.05^^42^320^6
 ;;^UTILITY(U,$J,358.3,4626,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4626,1,4,0)
 ;;=4^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,4626,1,5,0)
 ;;=5^789.05
 ;;^UTILITY(U,$J,358.3,4626,2)
 ;;=Periumbilical Pain^303322
 ;;^UTILITY(U,$J,358.3,4627,0)
 ;;=789.03^^42^320^7
 ;;^UTILITY(U,$J,358.3,4627,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4627,1,4,0)
 ;;=4^RL Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,4627,1,5,0)
 ;;=5^789.03
 ;;^UTILITY(U,$J,358.3,4627,2)
 ;;=RL Quadrant Abdominal Pain^303320
 ;;^UTILITY(U,$J,358.3,4628,0)
 ;;=789.01^^42^320^8
 ;;^UTILITY(U,$J,358.3,4628,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4628,1,4,0)
 ;;=4^RU Quadrant Abdominal Pain
 ;;^UTILITY(U,$J,358.3,4628,1,5,0)
 ;;=5^789.01
 ;;^UTILITY(U,$J,358.3,4628,2)
 ;;=RU Quadrant Abdominal Pain^303318
 ;;^UTILITY(U,$J,358.3,4629,0)
 ;;=789.00^^42^320^9
 ;;^UTILITY(U,$J,358.3,4629,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4629,1,4,0)
 ;;=4^Abdominal Pain, Unspec
 ;;^UTILITY(U,$J,358.3,4629,1,5,0)
 ;;=5^789.00
 ;;^UTILITY(U,$J,358.3,4629,2)
 ;;=Abdominal Pain, Unspec^303317
 ;;^UTILITY(U,$J,358.3,4630,0)
 ;;=V67.09^^42^321^1
 ;;^UTILITY(U,$J,358.3,4630,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4630,1,4,0)
 ;;=4^F/U Exam, Completed Treatment
 ;;^UTILITY(U,$J,358.3,4630,1,5,0)
 ;;=5^V67.09
 ;;^UTILITY(U,$J,358.3,4630,2)
 ;;=F/U exam, completed treatment^322080
 ;;^UTILITY(U,$J,358.3,4631,0)
 ;;=V58.42^^42^321^5
 ;;^UTILITY(U,$J,358.3,4631,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4631,1,4,0)
 ;;=4^Aftercare After Ca Surgery
 ;;^UTILITY(U,$J,358.3,4631,1,5,0)
 ;;=5^V58.42
 ;;^UTILITY(U,$J,358.3,4631,2)
 ;;=Aftercare after CA surgery^295530
 ;;^UTILITY(U,$J,358.3,4632,0)
 ;;=V58.73^^42^321^6
 ;;^UTILITY(U,$J,358.3,4632,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4632,1,4,0)
 ;;=4^Aftercare After Vasc Surg
 ;;^UTILITY(U,$J,358.3,4632,1,5,0)
 ;;=5^V58.73
 ;;^UTILITY(U,$J,358.3,4632,2)
 ;;=Aftercare after Vasc Surg^295530
 ;;^UTILITY(U,$J,358.3,4633,0)
 ;;=V58.74^^42^321^7
 ;;^UTILITY(U,$J,358.3,4633,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4633,1,4,0)
 ;;=4^Aftercare After Lung Surg
 ;;^UTILITY(U,$J,358.3,4633,1,5,0)
 ;;=5^V58.74
 ;;^UTILITY(U,$J,358.3,4633,2)
 ;;=Aftercare after Lung Surg^295530
 ;;^UTILITY(U,$J,358.3,4634,0)
 ;;=V58.77^^42^321^8
 ;;^UTILITY(U,$J,358.3,4634,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4634,1,4,0)
 ;;=4^Aftercare After Skin Surg
 ;;^UTILITY(U,$J,358.3,4634,1,5,0)
 ;;=5^V58.77
 ;;^UTILITY(U,$J,358.3,4634,2)
 ;;=Aftercare after Skin Surg^295530
 ;;^UTILITY(U,$J,358.3,4635,0)
 ;;=V58.75^^42^321^9
 ;;^UTILITY(U,$J,358.3,4635,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4635,1,4,0)
 ;;=4^Aftercare After Gi Surgery
 ;;^UTILITY(U,$J,358.3,4635,1,5,0)
 ;;=5^V58.75
 ;;^UTILITY(U,$J,358.3,4635,2)
 ;;=Aftercare after GI Surgery^295530
 ;;^UTILITY(U,$J,358.3,4636,0)
 ;;=V58.31^^42^321^2
 ;;^UTILITY(U,$J,358.3,4636,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4636,1,4,0)
 ;;=4^Attn Rem Surg Dressing
 ;;^UTILITY(U,$J,358.3,4636,1,5,0)
 ;;=5^V58.31
 ;;^UTILITY(U,$J,358.3,4636,2)
 ;;=^334216
 ;;^UTILITY(U,$J,358.3,4637,0)
 ;;=V58.32^^42^321^3
 ;;^UTILITY(U,$J,358.3,4637,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4637,1,4,0)
 ;;=4^Attn Removal Of Sutures
 ;;^UTILITY(U,$J,358.3,4637,1,5,0)
 ;;=5^V58.32
 ;;^UTILITY(U,$J,358.3,4637,2)
 ;;=^334217
 ;;^UTILITY(U,$J,358.3,4638,0)
 ;;=611.0^^42^322^23
 ;;^UTILITY(U,$J,358.3,4638,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4638,1,4,0)
 ;;=4^Mastitis
 ;;^UTILITY(U,$J,358.3,4638,1,5,0)
 ;;=5^611.0
 ;;^UTILITY(U,$J,358.3,4638,2)
 ;;=^74429
 ;;^UTILITY(U,$J,358.3,4639,0)
 ;;=611.71^^42^322^24
 ;;^UTILITY(U,$J,358.3,4639,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4639,1,4,0)
 ;;=4^Mastodynia
 ;;^UTILITY(U,$J,358.3,4639,1,5,0)
 ;;=5^611.71
 ;;^UTILITY(U,$J,358.3,4639,2)
 ;;=^74467
 ;;^UTILITY(U,$J,358.3,4640,0)
 ;;=626.8^^42^322^25
 ;;^UTILITY(U,$J,358.3,4640,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4640,1,4,0)
 ;;=4^Menstrual Disorder
 ;;^UTILITY(U,$J,358.3,4640,1,5,0)
 ;;=5^626.8
 ;;^UTILITY(U,$J,358.3,4640,2)
 ;;=^87521
 ;;^UTILITY(U,$J,358.3,4641,0)
 ;;=611.79^^42^322^26
 ;;^UTILITY(U,$J,358.3,4641,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4641,1,4,0)
 ;;=4^Nipple Discharge
 ;;^UTILITY(U,$J,358.3,4641,1,5,0)
 ;;=5^611.79
 ;;^UTILITY(U,$J,358.3,4641,2)
 ;;=^270462
 ;;^UTILITY(U,$J,358.3,4642,0)
 ;;=627.1^^42^322^27
 ;;^UTILITY(U,$J,358.3,4642,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4642,1,4,0)
 ;;=4^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,4642,1,5,0)
 ;;=5^627.1
 ;;^UTILITY(U,$J,358.3,4642,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,4643,0)
 ;;=218.9^^42^322^29
 ;;^UTILITY(U,$J,358.3,4643,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4643,1,4,0)
 ;;=4^Uterine Leiomyoma
 ;;^UTILITY(U,$J,358.3,4643,1,5,0)
 ;;=5^218.9
 ;;^UTILITY(U,$J,358.3,4643,2)
 ;;=^68944
 ;;^UTILITY(U,$J,358.3,4644,0)
 ;;=616.10^^42^322^30
 ;;^UTILITY(U,$J,358.3,4644,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4644,1,4,0)
 ;;=4^Vaginitis
 ;;^UTILITY(U,$J,358.3,4644,1,5,0)
 ;;=5^616.10
 ;;^UTILITY(U,$J,358.3,4644,2)
 ;;=^125233
 ;;^UTILITY(U,$J,358.3,4645,0)
 ;;=626.2^^42^322^18
 ;;^UTILITY(U,$J,358.3,4645,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4645,1,4,0)
 ;;=4^Excessive Menstruation
 ;;^UTILITY(U,$J,358.3,4645,1,5,0)
 ;;=5^626.2
 ;;^UTILITY(U,$J,358.3,4645,2)
 ;;=^75895
 ;;^UTILITY(U,$J,358.3,4646,0)
 ;;=V76.19^^42^322^28
 ;;^UTILITY(U,$J,358.3,4646,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4646,1,4,0)
 ;;=4^Screen Breast Exam
 ;;^UTILITY(U,$J,358.3,4646,1,5,0)
 ;;=5^V76.19
 ;;^UTILITY(U,$J,358.3,4646,2)
 ;;=^295652
 ;;^UTILITY(U,$J,358.3,4647,0)
 ;;=174.9^^42^322^4
 ;;^UTILITY(U,$J,358.3,4647,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4647,1,4,0)
 ;;=4^Cancer, Breast, Femal
 ;;^UTILITY(U,$J,358.3,4647,1,5,0)
 ;;=5^174.9
 ;;^UTILITY(U,$J,358.3,4647,2)
 ;;=Cancer, Breast, Femal^267202
 ;;^UTILITY(U,$J,358.3,4648,0)
 ;;=174.0^^42^322^8
 ;;^UTILITY(U,$J,358.3,4648,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4648,1,4,0)
 ;;=4^Cancer, Nipple, Female
 ;;^UTILITY(U,$J,358.3,4648,1,5,0)
 ;;=5^174.0
 ;;^UTILITY(U,$J,358.3,4648,2)
 ;;=Cancer, Nipple, Female^73528
 ;;^UTILITY(U,$J,358.3,4649,0)
 ;;=174.6^^42^322^3
 ;;^UTILITY(U,$J,358.3,4649,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4649,1,4,0)
 ;;=4^Cancer Of Breast Axillary
 ;;^UTILITY(U,$J,358.3,4649,1,5,0)
 ;;=5^174.6
 ;;^UTILITY(U,$J,358.3,4649,2)
 ;;=Cancer of Breast Axillary^267200
 ;;^UTILITY(U,$J,358.3,4650,0)
 ;;=174.1^^42^322^5
 ;;^UTILITY(U,$J,358.3,4650,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4650,1,4,0)
 ;;=4^Cancer, Central Breast
 ;;^UTILITY(U,$J,358.3,4650,1,5,0)
 ;;=5^174.1
 ;;^UTILITY(U,$J,358.3,4650,2)
 ;;=Cancer, Central Breast^267195
 ;;^UTILITY(U,$J,358.3,4651,0)
 ;;=174.3^^42^322^6
 ;;^UTILITY(U,$J,358.3,4651,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4651,1,4,0)
 ;;=4^Cancer, Lower Inner Breast
 ;;^UTILITY(U,$J,358.3,4651,1,5,0)
 ;;=5^174.3
 ;;^UTILITY(U,$J,358.3,4651,2)
 ;;=Cancer, Lower Inner Breast^267197
 ;;^UTILITY(U,$J,358.3,4652,0)
 ;;=174.5^^42^322^7
 ;;^UTILITY(U,$J,358.3,4652,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4652,1,4,0)
 ;;=4^Cancer, Lower Outer Breast
 ;;^UTILITY(U,$J,358.3,4652,1,5,0)
 ;;=5^174.5
 ;;^UTILITY(U,$J,358.3,4652,2)
 ;;=Cancer, Lower outer Breast^267199
 ;;^UTILITY(U,$J,358.3,4653,0)
 ;;=174.8^^42^322^9
 ;;^UTILITY(U,$J,358.3,4653,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4653,1,4,0)
 ;;=4^Cancer, Other Breast
 ;;^UTILITY(U,$J,358.3,4653,1,5,0)
 ;;=5^174.8
 ;;^UTILITY(U,$J,358.3,4653,2)
 ;;=Cancer, Other Breast^267201
 ;;^UTILITY(U,$J,358.3,4654,0)
 ;;=174.2^^42^322^11
 ;;^UTILITY(U,$J,358.3,4654,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4654,1,4,0)
 ;;=4^Cancer, Upper Inner Breast
 ;;^UTILITY(U,$J,358.3,4654,1,5,0)
 ;;=5^174.2
 ;;^UTILITY(U,$J,358.3,4654,2)
 ;;=Cancer, Upper Inner Breast^267196
 ;;^UTILITY(U,$J,358.3,4655,0)
 ;;=174.4^^42^322^12
 ;;^UTILITY(U,$J,358.3,4655,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4655,1,4,0)
 ;;=4^Cancer, Upper Outer Breast
 ;;^UTILITY(U,$J,358.3,4655,1,5,0)
 ;;=5^174.4
 ;;^UTILITY(U,$J,358.3,4655,2)
 ;;=Cancer, Upper Outer Breast^267198
 ;;^UTILITY(U,$J,358.3,4656,0)
 ;;=610.0^^42^322^13
 ;;^UTILITY(U,$J,358.3,4656,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4656,1,4,0)
 ;;=4^Cyst,Breast
 ;;^UTILITY(U,$J,358.3,4656,1,5,0)
 ;;=5^610.0
 ;;^UTILITY(U,$J,358.3,4656,2)
 ;;=^112247
 ;;^UTILITY(U,$J,358.3,4657,0)
 ;;=625.3^^42^322^15
 ;;^UTILITY(U,$J,358.3,4657,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4657,1,4,0)
 ;;=4^Dysmenorrhea
 ;;^UTILITY(U,$J,358.3,4657,1,5,0)
 ;;=5^625.3
 ;;^UTILITY(U,$J,358.3,4657,2)
 ;;=^37592
 ;;^UTILITY(U,$J,358.3,4658,0)
 ;;=610.1^^42^322^19
 ;;^UTILITY(U,$J,358.3,4658,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4658,1,4,0)
 ;;=4^Fibrocystic Disease
 ;;^UTILITY(U,$J,358.3,4658,1,5,0)
 ;;=5^610.1
 ;;^UTILITY(U,$J,358.3,4658,2)
 ;;=^46167
 ;;^UTILITY(U,$J,358.3,4659,0)
 ;;=217.^^42^322^2
 ;;^UTILITY(U,$J,358.3,4659,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4659,1,4,0)
 ;;=4^Benign Neoplasm Breast
 ;;^UTILITY(U,$J,358.3,4659,1,5,0)
 ;;=5^217.
 ;;^UTILITY(U,$J,358.3,4659,2)
 ;;=^267638
 ;;^UTILITY(U,$J,358.3,4660,0)
 ;;=617.9^^42^322^16
 ;;^UTILITY(U,$J,358.3,4660,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4660,1,4,0)
 ;;=4^Endometriosis
 ;;^UTILITY(U,$J,358.3,4660,1,5,0)
 ;;=5^617.9
 ;;^UTILITY(U,$J,358.3,4660,2)
 ;;=^40463
 ;;^UTILITY(U,$J,358.3,4661,0)
 ;;=618.6^^42^322^17
 ;;^UTILITY(U,$J,358.3,4661,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,4661,1,4,0)
 ;;=4^Enterocele,Vaginal
 ;;^UTILITY(U,$J,358.3,4661,1,5,0)
 ;;=5^618.6
 ;;^UTILITY(U,$J,358.3,4661,2)
 ;;=^56796
 ;;^UTILITY(U,$J,358.3,4662,0)
 ;;=625.6^^42^322^21
 ;;^UTILITY(U,$J,358.3,4662,1,0)
 ;;=^358.31IA^5^2
