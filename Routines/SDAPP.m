SDAPP ;ALB/TMP - SCHEDULING  CHART REQUEST ; 07 SEP 84  4:17 pm
 ;;5.3;Scheduling;**21,32,41,79**;AUG 13, 1993
4 ;;Chart Request
 S:'$D(DTIME) DTIME=300 I '$D(DT) D DT^SDUTL
 S (DIC,DIE)="^SC(",DIC(0)="AQME",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))",DIC("A")="SELECT CLINIC NAME: " D ^DIC K DIC("A"),DIC("S") Q:+Y<0  S SDIN=$S($D(^SC(+Y,"I")):1,1:""),SDRE="" I SDIN S SDIN=+^("I"),SDRE=+$P(^("I"),"^",2)
 I SDIN,SDIN'>DT,'SDRE S D0=+Y D WRT1 Q
 S DA=+Y,DR=1906,DR(2,44.006)=".01;S Y=2 I $S('$D(^SC(D0,""I"")):0,+^(""I"")'>0:0,+^(""I"")>X:0,+$P(^(""I""),U,2)'>X&(+$P(^(""I""),U,2)'=0):0,1:1) K ^SC(D0,""C"",D1) S Y="""" D WRT1^SDAPP;2" G ^DIE
 Q
19 ;;Edit Clinic Enrollment Data
 ; SCRESTA = Array of pt's teams causing restricted consults
 N SCRESTA,SCABORT
 S DIC="^DPT(",DIC(0)="AEMQF" D ^DIC Q:"^"[X  G:Y<0 19
 S DFN=+Y
 S SCREST=$$RESTPT^SCAPMCU4(.DFN,DT,"SCRESTA")
 IF SCREST D  Q:$G(SCABORT)
 .N SCTM
 . W !,?5,"Patient has restricted consults due to the following team assignment(s):"
 .S SCTM=0
 .F  S SCTM=$O(SCRESTA(SCTM)) Q:'SCTM  W !,?10,SCRESTA(SCTM)
 .IF $D(^XUSEC("SC CONSULT",DUZ)) D
 ..W !!,?10,"Team Members will be notified of new enrollments"
 .ELSE  D
 ..W !!,?10,"You need the SC CONSULT key to do enrollments for this patient"
 ..S SCABORT=1
 D BEFORE^SCMCEV3(DFN)
 S DA=+Y,DIE=DIC,DR="3",DR(2,2.001)="1",DR(3,2.011)=".01;1;5;3;4" D ^DIE
 D AFTER^SCMCEV3(DFN)
 D INVOKE^SCMCEV3(DFN)
 G 19
20 ;;Additional Non-Vet Elig Status
 S DIC="^DPT(",DIC(0)="AEMQF" D ^DIC Q:"^"[X  G:Y'>0 20
 I $S('$D(^DPT(+Y,"VET")):1,^("VET")'="Y":1,1:0) W !,*7,"Patient must be a veteran!!" G 20
 S DIE=DIC,DA=+Y,DR=".099" D ^DIE K DIE,DIC,DR
 G 20
WRT1 S SDY=Y,SDI=+^SC(D0,"I"),SDI1=+$P(^("I"),U,2) W *7,!,"Clinic is inactive ",$S(SDI1'=0:"from ",1:"as of ") S Y=SDI D DTS^SDUTL W Y S Y=SDI1 D:Y DTS^SDUTL W $S(SDI1=0:"",1:" to "_Y) S Y=SDY K SDY,SDI,SDI1 Q
