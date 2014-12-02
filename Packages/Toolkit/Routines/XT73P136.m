XT73P136 ;RSD/OAKLAND - Test Routine for XT*7.3*136
 ;;7.3;TOOLKIT;**136**;Apr 25, 1995;Build 5
 ;This routine is only to test MXMLPRESE for patch 136.
 Q
EN ;Display "PASSED" or "FAILED"
 N CB,I,TEST,Y,Z
 K ^TMP($J,"P136 TEST")
 S U="^",TEST="FAILED",Z=0
 F I=1:1 S Y=$T(TST1+I) Q:Y=""  D
 .I $E(Y,1,3)=" ;;" S Y=$E(Y,4,999),Z=Z+1,^TMP($J,"P136 TEST",Z)=Y Q
 .S Y=$E(Y,2,999),^TMP($J,"P136 TEST",Z)=^TMP($J,"P136 TEST",Z)_Y
 .Q
 S CB("ENDDOCUMENT")="ENDD^XT73P136",Y="^TMP($J,""P136 TEST"")"
 D EN^MXMLPRSE(Y,.CB,"") W !,"Test = ",TEST,!
 K ^TMP($J,"P136 TEST")
 Q
ENDD ;end of document call back
 S TEST="PASSED"
 Q
TST1 ; create test message
 ;;<Bloodbank><Patient dfn="990451" firstName="CARPANTS" lastName="BIFF" dob="7720613.000000" ssn="111111111" abo="A " rh="N">
 ;;<TransfusionReactions><TransfusionReaction type="Urticaria" date="3130408.151856" unitId="W040713210843" productTypeName="Thawed
 ; Apheresis FRESH FROZEN PLASMA" productTypePrintName="FFP AFR Thaw" productCode="E2121V00" comment="On 4/8/13 after transfusion of
 ; thawed plasma unit #W040713210843 the patient developed a rash and itching.  Th
 ;;e entire unit had been transfused.  There were only minor changes in his VS: T 98.3 to 98.2; HR 56 to 56; BP 119/71 to 132/75 and
 ; RR 18 to 18.  Blood Bank was notified of a suspected transfusion reaction.  A clerical check revealed no errors; the patient&ap
 ;;os;s posttransfusion plasma was not hemolyzed and his direct antiglobulin tesst (DAT) remained negative.  The patient's symptoms
 ; and the lack of laboratory findings are most conististent with a mild allergic transfusion reaction.  Such reactions are not uncommon
 ; and are usually directed to foreign proteins in the transfused plasma to which the recipient is immune.  If future transfusions are
 ; needed premedication with benadryl may be beneficial."/>
 ;;</TransfusionReactions></Patient></Bloodbank>
