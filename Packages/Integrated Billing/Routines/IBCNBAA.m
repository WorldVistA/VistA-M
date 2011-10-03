IBCNBAA ;ALB/ARH-Ins Buffer: process Accept set-up ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,184,246,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
ACCEPT(IBBUFDA,IBINSDA,IBGRPDA,IBPOLDA) ; process a buffer entry for acceptance then save in Insurance files
 ;    1) for Insurance Company, Group/Plan and Policy sets of data:
 ;        a) display the set of buffer data and corresponding existing selected ins data
 ;        b) if ins record exists confirm with user that it is the correct one to use
 ;        c) if ins record exists user selects method of saving to ins record: Merge/Overwrite/Replace/No Change/Individually Accept(skip blanks)
 ;        d) if new record needs to be created get user confirmation
 ;    2) display the actions that will be taken
 ;    3) user confirms that is correct
 ;    4) data moved into insurance files, new records created if needed or edit existing ones
 ;    5) complete some general functions that are executed whenever insurance is entered/edited
 ;    6) allow user to view buffer entry and new/updated insurance records
 ;    7) buffer ins/group/policy data deleted
 ;    8) buffer entry status updated
 ;
 N DFN,IBX,IBELIG,IBHELP,IBNEWINS,IBNEWGRP,IBNEWPOL,IBMVINS,IBMVGRP,IBMVPOL,IBACCPT,DIR,X,Y,DIRUT,IBDONE S IBDONE=0
 K ^TMP($J,"IB BUFFER SELECTED")  ; initialize selection file
 S IBINSDA=+$G(IBINSDA),IBGRPDA=+$G(IBGRPDA),IBPOLDA=+$G(IBPOLDA),(IBNEWINS,IBNEWGRP,IBNEWPOL,IBMVINS,IBMVGRP,IBMVPOL)=0
 S DFN=+$G(^IBA(355.33,+$G(IBBUFDA),60)) I 'DFN G ACCPTQ
 I +IBINSDA,+IBGRPDA,'IBPOLDA S IBPOLDA=$$PTGRP^IBCNBU1(DFN,IBINSDA,IBGRPDA) ; pateint already member of plan
 ;
 I $P($G(^IBA(355.33,$G(IBBUFDA),0)),U,4)'="E" G ACCPTQ
 I +IBINSDA,$G(^DIC(36,IBINSDA,0))="" G ACCPTQ
 I +IBGRPDA,+$G(^IBA(355.3,IBGRPDA,0))'=IBINSDA G ACCPTQ
 I +IBGRPDA S IBX=$G(^IBA(355.3,IBGRPDA,0)) I $P(IBX,U,2)=0,+$P(IBX,U,10),$P(IBX,U,10)'=DFN G ACCPTQ
 I +IBPOLDA,+$G(^DPT(DFN,.312,IBPOLDA,0))'=IBINSDA G ACCPTQ
 I +IBPOLDA,$P($G(^DPT(DFN,.312,IBPOLDA,0)),U,18)'=IBGRPDA G ACCPTQ
 ;
ACINS ;
 W @IOF S IBHELP=",INS^IBCNBCD("_IBBUFDA_","_IBINSDA_")"
 D INS^IBCNBCD(IBBUFDA,IBINSDA)
 I +IBINSDA S IBACCPT=$$MATCH("INSURANCE COMPANY") S:'IBACCPT (IBINSDA,IBGRPDA,IBPOLDA)=0 I $D(DIRUT) G ACCPTQ
 I +IBINSDA S IBMVINS=$$MOVE("INSURANCE COMPANY",IBHELP) I $D(DIRUT)!(IBMVINS="") G ACCPTQ
 I 'IBINSDA S IBNEWINS=$$NEW("INSURANCE COMPANY"),IBMVINS=3,(IBGRPDA,IBPOLDA)=0 I 'IBNEWINS G ACCPTQ
 ;
 I +IBMVINS=4 D INS^IBCNBAC(IBBUFDA,IBINSDA,1) ; Ind. Accept-Skip Blanks
 ;
ACGRP ;
 W @IOF S IBHELP=",GRP^IBCNBCD("_IBBUFDA_","_IBGRPDA_")"
 I +IBGRPDA W !,?14,"Patient is "_$S(+IBPOLDA:"",1:"NOT ")_"a member of this Insurance Group/Plan",!
 D GRP^IBCNBCD(IBBUFDA,IBGRPDA)
 I +IBGRPDA S IBACCPT=$$MATCH("GROUP/PLAN") S:'IBACCPT (IBGRPDA,IBPOLDA)=0 I $D(DIRUT) G ACCPTQ
 I +IBGRPDA S IBMVGRP=$$MOVE("GROUP/PLAN",IBHELP) I $D(DIRUT)!(IBMVGRP="") G ACCPTQ
 I 'IBGRPDA S IBNEWGRP=$$NEW("GROUP/PLAN"),IBMVGRP=3,IBPOLDA=0 I 'IBNEWGRP G ACCPTQ
 ;
 I +IBMVGRP=4 D GRP^IBCNBAC(IBBUFDA,IBGRPDA,1) ; Ind. Accept-Skip Blanks
 ;
