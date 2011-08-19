ORCDLR ;SLC/MKB-Utility functions for LR dialogs ;11/22/06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,29,49,61,71,79,175,243**;Dec 17, 1997;Build 242
TEST ; -- Setup ORTEST() array of ordering parameters
 N OI,TST,WRD,I,DG
 S OI=+$G(ORDIALOG(PROMPT,INST)) Q:'OI
 I '$D(ORTEST) S TST=+$P($G(^ORD(101.43,OI,0)),U,2) D TEST^LR7OR3(TST,.ORTEST) S ORTEST=TST
 S WRD="GenWardInstructions" I $O(ORTEST(WRD,0)) D  W !
 . W ! S I=0 F  S I=$O(ORTEST(WRD,I)) Q:I'>0  W !,ORTEST(WRD,I,0)
 S DG=$P($G(^ORD(101.43,+OI,"LR")),U,6) S:'$L(DG) DG="LAB"
 S DG=$O(^ORD(100.98,"B",DG,0)) S:DG ORDG=DG
 Q
 ;
CKTYP ; -- ck type of test [Exit Action]
 N X,Y S X=$G(ORDIALOG(PROMPT,INST)) Q:'X
 S Y=$P($G(^ORD(101.43,+X,"LR")),U,7)
 I (Y="O")!(Y="N") W $C(7),!,"This test may not be ordered anymore.  Please select another test." S ORQUIT=1 D WAIT Q
 Q
 ;
WAIT ; -- Wait for user
 N X W !,"Press <return> to continue ..." R X:DTIME
 Q
 ;
