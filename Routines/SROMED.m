SROMED ;BIR/MAM - ENTER/EDIT MEDICATIONS ;01/30/08
 ;;3.0; Surgery ;**21,44,79,100,151,166**;24 Jun 93;Build 6
 ;
 I '$D(^XUSEC("SROEDIT",DUZ))&'$D(^XUSEC("SROANES",DUZ)) W !!!,$C(7),"You must hold the SROEDIT key or the SROANES key to use this option !",! Q
 D ^SROLOCK G:SROLOCK END Q:'$D(SRTN)
 N SRLCK S SRLCK=$$LOCK^SROUTL(SRTN) I 'SRLCK G END
START S SRQ=0,SRSMED=1 G:SRTN<1 END W @IOF S SRF=0 R !!,"ENTER MEDICATION/DOSE(MG)/ROUTE/TIME: ",M:DTIME S:'$T M="^" G:M=""!(M="^") END S SRM=$P(M,"/",1),SRD=$P(M,"/",2),SRR=$P(M,"/",3),SRT=$P(M,"/",4) W !!
 I M="?" W !!,"Enter the medication, dose, route and time, separated by slashes (/).",!,"The Medication and time MUST be included, however the route and dose",!,"can be omitted.  i.e. 'MEDICATION/DOSE//TIME' will omit the route."
 I M="?" W !!,"Enter '??' to get a list of available drugs.",! D RET G:SRQ END G START
 I M?.E1C.E W !!,"Your answer has a control character in it, please re-type it.",! D RET G:SRQ END G START
 S (X,SRMM)=SRM D
 .N SRDIC,SRD S SRDIC=50,SRDIC(0)="EMQSZ",SRD="B^C" D MIX^PSSDI(50,"SR",.SRDIC,SRD,X,,DT)
 S SRM=$S(Y<0:"",1:$P(Y,"^",2))
 I SRM="",SRMM'["?" W !!,"The Drug '",SRMM,"' does not exist in your Drug file.  Please re-enter. " D RET G:SRQ END G START
 I SRMM="??" D RET G:SRQ END G START
 D TIME G:'$D(SRT) FLAG S X=SRT D FIELD^DID(130,.204,"","INPUT TRANSFORM","SRX") S SRX=SRX("INPUT TRANSFORM") X:SRT'="" SRX S SRT=$S(X="":SRT,1:X) D ROUTE G:'$D(SRR) FLAG D DOSE G:'$D(SRD) FLAG
FLAG S SRF=$S('$D(SRT)!('$D(SRD))!('$D(SRR)):0,1:1) I 'SRF W !!!,"NO ACTION TAKEN",! H 2 G END
DIE S DA=SRTN,DIE=130,DR=".375///"_SRM,DR(2,130.33)="1///"_SRT,DR(3,130.34)="1///"_SRD_";4///"_SRR D ^DIE W !!!,"MEDICATION ENTERED ...." K DR H 2
 G START
END W @IOF D ^SRSKILL D:$G(SRLCK) UNLOCK^SROUTL(SRTN)
 Q
RET R !!,"Press RETURN to Continue.   ",Z:DTIME S:'$T Z="^" S:Z="^" SRQ=1 Q
 Q
ROUTE ; check for route of administration
 Q:SRR=""  N SRHELP,SRVALUE D CHK^DIE(130.34,4,"E",SRR,.SRVALUE) I SRVALUE'="^" S SRR=SRVALUE Q
 D HELP^DIE(130.34,"",4,"S","SRHELP(1)")
 W !!,"Route entered is not one of the available choices.",!,"Please enter medication route again.",!!
 I $G(SRHELP(1,"DIHELP")) F I=1:1:SRHELP(1,"DIHELP") W SRHELP(1,"DIHELP",I),!
 S DIR("A")="Enter ROUTE",DIR(0)="130.34,4O" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRR="" Q
 S SRR=$P(Y,"^")
 Q
TIME ; check for time
 K %DT S X=SRT,%DT="R" D ^%DT I Y>0 Q
  W:SRT="" !!,"A time MUST be entered !"
 I '(SRT?1N!(SRT?2N&(SRT<13))!(SRT?4N)!(SRT?3N)!(SRT?2N1":"2N)!(SRT?1N1":"2N))!(+SRT>2400)!(SRT="") S SRF=1
 I SRF W !!,?5,"Enter the time in one of the following formats:",!,?9,"7:45, 0745, 745, 07:45, Date@Time, or NOW",!!,?5,"Time is required."
T1 S:SRT="" SRF=1 Q:SRF=0  R !!,"Enter Time: ",SRT:DTIME S:'$T!(SRT="") SRT="^" G:SRT["^" END W:SRT["?" !!,"Enter a time in the format above, or RETURN to bypass.  An '^' will exit this option." G:SRT["?" T1 S SRF=0 G TIME
 Q
DOSE ; check dosage
 Q:SRD=""  I $L(SRD)>15!($L(SRD)<1) W !!,"Dosage entered incorrectly." S SRF=1
 I SRD="?" W !!,"Dosage must be 1 to 15 characters in length, i.e. 15 mg." S SRF=1
D1 I SRF=1 R !!,"ENTER DOSE: ",SRD1:DTIME S:'$T SRD1="^" K:SRD1["^" SRD Q:SRD1["^"  W:SRD1["?" !!,"Dosage must be 1 to 15 characters in length" G:SRD1["?" D1 S SRD=SRD1,SRF=0 G DOSE
 Q
SCR(SRFL,SRPK) ; screening for fields point to the DRUG file (#50)
 N SRDT,SRN0,SRNODE,SROK,SRY S SROK=0,SRY=+Y K ^TMP($J,"SR")
 I $G(SRFL)=1 S SRTN=$S($G(SRTN):SRTN,1:DA),SRN0=$G(^SRF(SRTN,0)),SRDT=$S($P(SRN0,"^",9):$P($P(SRN0,"^",9),"."),1:DT)
 D DATA^PSS50(SRY,,$S($G(SRFL):SRDT,1:""),,,"SR")
 I SRPK="S" D  Q SROK
 .S SRNODE=$P($G(^TMP($J,"SR",SRY,63)),"^") K ^TMP($J,"SR") I SRNODE["S" S SROK=1
 S SROK=$S($P($G(^TMP($J,"SR",0)),"^")=-1:0,1:1) K ^TMP($J,"SR") Q SROK
