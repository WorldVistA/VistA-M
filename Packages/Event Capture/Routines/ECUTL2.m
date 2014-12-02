ECUTL2 ;ALB/JAM - Event Capture Diagnosis Code Selection ;23 Aug 2007
 ;;2.0;EVENT CAPTURE;**23,33,47,63,72,95,114**;8 May 96;Build 20
 ;
 ; Reference to $$SINFO^ICDEX supported by ICR #5747
 ; Reference to $$ICDDX^ICDEX supported by ICR5747
 ;
DIAG ;ask dx question (primary and multiple secondary) 
 ;check for primary dx and display message
 D PDXMSG
 ;ask for primary dx
 D PDX I ECOUT Q
 ;ask for secondary dx
 D SDX I ECOUT Q
 I $D(DTOUT)!$D(DUOUT) W:$P(ECPCE,"~",2)'="N" !!,"Please note that this record cannot be sent to PCE without a diagnosis.",!!
 Q
PDXMSG ; Check for existence of primary diagnoses and display message
 N TXT,ECPDX
 S (ECDX,ECDXN,ECDXO)="" K ECDXS
 ;Check if primary dx exist in file #721
 S ECPDX=$$PDXCK(ECDFN,ECDT,ECL,EC4)
 I +ECPDX W ! D 
 . W !?5,"WARNING: Primary Diagnoses already on File for this encounter."
 . W !?5,"If changed, all procedures will be updated. ("_ECDXN_")"
 . S ECDXO=ECDX
 I $P(ECPDX,U,2) D
 . S TXT="WARNING: Primary diagnoses already sent to PCE. If changed,"
 . S TXT=TXT_" all procedures"
 . W !!?5,TXT
 . S TXT="associated with this encounter will be updated and resent "
 . S TXT=TXT_"to PCE."
 . W !?5,TXT
 Q
PDXCK(ECDFN,ECDTX,ECLX,EC4X) ;Get primary dx frm file #721 for pat encounter
 ;   Input:   ECDFN     = Patient ien
 ;            ECDTX     = Date/time of procedure
 ;            ECLX      = Location ien
 ;            EC4X      = Clinic ien
 ;
 ;   Output:  PDXF^PCEF = primary dx flag (1/0)^dx sent to PCE flag (1/0)
 ;            ECDX      = Primary diagnoses ien
 ;            ECDXN     = Primary diagnoses code
 ;            ECDXIEN   = Array of encounter IENs w primary dx
 ;
 N PDXF,PCEF,DA,DXIEN,DXS,DXN,ECCS
 S (PDXF,PCEF)=0,DA="" K ECDXIEN
 I $G(ECDFN)=""!($G(ECDTX)="")!($G(ECLX)="")!($G(EC4X)="") Q PDXF_U_PCEF
 I $O(^ECH("APAT",ECDFN,ECDTX,""))="" Q PDXF_U_PCEF
 F  S DA=$O(^ECH("APAT",ECDFN,ECDTX,DA)) Q:DA=""  D
 .I EC4X'=$P($G(^ECH(DA,0)),U,19) Q
 .S ECDX=$P($G(^ECH(DA,"P")),U,2) I ECDX="" Q
 .; Determine Active Coding System Based on Date of Interest
 .S ECCS=$$SINFO^ICDEX("DIAG",ECDTX) ; Supported by ICR 5747
 .; Retrieve ICD info - Supported by ICR 5747
 .S ECDXN=$P($$ICDDX^ICDEX(ECDX,ECDTX,+ECCS,"I"),U,2)
 .S ECDXIEN(DA)=ECDXN_U_ECDX,PDXF=1
 .I $D(^ECH(DA,"SEND")),^("SEND")="" S PCEF=1
 .I $D(^ECH(DA,"DX")) D
 ..S DXS=0 F  S DXS=$O(^ECH(DA,"DX",DXS)) Q:'DXS  D
 ...S DXIEN=$P($G(^ECH(DA,"DX",DXS,0)),U)
 ...; Retrieve ICD info - Supported by ICR 5747
 ...S DXN=$P($$ICDDX^ICDEX(DXIEN,ECDTX,+ECCS,"I"),U,2) S:DXN'="" ECDXS(DXN)=DXIEN
 Q PDXF_U_PCEF
