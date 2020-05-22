IBDEI09T ; ; 01-MAY-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 01, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24039,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24039,1,2,0)
 ;;=2^Asp/Inj Small Jt w/ US
 ;;^UTILITY(U,$J,358.3,24039,1,3,0)
 ;;=3^20604
 ;;^UTILITY(U,$J,358.3,24040,0)
 ;;=20600^^75^996^6^^^^1
 ;;^UTILITY(U,$J,358.3,24040,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24040,1,2,0)
 ;;=2^Asp/Inj Small Jt w/o US
 ;;^UTILITY(U,$J,358.3,24040,1,3,0)
 ;;=3^20600
 ;;^UTILITY(U,$J,358.3,24041,0)
 ;;=20550^^75^996^9^^^^1
 ;;^UTILITY(U,$J,358.3,24041,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24041,1,2,0)
 ;;=2^Inject Tendon/Ligament/Cyst
 ;;^UTILITY(U,$J,358.3,24041,1,3,0)
 ;;=3^20550
 ;;^UTILITY(U,$J,358.3,24042,0)
 ;;=64490^^75^996^7^^^^1
 ;;^UTILITY(U,$J,358.3,24042,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24042,1,2,0)
 ;;=2^Cervical/Thoracic Inj,1st Level
 ;;^UTILITY(U,$J,358.3,24042,1,3,0)
 ;;=3^64490
 ;;^UTILITY(U,$J,358.3,24043,0)
 ;;=64480^^75^996^8^^^^1
 ;;^UTILITY(U,$J,358.3,24043,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24043,1,2,0)
 ;;=2^Cervical/Thoracic Inj,Ea Addl Level
 ;;^UTILITY(U,$J,358.3,24043,1,3,0)
 ;;=3^64480
 ;;^UTILITY(U,$J,358.3,24044,0)
 ;;=64483^^75^996^16^^^^1
 ;;^UTILITY(U,$J,358.3,24044,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24044,1,2,0)
 ;;=2^Lumbar/Sacral Inj,1st Level
 ;;^UTILITY(U,$J,358.3,24044,1,3,0)
 ;;=3^64483
 ;;^UTILITY(U,$J,358.3,24045,0)
 ;;=64484^^75^996^17^^^^1
 ;;^UTILITY(U,$J,358.3,24045,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24045,1,2,0)
 ;;=2^Lumbar/Sacral Inj,Ea Addl Level
 ;;^UTILITY(U,$J,358.3,24045,1,3,0)
 ;;=3^64484
 ;;^UTILITY(U,$J,358.3,24046,0)
 ;;=64490^^75^996^10^^^^1
 ;;^UTILITY(U,$J,358.3,24046,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24046,1,2,0)
 ;;=2^Intraarticular Jt or MBB Cervical/Thoracic,1st Level
 ;;^UTILITY(U,$J,358.3,24046,1,3,0)
 ;;=3^64490
 ;;^UTILITY(U,$J,358.3,24047,0)
 ;;=64491^^75^996^11^^^^1
 ;;^UTILITY(U,$J,358.3,24047,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24047,1,2,0)
 ;;=2^Intraarticular Jt or MBB Cervical/Thoracic,2nd Level
 ;;^UTILITY(U,$J,358.3,24047,1,3,0)
 ;;=3^64491
 ;;^UTILITY(U,$J,358.3,24048,0)
 ;;=64492^^75^996^12^^^^1
 ;;^UTILITY(U,$J,358.3,24048,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24048,1,2,0)
 ;;=2^Intraarticular Jt or MBB Cervical/Thoracic,3rd Level
 ;;^UTILITY(U,$J,358.3,24048,1,3,0)
 ;;=3^64492
 ;;^UTILITY(U,$J,358.3,24049,0)
 ;;=64493^^75^996^13^^^^1
 ;;^UTILITY(U,$J,358.3,24049,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24049,1,2,0)
 ;;=2^Intraarticular Jt or MBB Lumbar/Sacral,1st Level
 ;;^UTILITY(U,$J,358.3,24049,1,3,0)
 ;;=3^64493
 ;;^UTILITY(U,$J,358.3,24050,0)
 ;;=64494^^75^996^14^^^^1
 ;;^UTILITY(U,$J,358.3,24050,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24050,1,2,0)
 ;;=2^Intraarticular Jt or MBB Lumbar/Sacral,2nd Level
 ;;^UTILITY(U,$J,358.3,24050,1,3,0)
 ;;=3^64494
 ;;^UTILITY(U,$J,358.3,24051,0)
 ;;=64495^^75^996^15^^^^1
 ;;^UTILITY(U,$J,358.3,24051,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24051,1,2,0)
 ;;=2^Intraarticular Jt or MBB Lumbar/Sacral,3rd Level
 ;;^UTILITY(U,$J,358.3,24051,1,3,0)
 ;;=3^64495
 ;;^UTILITY(U,$J,358.3,24052,0)
 ;;=20552^^75^996^21^^^^1
 ;;^UTILITY(U,$J,358.3,24052,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24052,1,2,0)
 ;;=2^Trigger Point Inj,1-2 Muscles
 ;;^UTILITY(U,$J,358.3,24052,1,3,0)
 ;;=3^20552
 ;;^UTILITY(U,$J,358.3,24053,0)
 ;;=27096^^75^996^20^^^^1
 ;;^UTILITY(U,$J,358.3,24053,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24053,1,2,0)
 ;;=2^Sacroiliac Jt Inj w/ Fluoroscopy
 ;;^UTILITY(U,$J,358.3,24053,1,3,0)
 ;;=3^27096
 ;;^UTILITY(U,$J,358.3,24054,0)
 ;;=20553^^75^996^22^^^^1
 ;;^UTILITY(U,$J,358.3,24054,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24054,1,2,0)
 ;;=2^Trigger Point Inj,3+ Muscles
 ;;^UTILITY(U,$J,358.3,24054,1,3,0)
 ;;=3^20553
 ;;^UTILITY(U,$J,358.3,24055,0)
 ;;=20560^^75^996^18^^^^1
 ;;^UTILITY(U,$J,358.3,24055,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24055,1,2,0)
 ;;=2^Needle Insert w/o Inj,1 or 2 Muscles
 ;;^UTILITY(U,$J,358.3,24055,1,3,0)
 ;;=3^20560
 ;;^UTILITY(U,$J,358.3,24056,0)
 ;;=20561^^75^996^19^^^^1
 ;;^UTILITY(U,$J,358.3,24056,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24056,1,2,0)
 ;;=2^Needle Insert w/o Inj,3+ Muscles
 ;;^UTILITY(U,$J,358.3,24056,1,3,0)
 ;;=3^20561
 ;;^UTILITY(U,$J,358.3,24057,0)
 ;;=63650^^75^997^10^^^^1
 ;;^UTILITY(U,$J,358.3,24057,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24057,1,2,0)
 ;;=2^SC Stimulator Trial
 ;;^UTILITY(U,$J,358.3,24057,1,3,0)
 ;;=3^63650
 ;;^UTILITY(U,$J,358.3,24058,0)
 ;;=63685^^75^997^9^^^^1
 ;;^UTILITY(U,$J,358.3,24058,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24058,1,2,0)
 ;;=2^SC Stimulator Pulse Generator Implant
 ;;^UTILITY(U,$J,358.3,24058,1,3,0)
 ;;=3^63685
 ;;^UTILITY(U,$J,358.3,24059,0)
 ;;=63661^^75^997^8^^^^1
 ;;^UTILITY(U,$J,358.3,24059,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24059,1,2,0)
 ;;=2^SC Stimulator Lead Removal
 ;;^UTILITY(U,$J,358.3,24059,1,3,0)
 ;;=3^63661
 ;;^UTILITY(U,$J,358.3,24060,0)
 ;;=95970^^75^997^6^^^^1
 ;;^UTILITY(U,$J,358.3,24060,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24060,1,2,0)
 ;;=2^Analyze Neurostim w/o Reprogramming
 ;;^UTILITY(U,$J,358.3,24060,1,3,0)
 ;;=3^95970
 ;;^UTILITY(U,$J,358.3,24061,0)
 ;;=95971^^75^997^7^^^^1
 ;;^UTILITY(U,$J,358.3,24061,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24061,1,2,0)
 ;;=2^Analyze Simple Neurostim w/ Intraop/Subsq Programming
 ;;^UTILITY(U,$J,358.3,24061,1,3,0)
 ;;=3^95971
 ;;^UTILITY(U,$J,358.3,24062,0)
 ;;=95972^^75^997^4^^^^1
 ;;^UTILITY(U,$J,358.3,24062,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24062,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Intraop/Subsq Program
 ;;^UTILITY(U,$J,358.3,24062,1,3,0)
 ;;=3^95972
 ;;^UTILITY(U,$J,358.3,24063,0)
 ;;=95976^^75^997^5^^^^1
 ;;^UTILITY(U,$J,358.3,24063,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24063,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Simple CN Pulse Gen
 ;;^UTILITY(U,$J,358.3,24063,1,3,0)
 ;;=3^95976
 ;;^UTILITY(U,$J,358.3,24064,0)
 ;;=95977^^75^997^3^^^^1
 ;;^UTILITY(U,$J,358.3,24064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24064,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Complex CN Pulse Gen
 ;;^UTILITY(U,$J,358.3,24064,1,3,0)
 ;;=3^95977
 ;;^UTILITY(U,$J,358.3,24065,0)
 ;;=95983^^75^997^1^^^^1
 ;;^UTILITY(U,$J,358.3,24065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24065,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Brain Neurostim,1st 15min
 ;;^UTILITY(U,$J,358.3,24065,1,3,0)
 ;;=3^95983
 ;;^UTILITY(U,$J,358.3,24066,0)
 ;;=95984^^75^997^2^^^^1
 ;;^UTILITY(U,$J,358.3,24066,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24066,1,2,0)
 ;;=2^Analyze Complex Neurostim w/ Brain Neurostim,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,24066,1,3,0)
 ;;=3^95984
 ;;^UTILITY(U,$J,358.3,24067,0)
 ;;=97151^^75^998^1^^^^1
 ;;^UTILITY(U,$J,358.3,24067,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24067,1,2,0)
 ;;=2^Behavioral Id Assess by MD/QHP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24067,1,3,0)
 ;;=3^97151
 ;;^UTILITY(U,$J,358.3,24068,0)
 ;;=97152^^75^998^2^^^^1
 ;;^UTILITY(U,$J,358.3,24068,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24068,1,2,0)
 ;;=2^Behavioral Id Assess by Tech,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24068,1,3,0)
 ;;=3^97152
 ;;^UTILITY(U,$J,358.3,24069,0)
 ;;=0362T^^75^998^3^^^^1
 ;;^UTILITY(U,$J,358.3,24069,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24069,1,2,0)
 ;;=2^Behavioral Id Supporting Assess,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24069,1,3,0)
 ;;=3^0362T
 ;;^UTILITY(U,$J,358.3,24070,0)
 ;;=97153^^75^999^2^^^^1
 ;;^UTILITY(U,$J,358.3,24070,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24070,1,2,0)
 ;;=2^Adaptive Behavior Txmt by Protocol by Tech,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24070,1,3,0)
 ;;=3^97153
 ;;^UTILITY(U,$J,358.3,24071,0)
 ;;=97154^^75^999^5^^^^1
 ;;^UTILITY(U,$J,358.3,24071,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24071,1,2,0)
 ;;=2^Grp Adaptive Behavior Txmt by Protocol by Tech,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24071,1,3,0)
 ;;=3^97154
 ;;^UTILITY(U,$J,358.3,24072,0)
 ;;=97155^^75^999^3^^^^1
 ;;^UTILITY(U,$J,358.3,24072,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24072,1,2,0)
 ;;=2^Adaptive Behavior Txmt w/ Protocol Mod by MD/HCP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24072,1,3,0)
 ;;=3^97155
 ;;^UTILITY(U,$J,358.3,24073,0)
 ;;=97156^^75^999^4^^^^1
 ;;^UTILITY(U,$J,358.3,24073,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24073,1,2,0)
 ;;=2^Family Adaptive Behavior Txmt Guidance by MD/HCP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24073,1,3,0)
 ;;=3^97156
 ;;^UTILITY(U,$J,358.3,24074,0)
 ;;=97157^^75^999^7^^^^1
 ;;^UTILITY(U,$J,358.3,24074,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24074,1,2,0)
 ;;=2^Mult-Fam Adaptive Beh Txmt w/ Protocol Mod by MD/HCP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24074,1,3,0)
 ;;=3^97157
 ;;^UTILITY(U,$J,358.3,24075,0)
 ;;=97158^^75^999^6^^^^1
 ;;^UTILITY(U,$J,358.3,24075,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24075,1,2,0)
 ;;=2^Grp Adaptive Behavior Txmt w/ Protocol Mod by MD/HCP,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24075,1,3,0)
 ;;=3^97158
 ;;^UTILITY(U,$J,358.3,24076,0)
 ;;=0373T^^75^999^1^^^^1
 ;;^UTILITY(U,$J,358.3,24076,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,24076,1,2,0)
 ;;=2^Adaptive Behavior Txmt Supporting Assess,Ea 15 min
 ;;^UTILITY(U,$J,358.3,24076,1,3,0)
 ;;=3^0373T
 ;;^UTILITY(U,$J,358.3,24077,0)
 ;;=Z89.012^^76^1000^10
 ;;^UTILITY(U,$J,358.3,24077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24077,1,3,0)
 ;;=3^Acquired absence of left thumb
 ;;^UTILITY(U,$J,358.3,24077,1,4,0)
 ;;=4^Z89.012
 ;;^UTILITY(U,$J,358.3,24077,2)
 ;;=^5063532
 ;;^UTILITY(U,$J,358.3,24078,0)
 ;;=Z89.011^^76^1000^25
 ;;^UTILITY(U,$J,358.3,24078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24078,1,3,0)
 ;;=3^Acquired absence of right thumb
 ;;^UTILITY(U,$J,358.3,24078,1,4,0)
 ;;=4^Z89.011
 ;;^UTILITY(U,$J,358.3,24078,2)
 ;;=^5063531
 ;;^UTILITY(U,$J,358.3,24079,0)
 ;;=Z89.021^^76^1000^16
 ;;^UTILITY(U,$J,358.3,24079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24079,1,3,0)
 ;;=3^Acquired absence of right finger(s)
 ;;^UTILITY(U,$J,358.3,24079,1,4,0)
 ;;=4^Z89.021
 ;;^UTILITY(U,$J,358.3,24079,2)
 ;;=^5063534
 ;;^UTILITY(U,$J,358.3,24080,0)
 ;;=Z89.022^^76^1000^2
 ;;^UTILITY(U,$J,358.3,24080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24080,1,3,0)
 ;;=3^Acquired absence of left finger(s)
 ;;^UTILITY(U,$J,358.3,24080,1,4,0)
 ;;=4^Z89.022
 ;;^UTILITY(U,$J,358.3,24080,2)
 ;;=^5063535
 ;;^UTILITY(U,$J,358.3,24081,0)
 ;;=Z89.112^^76^1000^5
 ;;^UTILITY(U,$J,358.3,24081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24081,1,3,0)
 ;;=3^Acquired absence of left hand
 ;;^UTILITY(U,$J,358.3,24081,1,4,0)
 ;;=4^Z89.112
 ;;^UTILITY(U,$J,358.3,24081,2)
 ;;=^5063538
 ;;^UTILITY(U,$J,358.3,24082,0)
 ;;=Z89.111^^76^1000^19
 ;;^UTILITY(U,$J,358.3,24082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24082,1,3,0)
 ;;=3^Acquired absence of right hand
 ;;^UTILITY(U,$J,358.3,24082,1,4,0)
 ;;=4^Z89.111
 ;;^UTILITY(U,$J,358.3,24082,2)
 ;;=^5063537
 ;;^UTILITY(U,$J,358.3,24083,0)
 ;;=Z89.122^^76^1000^14
 ;;^UTILITY(U,$J,358.3,24083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24083,1,3,0)
 ;;=3^Acquired absence of left wrist
 ;;^UTILITY(U,$J,358.3,24083,1,4,0)
 ;;=4^Z89.122
 ;;^UTILITY(U,$J,358.3,24083,2)
 ;;=^5063541
 ;;^UTILITY(U,$J,358.3,24084,0)
 ;;=Z89.121^^76^1000^29
 ;;^UTILITY(U,$J,358.3,24084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24084,1,3,0)
 ;;=3^Acquired absence of right wrist
 ;;^UTILITY(U,$J,358.3,24084,1,4,0)
 ;;=4^Z89.121
 ;;^UTILITY(U,$J,358.3,24084,2)
 ;;=^5063540
 ;;^UTILITY(U,$J,358.3,24085,0)
 ;;=Z89.211^^76^1000^28
 ;;^UTILITY(U,$J,358.3,24085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24085,1,3,0)
 ;;=3^Acquired absence of right upper limb below elbow
 ;;^UTILITY(U,$J,358.3,24085,1,4,0)
 ;;=4^Z89.211
 ;;^UTILITY(U,$J,358.3,24085,2)
 ;;=^5063545
 ;;^UTILITY(U,$J,358.3,24086,0)
 ;;=Z89.212^^76^1000^13
 ;;^UTILITY(U,$J,358.3,24086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24086,1,3,0)
 ;;=3^Acquired absence of left upper limb below elbow
 ;;^UTILITY(U,$J,358.3,24086,1,4,0)
 ;;=4^Z89.212
 ;;^UTILITY(U,$J,358.3,24086,2)
 ;;=^5063546
 ;;^UTILITY(U,$J,358.3,24087,0)
 ;;=Z89.221^^76^1000^27
 ;;^UTILITY(U,$J,358.3,24087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24087,1,3,0)
 ;;=3^Acquired absence of right upper limb above elbow
 ;;^UTILITY(U,$J,358.3,24087,1,4,0)
 ;;=4^Z89.221
 ;;^UTILITY(U,$J,358.3,24087,2)
 ;;=^5063548
 ;;^UTILITY(U,$J,358.3,24088,0)
 ;;=Z89.222^^76^1000^12
 ;;^UTILITY(U,$J,358.3,24088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24088,1,3,0)
 ;;=3^Acquired absence of left upper limb above elbow
 ;;^UTILITY(U,$J,358.3,24088,1,4,0)
 ;;=4^Z89.222
 ;;^UTILITY(U,$J,358.3,24088,2)
 ;;=^5063549
 ;;^UTILITY(U,$J,358.3,24089,0)
 ;;=Z89.232^^76^1000^9
 ;;^UTILITY(U,$J,358.3,24089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24089,1,3,0)
 ;;=3^Acquired absence of left shoulder
 ;;^UTILITY(U,$J,358.3,24089,1,4,0)
 ;;=4^Z89.232
 ;;^UTILITY(U,$J,358.3,24089,2)
 ;;=^5063552
 ;;^UTILITY(U,$J,358.3,24090,0)
 ;;=Z89.231^^76^1000^24
 ;;^UTILITY(U,$J,358.3,24090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24090,1,3,0)
 ;;=3^Acquired absence of right shoulder
 ;;^UTILITY(U,$J,358.3,24090,1,4,0)
 ;;=4^Z89.231
 ;;^UTILITY(U,$J,358.3,24090,2)
 ;;=^5063551
 ;;^UTILITY(U,$J,358.3,24091,0)
 ;;=Z89.611^^76^1000^21
 ;;^UTILITY(U,$J,358.3,24091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24091,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,24091,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,24091,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,24092,0)
 ;;=Z89.411^^76^1000^18
 ;;^UTILITY(U,$J,358.3,24092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24092,1,3,0)
 ;;=3^Acquired absence of right great toe
 ;;^UTILITY(U,$J,358.3,24092,1,4,0)
 ;;=4^Z89.411
 ;;^UTILITY(U,$J,358.3,24092,2)
 ;;=^5063554
 ;;^UTILITY(U,$J,358.3,24093,0)
 ;;=Z89.412^^76^1000^4
 ;;^UTILITY(U,$J,358.3,24093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24093,1,3,0)
 ;;=3^Acquired absence of left great toe
 ;;^UTILITY(U,$J,358.3,24093,1,4,0)
 ;;=4^Z89.412
 ;;^UTILITY(U,$J,358.3,24093,2)
 ;;=^5063555
 ;;^UTILITY(U,$J,358.3,24094,0)
 ;;=Z89.422^^76^1000^11
 ;;^UTILITY(U,$J,358.3,24094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24094,1,3,0)
 ;;=3^Acquired absence of left toe(s)
 ;;^UTILITY(U,$J,358.3,24094,1,4,0)
 ;;=4^Z89.422
 ;;^UTILITY(U,$J,358.3,24094,2)
 ;;=^5063558
 ;;^UTILITY(U,$J,358.3,24095,0)
 ;;=Z89.421^^76^1000^26
 ;;^UTILITY(U,$J,358.3,24095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24095,1,3,0)
 ;;=3^Acquired absence of right toe(s)
 ;;^UTILITY(U,$J,358.3,24095,1,4,0)
 ;;=4^Z89.421
 ;;^UTILITY(U,$J,358.3,24095,2)
 ;;=^5063557
 ;;^UTILITY(U,$J,358.3,24096,0)
 ;;=Z89.431^^76^1000^17
 ;;^UTILITY(U,$J,358.3,24096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24096,1,3,0)
 ;;=3^Acquired absence of right foot
 ;;^UTILITY(U,$J,358.3,24096,1,4,0)
 ;;=4^Z89.431
 ;;^UTILITY(U,$J,358.3,24096,2)
 ;;=^5063560
 ;;^UTILITY(U,$J,358.3,24097,0)
 ;;=Z89.432^^76^1000^3
 ;;^UTILITY(U,$J,358.3,24097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24097,1,3,0)
 ;;=3^Acquired absence of left foot
 ;;^UTILITY(U,$J,358.3,24097,1,4,0)
 ;;=4^Z89.432
 ;;^UTILITY(U,$J,358.3,24097,2)
 ;;=^5063561
 ;;^UTILITY(U,$J,358.3,24098,0)
 ;;=Z89.442^^76^1000^1
 ;;^UTILITY(U,$J,358.3,24098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24098,1,3,0)
 ;;=3^Acquired absence of left ankle
 ;;^UTILITY(U,$J,358.3,24098,1,4,0)
 ;;=4^Z89.442
 ;;^UTILITY(U,$J,358.3,24098,2)
 ;;=^5063564
 ;;^UTILITY(U,$J,358.3,24099,0)
 ;;=Z89.441^^76^1000^15
 ;;^UTILITY(U,$J,358.3,24099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24099,1,3,0)
 ;;=3^Acquired absence of right ankle
 ;;^UTILITY(U,$J,358.3,24099,1,4,0)
 ;;=4^Z89.441
 ;;^UTILITY(U,$J,358.3,24099,2)
 ;;=^5063563
 ;;^UTILITY(U,$J,358.3,24100,0)
 ;;=Z89.511^^76^1000^23
 ;;^UTILITY(U,$J,358.3,24100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24100,1,3,0)
 ;;=3^Acquired absence of right leg below knee
 ;;^UTILITY(U,$J,358.3,24100,1,4,0)
 ;;=4^Z89.511
 ;;^UTILITY(U,$J,358.3,24100,2)
 ;;=^5063566
 ;;^UTILITY(U,$J,358.3,24101,0)
 ;;=Z89.512^^76^1000^8
 ;;^UTILITY(U,$J,358.3,24101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24101,1,3,0)
 ;;=3^Acquired absence of left leg below knee
 ;;^UTILITY(U,$J,358.3,24101,1,4,0)
 ;;=4^Z89.512
 ;;^UTILITY(U,$J,358.3,24101,2)
 ;;=^5063567
 ;;^UTILITY(U,$J,358.3,24102,0)
 ;;=Z89.611^^76^1000^22
 ;;^UTILITY(U,$J,358.3,24102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24102,1,3,0)
 ;;=3^Acquired absence of right leg above knee
 ;;^UTILITY(U,$J,358.3,24102,1,4,0)
 ;;=4^Z89.611
 ;;^UTILITY(U,$J,358.3,24102,2)
 ;;=^5063572
 ;;^UTILITY(U,$J,358.3,24103,0)
 ;;=Z89.612^^76^1000^7
 ;;^UTILITY(U,$J,358.3,24103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24103,1,3,0)
 ;;=3^Acquired absence of left leg above knee
 ;;^UTILITY(U,$J,358.3,24103,1,4,0)
 ;;=4^Z89.612
 ;;^UTILITY(U,$J,358.3,24103,2)
 ;;=^5063573
 ;;^UTILITY(U,$J,358.3,24104,0)
 ;;=Z89.622^^76^1000^6
 ;;^UTILITY(U,$J,358.3,24104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24104,1,3,0)
 ;;=3^Acquired absence of left hip joint
 ;;^UTILITY(U,$J,358.3,24104,1,4,0)
 ;;=4^Z89.622
 ;;^UTILITY(U,$J,358.3,24104,2)
 ;;=^5063576
 ;;^UTILITY(U,$J,358.3,24105,0)
 ;;=Z89.621^^76^1000^20
 ;;^UTILITY(U,$J,358.3,24105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24105,1,3,0)
 ;;=3^Acquired absence of right hip joint
 ;;^UTILITY(U,$J,358.3,24105,1,4,0)
 ;;=4^Z89.621
 ;;^UTILITY(U,$J,358.3,24105,2)
 ;;=^5063575
 ;;^UTILITY(U,$J,358.3,24106,0)
 ;;=R47.01^^76^1001^1
 ;;^UTILITY(U,$J,358.3,24106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24106,1,3,0)
 ;;=3^Aphasia
 ;;^UTILITY(U,$J,358.3,24106,1,4,0)
 ;;=4^R47.01
 ;;^UTILITY(U,$J,358.3,24106,2)
 ;;=^5019488
 ;;^UTILITY(U,$J,358.3,24107,0)
 ;;=I69.320^^76^1001^2
 ;;^UTILITY(U,$J,358.3,24107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24107,1,3,0)
 ;;=3^Aphasia following cerebral infarction
 ;;^UTILITY(U,$J,358.3,24107,1,4,0)
 ;;=4^I69.320
 ;;^UTILITY(U,$J,358.3,24107,2)
 ;;=^5007491
 ;;^UTILITY(U,$J,358.3,24108,0)
 ;;=I69.120^^76^1001^3
 ;;^UTILITY(U,$J,358.3,24108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24108,1,3,0)
 ;;=3^Aphasia following nontraumatic intracerebral hemorrhage
 ;;^UTILITY(U,$J,358.3,24108,1,4,0)
 ;;=4^I69.120
 ;;^UTILITY(U,$J,358.3,24108,2)
 ;;=^5007427
 ;;^UTILITY(U,$J,358.3,24109,0)
 ;;=I69.020^^76^1001^4
 ;;^UTILITY(U,$J,358.3,24109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24109,1,3,0)
 ;;=3^Aphasia following nontraumatic subarachnoid hemorrhage
 ;;^UTILITY(U,$J,358.3,24109,1,4,0)
 ;;=4^I69.020
 ;;^UTILITY(U,$J,358.3,24109,2)
 ;;=^5007395
 ;;^UTILITY(U,$J,358.3,24110,0)
 ;;=I69.820^^76^1001^5
 ;;^UTILITY(U,$J,358.3,24110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24110,1,3,0)
 ;;=3^Aphasia following other cerebrovascular disease
 ;;^UTILITY(U,$J,358.3,24110,1,4,0)
 ;;=4^I69.820
 ;;^UTILITY(U,$J,358.3,24110,2)
 ;;=^5007522
 ;;^UTILITY(U,$J,358.3,24111,0)
 ;;=I69.220^^76^1001^6
 ;;^UTILITY(U,$J,358.3,24111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24111,1,3,0)
 ;;=3^Aphasia following other nontraumatic intracranial hemorrhage
