FSCLDR ;SLC/STAFF-NOIS List Definition Replace ;9/6/98  20:49
 ;;1.1;NOIS;;Sep 06, 1998
 ;
RALL ; from FSCLMP
 I '$$CHECK^FSCLMPM(FSCLNUM,DUZ) W !,"You cannot edit this list.",$C(7) H 2 Q
 N LISTNAME,LISTNUM,LISTTYPE,NAME,NOTFLAG,OK,OWNER,ZERO
 S LISTNAME=FSCLNAME,LISTNUM=FSCLNUM
 S ZERO=^FSC("LIST",LISTNUM,0)
 S LISTTYPE=$P(ZERO,U,3) I '$L(LISTTYPE) S LISTTYPE="S"
 I "AMS"'[LISTTYPE W !,"You cannot edit this list.",$C(7) H 2 Q
 D NAME^FSCMU(LISTNAME,.NAME,.OK) I 'OK Q
 I NAME="@" D DELETE(LISTNAME,LISTNUM) Q
 D OWNER^FSCMU(+$P(ZERO,U,2),.OWNER,.OK) I 'OK Q
 D
 .N DIR,X,Y K DIR
 .I LISTTYPE="A" D  Q
 ..S DIR(0)="YAO",DIR("A")="Change type from Active to Manual update? ",DIR("B")="NO"
 ..S DIR("?",1)="Enter YES to change the list type."
 ..S DIR("?",2)="Enter NO or '^' to not change the type."
 ..S DIR("?")="^D HELP^FSCU(.DIR)"
 ..S DIR("??")="FSC U 1 NOIS"
 ..D ^DIR K DIR
 ..I Y=1 S LISTTYPE="M" D DELCALLS(LISTNUM)
 .I LISTTYPE="M" D  Q
 ..S DIR(0)="YAO",DIR("A")="Change type from Manual to Active update? ",DIR("B")="NO"
 ..S DIR("?",1)="Enter YES to change the list type."
 ..S DIR("?",2)="Enter NO or '^' to not change the type."
 ..S DIR("?")="^D HELP^FSCU(.DIR)"
 ..S DIR("??")="FSC U 1 NOIS"
 ..D ^DIR K DIR
 ..I Y=1 S FSCQEDIT=1,LISTTYPE="A"
 S NOTFLAG=$S($L($P(ZERO,U,6))&$L($P(ZERO,U,7)):1,1:0)
 N DA,DIE,DR S DIE="^FSC(""LIST"",",DA=LISTNUM,DR=".01///"_NAME_$S($L(OWNER):";1///"_OWNER,1:"")_";2///"_LISTTYPE_$S(LISTTYPE="A":";5;6;7",1:";5///@;6///@;7///@")_";200"
 L +^FSC("LIST",LISTNUM):30 I '$T D UNABLE Q
 D ^DIE
 L -^FSC("LIST",LISTNUM)
 I NOTFLAG,'$L($P(^FSC("LIST",LISTNUM,0),U,6))!'$L($P(^(0),U,7)) D DELNOT(LISTNUM)
 I $D(VALMAR) D ENTRY^FSCLMM,HEADER^FSCLMM
 S FSCLNAME=NAME,FSCLNUM=LISTNUM
 Q
 ;
DELETE(LISTNAME,LISTNUM) ; from FSCLMPM
 N DA,DIE,DIK,DR,SPEC
 D DELCALLS(LISTNUM)
 S DIE=7105.2,DR="9///@"
 S SPEC=0 F  S SPEC=$O(^FSC("SPEC","AL",LISTNUM,SPEC)) Q:SPEC<1  D
 .S DA=SPEC
 .L +^FSC("SPEC",SPEC):30 I '$T D UNABLE Q
 .D ^DIE
 .L -^FSC("SPEC",SPEC)
 .W !,"Deleted default list of ",$$VALUE^FSCGET(SPEC,7105.2,.01)
 D DELNOT(LISTNUM)
 D DELMRU(LISTNUM)
 S DA=LISTNUM,DIK="^FSC(""LIST""," D ^DIK
 W !,LISTNAME," deleted." H 2
 S VALMBCK="Q",FSCEXIT=1 ; exit from list manager after deleting a list
 Q
 ;
DELCALLS(LISTNUM) ;
 N CALL,LISTSNUM
 W ! S CALL=0 F  S CALL=$O(^FSCD("LISTS","ALC",LISTNUM,CALL)) Q:CALL<1  S LISTSNUM=+$O(^(CALL,0)) I LISTSNUM D DELETE^FSCLMPS(LISTSNUM) W "."
 Q
 ;
DELNOT(LISTNUM) ;
 N DA,DIK,NOTIFY
 W !,"Deleting notifications for this list."
 S DIK="^FSCD(""NOTIFY"","
 S NOTIFY=0 F  S NOTIFY=$O(^FSCD("NOTIFY","ALIST",LISTNUM,NOTIFY)) Q:NOTIFY<1  D
 .W "." S DA=NOTIFY
 .L +^FSCD("NOTIFY",NOTIFY):30 I '$T D UNABLE Q
 .D ^DIK
 .L -^FSCD("NOTIFY",NOTIFY)
 Q
 ;
DELMRU(LISTNUM) ; from FSCRPCLO
 N NUM
 S NUM=0 F  S NUM=$O(^FSCD("MRU","AL",LISTNUM,NUM)) Q:NUM<1  D DEL^FSCUCD("^FSCD(""MRU"",",NUM)
 Q
 ;
REPLACE(LISTNAME,LISTNUM) ; from FSCLMPE, FSCLMPM
 ; not scoped
 W !,"Reenter a query definition for ",LISTNAME,!
 D ADD^FSCLMPM(0,"ADD")
 Q
 ;
UNABLE ;
 W !,"Unable to edit."
 Q
