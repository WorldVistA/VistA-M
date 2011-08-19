SROUTC ;BIR/SJA - OUTCOMES DATA ;03/13/06
 ;;3.0; Surgery ;**125,135,153,174**;24 Jun 93;Build 8
 D UPDT490,EN^SROCCAT
 F I=205,206,208,209 S SRA(I)=$G(^SRF(SRTN,I))
 S NYUK=$P(SRA(208),"^",2) D YN S SRAO(1)=SHEMP_"^385",NYUK=$P(SRA(208),"^",7) D YN S SRAO(8)=SHEMP_"^391"
 S NYUK=$P(SRA(208),"^",3) D YN S SRAO(2)=SHEMP_"^386",NYUK=$P(SRA(206),"^",39) D YN S SRAO(9)=SHEMP_"^466"
 S NYUK=$P(SRA(205),"^",17) D YN S SRAO(3)=SHEMP_"^254",NYUK=$P(SRA(209),"^",12) D YN S SRAO(10)=SHEMP_"^490"
 S NYUK=$P(SRA(208),"^",5) D YN S SRAO(4)=SHEMP_"^388",NYUK=$P(SRA(205),"^",21) D YN S SRAO(11)=SHEMP_"^256"
 S NYUK=$P(SRA(205),"^",26) D YN S SRAO(5)=SHEMP_"^411",NYUK=$P(SRA(205),"^",22) D YN S SRAO(12)=SHEMP_"^410"
 S NYUK=$P(SRA(208),"^",6) D YN S SRAO(6)=SHEMP_"^389",NYUK=$P(SRA(206),"^",40) D YN S SRAO(13)=SHEMP_"^467"
 S NYUK=$P(SRA(205),"^",13) D YN S SRAO(7)=SHEMP_"^285",NYUK=$P(SRA(208),"^") D YN S SRAO(0)=SHEMP_"^384"
 S NYUK=$P(SRA(205),"^",40) D YN S SRAO(14)=SHEMP_"^448"
 ;
DISP S SRPAGE="PAGE: 1",SRHDR(.5)="OUTCOMES INFORMATION" D HDR^SROAUTL
 W !,"0. Operative Death: ",?35,$P(SRAO(0),"^")
 W !!,"Perioperative (30 day) Occurrences:",!,"-----------------------------------"
 W !,"1. Perioperative MI: ",?35,$P(SRAO(1),"^"),?40," 8. Repeat cardiac surg procedure: ",?76,$P(SRAO(8),"^")
 W !,"2. Endocarditis: ",?35,$P(SRAO(2),"^"),?40," 9. Tracheostomy: ",?76,$P(SRAO(9),"^")
 W !,"3. Renal failure require dialysis: ",$P(SRAO(3),"^"),?40,"10. Repeat ventilator w/in 30 days: ",?76,$P(SRAO(10),"^")
 W !,"4. Mediastinitis: ",?35,$P(SRAO(4),"^"),?40,"11. Stroke: ",?76,$P(SRAO(11),"^")
 W !,"5. Cardiac arrest requiring CPR: ",?35,$P(SRAO(5),"^"),?40,"12. Coma >= 24 hr: ",?76,$P(SRAO(12),"^")
 W !,"6. Reoperation for bleeding: ",?35,$P(SRAO(6),"^"),?40,"13. New Mech Circ Support: ",?76,$P(SRAO(13),"^")
 W !,"7. On ventilator >= 48 hr: ",?35,$P(SRAO(7),"^"),?40,"14. Postop Atrial Fibrillation: ",?76,$P(SRAO(14),"^")
 W !! F MOE=1:1:80 W "-"
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
UPDT490 ; update field 490
 N SRX S SRX=$P($G(^SRF(SRTN,209)),"^",12) S:SRX="" SRX="N"
 K DA,DIE,DR S DIE=130,DA=SRTN,DR="490////"_SRX D ^DIE K DA,DIE,DR
 Q
UPDATE N SRCMP,SROC,SRI,SRIF,SRQ,SRY D MAP
 I EMILY=5!(EMILY=13) D IP Q
 S X=$P(^SRO(136.5,SROC,0),"^"),DIC(0)="L",DLAYGO="130.22",DA(1)=SRTN,DIC="^SRF("_SRTN_",16," D FILE^DICN
 S $P(^SRF(SRTN,16,+Y,0),"^",2)=SROC,SRY=+Y
EM8 I EMILY=8 K DIR S DIR(0)="130.22,8",DIR("A")="Cardiopulmonary Bypass Status" D ^DIR G:X="" EM8 D  K DR,DA,DIE
 .K DA,DR,DIE,DIR I X["^"!(X="@")!(Y=0) D DEL S DA=SRTN,DIE=130,DR="391////N" D ^DIE Q
 .S DA=SRY,DR="8///"_Y,DA(1)=SRTN,DIE="^SRF(SRTN,16," D ^DIE
 Q
IP K DIR S DIR("A")="Is this an Intraoperative occurrence? ",DIR("B")="YES",DIR(0)="YA" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)
 S SRIF=Y
 I SRIF=1 S X=$P(^SRO(136.5,SROC,0),"^"),DIC(0)="L",DLAYGO="130.14",DA(1)=SRTN,DIC="^SRF("_SRTN_",10," D FILE^DICN S $P(^SRF(SRTN,10,+Y,0),"^",2)=SROC Q
 ;
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
MAP S SROC=$S(EMILY=1:17,EMILY=2:23,EMILY=3:9,EMILY=4:25,EMILY=5:16,EMILY=6:26,EMILY=7:6,EMILY=8:27,EMILY=9:33,EMILY=10:37,EMILY=11:12,EMILY=12:13,EMILY=14:39,1:34)
 Q
