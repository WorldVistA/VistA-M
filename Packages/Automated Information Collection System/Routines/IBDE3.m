IBDE3 ;ALB/CJM - ENCOUNTER FORM - IMP/EXP UTILITY -DISPLAYS TOOLKIT BLOCKS ;AUG 12,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**14**;APR 24, 1997
 ;
HDR ;
 S VALMHDR(1)="LIST OF TOOLKIT BLOCKS READY FOR IMPORT OR EXPORT"
 S VALMHDR(3)="(** there are "_$S($O(^IBE(358,0)):"also",1:"no")_" forms in the work space **)"
 Q
ONENTRY ;
 N LINE
 S VALMCNT=$G(BLKCNT)
 I $D(BLKLIST) S LINE=0 F  S LINE=$O(@BLKLIST@(LINE)) Q:'LINE  D FLDCTRL^VALM10(LINE)
 Q
ONEXIT ;
 Q
 ;
IDXBLKS ;build an array of forms used by IBCLINIC for the list processor
 N BLOCK,NODE,ORDER
 K @BLKLIST
 S (VALMCNT,ORDER)=0 F  S ORDER=$O(^IBE(358.1,"D",ORDER)) Q:'ORDER  S BLOCK=0 F  S BLOCK=$O(^IBE(358.1,"D",ORDER,BLOCK)) Q:'BLOCK  D
 .I $D(^IBE(358.1,BLOCK,0)) D
 ..S VALMCNT=VALMCNT+1,@BLKLIST@(VALMCNT,0)=$$DISPLAY(BLOCK,VALMCNT),@BLKLIST@("IDX",VALMCNT,VALMCNT)=BLOCK D FLDCTRL^VALM10(VALMCNT) ;set video for ID column
 S BLKCNT=VALMCNT
 Q
 ;
DISPLAY(BLOCK,ID) ;
 N NODE,RET
 S RET=$J(ID,3)_"  "
 S NODE=$G(^IBE(358.1,BLOCK,0))
 S RET=RET_$$PADRIGHT^IBDFU($P(NODE,"^",1),30)_"  "_$P(NODE,"^",13)
 Q RET
 ;
ADD ;adds a block to the work space
 N OLDBLOCK,NEWBLOCK
 D FULL^VALM1
 S VALMBCK="R"
 S OLDBLOCK=$$SELECT Q:'OLDBLOCK
 S NEWBLOCK=$$COPYBLK^IBDFU2(OLDBLOCK,"",357.1,358.1,"","",1)
 I NEWBLOCK K DIE,DR,DA S DIE="^IBE(358.1,",DA=NEWBLOCK,DR="1;" D ^DIE K DIE,DR,DA
 D IDXBLKS
 Q
 ;
DELETE ;deletes a block from the work space
 N PICK,FORM,IBTKBLK
 S IBTKBLK=1 ;can't delete tk blocks unless IBTKBLK
 D EN^VALM2($G(XQORNOD(0)))
 S PICK="" F  S PICK=$O(VALMY(PICK)) Q:'PICK  S BLOCK=+$G(@VALMAR@("IDX",PICK,PICK)) I BLOCK,$$RUSURE^IBDFU5($P($G(^IBE(358.1,BLOCK,0)),"^")) D DLTBLK^IBDFU3(BLOCK,"",358.1)
 S VALMBCK="R"
 D IDXBLKS
 Q
EDIT ;allows the export notes of a block to be edited
 N PICK,BLOCK
 D EN^VALM2($G(XQORNOD(0)))
 D FULL^VALM1
 S PICK="" F  S PICK=$O(VALMY(PICK)) Q:'PICK  S BLOCK=+$G(@VALMAR@("IDX",PICK,PICK)) D:BLOCK
 .K DIE,DR,DA S DIE="^IBE(358.1,",DR="1;",DA=BLOCK D ^DIE K DIE,DA,DR
 S VALMBCK="R"
 D IDXBLKS
 Q
