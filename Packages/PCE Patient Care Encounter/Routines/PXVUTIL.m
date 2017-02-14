PXVUTIL ;BIR/ADM - VIMM UTILITY ROUTINE ;08/15/16  16:18
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**201,210,215,216**;Aug 12, 1996;Build 11
 ;
 ; Reference to UCUMCODE^LEXMUCUM supported by ICR #6225
 ;
VIS ; display VIS name with identifiers
 N C,PXVNAME,PXVDATE,PXVSTAT,PXVLANG,X
 S X=$G(^AUTTIVIS(Y,0))
 S PXVNAME=$P(X,"^"),PXVDATE=$P(X,"^",2),PXVSTAT=$P(X,"^",3),PXVLANG=$P(X,"^",4)
 S X=PXVDATE,PXVDATE=$E(X,4,5)_"-"_$E(X,6,7)_"-"_$E(X,2,3)
 S Y=PXVSTAT,C=$P(^DD(920,.03,0),"^",2) D:Y'="" Y^DIQ S PXVSTAT=Y
 S Y=PXVLANG,C=$P(^DD(920,.04,0),"^",2) D:Y'="" Y^DIQ S PXVLANG=Y
 S Y=PXVNAME_"   "_PXVDATE_"   "_PXVSTAT_"   "_PXVLANG
 Q
 ;;
DUPDX(PXVIEN,PXVDX) ; extrinsic function to check for duplicate diagnoses
 ; PXVIEN - Internal Entry Number of the event, pointing to the
 ;        V IMMUNIZATION file (9000010.11)
 ; PXVDX is the diagnosis entered and used to check for duplicates
 ; 
 ; this code is called by the input transforms of:
 ;        ^DD(9000010.11,1304,0) & ^DD(9000010.113,.01,0)
 ; 
 ; RETURNS a 1 if the diagnosis already exists for this
 ;         entry, 0 if not
 ;
 N TXT K TXT S TXT(2)=" ",TXT(1,"F")="?5"
 I PXVDX=$P($G(^AUPNVIMM(PXVIEN,13)),"^",4) S TXT(1)="Selected diagnosis exists as the Primary Diagnosis for this event." D EN^DDIOL(.TXT,"","") Q 1
 I $D(^AUPNVIMM(PXVIEN,3,"B",PXVDX)) S TXT(1)="Selected diagnosis exists for this event." D EN^DDIOL(.TXT,"","") Q 1
 Q 0
 ;;
RSETDA ; code needed for the routine AUPNSICD to have the correct value in
 ;   DA, as AUPNSICD is not designed to be called from a multiple.
 N DA S DA=D0
 D ^AUPNSICD
 Q
HRS ; called by AH new style x-ref in V IMMUNIZATION file
 ; set number of hours between administration and reading of results
 N PXVX,X1,X2,X3
 S X1=$P($G(^AUPNVIMM(DA,14)),"^",3) ; DATE/TIME READ
 S X2=$P($G(^AUPNVIMM(DA,12)),"^") ; EVENT DATE AND TIME
 S X3=2 ; return difference in seconds
 S PXVX=""
 I $G(X1),$L(X1)>7,$G(X2),$L(X2)>7,$G(X2)'>$G(X1) S PXVX=$$FMDIFF^XLFDT(X1,X2,X3)\3600
 S $P(^AUPNVIMM(DA,14),"^",6)=PXVX
 Q
 ;
