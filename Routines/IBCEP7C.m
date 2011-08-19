IBCEP7C ;ALB/TMP - Functions for fac level PROVIDER ID MAINT ;11-07-00
 ;;2.0;INTEGRATED BILLING;**137,232,320,348,349**;21-MAR-94;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 G AWAY
AWAY Q
 ;
 ; IBDA - IEN for file 355.92
 ; IBFUNC = "A"dd or "E"dit
FACFLDS(IBDA,IBINS,IBITYP,IBFORM,IBDIV,IBFUNC,IBCAREUN,IBEFTFL) ; Chk for dups on fac id fld combos
 ;
 N IB,IBOK,DIC,DIR,X,Y,DTOUT,DUOUT,Z,Z0,DIE,DA,IBMAIN,IBQUIT,IBPARAM,IBCUF,IBDA0,IBCNTADD,I,IBLIMIT
 ;
 S IBOK=0,IBDA0=""
 I $G(IBDA) S IBDA0=$G(^IBA(355.92,IBDA,0))
 S IBPARAM=$G(^TMP("IBCE_PRVFAC_MAINT_INS",$J))
 S IBCUF=$S($P(IBDA0,U,3)]"":1,1:0)  ; Care Unit Flag
 ;
 I IBEFTFL="E",IBFUNC="A" D  G:$D(DTOUT)!$D(DUOUT) FLDSQ
 . K DIR
 . S DIR("A")="Define Billing Provider Secondary IDs by Care Units? "
 . S DIR("B")="No"
 . S DIR(0)="YAO"
 . S DIR("?",1)="Enter No to define a Billing Provider Secondary ID for the Division."
 . S DIR("?",2)="Enter Yes to define a Billing Provider Secondary ID for a specific Care Unit."
 . S DIR("?",3)="If no Care Unit is entered on Billing Screen 3, the Billing Provider"
 . S DIR("?")="Secondary ID defined for the Division will be transmitted in the claim."
 . D ^DIR
 . S IBCUF=$G(Y)  ; Care Unit Flag
 ;
 ; Get the Division
 S IBMAIN=$$MAIN^IBCEP2B()
 S IBDIV=0
 I IBEFTFL="E"!(IBEFTFL="LF") D  G:$D(DTOUT)!$D(DUOUT) FLDSQ
 . K DIR
 . S (IBQUIT,IBOK)=0,DA=$G(IBDA)
 . S DIR("A")="Division: ",DIR(0)="355.92,.05AOr"
 . ; Default Division - Main if adding or Existing if editing
 . I IBFUNC="E" S DIR("B")=$P($$DIV^IBCEP7($P(IBDA0,U,5)),"/")
 . I IBFUNC="A" S DIR("B")=$P($$EXTERNAL^DILFD(355.92,.05,"",IBMAIN),"/")
 . D ^DIR K DIR
 . Q:$D(DTOUT)!$D(DUOUT)
 . S IBDIV=+$S(Y>0:+Y,1:0)
 ;
 ; See if there are any Care Units
 S IBCAREUN="*N/A*"
 I IBEFTFL="E",IBCUF D
 . N TAR
 . D LIST^DIC(355.95,,.01,,,,,,"I $P(^(0),U,3)=+$G(IBINS),$P(^(0),U,4)=+$G(IBDIV)",,"TAR")
 . Q:+$G(TAR("DILIST",0))
 . S IBCUF=0
 . W !!,"There are no Care Units defined for this Division.",!
 ;
 ; Get the Care Unit
 I IBEFTFL="E",IBCUF D  I Y<1 G FLDSQ
 . K DIC
 . S DIC("A")="Care Unit: "
 . I IBFUNC="E" D  ; default only if editing
 .. Q:IBDIV'=$P(IBDA0,U,5)  ; don't default if division has changed
 .. S DIC("B")=$$EXTERNAL^DILFD(355.92,.03,"",$P(IBDA0,U,3))
 . S DIC=355.95,DIC("S")="I $P(^(0),U,3)=+$G(IBINS),$P(^(0),U,4)=+$G(IBDIV)",DIC(0)="AEMQ"
 . D ^DIC
 . I Y>0 S IBCAREUN=+Y
 ;
 ; Think this is done for sorting purposes.  Makes the main division first
 I IBDIV=IBMAIN S IBDIV=0
 ;
 ; Get the Provider ID Type
 K DIR
 S IBQUIT=0
 I $P(IBPARAM,U,3)'=1 D
 . S DIR("?")="Can NOT be State LIC # or Billing Facility Primary"
 . S DIR("A")="ID Qualifier: "
 . S DIR(0)="355.92,.06A^^K:'$$FACID^IBCEP7(+Y)!$P($G(^IBE(355.97,+Y,1)),U,9)!($P($G(^(0)),U,3)=""0B"") X"
 . W ! D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IBQUIT=1
 E  D  G:$D(DTOUT)!$D(DUOUT) FLDSQ
 . S DIR("A")="ID Qualifier: "    ;,DIR(0)="355.92,.06Ar"
 . S DIR(0)="PAr^355.97:AEMQ"
 . S DIR("?")="Enter a Qualifier to indentify the type of ID number you are entering."
 . ; Default Type of ID - Electronic Plan Type if adding or Existing if editing
 . N PITIEN S PITIEN=$S(IBFUNC="A"&(IBEFTFL="E"):$$BF^IBCU(),IBFUNC="E":$P(IBDA0,U,6),1:"")
 . I PITIEN]"" S DIR("B")=$P($G(^IBE(355.97,PITIEN,0)),U)
 . I IBEFTFL="E" D
 .. S DIR("?",1)=" The current default ID Qualifier is based upon the Electronic Plan Type."
 .. S DIR("?",2)=" You may change the ID Qualifier and the change will apply to all Plan"
 .. S DIR("?")=" Types."
 .. S DIR("S")="I ($P($G(^(0)),U,3)=$P($G(^IBE(355.97,PITIEN,0)),U,3))!$$BPS^IBCEPU(Y)"
 . I IBEFTFL="A" S DIR("S")="I $$BPS^IBCEPU(Y)"
 . I IBEFTFL="LF" S DIR("S")="I $$LFINS^IBCEPU(Y)"
 . D ^DIR K DIR
 G:IBQUIT FLDSQ
 S IBITYP=$P(Y,U)
 ;
 ; Get Form Type
 K DIR
 S DIR("A")="Form Type: "
 S DIR(0)=$S(IBEFTFL="LF":"SA^0:BOTH;1:UB-04;2:CMS-1500",1:"SA^1:UB-04;2:CMS-1500")
 ;
 I $G(IBDA) S DIR("B")=$S(+$P($G(^IBA(355.92,IBDA,0)),U,4)=0:"BOTH",1:$P("UB-04^CMS-1500",U,+$P($G(^IBA(355.92,IBDA,0)),U,4)))
 ;
 D ^DIR K DIR
 G:$D(DTOUT)!$D(DUOUT) FLDSQ
 S IBFORM=$P(Y,U)
 ;
 ; Set up array of exisiting IDs by form type, divison, and care units to avoid duplications
 S Z=0 F  S Z=$O(^IBA(355.92,"B",IBINS,Z)) Q:'Z  D
 . S Z0=$G(^IBA(355.92,Z,0))
 . I '(IBFUNC="E"&(Z=IBDA)) D
 .. I IBEFTFL="LF",$P(Z0,U,8)'="LF" Q   ; If lab/facility ID, it only needs to be unique among lab/facility IDs
 .. I IBEFTFL'="LF",$P(Z0,U,8)="LF" Q   ; If not lab/facility ID, it must be unigue for the others (secondary and additional)
 .. I IBEFTFL="A",$P(Z0,U,8)="E" Q
 .. I $P(Z0,U,8)="E",IBEFTFL'="A" S IB("*N/A*",$P(Z0,U,4),+$P(Z0,U,5),$S($P(Z0,U,3)]"":$P(Z0,U,3),1:"*N/A*"))=Z
 .. S IB($P(Z0,U,6),$P(Z0,U,4),+$P(Z0,U,5),$S($P(Z0,U,3)]"":$P(Z0,U,3),1:"*N/A*"))=Z
 . ;
 . ; count them
 . I IBFUNC="A",$P(Z0,U,8)=IBEFTFL,IBDIV=$P(Z0,U,5)!(IBDIV=0&($P(Z0,U,5)="")) D
 .. I ".1.2."[("."_$P(Z0,U,4)_".") S IBCNTADD($P(Z0,U,4))=$G(IBCNTADD($P(Z0,U,4)))+1 Q
 .. N I
 .. F I=1,2 S IBCNTADD(I)=$G(IBCNTADD(I))+1
 ; Check for duplications
 S IBOK=1
 ; Don't check if nothing is being changed.  The ID itself can be changed after return to calling program.
 I IBFUNC="E" S Z0=$G(^IBA(355.92,IBDA,0)) I $P(Z0,U,3)=IBCAREUN!($P(Z0,U,3)=""&(IBCAREUN="*N/A*")),IBFORM=$P(Z0,U,4),IBDIV=$P(Z0,U,5),IBITYP=$P(Z0,U,6) G FLDSQ
 I $G(IB($S(IBEFTFL="E":"*N/A*",1:IBITYP),IBFORM,IBDIV,IBCAREUN)) D
 . N Z,ZPC8 S Z=$G(IB($S(IBEFTFL="E":"*N/A*",1:IBITYP),IBFORM,IBDIV,IBCAREUN))
 . S ZPC8=""
 . I +Z S ZPC8=$P($G(^IBA(355.92,Z,0)),U,8)
 . S IBOK="0^DUPLICATE"_U_ZPC8
 I IBOK,IBFORM=0,$S($D(IB($S(IBEFTFL="E":"*N/A*",1:IBITYP),1,IBDIV,IBCAREUN))!$D(IB($S(IBEFTFL="E":"*N/A*",1:IBITYP),2,IBDIV,IBCAREUN)):1,1:0) S IBOK="0^FORM^SPECIFIC"
 I IBOK,IBFORM'=0,IBFORM'=3,$S($D(IB($S(IBEFTFL="E":"*N/A*",1:IBITYP),0,IBDIV,IBCAREUN)):1,1:0) S IBOK="0^FORM^BOTH"
 ;
 S IBLIMIT=$S(IBEFTFL="A":6,IBEFTFL="LF":5,1:"")
 I IBOK,IBFUNC="A",IBEFTFL'="E" D
 . I ".1.2."[("."_IBFORM_".") D  Q
 .. I $G(IBCNTADD(IBFORM))>(IBLIMIT-1) S IBOK="0^LIMIT"
 . N I
 . I IBFORM=0 F I=1,2 I $G(IBCNTADD(I))>IBLIMIT S IBOK="0^LIMIT" Q
 ;
 I 'IBOK D
 . I $P(IBOK,U,2)="DUPLICATE" D  Q
 .. S DIR("A",1)="This ID combination is already defined",DIR("A",2)=""
 .. ; under "_$S($P(IBOK,U,3)="A":" Additonal IDs",$P(IBOK,U,3)="E":"Billing Provider Secondary ID",1:"VA Lab/Facility IDs")_$S(IBFUNC="A":" - try editing it instead",1:""),DIR("A",2)=" "
 . ;
 . I $P(IBOK,U,2)="BOTH" D  Q
 .. S DIR("A",1)="An ID combination for both form types already exists.  Delete this one",DIR("A",2)="before defining and form specific IDs"_$S(IBDIV:" for this division"),DIR("A",4)=" "
 . ;
 . I $P(IBOK,U,2)="FORM" D  Q
 .. I $P(IBOK,U,3)="BOTH" S DIR("A",1)="This ID already exists for both form types - Delete it to enter this ID for",DIR("A",2)=" a specific form type",DIR("A",3)=" " Q
 .. S DIR("A",1)="This ID already exists for a specific form type - Delete specific form type",DIR("A",2)=" ID(s) before entering one for both form types",DIR("A",3)=" "
 . ;     
 . I $P(IBOK,U,2)="LIMIT" D  Q
 .. S DIR("A",1)="Limit is "_IBLIMIT_" IDs for each form type",DIR("A",2)=" "
 .. I IBEFTFL="A" D
 ... S DIR("A",1)="A maximum of 6 Additional Billing Provider Sec IDs can be entered for each Form"
 ... S DIR("A",2)="Type.  Before you can add another ID, you must delete an existing ID."
 ... S DIR("A",3)=" "
 ;
 I 'IBOK S DIR(0)="EA",DIR("A")="PRESS RETURN TO CONTINUE: " W ! D ^DIR K DIR
 ;
FLDSQ Q +IBOK
