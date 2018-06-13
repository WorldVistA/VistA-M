DGRP61 ;ALB/PJH,LBD,DJS - Patient MSDS History - List Manager Screen ;16 Oct 2017 16:04:16
 ;;5.3;Registration;**797,909,935**;Aug 13,1993;Build 53
 ;
EN(DFN) ;Main entry point to invoke the DGEN MSDS PATIENT list
 ; Input  -- DFN      Patient IEN
 ;
 D WAIT^DICD
 D EN^VALM("DGEN MSDS PATIENT")
 Q
 ;
HDR ;Header code
 N DGPREFNM,X,VA,VAERR
 S VALMHDR(1)=$J("",25)_"MILITARY SERVICE DATA, SCREEN <6.1>"
 D PID^VADPT
 S VALMHDR(2)=$E("Patient: "_$P($G(^DPT(DFN,0)),U),1,30)
 S VALMHDR(2)=VALMHDR(2)_" ("_VA("BID")_")"
 S X="PATIENT TYPE UNKNOWN"
 I $D(^DPT(DFN,"TYPE")),$D(^DG(391,+^("TYPE"),0)) S X=$P(^(0),U,1)
 S VALMHDR(2)=$$SETSTR^VALM1(X,VALMHDR(2),60,80)
 S VALMHDR(3)=$J("",4)_"Service Branch/Component  Service #"
 S VALMHDR(3)=VALMHDR(3)_"        Entered    Separated   Discharge"
 Q
 ;
INIT ;Build patient MSDS screen
 D CLEAN^VALM10
 K ^TMP("DGRP61",$J),DGSEL
 ;
 N GLBL
 S GLBL=$NA(^TMP("DGRP61",$J))
 D GETMSE(DFN,GLBL,1)
 ;Check if any old MSEs didn't copy and display warning message
 I $$WARNMSG^DGMSEUTL(DFN) D
 .S VALMSG="**More MSEs available to view on History Screen**"
 .D MSG^VALM10(VALMSG)
 Q
 ;
GETMSE(DFN,GLBL,NUM) ;Load service episodes from .3216 array
 ; INPUT: DFN = Patient IEN
 ;        GLBL = ^TMP global ref
 ;        NUM = 1 - display line numbers
 N DGDATA,DGDATE,DGSUB,X1,X2,X
 ; DGSEL - selectable items, DGSEL("episode count") - episode count for DGSEL
 ; not all items may be selectable
 K DGSEL S VALMCNT=0,DGDATE="",DGSEL("episode count")=0
 F  S DGDATE=$O(^DPT(DFN,.3216,"B",DGDATE),-1) Q:'DGDATE  D
 . S DGSUB=$O(^DPT(DFN,.3216,"B",DGDATE,"")) Q:'DGSUB
 . S DGDATA=$G(^DPT(DFN,.3216,DGSUB,0)) Q:DGDATA=""
 . D EPISODE(DGDATA,GLBL,NUM)
 Q
 ;
EPISODE(DGDATA,GLBL,NUM) ;Format individual service episode
 N DGFDD,DGRPSB,DGRPSC,DGRPSD,DGRPSE,DGRPSN,DGRPSS,Z
 ; increment episode count
 S DGSEL("episode count")=DGSEL("episode count")+1
 S DGRPSB=+$P(DGDATA,U,3),DGRPSC=$P(DGDATA,U,4),DGRPSN=$P(DGDATA,U,5)
 ;Service Branch/Component
 S Z=$S($D(^DIC(23,DGRPSB,0)):$E($P(^(0),"^",1),1,15),1:"UNKNOWN")
 I DGRPSC'="" D
 . N Z0
 . S Z0=$$SVCCOMP^DGRP6CL(DGRPSC) Q:Z0=""
 . S Z=Z_"/"_Z0
 ;Filipino vet proof
 I $$FV^DGRPMS(DGRPSB)=1 S Z=$E(Z_$J("",21),1,21)_"("_$P($G(^DPT(DFN,.321)),U,14)_")"
 ;Service Number
 S Z=Z_$J("",26-$L(Z))_$S(DGRPSN]"":DGRPSN,1:"UNKNOWN")
 S Z=Z_$J("",42-$L(Z))
 ;Entry and separation dates
 S DGRPSE=$P(DGDATA,U,1),DGRPSS=$P(DGDATA,U,2)
 S X=$S(DGRPSE]"":$$FMTE^XLFDT(DGRPSE,"5DZ"),1:"UNKNOWN   ")
 S Z=Z_$E(X,1,10)_"  "
 S X=$S(DGRPSS]"":$$FMTE^XLFDT(DGRPSS,"5DZ"),1:"UNKNOWN   ")
 S Z=Z_$E(X,1,10)_"  "
 ;DJS, Add FUTURE DISCHARGE DATE; DG*5.3*935
 ;DGFDD = FUTURE DISCHARGE DATE (internal)
 ;DGFDD("DISP") = FUTURE DISCHARGE DATE (display)
 S DGFDD=$P(DGDATA,U,8),DGFDD("DISP")=$S(DGFDD]"":$$FMTE^XLFDT(DGFDD,"5DZ"),1:"")
 ;Discharge type
 S DGRPSD=+$P(DGDATA,U,6)
 I 'DGRPSD S Z=Z_"UNKNOWN"
 E  S Z=Z_$S($D(^DIC(25,+DGRPSD)):$E($P(^DIC(25,DGRPSD,0),"^",1),1,9),1:"UNKNOWN")
 ;
 S VALMCNT=VALMCNT+1
 ; Add line numbers if NUM true
 I $G(NUM) D
 . ;DJS, Indicate MSE episode with FDD not editable or deletable; DG*5.3*935
 . ; not selectable, put < > around number, stop
 . I $G(DGRPV)!($P(DGDATA,U,7)]"")!($P(DGDATA,U,8)]"") S Z="<"_DGSEL("episode count")_"> "_Z Q
 . ; item is selectable, put into DGSEL, [ ] around number
 . S Z="["_DGSEL("episode count")_"] "_Z,DGSEL(DGSEL("episode count"))=DGRPSE
 ;
 ; Save to List Manager array for display
 S @GLBL@(VALMCNT,0)=$S($G(NUM):Z,1:$J("",4)_Z)
 D:DGFDD  ; if FDD found, add to display
 . S VALMCNT=VALMCNT+1,@GLBL@(VALMCNT,0)="    Future Discharge Date: "_DGFDD("DISP")
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGRP61",$J)
 Q
 ;
