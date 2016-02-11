SROCMPED ;BIR/MAM - ENTER/EDIT OCCURRENCES ;08/16/2011
 ;;3.0;Surgery;**26,38,47,125,153,170,176,177,182,184**;24 Jun 93;Build 35
 I '$P(^SRF(SRTN,SRTYPE,SRENTRY,0),"^",2) D NOCAT I SRSOUT S SRSOUT=0 Q
 I '$D(^SRF(SRTN,SRTYPE,SRENTRY,0)) K SRENTRY S SRSOUT=0 Q
START I '$D(^SRF(SRTN,SRTYPE,SRENTRY)) K SRENTRY S SRSOUT=0 Q
 S SRSOUT=0,SR=^SRF(SRTN,SRTYPE,SRENTRY,0)
 I $G(SRNEW),$P(SR,"^",2)=3,SRTYPE=16 D SEPSIS G:SRSOUT END G START
 I $G(SRNEW),$P(SR,"^",2)=27,SRTYPE=16,$P($G(^SRF(SRTN,"RA")),"^",2)="C" D RCP G:SRSOUT END G START
 I $G(SRNEW),$P(SR,"^",2)=12,SRTYPE=16 D STROKE G:SRSOUT END G START
 I $G(SRNEW),$P(SR,"^",2)=34 D NMC G:SRSOUT END G START
 I $G(SRNEW),$P(SR,"^",2)=40,SRTYPE=16 D UTI G:SRSOUT END G START
 D HDR^SROAUTL W !
 S SRO(1)=$P(SR,"^")_"^.01",X=$P(SR,"^",2),SRO(2)=X_"^"_$S(SRTYPE=10:3,1:5) I X S $P(SRO(2),"^")=$P(^SRO(136.5,X,0),"^")
 I $P(SR,"^",2)=40 D SR40 G DISP
 I $P(SR,"^",2)=3 S Y=$P(SR,"^",4),C=$P(^DD(130.22,7,0),"^",2) D:Y'="" Y^DIQ S SRO(3)=Y_"^7"
 I $P(SR,"^",2)=12 S Y=$P(SR,"^",8),C=$P(^DD(130.22,9,0),"^",2) D:Y'="" Y^DIQ S SRO(3)=Y_"^9"
 I $P(SR,"^",2)=34,SRTYPE=16 S Y=$P(SR,"^",14),C=$P(^DD(130.22,15,0),"^",2) D:Y'="" Y^DIQ S SRO(3)=Y_"^15"
 I $P(SR,"^",2)=34,SRTYPE=10 S Y=$P(SR,"^",7),C=$P(^DD(130.13,5,0),"^",2) D:Y'="" Y^DIQ S SRO(3)=Y_"^5"
 I $P(SR,"^",2)'=3&($P(SR,"^",2)'=12)&($P(SR,"^",2)'=40)&($P(SR,"^",2)'=34) D 
 .S SRSDATE=$E($P(SR,"^",7),1,7) I 'SRSDATE S SRSDATE=$E($P(^SRF(SRTN,0),"^",9),1,7)
 .I $P(SR,"^",2)=27,$P($G(^SRF(SRTN,"RA")),"^",2)="C" S Y=$P(SR,"^",5),C=$P(^DD(130.22,8,0),"^",2) D:Y'="" Y^DIQ S SRO(3)=Y_"^8" Q
 .S X=$P(SR,"^",3) D:X ICDSTR S SRO(3)=X_"^"_$S(SRTYPE=10:4,1:6)
 S SR(2)=$G(^SRF(SRTN,SRTYPE,SRENTRY,2)),SRO(4)=$P(SR(2),"^")_"^"_$S(SRTYPE=10:2,1:3)
 S X=$P(SR,"^",6),SHEMP=$S(X="U":"UNRESOLVED",X="I":"IMPROVED",X="D":"DEATH",X="W":"WORSE",1:""),SRO(5)=SHEMP_"^.05"
 K SRO(6) I SRTYPE=16 S X=$P(SR,"^",7) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S SRO(6)=X_"^2"
