DGRUGDS ;ALB/GRR - RAI/MDS DATA COLLECTION
 ;;5.3;Registration;**303,359**;Aug 13, 1993
 ;
 ;Display option description and allow user to terminate process
EN ;
 W @IOF
 N DGSTN,DGX,DGDIV
 F I=0:1 S DGX=$P($T(TEXT+I),";;",2) Q:DGX="$END"  W !,DGX
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Do you wish to continue? "
 S DIR("?")="Enter Yes to continue or No to quit"
 D ^DIR K DIR
 Q:'Y!$D(DIRUT)
 ;
 ;Ask user for division to seed
DIV ;
 W !
 N DIR,DIRUT
 S DIR(0)="PO^40.8:EMZ"
 S DIR("A")="Enter the Division you want to do Data Seeding for"
 S DIR("?")="Select the division you want to load the patient data for into the COTS database."
 D ^DIR K DIR Q:$D(DIRUT)!(+Y'>0)
 S DGDIV=Y
 S DGSTN=$$SITE^VASITE($$NOW^XLFDT,+DGDIV)
 W !!,?4,"You have selected: ",$P(DGDIV,"^",2)
 W !,?4,"Station Number   : ",$S(+DGSTN>0:$P(DGSTN,"^",3),1:"Undefined Station Number"),!
 I +DGSTN<0 D  G DIV
 .W !?4,"You cannot proceed with this division until the station number is corrected."
 .W !?4,"You may select another division or quit.",!
 N DIR,DUOUT,DTOUT
 S DIR(0)="YAO",DIR("A")="Is this correct? ",DIR("B")="YES"
 S DIR("?")="Enter Yes or No.  Yes will select, No will cancel."
 D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))
 G:'Y DIV
 W !
 N ZTDESC,ZTSAVE,ZTIO,ZTDTH,X,ZTQUEUED,ZTREQ,ZTRTN
 S ZTDESC="RAI/MDS DATA SEED FOR DIVISION "_$P(DGDIV,"^",2)
 S ZTRTN="EN1^DGRUGDS",ZTIO=""
 S DGDIV=+DGDIV
 S ZTSAVE("DGDIV")="",ZTSAVE("DGSTN")=""
 D ^%ZTLOAD
 I '$G(ZTSK) W !,"** The data seed process was not tasked **"
 I $G(ZTSK) W !,"The data seed process has been tasked (#",ZTSK,")"
 W !
 Q