PEXIT ;DGEN MSDS MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up or down
 ;D XQORM
 Q
 ;
ACT(DGACT) ; Entry point for menu action selection
 ; INPUT: DGACT = "A" - Add - DGEN MSDS ADD protocol
 ;              = "E" - Edit - DGEN MSDS EDIT protocol
 ;              = "D" - Delete - DGEN MSDS DELETE protocol
 N DGX,DA,DIE,DIC,DIK,DIPA,DR,X,Y
 I $G(DGACT)="" G ACTQ
 I $G(DGRPV) W !,"View only. This action cannot be selected." D PAUSE^VALM1 G ACTQ
 D FULL^VALM1
 I DGACT="A" D ADD G ACTQ
 I '$O(DGSEL(0)) D  G ACTQ
 . W !,"There are no episodes to "_$S(DGACT="E":"edit.",1:"delete.")
 . I $G(VALMCNT) D HECHLP
 . D PAUSE^VALM1
 S DGX=$$SEL(DGACT) I 'DGX G ACTQ
 S DGX=$G(DGSEL(DGX)) I 'DGX G ACTQ
 S DA(1)=DFN,DIC="^DPT("_DA(1)_",.3216,",DIC(0)="BX",X=DGX
 D ^DIC I Y<0 W !,"This episode is not in the patient's record." D PAUSE^VALM1 G ACTQ
 S DIPA("DA")=+Y
 I DGACT="E" K DA,DIC,DGFRDT S DIE="^DPT(",DA=DFN D SETDR1 D ^DIE G ACTQ
 ; deletion, ask user first
 I DGACT="D",$$RUSURE S DIK=DIC,DA(1)=DFN,DA=DIPA("DA") D ^DIK K DA,DIK
 ;
 ; DG*5.3*909 Potentially change Camp Lejeune to No with MSE changes
ACTQ ; menu action exit point 
 D INIT S VALMBCK="R" D SETCLNO^DGENCLEA Q
 ;
ADD ; Add new MSE to #2.3216 sub-file
 N X,Y,DIK,DA,DR,DIE,NEXT,DGFRDT
 ; Get next record number in sub-file
 S NEXT=$O(^DPT(DFN,.3216,"A"),-1),NEXT=NEXT+1
 D ZNODE(1)
 ; Prompt for MSE fields
 S DIE="^DPT("_DFN_",.3216,",DA(1)=DFN,DA=NEXT D SETDR2 D ^DIE
 I X["BAD" S DIK="^DPT("_DFN_",.3216,",DA(1)=DFN,DA=NEXT D ^DIK
 ; Check if new record is missing or incomplete
 I '$D(^DPT(DFN,.3216,NEXT)) D ZNODE(-1) Q
 I '$P(^DPT(DFN,.3216,NEXT,0),U) D  Q
 .S DIK="^DPT("_DFN_",.3216,",DA(1)=DFN,DA=NEXT D ^DIK D ZNODE(-1)
 ;
 ; File FILIPINO VET PROOF, if set
 I $G(DIPA("FVP"))]"" D
 .K DA,DR S DIE="^DPT(",DA=DFN,DR=".3214///^S X=DIPA(""FVP"")"
 .D ^DIE
 Q
 ;
