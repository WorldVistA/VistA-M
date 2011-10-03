ESPAJE ;ALB/ABR - ADD JOURNAL ENTRY ; 9/24/96
 ;;1.0;POLICE & SECURITY;**17,18,23,24,32,43**;Mar 31, 1994
 ;
 ;  This will enable multiple journal entries to be added for the same
 ;  time without overwriting one that is in use.
 ;
 N DIC,DA,X,Y,FIRST,REC,TME
 D DATE
 S FIRST=1
 I Y>0 F  D ENTRY Q:$G(Y)<0!$D(DUOUT)!$D(DTOUT)
 Q
DATE ;  select date
 S DIC="^ESP(916,",DIC(0)="AEQMZ"
 D ^DIC
 I Y S ESPDAT=+Y,DIC=DIC_ESPDAT_",4,",DIC("P")=$P(^DD(916,5,0),U,2)
 Q
 ;
ENTRY ;add/edit entry in time multiple
 S DA(1)=ESPDAT,DIC(0)="QAELMZ"
 I FIRST D
 .S DIC("B")=$$LAST(ESPDAT),FIRST=0
 E  K DIC("B")
 D ^DIC Q:Y<1
 S (REC,DA)=+Y
 L +^ESP(916,ESPDAT,4,REC):2 I '$T D  Q
 . W !!,">>Entry for this time is in use.",!,"To create an additional entry for this time, enter time in quotes."
 . W !,"  E.g. - ""1300"""
 . W !,"Try later to edit same entry.",!
EDIT ; edit (add) info to new entry
 S DIE=DIC,DA=+Y,DA(1)=ESPDAT,DR=".01;1;2;3" D ^DIE
 L -^ESP(916,ESPDAT,4,REC)
 Q
 ;
LAST(ESPDAT)    ; get last time for journal entry
 Q:'$G(ESPDAT) ""
 N TIME1,TIME2,ESPT,ESPT1,FCX,FC
 ;
 ; Are start and end times for the journal defined? If so, use them.
 ;
 S ESPT=$G(^ESP(916,ESPDAT,1)),ESPT1=$P($P(ESPT,"^"),"-",4)
 I ESPT S ESPT=$P($P(^ESP(916,ESPDAT,1),"^",2),"-",4)
 I ESPT,ESPT?4N,+ESPT>0&+ESPT<2401 D
 .S ESPT=+$P($P(^ESP(916,ESPDAT,1),"^",2),"-",4)+1
 .S TIME1="",TIME2=""
 .F  S TIME1=$O(^ESP(916,ESPDAT,4,"B",TIME1)) Q:TIME1=""  D
 ..S X=$S(TIME1<ESPT1:DT+1,1:DT)_"."_TIME1
 ..S:X>TIME2 TIME2=X
 .Q:$G(TIME2)=""
 .S TIME2=$J($P(TIME2,".",2),4),TIME2=$TR(TIME2," ",0)
 ;
 ;  If start/end times for journal not defined, assume 0001-2400
 ;
 E  D
 .S TIME1=$O(^ESP(916,ESPDAT,4,"B",""),-1)
 .S TIME2=$O(^ESP(916,ESPDAT,4,"B",9999),-1)
 .I (+TIME1)>TIME2 S TIME2=TIME1
 ;
 Q $G(TIME2)
