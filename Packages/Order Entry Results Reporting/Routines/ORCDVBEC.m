ORCDVBEC ;SLC/MKB-Utility functions for VBECS dialogs ;2/11/08  11:04
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212,309**;Dec 17, 1997;Build 26
 ;
 ; External References:
 ;   OEAPI^VBECA3       #4766
 ;   RR^LR7OR1          #2503
 ;   GCOM^LR7OR3        #2428
 ;   $$SITE^VASITE      #10112
 ;   $$HL7TFM^XLFDT     #10103
 ;   $$UP^XLFSTR        #10104
 ;
PTR(X) ; -- Returns pointer to #101.41 of prompt OR GTX X
 Q +$O(^ORD(101.41,"AB","OR GTX "_X,0))
 ;
EN ; -- entry action
 I '$L($T(OEAPI^VBECA3)) W $C(7),!!,"Blood Bank orders are not available yet!" H 2 S ORQUIT=1 Q
 N DIV,ORSTN,C,N,X S DIV=+$P($G(^SC(+$G(ORL),0)),U,15)
 S ORSTN=$P($$SITE^VASITE(DT,DIV),U,3)
 I $G(ORTYPE)'="Z" D OEAPI^VBECA3(.ORVB,+ORVP,ORSTN),PTINFO^ORCDVBC1
 S C=0 F  S C=$O(ORVB(C)) Q:C<1  S N=0 F  S N=$O(ORVB(C,"MSBOS",N)) Q:N<1  S X=$G(ORVB(C,"MSBOS",N)),ORMSBOS(C,$P(X,U))=$P(X,U,2) ;sort
 ;get initial state: ORCOMP/ORTEST = id^id^ ^id, ORTAS = 1 or 0:
 S (ORCOMP,ORTEST,ORTAS)="" I $D(OREDIT)!$G(OREWRITE) D
 . N P,I,X,X0 S P=$$PTR("ORDERABLE ITEM")
 . S I=0 F  S I=$O(ORDIALOG(P,I)) Q:I<1  S X=+$G(ORDIALOG(P,I)) D
 .. S X0=$G(^ORD(101.43,X,"VB")),X=+$P($G(^(0)),U,2)
 .. I $P(X0,U) S ORCOMP=ORCOMP_$S($L(ORCOMP):U,1:"")_X Q
 .. S ORTEST=ORTEST_$S($L(ORTEST):U,1:"")_X
 Q
 ;
EX ; -- exit action
 K ORITM,ORCOMP,ORTEST,ORTAS,ORMSBOS,ORTIME,ORIMTIME,ORDIV,ORCOLLCT,ORVB,ORASK
 I $G(ORXL) S ORL=ORXL K ORXL
 Q
 ;
