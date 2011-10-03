SCMCTSK6 ;ALB/JDS - PCMM Bulletins ; 7/19/05 10:04am
 ;;5.3;Scheduling;**297,532**;AUG 13, 1993;Build 21
 Q
MAKEMAIL(TYPE)  ;
 N PRE,IN
 S ZERO=$G(^SCPT(404.43,+ENTRY,0)),ZERO1=$G(^SCPT(404.42,+ZERO,0))
 S T=+$P(ZERO1,U,3),IN=$P($G(^SCTM(404.51,T,0)),U,7) S INSTNM=$$GET1^DIQ(4,(+IN)_",",.01)
 I INSTNM'=DIV S DIV=INSTNM D
 .S ^TMP("SCMCTXT",$J,CNT,0)="  "
 .S ^TMP("SCMCTXT",$J,CNT+1,0)="      INSTITUTION: "_DIV,CNT=CNT+2
 S PROV=$P($$GETPRTP^SCAPMCU2(+$P(ZERO,U,2),DT),U,2)
 S PRE=$P($$OKPREC2^SCMCLK(+$P(ZERO,U,2),DT),U,2)
 S A=$E($$NAME^SCMCQK1(+ZERO1)_$J("",30),1,20)_" "_$E($$GET1^DIQ(2,(+ZERO1)_",",.0905)_$J("",5),2,5)_" "
 S A=A_$E(PROV_$J("",20),1,17)_" "_$E($E($$TEAMNM^SCMCQK1(+$P(ZERO1,U,3)),1,14)_$J("",20),1,15)
 ;S A=A_" "_$E($$POSITION^SCMCQK1(+$P(ZERO,U,2))_$J("",20),1,20)
 D INACTDT^SCMCTSK1(+ENTRY) S Y=X S:$G(TYPE)=2 Y=$P(ZERO,U,4),Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3),A=A_$E(Y_$J("",20),1,11)
 I $G(TYPE)=3 S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) S A=A_" "_$E(Y_$J("",20),1,11)
 I $G(TYPE)=1 S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3) S A=A_" "_$E(Y_$J("",20),1,11)
 I $G(TYPE)=2 S B=$P(ZERO,U,12),A=A_" "_$S(B="NA":"NO APPT",B="DU":"DECEASED",1:"Unknown")
 S ^TMP("SCMCTXT",$J,CNT,0)=A
 I PRE'=PROV I $L(PRE) S CNT=CNT+1,^TMP("SCMCTXT",$J,CNT,0)=$J("",26)_$E(PRE,1,17)
 S CNT=CNT+1
 Q
