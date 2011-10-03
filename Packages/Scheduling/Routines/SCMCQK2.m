SCMCQK2 ;ALB/REW - Single Pt Tm/Pt Tm Pos Assign and Discharge ; 07 Oct 2002  12:10 PM
 ;;5.3;Scheduling;**297**;AUG 13, 1993
 ;
DSPL ;
 N LP,SCD,SCPOS
 S SCTOK=$$TMPT^SCAPMC3(DFN,"SCDT","","SCD","SCER1")
 S SCOK=$$TPPT^SCAPMC(DFN,"","","","","","","SCPOS","SCBKERR")
  ;
  ;loop through positions only getting the ones associated with the team
  ;and that are active.
  ;
  F LP=0:0 S LP=$O(SCPOS(LP)) Q:'LP  D
  .I $P(SCPOS(LP),U,6)]"" K SCPOS(LP) Q
  .S SCPOS("T",$P(SCPOS(LP),U,3),+SCPOS(LP))=SCPOS(LP)
 S CNT=0,POS=0
 F LP=0:0 S LP=$O(SCD(LP)) Q:'LP  S A=SCD(LP) I '$P(A,U,8) D
 .I 'CNT W !!,"NON PC ASSIGNMENTS",!
 .S CNT=CNT+1 W !,CNT,?4,"Non-PC Team: "_$P(A,U,2),?48,"Phone: "_$P($G(^SCTM(404.51,+A,0)),U,2) S DATA(CNT)=+A
 .F I=0:0 S I=$O(SCPOS("T",+A,I)) Q:'I  D
 ..I $P(DATA(CNT),U,2) S CNT=CNT+1
 ..S B=SCPOS("T",+A,I)
 ..S DATA(CNT)=(+A)_U_(+B),POS=1
 ..S SCPR=$$GETPRTP^SCAPMCU2(+B,DT),RES=$$NEWPERSN^SCMCGU(+SCPR,"SCPR")
 ..W:$X>76 !,CNT,?4,"Non-PC Team: "_$P(A,U,2),?48,"Phone: "_$P($G(^SCTM(404.51,+A,0)),U,2)
 ..W !,?7,"Provider: "_$P(SCPR,U,2),?45,"Position: "_$P(B,U,2)_"       "
 ..W !,?10,"Pager: "_$P($G(SCPR(+SCPR)),U,5),?48,"Phone: ",$P($G(SCPR(+SCPR)),U,2),?77," "
 I 'CNT W !,"No active NON PC ASSIGNMENTS for this patient",!
 Q
NPC N SCDT,SCER1,SCD,SCPOS
 D DSPL
 S DIR(0)="SO^0:NONE;1:TEAM ASSIGNMENT;"_$S(CNT:"2:POSITION ASSIGNMENT;3:UNASSIGNMENT;",1:"")
 S DIR("B")=1
 D ^DIR
 I Y=0 Q
 I Y=U Q
 I Y=1 D ASTM G NPC
READ S:CNT=1 X=1 I CNT>1 W !,"Select 1-"_CNT_": " R X:DTIME  Q:X=U  S X=+X I X>CNT!X<1 G READ
 I Y=3 S DATA=DATA(+X) S SCTPSTAT=1,SCTP=+$P(DATA,U,2),SCTM=+DATA D UNTP:SCTP,UNTM:'SCTP G NPC
 S DATA=DATA(+X),SCTM=+DATA S SCSELECT=$$SELPOS() G NPC:'$L(SCSELECT) D ASTP G NPC
 Q
UNTP ;unassign patient from position
 IF '$G(SCTP) W !,"No position defined" Q
 N OK,SCER,SCCL,SCBEGIN,SCN,SCLIST,SCEND,SCINCL,SCLSEQ,SCDATES,SCDTS
 S OK=0
 W !,"About to Unassign "_$$NAME(DFN)_" from: ",!,?8,$$POSITION(SCTP)_" position   ["_$P($$GETPRTP^SCAPMCU2(SCTP,DT),U,2)_"]"
 S SCDISCH=$$DATE("D")
 G:SCDISCH<1 QTUNTP
 G:'$$CONFIRM() QTUNTP
 S OK=$$INPTSCTP^SCAPMC22(DFN,SCTP,SCDISCH,.SCER)
 G:OK'>0 QTUNTP
 S SCCL=$P($G(^SCTM(404.57,+$G(SCTP),0)),U,9)
QTUNTP W !,"Position Unassignment "_$S(OK:"made.",1:"NOT made.")
 Q
 ;
 ;
