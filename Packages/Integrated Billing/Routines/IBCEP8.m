IBCEP8 ;ALB/TMP/OIFO-BP/RBN - Functions for NON-VA PROVIDER ;11-07-00
 ;;2.0;INTEGRATED BILLING;**51,137,232,288,320,343,374,377,391,400,436,432,476**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; -- main entry point
 N IBNPRV
 K IBFASTXT
 D FULL^VALM1
 D EN^VALM("IBCE PRVNVA MAINT")
 Q
 ;
HDR ; -- header code
 K VALMHDR
 Q
 ;
INIT ; Initialization
 N DIC,DA,X,Y,DLAYGO,IBIF,DIR,DTOUT,DUOUT
 K ^TMP("IBCE_PRVNVA_MAINT",$J)
 ;
 ; if coming in from main routine ^IBCEP6 this special variable IBNVPMIF is set already
 I $G(IBNVPMIF)'="" S IBIF=IBNVPMIF G INIT1
 ;
 S DIR("A")="(I)NDIVIDUAL OR (F)ACILITY?: ",DIR(0)="SA^I:INDIVIDUAL;F:FACILITY" D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) S VALMQUIT=1 G INITQ
 S IBIF=Y
 ;
INIT1 ;
 ;
 ; Begin IB*2.0*436 - RBN
 ;
 ;I IBIF="F" D
 ;. S VALM("TITLE")="Non-VA Lab or Facility Info"
 ;. K VALM("PROTOCOL")
 ;. S Y=$$FIND1^DIC(101,,,"IBCE PRVNVA NONIND MAINT")
 ;. I Y S VALM("PROTOCOL")=+Y_";ORD(101,"
 ;
 ; End IB*2.0*436 - RBN
 ;
 S DIC="^IBA(355.93,",DIC("DR")=".02///"_$S(IBIF'="F":2,1:1)
 S DIC("S")="I $P(^(0),U,2)="_$S(IBIF'="F":2,1:1)
 S DLAYGO=355.93,DIC(0)="AELMQ",DIC("A")="Select a NON"_$S(IBIF="I":"-",1:"/OTHER ")_"VA PROVIDER: "
 D ^DIC K DIC,DLAYGO
 I Y'>0 S VALMQUIT=1 G INITQ
 S IBNPRV=+Y
 ;
 ; *** Begin IB*2.0*436 - RBN
 ;
 N NEWENTRY
 S IBNPRV=+Y,NEWENTRY=$P($G(Y),U,3),IBFLPFLP=0
 I 'NEWENTRY D
 . N DA,X,Y,DIE,DR
 . ;D EN^DDIOL(" ")
 . ;D EN^DDIOL("If you do NOT want to edit the provider name or the provider type,","","!")
 . ;D EN^DDIOL("then press return at the following NAME prompt.  Otherwise,")
 . ;D EN^DDIOL("retype the name as you want it entered into the system.")
 . ;D EN^DDIOL(" ")
 . ;S DA=IBNPRV
 . ;S DIE="^IBA(355.93,"
 . ;S DR=".01"
 . ;D ^DIE
 . D SCREEN(IBNPRV)
 . I $D(Y) S VALMQUIT=1 G INITQ
 . I $G(IBFLPFLP) S IBIF=$S(IBIF="F":"I",1:"F")
 ;
 ; *** End IB*2.0*436 - rbn
 ;
 I IBIF="F" D
 . S VALM("TITLE")="Non-VA Lab or Facility Info"
 . K VALM("PROTOCOL")
 . S Y=$$FIND1^DIC(101,,,"IBCE PRVNVA NONIND MAINT")
 . I Y S VALM("PROTOCOL")=+Y_";ORD(101,"
 D BLD^IBCEP8B(IBNPRV)
INITQ Q
 ;
EXPND ;
 Q
 ;
HELP ;
 Q
 ;
EXIT ;
 K ^TMP("IBCE_PRVNVA_MAINT",$J)
 D CLEAN^VALM10
 K IBFASTXT
 Q
 ;
EDIT1(IBNPRV,IBNOLM) ; Edit non-VA provider/facility demographics
 ; IBNPRV = ien of entry in file 355.93
 ; IBNOLM = 1 if not called from list manager
 ;
 N DA,X,Y,DIE,DR,IBP
 I '$G(IBNOLM) D FULL^VALM1
 I IBNPRV D
 . I '$G(IBNOLM) D CLEAR^VALM1
 . S DIE="^IBA(355.93,",DA=IBNPRV,IBP=($P($G(^IBA(355.93,IBNPRV,0)),U,2)=2)
 . ; PRXM/KJH - Added NPI and Taxonomy to the list of fields to be edited. Put a "NO^" around the Taxonomy multiple (#42) since some of the sub-field entries are 'required'.
 . ; Begin IB*2.0*436 - RBN
 . ;S DR=".01;"_$S(IBP:".03;.04",1:".05;.1;.06;.07;.08;.13///24;W !,""ID Qualifier: 24 - EMPLOYER'S IDENTIFICATION #"";.09Lab or Facility Primary ID;.11;.15")_";D PRENPI^IBCEP81(IBNPRV);D EN^IBCEP82(IBNPRV);S DIE(""NO^"")="""";42;K DIE(""NO^"")"
 . ;S DR=$S(IBP:".03;.04",1:".05;.1;.06;.07;.08;.13///24;W !,""ID Qualifier: 24 - EMPLOYER'S IDENTIFICATION #"";.09Lab or Facility Primary ID;.11;.15")_";D PRENPI^IBCEP81(IBNPRV);D EN^IBCEP82(IBNPRV);S DIE(""NO^"")="""";42;K DIE(""NO^"")"
 . ; End IB*2.0*436 - RBN
 . ;IB*2.0*432  - add contact phone and name
 . S DR=$S(IBP:".03;.04",1:".05;.1;.06;.07;.08;1.01;I X="""" S Y=""@2"";1.02R;S Y=""@3"";@2;1.02;@3;1.03;.13///24;W !,""ID Qualifier: 24 - EMPLOYER'S IDENTIFICATION #"";.09Lab or Facility Primary ID;.11;.15")
 . ;IB*2.0*476 - Add FEE BASIS allow multiple value
 . ;S DR=DR_";D PRENPI^IBCEP81(IBNPRV);D EN^IBCEP82(IBNPRV);S DIE(""NO^"")="""";42;K DIE(""NO^"")"
 . S DR=DR_";D PRENPI^IBCEP81(IBNPRV);D EN^IBCEP82(IBNPRV);S DIE(""NO^"")="""";42;K DIE(""NO^"");D FBTGLSET^IBCEP8C1(IBNPRV)"
 . D ^DIE
 . Q:$G(IBNOLM)
 . D BLD^IBCEP8B(IBNPRV)
 I '$G(IBNOLM) K VALMBCK S VALMBCK="R"
 Q
 ;
EDITID(IBNPRV,IBSLEV) ; Link from this list template to maintain provider-specific ids
 ; This entry point is called by 4 action protocols.
 ; IBNPRV = ien of entry in file 355.93 (can be either an individual or a facility) (required)
 ; IBSLEV = 1 for facility/provider own ID's
 ; IBSLEV = 2 for facility/provider ID's furnished by an insurance company
 ;
 Q:'$G(IBNPRV)
 Q:'$G(IBSLEV)
 N IBPRV,IBIF
 D FULL^VALM1    ; set full scrolling region
 D CLEAR^VALM1   ; clear screen
 S IBPRV=IBNPRV
 ;
 K IBFASTXT
 S IBIF=$$GET1^DIQ(355.93,IBPRV,.02,"I")    ; 1=facility/group      2=individual
 D EN^VALM("IBCE PRVPRV MAINT")
 ;
 K VALMQUIT
 S VALMBCK=$S($G(IBFASTXT)'="":"Q",1:"R")
 Q
 ;
NVAFAC ; Enter/edit Non-VA facility information
 ; This entry point is called by the menu system for option IBCE PRVNVA FAC EDIT
 N X,Y,DA,DIC,IBNPRV,DLAYGO
 S DIC="^IBA(355.93,",DIC("S")="I $P(^(0),U,2)=1",DIC("DR")=".02///1"
 S DLAYGO=355.93,DIC(0)="AELMQ",DIC("A")="Select a NON/Other VA FACILITY: "
 D ^DIC K DIC,DLAYGO
 I Y'>0 S VALMQUIT=1 G NVAFACQ
 S IBNPRV=+Y
 D EDIT1(IBNPRV,1)
 ;
NVAFACQ Q
 ;
GETFAC(IB,IBFILE,IBELE,CSZLEN) ; Returns facility name, address lines or city-state-zip
 ;        IB = ien of entry in file
 ;    IBFILE = 0 for retrieval from file 4, 1 for retrieval from file 355.93
 ;  If IBELE = 0, returns name
 ;           = 1, returns address line 1
 ;           = 2, returns address line 2
 ;           = 12, returns address lines 1 and 2 together
 ;           = 3, returns city, state zip
 ;           = "3C", returns city    = "3S", state    = "3Z", zip
 ;    CSZLEN = max length allowed for city,st,zip string - Only applies when IBELE=3
 ;
 N Z,IBX,IC,IS,IZ,DIFF
 S IBX=""
 ;
 S Z=$S('IBFILE:$G(^DIC(4,+IB,1)),1:$G(^IBA(355.93,+IB,0)))
 I +IBELE=0 S IBX=$S('IBFILE:$P($G(^DIC(4,+IB,0)),U),1:$P($G(^IBA(355.93,+IB,0)),U))
 I IBELE=1!(IBELE=12) S IBX=$S('IBFILE:$P(Z,U),1:$P(Z,U,5))
 I IBELE=2!(IBELE=12) S IBX=$S(IBELE=12:IBX_" ",1:"")_$S('IBFILE:$P(Z,U,2),1:$P(Z,U,10))
 ;
 I +IBELE=3 D
 . I 'IBFILE S IC=$P(Z,U,3),IS=$$STATE^IBCEFG1($P($G(^DIC(4,+IB,0)),U,2)),IZ=$P(Z,U,4)
 . I IBFILE S IC=$P(Z,U,6),IS=$$STATE^IBCEFG1($P(Z,U,7)),IZ=$P(Z,U,8)
 . ;
 . I IBELE="3C" S IBX=IC Q
 . I IBELE="3S" S IBX=IS Q
 . I IBELE="3Z" S IBX=IZ Q
 . ;
 . S IBX=$$CSZ(IC,IS,IZ,+$G(CSZLEN))    ; build the city, st zip string since IBELE=3 here
 . Q
 ;
GETFACX ;
 Q IBX
 ;
CSZ(IC,IS,IZ,CSZLEN) ; build city, state, zip string
 ; IC - city
 ; IS - state abbreviation
 ; IZ - zip
 ; CSZLEN - max length allowed for city, st zip string
 ;
 NEW IBX,DIFF
 ;
 ; build the full city, st zip string
 S IBX=IC_$S(IC'="":", ",1:"")_IS_" "_IZ
 ;
 I '$G(CSZLEN) G CSZX          ; no max length to worry about
 I $L(IBX)'>CSZLEN G CSZX      ; length is OK so get out
 ;
 ; string is too long so try to shorten the zip if it has a dash
 I IZ["-" S IZ=$P(IZ,"-",1),IBX=IC_$S(IC'="":", ",1:"")_IS_" "_IZ I $L(IBX)'>CSZLEN G CSZX
 ;
 ; string is still too long so truncate the city name until it fits
 S DIFF=$L(IBX)-CSZLEN
 S IC=$E(IC,1,$L(IC)-DIFF)
 S IBX=IC_$S(IC'="":", ",1:"")_IS_" "_IZ
CSZX ;
 Q IBX
 ;
ALLID(IBPRV,IBPTYP,IBZ) ; Returns array IBZ for all ids for provider IBPRV
 ; for all provider id types or for id type in IBPTYP
 ; IBPRV = vp ien of provider
 ; IBPTYP = ien of provider id type to return or "" for all
 ; IBZ = array returned with internal data:
 ;  IBZ(file 355.9 ien)=ID type^ID#^ins co^form type^bill care type^care un^X12 code for id type
 N Z,Z0
 K IBZ
 G:'$G(IBPRV) ALLIDQ
 S IBPTYP=$G(IBPTYP)
 S Z=0 F  S Z=$O(^IBA(355.9,"B",IBPRV,Z)) Q:'Z  S Z0=$G(^IBA(355.9,Z,0)) D
 . I $S(IBPTYP="":1,1:($P(Z0,U,6)=IBPTYP)) S IBZ(Z)=($P(Z0,U,6)_U_$P(Z0,U,7)_U_$P(Z0,U,2)_U_$P(Z0,U,4)_U_$P(Z0,U,5)_U_$P(Z0,U,3))_U_$P($G(^IBE(355.97,+$P(Z0,U,6),0)),U,3)
 ;
ALLIDQ Q
 ;
CLIA() ; Returns ien of CLIA # provider id type
 N Z,IBZ
 S (IBZ,Z)=0 F  S Z=$O(^IBE(355.97,Z)) Q:'Z  I $P($G(^(Z,0)),U,3)="X4",$P(^(0),U)["CLIA" S IBZ=Z Q
 Q IBZ
 ;
STLIC() ; Returns ien of STLIC# provider id type
 N Z,IBZ
 S (IBZ,Z)=0 F  S Z=$O(^IBE(355.97,Z)) Q:'Z  I $P($G(^(Z,1)),U,3) S IBZ=Z Q
 Q IBZ
 ;
TAXID() ; Returns ien of Fed tax id provider id type
 N Z,IBZ
 S (IBZ,Z)=0 F  S Z=$O(^IBE(355.97,Z)) Q:'Z  I $P($G(^(Z,1)),U,4) S IBZ=Z Q
 Q IBZ
 ;
CLIANVA(IBIFN) ; Returns CLIA # for a non-VA facility on bill ien IBIFN
 N IBCLIA,IBZ,IBNVA,Z
 S IBCLIA="",IBZ=$$CLIA()
 I IBZ D
 . S IBNVA=$P($G(^DGCR(399,IBIFN,"U2")),U,10) Q:'IBNVA
 . S IBCLIA=$$IDFIND^IBCEP2(IBIFN,IBZ,IBNVA_";IBA(355.93,","",1)
 Q IBCLIA
 ;
VALFAC(X) ; Function returns 1 if format is valid for X12 facility name
 ; Alpha/numeric/certain punctuation valid.  Must start with an Alpha
 N OK,VAL
 S OK=1
 S VAL("A")="",VAL("N")="",VAL=",.- "
 I $E(X)'?1A!'$$VALFMT(X,.VAL) S OK=0
 Q OK
 ;
VALFMT(X,VAL) ; Returns 1 if format of X is valid, 0 if not
 ; X = data to be examined
 ; VAL = a 'string' of valid characters AND/OR (passed by reference)
 ;    if VAL("A") defined ==> Alpha
 ;    if VAL("A") defined ==> Numeric valid
 ;    if VAL("A") defined ==> Punctuation valid
 ;   any other character included in the string is checked individually
 N Z
 I $D(VAL("A")) D
 . N Z0
 . F Z=1:1:$L(X) I $E(X,Z)?1A S Z0(Z)=""
 . S Z0="" F  S Z0=$O(Z0(Z0),-1) Q:'Z0  S $E(X,Z0)=""
 I $D(VAL("N")) D
 . N Z0
 . F Z=1:1:$L(X) I $E(X,Z)?1N S Z0(Z)=""
 . S Z0="" F  S Z0=$O(Z0(Z0),-1) Q:'Z0  S $E(X,Z0)=""
 I $D(VAL("P")) D
 . N Z0
 . F Z=1:1:$L(X) I $E(X,Z)?1P S Z0(Z)=""
 . S Z0="" F  S Z0=$O(Z0(Z0),-1) Q:'Z0  S $E(X,Z0)=""
 I $G(VAL)'="" S X=$TR(X,VAL,"")
 Q (X="")
 ;
PS(IBXSAVE) ; Returns 1 if IBXSAVE("PSVC") indicates the svc was non-lab
 ; 
 Q $S($G(IBXSAVE("PSVC"))="":0,1:"13"[IBXSAVE("PSVC"))
 ;
 ; Pass in the Internal Entry number to File 355.93
 ; Return the Primary ID and Qualifier (ID Type) from 355.9
PRIMID(IEN35593) ; Return External Primary ID and ID Quailier
 N INDXVAL,LIST,MSG,IDCODE
 S INDXVAL=IEN35593_";IBA(355.93,"
 N SCREEN S SCREEN="I $P(^(0),U,8)"
 D FIND^DIC(355.9,,"@;.06EI;.07","Q",INDXVAL,,,SCREEN,,"LIST","MSG")
 I '+$G(LIST("DILIST",0)) Q ""   ; No Primary ID
 I +$G(LIST("DILIST",0))>1 Q "***ERROR***^***ERROR***"  ; Bad.  More than one. 
 ; Found just one
 S IDCODE=$$GET1^DIQ(355.97,LIST("DILIST","ID",1,.06,"I"),.03)
 Q $G(LIST("DILIST","ID",1,.07))_U_IDCODE_" - "_$G(LIST("DILIST","ID",1,.06,"E"))
 ;
 ; Begin IB*2.0*436 - RBN
 ;
PRVFMT ;  called only by the INPUT TRANSFORM of #355.93,.01
 ;      no other calls are allowed to this tag
 ;
 ; DSS/SCR 032812 PATCH 476 : Modified to support FB PAID TO IB background job
 ;
 ; DESCRIPTION  : Sets the NAME (.01) and the ENTITY TYPE (.02) fields
 ;                of file 355.93.  Allows the user to change the ENTITY
 ;                TYPE and forces reentry of the provider data so
 ;                that it matches the ENTITY TYPE,if changes are being 
 ;                made through IB menues.  Also formats the 
 ;                NAME to correspond to the ENTITY TYPE. Disallows
 ;                changing of the NAME field from ANYWHERE other than
 ;                PROVIDER ID MAINTENANCE or IB EDIT BILLING INFO 
 ;                (billing screens) or FB AUTO INTERFACE TO IB.  
 ;                Adding new entries directly from FileMan is no longer permitted.
 ; 
 ; INPUTS       : Variables set by user selected option, screen actions
 ;                and user input:
 ;                X        - Provider name passed in by .01 field input
 ;                           transform.
 ;                XQY0     - IB option selected by the user OR "FB PAID TO IB"
 ;                DA       - IEN of the record selected by the user or provided 
 ;                            by the OPTION: FB PAID TO IB
 ;                IBNVPMIF - ENTITY TYPE flag passed in from ListManager or provided 
 ;                           by the OPTION: FB PAID TO IB
 ;                           (F=Facility,I=Individual).
 ;                IBSCNN   - IB variable indication of the actions/submenu:
 ;                           #3, #4, and #7 found on bill screen #8  OR "" for FB PAID TO IB
 ;
 ; OUTPUTS      : IBFLPFLP - Indicate that the user is changing the
 ;                           ENTITY TYPE (flip flop).  Possible states:
 ;
 ;                   IBFLPFLP = 0 - The type was not changed.
 ;                            = 1 - The type changed to facility type.
 ;                            = 2 - The type changed to individual type.
 ;
 ; 
 ; GLOBALS      : ^IBA(355.93  - IB NON/OTHER VA BILLING PROVIDER file
 ; 
 ; 
 ;
 N OKRTN,IBNAM,IBCEPDA,IBTYPE
 S (IBFLPFLP,OKRTN)=0,IBNAM=X,IBCEPDA=$G(DA)
 ;
 ; Prevent modification of NAME (#.01) in file #355.93 from anywhere
 ; but the PROVIDER ID MAINTENANCE or IB EDIT BILLING INFO screens.
 ;
 I $P($G(XQY0),U,1)="IB EDIT BILLING INFO" D PRVINIT,PRVMANT S OKRTN=1
 I $P($G(XQY0),U,1)="IBCE PROVIDER MAINT" D PRVINIT,PRVMANT S OKRTN=1
 ;
 I $P($G(XQY0),U,1)="IB AUTO INTERFACE FROM FB" D EPTRANS^IBCEP8C() S OKRTN=1  ;IB*2.0*476
 ;
 I 'OKRTN K X
 Q
 ;==========================
PRVINIT ; initialization
 ;
 ; If arriving from the billing screens (IBSCNN is 3 or 4) the
 ; variable DA is the ien of the bill (file #399) - need to find the ien
 ; of 355.93 of the provider that the user entered/selected
 ;
 ; *** Begin IB*2.0*436 -RBN ***
 ;I $G(IBSCNN)=3!($G(IBSCNN)=4) S IBCEPDA=$O(^IBA(355.93,"B",IBNAM,"")),IBTYPE=$S(IBSCNN=3:2,1:1)
 I $G(IBDR20),'$G(IBCEP6FL) S IBCEPDA=$O(^IBA(355.93,"B",IBNAM,"")),IBTYPE=$S(IBDR20=84:1,IBDR20=104:1,1:2)
 ; *** End IB*2.0*436 -RBN ***
 ;
 ; If arriving from the Provider ID Maintenance call (billing screen or
 ; direct call to the option) & the user entered a brand new record, the
 ; IBNVPMIF variable is set to indicate if the user was entering a
 ; Non-VA facility ("F") or a Non-VA Provider (ie. individual) ("I")
 I '$G(IBCEPDA)&$D(IBNVPMIF) S IBTYPE=$S(IBNVPMIF="F":1,1:2)
 ;
 ; If arriving from the Provider ID Maintenance call (billing screen or
 ; direct call to the option) & the user selected an existing record
 I $G(IBCEPDA) S IBTYPE=$P($G(^IBA(355.93,IBCEPDA,0)),U,2)
 Q
 ;----------------------------
PRVMANT ; is the user flipping the provider type (for existing records only)
 N TXT,TXT2,%
 ;
 ; IBTYPE - based on the current value of provider type (#355.93,.02)
 ;          where "1" = Facility/Group  & "2" = Individual
 ;
 I '$G(IBTYPE) Q    ; one of the calls that triggers this routine needs
 ;               ; this check when creating a new record in file #355.93
 ;
 ; If record is not brand new (IBCEPDA exists) - give the user the
 ; opportunity to change the provider type field (#355.93,.02)
 I IBTYPE,$G(IBCEPDA) D
 . ;
 . S %=2  ; Default answer is no
 . ;
 . I IBTYPE=1 S TXT="Facility",TXT2="Individual/Provider"
 . I IBTYPE=2 S TXT="Individual/Provider",TXT2="Facility"
 . ;
 . D EN^DDIOL("This provider name exists and is a "_TXT_".","","!")
 . D EN^DDIOL("Do you want to change this record to be a "_TXT2)
 . ;
 . D YN^DICN
 . ;
 . I %=1 D
 . . ;
 . . S IBTYPE=$S(IBTYPE=1:2,1:1),IBFLPFLP=IBTYPE
 ;
 I IBTYPE=2 D STDNAME^XLFNAME(.IBNAM,"GP") S X=IBNAM
 I IBTYPE=1,('$$VALFAC^IBCEP8(IBNAM)) K X
 Q
 ;
 ; DESCRIPTION: This routine inputs a provider name and formats it appropriately as an 
 ;              individual or a facility name.
 ; 
 ; INPUTS     : name
 ; 
 ; OUTPUTS    : formatted name and provider type
 ; 
 ; VARIABLES  :
 ; 
 ; GLOBALS      : 
 ; 
 ; FUNCTIONS    : None
 ; 
 ; SUBROUTINES  : 
 ; 
 ; HISTORY    : Original version - 21 September 2010
 ;
SCREEN(IBNPRV) ;
 N IBNPRVN,IBNAME,DR,DIR,DA,DIRUT,X,DTOUT,DUOUT
 S IBNPRVN=""
 D EN^DDIOL(" ")
 D EN^DDIOL("If you do NOT want to edit the provider name or the provider type,","","!")
 D EN^DDIOL("then press return at the following NAME prompt.  Otherwise,")
 D EN^DDIOL("retype the name as you want it entered into the system.")
 D EN^DDIOL(" ")
 ;
 ; Get the current provider name
 ;
 S IBNAME=$P(^IBA(355.93,IBNPRV,0),U,1)
 ;
 ; Get the user's input
 ;
INPUT ;
 S DIR(0)="FOUr^3:30"
 S DIR("A")="NAME: "_IBNAME_"//"
 ;
 S DIR("?")=" "
 S DIR("?",1)="Press <ENTER> to accept the displayed provider name"
 S DIR("?",2)="or enter the name as you would like it displayed."
 ;
 S DIR("??")="IB PROV ID MAINT^"
 ;
 D ^DIR
 ;
 Q:$D(DTOUT)!$D(DUOUT)
 I X["?" G INPUT
 S:'$D(DIRUT) IBNPRVN=X
 ; The user entered something else
 ;
 S DIE="^IBA(355.93,"
 S DA=IBNPRV
 S DR=".01///"_IBNPRVN
 D ^DIE
 Q
 ;
 ; End IB*2.0*436 - RBN
 ;
