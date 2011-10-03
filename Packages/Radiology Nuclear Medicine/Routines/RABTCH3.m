RABTCH3 ;HISC/GJC-Delete Batch Reports  ;8/2/94  10:08
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ; The user accessing this option will only be able to delete
 ; Report Batches he/she has created through the RA BTCHNEW option.
 ; For the option: RA BTCHDEL
 ;
 ;               ***** Variable List *****
 ; ^TMP($J,"RA BTCHDEL",xternal fmat of .01,ien of record)=""
 ;
DEL ; Does this user have data to delete?
 Q:'$D(^RABTCH(74.2,"C",DUZ))
 N A,B,C,I,RADIC,RAHEAD,RALINE,RAOUT,RAPAGE,RATDAY
 S (RAOUT,RAPAGE)=0,Y=DT X ^DD("DD") S RATDAY=Y
 K ^TMP($J,"RA BTCHDEL"),^TMP($J,"RA BTCHDEL SEL")
 S RADIC="^RABTCH(74.2,",RADIC(0)="QEAMZ",RAUTIL="RA BTCHDEL"
 S RADIC("A")="Select Batch Name: ",RADIC("S")="I +$P(^(0),U,3)=DUZ"
 S RADIC("W")="D DICW^RABTCH3"
 D EN1^RASELCT(.RADIC,RAUTIL)
 I $G(RAQUIT)!('$D(^TMP($J,"RA BTCHDEL"))) D KILL Q
 S $P(RALINE,"*",(IOM+1))=""
 S RAHEAD="<<< Report Batches To Be Deleted >>>"
 D HDR
 S A="" F  S A=$O(^TMP($J,"RA BTCHDEL",A)) Q:A']""  D
 . S Y=0 F  S Y=$O(^TMP($J,"RA BTCHDEL",A,Y)) Q:Y'>0  D
 .. S C=+$G(C)+1
 .. W !,C_"]",?5,A D DICW
 .. Q
 . I $Y>(IOSL-4) D
 .. S RAOUT=$$EOS^RAUTL5()
 .. D:'RAOUT HDR
 .. Q
 . Q
 W ! K DIR S DIR(0)="YA"
 S DIR("A")="Do you wish to delete all the above Report Batches? "
 S DIR("?",1)="Enter 'Y' to delete all the above report batches or 'N' to"
 S DIR("?")="bypass the deletion of the report batches." D ^DIR K DIR
 I '+Y D KILL Q
 W !!?5,"Beginning the interactive deletion process."
 W !?5,"<Deleting>"
 K DA,DIK S A="",DIK="^RABTCH(74.2,"
 F  S A=$O(^TMP($J,"RA BTCHDEL",A)) Q:A']""  D
 . S B=0 F  S B=$O(^TMP($J,"RA BTCHDEL",A,B)) Q:B'>0  D
 .. S DA=B W:DA>0 "." D:DA>0 ^DIK
 .. Q
 . Q
 W !?5,"Deletion process has successfully completed."
KILL ; Kill and quit
 K %,DA,DDH,DIC,DIK,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RAQUIT,RAUTIL,X,Y,POP
 Q
DICW ; Display data
 N RAY S RAY=+Y
 N RA,RABTCHC,RABTCHP,Y
 S RA=$G(^RABTCH(74.2,RAY,0))
 S RABTCHC=$P(RA,U,2),RABTCHP=$P(RA,U,4)
 S Y=RABTCHC X:Y]"" ^DD("DD") S RABTCHC=Y
 S Y=RABTCHP X:Y]"" ^DD("DD") S RABTCHP=Y
 W ?40,"<Batch Created>: ",RABTCHC,!?40,"<Batch Printed>: ",RABTCHP
 Q
HDR ; Header
 S RAPAGE=RAPAGE+1
 W @IOF,!?$S(IOM=132:104,1:63),"Date: ",RATDAY
 W !?$S(IOM=132:104,1:63),"Page: ",RAPAGE
 W !?(IOM-$L(RAHEAD)\2),RAHEAD,!,RALINE
 Q
