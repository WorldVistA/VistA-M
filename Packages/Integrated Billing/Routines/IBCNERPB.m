IBCNERPB ;DAOU/RO - PAYER LINK REPORT - Prompts ;AUG-2003
 ;;2.0;INTEGRATED BILLING;**184,252,271,416,528,668,687**;21-MAR-94;Build 88
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #1519-For using the KERNEL routine XUTMDEVQ
 ;
 ; IB*2*687-rewrote/redesigned the report (basically from scratch) which
 ; included combining 3 routines into 2. The changes based on the patches prior
 ; to IB*2*688 were not tracked in the routine in the past; therefore, you will
 ; not find references to them below. The IB*2*668 reference (translating "IIV"
 ; to "EIV") will be overwritten with the rewrite.
 ;
 ; eIV - Electronic Ins. Verification
 ; IIU - Interfacility Ins. Update
 ;
 ; Input parameters: N/A
 ; Variables ZTSAVED for queueing:
 ; IBCNERTN="IBCNERPB" (current routine)
 ; IBCNESPC("PAPP")=Payer APPLICATION selected (1-eIV, 2-IIU, 3-Both)
 ; IBCNESPC("PDEACT")=Include Deactivated Payers? (1-include, 2-exclude)
 ; IBCNESPC("PDET")=Include Ins detail? (1-include list of ins, 2-do not list)
 ; IBCNESPC("POUT")=Output Format ('E'=EXCEL, 'R'=REPORT)
 ; IBCNESPC("PPYR")=Single Payer name or "" for ALL
 ; IBCNESPC("PSORT")=Primary Sort
 ; IBCNESPC("PTYPE")=Payer type (1-no active ins linked, 2-at least 1 ins linked, 3-All Payers)
 Q
 ;
EN ; Entry pt
 N IBCNERTN,IBCNESPC,POP,STOP,ZTQUEUED,ZTREQ,ZTSTOP
 S STOP=0,IBCNERTN="IBCNERPB"
 W @IOF
 W !,"Payer Link Report",!
 W !,"In order for an Insurance Company to be eligible for electronic insurance"
 W !,"eligibility communications via the eIV software or to transmit active insurance"
 W !,"to another VAMC via IIU, the Insurance Company needs to be linked to an"
 W !,"appropriate payer from the National EDI Payer list. The National EDI Payer"
 W !,"list contains the names of the payers that are currently participating with"
 W !,"the eIV and/or IIU process."
 W !!,"This report provides access to the following information:"
 W !!?4,"-  A list of all payers with current eIV and IIU settings."
 W !?4,"-  A list of all payers with associated linked insurance company detail."
 W !?4,"-  A list of all payers with no insurance companies linked."
 ;
R05 ; Include Deactivated Payers?
 N DIC,DTOUT,DUOUT,X,Y
 K IBCNERSPC
 W !!!
 S DIR(0)="Y"
 S DIR("A")="Include deactivated payers"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to include deactivated payers."
 S DIR("?")="  Enter NO to exclude deactivated payers."
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) S Y="" G REXIT
 I Y=-1 S Y=""
 S IBCNESPC("PDEACT")=Y
 ;
R10 ; Select Payer (#365.12)
 N DIC,DTOUT,DUOUT,X,Y
 W !
 S DIC(0)="ABEQ"
 S DIC("A")=$$FO^IBCNEUT1("Select a Payer (RETURN for ALL Payers): ",40,"L")
 ; Do not allow '~NO PAYER' or non-eIV/non-IIU payers
 S DIC("S")="I ($P(^(0),U,1)'=""~NO PAYER""),(($$PYRAPP^IBCNEUT5(""EIV"",$G(Y))'="""")!($$PYRAPP^IBCNEUT5(""IIU"",$G(Y))'=""""))"
 ; If 'no' deactivated payers selected, override the previous "screen" line.
 I '+IBCNESPC("PDEACT") S DIC("S")="I ('+$$PYRDEACT^IBCNINSU($G(Y))),($P(^(0),U,1)'=""~NO PAYER""),(($$PYRAPP^IBCNEUT5(""EIV"",$G(Y))'="""")!($$PYRAPP^IBCNEUT5(""IIU"",$G(Y))'=""""))"
 S DIC="^IBE(365.12,"
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) S Y="" G:$$STOP^IBCNINSU REXIT  G R05
 I Y=-1 S Y=""
 S IBCNESPC("PPYR")=Y
 I +Y,'+IBCNESPC("PDEACT"),+$$PYRDEACT^IBCNINSU(+Y) D  G R10
 . W !,*7,"*** Invalid activated payer...Please try again. ***"
 ;
R20 ; OUTPUT Format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) G:$$STOP^IBCNINSU REXIT  G R10
 S IBCNESPC("POUT")=Y
 I IBCNESPC("POUT")="E" S IBCNESPC("PAPP")=3,IBCNESPC("PSORT")=1,IBCNESPC("PTYPE")=3 G R50  ; For EXCEL go straight to Linked Ins Co Detail prompt.
 I IBCNESPC("PPYR")'="" S IBCNESPC("PAPP")=3,IBCNESPC("PTYPE")=3 G R50  ; For a Single P/ayer Only.
 ;