IMPORT ;allows the user to pick a block from the imp/exp files, then import it
 N PICK,BLOCK,NEWBLOCK,IBTKBLK,NAME
 S IBTKBLK=1
 D EN^VALM2($G(XQORNOD(0)))
 D FULL^VALM1
 S PICK="" F  S PICK=$O(VALMY(PICK)) Q:'PICK  S BLOCK=+$G(@VALMAR@("IDX",PICK,PICK)) D:BLOCK
 .S NAME=$$NEWNAME($P($G(^IBE(358.1,BLOCK,0)),"^"))
 .Q:NAME=""
 .S NEWBLOCK=$$COPYBLK^IBDFU2(BLOCK,$$TKFORM^IBDFU2C,358.1,357.1,"","",$$TKORDER^IBDF13,NAME)
 .D:$G(NEWBLOCK) DLTBLK^IBDFU3(BLOCK,"",358.1)
 S VALMBCK="R"
 D IDXBLKS
 D UPDATE^IBDECLN(1) ;clean up qualifiers (with messages)
 Q
VIEW ;allows the export notes of a form to be edited
 N PICK,BLOCK,IBARY,IBHDRRTN
 D EN^VALM2($G(XQORNOD(0)),"S")
 S PICK="" F  S PICK=$O(VALMY(PICK)) Q:'PICK  S BLOCK=+$G(@VALMAR@("IDX",PICK,PICK)) D
 .S IBHDRRTN="D VIEWHDR^IBDE3"
 .S IBARY="^IBE(358.1,"_BLOCK_",1)"
 .D EN^VALM("IBDE TEXT DISPLAY")
 S VALMBCK="R"
 Q
VIEWHDR ;
 S VALMHDR(1)="Export Notes For "_$P($G(^IBE(358.1,BLOCK,0)),"^")_" Block"
 Q
SELECT() ;allows the user to select a form, then a block from it
 N IBFORM,IBBLK
 S (IBFORM,IBBLK)=""
 K DIR S DIR(0)="S^1:TOOLKIT BLOCK;2:BLOCK FROM A TOOLKIT FORM;3:BLOCK FROM A FORM NOT IN THE TOOLKIT"
 S DIR("A")="What type of block do you want to export?"
 D ^DIR K DIR
 Q:(Y=-1)!($D(DIRUT)) ""
 I Y=1 D
 .S IBFORM=$$TKFORM^IBDFU2C
 E  S IBFORM=$$SLCTFORM^IBDFU4($S(Y=2:1,1:0))
 I IBFORM D
 .W !!,"NOW CHOOSE THE BLOCK TO COPY!",!
 .S IBBLK=$$SLCTBLK^IBDFU8(IBFORM)
 Q IBBLK
 ;
NEWNAME(OLDNAME) ;asks the user to select uniqued toolkit block name
 ;returns "" if unsuccessfull, else the blk name
 ;shows OLDNAME as the default if defined
 ;
 N NAME,FOUND,TKBLK,ORDER S NAME=""
 K DIR S DIR(0)="357.1,.01A",DIR("A")="New Toolkit Block Name: ",DIR("?")="Enter a unique name for the toolkit block up to 30 characters"
 S DIR("B")="" I $G(OLDNAME)'="" S DIR("B")=OLDNAME
 F  D  Q:'FOUND
 .S FOUND=0
 .D ^DIR I $D(DIRUT) S Y="" Q
 .S ORDER=0 F  S ORDER=$O(^IBE(357.1,"D",ORDER)) Q:ORDER=""  S TKBLK=$O(^IBE(357.1,"D",ORDER,0)) Q:'TKBLK   I $P($G(^IBE(357.1,TKBLK,0)),"^")=Y W !,"There is already a toolkit block with that name! The name should be unique." S FOUND=1 Q
 S:'FOUND NAME=Y
 K DIR
 Q NAME
