DGYVPST1 ;ALB/LD - Patch DG*5.3*64 Post-Init (cont.); 8/8/95
 ;;5.3;Registration;**64**;Aug 13, 1993
 ;
 ;
 ;
 ;
PRTERR ;--Print errors which occurred during pop of file #45.7 Eff Date mult
 N DGPTE,DGPTM,DGPTMSG,DGPTS
 S (DGPTM,DGPTS,DGPTE)=0
 I $E(IOST,1,2)="C-" D HDR
 F  S DGPTM=$O(^TMP("DGPTERR",$J,DGPTM)) Q:'DGPTM!($G(DGPTEX))  D
 .F  S DGPTS=$O(^TMP("DGPTERR",$J,DGPTM,DGPTS)) Q:'DGPTS!($G(DGPTEX))  D
 ..F  S DGPTE=$O(^TMP("DGPTERR",$J,DGPTM,DGPTS,DGPTE)) Q:'DGPTE!($G(DGPTEX))  D
 ...W !,"Specialty: ",$S($P($G(^DIC(42.4,DGPTM,0)),U)]"":$P($G(^DIC(42.4,DGPTM,0)),U),1:"UNKNOWN")
 ...W !,"Facility Treating Specialty: ",$S($P($G(^DIC(45.7,DGPTS,0)),U)]"":$P($G(^DIC(45.7,DGPTS,0)),U),1:"UNKNOWN")
 ...S DGPTMSG=$P($T(ERRMSG+DGPTE),";;",2)
 ...W !,DGPTMSG,!
 ...I $Y>(IOSL-5) D PAUSE Q:$G(DGPTEX)  D HDR
 K DGPTEX
 Q
 ;
PAUSE ;--Pause for screen output
 Q:$E(IOST,1,2)'="C-"
 N XX,DIR,DIRUT,DUOUT
 F XX=$Y:1:(IOSL-3) W !
 S DIR(0)="E" D ^DIR I $D(DIRUT)!($D(DUOUT)) S DGPTEX=1
 Q
 ;
HDR ;--Screen header
 W @IOF,?21,"Patch DG*5.3*64 Post-Init Report",!!
 Q
 ;
ERRMSG ;--Error messages
 ;;Error with entry in file #42.4: Effective Date multiple zero node not found.
 ;;Error with entry in file #42.4: Incomplete Effective Date multiple zero node.
 ;;Error with entry in file #42.4: Missing Effective Date field in multiple.
 ;;Error with entry in file #45.7: Post-init terminated by user.
 ;;Effective Date multiple data already exists for this facility treating spec.
 ;
INACT ;-- Report of inactive facility treating specialties.  These
 ;-- should be edited through the Treating Specialty Set-up option
 ;-- [DG TREATING SETUP] under the ADT System Definition Menu.
 ;
 N DGFAC,DGI,DGJ,DGX,POP
 W !!,">>> Creating Inactive Treating Specialty Report...",! H 2
 F DGI=70,71,77 D
 .F DGJ=0:0 S DGJ=$O(^DIC(45.7,"ASPEC",DGI,DGJ)) Q:'DGJ  S DGFAC(DGJ)=DGI_"^"_$P($G(^DIC(45.7,DGJ,0)),U)
 S %ZIS="MP" D ^%ZIS K %ZIS I POP Q
 U IO
 W @IOF,?23,"INACTIVE TREATING SPECIALTY REPORT",!
 W !!?4,"The following facility treating specialties point to treating specialties",!?4,"which are now inactive.  These facility treating specialties should be"
 W !?4,"edited to point to active specialties through the Treating Specialty",!?4,"Set-up option [DG TREATING SETUP] under the ADT System Definition Menu.",!!
 W !?8,"FACILITY TREATING SPECIALTY",?46,"INACTIVE TREATING SPECIALTY"
 W !?8,"===========================",?46,"===========================",!
 F DGX=0:0 S DGX=$O(DGFAC(DGX)) Q:'DGX  W !?8,$P($G(DGFAC(DGX)),U,2),?46,$P($G(^DIC(42.4,$P($G(DGFAC(DGX)),U),0)),U)
 I '$D(DGFAC) W !?4,"No inactive facility treating specialties found.",!
 D ^%ZISC
INACTQ Q
