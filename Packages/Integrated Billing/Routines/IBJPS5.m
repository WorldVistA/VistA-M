IBJPS5 ;BP/VAD - IB Site Parameters, Revenue Codes ; 19-AUG-2015
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for IBJP IB REVENUE CODES
 D EN^VALM("IBJP IB REVENUE CODES")
 Q
 ;
HDR ; -- header code
 S VALMSG=""
 Q
 ;
INIT ; INIT-- init variables and list array
 N ERROR,IBCNT,IBLN,IBSTR,REVDATA,RIENS,RVCD,RVDSC
 ;
 S (VALMCNT,IBCNT,IBLN)=0
 I $D(^IBE(350.9,1,15,"B")) D
 . S RVCD=0 F  S RVCD=$O(^IBE(350.9,1,15,"B",RVCD)) Q:'RVCD  D
 . . ;
 . . S RIENS=RVCD_","
 . . D GETS^DIQ(399.2,RIENS,".01;1;2","I","REVDATA","ERROR")
 . . ; do not included *RESERVED codes (must be ACTIVATE = 1 for Activated)
 . . Q:$G(REVDATA(399.2,RIENS,2,"I"))'=1
 . . S IBCNT=IBCNT+1
 . . S IBSTR=$$SETSTR^VALM1($J(IBCNT,4)_".","",2,6)
 . . S IBSTR=$$SETSTR^VALM1($J($G(REVDATA(399.2,RIENS,.01,"I")),3),IBSTR,10,4)
 . . S IBSTR=$$SETSTR^VALM1($G(REVDATA(399.2,RIENS,1,"I")),IBSTR,17,30)
 . . S IBLN=$$SET(IBLN,IBSTR)
 . . S @VALMAR@("ZIDX",IBCNT,$G(REVDATA(399.2,RIENS,.01,"I")))=""
 . . Q
 ;
 I 'IBLN S IBLN=$$SET(IBLN,$$SETSTR^VALM1("No Revenue Codes defined.","",13,40))
 ;
 S VALMCNT=IBLN,VALMBG=1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAR^VALM1,CLEAN^VALM10
 Q
 ;
RCADD ; -- Add a new Revenue Code
 N X,Y,DIE,DR,DIR,DIRUT,DUOUT,DTOUT,ERRMSG,FDA,RETIEN
 ;
 S VALMBCK="R"
 D FULL^VALM1
 D RCADD1,INIT
 Q
 ;
RCADD1 ; Looping tag for Adding Revenue Codes
 K FDA,RETIEN,ERRMSG,X
 ;
 S DIR(0)="350.9399,.01"
 S DIR("A")="Revenue Code"
 D ^DIR
 Q:'X
 ;
 I $D(^IBE(350.9,1,15,"B",+Y)) D  G RCADD1
 . D FULL^VALM1
 . W @IOF
 . W !,"This Revenue Code already exists on the Exclusion list."
 . W !,"Please enter another Revenue Code."
 . Q
 ;
 S FDA(350.9399,"+1,1,",.01)=+Y
 D UPDATE^DIE("","FDA","RETIEN","ERRMSG")
 G RCADD1
 ;
RCDEL ; -- Delete a Revenue Code
 N DR
 D RCDEL1
 S VALMBCK="R"
 Q
 ;
RCDEL1 ; Looping tag for deleting Revenue Codes
 N Z,VALMY
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)))
 S Z=0
 F  S Z=$O(VALMY(Z)) Q:'Z  D
 . N DIK,IEN,RIEN
 . S IEN=$O(@VALMAR@("ZIDX",Z,""))
 . S RIEN=$O(^IBE(350.9,1,15,"B",IEN,""))
 . I +RIEN S DIK="^IBE(350.9,1,15,",DA(1)=1,DA=RIEN D ^DIK
 K @VALMAR
 D INIT
 ;D RE^VALM4
 Q
 ;
SET(IBLN,IBSTR) ; -- Add a line to display list
 ; returns line number added
 S IBLN=IBLN+1 D SET^VALM10(IBLN,IBSTR,IBLN)
 Q IBLN
 ;
