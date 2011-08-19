TIUFT ; SLC/MAM - LM Template T (Items) INIT, Action Add Items ; 4-AUG-1999 10:52:47
 ;;1.0;TEXT INTEGRATION UTILITIES;**2,5,17,27,77**;Jun 20, 1997
HDR ; -- header code
 ; Requires Array TIUFNOD0.
 N TYPE,NAME
 S NAME=$P(TIUFNOD0,U)
 I $L(NAME)>60 S TYPE=$P(TIUFNOD0,U,4) S:TYPE="DOC" TYPE="TL" G SETHDR
 S TYPE=$$MIXED^TIULS(TIUFNOD0("TYPE"))
SETHDR I TYPE'="" S TYPE=TYPE_" "
 S VALMHDR(1)=$$CENTER^TIUFL("Items for "_TYPE_NAME,79)
HDRX Q
 ;
INIT ; -- init variables and list array; Also Update.
 ; Requires TIUFSTMP as set in EDITEMS^TIUFD2.
 ; Requires CURRENT array TIUFINFO
 ;as set in EDVIEW^TIUFHA, updated (if Template A has changed) 
 ;in AUPDATE^TIUFLA1.
 ;WARNING: +TIUFINFO may = 0!
 N LINENO,FILEDA
 K ^TMP("TIUF2",$J),^TMP("TIUF2IDX",$J)
 D CLEAN^VALM10
 S FILEDA=TIUFINFO("FILEDA"),VALMCNT=0
 I '$O(^TIU(8925.1,FILEDA,10,0)) D  G INITX
 . S ^TMP("TIUF2",$J,1,0)=""
 . S ^TMP("TIUF2",$J,2,0)="Entry has no items.",VALMCNT=2
 . Q
 S LINENO=0
 ; EDit Items checks item existence, so we know items exist in file:
 D BUFITEMS^TIUFLT("T",.TIUFINFO,.LINENO) G:$D(DTOUT) INITX
 D UPDATE^TIUFLLM1("T",LINENO,0) S VALMCNT=VALMCNT+LINENO
INITX I $D(DTOUT) S VALMQUIT=1
 Q
 ;
EXIT ; -- exit code for LM Template T
 K ^TMP("TIUF2",$J),^TMP("TIUFB",$J),^TMP("TIUF2IDX",$J),^TMP("TIUFBIDX",$J)
 Q
 ;
