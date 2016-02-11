SROUTC ;BIR/SJA - OUTCOMES DATA ;09/28/2011
 ;;3.0;Surgery;**125,135,153,174,175,176,182,184**;24 Jun 93;Build 35
 D UPDT645,UP422,EN^SROCCAT
 F I=205,206,208,209 S SRA(I)=$G(^SRF(SRTN,I))
 S NYUK=$P(SRA(205),"^",27) D YN S SRAO(1)=SHEMP_"^258",NYUK=$P(SRA(208),"^",7) D YN S SRAO(8)=SHEMP_"^391"
 S NYUK=$P(SRA(208),"^",3) D YN S SRAO(2)=SHEMP_"^386",NYUK=$P(SRA(206),"^",39) D YN S SRAO(9)=SHEMP_"^466"
 S NYUK=$P(SRA(205),"^",17) D YN S SRAO(16)=SHEMP_"^254"
 ;S NYUK=$P(SRA(205),"^",43) D YN S SRAO(10)=SHEMP_"^645"
 S NYUK=$P(SRA(205),"^",44) D YN S SRAO(10)=SHEMP_"^422"
 S NYUK=$P(SRA(208),"^",5) D YN S SRAO(4)=SHEMP_"^388",NYUK=$P(SRA(205),"^",21) D YN S SRAO(11)=SHEMP_"^256"
 S NYUK=$P(SRA(205),"^",26) D YN S SRAO(5)=SHEMP_"^411",NYUK=$P(SRA(205),"^",22) D YN S SRAO(12)=SHEMP_"^410"
 S NYUK=$P(SRA(208),"^",6) D YN S SRAO(6)=SHEMP_"^389",NYUK=$P(SRA(206),"^",40) D YN S SRAO(13)=SHEMP_"^467"
 S NYUK=$P(SRA(205),"^",13) D YN S SRAO(7)=SHEMP_"^285"
 S NYUK=$P(SRA(205),"^",40) D YN S SRAO(14)=SHEMP_"^448",NYUK=$P(SRA(205),"^",8) D YN S SRAO(15)=SHEMP_"^404"
 S NYUK=$P(SRA(205),"^",6) D YN S SRAO(3)=SHEMP_"^248"
 ;
DISP S SRPAGE="PAGE: 1",SRHDR(.5)="OUTCOMES INFORMATION" D HDR^SROAUTL
 W !,"Perioperative (30 day) Occurrences:",!,"-----------------------------------"
 W !,"1. Myocardial Infarction: ",?35,$P(SRAO(1),"^"),?40," 9. Tracheostomy: ",?76,$P(SRAO(9),"^")
 W !,"2. Endocarditis: ",?35,$P(SRAO(2),"^"),?40,"10. Out Of OR Unplanned Intubation:",?76,$P(SRAO(10),"^")
 W !,"3. Superficial Incisional SSI: ",?35,$P(SRAO(3),"^"),?40,"11. Stroke/CVA: ",?76,$P(SRAO(11),"^")
 W !,"4. Mediastinitis: ",?35,$P(SRAO(4),"^"),?40,"12. Coma >= 24 hr: ",?76,$P(SRAO(12),"^")
 W !,"5. Cardiac arrest requiring CPR: ",?35,$P(SRAO(5),"^"),?40,"13. New Mech Circ Support: ",?76,$P(SRAO(13),"^")
 W !,"6. Reoperation for bleeding: ",?35,$P(SRAO(6),"^"),?40,"14. Postop Atrial Fibrillation: ",?76,$P(SRAO(14),"^")
 W !,"7. On ventilator >= 48 hr: ",?35,$P(SRAO(7),"^"),?40,"15. Wound Disruption: ",?76,$P(SRAO(15),"^")
 W !,"8. Repeat cardiac surg procedure: ",?35,$P(SRAO(8),"^"),?40,"16. Renal failure require dialysis: ",$P(SRAO(16),"^")
 W !! F MOE=1:1:80 W "-"
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
UPDT645 ; update field 645
 N SRX S SRX=$P($G(^SRF(SRTN,205)),"^",43) S:SRX="" SRX="N"
 K DA,DIE,DR S DIE=130,DA=SRTN,DR="645////"_SRX D ^DIE K DA,DIE,DR
 Q
UP422 ; update field 422
 N SRX S SRX=$P($G(^SRF(SRTN,205)),"^",44) S:SRX="" SRX="N"
 K DA,DIE,DR S DIE=130,DA=SRTN,DR="422////"_SRX D ^DIE K DA,DIE,DR
 Q
