PSNPRE ;BIR/WRT-pre-init routine to ask question to kill off old reference files sent with the package  ;29 Sep 98 / 12:07 PM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
CKDUZ I $S(('($D(DUZ)#2)):1,'$D(^VA(200,DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!,"DUZ MUST BE SET TO A VALID USER NUMBER AND",!,"DUZ(0) MUST BE SET TO THE ""@"" SIGN",!! S XPDQUIT=2 Q
 I $D(^PS(59.7,1,10)) G MESSGE
 ;following check for a virgin install
 ;
 I '$D(^PSNDF(50.6)) D BMES^XPDUTL("The PSNDF global needs to be loaded on your system before the Installation"),MES^XPDUTL("can be run.") S XPDQUIT=2
 D PATCHCHK
 Q
 ;end of check for virgin install
MESSGE W !!,$C(7),"I need to delete the following files:",!!,?5,"DRUG INGREDIENTS   (50.416)",!,?5,"VA DRUG CLASS      (50.605)",!,?5,"DRUG UNITS         (50.607)"
 W !?5,"PACKAGE TYPE       (50.608)",!?5,"PACKAGE SIZE       (50.609)",!?5,"DRUG MANUFACTURER  (55.95)"
 W !!,"If you wish to retain a copy of these files, you may wish to backup these files",!,"before going any further."
 W !!,"If you start this Installation, you must let it run to completion." S DIR(0)="Y",DIR("A")="Are you sure you want to continue" D ^DIR K DIR I $D(DIRUT) S XPDQUIT=1 Q
 I 'Y S XPDQUIT=2 Q
GLB0 I '$D(^PSNDF(50.6)) D BMES^XPDUTL("The PSNDF global needs to be loaded on your system before the Installation"),MES^XPDUTL("can be run.") S XPDQUIT=2
VR31 I $$VERSION^XPDUTL("NATIONAL DRUG FILE")<3.18 D BMES^XPDUTL("You must have installed at least version 3.18") S XPDQUIT=1
 ;
PATCHCHK I $$VERSION^XPDUTL("INPATIENT MEDICATIONS")?1"4.5".E,'$$PATCH^XPDUTL("PSJ*4.5*59") D BMES^XPDUTL("You must install patch PSJ*4.5*59") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("INPATIENT MEDICATIONS") I NDF,NDF<4.5 D BMES^XPDUTL("You must have at least version 4.5 of Inpatient Medications") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("OUTPATIENT PHARMACY") I NDF,NDF<6 D BMES^XPDUTL("You must have at least version 6 of Outpatient Pharmacy") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("ALLERGY TRACKING SYSTEM") I NDF,NDF<4 D BMES^XPDUTL("You must have at least version 4 of Allergy Tracking") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("ADVERSE REACTION TRACKING") I NDF,NDF<4 D BMES^XPDUTL("You must have at least version 4 of Adverse Reaction Tracking") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("DSS EXTRACTS") I NDF,NDF<3 D BMES^XPDUTL("You must had at least version 3 os DSS Extracts") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("DRUG ACCOUNTABILITY") I NDF,NDF<3 D BMES^XPDUTL("You must have at least version 3 of Drug Accountability") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("PHARMACY DATA MANAGEMENT") I NDF,NDF<1 D BMES^XPDUTL("You must have at least version 1 of PDM") S XPDQUIT=1
  S NDF=$$VERSION^XPDUTL("ICR - IMMUNOLOGY CASE REGISTRY") I NDF,NDF<2.1 D BMES^XPDUTL("You must have at least version 2.1 of Immunology Case Registry") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("ORDER ENTRY/RESULTS REPORTING") I NDF,NDF<2.5 D BMES^XPDUTL("You must have at least version 2.5 of OE/RR") S XPDQUIT=1
 S NDF=$$VERSION^XPDUTL("CMOP") I NDF,NDF<2 D BMES^XPDUTL("You must have at least version 2 of CMOP") S XPDQUIT=1
 I $$VERSION^XPDUTL("INPATIENT MEDICATIONS")?1"5.0".E F NDF=11,14 I '$$PATCH^XPDUTL("PSJ*5.0*"_NDF) D BMES^XPDUTL("You must install patch PSJ*5*"_NDF) S XPDQUIT=1
 I $$VERSION^XPDUTL("OUTPATIENT PHARMACY")?1"6".E,'$$PATCH^XPDUTL("PSO*6.0*173") D BMES^XPDUTL("You must install patch PSO*6*173") S XPDQUIT=1
 I $$VERSION^XPDUTL("OUTPATIENT PHARMACY")?1"7".E F NDF=10,11 I '$$PATCH^XPDUTL("PSO*7.0*"_NDF) D BMES^XPDUTL("You must install patch PSO*7*"_NDF) S XPDQUIT=1
 I $$VERSION^XPDUTL("ALLERGY TRACKING SYSTEM")?1"4".E,'$$PATCH^XPDUTL("GMRA*4.0*13") D BMES^XPDUTL("You must install patch GMRA*4*13") S XPDQUIT=1
 I $$VERSION^XPDUTL("ADVERSE REACTION TRACKING")?1"4".E,'$$PATCH^XPDUTL("GMRA*4.0*13") D BMES^XPDUTL("You must install patch GMRA*4*13") S XPDQUIT=1
 I $$VERSION^XPDUTL("DSS EXTRACTS")?1"3".E,'$$PATCH^XPDUTL("ECX*3.0*10") D BMES^XPDUTL("You must install patch ECX*3*10") S XPDQUIT=1
 I $$VERSION^XPDUTL("DRUG ACCOUNTABILITY")?1"3".E,'$$PATCH^XPDUTL("PSA*3.0*8") D BMES^XPDUTL("You must install patch PSA*3*8") S XPDQUIT=1
 I $$VERSION^XPDUTL("PHARMACY DATA MANAGEMENT")?1"1".E,'$$PATCH^XPDUTL("PSS*1.0*15") D BMES^XPDUTL("You must install patch PSS*1*15") S XPDQUIT=1
 I $$VERSION^XPDUTL("ICR - IMMUNOLOGY CASE REGISTRY")?1"2.1".E,'$$PATCH^XPDUTL("IMR*2.1*3") D BMES^XPDUTL("You must install patch IMR*2.1*3") S XPDQUIT=1
 I $$VERSION^XPDUTL("ORDER ENTRY/RESULTS REPORTING")?1"3".E,'$$PATCH^XPDUTL("OR*3.0*33") D BMES^XPDUTL("You must install patch OR*3*33") S XPDQUIT=1
 I $$VERSION^XPDUTL("CMOP")?1"2".E,'$$PATCH^XPDUTL("PSX*2.0*18") D BMES^XPDUTL("You must install patch PSX*2*18") S XPDQUIT=1
 K NDF
 Q
