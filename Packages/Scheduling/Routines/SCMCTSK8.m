SCMCTSK8 ;;BP/DMR - PCMM INACTIVATION REPORTS ; 8/24/05 9:36am
 ;;5.3;Scheduling;**297**;AUG 13, 1993
 Q
FLAG ;
 IF FLDS="[SC PROVIDER FLAGGED]" D
 .W !,"PRIMARY CARE STAFF SCHEDULED FOR INACTIVATION"
 IF FLDS="[SC INACTIVATED]" D
 .W !,"PRIMARY CARE STAFF AUTOMATED INACTIVATIONS"
 W ?120,$E(DT,4,5)_"/"_$E(DT,6,7)_"/"_$E(DT,2,3)
 W !!,"This report is sorted by:"
 W !,"                                                           INSTITUTION"
 W !,"                                                           TEAM"
 W !,"                                                           PRACTITIONER"
 IF FLDS="[SC PROVIDER FLAGGED]" D
 .W !!,"WARNING- THE FOLLOWING PRIMARY CARE STAFF ARE SCHEDULED FOR AUTOMATED INACTIVATION FROM PCMM SOFTWARE UNLESS APPROPRIATE"
 .W !,"AND CONSISTENT ENTRIES ARE ENTERED IN THE NEW PERSON FILE AND THE TEAM POSITION FILE IN ACCORDANCE WITH PRIMARY CARE AND"
 .W !,"PCMM BUSINESS RULES IN VHA DIRECTIVE 2003-022.  (NOTE:  The staff's 'Person Class' is in the 'New Person' file, File #200,"
 .W !,"sub-file 8932.1 and field .01.  The staff person's 'Role' is entered in the PCMM GUI, in the 'Primary Care Position Setup'"
 .W !,"window on the 'Settings' tab.  'Role' is saved in the 'Team Position' file 404.57, 'Standard Role Name' field .03)."
 .W !,"Following entry of correct and consistent file entries, staff will be removed from this report the next time the staff"
 .W !,"inactivation routine runs, which is the last day of each month."
 IF FLDS="[SC INACTIVATED]" D
 .W !!,"WARNING- THE FOLLOWING PRIMARY CARE STAFF WERE AUTOMATICALLY INACTIVATED FROM THE PCMM SOFTWARE SINCE THEY DID NOT HAVE"
 .W !,"APPROPRIATE AND CONSISTENT 'PERSON CLASS' AND 'STANDARD ROLE' ENTRIES ACCORDING TO THE PRIMARY CARE BUSINESS RULES IN"
 .W !,"VHA DIRECTIVE 2003-022.  (The staff's 'Person Class' is in the 'New Person' file, #200, sub-file 8932.1, and field .01."
 .W !,"The staff's 'Role' is entered through the PCMM GUI software, 'Primary Care Position Setup' window on the 'Settings' tab."
 .W !,"'Role' is saved in the 'Team Position' file 404.57, 'Standard Role Name' field .03.) Following entry of correct and"
 .W !,"consistent file entries, staff may be re-assigned/re-activated to a primary care position in PCMM."
 W !!,"These are the Primary Care and PCMM business rules:"
 W !!,"1.)  Primary care providers and staff designated as Primary Care Providers (PCPs) in PCMM, that are not a Primary Care"
 W !,"physician (Medical Doctor or Doctor of Osteopathy) Nurse Practitioner (NP) or Physician Assistant (PA) will be"
 W !,"inactivated in the PCMM software."
 W !,"2.) Primary care providers and staff designated as Associate Primary Care Providers (APs,) that are not a Primary Care"
 W !,"Resident/Intern (Physician,) Nurse Practitioner (NP,) or Physician Assistant (PA,) will be inactivated in the PCMM software."
 W !,"3.) All staff, which are designated as a Primary Care Provider (PCP) or an Associate Primary Care Provider (AP) who do not"
 W !,"have an appropriate 'Person Class' entry consistent with their 'Standard Role Name' in VistA Fileman, will be"
 W !,"inactivated from their primary care position in PCMM software."
 IF FLDS="[SC PROVIDER FLAGGED]" D
 .W !,"4.) Staff inactivation's will occur six months after installation of this patch, SD*5.3*297."
 IF FLDS="[SC INACTIVATED]" D
 .W !,"4.) Staff inactivation's occurred six months after installation of this patch, SD*5.3*297."
 W !!,"Please contact the PCMM Coordinator or Information Systems (IRMS) department for assistance in resolving any problems."
 W @IOF
 Q
