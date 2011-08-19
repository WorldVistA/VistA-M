GMVER1 ;HOIFO/RM,YH,FT-ENTERED IN ERROR FOR A PATIENT & DATE RANGE ;12/12/01  12:36
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls          (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ;
EN1(RESULT,GMVDFN,GMVBEG,GMVEND) ; [RPC entry point]
 ; Returns Entered in Error records for a date range
 ; Input:
 ;  RESULT   = Where data is returned (closed array reference) (Required)
 ;  GMVDFN   = A pointer to the Patient file (#2) (Required)
 ;  GMVBEG   = Beginning date for all vitals
 ;  GMVEND   = Ending    date for all vitals
 ;
 ; Output:
 ;  RESULT() = TMP global address with the nodes of report text
 ;  The TMP global nodes are:
 ;  ^TMP($J,GMRDATE,GMRVITY,GMRVDA,1)=date/time of the error, Vital
 ;                                    type, name of user
 ;  ^TMP($J,GMRDATE,GMRVITY,GMRVDA,2)=error reason
 ;  ^TMP($J,GMRDATE,GMRVITY,GMRVDA,3)=revised data, if any (optional)
 ;  ^TMP($J,GMRDATE,GMRVITY,GMRVDA,4)=the incorrect data
 ;
 S GMRVITY=0
 K ^TMP($J,"LIST"),^TMP($J,"ERRORS")
 F  S GMRVITY=$O(^GMR(120.5,"AA",GMVDFN,GMRVITY)) Q:GMRVITY'>0  F GMRVDT=0:0 S GMRVDT=$O(^GMR(120.5,"AA",GMVDFN,GMRVITY,GMRVDT)) Q:GMRVDT'>0  S GMRVDATE=9999999-GMRVDT I GMRVDATE'<GMVBEG,GMRVDATE'>GMVEND D SORT
 S GMRDATE=0
 F  S GMRDATE=$O(^TMP($J,"LIST",GMRDATE)) Q:GMRDATE'>0  F GMRVITY=0:0 S GMRVITY=$O(^TMP($J,"LIST",GMRDATE,GMRVITY)) Q:GMRVITY'>0  F GMRVDA=0:0 S GMRVDA=$O(^TMP($J,"LIST",GMRDATE,GMRVITY,GMRVDA)) Q:GMRVDA'>0  D WRT
Q ; KILL VARIABLES
 K BADRATE,GOODRATE,GMRDAT,GMRDATE,GMRPR,GMRVDA,GMRVDATE,GMRVDT,GMRVERR,GMVEND,GMRVITY,GMVBEG,GMRVX,GMRP,GMRTYPE
 K GREASON,GMRZZ,GMRVARY,GMRQUAL,GMRVPO,GMVNODE,GMVSPACE,^TMP($J,"LIST")
 I '$D(^TMP($J,"ERRORS")) S ^TMP($J,"ERRORS",0)="No data for the time period indicated."
 S RESULT=$NA(^TMP($J,"ERRORS"))
 Q
SORT ; loop through the AA x-ref and find patient entries marked as
 ; entered in error (i.e., node 2 exists).
 S GMRVERR=0
 F  S GMRVERR=$O(^GMR(120.5,"AA",GMVDFN,GMRVITY,GMRVDT,GMRVERR)) Q:GMRVERR'>0  I '$D(^GMR(120.5,GMRVERR,2)) Q
 S GMRVDA=0
 F  S GMRVDA=$O(^GMR(120.5,"AA",GMVDFN,GMRVITY,GMRVDT,GMRVDA)) Q:GMRVDA'>0  I $D(^GMR(120.5,GMRVDA,2)) S ^TMP($J,"LIST",GMRVDATE,GMRVITY,GMRVDA)=GMRVERR
 Q
WRT ;
 S GMRVERR=^TMP($J,"LIST",GMRDATE,GMRVITY,GMRVDA)
 S GMRDAT("GOOD")=$S($D(^GMR(120.5,+GMRVERR,0)):^(0),1:"")
 I $D(^GMR(120.5,+GMRVERR,0)) D
 .K GMRVX
 .S GMRVX=$P(^GMRD(120.51,GMRVITY,0),"^",2)
 .S GMRVX(0)=$P(GMRDAT("GOOD"),"^",8)
 .D:GMRVX(0)>0!(GMRVX(0)=0) EN1^GMVSAS0
 .S GMRVX(1)=$S('$D(GMRVX(1)):"",'GMRVX(1):"",1:"*")
 .S GMRVX(0)=$$WRTDAT(GMRVX,GMRVX(0))
 .S GMRZZ=""
 .I $P($G(^GMR(120.5,GMRVERR,5,0)),"^",4)>0 D
 ..K GMRVARY
 ..S GMRVARY=""
 ..D CHAR^GMVCHAR(GMRVERR,.GMRVARY,GMRVITY)
 ..S GMRZZ=$$WRITECH^GMVCHAR(GMRVERR,.GMRVARY,9)
 ..S:GMRZZ'=""&(GMRVX'="PO2") GMRZZ=" ("_GMRZZ_")"
 ..Q
 . I GMRVX="P" D
 ..I GMRZZ'="",GMRVX(0)=1 S:$F(GMRZZ,"DORSALIS PEDIS")>0 GMRVX(1)=""
 ..I GMRZZ'="",GMRVX(0)=0 S:$F(GMRZZ,"DORSALIS PEDIS")>0 GMRVX(1)="*"
 ..Q
 .S GMRVPO=$P(^GMR(120.5,GMRVERR,0),"^",10)
 .S $P(GMRDAT("GOOD"),"^",8)=GMRVX(0)_GMRVX(1)_$S(GMRVPO'="":" with supplemental O2 "_$S(GMRVPO["l/min":$P(GMRVPO," l/min")_"L/min",1:"")_$S(GMRVPO["l/min":$P(GMRVPO," l/min",2),1:GMRVPO),1:"")_$S(GMRZZ'=""&(GMRVX="PO2"):" via ",1:"")_GMRZZ
 .Q
 I $D(^GMR(120.5,+GMRVDA,0)) D
 .S GMRDAT("BAD")=$S($D(^GMR(120.5,+GMRVDA,0)):^(0),1:"")
 .K GMRVX,GMRVX(0),GMRVX(1)
 .S GMRVX=$P(^GMRD(120.51,GMRVITY,0),"^",2)
 .S GMRVX(0)=$P(GMRDAT("BAD"),"^",8)
 .D:GMRVX(0)>0 EN1^GMVSAS0
 .S GMRVX(1)=$S('$D(GMRVX(1)):"",'GMRVX(1):"",1:"*")
 .S GMRVX(0)=$$WRTDAT(GMRVX,GMRVX(0))
 .S GMRZZ=""
 .I $P($G(^GMR(120.5,GMRVDA,5,0)),"^",4)>0 D
 ..K GMRVARY
 ..S GMRVARY=""
 ..D CHAR^GMVCHAR(GMRVDA,.GMRVARY,GMRVITY)
 ..S GMRZZ=$$WRITECH^GMVCHAR(GMRVDA,.GMRVARY,9)
 ..S:GMRZZ'=""&(GMRVX'="PO2") GMRZZ=" ("_GMRZZ_")"
 ..Q
 .I GMRVX="P" D
 ..I GMRZZ'="",GMRVX(0)=1 S:$F(GMRZZ,"DORSALIS PEDIS")>0 GMRVX(1)=""
 ..I GMRZZ'="",GMRVX(0)=0 S:$F(GMRZZ,"DORSALIS PEDIS")>0 GMRVX(1)="*"
 ..Q
 .S GMRVPO=$P(^GMR(120.5,GMRVDA,0),"^",10)
 .S $P(GMRDAT("BAD"),"^",8)=GMRVX(0)_GMRVX(1)_$S(GMRVPO'="":" with supplemental O2 "_$S(GMRVPO["l/min":$P(GMRVPO," l/min")_"L/min",1:"")_$S(GMRVPO["l/min":$P(GMRVPO," l/min",2),1:GMRVPO),1:"")_$S(GMRZZ'=""&(GMRVX="PO2"):" via ",1:"")_GMRZZ
 .S GREASON="" D ERREASON
 S GMRPR("VSDT")=$$FMTE^XLFDT(GMRDATE)
 S GMRPR("ENUS")=$E($$PERSON^GMVUTL1(+$P(GMRDAT("BAD"),U,6)),1,21)
 S GMRPR("TYPE")=$S(GMRVITY="":"",$D(^GMRD(120.51,GMRVITY,0)):$P(^(0),"^"),1:"")
 S GMVNODE=""
 S GMVSPACE=$$REPEAT^XLFSTR(" ",79) ;line of spaces
 S GMVNODE=GMRPR("VSDT")
 S GMVNODE=GMVNODE_$$FILLER^GMVUTL1(21,$L(GMVNODE),GMVSPACE)_GMRPR("TYPE")
 S GMVNODE=GMVNODE_$$FILLER^GMVUTL1(58,$L(GMVNODE),GMVSPACE)_GMRPR("ENUS")
 S ^TMP($J,"ERRORS",GMRDATE,GMRVITY,GMRVDA,1)=GMVNODE
 S ^TMP($J,"ERRORS",GMRDATE,GMRVITY,GMRVDA,2)="   Reason: "_GREASON
 S GMVNODE=""
 I $G(GMRVERR)>0 S GMVNODE="   (Revised)  "_$P(GMRDAT("GOOD"),"^",8) D
 .I GMRVX="PN" D
 ..S GOODRATE=$P(GMRDAT("GOOD"),U,8)
 ..S GMVNODE=GMVNODE_$S(GOODRATE=0:" No pain",GOODRATE=10:" Worst imaginable pain",GOODRATE=99:" Unable to respond",1:"")
 ..Q
 .Q
 I $L(GMVNODE)>0 D
 .S ^TMP($J,"ERRORS",GMRDATE,GMRVITY,GMRVDA,3)=GMVNODE
 .Q
 S GMVNODE=""
 I GMRVDA>0 S GMVNODE="   (Bad data)  "_$P(GMRDAT("BAD"),"^",8) D
 .I GMRVX="PN" D
 ..S BADRATE=$P(GMRDAT("BAD"),U,8)
 ..S GMVNODE=GMVNODE_$S(BADRATE=0:" No pain",BADRATE=10:" Worst imaginable pain",BADRATE=99:" Unable to respond",1:"")
 ..Q
 .Q
 I $L(GMVNODE)>0 D
 .S ^TMP($J,"ERRORS",GMRDATE,GMRVITY,GMRVDA,4)=GMVNODE
 .Q
 Q
