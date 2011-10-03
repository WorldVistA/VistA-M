SCMCTSK4 ;ALB/JDS - PCMM Inactivation Reports ; 18 Apr 2003  9:36 AM
 ;;5.3;Scheduling;**297,526**;AUG 13, 1993;Build 8
 Q
POSCHK ;
 N NAME S NAME=$P($G(^SD(403.46,+$P(INFO,U,3),0)),U)
 I "RESIDENT (PHYSICIAN)INTERN (PHYSICIAN)"[NAME S $P(DATA,U,3)=1 Q
 I "NURSE PRACTITIONERPHYSICIAN ASSISTANT"[NAME S $P(DATA,U,3)=2 Q
 I "PHYSICIAN-ATTENDINGPHYSICIAN-PRIMARY CARENURSE PRACTITIONERPHYSICIAN ASSISTANTPHYSICIAN-PSYCHIATRIST"[NAME D  Q
 .S $P(DATA,U,3)=3
 Q
DIOBEG ;
 N PG,DC
 N Y,% W @IOF,!,$G(SCDHD) D NOW^%DTC S Y=% W:$X>(IOM-40) ! W ?(IOM-40)
 W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12)
 W ?(IOM-15),"PAGE: 1"
 S Y="",$P(Y,"-",IOM)="" W !,Y,!!
 W ?(IOM/2-24),"**** Report Parameters Selected ****",!
 S SC="^TMP(""SC"",$J)"
 S X=$$PPAR^SCMCTSK8(.SC,.SCT)
 S (PG,DC)=1
 F  Q:$Y>(IOSL-3)  W !
 ;I IOST["C" W !! R SCX:DT I SCX[U S DIOUT=1
 Q
DIOEND ;print key
 N Y,% W @IOF,!,$G(SCDHD) D NOW^%DTC S Y=% W:$X>(IOM-40) ! W ?(IOM-40)
 W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12)
 W ?(IOM-15),"PAGE: "_($G(DC)+1)
 S Y="",$P(Y,"-",IOM)="" W !,Y,!!
 W !,"   REPORT KEY"
 W !,"   Field Name              Explanation of field name"
 W !,"   Patient Name            Name of patient scheduled to be inactivated from their primary care team and position/provider"
 W !,"   SSN                     Patient SSN."
 W !,"   PC Team                 Patient's assigned Primary Care team in PCMM."
 W !,"   Provider                Name of primary care practitioner/provider currently assigned to the patient.  This will be an"
 W !,"                           Associate PC Provider if the patient is assigned to an AP, or it will be a Primary Care Provider"
 W !,"                           (PCP) if the patient is not assigned to an Associate PC Provider (AP.)"
 W !,"   Team Position           The name of the team position to which the current practitioner/provider is assigned."
 W !,"   Institution/Division    Institution name, previously called Division, in which patient receives primary care."
 W !,"   Sched Date for Inactiva Date patient will be inactivated from PCMM and their Primary Care team and provider/position"
 W !,"                           panels. If the patient has a completed outpatient encounter with their current PCP or an"
 W !,"                           assigned AP before this date, the patient will not be inactivated.  If the patient's"
 W !,"                           inactivation date is extended for 60 days, with the PCMM Extend Patient's Inactivation Date"
 W !,"                           option, the patient's inactivation will not occur until the new extended date for inactivation."
 W !,"                           Note: There is a patient reassignment option, which allows an inactivated patient to be"
 W !,"                           reactivated to their previous Primary Care team and position if they return for care."
 W !,"   Next Appt Date          Patient is scheduled for an appointment on this date."
 W !,"                           May indicate patient wants to continue their assignment to their Primary Care team and provider."
 W !,"   Clinic for next Appt    The clinic in which the patient has their next scheduled appointment."
 Q
DIOEND1 ;print Key
 N Y,% W @IOF,!,$G(SCDHD) D NOW^%DTC S Y=% W:$X>(IOM-40) ! W ?(IOM-40)
 W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12)
 W ?(IOM-15),"PAGE: "_($G(DC)+1)
 S Y="",$P(Y,"-",IOM)="" W !,Y,!!
 W !,"  REPORT KEY"
 W !,"  Field Name              Explanation of field name"
 W !,"  Patient Name            Name of patient scheduled to be inactivated from their primary care team and position/provider."
 W !,"  SSN                     Patient SSN."
 W !,"  Institution             Institution name, previously called Division, in which patient receives primary care."
 W !,"  PC Team                 Patient's assigned Primary Care team in PCMM."
 W !,"  Provider/               Name of Primary Care practitioner/provider currently assigned to the patient."
 W !,"                          This may be an Associate PC Provider (AP,) if the patient is assigned to an AP, or"
 W !,"                          it may be a Primary Care Provider (PCP) if the patient is not assigned to an"
 W !,"                          Associate PC Provider (AP.)"
 W !,"  Team Position           The name of the team position to which the current provider is assigned."
 W !,"  Preceptor               Name of Preceptor/Primary Care Provider (PCP) if the patient is assigned to an Associate Provider."
 W !,"                          If this field is blank then the patient is assigned to a PCP, who displays in the Provider field."
 W !,"  Date Patient            Date patient was inactivated from PCMM and their Primary Care team and provider/position."
 W !,"   Inactivated            Note: There is a PCMM patient re-assignment option."
 W !,"  Reason Patient          Reason for patient's automated unassignment from their Primary Care team and provider/position."
 W !,"   Inactivated            No Appt The patient has been assigned to their current Primary Care Provider (PCP) for"
 W !,"                          12 months, and does not have a completed appointment encounter with their PCP or any assigned"
 W !,"                          Associated Primary Care Provider (AP) within those 12 months.  Therefore, they are considered"
 W !,"                          an inactive patient.  Alternatively, the patient has been assigned to their current PCP for at"
 W !,"                          least 12 months, and does not have a completed appointment encounter with their PCP or any"
 W !,"                          assigned Associated Primary Care Provider (AP) in the past 24 months. Therefore, they are"
 W !,"                          considered an inactive patient."
 W !,"                          Death - Patient's death, a date of death was entered in the Registration Package"
 Q
DIOEND2 ;print Key
