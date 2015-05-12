PXVUTIL ;BIR/ADM - VIMM UTILITY ROUTINE ;21 Aug 2014  4:44 PM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**201**;Aug 12, 1996;Build 41
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
