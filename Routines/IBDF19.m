IBDF19 ;ALB/CJM - ENCOUNTER FORM (compile forms,delete workcopy);NOV 22,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
GARBAGE ;delete unused blocks (belonging to WORKCOPY form)
 N IBJUNK,BLK,CR,FORM
 ;
 ;first delete unused workcopy blocks
 ;find the form=WORKCOPY, used as a work area
 S IBJUNK=+$O(^IBE(357,"B","WORKCOPY",""))
 ;clean up blocks not being used
 S BLK=0 F  S BLK=$O(^IBE(357.1,"C",IBJUNK,BLK)) Q:'BLK  L +^IBE(357.1,BLK):1 I $T D DLTBLK^IBDFU3(BLK,IBJUNK,357.1) L -^IBE(357.1,BLK)
 W !,"Blocks not belonging to any form have been deleted"
 ;
 ;delete cross-references for compilied forms if the forms have been deleted
 F CR="AT","AC","AG","AU","AB" S FORM=0 F  S FORM=$O(^IBE(357,CR,FORM)) Q:'FORM  I '$D(^IBE(357,FORM)) K ^IBE(357,CR,FORM)
 W !,"Extraneous cross-references on non-existant forms have been deleted"
 Q
 ;
 ;
COMPILE ;compiles IBFORM at the form level - leaves blocks already compiled alone
 ;
 ;lock the form while compiling
 Q:'$$LOCKFORM^IBDFU7(IBFORM)
 ;compile it only if not already compiled - it could have been compiled by another process while the form was being locked
 I $$FORMDSCR^IBDFU1C(.IBFORM) I 'IBFORM("COMPILED") D
 .N IBARRAY,IBDEVICE,IBPRINT,DFN,IBCLINIC,IBAPPT,SUB
 .S (IBDEVICE("RASTER"),IBDEVICE("GRAPHICS"))=1
 .S (IBDEVICE("CRT"),IBDEVICE("LISTMAN"),IBAPPT,IBCLINIC,DFN,IBDEVICE("PCL"))=0
 .D UNCMPL(.IBFORM,0)
 .D PRNTPRMS^IBDFU1C(.IBPRINT,0,1,0,1)
 .D ARRAYS^IBDFU1C(.IBFORM,.IBARRAY)
 .K ^TMP("IB",$J,"INTERFACES")
 .S SUB="" F  S SUB=$O(IBARRAY(SUB)) Q:SUB=""  K @IBARRAY(SUB)
 .D DRWBLKS^IBDF2A
 .S:IBFORM("COMPILED")'="F" IBFORM("COMPILED")=1
 .S $P(^IBE(357,IBFORM,0),"^",5)=IBFORM("COMPILED")
 .; -- if form not scannable and it compiled w/o formtype id...get one
 .I 'IBFORM("SCAN"),IBFORM("COMPILED"),'$P(^IBE(357,IBFORM,0),"^",13) S IBFORM("TYPE")=$$FORMTYPE^IBDF18D(1) I IBFORM("TYPE") S $P(^IBE(357,IBFORM,0),"^",13)=IBFORM("TYPE")
 .S:$P(^IBE(357,IBFORM,0),"^",13) ^IBE(357,"ADEF",$P(^IBE(357,IBFORM,0),"^",13),IBFORM)=""
 .K ^TMP("IB",$J,"INTERFACES"),X,Y,I
 D FREEFORM^IBDFU7(IBFORM)
 ; -- build form spec if form compiled successfully
 I IBFORM("SCAN"),IBFORM("COMPILED"),IBFORM("TYPE") D SCAN^IBDFBKS(IBFORM("TYPE"))
 Q
 ;
