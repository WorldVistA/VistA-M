EASXDR ;ALB/BRM - ROUTINE TO MERGE ENTRIES DURING PATIENT MERGE; ; 5/10/02 9:27am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**10**;Mar 15, 2001
 ;
EN(ARRAY) ;Entry point called with the name of the array containing the
 ; from and to pointers of the record being merged.  The array is
 ; formatted as follows:
 ;    ARRAY(FROM_IEN,TO_IEN,"FROM_IEN;DPT(","TO_IEN;DPT(")=""
 ;
 ; The code in this routine will prevent duplicate dependent entries
 ; from being created when the from and to records are the same
 ;
 N EASARY,IEN,DFNFR,DFNTO,IENFR,IENTO,OKTOMRG
 F DFNFR=0:0 S DFNFR=$O(@ARRAY@(DFNFR))  Q:$G(DFNFR)'>0  D
 .S DFNTO=$O(@ARRAY@(DFNFR,0))
 .S IENFR=$O(@ARRAY@(DFNFR,DFNTO,0))
 .S IENTO=$O(@ARRAY@(DFNFR,DFNTO,IENFR,0))
 .;attempt to merge relation entries
 .S OKTOMRG=$$CHKRELAT^EASXDR1(DFNFR,DFNTO,1)
 Q
OPTION ; entry point from 'Fix Duplicate Patient Relations' menu option
 N DTOUT,DUOUT,DIRUT,DIROUT,DA,DIR,DIC,X,Y,DFN,DGMSGF,SSN,VETNAM
 S DGMSGF=1
 S DIR(0)="408.12,.03"
 S DIR("A")="Select Patient SSN"
 S DIR("?")="Select the SSN of the patient whose Patient Relation entries should be merged."
 D ^DIR Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))
 W !
 I '+Y W !?2,Y(0)," Cannot be merged.  Please select a new entry."
 I $P(Y,";",2)["DGPR(408.13," D  G:'$D(DFN) OPTION
 .I '$D(^DGPR(408.12,"C",Y)) W !?2,Y(0)," Cannot be merged.  Please select a new entry." Q
 .S IEN12=$O(^DGPR(408.12,"C",Y,""))
 .S DFN=$P($G(^DGPR(408.12,IEN12,0)),"^")
 .S VETNAM=$P($G(^DPT(DFN,0)),"^")
 .S SSN=$P($G(^DPT(DFN,0)),"^",9)
 .W !?2,Y(0)," is not in the Patient (#2) file."
 .W !!?2,"The following patient must be used to merge this entry:"
 .W !?2,"SSN:",SSN,?20,"Patient Name:",VETNAM,!!
 .K DIR,Y
 .S DIR(0)="Y",DIR("B")="YES"
 .S DIR("A")="Would you like to continue this merge using "_VETNAM
 .S DIR("?",1)="Answer 'YES' if you would like to continue the merge process"
 .S DIR("?",2)="using the displayed patient.  This will merge all duplicate"
 .S DIR("?")="Patient Relations associated with the selected patient."
 .D ^DIR Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))
 .I 'Y K DFN Q
 .S Y=DFN
 S DFN=+Y
 S MSG=$$CHKRELAT^EASXDR1(DFN,DFN,0)
 I 'MSG W !?2,"No Patient Relation entries were merged for this patient.",!! G OPTION
 W !?2,+MSG_" Patient Relation "_$S(+MSG=1:"entry was",1:"entries were")_" successfully merged."
 W !!?2,"Data deleted during this merge will be stored for 10 days"
 W !?2,"in the following global: ^XTMP(""EASXDR1"",""DATA"","_DFN_")",!!
 G OPTION
 Q
