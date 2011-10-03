PRSEED3 ;HISC/JH/MD-ATTENDENCE - CLASS COMPLETE ;3/1/92
 ;;4.0;PAID;;Sep 21, 1995
DEL ; DELETE STUDENT FROM REGISTRATION FILE
 W !!,"Do you want to delete this record" S %=2 D YN^DICN I %=0 W $C(7),!!,"Answer YES or NO." G DEL
 I '(%=1) S:'(+%>0) POUT=1 Q
 S DIK="^PRSE(452.8,DA(2),3,DA(1),1," D ^DIK W !!,PRSENAM," **DELETED**"
 Q
DEL1 ; DELETE STUDENT ATTENDANCE RECORD
 W !!,"Do you want to delete this record" S %=2 D YN^DICN I %=0 W $C(7),!!,"Answer YES or NO." G DEL1
 I '(%=1) S:'(+%>0) POUT=1 Q
 S DIK="^PRSE(452," D ^DIK W !!,N1," **DELETED**"
 Q
LOC ; LOCATION SELECTION
 I X=U!($G(POUT)) S Y=0 Q
 S PRSEDEF="",PRSEDEF=$P($G(^PRSE(452,DA,0)),U,15)
 S PRSNAM=$P($G(^PRSE(452,DA,6)),U,2) I '(PRSNAM=""),$D(^VA(200,"B",PRSNAM)),$G(PRSEDEF)="" S PRSEDEF=$P(^PRSE(452.7,1,0),U,2)
 I PRSEDEF="",'($D(VA(200,"B",PRSNAM))),'(PRSNAM=""),$D(^PRSE(452.2,"B",PRSNAM)) D
 .  S PRSEDA=$O(^PRSE(452.2,"B",PRSNAM,0)) I $D(^PRSE(452.2,+PRSEDA,0)) S PRSEZ=^(0) S:'($P(PRSEZ,U,3)="") PRSEDEF=$P(PRSEZ,U,3)_","_$S($D(^DIC(5,+$P(PRSEZ,U,4),0)):$P(^(0),U,2),1:"")
 .  Q
ASK W !,"LOCATION OF PRESENTATION: "_$S('(PRSEDEF=""):PRSEDEF_"//",1:"") R X:DTIME I '$T!(X="^") S Y=0 Q
 I X="",'(PRSEDEF="") S X=PRSEDEF
 I $S(X["?":1,1:0) W !!,$C(7),?3,"Answer must be 3-30 characters in length.",!,?2,"This field contains the location where the Program/Class is to be held.",! G ASK
 S PRSELOC=$S('(X=""):X,X=""&'(PRSEDEF=""):PRSEDEF,1:"")
 K PRSNAM
 Q