UNTM ;
 ;assign patient from non pc team (and pc position if possible)
 N OK,SCER,SCBEGIN,SCN,SCLIST,SCEND,SCINCL,SCLSEQ,SCDATES,SCDTS,OK2,OK3
 S OK=0
 W !!,"About to Unassign "_$$NAME(DFN)_" from "_$$TEAMNM(SCTM)_" team"
 W:'SCTPSTAT !,?5,"AND from "_$$POSITION(SCTP)_" position  ["_$$WRITETP^SCMCDD1(SCTP)_"]"
 S SCDISCH=$$DATE("D")
 G:SCDISCH<1 QTUNTM
 G:'$$CONFIRM() QTUNTM
 IF 'SCTPSTAT D  G:OK2'>0 QTUNTM
 .W !,"Unassigned."
 .S OK2=$$INPTSCTP^SCAPMC22(DFN,SCTP,SCDISCH,.SCER)
 .IF OK2>0 D
 ..W "made."
 ..S SCCL=$P(^SCTM(404.57,SCTP,0),U,9)
 S OK3=$$ALLPOS^SCMCQK1()
 IF $$OKINPTTM^SCMCTMU2(DFN,SCTM,SCDISCH) D
 .S OK=$$INPTSCTM^SCAPMC7(DFN,SCTM,SCDISCH,.SCER)
 ELSE  D
 . W !,"Future/Current Patient-Position Assignment exists"
QTUNTM W !,"Team Unassignment "_$S(OK:"made",1:"NOT made.")
 Q
 ;
ASTM ;assign patient to team
 N DIC,Y,OK,SCTM,SCTMFLDS,SCER,SCBEGIN,SCN,SCLIST,SCEND,SCINCL,SCLSEQ,SCDATES,SCDTS
 S OK=0
 W !!,"About to Assign "_$$NAME(DFN)_" to a non primary care team"
 I $$SC^SCMCQK1(DFN) W !!,"********** This patient is 50 percent or greater service-connected ************"
 S DIC="^SCTM(404.51,"
 S DIC(0)="AEMQZ"
 S DIC("S")="IF $$ACTTM^SCMCTMU(Y,DT) I $$NEW^SCMCQK2()"
 ;  - select from active teams that can not be PC Teams
 D ^DIC
 G:Y<1 QTASTM
 S SCTM=+Y
 S SCASSDT=$$DATE("A")
 G:SCASSDT<1 QTASTM
 S SCTMCT=$$TEAMCNT^SCAPMCU1(SCTM)
 S SCTMMAX=$P($$GETEAM^SCAPMCU3(SCTM),"^",8)
 I SCTMCT'<SCTMMAX  D  G QTASTM:'$$YESNO2()
 .W !,"This assignment will reach or exceeded the maximum set for this team."
 .W !,"Currently assigned: "_SCTMCT
 .W !,"Maximum set for team: "_SCTMMAX
 I SCTMCT<SCTMMAX,'$$CONFIRM() G QTASTM
 S SCTM=+Y
 ;setup fields
 ;S SCTMFLDS(.08)=1 ;primary care assignment
 S SCTMFLDS(.11)=$G(DUZ,.5)
 D NOW^%DTC S SCTMFLDS(.12)=%
 IF $$ACPTTM^SCAPMC(DFN,SCTM,"SCTMFLDS",SCASSDT,"SCTPTME") D
 .S SCSELECT=$$SELPOS()
 .D:$L(SCSELECT) ASTP ;prompt for position prompt
 .S OK=1
QTASTM W !,"Team Assignment "_$S(OK:"made",1:"NOT made.")
 Q
