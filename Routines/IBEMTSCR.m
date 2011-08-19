IBEMTSCR ;ALB/RFJ-print billable types for visit copay ;23 Nov 01
 ;;2.0;INTEGRATED BILLING;**167,187,351**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 W !!,"This option will print the billable types for copay visits."
 W !,"You have the option to deliver the report to yourself in MailMan"
 W !,"or print the report to a printer or on your screen."
 ;
 N IBFMAIL,%ZIS,IBFPOST,POP,ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE
 S IBFMAIL=$$ASKPRINT
 I IBFMAIL<0 Q
 ;
 ;  select device
 I 'IBFMAIL D  I $D(IO("Q"))!(POP) K IO("Q"),ZTSK Q
 .   W ! S %ZIS="Q" D ^%ZIS Q:POP
 .   I $D(IO("Q")) D  D ^%ZTLOAD Q
 .   .   S ZTDESC="IB Visit Copay Billing Types",ZTRTN="DQ^IBEMTSCR"
 .   .   S ZTSAVE("IBFMAIL")="",ZTSAVE("ZTREQ")="@"
 ;
 W !!,"<*> please wait <*>"
 ;
 ;
DQ ;  print report
 ;  variable ibfmail=1 to print to a mail message
 ;  variable ibfpost=1 if from post init
 N IBDA,IBDATA,IBLINE,IBSTOP,X,XMY
 ;
 ;  *** build the report in tmp ***
 ;
 ;  report line counter
 S IBLINE=0
 ;
 D SET("This message is a summary of the Visit Copay Billing Types defined")
 D SET("for your station.")
 ;D SET("IB MEANS TEST.")
 D SET(" ")
 ;
 D SET("The following Visit Copay Billing Types are defined for your station:")
 D SET("Stop Code    Description                        Effective Date  Billable Type")
 D SET("---------    -----------------------------      --------------  -------------")
 S IBSTOP="" F  S IBSTOP=$O(^IBE(352.5,"B",IBSTOP)) Q:IBSTOP=""  D
 .   S IBDA=0 F  S IBDA=$O(^IBE(352.5,"B",IBSTOP,IBDA)) Q:'IBDA  S IBDATA=^IBE(352.5,IBDA,0) D
 .   .   ;  stop code
 .   .   S X=$J($P(IBDATA,"^"),9)
 .   .   ;  description
 .   .   S X=X_"    "_$P(IBDATA,"^",4)_$J("",35-$L($P(IBDATA,"^",4)))
 .   .   ;  effective date
 .   .   I '$P(IBDATA,"^",2) S $P(IBDATA,"^",2)="???????"
 .   .   S X=X_$E($P(IBDATA,"^",2),4,5)_"/"_$E($P(IBDATA,"^",2),6,7)_"/"_$E($P(IBDATA,"^",2),2,3)
 .   .   ;  billable type
 .   .   D SET(X_$J("",8)_$$TYPE($P(IBDATA,"^",3)))
 ;
 ; *** print or deliver the report from tmp ***
 ;
 ;  print the report
 I '$G(IBFMAIL) D
 .   N %,%I,IBFLAG,IBNOW,IBPAGE,IBSCREEN,X,Y
 .   D NOW^%DTC S Y=% D DD^%DT S IBNOW=Y
 .   S IBPAGE=1
 .   S IBSCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S IBSCREEN=1
 .   U IO D H
 .   ;
 .   S IBLINE=0 F  S IBLINE=$O(^TMP($J,"IBEMTSCR",IBLINE)) Q:'IBLINE!($G(IBFLAG))  S IBDATA=^(IBLINE) D
 .   .   I $Y>(IOSL-4) D:IBSCREEN PAUSE Q:$G(IBFLAG)  D H
 .   .   W !,IBDATA
 .   ;
 .   D ^%ZISC
 ;
 ;  deliver the report in mailman
 I $G(IBFMAIL) D
 .   I $G(IBFPOST) S XMY("G.IB MEANS TEST")=""
 .   S XMY(DUZ)=""
 .   S X=$$SENDMSG("IB Visit Copay Billing Types",.XMY)
 ;
 K ^TMP($J,"IBEMTSCR")
 Q
 ;
 ;
SET(DATA)       ; store report
 S IBLINE=IBLINE+1,^TMP($J,"IBEMTSCR",IBLINE)=DATA
 Q
 ;
 ;
SENDMSG(XMSUB,XMY) ;  send message with subject and recipients
 N %X,D0,D1,D2,DIC,DICR,DIW,X,XCNP,XMDISPI,XMDUN,XMDUZ,XMTEXT,XMZ,ZTPAR
 S XMDUZ="IB PACKAGE",XMTEXT="^TMP($J,""IBEMTSCR"","
 D ^XMD
 Q +$G(XMZ)
 ;
 ;
TYPE(CODE) ;  return the billable type based on set of codes
 I CODE=1 Q "Basic Care"
 I CODE=2 Q "Specialty Care"
 Q "Non-Billable"
 ;
 ;
ASKPRINT() ;  ask to print in mail or printer
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Do you want to deliver the report in MailMan"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
PAUSE ;  pause at end of page
 N X U IO(0) W !!,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" IBFLAG=1 U IO Q
 ;
 ;
H ;  header
 S %=IBNOW_"  PAGE "_IBPAGE,IBPAGE=IBPAGE+1 I IBPAGE'=2!(IBSCREEN) W @IOF
 W $C(13),"IB VISIT COPAY BILLING TYPES",?(80-$L(%)),%
 W !,$TR($J("",79)," ","-")
 Q
