LRAR01 ;DAL/HOAK EXTENSION OF LRAR00 ; 12/12/96  10:16 ;
 ;;5.2;LAB SERVICE;**111**;Sep 27, 1994
INIT ;
 ;
 ;
EN02 ;
CLEAN ;
 ;            REMOVE ^LAR FOR READ TAPE IN
 ;
 W !,"I will now CLEAR out the global"
 D FLAG
 ;
 S OK=1
 I F1<2 W !,"Search pass has not completed. " D
 .  W "Want to CLEAR ^LAR anyway" S %=1 D YN^DICN S:%'=1 OK=0
 Q:'OK
 ;
 S X=100
 F  S X=$O(^LAR(X)) Q:X=""  K ^LAR(X)
 S ^LAR("Z",0)="ARCHIVED LR DATA^63.9999"
 I P1,$P(^LAB(69.9,1,6,P1,0),U,4)=2 S $P(^(0),U,4)=3
 W !!,"Now read the tape back in to make sure we have a good tape."
 W !,"Then do the PURGE pass."
 QUIT
EN03 ;
PURGE ;
 ;          PURGE DATA FROM ^LR THAT IS IN ^LAR
 D FLAG
 ;
 I F1<3 W !," Please clear and reload the archive global.",$C(7) Q
 ;
 I F1'=3 W !,"PURGE in progress, or completed. Please let it finish." Q
 ;
 D DEV1^LRAR01 I POP D QUIT Q
 ;
 I $D(IO("Q")) K IO("Q") S ZTRTN="DQ2^LRCHIV",ZTSAVE("P1")="" D  QUIT
 .  S ZTSAVE("F1")="",ZTSAVE("LR(")="" D ^%ZTLOAD D QUIT
 ;
DQ2 ;
 I $P(^LAB(69.9,1,6,P1,0),U,4)'=3 D  D QUIT Q
 .  W !!,"Not in the right state.",!!
 S $P(^LAB(69.9,1,6,P1,0),U,4)=4
 D EN^LRAR05 S $P(^LAB(69.9,1,6,P1,0),U,4)=5
 K ^LAR("NAME"),^LAR("SSN"),^LAR("Z"),^LAB(69.9,1,"TAPE")
 K ^LAB(69.9,1,"LRDFN"),^LAB(69.9,1,"PURGE LRDFN")
 S ^LAR("Z",0)="ARCHIVED LR DATA^63.9999"
 D QUIT
 Q
 ;
FLAG ;
 ;       Whats happening in 69.9....
 ;
 S P1=$S($D(^LAB(69.9,1,"TAPE")):^("TAPE"),1:0)
 ;
 S F1=$S($D(^LAB(69.9,1,6,P1,0)):$P(^(0),U,4),1:0)
 ;
 ;     ^LAB(69.9,1,6,1,0) = TEST^TEST PHYSICAL^2860808.0904^1^2860500
 ;      Set a date range for LRIDT 
 ;
 Q
DEV ;
 D DEVICE^LRARCHIV
 QUIT
DEV1 S %ZIS="Q"
 S:'$D(%ZIS("A")) %ZIS("A")="ERROR LOG REPORT: "
 D ^%ZIS K %ZIS Q
 Q
 ;
KILL ;
 W ! W:$E(IOST,1,2)="P-" @IOF
 S ZTQUE="@"
 D ^%ZISC
 K I,J,LRPAT,LRDAT,LRDPF,LRIDT,LRSS,LRSUB,P1,PNM,SSN,X0,X1,X2,X3
 K ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE
 Q
 ;
PRT ;
 Q
 S %ZIS="Q",%ZIS("A")="Printer "
 D DEV
 I POP D KILL Q
 ;
 S LRPAT=1
 I $D(IO("Q")) S ZTRTN="LST^LRARCHIV",ZTSAVE("LRPAT")="" D
 .  S ZTDESC="Print Archive Patients" D ^%ZTLOAD G KILL
 D LST^LRARCHIV
QUIT D KILL
 QUIT
