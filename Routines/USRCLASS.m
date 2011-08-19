USRCLASS ; SLC/JER - User Class Management actions ;11/25/09
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**7,11,33**;Jun 20, 1997;Build 7
EDIT ; Edit user classes
 N USRDA,USRDATA,USREXPND,USRI,USRSTAT,DIROUT,USRCHNG
 N USRLST,NAME,NAME1,NAME2,LINE,CANTMSG
 D:'$D(VALMY) EN^VALM2(XQORNOD(0)) S USRI=0,USRCHNG=0
 F  S USRI=$O(VALMY(USRI)) Q:+USRI'>0  D  Q:$D(DIROUT)
 . S USRDATA=$S(VALMAR="^TMP(""USRCLASS"",$J)":$G(^TMP("USRCLASSIDX",$J,USRI)),1:$G(^TMP("USREXPIDX",$J,USRI)))
 . W !!,"Editing #",+USRDATA,!
 . S USRDA=+$P(USRDATA,U,2)
 . S NAME=$P(^USR(8930,USRDA,0),U),NAME1="|_ "_NAME,NAME2="-"_NAME
 . S LINE=^TMP("USRCLASS",$J,USRI,0)
 . D EDIT1
 . I (LINE[NAME1)!(LINE[NAME2) D  Q
 . . S CANTMSG=1,VALMBCK="Q",USRCHNG=0
 . I +$G(USRCHNG) S USRLST=$S($L($G(USRLST)):$G(USRLST)_", ",1:"")_USRI
 . I $D(USRDATA) D UPDATE^USRL(USRDATA)
 Q:$D(DIROUT)
 I $D(CANTMSG) D  K VALMY S VALMBCK="Q" Q
  . W !!,"  Expanded entries cannot be refreshed; please re-enter the option"
  . W !,"to see the result of your edits." H 3
 W !,"  Refreshing the list. If expanded entries require refreshing please"
 W !,"collapse and re-expand the entries." H 2
 S VALMSG="** "_$S($L($G(USRLST)):"Item"_$S($L($G(USRLST),",")>1:"s ",1:" ")_$G(USRLST),1:"Nothing")_" Edited **"
 K VALMY S VALMBCK="R"
 Q
EDIT1 ; Single record edit
 ; Receives USRDA
 N DA,DIE,DR
 I '+$G(USRDA) W !,"No Classes selected." H 2 Q
 S DIE="^USR(8930,",DA=USRDA,DR="[USR CLASS STRUCTURE EDIT]"
 D FULL^VALM1,^DIE
 S USRCHNG=1 ;Needs check if not really changed.
 Q
EXPAND ; Expand/Collapse user class hierarchy display
 N USRDNM,USRLNM,USRSTAT,USRVALMY
 D:'$D(VALMY) EN^VALM2(XQORNOD(0))
 I $D(VALMY) M USRVALMY=VALMY D EC^USRECCL(.USRVALMY)
 W !,"Refreshing the list."
 K VALMY S VALMBCK="R"
 S USRSTAT=+$P($G(^TMP("USRCLASS",$J,0)),U,2)
 S USRDNM=$P($G(^TMP("USRCLASS",$J,0)),U,3)
 S USRLNM=$P($G(^TMP("USRCLASS",$J,0)),U,4)
 S VALMCNT=+$G(@VALMAR@(0))
 S VALMBCK="R"
 Q
CREATE ; Class constructor
 N USRCREAT
 N DIC,DLAYGO,X,Y,USRSTAT,USRDNM,USRLNM D FULL^VALM1
 S (DIC,DLAYGO)=8930,DIC(0)="AELMQ",DIC("A")="Select CLASS: "
 D ^DIC Q:+Y'>0
 S USRCREAT=+$P(Y,U,3)
 S DA=+Y,DIE=DIC,DIE("NO^")="BACK",DR="[USR CLASS STRUCTURE EDIT]"
 D ^DIE
 S USRSTAT=+$P($G(^TMP("USRCLASS",$J,0)),U,2)
 S USRDNM=$P($G(^TMP("USRCLASS",$J,0)),U,3)
 S USRLNM=$P($G(^TMP("USRCLASS",$J,0)),U,4)
 I 'USRCREAT Q  ; Don't rebuild without cause
 W !,"Rebuilding main class list."
 D BUILD^USRCLST(USRSTAT,USRDNM,USRLNM)
 S VALMCNT=+$G(@VALMAR@(0))
 S VALMBCK="R"
 Q
MEMBERS ; List Members of classes and their subclasses
 N USRDA,USRDATA,USREXPND,USRI,USRSTAT,VALMCNT,DIROUT
 D:'$D(VALMY) EN^VALM2(XQORNOD(0)) S USRI=0
 F  S USRI=$O(VALMY(USRI)) Q:+USRI'>0  D  Q:$D(DIROUT)
 . S USRDATA=$S(VALMAR="^TMP(""USRCLASS"",$J)":$G(^TMP("USRCLASSIDX",$J,USRI)),1:$G(^TMP("USREXPIDX",$J,USRI)))
 . W !!,"Listing Members of #",+USRDATA,!
 . S USRDA=+$P(USRDATA,U,2) D EN^VALM("USR LIST MEMBERSHIP BY CLASS")
 . I $D(USRDATA) D UPDATE^USRL(USRDATA)
 W !,"Refreshing the list."
 S VALMSG="Members listed"
 K VALMY S VALMBCK="R"
 Q
