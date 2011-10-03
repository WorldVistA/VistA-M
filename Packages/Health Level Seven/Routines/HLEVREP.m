HLEVREP ;O-OIFO/LJA - Event Monitor REPORTS ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
SHOWONE ; Show entry in any Event Monitoring file...
 ;
 ;
CTRL ;
 ;
 D HD
 D EX
 F  Q:(IOSL-$Y)<4  W !
 QUIT:$$BTE^HLCSMON("Press RETURN to continue, '^' to exit... ")  ;->
CTRL1 D HD
 W !!,"You must now select one of the following files..."
 S FILE=$$FILE QUIT:FILE'>0  ;->
 W !
 D @("SHOW"_FILE)
 G CTRL1 ;->
 ;
 ;
 ;
SHOW7761 ; Show HL7 Monitor (#776.1) entries...
 N DIC,IEN
 D HDR("View 'HL7 Monitor file (#776.1)' Entries")
 ;
S7761 KILL DIC,IEN
 W !
 S IEN=$$ASKIEN(776.1) QUIT:IEN'>0  ;->
 W !!,"Loading report..."
 D LOAD7761(IEN)
 D BROWSE^DDBR($NA(^TMP($J,"HL7761")),"N","View 'HL7 Monitor file (#776.1)' Entries")
 KILL ^TMP($J,"HL7761")
 G S7761 ;->
 ;
LOAD7761(IEN) ; Load browswer global...
 KILL ^TMP($J,"HL7761")
 D BODY7761(IEN)
 D RUNS7761(IEN)
 Q
 ;
RUNS7761(EVIEN) ;
 N DATA,IEN,LASTDT,RUNS
 ;
 KILL ^TMP($J,"HLRUNS")
 ;
 ; Loop thru master job runs looking for event monitor checks...
 S LASTDT=":",RUNS=0
 F  S LASTDT=$O(^HLEV(776.2,"B",LASTDT),-1) Q:'LASTDT!(RUNS>6)  D
 .  S IEN=":"
 .  F  S IEN=$O(^HLEV(776.2,"B",+LASTDT,IEN),-1) Q:'IEN!(RUNS>6)  D
 .  .  S MIEN=$O(^HLEV(776.2,+IEN,51,"B",EVIEN,0)) QUIT:MIEN'>0  ;->
 .  .  S DATA=$G(^HLEV(776.2,+IEN,51,MIEN,0))
 .  .  S ^TMP($J,"HLRUNS",IEN)=$P(DATA,U,2)_U_$P(DATA,U,3) ; STATUS^TIME
 .  .  S RUNS=RUNS+1
 ;
 ; If none found...
 QUIT:'$D(^TMP($J,"HLRUNS"))  ;->
 ;
 ; Recent master job checks of monitor...
 D ADD7761(""),ADD7761("Recent Master Job Checks of this Monitor")
 D ADD7761($$REPEAT^XLFSTR("-",74))
 S IEN=0
 F  S IEN=$O(^TMP($J,"HLRUNS",IEN)) Q:'IEN  D
 .  S DATA=^TMP($J,"HLRUNS",IEN)
 .  D ADD7761($E($$SDT^HLEVX001($P(DATA,U,2))_$$REPEAT^XLFSTR(" ",17),1,17)_"  "_$$STAT2M^HLEVX001($P(DATA,U)))
 ;
 Q
 ;
BODY7761(IEN) ; Actual display code for entry...
 N NODE,P1,P2,P3,P4,P5,P6,PAR,PCE
 ;
 S NODE=$G(^HLEV(776.1,+IEN,0))
 F PCE=1:1:6 S @("P"_PCE)=$P(NODE,U,PCE)
 ;
 ; Store under field number...
 F PCE=1:1:8 S PAR(PCE)=$P($G(^HLEV(776.1,+IEN,40)),U,PCE)
 ;
 D SH7761("Monitor",$S(P1]"":P1,1:"---"))
 D SH7761("Description",$S(P3]"":P3,1:"---"))
 D SH7761("Status",$S(P2="A":"ACTIVE",1:"INACTIVE"))
 D SH7761("Requeue minutes",$S(P4:P4_"min",P4=0:"0 [Immediate Run]",1:"---"))
 D SH7761("M startup",$S(P6]"":P6,1:"---"))
 D XMYS(+IEN)
 W !,$$CJ^XLFSTR(" Parameter ""Variable"" Descriptors ",IOM,"-")
 F PCE=1:1:8 I PAR(PCE)]"" D
 .  W !,?25,"Parameter - "_PCE_" = ",PAR(PCE)
 ;
 D SHWP(776.1,IEN,41,"Parameter Notes")
 D SHWP(776.1,IEN,50,"Event Description")
 ;
 Q
 ;
