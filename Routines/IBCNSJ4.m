IBCNSJ4 ;ALB/CPM - INACTIVATE MULTIPLE INSURANCE PLANS ; 20-MAR-95
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,62**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; Inactivate/Delete Multiple Plans
 N DFN,IBAB,IBSEL,IBCDFN,IBSUB,IBBUM,IBBUD,IBBUMC
 N IBCPOL,IBDAT,IBDATP,IBCDFN1,IBBU,IBABDAT,IBINACTM,Y
 W !!,"This process will allow you to transfer subscribers from many insurance"
 W !,"plans into one 'master' plan.  After the subscribers from each selected"
 W !,"plan are transferred to the master plan, the selected plan will be deleted"
 W !,"from your system."
 W !!,"You should be very careful when you use this tool."
 W !!,"You must first select the master plan into which you will transfer all"
 W !,"selected plan subscribers.  This plan must be an active group plan.",!
 ;
 ; - select/display the master plan
 S Y=0,IBINACTM=1 D SEL4^IBCNSJ14 G:IBQUIT ENQ
 S IBPLAND=$G(^IBA(355.3,IBPLAN,0)) D MSTR
 ;
 ; - check annual benefits
 S X="" F  S X=$O(^IBA(355.4,"APY",IBPLAN,X)) Q:X=""  S IBAB(-X)=""
 I $D(IBAB) W !!,"Annual Benefits have been established for this plan." G CONT
 S DIR(0)="Y",DIR("A")="This plan has no Annual Benefits on file!  Do you wish to continue"
 S DIR("?")="If you wish to continue with this processing, enter 'YES.'  Otherwise, enter 'NO.'"
 W ! D ^DIR K DIR I 'Y K DIRUT,DTOUT,DUOUT,DIROUT G ENQ
 ;
CONT ; - explain next step
 I '$D(IBAB) W !!,*7,"Please note that any Benefits Used on file for subscribers who",!,"will be merged into the master plan will be deleted!"
 I $D(IBAB) D
 .W !!,"Any Benefits Used on file for subscribers who will be merged into the"
 .W !,"master plan will also be merged if the master plan has any Annual Benefits"
 .W !,"dated in the same year as the Benefits Used.  Please note that the"
 .W !,"Benefits Used date will be changed to match the date of the Annual Benefit."
 ;
 W !!,"You may now select the plans to be merged into the master plan... (type <CR>)"
 R X:DTIME
 ;
 ; - allow multiple plans to be selected
 K ^TMP($J,"IBSEL") W !,"  ....hmmm..." D LKP^IBCNSU2(IBCNS,1,1,.IBSEL,0,1) I '$O(^TMP($J,"IBSEL",0)) W !!,"No plans were selected!" G ENQ
 D MSTR S (X,Y)=0 F  S X=$O(^TMP($J,"IBSEL",X)) Q:'X  I X'=IBPLAN S Y=Y+1
 W !!,"There ",$S(Y=1:"was ",1:"were "),$S(Y:Y,1:"no")," plan",$E("s",Y'=1)," selected to be merged into the master plan."
 G:'Y ENQ
 ;
 ; - okay to go?
 S DIR(0)="Y",DIR("A")="Okay to merge th"_$S(Y=1:"is",1:"ese")_" plan"_$S(Y=1:"",1:"s")_" into the master plan"
 S DIR("?")="If you wish to merge the selected plans into the master plan, enter 'YES.'  Otherwise, enter 'NO.'"
 W ! D ^DIR K DIR I 'Y K DIRUT,DTOUT,DUOUT,DIROUT G ENQ
 ;
 W !!,"Merging each selected plan into the master plan...",!
 S (IBSUB,IBBUD,IBBUM,IBBUMC)=0
 S IBCPOL=0 F  S IBCPOL=$O(^TMP($J,"IBSEL",IBCPOL)) Q:'IBCPOL  I IBCPOL'=IBPLAN D
 .W "." K ^TMP($J,"IBSUBS")
 .S IBSUB=IBSUB+$$SUBS^IBCNSJ(IBCNS,IBCPOL,0,"^TMP($J,""IBSUBS"")")
 .;
 .; - move the subscribers and benefits used
 .S DFN=0 F  S DFN=$O(^TMP($J,"IBSUBS",DFN)) Q:'DFN  D
 ..S IBCDFN=0 F  S IBCDFN=$O(^TMP($J,"IBSUBS",DFN,IBCDFN)) Q:'IBCDFN  D
 ...Q:$P($G(^DPT(DFN,.312,IBCDFN,0)),"^",18)=IBPLAN
 ...D SWPL^IBCNSJ13(IBPLAN,DFN,IBCDFN)
 ...;
 ...; - merge/change/delete previous benefits used
 ...S IBDAT="" F  S IBDAT=$O(^IBA(355.5,"APPY",DFN,IBCPOL,IBDAT)) Q:IBDAT=""  D
 ....S IBCDFN1=0 F  S IBCDFN1=$O(^IBA(355.5,"APPY",DFN,IBCPOL,IBDAT,IBCDFN1)) Q:'IBCDFN1  I IBCDFN1=IBCDFN S IBBU=$O(^(IBCDFN1,0)) D
 .....S IBDATP=-IBDAT,IBABDAT=$O(IBAB($E(IBDATP,1,3)_"0000"))
 .....I $E(IBABDAT,1,3)'=$E(IBDATP,1,3) S IBBUD=IBBUD+1 D DBU^IBCNSJ(IBBU) Q
 .....S IBBUM=IBBUM+1 S:IBABDAT'=IBDATP IBBUMC=IBBUMC+1
 .....D MERG^IBCNSJ13(IBPLAN,IBBU,$S(IBABDAT'=IBDATP:IBABDAT,1:0))
 .;
 .; - delete the plan
 .D DEL^IBCNSJ(IBCPOL)
 ;
 W !!,"All selected plans have been deleted."
 W !,$S(IBSUB:IBSUB,1:"No")," subscriber",$S(IBSUB=1:" was",1:"s were")," transferred to the master plan."
 W !,$S(IBBUD:IBBUD,1:"No")," Benefits Used record",$S(IBBUD=1:" was",1:"s were")," deleted."
 W !,$S(IBBUM:IBBUM,1:"No")," Benefits Used record",$S(IBBUM=1:" was",1:"s were")," merged."
 I IBBUM W "  (",IBBUMC," had the date changed)"
 ;
ENQ K ^TMP($J,"IBSUBS"),^("IBSEL")
 Q
 ;
 ;
MSTR ; Display Master Plan Information
 W !!?24,"*** M A S T E R  P L A N ***"
 W !,"Plan Company: ",$P($G(^DIC(36,IBCNS,0)),"^")
 W !?3,"Plan Name: ",$S($P(IBPLAND,"^",3)]"":$P(IBPLAND,"^",3),1:"<unspecified>")
 W !," Plan Number: ",$S($P(IBPLAND,"^",4)]"":$P(IBPLAND,"^",4),1:"<unspecified>")
 Q
 ;
 ;
ASK() ; Does the user wish to inactivate multiple plans?
 N DIR,DIRUT,DUOUT,DTOUT,DIROUT,X,Y
 S DIR(0)="Y",DIR("A")="Do you wish to delete multiple plans simultaneously"
 S DIR("?")="If you wish to transfer subscribers from many duplicate plans into a master plan, enter 'YES.'  To inactivate a single plan, enter 'NO.'"
 W ! D ^DIR
 Q $S($D(DIRUT)!$D(DUOUT):-1,1:+Y)