DISP N SRSYS S SRSYS=$$ICD910^SROICD(SRTN)
 W !,"1. Occurrence: ",?30,$P(SRO(1),"^"),!,"2. Occurrence Category: ",?30,$P(SRO(2),"^")
 I $P(SR,"^",2)=40 D
 .W !,"3. UTI Signs/Symptoms Urg/Freq/Dys: ",$P(SRO(3),"^")
 .W !,"4. UTI Signs/Symptoms Fever:",?30,$P(SRO(4),"^"),!,"5. UTI Signs/Symptoms Tenderness: ",$P(SRO(5),"^")
 .W !,"6. UTI Culture:",?30,$P(SRO(6),"^"),!,"7. Indwelling Urethral Catheter > 2 Calendar Days: ",$P(SRO(7),"^")
 I $P(SR,"^",2)'=40 S X=$P(SR,"^",2) D
 .W !,"3. "_$S(X=3:"Sepsis Type",X=12:"Stroke/CVA Duration",X=34:$S(SRTYPE=16:"Postop",1:"Intraop")_" Device Type",X=27&($P($G(^SRF(SRTN,"RA")),"^",2)="C"):"CPB Status",1:"ICD Diagnosis Code "_$$ICDSTR^SROICD(SRTN))_":",?30,$P(SRO(3),"^")
 S II=$S($P(SR,"^",2)=40:8,1:4) W !,II_". Treatment Instituted:",?30,$P(SRO(II),"^"),!,(II+1)_". Outcome to Date:",?30,$P(SRO(II+1),"^")
 S II=$S($P(SR,"^",2)=40:10,1:6) I $D(SRO(II)) W !,II_". Date Noted: ",?30,$P(SRO(II),"^")
 S SRX=$S($P(SR,"^",2)=40:11,SRTYPE=10:6,1:7),SRO(SRX)="^" I $O(^SRF(SRTN,SRTYPE,SRENTRY,1,0)) S SRO(SRX)="*** INFORMATION ENTERED ***"_SRO(SRX)
 S X=$S(SRTYPE=10:1,1:4),SRO(SRX)=SRO(SRX)_X,SRMAX=SRX
 W !,SRX_". Occurrence Comments: ",?30,$P(SRO(SRX),"^")
 W !!,SRLINE
 W !!,"Select Occurrence Information: " R X:DTIME I '$T!("^"[X) S:X["^" SRSOUT=1 G END
 I "Aa"[X S X="1:"_SRMAX
 I X'?.N1":".N,'$D(SRO(X)) D HELP G:SRSOUT END W @IOF G START
 I X?.N1":".N S Y=$E(X),Z=$P(X,":",2) I Y<1!(Z>SRMAX)!(Y>Z) D HELP G:SRSOUT END W @IOF G START
 D HDR^SROAUTL W !
 I X?.N1":".N D RANGE G START
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN) D:SRZ=2 PRESS
 .S SRZ=X K DIE,DA,DR S DA(1)=SRTN,DA=SRENTRY,DIE="^SRF("_SRTN_","_SRTYPE_","
 .S DR=$P(SRO(X),"^",2)_$S((SRTYPE=16&($P(SRO(X),"^",2)=6))!(SRTYPE=10&($P(SRO(X),"^",2)=4)):"ICD Diagnosis Code "_$$ICDSTR^SROICD(SRTN),1:"T") D ^DIE K DR,DA
 .I SRZ=3,$P(SR,"^",2)=12,$P(^SRF(SRTN,16,SRENTRY,0),"^",8)<2 D YUP
 G START
 Q
ICDSTR ; get diagnosis info
 N SRICDSTR
 S SRICDSTR=$$ICD^SROICD(SRTN,X),X=$P(SRICDSTR,"^",2)_"  "_$P(SRICDSTR,"^",4)
 Q
HELP W @IOF,!!!!,"Enter the number, or range of numbers you want to edit.  Examples of proper",!,"responses are listed below."
 W !!,"1. Enter 'A' to update all occurrence information."
 S RANGE="(1-"_SRMAX_")"
 W !!,"2. Enter a number "_RANGE_" to update a specific occurrence element.  (For",!,"   example, enter '2' to update the occurrence category)"
 W !!,"3. Enter a range of numbers "_RANGE_" separated by a ':' to enter a range of",!,"   elements.  (For example, enter '1:3' to enter occurrence, occurrence",!,"   category, and ICD diagnosis code)"
 W ! D PRESS
 Q
RANGE ; range of numbers
 I $$LOCK^SROUTL(SRTN) D  D UNLOCK^SROUTL(SRTN)
 .S SHEMP=$P(X,":"),CURLEY=$P(X,":",2) F EMILY=SHEMP:1:CURLEY Q:SRSOUT  D ONE
 I CURLEY=2 D PRESS
 Q
ONE ; edit one item
 K DR,DA,DIE
 S DR=$P(SRO(EMILY),"^",2)_$S((SRTYPE=16&($P(SRO(EMILY),"^",2)=6))!(SRTYPE=10&($P(SRO(EMILY),"^",2)=4)):"ICD Diagnosis Code "_$$ICDSTR^SROICD(SRTN),1:"T")
 S DA=SRENTRY,DA(1)=SRTN
 S DIE="^SRF("_SRTN_","_SRTYPE_","
 D ^DIE K DR,DA
 I '$D(^SRF(SRTN,SRTYPE,SRENTRY))!$D(DTOUT)!$D(Y) S SRSOUT=1
 Q
END K SRO,SR,X,DA,DIE,DR,Y
 Q
SEPSIS D HDR^SROAUTL K DA,DIE,DR
 S DA=SRENTRY,DA(1)=SRTN,DR="7T",DIE="^SRF("_SRTN_","_SRTYPE_"," D ^DIE K DR,DA
 K DA,DIE,DR S SRNEW=0 I $D(DTOUT)!$D(Y) S SRSOUT=1 Q
 Q
