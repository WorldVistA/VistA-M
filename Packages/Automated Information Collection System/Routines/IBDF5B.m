IBDF5B ;ALB/CJM - ENCOUNTER FORM (edit a form - CONTINUED) ;07/27/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 80
 ;
 ;
EDITBLK ;allows the user to edit everything about the block
 ;allows user to discard or save changes to the block
 ;
 ;If IBBLK and IBBLK2 are used to point to two copies, one copy for editing and the other in case 'undo' is needed
 ; 
 N IBBLK,IBVALMBG,TOP1,TOP2,BOT1,BOT2,IBBLK2,IBTKODR,IBJUNK,IFSAVE,WDATA
 ;N IBMEMARY
 ;
 S IBVALMBG=VALMBG
 D FULL^VALM1
 S IBBLK=$$SLCTBLK^IBDFU8(IBFORM,IOSL,"HEADER") ;select the block
 I IBBLK D
 .D KILL^IBDFUA
 .S (IBBLK2,IBTKODR,IBJUNK)=""
 .S WDATA=IBPRINT("WITH_DATA")
 .D COPYBLK(IBBLK,.IBBLK2,.IBBLK,.IBTKODR,.IBJUNK) I 'IBBLK S IBBLK=IBBLK2,IBBLK2="" Q  ;sets IBBLK to the work copy, IBBLK2 to the copy actually on the form
 .D TOPNBOT^IBDFU5(IBBLK,.TOP1,.BOT1)
 .D EN^VALM("IBDF FORM BLOCK EDIT") ;call list processor
 .I IBBLK,IBBLK2 D
 ..S IFSAVE=$$ASKSAVE
 ..I IFSAVE D SAVECOPY(.IBBLK,.IBBLK2,IBTKODR) S IBBLK=IBBLK2,IBBLK2=""
 ..I 'IFSAVE D DLTCOPY(IBBLK) S IBBLK=IBBLK2,IBBLK2=""
 ..L -^IBE(357.1,IBBLK):1
 .I '$G(IBFASTXT) D
 ..S VALMBG=IBVALMBG
 ..S IBPRINT("WITH_DATA")=WDATA
 ..D TOPNBOT^IBDFU5(IBBLK,.TOP2,.BOT2)
 ..S TOP1=$S(TOP1<TOP2:TOP1,1:TOP2),BOT1=$S(BOT1>BOT2:BOT1,1:BOT2)
 ..D IDXFORM^IBDF5A(TOP1,BOT1)
 K ^TMP("IBDF DELETE SELECTION OPTION",$J),^TMP("IBDF DELETED ALL SELECTIONS",$J),^TMP("IBDF ADDSLCTN",$J)
 S VALMBCK="R"
 Q
DLTCOPY(WORKCOPY) ;deletes the block=WORKCOPY and unlocks it
 D DLTBLK^IBDFU3(WORKCOPY,IBJUNK,357.1)
 L -^IBE(357.1,WORKCOPY)
 S WORKCOPY=""
 Q
