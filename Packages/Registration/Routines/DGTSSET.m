DGTSSET ;ALB/LM - TREATING SPECIALTY SETUP & INITIALIZATION ; 4-1-93
 ;;5.3;Registration;**27,36,39,64,68,85,242**;Aug 13, 1993
 ;
START S DGEGL=+^DG(43,1,"G")\1 ; G&L init date
 S DGTSDIV=+$P($G(^DG(43,1,"GL")),"^",2) ; Multidivision Med Center
 ;
 I DGEGL'?7N W !!,"I cannot run this program until you specify an early date",!,"to run the G&L in the site parameters.",!!,*7,*7 G END
 ;
 S DGEGL=$O(^DG(40.8,0)) I '$D(^DG(40.8,DGEGL)) W !!,"I cannot run this program until you set up your Medical Center's",!,"Division File",!!,*7,*7 G END
 ;
TSR ; Day before TSR Initialiation Date
 S DGTSIN=$S($D(^DG(43,1,"G")):+$P(^DG(43,1,"G"),"^",11),1:"")
 ;
 I DGTSIN'>0 S DGTSIN=2921001
 S DGTSINDT=$$FMTE^XLFDT(DGTSIN) ; init date - external format
 S X1=DGTSIN,X2=-1 D C^%DTC S DGTSIN=X ; Internal format of date
 ;
 S DGTSDT=$$FMTE^XLFDT(DGTSIN)
 ;
FTS ; Facility Treating Specialty File
 W !
 S DIC="^DIC(45.7,",DIC(0)="AEQMZL",DLAYGO=45.7 D ^DIC G END:+Y'>0
 ;
 ;S DIE=DIC,DA=+Y,DGTS=$P(^DIC(45.7,DA,0),"^"),DR=".01;1;2;10;99" D ^DIE ; DGTS = TS Name
 S DIE=DIC,(DGTSIEN,DA)=+Y,DGTS=$P(^DIC(45.7,DA,0),"^"),DR="[DGTREAT]" D ^DIE ; DGTS = TS Name
 ;
 K DGEGL,DIC,DIE,Y,DA,DR,X,X1,X2
 ;
 ; This note was commented out (in patch DG*5.3*39) because it is only
 ; applicable to the initial setup of existing treating specialties for
 ; the Treating Specialty report.  It does not apply to new
 ; treating specialties.  (RESTORED - PATCH DG*5.3*85)
 ;
NOTE ; note to be displayed;
 W !!?5,"The information for the ",DGTS," treating specialty"
 W !?5,"should be entered ",$S($D(DGTSDIV):"by Medical Center Division",1:"")," as of midnight on "
 W !?5,DGTSDT," to properly initialize the Treating Specialty Report!",!!
 W ?5,"Following any new entries to or revisions of this data, "
 W !?5,"the G&L MUST BE recalculated back to ",DGTSINDT,".",!!
 ;
 W !
 S DGTSIF=$S($D(^DIC(45.7,"B",DGTS)):$O(^DIC(45.7,"B",DGTS,0)),1:-1) ; TS Internal Format (IEN) of Facility Treating Specialty
 ;
DV ; Medical Center Division File
 S DIC="^DG(40.8,",DIC(0)="AEQZ"
 ;
 I DGTSDIV D ^DIC G FTS:+Y'>0 S (DGTSDV,DA)=+Y
 ;
 I 'DGTSDIV S (DGTSDV,DA)=$O(^DG(40.8,0))
 ;
C ;    Treating Specialty Multiple
 ;         Census Multiple
 S DIE="^DG(40.8,",DR="[DGTS]" D ^DIE
 ;
 K DA,DR,DIE,DIC,Y,X
 ;
 I DGTSDIV G DV
 ;
 I 'DGTSDIV G FTS
 ;
PR ;
 W !!,"This report should be printed on 132 columns.",!
 S L=0,DIC="^DIC(45.7,",FLDS="[DGTREAT]",DHD="" D EN1^DIP Q
 ;
END K DGEGL,DGTSIN,DGTSDT,DGTSIF,DGTSDV,DGTSDIV,DGTS,DGTSIEN,DGTSPT,DIC,DIE,DA,DR,X,X1,X2 Q
