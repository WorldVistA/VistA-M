IBCNEPY ;DAOU/BHS - eIV PAYER EDIT OPTION ;28-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,416,668,687,732**;21-MAR-94;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Tag HELP1 calls EN^DDIOL
 ; Reference to EN^DDIOL in ICR #10142
 ; Call only from a tag
 ;
EN ; Main entry point
 ; Input:  n/a
 ; Output: Modifies entries in the Payer File (#365.12)
 ;
 ; Initialize variables
 NEW PYRIEN
 ;
 D CLRSCRN
 F  S PYRIEN=$$PAYER() Q:'PYRIEN  D EDIT(PYRIEN)
 ;
ENX ; EN exit point
 Q
 ;
CLRSCRN ;
 W @IOF
 W !?35,"Payer Edit"
 ;/vd-IB*2*687 - Changed the following informative text.
 W !!,?1,"This option displays the data in the Payer file for a given payer. You"
 W !?1,"may only edit site controlled fields and most fields are not site controlled."
 W !?1,"Site controlled fields cannot be edited for a deactivated payer."
 Q
 ;
EDIT(PIEN) ; Modify Payer application settings -/vd-IB*2*687 - Changed the variable IEN to PIEN
 ; Input:  IEN - key to Payer File (#365.12)
 ; Output: Modifies entries in the Payer File
 ;
 ; Initialize variables
 ;NEW IBDATA,LN,APPIEN   ;/vd-IB*2*687 - Replaced this line with the following line.
 ;IB*732/CKB - added ISBLUE
 N ARRAYEIV,ARRAYIIU,DEACT,EIVIENS,IBDATA,IENEIV,IENIIU,IIUIENS,ISBLUE,LN,LNLFT,LNRHT
 ;
 ;S LN=26   ;/vd-IB*2*687 - Replaced this line.
 ;/vd-IB*2*687 - Beginning of new code.
 S IENEIV=$$FIND1^DIC(365.13,,,"EIV"),IENIIU=$$FIND1^DIC(365.13,,,"IIU")
 S LN=40   ;Set LN to center the Payer display
 S LNLFT=27,LNRHT=37 ; Set LEFT and RIGHT column positions for alignment
 ;/vd-IB*2*687 - End of new code.
 ;
 ; Display non-editable fields:
 ;  Payer Name, VA National ID, CMS National ID, Date/Time Created,
 ;  EDI ID Number - Prof., EDI ID Number - Inst.
 S IBDATA=$G(^IBE(365.12,+PIEN,0))    ;/vd-IB*2*687 - Changed the variable IEN to PIEN
 ;
 D CLRSCRN
 W !!,$$FO^IBCNEUT1("Payer Name: ",LN,"R"),$P(IBDATA,U,1)
 W !,$$FO^IBCNEUT1("VA National ID: ",LN,"R"),$P(IBDATA,U,2)
 W !,$$FO^IBCNEUT1("CMS National ID: ",LN,"R"),$P(IBDATA,U,3)
 ;IB*732/CKB - display Blue Payer indicator if populated with 1-YES
 ; NOTE: FSC refers to this field as ISBLUE
 I +$P(IBDATA,U,9) S ISBLUE=$P(IBDATA,U,9) D
 . W !,$$FO^IBCNEUT1("Blue Payer: ",LN,"R"),$S(+ISBLUE:"YES",1:"NO")
 W !,$$FO^IBCNEUT1("Inst Electronic Bill ID: ",LN,"R"),$P(IBDATA,U,6)
 W !,$$FO^IBCNEUT1("Prof Electronic Bill ID: ",LN,"R"),$P(IBDATA,U,5)
 W !,$$FO^IBCNEUT1("Date/Time Created: ",LN,"R"),$$FMTE^XLFDT($P(IBDATA,U,4),"5Z")
 ;
 ;/vd-IB*2.0*687 - Replaced the following commented out lines of code.
 ;**************************************************************************
 ; Edit only the eIV payer application - IB*2*416
 ;IB*668/TAZ - Changed Payer Application from IIV to EIV
 ;S APPIEN=+$$PYRAPP^IBCNEUT5("EIV",+IEN)
 ;I 'APPIEN D  Q
 ;. W !!,"There is no eIV payer application defined for this Payer."
 ;. W ! S DIR(0)="E" D ^DIR K DIR W !
 ;. Q
 ;;
 ;D APPEDIT(+IEN,+APPIEN)       ; +APPIEN is always the eIV payer application
 ;Q
 ;;
 ;APPEDIT(PIEN,AIEN) ; Modify eIV Payer application settings
 ;; Input:  PIEN - key to Payer File (#365.12),
 ;;         AIEN - key to Payer Application File (#365.13) - eIV payer application
 ;; Output: Modifies entries in the Payer File
 ;;
 ;; Initialize variables
 ;;IB*668/TAZ - Added DEACT to NEW statement
 ;NEW DEACT,IBNODE,LN,FDA,DR,DA,DTOUT,DIE,DIRUT,DIR,X,Y
 ;;
 ;; Determine if the application is already defined for the Payer
 ;S LN=35
 ;S IBNODE=$G(^IBE(365.12,+PIEN,1,+AIEN,0))
 ;W !
 ;;
 ;I IBNODE="" W !,"eIV Payer Application not found - ERROR!" S DIR(0)="E" D ^DIR K DIR G APPEDX
 ;;
 ;;IB*668/TAZ - Changed Active to Enabled in field name and display
 ;; Display non-editable fields:
 ;W !,$$FO^IBCNEUT1("Payer Application: ",LN,"R"),"eIV"
 ;W !,$$FO^IBCNEUT1("Nationally Enabled: ",LN,"R"),$S(+$P(IBNODE,U,2):"Enabled",1:"Not Enabled")
 ;;IB*668/TAZ - Changed location for Future and Past Service date as well as Auto-Update
 ;W !,$$FO^IBCNEUT1("Future Service Days: ",LN,"R"),$$GET1^DIQ(365.121,+AIEN_","_PIEN_",",4.03)
 ;W !,$$FO^IBCNEUT1("Past Service Days: ",LN,"R"),$$GET1^DIQ(365.121,+AIEN_","_PIEN_",",4.04)
 ;W !,$$FO^IBCNEUT1("Auto-update Pt. Insurance: ",LN,"R"),$$GET1^DIQ(365.121,+AIEN_","_PIEN_",",4.01)
 ;;IB*668/TAZ - Changed how Deactivated is determined and changed Active to Enabled
 ;; Display deactivation info only when it exists
 ;S DEACT=$$PYRDEACT^IBCNINSU(+PIEN)
 ;I +DEACT D  G APPEDX
 ;. W !,$$FO^IBCNEUT1("Deactivated: ",LN,"R"),$S(+DEACT:"YES",1:"NO")
 ;. W !,$$FO^IBCNEUT1("Deactivation Date/Time: ",LN,"R"),$S(+$P(DEACT,U,2):$$FMTE^XLFDT($P(DEACT,U,2),"5Z"),1:"")
 ;. ; Locally Enabled is non-editable if application is deactivated
 ;. W !,$$FO^IBCNEUT1("Locally Enabled: ",LN,"R"),$S(+$P(IBNODE,U,3):"Enabled",1:"Not Enabled")
 ;;
 ;; Allow user to edit Locally Enabled flag
 ;; Also file the user who edited this local flag and the date/time
 ;S DR=".03                  Locally Enabled;.04////"_$G(DUZ)_";.05////"_$$NOW^XLFDT
 ;S DIE="^IBE(365.12,"_+PIEN_",1,"
 ;S DA=+AIEN,DA(1)=+PIEN
 ;D ^DIE
 ;;
 ;APPEDX Q
 ;/vd-IB*2.0*687 - End of commented out code.
 ;**************************************************************************
 ;/vd-IB*2.0*687 - Beginning of new code. Moved the Deactivation check and display to here
 S DEACT=$$PYRDEACT^IBCNINSU(+PIEN)  ; Get Deactivated data.
 I +DEACT D     ; If deactivated, display the deactivation information.
 . W !,$$FO^IBCNEUT1("Deactivated: ",LN,"R"),$S(+DEACT:"YES",1:"NO")
 . W !,$$FO^IBCNEUT1("Deactivation Date/Time: ",LN,"R"),$S(+$P(DEACT,U,2):$$FMTE^XLFDT($P(DEACT,U,2),"5Z"),1:"")
 ;
 ;/vd-IB*2*687 - Modified the display of applications to handle both eIV and IIU.
 S IENEIV=+$$PYRAPP^IBCNEUT5("EIV",+PIEN)  ; Get the ien of the EIV application
 S IENIIU=+$$PYRAPP^IBCNEUT5("IIU",+PIEN)  ; Get the ien of the IIU application
 ;
 I 'IENEIV,'IENIIU D  Q  ; No applications for this Payer.
 . W !!,"There are no eIV or IIU payer applications defined for this Payer."
 . W ! S DIR(0)="E" D ^DIR K DIR W !
 ;
 K ARRAYEIV,ARRAYIIU
 I IENEIV D
 . D PAYER^IBCNINSU(+PIEN,"EIV","*","E",.ARRAYEIV)   ; Get the Payer's EIV data.
 . S EIVIENS=$O(ARRAYEIV(365.121,""))
 I IENIIU D
 . D PAYER^IBCNINSU(+PIEN,"IIU","*","E",.ARRAYIIU)   ; Get the Payer's IIU data.
 . S IIUIENS=$O(ARRAYIIU(365.121,""))
 I 'IENEIV S LNRHT=LNLFT ; There's no EIV data to display, so the IIU data displays on the left.
 ;
 D APPDSPLY    ; Display the Application(s) data.
 I +DEACT Q    ; Do not attempt to Edit the editable fields if Deactivated.
 D APPEDIT     ; Edit the Application Fields that are editable.
 Q
 ;
APPDSPLY ; Display Application Data
 N DASHES,OFFSET
 S $P(DASHES,"-",80)="-"
 W !!,$$FO^IBCNEUT1("Payer Application: ",LNLFT,"R"),$S(+IENEIV:"eIV",1:"IIU")
 I +IENEIV,+IENIIU S OFFSET=4 W $$FO^IBCNEUT1("Payer Application: ",(LNRHT-OFFSET),"R"),"IIU"
 ;
 W !,$E(DASHES,1,38) I +IENEIV,+IENIIU W ?40,$E(DASHES,1,35)
 W !
 S OFFSET=0
 I +IENEIV D
 . W $$FO^IBCNEUT1("Nationally Enabled: ",LNLFT,"R")
 . W $G(ARRAYEIV(365.121,EIVIENS,.02,"E"))
 . S OFFSET=$L($G(ARRAYEIV(365.121,EIVIENS,.02,"E")))+1
 I +IENIIU D
 . W $$FO^IBCNEUT1("Nationally Enabled: ",(LNRHT-OFFSET),"R")
 . W $G(ARRAYIIU(365.121,IIUIENS,.02,"E"))
 ;
 W !
 S OFFSET=0
 I +IENEIV D
 . W $$FO^IBCNEUT1("Future Service Days: ",LNLFT,"R")
 . W $G(ARRAYEIV(365.121,EIVIENS,4.03,"E"))
 . S OFFSET=$L($G(ARRAYEIV(365.121,EIVIENS,4.03,"E")))+1
 I +IENIIU D
 . W $$FO^IBCNEUT1("IIU Locally Enabled: ",(LNRHT-OFFSET),"R")
 . W $G(ARRAYIIU(365.121,IIUIENS,.03,"E"))
 ;
 W !
 S OFFSET=0
 I +IENEIV D
 . W $$FO^IBCNEUT1("Past Service Days: ",LNLFT,"R")
 . W $G(ARRAYEIV(365.121,EIVIENS,4.04,"E"))
 . S OFFSET=$L($G(ARRAYEIV(365.121,EIVIENS,4.04,"E")))+1
 I +IENIIU D
 . W $$FO^IBCNEUT1("Receive IIU Data: ",(LNRHT-OFFSET),"R")
 . W $G(ARRAYIIU(365.121,IIUIENS,5.01,"E"))
 ;
 I +IENEIV D
 . W !,$$FO^IBCNEUT1("Auto-update Pt. Insurance: ",LNLFT,"R")
 . W $G(ARRAYEIV(365.121,EIVIENS,4.01,"E"))
 . W !,$$FO^IBCNEUT1("eIV Locally Enabled: ",LNLFT,"R")
 . W $G(ARRAYEIV(365.121,EIVIENS,.03,"E"))
 ;
 W !
 Q
 ;
 ;/vd-IB*2*687 - Modified APPEDIT for Editable fields for eIV and IIU applications.
APPEDIT ; Edit the Payer Application fields that are editable.
 N FDA,DR,DA,DTOUT,DIE,DIRUT,DIR,OPTOUT,X,Y
 S OPTOUT=0
 I +IENEIV D  Q:OPTOUT    ; Allow user to edit eIV Locally Enabled flag
 . S DR=".03 eIV App > eIV Locally Enabled"
 . S DR=DR_";.04////"_$G(DUZ)_";.05////"_$$NOW^XLFDT
 . S DIE="^IBE(365.12,"_+PIEN_",1,"
 . S DA=+IENEIV,DA(1)=+PIEN
 . D ^DIE S:$D(Y) OPTOUT=1 K DIE,DA,DR
 ;
 I +IENIIU D    ; Allow user to edit Receive IIU Data field
 . S DR="5.01 IIU App > Receive IIU Data"
 . S DIE="^IBE(365.12,"_+PIEN_",1,"
 . S DA=+IENIIU,DA(1)=+PIEN
 . D ^DIE S:$D(Y) OPTOUT=1 K DIE,DA,DR
 Q
 ;/vd-IB*2.0*687 - End of new code.
 ;
PAYER() ; Select Payer - File #365.12
 ; Init vars
 NEW DIC,DTOUT,DUOUT,X,Y
 ;
 W !!
 ; IB*732/DTG start - change standard DIC call to begins with/contains/list
 ;S DIC(0)="ABEQ"
 ;S DIC("A")=$$FO^IBCNEUT1("Payer Name: ",15,"R")
 ; ; Do not allow editing of '~NO PAYER' entry
 ;S DIC("S")="I $P(^(0),U,1)'=""~NO PAYER"""
 ;S DIC="^IBE(365.12,"
 ;D ^DIC
 ;I $D(DUOUT)!$D(DTOUT)!(Y<1) S Y=""
 ; ;
 ;Q $P(Y,U,1)
 ;
 ; Part 1, begin, contains, list
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILTER,IBA,IBB,IBCT,IBD,IBFND,IBI,IBJ,IBK,IBL,IBLKNM,IBLKUNM,IBN,IBNMA
 N IBNML,IBNMR,IBR,IBTMPA,IBTMPFIL,IBTN
 S IBTMPFIL="^TMP(""IBCNEPY-PALK"","_$J_")"
PAYST ; start of payer questions
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S FILTER=""
 S DIR(0)="SA^B:Begins with;C:Contains;L:List"
 S DIR("A")="Select B, C, or L:  "
 S DIR("A",1)=" B - Payer(s) that Begin with"
 S DIR("A",2)=" C - Payer(s) that Contain"
 S DIR("A",3)=" L - List of all Payers"
 S DIR("A",4)="  "
 S DIR("B")="B"
 S DIR("?")="^D HLPBEG^IBCNEPY",DIR("??")=DIR("?")
 D ^DIR
 S Y=$$UP^XLFSTR(Y)
 S FILTER="",FILTER=$S($E(Y)="B":1,$E(Y)="C":2,$E(Y)="L":3,1:"")
 I Y'=""&('FILTER)&($E(Y)'=U) W "   ??" G PAYST
 I FILTER'=1&(FILTER'=2)&(FILTER'=3) S IBFND="" G PAYX
 I FILTER=3 D PAYLST G PAYST
 ;
 ; Part 2, look up payer from 365.12
PAYNAM ;ask name
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 W !
 S DIR(0)="FO^1-80"
 S DIR("A")="Payer Name"
 S DIR("?")="^D HLPPN^IBCNEPY"
 S DIR("??")=DIR("?")
 D ^DIR
 S IBFND=""
 I Y=""!(Y=-1)!($E(Y)="^")
 I $E(Y)=U!(Y="")!($E(Y)="-") G PAYST
 ;I Y=""!(Y=-1) G PAYX
 S IBLKNM=Y,IBLKUNM=$$UP^XLFSTR(IBLKNM),IBNML=$L(IBLKUNM)
 ;Part 2A - collect names
 K @IBTMPFIL
 S IBFND="",IBNMA="^IBE(365.12,""B""",IBNMR=IBNMA_")"
 S @IBTMPFIL@(0)=0,IBOK=0
 F  S IBNMR=$Q(@IBNMR) Q:IBNMR=""!($E(IBNMR,1,$L(IBNMA))'=IBNMA)  D
 . S IBA=$QS(IBNMR,3),IBN=$QS(IBNMR,4),IBB=$$UP^XLFSTR(IBA)
 . I $E(IBB,1,9)="~NO PAYER" Q
 . S IBOK=$$FILTER^IBCNINSU(IBB,FILTER_U_IBLKUNM)
 . I IBOK D PSET
 ; Part 3 display / select displayed names
 I '@IBTMPFIL@(0) S IBFND="" D  G PAYNAM ; no payer's found
 . W "   No payer names matching criteria found"
 S IBCT=$G(@IBTMPFIL@(0)),IBR="",IBTN=$FN((IBCT/5),"",1),IBR=+$P(IBTN,".",1)*5,IBTN=$P(IBTN,".",2)
 S:IBTN IBR=IBR+5 K IBTMPA
 S IBTN="" I IBCT<6 M IBTMPA=@IBTMPFIL K IBTMPA(0) D  G:IBFND=U PAYST G:'IBFND PAYNAM G PAYX
 . S IBK=IBCT,IBFND=$$PAYD(.IBTMPA,0,IBK)
 S IBK=0
 F IBI=0:5:IBR Q:IBFND!(IBFND=U)  K IBTMPA F IBJ=1:1:5 S IBK=IBI+IBJ D  Q:IBFND!(IBFND=U)!(IBK>IBCT)
 . S IBD=$G(@IBTMPFIL@(IBK)),IBFND="" I IBD'="" S IBTMPA(IBK)=IBD
 . I IBD=""!(IBJ=5) S IBL=$S(IBK<IBCT:1,IBK=IBCT:0,1:0) D
 . . S IBLM=IBK I 'IBL&(IBK>IBCT) S IBLM=IBCT
 . . S IBFND=$$PAYD(.IBTMPA,IBL,IBLM)
 I IBFND=U G PAYST
 I 'IBFND G PAYNAM
 G PAYX
PAYX ; payer lookup exit point
 K @IBTMPFIL
 ;END
 I IBFND=U S IBFND=""
 Q IBFND
 ;
PSET ;set name into tmp array
 N IBC,IBD
 S IBC=@IBTMPFIL@(0)+1,@IBTMPFIL@(0)=IBC
 S @IBTMPFIL@(IBC)=IBA_U_IBN
 Q
 ;
PAYD(IBARY,IBO,IBLM) ; display up to 5 payer's for selection at a time.
 ; IBARY - 5 items to display
 ; IBO - are there more to display
 ;
 I $O(IBARY(0))="" Q ""
 N DIR,DIRUT,DIROUT,IBA,IBB,IBD,IBM,X,Y
 ; array is payer name ^ payer 365.12 ien
 S DIR(0)="LCO^1:"_IBLM,IBA=0 F  S IBA=$O(IBARY(IBA)) Q:'IBA  D
 . S IBD=IBARY(IBA)
 . S IBM=$E($P(IBD,U,1),1,35)
 . W !,?6,IBA,?13,IBM
 S DIR("?")="Enter the Item Number for the Payer desired"
 S DIR("A")="CHOOSE"
 I IBO=1 D
 . S DIR("A",1)="Press "_($S(IBO=1:"<Enter> to see more, ",1:""))_"'^' to exit this list,  OR"
 D ^DIR
 I $E(Y)=U S IBFND=U
 I Y S IBFND=$P(@IBTMPFIL@(+Y),U,2)
 Q IBFND
 ;
HLPBEG ; display help message
 W !,"Select the type of filter to narrow down your list of available Payers:"
 W !,"   Begins with - Displays Payer(s) that begin with the specified text"
 W !,"   Contains    - Displays Payer(s) that contain the specified text"
 W !,"   List        - Displays listing of all Payers"
 Q
 ;
HLPPN ; display help message for payer name
 I FILTER=1 W !,"Enter the Payer's name that you want to Begin With." Q
 I FILTER=2 W !,"Enter the string that you want the Payer's name to Contain." Q
 W !,"Enter Payer Name"
 Q
 ;
PAYLST ; list out payers in payer 'B' index in groups of 20
 ;
 N DIR,DTOUT,DUOUT,IBA,IBC,IBOK,X,Y
 W !,"CHOOSE FROM:"
 S IBA="",IBC=0
 F  S IBA=$O(^IBE(365.12,"B",IBA)) Q:IBA=""  S IBOK=1,IBC=IBC+1 D  Q:'IBOK
 . I IBA="~NO PAYER" Q
 . W !,IBA
 . I IBC#20'=0 Q
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!($D(DUOUT)) S IBOK=0
 W !!
 Q
 ;
 ; IB*732/DTG end - change standard DIC call to begins with/contains/list
HELP1 ;This is the help text for RECEIVE IIU DATA (#365.121,5.01)  ICR #: 10142
 N ARR
 S ARR(1,"F")="!"
 S ARR(1)="This field identifies whether the VA facility is allowing Interfacility"
 S ARR(2,"F")="!"
 S ARR(2)="Insurance Update Data to be received and saved into the buffer for processing."
 S ARR(3,"F")="!"
 S ARR(3)="Enter '1' for YES, show policies received from IIU for this payer in the buffer."
 S ARR(4,"F")="!"
 S ARR(4)="Enter '0' for No, don't show policies received from IIU in the buffer."
 S ARR(5,"F")="!"
 D EN^DDIOL(.ARR)
 Q