SAVECOPY(WORKCOPY,FORMCOPY,IBTKODR) ;deletes the block=FORMCOPY,adds WORKCOPY to IBFORM
 ;NOTE: upon completion WORKCOPY="",FORMCOPY points to what WORKCOPY initially did
 N IBDN,IBDX,IBD9,IBD10,IBDBL
 Q:('FORMCOPY)!('WORKCOPY)  ;something wrong!
 ;
 K DIE,DA,DR S DIE="^IBE(357.1,",DA=WORKCOPY,DR=".02////"_IBFORM
 I IBTKODR S DR=DR_";.14////"_IBTKODR
 D ^DIE K DIE,DR,DA
 ;
 ;In order to be able to update history, first check to see if there is any Selection List which is either ICD-9 or ICD-10
 S (IBD9,IBD10)=0
 ;FORMCOPY at this time is actually the Work Copy block, WORKCOPY is the new block
 ;Check to see if any List contains ICD-9 or ICD-10 existed prior this change
 S IBDN="" F  S IBDN=$O(^IBE(357.2,"C",FORMCOPY,IBDN)) Q:IBDN=""  S IBDX=$P($G(^IBE(357.2,IBDN,0)),U,11) I IBDX?1.N S IBDX=$E($P($G(^IBE(357.6,IBDX,0)),U,1),1,30) D
 .I '$D(^TMP("IBDF DELETED ALL SELECTIONS",$J)),'$O(^IBE(357.3,"C",IBDN,"")) Q  ;Only log history fields if ICD-9 or ICD-10 codes are contained in block.
 .I IBDX="DG SELECT ICD-9 DIAGNOSIS CODE" S IBD9=1
 .I IBDX="DG SELECT ICD-10 DIAGNOSIS COD" S IBD10=1
 ;
 ;Now check for any Data Fields with ICD-9 or ICD-10 inputs
 S IBDN=0 F  S IBDN=$O(^IBE(357.1,FORMCOPY,"B",IBDN)) Q:IBDN'?1.N  D
 .S IBDX=$P(^IBE(357.1,FORMCOPY,"B",IBDN,0),U,3) I IBDX?1.N S IBDX=$E($P($G(^IBE(357.6,IBDX,0)),U,1),1,30) D
 ..I IBDX="INPUT DIAGNOSIS CODE (ICD9)" S IBD9=1
 ..I IBDX="INPUT DIAGNOSIS CODE (ICD10)" S IBD10=1
 ;
 D DLTBLK^IBDFU3(FORMCOPY,IBFORM,357.1)
 D UNCMPL^IBDF19(IBFORM,0)
 L -^IBE(357.1,FORMCOPY)
 S FORMCOPY=WORKCOPY,WORKCOPY=""
 ;
 ;Check to see if any List contains ICD-9 or ICD-10 existed after the change
 S IBDQUIT=0
 S IBDN="" F  S IBDN=$O(^IBE(357.2,"C",FORMCOPY,IBDN)) Q:IBDN=""!(IBDQUIT)  S IBDX=$P($G(^IBE(357.2,IBDN,0)),U,11) I IBDX?1.N S IBDX=$E($P($G(^IBE(357.6,IBDX,0)),U,1),1,30) D
 .I '$D(^TMP("IBDF DELETED ALL SELECTIONS",$J)),'$O(^IBE(357.3,"C",IBDN,"")) S IBDQUIT=1 Q  ;Only log history fields if ICD-9 or ICD-10 codes are contained in block.
 .I IBDX="DG SELECT ICD-9 DIAGNOSIS CODE" S IBD9=1
 .I IBDX="DG SELECT ICD-10 DIAGNOSIS COD" S IBD10=1
 ;
 Q:IBDQUIT  ;Do not update history fields if ICD-9 or ICD-10 codes are not contained within the block.
 ;
 ;Now check for any Data Fields with ICD-9 or ICD-10 inputs
 S IBDN=0 F  S IBDN=$O(^IBE(357.1,FORMCOPY,"B",IBDN)) Q:IBDN'?1.N  D
 .S IBDX=$P(^IBE(357.1,FORMCOPY,"B",IBDN,0),U,3) I IBDX?1.N S IBDX=$E($P($G(^IBE(357.6,IBDX,0)),U,1),1,30) D
 ..I IBDX="INPUT DIAGNOSIS CODE (ICD9)" S IBD9=1
 ..I IBDX="INPUT DIAGNOSIS CODE (ICD10)" S IBD10=1
 ;
 ;Now update history if ICD-9 or ICD-10 was present before or after the change
 N IBDX
 I IBD9 S IBDX=$$CSUPD357^IBDUTICD(IBFORM,1,"",$$NOW^XLFDT(),DUZ)
 I IBD10 S IBDX=$$CSUPD357^IBDUTICD(IBFORM,30,"",$$NOW^XLFDT(),DUZ)
 Q
 ;
