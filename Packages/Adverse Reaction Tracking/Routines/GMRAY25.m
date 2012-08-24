GMRAY25 ;SLC/DAN Post-install routine ;6/8/05  14:33
 ;;4.0;Adverse Reaction Tracking;**25**;Mar 29, 1996
 ;
POST ;Post-install entry point
 D IDENTSS
 D MAIL
 Q
 ;
IDENTSS ;Identify entries that may not have had their signs/symptoms correctly stored, which may also have caused other important datt to not be stored
 N GMRAIEN,GMRA0
 S GMRAIEN=0 F  S GMRAIEN=$O(^GMR(120.8,GMRAIEN)) Q:'+GMRAIEN  D
 .S GMRA0=$G(^GMR(120.8,GMRAIEN,0))
 .Q:$P(GMRA0,U,12)'=""  ;Stop if signed off field has a value
 .Q:$$TESTPAT^VADPT($P(GMRA0,U))  ;Stop if test patient
 .Q:$P($G(^GMR(120.8,GMRAIEN,"ER")),U)  ;Stop if entered in error
 .Q:$P(GMRA0,U,4)<3040101  ;Stop if entry of allergy predates v25 installation
 .S ARRAY($$GET1^DIQ(2,$P(GMRA0,U)_",",.01)_" ("_$E($$GET1^DIQ(2,$P(GMRA0,U)_",",.09),6,9)_")",$P(GMRA0,U,2))="" ;Store pt name and reactant
 Q
 ;
MAIL ;Send message indicating post install is finished
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,GMRATXT,CNT,REACTANT,DIFROM,PNAME
 S XMDUZ="PATCH GMRA*4*25 POST-INSTALL",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S GMRATXT(1)="The post-install routine for patch GMRA*4*25"
 S GMRATXT(2)="finished on "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S GMRATXT(3)=""
 S CNT=3
 I $D(ARRAY) D
 .S CNT=CNT+1,GMRATXT(CNT)="The following patients have allergies on file that may be missing"
 .S CNT=CNT+1,GMRATXT(CNT)="important data required for order checking due to an error when the allergy"
 .S CNT=CNT+1,GMRATXT(CNT)="was saved.  If the user selected the space or dashed line from the"
 .S CNT=CNT+1,GMRATXT(CNT)="signs/symptoms box then the allergy would not have been saved correctly and"
 .S CNT=CNT+1,GMRATXT(CNT)="needs to be reviewed for accuracy.  The recommended course of action is to"
 .S CNT=CNT+1,GMRATXT(CNT)="mark the existing allergy as entered in error and then re-enter the allergy"
 .S CNT=CNT+1,GMRATXT(CNT)="information for the patient."
 .S CNT=CNT+1,GMRATXT(CNT)=""
 .S PNAME="" F  S PNAME=$O(ARRAY(PNAME)) Q:PNAME=""  D
 ..S CNT=CNT+1,GMRATXT(CNT)=PNAME
 ..S REACTANT="" F  S REACTANT=$O(ARRAY(PNAME,REACTANT)) Q:REACTANT=""  D
 ...S CNT=CNT+1,GMRATXT(CNT)="  "_REACTANT
 ..S CNT=CNT+1,GMRATXT(CNT)=""
 S XMTEXT="GMRATXT(",XMSUB="PATCH GMRA*4*25 Post Install COMPLETED"
 D ^XMD
 Q
