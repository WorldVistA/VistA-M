PXBPMOD ;ISA/EW,ESW - PROMPT MOD ; 10/31/02 12:12pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**73,88,89,108,121,149**Aug 12, 1996
 ;
 ;
 ;
 Q
 ;
MOD(PXVST,PXPAT,PXCPT,PXMODSTR,PXCPTIEN,PXVSTDAT,PXCNT,PXARR) ;
 ;CPT Modifier prompt
 ; Input:
 ;   PXVST    - Visit IEN.
 ;   PXPAT    - Patient IEN
 ;   PXCPT    - CPT code or IEN of its entry in CPT file (#81)
 ;   PXMODSTR - User entered string of modifier codes in external
 ;              format
 ;   PXCPTIEN - IEN of CPT code entry in V CPT file (#9000010.18)
 ;   PXVSTDAT - Visit date
 ;   PXCNT    - Number of active modifiers defined for CPT code
 ; Output:
 ;   PXARR    - Array containing modifiers.
 ;
 ;
 N DTOUT,DUOUT,DIROUT,DA,DIC,DR,PXGLB,Y,ICPTVDT
 S PXGLB="^AUPNVCPT",ICPTVDT=PXVSTDAT
 I $$VALCPT(PXCPT)<1 Q
 I +$$CPTOK^PXBUTL(PXCPT,PXVSTDAT)=0 Q
 I $G(PXCPTIEN)]"" S DA=PXCPTIEN
 I $G(PXCPTIEN)']"" D
 .D FILECPT
 .S (PXARR,PXNEWIEN)=DA
 ;Only prompt if there are active modifiers for the CPT code
 D:PXCNT>0 CPTMOD
 I $D(DTOUT)!$D(Y) D  Q
 .S (EDATA,DATA)="^C"
 .;Remove incomplete V CPT entry
 .I $G(PXNEWIEN)]"" D REMOVE^PXCEVFIL(PXNEWIEN)
 D BLDARRY
 Q
 ;
FILECPT ;Create a new entry in V CPT file and get IEN
 N X,Y,DD,DO,DR
 S DIC=PXGLB_"("
 S DIC(0)=""
 S X=PXCPT
 D FILE^DICN
 ;
 S DA=+Y
 S DIE=PXGLB_"("
 S DR=".02////^S X=PXPAT;.03////^S X=PXVST;"
 L +@(PXGLB_"(DA)"):10
 D ^DIE
 L -@(PXGLB_"(DA)")
 Q
 ;
CPTMOD ;Prompt for CPT Modifiers
 N PXMOD,PXERR,PXI
 S DR=1
 S DIE=PXGLB_"("
 S DIC(0)="AELMQ"
 L +@(PXGLB_"(DA)")
 ;--File modifiers entered before prompting user
 I $G(PXMODSTR)]"" D
 .I $L(PXMODSTR,",")=1 S DR="1//"_PXMODSTR Q
 .S PXMOD=""
 .F PXI=1:1 S PXMOD=$P(PXMODSTR,",",PXI) Q:PXMOD=""  D
 ..S PXERR=""
 ..D VAL^DIE(9000010.181,DA,.01,"",PXMOD,.PXERR)
 ..Q:PXERR="^"
 ..S DR="1///^S X=PXMOD"
 ..D ^DIE
 .S DR=1
 D ^DIE
 L -@(PXGLB_"(DA)")
 Q
 ;
BLDARRY ;Copy new modifiers into local array
 N PXFIL,PXSUBFIL,PXSUB,PXARR2
 S PXFIL=9000010.18,PXSUBFIL=9000010.181
 D GETS^DIQ(PXFIL,DA,"1*","I","PXARR2")
 S PXSUB=""
 F  S PXSUB=$O(PXARR2(PXSUBFIL,PXSUB)) Q:PXSUB=""  D
 .S PXARR(1,+PXSUB)=PXARR2(PXSUBFIL,PXSUB,.01,"I")
 Q
 ;
VALCPT(X) ;Determine if CPT code is valid
 ;internal or external value of CPT is evaluated
 N DIC,Y
 S DIC=81
 S DIC(0)="BN"
 S DIC("S")="I $P($$CPT^ICPTCOD(Y,IDATE),U,7)"
 D ^DIC
 Q Y