SHOWMAX ; -- Setup max days allowed for cont orders
 K ^TMP($J,"ORCDLR SHOWMAX")
 D ZERO^PSS51P1(+ORSCH,,,,"ORCDLR SHOWMAX")
 I $S('$G(ORSCH):1,"CD"'[$P($G(^TMP($J,"ORCDLR SHOWMAX",+ORSCH,5)),U):1,1:0) K ORDIALOG(PROMPT,INST) Q  ;just in case
 ;I $S('$G(ORSCH):1,"CD"'[$P($G(^PS(51.1,+ORSCH,0)),U,5):1,1:0) K ORDIALOG(PROMPT,INST) Q  ;just in case
 N Y,OK S ORSMAX=$G(^TMP($J,"ORCDLR SHOWMAX",+ORSCH,2.5)),ORSTMS=$P($G(^(0)),U,3)
 ;N Y,OK S ORSMAX=$P($G(^PS(51.1,ORSCH,0)),U,7),ORSTMS=$P($G(^(0)),U,3)
 S ORSMAX=$S('$G(ORSMAX):ORMAX,$G(ORTYPE)="Z":ORSMAX,ORMAX<ORSMAX:ORMAX,1:ORSMAX),ORSTMS=$S(ORSMAX&ORSTMS:ORSMAX*1440\ORSTMS,1:"") ;set max days, times
 I FIRST,$G(ORTYPE)="Q" S Y=$G(ORDIALOG(PROMPT,INST)) I $L(Y) S OK=$$CKMAX(Y) Q:OK  K ORDIALOG(PROMPT,INST) ;Q if valid, else fall thru and prompt
 W !!,"Maximum number of days for continuous orders is "_ORSMAX_"; enter a duration",!,"as either a number of days (3) or Xnumber of times (X3).",!
 K ^TMP($J,"ORCDLR SHOWMAX")
 Q
 ;
CKMAX(X) ; -- Ck duration X against max allowed
 N Y S Y=1
 I +X=X S Y=$S(X<0:"0^Cannot order in the past.",'ORSMAX:1,X'>ORSMAX:1,1:"0^Cannot order more than "_ORSMAX_" days in advance.") G CKQ
 I (X'?1"X"1.N),(X'?1"x"1.N) S Y="0^Enter either a number of days or X_number of times." G CKQ
 I ORSTMS,+$E(X,2,9)>ORSTMS S Y="0^Cannot order more than "_ORSTMS_" time* s." G CKQ
 I 'ORSTMS,+$E(X,2,9)>ORSMAX S Y="0^Cannot order for more than "_ORSMAX_" days." G CKQ ; day of week schedule
 S Y=1
CKQ Q Y
 ;
SAMPLE() ; -- Get default sample from Test for INST
 N X,Y I $L($G(LRFSAMP)) Q LRFSAMP
 I (ORCOLLCT="LC")!(ORCOLLCT="I") S X=$G(ORTEST("Lab CollSamp")) G SAMPQ
 S X=$G(ORTEST("Unique CollSamp")) G:X SAMPQ
 S X=$G(ORTEST("Default CollSamp"))
SAMPQ S Y=+$G(ORTEST("CollSamp",+X))
 Q Y
 ;
ENSAMP ; -- Get list of samples to pick from
 Q:$G(ORDIALOG(PROMPT,"LIST"))  N I,CNT,X,Y S (I,CNT)=0
 F  S I=$O(ORTEST("CollSamp",I)) Q:I'>0  S X=$G(ORTEST("CollSamp",I)) D
 . S Y=$P(X,U,1,2)_"   "_$$GET1^DIQ(61,+$P(X,U,3)_",",.01)_"  "_$P(X,U,4)
 . S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=Y
 . S ORDIALOG(PROMPT,"LIST","B",$P(X,U,2))=+X
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT_$S($$SECTION'="MI":"^1",1:"")
 Q
 ;
ASKSAMP() ; -- Ask for Collection Sample?
 N X,Y,DIR,DEFSAMP,SAMP0
 S DEFSAMP=$G(ORDIALOG(PROMPT,INST)),SAMP0=$G(^LAB(62,+DEFSAMP,0))
 I $G(ORTYPE)="Z",DEFSAMP Q 1
 I (ORCOLLCT="LC")!(ORCOLLCT="I"),$G(ORTEST("Lab CollSamp")) W !!,"Lab will collect "_$P(SAMP0,U)_" "_$P(SAMP0,U,3)_".",! Q 0
 I $G(ORTEST("Unique CollSamp")),DEFSAMP Q 0 ; unique -> don't ask
 I 'DEFSAMP!('FIRST) Q 1 ; no default or edit -> ask
 I $G(ORDIALOG(PROMPT,"LIST"))="1^1" Q 0 ; only one choice
 S DIR(0)="YA",DIR("A")="Is "_$P(SAMP0,U)_" "_$P(SAMP0,U,3)_" the correct sample to collect? ",DIR("B")="Yes"
 D ^DIR I $D(DTOUT)!$D(DUOUT) S ORQUIT=1 Q 0
 D:'Y LIST^ORCD
 Q 'Y
 ;
SECTION() ; -- Returns Lab section of Orderable Item
 N PTR,X
 S PTR=$O(^ORD(101.41,"AB","OR GTX ORDERABLE ITEM",0))
 S X=$P($G(^ORD(101.43,+$G(ORDIALOG(PTR,1)),"LR")),U,6)
 Q X
 ;
SHOWCOMM(SAMP) ; -- Show comments for sample
 Q:'$G(SAMP)  Q:'$G(ORTEST)  N ORCOMM,I
 D SCOM^LR7OR3(+ORTEST,SAMP,.ORCOMM)
 S I=0 F  S I=$O(ORCOMM(I)) Q:I'>0  W !,ORCOMM(I,0)
 Q
 ;
SPECIMEN() ; -- Get default specimen from Sample for INST
 N X,Y I $L($G(LRFSPEC)) S Y=LRFSPEC
 E  S X=$$VAL^ORCD("COLLECTION SAMPLE"),Y=+$P($G(^LAB(62,+X,0)),U,2)
 Q Y
 ;
SPECHELP ; -- Xecutable help for Specimen prompt
 I '$D(^LAB(61,"E")) D P^ORCDLGH Q
 W !,"Choose from: "
 N SP,I,DONE,CNT S (CNT,DONE)=0,SP=""
 F  S SP=$O(^LAB(61,"E",SP)) Q:SP=""  S I=+$O(^(SP,0)) I I D
 . S CNT=CNT+1 I CNT>(IOSL-2) S CNT=0 I '$$MORE^ORCD S DONE=1 Q
 . W !,"     "_$P($G(^LAB(61,I,0)),U)
 Q
 ;
URGENCY ; -- Get list of urgencies to pick from
 Q:$D(ORDIALOG(PROMPT,"LIST"))  N I,J,X
 I $G(ORTEST("Default Urgency")) S ORDIALOG(PROMPT,"LIST")="1^1",ORDIALOG(PROMPT,"LIST",1)=ORTEST("Default Urgency") Q  ; Forced Urgency
 I '$D(ORTEST("Urgencies")) S ORDIALOG(PROMPT,"LIST")="0^1" Q
 S (I,J)=0 F  S I=$O(ORTEST("Urgencies",I)) Q:I'>0  D
 . S X=ORTEST("Urgencies",I) I $G(ORCOLLCT)="LC",'$P($G(^LAB(62.05,+X,0)),U,2) Q  ; Lab cannot collect
 . S J=J+1,ORDIALOG(PROMPT,"LIST",J)=X,ORDIALOG(PROMPT,"LIST","B",$P(X,U,2))=+X
 S ORDIALOG(PROMPT,"LIST")=J_"^1"
 Q
 ;
ASKURG() ; -- Ask urgency prompt?
 I $G(ORTEST("Default Urgency")) Q 0 ; Forced Urgency
 I FIRST,$G(ORL) Q $$GET^XPAR("ALL^"_ORL,"LR ASK URGENCY")
 Q (+$G(ORDIALOG(PROMPT,"LIST"))>1)
 ;
REQDCOMM() ; -- Process required comments
 I $O(^TMP("ORWORD",$J,PROMPT,INST,0)) Q 0 ;edit as WP
 N LRTEST,LRSAMP,LRSPEC,LRTSTN,LRTCOM,LRCCOM,DA,CNT,I,REQDCOMM
 S LRSAMP=$$VAL^ORCD("COLLECTION SAMPLE"),LRSPEC=$$VAL^ORCD("SPECIMEN")
 S LRTSTN=1,LRTEST(1)=+ORTEST,DA=$O(^LAB(60,LRTEST(1),3,"B",+LRSAMP,0))
 S REQDCOMM=$P($G(^LAB(60,LRTEST(1),3,+DA,0)),U,6)
 S:'REQDCOMM REQDCOMM=+$P($G(^LAB(60,LRTEST(1),0)),U,19) Q:'REQDCOMM 1
 I $G(ORTYPE)="Z",$P($G(^LAB(62.07,+REQDCOMM,0)),U)'="ORDER COMMENT" Q 1
 X:$D(^LAB(62.07,REQDCOMM,.1)) ^(.1)
 S (CNT,I)=0 K REQDCOMM
 F  S I=$O(LRTCOM(LRTEST(1),I)) Q:I'>0  S CNT=CNT+1,REQDCOMM(CNT,0)=LRTCOM(LRTEST(1),I)
 S:$L($G(LRCCOM)) CNT=CNT+1,REQDCOMM(CNT,0)=LRCCOM
 I CNT S REQDCOMM(0)="^^"_CNT_U_CNT_U_DT_U_U,ORDIALOG(PROMPT,INST)="^TMP(""ORWORD"",$J,"_PROMPT_","_INST_")" M ^TMP("ORWORD",$J,PROMPT,INST)=REQDCOMM
RQ Q 1
 ;
XHELP(PTR) ; -- Xecutable help
 I $D(ORDIALOG(PTR,"LIST")),X="?"!$P(ORDIALOG(PTR,"LIST"),U,2) D LIST^ORCD Q
 D P^ORCDLGH ; ??-help
 Q
 ;
CHANGED(FLD) ; -- Kill dependent values when FLD changes
 N PROMPTS,P,NAME,PTR K ORCOLLCT
 S PROMPTS="COLLECTION SAMPLE^SPECIMEN^WORD PROCESSING 1^START DATE/TIME"
 S:FLD="OI" PROMPTS="COLLECTION TYPE^"_PROMPTS_"^LAB URGENCY"
 F P=1:1:$L(PROMPTS,U) S NAME=$P(PROMPTS,U,P),PTR=$O(^ORD(101.41,"AB","OR GTX "_NAME,0)) I PTR K ORDIALOG(PTR,ORI),ORDIALOG(PTR,"LIST")
 Q
 ;
LB(ORDER) ; -- Returns 1 or 0, if "LB #" is already in text
 N I,Y S I=0,Y=0
 F  S I=$O(^OR(100,+ORDER,1,I)) Q:I'>0  I $G(^(I,0))["LB #" S Y=1 Q
 Q Y
 ;
DATE(X) ; Free text input to FM time
 N %DT,Y
 D ^%DT
 Q Y
 ;
XSCH ; -- xecutable help for schedule prompt
 N X,IFN,CNT,Z,DONE
 K ^TMP($J,"ORSCLR XSCH")
 D AP^PSS51P1("LR",,,,"ORSCLR XSCH")
 W !!,"Choose from:" S CNT=1
 S X="" F  S X=$O(^TMP($J,"ORSCLR XSCH","APLR",X)) Q:X=""  S IFN=0 D  Q:$G(DONE)
 .;S X="" F  S X=$O(^PS(51.1,"APLR",X)) Q:X=""  S IFN=0 D  Q:$G(DONE)
 . F  S IFN=$O(^TMP($J,"ORSCLR XSCH","APLR",X,IFN)) Q:IFN'>0  D  Q:$G(DONE)
 . .;F  S IFN=$O(^PS(51.1,"APLR",X,IFN)) Q:IFN'>0  D  Q:$G(DONE)
 .. W !,"   "_X S CNT=CNT+1 Q:CNT'>(IOSL-5)  S CNT=0
 .. W !,"   '^' TO STOP: " R Z:DTIME S:'$T!(Z["^") DONE=1
 W !
 K ^TMP($J,"ORSCLR XSCH")
 Q
 ;
MULT(ORIFN,CTYPE,CDATE) ;check multiple orders from VALID^ORCDLR1
 N KID,OREVENT,ORSTRT,OK,X,Y,%DT
 I '$D(CTYPE) S CTYPE=$$VALUE^ORCSAVE2(ORIFN,"COLLECT")
 Q:"SPWC"[CTYPE 0  ; only check LC and I
 I '$D(CDATE) S CDATE=$$VALUE^ORCSAVE2(ORIFN,"START")
 D AM^ORCSAVE2:CDATE="AM",NEXT^ORCSAVE2:CDATE="NEXT" ; returns X
 S %DT="T" S:'$D(X) X=CDATE  D ^%DT I Y<1 Q 0
 D SCHEDULE^ORCSEND1(ORIFN,"LR",.ORSTRT,Y) Q:ORSTRT'>1 0 ; get all starts
 S KID=0,OK=1 F  S KID=$O(ORSTRT(KID)) Q:'KID!('OK)  D
 . I CTYPE="LC" S OK=$$LABCOLL^ORCDLR1(KID) Q
 . S OK=$$IMMCOLL^ORCDLR1(KID)
 I OK Q 0
 Q "1^One or more of the multiple orders will be changed to Ward Collect"
