DGRP11A ;ALB/LEG - REGISTRATION SCREEN 11.5/CAREGIVER ;Apr 05, 2020@16:48
 ;;5.3;Registration;**997,1014**;AUG 13, 1993;Build 42
 ;
 N DGCGTCNT,Z,DGRPS,DGRPW,DGCGRET,DGCOLL
 S DGRPS=11.5 D H^DGRPU
 ; call tag WW2 to display Group 1 to be selectable
 S (DGRPW,Z)=1 D WW2^DGRPV
 W " Caregiver Status Data: "
 ; note: see GET^VAFCREL definition details at bottom of routine
 D GET^VAFCREL(.DGCGRET,DFN)
 I +DGCGRET(0)=-1 W "(WARNING: MPI CONNECTION NOT AVAILABLE - Systems will",!,"be updated automatically when MPI is available. No further action needed to",!,"update.)" ;G CONT
 I +DGCGRET(0)'=-1 D  ; Get the number of Caregiver records in the array
 . S DGCGTCNT=$$MPICGCNT(.DGCGRET)
 . W "(",DGCGTCNT_$S(DGCGTCNT=1:" entry",1:" entries"),")"
 ;
 ;LEG; DG*5.3*1014; adding CCP Group 2
 ; Get flag for patient collateral eligibility
 S DGCOLL=$$CHKCOLL(DFN)
 ; DGRPVV is a globally used array for screen layout of groups as editable/not-editable
 ; Set Group 2 of screen 11.5 as <2> or [2] based on collateral flag
 S $E(DGRPVV(11.5),2)='DGCOLL
 S DGRPW=1,Z=2
 ; If collateral flag is TRUE, call tag WW2 to display Group [2] (always selectable)
 I DGCOLL D WW2^DGRPV
 ; otherwise call WW which will show Group as <2>
 I 'DGCOLL D WW^DGRPV
 W " Community Care Program (CCP) Collateral Data "
 ;
 G ^DGRPP
 Q
CHKCOLL(DFN) ; If patient Eligibility Codes include a COLLATERAL OF VET then return TRUE
 N DGI
 S DGI=$$FIND1^DIC(8,"","B","COLLATERAL OF VET")
 I $D(^DPT("AEL",DFN,DGI)) Q 1
 Q 0
MPICGCNT(DGCGRET) ; Return the number of CAREGIVER entries from MPI DGCGRET
 ; Input: DGCGRET - array of ALL returned records from MPI
 ; Return: DGCGNUM - number of CAREGIVER entries from MPI DGCGRET
 N DGCGNUM,DGI
 S DGCGNUM=0
 I +DGCGRET(0)=-1 Q -1 ;MPI error detection
 F DGI=1:1 Q:'$D(DGCGRET(DGI))  I "^CGG^CGP^CGS^"[(U_$P(DGCGRET(DGI),U,2)_U) D
 . ; Filter for RelationshipRoleCode = "FROM"
 . Q:$P(DGCGRET(DGI),U,4)'="FROM"
 . S DGCGNUM=DGCGNUM+1
 Q DGCGNUM
 ;
MPIGETCG(DGCGRET,DGCG,DGCGTCNT) ;Get array of CAREGIVER entries from MPI DGCGRET
 ; Inputs:
 ; DGCGRET - array of ALL returned records from MPI
 ; Ouputs:
 ; DGCG   - array of only Caregiver records from MPI
 ; DGCGTCNT   - total number of only Caregiver recs
 N DGI,DGJ,DGN,DGCGARR
 S DGCGTCNT=0
 I +DGCGRET(0)=-1 Q -1 ;MPI error detection
 ; Only want records that are RelationshipType for Caregiver 
 F DGI=1:1 Q:'$D(DGCGRET(DGI))  I "^CGG^CGP^CGS^"[(U_$P(DGCGRET(DGI),U,2)_U) D
 . ; Filter for RelationshipRoleCode = "FROM"
 . Q:$P(DGCGRET(DGI),U,4)'="FROM"
 . S DGCGTCNT=DGCGTCNT+1
 . S DGCGARR(DGCGTCNT)=DGCGRET(DGI)
 S DGCGARR(0)=DGCGRET(0)
 I $D(DGCGARR(1)) D MPISORT(.DGCGARR,.DGCG,7)
 Q