COPYBLK(IBBLK,FORMCOPY,WORKCOPY,IBTKODR,IBJUNK) ;copies the IBBLK to the WORKCOPY, then puts sets FORMCOPY=IBBLK
 ;IBJUNK set to the form="WORKCOPY", IBTKODR set to the original value of the field TOOL KIT ORDER
 ;
 N NODE
 S WORKCOPY=IBBLK,FORMCOPY=""
 Q:'IBBLK  ;no block to copy!
 S NODE=$G(^IBE(357.1,IBBLK,0))
 S IBTKODR=$P(NODE,"^",14)
 ;find the form=WORKCOPY, used as a work area
 S IBJUNK=+$O(^IBE(357,"B","WORKCOPY",""))
 ;copy the block
 S FORMCOPY=$$COPYBLK^IBDFU2(IBBLK,IBFORM,357.1,357.1)
 I 'FORMCOPY W !,"Unable to edit the block!" D PAUSE^IBDFU5 S FORMCOPY=IBBLK Q
 ;
 ;make sure both copies are locked
 ;the working copy on IBJUNK is locked so that the option does cleanup knows which blocks are in current use - others on IBJUNK can be deleted
 L +^IBE(357.1,FORMCOPY):1
 L +^IBE(357.1,WORKCOPY):1
 ;
 ;mark the working copy as not being in the tk and not on IBFORM
 K DIE,DA,DR S DIE="^IBE(357.1,",DA=WORKCOPY,DR=".02////"_IBJUNK_";.14////0"
 D ^DIE K DIE,DR,DA
 Q
 ;
ASKSAVE() ;asks the user if changes to the block should be saved
 ;returns 1 for yes, 0 for no
 K DIR S DIR(0)="Y",DIR("A")="Save changes to the block",DIR("B")="YES"
 D ^DIR K DIR
 Q:$D(DIRUT) 0
 Q Y
DECIDE ;allows user to either save or discard changes to the block being edited
 N WHAT
 ;
 S WHAT=$$DOWHAT
 I WHAT="S" D
 .D SAVECOPY(.IBBLK,.IBBLK2,IBTKODR),COPYBLK(IBBLK2,.IBBLK2,.IBBLK,.IBTKODR,.IBJUNK) S VALMBCK="" I 'IBBLK S IBBLK=IBBLK2,IBBLK2="" S VALMBCK="Q"
 I WHAT="D" D
 .D DLTCOPY(IBBLK) S IBBLK=IBBLK2,IBBLK2="" D COPYBLK(IBBLK,.IBBLK2,.IBBLK,.IBTKODR,.IBJUNK)
 .I IBBLK S VALMBCK="R" D IDXBLOCK^IBDFU4
 .I 'IBBLK S IBBLK=IBBLK2,IBBLK2="",VALMBCK="Q"
 Q
 ;
DOWHAT() ;returns "D" for discard, "S" for save, "" for do nothing
 K DIR S DIR(0)="SB^S:Save Changes;D:Discard Changes;",DIR("A")="Save or Discard the recent changes to the block?"
 D ^DIR K DIR
 Q:$D(DIRUT) ""
 Q Y
 ;
PRINT ;prints the form
 ;
 N QUIT S QUIT=0
 S VALMBCK=""
 I $G(IBBLK),'$G(IBTKBLK) D  Q:QUIT
 .W !,"Before printing the form any changes you have made must be saved.",!,"Is that okay?"
 .K DIR S DIR(0)="Y" D ^DIR  K DIR I 'Y!$D(DIRUT) S QUIT=1 QUIT
 .D SAVECOPY(.IBBLK,.IBBLK2,IBTKODR),COPYBLK(IBBLK2,.IBBLK2,.IBBLK,.IBTKODR,.IBJUNK) S VALMBCK="" I 'IBBLK S IBBLK=IBBLK2,IBBLK2="" S VALMBCK="Q",QUIT=1
 D:'QUIT PRINT^IBDF1C(.IBFORM)
 Q
