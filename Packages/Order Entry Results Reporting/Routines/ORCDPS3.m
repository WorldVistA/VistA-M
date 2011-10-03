ORCDPS3 ;SLC/MKB-Pharmacy dialog utilities ;09/11/07
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**94,116,134,158,149,190,277,243,289,317**;Dec 17, 1997;Build 2
 ;
 ;Reference to SCNEW^PSOCP supported by IA #2534
 ;Reference to DIS^DGRPDB supported by IA #700
 ;Reference to ^PSJORPOE supported by IA #3167
 ;
START ; -- Start Date entry action
 S $P(ORDIALOG(PROMPT,0),":",3)=$S($G(ORCAT)="I":"ETRX",1:"EX")
 I $G(ORCAT)'="I" K ORSD K:$G(ORENEW)!$G(OREWRITE)!$D(OREDIT) ORDIALOG(PROMPT,INST) ;Inpt only
 Q
 ;
ADMIN ; -- Return default admin time for order in ORSD
 ;    Called from EXDOSE^ORCDPS2
 Q:$D(ORSD)  Q:$G(ORCAT)'="I"  ;inpt only
 N PSOI,PSIFN,SCH,CNJ,ORI,ORX
 S PSOI=+$P($G(^ORD(101.43,+$G(OROI),0)),U,2)
 S PSIFN=$S($G(ORENEW):$G(^OR(100,+$G(ORIFN),4)),1:"")
 S SCH=$$PTR^ORCD("OR GTX SCHEDULE"),CNJ=$$PTR^ORCD("OR GTX AND/THEN"),ORX=""
 S ORI=0 F  S ORI=$O(ORDIALOG(PROMPT,ORI)) Q:ORI<1  S ORX=ORX_$S($L(ORX):U,1:"")_$G(ORDIALOG(CNJ,ORI))_";"_$G(ORDIALOG(SCH,ORI))
 S ORSD=$$FIRST(+ORVP,+$G(ORWARD),PSOI,ORX,PSIFN,"")
 S:$P(ORSD,U)="NEXT" ORSD="NEXTA^"_$P(ORSD,U,2,99)
 Q
 ;
FIRST(DFN,WARD,OI,DATA,ORDER,ADMIN)   ; -- Return expected first admin time of order
 N CNT,ORCNT,ORI,J,ORZ,Y,SCH,ORX,TNUM
 I '$G(DFN)!'$G(OI) Q ""
 S ORCNT=0 F ORI=1:1:$L(DATA,"^") S ORZ=$P(DATA,U,ORI) D  Q:$E(ORZ)="T"
 .S TNUM=$$NUMCHAR(ORZ,";") Q:TNUM=0
 .F CNT=1:1:TNUM D
 .. S SCH=$P(ORZ,";",CNT+1) Q:'$L(SCH)  S ORCNT=ORCNT+1
 .. I ORCNT>1 S ADMIN=""
 .. S ORX(ORCNT)=$$STARTSTP^PSJORPOE(DFN,SCH,OI,WARD,$G(ORDER),$G(ADMIN))
 S Y=9999999,J=0
 F ORI=1:1:ORCNT S ORZ=$P(ORX(ORI),U,4) I ORZ<Y S Y=ORZ,J=ORI ;earliest
 S Y=$S(J:ORX(J),1:"")
 Q Y
 ;
NUMCHAR(STRING,SUB) ;
 N CNT,RESULT
 S RESULT=0
 F CNT=1:1:$L(STRING) I $E(STRING,CNT)=SUB S RESULT=RESULT+1
 Q RESULT
 ;
