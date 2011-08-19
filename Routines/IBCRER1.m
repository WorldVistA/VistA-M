IBCRER1 ;ALB/ARH - RATES: CM RC NATIONAL ENTER/EDIT OPTION (CONT) ; 13-FEB-2007
 ;;2.0;INTEGRATED BILLING;**370**;21-MAR-94;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
CHGLN(IBEFF,IBTYP,IBLINE) ; get all user data for charge
 ; Input:  pass by reference to get/retain defaults: Effective Date, Inst/Prof
 ; Output: IBLINE if passed by reference
 ; IBLINE = 'cpt ifn^eff dt^mod ifn^type (I/P)^charge^incr type (PR/ML/HR/MN)^incr charge^inpt^snf^opt^free'
 ;          or null if no CPT, or -1 if invalid (exit)
 N IBCPT,IBMOD,IBCHGU,IBINCR,IBCHGI,IBINP,IBSNF,IBOPT,IBFS S IBEFF=$G(IBEFF),IBTYP=$G(IBTYP),IBLINE=""
 ;
 S IBCPT=$$GETCPT(IBEFF) I IBCPT<1 S IBLINE=-1 Q  ; active cpt code
 S IBEFF=$$GETEFF(IBEFF) Q:IBEFF<1  ; charge effective date
 S IBMOD=$$GETMOD() Q:IBMOD<0  ; modifier for procedure charge
 S IBTYP=$$GETTYP(IBTYP) Q:IBTYP<0  ; charge type, inst/prof
 S IBCHGU=$$GETCHGU() Q:IBCHGU<0  W ! ; unit charge
 ;
 S IBINCR=$$GETINCR() Q:IBINCR<0  ; type of incremental charge
 S IBCHGI=$$GETCHGI(IBINCR) Q:IBCHGI<0  W ! ; incremental charge
 ;
 S IBINP=$$GETIINP() Q:IBINP<0  ; inpatient indicator
 S IBSNF=$$GETISNF() Q:IBSNF<0  ; snf indicator
 S IBOPT=$$GETIOPT() Q:IBOPT<0  ; outpatient indictor
 S IBFS=$$GETIFS() Q:IBFS<0  ; freestanding indicator
 ;
 S IBLINE=+IBCPT_U_+IBEFF_U_IBMOD_U_IBTYP_U_IBCHGU_U_IBINCR_U_IBCHGI_U_IBINP_U_IBSNF_U_IBOPT_U_IBFS
 Q
 ;
GETCPT(EFFDT) ; Get CPT/HCPCS procedure associated with charge
 ; Returns: IFN of CPT/HCPCS selected, -1 if invalid
 N IBX,DIC,DIE,DA,DR,I,X,Y,DTOUT,DUOUT S IBX=-1
 ;
 S DIC("A")="Select PROCEDURE CPT/HCPCS: " I +$G(EFFDT) S DIC("S")="I $$CPTACT^IBACSV(+Y,EFFDT)"
 S DIC="^ICPT(",DIC(0)="AEMNQ" D ^DIC K DIC I +Y>0 S IBX=+Y
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETEFF(DEFAULT) ; Get Effective Date for charge, must be within date range of current version
 ; returns valid effective date, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y,IBY,IBI,IBZ,IBA,IBMIN S IBMIN="",IBA="",IBX=-1
 S IBY=$$VERSALL^IBCRHBRV() F IBI=1:1 S IBZ=$P(IBY,U,IBI) Q:IBZ=""  S IBMIN=IBZ
 S DIR("?",1)="Charge Effective Date must be within the date range of the current RC"
 S DIR("?",2)="version, v"_+IBMIN_".  Date must be between "_$$DATE(+$P(IBMIN,";",2))_" and Today.",DIR("?",3)=""
 S DIR("?")="Enter Effective Date of Charge."
 ;
 S DIR("A")="EFFECTIVE DATE" I +$G(DEFAULT)>0 S DIR("B")=$$DATE(DEFAULT),IBA="A",DIR("A")=DIR("A")_": "
 S DIR(0)="D"_IBA_"^"_+$P(IBMIN,";",2)_":"_DT_":EX" D ^DIR K DIR I Y?7N S IBX=+Y
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETMOD() ; Get Modifier associated with the procedure charge
 ; Modifier not limited to valid CPTs since that list is often out of date
 ; Returns: IFN of selected modifier, null if no modifier selected, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=""
 S DIR("?",1)="Modifier is optional.  If a modifier is added then the charge will only"
 S DIR("?",2)="be applied if the modifier is assigned to the procedure on the bill.",DIR("?",3)=""
 S DIR("?")="Enter the Modifier associated with the procedure charge."
 ;
 S DIR("A")="MODIFIER"
 S DIR(0)="PO^DIC(81.3,:AEMQ" D ^DIR K DIR I Y>0 S IBX=+Y
 I $D(DUOUT)!$D(DTOUT) S IBX=-1
 Q IBX
 ;
