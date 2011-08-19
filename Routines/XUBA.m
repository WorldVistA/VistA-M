XUBA ; BT/BP - LIST USERS HAVE INACTIVE PERSON CLASSES; 4/27/2010
 ;;8.0;KERNEL;**541**; July 10, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PR ; entry point of the option LIST USERS NEED TO BE ASSIGNED NEW PERSON CLASSES
 N DIR,XUA541,Y S DIR("A")="Do you want to list active users only",DIR(0)="Y",DIR("B")="NO" D ^DIR
 S XUA541=$G(Y) I XUA541="^" Q
 W @IOF,! S %ZIS="MQ" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTIO=ION,ZTRTN="PRNT^XUBA",ZTSAVE("XUA541")="",ZTDESC="LIST USERS NEED PERSON CLASSES" D ^%ZTLOAD D HOME^%ZIS
 I $D(ZTSK) W !,"Queued as task# ",ZTSK,!! D PAUSE G EXIT
 ;
PRNT ; print the report
 U IO D INPSC,LIST(XUA541)
 N XUI,XUC,XUPG,XUB S XUC=0,XUPG=1,XUB=0
 N XUPSUP D PGBK ;set value of the page break for devices
 D HDR  ;Header
 S XUI="" F  S XUI=$O(^TMP("XUINPSCN",$J,XUI)) Q:XUI=""  D
 . W !,$G(XUI),?20,$G(^TMP("XUINPSCN",$J,XUI))
 . S XUC=XUC+1
 . X XUPSUP ;page set up and break
 I XUB=1 Q
 W !!!,"Number of users: ",XUC
 I $E(IOST,1,2)="C-" W !! D PAUSE
 D EXIT
 Q
 ;
INPSC ;get all inactive Person Class from the PERSON CLASS FILE.
 N XUI,XUY,COUNT
 K ^TMP("XUINPSC",$J)
 S COUNT=$P($G(^USC(8932.1,0)),"^",4)
 F XUI=1:1:COUNT D
 . I $$GET3^XUPCF(XUI)="Inactive" S ^TMP("XUINPSC",$J,XUI)=$$GET5^XUPCF(XUI)
 Q
 ;
LIST(XUA541) ; get all users who need to be assigned a new Person Class.
 N XUI,XUY,XUV,XUIEN,%
 K ^TMP("XUINPSCN",$J)
 S XUIEN=0 F  S XUIEN=$O(^VA(200,XUIEN)) Q:XUIEN'>0  D
 . I XUA541=1,'(+$$ACTIVE^XUSER(XUIEN)) Q
 . S XUY=+$$GET^XUA4A72(XUIEN) Q:XUY'>0
 . I $D(^TMP("XUINPSC",$J,XUY)) D
 . . N XUNAME S XUNAME=$E($P($G(^VA(200,XUIEN,0)),"^"),1,18)
 . . I XUNAME'="" S ^TMP("XUINPSCN",$J,XUNAME)=$E($P($$GET^XUA4A72(XUIEN),"^",1,2),1,60)
 Q
 ;
CLEAN ;clean the global
 K ^TMP("XUINPSC",$J)
 K ^TMP("XUINPSCN",$J)
 Q
 ;
PGBK ;page break
 S XUPSUP="I $Y>(IOSL-3) S XUPG=XUPG+1 W @IOF D HDR"
 I $E(IOST,1,2)="C-" S XUPSUP="I $Y>(IOSL-3) S XUPG=XUPG+1 D PAUSE I XUB'=1 W @IOF D HDR"
 Q
 ;
HDR ;
 W ?IOM-40,"Report on ",$$FMTE^XLFDT($$DT^XLFDT),"    Page ",$G(XUPG),!
 W !,"User name:",?20,"Currently has the inactive Person Class IEN^NAME:"
 W !,"----------",?20,"-------------------------------------------------"
 Q
 ;
PAUSE ;
 W !,"Press RETURN to continue or '^' to exit: " R XUB:DTIME
 I '$T S XUI="zzzzzzzzz"
 I XUB["^" S XUI="zzzzzzzzz",XUB=1
 Q
 ;
EXIT ;
 D CLEAN
 D ^%ZISC
 K %ZIS,ZTDESC,ZTSK,ZTIO,ZTRTN,ZTSAVE
 Q