ACPOL ;
 W @IOF S IBHELP=",POLICY^IBCNBCD("_IBBUFDA_","_IBPOLDA_")"
 I 'IBPOLDA W !,"This will be a New policy for this group and patient.",!
 D POLICY^IBCNBCD(IBBUFDA,IBPOLDA)
 I +IBPOLDA S IBACCPT=$$MATCH("PATIENT POLICY") S:'IBACCPT IBPOLDA=0 I $D(DIRUT) G ACCPTQ
 I +IBPOLDA S IBMVPOL=$$MOVE("PATIENT POLICY",IBHELP) I $D(DIRUT)!(IBMVPOL="") G ACCPTQ
 I 'IBPOLDA S IBNEWPOL=$$NEW("PATIENT POLICY"),IBMVPOL=3 I 'IBNEWPOL G ACCPTQ
 ;
 I +IBMVPOL=4 D POLICY^IBCNBAC(IBBUFDA,IBPOLDA,1) ; Ind. Accept-Skip Blanks
 ;
ACEB ;
 W @IOF
 D ELIG^IBCNBCD(IBBUFDA,IBPOLDA) S IBELIG=$$REPL() I $D(DIRUT) G ACCPTQ
 ;
CHECK ; display changes that will be made and ask user for confirmation
 W @IOF
 ;
 I +IBINSDA S IBX="The Buffer data will "_$P(IBMVINS,U,2)_" the existing Insurance Company data."
 I +IBINSDA,'IBMVINS S IBX="There will be "_$P(IBMVINS,U,2)_" to the existing Insurance Company data."
 I 'IBINSDA S IBX=$P(^IBA(355.33,IBBUFDA,20),U,1)_" will be added as a NEW Insurance Company."
 W !!,$G(IORVON)_"STEP 1: Insurance Company"_$J("",55)_$G(IORVOFF) W !,IBX
 ;
 I +IBGRPDA S IBX="The Buffer data will "_$P(IBMVGRP,U,2)_" the existing Group/Plan data."
 I +IBGRPDA,'IBMVGRP S IBX="There will be "_$P(IBMVGRP,U,2)_" to the existing Group/Plan data."
 I 'IBGRPDA S IBX="A NEW Group Plan will be added to this Insurance Company."
 W !!,$G(IORVON)_"STEP 2: Group/Plan"_$J("",62)_$G(IORVOFF) W !,IBX
 ;
 I +IBPOLDA S IBX="The Buffer data will "_$P(IBMVPOL,U,2)_" the existing Policy data."
 I +IBPOLDA,'IBMVPOL S IBX="There will be "_$P(IBMVPOL,U,2)_" to the existing Policy data."
 I 'IBPOLDA S IBX="A NEW Patient Policy will be added for this patient and this Group/Plan."
 W !!,$G(IORVON)_"STEP 3: Patient Policy"_$J("",58)_$G(IORVOFF) W !,IBX
 ;
 I IBELIG S IBX="The Buffer data will"_$S(IBELIG:"",1:" not")_" replace the existing EB data."
 W !!,$G(IORVON)_"STEP 4: Eligibility/Benefits"_$J("",58)_$G(IORVOFF) W !,IBX
 ;
 I +IBINSDA,$P(IBMVINS,U,1)=0,+IBGRPDA,$P(IBMVGRP,U,1)=0,+IBPOLDA,$P(IBMVPOL,U,1)=0,+IBELIG=0 W !!!,"This would result in No Change to the existing Insurance data.  Process aborted." D WAIT G ACCPTQ
 ;
 I '$$OK G ACCPTQ
 ;
PROCESS ; process all changes selected by user, add/edit insurance files based on buffer data, cleanup, ...
 ;
 D ACCEPT^IBCNBAR(IBBUFDA,DFN,IBINSDA,IBGRPDA,IBPOLDA,IBMVINS,IBMVGRP,IBMVPOL,IBNEWINS,IBNEWGRP,IBNEWPOL,IBELIG)
 S IBDONE=1
 ;
ACCPTQ K ^TMP($J,"IB BUFFER SELECTED")  ; cleanup selection file
 Q IBDONE
 ;
 ;
 ;
