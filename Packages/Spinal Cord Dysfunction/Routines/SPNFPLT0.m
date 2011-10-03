SPNFPLT0 ;HISC/DAD-FIM SCORE REPORT ;9/15/95  10:58
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 K DIR
 S DIR(0)="SO^1:Self Report of Function;2:FIM;"
 S DIR("A")="Select the type of Functional Status you wish to print"
 S DIR("?",1)="Enter 1 to print Self Report of Function scores"
 S DIR("?",2)="Enter 2 to print FIM scores"
 S DIR("?")="Please enter 1 or 2"
 W ! D ^DIR S SPNFFTYP=Y_U_$G(Y(0)) I $D(DIRUT) G EXIT
 ;
 I +SPNFFTYP=2 D  G:$D(DIRUT) EXIT
 . K DIR S DIR(0)="SO^1:Motor Score;2:Cognitive Score;3:Total Score;"
 . S DIR("A")="Select the type of FIM score you wish to print"
 . S DIR("?",1)="Enter 1 to print Motor scores"
 . S DIR("?",2)="Enter 2 to print Cognitive scores"
 . S DIR("?",3)="Enter 3 to print Total scores"
 . S DIR("?")="Please enter 1, 2, or 3"
 . W ! D ^DIR S SPNFSTYP=Y_U_$G(Y(0))
 . Q
 E  D
 . S SPNFSTYP="3^Total Score"
 . Q
 K DIR S DIR(0)="DOA^:"_DT
 S DIR("A")="Enter the beginning date range: "
 S DIR("?")="Enter the beginning date to search for Functional Status scores"
 W ! D ^DIR S SPNFBDT=Y I $D(DIRUT) G EXIT
 K DIR S DIR(0)="DOA^"_SPNFBDT_":"_DT
 S DIR("A")="Enter the ending    date range: "
 S DIR("?")="Enter the ending date to search for Functional Status scores"
 D ^DIR S SPNFEDT=Y I $D(DIRUT) G EXIT
 K ^TMP($J,"SPNFPLT0")
 S SPNDIC="^SPNL(154.1,",SPNDIC(0)="AEMNQZ"
 S SPNDIC("A")="Select PATIENT: ",SPNUTIL="SPNFPLT0"
 ;S SPNDIC("S")="I $O(^SPNL(154.1,""AA"",+SPNFFTYP,+Y,0))"
 S SPNDIC("S")="I $$SCREEN^SPNFPLT0(Y)"
 S SPNDIC("W")=""
 D ^SPNUTL0 I SPNQUIT G EXIT
 ;
 K %ZIS,IOP S %ZIS="QM" W ! D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="TASK^SPNFPLT0"
 . S (ZTSAVE("SPNFFTYP"),ZTSAVE("SPNFSTYP"))=""
 . S (ZTSAVE("SPNFBDT"),ZTSAVE("SPNFEDT"))=""
 . S ZTSAVE("^TMP($J,""SPNFPLT0"",")=""
 . S ZTDESC="SCD Functional Status Scores Report"
 . D ^%ZTLOAD
 . Q
TASK ;
 D PRINT^SPNFPLT1
EXIT ;
 D ^%ZISC
 K %ZIS,DA,DIC,DIQ,DIR,DIRUT,DIROUT,DR,DTOUT,DUOUT,POP,SPNDIC,SPNEXIT
 K SPNFBDT,SPNFD0,SPNFDATE,SPNFDFN,SPNFEDT,SPNFFTYP,SPNFHI,SPNFLEVL
 K SPNFLO,SPNFOUND,SPNFPAGE,SPNFSTYP,SPNFTAB,SPNFUNDL,SPNPIECE,SPNQUIT
 K SPNSCORE,SPNTODAY,SPNUTIL,X,Y,ZTDESC,ZTRTN,ZTSAVE,^TMP($J,"SPNFPLT0")
 Q
SCREEN(Y) ;
 S SPNDOF=+$G(^SPNL(154.1,+Y,0))
 I '$D(^SPNL(154.1,"AA",+SPNFFTYP,SPNDOF)) G Q
 S SPNDOF(1)=$O(^SPNL(154.1,"AA",+SPNFFTYP,SPNDOF,0))
 S SPNDOF(2)=$O(^SPNL(154.1,"AA",+SPNFFTYP,SPNDOF,SPNDOF(1),0))
 I '$D(^SPNL(154.1,"AA",+SPNFFTYP,SPNDOF,SPNDOF(1),+Y)) G Q
 I '$O(^SPNL(154.1,"AA",+SPNFFTYP,SPNDOF,0)) G Q
 I +Y>SPNDOF(2) G Q
 K SPNDOF
 Q 1
Q K SPNDOF
 Q 0