STROKE D HDR^SROAUTL K DIR S DIR(0)="130.22,9",DIR("A")="Stroke/CVA Duration",DIR("B")="<24 HOURS" D ^DIR K DIR I $D(DTOUT) S SRSOUT=1 Q 
 K DA,DR,DIE I X["^"!(X="@")!(Y=1) D DEL S DA=SRTN,DIE=130,DR="256////N" D ^DIE K DR,DA,DIE Q
 S DA=SRENTRY,DR="9///"_Y,DA(1)=SRTN,DIE="^SRF(SRTN,16," D ^DIE S SRNEW=0 K DR,DA,DIE
 Q
NMC D HDR^SROAUTL K DA,DIE,DR
 S DA=SRENTRY,DA(1)=SRTN,DR=$S(SRTYPE=10:"5T",1:"15T"),DIE="^SRF("_SRTN_","_SRTYPE_"," D ^DIE K DR,DA
 K DA,DIE,DR S SRNEW=0 I $D(DTOUT)!$D(Y) S SRSOUT=1 Q
 Q
UTI D HDR^SROAUTL S DA=SRENTRY,DA(1)=SRTN,DR="11T;12T;13T;14T;10T",DIE="^SRF(SRTN,16," D ^DIE K DR,DA
 K DA,DIE,DR S SRNEW=0 I $D(DTOUT)!$D(Y) S SRSOUT=1 Q
 Q
SR40 ;
 S Y=$P(SR,"^",10),C=$P(^DD(130.22,11,0),"^",2) D:Y'="" Y^DIQ S SRO(3)=Y_"^11"
 S Y=$P(SR,"^",11),C=$P(^DD(130.22,12,0),"^",2) D:Y'="" Y^DIQ S SRO(4)=Y_"^12"
 S Y=$P(SR,"^",12),C=$P(^DD(130.22,13,0),"^",2) D:Y'="" Y^DIQ S SRO(5)=Y_"^13"
 S Y=$P(SR,"^",13),C=$P(^DD(130.22,14,0),"^",2) D:Y'="" Y^DIQ S SRO(6)=Y_"^14"
 S Y=$P(SR,"^",9),C=$P(^DD(130.22,10,0),"^",2) D:Y'="" Y^DIQ S SRO(7)=Y_"^10"
 S SR(2)=$G(^SRF(SRTN,SRTYPE,SRENTRY,2)),SRO(8)=$P(SR(2),"^")_"^"_$S(SRTYPE=10:2,1:3)
 S X=$P(SR,"^",6),SHEMP=$S(X="U":"UNRESOLVED",X="I":"IMPROVED",X="D":"DEATH",X="W":"WORSE",1:""),SRO(9)=SHEMP_"^.05"
 K SRO(10) S X=$P(SR,"^",7) S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) S SRO(10)=X_"^2"
 S SRX=11,SRO(SRX)="^" I $O(^SRF(SRTN,SRTYPE,SRENTRY,1,0)) S SRO(SRX)="*** INFORMATION ENTERED ***"_SRO(SRX)
 S SRO(SRX)=SRO(SRX)_11
 Q
RCP D HDR^SROAUTL K DA,DIE,DR
 S DA=SRENTRY,DA(1)=SRTN,DR="8T",DIE="^SRF("_SRTN_","_SRTYPE_"," D ^DIE K DR,DA
 K DA,DIE,DR S SRNEW=0 I $D(DTOUT)!$D(Y) S SRSOUT=1 Q
 Q
NOCAT W @IOF,!,"The occurrence selected does not have a corresponding category.  A category",!,"must be selected at this time, or the occurrence will be deleted.",!
 K DIE,DIC,X,Y,SRCAT
 S DIC=136.5,DIC(0)="QEAMZ",DIC("A")="Select Occurrence Category: ",DIC("S")="I '$P(^(0),U,2)" S:SRTYPE=10 DIC("S")=DIC("S")_",$P(^(0),U,3)" D ^DIC
 I +Y>0 S SRCAT=+Y K DIE,DR,DA S DA(1)=SRTN,DA=SRENTRY,DIE="^SRF("_DA_","_SRTYPE_",",DR=$S(SRTYPE=10:3,1:5)_"////"_SRCAT D ^DIE K DR,DA
 I $D(SRCAT) K SRCAT Q
DEL W !!,"Are you sure that you want to delete this occurrence ? NO// " R SRYN:DTIME I '$T!(SRYN["^") D YUP S SRSOUT=1 Q
 I "YyNn"'[SRYN W !!,"Enter 'YES' to delete this occurrence from the patient's record.  Enter 'NO'",!,"to backup and enter a category for this occurrence." G DEL
 I "Nn"[SRYN G NOCAT
YUP ; delete occurrence
 K DIK,DA S DA=SRENTRY,DA(1)=SRTN,DIK="^SRF("_SRTN_","_SRTYPE_"," D ^DIK K DIK,DA
 Q
PRESS W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
