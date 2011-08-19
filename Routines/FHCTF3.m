FHCTF3 ; HISC/REL/NCA - Clear File Entries ;4/6/01  09:37
 ;;5.5;DIETETICS;**4**;Jan 28, 2005;Build 32
E0 K DIC,^TMP($J) S DIC="^VA(200,",DIC(0)="AQEM",DIC("A")="Select CLINICIAN: ",DIC("B")=$P($G(^VA(200,DUZ,0)),"^",1) W ! D ^DIC K DIC G KIL:"^"[X!$D(DTOUT),E0:Y<1 S FHDUZ=+Y
 S (FHQT,CNT,QT)=0 D NOW^%DTC S NOW=%,DT=NOW\1 D CLN^FHCTF4 S $P(LN,"-",80)="",QT=""
E1 F LLL=0:0 S LLL=$O(^FH(119,FHDUZ,"I",LLL)) Q:LLL<1  S FHTF=^(LLL,0),DFN=$P(FHTF,U,4),FHZ115="P"_DFN D CHECK^FHOMDPA I $G(FHDFN) D
 .D PATNAME^FHOMUTL
 .S ^TMP($J,FHPTNM,FHDFN,LLL)=FHDFN
 S FHPTNM=""
CL0 S FHPTNM=$O(^TMP($J,FHPTNM)) G:(FHPTNM="")!(FHQT=U) OUT G CL1
 ;
OUT G:FHQT=U KIL I 'CNT W !!,"No Tickler File Entries"
 W ! G KIL
 ;
CL1 F FHDFN=0:0 S FHDFN=$O(^TMP($J,FHPTNM,FHDFN)) Q:FHDFN'>0  S FHCNT=0,QT="" K FHCLR F FHI=0:0 S FHI=$O(^TMP($J,FHPTNM,FHDFN,FHI)) D:FHI'>0 ASK Q:QT=U  D CL2
 G CL0
 ;
CL2 I FHI'>0 S QT=U Q
 S FHTF=$G(^FH(119,FHDUZ,"I",FHI,0))
 S DTP=$P(FHTF,"^",1),TYP=$P(FHTF,"^",2),X=$P(FHTF,"^",3),DFN=$P(FHTF,"^",4),ADM=$P(FHTF,"^",5)
 S CNT=CNT+1
 I DFN,ADM S FHWRD=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8)
 D:'FHCNT HDR
 S FHCNT=FHCNT+1
 S FHCLR(TYP,FHCNT)=FHI
 S Y=DTP X ^DD("DD")
 W !,FHCNT,".",?4,$P(FHTF,U,3),"  Date: ",Y
 Q