NOW ; -- First dose now?
 N X,Y,DIR,SCH
 K ^TMP($J,"ORCDPS3 NOW")
 ;DJE/VM *317 added check on ORIVTYPE. Don't require dosage for intermittent IVs
 I $G(ORCAT)="O"!(('$D(ORSD))&($G(ORIVTYPE)'="I"))!$L($G(OREVENT))!$G(ORENEW) K ORDIALOG(PROMPT,INST),^TMP($J,"ORCDPS3 NOW") Q
 D AP^PSS51P1("PSJ",,,,"ORCDPS3 NOW")
 ; ask on Copy? Change?
 S X=$$PTR^ORCD("OR GTX SCHEDULE"),Y=+$O(ORDIALOG(X,0))
 S SCH=$G(ORDIALOG(X,Y)),Y=+$O(^TMP($J,"ORCDPS3 NOW","APPSJ",SCH,0)) ;1st one
 ;S SCH=$G(ORDIALOG(X,Y)),Y=+$O(^PS(51.1,"APPSJ",SCH,0)) ;1st one
 I $P($G(^TMP($J,"ORCDPS3 NOW",Y,5)),"^")="O"!(Y<1) K ORDIALOG(PROMPT,INST),^TMP($J,"ORCDPS3 NOW") Q
 ;I $P($G(^PS(51.1,Y,0)),U,5)="O"!(Y<1) K ORDIALOG(PROMPT,INST),^TMP($J,"ORCDPS3 NOW") Q
 ; other conditions?
 S DIR(0)="YA",DIR("A")="Give additional dose NOW? "
 S DIR("B")=$S($G(ORDIALOG(PROMPT,INST)):"YES",1:"NO")
 I $G(ORINPT),$P(ORSD,U,4) S DIR("A",1)="Next scheduled administration time: "_$$FMTE^XLFDT($P(ORSD,U,4))
 S DIR("?")="Enter YES if you want a dose given now in addition to the regular administration times for this schedule and ward."
 D ^DIR S:$D(DTOUT)!$D(DUOUT) ORQUIT=1
 I $G(ORQUIT)!(Y'>0) K ORDIALOG(PROMPT,INST),^TMP($J,"ORCDPS3 NOW") Q
 S ORDIALOG(PROMPT,INST)=1 I $G(ORCOMPLX) D
 . W $C(7),!,"  >> First Dose NOW is in addition to those already entered.    <<"
 . W !,"  >> Please adjust the duration of the first one, if necessary. <<"
 K ^TMP($J,"ORCDPS3 NOW")
 Q
 ;
DEFSTRT ; -- Returns default start date/time in Y
 ;    Expects PROMPT,INST,ORDIALOG,ORSD to be defined
 ;
 Q:$G(ORCAT)="O"  Q:$G(ORTYPE)="Z"  ;skip if outpt or editor
 N LAST,STRT,DUR,D1,D2,OFF,F1,F2,UNT,Y1,Y2,I,J K Y
 S LAST=+$O(ORDIALOG(+$$PTR^ORCD("OR GTX INSTRUCTIONS"),INST),-1)
 S STRT=$G(ORDIALOG(PROMPT,LAST))
 I LAST'>0!'$L(STRT) S:$L($P($G(ORSD),U)) Y=$P(ORSD,U) Q  ;first inst
 S DUR=$G(ORDIALOG(+$$PTR^ORCD("OR GTX DURATION"),LAST))
 I +DUR'>0 S Y=STRT Q  ;no duration = same start
 S DUR=$$FMDUR(DUR) I STRT D  Q  ;FM date/time, so just add
 . N X,%DT S %DT="TX",X=STRT_"+"_DUR D ^%DT
 . I Y'>0 S Y=STRT ;error
 S D1=+DUR,D2=$P(DUR,D1,2) S:(STRT="NEXTA")!(STRT="CLOSEST") STRT="NOW"
 S OFF=$P(STRT,"+",2) I '$L(OFF) S Y=STRT_"+"_DUR Q  ;no prev offset
 S F1=+OFF,F2=$P(OFF,F1,2),UNT=F2,Y=STRT
 I D2=F2 S Y=$P(STRT,"+")_"+"_(D1+F1)_UNT Q  ;same units
 F I="S","'","H","D","W","M" I (F2=I)!(D2=I) S UNT=I D  Q
 . S:D2=UNT Y1=D1,X1=F1,X2=F2 ; Y1=# in UNT
 . S:F2=UNT Y1=F1,X1=D1,X2=D2 ; X1=# in other units X2
 . F J=1:1 S Z=$T(CONV+J) Q:Z["ZZZZ"  I $P(Z,";",3,4)=(X2_";"_UNT) S Y2=+$P(Z,";",5) Q
 . S Y=$P(STRT,"+")_"+"_(Y1+$S(Y2:Y2*X1,1:0))_UNT
 Q
 ;
FMDUR(X)        ; -- convert '# DAYS' to #D
 N X1,X2,Y I +X'>0 Q ""
 S X1=+X,X2=$P(X," ",2) S:'$L(X2) X2="DAYS"
 S Y=X1_$S("MINUTES"[X2:"'",1:$E(X2))
 Q Y
 ;
CONV ;;unit;unit;factor
 ;;';S;60
 ;;H;';60
 ;;H;S;3600
 ;;D;H;24
 ;;D;';1440
 ;;D;S;86400
 ;;W;D;7
 ;;W;H;168
 ;;W;';10080
 ;;W;S;604800
 ;;M;W;4
 ;;M;D;30
 ;;M;H;720
 ;;M;';43200
 ;;M;S;2592000
 ;;ZZZZ
 ;
ASKDUR()        ; -- Returns 1 or 0, if Duration prompt should be asked
 K ^TMP($J,"ORCDPS3 ASKDUR")
 N X,Y I '$G(ORCOMPLX) K ORDIALOG(PROMPT,INST) Q 0
 S Y=1 G:'$L($G(ORSCH)) ADQ ;no schedule
 D AP^PSS51P1("PSJ",,,,"ORCDPS3 ASKDUR")
 S X=+$O(^TMP($J,"ORCDPS3 ASKDUR","APPSJ",ORSCH,"")) G:X'>0 ADQ
 ;S X=+$O(^PS(51.1,"APPSJ",ORSCH,0)) G:X'>0 ADQ
 S:^TMP($J,"ORCDPS3 ASKDUR",X,5)="O" Y=0
 ;S:$P($G(^PS(51.1,X,0)),U,5)="O" Y=0
ADQ ;
 K ^TMP($J,"ORCDPS3 ASKDUR")
 Q Y
 ;
CKDUR(X) ; -- Returns validated form of duration X, or null if invalid
 N X1,X2,Y,Z S Y=""
 S X1=+$G(X),X2=$P($G(X),X1,2) I X1'>0 Q ""
 S X2=$$UP^XLFSTR(X2),X2=$$STRIP^XLFSTR(X2," ") S:'$L(X2) X2="DAYS"
 F Z="MONTHS^&MONTHS&MONS","WEEKS^&WEEKS&WKS","DAYS^&DAYS&DYS","HOURS^&HOURS&HRS","MINUTES^&MINUTES&MINS'","SECONDS^&SECONDS&SECS" I $P(Z,U,2)[("&"_X2) S Y=$P(Z,U) Q
 S:$L(Y) Y=X1_" "_$S(X1=1:$E(Y,1,$L(Y)-1),1:Y) ;strip trailing 's'
 Q Y
 ;
DUR ; -- Process duration [from P-S Action]
 N X S X=$G(ORDIALOG(PROMPT,ORI)),X=$$CKDUR(X)
 I '$L(X) K DONE W $C(7),!,ORDIALOG(PROMPT,"?"),! Q
 S ORDIALOG(PROMPT,ORI)=X D:$G(ORESET)'=X CHANGED^ORCDPS1("QUANTITY")
 Q
 ;
TEST(START,DURTN)       ; -- test DEFSTRT
 N INST,ORSD,ORDIALOG,PROMPT
 S ORDIALOG(136,1)="",INST=2,ORSD="NOW",PROMPT=6
 S:$L($G(START)) ORDIALOG(6,1)=START S:$G(DURTN) ORDIALOG(153,1)=DURTN
 D DEFSTRT W !,Y
 Q
 ;
SC ; -- Dialog validation, to ask SC questions
 ;    Expects ORIFN, ORDA, and ORDER
 ;
 Q:'$L($T(SCNEW^PSOCP))  Q:'$G(ORIFN)  Q:'$G(ORDA)
 Q:$P($G(^OR(100,ORIFN,0)),U,12)'="O"  Q:$P($G(^(8,ORDA,0)),U,2)'="NW"  Q:$P($G(^(0)),U,15)=""
 ;
 N OR3,ORDRUG,PSIFN,ORX,I,J,DIE,DR,DA,X,Y,DTOUT,ORIGVIEW,DFN
 S OR3=$G(^OR(100,ORIFN,3)),X=$P(OR3,U,11) I X>2 Q  ;new, edit, or renew
 I X S Y=$P(OR3,U,5),PSIFN=$G(^OR(100,Y,4)) ;get PS# if edit/renewal
 S ORDRUG=$$VALUE^ORCSAVE2(ORIFN,"DRUG")
 D SCNEW^PSOCP(.ORX,+ORVP,ORDRUG,$G(PSIFN)) Q:'$D(ORX)
 S DIE="^OR(100,",DA=ORIFN,DR="",J=0
 F I="SC","MST","AO","IR","EC","HNC","CV" S J=J+1 I $D(ORX(I)) S X=ORX(I) S:I="CV"&(X="") X=1 S DR=DR_";5"_J_"R"_$S($L(X):"//"_$S(X:"YES",1:"NO"),1:"")
 S:$E(DR)=";" DR=$E(DR,2,999) Q:'$L(DR)  S ORIGVIEW=1
 I $D(ORX("SC")) S DFN=+ORVP D DIS^DGRPDB ;show current SC data
 W !!,"Is "_$$ORDITEM^ORCACT(ORDER)_" for treatment related to:"
 D ^DIE S:$D(DTOUT)!$D(Y) ORQUIT=1
 Q
