DVBHT ;PKE/ISC-ALBANY; HINQ alert parser; 5/10/92 ; 3/9/06 4:18pm
 ;;4.0;HINQ;**12,18,20,56**;03/25/92
 ;
 ;call alert
ALERT I '$D(ZTQUEUED) H 1 W $C(7),".. Alert found."
 S (I,Y)=0,XQAMSG=""
 F  S Y=$O(DVBDATA(Y)) Q:'Y  DO
 .S $P(DVBDATA,"^",I+1)=Y
 .S XQAMSG=XQAMSG_$S(I:", ",1:"")_Y S I=I+1
 .K DVBDATA(Y)
 S XQAMSG="Screen"_$S(I>1:"s ",1:"  ")_XQAMSG
 ;
 D MAILGP^DVBHT2,REQUSR^DVBHT2
 I $D(XQA)'>9 S XQA(DUZ)=""
 S Y=DT D TM
 ;
 S XQAMSG=$E($P(^DPT(DFN,0),"^")_"        ",1,9)_" "_"("_$E(^(0))_$E($P(^(0),"^",9),6,10)_")"_$S('$L($E($P(^(0),"^",9),10)):":",1:"")_" HINQ Update . "_$E(XQAMSG_"                ",1,16)_$J(Y,8)
 I '$O(XQA(0))
 E  S XQAMSG=XQAMSG_" "_$E($P($P(^VA(200,$O(XQA(0)),0),"^"),","),1,10)
 ;
TST S XQAID="DVB,"_DFN
 S XQAROU="SETUP^DVBHT"
 ;S XQAFLG="R"
 S XQADATA=DFN_"^"_DVBDATA K DVBDATA
 ;
 D SETUP^XQALERT
 S $P(^DVB(395.5,DFN,0),"^",6)=1 Q  ;set alert SET
 ;
 ;entry action from alert
SETUP S DVBDATA=XQADATA K XQADATA,XQAKILL,DVBNOALR
 S Y=+$P(DVBDATA,"^") Q:'Y
 S DFN=Y,DVBDATA=$P(DVBDATA,"^",2,99)
 I '$D(^DVB(395.5,Y,0)) S XQAKILL=0 D KIL Q
 I '$P(^DVB(395.5,Y,0),"^",6) DO  D KIL Q
 .W !,?15," another request pending, alert cleared"
 .S XQAKILL=0
 I '$D(^XUSEC("DG ELIGIBILITY",DUZ)) DO  D KIL Q
 .S XQAKILL=1
 .D DISPLAY
 .D PAGE
 ;if no to hinq screens
 I $P(^DVB(395,1,0),"^",5)="n" DO  D END Q
 .S XQAKILL=0,DVBJ2=1
 .D TEM^DVBHIQR I $D(DVBERCS) K XQAKILL Q
 .D ACHK^DVBHT1
 .D DISPLAY
 .I $D(DVBNOALR) D PAGE,FILE^DVBHQUP Q
 .D ACKNOW
 .I $D(DVBNOALR) D FILE^DVBHQUP Q
 .K XQAKILL
 ;
 D A^DVBHUTIL W !
 K DVBDIQ
 ;
UPD L +^DPT(DFN):3 I $T DO
 .N XQAID
 .S DIE="^DPT(",(DA,DFN)=+Y,DR="[DVBHINQ UPDATE]",DVBJ2=0 D TEM^DVBHIQR
 .N DVBQT
 .I '$D(DVBERCS) D CHKID^DVBHQD1 I DVBQT D  Q
 .. N DVBTMP1,DVBTMP2
 .. S DVBTMP1=$G(DVBNOALR)
 .. S DVBTMP2=$G(DVBJ2)
 .. S DVBNOALR=";4///a;5////"_DUZ_";6///N",DVBJ2=1
 .. D FILE^DVBHQUP
 .. S DVBNOALR=DVBTMP1
 .. S DVBJ2=DVBTMP2
 .D ^DIE:'$D(DVBERCS) K DIE,DR,DA Q
 E  W !?3,"This patient data is being edited by another user" H 1 G END
 L -^DPT(DFN)
 ;
 I DVBJ2 DO  ;patient updated, alerts filed in up
 .W !!,"Checking the alerts ."
 .D ACHK^DVBHT1
 .I $D(DVBNOALR) DO
 . .S DVBNOALR=";4///c;5////"_DUZ_";6///N"
 . .W ". OK"
 .E  DO
 . .W ". need more changes"
 . .D DISPLAY
 . .D ACKNOW
 .H 1
 E  DO  ;patient not updated
 .I $D(DVBNOALR) DO  Q
 . .I DVBNOALR]"" D FILE^DVBHQUP
 . .;;;D DISPLAY
 .D ACHK^DVBHT1
 .D DISPLAY I $D(DVBNOALR) Q
 .D ACKNOW
 .I $D(DVBNOALR),DVBNOALR]"" D FILE^DVBHQUP
 ;
 K DVBDIQ D C^DVBHQUP
 ;
