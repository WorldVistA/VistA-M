FBCHC78 ;AISC/DMK-CANCEL A 7078 ;8/18/2004
 ;;3.5;FEE BASIS;**82**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;check if user holds 'FBAASUPERVISOR' security key
 Q:'$G(DUZ)
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !,"You must be a holder of the 'FBAASUPERVISOR' key to cancel a 7078.",! Q
 ;
 ;get station number from site parameter file
 D SITEP^FBAAUTL G END:FBPOP
 S FBPSA=$E($P($G(^DIC(4,+$P($G(FBSITE(1)),"^",3),99)),"^"),1,3)
 ;
ASK ;get 7078 entry to cancel
 W ! S DIC(0)="AEQMZ",DIC="^FB7078(",D="D",DIC("A")="Select Patient: ",DIC("S")="I $P(^(0),U,9)'=""DC""&($P(^(0),U,11)=$S($D(FBNH):7,1:6))" D IX^DIC K DIC,D G END:X=""!(X="^"),ASK:Y<0
 S FB7078=+Y_";FB7078(",FBAAOB=FBPSA_"-"_$P(Y(0,0),".")_"-"_$P(Y(0,0),".",2),DFN=+$P(Y(0),"^",3),FB(161)=+$O(^FBAAA("AG",FB7078,DFN,0)),FBMM=$E($P(Y(0),U,4),4,5)
 S FBADDT=$P(Y(0),U,4),FBVEN=$P(Y(0),U,2)
 I $D(FBNH) S DIC="^FBAACNH(",DIC(0)="MZ",DIC("S")="I $P(^(0),U,2)=DFN&($P(^(0),U,10)=FB(161))",X=$P(Y(0),U,4) D ^DIC K DIC I +Y>0 W !,*7,"Must delete all movements associated with this authorization before canceling.",! G END
 ;
 ;check if payments made against the 7078
 ;if so do not allow a user to cancel
 I $D(^FBAAI("E",FB7078)) W !!,*7,"There is already an invoice entered for this hospitalization.  Cannot delete!",!! G END
 I $D(^FBAAC("AM",FB7078)) W !!,*7,"There already are ancillary services entered against this authorization.  Cannot delete!",!! G END
 ;
 ;display 7078 and ask if ok to cancel
 S DA=+FB7078,DIC="^FB7078(",DR="0;1" D EN^DIQ
 W ! S DIR(0)="Y",DIR("A")="Are you sure you want to cancel",DIR("B")="No" D ^DIR K DIR G FBCHC78:'Y,END:$D(DIRUT)
 ;
 ;cancelling 7078 and associated athorization in file 161
 ;deleting associated 7078 from the notification file in civil hospital
 ;remove entries assoiciated with CNH in 161.23
 ;removing estimated amount from 1358
 I '$D(FBNH) S DA=$O(^FBAA(162.2,"AM",+FB7078,0)) I DA S DIE="^FBAA(162.2,",DR="16///@" D ^DIE K DIC,DIE W " ."
 S DA(1)=DFN,DA=$O(^FBAAA("AG",FB7078,DFN,0)) I DA S DIK="^FBAAA("_DFN_",1," D ^DIK K DIK,DA W "."
 S DA=+FB7078,DIE="^FB7078(",DR=".013////^S X=DUZ;.014////^S X=DT;9////^S X=""DC""" D ^DIE K DIE,DIC W "."
 I $D(FBNH) S FBI=0 F  S FBI=$O(^FBAA(161.23,"AC",+FB7078,FBI)) Q:'FBI  I $D(^FBAA(161.23,FBI,0)) D
 . S DA=FBI,DIK="^FBAA(161.23," D ^DIK K DIK W "."
 ; if cancelled civil hospital 7078 then delete associated PTF record
 I '$G(FBNH) D PTFD^FBUTL6(DFN,FBADDT)
 W !!,"Authorization cancelled.  Now updating 1358.",!
 D 1358 I $D(FBERR) W !,"Unable to affect 1358 adjustment.  Use appropriate IFCAP options.",!
 W "...  Finished",!
 ;
END K DA,DR,DIE,DIC,DFN,FB,FBI,FB7078,FBAAOB,FBERR,PRC,PRCS,PRCSX,FBPSA,FBZZ,FBSITE,X,Y,FBPOP,FBNH,FBMM,FBADDT,FBVEN
 Q
1358 ;subtract estimated dollar amount from 1358
 ;FBAAOB=FULL OBLIGATION NUMBER (STATION #-OBLIGATION #-REF #)
 ;FBERR returned if IFCAP call fails
 ;internal entry # in 424 = $O(^PRC(424,"B",FBAAOB,0))
 ;
 ;check if 1358 available for posting
 I '$$INTER() W !,*7,"Unable to locate reference number on 1358.",! S FBERR=1 Q
 S PRCS("X")=$P(FBAAOB,"-",1,2),PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 W !,*7,"1358 Not available for posting.",! S FBERR=1 Q
 D NOW^%DTC
 S PRCSX=$$INTER()_"^"_%_"^"_0_"^"_"Authorization has been cancelled"_"^"_1_"^"
 S PRCS("TYPE")="FB" D ^PRCS58CC I Y'=1 W !,*7,$P(Y,"^",2),! S FBERR=1 Q
 Q
 ;
INTER() ;get internal entry number from file 424
 ;first check interface id x-ref
 ;second check is to "B" x-ref to stay backward compatible with IFCAP3.6
 ;
 I '$G(FBNH),$D(^PRC(424,"E",DFN_";"_+FB7078_";"_$P(FBAAOB,"-",2))) Q $O(^(DFN_";"_+FB7078_";"_$P(FBAAOB,"-",2),0))
 I $G(FBNH),$D(^PRC(424,"E",DFN_";"_+FB7078_";"_$P(FBAAOB,"-",2)_";"_FBMM)) Q $O(^(DFN_";"_+FB7078_";"_$P(FBAAOB,"-",2)_";"_FBMM,0))
 I $D(^PRC(424,"B",FBAAOB)) Q $O(^(FBAAOB,0))
 Q 0
 ;
CNH ;entry point to cancel an authorization associated with the
 ;community nursing home program.
 S FBNH=1 G FBCHC78
 Q
