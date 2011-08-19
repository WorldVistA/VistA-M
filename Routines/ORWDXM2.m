ORWDXM2 ; SLC/KCM - Quick Orders ;05/18/2009
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,109,116,132,158,187,195,215,243,280**;Dec 17, 1997;Build 85
 ;
ADMTIME(ORDLOC,PATLOC,ENCLOC,DELAY,ISIMO) ;
 N ADMLOC,INST,SCHLOC,SCHTYPE
 S ADMLOC=+$P($G(ORDIALOG("B","ADMINISTRATION TIMES")),U,2)
 I ADMLOC>0,ORDLOC>0,PATLOC'=ORDLOC D  Q
 .S INST=0 F  S INST=$O(ORDIALOG(ADMLOC,INST)) Q:+INST'>0  D
 ..S ORDIALOG(ADMLOC,INST)=""
 I ADMLOC>0,$S(ENCLOC'=PATLOC:1,ISIMO:1,DELAY:1,1:0) D  Q
 .S INST=0 F  S INST=$O(ORDIALOG(ADMLOC,INST)) Q:+INST'>0  D
 ..S ORDIALOG(ADMLOC,INST)=""
 S SCHLOC=+$P($G(ORDIALOG("B","SCHEDULE TYPE")),U,2) Q:SCHLOC'>0
 S INST=0 F  S INST=$O(ORDIALOG(SCHLOC,INST)) Q:+INST'>0  D
 .S SCHTYP=$G(ORDIALOG(SCHLOC,INST)) Q:SCHTYP=""
 .I $S(SCHTYP="P":1,SCHTYP="O":1,SCHTYP="OC":1,1:0),ADMLOC>0 S ORDIALOG(ADMLOC,INST)=""
 Q
 ;
CLRRCL(OK)      ; clear ORECALL
 S OK=1
 K ^TMP("ORECALL",$J),^TMP("ORWDXMQ",$J)
 Q
VERTXT ; set verify text for order
 N SEQ,DA,X,PROMPT,MULT,CHILD,INST,TITLE,TEMP,ILST,SPACES
 N ISADMIN
 S ILST=0,$P(SPACES," ",31)=""
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ)) Q:SEQ'>0  D
 . S DA=0 F  S DA=$O(^ORD(101.41,+ORDIALOG,10,"B",SEQ,DA)) Q:'DA  D
 . . S X0=$G(^ORD(101.41,+ORDIALOG,10,DA,0))
 . . S ISADMIN=$S(+OREVENT>0:0,ISIMO=1:0,$P($G(^ORD(101.41,$P(X0,U,2),0)),U)="OR GTX ADMIN TIMES":1,1:0)
 . . I ISADMIN=1,ORDLOC>0,ORDLOC'=PATLOC Q
 . . I $P(X0,U,9)["*",ISADMIN=0 Q
 . . S PROMPT=$P(X0,U,2),MULT=$P(X0,U,7),CHILD=$P(X0,U,11) I CHILD,ISADMIN=0 Q
 . . Q:'PROMPT  S INST=$O(ORDIALOG(PROMPT,0)) Q:'INST  ; no values
 . . S TITLE=$S($L($G(ORDIALOG(PROMPT,"TTL"))):ORDIALOG(PROMPT,"TTL"),1:ORDIALOG(PROMPT,"A"))
 . . I $E(ORDIALOG(PROMPT,0))="W" D
 . . . N IWP,WP,CNT
 . . . S IWP=0,CNT=0
 . . . F  S IWP=$O(^TMP("ORWORD",$J,PROMPT,INST,IWP)) Q:'IWP  D
 . . . . S CNT=CNT+1,WP(CNT)=^TMP("ORWORD",$J,PROMPT,INST,IWP,0)
 . . . I CNT=1 S ILST=ILST+1,LST(ILST)=$J(TITLE,30)_WP(1)
 . . . I CNT>1 D 
 . . . . S ILST=ILST+1,LST(ILST)=TITLE,IWP=0
 . . . . F  S IWP=$O(WP(IWP)) Q:'IWP  S ILST=ILST+1,LST(ILST)=WP(IWP)
 . . E  D
 . . . S TEMP=$$ITEM^ORCDLG(PROMPT,INST) I TEMP="" Q
 . . . S ILST=ILST+1,LST(ILST)=$J(TITLE,30)
 . . . ;S LST(ILST)=LST(ILST)_$$ITEM^ORCDLG(PROMPT,INST)
 . . . S LST(ILST)=LST(ILST)_TEMP
 . . Q:'MULT  Q:'$O(ORDIALOG(PROMPT,INST))  ; done
 . . F  S INST=$O(ORDIALOG(PROMPT,INST)) Q:INST'>0  S ILST=ILST+1,LST(ILST)=SPACES_$$ITEM^ORCDLG(PROMPT,INST)
 D DISPLAY^ORWDBA3  ;for display of Billing Aware data from orig order
 Q
RA ; setup environment for radiology
 ; -- get imaging types based on display group of quick order and
 ;    setup list of imaging locations based on imaging type
 N ORY,ITYPE,IFN,CNT,ORIMLOC,PROMPT
 S ORDIV=$$DIV^ORCDRA1,ITYPE=$P($G(^ORD(100.98,+ORDG,0)),U,3)
 S ORIMTYPE=$O(^RA(79.2,"C",ITYPE,0))
 D EN4^RAO7PC1(ITYPE,"ORY")
 S (IFN,CNT)=0 F  S IFN=$O(ORY(IFN)) Q:IFN'>0  D
 . S CNT=CNT+1,ORIMLOC(CNT)=ORY(IFN),ORIMLOC("B",$P(ORY(IFN),U,2))=IFN
 I '$$GET^XPAR("ALL","RA SUBMIT PROMPT",1,"Q"),CNT>1 K ORIMLOC
 E  S ORIMLOC=CNT_"^1"
 S PROMPT=$O(^ORD(101.41,"B","OR GTX IMAGING LOCATION",0))
 I $G(ORIMLOC) M ORDIALOG(PROMPT,"LIST")=ORIMLOC
 Q
LR ; setup environment for lab
 ; -- setup ORTIME, ORIMTIME & ORTEST arrays
 ;    setup ORMAX, ORDG, & ORCOLLCT variables
 N PROMPT,INST,EDITONLY
 D GETIMES^ORCDLR1  ; sets up ORTIME and ORIMTIME arrays
 S ORMAX=$$GET^XPAR("ALL^LOC.`"_+ORL,"LR MAX DAYS CONTINUOUS",1,"Q")
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0)),INST=1
 D LRTEST           ; sets up ORTEST array and ORDG
 S PROMPT=$O(^ORD(101.41,"B","OR GTX COLLECTION TYPE",0))
 I $D(ORDIALOG(PROMPT,1)) S ORCOLLCT=ORDIALOG(PROMPT,1) I 1
 E  S EDITONLY=0,ORCOLLCT=$$COLLTYPE^ORCDLR1
 I ORCOLLCT="I" D
 . S PROMPT=$O(^ORD(101.41,"B","OR GTX START DATE/TIME",0))
 . D LRICTMOK
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ADMIN SCHEDULE",0))
 I $D(ORDIALOG(PROMPT,1)) S ORSCH=ORDIALOG(PROMPT,1)
 Q
