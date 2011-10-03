SROAPRT7 ;BIR/MAM - PRINT OCCURRENCES ;01/24/07
 ;;3.0; Surgery ;**38,47,57,60,125,160**;24 Jun 93;Build 7
 K SRA,SRAO D EN^SROCCAT S SRA(205)=$G(^SRF(SRTN,205))
 S NYUK=$P(SRA(205),"^",5) D YN S SRAO(1)=SHEMP_"^403",NYUK=$P(SRA(205),"^",6) D YN S SRAO("1A")=SHEMP_"^248",NYUK=$P(SRA(205),"^",7) D YN S SRAO("1B")=SHEMP_"^249"
 S NYUK=$P(SRA(205),"^",37) D YN S SRAO("6E")=SHEMP_"^488",NYUK=$P(SRA(205),"^",8) D YN S SRAO("1C")=SHEMP_"^404",NYUK=$P(SRA(205),"^",39) D YN S SRAO("6F")=SHEMP_"^447"
 S NYUK=$P(SRA(205),"^",9) D YN S SRAO(2)=SHEMP_"^318",NYUK=$P(SRA(205),"^",10) D YN S SRAO("2A")=SHEMP_"^251",NYUK=$P(SRA(205),"^",11) D YN S SRAO("2B")=SHEMP_"^412",NYUK=$P(SRA(205),"^",12) D YN S SRAO("2C")=SHEMP_"^252"
 S NYUK=$P(SRA(205),"^",13) D YN S SRAO("2D")=SHEMP_"^285"
 S NYUK=$P(SRA(205),"^",15) D YN S SRAO(3)=SHEMP_"^319",NYUK=$P(SRA(205),"^",16) D YN S SRAO("3A")=SHEMP_"^409",NYUK=$P(SRA(205),"^",17) D YN S SRAO("3B")=SHEMP_"^254",NYUK=$P(SRA(205),"^",18) D YN S SRAO("3C")=SHEMP_"^255"
 S NYUK=$P(SRA(205),"^",20) D YN S SRAO(4)=SHEMP_"^320",NYUK=$P(SRA(205),"^",21) D YN S SRAO("4A")=SHEMP_"^256",NYUK=$P(SRA(205),"^",22) D YN S SRAO("4B")=SHEMP_"^410",NYUK=$P(SRA(205),"^",23) D YN S SRAO("4C")=SHEMP_"^287"
 S NYUK=$P(SRA(205),"^",25) D YN S SRAO(5)=SHEMP_"^321",NYUK=$P(SRA(205),"^",26) D YN S SRAO("5A")=SHEMP_"^411",NYUK=$P(SRA(205),"^",27) D YN S SRAO("5B")=SHEMP_"^258",NYUK=$P(SRA(205),"^",28) D YN S SRAO("5C")=SHEMP_"^259"
 S NYUK=$P(SRA(205),"^",30) D YN S SRAO(6)=SHEMP_"^322",NYUK=$P(SRA(205),"^",32) D YN S SRAO("6A")=SHEMP_"^257"
 S NYUK=$P(SRA(205),"^",33) D YN S SRAO("6B")=SHEMP_"^261",NYUK=$P(SRA(205),"^",34) D YN S SRAO("6C")=SHEMP_"^263",NYUK=$P(SRA(205),"^",35) D YN S SRAO("6D")=SHEMP_"^250"
 K SROOC N SRSEP,SRSTAR
 D OCC^SROAUTL0
 S X=$G(SROOC(21)) I X'="" S X=$P($G(SROOC(21)),U)_" "_$E($P($G(SROOC(21)),U,2),1,17)
 S SRAO("6G")=X_"^392"
 S X=$G(SROOC(29)) I X'="" S X=$P($G(SROOC(29)),U)_" "_$E($P($G(SROOC(29)),U,2),1,17)
 S SRAO("2E")=X_"^253"
 S X=$G(SROOC(30)) I X'="" S X=$P($G(SROOC(30)),U)_" "_$E($P($G(SROOC(30)),U,2),1,17)
 S SRAO("4D")=X_"^343"
 S X=$G(SROOC(31)) I X'="" S X=$P($G(SROOC(31)),U)_" "_$E($P($G(SROOC(31)),U,2),1,17)
 S SRAO("3D")=X_"^286"
 S X=$G(SROOC(32)) I X'="" S X=$P($G(SROOC(32)),U)_" "_$E($P($G(SROOC(32)),U,2),1,17)
 S SRAO("5D")=X_"^344"
 S X=$G(SROOC(36)) I X'="" S X=$P($G(SROOC(36)),U)_" "_$E($P($G(SROOC(36)),U,2),1,17)
 S SRAO("1D")=X_"^489"
 S Y=6 F  S Y=$O(SRAO(Y)) Q:Y=""  D
 .I $E(Y)="1" S SRI=$S(Y="1A":1,Y="1B":2,Y="1C":22,1:"") Q:SRI=""
 .I $E(Y)="2" S SRI=$S(Y="2A":4,Y="2B":7,Y="2C":5,Y="2D":6,1:"")  Q:SRI=""
 .I $E(Y)="3" S SRI=$S(Y="3A":8,Y="3B":9,Y="3C":10,1:"")  Q:SRI=""
 .I $E(Y)="4" S SRI=$S(Y="4A":12,Y="4B":13,Y="4C":14,1:"")  Q:SRI=""
 .I $E(Y)="5" S SRI=$S(Y="5A":16,Y="5B":17,Y="5C":11,1:"")  Q:SRI=""
 .I $E(Y)="6" S SRI=$S(Y="6A":15,Y="6B":19,Y="6C":20,Y="6D":3,Y="6E":35,Y="6F":38,1:"")  Q:SRI=""
 .S SRIN=Y I SROC(SRI)="       "&($P(SRAO(SRIN),"^")="YES") S $P(SRAO(SRIN),"^")="ND"
 .S $P(SRAO(SRIN),"^")=$S($P(SRAO(SRIN),"^")="YES":$E(SROC(SRI),4,5)_"/"_$E(SROC(SRI),6,7)_"/"_$E(SROC(SRI),2,3),$P(SRAO(SRIN),"^")="NO":"   "_$P(SRAO(SRIN),"^"),$P(SRAO(SRIN),"^")="ND":" NO DATE",1:$P(SRAO(SRIN),"^"))
 I $G(SRSEP)'="" S X=$P(SRAO("6D"),"^"),$P(SRAO("6D"),"^")=SRSEP_" "_X
 F SRK="1D","4D","3D","5D","2E","6G" S SRKO=$S(SRK="4D":30,SRK="3D":31,SRK="5D":32,SRK="2E":29,SRK="6G":21,SRK="1D":36,1:"") I $P(SRAO(SRK),"^")'="" D
 .S SRSTAR=1 I SROC(SRKO)="       " S SRD="NO DATE"
 .I SROC(SRKO)'="       " S SRD=$E(SROC(SRKO),4,5)_"/"_$E(SROC(SRKO),6,7)_"/"_$E(SROC(SRKO),2,3)
 .S $P(SRAO(SRK),"^")="* "_$P(SRAO(SRK),"^")_$J(SRD,(26-$L($P(SRAO(SRK),"^")))+10)
