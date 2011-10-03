ZISPL ;SF/RWF - UTILITIES FOR SPOOLING ;03/31/2003  08:53
 ;;8.0;KERNEL;**23,69,291**;Jul 10, 1995
 ;This is the general code for managment of the spooler file.
DELETE ;delete a document from the file.
A S DIC("A")="Delete which SPOOL DOCUMENT: " D GETDOC G:Y<0 EXIT
 I '$P(ZISPL0,U,7) W !,$C(13),"This Document hasn't been printed.  Are you sure??"
 S DIR(0)="S^n:NO;y:YES;c:CLEAR",DIR("A")="...OK TO DELETE",DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!("yc"'[Y) EXIT
 S ZISY=Y D DSD($P(ZISPL0,U,10)) ;delete data
 I ZISY["c" S X=^XMB(3.51,ZISDA,0),^(0)=$P(X,"^",1)_"^^^^"_DUZ_"^^^"_$P(X,"^",8) K ^XMB(3.51,ZISDA,2) W " ... DOCUMENT CLEARED!!" G EXIT
 ;
 D DSDOC(ZISDA) ;Delete entry
 W "  ...DOCUMENT DELETED!!",$C(13),!
 G EXIT
DEL ;Called from mailman to delete the document.
 Q  ;Obsolete
GETDOC ;Get a spool document to work on.
 S Y=-1 Q:$D(DUZ)[0  S ZISPLU=$S($D(^VA(200,DUZ,"SPL")):^("SPL"),1:"") I $P(ZISPLU,"^",1)'["y" W !,?5,$C(13),"You must be authorized by IRM to use spooling" Q
 S DIC=3.51,DIC(0)="AEMQZ" D ^DIC Q:Y<0  I $P(Y(0),U,2)]"" W !,?5,$C(13),"This spool is still active and can't be worked on." G GETDOC
 S ZISDA=+Y,ZISPL0=Y(0) K DIC Q
 ;
PRINT ;
 N %,DIC,DIE,DR,DA,X,Y,ZISPL0,ZISPG,ZISDA,ZISDA2,ZISPLC,ZISFDA,ZISIEN,ZISIOP,ZISMSG
P S DIC("A")="Print which SPOOL DOCUMENT: " D GETDOC K IOP,%ZIS,%IS Q:Y<0
 S ZISPG=$P(ZISPL0,U,8) I $P(ZISPL0,U,3)="m" W !,"Sorry, this spool document has been converted into a mail message",!,"and you are unable to print it" G EXIT
 I $P(ZISPL0,U,10)'>0 W !,"Sorry there isn't anything to print." G EXIT
 I $P(ZISPL0,U,11) D MSG2 S %=2 D YN^DICN G EXIT:%'=1
IO ;
 S DIR(0)="N^1:99",DIR("A")="Copies to Print" D ^DIR S ZISPLC=+$G(Y) I $D(DIRUT) G EXIT
 U IO(0) S %IS="MQ" D ^%ZIS G:POP EXIT S ZISIOP=ION_";"_IOST_";"_IOM_";"_IOSL
 U IO(0) S ZISDA2=$$FIND1^DIC(3.5121,","_ZISDA_",","O",ION)
 I ZISDA2>0,$P(^XMB(3.51,ZISDA,2,ZISDA2,0),"^",3) S ZISMSG="This device is currently printing a copy of this document" G CIO
 I +ZISPG>IOM!($P(ZISPG,";",2)>IOSL) S ZISMSG="Current page is "_IOM_" by "_IOSL_$C(13,10)_" Page must be at least "_(+ZISPG)_" by "_$P(ZISPG,";",2) G CIO
 S %=$S(ZISDA2>0:ZISDA2_",",1:"?+1,")_ZISDA_","
 S ZISFDA(3.5121,%,.01)=ION,ZISFDA(3.5121,%,1)=ZISPLC D UPDATE^DIE("","ZISFDA","ZISIEN")
 S:ZISDA2'>0 ZISDA2=ZISIEN(1)
 W ! I '$D(IO("Q")) S %ZIS="",IOP=ZISIOP D ^%ZIS G:'POP DQP^ZISPL2
 S ZTRTN="DQP^ZISPL2",ZTDESC="Print spool document",ZTIO=ZISIOP,ZTSAVE("ZISDA")="",ZTSAVE("ZISDA2")="",ZTSAVE("ZISPLC")=""
 K IO("Q") D ^%ZTLOAD,^%ZISC K ZTSK G EXIT:$P(ZISPLU,"^",2)'["y" W !!,"Also send to" G IO
 ;
CIO ;Close device and go to IO
 D ^%ZISC U IO D:$D(ZISMSG)  G IO
 . W !,ZISMSG K ZISMSG
CEXIT ;Close device and Exit
 D ^%ZISC
EXIT D KILL^XUSCLEAN S ZTREQ="@" Q
 ;
KERMIT ;Use Kermit to send a spooler file
 D GETDOC Q:Y'>0  S ZISDA=$P(ZISPL0,U,10) G EXIT:ZISDA'>0 S XTKDIC="^XMBS(3.519,"_ZISDA_",2,",XTKFILE=$P(ZISPL0,U)
 D MODE^XTKERMIT G EXIT:$D(DIRUT) D SEND^XTKERMIT G EXIT
 ;
BROWSE ;Use FM Browser to look at document
 D GETDOC Q:Y'>0  S ZISDA=$P(ZISPL0,U,10) G EXIT:ZISDA'>0
 D BROWSE^DDBR($NA(^XMBS(3.519,ZISDA,2)),"NR",$P(ZISPL0,U)) G EXIT
 ;
MAIL ;Make into a mail message (move text from file #3.519 to file #3.9)
 N ZISPLU,ZISDA,ZISPL0,XS,ZISLINES,DIR,X,Y
 S ZISPLU=$G(^VA(200,DUZ,"SPL")) I $P(ZISPLU,U,3)["n" W !,"You are not authorized to convert Spool Documents into MailMan Messages." G EXIT
 D GETDOC G:'$D(ZISPL0) EXIT
 S XS=$P(ZISPL0,"^",10) I 'XS D MSG1 G EXIT
 S ZISLINES=$P(ZISPL0,U,9) I '+ZISLINES D MSG1 G EXIT
 K DIR,X,Y
 S DIR(0)="Y"
 S DIR("A")="Convert spool doc: "_$P(ZISPL0,U)_" into a MailMan message"
 S DIR("B")=$$EZBLD^DIALOG(39054) ; Yes
 D ^DIR G:'Y EXIT
 N XMDUZ,ZISSUBJ,ZISINSTR,ZISABORT,XMV
 S ZISABORT=0
 D INITAPI^XMVVITAE
 D ASK(.ZISSUBJ,.ZISINSTR,.ZISABORT) I ZISABORT G CLEAN
 G:ZISLINES<500 MAILIT
 W !
 K DIR,X,Y
 S DIR(0)="Y"
 S DIR("A",1)="You have "_ZISLINES_" lines of text to convert into a MailMan message."
 S DIR("A")="Do you wish to queue this conversion process"
 S DIR("B")=$$EZBLD^DIALOG(39054) ; Yes
 D ^DIR I $D(DIRUT) G CLEAN
 G:'Y MAILIT
 N ZTIO,ZTRTN,ZTDESC,ZTDTH,ZTSAVE,I
 S ZTIO="",ZTRTN="MAILTASK^ZISPL",ZTDESC="Convert spool document into MailMan message"
 F I="ZISDA","XMDUZ","ZISSUBJ","ZISINSTR(","XMV(","^TMP(""XMY"",$J,","^TMP(""XMY0"",$J," S ZTSAVE(I)=""
 D ^%ZTLOAD
 I '$G(ZTSK) W !,"Queueing failed."
 E  W !,$$EZBLD^DIALOG(34501.1,ZTSK) ; Request queued.  Task number: |1|
 G CLEAN
MAILTASK ;
 N XS
 S XS=$P($G(^XMB(3.51,ZISDA,0)),"^",10)
 I 'XS D DSDOC(ZISDA) Q
MAILIT ;
 W:'$D(ZTQUEUED) !!,$$EZBLD^DIALOG(34234) ; Moving to a MailMan message...
 N XMZ
 D CRE8XMZ^XMXAPI(ZISSUBJ,.XMZ) I $D(XMERR) G CLEAN
 D MOVEBODY^XMXAPI(XMZ,"^XMBS(3.519,"_XS_",2)") I $D(XMERR) G CLEAN
 W:'$D(ZTQUEUED) !,$$EZBLD^DIALOG(34236) ; Finished moving.
 D SENDMSG^XMAPHOST(DUZ,XMZ,.ZISINSTR)
 D DSDOC(ZISDA),DSD(XS)
CLEAN ;
 I $D(XMERR) D
 . I '$D(ZTQUEUED) D SHOWERR^XMXAPIU Q
 . K XMERR,^TMP("XMERR",$J)
 D CLEANUP^XMXADDR
 G EXIT
ASK(ZISSUBJ,ZISINSTR,ZISABORT) ;
 S ZISSUBJ=$E("Spool document: "_$P(ZISPL0,"^"),1,65)
 D SUBJ^XMXAPIU(.ZISSUBJ) I $D(XMERR) S ZISABORT=1 Q
 D FROMWHOM^XMAPHOST(DUZ,.ZISINSTR,.ZISABORT) Q:ZISABORT
 S ZISINSTR("ADDR FLAGS")="R"
 D TOWHOM^XMXAPIU(DUZ,"","S",.ZISINSTR)
 I $D(XMERR) S ZISABORT=1
 Q
DSD(DA) ; Delete an entry in the spool data file.
 Q:DA'>0  N DIK K ^XMB(3.51,"AM",DA) S DIK="^XMBS(3.519," D ^DIK
 Q
DSDOC(DA) ; Delete an entry in the spool doc file.
 Q:DA'>0  N DIK S DIK="^XMB(3.51," D ^DIK
 Q
MSG1 W !,"This spool document doesn't have any text."
 Q
MSG2 W !,"You have exceeded the total spool document line limit allowed."
 W !,"Therefore, this spool document is incomplete."
 W !!,"Do you still wish to print this document"
 Q
