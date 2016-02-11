SROAPCA3 ;BIR/MAM - CARDIAC OCCURRENCE DATA ;09/28/2011
 ;;3.0;Surgery;**38,71,95,101,125,160,164,166,174,175,176,182,184**;24 Jun 93;Build 35
 D EN^SROCCAT K SRA S SRA(205)=$G(^SRF(SRTN,205)),SRA(208)=$G(^SRF(SRTN,208)),SRA(206)=$G(^SRF(SRTN,206)),SRA(209)=$G(^SRF(SRTN,209))
 S SRA(210)=$G(^SRF(SRTN,210))
 S NYUK=$P(SRA(205),"^",27) D YN S SRAO(3)=SHEMP_"^258",NYUK=$P(SRA(208),"^",3) D YN S SRAO(4)=SHEMP_"^386",NYUK=$P(SRA(205),"^",17) D YN S SRAO(5)=SHEMP_"^254",NYUK=$P(SRA(205),"^",44) D YN S SRAO(6)=SHEMP_"^422"
 S NYUK=$P(SRA(208),"^",5) D YN S SRAO(7)=SHEMP_"^388",NYUK=$P(SRA(208),"^",6) D YN S SRAO(8)=SHEMP_"^389",NYUK=$P(SRA(205),"^",13) D YN S SRAO(9)=SHEMP_"^285"
 S NYUK=$P(SRA(208),"^",7) D YN S SRAO(10)=SHEMP_"^391",NYUK=$P(SRA(205),"^",22) D YN S SRAO(11)=SHEMP_"^410"
 S NYUK=$P(SRA(205),"^",21) D YN S SRAO(12)=SHEMP_"^256" D DUR
 S NYUK=$P(SRA(205),"^",26) D YN S SRAO(13)=SHEMP_"^411"
 S NYUK=$P(SRA(206),"^",39) D YN S SRAO(14)=SHEMP_"^466"
 S NYUK=$P(SRA(206),"^",40) D YN S SRAO(15)=SHEMP_"^467",NYUK=$P(SRA(205),"^",6) D YN S SRAO(18)=SHEMP_"^248"
 S NYUK=$P(SRA(205),"^",40) D YN S SRAO(16)=SHEMP_"^448",NYUK=$P(SRA(205),"^",8) D YN S SRAO(17)=SHEMP_"^404"
 S X=$P(SRA(205),"^",3),Y=$S(X'="":X,1:$P($G(^DPT(DFN,.35)),"^")),SRDEAD=Y I Y D D^DIQ S SRDEAD=Y
 S X=$P(SRA(210),"^",5) S SRAO(20)=$S(X=1:"HOME",X=2:"ACUTE CARE FACILITY",X=3:"LONG TERM CARE",X=4:"HOMELESS",X=5:"UNKNOWN",1:"")_"^670"
 S X=$P(SRA(210),"^",6) D F671 S SRAO(21)=SHEMP_"^671"
 S NYUK=$P(SRA(210),"^",8) D YN S SRAO(22)=SHEMP_"^673"
 S NYUK=$P(SRA(210),"^",9) D YN S SRAO(23)=SHEMP_"^674"
 S X=$P(SRA(210),"^",12) S SRAO(24)=$$F677(X)_"^677"
 I $Y+5>IOSL D PAGE^SROAPCA I SRSOUT Q
 W !!,"VII. OUTCOMES"
 W !!,"Perioperative (30 day) Occurrences:"
 W !,?2,"Myocardial Infarction:",?35,$P(SRAO(3),"^"),?41,"Tracheostomy:",?75,$P(SRAO(14),"^")
 W !,?2,"Endocarditis:",?35,$P(SRAO(4),"^"),?41,"Out Of OR Unplanned Intubation:",?75,$P(SRAO(6),"^")
 W !,?2,"Superficial Incisional SSI:",?35,$P(SRAO(18),"^"),?41,"Stroke/CVA:",?68,$J($P(SRAO(12),"^"),11)
 W !,?2,"Mediastinitis:",?35,$P(SRAO(7),"^"),?41,"Coma > or = 24 Hours:",?75,$P(SRAO(11),"^")
 W !,?2,"Cardiac Arrest Requiring CPR:",?35,$P(SRAO(13),"^"),?41,"New Mech Circulatory Support:",?75,$P(SRAO(15),"^")
 W !,?2,"Reoperation for Bleeding:",?35,$P(SRAO(8),"^"),?41,"Postop Atrial Fibrillation:",?75,$P(SRAO(16),"^")
 W !,?2,"On ventilator > or = 48 hr:",?35,$P(SRAO(9),"^"),?41,"Wound Disruption:",?75,$P(SRAO(17),"^")
 W !,?2,"Repeat cardiac Surg procedure:",?35,$P(SRAO(10),"^"),?41,"Renal Failure Requiring Dialysis:",?75,$P(SRAO(5),"^")
 D RES
 Q
DUR ; get stroke/cva duration
 N SROCC,SRDUR I $P(SRAO(12),"^")="NO" S X=1
 I X'=1 S SROCC=0 F  S SROCC=$O(^SRF(SRTN,16,SROCC)) Q:'SROCC  I $P(^SRF(SRTN,16,SROCC,0),"^",2)=12 S X=$P(^SRF(SRTN,16,SROCC,0),"^",8)
 S SRDUR=$S(X=2:"<24 HOURS",X=3:"24-72 HOURS",X=4:">72 HOURS",1:"NO SYMPTOMS")
 S SRAO(12)=SRDUR_"^256"
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
F671 ;
 S SHEMP=$S(X=1:"AMB W/O ASSISTIVE DEVICE",X=2:"AMB WITH CANE OR WALKER",X=3:"USES MANUAL WHEELCHAIR INDEPENDENTLY",X=4:"DOES NOT AMB",1:"")
 Q
F677(X) ;
 Q $S(X=0:"NO PREVIOUS SURG",X=1:"1 PREVIOUS SURG",X=2:"2 PREVIOUS SURG",X=3:"3 PREVIOUS SURG",X=4:"4 PREVIOUS SURG",X=5:"5 PREVIOUS SURG",X=6:"6 PREVIOUS SURG",1:"")
 ;
RES I $Y+12>IOSL D PAGE^SROAPCA I SRSOUT Q
 S SRA(208)=$G(^SRF(SRTN,208))
 S SRA(.2)=$G(^SRF(SRTN,.2))
 W !!,"VIII. RESOURCE DATA"
 S Y=$P($G(^SRF(SRTN,208)),"^",11),C=$P(^DD(130,413,0),"^",2) D Y^DIQ S X=$S(Y'="":Y,1:"NOT ENTERED") W !,"Transfer Status: ",?25,X
 S Y=$P(SRA(208),"^",14) D DT^SROAPCA1 W !,"Hospital Admission Date:",?25,X
 S Y=$P(SRA(208),"^",15) D DT^SROAPCA1 W !,"Hospital Discharge Date:",?25,X
 S Y=$P($G(^SRF(SRTN,210)),"^",14),C=$P(^DD(130,685,0),"^",2) D Y^DIQ S X=$S(Y'="":Y,1:"NOT ENTERED") W !,"DC/REL Destination:",?25,X
 S Y=$P(SRA(.2),"^",10) D DT^SROAPCA1 W !,"Time Patient In  OR: ",?25,X
 S Y=$P(SRA(.2),"^",2) D DT^SROAPCA1 W ?45,"Operation Began: ",?66,X
 S Y=$P(SRA(.2),"^",3) D DT^SROAPCA1 W !,"Operation Ended: ",?25,X
 S Y=$P(SRA(.2),"^",12) D DT^SROAPCA1 W ?45,"Time Patient Out OR: ",X
 S Y=$P(SRA(208),"^",22) I Y>1 D DT^SROAPCA1 S Y=X
 S Y=$S(Y="NS":"Unable to determine",Y="RI":"Remains intubated at 30 days",1:Y) W !,"Date and Time Patient Extubated: ",?33,Y
 I $P(SRA(208),"^",22)>1,$P(SRA(.2),"^",12) D
 .S X=$$FMDIFF^XLFDT($P(SRA(208),"^",22),$P(SRA(.2),"^",12),2) W !,?5,"Postop Intubation Hrs: ",?33,$FN((X/3600),"+",1)
 S Y=$P(SRA(208),"^",23) I Y>1 D DT^SROAPCA1 S Y=X
 S Y=$S(Y="NS":"Unable to determine",Y="RI":"Remains in ICU at 30 days",1:Y) W !,"Date and Time Patient Discharged from ICU: ",?43,Y
 S Y=$P(SRA(209),"^") W !,"Patient is Homeless: ",?25,$S(Y="Y":"YES",Y="N":"NO",Y="NS":"NS",1:"")
 W !,"Date of Death: ",?25,SRDEAD,?45,"30-Day Death: ",?65,$S($P(SRA(205),"^",41)="Y":"YES",1:"NO")
 W !,"Current Residence: ",?25,$E($P(SRAO(20),"^"),1,20),?45,"Ambulation Device: ",?65,$E($P(SRAO(21),"^"),1,15)
 W !,"History of Cancer: ",?25,$E($P(SRAO(22),"^"),1,20),?45,"History of Radiation Therapy: ",?65,$E($P(SRAO(23),"^"),1,15)
 W !,"Prior Surg in Same Operative: ",$E($P(SRAO(24),"^"),1,20),!
 I $Y+7>IOSL D PAGE^SROAPCA I SRSOUT Q
 W !,"IX. SOCIOECONOMIC, ETHNICITY, AND RACE"
 N SREMP S SREMP=$P(SRA(208),"^",18) S SREMP=$S(SREMP=1:"EMPLOYED FULL TIME",SREMP=2:"EMPLOYED PART TIME",SREMP=3:"NOT EMPLOYED",SREMP=4:"SELF EMPLOYED",SREMP=5:"RETIRED",SREMP=6:"ACTIVE MILITARY DUTY",SREMP=9:"UNKNOWN",1:" ")
 W !,?1,"Employment Status Preoperatively: ",?40,SREMP
 K SRA,SRAO
 ; Race/Ethnic
 D ENTH^SRORACE
 I $Y+7>IOSL D PAGE^SROAPCA I SRSOUT Q
 D ^SROAPCA4
 W !!," *** End of report for "_SRANM_" assessment #"_SRTN_" ***"
 I $E(IOST)'="P" W ! K DIR S DIR(0)="E" D ^DIR K DIR
 Q