ADD ; Template T (Items) Action Add Items
 ; Adds new or existing Docmt Defs to parent entry as items.
 ; Updates Template H or A and D as well as Item Template I.
 ; Requires CURRENT arrays TIUFINFO, TIUFNOD0, CURRENT variable TUIFVCN1 
 ;as set in EDVIEW^TIUFHA, updated (if Template A has changed) 
 ;in AUPDATE^TIUFLA1, or (if Template H has changed) in UPDATE^TIUFLLM1.
 ;WARNING: +TIUFINFO may = 0 if Template A has changed!
 ; Requires TIUFTMPL, TIUFSTMP.
 ; Requires TIUFWHO, set in Options TIUF/A/C/H EDIT/SORT/CREATE DDEFS CLIN/MGR/NATL.
 ; If TIUFTMPL ="A", Requires TIUFATTR, TIUFAVAL as set in protocols TIUF SORT BY...
 N FILEDA,NEWOR,ADDFLAG,DIC,DLAYGO,X,Y,NFILEDA,NEWFLAG,NEWSTAT
 N MSG2,MSG,MSG1,TENDA,DA,DIE,DR,CFILEDA,LINENO,DTOUT,DIRUT,DIROUT,DUOUT
 N CNTCHNG,FIELDS,DIK,TIUFOUT1,EXITFLG,TIUFXNOD,TIUFY,TIUFXHLX
 N NNODE0,TIUFTMSG,TIUFTLST,TIUFIMSG,SEQUENCE,SUBS,OVERRIDE,DDEFUSED
 S FILEDA=TIUFINFO("FILEDA"),TIUFXNOD=$G(XQORNOD(0))
 S VALMBCK=""
 I TIUFWHO="N" D FULL^VALM1,OVERWARN^TIUFHA2
 I $P(TIUFNOD0,U,13),TIUFWHO'="N",$P(TIUFNOD0,U,4)="DOC"!($P(TIUFNOD0,U,4)="CO") W !!," Parent is National, of Type TL or CO; Can't add or delete Items" D PAUSE^TIUFXHLX G ADDX
 S (ADDFLAG,TIUFOUT1)=0
 ; Can't avoid redisplay since may have asked for help or answered no, not adding, in which case must erase and redisplay.
 F  D  L -^TIU(8925.1,+$G(NFILEDA)) G:$D(DTOUT) ADDX S VALMSG=$$VMSG^TIUFL D RE^VALM4,RESET^TIUFXHLX S:$D(DUOUT) TIUFOUT1=1 Q:TIUFOUT1
 . K MSG2
 . D FULL^VALM1 ;displays list before does XE Help, so must full here
 . S DIC("A")=$S(TIUFWHO="C":"Enter Shared Component Name to add as Item: ",1:"Enter Document Definition Name to add as Item: ")
 . S DIC=8925.1,DIC(0)="AELQ" I TIUFWHO="C" S DIC(0)="AEQ"
 . S DIC("S")=$S(TIUFWHO="C":"I $P(^(0),U,10)&($P(^(0),U,4)=""CO"")",1:$$NAMSCRN^TIUFLF2(FILEDA)),DLAYGO=8925.1
 . N OVERRIDE S OVERRIDE=$$OVERRIDE^TIUFHA2("be allowed to select ANY inactive orphan item, including the wrong TYPE") Q:$D(DIRUT)  I TIUFWHO="N",'OVERRIDE W !,"  OK, you can only select appropriate items:",!
 . I OVERRIDE S DIC("S")="I $$ORPHAN^TIUFLF4(Y,^TIU(8925.1,Y,0))=""YES"""
 . D ^DIC S TIUFY=Y
 . I TIUFY=-1 S TIUFOUT1=1 Q
 . S NFILEDA=+TIUFY,NEWFLAG=$P(TIUFY,U,3),NNODE0=^TIU(8925.1,NFILEDA,0)
 . L +^TIU(8925.1,NFILEDA):1 I '$T W !!,"Another user is editing item.  Please try later.",! K DUOUT D PAUSE^TIUFXHLX Q
 . I 'NEWFLAG,$$STATWORD^TIUFLF5($P(^TIU(8925.1,+Y,0),U,7))'="INACTIVE" W !!,"NOT inactive; Can't add Item",! H 3 Q
 . S DDEFUSED=$$DDEFUSED^TIUFLF(NFILEDA)
 . I TIUFWHO'="N",DDEFUSED="YES" N DIR,Y D  Q:'Y
 . . I $P(NNODE0,U,10) S Y=1 Q  ;P76 Shared component
 . . I $P(NNODE0,U,4)'="DOC" S Y=0 Q
 . . S DIR(0)="Y",DIR("B")="NO"
 . . S DIR("A",1)="WARNING: This orphan Title is already IN USE, an ABNORMAL situation.  You will",DIR("A",2)="have to take additional actions after adding it.  You will not be able to",DIR("A",3)="delete it once it is added."
 . . S DIR("A")="  Want to go ahead and add it anyway" W ! D ^DIR
 . N TIUFIMSG I $$DUP^TIUFLF7($P(NNODE0,U),FILEDA,NFILEDA) W !!,TIUFIMSG,! K DUOUT D PAUSE^TIUFXHLX D:NEWFLAG DELETE(NFILEDA) Q
 . D TYPELIST^TIUFLF7($P(NNODE0,U),NFILEDA,FILEDA,.TIUFTMSG,.TIUFTLST) I $D(DTOUT) D:NEWFLAG DELETE(NFILEDA) Q
 . I $D(TIUFTMSG("T")) W !!,TIUFTMSG("T"),!,"Can't add Item",! K DUOUT D PAUSE^TIUFXHLX D:NEWFLAG DELETE(NFILEDA) Q  ;Parent has no/wrong type
 . I TIUFTLST="" W !!," Please enter a different Name; File already has entries of every permitted Type",!,"with that Name",! K DUOUT D PAUSE^TIUFXHLX D:NEWFLAG DELETE(NFILEDA) Q
 . I NEWFLAG D STUFFLDS^TIUFLF4(NFILEDA,FILEDA) S NNODE0=^TIU(8925.1,NFILEDA,0)
 . W !!," Editing prospective Item:",!
 . S EXITFLG=0
 . I NEWFLAG S FIELDS=";.05;.06;" S:$P(NNODE0,U,4)="" FIELDS=";.04"_FIELDS S:TIUFWHO="N" FIELDS=FIELDS_".13;" D ASKFLDS^TIUFLF1(NFILEDA,FIELDS,FILEDA,.NEWSTAT,.EXITFLG) Q:$D(DTOUT)
 . D OWNCHEC^TIUFLF8(NFILEDA)
 . N TIUFCK
 . I 'OVERRIDE D CHECK^TIUFLF3(NFILEDA,FILEDA,1,.TIUFCK) D  I $D(MSG2) S MSG=MSG1_MSG2 W !!,MSG,! K DUOUT D PAUSE^TIUFXHLX D:NEWFLAG DELETE(NFILEDA) Q
 . . F SUBS="S","OBJ","OBJINACT","B","O","V","E","R","H","N","G","D" K TIUFCK(SUBS)
 . . S MSG1="Can't Add Item: "
 . . I $D(TIUFCK)>9 S MSG2=$P(TIUFCK,U,2) Q
 . . S NNODE0=^TIU(8925.1,NFILEDA,0)
 . . I $O(^TIU(8925.1,"AD",NFILEDA,0)),'$P(NNODE0,U,10) S MSG2="Item Already has Parent" Q
 . . I $D(^TIU(8925.1,FILEDA,10,"B",NFILEDA)) S MSG2="Entry Already has Item"
 . D ADDTEN^TIUFLF4(FILEDA,NFILEDA,NNODE0,.TENDA)
 . I TENDA="" W " ?? Couldn't be added! " K DUOUT D PAUSE^TIUFXHLX Q
 . I TIUFTMPL="A",$E(TIUFATTR)="P" S TIUFREDO=1 ; Adding item affects parentage globally.
 . I DDEFUSED'="YES",'EXITFLG,'$D(DTOUT) S FIELDS=";.07;" D ASKFLDS^TIUFLF1(NFILEDA,FIELDS,FILEDA,.NEWSTAT,.EXITFLG) Q:$D(DTOUT)
 . S DA(1)=FILEDA,DA=TENDA
 . I 'EXITFLG,'$D(DTOUT) D  L -^TIU(8925.1,FILEDA,10,TENDA) Q:$D(DTOUT)
 . . L +^TIU(8925.1,FILEDA,10,TENDA):1 I '$T W !!,"Another user is editing item.  Please edit later.",! H 2 Q
 . . S DIE="^TIU(8925.1,DA(1),10,"
 . . S DR="3" D ^DIE I $D(Y)!$D(DTOUT) Q
 . . I $P(TIUFNOD0,U,4)="CL" S SEQUENCE=$P(^TIU(8925.1,DA(1),10,DA,0),U,3),DR="2///^S X=SEQUENCE" I $L(SEQUENCE)<5,$L(SEQUENCE) D ^DIE ;Stuff mnem with seq value
 . . S DR=$S($P(TIUFNOD0,U,4)="CL":"2;4",1:4) D ^DIE K DUOUT
 . S MSG=" Item Added" W !,MSG,! H 1
 . I DDEFUSED="YES" D  D PAUSE^TIUFXHLX
 . . I $P(NNODE0,U,10) Q  ;P76
 . . I TIUFWHO'="N" W !,"WARNING: You have just added a Title which is already IN USE.  Please Update",!,"Parent Document Type for this Title.  If documents still seem to be missing,",!,"please contact Customer Service.",! Q
 . . W !,"WARNING: You have just added an item which is already IN USE.  Please Update",!,"Parent Document Type for this Title/all Titles under this item.  If documents"
 . . W !,"are still missing, use TLDOCMTS^TIUFHA8 to reindex class cross references.",!
 . ;      Update Template T with Item:
 . D INIT Q:$D(DTOUT)
 . S LINENO=$O(^TMP("TIUF2IDX",$J,"DAF",NFILEDA,""))
 . I LINENO<VALMBG!(LINENO>(VALMBG+VALM("LINES")-1)) S VALMBG=LINENO
 . S ADDFLAG=1
 . ;  Update Template A with item (may be new, may be no longer Orphan):
 . I TIUFTMPL="A" D
 . . D AUPDATE^TIUFLA1(NNODE0,NFILEDA,.CNTCHNG) S:CNTCHNG TIUFVCN1=TIUFVCN1+1 ;CNTCHNG is Count Change
 G:'ADDFLAG ADDX
 D NODE0ARR^TIUFLF(FILEDA,.TIUFNOD0) G:$D(DTOUT) ADDX
 ;      Template D is updated when return to it from T
 ;   Template H doesn't need update: will just reexpand when leave items.
ADDX ;
 I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
DELETE(DA) ; Delete DA from file
 N DIK S DIK="^TIU(8925.1," D ^DIK
 Q
