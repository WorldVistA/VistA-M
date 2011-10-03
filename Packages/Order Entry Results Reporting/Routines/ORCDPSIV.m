ORCDPSIV ;SLC/MKB-Pharmacy IV dialog utilities ;06/17/10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,38,48,158,195,243,296,280**;Dec 17, 1997;Build 85
 ;Per VHA Directive 2004-038, this routine should not be modified.
CKSCH ; -- validate schedule [Called from P-S Action]
 N ORX S ORX=ORDIALOG(PROMPT,ORI) Q:ORX=$G(ORESET)  K ORSD
 D EN^PSSGS0(.ORX,"I")
 I $D(ORX) S ORDIALOG(PROMPT,ORI)=ORX Q
 W $C(7),!,"Enter a standard schedule for administering this medication."
 Q
ISONETIM(SCH) ;
 N DUR
 I SCH="" Q 0
 K ^TMP($J,"ORCDPSIV GETSCHTYP")
 D ZERO^PSS51P1(,SCH,"PSJ","O","ORCDPSIV GETSCHTYP")
 I $D(^TMP($J,"ORCDPSIV GETSCHTYP","B",SCH)) D  Q 1
 .S DUR=$$PTR^ORCD("OR GTX DURATION")
 .I $G(ORDIALOG(DUR,1))="" Q
 .S ORDIALOG(DUR,1)=""
 .W !,"IV Orders with a schedule type of one-time cannot have a duration."
 .W !,"The duration has been deleted from this quick order." H 1
 K ^TMP($J,"ORCDPSIV GETSCHTYP")
 Q 0
 ;
ADDFRD(ORDIALOG,INST,PROMPT) ;
 N ADDFRIEN,ADDIEN,OI,PSOI,RESULT
 S RESULT=""
 I $G(ORIVTYPE)'="C" Q RESULT
 S ADDFRIEN=$O(^ORD(101.41,"AB","OR GTX ADDITIVE FREQUENCY","")) I 'ADDFRIEN Q RESULT
 S ADDIEN=$O(^ORD(101.41,"AB","OR GTX ADDITIVE","")) I 'ADDIEN Q RESULT
 S RESULT=$$RECALL^ORCD(PROMPT,INST) I RESULT'="" Q RESULT
 S OI=$G(ORDIALOG(ADDIEN,INST)) I OI="" Q RESULT
 S PSOI=+$P($G(^ORD(101.43,OI,0)),U,2) I +PSOI'>0 Q RESULT
 S RESULT=$$IV^PSSDSAPA(+PSOI)
 S RESULT=$S(RESULT="A":"All Bags",RESULT=1:"1 Bag/Day",1:"")
 Q RESULT
 ;
ADDFRQC ;
 I $G(ORIVTYPE)'="C" Q
 W !,"Select from the list of the codes below to assign an additive frequency for this additive."
 W !,"A = All Bags"
 W !,"1 = 1 Bag/Day"
 W !,"S = See Comments"
 W !
 Q
ADDFRQI ;
 S X=$$UP^XLFSTR(X)
 I X'="A",X'=1,X'="S" D ADDFRQC K X Q
 I X="A" S X="All Bags" Q
 I X=1 S X="1 Bag/Day" Q
 I X="S" S X="See Comments"
 Q
 ;
PROVIDER ; -- Check provider, if authorized to write med orders
 I $D(^XUSEC("OREMAS",DUZ)),'$$GET^XPAR("ALL","OR OREMAS MED ORDERS") W $C(7),!!,"OREMAS key holders may not enter medication orders." S ORQUIT=1 Q
 N PS,NAME S PS=$G(^VA(200,+$G(ORNP),"PS")),NAME=$P($G(^(20)),U,2)
 I '$L(NAME) S NAME=$P(^VA(200,+$G(ORNP),0),U)
 I '$P(PS,U) W $C(7),!!,NAME_" is not authorized to write medication orders!" S ORQUIT=1
 I $P(PS,U,4),$$NOW^XLFDT>$P(PS,U,4) W $C(7),!!,NAME_" is no longer authorized to write medication orders!" S ORQUIT=1
 I $G(ORQUIT) W !,"You must select another provider to continue.",! S PS=$$MEDPROV I PS S ORXNP=ORNP,ORNP=PS K ORQUIT
 Q
 ;
