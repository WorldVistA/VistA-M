PSJPDAPP ;BIR/MHA - SEND APPOINTMENTS TO PADE ;11/27/15
 ;;5.0;INPATIENT MEDICATIONS;**317**;16 DEC 97;Build 130
 ;Reference to ^PS(55 is supported by DBIA 2191
 ;Reference to ^ORD(101 supported by DBIA 872
 ;Reference to GETPLIST^SDAMA202 supported by DBIA 3869
 ;Reference to ^SC supported by DBIA 10040
 ;Reference to ^DPT supported by DBIA 10035
 Q
 ;
EN ;
 N PDA,PDCL,PDCLA,PDI,PDJ,PDK,PSJAP,PSJCLPD,PSJPDNM,PSJDIV,DTP,SA,SEQ,I,J,K,L,P,X,Y,Z,PSJNIP,X1,X2
 S (DTP,PSJAP,I)=0
 F  S I=$O(^PS(58.7,I)) Q:'I  S J=$$PDACT^PSJPDCLA(I)
 Q:'PSJAP
 S I=0 F  S I=$O(PSJAP(I)) Q:'I  D
 . S DTP=+$G(^PS(58.7,I,1))
 . S J=0 F  S J=$O(^PS(58.7,I,"DIV",J)) Q:'J  D
 .. S Y=$G(^PS(58.7,I,"DIV",J,0)) I Y=""!($P(Y,"^",2)&($P(Y,"^",2)<DT)) Q
 .. S SA=""
 .. I $P(Y,"^",9)="Y" S:$P(Y,"^",4) SA=$P($G(^PS(58.71,$P(Y,"^",4),0)),"^") D ALLCLN   ;send appt for all clinics
 .. D CLARR
 M PDCL=PDCLA
 Q:'$D(PDCL)
 N SNM,CNM S SNM="PSJ SIU-S12 SERVER",CNM="PSJ SIU-S12 CLIENT"
 I '$O(^ORD(101,"B",SNM,0))!('$O(^ORD(101,"B",CNM,0))) Q
 N NHL D INIT^HLFNC2(SNM,.NHL) Q:$D(NHL)=1
 N NFS,NECH,HL,HLFS,NSEG,EDT,APT,DFN,PSJDTM,PSJND,PSJVP,PSJVNM,PSJDNS,PSJDNM,PSJOR,PSJORN
 M HL=NHL S (NFS,HLFS)=HL("FS"),NECH=$E(HL("ECH"),1)
 S PDI=0 F  S PDI=$O(PDCL(PDI)) Q:'PDI  D
 . S PSJND=$G(^PS(58.7,PDI,0))
 . S PSJVNM=$P(PSJND,"^"),PSJDNS=$P(PSJND,"^",2),PSJVP=$P(PSJND,"^",3)
 . S PDJ=0 F  S PDJ=$O(PDCL(PDI,PDJ)) Q:'PDJ  D
 .. S PSJDNM=$P($$SITE^VASITE(,PDJ),"^",3)
 .. S PDK=0 F  S PDK=$O(PDCL(PDI,PDJ,PDK)) Q:'PDK  D APPT
 Q
 ;
APPT ;
 K ^TMP($J,"SDAMA202")
 S PSJOR=PDK,PSJORN=$P(^SC(PDK,0),"^")
 S DTP=PDCL(PDI,PDJ,PDK)
 S EDT=DT
 I DTP S X1=DT,X2=+DTP D C^%DTC S EDT=X
 D GETPLIST^SDAMA202(PDK,"1;4","",DT,EDT)
 Q:'$D(^TMP($J,"SDAMA202"))
 K APDTM,CLNM
 S PDA=0 F  S PDA=$O(^TMP($J,"SDAMA202","GETPLIST",PDA)) Q:'PDA  D
 . S PSJDTM=+^TMP($J,"SDAMA202","GETPLIST",PDA,1)
 . S DFN=+^TMP($J,"SDAMA202","GETPLIST",PDA,4)
 . Q:$P($G(^DPT(DFN,.1)),"^")]""&($P(^PS(58.7,PDI,0),"^",6)'="Y")
 . K NSEG N ZZ1,XX,FTS S (ZZ1,FTS)="",PSJNIP=0
 . I $P($G(^DPT(DFN,.1)),"^")]"" D
 .. D IN5^VADPT
 .. N PSJQ,PSJWD,PSJRBD
 .. S PSJWD=$P(VAIP(5),"^",2),PSJRBD=$P(VAIP(6),"^",2)
 .. S PSJQ=$$CHKPD^PSJPDCL(PSJWD,PSJRBD)
 .. I 'PSJQ S PSJNIP=1 Q
 .. S FTS=$P(VAIP(8),"^")_NECH_$P(VAIP(8),"^",2)
 .. S XX=0 F  S XX=$O(PSJQ(XX)) Q:'XX  D
 ... I XX=PDI,$P(PSJQ(XX),"^",2)'="" S ZZ1=$P(PSJQ(XX),"^",2)
 ... I XX'=PDI S PSJNIP=1
 . S SEQ=0 D SRBLD^PSJPDCLA M HL=NHL N ZZ2 S ZZ2=$S($P(DTP,"^",2)'="":$P(DTP,"^",2),1:"")
 . S SEQ=SEQ+1,NSEG(SEQ)="ZZZ"_HL("FS")_$S(ZZ1'="":ZZ1,1:"")_HL("FS")_ZZ2_HL("FS")_FTS
 . K HLP,HLA,PSJSND S HLP="",HLP("SUBSCRIBER")="^^^^~"_PSJDNS_":"_PSJVP_"~DNS"
 . N XX S XX=PDI D PV19 M HLA("HLS")=NSEG
 . D GENERATE^HLMA(SNM,"LM",1,.PSJSND,"",.HLP)
 . D LOG^PSJPADE
 Q
 ;
ALLCLN ;
 N ND S Z=0 F  S Z=$O(^SC(Z)) Q:'Z  D
 .S ND=^SC(Z,0) Q:$P(ND,"^",3)'="C"  Q:$P(ND,"^",15)'=J
 .I $D(^SC(Z,"I")) S X=$G(^SC(Z,"I")) I $P(X,"^"),$P(X,"^",2)'>$P(X,"^") Q
 .S PDCL(I,J,Z)=DTP_$S(SA]"":"^"_SA,1:"")
 Q
 ;
CLARR ;
 S Z=0,SA=""
 F  S Z=$O(^PS(58.7,I,"DIV",J,"CL",Z)) Q:'Z  S K=^PS(58.7,I,"DIV",J,"CL",Z,0) D:$P(K,"^",3)="Y"
 . S SA=$P(K,"^",2)
 . S:SA SA=$P($G(^PS(58.71,SA,0)),"^")
 . S PDCLA(I,J,+K)=DTP_$S(SA]"":"^"_SA,1:"")
 S Z=0
 F  S Z=$O(^PS(58.7,I,"DIV",J,"PCG",Z)) Q:'Z  D:$P($G(^PS(58.7,I,"DIV",J,"PCG",Z,2)),"^")="Y"
 . S SA=$P($G(^PS(58.7,I,"DIV",J,"PCG",Z,0)),"^",2)
 . S:SA SA=$P($G(^PS(58.71,SA,0)),"^")
 . S X=0 F  S X=$O(^PS(58.7,I,"DIV",J,"PCG",Z,1,X)) Q:'X  D
 .. S K=+$G(^PS(58.7,I,"DIV",J,"PCG",Z,1,X,0))
 .. I '$D(PDCLA(I,J,K)) S PDCLA(I,J,K)=DTP_$S(SA]"":"^"_SA,1:"")
 S Z=0
 F  S Z=$O(^PS(58.7,I,"DIV",J,"VCG",Z)) Q:'Z  S X=^PS(58.7,I,"DIV",J,"VCG",Z,0) D:$P(X,"^",3)="Y"
 . S SA=$P(X,"^",2) S:SA SA=$P($G(^PS(58.71,SA,0)),"^")
 . S Y=0 F  S Y=$O(^PS(57.8,+X,1,Y)) Q:'Y  D
 .. S K=+^(Y,0) S:'$D(PDCLA(I,J,K)) PDCLA(I,J,K)=DTP_$S(SA]"":"^"_SA,1:"")
 S Z=0,L=""
 F  S Z=$O(^PS(58.7,I,"DIV",J,"WCN",Z)) Q:'Z  S X=^PS(58.7,I,"DIV",J,"WCN",Z,0) D:$P(X,"^",3)="Y"
 . S SA=$P(X,"^",2) S:SA SA=$P($G(^PS(58.71,SA,0)),"^")
 . S (Y,P)=$P(X,"^") F  S P=$O(^SC("B",P)) Q:P=""!($E(P,1,$L(Y))'=Y)  D
 .. S K=$O(^SC("B",P,0)),L=$G(^SC(K,0)) Q:$P(L,"^",3)'="C"  Q:$P(L,"^",15)'=J
 .. S:'$D(PDCLA(I,J,K)) PDCLA(I,J,K)=DTP_$S(SA]"":"^"_SA,1:"")
 Q
 ;
PV19 ;
 N NC,NDFN,NCLI,N19,NSA,NS,NWDI,NQ
 S (NSA,N19)="",(NQ,NC)=0,NS=$E(HL("ECH"),1),PDL(10)=XX,PDL(4)=HL("ETN")
 S:ZZ2]"" (NSA,PDL(12))=$O(^PS(58.71,"B",ZZ2,0))
 S:ZZ1]"" PDL(11)=$O(^PS(58.71,"B",ZZ1,""))
 F  S NC=$O(NSEG(NC)) Q:'NC  D  Q:NQ
 . I $E(NSEG(NC),1,3)="PID" S (NDFN,PDL(1))=+$P(NSEG(NC),HL("FS"),4) Q
 . I $E(NSEG(NC),1,3)="PV1" D  S NQ=1 Q
 .. I $P(NSEG(NC),HL("FS"),12)]"" D
 ... S NCLI=$P($P(NSEG(NC),HL("FS"),12),NS,2)
 ... S:'NCLI NCLI=$O(^SC("B",$P($P(NSEG(NC),HL("FS"),12),NS),0))
 ... S:NCLI PDL(5)=+$P($G(^SC(NCLI,0)),"^",15)
 ... S N19=NDFN_"-"_$S(NSA]"":NSA_"S",1:NCLI),PDL(9)=N19 S:NCLI PDL(8)=NCLI
 ... S $P(NSEG(NC),HL("FS"),20)=N19
 .. I $P(NSEG(NC),HL("FS"),4)]"" D
 ... S NWDI=$O(^DIC(42,"B",$P($P(NSEG(NC),HL("FS"),4),NS),0))
 ... I NWDI S PDL(7)=NWDI S:'$G(PDL(5)) PDL(5)=+$P($G(^DIC(42,NWDI,0)),"^",11)
 .. S:$P(NSEG(NC),HL("FS"),51)]"" PDL(6)=$P(NSEG(NC),HL("FS"),51)
 Q
 ;
