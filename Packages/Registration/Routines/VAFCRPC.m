VAFCRPC ;BIR/DLR-RPC ENTRY POINTS ; 8/11/10 6:18pm
 ;;5.3;Registration;**414,440,474,477,479,825,981**;Aug 13, 1993;Build 1
 ;;Routine uses the following supported IAs #2701 and #3027.
PDAT(RETURN,VALUE,SSN) ;remote pdat display
 ;'value' will pass in either an icn, ssn, dfn or patient name
 N ARRAY,DFN,ICN,NAME,SSN,VAFCSEN
 I $O(VALUE(""))="" S VALUE("ICN")=VALUE ;backwards compatibility - sites passing in an icn
 S ICN=$G(VALUE("ICN")) ;icn (local or national) passed in from mpi
 S NAME=$G(VALUE("NAME")) ;patient name passed in from mpi
 S SSN=$G(VALUE("SSN")) ;social security number passed in from mpi
 S DFN=$G(VALUE("DFN")) ;patient file ien passed in from mpi
 I $G(SSN)'="" S DFN=$O(^DPT("SSN",SSN,0)) I DFN="" S RETURN(1)="-1^Invalid SSN passed into RPC" Q
 I $G(ICN)'="" S DFN=$$GETDFN^MPIF001(ICN) I +DFN<0 S RETURN(1)="-1^Invalid ICN passed into RPC" Q  ;IA 2701
 I $G(NAME)'="" S DFN=$O(^DPT("B",NAME,0)) I DFN="" S RETURN(1)="-1^Invalid NAME passed into RPC" Q
 I $S('$G(DFN):1,'$D(^DPT(DFN,0)):1,1:0) S RETURN(1)="-1^Invalid DFN passed into RPC" Q
 ;log patient sensitivity on receiving system and send msg bulletin
 ;D NOTICE^DGSEC4(.VAFCSEN,DFN,"RPC - VAFC REMOTE AUDIT FROM THE MPI^Remote Audit Query",3) ;IA #3027
 S ARRAY="^TMP(""VAFCHFS"","_$J_")"
 D HFS^VAFCHFS("START^VAFCPDAT")
 ;M RETURN=@ARRAY
 D DSPPDAT^VAFCHFS(.RETURN)
 K ^TMP("VAFCHFS",$J)
 Q
 ;
AUDIT(RETURN,VALUE,SSN,SDT,EDT) ;remote audit display
 ;'value' will pass in either an icn, ssn, dfn or patient name
 N ARRAY,DFN,ICN,NAME,SSN,VAFCSEN
 S ICN=$G(VALUE("ICN")) ;icn (local or national) passed in
 S NAME=$G(VALUE("NAME")) ;patient name passed in
 S SSN=$G(VALUE("SSN")) ;social security number passed in
 S DFN=$G(VALUE("DFN")) ;patient file ien passed in
 I $G(SSN)'="" S DFN=$O(^DPT("SSN",SSN,0)) I DFN="" S RETURN(1)="-1^Invalid SSN passed into RPC" Q
 I $G(ICN)'="" S DFN=$$GETDFN^MPIF001(ICN) I +DFN<0 S RETURN(1)="-1^Invalid ICN passed into RPC" Q  ;IA 2701
 I $G(NAME)'="" S DFN=$O(^DPT("B",NAME,0)) I DFN="" S RETURN(1)="-1^Invalid NAME passed into RPC" Q
 I $S('$G(DFN):1,'$D(^DPT(DFN,0)):1,1:0) S RETURN(1)="-1^Invalid DFN passed into RPC" Q
 ;log patient sensitivity on receiving system and send msg bulletin
 ;D NOTICE^DGSEC4(.VAFCSEN,DFN,"RPC - VAFC REMOTE AUDIT FROM THE MPI^Remote Audit Query",3) ;IA #3027
 S ARRAY="^TMP(""VAFCHFS"","_$J_")"
 D HFS^VAFCHFS("START^VAFCAUD(DFN,SDT,EDT,1)")
 ;M RETURN=@ARRAY
 D DSPPDAT^VAFCHFS(.RETURN)
 K ^TMP("VAFCHFS",$J)
 Q
AAUPD(RETURN,ARRAA) ;Assigning authority update
 ;RPC: VAFC AA UPDATE
 S RETURN=$$ADD^VAFCAAUT(.ARRAA,.ERR)
 Q
 ;
 ;**128, Story 951754 (jfw) - Maintain EHRM MIGRATED FACILITIES File #391.919
 ;Input: ARRCRNR - List of Sites that have migrated to CERNER.
 ;       ie. ARRCRN(<Station#>)=""
 ;           ARRCRN(<Station#>)=""
 ;           etc..
 ;Output: 1 if successful else ERROR CODE ^ ERROR MESSAGE
UPDMFAC(RETURN,ARRCRNR) ;Update EHRM MIGRATED FACILITIES (#391.919) file
 ;RPC: VAFC MVI MGRTD FACILITIES UPDT
 ;MVI will remotely update the EHRM MIGRATED FACILITIES (#391.919) file
 ;with sites that have Migrated to using the CERNER application.
 D UPDT^VAFCCRNR(.ARRCRNR,.RETURN)
 Q
