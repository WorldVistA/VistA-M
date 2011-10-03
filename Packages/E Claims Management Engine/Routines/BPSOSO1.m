BPSOSO1 ;BHAM ISC/FCS/DRS - NCPDP Override Main menu ;03/07/08  10:33
 ;;1.0;E CLAIMS MGMT ENGINE;**1,7**;JUN 2004;Build 46
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;---------------------------------------------------------------
 ; IHS/SD/lwj  9/3/02  NCPDP 5.1 changes
 ; In 3.2, prior authorization was updated and stored in field 416.
 ; In 5.1, 416 is obsolete, and the information could be stored
 ; in field 461, and 462 or in the prior authorization segment.
 ; For now, the insurer/processors appear to be using 461, and
 ; 462 rather than the segment.  In any case, we needed to change
 ; the way we capture prior authorization information - AND - we
 ; have to keep populating 416 since we have to still process 3.2
 ; claims.  This routine was changed to call PRIORA in BPSOSo2
 ; rather than EDIT^BPSOSO2 when we are processing a prior auth.
 ;(Field prompts also altered to match 5.1 standards.)
 ;---------------------------------------------------------------
 Q
TEST D MENU("") Q
MENU(IEN)          ;EP -
 D SETLIST
 N PROMPT S PROMPT(1)="Select which claim data you wish to override."
 S PROMPT(2)="Use   ^   to exit this menu."
 N SEL F  D  Q:'SEL  Q:SEL=-1
 . S SEL=$$LIST^BPSOSU4("S",$$LISTROOT,$$ANSROOT,"Override Claim Defaults",.PROMPT,1,20,$S($G(DTOUT):DTOUT,1:300))
 . I SEL W ! H 1 D @$P($T(LIST+SEL),";",4) ;
 Q
LISTROOT()         Q "^TMP("""_$T(+0)_""","_$J_","
ANSROOT()          Q "^TMP("""_$T(+0)_""","_($J+.1)_","
SETLIST K ^TMP("BPSOSO1",$J),^TMP("BPSOSO1",$J+.1)
 N I,X F I=1:1 D  Q:X="*"
 . S X=$T(LIST+I),X=$P(X,";",2,$L(X)) Q:X="*"
 . S ^TMP("BPSOSO1",$J,I,"I")=$P(X,";")
 . S ^TMP("BPSOSO1",$J,I,"E")=$P(X,";",2)
 S ^TMP("BPSOSO1",$J,0)=I-1
 Q
 ;
 ; IHS/SD/lwj 9/3/02 - the following 3 lines were removed from LIST -
 ; new 1 - 3 lines were added to replace them
 ;1;Preauthorization #;EDIT^BPSOSO2(IEN,416)
 ;2;Person Code;EDIT^BPSOSO2(IEN,303)
 ;3;Relationship Code;EDIT^BPSOSO2(IEN,306)
 ;
 ; IHS/SD/lwj 9/3/02 - since still unimplemented, the following
 ; lines were removed from the menu options in LIST
 ;I;Order of insurance;NOTIMP
 ;P;Pricing;NOTIMP
 ;
LIST ;
 ;1;Prior Authorization;PRIORA^BPSOSO2(IEN)  ;IHS/SD/lwj 9/3/02
 ;2;Patient Gender Code;EDIT^BPSOSO2(IEN,303)
 ;3;Patient Relationship Code;EDIT^BPSOSO2(IEN,306)
 ;4;Eligibility Clarification Code;EDIT^BPSOSO2(IEN,309)
 ;*;Enter/edit/override any NCPDP field;EDIT^BPSOSO2(IEN)
 ;*
NOTIMP W !,"That option isn't yet implemented.",! N % R %:3 Q
