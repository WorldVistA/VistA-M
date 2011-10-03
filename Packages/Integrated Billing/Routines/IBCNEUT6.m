IBCNEUT6 ;DAOU/ESG - IIV MISC. UTILITIES ;14-AUG-2002
 ;;2.0;INTEGRATED BILLING;**184,252,271**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Can't be called from the top
 Q
 ;
AMCHECK ; This procedure will examine the insurance company names in the 
 ; Auto Match file (#365.11) to make sure there is still at least
 ; one active insurance company with that name.  If there isn't,
 ; then the Auto Match entries for that insurance company name
 ; will be deleted.
 ;
 NEW NAME,INSIEN,FOUNDACT,DA,DIK,DIC,X,Y,%
 S NAME=""
 F  S NAME=$O(^IBCN(365.11,"C",NAME)) Q:NAME=""  D
 . ;
 . ; For this Auto Match ins co name, see if there is an active ins co
 . S INSIEN=0,FOUNDACT=0
 . F  S INSIEN=$O(^DIC(36,"B",NAME,INSIEN)) Q:'INSIEN  I $$ACTIVE^IBCNEUT4(INSIEN) S FOUNDACT=1 Q
 . ;
 . ; If an active ins co was found, then we're OK so quit
 . I FOUNDACT Q
 . ;
 . ; Otherwise, we need to delete all Auto Match entries for this name
 . S DA=0,DIK="^IBCN(365.11,"
 . F  S DA=$O(^IBCN(365.11,"C",NAME,DA)) Q:'DA  D ^DIK
 . Q
AMCHKX ;
 Q
 ;
 ;
AMADD(INSNAME,IBCNEXT1) ; Conditionally add an Auto Match entry based on user input
 ; Input Parameters:
 ;    INSNAME is a valid, active insurance company name
 ;   IBCNEXT1 is the existing entry in the ins co name field in the
 ;            buffer.  This may be used as the Auto Match value for
 ;            a new auto match entry.
 ;
 NEW AMDATA,AMIEN,AMERROR
 NEW DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 NEW D,D0,D1,DA,DB,DC,DDH,DE,DG,DH,DI,DIC,DIE,DIEL,DIFLD,DIG,DIH
 NEW DIK,DILN,DIPA,DISYS,DIV,DK,DL,DM,DN,DOV,DP,DQ,DR,DU,DV,DZ
 ;
 ; First, check security key to see if user is allowed to do this
 I '$$KCHK^XUSRB("IBCNE IIV AUTO MATCH") G AMADDX
 ;
 S IBCNEXT1=$$UP^XLFSTR(IBCNEXT1)               ; all uppercase
 S IBCNEXT1=$$TRIM^XLFSTR(IBCNEXT1)             ; lead/trail spaces
 I IBCNEXT1="" G AMADDX                         ; must exist
 I $L(IBCNEXT1)>30!($L(IBCNEXT1)<3) G AMADDX    ; too long or too short
 I IBCNEXT1=INSNAME G AMADDX                    ; cannot equal the name
 I $D(^IBCN(365.11,"B",IBCNEXT1)) G AMADDX      ; already in Auto Match
 I $D(^DIC(36,"B",IBCNEXT1)) G AMADDX           ; already an ins co name
 I $D(^DIC(36,"C",IBCNEXT1)) G AMADDX           ; already a synonym
 I IBCNEXT1["*" G AMADDX                        ; no wildcards allowed
 ;
 S DIR(0)="YO"
 S DIR("A",1)=" "
 S DIR("A",2)="Do you want to add an Auto Match entry that associates"
 S DIR("A")=IBCNEXT1_" with "_INSNAME
 S DIR("B")="No"
 S DIR("?",1)="      The Auto Match Value is "_IBCNEXT1_"."
 S DIR("?",2)="The Insurance Company Name is "_INSNAME_"."
 S DIR("?",3)=" "
 S DIR("?",4)="Please enter NO if you do not want to associate these two values together"
 S DIR("?",5)="in the Auto Match file."
 S DIR("?",6)=" "
 S DIR("?",7)="Please enter YES if you do want to create an Auto Match entry for these"
 S DIR("?",8)="two values.  If you enter YES, then you will have the chance to modify"
 S DIR("?")="the Auto Match Value."
 D ^DIR K DIR
 D EN^DDIOL(,,"!!")
 ;
 ; If user didn't say Yes, then we exit
 I 'Y G AMADDX
 ; To allow for edits to the .01 field and not the .02 field,
 ; Add this new entry first and then edit only the .01 field.
 S AMDATA(365.11,"+1,",.01)=IBCNEXT1
 S AMDATA(365.11,"+1,",.02)=INSNAME
 S AMDATA(365.11,"+1,",.03)=$$NOW^XLFDT
 S AMDATA(365.11,"+1,",.04)=DUZ
 S AMDATA(365.11,"+1,",.05)=$$NOW^XLFDT
 S AMDATA(365.11,"+1,",.06)=DUZ
 S AMDATA(365.11,"+1,",.07)=IBCNEXT1
 S AMDATA(365.11,"+1,",.08)=INSNAME
 D UPDATE^DIE("","AMDATA","AMIEN","AMERROR")
 ;
 I $D(AMERROR) G AMADDX       ; FileMan error so get out
 S AMIEN=+$G(AMIEN(1))        ; internal entry number created
 I 'AMIEN G AMADDX            ; if IEN not there get out
 ;
 ; Here we have to edit the entry to allow for the opportunity to 
 ; change something
 S DIE=365.11,DA=AMIEN,DR=".01;.05////"_$$NOW^XLFDT_";.06////"_DUZ
 D ^DIE
 ;
 ; Display the confirmation message to the user
 S AMDATA=$G(^IBCN(365.11,AMIEN,0))
 I AMDATA'="" D EN^DDIOL($P(AMDATA,U,1)_" is now associated with "_$P(AMDATA,U,2)_".",,"!!?3")
 D EN^DDIOL(,,"!!")
AMADDX ;
 Q
 ;
PYRFLTR() ;
 ; Function to assist with filtering items in custom payer
 ; lookups for most popular list.  This logic is used in the
 ; DIC("S") definition for the lookup
 ;
 NEW IBDATA,IBPIEN,IBPNM,IBAIEN,IBADATA,OK
 ;
 S OK=1
 ;
 S IBDATA=^(0)   ; Naked reference from DIC call
 S IBPIEN=$G(Y) I IBPIEN="" S OK=0 G XPFLTR
 ;
 ; Set Payer Name and IEN
 S IBPNM=$P(IBDATA,U,1) I IBPNM="" S OK=0 G XPFLTR
 ;
 ; Set Payer Application IEN (365.13)
 ;  Quit if IIV not defined for payer
 S IBAIEN=$$PYRAPP^IBCNEUT5("IIV",IBPIEN) I IBAIEN="" S OK=0 G XPFLTR
 ;
 ; Get IIV application specific data
 S IBADATA=$G(^IBE(365.12,IBPIEN,1,IBAIEN,0)) I IBADATA="" S OK=0 G XPFLTR
 ;
 ; Filter if Deactivated
 I +$P(IBADATA,U,11) S OK=0 G XPFLTR
 ;
 ; Filter if ID Inq Req ID and SSN is not ID
 I +$P(IBADATA,U,8),'$P(IBADATA,U,9) S OK=0 G XPFLTR
 ;
 ; Filter if already in the list
 I $D(^TMP($J,"IBJPI3-IENS",IBPIEN)) S OK=0 G XPFLTR
 ;
XPFLTR Q OK
 ;
DSPLINE() ;
 ; Format display text for custom Most Pop. payer lookup
 ;
 N ITEMDATA,DISPSTR,IBAIEN,IBADATA,PYRIEN,PADLEN
 ;
 ; Initialize the data for the item to be displayed
 ; Naked reference is referencing the DIC data
 S ITEMDATA=^(0)
 ;
 ; Initialize Display string
 S DISPSTR=""
 ;
 ; Payer IEN is passed from DIC as Y
 S PYRIEN=+$G(Y) I 'PYRIEN G EXDSP
 ;
 ; Set Payer Application IEN (365.13)
 S IBAIEN=$$PYRAPP^IBCNEUT5("IIV",PYRIEN) I IBAIEN="" G EXDSP
 ;
 ; Get IIV Application specific data
 S IBADATA=$G(^IBE(365.12,PYRIEN,1,IBAIEN,0)) I IBADATA="" G EXDSP
 ;
 ; Pad start of display data, adjusting for payer name length
 S PADLEN=$L($E($P($G(ITEMDATA),U),1,30))
 S DISPSTR=DISPSTR_$$FO^IBCNEUT1("",31-PADLEN,"L")
 ;
 ; Add National and Local active flags
 S DISPSTR=DISPSTR_"  National: "_$$FO^IBCNEUT1($S('$P(IBADATA,U,2):"Inactive",1:"Active"),8)
 S DISPSTR=DISPSTR_"  Local: "_$$FO^IBCNEUT1($S('$P(IBADATA,U,3):"Inactive",1:"Active"),8)
EXDSP ;
 Q DISPSTR
 ;
