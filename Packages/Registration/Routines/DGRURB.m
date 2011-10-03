DGRURB ; ALB/SCK - LIST MANAGER INTERFACE FOR ROOM-BED TRANSLATION; 16-FEB-2000
 ;;5.3;Registration;**190,312**;Aug 13, 1993
 ;
EN ; -- main entry point for DGRU ROOM-BED
 K XQORS,VALMEVL
 N VALMCNT,DGRUCNT,VALMI,VALMY,XQORNOD,VALMBCK,VALMHDR
 D EN^VALM("DGRU ROOM-BED")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="RAI/MDS COTS Room-Bed Translation"
 S VALMHDR(2)="Data Entry Screen"
 Q
 ;
INIT ; -- init variables and list array
 ; Variables
 ;  DGIEN    - ien of the file #46.13 entry
 ;  DGNODE   - Zero node of file #46.13
 ;  DGCNT    - Count of entries in the LM array 
 ;  DGTRN    - File #46.13 ien^translated Room-Bed^Bed description
 ;  DGRM     - Room-Bed name in external format
 ;
 N DGIEN,DGNODE,DGTRN,DGCNT,X,DGRM
 ;
 K ^TMP("DGRURB",$J)
 K ^TMP("DGRUSRT",$J)
 ;
 D CLEAN^VALM10
 ;; Sort Room-Beds first
 S (DGIEN,VALMCNT)=0
 F  S DGIEN=$O(^DGRU(46.13,DGIEN)) Q:'DGIEN  D
 . S DGNODE=$G(^DGRU(46.13,DGIEN,0))
 . Q:DGNODE']""
 . S ^TMP("DGRUSRT",$J,$E($$GET1^DIQ(405.4,+DGNODE,.01),1,20),+DGNODE)=DGIEN_"^"_$P(DGNODE,"^",2)_"^"_$E($$GET1^DIQ(405.4,+DGNODE,.02),1,30)
 ;
 ;; Build display list
 S DGRM="",DGCNT=1
 F  S DGRM=$O(^TMP("DGRUSRT",$J,DGRM)) Q:DGRM=""  D
 . S DGIEN=0
 . F  S DGIEN=$O(^TMP("DGRUSRT",$J,DGRM,DGIEN)) Q:'DGIEN  D
 . . S DGTRN=^TMP("DGRUSRT",$J,DGRM,DGIEN)
 . . S X=$$SETFLD^VALM1(DGCNT,"","NUM")
 . . S X=$$SETFLD^VALM1(DGRM,X,"VISTA")
 . . S X=$$SETFLD^VALM1($P(DGTRN,"^",2),X,"COTS")
 . . S X=$$SETFLD^VALM1($P(DGTRN,"^",3),X,"RMDESC")
 . . D SET(X,DGCNT,+DGTRN)
 . . S DGCNT=DGCNT+1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("DGRURB",$J)
 K ^TMP("DGRUSRT",$J)
 D FULL^VALM1
 D CLEAN^VALM10
 Q
 ;
ADD ; Add a new room-bed translation value
 N DIR,DIRUT,DGVM,DGTR,FDA
 ;
 D FULL^VALM1
 S DIR(0)="PAO^405.4:EMZ",DIR("A")="Vista Room-Bed: "
 S DIR("S")="I $$RAI^DGRURB(Y)"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGVM=+Y
 ;
 K DIRUT
 S DIR(0)="FA^3:8^K:'X?.5UN1""-"".2UN"
 S DIR("A")="Enter Translated Room-Bed: "
 S DIR("?",1)="Answer must be 3-8 characters in length"
 S DIR("?",2)="in the format xxxxx-xx, where the first piece does"
 S DIR("?")="not exceed 5 characters, and the second does not exceed 2."
 D ^DIR K DIR
 Q:$D(DIRUT)
 S DGTR=$G(Y)
 ;
 S FDA(1,46.13,"?+1,",.01)=DGVM
 S FDA(1,46.13,"?+1,",.02)=DGTR
 D UPDATE^DIE("","FDA(1)")
 ;
 D INIT
 Q
 ;
DEL ; Delete an existing room-bed translation value
 N DA,DIK
 ;
 D FULL^VALM1
 D EN^VALM2(XQORNOD(0),"OS")
 S VALMI=0
 S VALMI=$O(VALMY(VALMI))
 Q:'VALMI
 ;
 S DIR(0)="YAO",DIR("A")="Are you sure you want to delete this translation? "
 S DIR("B")="NO"
 D ^DIR K DIR
 Q:$D(DIRUT)
 I Y D
 . S DA=^TMP("DGRURB",$J,"IDX",VALMI,VALMI)
 . S DIK="^DGRU(46.13,"
 . D ^DIK
 . D INIT
 Q
 ;
RAI(DGIEN) ; Screening logic for room lookup.  Associated ward must have the 
 ; RAI/MDS WARD field = "Yes"
 N DGOK,DGNDX
 ;
 S DGNDX=0,DGOK=0
 F  S DGNDX=$O(^DG(405.4,DGIEN,"W",DGNDX)) Q:'DGNDX  D  G:DGOK=1 EXITSC
 . S DGOK=$$GET1^DIQ(42,DGNDX,.035,"I")
EXITSC Q DGOK
 ;
SET(X,DGCNT,DGIEN) ;
 S VALMCNT=$G(VALMCNT)+1
 S ^TMP("DGRURB",$J,VALMCNT,0)=X
 S ^TMP("DGRURB",$J,"IDX",VALMCNT,DGCNT)=DGIEN
 S ^TMP("DGRURB",$J,"INIT",VALMCNT,DGCNT)=""
 Q
