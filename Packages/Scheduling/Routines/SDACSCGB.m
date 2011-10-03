SDACSCGB ;ALBISC/TET - BATCH UPDATE COMP GEN APPT TYPES FOR C&P'S ;3/23/92  13:59
 ;;5.3;Scheduling;**132**;Aug 13, 1993
 ;
BATCH ; - enter here for batch update cg appt types fm cg (possible C&P) to C&P
READ ;enter here to read
 D ASK2^SDDIV G EXIT:Y<0
 ;
R1 ; -- get date range
 S DIR(0)="D^::ET"
 S DIR("A")="Enter Beginning Date"
 S DIR("?")="^D HELP^%DTC"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S SDBEG=Y
 I SDBEG>DT W !,"   Future dates are not allowed.",*7 G R1
 D DD^%DT S FR=Y
 ;
 S DIR(0)="D^"_SDBEG_":NOW:TE"
 S DIR("A")="Enter Ending Date"
 S DIR("?")="^D HELP^%DTC"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S SDBEG=SDBEG-.0001,SDEND=Y_".9999"
 D DD^%DT S TO=Y
 ;
 ; -- display selections
 W !!?8,"Selected date range begins on ",FR," and ends on ",TO
 W !?8,"Division:  ",$S(VAUTD:"ALL",1:"")
 IF 'VAUTD S SDDIV=0 F I=1:1 S SDDIV=$O(VAUTD(SDDIV)) Q:'SDDIV  D
 . W:'(I#2) ?45,VAUTD(SDDIV),!
 . W:(I#2) ?20,VAUTD(SDDIV)
 W !!
 ;
 S DIR("A",1)="   This option will automatically update the Computer Generated"
 S DIR("A",2)="   appointment types which are possible C&P to C&P appointment"
 S DIR("A",3)="   type for the above parameters."
 S DIR("A",4)=""
 S DIR("A")="   Are you sure you wish to continue"
 S DIR("?")="Enter 'Yes' to automatically update appointment type, 'No' to exit."
 S DIR("?",1)="You should exercise this option after you have reviewed"
 S DIR("?",2)="visits which have an appointment type of 'Computer Generated'"
 S DIR("?",3)="AND after you have selectively edited any possible C&Ps which are not."
 S DIR("?",4)="   "
 S DIR("?",5)="This option will then update all remaining visits which have"
 S DIR("?",6)="a computer generated appointment type due to a possible C&P visit"
 S DIR("?",7)="to a Comp & Pen appointment type for the parameters selected."
 S DIR("?",8)="  "
 S DIR(0)="YO"
 D ^DIR K DIR G:$D(DIRUT)!('Y) EXIT
 ;
 ; -- queue job
 S DGVAR="SDBEG^SDEND^VAUTD#"
 S DGPGM="UPD^SDACSCGB"
 D ZIS^DGUTQ
 G:POP EXIT
 ;
UPD ; -- queue entry point
 N SDT,SDOE,SDOE0,SDOECG,SDDIV,DFN,SDDAT,DASH,PG,CT,SDAPTYPR,Y,VA
 ;
 S (PG,CT)=0
 S DASH="",$P(DASH,"-",79)=""
 W:$E(IOST,1,2)="C-" @IOF
 D HDR
 ;
 S SDT=0
 F  S SDT=$O(^SCE("ACG",SDT)) Q:'SDT  D  G:$D(DIRUT) EXIT
 . S SDOE=0
 . F  S SDOE=$O(^SCE("ACG",SDT,SDOE)) Q:'SDOE  D  Q:$D(DIRUT)
 . . S SDOE0=$G(^SCE(SDOE,0))
 . . S SDOECG=$G(^SCE(SDOE,"CG"))
 . . S SDDAT=+SDOE0
 . . S SDDIV=+$P(SDOE0,U,11)
 . . S DFN=$P(SDOE0,U,2)
 . . S SDAPTYPR=+$P(SDOECG,U,2)
 . . IF VAUTD!($D(VAUTD(SDDIV))),SDDAT'<SDBEG,SDDAT'>SDEND D  Q:$D(DIRUT)
 . . . S Y=SDDAT D DD^%DT S SDY=Y
 . . . D DEM^VADPT
 . . . IF SDAPTYPR=2 D DIE
 ;
 W !?10,CT," Visit"_$S(CT=1:"",1:"s")_" updated ...Batch update complete.",*7
 ;
EXIT ; -- exit logic
 K %DT,CT,D,DA,DASH,DE,DFN,DFN0,DGPGM,DIC,DIE,DIRUT,DQ,DR
 K DTOUT,DUOUT,FR,I,J,PG,POP,SDA,SDAPTYPR,SDBEG,SDCSNODE
 K SDDAT,SDDIV,SDEND,SDUPDT,SDY,SDZN,SDTYPE,TO,VADM,VAEL
 K VAERR,VAUTD,VA,X,Y
 D CLOSE^DGUTQ
 Q
 ;
DIE ; -- update entry
 N DIE,DR,DA,DE,DQ
 S DIE="^SCE(",DA=SDOE,DR=".1////^S X=1;202///@" D ^DIE
 ;
 S CT=CT+1
 D:$Y+6>IOSL CR Q:$D(DIRUT)
 W !,SDY,?35,$S('VAERR:$E(VADM(1),1,30),1:"UNKNOWN")
 Q
 ;
CR ; -- end of page processing
 I $D(IOST),$E(IOST,1,2)="C-" D  Q:$G(DIRUT)
 . S DIR(0)="E"
 . W ! D ^DIR K DIR
 . I $D(DUOUT)!($D(DTOUT)) D
 . . S DIRUT=1
 . . W !,SDY,?35,$S('VAERR:$E(VADM(1),1,30),1:"UNKNOWN"),!!,"Update incomplete!",*7
 W @IOF D HDR
 Q
 ;
HDR ; -- header processing
 S PG=PG+1
 W !?17,"UPDATED COMPUTER GENERATED APPOINTMENT TYPES",!!,"Date/Time",?35,"Name",?68,"Page ",PG,!,DASH,!!
 Q
 ;
