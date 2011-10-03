IBOSTUS ;ALB/SGD - MCCR BILL STATUS REPORT ;25 MAY 88 14:19
 ;;2.0;INTEGRATED BILLING;**118,128,137,161,155**;21-MAR-94
 ;
 ;MAP TO DGCROST
 ;
EN I '$D(DT) D DT^DICRW
 ;
 S IBNOEOB=0  ;init.
 ;
 ; - Choose bill status, if necessary.
 S DIR(0)="Y",DIR("A")="Do you want to print the status of ALL bills"
 S DIR("B")="YES",DIR("?")="Choose (Y)es or (N)o" W !
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G Q
 I Y S IBBST="ALL" G SORT
 ;
 S DIR(0)="399,.13AO^^I X[""*""!(X=5) W !,*7,""THIS STATUS IS NOT USED"" K X",DIR("A")="CHOOSE BILL STATUS: " D
 . N DA
 . W ! D ^DIR W ! K DIR
 I $D(DIRUT) G Q
 S IBBST=$E(Y(0)),IBHD=Y(0)
 ;
MRA ; If user chose MRA Request status, check if user wants to only print Bills with No MRA Received
 I IBBST'="R" G SORT
 S DIR(0)="Y",DIR("A")="Print ONLY Bills with No MRA Received and No CSA Rejection messages"
 S DIR("B")="No",DIR("?")="Enter (Y)es or (N)o"
 S DIR("??")="^D HELP4^IBOSTUS"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G Q
 S IBNOEOB=Y
 ;
SORT ; - Choose the date type to sort on.
 S DIR(0)="S^1:EVENT DATE;2:BILL DATE;3:ENTERED DATE;4:MRA REQUEST DATE"
 S DIR("A")="SORT BY",DIR("B")=1,DIR("?")="^D HELP2^IBOSTUS"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G Q
 S IBDTP=$S(Y=1:"Event",Y=2:"Bill",Y=3:"Entered",Y=4:"MRA Request",1:"") Q:IBDTP=""
DATE W ! S %DT="AEPX",%DT("A")="Start with "_IBDTP_" DATE: ",%DT(0)=-DT
 D ^%DT G Q:Y<0 S IBBEG=Y
DATE1 S %DT="EPX" W !,"Go to "_IBDTP_" DATE: TODAY// " R X:DTIME
 S:X=" " X=IBBEG G Q:(X["^") S:X="" X="TODAY" D ^%DT I Y<0 G DATE1
 S IBEND=Y I IBEND<IBBEG W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G DATE1
 I IBEND>DT W *7," ??" G DATE1
 ;
PS ; - Print summary, if necessary.
 S DIR(0)="Y",DIR("A")="Do you want to print the summary ONLY"
 S DIR("B")="NO",DIR("?")="^D HELP3^IBOSTUS" W !
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G Q
 S IBSUM=+Y
 ;
 ; If the user wants both the detail and summary reports AND
 ; if ClaimsManager is currently running, then ask the user if he
 ; or she wishes to display the Comments from the ClaimsManager
 ; file (#351.9).
 ;
 S IBCICOMM=0
 I 'IBSUM,$$CK0^IBCIUT1() D  I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G Q
 . W !
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to see ClaimsManager comments associated with these bills"
 . S DIR("B")="NO"
 . S DIR("?",1)="  Enter YES if you would like to see the comments which are stored in the"
 . S DIR("?",2)="    ClaimsManager file (#351.9) for each bill on this report."
 . S DIR("?")="  Enter NO if you do not want to see these comments."
 . D ^DIR K DIR
 . S IBCICOMM=+Y
 . Q
 ;
 W !!,*7,"*** Margin width of this output is ",$S(IBSUM:80,1:132)," ***"
 S %ZIS="QM" D ^%ZIS G:POP Q
 I $D(IO("Q")) K IO("Q") D  G Q
 .S ZTRTN="DQ^IBOSTUS",ZTDESC="IB - Bill Status Report",ZTSAVE("IB*")=""
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 ;
DQ ; - Tasked entry point.
 D EN^IBOSTUS1
 ;
Q D ^%ZISC
 K %,I,J,X,X1,X2,Y,Z,IBIFN,%DT,IBAPP,POP,IBPAGE,DGPGM,DGVAR,IBNEX,IBBEG
 K IBF,IBEND,IBHD,IBL,IBBST,IBBS,IBBSBY,IBBSDT,IB0,IBS,IBRUN,IBSUM,IBU1
 K IBDTP,IBBY,VAERR,DIRUT,DUOUT,DTOUT,DIROUT,IBCICOMM,IBNOEOB
 Q
 ;
HELP2 ; - Help for Sort By prompt.
 W !!,"   EVENT DATE is the date beginning the bill's episode of care"
 W !!,"   BILL DATE is the date the bill was initially printed"
 W !!,"   ENTERED DATE is the date the bill was first entered"
 W !!,"   MRA REQUEST DATE is the date the MRA request bill was sent to Medicare"
 Q
 ;
HELP3 ; - Help for Summary Only prompt.
 W !!,"Select (Y)ES to just print the bill status summary, or (N)O"
 W !," to print the BOTH the detail and summary reports."
 Q
 ;
HELP4 ; Help for No MRA on file prompt.
 W !,"Enter YES if you would like to see bills that are in a Request MRA status"
 W !,"with no MRAs and no CSA rejection messages on file."
 W !!,"Enter NO if you would like to see ALL bills that are in a Request MRA status."
 Q
 ;
SUM ; - Print summary.
 S:'IBSUM IBSUM=1 D HEAD^IBOSTUS1
 S IBST1="RATE TYPE  : ",IBST2="BILL STATUS: "
 F I="IBST1","IBST2" N IBTOT D
 .S IBCAT="" F  S IBCAT=$O(@I@(IBCAT)) Q:IBCAT=""  D
 ..I IBCRT,($Y>(IOSL-2)) D HEAD^IBOSTUS1
 ..S X=@I@(IBCAT,"$"),X2="2$" D COMMA^%DTC
 ..W !,IBCAT,?18,".................... ",?42,$J(X,15),?60,$J(@I@(IBCAT,"C"),6),?67," BILLS"
 ..S IBTOT("C")=$G(IBTOT("C"))+@I@(IBCAT,"C")
 ..S IBTOT("$")=$G(IBTOT("$"))+@I@(IBCAT,"$")
 .W !,?40,"-----------------",?60,"-------------"
 .S X=$G(IBTOT("$")),X2="2$" D COMMA^%DTC
 .W !?42,$J(X,15),?60,$J($G(IBTOT("C")),6),?67," BILLS",!
 ;
 Q
