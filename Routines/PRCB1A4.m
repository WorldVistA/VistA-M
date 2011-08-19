PRCB1A4 ;WOIFO/DWA-COPY FCP USERS TO NEW FCP ;3/8/04 2:22 PM
 ;;5.1;IFCAP;**76**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
V ; invalid entry
 Q
 ;
 ; this routine will copy users from an existing Fund Control Point
 ; to an empty Fund Control Point.
 ; 
EN ;
 S PRCF("X")="AS" D ^PRCFSITE I '$G(PRC("SITE")) Q
 S SITE=PRC("SITE")
 ;
 ;
 N FCP1,FCP2,PRFL,DIC,DIR,I,X,Y,FLDS,BY,TO,FR,IOP,L,B,PRCNT,PRCLAST
 ;
FROM ; prompt for FCP to copy FROM
 S DIR(0)="NA^1:9999^I 'X!('$D(^PRC(420,SITE,1,Y))) K X",DIR("A")="Select FCP to copy FROM: ",DIR("?")="Answer must be a valid 1-4 digit Fund Control Point number." D ^DIR K DIR
 I Y="^" G QUIT
 I 'Y D FROM
 S FCP1=Y K X,Y
 ;
DISPLAY ; display the user profiles for the chosen FCP
 W !!
 S L=0,DIC="^PRC(420,SITE,1,FCP1,1,",FLDS=".01;L20,1;L23,2;C51,3;C68",IOP=IO,BY=".01",FR=",",TO="",DHD="Control Point Users List "_FCP1 D EN1^DIP K DIC
 I '$D(^PRC(420,SITE,1,FCP1,1)) W !,?15,"*** NO USERS FOUND ***",!! G FROM
 I $P($G(^PRC(420,SITE,1,FCP1,1,0)),"^",3)="" W ! G FROM
 I '$$CONFRM(FCP1,.X)
 I X=1 G FROM
 I X=0 G QUIT
 I X=2 D
 . S X="^PRC(420,SITE,1,FCP1,1,",B=3
 . D ICLOCK^PRC0B(X,.B)
 . I 'B W !,"Someone else is using that FCP, please try later."
 . Q
 I 'B G FROM
 ;
GETFCP ; get the FCP to copy TO
 S DIR(0)="NA^1:9999^K:'$D(^PRC(420,SITE,1,Y))!('X) X",DIR("A")="Select FCP to copy TO: ",DIR("?")="Answer must be a valid 1-4 digit Fund Control Point number." D ^DIR K DIR
 I X="^" D DCLOCK^PRC0B("^PRC(420,SITE,1,FCP1,1,") G QUIT
 S FCP2=Y K X,Y
 I '$$CONFRM2(FCP2,.X) D DCLOCK^PRC0B("^PRC(420,SITE,1,FCP1,1,") G QUIT
 I X=1 G GETFCP
 I $P($G(^PRC(420,SITE,1,FCP2,1,0)),"^",3)'="" D  G QUIT
 . W !!,"I cannot complete the copy, FCP ==> "_FCP2_" is not empty."
 ;
 I X=2 S X="^PRC(420,SITE,1,FCP2,1,",B=3
 D ICLOCK^PRC0B(X,.B)
 I 'B W !,"Someone else is using that FCP, please try later." G GETFCP
 ;
XTRCT ;
 S PRCNT=0,PRCLAST=0
 S PRFL=0 F  S PRFL=$O(^PRC(420,SITE,1,FCP1,1,PRFL)) Q:'PRFL  D
 . S DIC="^PRC(420,SITE,1,FCP1,1,",DIC(0)="V,Z",X=PRFL
 . D ^DIC S PRFL(X)=Y(0,0)_"^"_Y(0)
 . S PRCNT=$G(PRCNT)+1,PRCLAST=$P(PRFL(X),"^",2)
 . Q
 ;
COPY ; copy records to new FCP, setup cross references as needed
 S X=0 F  S X=$O(PRFL(X)) Q:'X  D
 . S ^PRC(420,SITE,1,FCP2,1,X,0)=^PRC(420,SITE,1,FCP1,1,X,0)
 . S:$D(^PRC(420,SITE,1,FCP1,1,X,2)) ^PRC(420,SITE,1,FCP2,1,X,2)=^PRC(420,SITE,1,FCP1,1,X,2)
 . I $P(PRFL(X),"^",3)]"" D
 . . S ^PRC(420,"A",X,SITE,FCP2,$P(PRFL(X),"^",3))=""
 . S ^PRC(420,"C",X,SITE,FCP2,X)=""
 S $P(^PRC(420,SITE,1,FCP2,1,0),"^",2)="420.02IPA" ; define subfile
 S $P(^PRC(420,SITE,1,FCP2,1,0),"^",4)=PRCNT  ; keep users counted
 S $P(^PRC(420,SITE,1,FCP2,1,0),"^",3)=PRCLAST ; last user added
 W !!,"The FCP copy has been completed.",!
 Q
 ;
UNLCK ; unlock
 ;Q:'$G(FCP1)
 D DCLOCK^PRC0B("^PRC(420,SITE,1,FCP1,1,")
 D DCLOCK^PRC0B("^PRC(420,SITE,1,FCP2,1,")
 ;
QUIT ;
 K DLAYGO,DIC,X,Y,FCP1,FCP2,PRC,DIR,PRFL,PRCF,PRCNT,PRCLAST,SITE
 Q
 ;
CONFRM(FCP,X) ; ask if these are the records that user wishes to copy
 W !!,?10,"PLEASE NOTE: THE FCP 'TO COPY TO' MUST BE EMPTY."
 W !!,"If you choose to use this option you must copy all users and their profiles."
 W !!,"Are these the correct users to copy?"
 S DIR(0)="Y",DIR("B")="YES",DIR("?")="Answer YES if these are the correct users to copy, NO to choose a different FCP, or ""^"" to QUIT."
 D ^DIR K DIR
 I 'Y S X=1
 I Y="^" S X=0
 I Y S X=2
 Q X
 ;
CONFRM2(FCP,X) ; confirm that the TO FCP is correct
 W !!,"Copy users from "_FCP1_" to "_FCP_"?"
 S DIR(0)="Y",DIR("B")="YES",DIR("?")="Answer YES to copy, NO to choose a different FCP, or ""^"" to QUIT."
 D ^DIR K DIR
 I 'Y S X=1
 I Y="^" S X=0
 I Y S X=2
 Q X