XMYS(HLEVIENE) ; Add XMYs from monitor...
 N REC,TAG,XMY
 D ADDXMYS^HLEVAPI2(+HLEVIENE) QUIT:'$D(XMY)  ;->
 S VAL=""
 F  S VAL=$O(XMY(VAL)) Q:VAL']""  D
 .  I VAL["@" S REC(VAL)="" QUIT  ;->
 .  I VAL=+VAL S VAL=$P($G(^VA(200,+VAL,0)),U) S:VAL]"" REC(VAL)="" QUIT  ;->
 .  I $E(VAL,1,2)="G." S REC(VAL)=""
 KILL XMY
 QUIT:'$D(REC)  ;->
 S VAL=""
 S TAG=$E("                    Recipients:                ",1,35)
 F  S VAL=$O(REC(VAL)) Q:VAL']""  D
 .  S TAG=TAG_VAL
 .  D ADD7761(TAG)
 .  S TAG=$$REPEAT^XLFSTR(" ",35)
 Q
 ;
SHWP(FILE,IEN,HLN,TAG) ;
 N MIEN,TXT
 QUIT:$O(^HLEV(FILE,+IEN,HLN,0))'>0  ;-> No data...
 S TXT=$$CJ^XLFSTR(" "_TAG_" ",IOM,"-")
 D ADD7761(TXT)
 S MIEN=0
 F  S MIEN=$O(^HLEV(FILE,+IEN,HLN,MIEN)) Q:MIEN'>0  D
 .  D ADD7761(^HLEV(FILE,+IEN,HLN,MIEN,0))
 Q
 ;
SH7761(TAG,VAL) ;
 N TXT
 S TXT=$E($$REPEAT^XLFSTR(" ",80),1,(32-$L(TAG)-2))_TAG_":"
 S TXT=$E(TXT_$$REPEAT^XLFSTR(" ",45),1,35)_VAL
 D ADD7761(TXT)
 Q
 ;
ADD7761(TXT) ; Add TXT to browser global...
 N NO
 S NO=$O(^TMP($J,"HL7761",":"),-1)+1
 S ^TMP($J,"HL7761",+NO)=TXT
 Q
 ;