PDX ;Ask primary diagnoses code
 ;   Variables:   ECDX    = Primary diagnoses ien
 ;                ECDXN   = Primary diagnoses code, default if define
 ;                ECOUT   = Error flag (1/0)
 ;   
 N DIC,X,Y,DTOUT,DUOUT,DEFX,ECODE,PROMPT,ECCS
 S ECDX=$G(ECDX),ECDXN=$G(ECDXN),PROMPT="Primary ICD Code: "
 S:ECDXN'="" DEFX=ECDXN
 F  D LEX Q:$G(ECOUT)  D  I $D(ECODE) Q
 .I X="" W !,"This is a required response. Enter '^' to exit" Q
 .S ECDXN=ECODE
 .S ECCS=$$SINFO^ICDEX("DIAG",$G(ECDT)) ; Supported by ICR 5747 
 .S ECDX=$$ICDDX^ICDEX(ECODE,$G(ECDT),+ECCS,"E") ; Supported by ICR 5747
 Q
SDX ;Ask secondary diagnoses code
 ;   Variables:   ECDX    = Primary diagnoses ien, default if define
 ;                ECDXN   = Primary diagnoses code
 ;                ECOUT   = Error flag (1/0)
 ;                ECDXS   = Array with secondary diagnosis code
 ;                          subscript=dx code and set equal to dx ien
 ;
 N Y,X,DEFX,DIC,DTOUT,DUOUT,ECODE,ECCS
 S ECOUT=$G(ECOUT),PROMPT="Secondary ICD Code: "
 F  D LSTDXS,LEX Q:Y<0  D  I ECOUT Q
 .I ECODE="" Q
 .I ECODE=$G(ECDXN) W "  Already exist as primary dx." Q
 .I $D(ECDXS(ECODE)) D DELDUP Q
 .; Determine Active Coding System Based on Date of Interest
 .S ECCS=$$SINFO^ICDEX("DIAG",$G(ECDT)) ; Supported by ICR 5747
 .S ECDXS(ECODE)=+$$ICDDX^ICDEX(ECODE,$G(ECDT),+ECCS,"E") ; Supported by ICR 5747
 Q
DELDUP ;Delete secondary diagnosis code from list
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT
 S DIR("A")="Delete "_ECODE_" Code from List"
 S DIR(0)="Y"
 D ^DIR
 I $D(DIRUT)!($D(DIROUT)) S ECOUT=1 Q
 I Y K ECDXS(ECODE)
 Q
 ;