MATCH(IBDESC) ; ask the user if the buffer entry is a match with the selected insurance file entry
 ; returns 1 if there is a match, 0 otherwise
 N DIR,X,Y,IBX S IBX=0
 S DIR("?")="Enter Yes if this existing "_IBDESC_" corresponds to the buffer entry "_IBDESC_".  Enter No to add new "_IBDESC_"."
 S DIR("?",1)="Entering Yes will match this existing "_IBDESC_" with the buffer entry,"
 S DIR("?",2)="no new "_IBDESC_" will be created.  Any existing "_IBDESC_" data"
 S DIR("?",3)="changes based on the Buffer data will be applied to this "_IBDESC_"."
 S DIR("?",4)="Enter No to create a new "_IBDESC_" if the Buffer entry's "
 S DIR("?",5)=IBDESC_" data does not match any existing "_IBDESC_".",DIR("?",6)=""
 ;
 W ! S DIR(0)="YO",DIR("A")="Is this the correct "_IBDESC_" to match with this Buffer entry" D ^DIR I Y=1 S IBX=1
 Q IBX
 ;
MOVE(IBDESC,IBHELP) ; ask the user what method they want to use to transfer buffer data to the insurance files
 ; returns 1^merge, 2^overwrite, 3^replace, 4^individually accept (skip blanks),
 ;  0^no change,
 ;  or "" if none of the methods was chosen
 N DIR,X,Y,IBX S IBX=""
 S DIR("?")="^D HELP^IBCNBUH,WAIT^IBCNBAA"_$G(IBHELP),DIR("??")="^D HELP2^IBCNBUH,WAIT^IBCNBAA"_$G(IBHELP)
 S DIR("A")="Select the method to update the "_IBDESC
 ; DAOU/BHS - 08/28/2002 - Added INDIVIDUALLY ACCEPT methods
 W ! S DIR(0)="SOB^M:MERGE;O:OVERWRITE;R:REPLACE;N:NO CHANGE;I:INDIVIDUALLY ACCEPT (SKIP BLANKS)" D ^DIR
 S IBX=$S(Y="M":1,Y="O":2,Y="R":3,Y="I":4,Y="N":0,1:"") I IBX'="" S IBX=IBX_U_$G(Y(0))_$S(+IBX=1:" with",1:"")
 Q IBX
 ;
NEW(IBDESC) ; ask user if they want to add a new entry to the insurance files (36, 355.3, or 2.312)
 ; returns 1 if Yes create a new entry, 0 otherwise
 N DIR,X,Y,IBX S IBX=0
 I IBDESC="INSURANCE COMPANY",'$D(^XUSEC("IB INSURANCE COMPANY ADD",DUZ)) W !!,"Sorry, but you do not have the required privileges to add",!,"new Insurance Companies." D WAIT G NEWQ
 ;
 S DIR("?")="Enter Yes to create a new "_IBDESC_". Enter No to stop this process."
 S DIR("?",1)="Enter Yes to create a new "_IBDESC_" in the Insurance files for"
 S DIR("?",2)="this Buffer entry only if no existing "_IBDESC_" could be found"
 S DIR("?",3)="that matches this buffer entry.",DIR("?",4)=""
 W ! S DIR(0)="YO",DIR("A")="No "_IBDESC_" Selected, Add a New "_IBDESC D ^DIR I +Y=1 S IBX=1
NEWQ Q IBX
 ;
REPL() ; ask user if they want to replace eligibility/benefits data in pt. insuarance
 N DIR,X,Y,IBX
 S IBX=0
 S DIR(0)="YO",DIR("A")="Replace the Pt's Eligibility/Benefits data",DIR("B")="YES"
 S DIR("?")="Enter Yes to replace existing Eligibility/Benefits data with one from eIV response."
 W ! D ^DIR I +Y=1 S IBX=1
 Q IBX
 ;
OK() ; ask the user if the buffer data should be moved to the insurance files
 ; returns 1 if yes, 0 otherwise
 N DIR,X,Y,IBX S IBX=0 W !!!
 S DIR("?")="Enter Yes to accept/verify the buffer data and move it to the insurance files.  Enter No to stop this process."
 S DIR("?",1)="Entering Yes will cause several things to happen:"
 S DIR("?",2)="  1 - the above changes will be completed and the Insurance files updated with"
 S DIR("?",3)="      the buffer data."
 S DIR("?",4)="  2 - the Insurance entries modified or added will be flagged as verified."
 S DIR("?",5)="  3 - most of the insurance and patient related information in the buffer entry"
 S DIR("?",6)="      will be deleted, leaving only a stub entry for reporting purposes.",DIR("?",7)=""
 S DIR(0)="YO",DIR("A")="Is this Correct, update the existing Insurance files now" D ^DIR I Y=1 S IBX=1
 Q IBX
 ;
WAIT N DIR,DIRUT,DUOUT,DTOUT,X,Y W !! S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR W !!
 Q