SHOW776 ; Show HL7 Monitor Job (#776) entries...
 N DIC,IEN
S776 KILL DIC,IEN
 S IEN=$$ASKIEN(776) QUIT:IEN'>0  ;->
 D VIEW776(+IEN)
 W !,$$REPEAT^XLFSTR("-",IOM)
 G S776 ;->
 ;
VIEW776(IEN) ; Actual display code for entry...
 ;
 W !!,"View Code to be placed here..."
 Q
 ;
 ;
SHOW7762 ; Show HL7 Monitor Master Job (#776.2) entries...
 N DIC,IEN
S7762 KILL DIC,IEN
 S IEN=$$ASKIEN(776.2) QUIT:IEN'>0  ;->
 D VIEW7762(+IEN)
 W !,$$REPEAT^XLFSTR("-",IOM)
 G S7762 ;->
 ;
VIEW7762 ; Actual display code for entry...
 ;
 W !!,"View Code to be placed here..."
 Q
 ;
 ;
SHOW7769 ; Show HL7 Monitor Parameters (#776.999) entries...
 D VIEW7769(1)
 W !,$$REPEAT^XLFSTR("-",IOM)
 Q
 ;
VIEW7769(BT) ; Actual display code for entry...
 N DATA,NODE,P1,P2,P3,P4,P5,P6,PCE,TAG,VAL
 ;
 S NODE=$G(^HLEV(776.999,1,0)) I NODE']"" D  QUIT  ;->
 .  W !,"No system entry exists..."
 ;
 F PCE=1:1:6 S @("P"_PCE)=$P(NODE,U,PCE)
 ;
 S NODE(1)=P1_U_"Name"
 S NODE(2)=$S(P2="A":"ACTIVE",1:"INACTIVE")_U_"Status - MASTER"
 S NODE(3)=P3_"min"_U_"Requeue minutes - MASTER"
 S NODE(4)=P4_"hr"_U_"Purge hours - RUNTIME DATA"
 S NODE(6)=$S(P6="A":"ACTIVE",1:"INACTIVE")_U_"Status - EVENT"
 ;
 W @IOF,$$CJ^XLFSTR("System Parameters",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 ;
 F PCE=1,"Status Fields",2,6,"Requeue Frequency for Master Job",3,"Purge Parameters (""Cutoff"" hours)",4 D
 .  I PCE'=+PCE D  QUIT  ;->
 .  .  W !!,$$CJ^XLFSTR(PCE,IOM)
 .  .  W !,$$CJ^XLFSTR($$REPEAT^XLFSTR("-",$L(PCE)+20),IOM)
 .  S DATA=NODE(PCE),VAL=$P(DATA,U),TAG=$P(DATA,U,2)
 .  S DATA=TAG_":   "_VAL
 .  W !,$$CJ^XLFSTR(DATA,IOM)
 ;
 I $G(BT) D TELL^HLEVMST0("","0^0^999")
 ;
 Q
 ;
 ;
ASKIEN(FILE,HLAYGO) ; Generic DIC lookup...
 N DIC,X,Y
 S DIC=FILE,DIC(0)="AEMQN"_$G(HLAYGO)
 S DIC("A")="Select "_$S(FILE=776:"EVENT ""RUN"" ENTRY",FILE=776.1:"EVENT MONITOR ENTRY",FILE=776.2:"MASTER JOB ""RUN"" ENTRY",FILE=776.999:"PARAMETER ENTRY",1:"??")_": "
 D ^DIC
 Q $S(+Y>0:+Y,1:"")
 ;
FILE() ; Get from user file to display information...
 N ANS,DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^1:HL7 Monitor file (#776.1);2:HL7 Monitor Parameters file (#776.999);3:HL7 Monitor Job file (#776);4:HL7 Monitor Master Job file (#776.2);5:Exit this option"
 S DIR("A")="Select OPTION"
 D ^DIR
 S ANS=+Y\1,ANS=$S(ANS>0&(ANS<5):+ANS,1:"")
 S ANS=$S(ANS:$P("7761^7769^776^7762",U,+ANS),1:"")
 Q ANS
 ;
HD W @IOF,$$CJ^XLFSTR("Display Event Monitoring Entries",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;           This option displays entries from the following files:
 ;;   
 ;;                             SETUP-RELATED FILES
 ;;             ----------------------------------------------------
 ;;                       HL7 Monitor file (#776.1)
 ;;                       HL7 Monitor Parameters file (#776.999)
 ;;
 ;;                            RUNTIME-RELATED FILES
 ;;             ----------------------------------------------------
 ;;                       HL7 Monitor Job file (#776)
 ;;                       HL7 Monitor Master Job file (#776.2)
 Q
 ;
HDR(TXT,IEN) W @IOF,$$CJ^XLFSTR(TXT,IOM)
 N IOINHI,IOINORM,NAME,X,Y
 I $G(IEN) D
 .  S X="IOINHI;IOINORM" D ENDR^%ZISS
 .  S NAME=$P($G(^HLEV(776.1,+IEN,0)),U)
 .  W !,$$CJ^XLFSTR(IOINHI_NAME_" [#"_IEN_"]"_IOINORM,IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 Q
 ;
EOR ;HLEVREP - Event Monitor REPORTS ;5/16/03 14:42
