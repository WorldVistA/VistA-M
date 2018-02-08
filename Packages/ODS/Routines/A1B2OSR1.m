A1B2OSR1 ;ALB/AAS - ODS SUMMARY REPORT - COLLECT DATA ; 11-JAN-91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
 K ^UTILITY($J)
 D DATA Q
 ;
DATA ;  -- collect admission data
 S A=A1B2BDT-.00001
 F I=A:0 S A=$O(^A1B2(11500.2,"B",A)) Q:'A!(A>(A1B2EDT+.9))  F M=0:0 S M=$O(^A1B2(11500.2,"B",A,M)) Q:'M  I M,$D(^A1B2(11500.2,M,0)) S N=^(0) D FAC,ADM
 ;
 ;  --collect discharge data
 S D=A1B2BDT-.00001
 F I=D:0 S D=$O(^A1B2(11500.2,"ADS",D)) Q:'D!(D>(A1B2EDT+.9))  F M=0:0 S M=$O(^A1B2(11500.2,"ADS",D,M)) Q:'M  I M,$D(^A1B2(11500.2,M,0)) S N=^(0) D FAC,DIS
 ;
 ;  -- collect patients remaining
 S P=""
 F I=0:0 S P=$O(^A1B2(11500.2,"B",P)) Q:'P!(P>(A1B2EDT+.9))  F M=0:0 S M=$O(^A1B2(11500.2,"B",P,M)) Q:'M  I M,$D(^A1B2(11500.2,M,0)) S N=^(0) D FAC I $S($P(N,"^",6)="":1,($P(N,"^",6)>(A1B2EDT+.9)):1,1:0) D PTRM
 ;
 ;  -- collect data on VA patients transfered to other facilities
 S T=A1B2BDT-.0001
 F I=T:0 S T=$O(^A1B2(11500.3,"B",T)) Q:'T!(T>(A1B2EDT+.9))  F M=0:0 S M=$O(^A1B2(11500.3,"B",T,M)) Q:'M  I M,$D(^A1B2(11500.3,M,0)) S N=^(0) D FAC,TRF
 Q
 ;
ADM ;  -- count total admissions
 Q:FAC=""!('A1B2CHK)
 S DFN=$P(N,"^",2) Q:'DFN!('$P(N,"^",15))
 S BOS=$S('DFN:"",'$D(^A1B2(11500.1,DFN,0)):"",1:$P(^(0),"^",4))
 S SPC=$S('$P(N,"^",3):"",'$D(^DIC(42.4,$P(N,"^",3),0)):"",1:$P(^(0),"^",3))
 S:'$D(^UTILITY($J,"ODS-ADM",FAC)) ^(FAC)=0 S ^(FAC)=^(FAC)+1
 S:'$D(^UTILITY($J,"ODS-ADM-NAT")) ^("ODS-ADM-NAT")=0 S ^("ODS-ADM-NAT")=^("ODS-ADM-NAT")+1
 ;
 ;  -- count unique admissions
 I '$D(^UTILITY($J,"ODS-PT-ADM",DFN,FAC)) S:'$D(^UTILITY($J,"ODS-UNQ-ADM",FAC)) ^(FAC)=0 S ^(FAC)=^(FAC)+1
 I '$D(^UTILITY($J,"ODS-PT-ADM",DFN)) S:'$D(^UTILITY($J,"ODS-UNQ-ADM-NAT")) ^("ODS-UNQ-ADM-NAT")=0 S ^("ODS-UNQ-ADM-NAT")=^("ODS-UNQ-ADM-NAT")+1
 ;
 ;  -- count unique admssions by branch of service
 I BOS]"",'$D(^UTILITY($J,"ODS-PT-ADM-BOS",BOS,DFN,FAC)) S:'$D(^UTILITY($J,"ODS-UNQA-BOS",FAC,BOS)) ^(BOS)=0 S ^(BOS)=^(BOS)+1
 I BOS]"",'$D(^UTILITY($J,"ODS-PT-ADM-BOS",BOS,DFN)) S:'$D(^UTILITY($J,"ODS-UNQA-BOS-NAT",BOS)) ^(BOS)=0 S ^(BOS)=^(BOS)+1
 ;
 ;  -- count unique admissions by specialty
 I SPC]"",'$D(^UTILITY($J,"ODS-PT-ADM-SPC",SPC,DFN,FAC)) S:'$D(^UTILITY($J,"ODS-UNQA-SPC",FAC,SPC)) ^(SPC)=0 S ^(SPC)=^(SPC)+1
 I SPC]"",'$D(^UTILITY($J,"ODS-PT-ADM-SPC",SPC,DFN)) S:'$D(^UTILITY($J,"ODS-UNQA-SPC-NAT",SPC)) ^(SPC)=0 S ^(SPC)=^(SPC)+1
 ;
 ;   - store unique indicator
 S ^UTILITY($J,"ODS-PT-ADM",DFN,FAC)=""
 I BOS]"" S ^UTILITY($J,"ODS-PT-ADM-BOS",BOS,DFN,FAC)=""
 I SPC]"" S ^UTILITY($J,"ODS-PT-ADM-SPC",SPC,DFN,FAC)=""
 Q
 ;
