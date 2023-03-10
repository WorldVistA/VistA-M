IBDEI05R ; ; 01-AUG-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;AUG 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13915,1,3,0)
 ;;=3^Osteomyelitis,Acute Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,13915,1,4,0)
 ;;=4^M86.00
 ;;^UTILITY(U,$J,358.3,13915,2)
 ;;=^5014497
 ;;^UTILITY(U,$J,358.3,13916,0)
 ;;=M86.50^^53^590^104
 ;;^UTILITY(U,$J,358.3,13916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13916,1,3,0)
 ;;=3^Osteomyelitis,Chronic Hematogenous,Unspec Site
 ;;^UTILITY(U,$J,358.3,13916,1,4,0)
 ;;=4^M86.50
 ;;^UTILITY(U,$J,358.3,13916,2)
 ;;=^5014607
 ;;^UTILITY(U,$J,358.3,13917,0)
 ;;=M86.30^^53^590^105
 ;;^UTILITY(U,$J,358.3,13917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13917,1,3,0)
 ;;=3^Osteomyelitis,Chronic Multifocal,Unspec Site
 ;;^UTILITY(U,$J,358.3,13917,1,4,0)
 ;;=4^M86.30
 ;;^UTILITY(U,$J,358.3,13917,2)
 ;;=^5014559
 ;;^UTILITY(U,$J,358.3,13918,0)
 ;;=M86.20^^53^590^106
 ;;^UTILITY(U,$J,358.3,13918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13918,1,3,0)
 ;;=3^Osteomyelitis,Subacute,Unspec Site
 ;;^UTILITY(U,$J,358.3,13918,1,4,0)
 ;;=4^M86.20
 ;;^UTILITY(U,$J,358.3,13918,2)
 ;;=^5014535
 ;;^UTILITY(U,$J,358.3,13919,0)
 ;;=M86.8X9^^53^590^107
 ;;^UTILITY(U,$J,358.3,13919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13919,1,3,0)
 ;;=3^Osteomyelitis,Unspec Sites
 ;;^UTILITY(U,$J,358.3,13919,1,4,0)
 ;;=4^M86.8X9
 ;;^UTILITY(U,$J,358.3,13919,2)
 ;;=^5014655
 ;;^UTILITY(U,$J,358.3,13920,0)
 ;;=N73.5^^53^590^110
 ;;^UTILITY(U,$J,358.3,13920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13920,1,3,0)
 ;;=3^Peritonitis,Female Pelvic,Unspec
 ;;^UTILITY(U,$J,358.3,13920,1,4,0)
 ;;=4^N73.5
 ;;^UTILITY(U,$J,358.3,13920,2)
 ;;=^5015817
 ;;^UTILITY(U,$J,358.3,13921,0)
 ;;=M00.10^^53^590^111
 ;;^UTILITY(U,$J,358.3,13921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13921,1,3,0)
 ;;=3^Pneumococcal Arthritis,Unspec Joint
 ;;^UTILITY(U,$J,358.3,13921,1,4,0)
 ;;=4^M00.10
 ;;^UTILITY(U,$J,358.3,13921,2)
 ;;=^5009621
 ;;^UTILITY(U,$J,358.3,13922,0)
 ;;=A92.5^^53^590^181
 ;;^UTILITY(U,$J,358.3,13922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13922,1,3,0)
 ;;=3^Zika Virus Disease (Confirmed)
 ;;^UTILITY(U,$J,358.3,13922,1,4,0)
 ;;=4^A92.5
 ;;^UTILITY(U,$J,358.3,13922,2)
 ;;=^7006765
 ;;^UTILITY(U,$J,358.3,13923,0)
 ;;=R78.81^^53^590^7
 ;;^UTILITY(U,$J,358.3,13923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13923,1,3,0)
 ;;=3^Bacteremia
 ;;^UTILITY(U,$J,358.3,13923,1,4,0)
 ;;=4^R78.81
 ;;^UTILITY(U,$J,358.3,13923,2)
 ;;=^12280
 ;;^UTILITY(U,$J,358.3,13924,0)
 ;;=J15.9^^53^590^113
 ;;^UTILITY(U,$J,358.3,13924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13924,1,3,0)
 ;;=3^Pneumonia, Bacterial,Unspec
 ;;^UTILITY(U,$J,358.3,13924,1,4,0)
 ;;=4^J15.9
 ;;^UTILITY(U,$J,358.3,13924,2)
 ;;=^5008178
 ;;^UTILITY(U,$J,358.3,13925,0)
 ;;=J95.851^^53^590^118
 ;;^UTILITY(U,$J,358.3,13925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13925,1,3,0)
 ;;=3^Pneumonia, Vent-Associated
 ;;^UTILITY(U,$J,358.3,13925,1,4,0)
 ;;=4^J95.851
 ;;^UTILITY(U,$J,358.3,13925,2)
 ;;=^336692
 ;;^UTILITY(U,$J,358.3,13926,0)
 ;;=J12.9^^53^590^119
 ;;^UTILITY(U,$J,358.3,13926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13926,1,3,0)
 ;;=3^Pneumonia, Viral,Unspec
 ;;^UTILITY(U,$J,358.3,13926,1,4,0)
 ;;=4^J12.9
 ;;^UTILITY(U,$J,358.3,13926,2)
 ;;=^5008169
 ;;^UTILITY(U,$J,358.3,13927,0)
 ;;=J69.0^^53^590^120
 ;;^UTILITY(U,$J,358.3,13927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13927,1,3,0)
 ;;=3^Pneumonitis,Aspiration,Unspec
 ;;^UTILITY(U,$J,358.3,13927,1,4,0)
 ;;=4^J69.0
 ;;^UTILITY(U,$J,358.3,13927,2)
 ;;=^5008288
 ;;^UTILITY(U,$J,358.3,13928,0)
 ;;=T85.79XA^^53^590^135
 ;;^UTILITY(U,$J,358.3,13928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13928,1,3,0)
 ;;=3^Sepsis d/t Device,Implant or Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,13928,1,4,0)
 ;;=4^T85.79XA
 ;;^UTILITY(U,$J,358.3,13928,2)
 ;;=^5055676
 ;;^UTILITY(U,$J,358.3,13929,0)
 ;;=A41.9^^53^590^136
 ;;^UTILITY(U,$J,358.3,13929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13929,1,3,0)
 ;;=3^Sepsis d/t Urinary Source
 ;;^UTILITY(U,$J,358.3,13929,1,4,0)
 ;;=4^A41.9
 ;;^UTILITY(U,$J,358.3,13929,2)
 ;;=^5000214^N39.0
 ;;^UTILITY(U,$J,358.3,13930,0)
 ;;=R65.21^^53^590^140
 ;;^UTILITY(U,$J,358.3,13930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13930,1,3,0)
 ;;=3^Septic Shock d/t Severe Sepsis
 ;;^UTILITY(U,$J,358.3,13930,1,4,0)
 ;;=4^R65.21
 ;;^UTILITY(U,$J,358.3,13930,2)
 ;;=^5019548
 ;;^UTILITY(U,$J,358.3,13931,0)
 ;;=T83.511A^^53^590^174
 ;;^UTILITY(U,$J,358.3,13931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13931,1,3,0)
 ;;=3^UTI d/t Indwelling Urethral Catheter,Init Encntr
 ;;^UTILITY(U,$J,358.3,13931,1,4,0)
 ;;=4^T83.511A
 ;;^UTILITY(U,$J,358.3,13931,2)
 ;;=^5140138
 ;;^UTILITY(U,$J,358.3,13932,0)
 ;;=T83.511D^^53^590^173
 ;;^UTILITY(U,$J,358.3,13932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13932,1,3,0)
 ;;=3^UTI d/t Indwelling Urethral Catheter,Healing/Subs
 ;;^UTILITY(U,$J,358.3,13932,1,4,0)
 ;;=4^T83.511D
 ;;^UTILITY(U,$J,358.3,13932,2)
 ;;=^5140139
 ;;^UTILITY(U,$J,358.3,13933,0)
 ;;=T83.511S^^53^590^175
 ;;^UTILITY(U,$J,358.3,13933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13933,1,3,0)
 ;;=3^UTI d/t Indwelling Urethral Catheter,Sequela
 ;;^UTILITY(U,$J,358.3,13933,1,4,0)
 ;;=4^T83.511S
 ;;^UTILITY(U,$J,358.3,13933,2)
 ;;=^5140140
 ;;^UTILITY(U,$J,358.3,13934,0)
 ;;=A04.71^^53^590^26
 ;;^UTILITY(U,$J,358.3,13934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13934,1,3,0)
 ;;=3^Colitis,C. Difficile,Recurrent
 ;;^UTILITY(U,$J,358.3,13934,1,4,0)
 ;;=4^A04.71
 ;;^UTILITY(U,$J,358.3,13934,2)
 ;;=^5151291
 ;;^UTILITY(U,$J,358.3,13935,0)
 ;;=A04.72^^53^590^25
 ;;^UTILITY(U,$J,358.3,13935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13935,1,3,0)
 ;;=3^Colitis,C. Difficile,Not Spec as Recurrent
 ;;^UTILITY(U,$J,358.3,13935,1,4,0)
 ;;=4^A04.72
 ;;^UTILITY(U,$J,358.3,13935,2)
 ;;=^5151292
 ;;^UTILITY(U,$J,358.3,13936,0)
 ;;=T81.40XD^^53^590^66
 ;;^UTILITY(U,$J,358.3,13936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13936,1,3,0)
 ;;=3^Infect Following Proced,Unspec,Subs
 ;;^UTILITY(U,$J,358.3,13936,1,4,0)
 ;;=4^T81.40XD
 ;;^UTILITY(U,$J,358.3,13936,2)
 ;;=^5157585
 ;;^UTILITY(U,$J,358.3,13937,0)
 ;;=T81.40XS^^53^590^65
 ;;^UTILITY(U,$J,358.3,13937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13937,1,3,0)
 ;;=3^Infect Following Proced,Unspec,Sequela
 ;;^UTILITY(U,$J,358.3,13937,1,4,0)
 ;;=4^T81.40XS
 ;;^UTILITY(U,$J,358.3,13937,2)
 ;;=^5157586
 ;;^UTILITY(U,$J,358.3,13938,0)
 ;;=T81.41XA^^53^590^60
 ;;^UTILITY(U,$J,358.3,13938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13938,1,3,0)
 ;;=3^Infect Following Proced,Superfic Incis Surg Site,Init
 ;;^UTILITY(U,$J,358.3,13938,1,4,0)
 ;;=4^T81.41XA
 ;;^UTILITY(U,$J,358.3,13938,2)
 ;;=^5157587
 ;;^UTILITY(U,$J,358.3,13939,0)
 ;;=T81.41XD^^53^590^61
 ;;^UTILITY(U,$J,358.3,13939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13939,1,3,0)
 ;;=3^Infect Following Proced,Superfic Incis Surg Site,Subs
 ;;^UTILITY(U,$J,358.3,13939,1,4,0)
 ;;=4^T81.41XD
 ;;^UTILITY(U,$J,358.3,13939,2)
 ;;=^5157588
 ;;^UTILITY(U,$J,358.3,13940,0)
 ;;=T81.42XD^^53^590^52
 ;;^UTILITY(U,$J,358.3,13940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13940,1,3,0)
 ;;=3^Infect Following Proced,Deep Incis Surg Site,Subs
 ;;^UTILITY(U,$J,358.3,13940,1,4,0)
 ;;=4^T81.42XD
 ;;^UTILITY(U,$J,358.3,13940,2)
 ;;=^5157591
 ;;^UTILITY(U,$J,358.3,13941,0)
 ;;=T81.42XA^^53^590^51
 ;;^UTILITY(U,$J,358.3,13941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13941,1,3,0)
 ;;=3^Infect Following Proced,Deep Incis Surg Site,Init
 ;;^UTILITY(U,$J,358.3,13941,1,4,0)
 ;;=4^T81.42XA
 ;;^UTILITY(U,$J,358.3,13941,2)
 ;;=^5157590
 ;;^UTILITY(U,$J,358.3,13942,0)
 ;;=T81.42XS^^53^590^53
 ;;^UTILITY(U,$J,358.3,13942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13942,1,3,0)
 ;;=3^Infect Following Proced,Deep Incis Surg Site,Sequela
 ;;^UTILITY(U,$J,358.3,13942,1,4,0)
 ;;=4^T81.42XS
 ;;^UTILITY(U,$J,358.3,13942,2)
 ;;=^5157592
 ;;^UTILITY(U,$J,358.3,13943,0)
 ;;=T81.43XA^^53^590^54
 ;;^UTILITY(U,$J,358.3,13943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13943,1,3,0)
 ;;=3^Infect Following Proced,Organ/Space Surg Site,Init
 ;;^UTILITY(U,$J,358.3,13943,1,4,0)
 ;;=4^T81.43XA
 ;;^UTILITY(U,$J,358.3,13943,2)
 ;;=^5157593
 ;;^UTILITY(U,$J,358.3,13944,0)
 ;;=T81.43XD^^53^590^55
 ;;^UTILITY(U,$J,358.3,13944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13944,1,3,0)
 ;;=3^Infect Following Proced,Organ/Space Surg Site,Subs
 ;;^UTILITY(U,$J,358.3,13944,1,4,0)
 ;;=4^T81.43XD
 ;;^UTILITY(U,$J,358.3,13944,2)
 ;;=^5157594
 ;;^UTILITY(U,$J,358.3,13945,0)
 ;;=T81.43XS^^53^590^56
 ;;^UTILITY(U,$J,358.3,13945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13945,1,3,0)
 ;;=3^Infect Following Proced,Organ/Space Surg Site,Sequela
 ;;^UTILITY(U,$J,358.3,13945,1,4,0)
 ;;=4^T81.43XS
 ;;^UTILITY(U,$J,358.3,13945,2)
 ;;=^5157595
 ;;^UTILITY(U,$J,358.3,13946,0)
 ;;=T81.49XA^^53^590^57
 ;;^UTILITY(U,$J,358.3,13946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13946,1,3,0)
 ;;=3^Infect Following Proced,Oth Surg Site,Init
 ;;^UTILITY(U,$J,358.3,13946,1,4,0)
 ;;=4^T81.49XA
 ;;^UTILITY(U,$J,358.3,13946,2)
 ;;=^5157599
 ;;^UTILITY(U,$J,358.3,13947,0)
 ;;=T81.49XD^^53^590^58
 ;;^UTILITY(U,$J,358.3,13947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13947,1,3,0)
 ;;=3^Infect Following Proced,Oth Surg Site,Subs
 ;;^UTILITY(U,$J,358.3,13947,1,4,0)
 ;;=4^T81.49XD
 ;;^UTILITY(U,$J,358.3,13947,2)
 ;;=^5157600
 ;;^UTILITY(U,$J,358.3,13948,0)
 ;;=T81.49XS^^53^590^59
 ;;^UTILITY(U,$J,358.3,13948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13948,1,3,0)
 ;;=3^Infect Following Proced,Oth Surg Site,Sequela
 ;;^UTILITY(U,$J,358.3,13948,1,4,0)
 ;;=4^T81.49XS
 ;;^UTILITY(U,$J,358.3,13948,2)
 ;;=^5157601
 ;;^UTILITY(U,$J,358.3,13949,0)
 ;;=T81.44XA^^53^590^132
 ;;^UTILITY(U,$J,358.3,13949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13949,1,3,0)
 ;;=3^Sepsis Following Proced,Init
 ;;^UTILITY(U,$J,358.3,13949,1,4,0)
 ;;=4^T81.44XA
 ;;^UTILITY(U,$J,358.3,13949,2)
 ;;=^5157596
 ;;^UTILITY(U,$J,358.3,13950,0)
 ;;=T81.44XD^^53^590^134
 ;;^UTILITY(U,$J,358.3,13950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13950,1,3,0)
 ;;=3^Sepsis Following Proced,Subs
 ;;^UTILITY(U,$J,358.3,13950,1,4,0)
 ;;=4^T81.44XD
 ;;^UTILITY(U,$J,358.3,13950,2)
 ;;=^5157597
 ;;^UTILITY(U,$J,358.3,13951,0)
 ;;=T81.44XS^^53^590^133
 ;;^UTILITY(U,$J,358.3,13951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13951,1,3,0)
 ;;=3^Sepsis Following Proced,Sequela
 ;;^UTILITY(U,$J,358.3,13951,1,4,0)
 ;;=4^T81.44XS
 ;;^UTILITY(U,$J,358.3,13951,2)
 ;;=^5157598
 ;;^UTILITY(U,$J,358.3,13952,0)
 ;;=T81.41XS^^53^590^63
 ;;^UTILITY(U,$J,358.3,13952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13952,1,3,0)
 ;;=3^Infect Following Proced,Superfic Incis Surg Site,Sequela
 ;;^UTILITY(U,$J,358.3,13952,1,4,0)
 ;;=4^T81.41XS
 ;;^UTILITY(U,$J,358.3,13952,2)
 ;;=^5157589
 ;;^UTILITY(U,$J,358.3,13953,0)
 ;;=T81.40XA^^53^590^64
 ;;^UTILITY(U,$J,358.3,13953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13953,1,3,0)
 ;;=3^Infect Following Proced,Unspec,Init
 ;;^UTILITY(U,$J,358.3,13953,1,4,0)
 ;;=4^T81.40XA
 ;;^UTILITY(U,$J,358.3,13953,2)
 ;;=^5157584
 ;;^UTILITY(U,$J,358.3,13954,0)
 ;;=F10.10^^53^591^7
 ;;^UTILITY(U,$J,358.3,13954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13954,1,3,0)
 ;;=3^Alcohol Use Disorder,Mild
 ;;^UTILITY(U,$J,358.3,13954,1,4,0)
 ;;=4^F10.10
 ;;^UTILITY(U,$J,358.3,13954,2)
 ;;=^5003068
 ;;^UTILITY(U,$J,358.3,13955,0)
 ;;=F10.14^^53^591^17
 ;;^UTILITY(U,$J,358.3,13955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13955,1,3,0)
 ;;=3^Alcohol-Induced Bipolar & Related Disorder/Depressive Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13955,1,4,0)
 ;;=4^F10.14
 ;;^UTILITY(U,$J,358.3,13955,2)
 ;;=^5003072
 ;;^UTILITY(U,$J,358.3,13956,0)
 ;;=F10.182^^53^591^19
 ;;^UTILITY(U,$J,358.3,13956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13956,1,3,0)
 ;;=3^Alcohol-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13956,1,4,0)
 ;;=4^F10.182
 ;;^UTILITY(U,$J,358.3,13956,2)
 ;;=^5003078
 ;;^UTILITY(U,$J,358.3,13957,0)
 ;;=F10.20^^53^591^8
 ;;^UTILITY(U,$J,358.3,13957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13957,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,13957,1,4,0)
 ;;=4^F10.20
 ;;^UTILITY(U,$J,358.3,13957,2)
 ;;=^5003081
 ;;^UTILITY(U,$J,358.3,13958,0)
 ;;=F10.21^^53^591^9
 ;;^UTILITY(U,$J,358.3,13958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13958,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,13958,1,4,0)
 ;;=4^F10.21
 ;;^UTILITY(U,$J,358.3,13958,2)
 ;;=^5003082
 ;;^UTILITY(U,$J,358.3,13959,0)
 ;;=F10.230^^53^591^10
 ;;^UTILITY(U,$J,358.3,13959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13959,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal
 ;;^UTILITY(U,$J,358.3,13959,1,4,0)
 ;;=4^F10.230
 ;;^UTILITY(U,$J,358.3,13959,2)
 ;;=^5003086
 ;;^UTILITY(U,$J,358.3,13960,0)
 ;;=F10.231^^53^591^11
 ;;^UTILITY(U,$J,358.3,13960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13960,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,13960,1,4,0)
 ;;=4^F10.231
 ;;^UTILITY(U,$J,358.3,13960,2)
 ;;=^5003087
 ;;^UTILITY(U,$J,358.3,13961,0)
 ;;=F10.232^^53^591^12
 ;;^UTILITY(U,$J,358.3,13961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13961,1,3,0)
 ;;=3^Alcohol Use Disorder,Moderate-Severe w/ Withdrawal Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,13961,1,4,0)
 ;;=4^F10.232
 ;;^UTILITY(U,$J,358.3,13961,2)
 ;;=^5003088
 ;;^UTILITY(U,$J,358.3,13962,0)
 ;;=F10.239^^53^591^6
 ;;^UTILITY(U,$J,358.3,13962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13962,1,3,0)
 ;;=3^Alcohol Dependence w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,13962,1,4,0)
 ;;=4^F10.239
 ;;^UTILITY(U,$J,358.3,13962,2)
 ;;=^5003089
 ;;^UTILITY(U,$J,358.3,13963,0)
 ;;=F10.24^^53^591^18
 ;;^UTILITY(U,$J,358.3,13963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13963,1,3,0)
 ;;=3^Alcohol-Induced Depressive & Related Disorder w/ Moderate-Severe Use Disorder
 ;;^UTILITY(U,$J,358.3,13963,1,4,0)
 ;;=4^F10.24
 ;;^UTILITY(U,$J,358.3,13963,2)
 ;;=^5003090
 ;;^UTILITY(U,$J,358.3,13964,0)
 ;;=F10.29^^53^591^20
 ;;^UTILITY(U,$J,358.3,13964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13964,1,3,0)
 ;;=3^Alcohol-Related Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,13964,1,4,0)
 ;;=4^F10.29
 ;;^UTILITY(U,$J,358.3,13964,2)
 ;;=^5003100
 ;;^UTILITY(U,$J,358.3,13965,0)
 ;;=F10.11^^53^591^5
 ;;^UTILITY(U,$J,358.3,13965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13965,1,3,0)
 ;;=3^Alcohol Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,13965,1,4,0)
 ;;=4^F10.11
 ;;^UTILITY(U,$J,358.3,13965,2)
 ;;=^268230
 ;;^UTILITY(U,$J,358.3,13966,0)
 ;;=F10.130^^53^591^3
 ;;^UTILITY(U,$J,358.3,13966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13966,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Uncomplicated
 ;;^UTILITY(U,$J,358.3,13966,1,4,0)
 ;;=4^F10.130
 ;;^UTILITY(U,$J,358.3,13966,2)
 ;;=^5159130
 ;;^UTILITY(U,$J,358.3,13967,0)
 ;;=F10.131^^53^591^1
 ;;^UTILITY(U,$J,358.3,13967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13967,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal Delirium
 ;;^UTILITY(U,$J,358.3,13967,1,4,0)
 ;;=4^F10.131
 ;;^UTILITY(U,$J,358.3,13967,2)
 ;;=^5159131
 ;;^UTILITY(U,$J,358.3,13968,0)
 ;;=F10.132^^53^591^2
 ;;^UTILITY(U,$J,358.3,13968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13968,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal Perceptual Disturbance
 ;;^UTILITY(U,$J,358.3,13968,1,4,0)
 ;;=4^F10.132
 ;;^UTILITY(U,$J,358.3,13968,2)
 ;;=^5159132
 ;;^UTILITY(U,$J,358.3,13969,0)
 ;;=F10.139^^53^591^4
 ;;^UTILITY(U,$J,358.3,13969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13969,1,3,0)
 ;;=3^Alcohol Abuse w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,13969,1,4,0)
 ;;=4^F10.139
 ;;^UTILITY(U,$J,358.3,13969,2)
 ;;=^5159133
 ;;^UTILITY(U,$J,358.3,13970,0)
 ;;=F10.930^^53^591^15
 ;;^UTILITY(U,$J,358.3,13970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13970,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Uncomplicated
 ;;^UTILITY(U,$J,358.3,13970,1,4,0)
 ;;=4^F10.930
 ;;^UTILITY(U,$J,358.3,13970,2)
 ;;=^5159134
 ;;^UTILITY(U,$J,358.3,13971,0)
 ;;=F10.931^^53^591^13
 ;;^UTILITY(U,$J,358.3,13971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13971,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Delirium
 ;;^UTILITY(U,$J,358.3,13971,1,4,0)
 ;;=4^F10.931
 ;;^UTILITY(U,$J,358.3,13971,2)
 ;;=^5159135
 ;;^UTILITY(U,$J,358.3,13972,0)
 ;;=F10.932^^53^591^14
 ;;^UTILITY(U,$J,358.3,13972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13972,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Perceptual Disturbances
 ;;^UTILITY(U,$J,358.3,13972,1,4,0)
 ;;=4^F10.932
 ;;^UTILITY(U,$J,358.3,13972,2)
 ;;=^5159136
 ;;^UTILITY(U,$J,358.3,13973,0)
 ;;=F10.939^^53^591^16
 ;;^UTILITY(U,$J,358.3,13973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13973,1,3,0)
 ;;=3^Alcohol Use,Unspec w/ Withdrawal,Unspec
 ;;^UTILITY(U,$J,358.3,13973,1,4,0)
 ;;=4^F10.939
 ;;^UTILITY(U,$J,358.3,13973,2)
 ;;=^5159137
 ;;^UTILITY(U,$J,358.3,13974,0)
 ;;=F15.10^^53^592^5
 ;;^UTILITY(U,$J,358.3,13974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13974,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Mild
 ;;^UTILITY(U,$J,358.3,13974,1,4,0)
 ;;=4^F15.10
 ;;^UTILITY(U,$J,358.3,13974,2)
 ;;=^5003282
 ;;^UTILITY(U,$J,358.3,13975,0)
 ;;=F15.14^^53^592^3
 ;;^UTILITY(U,$J,358.3,13975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13975,1,3,0)
 ;;=3^Amphetamine-Induced Depressive,Bipolar & Related Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13975,1,4,0)
 ;;=4^F15.14
 ;;^UTILITY(U,$J,358.3,13975,2)
 ;;=^5003287
 ;;^UTILITY(U,$J,358.3,13976,0)
 ;;=F15.182^^53^592^4
 ;;^UTILITY(U,$J,358.3,13976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13976,1,3,0)
 ;;=3^Amphetamine-Induced Sleep Disorder w/ Mild Use Disorder
 ;;^UTILITY(U,$J,358.3,13976,1,4,0)
 ;;=4^F15.182
 ;;^UTILITY(U,$J,358.3,13976,2)
 ;;=^5003293
 ;;^UTILITY(U,$J,358.3,13977,0)
 ;;=F15.20^^53^592^6
 ;;^UTILITY(U,$J,358.3,13977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13977,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe
 ;;^UTILITY(U,$J,358.3,13977,1,4,0)
 ;;=4^F15.20
 ;;^UTILITY(U,$J,358.3,13977,2)
 ;;=^5003295
 ;;^UTILITY(U,$J,358.3,13978,0)
 ;;=F15.21^^53^592^7
 ;;^UTILITY(U,$J,358.3,13978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13978,1,3,0)
 ;;=3^Amphetamine-Type Disorder,Moderate-Severe In Remission
 ;;^UTILITY(U,$J,358.3,13978,1,4,0)
 ;;=4^F15.21
 ;;^UTILITY(U,$J,358.3,13978,2)
 ;;=^5003296
 ;;^UTILITY(U,$J,358.3,13979,0)
 ;;=F15.23^^53^592^2
 ;;^UTILITY(U,$J,358.3,13979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13979,1,3,0)
 ;;=3^Amphetamine or Other Stimulant Withdrawal
 ;;^UTILITY(U,$J,358.3,13979,1,4,0)
 ;;=4^F15.23
 ;;^UTILITY(U,$J,358.3,13979,2)
 ;;=^5003301
 ;;^UTILITY(U,$J,358.3,13980,0)
 ;;=F15.11^^53^592^1
 ;;^UTILITY(U,$J,358.3,13980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,13980,1,3,0)
 ;;=3^Amphetamine or Other Stimulalant Abuse,In Remission
 ;;^UTILITY(U,$J,358.3,13980,1,4,0)
 ;;=4^F15.11
 ;;^UTILITY(U,$J,358.3,13980,2)
 ;;=^5151304
