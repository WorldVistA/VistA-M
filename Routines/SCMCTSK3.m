SCMCTSK3 ;ALB/JDS - PCMM Inactivation Reports ; 7/19/05 10:06am  ; Compiled June 7, 2007 13:57:55  ; Compiled February 12, 2008 11:46:47
 ;;5.3;Scheduling;**297,499,532**;AUG 13, 1993;Build 21
 Q
SORTP ;sort template
 N DIC
 S DIC=200,DIC(0)="ZME"
 S DIC("S")="I $D(^SCTM(404.52,""C"",+Y))"
 S DIR("A")="Start with Provider",DIR("B")="FIRST",DIR(0)="F" D ^DIR
 I X="FIRST" S DIPA("SP")="",DIPA("EI")="zzz",X=1 Q
 D ^DIC I Y<0 S DIPA("SP")=X Q:X[U  D
 .S DIR("A")="Go to Provider",DIR("B")="LAST" S DIR(0)="F" D ^DIR
 .I X="LAST" S DIPA("EP")="zzz"
 I Y>0 S DIPA("SP")=$P(Y(0),U),DIC(0)="AZQME",DIC("A")="Go to Provider: "
 D ^DIC
 I Y>0 S DIPA("EP")=$P(Y(0),U)
 I Y<0 S DIPA("EP")=X Q:X[U
 S X=1 Q
 Q
KEY ;Inactivated Report Key
 D KEY^SCMCTSK3 Q
SORTYP()        ; sort type
 W !,"Sort report by"
 S DIR(0)="SO^1:TEAM;2:ASSOCIATED CLINIC;"
 S DIR("B")=1
 D ^DIR
 Q Y
DV(PP) ;return institution sort of patient assignment entry and then IEN of team^ien of position
 N A,B,C,T,I,INSTNM,INSTN
 S A=$G(^SCPT(404.43,+PP,0)),T=+$P($G(^SCPT(404.42,+A,0)),U,3) I $D(INST(T)) Q INST(T)_U_T_U_$P(A,U,2)
 S I=$P($G(^SCTM(404.51,T,0)),U,7) I $O(^TMP("SC",$J,"DIV",0)) I '$D(^TMP("SC",$J,"DIV",I)) Q -1
 S INSTNM=$$GET1^DIQ(4,(+I)_",",.01),INSTN=$$GET1^DIQ(4,(+I)_",",99)
 S INST(T)=$S($L(INSTN)=3:INSTN_" ",1:"")_INSTNM Q INST(T)_U_T_U_$P(A,U,2)
EC(PP) ;return enrolled clinics
 N I,A
 S A=""
 F I=0:0 S I=$O(^SCTM(404.57,+$P(ZERO,U,2),5,I)) Q:'I  D
 .I '$$PTCL^SCRPO2(DFN,U_I,0,DT) Q   ;not enrolled
 .I $D(CLIN(I)) S A=A_CLIN(I)_U Q
 .I $O(^TMP("SC",$J,"CLINIC",0)) I '$D(^(I)) Q
 .S CLIN(I)=$P($G(^SC(I,0)),U) I $L(CLIN(I)) S A=A_CLIN(I)_U
 Q $S(A="":-1,1:A)
TM(PP) ;Return Team
 N I,A,T
 S T=+$P($G(^SCPT(404.42,+ZERO,0)),U,3)
 I $D(TEAM(T)) Q TEAM(T)
 I $O(^TMP("SC",$J,"TEAM",0)) I '$D(^(T)) Q -1
 S TEAM(T)=$P($G(^SCTM(404.51,+T,0)),U)
 I '$L(TEAM(T)) K TEAM(T) Q -1
 Q TEAM(T)
IU(DFN) ;is patient inactivity unassigned
 N I,A,B,DATA,QUIT
 S DATA=-1,QUIT=0
 F I=0:0 S I=$O(^SCPT(404.42,"B",+$G(DFN),I)) Q:'I  S A=$G(^SCPT(404.42,I,0)) D  Q:QUIT
 .F J=0:0 S J=$O(^SCPT(404.43,"B",I,J)) Q:'J  S B=$G(^SCPT(404.43,+J,0)) D  Q:QUIT
 ..I $P(B,U,5),'$P(B,U,4) K A S QUIT=1 Q
 ..I $P(B,U,12)="NA" S POS=+J D
 ...S A("IU",I)=A
 ...S A("IUA")=A
 ...S A("IUB")=B
 ...I $P(A,U,8),'$P(A,U,9) S A("A")=1
 ;Q:$D(A("A")) DATA
 Q:'$D(A("IU")) DATA
 ;S DATA="1~"_$P(^SCTM(404.51,+$P(A,U,3),0),U)_"~"_(+$P(A,U,3))_"~"_$P($G(^SCTM(404.57,+$P(B,U,2),0)),U)_"~"_($P(B,U,2))_"~"_POS
 S DATA="1~"_$P(^SCTM(404.51,+$P(A("IUA"),U,3),0),U)_"~"_(+$P(A("IUA"),U,3))_"~"_$P($G(^SCTM(404.57,+$P(A("IUB"),U,2),0)),U)_"~"_($P(A("IUB"),U,2))_"~"_POS
 Q DATA
PROMPT(SCDESC,DATESORT) ;Prompt for report parameters, queue report
 ;Input: LIST=comma delimited string of list subscripts to prompt for
 ;Input: SCRTN=report routine entry point
 ;Input: SCDESC=tasked job description
 ;
 K TEAM,CLIN,INST,^TMP("SCSORT",$J)
 N SCDIV,SCBDT,SCEDT,SC,SCI,SCX,SCOUT,SCT
 D HOME^%ZIS
 D ENS^%ZISS
 S SC="^TMP(""SC"",$J)" K @SC S SCOUT=0
 D TITL^SCRPW50(SCDESC)
 I $L($G(DATESORT)) D  G:'$$DTR^SCRPO(.SC,.SCBDT,.SCEDT) END
 .D SUBT^SCRPW50(DATESORT)
 .S SCBDT("B")="T-30",SCEDT("B")="TODAY"
 .I (DATESORT["Scheduled Ina")!(DATESORT["Scheduled for Inactivation") S SCEDT("B")="T+60"
 S LIST="DIV,TEAM,POS,ASPR"
 ;D SUBT^SCRPW50("**** Date Range Selection ****")
 ;S (SCBDT("B"),SCEDT("B"))="TODAY"
 ;G:'$$DTR^SCRPO(.SC,.SCBDT,.SCEDT) END
 ;D SUBT^SCRPW50("**** Report Parameter Selection ****")
 F SCI=1:1:$L(LIST,",") S SCX=$P(LIST,",",SCI) D  Q:SCOUT
 .S SCOUT='$$LIST^SCRPO(.SC,SCX,1)
 .Q
 G:SCOUT END
 S SORT="DV,TM,TP,PR"_$S(SCDESC["FTEE":",AC",1:",PT")
 D SUBT^SCRPW50("**** Output sort order (optional) ****")
 G:'$$SORT^SCRPO(.SC,SORT,"") END
 S SCT(1)="**** Report Parameters Selected ****" D SUBT^SCRPW50(SCT(1))
 G:'$$PPAR^SCRPO(.SC,1,.SCT) END
 S SORTN=""
 F SCI=0:0 S SCI=$O(^TMP("SC",$J,"SORT",SCI)) Q:'SCI  S SORTN=SORTN_$P(^(SCI),U,2)_U
 W:$G(IORESET)'[$C(99) $G(IORESET)
 Q
END W:$G(IORESET)'[$C(99) $G(IORESET) K ^TMP("SC",$J) Q
EXTEND ;Sort Extend
 K ^TMP("SCSORT",$J)
 I '$D(^TMP("SC",$J,"SORT",1)) S ^(1)="DV^INSTITUTION^SCDIV",SORTN="DIVISION"
 N SORT S A="" F  S A=$O(^TMP("SC",$J,A)) Q:A=""  I "XRSORTDTR"'[A I $G(^(A))'="ALL" S SORT($S(A="ASPR":"PR",A="DIV":"DV",A="POS":"TP",1:"TM",A="PATIENT":PT))=""
 N I,A,ED,SD
 F I=0:0 S I=$O(^SCPT(404.43,"AEXT",I)) Q:'I  F J=0:0 S J=$O(^SCPT(404.43,"AEXT",I,J)) Q:'J  D
 .I '$P($G(^SCPT(404.43,J,0)),U,15) Q
 .S SD=$G(^TMP("SC",$J,"DTR","BEGIN")) I SD S ED=$G(^("END")) S:'ED ED=9999999 D INACTDT^SCMCTSK1(J) I (X<SD)!(X>ED) Q
 .D SORT(0)
 Q
FILEIN(DATA,INFO) ;undo a inactivation
 ;INFO entry in PATIENT POSITION ASSIGNMENT file
 N ZERO,FLDA S DATA=1
 S ZERO=$G(^SCPT(404.43,+$G(INFO),0))
 ;I $P(ZERO,U,12)'="IU" Q
 S FLDA(404.43,(+INFO)_",",.12)=""
 S FLDA(404.43,(+INFO)_",",.04)=""
 S FLDA(404.43,(+INFO)_",",.15)=""
 S FLDA(404.43,(+INFO)_",",.17)=DT
 I $D(^SCPT(404.42,+ZERO,0)) S FLDA(404.42,(+ZERO)_",",.15)="",FLDA(404.42,(+ZERO)_",",.09)=""
 D FILE^DIE("E","FLDA","ERR")
 Q
UNASSIGN  ;Sort UNASSIGNMENTS
 N END,START
 K ^TMP("SCSORT",$J)
 S START=$G(^TMP("SC",$J,"DTR","BEGIN"))-.1,END=$G(^("END"))+.9
 I '$D(^TMP("SC",$J,"SORT",1)) S ^(1)="DV^INSTITUTION^SCDIV",SORTN="INSTITUTION"
 N I,A,STAT
 F STAT="NA","DU" F J=0:0 S J=$O(^SCPT(404.43,"ASTATB",STAT,J)) Q:'J  D
 .S ZERO=$G(^SCPT(404.43,J,0)) I ($P(ZERO,U,4)<START)!($P(ZERO,U,4)>END) Q
 .D SORT(1)
 Q
DFN(A) ;Return patient from Position assigment
 Q +$G(^SCPT(404.42,+$G(A),0))
PA(A) ;return patient name
 Q $P($G(^DPT(+$G(DFN),0)),U)
PR(PP) ;Return assigned provider
 N A
 S A=$$GETPRTP^SCAPMCU2(+$P(ZERO,U,2),DT)
 I $O(^TMP("SC",$J,"ASPR",0)) I '$D(^(+A)) Q -1
 S A=$P(A,U,2)
 Q $S(A="":-1,1:A)
TP(A) ;return the team position
 N TP S TP=+$P($G(ZERO),U,2)
 I $O(^TMP("SC",$J,"POS",0)) I '$D(^(TP)) Q -1
 Q $P($G(^SCTM(404.57,+TP,0)),U)
FLAGG ;Sort FLAGGED
 K ^TMP("SCSORT",$J)
 N I,A,J
 I '$D(^TMP("SC",$J,"SORT",1)) S ^(1)="DV^INSTITUTION^SCDIV",SORTN="INSTITUTION",^(2)="TM^TEAM^SCTEAM",^(3)="PR^PROVIDER^SCPROV",^(4)="PA^PATIENT^SCPAT"
 N SORT S A="" F  S A=$O(^TMP("SC",$J,A)) Q:A=""  I "XRSORTDTR"'[A I $G(^(A))'="ALL" S SORT($S(A="ASPR":"PR",A="DIV":"DV",A="POS":"TP",1:"TM",A="PATIENT":PT))=""
 S SDT=$G(^TMP("SC",$J,"DTR","BEGIN")),END=$G(^("END"))+.9
 F I=0:0 S I=$O(^SCPT(404.43,"AFLG",I)) Q:'I  F J=0:0 S J=$O(^SCPT(404.43,"AFLG",I,J)) Q:'J  D
 .I SDT>0 S:(END'>9) END=9999999 D INACTDT^SCMCTSK1(J) I (X<SDT)!(X>END) Q
 .D SORT(0)
 Q
SORT(INACTIVE)  ;
 N A,B,C,D,E,QUIT,SCA,K,KCNT,PIECE
 S ZERO=$G(^SCPT(404.43,+J,0)) Q:$S('$G(INACTIVE):$P(ZERO,U,4),1:'$P(ZERO,U,4))
 S DFN=$$DFN(+ZERO)
 S QUIT=0,KCNT=0
 F K=1:1 Q:'$D(^TMP("SC",$J,"SORT",K))  S A=^(K) K SORT($P(A,U)) S @("A("_K_")=$$"_$P(A,U)_"("_J_")") D  I (A(K)=-1)!($P(A(K),U)="") S QUIT=1 Q
 .I $P(A,U)="EC",$L(A(K),U)>2 S KCNT=K
 Q:QUIT
 S A="" F  S A=$O(SORT(A)) Q:A=""  S @("B=$$"_A_"("_J_")") I B=-1 S QUIT=1 Q
 Q:QUIT
 F PIECE=1:1:$S(KCNT:$L(A(KCNT),U)-1,1:1) D
 .S B="E" K @B
 .F K=1:1:$O(A(99),-1) S @B@($P(A(K),U,$S(K=KCNT:PIECE,1:1)))="" S C=$Q(@B) K @B S B=C
 .S @B@(J)=""
 .M ^TMP("SCSORT",$J)=E
 Q
INACT ;
 N ALPHA,ZERO
 S ALPHA=$G(^SCTM(404.44,1,1)),ALPHA=$P(ALPHA,U,8) I ALPHA<DT S ALPHA=0
 S ZERO=$G(^SCPT(404.43,+$G(PA),0)) I '$P(ZERO,U,15) S X="" Q
 S X1=$P(ZERO,U,15),X2=$S(ALPHA:2,1:30) I $P(ZERO,U,13) S X2=$S(ALPHA:5,1:90)
 D C^%DTC Q:ALPHA  Q:$E(X,6,7)=15
 F  S (ZERO,X1)=X,X2=1 D C^%DTC Q:$E(X,6,7)=15  I $E(X,6,7)="01" S X=ZERO Q
 Q
INCON ;Inconsistency
 N X
 F POS=0:0 S POS=$O(^SCTM(404.57,POS)) Q:'POS  D POSIN(POS) I $L(X) S ^TMP("SCMCTSK",$J,POS)=X
 Q
POSIN(POS)      ;
 S X=""
 N ZERO S ZERO=$G(^SCTM(404.57,POS,0))
 I '$P(ZERO,U,4) Q   ;not primary care ignore this
 I '$$ACTTP^SCMCTPU(POS) Q  ;inactive position   
 I '$$OKPREC3^SCMCLK(POS,DT) I '$P($G(^SD(403.46,+$P(ZERO,U,3),0)),U,3) S X="Role not=PCprovider" Q
 ;find provider assigned to position and their person class
 S PROV=+$$GETPRTP^SCAPMCU2(POS,DT) Q:'PROV
 S PC=$$GET^XUA4A72(+PROV)
 I '$O(^SD(403.46,+$P(ZERO,U,3),2,0)) Q
 I '$D(^SD(403.46,+$P(ZERO,U,3),2,+PC)) S X="PersonClass not valid"
 Q
PRFLAG ;
 N LASTDT,POSH
 K ^TMP("SCMCTSK",$J) N FLDA
 F POS=0:0 S POS=$O(^SCTM(404.57,POS)) Q:'POS  S ZERO=$G(^(POS,0)) D
 .I '$P(ZERO,U,4) Q   ;not primary care ignore this
 .I '$$ACTTP^SCMCTPU(POS) Q  ;inactive position
 .S LASTDT=+$O(^SCTM(404.52,"AIDT",POS,1,-DT)),POSH=+$O(^SCTM(404.52,"AIDT",POS,1,LASTDT,0)) Q:'POSH
 .I $O(^SCTM(404.52,"AIDT",POS,0,-9999999))<LASTDT Q   ;inactivation already scheduled
 .I $P($G(^SCTM(404.52,POSH,0)),U,10) Q  ;inactivation already scheduled S FLDA(404.52,POSH_",",.091)="" ;already flagged
 .I '$P($G(^SCTM(404.52,POSH,0)),U,4) Q   ;inactive
 .I '$$OKPREC3^SCMCLK(POS,DT) I '$P($G(^SD(403.46,+$P(ZERO,U,3),0)),U,3) S ^TMP("SCMCTSK",$J,POSH)="Role cannot be primary care" Q
 .;find provider assigned to position and their person class
 .S PROV=+$$GETPRTP^SCAPMCU2(POS,DT)
 .S PC=$$GET^XUA4A72(+PROV)
 .I '$D(^SD(403.46,+$P(ZERO,U,3),2,+PC)) S ^TMP("SCMCTSK",$J,POSH)="Person Class is not valid for this role"
 F POS=0:0 S POS=$O(^TMP("SCMCTSK",$J,POS)) Q:'POS  S FLDA(404.52,POS_",",.091)=DT
VERPR ;verify already flagged positions; SD/499 replaced "AFLG" with "AFLAG"
 N II,POSH S II="" F  S II=$O(^SCTM(404.52,"AFLAG",II)) Q:'II  S POSH=""  F  S POSH=$O(^SCTM(404.52,"AFLAG",II,POSH)) Q:'POSH  D
 .N ZERO,ZEROTP S ZERO=$G(^SCTM(404.52,POSH,0))
 .I '$P(ZERO,U,4) S FLDA(404.52,POSH_",",.091)="" Q
 .;SD/499; added verification of the POSSIBLE PRIMARY PRACTITIONER field
 .;in the TEAM POSITION file
 .N TP S TP=$P(ZERO,U) S ZEROTP=$G(^SCTM(404.57,TP,0))
 .I '$P(ZEROTP,U,4) S FLDA(404.52,POSH_",",.091)="" Q
 .I (-$O(^SCTM(404.52,"AIDT",+ZERO,0,-9999999)))>$P(ZERO,U,2) S FLDA(404.52,POSH_",",.091)=""
 I $O(FLDA(0)) D FILE^DIE("I","FLDA","ERR")
 K ^TMP("SCMCTSK",$J)
 Q