DISP W:$E(IOST)'="C" ! W !,?21,"PERIOPERATIVE OCCURRENCE INFORMATION",!!,"WOUND OCCURRENCES:",?33,$P(SRAO(1),"^"),?41,"CNS OCCURRENCES:",?74,$P(SRAO(4),"^")
 W !,"Superficial Incisional SSI:",?30,$P(SRAO("1A"),"^"),?41,"Stroke/CVA:",?71,$P(SRAO("4A"),"^")
 W !,"Deep Incisional SSI:",?30,$P(SRAO("1B"),"^"),?41,"Coma > 24 Hours:",?71,$P(SRAO("4B"),"^")
 W !,"Wound Disruption:",?30,$P(SRAO("1C"),"^"),?41,"Peripheral Nerve Injury:",?71,$P(SRAO("4C"),"^")
 I $P(SRAO("1D"),"^")'=""!($P(SRAO("4D"),"^")'="") W !,$P(SRAO("1D"),"^"),?41,$P(SRAO("4D"),"^")
 W !!,"URINARY TRACT OCCURRENCES: ",?33,$P(SRAO(3),"^"),?41,"CARDIAC OCCURRENCES:",?74,$P(SRAO(5),"^")
 W !,"Renal Insufficiency: ",?30,$P(SRAO("3A"),"^"),?41,"Arrest Requiring CPR:",?71,$P(SRAO("5A"),"^")
 W !,"Acute Renal Failure:",?30,$P(SRAO("3B"),"^"),?41,"Myocardial Infarction:",?71,$P(SRAO("5B"),"^")
 W !,"Urinary Tract Infection:",?30,$P(SRAO("3C"),"^"),?41,$P(SRAO("5D"),"^")
 I $P(SRAO("3D"),"^")'="" W !,$P(SRAO("3D"),"^")
 W !,?41,"OTHER OCCURRENCES:",?74,$P(SRAO(6),"^")
 W !,"RESPIRATORY OCCURRENCES:",?33,$P(SRAO(2),"^"),?41,"Bleeding/Transfusions:",?71,$P(SRAO("6A"),"^")
 W !,"Pneumonia:",?30,$P(SRAO("2A"),"^"),?41,"Graft/Prosthesis/Flap Failure:",?71,$P(SRAO("6B"),"^")
 W !,"Unplanned Intubation:",?30,$P(SRAO("2B"),"^"),?41,"DVT/Thrombophlebitis:",?71,$P(SRAO("6C"),"^")
 W !,"Pulmonary Embolism:",?30,$P(SRAO("2C"),"^"),?41,"Systemic Sepsis: " D
 .I $P(SRAO("6D"),"^")="   NO" W ?71,$P(SRAO("6D"),"^") Q
 .W $J($P(SRAO("6D"),"^"),21)
 W !,"On Ventilator > 48 Hours:",?30,$P(SRAO("2D"),"^"),?41,"Organ/Space SSI:",?71,$P(SRAO("6E"),"^")
 W !,$P(SRAO("2E"),"^"),?41,"C. difficile Colitis:",?71,$P(SRAO("6F"),"^")
 W !,?41,$P(SRAO("6G"),"^")
 I $G(SRSTAR) W !,"* indicates Other (ICD9)"
 I $E(IOST)="C" W !! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 Q
YN S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