LRTEST ; -- Setup ORTEST() array of ordering parameters (copied from ORCDLR)
 N OI,TST,DG
 S OI=+$G(ORDIALOG(PROMPT,INST)) Q:'OI
 I '$D(ORTEST) S TST=+$P($G(^ORD(101.43,OI,0)),U,2) D TEST^LR7OR3(TST,.ORTEST) S ORTEST=TST
 S DG=$P($G(^ORD(101.43,+OI,"LR")),U,6) S:'$L(DG) DG="LAB"
 S DG=$O(^ORD(100.98,"B",DG,0)) S:DG ORDG=DG
 Q
LRRQCM()        ; return true if lab test has required comments
 I $O(^TMP("ORWORD",$J,PROMPT,INST,0)) Q 1 ; edit via WP
 N LRTEST,LRSAMP,LRSPEC,LRTSTN,LRTCOM,LRCCOM,DA,CNT,I,REQDCOMM,OI,TST
 S LRSAMP=$$VAL^ORCD("COLLECTION SAMPLE"),LRSPEC=$$VAL^ORCD("SPECIMEN")
 S OI=+$G(ORDIALOG(PROMPT,INST)) Q:'OI 0
 I '$D(ORTEST) S TST=+$P($G(^ORD(101.43,OI,0)),U,2) D TEST^LR7OR3(TST,.ORTEST) S ORTEST=TST
 S LRTSTN=1,LRTEST(1)=+ORTEST,DA=$O(^LAB(60,LRTEST(1),3,"B",+LRSAMP,0))
 S REQDCOMM=$P($G(^LAB(60,LRTEST(1),3,+DA,0)),U,6)
 S:'REQDCOMM REQDCOMM=+$P($G(^LAB(60,LRTEST(1),0)),U,19)
 Q REQDCOMM
