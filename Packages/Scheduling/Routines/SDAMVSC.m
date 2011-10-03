SDAMVSC ;;OIFO-BAY PINES/TEH - Appt Event Driver Utilities-Validate SC Appt type ; 12/1/91 [ 09/19/96  1:39 PM ]  ; Compiled August 20, 2007 14:28:26
 ;;5.3;Scheduling;**394,417,491**;Aug 13, 1993;Build 53
 ;
 ;
 ;***************************************************************************************************************************
 ;
 ;                            ***** NOTE *****
 ;                                                   
 ;This software was created to be used with the SCHEDULING V5.3 appointment management package. The SRA API (SDAMA301)
 ;was employed to retrieve data from the PATIENT APPOINTMENT file (2.98) due inpart to VA Fileman non-compliance.
 ;
 ;DBIA #4433 SUBSCRIPTION 
 ;
 ;
 ;Entry Point EN. This routine requires the OUTPATIENT ENOUNTER IEN (variable SDOE)
 ;
 ;GLOBALS: ^SCE(IEN,0) (#.1) APPOINTMENT TYPE [10P:409.1]
 ;         ^DPT(IEN,"S",DATE,0)  ^ (#9.5) APPOINTMENT TYPE [16P:409.1]
 ;         ^SD(409.41,0)=OUTPATIENT CLASSIFCATION TYPE "Was treatment for SC Condition? " QUESTION FOR CHECKOUT.
 ;
 ;PROTOCOLS: This routine is called from the SDAM APPOINTMENT EVENTS.
 ;         
 ;This validates that both the OUTPATIENT ENCOUNTER and the PATIENT SCHEDULING NODES for APPOINTMENT TYPE are (pointer to
 ;409.1 APPOINTMENT TYPE) are set to the "SERVICE CONNECTED" appointment type when the response to the CLASSIFICATION TYPE
 ;"Was treatment for SC Condition?" question is answered "YES". If the question is answered "NO" and the APPOINTMENT TYPE
 ;is SERVICE CONNECTED, then the APPOINTMENT TYPE is reverted to REGULAR.
 ;
 ;
 ;****************************************************************************************************************************
 Q
EN ;Entry Point
 Q:'$G(SDOE)
 N SDN,SDVSCL,SDVSTD,SDAPDF,SDDPTYP,SDOED,SDVSTD,SDVDPTD,SDVSCD,SDSCV,SDAPPTY,SDAPDT,SDDFN,SDVSTD,SDIENS,SDARRAY,SDAPDF
 S SDOED=$G(^SCE(SDOE,0)) Q:SDOED=""
 S SDDFN=$P(SDOED,U,2),SDAPDT=$P(SDOED,U)
 ;GET APPOINTMENT FROM EVENT OUTPUT ARRAY
 I $G(^TMP("SDAMEVT",$J,"AFTER","DPT")) S SDAPDPT=$P($G(^TMP("SDAMEVT",$J,"AFTER","DPT")),"^",16)
 E  S SDAPDPT=$P(SDOED,"^",10) ;APP TYPE
 S SDVSCL=$P(SDOED,U,4)
 S SDVSTD=$P(SDOED,U,5)
 Q:'SDVSTD  ; ticket #194210 ; do not proceed if no pointer to a visit
 Q:'$D(^AUPNVSIT(SDVSTD,800))
 S SDSCV=+$$GET1^DIQ(9000010,SDVSTD_",",80001,"I") ;SC flag in Visit file
 S SDAPDF=$$GET1^DIQ(44,SDVSCL_",",2507,"I") ;default appt type
 ;find if credit stop secondary visit exists.
 N SDVSTDS,SDOE1 S SDOE1="" S SDVSTDS=$O(^AUPNVSIT("AD",SDVSTD,""))
 I SDVSTDS>0 S SDOE1=$O(^SCE("AVSIT",SDVSTDS,""))
 I SDSCV I SDAPDPT'=11 S SDAPDPT=11 D APPT F SDE=SDOE,SDOE1 I SDE>0 D SCE(SDE)
 I 'SDSCV I SDAPDPT=11 D  D APPT F SDE=SDOE,SDOE1 I SDE>0 D SCE(SDE)
 . I SDAPDF'="" S SDAPDPT=SDAPDF ; set to default if exists for this clinic
 . E  S SDAPDPT=9 ; set to regular
 Q
SCE(SDE) ;Set FDA for SCE(ien,0) OUTPATIENT ENCOUNTER
 S SDIENS=SDE_"," K ^TMP("SDAMSCE",$J)
 D FDA^DILF(409.68,SDIENS,.1,,SDAPDPT,"^TMP(""SDAMSCE"",$J)","^TMP(""SDAMSCE"",$J)")
 I $D(^TMP("SDAMSCE",$J,"DIERR")) D  Q
 .W !,"Processing Error ",^TMP("SDAMSCE",$J,"DIERR",1) Q
 D FILE^DIE(,"^TMP(""SDAMSCE"",$J)","^TMP(""SDAMSCE"",$J)")
 Q
APPT ;quit if clinic in event doesn't match clinic in ^DPT
 ;set up app type in DPT
 I +$G(^TMP("SDAMEVT",$J,"AFTER","DPT"))'=+$G(^DPT(SDDFN,"S",SDAPDT,0)) Q
 I $D(^DPT(SDDFN,"S",SDAPDT,0)) S $P(^DPT(SDDFN,"S",SDAPDT,0),U,16)=SDAPDPT
END Q