ASTP ;assign patient to practitioner
 N DIC,Y,OK,SCCL,X,SCTPFLDS,SCER,SCBEGIN,SCN,SCLIST,SCEND,SCINCL,SCLSEQ,SCDATES,SCDTS
 S OK=0
 W !!,"About to Assign "_$$NAME(DFN)_" to non PC Position Assignment"
 I $$SC^SCMCQK1(DFN) W !!,"********** This patient is 50 percent or greater service-connected ************"
 ;lookup to display only position and [practitioner]
 IF SCSELECT="PRACT" D
 .S DIC("W")="N SCP1 S SCP1=$G(^SCTM(404.52,Y,0)) W ""    ["",$P($G(^VA(200,+$P(SCP1,U,3),0)),U,1),""]"""
 .S DIC("A")="POSITION's Current PRACTITIONER: "
 .S DIC="^SCTM(404.52,"
 .;Must be from team, must be active,must not have future inactivation
 .S DIC("S")="I $$PRACSCR^SCMCQK2(Y)"
 .S D="C"
 ELSE  D
 .S DIC="^SCTM(404.57,"
 .S D="B"
 .S DIC("A")="POSITION's Name: "
 .S DIC("S")="I $$POSSCR^SCMCQK2(Y)"
 S DIC(0)="AEMQZ"
 D MIX^DIC1
 G:Y<1 QTASTP
 IF SCSELECT="PRACT" D
 .S SCTP=$P(Y,U,2)
 ELSE  D
 .S SCTP=$P(Y,U,1)
 S SCASSDT=$$DATE("A")
 G:SCASSDT<1 QTASTP
 S SCTMCT=$$PCPOSCNT^SCAPMCU1(SCTP),SCTMMAX=+$P($G(^SCTM(404.57,SCTP,0)),U,8)
 I SCTMCT'<SCTMMAX D  G QTASTP:'$$YESNO2
 .W !,"This assignment will reach or exceeded the maximum set for this position."
 .W !,"Currently assigned: "_SCTMCT
 .W !,"Maximum set for position: "_SCTMMAX
 G:'$$CONFIRM() QTASTP
 ;setup fields
 S SCTPFLDS(.03)=SCASSDT
 ;S SCTPFLDS(.05)=1 ;pc pract role
 S SCTPFLDS(.06)=$G(DUZ,.5)
 D NOW^%DTC S SCTPFLDS(.07)=%
 IF $$ACPTTP^SCAPMC21(DFN,SCTP,"SCTPFLDS",SCASSDT,"SCTPTME",0) D
 .S OK=1
 .S SCCL=$P(^SCTM(404.57,SCTP,0),U,9)
QTASTP W !,"Position Assignment "_$S(OK:"made",1:"NOT made.")
 Q
NAME(DFN) ;return patient name
 Q $P($G(^DPT(DFN,0)),U,1)
 ;
POSITION(SCTP) ;return position name
 Q $P($G(^SCTM(404.57,SCTP,0)),U,1)
 ;
TEAMNM(SCTM) ;return team name
 Q $P($G(^SCTM(404.51,SCTM,0)),U,1)
 ;
CLINIC(SCCL) ;return clinic name
 Q $P($G(^SC(+SCCL,0)),U,1)
 ;
YESNO() ;
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR
 Q Y>0
 ;
YESNO2() ;
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to continue with the assignment (Yes/No)?"
 D ^DIR
 Q Y>0
CONFIRM() ;confirmation call
 N DIR,X,Y
 S DIR("A")="Are you sure (Yes/No)"
 S DIR(0)="Y"
 D ^DIR
 Q +Y=1
 ;
SELPOS() ;return way to select position: 1=PRACT,2=POSIT,3=NONE
 N DIR,X,Y
 W !,"Choose way to select NON PC POSITION Assignment: "
 S DIR(0)="SO^0:NONE;1:BY PRACTITIONER ASSIGNMENT;2:BY POSITION ASSIGNMENT"
 S DIR("B")=1
 D ^DIR
 Q $S(Y'>0:"",+Y=1:"PRACT",1:"POSIT")
 ;
DATE(TYPE) ;return date type=A or D
 N DIR,X,Y
 S DIR("A")=$S(TYPE="A":"Assignment",1:"Unassignment")_" date: "
 S DIR(0)="DA^::EXP"
 S Y=$S($D(SCDISCH):SCDISCH,$D(SCASSDT):SCASSDT,(TYPE="A"):"TODAY",1:"TODAY-1")
 X ^DD("DD")
 S DIR("B")=Y
 D ^DIR
 Q Y
 ;
PRACSCR(SC40452) ;screen for for file 404.52
 N SCP,SCNODE,OK
 S SCP=$G(^SCTM(404.52,SC40452,0))
 S OK=0
 G:'SCP QTPP
 S SCNODE=$G(^SCTM(404.57,+SCP,0))
 S OK=$S($P(SCNODE,U,2)'=SCTM:0,$P(SCNODE,U,4):0,($O(^SCTM(404.52,"AIDT",+SCP,1,""))'=-$P(SCP,U,2)):0,($O(^SCTM(404.52,"AIDT",+SCP,0,-$P(SCP,U,2)),-1)):0,($$ACTTP^SCMCTPU(+SCP)>0):1,1:0)
QTPP Q OK
 ;
POSSCR(SCTP) ;screen for file 404.57
 N SCNODE
 S SCNODE=$G(^SCTM(404.57,SCTP,0))
 Q $S($P(SCNODE,U,2)'=SCTM:0,$P(SCNODE,U,4):0,($$ACTTP^SCMCTPU(SCTP)>0):1,1:0)
 Q
NEW() ;
 F I=0:0 S I=$O(SCD(I)) Q:'I  I (+SCD(I))=(+Y) Q
 Q 'I