GETTYP(DEFAULT) ; Get Charge Type: Institutional or Professional
 ; Returns: I for Institutional, P for Professional, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=-1
 I $G(DEFAULT)'="" S DEFAULT=$S(DEFAULT="I":"Institutional",DEFAULT="P":"Professional",1:"")
 S DIR("?")="Enter the type of charge, either Institutional or Professional."
 ;
 S DIR("A")="CHARGE TYPE" I $G(DEFAULT)'="" S DIR("B")=DEFAULT
 S DIR(0)="SB^I:Institutional;P:Professional" D ^DIR S IBX=Y
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETCHGU() ; get procedures unit charge
 ; Returns: dollar amount (non-zero), -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=-1
 S DIR("?",1)="The dollar amount to be added to a bill for each of this procedure on the bill."
 S DIR("?",2)="Enter an amount greater than zero and less than 99999, 2 decimal digits."
 S DIR("?")="Enter the unit charge for Procedure to be used at all sites."
 ;
 S DIR("A")="UNIT CHARGE: "
 S DIR(0)="NA^.001:99999:2" D ^DIR K DIR I +Y>0 S IBX=Y
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETINCR() ; get the type of charge, identifies Charge Method and incremental calculations
 ; Returns: PR for standard, HR for observation, MN for anesthesia, ML for ambulance, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=-1
 S DIR("?",1)="Most charges are a standard charge per procedure.  There are three types of"
 S DIR("?",2)="charges that require special calculations that add charge based on an "
 S DIR("?",3)="increment of units:  Anesthesia, Observation, Ambulance."
 S DIR("?")="Enter type of care that will identify the charge calculation."
 ;
 S DIR("A")="Standard, Observation, Anesthesia, or Ambulance",DIR("B")="Standard"
 S DIR(0)="SB^PR:Standard;HR:Observation;MN:Anesthesia;ML:Ambulance" D ^DIR S IBX=Y
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 ;
 Q IBX
 ;
GETCHGI(TYPE) ; if a special charge then get the incremental charge amount, anesthesia and observation only
 ; Returns: dollar amount if applicable (non-zero), null if not applicable, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y,IBTYP S TYPE=$G(TYPE),IBX=-1
 S IBTYP=$S(TYPE="MN":"Anesthesia",TYPE="HR":"Observation",1:"") I IBTYP="" S IBX=""
 S DIR("?",1)="Anesthesia and Observation have a unit charge added to a base/incremental"
 S DIR("?",2)="charge that is multiplied by the time associated with the procedure."
 S DIR("?",3)="Enter an amount greater than zero and less than 99999, 2 decimal digits.",DIR("?",4)=""
 S DIR("?")="Enter the base or incremental "_IBTYP_" charge for this procedure."
 ;
 S DIR("A")=IBTYP_" BASE CHARGE: "
 I IBTYP'="" S DIR(0)="NA^.001:99999:2" D ^DIR K DIR I +Y>0 S IBX=Y
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETIINP() ; Get Inpatient Indicator, is this charge billable for Inpatient care
 ; Returns: 1 for Yes Billable for Inpatient care, 0 for not billable, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=0
 S DIR("?")="Enter Yes if this charge is billable for Inpatient care, No otherwise."
 ;
 S DIR(0)="Y",DIR("A")="INPATIENT",DIR("B")="No" D ^DIR I Y=1 S IBX=1
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETISNF() ; Get SNF Indicator, is this charge billable for Skilled Nursing care
 ; Returns: 1 for Yes Billable for SNF care, 0 for not billable, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=0
 S DIR("?")="Enter Yes if this charge is billable for SNF care, No otherwise."
 ;
 S DIR(0)="Y",DIR("A")="SKILLED NURSING",DIR("B")="Yes" D ^DIR I Y=1 S IBX=1
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETIOPT() ; Get Outpatient Indicator, is this charge billable for Outpatient care
 ; Returns: 1 for Yes Billable for outpatient care, 0 for not billable, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=0
 S DIR("?")="Enter Yes if this charge is billable for Outpatient care, No otherwise."
 ;
 S DIR(0)="Y",DIR("A")="OUTPATIENT",DIR("B")="Yes" D ^DIR I Y=1 S IBX=1
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
GETIFS() ; Get Freestanding Indicator, is this charge billable at Freestanding Sites
 ; Returns: 1 for Yes Billable at Non-Provider Based/Freestanding sites, 0 for not billable, -1 if invalid
 N IBX,DIR,DUOUT,DTOUT,DIRUT,X,Y S IBX=0
 S DIR("?",1)="All charges for Freestanding sites will be stored as Professional charges."
 S DIR("?")="Enter Yes if this charge is billable at Freestanding Sites, No otherwise."
 ;
 S DIR(0)="Y",DIR("A")="FREESTANDING",DIR("B")="Yes" D ^DIR I Y=1 S IBX=1
 I $D(DTOUT)!$D(DUOUT) S IBX=-1
 Q IBX
 ;
DATE(X) ; returns VA date in external form
 N Y S Y="" I $G(X)?7N.E S Y=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 Q Y