ASK W !!,"Select an entry to clear (1,2,3... or 'A' or Return): Return// " R FHNM:DTIME I '$T!(FHNM["^") S FHQT=U Q
 I FHNM="" S QT=U Q
 S X=FHNM D TR^FH S FHNM=X
 S FHASK=0 K FHCHK
 I FHNM'="A" S FHTYP="" D
 .F  S FHTYP=$O(FHCLR(FHTYP)) Q:FHTYP=""  F FHI=0:0 S FHI=$O(FHCLR(FHTYP,FHI)) Q:FHI'>0  S FHCHK(FHI)=""
 .F FHENT=1:1 S FHNUM=$P(FHNM,",",FHENT) Q:FHNUM=""  D
 ..I '$D(FHCHK(FHNUM)) W *7,!!,"Enter an entry, or group of entries separated by a comma, or 'A' for all entries, or Return to bypass!" S FHASK=1
 G:FHASK ASK
 S (FHTYPSV,FHTYP)=""
 I FHNM="A" F  S FHTYP=$O(FHCLR(FHTYP)) G:FHTYP="" D1 D:(FHTYPSV'="")&(FHTYP'=FHTYPSV) D1 D
 .K FHIEN F FHII=0:0 S FHII=$O(FHCLR(FHTYP,FHII)) Q:FHII'>0  S FHTYPSV=FHTYP,FHIEN(FHCLR(FHTYP,FHII))=""
 I FHNM'="A" F  S FHTYP=$O(FHCLR(FHTYP)) G:FHTYP="" D1 D:(FHTYPSV'="")&(FHTYP'=FHTYPSV) D1 D
 .K FHIEN F FHENT=1:1 S FHII=$P(FHNM,",",FHENT) Q:FHII=""  S FHTYPSV=FHTYP I $D(FHCLR(FHTYP,FHII)) S FHIEN(FHCLR(FHTYP,FHII))=""
 Q
D1 ;
 S FHTICK=$O(FHIEN(0))
 Q:'FHTICK
 S FHTF=$G(^FH(119,FHDUZ,"I",FHTICK,0)) D D2
 Q:QT=U
 F LLL=0:0 S LLL=$O(FHIEN(LLL)) Q:LLL'>0  D
 .S FHTF=$G(^FH(119,FHDUZ,"I",LLL,0)),DTP=$P(FHTF,"^",1),TYP=$P(FHTF,"^",2),X=$P(FHTF,"^",3),DFN=$P(FHTF,"^",4),ADM=$P(FHTF,"^",5)
 .D:FHTYPSV'="C" @FHTYPSV
 G DNE
 ;
S S:NO $P(^FHPT(FHDFN,"A",ADM,"SF",NO,0),"^",30,31)=NOW_"^"_DUZ
 K ^FH(119,FHDUZ,"I",LLL)
 Q
C ;
 Q
D S:FHORD $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",16,17)=NOW_"^"_DUZ
 K ^FH(119,FHDUZ,"I",LLL)
 Q
T S:TF $P(^FHPT(FHDFN,"A",ADM,"TF",TF,0),"^",15,16)=NOW_"^"_DUZ
 K ^FH(119,FHDUZ,"I",LLL)
 Q
N I F1,$D(^FHPT(FHDFN,"S",F1,0)) S $P(^FHPT(FHDFN,"S",F1,0),"^",4,5)=NOW_"^"_DUZ
 K ^FH(119,FHDUZ,"I",LLL)
 Q
M ;
 S F1=$P(FHTF,"^",6) S $P(^FHPT(FHDFN,"A",ADM,"MO",F1,0),"^",3,5)=MOCOM_"^"_DUZ_"^"_NOW
 K ^FH(119,FHDUZ,"I",LLL)
 Q
 ;
D2 S DTP=$P(FHTF,"^",1),TYP=$P(FHTF,"^",2),X=$P(FHTF,"^",3),DFN=$P(FHTF,"^",4),ADM=$P(FHTF,"^",5)
 S CNT=CNT+1
 I DFN,ADM S FHWRD=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8)
 D SF:TYP="S",CN:TYP="C",DI:TYP="D",TF:TYP="T",NS:TYP="N",MO:TYP="M" Q
