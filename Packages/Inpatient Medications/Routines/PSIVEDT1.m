PSIVEDT1 ;BIR/MLM - EDIT IV ORDER (CONT) ;Nov 2, 2021@12:47:00
 ;;5.0;INPATIENT MEDICATIONS;**3,7,41,47,50,64,58,116,110,111,113,267,279,305,194,373,411,416,399**;16 DEC 97;Build 64
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PS(51.1 is supported by DBIA# 2177.
 ;
10 ; Start Date
 I $G(P("APPT")) S P(2)=P("APPT") ;p411 - set Start Date to Visit Date
 D:'P(2)&P("IVRM")!($G(PSJREN)) ENT^PSIVCAL
A10 I $G(P("RES"))="R" I $G(ON)["P",$P($G(^PS(53.1,+ON,0)),"^",24)="R" D  Q
 . Q:'$G(PSIVRENW)  W !!?5,"This is a Renewal Order. Start Date may not be edited at this point." D PAUSE^VALM1
 I $G(ON)["V"!($G(ON)["U") I $$COMPLEX^PSJOE(DFN,ON) D  Q
 .Q:$G(PSJBKDR)  W !!?5,"This is a Complex Order. Start Date may not be edited at this point." D PAUSE^VALM1
 S Y=P(2) X ^DD("DD") W !,"START DATE/TIME: "_$S(Y]"":Y_"// ",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 I $E(X)=U!(P(2)&X="") Q
 I X["???",($E(P("OT"))="I"),(PSIVAC["C") D ORFLDS G 10
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S F1=53.1,F2=10 S:X="@" X="?" D ENHLP^PSIVORC1 G A10
 K %DT S:X="" X=P(2) S %DT="ERTX" D ^%DT K %DT G:Y'>0 A10
 I $G(P("RES"))="R",(+Y<+$P($G(^PS(55,DFN,"IV",+$G(P("OLDON")),0)),U,2)) D  G 10
 .; naked ref below refers to line above
 .S Y=$P(^(0),U,2) X ^DD("DD") W $C(7),!!,"Start date of order being renewed is ",Y,".",!,"Start date of renewal order must be AFTER start date of order being renewed.",!
 S X1=$G(P("LOG")),X2=-7 D C^%DTC I +Y<X W $C(7),!!,"Start date/time may not be entered prior to 7 days from the order's LOGIN DATE.",! G A10
 ; RBD PSJ*5*373 Soft stop when Start Date more than 7 days after Order's LOGIN DATE
 S X1=$G(P("LOG")),X2=+7 D C^%DTC
 I +Y>X W !!,$C(7),"Start date/time should not be entered for more than 7 days after the",!,"order's LOGIN DATE.",! K DIR D WAIT^VALM1
 S P(2)=+Y,PSGSDX=1
 Q
 ;
25 ; Stop Date
 G:$D(PSGFDX) A25
 I P("IVRM")]"",$S(P(3)<P(2):1,$G(PSIVAC)["E":0,1:1) S PSIVSITE=$G(^PS(59.5,+P("IVRM"),1)),$P(PSIVSITE,"^",20,21)=$G(^PS(59.5,+P("IVRM"),5)) D ENSTOP^PSIVCAL
A25 I $G(ON)["V"!($G(ON)["U") I $$COMPLEX^PSJOE(DFN,ON) D  Q
 .Q:$G(PSJBKDR)  W !!?5,"This is a Complex Order. Stop Date may not be edited at this point." D PAUSE^VALM1
 S Y=P(3) X ^DD("DD") W !,"STOP DATE/TIME: "_$S(Y]"":Y_"// ",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 Q:X=""&P(2)  I $E(X)=U!(X=""&P(2)) Q
 I X["???",($E(P("OT"))="I"),(PSIVAC["C") D ORFLDS G 25
 I X="@"!(X["?") W $C(7),"  (Required)" S F1=53.1,F2=25,X="?" D ENHLP^PSIVORC1 G A25
 K %DT S:X="" X=$G(Y) S:X="" X=P(3) S %DT="ERTX" D:X'=+X ^%DT
 I X=+X,X>0,X'>2000000 G A25:'$$ENDL^PSGDL(P(9),X) D ENDL^PSIVSP
 D DOSE
 I $G(X)="" S X=Y
 I $G(X)="" S X=P(3)
 I $G(Z)]"",Z>X D  G A25
 . W !,"There is no administration time that falls between the Start Date/Time"
 . W !,"and Stop Date/Time.",!
 S X=Y S:Y<1!Y'["." X="" G:Y'>0 A25
 ; RBD PSJ*5*373 Hard stop when Stop Date more than 367 days after Start Date
 S X1=+Y,X2=P(2) D ^%DTC
 I X>367 W $C(7),!!?13,"*** STOP DATE cannot be more than 367 days from START DATE ***",! G A25
 S P(3)=+Y,PSGFDX=1
 Q
 ;
26 ; Schedule
 I $G(P("RES"))="R" I $G(ON)["P",$P($G(^PS(53.1,+ON,0)),"^",24)="R" D  Q
 . Q:'$G(PSIVRENW)  W !!?5,"This is a Renewal Order. Schedule may not be edited at this point." D PAUSE^VALM1
 I $G(ON)["V"!($G(ON)["U") I $$COMPLEX^PSJOE(DFN,ON) D  Q
 .Q:$G(PSJBKDR)  W !!?5,"This is a Complex Order. Schedule may not be edited at this point." D PAUSE^VALM1
 W !,"SCHEDULE: ",$S(P(9)]"":P(9)_"// ",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 I $E(X)=U!(X="") Q
 I X="@" D DEL^PSIVEDRG S:%=1 P(9)="" G 26
 I '$$SCHREQ^PSJLIVFD(.P) S P(7)="" I $P(X,"@",2)=0 D  G 26
 .W $C(7),!!?2,"'@0' is not permitted for Continuous IV's",!
 I X["???",($E(P("OT"))="I"),(PSIVAC["C") D ORFLDS G 26
 ;*194 Allow multi-word schedules
 I X?1."?"!($L(X)>22)!($L(X," ")>$S(X["PRN":4,1:3)) S F1=55.01,F2=.09 D ENHLP^PSIVORC1 G 26
 S CHG=0 I P(9)]"",X'=P(9) S CHG=1
 S P(7)="" K PSGOES D EN^PSIVSP S:XT<0 X="" I $G(X)="" W $C(7),"??" G 26
 I CHG D
 . S P(9)=X,P(11)=Y,P(15)=XT
 . I $$ODD^PSGS0(P(15)) S P(11)=""
 . W !!?5,"This change in schedule also changes the Administration Times and Schedule Type of this order."
 . S DIR("A")="Enter RETURN to continue or '^' to exit:"
 . D PAUSE^VALM1
 K CHG
 Q
 ;
39 ; Admin Times
 S ORIG=$G(P(11))
A39 I $G(P("RES"))="R" I $G(ON)["P",($P($G(^PS(53.1,+ON,0)),"^",24)="R") D  Q
 . Q:'$G(PSIVRENW)  W !!?5,"This is a Renewal Order. Administration times may not be edited at this point." D PAUSE^VALM1
 I $G(ON)["V"!($G(ON)["U") I $$COMPLEX^PSJOE(DFN,ON) D  Q
 .Q:$G(PSJBKDR)  W !!?5,"This is a Complex Order. Admin Times may not be edited at this point." D PAUSE^VALM1
 I $G(P(9))=""!($G(P(9))[" PRN")!($G(P(9))="PRN") Q  ;No schedule or PRN schedule
 I $$ODD^PSGS0(P(15)) S P(11)="" Q
 W !,"ADMINISTRATION TIMES: ",$S(P(11)]"":P(11)_"//",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 I '($G(P(15))="D"&'DONE) I $E(X)=U S (X,P(11))=ORIG Q
 I X="",P(11)]"" S X=P(11)
 I ($G(P(15))="D"!($G(P(9))["@"))&('$G(X)!(X["@")) W $C(7),"  ??" S X="?" W:(P(15)="D"!(X["@")) !,"This is a 'DAY OF THE WEEK' schedule and MUST have admin times." G A39
 I X="@" D DEL^PSIVEDRG S:%=1 P(11)="" G A39
 I X?1."?" D ENHLP^PSGOEM(53.1,39) G A39
 I X["???",($E(P("OT"))="I"),(PSIVAC["C") D ORFLDS G A39
 I $G(P(15))'="D",$G(P(15))'="P",'$$ONCALL(P(9)) D TIMES I '$D(X) G A39
 K:X[""""!($A(X)=45) X W:$G(X)="^"!('$D(X)) $C(7),"  ??" G:$G(X)="^"!('$D(X)) A39 S P(11)=X D:$G(PSIVCAL) ENT^PSIVCAL,ENSTOP^PSIVCAL K PSIVCAL
 Q
 ;
59 ; Infusion Rate
 ;*305
 N P8BADDEF S P8BADDEF=0 K PSJEXMSG
 I $G(P("RES"))="R" I $G(ON)["P",$P($G(^PS(53.1,+ON,0)),"^",24)="R" D  Q
 . Q:'$G(PSIVRENW)  W !!?5,"This is a Renewal Order. Infusion Rate may not be edited at this point." D PAUSE^VALM1
 W !,"INFUSION RATE: ",$S(P(8)]"":$P(P(8),"@")_"//",1:"") R X:DTIME S:'$T X=U S:X=U DONE=1 I $S($E(X)=U:1,X]"":0,1:P(8)]"") D:'$G(DONE) EXPINF(.X) D:'$G(DONE) NUMLAB(.P) G:$G(P8BADDEF) 59 Q
 S X=$TR(X,$C(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,127)) ; Strip out control characters
 I ((P(4)="P")!((P(4)="C")&(P(23)="P"))!(("C^S"[P(4))&(P(5)=1)))&(X["@") D  G 59
 .W $C(7),!!?2,"'@' is not permitted for Intermittent IV's",!
 I (X["^") D  G 59
 .W $C(7),!!?2,"'^' is not permitted",!
 I X=""&((P(4)="P")!((P(4)="C")&(P(23)="P"))!(("C^S"[P(4))&(P(5)=1))) Q
 I X="@" D DEL^PSIVEDRG S:%=1 P(8)="" G 59
 I X["???",($E(P("OT"))="I"),(PSIVAC["C") D ORFLDS G 59
 I X["?" S F1=53.1,F2=59 D ENHLP^PSIVORC1 G 59
 D EXPINF(.X)
 I ($L(X)>30!($L(X)=1)),(X'?1N) D  G 59
 .W $C(7),!!?3,"Free text entries must contain a minimum of 2 characters",!?3,"and a maximum of 30 characters",!
 I X]"" D ENI^PSIVSP W:'$D(X) $C(7)," ??" G:'$D(X) 59 S P(8)=X
 I P(8)="" W $C(7),!!,"An infusion rate must be entered!" G 59
 D NUMLAB(.P)
 Q
 ;
NUMLAB(P) ; Prompt for Number of Labels
 N PSJILBS
NUMLAB2 ; Loop ;*305
 ; Quit if no Infusion Rate
 Q:($G(P(8))="")
 I ((P(4)="P")!((P(4)="C")&(P(23)="P"))!(("C^S"[P(4))&(P(5)=1))) D  Q
 .I $G(X)="",$G(P(8))["@" S P(8)=$P(P(8),"@")
 K DIR S PSJILBS=$P($G(P(8)),"@",2) S:'(PSJILBS?1.N) PSJILBS=$G(P("NUMLBL")) I $G(PSJILBS)?1.N S DIR("B")=PSJILBS
 D NLBHLP(1)
 S DIR(0)="FAO",DIR("A")="NUMBER OF LABELS PER DAY: " D ^DIR Q:X="^"
 I X="@" D DEL^PSIVEDRG S:%=1 P("NUMLBL")="",P(8)=$P(P(8),"@") G NUMLAB2
 I X?1."?" D NLBHLP G NUMLAB2
 I X?1.2N S P("NUMLBL")=+X,P(8)=$P(P(8),"@")_"@"_P("NUMLBL") Q
 I X="",(P(8)'?1N.N.1".".1N1" ml/hr") D  G NUMLAB2
 .W $C(7),!!,"Number of Labels is required for continuous IV's with free text Infusion Rate.",!
 Q:X=""
 I X'?1.2N D  G NUMLAB2
 .W $C(7),!!,"Type a number between 0 and 99, 0 decimal digits",!
 Q
 ;
63 ; Remarks
 N DIR S X="",DIR(0)="53.1,63" S:P("REM")]"" DIR("B")=P("REM") D ^DIR I X="^"!$D(DTOUT) S DONE=1 Q
 I X="@" D DEL^PSIVEDRG S:%=1 P("REM")="" G 63
 I X]"",$E(X)'="^" S P("REM")=X
 Q
 ;
64 ; Other Print Info
 N OPIMSG,PSJOPILN,PSJOPIT,PSJTMPTX,TMPLIN,PSJOVRMX
 S PSJOPILN=$$EDITOPI^PSJBCMA5(DFN) S OPIMSG="Instructions too long. See Order View or BCMA for full text."
 S PSJTMPTX="",PSJOVRMX=0
 S TMPLIN=0 F  S TMPLIN=$O(^PS(53.45,$G(PSJSYSP),6,TMPLIN)) Q:'TMPLIN!PSJOVRMX  D
 .S:($L(PSJTMPTX)+$L($G(^PS(53.45,$G(DUZ),6,TMPLIN,0))))>60 PSJOVRMX=1 Q:$G(PSJOVRMX)  D
 ..S PSJTMPTX=$G(PSJTMPTX)_$S($L($G(PSJTMPTX)):" ",1:"")_$G(^PS(53.45,$G(DUZ),6,TMPLIN,0))
 S PSJTMPTX=$S($G(PSJOVRMX):OPIMSG,1:$G(PSJTMPTX))
 S P("OPI")=PSJTMPTX I (PSJOPILN>0) S P("OPI")=$$ENBCMA^PSJUTL("V")
 I PSJTMPTX="",PSJOPILN="" S P("OPI")=$$ENBCMA^PSJUTL("V")  ;P416
 Q
 ;
IND ;*399-IND
 N INDLST,DIR,SEL,I,J,K,L,M,N,O,INDI,CHK,CNT K DUOUT,DTOUT,DIROUT,DIRUT
 S (CHK,CNT,J)=0
 S O=0 S:'$D(DRG("AD")) O=1
 F I="AD","SOL" S J=0 F  S J=$O(DRG(I,J)) Q:'J  S K=$P(DRG(I,J),U,6) D:K
 . K ^TMP($J,"PSJDIND")
 . D INDCATN^PSS50P7(K,"PSJDIND")
 . Q:'$O(^TMP($J,"PSJDIND",0))
 . S L=0 F  S L=$O(^TMP($J,"PSJDIND",L)) Q:'L  D
 . . S N=$P($G(^TMP($J,"PSJDIND",L)),"^") S:N]"" M(N)=""
 K ^TMP($J,"PSJDIND")
 I '$D(M) S Y=99 G CIND
 S INDI="" F  S INDI=$O(M(INDI)) Q:INDI=""  D
 . I $G(P("IND"))]"",INDI=P("IND") S CHK=1
 . S CNT=CNT+1,DIR("L",CNT)="  "_CNT_$S(CNT<10:"   ",1:"  ")_INDI S:CNT=1 SEL=CNT_":"_INDI S:CNT>1 SEL=SEL_";"_CNT_":"_INDI
 W !,"INDICATION:"
 S DIR(0)="SO^"_SEL_";99:Free Text entry",DIR("A")="Select INDICATION from the list"
 S DIR("L")="  99  Free Text entry"
 S:CHK DIR("B")=P("IND") S:'CHK&(P("IND")]"") DIR("B")=99
 S DIR("?")="This field contains the Indication For Use and must be 3-40 characters in length"
 D ^DIR
 I X="^"!($G(DTOUT))!($G(DIROUT)) S DONE=1 Q
 I Y=99 S:CHK P("IND")="" G CIND
 I X="@",$G(P("IND"))]"" D DEL^PSIVEDRG G:%'=1 IND S P("IND")="" Q
 I X="@" S P("IND")="" G IND
 S:Y>0 P("IND")=Y(0)
 Q
 ;
CIND ;
 I Y=99 N I,J,IND,DA D  G:$G(Y)=99 CIND
  . K X,Y,DIRUT,DTOUT,DUOUT,DIROUT,DIR
  . S:$G(P("IND"))]"" DIR("B")=P("IND")
 . S DIR(0)="53.1,132",DIR("A")="INDICATION" D ^DIR
 . I X="^"!($G(DTOUT))!($G(DIROUT)) S DONE=1 Q
 . I X="@",$G(P("IND"))]"" D DEL^PSIVEDRG G:%'=1 IND S P("IND")="" Q
 . I X="@" S P("IND")="" G IND
 . I $L(X," ")=1,$L(X)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED WITHOUT SPACES.",! S Y=99 Q
 . S IND="" F I=1:1:$L(X," ") Q:I=""  S J=$P(X," ",I) D  I '$D(X) S Y=99 Q
 . .I $L(J)>32 W $C(7),!?5,"MAX OF 32 CHARACTERS ALLOWED BETWEEN SPACES.",! K X Q
 . .S:J]"" IND=$S($G(IND)]"":IND_" ",1:"")_J
 . Q:$G(Y)=99
 . S P("IND")=$$ENLU^PSGMI(IND)
 Q
 ;
ORFLDS ; Display OE/RR fields during edit.
 D FULL^VALM1
 W !!,"Orderable Item: ",$P(P("PD"),U,2),!,"Give: ",$P(P("MR"),U,2)," ",P(9),!!
 Q
 ;
TIMES ;At least one admin time, not more than interval allows.
 I $G(P(15)) Q:$$ODD^PSGS0(P(15))
 I $G(P(15))="C"!$$CONTIN($G(P(9))) I '$$ONCALL($G(P(9))),X="" W !,"This order requires at least one administration time." K X Q  ;No times
 N H,I,MAX
 I $G(P(15))="O"!$$ONETIME($G(P(9))) I $L(X,"-")>1 W !," This is a One Time Order - only one administration time is permitted." K X Q
 I $G(P(15))="O"!$$ONETIME($G(P(9))) Q  ;Done validating One Time
 I $G(P(9))]"" S H=+$O(^PS(51.1,"B",P(9),0)) S I=$P($G(^PS(51.1,H,0)),"^",3)
 I +I=0 Q  ;No frequency - can not check frequency related items
 S MAX=1440/I
 I MAX<1,$L(X,"-")>1 W !,"This order requires one administration time." K X Q
 I MAX'<1,$L(X,"-")>MAX W !,"The number of admin times entered is greater than indicated by the schedule." K X Q  ;Too many times
 I MAX'<1,$L(X,"-")<MAX D  ;Too few times
 . W !,"The number of admin times entered is fewer than indicated by the schedule."
 . N X,DIR
 . D PAUSE^VALM1
 Q
 ;
DOSE ;Make certain at least one dose is given.
 N INFO,Y,PNINE
 S PNINE=P(9)
 S INFO=$G(P(2))_U_$G(P(3))_U_$G(P(9))_U_$P($G(PSGZZND),"^",5)_U_$P($G(P("PD")),"^")_U_$G(P(11))
 I '$L($G(PSGP)) N PSGP S PSGP=""
 S Z=$$ENQ^PSJORP2(PSGP,INFO)  ;Expected first dose.
 S P(9)=PNINE
 Q
 ;
ONCALL(SCHD) ; Check if a schedule is type On Call (all schedules with a given name must have the same schedule type)
 N NXT,SCHARR
 S OCCHK=0
 Q:$G(SCHD)="" OCCHK
 Q:'$D(^PS(51.1,"APPSJ",SCHD)) OCCHK
 S NXT=0 F  S NXT=$O(^PS(51.1,"APPSJ",SCHD,NXT)) Q:'NXT  S TYP=$P($G(^PS(51.1,+NXT,0)),"^",5) S:TYP]"" SCHARR(TYP)=""
 I '$D(SCHARR("OC")) S OCCHK=0 Q OCCHK
 I $O(SCHARR("OC"))]""!($O(SCHARR("OC"),-1)]"") S OCCHK=0 Q OCCHK
 I $D(SCHARR("OC")) S OCCHK=1
 Q OCCHK
 ;
ONETIME(SCHD) ; Check if a schedule is type On Call (all schedules with a given name must have the same schedule type)
 N NXT,SCHARR
 S OCCHK=0
 Q:$G(SCHD)="" OCCHK
 Q:'$D(^PS(51.1,"APPSJ",SCHD)) OCCHK
 S NXT=0 F  S NXT=$O(^PS(51.1,"APPSJ",SCHD,NXT)) Q:'NXT  S TYP=$P($G(^PS(51.1,+NXT,0)),"^",5) S:TYP]"" SCHARR(TYP)=""
 I '$D(SCHARR("O")) S OCCHK=0 Q OCCHK
 I $O(SCHARR("O"))]""!($O(SCHARR("O"),-1)]"") S OCCHK=0 Q OCCHK
 I $D(SCHARR("O")) S OCCHK=1
 Q OCCHK
 ;
CONTIN(SCHD) ; Check if a schedule is type On Call (all schedules with a given name must have the same schedule type)
 N NXT,SCHARR
 S OCCHK=0
 Q:$G(SCHD)="" OCCHK
 Q:'$D(^PS(51.1,"APPSJ",SCHD)) OCCHK
 S NXT=0 F  S NXT=$O(^PS(51.1,"APPSJ",SCHD,NXT)) Q:'NXT  S TYP=$P($G(^PS(51.1,+NXT,0)),"^",5) S:TYP]"" SCHARR(TYP)=""
 I '$D(SCHARR("C")) S OCCHK=0 Q OCCHK
 I $O(SCHARR("C"))]""!($O(SCHARR("C"),-1)]"") S OCCHK=0 Q OCCHK
 I $D(SCHARR("C")) S OCCHK=1
 Q OCCHK
 ;
NLBHLP(OUT) ; Help text for Number of Labels per day
 I OUT=1 D  Q
 .S DIR("?",1)="Enter the # of labels per day that will be needed."
 .S DIR("?",2)=""
 .S DIR("?",3)="Example:   0 = 0 labels per day."
 .S DIR("?",4)="           2 = 2 labels per day."
 .S DIR("?",5)="Note:  Number of Labels per day is required for continuous IV orders"
 .S DIR("?",6)="       with free text Infusion Rate. Number of labels per day is not"
 .S DIR("?",7)="       permitted for Intermittent (IVPB) type orders; for Intermittent"
 .S DIR("?",8)="       orders, the schedule and administration time(s) will be used to"
 .S DIR("?")="       determine the number of labels needed."
 ;
 W !,"Enter the # of labels per day that will be needed."
 W !,"Example:   0 = 0 labels per day."
 W !,"           2 = 2 labels per day."
 W !!,"Note: Number of Labels per day is required for continuous IV orders"
 W !,"       with free text Infusion Rate. Number of labels per day is not"
 W !,"       permitted for Intermittent (IVPB) type orders; for Intermittent"
 W !,"       orders, the schedule and administration time(s) will be used to"
 W !,"       determine the number of labels needed."
 Q
 ;
EXPINF(P8,SILENT) ; Expand Infusion Rate
 ;*305
 Q:$G(P8)!($G(PSJEXMSG))  N P8TMP S P8TMP=$$UP^XLFSTR($P(P8,"@"))
 N EXPANDED S EXPANDED="" D INFCHK^PSJLIVFD(P8TMP,.EXPANDED)
 I (EXPANDED=$P(P8,"@"))!(EXPANDED=P8TMP) Q
 S PSJEXMSG=1 I '$G(SILENT) W "     Now expanding text"
 I P8["@" S $P(P8,"@")=EXPANDED
 I P8'["@" S P8=EXPANDED
 I '$G(SILENT) W:$G(PSJEXMSG) !," Input expanded to ",EXPANDED
 Q
 ;
