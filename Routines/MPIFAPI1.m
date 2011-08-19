MPIFAPI1 ;CMC/BP-APIS FOR MPI - CONTINUED ;DEC 21, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**37,41**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;   ^DPT( - #2070 and #4079
 ;   ^DPT("AICN", ^DPT("AMPIMIS", ^DPT("ASCN2" - #2070
 ;   EXC, START, STOP^RGHLLOG - #2796
 ;
UPDATE(DFN,ARR,MPISILNT,REMOVE) ;api to edit 'mpi','mpifhis' and 'mpicmor' nodes
 ;**37 UPDATE module moved 3/30/05 from MPIFAPI into MPIFAPI1.
 ;
 ;DFN - patient IEN
 ;ARR - array in the format listed below
 ; MPI node by passing in ARR(field#)=value
 ;  **NOTE:  991.04 is only edited based on the edit of 991.01
 ;           991.03 should be passed with either "@" or IEN in File 4
 ; MPIFHIS node by passing ARR(992)=old ICN to remove from multiple
 ; MPICMOR node by passing ARR(993)=old CMOR to remove from multiple
 ;MPISILNT(optional) - 0 to not suppress exceptions (default)
 ;                     1 to suppress exceptions
 ;REMOVE (optional) - 0 default - use FM to delete MPI values
 ;    1 to delete outside FM the MPI fields -- should only be used to clean up the stub record's mpi data, including history for icn and cmor
 ;Returns : -1^error message if unable to update fields
 ;          0 if successfully updated fields
 ;
 N MPIRETN,MPIX,VALUE,ICN,SCN,ICN2,DFN2
 I DFN'>0 Q "-1^DFN passed into UPDATE^MPIFAPI not greater than 0"
 Q:'$D(^DPT(DFN,0)) "-1^DFN "_DFN_" does not exist"
 S MPIRETN=0,RGRSICN=""
 F  L +^DPT("MPI",DFN):10 Q:$T
 I $D(REMOVE) D CLEAN^MPIF002(DFN,.ARR,.MPIRETN) L -^DPT("MPI",DFN) Q MPIRETN
 I $D(@ARR@(991.01)) D
 .I '$D(@ARR@(991.02)) S MPIRETN="-1^ICN "_ICN_", passed without checksum" Q
 .;quit if local is going to overwrite national
 .S ICN=+$$GETICN^MPIF001(DFN) I ICN>0 I $E(@ARR@(991.01),1,3)=$P($$SITE^VASITE(),"^",3),$E(ICN,1,3)'=$E(@ARR@(991.01),1,3) S MPIRETN="-1^Overwriting the National ICN, "_ICN_", with a local, "_@ARR@(991.01)_", isn't allowed" Q
 .; quit if ICN has already been assigned to another patient in your data base
 .S ICN2=@ARR@(991.01)
 . S DFN2=$O(^DPT("AICN",ICN2,"")) I DFN2'="",'$D(^DPT(DFN2)) K ^DPT("AICN",ICN2)
 .;^ **41 CHECK IF THE DFN HOLDING THIS ICN IS RELATED TO BOGUS XREF
 .I $D(^DPT("AICN",ICN2)),DFN'=$O(^DPT("AICN",ICN2,"")) D
 ..I DFN'=($O(^DPT("AICN",ICN2,""))) D 
 ...N DFN2 S DFN2=$O(^DPT("AICN",ICN2,""))
 ...D TWODFNS^MPIF002(DFN2,DFN,ICN2)
 ..I $P($$SITE^VASITE(),"^",3)'=200 S MPIRETN="-1^ICN "_ICN2_" is already in use for pt DFN "_DFN ;;**37
 .Q:+MPIRETN=-1
 .K FDA S FDA(1,2,DFN_",",991.01)=@ARR@(991.01)
 .K MPIERR D FILE^DIE("E","FDA(1)","MPIERR") K FDA(1) I $D(MPIERR("DIERR")) S MPIRETN="-1^Unable to update pt's ICN (DFN="_DFN_") ICN to "_@ARR@(991.01)_" because "_MPIERR("DIERR",1,"TEXT",1)
 .I +MPIRETN'=0 Q
 .K FDA S FDA(1,2,DFN_",",991.02)=@ARR@(991.02)
 .K MPIERR D FILE^DIE("E","FDA(1)","MPIERR") K FDA(1) I $D(MPIERR("DIERR")) S MPIRETN="-1^Unable to update pt's ("_DFN_") ICN Checksum to "_@ARR@(991.02)_" because "_MPIERR("DIERR",1,"TEXT",1)
 .I +MPIRETN'=0 Q
 .K FDA S FDA(1,2,DFN_",",991.04)="@"
 .K MPIERR D FILE^DIE("E","FDA(1)","MPIERR") K FDA(1) I $D(MPIERR("DIERR")) S MPIRETN="-1^Unable to delete pt's ("_DFN_" LOCALLY ASSIGNED ICN field because "_MPIERR("DIERR",1,"TEXT",1)
 I MPIRETN=0 I $D(@ARR@(991.03)) D
 .I @ARR@(991.03)="@" K FDA S FDA(1,2,DFN_",",991.03)="@"
 .I @ARR@(991.03)'="@" I @ARR@(991.03)>0 I $$STA^XUAF4(@ARR@(991.03))'="" S FDA(1,2,DFN_",",991.03)="`"_@ARR@(991.03)
 .D FILE^DIE("E","FDA(1)","MPIERR") I $D(MPIERR("DIERR")) D
 ..S MPIRETN="-1^Unable to update pt's ("_DFN_") CMOR to "_@ARR@(991.03)_" because "_MPIERR("DIERR",1,"TEXT",1)
 ..I +$G(MPISILNT)=0 N RGLOG D START^RGHLLOG(0) D EXC^RGHLLOG(221,"Unable to update CMOR to "_@ARR@(991.03)_" for DFN="_DFN,DFN) D STOP^RGHLLOG(0)
 I MPIRETN=0 I $D(@ARR@(991.05)) D
 .I @ARR@(991.05)="@" D
 ..S SCN=$$SUBNUM^MPIFAPI(DFN),DA=SCN,DIK="^HLS(774," D ^DIK K DIK,DA ;**37
 ..S $P(^DPT(DFN,"MPI"),"^",5)=""
 ..K ^DPT("ASCN2",SCN,DFN)
 .I @ARR@(991.05)'="@" D
 ..;do edit and return result
 ..S DIE="^DPT(",DA=DFN,DR="991.05///^S X=@ARR@(991.05)" D ^DIE
 I MPIRETN=0 I $D(@ARR@(992)) D
 .;delete old value from history multiple
 .S MPIX=0 F  S MPIX=$O(^DPT(DFN,"MPIFHIS",MPIX)) Q:'MPIX  S VALUE=^DPT(DFN,"MPIFHIS",MPIX,0) I $P(VALUE,"^")=@ARR@(992) D
 ..K ^DPT("AICN",@ARR@(992),DFN),MPIERR,FDA
 ..S FDA(1,2.0992,MPIX_","_DFN_",",.01)="@" D FILE^DIE("","FDA(1)","MPIERR")
 ..I $D(MPIERR("DIERR")) S MPIRETN="-1^Unable to delete pt's ("_DFN_")  ICN "_@ARR@(992)_" from ICN HISTORY because "_MPIERR("DIERR",1,"TEXT",1) K MPIERR,FDA
 I MPIRETN=0 I $D(@ARR@(993)) D
 .;delete old value from history multiple
 .S MPIX=0 F  S MPIX=$O(^DPT(DFN,"MPICMOR",MPIX)) Q:'MPIX  S VALUE=^DPT(DFN,"MPICMOR",MPIX,0) I $P(VALUE,"^")=@ARR@(993) D
 ..K FDA,MPIERR S FDA(1,2.0993,MPIX_","_DFN_",",.01)="@" D FILE^DIE("","FDA(1)","MPIERR")
 ..I $D(MPIERR("DIERR")) S MPIRETN="-1^Unable to delete pt's ("_DFN_") CMOR "_@ARR@(993)_" from CMOR HISTORY because "_MPIERR("DIERR",1,"TEXT",1) K MPIERR,FDA
 K ^DPT("AMPIMIS",DFN),RGRSICN
 L -^DPT("MPI",DFN)
 Q MPIRETN
 ;