LRASMP()       ; return true to ask collection sample (from ASKSAMP^ORCDLR)
 N DEFSAMP,SAMP0
 S DEFSAMP=$G(ORDIALOG(PROMPT,INST)),SAMP0=$G(^LAB(62,+DEFSAMP,0))
 I (ORCOLLCT="LC")!(ORCOLLCT="I"),$G(ORTEST("Lab CollSamp")) Q 0
 I $G(ORTEST("Unique CollSamp")),DEFSAMP Q 0 ; unique -> don't ask
 I 'DEFSAMP!('FIRST) Q 1 ; no default or edit -> ask
 I $G(ORDIALOG(PROMPT,"LIST"))="1^1" Q 0 ; only one choice
 Q 1
LRICTMOK        ;
 Q:'$D(ORDIALOG(PROMPT,1))
 N ORY
 D VALDT^ORWU(.ORY,ORDIALOG(PROMPT,1))
 I +$$VALID^LR7OV4(DUZ(2),ORY)=0 S ORDIALOG(PROMPT,1)=""
 Q
DO ; setup environment for diet order
 ; partially copied from EN^ORCDFH
 I ORCAT'="I" D  Q
 . S ORQUIT=1
 . S LST(0)="8^0"
 . S LST(.5)="This type of diet may be entered for inpatients only."
 D EN^FHWOR8(+ORVP,.ORPARAM)          ; set FH ordering parameters
 S:'$L($G(ORPARAM(3))) ORPARAM(3)="T" ; for now
 N PROMPT,OI                          ; set NPO flag if NPO diet
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0))
 S OI=+$G(ORDIALOG(PROMPT,1))
 S ORNPO=($P($G(^ORD(101.43,OI,0)),U)="NPO")
 S PROMPT=$O(^ORD(101.41,"B","OR GTX START DATE/TIME",0))
 S X=$G(ORDIALOG(PROMPT,1)) I $L(X) D CNV^ORCDFH1 S ORDIALOG(PROMPT,1)=$G(X)
 Q
EL ; setup environment for early/late tray
 D EN^FHWOR8(+ORVP,.ORPARAM)          ; set FH ordering parameters
 S:'$L($G(ORPARAM(3))) ORPARAM(3)="T" ; for now
 D EN2^ORCDFH                         ; setup ORTIME array
 N PROMPT                             ; set ORMEAL,ORTRAY
 S PROMPT=$O(^ORD(101.41,"B","OR GTX MEAL",0))
 I $D(ORDIALOG(PROMPT,1)) S ORMEAL=ORDIALOG(PROMPT,1)
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0))
 I $D(ORDIALOG(PROMPT,1)) S ORTRAY=ORDIALOG(PROMPT,1)
 Q
UD ; setup environment for unit dose med
 I $G(ORWP94) G PS^ORWDPS3  ; if patch 94 installed
 ;
 D AUTHMED Q:$G(ORQUIT)  ; checks authorized to write meds
 N PROMPT,OI
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0))
 I $D(ORDIALOG(PROMPT,1)) S OI=ORDIALOG(PROMPT,1) D MEDACTV(1) Q:$G(ORQUIT)
 D INSTR^ORCDPS(OI)      ; sets up instructions, routes, etc.
 D CHOICES^ORCDPS("U")   ; gets list of dispense drugs       
 Q