KEY W #
 W !,"Column                      Explanation"
 W !!,"Institution                 Institution name, previously called Division, in which provider sees primary care patients."
 W !,"PC Team                     Staff person's Primary Care team in PCMM software."
 W !,"Name                        Name of staff inactivated from their primary care position in PCMM software."
 W !,"Team Position               The name of the team position to which the staff was assigned."
 W !,"Associated Clinic           Associated Clinic(s) where provider saw primary care patients.  'Associated Clinics' display in the PCMM"
 W !,"                            GUI, 'Primary Care Position Setup' window, on the 'Associated Clinics' tab and are saved"
 W !,"                            in the Team Position file 404.575 and .01 field, 'Associated Clinics'."
 W !,"Role                        The function this position serves, as entered in PCMM GUI on the 'Primary Care Position Setup' window,"
 W !,"                            'General' tab and saved in the Team Position file 404.57, Standard Role Name field .03."
 W !,"                            Examples:  Physician, Nurse Practitioner, Resident, Intern, Social Worker, or Psychologist."
 W !,"Person Class                Nationally used clinician identifier for provider types from the New Person file #200, sub-file 8932.1,"
 W !,"                            and field .01, for example, Physicians (MD and DO)."
 IF FLDS="[SC INACTIVATED]" D
 .W !,"# Pts Unassigned            The number of primary care patients unassigned because of this staff's inactivation in PCMM. This number"
 .W !,"                            is the number viewed in the field, 'Patients for Position:  Actual', displayed in the PCMM GUI Primary"
 .W !,"                            Care Position Setup window on the Settings tab.  Use the 'PCMM Inconsistency Report' to see patients"
 .W !,"                            with a team assignment and no provider assignment."
 .W !,"Date Inactivated            The date this staff person was inactivated from their Primary Care position in the PCMM software, if"
 .W !,"                            their Role and Person Class remained inappropriate or inconsistent."
 IF FLDS="[SC PROVIDER FLAGGED]" D
 .W !,"# Pts Assigned              The number of primary care patients currently assigned to this provider's position.  This number,"
 .W !,"                            'Patients for Position:  Actual', displays in the PCMM GUI 'Primary Care Position Setup' window"
 .W !,"                            on the 'Settings' tab and is a count of the number of patients assigned to this provider position"
 .W !,"                            at the time of this report."
 .W !,"Scheduled Inactivate Date   Date staff will be inactivated from their Primary Care position in the PCMM software, if the staff's"
 .W !,"                            'Role' and 'Person Class' aren't appropriate and consistent with Primary Care business rules."
 W !,"Reason for Inconsistency/   The reason causing this primary care staff or provider's inactivation."
 W !,"Inactivation                Their 'Role' and 'Person Class' must be consistent and appropriate for their assignment in"
 W !,"                            PCMM.  Please refer to the Warning at the top of this report."
 W !,"                            'Role not=PC provider' means the 'Standard Role Name' entered in file 404.57, .03 is not a"
 W !,"                            valid role for this position to be a primary care provider.  For example, Social Workers,"
 W !,"                            Dietitians, Psychologists and others may not be indicated as providing primary care or be"
 W !,"                            AP's or PCP's in PCMM according to the Primary Care business rules in VHA Directives."
 W !,"                            'Person Class not valid' means this person's entry in the New Person file #200 is"
 W !,"                            not congruent with being the type of primary care provider entered in PCMM."
 W !,"                            For example, a Resident may not be a PCP in PCMM."
 W !,"Total                       Sums the number of patients who will be or were effected by practitioners inactivation's from PCMM."
 W !,"Count                       A total count of the number of staff positions scheduled for inactivation or were inactivated."
 Q
PPAR(SC,SCT)    ;Print Sort Display
 S X=$$PPAR^SCRPO(.SC,0,.SCT)
 I $O(^TMP("SCSORT",$J,""))']"" W !!," *** NO RECORDS TO PRINT ***",!!
 Q 1
