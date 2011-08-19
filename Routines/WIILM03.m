WIILM03 ;VISN20/WDE/WHN -  WII LM SCREEN FOR PENDING TRANSMISSION ; 26-JUN-2008
 ;;1.0;Wounded Injured and Ill Warriors;**1**;06/26/2008;Build 28
 ; ListManager functionality designed through the List Manager Work Bench "^VALMWB" 
 ; ------------Variable list------------------
 ;  WIIAD    --  movement admission date
 ;  WIIDD    --  movement discharge date
 ;  WIILN    --  listmanager line number
 ;  WIILVAR  --  listmanager line/column information
 ;  WIINA    --  patient name
 ;  WIINODE  --  zer0th node of the WII file entry
 ;  WIISSN   --  patient SSN
 ;  WIIVA    --  facility number
 ;  WIIX     --  IEN of file entry
EN ; -- main entry point for WII LM STATUS 2 REVIEW
 D EN^VALM("WII LM STS 2 REVIEW")
 Q
 ;
HDR ; -- header code
 K X S $P(X," ",(80-$L("Admission/Discharges Flagged Approved for forwarding to DFAS")\2))=""
 S VALMHDR(1)=X_"Admission/Discharges Flagged Approved for forwarding to DFAS"
 S VALMHDR(2)=""
 Q
INIT ; -- init variables and list array
 S (WIILN,WIIX)=0 F  S WIIX=$O(^WII(987.5,"C",2,WIIX)) Q:WIIX=""  D
 . S WIILN=WIILN+1
 . S WIINODE=$G(^WII(987.5,WIIX,0)),WIILVAR=""
 . S WIINA=$P(WIINODE,U,2),WIISSN=$P(WIINODE,U,3),WIIAD=$P(WIINODE,U,6),WIIDD=$P(WIINODE,U,7),WIIVA=$P(WIINODE,U,5)
 . S WIILVAR=$$SETFLD^VALM1(WIILN_".",WIILVAR,"LINENO")
 . S WIILVAR=$$SETFLD^VALM1(WIINA,WIILVAR,"NAME")
 . S WIILVAR=$$SETFLD^VALM1(WIISSN,WIILVAR,"SSN")
 . S WIILVAR=$$SETFLD^VALM1(WIIAD,WIILVAR,"ADT")
 . S WIILVAR=$$SETFLD^VALM1(WIIDD,WIILVAR,"DDT")
 . S WIILVAR=$$SETFLD^VALM1(WIIVA,WIILVAR,"VA")
 . S WIILVAR=$$SETFLD^VALM1(WIIX,WIILVAR,"WII")
 . D SET^VALM10(WIILN,WIILVAR,WIIX)
 S VALMCNT=WIILN
 I WIILN<1 S @VALMAR@(1,0)=" No Active Duty Admission/Discharge have been approved"
 K WIIAD,WIIDD,WIILN,WIILVAR,WIINA,WIINODE,WIISSN,WIIVA,WIIX
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
EXIT ; -- exit code
 D CLEAN^VALM10 I $D(VALMBCK),VALMBCK="R" D REFRESH^VALM S VALMBCK=$P(VALMBCK,"R")_$P(VALMBCK,"R",2)
 Q
EXPND ; -- expand code
 Q
LJ(X,L) ; left justify function X=string L=length
 S X=X_"                      ",X=$E(X,1,L) Q X
 Q
ZAP ;
 K DIE,DIRUT,DA,Y,X,DR,STATUS,WIILN,VALMAR,VALMBG,VALMCNT,VALMLST,WIIEN,WIILN,WIINODE,WIIX,WIIY,WIIZ,Y,VALMBCK,VALMHDR
