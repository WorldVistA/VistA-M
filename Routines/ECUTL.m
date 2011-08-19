ECUTL ;ALB/GTS/JAM - Event Capture Utilities ;23 Jul 2008
 ;;2.0; EVENT CAPTURE ;**10,18,47,63,95**;8 May 96;Build 26
 ;
FNDVST(ECVST,ECRECNUM,EC2PCE) ; Search EC Patient records for associated Visits
 ;
 ;   Input: ECVST    - Visit file IEN to search for
 ;          ECRECNUM - Event Capture record number to skip processing
 ;          EC2PCE   - Array passed by reference to contain results
 ;
 ;  Output: ECERR  1 - One of the records to resend lacks a zero node
 ;                 0 - All of the records to resend have zero nodes
 ;          EC2PCE   - array subscripted by date and pointer
 ;                     to EVENT CAPTURE PATIENT (#721) file
 ;                     [Ex: ECPCE(3080101,611)]
 ;
 N ECIEN,ECERR,ECVAR
 I '$D(ECRECNUM) S ECRECNUM=0
 S (ECVAR,ECERR)=0
 S:+ECVST'>0 ECERR=1
 I ECERR=0 DO
 .S ECIEN=""
 .F  S ECIEN=$O(^ECH("C",ECVST,ECIEN)) Q:+ECIEN=0  DO
 ..S:ECRECNUM'=ECIEN ECVAR=$$RSEND(ECIEN,.EC2PCE)
 ..S:ECVAR>0 ECERR=1
FNDVSTQ Q ECERR
 ;
RSEND(ECIEN,ECPCE) ; Prepare EC Patient record for resending to PCE
 ;
 ;   Input:  ECIEN - IEN for record to resend to PCE
 ;           ECPCE - array passed by reference to contain results
 ;  Output:  0 if successful   - EC Patient record will be resent to PCE
 ;           1 if Unsuccessful - EC Patient record lacks zero node
 ;           ECPCE - array subscripted by date and pointer
 ;                  to EVENT CAPTURE PATIENT (#721) file
 ;                  [Ex: ECPCE(3080101,611)]
 ;
 N ECERR,DA,DIE,DR,ECPROCDT
 S ECERR=0
 I '$D(^ECH(ECIEN,0)) S ECERR=1
 I ECERR=0 DO
 .S ECPROCDT=$P(^ECH(ECIEN,0),"^",3)
 .;remove set of field #31 and create ECPCE array to pass to
 .;direct EC to PCE xfer task
 .;S DA=ECIEN,DIE=721,DR="25///@;28///@;31///^S X=ECPROCDT;32///@"
 .S DA=ECIEN,DIE=721,DR="25///@;28///@;32///@"
 .D ^DIE
 .S ECPCE(ECPROCDT,ECIEN)=""
RSENDQ Q ECERR
MODSCN() ;Screen CPT Procedure Modifier
 N ECPT,ECCPT,ECPDT
 S ECCPT="" I $G(ECP)'="" D
 . S ECCPT=$S(ECP["EC":$P($G(^EC(725,+ECP,0)),"^",5),1:+ECP)
 S ECPDT=$S($D(^ECH(DA,0)):$P(^ECH(DA,0),U,3),$D(ECDT):ECDT,1:"")
 S ECPT=$S($D(^ECH(DA,"P")):$P(^ECH(DA,"P"),U),ECCPT'="":ECCPT,1:"")
 I ECPT'="",+$$MODP^ICPTMOD(ECPT,+Y,"I",ECPDT)>0
 Q
ASKMOD(PROC,MOD,PRDT,ECMOD,ECERR) ; Ask CPT modifiers for CPT procedure
 ; Input           PROC  = CPT Procedure
 ;                 MOD   = Default modifier
 ;                 PRDT  = Date/Time of procedure. Checks modifier status
 ;
 ;Output           ECMOD(  array with modifiers
 ;                 ECERR = Error flag 1 - error or 0 - no error.
 ;
 N DTOUT,DUOUT,DIROUT,SUB,I,DEF,DIR,DIC,DSC,IEN,DATA,MODAR
 S ECERR=$G(ECERR,0),DEF=""
 I PROC="" S ECERR=1 G ASKMODQ
 I '$D(PRDT) S PRDT=""
 S DIC="^ICPT(",DIC(0)="N",X=PROC
 S DIC("S")="I $P($$CPT^ICPTCOD(+Y,PRDT),""^"",7)"
 D ^DIC I +Y=-1 S ECERR=1 G ASKMODQ
 ;If no modifiers present for CPT code quit
 S DATA=$$CODM^ICPTCOD(PROC,"MODAR","",PRDT)
 G:$O(MODAR(""))="" ASKMODQ K MODAR
 ;Set modifiers in ECMOD array if a valid pair (CPT code/modifier)
 S SUB="" F I=1:1 S SUB=$P(MOD,",",I) Q:SUB=""  D
 . S DATA=$$MODP^ICPTMOD(PROC,SUB,"E",PRDT)
 . I +DATA'>0 W !?2,"Modifier: ",SUB," Invalid - ",$P(DATA,U,2) Q
 . S DSC=$P(DATA,U,2),IEN=$P(DATA,U),ECMOD(PROC,SUB)=DSC_U_IEN,DEF=SUB
 ;List modifiers entered
 S SUB="" F I=1:1 S SUB=$O(ECMOD(PROC,SUB)) Q:SUB=""  D
 . W !?2,"Modifier: ",SUB," ",$P(ECMOD(PROC,SUB),U)
 I DEF'="" S DIR("B")=DEF
AGAIN N Y,X,DEFX,ECY
 S DIR("A")="Modifier",DIR("?")="^D MODHLP^ECUTL"
 S DIR(0)="FO^^I $$VALMOD^ECUTL(PROC,X,PRDT)",DEFX=""
 D ^DIR K DIR G:X="" ASKMODQ
 I $D(DTOUT)!($D(DUOUT))!($D(DIROUT)) K ECMOD(PROC) S ECERR=1 G ASKMODQ
 D  G AGAIN
 . I X="@" K:DEF'="" ECMOD(PROC,DEF) W "  ...deleted" Q
 . I '$D(ECY) Q
 . I DEF'=DEFX,DEFX'="",$D(ECMOD(PROC,DEFX)) S (DEF,DIR("B"))=DEFX Q
 . K DIR("B") S ECMOD(PROC,$P(ECY,U,2))=$P(ECY(0),U,2)_U_$P(ECY,U),DEF=""
 ;
ASKMODQ Q $S(ECERR:0,1:1)
 ;
VALMOD(PROC,X,PRDT) ;Validate modifiers
 N DIC,DTOUT,DUOUT,DIROUT,DUOUT
 S DIC="^DIC(81.3,",DIC(0)="MEQZ"
 S DIC("W")="W ""   "" W ""   "",$P($$MOD^ICPTMOD(+Y,""I"",$G(PRDT)),U,3)"
 S DIC("S")="I +$$MODP^ICPTMOD(PROC,Y,""I"",PRDT)>0"
 D ^DIC I Y<0 K X Q 1
 M ECY=Y S DEFX=$P(Y,U,2)
 Q 1
MODHLP ;Help for CPT modifiers
 N DIC,MOD,D
 Q:'$D(PROC)  I $D(ECMOD(PROC)) D
 . W !?2,"Answer with CPT MODIFIER",!?1,"Choose from:"
 . S MOD="" F  S MOD=$O(ECMOD(PROC,MOD)) Q:MOD=""  W !,?4,MOD
 W !?6,"You may enter a new CPT MODIFIER, if you wish"
 W !?6,"Enter a modifier that is valid for the CPT procedure code."
 S DIC="^DIC(81.3,",DIC("W")="W ""   "" W ""   "",$P($$MOD^ICPTMOD(+Y,""I"",$G(PRDT)),U,3)",D="B"
 S DIC(0)="QEZ",DIC("S")="I +$$MODP^ICPTMOD(PROC,Y,""I"",$G(PRDT))>0"
 D DQ^DICQ
 Q
MOD(ECIEN,MFT,OUTARR) ;Returns modifiers associated with an EC Patient IEN
 ;  Input: ECIEN  - IEN entry in file 721/^ECH(
 ;         MFT    - format to provide modifier
 ;                  "I" - ien format
 ;                  "E" - .01 format (default)
 ;
 ; Output: OUTARR - output array subscripted by modifer ien or .01 value 
 ;                  ien^modifier^modifier description
 ;         returns 1 if successful or 0 if unsuccessful
 ;      
 I $G(ECIEN)="" Q 0  ;IEN not define.
 I '$D(^ECH(ECIEN)) Q 0  ;IEN does not exist in file 721/^ECH(
 I $O(^ECH(ECIEN,"MOD",0))="" Q 0  ;No modifiers on file for entry
 N MOD,IEN,ECMERR,MODARY,MODESC,SUB,SEQ,ECDT
 S MFT=$S($G(MFT)="":"E",1:MFT) I "E^I"'[$E(MFT) S MFT="E"
 S ECDT=$P($G(^ECH(ECIEN,0)),U,3)
 D GETS^DIQ(721,ECIEN,"36*","IE","MODARY","ECMERR")
 I $D(ECMERR) Q 0  ;Error looking up entry
 S SEQ="" F  S SEQ=$O(MODARY(721.036,SEQ)) Q:SEQ=""  D
 . S SUB=$G(MODARY(721.036,SEQ,.01,MFT)) I SUB="" Q
 . S IEN=$G(MODARY(721.036,SEQ,.01,"I")) I IEN="" Q
 . S MOD=$G(MODARY(721.036,SEQ,.01,"E")) I MOD="" S MOD="Unknown"
 . S MODESC=$P($$MOD^ICPTMOD(MOD,"E",ECDT),U,3)
 . I MODESC="" S MODESC="Unknown"
 . S OUTARR(SUB)=IEN_U_MOD_U_MODESC
 Q $S($D(OUTARR):1,1:0)