MPISORT(DGCGARRIN,DGCGARROUT,DGCGSORTPC) ; sorts the input array by data piece; default is 7=STATUS DATE, descending
 ; DGCGARRIN    - Input array of Caregiver data records to be sorted by Status Date
 ; DGCGARROUT   - Output array of Caregiver data records sorted by Status Date
 ; DGCGSORTPC   - Piece number of array data to sort by (Status Date) 
 ; DGCGARRTMP   - Intermediate array of Caregiver data being sorted by Status Date
 N DGCGARRTMP,DGCGCNT,DGI,DGL1,DGL2,DGX,DGCGDATAPC
 I '$D(DGCGSORTPC) S DGCGSORTPC=7
 ; ICN ^ RELTYP ^ RELTYPDISP ^ RCODE ^ RSTATUS ^ RSTATUSDISP ^ RSTATDATE ^ CGSPONSNAM
 S DGCGARROUT(0)=DGCGARRIN(0)
 F DGI=1:1:DGCGTCNT S DGX=DGCGARRIN(DGI),DGCGDATAPC=$P(DGX,U,DGCGSORTPC),DGCGARRTMP(DGCGDATAPC,DGI)=DGX
 S DGL1="",DGCGCNT=0
 F  S DGL1=$O(DGCGARRTMP(DGL1),-1),DGL2="" Q:DGL1=""  D
 . F  S DGL2=$O(DGCGARRTMP(DGL1,DGL2),-1) Q:DGL2=""  D
 .. S DGCGCNT=DGCGCNT+1,DGCGARROUT(DGCGCNT)=DGCGARRTMP(DGL1,DGL2)
 Q
 ;  ======GET^VAFCREL definition details=================================================================
 ; Call API: GET^VAFCREL(.RETURN,DFN) to get patient Relationship data in RETURN array 
 ;  Format of array:
 ;The RETURN(0) array will always be returned.
 ;RETURN(0)   - If relationships found for a given DFN, it will contain 1 in the 1st piece 
 ;              and "RELATIONSHIPS RETURNED" text in 2nd piece
 ;            - If no relationships are found for a given DFN, it will contain 0 in the 1st piece 
 ;              and "NO RELATIONSHIPS RETURNED" text in 2nd piece
 ;            - If error condition, it will contain -1 in the 1st piece and error message text in 2nd piece 
 ; RETURN(0)="1^RELATIONSHIPS RETURNED"
 ; RETURN(0)="0^NO RELATIONSHIPS RETURNED"
 ; RETURN(0)="-1^ERROR:Timeout Limit Reached"  *** note: timeout limit is 10 seconds  Possible error conditions
 ; RETURN(0)="-1^ERROR:Internal Error"
 ; RETURN(0)="-1^ERROR:Unknown ID"
 ; RETURN(1-n)- If relationships are found for a given DFN, it will contain the list of Relationships
 ;              in the following format:
 ;                  ICN^RelationshipType^RelationshipTypeDisplay^RelationshipRoleCode^RelationshipStatus
 ;                  ^RelationshipStatusDisplay^RelationshipStatusChangeDate^AssignedName
 ; RETURN(1)="1002345678V123456^CGP^CAREGIVER: PRIMARY^QUAL^ACTIVE^APPROVED^20200220^Jones, William M"
 ; RETURN(2)="1901234590V098766^CGS^CAREGIVER: SECONDARY^QUAL^ACTIVE^APPROVED^20200220^Jones, Donna"
 ; RETURN(3)="1002345678V123456^SONC^SON^QUAL^ACTIVE^ACTIVE^20200220^Jones, Mike"
 ; RETURN(4)="1901234590V098766^CGP^CAREGIVER: PRIMARY^QUAL^TERMINATED^BENEFIT END DATE^20170220^Jones, Donna"
 ; RETURN(5)="1007879802V000909^SPS^SPOUSE^QUAL^ACTIVE^ACTIVE^20120301^Jones, Donna"
 ; RETURN(6)="1089022222V123423^BRO^BROTHER^QUAL^ACTIVE^ACTIVE^20111202^Jones, Joseph"
 ;
