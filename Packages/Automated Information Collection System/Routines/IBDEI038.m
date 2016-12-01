IBDEI038 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3803,1,3,0)
 ;;=3^Secondary Dysmenorrhea
 ;;^UTILITY(U,$J,358.3,3803,1,4,0)
 ;;=4^N94.5
 ;;^UTILITY(U,$J,358.3,3803,2)
 ;;=^5015921
 ;;^UTILITY(U,$J,358.3,3804,0)
 ;;=N94.6^^20^266^5
 ;;^UTILITY(U,$J,358.3,3804,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3804,1,3,0)
 ;;=3^Dysmenorrhea,Unspec
 ;;^UTILITY(U,$J,358.3,3804,1,4,0)
 ;;=4^N94.6
 ;;^UTILITY(U,$J,358.3,3804,2)
 ;;=^5015922
 ;;^UTILITY(U,$J,358.3,3805,0)
 ;;=N95.0^^20^266^16
 ;;^UTILITY(U,$J,358.3,3805,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3805,1,3,0)
 ;;=3^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,3805,1,4,0)
 ;;=4^N95.0
 ;;^UTILITY(U,$J,358.3,3805,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,3806,0)
 ;;=R87.619^^20^266^1
 ;;^UTILITY(U,$J,358.3,3806,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3806,1,3,0)
 ;;=3^Abnormal Cytology Findings in Cervix Uteri Specimen,Unspec
 ;;^UTILITY(U,$J,358.3,3806,1,4,0)
 ;;=4^R87.619
 ;;^UTILITY(U,$J,358.3,3806,2)
 ;;=^5019676
 ;;^UTILITY(U,$J,358.3,3807,0)
 ;;=Z12.39^^20^266^18
 ;;^UTILITY(U,$J,358.3,3807,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3807,1,3,0)
 ;;=3^Screening for Malig Neop of Breast
 ;;^UTILITY(U,$J,358.3,3807,1,4,0)
 ;;=4^Z12.39
 ;;^UTILITY(U,$J,358.3,3807,2)
 ;;=^5062686
 ;;^UTILITY(U,$J,358.3,3808,0)
 ;;=C53.9^^20^266^13
 ;;^UTILITY(U,$J,358.3,3808,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3808,1,3,0)
 ;;=3^Malig Neop Cervix Uteri
 ;;^UTILITY(U,$J,358.3,3808,1,4,0)
 ;;=4^C53.9
 ;;^UTILITY(U,$J,358.3,3808,2)
 ;;=^5001204
 ;;^UTILITY(U,$J,358.3,3809,0)
 ;;=C56.9^^20^266^14
 ;;^UTILITY(U,$J,358.3,3809,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3809,1,3,0)
 ;;=3^Malig Neop Ovary,Unspec
 ;;^UTILITY(U,$J,358.3,3809,1,4,0)
 ;;=4^C56.9
 ;;^UTILITY(U,$J,358.3,3809,2)
 ;;=^5001214
 ;;^UTILITY(U,$J,358.3,3810,0)
 ;;=K64.8^^20^267^6
 ;;^UTILITY(U,$J,358.3,3810,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3810,1,3,0)
 ;;=3^Hemorrhoids,Internal
 ;;^UTILITY(U,$J,358.3,3810,1,4,0)
 ;;=4^K64.8
 ;;^UTILITY(U,$J,358.3,3810,2)
 ;;=^5008774
 ;;^UTILITY(U,$J,358.3,3811,0)
 ;;=K64.9^^20^267^7
 ;;^UTILITY(U,$J,358.3,3811,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3811,1,3,0)
 ;;=3^Hemorrhoids,Unspec
 ;;^UTILITY(U,$J,358.3,3811,1,4,0)
 ;;=4^K64.9
 ;;^UTILITY(U,$J,358.3,3811,2)
 ;;=^5008775
 ;;^UTILITY(U,$J,358.3,3812,0)
 ;;=K64.0^^20^267^1
 ;;^UTILITY(U,$J,358.3,3812,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3812,1,3,0)
 ;;=3^First Degree Hemorrhoids
 ;;^UTILITY(U,$J,358.3,3812,1,4,0)
 ;;=4^K64.0
 ;;^UTILITY(U,$J,358.3,3812,2)
 ;;=^5008769
 ;;^UTILITY(U,$J,358.3,3813,0)
 ;;=K64.1^^20^267^2
 ;;^UTILITY(U,$J,358.3,3813,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3813,1,3,0)
 ;;=3^Second Degree Hemorrhoids
 ;;^UTILITY(U,$J,358.3,3813,1,4,0)
 ;;=4^K64.1
 ;;^UTILITY(U,$J,358.3,3813,2)
 ;;=^5008770
 ;;^UTILITY(U,$J,358.3,3814,0)
 ;;=K64.2^^20^267^3
 ;;^UTILITY(U,$J,358.3,3814,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3814,1,3,0)
 ;;=3^Third Degree Hemorrhoids
 ;;^UTILITY(U,$J,358.3,3814,1,4,0)
 ;;=4^K64.2
 ;;^UTILITY(U,$J,358.3,3814,2)
 ;;=^5008771
 ;;^UTILITY(U,$J,358.3,3815,0)
 ;;=K64.3^^20^267^4
 ;;^UTILITY(U,$J,358.3,3815,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3815,1,3,0)
 ;;=3^Fourth Degree Hemorrhoids
 ;;^UTILITY(U,$J,358.3,3815,1,4,0)
 ;;=4^K64.3
 ;;^UTILITY(U,$J,358.3,3815,2)
 ;;=^5008772
 ;;^UTILITY(U,$J,358.3,3816,0)
 ;;=K64.4^^20^267^5
 ;;^UTILITY(U,$J,358.3,3816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3816,1,3,0)
 ;;=3^Hemorrhoids,External
 ;;^UTILITY(U,$J,358.3,3816,1,4,0)
 ;;=4^K64.4
 ;;^UTILITY(U,$J,358.3,3816,2)
 ;;=^269834
 ;;^UTILITY(U,$J,358.3,3817,0)
 ;;=K64.5^^20^267^8
 ;;^UTILITY(U,$J,358.3,3817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3817,1,3,0)
 ;;=3^Perianal venous thrombosis
 ;;^UTILITY(U,$J,358.3,3817,1,4,0)
 ;;=4^K64.5
 ;;^UTILITY(U,$J,358.3,3817,2)
 ;;=^5008773
 ;;^UTILITY(U,$J,358.3,3818,0)
 ;;=K61.0^^20^268^1
 ;;^UTILITY(U,$J,358.3,3818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3818,1,3,0)
 ;;=3^Anal Abscess
 ;;^UTILITY(U,$J,358.3,3818,1,4,0)
 ;;=4^K61.0
 ;;^UTILITY(U,$J,358.3,3818,2)
 ;;=^5008749
 ;;^UTILITY(U,$J,358.3,3819,0)
 ;;=K61.1^^20^268^5
 ;;^UTILITY(U,$J,358.3,3819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3819,1,3,0)
 ;;=3^Rectal Abscess
 ;;^UTILITY(U,$J,358.3,3819,1,4,0)
 ;;=4^K61.1
 ;;^UTILITY(U,$J,358.3,3819,2)
 ;;=^259588
 ;;^UTILITY(U,$J,358.3,3820,0)
 ;;=K61.3^^20^268^4
 ;;^UTILITY(U,$J,358.3,3820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3820,1,3,0)
 ;;=3^Ischiorectal Abscess
 ;;^UTILITY(U,$J,358.3,3820,1,4,0)
 ;;=4^K61.3
 ;;^UTILITY(U,$J,358.3,3820,2)
 ;;=^5008751
 ;;^UTILITY(U,$J,358.3,3821,0)
 ;;=K61.4^^20^268^3
 ;;^UTILITY(U,$J,358.3,3821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3821,1,3,0)
 ;;=3^Intrasphincteric Abscess
 ;;^UTILITY(U,$J,358.3,3821,1,4,0)
 ;;=4^K61.4
 ;;^UTILITY(U,$J,358.3,3821,2)
 ;;=^5008752
 ;;^UTILITY(U,$J,358.3,3822,0)
 ;;=K61.2^^20^268^2
 ;;^UTILITY(U,$J,358.3,3822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3822,1,3,0)
 ;;=3^Anorectal Abscess
 ;;^UTILITY(U,$J,358.3,3822,1,4,0)
 ;;=4^K61.2
 ;;^UTILITY(U,$J,358.3,3822,2)
 ;;=^5008750
 ;;^UTILITY(U,$J,358.3,3823,0)
 ;;=S09.12XA^^20^269^2
 ;;^UTILITY(U,$J,358.3,3823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3823,1,3,0)
 ;;=3^Laceration of Muscle/Tendon of Head,Init Encntr
 ;;^UTILITY(U,$J,358.3,3823,1,4,0)
 ;;=4^S09.12XA
 ;;^UTILITY(U,$J,358.3,3823,2)
 ;;=^5021287
 ;;^UTILITY(U,$J,358.3,3824,0)
 ;;=S16.2XXA^^20^269^1
 ;;^UTILITY(U,$J,358.3,3824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3824,1,3,0)
 ;;=3^Laceration of Muscle/Fascia/Tendon at Neck Level,Init Encntr
 ;;^UTILITY(U,$J,358.3,3824,1,4,0)
 ;;=4^S16.2XXA
 ;;^UTILITY(U,$J,358.3,3824,2)
 ;;=^5022361
 ;;^UTILITY(U,$J,358.3,3825,0)
 ;;=S31.114A^^20^269^5
 ;;^UTILITY(U,$J,358.3,3825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3825,1,3,0)
 ;;=3^Laceration w/o FB of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,3825,1,4,0)
 ;;=4^S31.114A
 ;;^UTILITY(U,$J,358.3,3825,2)
 ;;=^5134427
 ;;^UTILITY(U,$J,358.3,3826,0)
 ;;=S31.111A^^20^269^6
 ;;^UTILITY(U,$J,358.3,3826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3826,1,3,0)
 ;;=3^Laceration w/o FB of LUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,3826,1,4,0)
 ;;=4^S31.111A
 ;;^UTILITY(U,$J,358.3,3826,2)
 ;;=^5024044
 ;;^UTILITY(U,$J,358.3,3827,0)
 ;;=S31.113A^^20^269^37
 ;;^UTILITY(U,$J,358.3,3827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3827,1,3,0)
 ;;=3^Laceration w/o FB of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,3827,1,4,0)
 ;;=4^S31.113A
 ;;^UTILITY(U,$J,358.3,3827,2)
 ;;=^5024050
 ;;^UTILITY(U,$J,358.3,3828,0)
 ;;=S31.110A^^20^269^38
 ;;^UTILITY(U,$J,358.3,3828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3828,1,3,0)
 ;;=3^Laceration w/o FB of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,3828,1,4,0)
 ;;=4^S31.110A
 ;;^UTILITY(U,$J,358.3,3828,2)
 ;;=^5024041
 ;;^UTILITY(U,$J,358.3,3829,0)
 ;;=S31.821A^^20^269^8
 ;;^UTILITY(U,$J,358.3,3829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3829,1,3,0)
 ;;=3^Laceration w/o FB of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,3829,1,4,0)
 ;;=4^S31.821A
 ;;^UTILITY(U,$J,358.3,3829,2)
 ;;=^5024311
 ;;^UTILITY(U,$J,358.3,3830,0)
 ;;=S01.412A^^20^269^9
 ;;^UTILITY(U,$J,358.3,3830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3830,1,3,0)
 ;;=3^Laceration w/o FB of Left Cheek/TMJ Area,Init Encntr
 ;;^UTILITY(U,$J,358.3,3830,1,4,0)
 ;;=4^S01.412A
 ;;^UTILITY(U,$J,358.3,3830,2)
 ;;=^5020156
 ;;^UTILITY(U,$J,358.3,3831,0)
 ;;=S01.312A^^20^269^10
 ;;^UTILITY(U,$J,358.3,3831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3831,1,3,0)
 ;;=3^Laceration w/o FB of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,3831,1,4,0)
 ;;=4^S01.312A
 ;;^UTILITY(U,$J,358.3,3831,2)
 ;;=^5020117
 ;;^UTILITY(U,$J,358.3,3832,0)
 ;;=S51.012A^^20^269^11
 ;;^UTILITY(U,$J,358.3,3832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3832,1,3,0)
 ;;=3^Laceration w/o FB of Left Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,3832,1,4,0)
 ;;=4^S51.012A
 ;;^UTILITY(U,$J,358.3,3832,2)
 ;;=^5028629
 ;;^UTILITY(U,$J,358.3,3833,0)
 ;;=S91.212A^^20^269^13
 ;;^UTILITY(U,$J,358.3,3833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3833,1,3,0)
 ;;=3^Laceration w/o FB of Left Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3833,1,4,0)
 ;;=4^S91.212A
 ;;^UTILITY(U,$J,358.3,3833,2)
 ;;=^5044276
 ;;^UTILITY(U,$J,358.3,3834,0)
 ;;=S91.112A^^20^269^14
 ;;^UTILITY(U,$J,358.3,3834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3834,1,3,0)
 ;;=3^Laceration w/o FB of Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3834,1,4,0)
 ;;=4^S91.112A
 ;;^UTILITY(U,$J,358.3,3834,2)
 ;;=^5044186
 ;;^UTILITY(U,$J,358.3,3835,0)
 ;;=S61.412A^^20^269^15
 ;;^UTILITY(U,$J,358.3,3835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3835,1,3,0)
 ;;=3^Laceration w/o FB of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,3835,1,4,0)
 ;;=4^S61.412A
 ;;^UTILITY(U,$J,358.3,3835,2)
 ;;=^5032990
 ;;^UTILITY(U,$J,358.3,3836,0)
 ;;=S61.311A^^20^269^17
 ;;^UTILITY(U,$J,358.3,3836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3836,1,3,0)
 ;;=3^Laceration w/o FB of Left Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3836,1,4,0)
 ;;=4^S61.311A
 ;;^UTILITY(U,$J,358.3,3836,2)
 ;;=^5032909
 ;;^UTILITY(U,$J,358.3,3837,0)
 ;;=S61.211A^^20^269^18
 ;;^UTILITY(U,$J,358.3,3837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3837,1,3,0)
 ;;=3^Laceration w/o FB of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3837,1,4,0)
 ;;=4^S61.211A
 ;;^UTILITY(U,$J,358.3,3837,2)
 ;;=^5032774
 ;;^UTILITY(U,$J,358.3,3838,0)
 ;;=S91.215A^^20^269^20
 ;;^UTILITY(U,$J,358.3,3838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3838,1,3,0)
 ;;=3^Laceration w/o FB of Left Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,3838,1,4,0)
 ;;=4^S91.215A
