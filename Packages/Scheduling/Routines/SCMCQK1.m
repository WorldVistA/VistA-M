SCMCQK1 ;ALBOI/REW - Single Pt Tm/Pt Tm Pos Assign and Discharge;11/07/02
 ;;5.3;Scheduling;**148,177,231,264,436,297,446,524,535**;AUG 13, 1993;Build 3
 ;
 ;04/25/2006 SD*5.3*446 INTER-FACILITY TRANSFER
UNTP ;unassign patient from pc prac position
 I '$G(SCTP) W !,"No position defined" Q
 N OK,SCER,SCCL,SCBEGIN,SCN,SCLIST,SCEND,SCINCL,SCLSEQ,SCDATES,SCDTS
 S OK=0
 W !,"About to Unassign "_$$NAME(DFN)_" from: ",!,?8,$$POSITION(SCTP)_" position   ["_$P($$GETPRTP^SCAPMCU2(SCTP,DT),U,2)_"]"
 S SCDISCH=$$DATE("D")
 G:SCDISCH<1 QTUNTP
 G:'$$CONFIRM() QTUNTP
 S OK=$$INPTSCTP^SCAPMC22(DFN,SCTP,SCDISCH,.SCER)  ; og/sd/524
 G:OK'>0 QTUNTP
 ;comment out following lines in SD*5.3*535 - clinic enrollment no longer used
 ;S SCCL=$P($G(^SCTM(404.57,+$G(SCTP),0)),U,9)
 ;I SCCL D DISCL
QTUNTP W !,"Position Unassignment "_$S(OK:"made.",1:"NOT made.")
 Q
ENRCL ; no longer used with SD*5.3*535
 Q
 N SCRESTA,SCREST,SCCLNM,SCTM
 N SCCL
 F SCCL=0:0 S SCCL=$O(^SCTM(404.57,+$G(SCTP),5,SCCL)) Q:'SCCL  D
 .Q:$$ACTCL(DFN,SCCL)
 .W !!!,"The "_$$POSITION(SCTP)_" is associated with the ",$$CLINIC(SCCL)_" clinic."
 .;SCRESTA = Array of pt's teams causing restricted consults
 .N SCRESTA
 .S SCREST=$$RESTPT^SCAPMCU4(DFN,DT,"SCRESTA")
 .I SCREST D
 ..N SCTM
 ..S SCCLNM=Y
 ..W !,?5,"Patient has restricted consults due to team assignment(s):"
 ..S SCTM=0
 ..F  S SCTM=$O(SCRESTA(SCTM)) Q:'SCTM  W !,?10,SCRESTA(SCTM)
 .I SCREST&'$G(SCOKCONS) D  G QTECL
 ..W !,?5,"This patient may only be enrolled in clinics via"
 ..W !,?15,"Edit Clinic Enrollment Data option"
 .W !,"Do you wish to enroll the patient from this clinic on "
 .S Y=SCASSDT X ^DD("DD") W Y,"?"
 .I $$YESNO() D
 ..W !,"Clinic Enrollment"
 ..I $$ACPTCL^SCAPMC18(DFN,SCCL,,SCASSDT,"SCENER") W " made"
 ..E  W "NOT made "
QTECL Q
DISCL ; no longer used with SD*5.3*535
 Q
 N SCCL F SCCL=0:0 S SCCL=$O(^SCTM(404.57,+$G(SCTP),5,SCCL)) Q:'SCCL  D
 .Q:'$$ACTCL(DFN,SCCL)
 .W !,$$NAME(DFN)," is enrolled in the associated "_$$CLINIC(SCCL)_" clinic."
 .W !,"Do you wish to discharge the patient from this clinic on "
 .S Y=SCDISCH X ^DD("DD") W Y,"?"
 .Q:'$$YESNO()
 .N SDFN,SDCLN S SDFN=DFN,SDCLN=SCCL
 .N DFN D ^SDCD