DIS ;  -- count total discharges
 Q:FAC=""!('$P(N,"^",15))!('A1B2CHK)
 S:'$D(^UTILITY($J,"ODS-DIS",FAC)) ^(FAC)=0 S ^(FAC)=^(FAC)+1
 S:'$D(^UTILITY($J,"ODS-DIS-NAT")) ^("ODS-DIS-NAT")=0 S ^("ODS-DIS-NAT")=("ODS-DIS-NAT")+1
 Q:'$P(N,"^",11)
 ;  -- count transfers to non-va facilities
 S:'$D(^UTILITY($J,"ODS-TRF-NVA",FAC)) ^(FAC)=0 S ^(FAC)=^(FAC)+1
 S:'$D(^UTILITY($J,"ODS-TRF-NVA-NAT")) ^("ODS-TRF-NVA-NAT")=0 S ^("ODS-TRF-NVA-NAT")=^("ODS-TRF-NVA-NAT")+1
 Q
 ;
PTRM ;  -- count patients remaining
 Q:FAC=""!('$P(N,"^",15))!('A1B2CHK)
 S:'$D(^UTILITY($J,"ODS-PTRM",FAC)) ^(FAC)=0 S ^(FAC)=^(FAC)+1
 S:'$D(^UTILITY($J,"ODS-PTRM-NAT")) ^("ODS-PTRM-NAT")=0 S ^("ODS-PTRM-NAT")=^("ODS-PTRM-NAT")+1
 Q
 ;
TRF ;  -- count patient transfers
 Q:FAC=""!('$P(N,"^",15))!($P(N,"^",11)="")!('A1B2CHK)
 S TYP=$P(N,"^",11),SUBS=$S(TYP:"ODS-DISP-NVA",1:"ODS-DISP-VA")
 S:'$D(^UTILITY($J,SUBS,FAC)) ^(FAC)=0 S ^(FAC)=^(FAC)+1
 S SUBS=SUBS_"-NAT"
 S:'$D(^UTILITY($J,SUBS)) ^(SUBS)=0 S ^(SUBS)=^(SUBS)+1
 Q
 ;
FAC ;  --set up facility number/name
 S FAC=$P(N,"^",7) Q:FAC=""!('$P(N,"^",15))
 S A1B2CHK=0,X=$S($D(A1B2NTY):$P(A1B2NTY,U,2),1:"")
 I $S(X=""!(X="A"):1,X="R":$P(N,U,9)=A1B2VRG,X="V":$P(N,U,7)=A1B2FN,1:0) S A1B2CHK=1
 Q:'A1B2CHK
 I '$D(^UTILITY($J,"ODS-FAC",FAC)) S ^UTILITY($J,"ODS-FAC",FAC)=$P(N,"^",8)
 Q