END S END="N DVBNOALR,XQAID D KILL^XUSCLEAN" X END
 I $D(DVBNOALR) S XQAKILL=0
KIL K DVBNOALR,DVBDATA,DFN,DVBJ2,DR,DVBDIQ,LP2,DIC,DIQ,DA,D0 Q
 ;
 ;display alert
DISPLAY Q:'$D(DVBDATA)  I '$L($P(DVBDATA,"^",11)) DO CMSG Q
INFO ;
 ;;Diagnostic Ver.Ind.: NO   Verify Service Connections at RO
 I '$D(DVBDIQ(2,DFN,.01,"E")) S DR=".01;.09" D DIQDR^DVBHT1
 S DVBALERT="LOAD/EDIT Screen"_$S(DVBDATA'["SC D":" 7",1:"s 7, 11")
 W !," ----------------------------------------------------------------------------"
 W !,"| ",DVBDIQ(2,DFN,.01,"E"),"  "
 W $E(DVBDIQ(2,DFN,.01,"E")),$E(DVBDIQ(2,DFN,.09,"E"),6,10)
 W ?39,DVBALERT,?69,"HINQ"
 W ?77,"|",!
 I $D(XQAKILL)
 F I=11:1 S DVBALERT=$P(DVBDATA,"^",I)_"'" Q:'DVBALERT  DO
 .W:$X<10 "|",?6
 .I $E(DVBALERT,2)="+" W "HINQ has data not in patient file `"
 .I $E(DVBALERT,2)="-" W "Patient file has data not in HINQ `"
 .I $E(DVBALERT,2)="?" W "HINQ, Patient file are different  `"
 .I $E(DVBALERT,2)="X" DO
 . .I $E(DVBALERT,3) W $P($T(INFO+$E(DVBALERT,3)),";;",2)
 . .S DVBALERT=$E(DVBALERT)
 .W $E(DVBALERT,3,$L(DVBALERT))
 .W ?66,"Screen (",$E(DVBALERT),")",?77,"|",!
 W " ----------------------------------------------------------------------------"
 K DVBALERT
 Q
ACKNOW K DIR S DIR("A")="Do you wish to acknowledge inconsistencies and clear this Alert ? "
 S DIR("B")="No"
 S DIR("?",1)="If the patient file has data that should not be updated by HINQ, this Alert"
 S DIR("?",2)="can be acknowledged and cleared by entering 'Y'es.  Otherwise, just continue"
 S DIR("?")="Press RETURN to continue,'Y'es to acknowledge, '^' to exit:"
 S DIR(0)="YAO" D ^DIR K DIR Q:'Y
 S DVBNOALR=";4///a;5////"_DUZ_";6///N"
 W !!?6,"   Alert will be cleared" H 1 Q
 ;
PAGE K DVBALERT S DIR(0)="E" D ^DIR K DIR Q
 ;
CMSG W !!,?20,"Alerts have been cleared",! Q
 ;
TM S Y=$E(Y,4,5)_"/"_$E(Y,6,7)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".") Q