SF ; Clear Supplemental Feeding
 S NO=$P(FHTF,"^",6)
 D CUR^FHORD7
 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 S Y=$S('NO:"",1:$G(^FHPT(FHDFN,"A",ADM,"SF",NO,0))) D L1^FHNO7
S1 R !!,"Is Order OK? Y// ",YN:DTIME S:'$T!(YN["^") QT="^" Q:QT="^"  S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G S1
 S YN=$E(YN,1) I YN'="Y" S QT=U
 Q
CN ; Clear Consult
 S FHDR=$P(FHTF,"^",6),Y=^FHPT(FHDFN,"A",ADM,"DR",FHDR,0),ALL=0
 D D1^FHORC2
C1 R !!,"Disposition (C=Complete, X=Cancelled, R=Reassign, RETURN to bypass): ",TYP:DTIME S:'$T!(TYP["^") QT="^" Q:"^"[TYP  S X=TYP D TR^FH S TYP=X I TYP'?1U!("XCR"'[TYP) W *7,!,"Enter C, X or R or Press RETURN to bypass" G C1
 I TYP="R" G C2
C11 I ORIFN S ORSTS=TYP="C"+1 D ST^ORX
 K ^FHPT("ADRU",FHDUZ,FHDFN,ADM,FHDR)
 S $P(^FHPT(FHDFN,"A",ADM,"DR",FHDR,0),"^",8,10)=TYP_"^"_NOW_"^"_DUZ K ^FH(119,FHDUZ,"I",LLL)
 D:TYP="C" EN31^FHASE G DNE
C2 K DIC S DIC="^VA(200,",DIC(0)="AEQM",DIC("A")="REASSIGN to Clinician: " W ! D ^DIC S:$D(DTOUT) QT="^" Q:Y<1  S XMKK=+Y K DIC
 K ^FHPT("ADRU",FHDUZ,FHDFN,ADM,FHDR) S ^FHPT("ADRU",XMKK,FHDFN,ADM,FHDR)=""
 S $P(^FHPT(FHDFN,"A",ADM,"DR",FHDR,0),"^",5)=XMKK
 K ^FH(119,FHDUZ,"I",LLL) S FHSV=FHDUZ,FHDUZ=XMKK D FILE^FHCTF2 S FHDUZ=FHSV
 S WARD=""
 I FHWRD S WARD=$P($G(^FH(119.6,+FHWRD,0)),"^",1)
 S REQ=CON D POST^FHORC
 G DNE
 Q
 ;
TF ; Tubefeed
 S TF=$P(FHTF,"^",6)
 D DIS^FHORT2
T1 R !!,"Is Order OK? Y// ",YN:DTIME S:'$T!(YN["^") QT="^" Q:QT="^"  S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G T1
 S YN=$E(YN,1) I YN'="Y" S QT=U
 Q
DI ; Diet
 S FHORD=$P(FHTF,"^",6)
 I FHORD D C2^FHORD7 W !!,"Current Diet: ",$S(Y'="":Y,1:"No current order")
 I 'FHORD W !!,"No current order"
 I FHORD,$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,1)) S COM=^(1) W:COM'="" !,"Comment: ",COM
 S TYS=$P(X,"^",8) I TYS'="" W !,"Service: ",$S(TYS="T":"Tray",TYS="D":"Dining Room",1:"Cafeteria")
 S DTP=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",3) I DTP D DTP^FH W !,"Expires: ",DTP
 R !!,"Is Order OK? Y// ",YN:DTIME S:'$T!(YN["^") QT="^" Q:QT="^"  S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G D1
 S YN=$E(YN,1) I YN'="Y" S QT=U
 Q
NS ; Status
 S F1=$P(FHTF,"^",6),Y=$G(^FHPT(FHDFN,"S",+F1,0)) Q:Y=""  S S=$P(Y,"^",2)
 W !!,"Current Status: ",$P($G(^FH(115.4,+S,0)),"^",2)
N1 R !!,"Is Status OK? Y// ",YN:DTIME S:'$T!(YN["^") QT="^" Q:QT="^"  S:YN="" YN="Y" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G N1
 S YN=$E(YN,1) I YN'="Y" S QT=U
 Q
MO ; Monitor
 W !!,$P(FHTF,"^",3)
M1 S MOCOM="" R !!,"Action Taken: ",MOCOM:DTIME S:MOCOM="^" QT="^" Q:'$T!(MOCOM["^")  I MOCOM'?.ANP W *7," ??" G M1
 I MOCOM=""!($L(MOCOM)>60)!(MOCOM?1"?".E) W *7,!,"Required entry: document action (up to 60 characters) or ^ to bypass." G M1
 Q
DNE W "  ... done" Q
HDR S DFN=$P($G(^FHPT(FHDFN,0)),U,1),DFN=$E(DFN,2,99) Q:'DFN  S Y0=$G(^DPT(DFN,0)) W !!!,$P(Y0,"^",1) D PID^FHDPA W:BID'="" " (",BID,")"
 W ?40,$S($P(Y0,"^",2)="F":"Female",1:"Male")
 S AGE=$P(Y0,"^",3) I AGE'="" S AGE=$E(DT,1,3)-$E(AGE,1,3)-($E(DT,4,7)<$E(AGE,4,7)) W "   Age ",AGE
 S WARD=""
 I FHWRD S WARD=$P($G(^FH(119.6,+FHWRD,0)),"^",1)
 S X=WARD_" "_$P($G(^DPT(DFN,.101)),"^",1) W ?(79-$L(X)),X
 W !,LN
 Q
HDR1 S X=$S(TYP="S":"SUPPLEMENTAL FEEDING",TYP="C":"DIETETIC CONSULTATION",TYP="D":"DIET ORDER",TYP="T":"TUBEFEEDING",TYP="N":"NUTRITION STATUS",TYP="M":"MONITOR",1:"")
 Q
KIL ;clean variables
 K ^TMP($J),ADM,AGE,BID,CNT,DFN,FHAGE,FHBID,FHCLR,FHCNT,FHDFN,FHDOB,FHDUZ,FHI,FHNM,FHPCZN,FHPTNM,FHQT,FHSEX,FHSSN,FHTF,FHWRD,FHZ115,FILE
 K IEN,FLAG,K,LLL,LN,NOW,PID,QT,TYP,W1,WARD,X,Y,YO,FHA,YN,FHORD,FHTF,DTP,DTE,A1,DDH,DIR,FHASK,FHENT,FHIEN,FHII,FHLD,FHNUM,QUAFI
 K FHOR,FHTICK,FHTYP,FHTYPSV,IEN200,REASK,TYS,MOCOM,AGE,F1,FHDR,DIC,DIR,FHSV,FHCHK,D3,Y0,ALL,T,TF2,NO,TUN,TFCOM,STR,QUA,QUASE
 K FHDU,X1,REQ,COM,FHTDAT,FHI115,I
 Q
