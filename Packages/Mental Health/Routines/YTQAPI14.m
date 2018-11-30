YTQAPI14 ;ASF/ALB,HIOFO/FT - MHA PROCEDURES ; 3/27/13 11:34am
 ;;5.01;MENTAL HEALTH;**85,97,96,103,108**;Dec 30, 1994;Build 17
 Q
 ;Reference to ^XUSEC( supported by DBIA #10076
 ;Reference to ^DPT( supported by DBIA #10035
 ;Reference to ^PXRMINDX(601.84, supported by DBIA #4290
 ;Reference to FILE 870 supported by DBIA #5603
RESEND ;resend all no transmits and errors
 ;N YSDATE,YSAD,YSTS,YSFILT,YSBEG,YSEND
 ;W @IOF,!,"MHA3 HL7 Resends",!!,"CAUTION:: use only if instructed by National Support Staff",!
 ;K DIR S DIR(0)="Y",DIR("B")="No",DIR("A")="Continue" D ^DIR Q:$D(DIRUT)
 ;Q:Y=0
 ;K DIR S DIR(0)="D^:DT:EX",DIR("A")="Begin Date" D ^DIR Q:$D(DIRUT)
 ;S YSBEG=Y
 ;K DIR S DIR(0)="D^"_Y_":DT:EX",DIR("A")="End Date" D ^DIR Q:$D(DIRUT)
 ;S YSEND=Y
 ;K DIR S DIR(0)="S^E:Errors only;T:Awaiting Transmission only;B:Both Errors;A:All administrations",DIR("A")="Filter resend" D ^DIR Q:$D(DIRUT)
 ;S YSFILT=Y
 ;S YSCODE=0,N1=0 F  S YSCODE=$O(^YTT(601.84,"AC",YSCODE)) Q:YSCODE'>0  D
 ;. S YSSNDFLG=$P($G(^YTT(601.71,YSCODE,8)),U,4)
 ;. Q:YSSNDFLG'="Y"
 ;. S YSDATE=YSBEG,YSEND=YSEND+.9
 ;. F  S YSDATE=$O(^YTT(601.84,"AC",YSCODE,YSDATE)) Q:YSDATE'>0!(YSDATE>YSEND)  D
 ;.. S YSAD=0 F  S YSAD=$O(^YTT(601.84,"AC",YSCODE,YSDATE,YSAD)) Q:YSAD'>0  D  Q
 ;... S YSTS=$P($G(^YTT(601.84,YSAD,2)),U)
 ;... Q:YSTS=""  ;-->out never send --incomplete
 ;... I YSFILT="E" Q:YSTS'="E"
 ;... I YSFILT="T" Q:YSTS'="T"
 ;... I YSFILT="B" Q:(YSTS'="E")&(YSTS'="T")
 ;... D NULLNOW
 ;... K YS,YSDATA S YS("AD")=YSAD D HL7^YTQHL7(.YSDATA,.YS)
 ;... S N1=N1+1 ;W !,N1,"  ",YSAD,"  date=",YSDATE," stat= ",YSTS
 ;W !,N1," messages resent"
 Q
NULLNOW ;set transmission status to "" and NOW
 ;N DIE,DR,DA
 ;S DA=YSAD,DIE="^YTT(601.84,",DR="11////@;12///NOW"
NN1 ;re-entry if lock fails
 ;L +^YTT(601.84,DA):DILOCKTM I '$T H 10 G NN1
 ;D ^DIE
 ;L -^YTT(601.84,DA)
 Q
CKHL7 ;check hl7 status
 ;N DIC,DA
 ;W @IOF,!?15,"*** HL7 Check ***",!
 ;S X="YS MHAT",DIC=870 D ^DIC
 ;I +Y'>0 W !,"YS MHAT ERROR" Q  ;-->out
 ;S DA=+Y D EN^DIQ
 ;S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Continue" D ^DIR Q:$D(DIRUT)
 ;Q:Y=0
 ;D SELADM^YTQAPI14(.YSAD)
 ;Q:YSAD'>0  ;-->out
 ;S DIC="^YTT(601.84,",DA=YSAD D EN^DIQ
 Q
SEND1 ;send single HL7 by pt & test
 ;N DIC,YSAD
 ;D SELADM^YTQAPI14(.YSAD)
 ;Q:YSAD'>0
 ;K YS,YSDATA
 ;D NULLNOW
 ;S YS("AD")=YSAD D HL7^YTQHL7(.YSDATA,.YS)
 ;W !,"HL7 message created..."
 Q
SELADM(YSADIEN) ;select admin by pt and test
 ;N N,YSGIVEN,DIC,DFN,YSCODEN,YSDFN
 ;S YSADIEN=0
 ;D ^YSLRP Q:YSDFN'>0
 ;S DIC="^YTT(601.71,",DIC(0)="AEQ" D ^DIC Q:Y'>0
 ;S YSCODEN=+Y
 ;S YSGIVEN=0
 ;F  S YSGIVEN=$O(^PXRMINDX(601.84,"PI",YSDFN,YSCODEN,YSGIVEN)) Q:YSGIVEN'>0  D
 ;. S N=0 F  S N=$O(^PXRMINDX(601.84,"PI",DFN,YSCODEN,YSGIVEN,N)) Q:N'>0  D
 ;.. W !,N
 ;.. S Y=YSGIVEN D DD^%DT W ?15,Y
 ;S DIC="^YTT(601.84,",DIC(0)="AEQ" D ^DIC
 ;S YSADIEN=+Y
 Q
NOPNOTE ;entry point for YTQ PNOTE FLAG option
 N DIE,DIC,X,Y,DA,DR
 S DIC="^YTT(601.71,",DIC(0)="AEMQ" D ^DIC Q:Y'>0
 S DIE="^YTT(601.71,",DA=+Y,DR="28;29;30" D ^DIE
 Q
EXEMPT ;entry point for YTQ EXEMPT TEST option
 N DIE,DIC,X,Y,DA,DR
 W @IOF,!,"*** Exempt Test ***",!!
 W "Caution-- changing the exempt level of a published test may break copyright",!,"agreements. Changes to national tests are at the risk of the changing facility.",!!
 S DIC="^YTT(601.71,",DIC(0)="AEMQ" D ^DIC Q:Y'>0
 S DIE="^YTT(601.71,",DA=+Y,DR="8;9;27;18///NOW" D ^DIE
 Q
SIGNOK(YSDATA,YS) ;entry point for YTQ ASI SIGNOK rpc
 ;Input: IENS as iens for 604
 ;Output: 1^OK TO SIGN
 ;        0^MISSING REQUIRED FIELDS
 ;        2^A G12 RECORD
 N N1,YSASCLS,X,YSASFLD,YSF,YSN,YSFLAG,YSIEN,YSTYPE
 S YSFLAG=1
 S YSIEN=$G(YS("IENS"),-1)
 I '$D(^YSTX(604,YSIEN,0)) S YSDATA(1)="[ERROR]",YSDATA(2)="BAD IEN" Q
 S YSDATA(1)="[DATA]",YSDATA(2)="1^OK TO SIGN"
 S YSN=2
 S YSASCLS=$$GET1^DIQ(604,YSIEN_",",.04,"I")
 S YSASCLS=YSASCLS+3
 S N1=0 F  S N1=$O(^YSTX(604.66,N1)) Q:N1'>0  D:($P(^YSTX(604.66,N1,0),U,8)&($P(^YSTX(604.66,N1,0),U,YSASCLS)))
 . S YSASFLD=$P(^YSTX(604.66,N1,0),U,3)
 . D TYPE
 . S YSF=$S(YSASFLD>10.02&(YSASFLD<10.44):"I",YSTYPE=1:"",1:"I")
 . S X=$$GET1^DIQ(604,YSIEN,YSASFLD,YSF)
 . S:X="" YSFLAG=0,YSN=YSN+1,YSDATA(YSN)=^YSTX(604.66,N1,0)
 S X=$$GET1^DIQ(604,YSIEN,YSASFLD,.11)
 S:X="X"!(X="N") YSFLAG=2
 S:YSFLAG=0 YSDATA(2)="0^MISSING REQUIRED FIELDS"
 S:YSFLAG=2 YSDATA(2)="2^A G12 RECORD"
 Q
TYPE ;check field type
 ;O = NOT A POINTER 1 = POINTER
 N YSFLD
 S YSTYPE=0
 D FIELD^DID(604,YSASFLD,"","TYPE","YSFLD")
 S:YSFLD("TYPE")="POINTER" YSTYPE=1
 Q
SCOREIT(YSDATA,YS) ; from YTQAPI8
 N N,N2,N4,R,S,YSAA,I,II,DFN,YSCODE,YSADATE,YSSCALE,YSBED,YSEND
 K YSDATA,YSSONE
 D PARSE^YTAPI(.YS)
SCOR1 S (YSTEST,YSET)=$O(^YTT(601,"B",YSCODE,0))
 S YSED=YSADATE
 S YSDFN=DFN
 S YSSX=$P(^DPT(DFN,0),U,2)
 S YSTN=YSCODE
 IF '$D(^YTD(601.2,YSDFN,1,YSET,1,YSED)) S YSDATA(1)="[ERROR SCORE1+5]",YSDATA(2)="no administration found" Q
 D PRIV ;check it
 S YSR(0)=$G(^YTT(601.6,YSET,0))
 I $P(YSR(0),U,2)="Y" S X=^YTT(601.6,YSET,1) X X
 Q:$G(YSDATA(1))?1"[ERROR".E
 D SCORSET^YTAPI2
 D:YSPRIV SF^YTAPI2
 S N1=0
 F  S N1=$O(YSSONE(N1)) Q:N1'>0  S N=N+1,YSDATA(N)=YSSONE(N1)
 D CLEAN^YSMTI5 Q
PRIV ;check privileges
 N YS71,YSKEY
 S YSPRIV=0
 S YS71=$O(^YTT(601.71,"B",YSTN,0))
 Q:YS71'>0  ;-->out error
 S YSKEY=$$GET1^DIQ(601.71,YS71_",",9)
 I YSKEY="" S YSPRIV=1 Q  ;-->out exempt
 I $D(^XUSEC(YSKEY,DUZ)) S YSPRIV=1 Q  ;-->out has key
 Q