R30 ; eIV, IIU or ALL Payers
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !!!,"eIV Payer list - displays those payers who can send and receive"
 W !,"                 HIPAA 270/271 transactions for verification."
 W !,"IIU Payer list - displays those payers who are eligible to exchange"
 W !,"                 between VAMCs for active insurance."
 W !,"Both           - includes any payer that is defined as either eIV or IIU"
 W !,"                 or both applications."
 S DIR(0)="S^1:eIV Payer List;2:IIU Payer List;3:Both"
 S DIR("A")="Select a report option"
 S DIR("B")="3"
 S DIR("?",1)="1 - Select eIV PAYER LIST to view payers eligible to send and receive"
 S DIR("?",2)="    HIPAA 270/271 transactions for verification."
 S DIR("?",3)="2 - Select IIU PAYER LIST to view payers eligible to exchange between"
 S DIR("?",4)="    VAMCs for active insurance."
 S DIR("?",5)="3 - Select BOTH to view payers that are defined as either eIV or IIU or"
 S DIR("?",6)="    both applications."
 S DIR("?")=" "
 D ^DIR K DIR I $D(DIRUT) G:$$STOP^IBCNINSU REXIT  G R20
 S IBCNESPC("PAPP")=Y
 ;
R40 ; PAYER Type
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S^1:Unlinked Payers;2:Linked Payers;3:ALL Payers"
 S DIR("A")="Select the type of payers to display"
 S DIR("B")="3"
 S DIR("?",1)=" 1 - Only payers with no active insurance companies linked"
 S DIR("?",2)=" 2 - Only payers with at least one insurance company linked"
 S DIR("?",3)=" 3 - ALL Payers"
 S DIR("?")=" "
 D ^DIR K DIR I $D(DIRUT) G:$$STOP^IBCNINSU REXIT  G R30
 S IBCNESPC("PTYPE")=Y  I IBCNESPC("PTYPE")=1 S IBCNESPC("PDET")=2 G R60
 ;
R50 ; Linked Ins Co Detail?
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="S^1:List linked insurance company detail;2:Do not list linked insurance company detail"
 S DIR("A")="Select company detail option"
 S DIR("B")="1"
 S DIR("?",1)=" 1 - Include a list of insurance companies linked to the payers"
 S DIR("?",2)=" 2 - Do not list linked insurance companies, total number only"
 S DIR("?")=" "
 D ^DIR K DIR
 I $D(DIRUT) G:$$STOP^IBCNINSU REXIT G:(IBCNESPC("POUT")="E")!(IBCNESPC("PPYR")'="") R20  G R40
 S IBCNESPC("PDET")=Y
 ;
R60 ; PRIMARY sort
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I IBCNESPC("POUT")="E" S IBCNESPC("PSORT")=1 G R100   ; If EXCEL skip prompt
 I IBCNESPC("PPYR")'="" S IBCNESPC("PSORT")=1 G R100   ; If a single payer skip prompt
 S DIR(0)="S^1:Payer Name;2:VA National Payer ID;3:Nationally Enabled Status;4:Locally Enabled Status;5:# of Linked Insurance Companies"
 S DIR("A")="Select the primary sort field"
 S DIR("B")=1
 S DIR("?")=" Select a data field by which this report should be primarily sorted."
 D ^DIR K DIR
 I $D(DIRUT) G:$$STOP^IBCNINSU REXIT G:(IBCNESPC("PTYPE")=1) R40  G:(IBCNESPC("PPYR")'="") R20  G R50
 S IBCNESPC("PSORT")=Y
 ;
R100 ; 132 width.
 I IBCNESPC("POUT")="R" W !!!,"*** This report is 132 characters wide ***",!
 I IBCNESPC("POUT")="E" W !!!,"*** To avoid wrapping, enter '0;256;999' at the 'DEVICE' prompt. ***",!
 D DEVICE(IBCNERTN,.IBCNESPC) I STOP G:$$STOP^IBCNINSU REXIT  G:(IBCNESPC("POUT")="E") R50  G:(IBCNESPC("PTYPE")=1) R60  G:(IBCNESPC("PPYR")'="") R50  G R60
 ;
REXIT ; Exit pt
 Q
 ;
DEVICE(IBCNERTN,IBCNESPC) ; Device Handler
 ; IBCNERTN = Routine name for ^TMP($J,...
 ; IBCNESPC = Array of params
 N POP,ZTDESC,ZTRTN,ZTSAVE
 S ZTRTN="COMPILE^IBCNERPC("""_IBCNERTN_""",.IBCNESPC)"
 S ZTDESC="Payer Link Report"
 S ZTSAVE("IBCNESPC(")=""
 S ZTSAVE("IBCNERTN")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)   ; ICR # 1519
 I POP S STOP=1
DEVICEX ; DEVICE exit
 Q
 ;
