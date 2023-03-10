PXAIPRVV ;ISL/JVS,PKR - VALIDATE PROVIDER DATA ;11/19/2021
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**27,186,211,217**;Aug 12, 1996;Build 134
 ;
ERRSET ;Set the rest of the error data.
 S STOP=1
 S PXAERRF("PRV")=1
 S PXADI("DIALOG")=8390001.001
 S PXAERR(7)="PROVIDER"
 Q
 ;
PRIM(VISITIEN,PXADATA,PXAERRF,PXAPREDT) ;Check there is only one primary
 ;provider.
 N EPRIM,IND,NPPE,NPPN,NPPT,NPRIM,PPEDIT,PPLISTE,PPLISTN,PROVIEN
 N STOP,TEMP,VPRVIEN
 S (NPPE,VPRVIEN)=0
 F  S VPRVIEN=$O(^AUPNVPRV("AD",VISITIEN,VPRVIEN)) Q:VPRVIEN=""  D
 . S TEMP=^AUPNVPRV(VPRVIEN,0)
 . S PROVIEN=$P(TEMP,U,1)
 . I $P(TEMP,U,4)="P" S PPLISTE(PROVIEN)=""
 ;
 S (IND,PPEDIT)=0
 F  S IND=+$O(@PXADATA@("PROVIDER",IND)) Q:IND=0  D
 . S PROVIEN=@PXADATA@("PROVIDER",IND,"NAME")
 . I PROVIEN="" Q
 .;Check for changes to the existing primary provider.
 . I $D(PPLISTE(PROVIEN)) D  Q
 .. I +$G(@PXADATA@("PROVIDER",IND,"DELETE"))=1 D  Q
 ... S PPEDIT=1 K PPLISTE(PROVIEN)
 .. I +$G(@PXADATA@("PROVIDER",IND,"PRIMARY"))=0 S PPEDIT=1 K PPLISTE(PROVIEN)
 .;
 .;Check for adding a new primary provider.
 . I +$G(@PXADATA@("PROVIDER",IND,"PRIMARY"))=1 S PPLISTN(PROVIEN)=""
 . I +$G(@PXADATA@("PROVIDER",IND,"DELETE"))=1 K PPLISTN(PROVIEN)
 ;
 S NPPE=0,PROVIEN=""
 F  S PROVIEN=$O(PPLISTE(PROVIEN)) Q:PROVIEN=""  S NPPE=NPPE+1,EPRIM(NPPE)=PROVIEN
 S NPPN=0,PROVIEN=""
 F  S PROVIEN=$O(PPLISTN(PROVIEN)) Q:PROVIEN=""  S NPPN=NPPN+1,NPRIM(NPPN)=PROVIEN
 ;
 I NPPE>1 D  Q
 . S PXAERR(9)="PROVIDER"
 . S PXAERR(11)="VISIT IEN="_VISITIEN
 . S PXAERR(12)="This encounter already has "_NPPE_" primary provider(s), there can only be one."
 . S PXAERR(12)=PXAERR(12)_" They are: "
 . F IND=1:1:NPPE S PXAERR(12)=PXAERR(12)_$S(IND=1:" ",1:", ")_EPRIM(IND)
 . D ERRSET
 ;
 I (PPEDIT=1),($G(PXAPREDT)'=1) D
 . S PXAERR(9)="PPEDIT"
 . S PXAERR(11)=$G(PXAPREDT)
 . S PXAERR(12)="Attempting to edit primary provider and PPEDIT is not 1."
 . D ERRSET
 ;
 I NPPN>1 D  Q
 . S PXAERR(9)="PROVIDER"
 . S PXAERR(11)="VISIT IEN="_VISITIEN
 . S PXAERR(12)="Attempting to add "_NPPN_" primary provider(s), there can only be one."
 . S PXAERR(12)=PXAERR(12)_" They are: "
 . F IND=1:1:NPPN S PXAERR(12)=PXAERR(12)_$S(IND=1:" ",1:", ")_NPRIM(IND)
 . D ERRSET
 ;
 S NPPT=NPPE+NPPN
 I NPPT>1 D  Q
 . S PXAERR(9)="PROVIDER"
 . S PXAERR(12)=NPPT_" providers have been designated as primary, there can only be one."
 . S PXAERR(12)=PXAERR(12)_" They are:"
 . F IND=1:1:NPPE S PXAERR(12)=PXAERR(12)_$S(IND=1:" ",1:", ")_EPRIM(IND)
 . F IND=1:1:NPPN S PXAERR(12)=PXAERR(12)_$S(IND=1:" ",1:", ")_NPRIM(IND)
 . D ERRSET
 Q
 ;
VAL ;Validate the input.
 I $G(PXAA("NAME"))="" D  Q
 . S PXAERR(9)="PROVIDER"
 . S PXAERR(12)="The provider is missing."
 . D ERRSET
 ;
 ;If this is a deletion no further verification is required.
 I $G(PXAA("DELETE"))=1 Q
 ;
 ;Verify that the provider is valid.
 I '$$VPRV^PXAIPRVV(PXAA("NAME"),.PXAA,.PXAERR,PXAVISIT) D ERRSET Q
 ;
 ;If there are comments check the length.
 ;* I $G(PXAA("COMMENT"))'="",'$$TEXT^PXAIVAL("COMMENT",PXAA("COMMENT"),1,245) D
 ;* . D ERRSET
 ;
 ;If PKG is input verify it.
 ;* I $G(PXAA("PKG"))'="" D
 ;* . N PKG
 ;* . S PKG=$$VPKG^PXAIVAL(PXAA("PKG"),.PXAERR)
 ;* . I PKG=0 S PXAERR(9)="PKG" D ERRSET Q
 ;* . S PXAA("PKG")=PKG
 ;* I $G(STOP)=1 Q
 ;
 ;If SOURCE is input verify it.
 ;* I $G(PXAA("SOURCE"))'="" D
 ;* . N SRC
 ;* . S SRC=$$VSOURCE^PXAIVAL(PXAA("SOURCE"),.PXAERR)
 ;* . I SRC=0 S PXAERR(9)="SOURCE" D ERRSET Q
 ;* . S PXAA("SOURCE")=SRC
 Q
 ;
VPRV(PXDUZ,PXAA,PXAERR,VISITIEN) ;Check for a valid provider.
 I '$D(^VA(200,PXDUZ)) D  Q 0
 . S PXAERR(9)="PROVIDER"
 . S PXAERR(12)="The pointer to file #200 is not valid."
 ;
 ;Check for an active Person Class.
 N CLASS,EVENTDT
 S PXAERR(9)="Provider"
 S EVENTDT=$G(PXAA("EVENT D/T"))
 I EVENTDT="" S EVENTDT=$P(^AUPNVSIT(VISITIEN,0),U,1)
 S CLASS=+$$GET^XUA4A72(PXDUZ,EVENTDT)
 I CLASS'>0 D  Q 0
 . S PXAERR(12)="The Provider (DUZ="_PXDUZ_") does not have an active person class on the date of the encounter: "_$$FMTE^XLFDT(EVENTDT)
 Q 1
 ;