SEL(ACT) ; function, prompt for episode to edit/delete
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 ; range is 1 to episode count, must be in DGSEL to be selectable
 S DIR(0)="NAO^1:"_DGSEL("episode count")_"^K:'$D(DGSEL(X)) X"
 S DIR("A")="Select Episode: "
 S DIR("?")="^D SELHLP^DGRP61(ACT)"
 D ^DIR I 'Y Q 0
 Q Y
 ;
SELHLP(ACT) ; Help message for episode prompt
 W !,"Select an episode to ",$S(ACT="E":"edit.",1:"delete.")
 W !,"Only numbers in square brackets [ ] are selectable."
 D HECHLP
 N DIR D PAUSE^VALM1
 Q
HECHLP ; Help message for episodes that can only be changed by HEC
 W !,"Angled brackets < > indicate episodes that cannot be changed in VistA."
 W !,"Please contact the HECAlert mail group or the HEC if you need to update"
 W !,"this information."
 Q
 ;
ZNODE(VAL) ; Update zero node of MSE multiple .3216
 Q:'$G(VAL)  Q:'$G(DFN)
 N ZNODE
 S ZNODE=$G(^DPT(DFN,.3216,0))
 S ^DPT(DFN,.3216,0)="^2.3216D^"_($P(ZNODE,U,3)+VAL)_U_($P(ZNODE,U,4)+VAL)
 Q
SETDR1 ; Set DR array to edit MSE fields
 S DR="I '$G(DIPA(""DA"")) S Y=0;.3216////^S X=""`""_DIPA(""DA"");.3214///^S X=$G(DIPA(""FVP""))"
 S DR(2,2.3216)="D SET0^DGRP61(.DA,.DIPA);@61;.03;S DIPA(""X"")=X;I X'="""" S:$$FV^DGRPMS(X)'=1 Y=""@62"";S DIPA(""FVP"")=$$FVP^DGRP61"
 S DR(2,2.3216,1)="I DIPA(""FVP"")=""^"" K DIPA(""FVP"") S Y=0;I DIPA(""FVP"")="""" D PRF^DGRPE S Y=""@61"";S Y=""@63"""
 S DR(2,2.3216,2)="@62;D:DIPA(""X"")]"""" WARN^DGRP61(.DIPA,.Y);.04;@63;.05;.01;.02;.06"
 Q
SETDR2 ; Set DR array to add MSE fields
 S DR="@61;.03;S DIPA(""X"")=X;I X'="""" S:$$FV^DGRPMS(X)'=1 Y=""@62"";S DIPA(""FVP"")=$$FVP^DGRP61;I DIPA(""FVP"")=""^"" S Y=0;I DIPA(""FVP"")="""" D PRF^DGRPE S Y=""@61"";@62;S:'$$CMP^DGRP61(DIPA(""X"")) Y=""@63"";.04;@63;.05;.01;.02;.06"
 Q
FVP() ; Prompt for FILIPINO VET PROOF
 N DA,X,Y,DIR,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)="2,.3214",DA=DFN
 D ^DIR I Y=""!(Y="^") Q Y
 Q Y
 ;
SET0(DA,DIPA) ; Set DIPA(0) to values of Service Branch and Service Component
 K DIPA(0)
 S DIPA(0)=$P($G(^DPT(DA(1),.3216,DA,0)),U,3,4)
 Q
 ;
WARN(DIPA,Y) ;Warns that the Service Branch was changed so the
 ; Service Component was deleted
 ; Returns Y to skip component if the component should not be asked
 ;   for this branch of service
 I '$$CMP($G(DIPA("X"))) S Y="@63"
 I $P($G(DIPA(0)),U,2)=""!($P($G(DIPA(0)),U)="") Q
 I $P(DIPA(0),U)=DIPA("X") Q   ;Service Branch didn't change
 ;
 I '$D(DIQUIET) W !!,*7,"** WARNING - BRANCH OF SERVICE WAS CHANGED SO THE COMPONENT WAS DELETED",!
 Q
 ;
CMP(X) ; Function to determine if service component is valid for
 ; branch of service ien in X   0 = invalid  1 = valid  
 ; Component only valid for ARMY/AIR FORCE/MARINES/COAST GUARD/NOAA/USPHS
 Q $S('$G(X):0,X'>5!(X=9)!(X=10):1,1:0)
 ;
RUSURE() ; Confirmation prompt for deleting episode
 N DIR,Y,X,DIRUT,DIROUT,DTOUT,DUOUT
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Are you sure you want to delete this military service episode? "
 D ^DIR I 'Y W !,"<< NOTHING DELETED >>" Q 0
 Q 1
 ;