XHELP ; -- display OI's in groups
 N INDEX,CNT,SCREEN,X,Y,SYN,Y0,D,Z,DONE
 S CNT=1,SCREEN=$G(ORDIALOG(PROMPT,"S"))
 F INDEX="S.VBC","S.VBT" D  Q:$G(DONE)
 . W !!,$S(INDEX["C":"Choose from Blood Components:",1:"or Diagnostic Tests:")
 . S X="" F  S X=$O(^ORD(101.43,INDEX,X)) Q:X=""  S Y=0 D  Q:$G(DONE)
 .. F  S Y=$O(^ORD(101.43,INDEX,X,Y)) Q:Y'>0  S SYN=$G(^(Y)) I 'SYN D  Q:$G(DONE)
 ... S Y0=$G(^ORD(101.43,Y,0)),D=INDEX X:$L(SCREEN) SCREEN Q:'$T
 ... W !,"   "_X ;W:SYN "     "_$P(SYN,U,4) ; echo .01 if synonym
 ... S CNT=CNT+1 Q:CNT'>(IOSL-5)  S CNT=0
 ... W !,"   '^' TO STOP: " R Z:DTIME S:'$T!(Z["^") DONE=1
 W !
 Q
 ;
PSAOI ; -- set ORASK flags or show GenWrdInstructions for OI instance
 I $$DUP^ORCD(PROMPT,ORI) K DONE W $C(7),!,"This component or test has already been selected!",! Q
 N X0,NAME,ORT,ORWRD,WRD,I
 S ORASK=+$G(^ORD(101.43,+$G(Y),"VB")),X0=$G(^(0)) ;VBEC OI
 Q:ORASK  Q:$G(ORESET)=+$G(Y)  ;get ward instr for new tests
 S NAME=$P(X0,U,8),ORT=+$$TEST^ORCSEND2(NAME) ;corresponding Lab OI
 S ORT=+$P($G(^ORD(101.43,ORT,0)),U,2) ;#60 ien
 D GCOM^LR7OR3(ORT,.ORWRD) S WRD="GenWardInstructions"
 I $O(ORWRD(WRD,0)) W !! S I=0 F  S I=$O(ORWRD(WRD,I)) Q:I'>0  W ORWRD(WRD,I,0),!
 Q
 ;
MOD ; -- get allowable modifier values
 Q:$G(ORDIALOG(PROMPT,"LIST"))  N ORX,I,X
 D GETLST^XPAR(.ORX,"ALL","OR VBECS MODIFIERS","Q")
 S I=0 F  S I=$O(ORX(I)) Q:I<1  D
 . S X=$P($G(ORX(I)),U,2) Q:'$L(X)
 . S ORDIALOG(PROMPT,"LIST",I)=X_U_X
 . S ORDIALOG(PROMPT,"LIST","B",$$UP^XLFSTR(X))=X
 S:ORX ORDIALOG(PROMPT,"LIST")=ORX_"^1"
 Q
 ;
PSAMT ; -- Post-Selection Action for Amount, to validate and format
 ;   only allow numeric entry for now, until GUI can accept volume
 N X,X1,X2
 I +Y'=Y W !,$C(7),"Enter the number of units needed, from 1-99." K DONE Q
 S X=$$UP^XLFSTR(Y),X1=+X ;,X2=$$STRIP($P(X,X1,2))
 ;I X2="ML" S ORDIALOG(PROMPT,ORI)=X1_"ml" Q
 I (X1<1)!(X1>99) W !,$C(7),"Enter the number of units needed, from 1-99." K DONE Q  ;!("UNITS"'[X2)
 S ORDIALOG(PROMPT,ORI)=X1 ;_" unit"_$S(X1>1:"s",1:"")
 Q
 ;
SPCSTS ; -- set Specimen Status by component [Entry Action]
 I '$G(ORASK) K ORDIALOG(PROMPT,INST) Q  ;not a component
 N OI,X S OI=+$G(ORDIALOG($$PTR("ORDERABLE ITEM"),INST))
 S X=+$P($G(^ORD(101.43,OI,0)),U,2)
 S ORDIALOG(PROMPT,INST)=$G(ORVB(X,"SPECIMEN"))_U_$G(ORVB("SPECIMEN"))
 Q
 ;
EXOI ; -- setup dialog parameters for selected items
 N ORI,X,X0,TEST,COMP
 S (ORTAS,TEST,COMP)="" K ORASK
 S ORI=0 F  S ORI=$O(ORDIALOG(PROMPT,ORI)) Q:ORI<1  D
 . S X=+$G(ORDIALOG(PROMPT,ORI)),X0=$G(^ORD(101.43,X,"VB")),X=+$P($G(^(0)),U,2)
 . I $P(X0,U) S COMP=COMP_$S($L(COMP):U,1:"")_X Q
 . S TEST=TEST_$S($L(TEST):U,1:"")_X S:$P(X0,U,2)>1 ORTAS=1
 I ORTEST'=TEST S ORTEST=TEST K ORTEST("Lab CollSamp")
 I ORCOMP'=COMP S ORCOMP=COMP D CHANGED:'FIRST,COMP:COMP
 I ORCOMP,U[$G(ORVB("ABORH")),'ORTAS,$G(ORTYPE)'="Z" D ADDTAS
 Q
 ;
COMP ; -- Handle component-specific tasks [from EXOI]
 ;    Uses ORCOMP, ORVB(comp)
 Q:$G(ORTYPE)="Z"  ;QO editor
 N ORP,ORI,ORT,ORTST,ORTMP,ORTDT,ORZ,ORHDR,OROOT,N
 F ORI=1:1:$L(ORCOMP,U) S ORC=$P(ORCOMP,U,ORI) D
 . S N=0 F  S N=$O(ORVB(ORC,"TEST",N)) Q:N<1  S ORT=+$G(ORVB(ORC,"TEST",N)),ORTST(ORT)=""
 . I $G(ORVB(ORC,"SPECIMEN")),$P($G(ORVB("SPECIMEN")),U,2)="",'ORTAS D ADDTAS
C1 S ORP=$$PTR("RESULTS"),(ORI,ORT)=0 F  S ORT=+$O(ORTST(ORT)) Q:ORT<1  D
 . K ^TMP("LRRR",$J) D RR^LR7OR1(+ORVP,,,,,ORT,,1)
 . ;S ORTMP="^TMP(""LRRR"",$J,+ORVP)",ORTMP=$Q(@ORTMP)
 . ;Q:$P(ORTMP,",",1,3)'=("^TMP(""LRRR"","_$J_","_+ORVP)
 . S ORTMP=$$FIRST(+ORVP,ORT) Q:'$L(ORTMP)
 . S ORTDT=9999999-+$P(ORTMP,",",5),ORZ=@ORTMP
 . S ORI=ORI+1,ORDIALOG(ORP,ORI)=$P(ORZ,U,1,6)_U_ORTDT
 . W:'$G(ORHDR) !!,"RECENT LAB RESULTS:",!,"Test       Result    Units      Range     Collected       Accession     Sts"
 . W:'$G(ORHDR) !,"----       ------    -----      -----     ---------       ---------     ---"
 . W !,$$PAD^ORCHTAB($P(ORZ,U,15),8)_$J($P(ORZ,U,2),9)_" "_$$PAD^ORCHTAB($P(ORZ,U,3),3)_$$PAD^ORCHTAB($P(ORZ,U,4),11)_$$PAD^ORCHTAB($P(ORZ,U,5),10)_$$DATETIME^ORCHTAB(ORTDT)_"  "_$$PAD^ORCHTAB($P(ORZ,U,16),15)_$P(ORZ,U,6)
 . S ORHDR=1,OROOT=$P(ORTMP,",",1,5)_",""N""" ;ck for comments
 . F  S ORTMP=$Q(@ORTMP) Q:$P(ORTMP,",",1,6)'=OROOT  W !," "_@ORTMP
 W:$G(ORHDR) ! K ^TMP("LRRR",$J)
 W !!,"NOTE: The nursing blood administration order must be entered separately."
 Q
 ;
FIRST(DFN,TEST) ; -- returns array reference to first data node 
 ;    in ^TMP("LRRR",$J,DFN) for TEST
 N Y,IDT,DA S Y=""
 S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,"CH",IDT)) Q:IDT<1  D  Q:Y
 . S DA=0 F  S DA=$O(^TMP("LRRR",$J,DFN,"CH",IDT,DA)) Q:DA<1  I +$G(^(DA))=TEST S Y=1 Q
 I Y S Y=$NA(^TMP("LRRR",$J,DFN,"CH",IDT,DA))
 Q Y
 ;
ADDTAS ; -- adds T&S to order, sets ORTAS=1
 ;    Expects PROMPT=OI, ORTEST
 N ORI S ORI=$O(ORDIALOG(PROMPT,"?"),-1),ORI=ORI+1
 S ORDIALOG(PROMPT,ORI)=+$O(^ORD(101.43,"ID","1;99VBC",0))
 W !!,"Type & Screen added for new specimen."
 S ORTAS=1,ORTEST=$G(ORTEST)_$S($L($G(ORTEST)):U,1:"")_"1"
 Q
 ;
CHANGED ; -- Kill dependent values when Component changes
 N PTR,I,J
 F I="FREE TEXT","RESULTS" S PTR=$$PTR(I) I PTR D
 . S J=0 F  S J=$O(ORDIALOG(PTR,J)) Q:J<1  K ORDIALOG(PTR,J)
 . K ORDIALOG(PTR,"LIST")
 Q
 ;
DTW ; -- Comp D/T Wanted to specimen exp d/t for TAS [DTW Exit Action]
 Q:$G(ORTAS)  Q:'$G(ORVB("SPECIMEN"))  Q:$G(ORTYPE)="Z"
 N X,Y,%DT,EXP
 S X=$G(ORDIALOG(PROMPT,INST)),%DT="T" D ^%DT Q:Y<1
 S EXP=$$HL7TFM^XLFDT(+$G(ORVB("SPECIMEN")))
 I EXP<Y D ADDTAS
 Q
 ;
REASON ; -- get allowable reasons
 Q:$G(ORDIALOG(PROMPT,"LIST"))  N ORX,I,X
 D GETLST^XPAR(.ORX,"ALL","OR VBECS REASON FOR REQUEST","Q")
 S I=0 F  S I=$O(ORX(I)) Q:I<1  D
 . S X=$P($G(ORX(I)),U,2) Q:'$L(X)
 . S ORDIALOG(PROMPT,"LIST",I)=X_U_X
 . S ORDIALOG(PROMPT,"LIST","B",$$UP^XLFSTR(X))=X
 S:ORX ORDIALOG(PROMPT,"LIST")=ORX ;_"^1"
 Q
 ;
ENTYPE ; -- set up Coll Type
 I '$D(ORTEST("Lab CollSamp")) D
 . N I,V,T,LC S LC=1
 . F I=1:1:$L(ORTEST,U) S V=+$P(ORTEST,U,I) D  Q:'LC  ;no LC samp
 .. S T=$$LAB60(V) ;VBECS ID -> #60 ien
 .. I '$P($G(^LAB(60,T,0)),U,9) S LC=0 Q
 . S ORTEST("Lab CollSamp")=LC
 I '$D(ORTIME),'$D(ORIMTIME) D GETIMES^ORCDLR1
 Q
 ;
LAB60(X) ; -- Return file 60 ien for VBECS OI ID
 N Y,I,NM
 S I=$O(^ORD(101.43,"ID",+X_";99VBC",0)),NM=$P($G(^ORD(101.43,+I,0)),U)_" - LAB"
 S Y=+$O(^LAB(60,"B",NM,0))
 Q Y
 ;
ENSURG ; -- Get list of surgeries from ORVB("SURGERY")
 S:$P($G(^ORD(101.42,+$$VAL^ORCD("URGENCY"),0)),U,2)="P" REQD=1
 Q:$G(ORDIALOG(PROMPT,"LIST"))  N I,CNT,X S (I,CNT)=0
 F  S I=$O(ORVB("SURGERY",I)) Q:I'>0  S X=$G(ORVB("SURGERY",I)) D
 . S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=X_U_X
 . S ORDIALOG(PROMPT,"LIST","B",$$UP^XLFSTR(X))=X
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT_"^1"
 Q
 ;
CKMSBOS ; -- check if MSBOS limit exists, was exceeded [from PSA]
 Q:'$L($G(Y))  N OI,AMT,I,X,COMP,LIMIT
 S OI=$$PTR("ORDERABLE ITEM"),AMT=$$PTR("AMOUNT")
 S I=0 F  S I=$O(ORDIALOG(OI,I)) Q:I<1  D
 . S X=ORDIALOG(OI,I),COMP=+$P($G(^ORD(101.43,+X,0)),U,2)
 . S LIMIT=$G(ORMSBOS(COMP,$P(Y,U))) Q:LIMIT=""
 . Q:$G(ORDIALOG(AMT,I))'>LIMIT
 . W !,"  >> Requested #units of "_$P($G(^ORD(101.43,+X,0)),U)_" exceeds MSBOS limit of "_LIMIT_"!",!
 Q
 ;
ENURG ; -- Get list of urgencies from #101.42, parameter
 Q:$G(ORDIALOG(PROMPT,"LIST"))  N I,CNT,X S CNT=0
 S X="" F  S X=$O(^ORD(101.42,"S.VBEC",X)) Q:X=""  D
 . ;I X="STAT" Q:'$$GET^XPAR("ALL","OR VBECS STAT USER")
 . ;I X="STAT",'$D(^XUSEC("ORES",DUZ)),'$D(^XUSEC("ORELSE",DUZ)) Q
 . S I=0 F  S I=$O(^ORD(101.42,"S.VBEC",X,I)) Q:I<1  D
 .. S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",CNT)=I_U_X
 .. S ORDIALOG(PROMPT,"LIST","B",$$UP^XLFSTR(X))=I
 S:CNT ORDIALOG(PROMPT,"LIST")=CNT_"^1"
 Q
 ;
ASKURG() ; -- ask unless PreOp, set default
 N Y S Y=1
 I FIRST,'$D(ORDIALOG(PROMPT,INST)),$G(ORTYPE)'="Z" D
 . I $$PREOP S ORDIALOG(PROMPT,INST)=+$O(^ORD(101.42,"C","P",0)),Y=0 Q
 . S ORDIALOG(PROMPT,INST)=9 ;default
 Q Y
 ;
PREOP() ; -- Returns 1 or 0, if order is for pre-op
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YAO",DIR("A")="Is this order for pre-op? "
 S DIR("?")="If YES, the urgency will be set to PRE-OP and a surgery name will be required"
 S DIR("B")="NO" D ^DIR S:$D(DTOUT)!($D(DUOUT)) ORQUIT=1
 Q +Y
