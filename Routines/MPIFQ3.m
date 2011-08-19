MPIFQ3 ;BIRM/CMC-QUERY LIST MANAGER FUNCTIONS ;APR 28, 2003
 ;;1.0; MASTER PATIENT INDEX VISTA ;**28,43,53**;30 Apr 99;Build 1
 ;
MSG(LOCSSN,LOCNAME,MPISSN,MPINAME,MPIDOB,LOCDOB) ;
 W !!!,"Local SSN = "_LOCSSN,?40,"MPI SSN = "_MPISSN
 W !,"Local NAME = "_LOCNAME,?40,"MPI NAME = "_MPINAME
 W !,"Local DATE OF BIRTH = "_LOCDOB,?40,"MPI DATE OF BIRTH = "_MPIDOB
 Q
MSG3 W !!,"Updating ICN and CMOR"
 Q
MSG1 W !!,"You are attempting to assign an ICN that has already been assigned",!,"to another patient in your Patient file."
 W !,"An exception will be recorded noting that these 2 patients ",!,"need to be reviewed to determine if they are duplicates."
 Q
MSG2 W !!,"You have selected a patient from the list of potential matches",!," where there is a difference found between your data and the MPI."
 W !," Are you sure this is the correct patient?"
 Q
MSG5 W !!,"No Action Taken"
 Q
MSG4 W !!,"When you reach the MPI QUERY RESULTS screen, the software has"
 W !,"queried the Master Patient Index, for possible matches to the patient"
 W !,"you are adding, or have selected (pre-existing record).",!!,"The MPI has returned a list of possible matches for that patient."
 W !,"An '*' indicates the Integration Control Number of a patient",!,"on the list already matches one in your PATIENT (#2) file."
 W !,"To select a patient from the list, choose SE."
 I '$D(MPIFDUP) W !,"If the patients listed as potential matches are not the same patient",!,"select NEW to create a new entry on the MPI for this patient."
 W !,"To view all data for a patient in the list of possible matches",!,"from the MPI, select MPI."
 W !,"To view additional data for a patient in the list of possible",!,"matches from the CMOR site, select CMR."
 I $D(MPIFDUP) D
 .W !,"If the patients listed as potential matches are not the same as"
 .W !,"your patient, there is nothing for you to do.  Therefore, you may",!,"wish to mark the exception as processed."
 Q
PROMPT ;
 W !!
 S DIR("A")="Hit the Enter key, to Continue ",DIR(0)="EA"
 D ^DIR K DIR(0),DIR("A")
 Q
PROMPT1() ;
 N DIR,X,Y
 W !
 S DIR("A")="Are you sure this is the correct patient? Enter YES or NO ",DIR(0)="YA"
 D ^DIR K DIR(0),DIR("A")
 Q Y
HERESSN(SSN) ;
 N DFN
 I $G(SSN)="" Q 0
 S DFN=$O(^DPT("SSN",SSN,0))
 Q:$G(DFN)']"" 0
 Q DFN
CHECK(DFN) ;
 N CHECK
 D GETDATA^MPIFQ0("^DPT(",DFN,"CHECK",".01;.02;.03;.09;.301;391;1901")
 I $G(CHECK(2,DFN,.01))']"" Q 0
 I $G(CHECK(2,DFN,.02))']"" Q 0
 I $G(CHECK(2,DFN,.03))']"" Q 0
 I $G(CHECK(2,DFN,.09))']"" Q 0
 I $G(CHECK(2,DFN,.301))']"" Q 0
 I $G(CHECK(2,DFN,391))']"" Q 0
 I $G(CHECK(2,DFN,1901))']"" Q 0
 Q 1
TF(DFN,ARR) ;Add you to TF list and trigger TF and Sub msgs
 I $$PATCH^XPDUTL("DG*5.3*261") D FILE^VAFCTFU(DFN,+$$SITE^VASITE,1)
 N RESLT
 S RESLT=$$A24^MPIFA24B(DFN)
 I +RESLT<0 D EXC^RGHLLOG(208,"Problem building A24 (ADD TF) for DFN= "_DFN,DFN)
 Q
 ;
A28(DFN) ;
 S ICN=$$A28^MPIFA28(DFN)
 I +ICN>0 I '$D(MPIFS) W:'$D(MPIFRPC) !!,"Message sent to MPI requesting Patient to be added."
 Q
LOCAL(DFN) ;
 Q:+$$GETICN^MPIF001(DFN)>0
 N ICN S ICN=$$ICNLC^MPIF001(DFN) ;don't assign local if exists
 Q
HEREICN(ICN) ;
 Q:$G(ICN)="" 0
 N DFN S DFN=$$GETDFN^MPIF001(+ICN)
 Q:$G(DFN)'>0 0
 Q DFN
LOC2(DFN) ;**53 MPIC_1853 The LOC2 module is obsolete and is no longer being called.
 ;W:'$D(MPIFRPC) !!,"Potential Match Found Assigning Local ICN"
 ;D START^RGHLLOG(),EXC^RGHLLOG(218,"For Patient DFN="_DFN_" Use Single Patient Initialization to MPI option to manually process",DFN),STOP^RGHLLOG()
 ;D LOCAL(DFN)
 Q