UPDATE N SRCMP,SROC,SRI,SRIF,SRQ,SRY D MAP
 I EMILY=5!(EMILY=13) D IP Q:EMILY=5
 I EMILY=13 S SRY=+Y G EM13
 S X=$P(^SRO(136.5,SROC,0),"^"),DIC(0)="L",DLAYGO="130.22",DA(1)=SRTN,DIC="^SRF("_SRTN_",16," D FILE^DICN
 S $P(^SRF(SRTN,16,+Y,0),"^",2)=SROC,SRY=+Y
EM13 I EMILY=13 K DIR S DIR(0)="130"_$S(SRIF=1:".13,5",1:".22,15"),DIR("A")=$S(SRIF=1:"Intra",1:"Post")_"op Device Type" D ^DIR G:X="" EM13 D  K DR,DA,DIE
 .K DA,DR,DIE,DIR I X["^"!(X="@")!(Y=0) D DEL S DA=SRTN,DIE=130,DR="467////N" D ^DIE Q
 .S DA=SRY,DR=$S(SRIF=1:5,1:15)_"///"_Y,DA(1)=SRTN,DIE="^SRF(SRTN,"_$S(SRIF=1:10,1:16)_"," D ^DIE
EM8 I EMILY=8 K DIR S DIR(0)="130.22,8",DIR("A")="Cardiopulmonary Bypass Status" D ^DIR G:X="" EM8 D  K DR,DA,DIE
 .K DA,DR,DIE,DIR I X["^"!(X="@")!(Y=0) D DEL S DA=SRTN,DIE=130,DR="391////N" D ^DIE Q
 .S DA=SRY,DR="8///"_Y,DA(1)=SRTN,DIE="^SRF(SRTN,16," D ^DIE
EM11 I EMILY=11 K DIR S DIR(0)="130.22,9",DIR("A")="Stroke/CVA Duration",DIR("B")="<24 HOURS" D ^DIR G:X="" EM11 D  K DR,DA,DIE
 .K DA,DR,DIE,DIR I X["^"!(X="@")!(Y=1) D DEL S DA=SRTN,DIE=130,DR="256////N" D ^DIE Q
 .S DA=SRY,DR="9///"_Y,DA(1)=SRTN,DIE="^SRF(SRTN,16," D ^DIE
 Q
IP K DIR S DIR("A")="Is this an Intraoperative occurrence? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)
 S SRIF=Y
 I SRIF=1 S X=$P(^SRO(136.5,SROC,0),"^"),DIC(0)="L",DLAYGO="130.14",DA(1)=SRTN,DIC="^SRF("_SRTN_",10," D FILE^DICN S $P(^SRF(SRTN,10,+Y,0),"^",2)=SROC Q
 I SRIF=0 S X=$P(^SRO(136.5,SROC,0),"^"),DIC(0)="L",DLAYGO="130.22",DA(1)=SRTN,DIC="^SRF("_SRTN_",16," D FILE^DICN S $P(^SRF(SRTN,16,+Y,0),"^",2)=SROC
 Q
DEL ; delete existing Post/Intraoperative occurrences.
 N II,SRII,SROC D MAP
 S II=0 F  S II=$O(^SRF(SRTN,16,II)) Q:'II  S SRII=$G(^(II,0)) I $P(SRII,"^",2)=SROC D  Q
 .S DA(1)=SRTN,DA=II,DIK="^SRF("_SRTN_",16," D ^DIK I '$O(^SRF(SRTN,16,0)) K ^SRF(SRTN,16,0)
 ;
 S II=0 F  S II=$O(^SRF(SRTN,10,II)) Q:'II  S SRII=$G(^(II,0)) I $P(SRII,"^",2)=SROC D  Q
 .S DA(1)=SRTN,DA=II,DIK="^SRF("_SRTN_",10," D ^DIK I '$O(^SRF(SRTN,10,0)) K ^SRF(SRTN,10,0)
 Q
MAP S SROC=$S(EMILY=1:17,EMILY=2:23,EMILY=3:1,EMILY=4:25,EMILY=5:16,EMILY=6:26,EMILY=7:6,EMILY=8:27,EMILY=9:33,EMILY=10:41,EMILY=11:12,EMILY=12:13,EMILY=14:39,EMILY=15:22,EMILY=16:9,1:34)
 Q
