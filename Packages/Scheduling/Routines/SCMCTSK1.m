SCMCTSK1 ;ALB/JDS - PCMM Inactivations; 18 Apr 2003  9:36 AM ; 10/24/07 12:24pm  ; Compiled January 25, 2008 12:11:43  ; Compiled March 26, 2008 22:27:26
 ;;5.3;Scheduling;**297,498,527,499,532**;AUG 13, 1993;Build 21
 Q
INACTIVE ;
 ;Flag patients
 N I,CNT,SC297,TPZ,TYDT,TEAMN,STDT,Q,SDDT,STDD S CNT=0
 D DT^DICRW
 N SD1 S SDDT="" F SD1=DT,DT-1 I $D(^XTMP("SCMCTSK2-"_SD1,$J,"START")) S SDDT=SD1 Q
 I SDDT'>0 D DT^DICRW S SDDT=DT
 S %DT="",X="T-11M" D ^%DT S STDD=+Y
 S A="^SCPT(404.43,""ADFN""",L=""""""
 S Q=A_")"
 F  S Q=$Q(@Q) Q:Q'[A  D
 .S ENTRY=+$P(Q,",",6)
 .S ZERO=$G(^SCPT(404.43,+ENTRY,0))
 .I $P(ZERO,U,15) Q
 .S POS=+$P(ZERO,U,2)
 .I $P(ZERO,U,4) Q  ;UNASS
 .I '$P(ZERO,U,5) Q  ;Not PC
 .I $P(ZERO,U,3)>STDD Q  ;<11 months
 .;get preceptor
 .S PREC=$$DATES^SCAPMCU1(404.53,+POS),PREC=$S(PREC:$P($G(^SCTM(404.53,+$P(PREC,U,4),0)),U,6),1:+POS)
 .S DFN=$P(Q,",",3)
 .I $G(XPDIDTOT),('(DFN#5)) D UPDATE^XPDID(DFN)
 .S TEAM=$P(Q,",",4),TEAMNM=$P($G(^SCTM(404.51,+TEAM,0)),U)
 .N STDT S %DT="",X="T-12M" D ^%DT S STDT=+Y
 .;N-new or E-est
 .N NEW
 .I $P(ZERO,U,3)<STDT S NEW=0
 .E  S NEW=1
 .N TYDT
 .I NEW N STDT S %DT="",X="T-11M" D ^%DT S STDT=+Y D
 ..S X1=STDT,X2=-7 D C^%DTC S TYDT=X
 .I 'NEW N STDT S %DT="",X="T-23M" D ^%DT S STDT=+Y Q:$P(ZERO,U,3)'<STDT  D
 ..S X1=STDT,X2=-7 D C^%DTC S TYDT=X
 .N PROV,SEEN,PRECP D SEEN(DFN,POS,TYDT,SDDT,.PROV,.PRECP,.SEEN) Q:SEEN
 .;flag
 .S DIE="^SCPT(404.43,",DR=".15////"_SDDT,DA=ENTRY D ^DIE
 .S TPZ=$G(^SCTM(404.57,+POS,2))
 .I "TP"[$P(TPZ,U,9) I $G(PROV) S CNT=CNT+1,^TMP("SCF",$J,PROV,CNT,ENTRY)=""
 .I $P(TPZ,U,10),$G(PRECP) S CNT=CNT+1,^TMP("SCF",$J,PRECP,CNT,ENTRY)=""
 Q
SEEN(DFN,POS,TYDT,SDDT,PROV,PROVP,SEEN) ;
 S SEEN=0,PROVP=""
 N SCPRO,I,PRO,X,SCPRDTS,SCPR,PREC
 S PROV=+$$GETPRTP^SCAPMCU2(POS,SDDT)
 S SCPRDTS("BEGIN")=TYDT,SCPRDTS("END")=SDDT,SCPRDTS("INCL")=0
 S X=$$PRTP^SCAPMC(POS,"SCPRDTS","SCPR")
 S I=0 F  S I=$O(SCPR(I)) Q:'I  S SCPRO(+SCPR(I))="",SCPRO(+SCPR(I),I)=$P(SCPR(I),U,9,10) D
 .S PREC=$P(SCPR(I),U,12)
 .I PREC,PREC'=POS S PROVP=+$$GETPRTP^SCAPMCU2(PREC,SDDT) S SCPRO(+PROVP)="" S SCPRO(+PROVP,I)=$P(SCPR(I),U,9,10)
 F I=TYDT:0 S I=$O(^SCE("ADFN",DFN,I)) Q:'I  D  Q:SEEN
 .S J=0 F  S J=$O(^SCE("ADFN",DFN,I,J)) Q:'J  D  Q:SEEN
 ..N VISIT S VISIT=+$P($G(^SCE(J,0)),U,5) I $G(^SCE(J,0))<$G(TYDT) Q
 ..S PRO=0 F  S PRO=$O(SCPRO(PRO)) Q:'PRO  D  Q:SEEN
 ...I $D(^SDD(409.44,"AO",J,$G(PRO))) D CHK I SEEN=1 Q
 ...N V F V=0:0 S V=$O(^AUPNVPRV("AD",VISIT,V)) Q:'V  I PRO=(+$G(^AUPNVPRV(V,0))) D CHK I SEEN=1 Q
 Q
CHK ;
 N SDX S SDX="" F  S SDX=$O(SCPRO(PRO,SDX)) Q:SDX=""  D  Q:SEEN
 .I $P(SCPRO(PRO,SDX),U,2)="" D  Q
 ..I I'<$P(SCPRO(PRO,SDX),U) S SEEN=1
 .I I'<TYDT&(I'>$P(SCPRO(PRO,SDX),U,2)) S SEEN=1
 Q
DIS ;disch
 N ZERO S ZERO=$G(^SCPT(404.43,+ENTRY,0))
 I $P(ZERO,U,4) Q
 D DIS2^SCMCTSK7
 Q
CHKENR(DATA,INFO) ;check if patient enrolled in teamposition clinic
 S DATA(0)=-1
 Q
EXTEND(DATA,SCTEAM) ;to inact. in next 60 days
 ;IEN^POSITION^PATIENT^EXTENDED^REASON
 K DATA,SCDATA,SDDATA
 N CNT,I,J,K,A,POSA S CNT=1 S SCTEAM=$G(SCTEAM),DATA(1)="<DATA>"
 D DT^DICRW
 N SD1 S SDDT="" F SD1=DT,DT-1 I $D(^XTMP("SCMCTSK2-"_SD1,$J,"START")) S SDDT=SD1 Q
 I SDDT'>0 D DT^DICRW S SDDT=DT
 S X="T-9M" D ^%DT S STDT=Y
 S X="T-21M" D ^%DT S TYDT=+Y  ;MAKE THIS 21
 S POSA=""
 S POS=+$P(SCTEAM,U,2) I POS D POS,EX1 Q
 F  S POSA=$O(^SCTM(404.57,"ATMPOS",+SCTEAM,POSA)) Q:POSA=""  D  Q:CNT>100
 .F POS=0:0 S POS=$O(^SCTM(404.57,"ATMPOS",+SCTEAM,POSA,POS)) Q:'POS  D POS Q:CNT>100
 I CNT>100 S DATA(1)="TOO MANY" Q
EX1 S A="SDDATA",CNT=1 F  S A=$Q(@A) Q:A=""  D
 .S B=@A
 .S DATA(CNT)=(+$P(B,U,3))_U_$TR($P($P(A,"(",2),","),$C(34))_U_$TR($P(B,U,2),$C(34))_U_$P($G(^SCPT(404.43,+$P(B,U,3),0)),U,13)_U_$P($G(^SCPT(404.43,+$P(B,U,3),0)),U,14)
 .S CNT=CNT+1
 Q
POS I '$$DATES^SCAPMCU1(404.59,POS) Q  ;Position inact
 I '$P($G(^SCTM(404.57,POS,0)),U,4) Q  ;Not PC
 ;patients for position
 K ^TMP("SC TMP LIST",$J)
 S X=$$PTTP^SCAPMC(POS,"",.SCLIST,.SCERR)
 S J=0 F  S J=$O(@SCLIST@(J)) Q:'J  S SCDATA=^(J) D
 .N J I $P(SCDATA,U,4)>STDT Q
 .I '$P($G(^SCPT(404.43,+$P(SCDATA,U,3),0)),U,5) Q
 .I '$P($G(^SCPT(404.43,+$P(SCDATA,U,3),0)),U,15) Q
 .S DFN=+SCDATA
 .D SEEN(DFN,POS,TYDT,SDDT,.PROV,.PRECP,.SEEN) Q:SEEN
 .S SDDATA($P($G(^SCTM(404.57,POS,0)),U),$P(SCDATA,U,2),+SCDATA)=SCDATA,CNT=CNT+1
 K @SCLIST
 Q
FILE(RES,DATA) ;File data on FTEE
 N I
 F I=1:1 Q:'$D(DATA(I))  D
 .S $P(DATA(I),U,7)=$TR($P(DATA(I),U,7),"[]")
 .S ZERO=$G(^SCPT(404.43,+DATA(I),0))
 .I $P(ZERO,U,13)=$P(DATA(I),U,6) I $P(ZERO,U,14)=$P(DATA(I),U,7) Q
 .S FLDA(404.43,(+DATA(I))_",",.13)=$P(DATA(I),U,6)
 .S FLDA(404.43,(+DATA(I))_",",.14)=$E($P(DATA(I),U,7),1,50)
 .S FLDA(404.43,(+DATA(I))_",",.16)="`"_(+$G(DUZ))
 I $O(FLDA(0)) D FILE^DIE("E","FLDA","ERR")
 Q
SCREEN ;Active assign. screen
 N A S A=$G(^SCTM(404.52,D0,0))
 N J S J=-(DT+1),J=$O(^SCTM(404.52,"AIDT",+A,1,J)) I J="" S X=0 Q
 I '$P($G(^SCTM(404.57,+A,0)),U,4) Q  ;Not PC
 I '$$DATES^SCAPMCU1(404.59,+A) Q   ;Not an active position
 I $O(^SCTM(404.52,"AIDT",+A,0,-(DT+1)))<J S X=0 Q
 I '$D(^SCTM(404.52,"AIDT",+A,1,J,D0)) S X=0 Q
 S X=1 Q
SUM(PR,POSI) ;get pos for prov
 N I,INS,ZERO,SCA,TEAM,FTEE,Z
 S I="",FTEE=0
 F  S I=$O(^SCTM(404.52,"C",PR,I),-1) Q:'I  D
 .S ZERO=$G(^SCTM(404.52,I,0)) Q:$D(SCA(+ZERO))  Q:(POSI=(+ZERO))  S SCA(+ZERO)=""
 .S INS=$P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+ZERO,0)),U,2),0)),U,7)
 .S ACTIVE=$$DATES^SCAPMCU1(404.52,+ZERO,DT+.5) Q:'ACTIVE
 .S (Z,ZERO)=$G(^SCTM(404.52,+$P(ACTIVE,U,4),0)) Q:$P(Z,U,3)'=PR
 .S ACTIVE=$$DATES^SCAPMCU1(404.59,+Z,DT+.5) Q:'ACTIVE
 .S Z=$G(^SCTM(404.57,+Z,0))
 .Q:'$P(Z,U,4)  ;Cannot be primary
 .S TEAM=$G(^SCTM(404.51,+$P(Z,U,2),0))
 .Q:'$P(TEAM,U,5)
 .S FTEE=FTEE+$P(ZERO,U,9)
 Q FTEE
