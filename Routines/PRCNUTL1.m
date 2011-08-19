PRCNUTL1 ;SSI/ALA-Utility Program ;[ 04/24/96  2:12 PM ]
 ;;1.0;Equipment/Turn-In Request;**5**;Sep 13, 1996
LOC ; Translate location field into pointer and store it
 N DIEL,DM,DC,DH,DI,DK,DP,DL,DIFLD,DQ,DR,DIC,DA,X,Y
 S X=$P($G(^PRCN(413,D0,2)),U,11),DIC(0)="EZ"
 S DIC="^ENG(""SP""," D ^DIC I +Y<0 S $P(^PRCN(413,D0,2),U,19)="" Q
 S DR="26////"_$P(Y,U,2)_";26.5////"_+Y,DA=D0 D ^DIE
 Q
LOCHLP ; Executable help for Location field
 S DUOUT=0,PRCNCT=0,HL0=0
 F  S HL0=$O(^DD(413,26,21,HL0)) Q:HL0'>0  W !,^DD(413,26,21,HL0,0)
 W !!,"Locations currently in the space file:"
 S L="" F  S L=$O(^ENG("SP","B",L)) Q:L=""  D T I $G(DUOUT)=1 S DUOUT=0 Q
 K L,PRCNDI,PRCND,PRCNA,X
 Q
VEN ; Translate training vendor field into pointer and store it
 N DIEL,DM,DC,DH,DI,DK,DP,DL,DIFLD,DQ,DR,DIC,DA,X,Y
 S X=$P($G(^PRCN(413,D0,7)),U,4),DIC(0)="EZ"
 S DIC="^PRC(440," D ^DIC I +Y<0 S $P(^PRCN(413,D0,7),U,16)="",DIE=DIC
 S DR="55////"_$P(Y,U,2)_";55.5////"_+Y,DA=D0 D ^DIE
 Q
VENHLP ; Executable help for training vendor field
 S DUOUT=0,PRCNCT=0,HL0=0
 F  S HL0=$O(^DD(413,55,21,HL0)) Q:HL0'>0  W !,^DD(413,55,21,HL0,0)
 W !!,"Current Vendors: "
 S L="" F  S L=$O(^PRC(440,"B",L)) Q:L=""  D T I $G(DUOUT)=1 S DUOUT=0 Q
 K L,PRCNDI,PRCND,PRCNA,X
 Q
EQHLP ; Special help for screening items from Equipment Inventory
 S PRCND=$X,PRCNDI=21,PRCNCT=0
 S:$G(PRCNCMR)="" PRCNCMR=$P(^PRCN(413.1,DA,0),U,16)
 S N=0 F  S N=$O(^ENG(6914,N)) Q:N'>0  D  I $G(DUOUT)=1 S DUOUT=0 Q
 . I $D(^PRCN(413.1,"AB",N)) Q
 . S ACQ=$P($G(^ENG(6914,N,3)),U,4) I ACQ'="P"&(ACQ'="M")&(ACQ'="O")&(ACQ'="") Q
 . I $P($G(^ENG(6914,N,2)),U,9)'=PRCNCMR Q
 . S L=N_"     "_$P(^ENG(6914,N,0),U,2) D T I $G(DUOUT)=1 Q
 K PRCNDI,PRCND,PRCNA,N,ACQ
 Q
T S PRCNCT=PRCNCT+1
 I PRCNCT<10 W !,L Q
 R !,"'^' TO STOP: ",PRCNA:DTIME S:'$T PRCNA=U
 I $G(PRCNA)[U S DUOUT=1 Q
 S PRCNCT=0
 Q
UCK ;  Check for user type and set screen
 I $D(^XUSEC("PRCNPPM",DUZ)) Q
 I $D(^XUSEC("PRCNCMR",DUZ)) S DIC("S")="I $P(^(0),U,6)=DUZ" Q
 I $D(^XUSEC("PRCNWHSE",DUZ)) S DIC("S")="I $P(^(0),U,7)=22" Q
 E  S DIC("S")="I $P(^(0),U,2)=DUZ"
 Q
