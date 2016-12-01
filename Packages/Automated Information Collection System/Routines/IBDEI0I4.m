IBDEI0I4 ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22960,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Init Encntr
 ;;^UTILITY(U,$J,358.3,22960,1,4,0)
 ;;=4^Y37.200A
 ;;^UTILITY(U,$J,358.3,22960,2)
 ;;=^5137997
 ;;^UTILITY(U,$J,358.3,22961,0)
 ;;=Y37.200D^^58^859^92
 ;;^UTILITY(U,$J,358.3,22961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22961,1,3,0)
 ;;=3^Miltary Op Inv Explosion/Fragments,Milt,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22961,1,4,0)
 ;;=4^Y37.200D
 ;;^UTILITY(U,$J,358.3,22961,2)
 ;;=^5137999
 ;;^UTILITY(U,$J,358.3,22962,0)
 ;;=X00.1XXA^^58^859^13
 ;;^UTILITY(U,$J,358.3,22962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22962,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Init Encntr
 ;;^UTILITY(U,$J,358.3,22962,1,4,0)
 ;;=4^X00.1XXA
 ;;^UTILITY(U,$J,358.3,22962,2)
 ;;=^5060664
 ;;^UTILITY(U,$J,358.3,22963,0)
 ;;=X00.1XXD^^58^859^14
 ;;^UTILITY(U,$J,358.3,22963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22963,1,3,0)
 ;;=3^Exp to Smoke in Uncontrolled Bldg Fire,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22963,1,4,0)
 ;;=4^X00.1XXD
 ;;^UTILITY(U,$J,358.3,22963,2)
 ;;=^5060665
 ;;^UTILITY(U,$J,358.3,22964,0)
 ;;=Y36.820S^^58^859^21
 ;;^UTILITY(U,$J,358.3,22964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22964,1,3,0)
 ;;=3^Explosn of Bomb Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,22964,1,4,0)
 ;;=4^Y36.820S
 ;;^UTILITY(U,$J,358.3,22964,2)
 ;;=^5061795
 ;;^UTILITY(U,$J,358.3,22965,0)
 ;;=Y36.810S^^58^859^24
 ;;^UTILITY(U,$J,358.3,22965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22965,1,3,0)
 ;;=3^Explosn of Mine Placed During War Op but Expld After,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,22965,1,4,0)
 ;;=4^Y36.810S
 ;;^UTILITY(U,$J,358.3,22965,2)
 ;;=^5061789
 ;;^UTILITY(U,$J,358.3,22966,0)
 ;;=Y36.6X0S^^58^859^114
 ;;^UTILITY(U,$J,358.3,22966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22966,1,3,0)
 ;;=3^War Op Inv Biological Weapons,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,22966,1,4,0)
 ;;=4^Y36.6X0S
 ;;^UTILITY(U,$J,358.3,22966,2)
 ;;=^5061777
 ;;^UTILITY(U,$J,358.3,22967,0)
 ;;=Y36.410S^^58^859^122
 ;;^UTILITY(U,$J,358.3,22967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22967,1,3,0)
 ;;=3^War Op Inv Rubber Bullets,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,22967,1,4,0)
 ;;=4^Y36.410S
 ;;^UTILITY(U,$J,358.3,22967,2)
 ;;=^5061693
 ;;^UTILITY(U,$J,358.3,22968,0)
 ;;=Y36.200S^^58^859^119
 ;;^UTILITY(U,$J,358.3,22968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22968,1,3,0)
 ;;=3^War Op Inv Explosion/Fragments,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,22968,1,4,0)
 ;;=4^Y36.200S
 ;;^UTILITY(U,$J,358.3,22968,2)
 ;;=^5061609
 ;;^UTILITY(U,$J,358.3,22969,0)
 ;;=Y36.300S^^58^859^120
 ;;^UTILITY(U,$J,358.3,22969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22969,1,3,0)
 ;;=3^War Op Inv Fire/Conflagr/Hot Subst,Unspec,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,22969,1,4,0)
 ;;=4^Y36.300S
 ;;^UTILITY(U,$J,358.3,22969,2)
 ;;=^5061663
 ;;^UTILITY(U,$J,358.3,22970,0)
 ;;=Y36.230A^^58^859^116
 ;;^UTILITY(U,$J,358.3,22970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22970,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Init Encntr
 ;;^UTILITY(U,$J,358.3,22970,1,4,0)
 ;;=4^Y36.230A
 ;;^UTILITY(U,$J,358.3,22970,2)
 ;;=^5061625
 ;;^UTILITY(U,$J,358.3,22971,0)
 ;;=Y36.230D^^58^859^117
 ;;^UTILITY(U,$J,358.3,22971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22971,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Subs Encntr
 ;;^UTILITY(U,$J,358.3,22971,1,4,0)
 ;;=4^Y36.230D
 ;;^UTILITY(U,$J,358.3,22971,2)
 ;;=^5061626
 ;;^UTILITY(U,$J,358.3,22972,0)
 ;;=Y36.230S^^58^859^118
 ;;^UTILITY(U,$J,358.3,22972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22972,1,3,0)
 ;;=3^War Op Inv Explosion of IED,Milt Pers,Sequela
 ;;^UTILITY(U,$J,358.3,22972,1,4,0)
 ;;=4^Y36.230S
 ;;^UTILITY(U,$J,358.3,22972,2)
 ;;=^5061627
 ;;^UTILITY(U,$J,358.3,22973,0)
 ;;=Y36.7X0S^^58^859^130
 ;;^UTILITY(U,$J,358.3,22973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22973,1,3,0)
 ;;=3^War Op w/ Chem Weapons/Unconvtl Warfare,Milt,Sequela
 ;;^UTILITY(U,$J,358.3,22973,1,4,0)
 ;;=4^Y36.7X0S
 ;;^UTILITY(U,$J,358.3,22973,2)
 ;;=^5061783
 ;;^UTILITY(U,$J,358.3,22974,0)
 ;;=F02.81^^58^860^11
 ;;^UTILITY(U,$J,358.3,22974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22974,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,22974,1,4,0)
 ;;=4^F02.81
 ;;^UTILITY(U,$J,358.3,22974,2)
 ;;=^5003049
 ;;^UTILITY(U,$J,358.3,22975,0)
 ;;=F02.80^^58^860^12
 ;;^UTILITY(U,$J,358.3,22975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22975,1,3,0)
 ;;=3^Dementia in Oth Diseases Classd Elswhr w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,22975,1,4,0)
 ;;=4^F02.80
 ;;^UTILITY(U,$J,358.3,22975,2)
 ;;=^5003048
 ;;^UTILITY(U,$J,358.3,22976,0)
 ;;=F03.91^^58^860^13
 ;;^UTILITY(U,$J,358.3,22976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22976,1,3,0)
 ;;=3^Dementia w/ Behavioral Disturbances,Unspec
 ;;^UTILITY(U,$J,358.3,22976,1,4,0)
 ;;=4^F03.91
 ;;^UTILITY(U,$J,358.3,22976,2)
 ;;=^5133350
 ;;^UTILITY(U,$J,358.3,22977,0)
 ;;=G31.83^^58^860^14
 ;;^UTILITY(U,$J,358.3,22977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22977,1,3,0)
 ;;=3^Dementia w/ Lewy Bodies
 ;;^UTILITY(U,$J,358.3,22977,1,4,0)
 ;;=4^G31.83
 ;;^UTILITY(U,$J,358.3,22977,2)
 ;;=^329888
 ;;^UTILITY(U,$J,358.3,22978,0)
 ;;=F01.51^^58^860^30
 ;;^UTILITY(U,$J,358.3,22978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22978,1,3,0)
 ;;=3^Vascular Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,22978,1,4,0)
 ;;=4^F01.51
 ;;^UTILITY(U,$J,358.3,22978,2)
 ;;=^5003047
 ;;^UTILITY(U,$J,358.3,22979,0)
 ;;=F01.50^^58^860^31
 ;;^UTILITY(U,$J,358.3,22979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22979,1,3,0)
 ;;=3^Vascular Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,22979,1,4,0)
 ;;=4^F01.50
 ;;^UTILITY(U,$J,358.3,22979,2)
 ;;=^5003046
 ;;^UTILITY(U,$J,358.3,22980,0)
 ;;=A81.9^^58^860^6
 ;;^UTILITY(U,$J,358.3,22980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22980,1,3,0)
 ;;=3^Atypical Virus Infection of CNS,Unspec
 ;;^UTILITY(U,$J,358.3,22980,1,4,0)
 ;;=4^A81.9
 ;;^UTILITY(U,$J,358.3,22980,2)
 ;;=^5000414
 ;;^UTILITY(U,$J,358.3,22981,0)
 ;;=A81.09^^58^860^8
 ;;^UTILITY(U,$J,358.3,22981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22981,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease NEC
 ;;^UTILITY(U,$J,358.3,22981,1,4,0)
 ;;=4^A81.09
 ;;^UTILITY(U,$J,358.3,22981,2)
 ;;=^5000410
 ;;^UTILITY(U,$J,358.3,22982,0)
 ;;=A81.00^^58^860^9
 ;;^UTILITY(U,$J,358.3,22982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22982,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22982,1,4,0)
 ;;=4^A81.00
 ;;^UTILITY(U,$J,358.3,22982,2)
 ;;=^5000409
 ;;^UTILITY(U,$J,358.3,22983,0)
 ;;=A81.01^^58^860^10
 ;;^UTILITY(U,$J,358.3,22983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22983,1,3,0)
 ;;=3^Creutzfeldt-Jakob Disease,Variant
 ;;^UTILITY(U,$J,358.3,22983,1,4,0)
 ;;=4^A81.01
 ;;^UTILITY(U,$J,358.3,22983,2)
 ;;=^336701
 ;;^UTILITY(U,$J,358.3,22984,0)
 ;;=A81.89^^58^860^7
 ;;^UTILITY(U,$J,358.3,22984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22984,1,3,0)
 ;;=3^Atypical Virus Infections of CNS NEC
 ;;^UTILITY(U,$J,358.3,22984,1,4,0)
 ;;=4^A81.89
 ;;^UTILITY(U,$J,358.3,22984,2)
 ;;=^5000413
 ;;^UTILITY(U,$J,358.3,22985,0)
 ;;=A81.2^^58^860^27
 ;;^UTILITY(U,$J,358.3,22985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22985,1,3,0)
 ;;=3^Progressive Multifocal Leukoencephalopathy
 ;;^UTILITY(U,$J,358.3,22985,1,4,0)
 ;;=4^A81.2
 ;;^UTILITY(U,$J,358.3,22985,2)
 ;;=^5000411
 ;;^UTILITY(U,$J,358.3,22986,0)
 ;;=B20.^^58^860^17
 ;;^UTILITY(U,$J,358.3,22986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22986,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/ Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,22986,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,22986,2)
 ;;=^5000555^F02.81
 ;;^UTILITY(U,$J,358.3,22987,0)
 ;;=B20.^^58^860^18
 ;;^UTILITY(U,$J,358.3,22987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22987,1,3,0)
 ;;=3^HIV Disease w/ Dementia w/o Behavioral Disturbances
 ;;^UTILITY(U,$J,358.3,22987,1,4,0)
 ;;=4^B20.
 ;;^UTILITY(U,$J,358.3,22987,2)
 ;;=^5000555^F02.80
 ;;^UTILITY(U,$J,358.3,22988,0)
 ;;=F10.27^^58^860^1
 ;;^UTILITY(U,$J,358.3,22988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22988,1,3,0)
 ;;=3^Alcohol Dependence w/ Alcohol-Induced Persisting Dementia
 ;;^UTILITY(U,$J,358.3,22988,1,4,0)
 ;;=4^F10.27
 ;;^UTILITY(U,$J,358.3,22988,2)
 ;;=^5003095
 ;;^UTILITY(U,$J,358.3,22989,0)
 ;;=F19.97^^58^860^29
 ;;^UTILITY(U,$J,358.3,22989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22989,1,3,0)
 ;;=3^Psychoactive Substance Use w/ Persisting Dementia NEC
 ;;^UTILITY(U,$J,358.3,22989,1,4,0)
 ;;=4^F19.97
 ;;^UTILITY(U,$J,358.3,22989,2)
 ;;=^5003465
 ;;^UTILITY(U,$J,358.3,22990,0)
 ;;=F03.90^^58^860^15
 ;;^UTILITY(U,$J,358.3,22990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22990,1,3,0)
 ;;=3^Dementia w/o Behavioral Disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,22990,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,22990,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,22991,0)
 ;;=G30.0^^58^860^2
 ;;^UTILITY(U,$J,358.3,22991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22991,1,3,0)
 ;;=3^Alzheimer's Disease w/ Early Onset
 ;;^UTILITY(U,$J,358.3,22991,1,4,0)
 ;;=4^G30.0
 ;;^UTILITY(U,$J,358.3,22991,2)
 ;;=^5003805
 ;;^UTILITY(U,$J,358.3,22992,0)
 ;;=G30.1^^58^860^3
 ;;^UTILITY(U,$J,358.3,22992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22992,1,3,0)
 ;;=3^Alzheimer's Disease w/ Late Onset
 ;;^UTILITY(U,$J,358.3,22992,1,4,0)
 ;;=4^G30.1
 ;;^UTILITY(U,$J,358.3,22992,2)
 ;;=^5003806
 ;;^UTILITY(U,$J,358.3,22993,0)
 ;;=G30.9^^58^860^4
 ;;^UTILITY(U,$J,358.3,22993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,22993,1,3,0)
 ;;=3^Alzheimer's Disease,Unspec
 ;;^UTILITY(U,$J,358.3,22993,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,22993,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,22994,0)
 ;;=G10.^^58^860^19