FTEECHK(DATA,PAIEN) ;check Ftee>1
 N A S A=$G(^SCTM(404.52,+PAIEN,0)),FTEE=$$SUM(+$P(PAIEN,U,3),+A)
 S DATA=0
 S DATA=FTEE+$P(PAIEN,U,2)
 Q
SORT(DIPA,SDD) ;sort tmpl
 N DIC
 S DIC=4,DIC(0)="ZME"
 S DIC("S")="I $D(^SCTM(404.51,""AINST"",+Y))"
 S DIR("A")="Start with Institution",DIR("B")="FIRST",DIR(0)="F" D ^DIR
 I X="FIRST" S DIPA("SI")="",DIPA("EI")="zzz",SDD=1 Q
 D ^DIC I Y<0 S DIPA("SI")=X S SDD=X Q:SDD[U  D
 .S DIR("A")="Go to Institutiton",DIR("B")="LAST" S DIR(0)="F" D ^DIR
 .I X="LAST" S DIPA("EI")="zzz"
 I Y>0 S DIPA("SI")=$P(Y(0),U),DIC(0)="AZQME",DIC("A")="Go to Institution: "
 D ^DIC
 I Y>0 S DIPA("EI")=$P(Y(0),U)
 I Y<0 S DIPA("EI")=X S SDD=X Q:SDD[U
 S SDD=1 Q
FTEERPT ;FTEE REPORT
 D FTERPT^SCMCTSK6 Q
 Q
POSCHK(DATA,INFO) ;
 N PCLASS
 ;TEAM POSITION IEN^PC^STANDARD POSITITION IEN
 I '$P(INFO,U,3) S DATA="1^Role Must be Entered" Q
 I $P(INFO,U,2) I '$P($G(^SD(403.46,+$P(INFO,U,3),0)),U,3) S DATA="1^This Role cannot provide Primary Care" Q
 I $P(INFO,U,2),($P($G(^SD(403.46,+$P(INFO,U,3),0)),U,3)=2) I '$$DATES^SCAPMCU1(404.53,+INFO) S DATA="1^This Role cannot provide Primary Care unless Precepted" Q
 S DATA=0
 I ('INFO)!('$P(INFO,U,2)) Q
 ;Is provider role acceptable?
 S J=-(DT+1) S J=$O(^SCTM(404.52,"AIDT",+INFO,1,J)) Q:J=""
 I $O(^SCTM(404.52,"AIDT",+INFO,0,-(DT+1)))<J Q
 S K=0 S K=$O(^SCTM(404.52,"AIDT",+INFO,1,J,K)) Q:'K
 S ZERO=$G(^SCTM(404.52,+K,0))
 ;Get person class for provider
 S PCLASS=$$GET^XUA4A72(+$P(ZERO,U,3))
 ;IEN^Occupation^specialty^sub-specialty^Effective date^expiration date^VA Code^specialty code
 I '$D(^SD(403.46,+$P(INFO,U,3),2,"B",+PCLASS)) S DATA="1^Person Class of "_$$GET1^DIQ(200,(+$P(ZERO,U,3))_",",.01)_" is not valid in this Role." D POSCHK^SCMCTSK4
 Q
SEED ;seed one patient/provider
 W !,"To retransmit all patients for a given provider press return to select the provider",!!
 N DIC,SCADT,SCDDT,SCPAI
 S SC177=$$PDAT^SCMCGU("SD*5.3*177")
 I +SC177=0 D  Q
 . S SC2="  Unable to obtain SD*5.3*177 Installation Date."
 . D MSG^SCMCCV6(SC1,SC2)
 . Q
 S DIC="^DPT(",DIC(0)="MEQA" D ^DIC G PRSEED:Y'>0
 ;event filer for 1 patient
 S SCDFN=+Y W !,SCDFN
SCDFN S SC1="^SCPT(404.43,""APCPOS"",SCDFN,1)"
 ;quit if no PC assign
 Q:'$D(@SC1)
 S SCADT=0
 F  S SCADT=$O(@SC1@(SCADT)) Q:SCADT=""  D
 .S SCTP=0
 .F  S SCTP=$O(@SC1@(SCADT,SCTP)) Q:'SCTP  D
 ..; quit if team position does not exist
 ..Q:'$D(^SCTM(404.57,SCTP,0))
 ..S SCPAI=0
 ..F  S SCPAI=$O(@SC1@(SCADT,SCTP,SCPAI)) Q:'SCPAI  D
 ...S SCDDT=$P($G(^SCPT(404.43,SCPAI,0)),U,4)
 ...;quit if not active within date range
 ...Q:$$DTCHK^SCAPU1(SC177,DT,0,SCADT,SCDDT)<1
 ...N SCVAR S SCVAR=SCPAI_";SCPT(404.43,"
 ...;add to HL7 event file
 ...Q:$D(^SCPT(404.48,"AACXMIT",SCVAR))
 ...Q:$$CHECK^SCMCHLB1(SCVAR)'=1
 ...D ADD^SCMCHLE("NOW",SCVAR,SCDFN,SCTP)
 Q
PRSEED ;seed practitioner
 N AH,SC177
 S SC177=$$PDAT^SCMCGU("SD*5.3*177")
 I +SC177=0 D  Q
 . S SC2=" No SD*5.3*177 Installation Date."
 . D MSG^SCMCCV6(SC1,SC2)
 S DIC=200,DIC(0)="MEQA",DIC("A")="Select Provider: " D ^DIC Q:Y'>0
 S SCPROV=+Y
 F AH=0:0 S AH=$O(^SCTM(404.52,"C",SCPROV,AH)) Q:'AH  S TP=+$G(^SCTM(404.52,+AH,0)) D
 . Q:$D(SCTP(TP))
 . S SCTP(TP)=1
 . F SCDFN=0:0 S SCDFN=$O(^SCPT(404.43,"ADFN",SCDFN)) Q:'SCDFN  I $D(^(SCDFN,TP)) I '$D(SCU(SCDFN)) D SCDFN S SCU(SCDFN)=1
 . Q:'$P($G(^SCTM(404.57,TP,0)),U,4)
 . S SCVAR=AH_";SCTM(404.52,"
 . ;Quit if an event entry already exists
 . N QUIT,I S QUIT=0
 . F I=0:0 S I=$O(^SCPT(404.48,"AACXMIT",SCVAR,I)) Q:'I  I $P($G(^SCPT(404.48,I,0)),U,8) S QUIT=1 Q
 . Q:QUIT
 . D ADD^SCMCHLE("NOW",SCVAR,,AH,1)
 Q
INCON ;inconsistent PC assignments
 N POS
 D INCON^SCMCTSK3
 Q
INCONR ;inconsistent report
 N BY
 K ^TMP("SCMCTSK",$J)
 S DIC="^SCTM(404.57,",(FLDS,BY)="[SCMC INCONSISTENT]",DIOBEG="D INCON^SCMCTSK1"
 D EN1^DIP
 Q
INACTDT(PA) ;Scheduled inactivation date.
 D INACT^SCMCTSK3 Q
IU(DFN) ;is patient inactivity unassigned
 Q $$IU^SCMCTSK3(DFN)
 N I,A,B,DATA