IV ; setup environment for IV fluid
 D AUTHMED Q:$G(ORQUIT)  ; checks authorized to write meds
 ; sets up list of volumes if only one solution
 ; otherwise, let the dialog go interactive
 N PROMPT,INST,CNT,OI
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0))
 S (CNT,INST)=0
 F  S INST=$O(ORDIALOG(PROMPT,INST)) Q:'INST  D  Q:$G(ORQUIT)
 . S CNT=CNT+1
 . S OI=ORDIALOG(PROMPT,INST) D MEDACTV(3) ; check active solutions
 I CNT=1 S INST=1 D VOLUME^ORCDPSIV
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ADDITIVE",0))
 S INST=0
 F  S INST=$O(ORDIALOG(PROMPT,INST)) Q:'INST  D  Q:$G(ORQUIT)
 . S OI=ORDIALOG(PROMPT,INST) D MEDACTV(4) ; check active additives
 Q
OP ; setup environment for outpatient pharmacy
 I $G(ORWP94) G PS^ORWDPS3  ; if patch 94 installed
 ;
 D AUTHMED Q:$G(ORQUIT)       ; checks authorized to write meds
 N PROMPT,INST,CNT,OI
 S PROMPT=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0)),OI=0
 I $D(ORDIALOG(PROMPT,1)) S OI=$G(ORDIALOG(PROMPT,1)) D MEDACTV(2) Q:$G(ORQUIT)
 D:+OI INSTR^ORCDPS(OI)           ; sets up instructions, routes, etc.
 D CHOICES^ORCDPS("O")        ; gets list of dispense drugs      
 ; get defaults for drug, refills if only one dispense drug
 S PROMPT=$O(^ORD(101.41,"B","OR GTX DISPENSE DRUG",0))
 S (CNT,INST)=0
 F  S INST=$O(ORDIALOG(PROMPT,INST)) Q:'INST  S CNT=CNT+1
 I CNT=1 D
 . S ORDRUG=+$G(ORDIALOG(PROMPT,1)),ORCOMPLX=0
 . S OREFILLS=$P($G(ORDIALOG(PROMPT,"LIST","D",ORDRUG)),U,3)
 . S:'$L(OREFILLS) OREFILLS=11
 E  S ORCOMPLX=1,OREFILLS=11  ; force interactive on complex order
 S ORCOPAY=1                  ; ask SC if can't determine copay
 I $G(ORDRUG),$L($T(ASKSC^ORCDPS)) S ORCOPAY=$$ASKSC^ORCDPS
 Q
AUTHMED ; sets ORQUIT if not authorized to write meds
 N NOAUTH,NAME
 D AUTH^ORWDPS32(.NOAUTH,ORNP)
 I +NOAUTH D
 . S ORQUIT=1
 . S LST(0)="8^0"
 . ; FIX FOR REMEDY 71069, CQ 15917
 . S LST(.5)=$P(NOAUTH,U,2)
 . ;S NAME=$P($G(^VA(200,+ORNP,20)),U,2)
 . ;I '$L(NAME) S NAME=$P($G(^VA(200,+ORNP,0)),U,1)
 . ;S LST(.5)=NAME_" is not authorized to write med orders."
 Q
MEDACTV(USAGE) ; sets ORQUIT if the orderable item is not active for a med
 Q:'$G(OI)  S USAGE=+$G(USAGE)
 I $G(^ORD(101.43,OI,.1)),^(.1)'>$$NOW^XLFDT D  Q
 . S ORQUIT=1,LST(0)="8^0"
 . S LST(.5)=$P($G(^ORD(101.43,OI,0)),U)_" has been inactivated and may not be ordered anymore."
 I USAGE,'$P($G(^ORD(101.43,OI,"PS")),U,USAGE) D  Q
 . S ORQUIT=1,LST(0)="8^0"
 . S LST(.5)=$P($G(^ORD(101.43,OI,0)),U)_" may not be ordered as an "_$S(USAGE=1:"inpatient medication",USAGE=2:"outpatient medication",USAGE=3:"IV solution",1:"IV additive")_" anymore."
 Q
SCHEDULD() ; Is patient scheduled for PREOP (Imaging)
 I $G(ORDIALOG(PROMPT,1)) Q 1 ; don't ask - already have date
 E  Q 0
 Q