QTDCL Q
UNTM ;
 ;assign patient from pc team (and pc position if possible)
 N OK,SCER,SCBEGIN,SCN,SCLIST,SCEND,SCINCL,SCLSEQ,SCDATES,SCDTS,OK2,OK3
 S OK=0
 W !!,"About to Unassign "_$$NAME(DFN)_" from "_$$TEAMNM(SCTM)_" team"
 W:'SCTPSTAT !,?5,"AND from "_$$POSITION(SCTP)_" position  ["_$$WRITETP^SCMCDD1(SCTP)_"]"
 S SCDISCH=$$DATE("D")
 G:SCDISCH<1 QTUNTM
 G:'$$CONFIRM() QTUNTM
 IF 'SCTPSTAT D  G:OK2'>0 QTUNTM
 .W !,"PC assignment unassigned."
 .S OK2=$$INPTSCTP^SCAPMC22(DFN,SCTP,SCDISCH,.SCER)
 .IF OK2>0 D
 ..W "made."
 ..S SCCL=$P(^SCTM(404.57,SCTP,0),U,9)
 ..;D:SCCL DISCL ;commented out in SD*5.3*535
 S OK3=$$ALLPOS()
 IF $$OKINPTTM^SCMCTMU2(DFN,SCTM,SCDISCH) D
 .S OK=$$INPTSCTM^SCAPMC7(DFN,SCTM,SCDISCH,.SCER)
 ELSE  D
 .W !,"Future/Current Patient-Position Assignment exists"
QTUNTM W !,"Team Unassignment "_$S(OK:"made",1:"NOT made.")
 Q
ALLPOS() ;unassign all patient-positions for team
 ;not stand-alone - needs dfn,sctm
 ;return 1=No positions left assigned|0=At least 1 position assigned
 N OK,SCDT1,SCPTTPX,SCERRR,SCTP,SCCNT,SCPTTPI,SCLOC,SCNODE,SCPTTP2
 S SCDT1("BEGIN")=SCDISCH+1
 S SCDT1("END")=3990101
 S SCDT1("INCL")=0  ;anytime from now to future
 S OK=$$TPPT^SCAPMC23(DFN,"SCDT1",,,,,,"SCPTTPX",.SCERRR)
 S (SCTP,SCCNT)=0
 W !,"Checking for other position assignments to team..."
 F  S SCTP=$O(SCPTTPX("SCTP",SCTM,SCTP)) Q:'SCTP  S SCCNT=SCCNT+1 D
 .S SCPTTPI=$O(SCPTTPX("SCTP",SCTM,SCTP,9999999),-1)
 .S SCLOC=$O(SCPTTPX("SCTP",SCTM,SCTP,SCPTTPI,0))
 .S SCNODE=SCPTTPX(SCLOC)
 .S SCPTTP2(SCTP)=""
 .W !,?3,$P(SCNODE,U,2),"   ",$P(SCNODE,U,8)
 .IF $P(SCNODE,U,6)!(SCDISCH'>$P(SCNODE,U,5)) D
 ..W !,?5,"Unassignment date already exists or unassignment after assignment date"
 ..W !,?15,"- Correct via PCMM GUI"
 ..S OK=0
 W !,?5,$S(SCCNT:SCCNT,1:"No")_" current/future position assignment(s)"
 G:'OK!('SCCNT) QTALL
 W !!,"About to unassign the above patient-position assignments"
 IF '$$CONFIRM S OK=0 G QTALL
 S SCTP=0
 F  S SCTP=$O(SCPTTP2(SCTP)) Q:'SCTP  D  Q:'OK
 .S OK=$$INPTSCTP^SCAPMC22(DFN,SCTP,SCDISCH,.SCER)
 .W:'OK !,?10,"Problem with unassignment, correct via PCMM GUI"
