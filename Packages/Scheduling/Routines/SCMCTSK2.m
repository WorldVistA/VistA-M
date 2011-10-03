SCMCTSK2 ;ALB/JDS - PCMM Inactivation Nightly Job; 18 Apr 2003  9:36 AM ; 10/24/07 12:23pm  ; Compiled November 21, 2007 13:32:47  ; Compiled March 17, 2008 15:27:15
 ;;5.3;Scheduling;**297,498,527,499,532**;AUG 13, 1993;Build 21
 Q
NIGHT ;
 N ENDDT,NOINAC,SIXM,FLGDT,L,PATDT,SEEN,SDDT,LDOM
 D DT^DICRW S SDDT=$P($G(^XTMP("SCMCTSK2-"_DT,0)),U,2)
 I SDDT="" S SDDT=DT
 S ALPHA=$G(^SCTM(404.44,1,1)),ALPHA=$P(ALPHA,U,8) I ALPHA<SDDT S ALPHA=0
 ;if 'ALPHA NOINAC=1 except 15th and the Last Day of a Month (LDoM)
 ;inact only on 15th and on LDoM
 S (NOINAC,LDOM)=0
 S X1=SDDT,X2=1 D C^%DTC
 I ($E(SDDT,1,5)'=$E(X,1,5)) S LDOM=1
 I 'ALPHA D
 .I ($E(SDDT,6,7)'=15)&('LDOM) S NOINAC=1
 .D INACTIVE^SCMCTSK1
 S SIXM=$P($G(^SCTM(404.44,1,1)),U,9)
 I SIXM!(LDOM) D PRFLAG
 I ALPHA D INACTIVE^SCMCTSK1
 ;determine ENDDT-Inactn Date-30 days if flagged today
 F DATE=0:0 S DATE=$O(^SCPT(404.43,"AFLG",DATE)) Q:'DATE  D
 .F ENTRY=0:0 S ENTRY=$O(^SCPT(404.43,"AFLG",DATE,ENTRY)) Q:'ENTRY  D
 ..S ZERO=$G(^SCPT(404.43,ENTRY,0)) Q:'ZERO
 ..S DFN=+$G(^SCPT(404.42,+ZERO,0)) Q:'DFN
 ..S POS=$P(ZERO,U,2)
 ..I $P(ZERO,U,4) D UNFLG Q  ;unass.
 ..S X1=DATE,X2=$S(ALPHA:+2,1:+30) D C^%DTC S ENDDT=X
 ..N SDASS S SDASS=$P(ZERO,U,3)
 ..;N-new or E-stbl.
 ..;assig >12 months since flagging, not NEW, E-stbl)
 ..N NEW
 ..S NEW=0 S X1=DATE,X2=SDASS D ^%DTC I X<365 S NEW=1
 ..I NEW S %DT="",X="T-12M" D ^%DT S STDT=+Y D
 ...S X1=STDT,X2=-7 D C^%DTC S TYDT=X
 ..I 'NEW S %DT="",X="T-24M" D ^%DT S STDT=+Y D
 ...S X1=STDT,X2=-7 D C^%DTC S TYDT=X
 ..;
 ..;I $P(ZERO,U,17) D UNFLG Q  ;react.
 ..;get prec 
 ..;S %DT="",X="T-12M" D ^%DT S STDT=+Y
 ..;S PREC=$$DATES^SCAPMCU1(404.53,+POS),PREC=$S(PREC:$P($G(^SCTM(404.53,+$P(PREC,U,4),0)),U,6),1:+POS)
 ..I '$P(ZERO,U,5) D UNFLG Q  ;Not PC
 ..D SEEN^SCMCTSK1(DFN,POS,TYDT,SDDT,.PROV,.PRECP,.SEEN)
 ..;S PC=$$GET^XUA4A72(+PROV)
 ..I SEEN D UNFLG Q
 ..I $P(ZERO,U,13) S X1=DATE,X2=$S(ALPHA:4,1:90) D C^%DTC S FLGDT=X I FLGDT>SDDT Q  ;do not inactivate yet; extended
 ..I ('NOINAC)&(SDDT'<ENDDT) D DIS^SCMCTSK1
 ;flag prov 6m after install sd/297
 I NOINAC D:ALPHA BULL I '$D(^SCPT(404.43,"AFLG",SDDT)) K ^TMP($J,"SCMCTSK2") Q
 ;flag prov 6m after install sd/297
 ;I SIXM&(SIXM'>SDDT)!LDOM D
 I LDOM!ALPHA D
 .D PRINAC
 .;N FLDA
 .;S FLDA(404.44,"1,",19)=""
 .;D FILE^DIE("I","FLDA","ERR")
 D BULL K ^TMP($J,"SCMCTSK2")
 Q
UNFLG ;Unflagging
 N DR,DIE,DA
 S DR=".15///@;.13///@;.12///@",DIE="^SCPT(404.43,",DA=ENTRY D ^DIE
 Q
PRFLAG ;flag incorrect provider pos
 N POS
 ;prov inact. has run once
 ;I $P($G(^SCTM(404.44,1,1)),U,11)'="" Q
 D PRFLAG^SCMCTSK3
 Q
PRINAC ;inact. flagged providers
 N I,II
 ;Prov inact. run already
 I $G(SDDT)="" S SDDT=DT
 ;S II=$P($G(^SCTM(404.44,1,1)),U,11) I II'="",II'=SDDT Q
 F I=0:0 S I=$O(^SCTM(404.52,I)) Q:'I  S ZERO=$G(^(I,0)) I $P(ZERO,U,10) D
 .S ZEROIEN=I
 .;uncomment next line for testing only bpfo/swo 11.19.2008
 .;S X1=$P(ZERO,U,10),X2=$S(ALPHA:2,1:30) D C^%DTC I SDDT<X Q  ;not time yet
 .;I $P(ZERO,U,10)>$G(ENDDT) Q   ;not time yet
 .I +$$EN^SCMCTSKI(1)<SDDT Q
 .I $O(^SCTM(404.52,"AIDT",+ZERO,0,-9999999))<(-$P(ZERO,U,2)) Q   ;inactivated
 .;Check valid criteria
 .S POS=+ZERO
 .S PROV=+$$GETPRTP^SCAPMCU2(POS,SDDT)
 .S PC=$$GET^XUA4A72(+PROV)
 .S DR=".091///@",DIE="^SCTM(404.52,",DA=ZEROIEN D ^DIE  ;remove flag
 .S ZERO1=$G(^SCTM(404.57,POS,0))
 .I '$D(^SD(403.46,+$P(ZERO1,U,3),2,+PC)) D
 ..;inactivation
 ..K DO
 ..S DIC="^SCTM(404.52,",X=+ZERO,DIC("DR")=".02////"_DT_";.03////"_$P(ZERO,U,3)_";.04////0;.05///EMPLOYEE LEAVES POSITION;.11////1"
 ..S DIC(0)="Z" D FILE^DICN
 ..;S DIE="^SCTM(404.52,",DA=+ZERO,DR=".02////"_SDDT_";.03////"_$P(ZERO,U,3)_";.04////0;.05///EMPLOYEE LEAVES POSITION;.11////1"
 ..;D ^DIE
 ;only run inact. once
 S $P(^SCTM(404.44,1,1),U,11)=SDDT
 Q
FUTAPP(DFN) ;print future appts
 N TAB,SCDT0 S TAB=$X
 I $G(SDDT)="" S SDDT=DT
 S SCDT=SDDT+.24
 F  S SCDT=$O(^DPT(DFN,"S",SCDT)) Q:'SCDT  D
 . S SCDT0=$G(^DPT(DFN,"S",SCDT,0)) Q:$L($P(SCDT0,U,2))
 . S CLIEN=$P(SCDT0,"^") Q:'CLIEN
 . S Y=SCDT X ^DD("DD") W $E(Y_" ",1,17)_" "_$E($P($G(^SC(+CLIEN,0)),U),1,10)
 Q
GETASC(DATA,ENTRY) ;get assoc. clinics
 N I,CNT S CNT=0
 F I=0:0 S I=$O(^SCTM(404.57,+$G(ENTRY),5,I)) Q:'I  S CNT=CNT+1,DATA(CNT)=I_U_$P($G(^SC(I,0)),U)
 Q
SETASC(RESULT,DATA) ;set assoc. clinics
 D SETASC^SCMCTSK7(.RESULT,DATA) Q
MSG(SCTP,DFN) ;send inact. message
 ;given valid positions get current practitioners
 S SCLIST="SCL"
 I $G(SDDT)="" S SDDT=DT
 I "N"'[$P($G(^SCTM(404.57,SCTP,2)),U,9) D
 .S SCOK=$$PRTP^SCAPMC(SCTP,"",.SCLIST,.SCERR)
 .;if preceptor notice turned on for message type
 I +$P($G(^SCTM(404.57,SCTP,2)),U,9) D
 .S SCX=+$$OKPREC2^SCMCLK(SCTP,SDDT)
 .;if preceptor duz returned, add to array
 .I SCX S @SCLIST@("SCPR",SCX)=""
 N XMY F I=0:0 S I=$O(@SCLIST@("SCPR",I)) Q:'I  S XMY(I)=""
 S SCTEXT(1,0)="PATIENT "_$P($G(^DPT(DFN,0)),U)_" has been inactivated from PC team position "_$P($G(^SCTM(404.57,SCTP,0)),U)
 S XMSUB="Provider's Inactivated Primary Care Patients" D ^XMD
 Q
BULL ;EOM Bulletin
 N DISUPNO,BY,DHIT,HEAD
 S DISUPNO=1,L=0
 S XMSUB="Patients Scheduled for Inactivation from PC Panel"
 S XMY("G.PCMM PATIENT/PROVIDER INACTIVE")=""
 K ^TMP("SCMC",$J),^TMP("SCMCTXT",$J),^TMP("SCML",$J)
 S XMTEXT="^TMP(""SCMCTXT"",$J," ;S @XMTEXT@(0)=""
 S DIC="^SCPT(404.43,",BY="[SCMC FLAGGED BULLETIN]",FLDS="[SC BULLETIN]",CNT=0
 S:0 FLDS="" S IOP="",DHD="@@",(FR,TO)="" D EN1^DIP
 S ^TMP("SCMCTXT",$J,1,0)="There are "_$O(^TMP("SCMC",$J,""),-1)_" Patients scheduled for inactivation in next 30 days"
 D LINES(1)
 D ^XMD
 D PRMAIL^SCMCTSK5(1)
 F SCI=0:0 S SCI=$O(^TMP("SCF",$J,SCI)) Q:'SCI  D
 .K XMY S XMY(SCI)="" K ^TMP("SCMC",$J),^TMP("SCMCTXT",$J)
 .M ^TMP("SCMC",$J)=^TMP("SCF",$J,SCI)
 .S XMSUB="Patients Scheduled for Inactivation from PC Panel"
 .S XMTEXT="^TMP(""SCMCTXT"",$J,"
 S DISUPNO=1
 K ^TMP("SCMC",$J),^TMP("SCMCTXT")
 I $G(NOINAC) K ^TMP($J,"SCMCTSK2") Q  ; SD/499
 S XMSUB="Patients With Extended PCMM Inactivation Dates"
 S XMY("G.PCMM PATIENT/PROVIDER INACTIVE")=""
 K ^TMP("SCMC",$J)
 S XMTEXT="^TMP(""SCMCTXT"",$J," ;S @XMTEXT@(0)=""
 S DIC="^SCPT(404.43,",BY="[SCMC EXTENDED BULLETIN]",DHIT="S CNT=$G(CNT)+1,^TMP(""SCMC"",$J,CNT,D0)=""""",CNT=0
 S FR=",,,",TO=FR,FLDS="",IOP="",DHD="@@" D EN1^DIP
 S ^TMP("SCMCTXT",$J,1,0)="There are "_$O(^TMP("SCMC",$J,""),-1)_" Patients Extended from inactivation"
 D LINES(3)
 D ^XMD
 D PRMAIL^SCMCTSK5(3)
 S DISUPNO=1
 K ^TMP("SCMC",$J),^TMP("SCMCTXT")
 S XMSUB="Patients Automated Inactivations from PC Panels"
 S XMY("G.PCMM PATIENT/PROVIDER INACTIVE")=""
 K ^TMP("SCMC",$J)
 S XMTEXT="^TMP(""SCMCTXT"",$J," ;S @XMTEXT@(0)=""
 S DIC="^SCPT(404.43,",BY="[SCMC INACTIVATED]",DHIT="S CNT=$G(CNT)+1,^TMP(""SCMC"",$J,CNT,D0)=""""",CNT=0
 S FLDS="",IOP="",DHD="@@",FR=",T-30,,",TO=",,,,," D EN1^DIP
 S ^TMP("SCMCTXT",$J,1,0)="There are "_$O(^TMP("SCMC",$J,""),-1)_" Patients Inactivated in last 30 days"
 D LINES(2)
 D ^XMD
TST ;
 S DISUPNO=1
 D PRMAIL^SCMCTSK5(2)
 K ^TMP("SCMC",$J),^TMP("SCMCTXT")
 ;I $P($G(^SCTM(404.44,1,1)),U,11)="" D
 S XMSUB="PC Providers Scheduled for Inactivation"
 S XMY("G.PCMM PATIENT/PROVIDER INACTIVE")=""
 K ^TMP("SCMC",$J)
 S XMTEXT="^TMP(""SCMCTXT"",$J,"
 S DIC="^SCTM(404.52,",BY="[SC PROVIDER FLAGGED BULLE]",DHIT="S CNT=$G(CNT)+1,^TMP(""SCMC"",$J,CNT,D0)=""""",CNT=0
 S FLDS="",IOP="",DHD="@@",FR="",TO="" D EN1^DIP
 D LINES(4)
 D ^XMD
 D PRMAIL^SCMCTSK5(4)
 D BULL^SCMCTSK6
 Q
LINES(TYPE) ;Lines of Bulletin
 D LINES^SCMCTSK5(TYPE) Q
ROLE(DATA,INFO) ;SCMC ROLE
 N ROLE,TP,I
 S ROLE=+$G(INFO),TP=+$P($G(INFO),U,2)
 S DATA(0)="0^0^0"
 I 'ROLE Q
 I 'TP Q
 S DATA(0)=+$P($G(^SD(403.46,ROLE,0)),U,3) ;I DATA(0)=3!(DATA(0)=0) S DATA(0)=DATA(0)_"^0^0" Q
 I $$DATES^SCAPMCU1(404.53,+TP) S DATA(0)=DATA(0)_"^1^0" Q
 N PREC S PREC=0
 F I=0:0 S I=$O(^SCTM(404.53,"AD",TP,I)) Q:'I  D   Q:PREC
 .I $D(^SCTM(404.53,"AD",TP,I,1)) I '$D(^(0)) S PREC=1
 I PREC S DATA(0)=DATA(0)_"^0^1" Q
 S DATA(0)=DATA(0)_"^0^0"
 Q
INRPT ; REPORT
 N DIOEND,SCDHD
 D PROMPT^SCMCTSK3("** Date Range Selection **","DATE PATIENTS INACTIVATED FROM PC PANELS")
 Q:'$D(^TMP("SC",$J,"XR"))
 D UNASSIGN^SCMCTSK3
 S Q=""""
 S DIC="^SCPT(404.43," ;=0,BY="[SCMC INACTIVATION SORT]"
 D BY
 S (SCDHD,DHD)="AUTOMATED PATIENT INACTIVATION FROM PRIMARY CARE PANELS REPORT"
 S DIOBEG="D DIOBEG^SCMCTSK4"
 S DIOEND="D DIOEND1^SCMCTSK4"
 S FLDS="[SCMC INACTIVATED]" ;,FR="?,,"_$TR(DIPA("SI"),","," "),TO="T,,"_$TR(DIPA("EI")_"z",","," ")
 D EN1^DIP
 Q
IN30 ;inact. last month
 N DIPA,SDD D SORT^SCMCTSK1(.DIPA,.SDD) Q:'SDD  ;SD/499
 S Q=""""
 S DIC="^SCPT(404.43,",L=0,BY="[SCMC INACTIVATION SORT]"
 S DHD="Patients Inactivated from Primary Care Panels in the Past Month"
 S FLDS="[SCMC INACTIVATED]",FR="T-31,,"_$TR(DIPA("SI"),","," "),TO="T,,"_$TR(DIPA("EI")_"z",","," ")
 D EN1^DIP
 Q
EXRPT ;EXTEND REPORT
 K CLIN,TEAM,INST
 D PROMPT^SCMCTSK3("PCMM Patients with Extended Inactivations","Scheduled Inactivation Date")
 Q:'$D(^TMP("SC",$J,"XR"))
 S Q="""",SORT=1
 D EXTEND^SCMCTSK3
 S DIC="^SCPT(404.43," ;,L=0,BY="[SCMC EXTENDED]"
 S (SCDHD,DHD)="PCMM Patients with extended Inactivations"
 S DIOBEG="D DIOBEG^SCMCTSK4",DIOEND="D EXTKEY^SCMCTSK9"
 D BY
 S FLDS="[SCMC EXTENDED]"
 D EN1^DIP
 Q 
BY N DISPAR
 S BY(0)="^TMP(""SCSORT"",$J)",L(0)=$O(^TMP("SC",$J,"SORT",99),-1)+1,DISPAR(0,1)="+",L=0 I $G(SCDHD)["FTEE" S DISPAR(0,1)="+#" ;BY="@'.01"
 F I=1:1:$L(SORTN,U) S A=$P(SORTN,U,I) Q:'$L(A)  S $P(DISPAR(0,I),U,2)=";"_Q_A_": "_Q D
 .I A["PATIENT" I (I>1)!($G(SCDHD)["Patients Scheduled for Inactivation from PC Panel") S $P(DISPAR(0,I),U)="@"
 .I $G(SCDHD)["FTEE" D
 ..I A["PROV" S $P(DISPAR(0,I),U)="@"
 ..I I>1 I (A["CLI")!(A["POS") S $P(DISPAR(0,I),U)="@"_$P($G(DISPAR(0,I)),U)
 S ZTSAVE("^TMP(""SC"",$J,")="",ZTSAVE("^TMP(""SCSORT"",$J,")=""
 Q
FLRPT ;FLAGGED REPORT
 D PROMPT^SCMCTSK3("Patients Scheduled for Inactivation from PC Panels","Date Scheduled for Inactivation")
 Q:'$D(^TMP("SC",$J,"XR"))
 D FLAGG^SCMCTSK3
 S Q=""""
 S DIC="^SCPT(404.43,",L=0
 S (SCDHD,DHD)="Patients Scheduled for Inactivation from PC Panels"
 D BY
 S DIOBEG="D DIOBEG^SCMCTSK4"
 S FLDS="[SCMC PENDING UNASSIGN]"
 I $G(DISPAR(0,1))["PATIENT" S FLDS="[SCMC PENDING UNASSIGN PAT]"
 S DIOEND="D DIOEND^SCMCTSK4"
 D EN1^DIP
