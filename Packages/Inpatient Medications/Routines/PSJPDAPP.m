PSJPDAPP ;BIR/MHA - SEND APPOINTMENTS TO PADE ;11/27/15
 ;;5.0;INPATIENT MEDICATIONS;**317,389,415,432**;16 DEC 97;Build 18
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
 K ^TMP($J,"PSJCLSA")
 F  S I=$O(^PS(58.7,I)) Q:'I  S J=$$PDACT^PSJPDCLA(I)
 Q:'PSJAP
 S I=0 F  S I=$O(PSJAP(I)) Q:'I  D
 . S DTP=+$G(^PS(58.7,I,1))
 . S J=0 F  S J=$O(^PS(58.7,I,"DIV",J)) Q:'J  D
 .. S Y=$G(^PS(58.7,I,"DIV",J,0)) I Y=""!($P(Y,"^",2)&($P(Y,"^",2)<DT)) Q
 .. S SA=""
 .. I $P(Y,"^",9)="Y" S:$P(Y,"^",4) SA=$P($G(^PS(58.71,$P(Y,"^",4),0)),"^") D ALLCLN   ;send appt for all clinics
 .. D CLARR
 .. ; Get all CLINIC to SEND AREA associations, where 
 .. ; INCLUDE CLINICS IN BG JOB and RE-SEND ORDERS AT CHECK-IN evaluates to YES
 .. D GETDSARS^PSJPDAPP(I,J,3)
 M PDCL=PDCLA
 I '$D(PDCL) D KILLTMP Q
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
 D KILLTMP
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
 K APDTM,CLNM,PSJXCL
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
 ... I $G(PSJXCL(PDI)) S PSJNIP=0
 . S SEQ=0 D SRBLD^PSJPDCLA M HL=NHL N ZZ2 S ZZ2=$S($P(DTP,"^",2)'="":$P(DTP,"^",2),1:"")
 . S SEQ=SEQ+1,NSEG(SEQ)="ZZZ"_HL("FS")_$S(ZZ1'="":ZZ1,1:"")_HL("FS")_ZZ2_HL("FS")_FTS
 . K HLP,HLA,PSJSND S HLP="",HLP("SUBSCRIBER")="^^^^~"_PSJDNS_":"_PSJVP_"~DNS"
 . N XX S XX=PDI D PV19 M HLA("HLS")=NSEG
 . D GENERATE^HLMA(SNM,"LM",1,.PSJSND,"",.HLP)
 . D LOG^PSJPADE
 . ;check for O11 re-send
 . D RESNDORDS^PSJPDCLA(DFN,PSJOR,PDJ,PDI,3) ; Resend all orders for the input CLINIC's SEND AREA 
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
 . S Y=$P(X,"^"),P=$E(X,1,$L(Y)-1) F  S P=$O(^SC("B",P)) Q:P=""  D
 .. Q:($E(P,1,$L(Y))'=Y)  ;p415
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
GETPSARS(PSYSIN,DFNIN,FILTER) ; Return Send Area for all clinic orders for patient DFN
 ; OUTPUT:  ^TMP($J,"PSJCLSA",PSYSIN,PDIVIN,"CL",CLINICIEN,SENDAREAIEN)=PCLSAS
 ;          ^TMP($J,"PSJCLSA",PSYSIN,PDIVIN,"SA",SENDAREAIEN,CLINICIEN)=PCLSAS
 ;          PCLSAS=Send Area Name^PADE System^Division^Clinic Name^Source of Send Area value
 ; INPUT
 ;      PSYSIN (required) - PADE System IEN from File #58.7 
 ;      FILTER (optional) - 0: No filter
 ;                          1: INCLUDE CLINIC IN BG JOB required (set to YES).
 ;                          2: RE-SEND ORDERS AT CHECK-IN required (set to YES)
 ;                          3: Both INCLUDE CLINIC IN BG JOB and RE-SEND ORDERS AT CHECK-IN required (set to YES)
 ;
 Q:'$G(PSYSIN)
 N ND,CLIN,DFN,DIVISION
 S FILTER=+$G(FILTER)
 ;
 K ^TMP("PS",$J),^TMP($J,"PSJCLSA") S CNT=0
 S DFN=DFNIN
 D OCL1^PSJORRE(DFN,"","",0)
 Q:'$D(^TMP("PS",$J))
 ;
 N PSJORD,CLINICA
 S I=0 F  S I=$O(^TMP("PS",$J,I)) Q:'I  D
 . N CLINICI,IENS
 . S J=^TMP("PS",$J,I,0),PSJORD=$P(J,"^")
 . Q:'((PSJORD["U"!(PSJORD["V")&($P(J,"^",9)="ACTIVE")))
 . S IENS=+PSJORD_","_+DFN
 . I PSJORD["U" S CLINICI=$$GET1^DIQ(55.06,IENS,130,"I")
 . I PSJORD["V" S CLINICI=$$GET1^DIQ(55.01,IENS,136,"I")
 . Q:'$G(CLINICI)
 . S DIVISION=$$GET1^DIQ(44,CLINICI,3.5,"I")
 . Q:'$G(DIVISION)
 . S CLINICA(DIVISION,CLINICI)=""
 Q:'$O(CLINICA(""))
 ;
 S DIVISION=0 F  S DIVISION=$O(CLINICA(DIVISION)) Q:'DIVISION  D
 . S CLINICA=0 F  S CLINICA=$O(CLINICA(DIVISION,CLINICA)) Q:'CLINICA  D TMPSA(PSYSIN,DIVISION,CLINICA,FILTER)
 ;
 Q
GETDSARS(PSYSIN,PDIVIN,FILTER) ; Return Send Area for all clinics in Division PDIVIN
 ; OUTPUT:  ^TMP($J,"PSJCLSA",PSYSIN,PDIVIN,"CL",CLINICIEN,SENDAREAIEN)=PCLSAS
 ;          ^TMP($J,"PSJCLSA",PSYSIN,PDIVIN,"SA",SENDAREAIEN,CLINICIEN)=PCLSAS
 ;          PCLSAS=Send Area Name^PADE System^Division^Clinic Name^Source of Send Area value
 ; INPUT
 ;      PSYSIN (required) - PADE System IEN from File #58.7 
 ;      PDIVIN (required) - PADE Division from File #58.7   
 ;      FILTER (optional) - 0: No filter
 ;                          1: INCLUDE CLINIC IN BG JOB required (set to YES).
 ;                          2: RE-SEND ORDERS AT CHECK-IN required (set to YES)
 ;                          3: Both INCLUDE CLINIC IN BG JOB and RE-SEND ORDERS AT CHECK-IN required (set to YES)
 ;
 Q:'$G(PSYSIN)!'$G(PDIVIN)
 N ND,CLIN
 S FILTER=+$G(FILTER)
 ;
 S CLIN=0 F  S CLIN=$O(^SC(CLIN)) Q:'CLIN  D
 . D TMPSA(PSYSIN,PDIVIN,CLIN,FILTER)
 Q
 ;
TMPSA(PSYSIN,PDIVIN,CLIN,FILTER) ; Build ^TMP( for clinic CLIN
 N PCLSAS
 S ND=^SC(CLIN,0) Q:$P(ND,"^",3)'="C"  Q:$P(ND,"^",15)'=PDIVIN                   ; Different Division
 I $D(^SC(CLIN,"I")) S X=$G(^SC(CLIN,"I")) I $P(X,"^"),$P(X,"^",2)'>$P(X,"^") Q  ; Inactive Clinic
 S PCLSAS=$$GETSAR(PSYSIN,PDIVIN,CLIN,FILTER)
 I $L($P(PCLSAS,"^"))>1 S PCLSAS(PSYSIN,PDIVIN,CLIN)=PCLSAS D
 . N SNDAREA,SNDAREAI S SNDAREA=$P(PCLSAS,"^"),SNDAREAI=$P(PCLSAS,"^",6)
 . S ^TMP($J,"PSJCLSA",PSYSIN,PDIVIN,"CL",CLIN,SNDAREAI)=PCLSAS
 . S ^TMP($J,"PSJCLSA",PSYSIN,PDIVIN,"SA",SNDAREAI,CLIN)=PCLSAS
 Q
 ;
GETSAR(PSYSIN,PDIVIN,PCLININ,FILTER) ; Return Send Area for clinic PCLIN
 ; PSYS - PADE system from PADE SYSTEM SETUP (#58.7)
 ; PDIV - Division from PADE SYSTEM SETUP (#58.7) (pointer to MEDICAL CENTER DIVISION #40.8)
 ; PSNDAR - Send Area from PADE SYSTEM SETUP (58.7) associated with the lowest (most specific/granular) clinic parameter
 ;
 I '$G(PSYSIN)!'$G(PDIVIN)!'$G(PCLININ) Q 0
 N PSJSAR,PSJSARI,PSJQ,PCLINAM,PSADIVDF,PSADIVDFI,PSJRESND,PSJBGJOB,PSJRESNDD,PSJBGJOBD,PSJNORES
 N PSJPSARI
 ;
 S PSJQ=""         ; Return values
 S PSADIVDF=""     ; Default Divisional Send Area Name 
 S PSADIVDFI=""    ; Default Divisional Send Area IEN
 S PSJRESND=""     ; RE-SEND ORDERS AT CHECK-IN flag for clinic/clinic group
 S PSJRESNDD=""    ; RE-SEND ORDERS AT CHECK-IN Divisional default (or System default if Div is null)
 S PSJBGJOB=""     ; INCLUDE CLINIC IN BG JOB flag for clinic/clinic group
 S PSJBGJOBD=""    ; INCLUDE CLINIC IN BG JOB flag Divisional default (or System default if Div is null)
 ;
 S PCLINAM=$P($G(^SC(+PCLININ,0)),"^")
 ;
 N DN S DN=$G(^PS(58.7,PSYSIN,"DIV",PDIVIN,0)) Q:DN="" 0
 N DC S DC=$P(DN,"^",2)
 I DC&(DC<DT) Q 0 ;DIV INACTIVE
 ;
 ; RE-SEND ORDERS AT CHECK-IN (default - if not defined at lower level)
 S PSJRESNDD=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,0)),"^",10)
 I PSJRESNDD="" S PSJRESNDD=$P($G(^PS(58.7,PSYSIN,1)),"^",3)
 ;
 ; INCLUDE ALL CLINICS IN BG JOB? (default - if not defined at lower level)
 S PSJBGJOBD=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,0)),"^",9)
 S PSJBGJOBD=$S(PSJBGJOBD="Y":1,PSJBGJOBD="N":0,1:"")
 ;
 ; Get Divisional/System default Send Area if not filtered
 I ($P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,0)),"^",3)="Y")&($P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,2)),"^",1)="Y") D
 . S PSADIVDFI=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,0)),"^",4)
 . S:PSADIVDFI PSADIVDF=$P($G(^PS(58.71,PSADIVDFI,0)),"^")
 ;
 ; Get CLINIC default Send Area if not filtered
 S PSJSARI=$O(^PS(58.7,PSYSIN,"DIV",PDIVIN,"CL","B",PCLININ,0))
 I PSJSARI D
 . I ($G(FILTER)=2)!($G(FILTER)=3) D  Q:'$G(PSJRESND)
 .. S PSJRESND=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"CL",PSJSARI,0)),"^",4)
 .. S:PSJRESND="" PSJRESND=PSJRESNDD
 . I ($G(FILTER)=1)!($G(FILTER)=3) D  Q:'$G(PSJBGJOB)
 .. S PSJBGJOB=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"CL",PSJSARI,0)),"^",3)
 .. S PSJBGJOB=$S(PSJBGJOB="Y":1,1:PSJBGJOBD)   ; Choices=YES or NULL
 .. S:PSJBGJOB PSJBGJOBD=PSJBGJOB               ; If INCLUDE=YES, use as default for this clinic (can't be overridden) 
 . S PSJSARI=+$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"CL",PSJSARI,0)),"^",2)
 . S PSJSAR=$P($G(^PS(58.71,+PSJSARI,0)),"^")
 . S PSJQ=PSJSAR_"^"_PSYSIN_"^"_PDIVIN_"^"_PCLINAM_"^CL^"_PSJSARI
 Q:$L(PSJQ) PSJQ
 Q:(PSJRESND=0) ""  ; RE-SEND ORDERS=NO for this clinic, filter=required, ignore higher Send Area values.
 ;
 ; Get PADE CLINIC GROUP Send Area if not filtered
 S PSJSARI=$O(^PS(58.7,PSYSIN,"DIV",PDIVIN,"PCG","C",PCLININ,0))
 I PSJSARI D
 . I ($G(FILTER)=2)!($G(FILTER)=3) D  Q:'$G(PSJRESND)
 .. S PSJRESND=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"PCG",PSJSARI,2)),"^",2)
 .. S:PSJRESND="" PSJRESND=PSJRESNDD
 . I ($G(FILTER)=1)!($G(FILTER)=3) D  Q:'$G(PSJBGJOB)
 .. S PSJBGJOB=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"PCG",PSJSARI,2)),"^")
 .. S PSJBGJOB=$S(PSJBGJOB="Y":1,1:PSJBGJOBD)   ; Choices=YES or NULL
 .. S:PSJBGJOB PSJBGJOBD=PSJBGJOB               ; If INCLUDE=YES, use as default for this clinic (can't be overridden) 
 . S PSJSARI=+$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"PCG",PSJSARI,0)),"^",2)
 . S PSJSAR=$P($G(^PS(58.71,+PSJSARI,0)),"^")
 . S PSJQ=PSJSAR_"^"_PSYSIN_"^"_PDIVIN_"^"_PCLINAM_"^PCG^"_PSJSARI
 Q:$L(PSJQ) PSJQ
 Q:(PSJRESND=0) ""  ; RE-SEND ORDERS=NO for this clinic, filter=required, ignore higher Send Area values.
 ;
 ; Get VISTA CLINIC GROUP Send Area if not filtered
 I $O(^PS(57.8,"AC",PCLININ,0)) D
 . S PSJSARI=$O(^PS(57.8,"AC",PCLININ,0))
 . I PSJSARI S PSJSARI=$O(^PS(58.7,PSYSIN,"DIV",PDIVIN,"VCG","B",PSJSARI,0))
 . Q:'PSJSARI
 . I ($G(FILTER)=2)!($G(FILTER)=3) D  Q:'$G(PSJRESND)
 .. S PSJRESND=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"VCG",PSJSARI,0)),"^",4)
 .. S:PSJRESND="" PSJRESND=PSJRESNDD
 . I ($G(FILTER)=1)!($G(FILTER)=3) D  Q:'$G(PSJBGJOB)
 .. S PSJBGJOB=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"VCG",PSJSARI,0)),"^",3)
 .. S PSJBGJOB=$S(PSJBGJOB="Y":1,1:PSJBGJOBD)   ; Choices=YES or NULL
 .. S:PSJBGJOB PSJBGJOBD=PSJBGJOB               ; If INCLUDE=YES, use as default for this clinic (can't be overridden) 
 . S PSJSARI=+$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"VCG",PSJSARI,0)),"^",2)
 . S PSJSAR=$P($G(^PS(58.71,PSJSARI,0)),"^")
 . S PSJQ=PSJSAR_"^"_PSYSIN_"^"_PDIVIN_"^"_PCLINAM_"^VCG^"_PSJSARI
 Q:$L(PSJQ) PSJQ
 Q:(PSJRESND=0) ""  ; RE-SEND ORDERS=NO for this clinic, filter=required, ignore higher Send Area values.
 ;
 ; Get WILDCARD CLINIC NAME Send Area if not filtered
 S PSJPSARI=$O(^PS(58.7,PSYSIN,"DIV",PDIVIN,"WCN","B",0)) I PSJPSARI'="" D
 . N PSJWC,PSJLEN S PSJWC="" F  S PSJWC=$O(^PS(58.7,PSYSIN,"DIV",PDIVIN,"WCN","B",PSJWC)) Q:PSJWC=""  D
 .. I $E(PCLINAM,1,$L(PSJWC))=PSJWC S PSJLEN($L(PSJWC),PSJWC)=""
 . I $D(PSJLEN) D
 .. S PSJPSARI=$O(PSJLEN(999),-1)
 .. S PSJPSARI=$O(PSJLEN(PSJPSARI,0))
 .. S PSJPSARI=+$O(^PS(58.7,PSYSIN,"DIV",PDIVIN,"WCN","B",PSJPSARI,0))
 .. S PSJSARI=+$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"WCN",PSJPSARI,0)),"^",2)
 .. S PSJSAR=$P($G(^PS(58.71,PSJSARI,0)),"^")
 . I ($G(FILTER)=2)!($G(FILTER)=3) D  Q:'$G(PSJRESND)
 .. S PSJRESND=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"WCN",PSJPSARI,0)),"^",4)
 .. S:PSJRESND="" PSJRESND=PSJRESNDD
 . I ($G(FILTER)=1)!($G(FILTER)=3) D  Q:'$G(PSJBGJOB)
 .. S PSJBGJOB=$P($G(^PS(58.7,PSYSIN,"DIV",PDIVIN,"WCN",PSJPSARI,0)),"^",3)
 .. S PSJBGJOB=$S(PSJBGJOB="Y":1,1:PSJBGJOBD)   ; Choices=YES or NULL
 .. S:PSJBGJOB PSJBGJOBD=PSJBGJOB               ; If INCLUDE=YES, use as default for this clinic (can't be overridden) 
 . S PSJQ=$G(PSJSAR)_"^"_PSYSIN_"^"_PDIVIN_"^"_PCLINAM_"^WCN^"_PSJSARI
 Q:$L(PSJQ) PSJQ
 Q:(PSJRESND=0) ""  ; RE-SEND ORDERS=NO for this clinic, filter=required, ignore higher Send Area values.
 ; 
 ; If no matches, use Division default. PSADIVDF only defined if SEND MESSAGES FOR ALL CLINICS? and SEND ORDER MESSAGES? set to YES
 ; and Divisional default SEND AREA exists.
 I $L($G(PSADIVDF)) D
 . I ($G(FILTER)=2)!($G(FILTER)=3) Q:'$G(PSJRESNDD)
 . I ($G(FILTER)=1)!($G(FILTER)=3) Q:'$G(PSJBGJOBD)
 . S PSJQ=PSADIVDF_"^"_PSYSIN_"^"_PDIVIN_"^"_PCLINAM_"^DIVDFLT^"_PSADIVDFI
 Q PSJQ
 ;
KILLTMP ; Clean up ^TMP($J,"PSJCLSA")
 K ^TMP($J,"PSJCLSA")
 Q
