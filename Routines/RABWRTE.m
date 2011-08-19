RABWRTE ;HISC/SM - Billing Aware Report Entry ;11/19/04  12:35
 ;;5.0;Radiology/Nuclear Medicine;**41**;Mar 16,1998
 Q
ELOC ;Enter Inter. Img. Location
 ; called from IN1^RARTE4 & NOEDIT^RARTRPV1
 N RACLC0,RADT0,RAERR,RAXITYPI,RAXITYPE,RAIIL
 ; RACLC0 = current switchedTo/signedOn loc's 0 node
 ; RADT0 = exam's DT 0 node
 ; RAXITYP = exam's Imaging Type in text
 ; RAIIL = value of current report's Int. Img Loc ien
 S RAERR=0
 S RACLC0=$G(^RA(79.1,+$G(RAMLC),0)) Q:RACLC0=""
 S RAIIL=$G(^RARPT(RARPT,"BA"))
 S RADT0=$G(^RADPT(RADFN,"DT",RADTI,0))
 S RAXITYPI=$P(RADT0,U,2) ; Exam's Img Type, Internal
 S RAXITYPE=$P(^RA(79.2,+RAXITYPI,0),U) ; Exam's Img Type, External
 ;
 ; skip checks if there's Int. Img Loc data and its Credit Method is ok
 I RAIIL,$P($G(^RA(79.1,+RAIIL,0)),U,21)'=3 G INPUT
 ;
 I $P(RACLC0,U,21)=3 D
 . W !!?5,$C(7),"Your signed-on or switched-to location is ",$P($G(RACCESS(DUZ,"LOC",+$G(RAMLC))),U,2),",",!?5,"which has a Credit Method of '",$P($P($P(^DD(79.1,21,0),U,3),"3:",2),";"),"'."
 . W !,?5,"This Credit Method does not allow for Interpretation work.",!
 . S RAERR=1
 I $P(RACLC0,U,6)'=$P(RADT0,U,2) D
 . W !!?5,$C(7),"Your signed-on or switched-to location is ",$P($G(RACCESS(DUZ,"LOC",+$G(RAMLC))),U,2),",",!?5,"which has an Imaging Type of '",$P(^RA(79.2,+$P(RACLC0,U,6),0),U),"'."
 . W !?5,"But the exam has an Imaging Type of '"_RAXITYPE,"'."
 . S RAERR=2
 I RAERR D
 . W !!?5,"You may optionally switch your current location to a location that",!?5,"allows either Regular or Interpretation credit.  Then that location"
 . W !?5,"will be used as the default value to this field.",!
INPUT S DA=RARPT
 S DIE="^RARPT("
 S DR=86 S:'RAERR DR=DR_"//"_$P(RACCESS(DUZ,"LOC",+RAMLC),U,2)
 W ! D ^DIE W !
 Q
SIIL() ; Screen Interpreting Imaging Location
 ; called by DD(74,86's DIC("S")
 ; check file 79.1 img loc's credit method 
 I $P(^RA(79.1,+Y,0),U,21)=3 Q 0 ;Img Loc's Credit Meth is Tech Only
 I '$D(RADFN) Q 1 ; can't continue, thus default to ok
 I '$D(RADTI) Q 1 ; can't continue, thus default to ok
 ; check file 79.1 img loc against case's imaging location
 I $P(^RA(79.1,+Y,0),U,6)'=$P(^RADPT(RADFN,"DT",RADTI,0),U,2) Q 0
 ; check file 79.1 img loc's INACTIVE dt against case's exam date
 I $P(^RA(79.1,+Y,0),U,19),$G(RADTE)]$P(^RA(79.1,+Y,0),U,19) Q 0
 Q 1