QTALL Q OK
ASTM ;assign patient to PC team
 N DIC,Y,OK,SCTM,SCTMFLDS,SCER,SCBEGIN,SCN,SCLIST,SCEND,SCINCL,SCLSEQ,SCDATES,SCDTS
 S OK=0
 W !!,"About to Assign "_$$NAME(DFN)_" to a primary care team"
 I $$SC(DFN) W !!,"********** This patient is 50 percent or greater service-connected ************"
 S DIC="^SCTM(404.51,"
 S DIC(0)="AEMQZ"
 S DIC("S")="IF $$ACTTM^SCMCTMU(Y,DT)&($P($G(^SCTM(404.51,Y,0)),U,5))"
 ;select from active teams that can be PC Teams
 D ^DIC
 G:Y<1 QTASTM
 S SCTM=+Y
 ;The following logic to present warning message added per SD*5.3*436
 I $P($G(^SCTM(404.51,SCTM,0)),U,10) D  G:'SCFLAG QTASTM
 .S SCFLAG=0
 .W !!,"This team is closed to further patient assignments.  While you are"
 .W !,"not currently prevented from assigning this patient, you may want to"
 .W !,"check before continuing."
 .Q:'$$YESNO1()  ; new function call per SD*5.3*436
 .Q:'$$CONFIRM()
 .S SCFLAG=1 W !
 S SCASSDT=$$DATE("A")
 G:SCASSDT<1 QTASTM
 S SCTMCT=$$TEAMCNT^SCAPMCU1(SCTM)
 S SCTMMAX=$P($$GETEAM^SCAPMCU3(SCTM),"^",8)
 I SCTMCT'<SCTMMAX  D  G QTASTM:$$WAITYN(),QTASTM:'$$YESNO2()
 .W !,"This assignment will reach or exceeded the maximum set for this team."
 .W !,"Currently assigned: "_SCTMCT
 .W !,"Maximum set for team: "_SCTMMAX
 I SCTMCT<SCTMMAX,'$$CONFIRM() G QTASTM
 S SCTM=+Y
 ;setup fields
 S SCTMFLDS(.08)=1 ;primary care assignment
 S SCTMFLDS(.11)=$G(DUZ,.5)
 D NOW^%DTC S SCTMFLDS(.12)=%
 IF $$ACPTTM^SCAPMC(DFN,SCTM,"SCTMFLDS",SCASSDT,"SCTPTME") D
 .S SCSELECT=$$SELPOS()
 .D:$L(SCSELECT) ASTP ;prompt for position prompt
 .S OK=1
QTASTM W !,"Team Assignment "_$S(OK:"made",1:"NOT made.")
 S:$D(SDWLPCMM) SDWLPCMM=OK  ; 446
 Q
ASTP ;assign patient to PC practitioner
 N DIC,Y,OK,SCCL,X,SCTPFLDS,SCER,SCBEGIN,SCN,SCLIST,SCEND,SCINCL,SCLSEQ,SCDATES,SCDTS
 S OK=0
 W !!,"About to Assign "_$$NAME(DFN)_" to PC Position Assignment"
 I $$SC(DFN) W !!,"********** This patient is 50 percent or greater service-connected ************"
 ;lookup to display only position and [practitioner]
 IF SCSELECT="PRACT" D
 .S DIC("W")="N SCP1 S SCP1=$G(^SCTM(404.52,Y,0)) W ""    ["",$P($G(^VA(200,+$P(SCP1,U,3),0)),U,1),""]"""
 .S DIC("A")="POSITION's Current PRACTITIONER: "
 .S DIC="^SCTM(404.52,"
 .;Must be from team, must be activation,must not have future inactivation
 .S DIC("S")="I $$PRACSCR^SCMCQK1(Y)"
 .S D="C"
 ELSE  D
 .S DIC="^SCTM(404.57,"
 .S D="B"
 .S DIC("A")="POSITION's Name: "
 .S DIC("S")="I $$POSSCR^SCMCQK1(Y)"
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
 I SCTMCT'<SCTMMAX D  G QTASTP:$$WAITYN,QTASTP:'$$YESNO2
 .W !,"This assignment will reach or exceeded the maximum set for this position."
 .W !,"Currently assigned: "_SCTMCT
 .W !,"Maximum set for position: "_SCTMMAX
 G:'$$CONFIRM() QTASTP
 ;setup fields
 S SCTPFLDS(.03)=SCASSDT
 S SCTPFLDS(.05)=1 ;pc pract role
 S SCTPFLDS(.06)=$G(DUZ,.5)
 D NOW^%DTC S SCTPFLDS(.07)=%
 IF $$ACPTTP^SCAPMC21(DFN,SCTP,"SCTPFLDS",SCASSDT,"SCTPTME",0) D
 .S OK=1
 .S SCCL=$O(^SCTM(404.57,+$G(SCTP),5,0))
 .D:SCCL ENRCL