MM(TYPE)        ;for providers
 N EXP
 ;S Y=$P($G(^SCTM(404.52,+ENTRY,0)),U,10) I 'ALPHA D
 S EXP=$$EN^SCMCTSKI(1)
 ;.;S X1=Y,X2=30 D C^%DTC I $E(X,6,7)<16 S $E(X,6,7)=15 Q
 ;.;S X=$S($E(X,4,5)=2:28,$E(X,4,5)=4:30,$E(X,4,5)=6:30,$E(X,4,5)=9:30,$E(X,4,5)=11:30,1:31)
 ;I ALPHA D
 ;.S X1=Y,X2=2 D C^%DTC
 S EXP=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S ZERO=$G(^SCTM(404.52,+ENTRY,0)) N CLI
 S TP=$G(^SCTM(404.57,+ZERO,0)) D MAIL^SCMCTSK5(+ZERO,+$P(TP,U,2)) S T=$P(TP,U,2)
 S ^TMP("SCML",$J,"POS",+$P(ZERO,U,3))=""
 S ^TMP("SCML",$J,"XM",+$P(ZERO,U,3),+ZERO)=""
 I TYPE=5 S Y=$P(ZERO,U,2),EXP=$E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 S IN=$P($G(^SCTM(404.51,T,0)),U,7) S INSTNM=$$GET1^DIQ(4,(+IN)_",",.01)
 I INSTNM'=DIV S DIV=INSTNM D
 .S ^TMP("SCMCTXT",$J,CNT,0)="   "
 .S ^TMP("SCMCTXT",$J,CNT+1,0)="      INSTITUTION: "_DIV,CNT=CNT+2
 N I,CNT1 S CNT1=0
 S ROLE=$P($G(^SD(403.46,+$P(TP,U,3),0)),U)
 S PC=$P($$GET^XUA4A72(+$P(ZERO,U,3)),U,2)
 I $G(^TMP("SCMCTXT",$J,3,0))["|POS|" S A=^(0),^(0)=$P(A,"|POS|")_$P(TP,U)_" ROLE: "_ROLE D
 .S A=$G(^TMP("SCMCTXT",$J,5,0)),^(0)=$P(A,"|PC|")_PC
 F I=0:0 S I=$O(^SCTM(404.57,+ZERO,5,I)) Q:'I  S CLI(CNT1)=$P($G(^SC(I,0)),U),CNT1=CNT1+1
 S A=$E($P($G(^VA(200,+$P(ZERO,U,3),0)),U)_$J("",20),1,14)_" "_$E($G(CLI(0))_$J("",10),1,9)
 S A=A_" "_$E($P(TP,U)_$J("",20),1,10)_" "_$E(ROLE_$J("",20),1,14)
 S A=A_" "_$E(PC_$J("",20),1,14)
 S A=A_" "_$E($$PCPOSCNT^SCAPMCU1(+ZERO,DT,0)_$J("",9),1,4)_" "_EXP
 S ^TMP("SCMCTXT",$J,CNT,0)=A
 F I=1:1 Q:'$D(CLI(I))  I $L(CLI(I)) S CNT=CNT+1,^TMP("SCMCTXT",$J,CNT,0)=$J("",15)_$E(CLI(I),1,9)
 S CNT=CNT+1
 Q
PRMAIL(TYPE)    ;
 ;Send mail to providers
 N USER
 F USER=0:0 S USER=$O(^TMP("SCML",$J,"XM",USER)) Q:'USER  D
 .F I=HEAD:0 S I=$O(^TMP("SCMCTXT",$J,I)) Q:'I  K ^(I)
 .I TYPE=5 D M5
 .S CNT=HEAD,DIV=""
 .F I=0:0 S I=$O(^TMP("SCMC",$J,I)) Q:'I  S ENTRY=+$O(^(I,0)) D
 ..S ZERO=$G(^SCPT(404.43,+ENTRY,0)),ZERO1=$G(^SCPT(404.42,+ZERO,0))
 ..I TYPE>3 D  Q
 ...S ZERO=$G(^SCTM(404.52,+ENTRY,0))
 ...I $D(^TMP("SCML",$J,"XM",USER,+ZERO)) D MM(TYPE)
 ..I $D(^TMP("SCML",$J,"XM",USER,+$P(ZERO,U,2))) D MAKEMAIL(TYPE)
 .I CNT=HEAD Q
 .S XMY(USER)="",XMTEXT="^TMP(""SCMCTXT"",$J,"
 .S XMSUB="Patients Scheduled for Inactivation from Primary Care Panel"
 .I TYPE=3 S XMSUB="Patients With Extended PCMM Inactivation Date"
 .I TYPE=2 S XMSUB="Patients Automated Inactivations from Primary Care Panels"
 .I TYPE=4 S XMSUB="Primary Care Providers Scheduled for Inactivation"
 .I TYPE=5 Q  ;S XMSUB="Primary Care Providers Inactivated"
 .D ^XMD
 Q
M5 ;Individual provider bulletin
 Q:$G(^TMP("SCMCTXT",$J,1,0))["ATTENTION"
 F I=1:1:CNT-1 Q:'$D(^TMP("SCMCTXT",$J,I))  S A=^(I,0),^TMP("SCMCTXT",$J,I+11,0)=A
 F I=0:1:10 S A=$P($T(M6+I),";;",2),^TMP("SCMCTXT",$J,I+1,0)=A
 S HEAD=HEAD+12
 Q
M6 ;;ATTENTION: You may be inactivated as Primary Care Staff in the computer program
 ;;Primary Care Management Module (PCMM) VistA
 ;;Your Primary Care position |POS|       Role |ROLE|
 ;;May not correspond to your Person Class of
 ;;|PC|
 ;;in VistA (file 200). Associate Primary Care Providers who provide Primary Care
 ;;must be a Resident or Intern (Physician) a Nurse Practitioner or a Physician's
 ;;Assistant. Primary Care Providers must be an Attending physician (MD or DO),
 ;;Nurse Practitioner or a Physician's Assistant
 ;;Please contact your PCMM Coordinator or information systems department if you
 ;;do not think you should be inactivated in PCMM as a provider.
 Q
ACLIN ;Get sting of clinics in Alpha Order
 S X=""
 N A,I
 F I=0:0 S I=$O(^SCTM(404.57,+$G(D0),5,I)) Q:'I  S A=$P($G(^SC(I,0)),U) I $L(A) S A(A)=""
 S A="" F  S A=$O(A(A)) Q:A=""  S X=X_$E(A,1,5)_U
 S X=$P(X,U,1,$S(X[U:$L(X,U)-1,1:1))
 Q
BULL ;
 N FLDS
 S DISUPNO=1
 K ^TMP("SCMC",$J),^TMP("SCMCTXT",$J),^TMP("SCML",$J),XMY
 S XMY("G.PCMM PATIENT/PROVIDER INACTIVE")=""
 S XMTEXT="^TMP(""SCMCTXT"",$J,"
 S DIC="^SCTM(404.52,",BY="[SCMC PROVIDER INACTIVATED]",DHIT="S CNT=$G(CNT)+1,^TMP(""SCMC"",$J,CNT,D0)=""""",CNT=0
 S FLDS="",IOP="",DHD="@@",FR="",TO="" D EN1^DIP
 S XMSUB="Primary Care Providers Inactivated"
 D LINES^SCMCTSK5(5)
 D ^XMD
 D PRMAIL^SCMCTSK5(5)
 Q
FTERPT ;FTEE REPORT
 D PROMPT^SCMCTSK3("DIRECT PC FTEE-PANEL SIZE")
 Q:'$D(^TMP("SC",$J,"XR"))
 ;D FLAGG^SCMCTSK3
 S Q=""""
 S DIC="^SCTM(404.52,",L=0
 D FTEE
 S (SCDHD,DHD)="DIRECT PC FTEE AND PANEL SIZE REPORT"
 D BY^SCMCTSK2
 S DIOBEG="D DIOBEG^SCMCTSK4"
 S FLDS="[SCMC DIRECT PC FTEE]"
 I $D(^TMP("SC",$J,"SCLIN")) S FLDS="[SCMC DIRECT PC FTEE 1 CLN]"
 S DIOEND="D DIOEND^SCMCTSK7"
 D EN1^DIP
 Q
FTEE ;Sort FLAGGED
 K ^TMP("SCSORT",$J)
 N I,A,J
 I '$D(^TMP("SC",$J,"SORT",1)) S ^(1)="DV^INSTITUTION^SCDIV",SORTN="INSTITUTION",^(2)="TM^TEAM^SCTEAM",^(3)="PR^PROVIDER^SCPROV"
 N SORT S A="" F  S A=$O(^TMP("SC",$J,A)) Q:A=""  I "XRSORTDTR"'[A I $G(^(A))'="ALL" S SORT($S(A="ASPR":"PR",A="CLINIC":"EC",A="DIV":"DV",A="POS":"TP",1:"TM"))=""
 F I=0:0 S I=$O(^SCTM(404.52,"AIDT",I)) Q:'I  S K=$O(^SCTM(404.52,"AIDT",I,1,-9999999)) I K D
 .I $O(^SCTM(404.52,"AIDT",I,0,K),-1) Q   ;inactive
 .S J=$O(^SCTM(404.52,"AIDT",I,1,K,0)) Q:'J
 .D SORT(0)
 Q
SORT(INACTIVE)  ;
 N A,B,C,D,E,QUIT,SCA,K,KCNT
 S ZERO=$G(^SCTM(404.52,+J,0))
 S QUIT=0,KCNT=0
 F K=1:1 Q:'$D(^TMP("SC",$J,"SORT",K))  S A=^(K) K SORT($P(A,U)) S @("A("_K_")=$$"_$P(A,U)_"("_J_")") D  I (A(K)=-1)!($P(A(K),U)="") S QUIT=1 Q
 .I ($P(A,U)="EC")!($P(A,U)="AC") D
 ..I $L(A(K),U)>2 S KCNT=K
 ..N I F I=1:1:$L(A(K),U)-1 S ^TMP("SC",$J,"SCLIN",+ZERO,$P(A(K),U,I))=""
 Q:QUIT
 S A="" F  S A=$O(SORT(A)) Q:A=""  S @("B=$$"_A_"("_J_")") I B=-1 S QUIT=1 Q
 Q:QUIT
 F PIECE=1:1:$S(KCNT:$L(A(KCNT),U)-1,1:1) D
 .S B="E" K @B
 .F K=1:1:$O(A(99),-1) S @B@($P(A(K),U,$S(K=KCNT:PIECE,1:1)))="" S C=$Q(@B) K @B S B=C
 .S @B@(J)=""
 .M ^TMP("SCSORT",$J)=E
 Q
DV(PP) ;return institution sort of patient assignment entry and then IEN of team^ien of position
 N A,B,C,T,I,INSTNM,INSTN
 S T=+$P($G(^SCTM(404.57,+ZERO,0)),U,2) I $D(INST(T)) Q INST(T)_U_T_U_(+ZERO)
 S I=+$P($G(^SCTM(404.51,T,0)),U,7) I $O(^TMP("SC",$J,"DIV",0)) I '$D(^TMP("SC",$J,"DIV",I)) Q -1
 S INSTNM=$$GET1^DIQ(4,(+I)_",",.01),INSTN=$$GET1^DIQ(4,(+I)_",",99)
 S INST(T)=$S($L(INSTN)=3:INSTN_" ",1:"")_INSTNM Q INST(T)_U_T_U_(+ZERO)
EC(PP) Q $$AC(PP)
AC(PP) ;return enrolled clinics
 N I,A
 S A=""
 F I=0:0 S I=$O(^SCTM(404.57,+ZERO,5,I)) Q:'I  D
 .;I '$$PTCL^SCRPO2(DFN,U_I,0,DT) Q   ;not enrolled
 .I $D(CLIN(I)) S A=A_CLIN(I)_U Q
 .I $O(^TMP("SC",$J,"CLINIC",0)) I '$D(^(I)) Q
 .S CLIN(I)=$P($G(^SC(I,0)),U) I $L(CLIN(I)) S A=A_CLIN(I)_U
 Q $S(A="":-1,1:A)
TM(PP) ;Return Team
 N I,A,T
 S T=+$P($G(^SCTM(404.57,+ZERO,0)),U,2)
 I $D(TEAM(T)) Q TEAM(T)
 I $O(^TMP("SC",$J,"TEAM",0)) I '$D(^(T)) Q -1
 S TEAM(T)=$P($G(^SCTM(404.51,+T,0)),U)
 I '$L(TEAM(T)) K TEAM(T) Q -1
 Q TEAM(T)
TP(A) ;return the team position
 N TP S TP=+ZERO
 I $O(^TMP("SC",$J,"POS",0)) I '$D(^(TP)) Q -1
 Q $P($G(^SCTM(404.57,+TP,0)),U)
PR(PP) ;Return assigned provider
 N A
 I $O(^TMP("SC",$J,"ASPR",0)) I '$D(^(+$P(ZERO,U,3))) Q -1
 S A=$$GET1^DIQ(200,(+$P(ZERO,U,3))_",",.01) Q $S(A="":-1,1:A)
 Q
PCP(D0) ;PCP or AP
 N TP,A S TP=+$G(^SCTM(404.52,D0,0))
 S A=$O(^SCTM(404.53,"AIDT",TP,1,0),-1) I 'A Q "PCP"
 I $O(^SCTM(404.53,"AIDT",TP,0,A),-1) Q "PCP"
 Q "AP"
CLN(D0) ;sorted by clinic get next one
 N A S A=$O(^TMP("SC",$J,"SCLIN",D0,"")) Q:A=""
 N I F I=0:0 S I=$O(^SC("B",A,I)) Q:'I  I $D(^SCTM(404.57,D0,5,I)) Q
 Q:'I
 S DIPA("NUM")="`"_I K ^TMP("SC",$J,"SCLIN",D0,A)
