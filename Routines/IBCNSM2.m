IBCNSM2 ;ALB/AAS - INSURANCE MANAGEMENT - EDIT ROUTINE ; 22-OCT-92
 ;;2.0;INTEGRATED BILLING;**28,103,139**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% S U="^"
 ;
BU ; -- Enter Edit benefits already used
 D FULL^VALM1
 N I,J,IBXX,VALMY,IBCNS,IBCPOL,IBCDFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBPPOL=$G(^TMP("IBNSMDX",$J,$O(^TMP("IBNSM",$J,"IDX",IBXX,0))))
 .Q:IBPPOL=""
 .S IBCNS=+$P(IBPPOL,"^",5),IBCPOL=+$P(IBPPOL,"^",22),IBCDFN=+$P(IBPPOL,"^",4)
 .D EN^VALM("IBCNS BENEFITS USED BY DATE")
 .Q
 S VALMBCK="R" Q
 ;
EP ; -- Enter Edit Patient Insurance Policy Information
 ;
 S VALMBCK="R" Q
 ;
EI ;  -- Enter Edit Insurance Company Information
 ; -- if coming from benefit screen
 ;    ibcns=insurance co number
 D FULL^VALM1
 I $G(IBCNS)>0 D EN^VALM("IBCNS INSURANCE COMPANY") G EIQ
 ;
 ; -- if coming from list of policies, allow selection
 N I,J,IBXX,IBCNS,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S I=$G(^TMP("IBNSMDX",$J,$O(^TMP("IBNSM",$J,"IDX",IBXX,0))))
 .S IBCNS=$P(I,"^",5)
 .D EN^VALM("IBCNS INSURANCE COMPANY")
EIQ S VALMBCK="R" Q
 ;
VC ; -- Verify Insurance Coverage
 D FULL^VALM1
 N I,J,IBXX,VALMY
 ;
 ; -- If no effective policies ask to verify no coverage
 I '$$EPOL(DFN) D VCN G EXIT
 ;
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D
 .S IBPPOL=$G(^TMP("IBNSMDX",$J,$O(^TMP("IBNSM",$J,"IDX",IBXX,0))))
 .Q:IBPPOL=""  D VFY
 ;
EXIT ; -- Kill variables, refresh screen
 ;
 D BLD^IBCNSM
 K I,J,IBXX,DA,DR,IBDUZZ
 S VALMBCK="R" Q
 ;
VFY ; -- Display most recent verification
 ;
 N DA,DR,IBDUZ,IB0,IBWNR
 D FULL^VALM1
 S IBCH=$P(IBPPOL,U,1)
 S IBWNR=$$GETWNR^IBCNSMM1()
 ;
 ;  -- If Medicare WNR and Name of Insured is different from Pt. Name
 ;     display Warning message.
 S IB0=$G(^DPT(DFN,.312,$P(IBPPOL,U,4),0))
 I +IBWNR=+IB0 D
 .I $P(IB0,U,17)="" Q
 .I $P(IB0,U,17)=$P($G(^DPT(DFN,0)),U,1) Q
 .W !!,"WARNING: Patient Name: '"_$P($G(^DPT(DFN,0)),U,1)_"'  DOES NOT MATCH"
 .W !,"      Name of Insured: '"_$P(IB0,U,17)_"' for this "_$P(IBWNR,U,2)_" policy."
 ;
 S IBDUZ=$P($G(^DPT(DFN,.312,$P(IBPPOL,U,4),1)),U,4)
 I 'IBDUZ D REVASK Q
 W !!," "_IBCH_" LAST VERIFIED BY "_$P($G(^VA(200,+IBDUZ,0)),U)_" ON "_$$DAT1^IBOUTL($P($G(^DPT(DFN,.312,$P(IBPPOL,U,4),1)),U,3))_". . ."
 I $P($P($G(^DPT(DFN,.312,$P(IBPPOL,U,4),1)),U,3),".")=DT W !,"COVERAGE VERIFIED TODAY, "_$$DAT1^IBOUTL(DT) H 3
 E  D REVASK
 Q
 ;
REVASK ; -- Determine whether user wishes to re-verify
 ;
 N Y
 W:'IBDUZ !
 S DIR("B")="No",DIR(0)="YO",DIR("A")=$S('IBDUZ:" "_IBCH_" NEVER PREVIOUSLY VERIFIED.  DO YOU WISH TO VERIFY COVERAGE",1:"ARE YOU RE-VERIFYING COVERAGE TODAY")
 D ^DIR K DIR Q:$D(DIRUT)
 I Y D REVFY
 Q
 ;
REVFY ; -- Re-verify
 ;
 S DA(1)=DFN,DA=$P(IBPPOL,U,4),DIE="^DPT(DFN,.312,",DR="1.03////"_DT_";1.04////"_DUZ D ^DIE K DIE
 S IBDUZ=$P($G(^DPT(DFN,.312,$P(IBPPOL,U,4),1)),U,4)
 W !," "_IBCH_" VERIFIED BY "_$P($G(^VA(200,+IBDUZ,0)),U)_" ON "_$$DAT1^IBOUTL($P($G(^DPT(DFN,.312,$P(IBPPOL,U,4),1)),U,3)) D PAUSE^VALM1
 Q
 ;
VCN ; -- Ask to verifiy patient has no coverage
 ;
 N DA,DLAYGO,DIE,DIR,DR,DIRUT,DUOUT,DIOUT,DTOUT,IBADD,IBEXERR,IBWHER,X,Y
 W !!,?5,"Patient has no effective insurance coverage on file."
 S DIR("B")="No",DIR(0)="Y"
 S DIR("A")=$S(+$G(^IBA(354,DFN,60)):"Re-v",1:"V")_"erify that patient has No Insurance Coverage "
 S DIR("?")="Enter 'Yes' to enter a Verification of No Coverage Date"
 D ^DIR
 I Y D
 .I '$D(^IBA(354,DFN)) D ADDP^IBAUTL6 I '$G(IBADD) W "   <Try again Later>" Q
 .S DA=DFN,DIE="^IBA(354,",DR=60 D ^DIE I $D(Y)=0 N IBX S IBX=$P($G(^DPT(DFN,.31)),"^",11) D
 ..I X]""&(IBX'="N") S IBX="N",$P(^DPT(DFN,.31),"^",11)="N" D MSG
 ..I X']""&(IBX'="U") S IBX="U",$P(^DPT(DFN,.31),"^",11)="U" D MSG
 ..Q
 Q
 ;
EPOL(DFN) ; Does the patient have any effective policies?
 ;  Input:  DFN  --  Pointer to the patient in file #2
 ; Output:    0  --  The patient has no effective policies
 ;            1  --  The patient has at least one effective policy
 ;
 N J,X,Y S Y=0
 S J=0 F  S J=$O(^DPT(DFN,.312,J)) Q:'J  S X=$G(^(J,0)) D  Q:Y
 .I '$P(X,"^",4) S Y=1 Q
 .I $P(X,"^",4)>DT S Y=1
 Q Y
 ;
MSG ;If there is a change in the status of the covered by health insurance 
 ;field #11 in the Patient file #2, The user is notified of the change.
 I '$D(ZTQUEUED) S VALMSG="COVERED BY HEALTH INSURANCE changed to '"_IBX_$S(IBX="U":"NKNOWN'",1:"O'")
 Q