QTASTP W !,"Position Assignment "_$S(OK:"made",1:"NOT made.")
 S:$D(SDWLPCMM) SDWLPCMM=OK ;446
 Q
NAME(DFN) ;return patient name
 Q $P($G(^DPT(DFN,0)),U,1)
POSITION(SCTP) ;return position name
 Q $P($G(^SCTM(404.57,SCTP,0)),U,1)
TEAMNM(SCTM) ;return team name
 Q $P($G(^SCTM(404.51,SCTM,0)),U,1)
CLINIC(SCCL) ;return clinic name
 Q $P($G(^SC(+SCCL,0)),U,1)
YESNO() ;
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR
 Q Y>0
YESNO1() ; added per SD*5.3*436
 N DIR,X,Y
 S DIR(0)="Y",DIR("A")="Do you wish to assign this patient now (Yes/No)?"
 S DIR("B")="NO"
 D ^DIR
 Q Y>0
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
SELPOS() ;return way to select position: 1=PRACT,2=POSIT,3=NONE
 N DIR,X,Y
 W !,"Choose way to select PC POSITION Assignment: "
 S DIR(0)="SO^0:NONE;1:BY PRACTITIONER ASSIGNMENT;2:BY POSITION ASSIGNMENT"
 S DIR("B")=1
 D ^DIR
 Q $S(Y'>0:"",+Y=1:"PRACT",1:"POSIT")
DATE(TYPE) ;return date type=A or D
 N DIR,X,Y
 S DIR("A")=$S(TYPE="A":"Assignment",1:"Unassignment")_" date: "
 S DIR(0)="DA^::EXP"
 S Y=$S($D(SCDISCH):SCDISCH,$D(SCASSDT):SCASSDT,(TYPE="A"):"TODAY",1:"TODAY-1")
 X ^DD("DD")
 S DIR("B")=Y
 D ^DIR
 Q Y
ACTCL(DFN,SCCL) ;is patient enrolled in clinic? - not called with SD*5.3*535
 Q
 N SCXX
 S SCXX=$O(^DPT(DFN,"DE","B",SCCL,9999),-1)
 Q $S('SCXX:0,($P(^DPT(DFN,"DE",+SCXX,0),U,2)="I"):0,1:1)
PRACSCR(SC40452) ;screen for for file 404.52
 N SCP,SCNODE,OK
 S SCP=$G(^SCTM(404.52,SC40452,0))
 S OK=0
 G:'SCP QTPP
 S SCNODE=$G(^SCTM(404.57,+SCP,0))
 S OK=$S($P(SCNODE,U,2)'=SCTM:0,'$P(SCNODE,U,4):0,($O(^SCTM(404.52,"AIDT",+SCP,1,""))'=-$P(SCP,U,2)):0,($O(^SCTM(404.52,"AIDT",+SCP,0,-$P(SCP,U,2)),-1)):0,($$ACTTP^SCMCTPU(+SCP)>0):1,1:0)
QTPP Q OK
POSSCR(SCTP) ;screen for file 404.57
 N SCNODE
 S SCNODE=$G(^SCTM(404.57,SCTP,0))
 Q $S($P(SCNODE,U,2)'=SCTM:0,'$P(SCNODE,U,4):0,($$ACTTP^SCMCTPU(SCTP)>0):1,1:0)
 Q
WAITYN() ;
 N %,OK,Y
 I SCTMCT<SCTMMAX Q 0
 N A,SC S A=$$ONWAIT^SCMCWAIT(DFN) I A W:(+A=3) !,$P(A,";",2) I $S($G(SCTP):A>1,1:1) Q 0
 N DIR,X,Y
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Do you wish to place the patient on the wait list (Yes/No)?"
 D ^DIR
 I Y=1 S Y=$$WAITS^SCMCWAIT(DFN,SCTM,$G(SCTP),$G(SC)) I Y>0 W !,"Patient Placed on Wait List"
 Q Y>0
SC(DFN) ;Is patient 50 to 100%
 D ELIG^VADPT Q $P($G(VAEL(3)),U,2)>49