DOSAGE(PXIEN) ; Used to compute Dosage (9000010.11,1312.5)
 ;Input:
 ;   PXIEN = (Required) Pointer to #9000010.11
 ;Returns:
 ;   Concatenation of DOSE_" "_DOSE UNITS (e.g., ".5 mL")
 N PXDOSE,PXUNITS
 I $G(PXIEN)="" Q ""
 S PXDOSE=$P($G(^AUPNVIMM(PXIEN,13)),U,12)
 I PXDOSE="" Q ""
 S PXDOSE=$FN(PXDOSE,",")
 S PXUNITS=$P($G(^AUPNVIMM(PXIEN,13)),U,13)
 I PXUNITS S PXUNITS=$P($$UCUMCODE^LEXMUCUM(PXUNITS),U)  ; ICR 6225
 Q PXDOSE_$S(PXUNITS'="":" "_PXUNITS,1:"")
 ;
OFFER() ; called from screen on VIS OFFERED/GIVEN TO PATIENT field (#.01) in 
 ; VIS OFFERED/GIVEN TO PATIENT multiple field (#2) in file #9000010.11
 ; 
 ; PXD is defined by immunization edit process in PCE and is the value of 
 ; Y from the DIR call to select an immunization.
 ;
 N PXVIS,PXDA
 S PXVIS=0
 I $G(DA),$D(^AUTTIMM($P(^AUPNVIMM(DA,0),"^"),4,"B",Y)),'$D(^AUPNVIMM(DA,2,"B",Y)) S PXVIS=1
 I '$G(DA),$G(PXD) S PXDA=+PXD I PXDA,$D(^AUTTIMM(PXDA,4,"B",Y)),'$D(^AUPNVIMM(PXDA,2,"B",Y)) S PXVIS=1
 Q PXVIS
 ;
IMMSEL(PXVIMM,PXVISIT) ; Immunization screen for V Immunization file
 ;
 ; Input:
 ;       PXVIMM: Immunization IEN (#9999999.14)
 ;      PXVISIT: Visit IEN (#9000010)
 ;
 ; Return:
 ;    0: Entry is not selectable
 ;    1: Entry is selectable
 ;
 N PXVHIST,PXVSC,PXVISITDT
 ;
 I '$G(PXVIMM) Q 0
 ;
 S PXVISITDT=""
 I $G(PXVISIT) S PXVISITDT=$P($G(^AUPNVSIT(PXVISIT,0)),U,1)
 ;
 S PXVHIST=0
 S PXVSC=$P($G(^AUPNVSIT(+$G(PXVISIT),0)),U,7)
 I $G(PXVSC)="E" S PXVHIST=1
 ;
 ; For non-historical, only allow active entries
 I 'PXVHIST,'$$SCREEN^XTID(9999999.14,,PXVIMM_",",PXVISITDT) Q 1
 ;
 ; For historical, only allow SELECTABLE FOR HISTORIC entries
 I PXVHIST,$P($G(^AUTTIMM(PXVIMM,6)),U,1)="Y" Q 1
 ;
 Q 0
 ;
IMMCRSEL(PXVICR,PXVIMM) ; Immunization screen for V Imm Contra/Refusal Events file
 ;
 ; Input:
 ;    PXVICR: Contraindication/Refusal Variable Pointer (#9000010.707, #.01)
 ;    PXVIMM: Immunization IEN (#9999999.14)
 ;
 ; Return:
 ;    0: Entry is not selectable
 ;    1: Entry is selectable
 ;
 N PXCONTRA,PXRSLT
 ;
 S PXRSLT=0
 ;
 I '$G(PXVICR) Q PXRSLT
 I '$G(PXVIMM) Q PXRSLT
 ;
 I PXVICR[920.5 D  Q PXRSLT
 . I $$IMMSTAT^PXAPIIM(PXVIMM)?1(1"A",1"H") S PXRSLT=1
 ;
 S PXCONTRA=+PXVICR
 ;
 ; Immunizations Limited To multiple is null
 I '$O(^PXV(920.4,PXCONTRA,3,0)) D  Q PXRSLT
 . I $$IMMSTAT^PXAPIIM(PXVIMM)?1(1"A",1"H") S PXRSLT=1
 ;
 ; PXVIMM is an entry in the Immunizations Limited To multiple
 I $O(^PXV(920.4,PXCONTRA,3,"B",PXVIMM,0)) S PXRSLT=1
 ;
 Q PXRSLT
ARTAPI(PXALERGY) ; extrinsic function returns whether allergy  ; PX*1*216
 ; Input:
 ;    PXALERGY - (required) Pointer to IMM CONTRAINDICATION REASONS file (#920.4)  ; PX*1*216
 ;
 ; Returns:
 ;    1: Entry is an allergy  ; PX*1*216
 ;    0: Entry is not an allergy  ; PX*1*216
 ;
 I '$G(PXALERGY) Q ""  ; PX*1*216
 I '$D(^PXV(920.4,PXALERGY)) Q ""  ; PX*1*216
 I $P($G(^PXV(920.4,PXALERGY,0)),U)["ALLERGY" Q 1  ; PX*1*216
 I $P($G(^PXV(920.4,PXALERGY,0)),U)="SEVERE REACTION PREVIOUS DOSE" Q 1  ; PX*1*216
 Q 0  ; PX*1*216
 ;
INST(PXVIN) ; Return Institution based off input
 ; Input:
 ;    PXVIN - Possible values are:
 ;               "I:X": Institution (#4) IEN #X
 ;               "V:X": Visit (#9000010) IEN #X
 ;               "L:X": Hopital Location (#44) IEN #X
 ;
 ; Output:
 ;    Pointer to #4
 ;
 N PXVIEN,PXVINST,PXVTO
 ;
 S PXVTO=$P($G(PXVIN),":",1)
 S PXVIEN=$P($G(PXVIN),":",2)
 S PXVINST=""
 ;
 I PXVTO="I" D
 . S PXVINST=PXVIEN
 ;
 I PXVTO="V",$D(^AUPNVSIT(+PXVIEN,0)) D
 . S PXVINST=$$DIV1^PXVXR(PXVIEN)
 ;
 I PXVTO="L",$D(^SC(+PXVIEN,0)) D
 . S PXVINST=$P($G(^SC(+PXVIEN,0)),U,4)
 . I 'PXVINST S PXVINST=$$INS4LOC^VSITCK1(PXVIEN)
 ;
 I 'PXVINST S PXVINST=$G(DUZ(2))
 I 'PXVINST S PXVINST=$$KSP^XUPARAM("INST")
 ;
 Q PXVINST