CHGACT(MRGFRIEN,MRGTOIEN,EFFDT) ;
 N DIE,DIR,DIRUT,DTOUT,DUOUT,DIROUT,DIC,DA,DR,DIQ,X,Y,SSNFR,SSNTO
 N ACTIVE
 ; display data about each record
 D FINDSSN(MRGFRIEN,.SSNFR),FINDSSN(MRGTOIEN,.SSNTO)
 W:SSNFR'="" !!,"SSN:"_SSNFR
 S DIC="^DGPR(408.12,",DA=MRGFRIEN,DIQ(0)="R" D EN^DIQ
 W:SSNTO'="" !,"SSN:"_SSNTO
 S DIC="^DGPR(408.12,",DA=MRGTOIEN,DIQ(0)="R" D EN^DIQ
 ; ask user to enter the correct active flag for this date
 S DIR(0)="Y"
 S DIR("A")="Should the active flag be 'YES' or 'NO' for "_$$FMTE^XLFDT($G(EFFDT))
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q
 S ACTIVE=Y
 N IEN12,SUBIEN,ACTROOT,FDA,DIERR
 F IEN12=MRGFRIEN,MRGTOIEN D
 .S ACTROOT="^DGPR(408.12,"_IEN12_",""E"")"
 .S SUBIEN=""
 .Q:'$D(@ACTROOT@("B",EFFDT))
 .F  S SUBIEN=$O(@ACTROOT@("B",EFFDT,SUBIEN)) Q:'SUBIEN  D
 ..I $P($G(@ACTROOT@(SUBIEN,0)),"^",2)=ACTIVE Q
 ..S FDA(408.1275,SUBIEN_","_IEN12_",",.02)=ACTIVE
 ..D FILE^DIE("K","FDA","DIERR")
 ; update arrays
 K ^TMP($J,"EASXDR"),ERROR
 M ^TMP($J,"EASXDR","MRGTO",MRGTOIEN)=^DGPR(408.12,MRGTOIEN)
 M ^TMP($J,"EASXDR","MRGFR",MRGFRIEN)=^DGPR(408.12,MRGFRIEN)
 ;D LOOP^EASXDR1
 Q
FINDSSN(IEN40812,SSN) ;find SSN associated with Patient Relation entry
 N ROOT,NODE12,POINT
 S SSN="UNKNOWN"
 S NODE12=$G(^DGPR(408.12,IEN40812,0))
 S POINT=$P(NODE12,"^",3)
 S ROOT="^"_$P(POINT,";",2)_$P(POINT,";")_")"
 I '$D(@ROOT@(0)) Q
 S SSN=$P($G(@ROOT@(0)),"^",9)
 Q
DELETE ; entry point from 'Delete Duplicate MT/Copay Dependents' menu option
 N MSG,DTOUT,DUOUT,DIRUT,DIROUT,DA,DIR,DIC,X,Y,DFN,DGMSGF,SSN,VETNAM
 S DGMSGF=1
 S DIR(0)="408.12,.03"
 S DIR("A")="Select MT/Copay Dependent to be deleted"
 S DIR("?")="Select the SSN of the patient whose Patient Relation entries should be deleted."
 D ^DIR Q:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))
 S IEN12=$O(^DGPR(408.12,"C",Y,""))
 I 'IEN12 W !!?2,Y(0)," Cannot be deleted.  Please select a new entry.",! G DELETE
 S DIC="^DGPR(408.12,",DA=IEN12,DIQ(0)="R" D EN^DIQ
 K DIR,Y,DTOUT,DIROUT,DIRUT,DUOUT
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Would you like to PERMANENTLY DELETE this record"
 S DIR("?",1)="Answer 'YES' if you would like to continue the deletion process"
 S DIR("?",2)="using the displayed patient.  This process will permanently delete the"
 S DIR("?")="408.13, 408.21, and 408.22 file entries associated with the selected patient."
 D ^DIR
 G:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))!('Y) DELETE
 S MSG=$$REMOVE^EASXDR1(IEN12,"")
 I 'MSG W !?2,"No Patient Relation entries were deleted for this patient.",!! G DELETE
 W !?2,+MSG_" Patient Relation "_$S(+MSG=1:"entry was",1:"entries were")_" successfully deleted."
 W !!?2,"Data deleted during this process will be stored for 10 days"
 W !?2,"in the following global: ^XTMP(""EASXDR1"",""DATA"",""DELETE"",408.12,"_IEN12_")",!!
 G DELETE
 Q
