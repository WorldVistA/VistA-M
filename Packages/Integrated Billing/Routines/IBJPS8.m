IBJPS8 ;AITC/WCJ - IB Site Parameters, CMN CPT Inclusions CPT Codes ;02-Feb-2018
 ;;2.0;INTEGRATED BILLING;**608**;21-MAR-94;Build 90
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for IBJP IB CMN CPTS
 D EN^VALM("IBJPS CMN CPTS")
 Q
 ;
HDR ; -- header code
 S VALMSG=""
 Q
 ;
INIT ; -- init variables and list array
 N ERROR,IBCNT,IBLN,IBSTR
 N CPTDATA,CIENS,CPTIEN,RTYDSC
 ;
 S (VALMCNT,IBCNT,IBLN)=0
 I $D(^IBE(350.9,1,16,"B")) D
 . S CPTIEN=0 F  S CPTIEN=$O(^IBE(350.9,1,16,"B",CPTIEN)) Q:'CPTIEN  D
 . . ;
 . . S CIENS=CPTIEN_","
 . . D GETS^DIQ(81,CIENS,".001;.01;2","I","CPTDATA","ERROR")
 . . S IBCNT=IBCNT+1
 . . S IBSTR=$$SETSTR^VALM1($J(IBCNT,4)_".","",2,6)
 . . S IBSTR=$$SETSTR^VALM1($G(CPTDATA(81,CIENS,.01,"I")),IBSTR,10,10)
 . . S IBSTR=$$SETSTR^VALM1($G(CPTDATA(81,CIENS,2,"I")),IBSTR,25,30)
 . . S IBLN=$$SET(IBLN,IBSTR)
 . . S @VALMAR@("ZIDX",IBCNT,+CIENS)=""
 . . Q
 ;
 I 'IBLN S IBLN=$$SET(IBLN,$$SETSTR^VALM1("No CMN CPTs defined.","",13,40))
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
EXPND ; -- expand code
 Q
 ;
RTADD(IBTCFLAG) ; -- Add a new CPT Codes
 N X,Y,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,ERRMSG,FDA,RETIEN
 ;
 S VALMBCK="R"
 D FULL^VALM1
 D RTADD1
 D INIT
 Q
 ;
RTADD1 ; Looping tag for Adding CPT Codes
 K DA,DIE,DIR,DIRUT,DR,DTOUT,DUOUT,ERRMSG,FDA,RETIEN,X,Y
 ;
 S DIR(0)="350.916,.01"
 S DIR("A")="CPT Code"
 D ^DIR
 Q:'+Y
 ;
 I $D(^IBE(350.9,1,16,"B",+Y)) D  G RTADD1
 . D FULL^VALM1
 . W @IOF
 . W !,"This CPT Code already exists on the Inclusion list."
 . W !,"Please enter another CPT Code."
 . Q
 ;
 S FDA(350.916,"+1,1,",.01)=+Y
 D UPDATE^DIE("","FDA","RETIEN","ERRMSG")
 G RTADD1
 ;
RTDEL ; -- Delete a CPT Coode
 N DR
 D RTDEL1
 S VALMBCK="R"
 Q
 ;
RTDEL1 ; Looping tag for deleting CPT Codes
 N Z,VALMY
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)))
 S Z=0
 F  S Z=$O(VALMY(Z)) Q:'Z  D
 . N DIK,IEN,RIEN
 . S IEN=$O(@VALMAR@("ZIDX",Z,""))
 . Q:IEN=""
 . S RIEN=$O(^IBE(350.9,1,16,"B",IEN,""))
 . I +RIEN S DIK="^IBE(350.9,1,16,",DA(1)=1,DA=RIEN D ^DIK
 K @VALMAR
 D INIT
 Q
 ;
SET(IBLN,IBSTR) ; -- Add a line to display list
 ; returns line number added
 S IBLN=IBLN+1 D SET^VALM10(IBLN,IBSTR,IBLN)
 Q IBLN
 ;
CMNPRMT(IBXIEN,IBPROCP,CPTIEN) ;JRA Determine if procedure requires prompting for CMN Info
 ;Basically checks if CPTIEN is in the "CMN CPT Code Inclusion" list
 ;  Input: IBXIEN  = Internal bill/claim number
 ;         IBPROCP = Procedure line subscript
 ;         CPTIEN  = CPT code ien
 ;
 ;  Output: 1 = Prompt user for CMN info
 ;          0 = Don't prompt user for CMN info
 ;
 I '$G(IBXIEN)!('$G(IBPROCP)!('$G(CPTIEN))) Q 0
 ;Prompt if the CPT is in IB Site Parameters "CMN CPT Code Inclusion" list -OR- if "CMN Required?" already set to "YES"
 I $D(^IBE(350.9,1,16,"B",CPTIEN))>1!($$CMNDATA^IBCEF31(IBXIEN,IBPROCP,23,"I")) Q 1
 Q 0
 ;
