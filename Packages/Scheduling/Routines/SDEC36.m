SDEC36 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;COLLECT WAITLIST FOR GIVEN RESOURCE - RPC
WAITLIST(SDECY,SDECRES) ;COLLECT WAITLIST DATA
 ;WAITLIST(SDECY,SDECRES)  external parameter tag in SDEC
 ;  .SDECY   = returned pointer to list of waitlist data
 ;   SDECRES = resource code - pointer to ^SDEC(409.831 (SDEC RESOURCE)
 ; called by SDEC WAITLIST remote procedure
 ;RETURN:
 ;Returns a Global Array in which each array entry contains wait list data separated by ^:
 ; 1. HOSPITAL_LOC_IEN
 ; 2. WAIT_LIST_IEN
 ; 3. PATIENT_IEN
 ; 4. PATIENT_NAME
 ; 5. HOME_PHONE
 ; 6. WORK_PHONE
 ; 7. CHART
 ; 8. DATE_ADDED
 ; 9. REASON
 ;10. PRIORITY
 ;11. PROVIDER
 ;12. RECALL_DATE
 ;13. COMMENT
 N SDECI,SDECNOD,SDECRESN,SDECSC,SDECTMP,BSDWL,SDECWLD,SDECWLN,CI,WL
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 ;                1                      2                   3                 4                  5
 S SDECTMP="I00020HOSPITAL_LOC_IEN^I00020WAIT_LIST_IEN^I00020PATIENT_IEN^T00030PATIENT_NAME^T00030HOME_PHONE^"
 ;                        6                7           8                9            10             11
 S SDECTMP=SDECTMP_"T00020WORK_PHONE^T00030CHART^D00020DATE_ADDED^T00030REASON^T00020PRIORITY^I00020PROVIDER^"
 ;                        12                13
 S SDECTMP=SDECTMP_"D00020RECALL_DATE^T00250COMMENT"_$C(30)
 S ^TMP("SDEC",$J,0)=SDECTMP_$C(31)
 Q   ;TODO - this is looking at ^BSDWL - needs to be changed to look at ^SDWL
 ;
ERROR ;
 D ERR("VISTA Error")
 Q
 ;
ERR(SDECERR) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30,31)
 Q
