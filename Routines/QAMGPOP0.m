QAMGPOP0 ;HISC/DAD-BUILD A PATIENT GROUP FROM A FM SEARCH ;9/3/93  13:20
 ;;1.0;Clinical Monitoring System;;09/13/1993
EN ;
 K DIC S DIC="^QA(743.5,",DIC(0)="AELMNQZ",DIC("A")="Select GROUP: ",DIC("DR")=".02////2",DIC("S")="I $P(^(0),""^"",2)=2",DLAYGO=743.5
 W ! D ^DIC G:Y'>0 EXIT S QAMGRPD0=+Y,QAMGNAM=Y(0,0)
 I $O(^QA(743.5,QAMGRPD0,"GRP",0)) D  G EXIT:QAMQUIT=1,EN:QAMQUIT=2
 . K DIR S DIR(0)="SO^M:Merge data;D:Delete data;"
 . S DIR("A",1)="This group already contains group members."
 . S DIR("A",2)="Should the newly found entries be merged with"
 . S DIR("A",3)="the existing entries or should the old entries"
 . S DIR("A",4)="be deleted prior to the search?",DIR("A",5)=""
 . S DIR("A")="Delete or Merge"
 . D ^DIR
 . S QAMQUIT=$S($D(DTOUT):1,$D(DUOUT):1,$D(DIROUT):1,$D(DIRUT):2,1:0)
 . Q:Y="M"!QAMQUIT
 . K ^QA(743.5,QAMGRPD0,"GRP")
 . Q
 K DIC S DIC="^DIC(",DIC(0)="AEMNQZ",DIC("A")="Select FILE TO SEARCH: ",DIC("S")="I $D(^DIC(""AC"",""QAM"",+Y))"
 W ! D ^DIC G:Y'>0 EXIT S QAMFILE=+Y
 W !!,"Searching the ",Y(0,0)," file (#",+Y,")"
 S DIC=QAMFILE K ^TMP("QAM",$J) D EN^DIS
 I $D(^QA(743.5,QAMGRPD0,"GRP",0))[0 S ^(0)="^743.51A^^"
 S QAMCOUNT=$P(^QA(743.5,QAMGRPD0,"GRP",0),"^",4)
 S QAMTHIRD=$P(^QA(743.5,QAMGRPD0,"GRP",0),"^",3),QAMGRPD1=QAMTHIRD+1
 W !!,"Building the ",QAMGNAM," group . . ."
 F QAMIEN=0:0 S QAMIEN=$O(^TMP("QAM",$J,QAMIEN)) Q:QAMIEN'>0  D
 . Q:$O(^QA(743.5,QAMGRPD0,"GRP","AB",QAMIEN,0))
 . F QAMGRPD1=QAMGRPD1:1 L +^QA(743.5,QAMGRPD0,"GRP",QAMGRPD1,0):0 Q:$T&($D(^QA(743.5,QAMGRPD0,"GRP",QAMGRPD1,0))[0)  L -^QA(743.5,QAMGRPD0,"GRP",QAMGRPD1,0)
 . S X=^TMP("QAM",$J,QAMIEN)_";"_QAMIEN
 . S ^QA(743.5,QAMGRPD0,"GRP",QAMGRPD1,0)=X
 . L -^QA(743.5,QAMGRPD0,"GRP",QAMGRPD1,0)
 . S QAQADICT=743.51,QAQAFLD=.01,(D0,DA(1))=QAMGRPD0,(D1,DA)=QAMGRPD1
 . D ENSET^QAQAXREF
 . S QAMCOUNT=QAMCOUNT+1
 . Q
 S $P(^QA(743.5,QAMGRPD0,"GRP",0),"^",3,4)=$S($G(QAMGRPD1):QAMGRPD1,1:QAMTHIRD)_"^"_QAMCOUNT
 I $O(^TMP("QAM",$J,0))'>0 W !!,"No group entries were created !!"
 I $O(^QA(743.5,QAMGRPD0,"GRP",0))'>0 D
 . W "  Deleting the ",QAMGNAM," group."
 . S DIK="^QA(743.5,",DA=QAMGRPD0 D ^DIK
 . Q
EXIT ;
 K DA,DIC,DIK,QAMCOUNT,QAMFILE,QAMGNAM,QAMGRPD0,QAMGRPD1,QAMIEN,QAMTHIRD,QAQDICT,QAQFLD,X,Y,^TMP("QAM",$J)
 Q
