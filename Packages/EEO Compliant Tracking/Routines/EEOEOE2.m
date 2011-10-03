EEOEOE2 ;HISC/JWR - Station Edit routine ;11/9/92  11:12
 ;;2.0;EEO Complaint Tracking;**1**;Apr 27, 1995
SEC ;Sets up security variables
 D ^EEOEOSE I FAIL Q
STATION ;Enter/edit station EEO information.
 S EEOYQ="Enter/edit station EEO information.",EDIT=1
 S (EEOYSCR,DIC("S"))="I $$SCREEN^EEOEOSE(Y)"
 S (DIC,DIE)="^EEO(785,",DLAYGO=785,DIC("A")="Select NAME:  "
 S (EEODIC(0),DIC(0))=$S(XQY0["Informal":"AEFLQM",1:"AEFQM")
 W !!,EEOYQ
 K Y,DA D NEW^EEOEEDIE
ENT ;I $P(Y,U,3)=1,$D(DUZ) S EEONAME=$P($G(^VA(200,DUZ,0)),U),(EEOY,DA)=+Y,DR="14///"_EEONAME_";98///"_DUZ,DIC(0)="L" D ^DIE S Y=EEOY
 I Y=""!(Y<0) K DA,DR,DLAYGO Q
 S DIC(0)=EEODIC(0),(DA,EDA)=+Y L +^EEO(785,EDA):0 I '$T W *7,!!,"ANOTHER PERSON IS EDITING THIS RECORD" K DA,EDA G STATION
 D CASENO^EEOEOSE
 I $D(^EEO(785,DA,4)) I $P(^EEO(785,DA,4),U)'="" D MSG G ELK
 I $D(^EEO(785,DA,12)) I $P(^EEO(785,DA,12),U,2)'="" D DMSG G ELK
 I XQY0["Investigation" D DR2,^EEOEEDIE G ELK
 I XQY0["Formal" D DR1,^EEOEEDIE,CASENO^EEOEOSE G ELK
ELK ;Unlocks edited file and returns to selection prompt
 L -^EEO(785,EDA)
 G STATION
DR1 ;DR for Enter/Edit Formal Complaint Info
 S DR="S EEOC1=$P($G(^EEO(785,DA,1)),U,3);16;D SAVE^EEOEOE2;14;16.3;16.75;20;15.3;I X="""" S Y=21;15.4;21:23;24;26;41;40.5;40.6;1.2;23.5;44;45;46.2;I X="""" S Y=46.5;71;46.4;I X="""" S Y=46.5;71.5;46.5;47;I X="""" S Y="""";72"
 Q
DR2 ;DR for Enter/Edit Investigator Information
 S DR="29;27.5;32" K EEOTYPE
 S DR(2,785.03)="1;D TYPE^EEOUTIL1;2//^S X=EEOTYPE;B  I EEOTYPE'[""RETI"" S Y=4;7;4"
DR3 Q
MSG ;Comes here if case closed
 W !!,?3,*7,"***** This case has been closed.  Editing is not allowed. ***** " Q
DMSG W !!,?3,*7,"***** This case has been deleted *****",!
 Q
FORMAL ;Entry for counselor to change status of complaint to formal
 ;Q:$G(EEOCOUNS)'>0
 Q:$P($G(^EEO(785,D0,1)),U,3)>0
 W !!! S DIR("A",1)="  Do you want to change the Status of this Complaint to Formal?",DIR("A",2)="  Note that once changed you may not be able to further edit some Informal ",DIR("A")="     Change to Formal Status ",DIR("A",3)=" "
 S DIR("A",3)="  information and will not be able to access this complaint through the ",DIR("A",4)="  counselor's edit options.",DIR("A",5)=" "
 S DIR(0)="Y^AO",DIR("B")="NO" D ^DIR
 I Y=1 S DR="16;S EEOYI=X I X="""" S Y="""";62///X",(DIC,DIE)=785,DA=D0,DIC(0)="AMNQZ" D ^DIE,CASENO^EEOEOSE K DR S DR="16////"_EEOYI,DIE=785.5 D ^DIE
 K DIE,DIR,DIC,DR Q
SAVE S EEOC2=$P($G(^EEO(785,DA,1)),U,3)
 I $G(EEOC1)>0&(EEOC2="") S EEOC(DA)=DA_"^"_DUZ_"^"_DT_"^"_EEOC1_"^^"_+^EEO(785,DA,1)
 K EEOC1,EEOC2 Q
