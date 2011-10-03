SPNMAIN ;SAN/WDE/Display/edit divison of the user./2/15/2000
 ;;2.0;Spinal Cord Dysfunction;**12,13,15,20**;01/02/1997
 ;
EN(DUZ) ;
 Q:'$D(DUZ)
 ;returns the 3 or 5 digit station number  ie 644 or 665BY.
 S SPNDIV=$P($G(^SPNL(154.91,1,1,DUZ,0)),U,2)
 Q SPNDIV
 ;
EN2(DUZ) ;
 Q:'$D(DUZ)
 ;returns the division name
 S SPNDIV1=$P($G(^SPNL(154.91,1,1,DUZ,0)),U,2) I SPNDIV1="" Q SPNDIV1
 S SPNDIV2="",SPNDIV2=$O(^DG(40.8,"C",SPNDIV1,SPNDIV2))
 I SPNDIV2="" S SPNDIV1="ERROR" K SPNDIV2 Q SPNDIV1
 S SPNDIV1=$P($G(^DG(40.8,SPNDIV2,0)),U,1)
 K SPNDIV2
 Q SPNDIV1
DISP ;display the site prefix and name to the user
 I $D(IOF) W @IOF
 Q:'$D(DUZ)
 S SPNUSE1=$P($G(^VA(200,DUZ,0)),U,1) S SPNUSE1=$P(SPNUSE1,",",2)_" "_$P(SPNUSE1,",",1)
 W !!?5,"Hello "_SPNUSE1
 I $$EN^SPNMAIN(DUZ)="" W !?10,"You need to select a division that you work under." D NEW D EDIT Q
 W !?5,"You are working under the division of ",$$EN^SPNMAIN(DUZ)," / ",$$EN2(DUZ),"."
 S SPNTST=$G(^SPNL(154.91,1,1,DUZ,0)),SPNTST=$P(SPNTST,U,4)
 I SPNTST'="Y" D LOAD^SPNDIV(DUZ) K SPNTST  ;ONE TIME LOAD INTO 154
 Q
EDIT ;
 ;used to change if user has an entry on file
 W !
 S DIE="^SPNL(154.91,1,1," ; global root of subfile
 S DA(1)=1 ; entry number in file
 S DA=DUZ ;Sub entry number
 I $D(DR)=0 S DR="1"
 S DIE(0)="AEMNQ"
 D ^DIE
 K DIE,DA,DR,X,Y
 I $$EN^SPNMAIN(DUZ)="" W !,"You are required to enter a Medical Center Division." H 2 D EDIT
 Q
NEW ;user did not have a division selected and we will add
 S DR=10
 S DR(1,154.91)="10;"
 S DIC="^SPNL(154.91,1,1,"
 S DIC(0)="AEMNQ"
 S DIC("P")=$P(^DD(154.91,10,0),U,2)
 S DA=1
 S DA(1)=1
 S X=DUZ,DINUM=DUZ
 D FILE^DICN
 K DIC,DR,DA,Y,X
 Q