EN1 ;
 N DGSENM,DGIEN,DGRSIED,DGWARD,DGWARD,DGWIEN,DGWDIV,DGSEED,DGMDT,DGRUGDS
 S U="^",DGSENM="DGRU-RAI-A01-SERVER",DGRSIED=$O(^ORD(101,"B",DGSENM,0)) ;SET VARIABLES TO CALL HL7 INIT FUNCTION
 D INIT^HLFNC2(DGSENM,.HL) ;Initialize A01 server, sets HL7 variables
 I $O(HL(""))']"" D  Q  ;WAS UNABLE TO INTIALIZE
 .S HLERR(1)=HL
 .;S DGWARD="" F  S DGWARD=$O(^DGPM("CN",DGWARD)) Q:DGWARD=""  S DGWIEN=+$O(^DIC(42,"B",DGWARD,0)) I $$GET1^DIQ(42,DGWIEN,.035,"I")=1 D  ;loop through active patients, if ward is RAI/MDS flagged, continue
 .;S DGWDIV=$$GET1^DIQ(42,DGWIEN,.015,"I") I DGWDIV=DGDIV S DGIEN=0 F  S DGIEN=$O(^DGPM("CN",DGWARD,DGIEN)) Q:DGIEN'>0  D  ;If ward in the division selected, continue
 ;..S DFN=$$GET1^DIQ(405,DGIEN,.03,"I") Q:DFN=""  ;get patient ien
 ;..S DGMDT=$$GET1^DIQ(405,DGIEN,.01,"I") Q:DGMDT=""
 ;..S DGSEED=1 D BLDMSG^DGRUADT1(DFN,"A01",DGIEN,DGMDT,DGWIEN)
 ;
 S DGRUGDS=0
 S DGWARD=""
 ;Loop through active patients
 F  S DGWARD=$O(^DGPM("CN",DGWARD)) Q:(DGWARD="")!(DGRUGDS)  D
 .;Task asked to stop ?
 .S X="Looping through ward "_DGWARD
 .S DGRUGDS=$$S^%ZTLOAD(X) Q:DGRUGDS
 .S DGWIEN=+$O(^DIC(42,"B",DGWARD,0))
 .;Not an RAI/MDS ward
 .Q:'$$GET1^DIQ(42,DGWIEN,.035,"I")
 .S DGWDIV=$$GET1^DIQ(42,DGWIEN,.015,"I")
 .;Ward not in selected division
 .Q:DGWDIV'=DGDIV
 .;Loop through movements
 .S DGIEN=0
 .F  S DGIEN=$O(^DGPM("CN",DGWARD,DGIEN)) Q:(DGIEN'>0)!(DGRUGDS)  D
 ..;Get patient pointer and movement date/time
 ..S DFN=$$GET1^DIQ(405,DGIEN,.03,"I") Q:DFN=""
 ..S DGMDT=$$GET1^DIQ(405,DGIEN,.01,"I") Q:DGMDT=""
 ..;Send message to RAI/MDS machine
 ..S DGSEED=1 D BLDMSG^DGRUADT1(DFN,"A01",DGIEN,DGMDT,DGWIEN)
 ..;Task asked to stop ?
 ..S X="Looping through ward "_DGWARD_" -- Last DFN sent was "_DFN
 ..S DGRUGDS=$$S^%ZTLOAD(X) Q:DGRUGDS
 ;Update task message with completion status
 I DGRUGDS S X=$$S^%ZTLOAD("Task stopped as requested")
 I 'DGRUGDS S X=$$S^%ZTLOAD("Task ran to completion")
 Q
 ;
TEXT ;;This option will do the data seeding of patient data in the RAI/MDS COTS system.
 ;;HL7 A01 Admit messages will be created for patients currently active in wards
 ;;assigned to the selected division.  This option should be run only once per
 ;;division and the COTS system database should be empty of patient data prior
 ;;to using this option.
 ;;
 ;;***NOTE***
 ;;
 ;;It is extremely important that both the Ward translation file (#46.12) and the
 ;;Room-Bed Translation file (#46.13) be complete if they are needed for use.
 ;;The RAI/MDS flag must be set to YES for the RAI/MDS wards in the selected
 ;;division BEFORE this option is run.
 ;;
 ;;$END
 ;;
 ;Entry point for individual data seed
EN3 ;
 W @IOF
 N DGINPT,DGPTNM,DGFNM,DGLNM
 F I=0:1 S DGX=$P($T(TEXT3+I),";;",2) Q:DGX="$END"  W !,DGX
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Do you wish to continue? "
 S DIR("?")="Enter Yes to continue or No to quit"
 D ^DIR K DIR
 Q:'Y!$D(DIRUT)
 ;
 ;Select patient(s)
INPAT ;
 W !
 N DIR,DIRUT,DFN,DGIEN,DGWIEN,DGMDT
 S DIR(0)="PAO^2:EMZ"
 S DIR("A")="Enter the patient you want to data seed: "
 S DIR("?")="Select the patient you want to load into the COTS database."
 D ^DIR K DIR Q:$D(DIRUT)!(+Y'>0)
 S DGINPT=+Y
 S DGPTNM=$$GET1^DIQ(2,DGINPT,.01)
 S DGFNM=$P(DGPTNM,",",2)
 S DGLNM=$P(DGPTNM,",",1)
 S DGPTNM=DGFNM_" "_DGLNM
 W !!,?4,"You have selected: ",DGPTNM
 W !
 I +DGINPT<0 D  G INPAT
 .W !?4,"You cannot proceed with this patient"
 .W !?4,"You may select another patient or quit.",!
 N DIR,DUOUT,DTOUT
 S DIR(0)="YAO",DIR("A")="Is this correct? ",DIR("B")="YES"
 S DIR("?")="Enter Yes or No. Yes will select this patient. No will cancel the selection of this patient."
 D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))
 G:'Y INPAT D EN4
 ;Allow another selection
 W !
 S DIR(0)="YAO",DIR("A")="Select another patient? ",DIR("B")="NO"
 S DIR("?")="Enter Yes or No. Yes will allow you to select another patient."
 D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))!('Y)
 G:Y INPAT
 W !
 Q
 ;
 ;Set variables to call HL7 Function
EN4 ;
 N DGSENM,DGIEN,DGRSIED,DGWARD,DGWARD,DGWIEN,DGWDIV,DGSEED,DGMDT,DGRUGDS
 S U="^",DGSENM="DGRU-RAI-A01-SERVER",DGRSIED=$O(^ORD(101,"B",DGSENM,0))
 D INIT^HLFNC2(DGSENM,.HL) ;Initialize A01 server, sets HL7 variables
 I $O(HL(""))']"" D  Q  ;WAS UNABLE TO INTIALIZE
 .S HLERR(1)=HL
 ;
 ;Get selected patient's last ward location.  If RAI ward, send message.
 ;If not an RAI ward, allow another inpatient selection.  If current
 ;ward location is empty, patient is inactive & allow another selection.
ACTIVE ;
 S DFN=DGINPT
 S DGRUGDS=0
 S VAIP("D")="LAST"
 D IN5^VADPT
 I '$$CHKWARD^DGRUUTL(+$P(VAIP(5),"^")) W !!?4,DGPTNM_" is not in an RAI ward." D EXIT Q
 I $$GET1^DIQ(2,DFN,.1)="" W !!?4,DGPTNM_" is not an active patient in an RAI ward." D EXIT Q
 I $$CHKWARD^DGRUUTL(+$P(VAIP(5),"^")) S DGWIEN=+$P(VAIP(5),"^"),DGIEN=VAIP(1),DGMDT=+$P(VAIP(3),"^")
 S DGSEED=1 D BLDMSG^DGRUADT1(DFN,"A01",DGIEN,DGMDT,DGWIEN)
 W !!?4,"Sending message..."
 D EXIT
 Q
 ;Reset variables for next selection
EXIT ;
 K DFN,DGIEN,DGINPT,DGWIEN,DGMDT,VAIP
 ;
TEXT3 ;;This option will do the data seeding of patient data in the RAI/MDS COTS system.
 ;;HL7 A01 Admit messages will be created for selected patients currently active in
 ;;RAI designated wards.
 ;;
 ;;***NOTE***
 ;;
 ;;It is extremely important that both the Ward translation file (#46.12)and the
 ;;Room-Bed Translation file (#46.13) be complete if they are needed for use.
 ;;The RAI/MDS flag must be set to YES for the RAI/MDS wards in the selected
 ;;division BEFORE this option is run.
 ;;
 ;;$END
 ;;