MEDPROV() ; -- Return ordering med provider
 N X,Y,D,DIC
 S DIC=200,DIC(0)="AEQ",DIC("A")="Select PROVIDER: ",D="AK.PROVIDER"
 S DIC("S")="I $P($G(^(""PS"")),U),'$P(^(""PS""),U,4)!($P(^(""PS""),U,4)>$$NOW^XLFDT)"
 D IX^DIC S:Y>0 Y=+Y I Y'>0 S Y="^"
 Q Y
 ;
CHANGED(TYPE) ; -- Kill dependent values when OI changes
 N PROMPTS,NAME,PTR,P,I
 Q:'$L($G(TYPE))  S PROMPTS=""
 S:TYPE="B" PROMPTS="VOLUME"
 S:TYPE="A" PROMPTS="STRENGTH PSIV^UNITS"
 I TYPE="T" D
 .S PROMPTS="INFUSION RATE^SCHEDULE^ADDITIVE FREQUENCY"
 .S PTR=$O(^ORD(101.41,"AB","OR GTX DURATION","")) Q:'PTR
 .I $G(ORDIALOG(PTR,1))["DOSES" S PROMPTS=PROMPTS_U_"DURATION"
 ;
 F P=1:1:$L(PROMPTS,U) S NAME=$P(PROMPTS,U,P) D
 . S PTR=$O(^ORD(101.41,"AB","OR GTX "_NAME,0)) Q:'PTR
 . S I=0 F  S I=$O(ORDIALOG(PTR,I)) Q:I'>0  K ORDIALOG(PTR,I)
 . K ORDIALOG(PTR,"LIST")
 Q
 ;
INACTIVE(TYPE) ; -- Check OI inactive date
 N OI,X,I,PSOI,DEA,EXIT S:$G(TYPE)'="A" TYPE="S"
 S OI=+$G(ORDIALOG(PROMPT,INST)) Q:OI'>0
 I $G(^ORD(101.43,OI,.1)),^(.1)'>$$NOW^XLFDT D  Q  ;inactive
 . S X=$S(TYPE="A":"additive",1:"solution"),ORQUIT=1
 . W $C(7),!,"This "_X_" may not be ordered anymore.  Please select another."
 S I=$S(TYPE="A":4,1:3) I '$P($G(^ORD(101.43,OI,"PS")),U,I) D  Q
 . S X=$S(TYPE="A":"an additive",1:"a solution"),ORQUIT=1
 . W $C(7),!,"This item may not be ordered as "_X_"."
 S EXIT=$$INPT^ORCD I EXIT=0 D ROUTECHK Q
 Q:'$L($T(IVDEA^PSSUTIL1))  ;DBIA #3784
 S PSOI=+$P($G(^ORD(101.43,OI,0)),U,2)
 S DEA=$$IVDEA^PSSUTIL1(PSOI,TYPE) I DEA>0 D  Q:$G(ORQUIT)
 . I $G(ORNP),'$L($P($G(^VA(200,+ORNP,"PS")),U,2)),'$L($P($G(^("PS")),U,3)) W $C(7),!,$P($G(^(0)),U)_" must have a DEA# or VA# to order this drug!" S ORQUIT=1 Q
 . I DEA=1 W $C(7),!,"This order will require a wet signature!"
 D ROUTECHK
 Q
 ;
VOLUME ; -- get allowable volumes for solution
 N PSOI,ORY,CNT,I,XORY K ORDIALOG(PROMPT,"LIST")
 S PSOI=+$P($G(^ORD(101.43,+$$VAL^ORCD("SOLUTION",INST),0)),U,2)_"B"
 D ENVOL^PSJORUT2(PSOI,.ORY) Q:'ORY
 ;S (I,CNT)=0 F  S I=$O(ORY(I)) Q:I'>0  S CNT=CNT+1,ORDIALOG(PROMPT,"LIST",+ORY(I))=+ORY(I)
 S (I,CNT)=0 F  S I=$O(ORY(I)) Q:I'>0  D
 . S CNT=CNT+1
 . S XORY(I)=+ORY(I) I XORY(I)<1,$E(XORY(I),1,2)'="0." S XORY(I)=0_XORY(I)
 . S ORDIALOG(PROMPT,"LIST",XORY(I))=XORY(I)
 S ORDIALOG(PROMPT,"LIST")=CNT_"^1"
 Q
 ;
UNITS ; -- get allowable units for current additive
 N PSOI,ORY,I,UNITS
 S PSOI=+$P(^ORD(101.43,+ORDIALOG($$PTR^ORCD("OR GTX ADDITIVE"),INST),0),U,2)_"A"
 D ENVOL^PSJORUT2(PSOI,.ORY)
 S I=$O(ORY(0)) Q:'I  S UNITS=$P($G(ORY(I)),U,2)
 S ORDIALOG($$PTR^ORCD("OR GTX UNITS"),INST)=UNITS
 W !," (Units for this additive are "_UNITS_")"
 Q
 ;
PREMIX() ; -- Returns 1 or 0, if IV base is a premix solution
 N BASE,PS,I,Y
 S BASE=$$PTR^ORCD("OR GTX ORDERABLE ITEM"),Y=0
 S I=0 F  S I=$O(ORDIALOG(BASE,I)) Q:I'>0  D  Q:Y
 . S PS=$G(^ORD(101.43,+$G(ORDIALOG(BASE,I)),"PS"))
 . I $P(PS,U,3)&($P(PS,U,4)) S Y=1
 Q Y
 ;
IVRTEENT ;
 N ARRAY,DIR,RIEN,TROUTE
 I ORTYPE'="Z" Q
 S RIEN=$P($G(ORDIALOG("B","ROUTE")),U,2) Q:RIEN'>0
 S EXIT=0,TROUTE=$G(ORDIALOG(RIEN,1)) Q:TROUTE'>0
 I $$IVRTESCR(TROUTE)=1 Q
 S ORDIALOG(RIEN,1)=""
 W !!,"The selected route is not a valid route for this order."
 W !,"Select a new route for this order from the list of routes below."
 D RTEDISP(.ARRAY)
 Q
 ;
BIVOI(ARRAY) ;
 N CNT,NUM,OIIEN,OTYPE
 S CNT=0
 F OTYPE="SOLUTION","ADDITIVE" D
 .S OIIEN=+$P($G(ORDIALOG("B",OTYPE)),U,2) I OIIEN>0 D
 ..S NUM=0 F  S NUM=$O(ORDIALOG(OIIEN,NUM)) Q:NUM'>0  I +$G(ORDIALOG(OIIEN,NUM))>0 D
 ...S CNT=CNT+1,ARRAY(CNT)=ORDIALOG(OIIEN,NUM)
 Q
 ;
LVROUTES ;
 N ARRAY,ROUTES
 D BIVOI(.ARRAY)
 D IVDOSFRM^ORWDPS33(.ROUTES,.ARRAY,1)
 D RTEDISP(.ROUTES)
 Q
 ;
RTEDISP(ROUTES) ;
 N CNT
 S CNT="" F  S CNT=$O(ROUTES(CNT)) Q:CNT'>0  D
 .W !,$P($G(ROUTES(CNT)),U,2)
 Q
 ;
IVRTESCR(Y) ;
 N ARRAY,ROUTES,VALUE
 D BIVOI(.ARRAY)
 S VALUE=$$IVQOVAL^ORWDPS33(.ARRAY,Y) I VALUE'="" Q 1
 Q 0
 ;
ROUTECHK ;
 N CNT,IEN,ROUTE,VALUE
 S RIEN=$P($G(ORDIALOG("B","ROUTE")),U,2) Q:RIEN'>0
 S TROUTE=$G(ORDIALOG(RIEN,1)) Q:TROUTE'>0
 I $$IVRTESCR(TROUTE)=1 Q
 S ORDIALOG(RIEN,1)=""
 W !!,"The route defined for this order is an invalid route."
 W !,"You will need to define a new route for this order."
 Q
 ;
ENRATE ; -- set display text, help based on IV TYPE
 N X,MSG S X=$G(ORIVTYPE),MSG=""
 S ORDIALOG(PROMPT,"A")=$S(X="I":"Infuse over time (min): ",1:"Infusion Rate (ml/hr): ")
 S MSG="Enter the "_$S(X="I":"number of minutes over which to infuse this medication.",1:"infusion rate, as the number of ml/hr or Text@Number of Labels per day. ")
 S ORDIALOG(PROMPT,"?")=MSG
 I X="I" D
 .N RATEI,RATEV,TIME,UNIT
 .S RATEI=$P($G(ORDIALOG("B","INFUSION RATE")),U,2) Q:RATEI'>0
 .S RATEV=$G(ORDIALOG(RATEI,1)) Q:'$L(RATEV)
 .I RATEV'["INFUSE OVER" Q
 .S TIME=$P(RATEV," ",3)
 .S UNIT=$P(RATEV," ",4)
 .I TIME["." Q
 .I UNIT="Hours" S TIME=TIME*60
 .S ORDIALOG(RATEI,1)=TIME
 Q
 ;
INF ; -- input transform for INFUSION RATE
 N ALPHA,CNT,EXIT,FAIL,LDEC,RDEC,TEMP
 I $G(ORIVTYPE)="I" D  Q
 .I X["." W !,"Infuse Over Time must be a whole number." K X Q
 .I $L(X)>4 W !,"Infuse Over Time cannot exceed 4 characters for minutes." K X Q
 .S FAIL=0
 .F CNT=1:1:$L(X) D  I FAIL=1 Q
 ..I ($A($E(X,CNT))<48)!($A($E(X,CNT))>58) S FAIL=1
 .I FAIL=1 W !,"Infuse Over Time must be a whole number." K X Q
 K:$L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) X I '$D(X) Q
 I $G(ORIVTYPE)="C" D  Q
 .S TEMP=$E(X,($L(X)-5),$L(X))
 .I X["@",$$UP^XLFSTR(TEMP)=" ML/HR" Q
 .S ALPHA=0
 .I X'["@",X'["." D  I ALPHA=1 K X Q
 ..F CNT=1:1:$L(X) D  I ALPHA=1 Q
 ...I ($A($E(X,CNT))<48)!($A($E(X,CNT))>58) S ALPHA=1
 .S EXIT=0
 .I X[".",X'["@" D  I EXIT=1 K X Q
 ..S LDEC=$P(X,"."),RDEC=$P(X,".",2)
 ..I LDEC="" W !,"Infusion Rate required a leading numeric value." S EXIT=1
 ..I $L(RDEC)>1 W !,"Infusion Rate cannot exceed one decimal place." S EXIT=1
 ..S ALPHA=0
 ..F CNT=1:1:$L(LDEC) D  I ALPHA=1 S EXIT=1 Q
 ...I ($A($E(LDEC,CNT))<48)!($A($E(LDEC,CNT))>58) S ALPHA=1
 ..I $L(RDEC)=0 Q
 ..F CNT=1:1:$L(RDEC) D  I ALPHA=1 S EXIT=1 Q
 ...I ($A($E(RDEC,CNT))<48)!($A($E(RDEC,CNT))>58) S ALPHA=1
 .D ORINF^PSIVSP Q
 ; -- assume #minutes for now
 K:(X'=+X)!(X<1)!(X>999) X ;range?
 Q
 ;
VALIDAYS(X) ; -- Validate IV duration
 N UNITS,X1,X2,Y,I
 I X'?1.N." "1.A Q 0
 S UNITS="^MIN^HOURS^DAYS^M^H^D^",(X1,X2)=""
 F I=1:1:$L(X) S Y=$E(X,I) S:Y?1N X1=X1_Y S:Y?1A X2=X2_$$UP^XLFSTR(Y)
 I 'X1 Q 0
 I UNITS'[(U_X2_U) Q 0
 Q 1
 ;
VALDURA(X) ;-- Validate IV duration/limitation
 K:$L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) X I '$D(X) Q
 ;
IVPSI ;INPUT-TRANSFORM
 I $L(X)<1!($L(X)>30)!(X["""")!($A(X)=45) S X="" Q
 I $L(X)>1,X[" " W !,"Spaces are not allow in the duration." K X Q
 I $E(X)=0 W !,!,"Duration cannot start with a zero." K X Q
 I X["." W !,!,"Invalid duration or total volume.",!,"Duration has to be integer value!" S X="" Q
 S X=$$UP^XLFSTR(X)
 I X["DOSES" D  Q
 .I $G(ORIVTYPE)'="I" K X W !,"Continuous IV Orders cannot have DOSES as a duration." Q
 .I +$P(X,"DOSES")<1,+$P(X,"DOSES")>200000 W !,"Invalid number of Doses.",! K X Q
 I (X'?.N1.2A),(X'?.N1".".N1.2A) W !,!,"Invalid duration or total volume.",! S X="" Q
 I (X?.N1A) D
 . I (X["L")!(X["H")!(X["D") Q
 . E  W !,!,"Invalid duration or total volume.",! S X="" Q
 I (X?.N1".".N1A) D
 . I X["L" Q
 . E  W !,!,"Invalid duration or total volume.",!,"Duration has to be integer value!",! S X="" Q
 I (X?.N2A)!(X?.N1".".N2A) D
 . I (X["ML")!(X["CC") Q
 . E  W !,!,"Invalid duration or total volume",! S X="" Q
 I X="" K X
 Q
 ;
IVPSI1 ; ASK ON CONDITION
 N DURI,DURV,TEMPX
 I $G(OROTSCH)=1 Q
 S DURI=$P($G(ORDIALOG("B","LIMITATION")),U,2)
 I DURI>0 S DURV=$G(ORDIALOG(DURI,1))
 I $L(DURV)>1,$E(DURV)="f",DURV["doses" D
 .S TEMPX=$P(DURV," ",5)_"DOSES"
 .I TEMPX'="",TEMPX'=DURV S ORDIALOG(DURI,1)=TEMPX
 N INT,IVTYPE,ONETIME,TYPE,SCH,SCHNAME
 D IVDURT($G(ORIVTYPE))
 ;I $G(ORIVTYPE)'="I" D  G IVPS1X
 ;.W !,!,"Enter the length of administrative time or total volume for IV fluid order followed by ML or CC for milliliters, L for liters, D for days, H for hours to set limitation."
 ;.W !,"(Examples: 1500ML, 1000CC, 1L, 3D, or 72H)",!
 ;W !,"This field is optional a value does not need to be entered."
 ;W !,!,"Enter the length of administrative time or total volume for IV fluid order followed by ML or CC for milliliters, L for liters, D for days, H for hours or DOSES to set limitation."
 ;W !,"(Examples: 1500ML, 1000CC, 1L, 3D, 72H, or 10DOSES)",!
IVPS1X ;
 ;W !,"This field is optional a value does not need to be entered."
 I 1
 Q
 ;
IVDURT(TYPE) ;
 I TYPE'="I" D  G IVDURX
 .W !,!,"Enter the length of administrative time or total volume for IV fluid order followed by ML or CC for milliliters, L for liters, D for days, H for hours to set limitation."
 .W !,"(Examples: 1500ML, 1000CC, 1L, 3D, or 72H)",!
 W !,"This field is optional a value does not need to be entered."
 W !,!,"Enter the length of administrative time or total volume for IV fluid order followed by ML or CC for milliliters, L for liters, D for days, H for hours or DOSES to set limitation."
 W !,"(Examples: 1500ML, 1000CC, 1L, 3D, 72H, or 10DOSES)",!
IVDURX ;
 W !,"This field is optional a value does not need to be entered."
 Q
 ;
IVDURH ;
 D IVDURT($G(ORIVTYPE))
 Q
 ;