ERREASON ;ERROR REASON
 Q:'$D(^GMR(120.5,+GMRVDA,2.1))
 S GER=0
 F  S GER=$O(^GMR(120.5,+GMRVDA,2.1,GER)) Q:GER'>0  S GER(1)=+$G(^GMR(120.5,+GMRVDA,2.1,GER,0)) D
 .S GER(2)=$S(GER(1)=1:"incorrect date/time",GER(1)=2:"incorrect reading",GER(1)=3:"incorrect patient",GER(1)=4:"invalid record",1:"")
 .I GER(2)'="" S GREASON=GREASON_$S(GREASON'="":", ",1:"")_GER(2)
 .Q
 K GER
 Q
WRTDAT(TYPE,DATA) ;
 I '((TYPE="BP")!(TYPE="P")!(TYPE="R")),DATA>0 D @($$UP^XLFSTR(TYPE))
 Q DATA
T S DATA=DATA_" F  ("_$J(+DATA-32*5/9,0,1)_" C)" Q
WT S DATA=DATA_" lb  ("_$J(DATA/2.2,0,2)_" kg)" Q
HT S DATA=$S(DATA\12:DATA\12_" ft ",1:"")_$S(DATA#12:DATA#12_" in",1:"")_" ("_$J(DATA*2.54,0,2)_" cm)" Q
CG S DATA=DATA_" in ("_$J(+DATA/.3937,0,2)_" cm)" Q
CVP S DATA=DATA_" cmH2O ("_$J(DATA/1.36,0,1)_" mmHg)" Q
PO2 S DATA=DATA_"%" Q
PN I DATA=0 S DATA=DATA_" No pain " Q
 I DATA=99 S DATA=DATA_" Unable to respond " Q
 I DATA=10 S DATA=DATA_" Worst imaginable pain " Q
 Q