ASKCMPL(IBFORM) ;ask if the form should be compiled or uncompiled
 Q:'$G(IBFORM)
 N BLK,QUIT S QUIT=0
 I $P($G(^IBE(357,IBFORM,0)),"^",5) D
 .W !,"The form is currently compiled. Should it be recompiled?"
 .K DIR S DIR(0)="Y",DIR("B")="YES"
 .D ^DIR K DIR
 .S:$D(DUOUT)!(Y'=1) QUIT=1
 Q:QUIT
 ;uncompile the form
 D UNCMPALL(IBFORM)
 Q
 ;
CMPLACTN ;action for compiling a form listed on the screen
 N IBFORM
 I $G(IBAPI("SELECT"))'="" X IBAPI("SELECT")
 I IBFORM D ASKCMPL(IBFORM)
 S VALMBCK="R"
 Q
 ;
KILLTBL(IBFORM) ;
 ; -- marks the FORM DEFINITION TABLE for deletion
 ;    IBFORM("TYPE") is reset to "", pass IBFORM by reference
 ;
 Q:'IBFORM("TYPE")
 ;
 ; -- Mark forms for deletion
 S $P(^IBD(357.95,IBFORM("TYPE"),0),"^",2)=DT,^IBD(357.95,"ADEL",DT,IBFORM("TYPE"))=""
 K ^IBE(357,"ADEF",IBFORM("TYPE"),IBFORM) ; kill cross reference
 S IBFORM("TYPE")="",$P(^IBE(357,IBFORM,0),"^",13)=""
 Q
 ;
UNCMPL(IBFORM,FAILED) ;marks the form as not compiled and deletes or marks for deletion the FORM DEFINITION TABLE
 ;leaves the blocks compiled
 ;if FAILED means compilation of form was attempted, but failed - mark form accordingly
 ;IBFORM is the form - if passed by reference IBFORM("TYPE") and IBFORM("COMPILED") are set
 ;
 Q:'IBFORM
 N NODE
 S NODE=$G(^IBE(357,IBFORM,0))
 S IBFORM("SCAN")=$P(NODE,"^",12),IBFORM("TYPE")=$P(NODE,"^",13)
 D:IBFORM("TYPE") KILLTBL(.IBFORM)
 S IBFORM("COMPILED")=$S($G(FAILED):"F",1:0),$P(^IBE(357,IBFORM,0),"^",5)=IBFORM("COMPILED")
 Q
 ;
UNCMPALL(IBFORM) ;uncompile the form and it's blocks
 N BLK
 D UNCMPL(IBFORM,0)
 ;also uncompile all of its blocks
 S BLK=0 F  S BLK=$O(^IBE(357.1,"C",IBFORM,BLK)) Q:'BLK  D UNCMPBLK^IBDF19(BLK)
 Q
BLKCHNG(FORM,BLOCK) ;call this if the block is edited - uncompiles the block and form
 D UNCMPBLK(BLOCK)
 D UNCMPL(FORM)
 Q
 ;
UNCMPBLK(BLOCK) ;delete the compiled version of the block
 K ^IBE(357.1,BLOCK,"V"),^IBE(357.1,BLOCK,"S"),^IBE(357.1,BLOCK,"B"),^IBE(357.1,BLOCK,"H")
 Q
 ;
KILL(TYPE) ;deletes the form definition=TYPE
 K ^IBD(357.95,"AC",TYPE),^IBD(357.95,TYPE,1)
 K ^IBD(357.95,"AD",TYPE),^IBD(357.95,TYPE,2)
 K DA S DIK="^IBD(357.95,",DA=TYPE D ^DIK K DIK,DA
 Q
 ;
RECMPALL ;causes all forms to be recompiled
 N IBFORM,IBQUIT,DIR,DIRUT,DUOUT,DTOUT
 S IBQUIT=0
 I '$D(ZTQUEUED) D
 .S DIR("?")="Enter 'Yes' to cause all forms to uncompile or 'No' to do nothing.  Forms will actually recompile as they are printed."
 .S DIR(0)="Y",DIR("A")="Do you really want to Recompile all Forms"
 .D ^DIR S IBQUIT='Y
 I $G(IBQUIT) W !!,"Okay, nothing recompiled" Q
 ;
 W:'$D(ZTQUEUED) !!,"Uncompiling all forms..."
 S IBFORM=0
 F  S IBFORM=$O(^IBE(357,IBFORM)) Q:'IBFORM  D
 .Q:'$$LOCKFORM^IBDFU7(IBFORM)
 .D UNCMPALL(IBFORM)
 .D FREEFORM^IBDFU7(IBFORM)
 .W:'$D(ZTQUEUED) "."
 W:'$D(ZTQUEUED) !!,"Okay, forms will be recompiled as they are printed."
 Q