LEX ;ICD code from LEX database
 ;K X,Y
 N IMP,APP,ECX
 S (ECX,X)=$G(DEFX)
 ;LEX DBIA1577
 S IMP=$$IMPDATE^LEXU("10D"),APP=$S(ECDT<IMP:"ICD",1:"10D") ; Supported by ICR 5679
 D CONFIG^LEXSET(APP,APP,$G(ECDT))
 D LOOK^LEXA(ECX,APP,1,"",ECDT)   ;LEX DBIA2950
 S DIC="757.01",DIC(0)=$S('$L($G(X)):"A",1:"")_"EQM",DIC("A")=PROMPT
 D ^DIC
 I $D(DTOUT)!$D(DUOUT) S ECOUT=1 Q
 I X="" Q
 I Y<0 S ECOUT=1 Q
 S ECODE=$G(Y(1))
 Q 
 ;
LSTDXS ;list ICD code
 N DXS,ECCS
 I $D(ECDXS) D
 . W !?1,"Secondary ICD code entered:"
 . S DXS=""
 . F  S DXS=$O(ECDXS(DXS)) Q:DXS=""  D
 . . ; Determine Active Coding System Based on Date of Interest
 . . S ECCS=$$SINFO^ICDEX("DIAG",$G(ECDT)) ; Supported by ICR 5747
 . . W !,?4,DXS,?15,$P($$ICDDX^ICDEX(DXS,$G(ECDT),+ECCS,"E"),"^",4) ; Supported by ICR 5747
 Q
PXUPD(ECDFN,ECDT,ECL,EC4,ECDXP,ECDXX,ECXIEN) ; Update all associated
 ; procedures for an EC Patient encounter with the same primary and 
 ; secondary dx codes
 ;
 ;   Input:   ECDFN     = Patient ien
 ;            ECDT      = Date/time of procedure
 ;            ECL       = Location ien
 ;            EC4       = Clinic ien
 ;            ECDXP     = Primary diagnoses code
 ;            ECDXX     = Array of secondary diagnoses codes
 ;            ECXIEN    = 721 ien, if define don't process
 ;
 ;  Output: ECERR  0 - Process completed
 ;
 N ECIEN,ECERR,DIE,DR,DA,DTOUT,DIROUT,ECDXIEN,ECPDX,ECDX,ECDXN,DIC,X
 N ECVST,ECVAR1,VALQUIET,DXN,DXSIEN,DIK,ECDXS
 S ECERR=0
 I $D(ECDXP)="" Q ECERR
 S ECPDX=$$PDXCK(ECDFN,ECDT,ECL,EC4)
 I '$D(ECDXIEN) Q ECERR
 S ECIEN="",DIE="^ECH("
 F  S ECIEN=$O(ECDXIEN(ECIEN)) Q:ECIEN=""  D
 . I $G(ECXIEN)'="",ECXIEN=ECIEN Q
 . S ECNODE=$G(^ECH(ECIEN,"P")) I ECNODE="" Q
 . I ECDXP'=$P(ECNODE,U,2) D
 . . S DA=ECIEN,DR="20////"_ECDXP D ^DIE
 . . S $P(^ECH(ECIEN,"PCE"),"~",11)=ECDXP
 . ;delete all secondary diagnosis codes
 . S DA(1)=ECIEN,DIK="^ECH("_DA(1)_",""DX"",",DA=0
 . F  S DA=$O(^ECH(ECIEN,"DX",DA)) Q:'DA  D ^DIK
 . I $D(^ECH(ECIEN,"DX")) K ^ECH(ECIEN,"DX")
 . ;update secondary diagnosis codes on procedure
 . S DXN="" F  S DXN=$O(ECDXX(DXN)) Q:DXN=""  D
 . . S DXSIEN=$P(ECDXX(DXN),U) I DXSIEN<0 Q
 . . K DIC,DD,DO S DIC(0)="L",DA(1)=ECIEN,DIC("P")=$P(^DD(721,38,0),U,2)
 . . S X=DXSIEN,DIC="^ECH("_DA(1)_","_"""DX"""_"," D FILE^DICN
 . ;delete visit and resend to PCE
 . S ECVST=+$P($G(^ECH(ECIEN,0)),"^",21) I 'ECVST Q
 . ;* Prepare all EC records with same Visit file entry to resend to PCE
 . K EC2PCE S ECVAR1=$$FNDVST^ECUTL(ECVST,,.EC2PCE)
 . ;- Set VALQUIET to stop Amb Care validator from broadcasting to screen
 . N ECPKG,ECSOU
 . S ECPKG=$O(^DIC(9.4,"B","EVENT CAPTURE",0)),ECSOU="EVENT CAPTURE DATA"
 . S VALQUIET=1,ECVV=$$DELVFILE^PXAPI("ALL",ECVST,ECPKG,ECSOU)
 . ;- Send to PCE task
 . D PCETASK^ECPCEU(.EC2PCE) K EC2PCE
 Q ECERR
