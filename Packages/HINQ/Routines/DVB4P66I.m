DVB4P66I ;ALB/MJB/RC - DISABILITY FILE UPDATE ; 11/16/10 3:57pm
 ;;4.0;HINQ;**66**;03/25/92;Build 14
 ;
 ;This routine will delete ICD DIAGNOSIS mappings for DISABILITY
 ;CONDITIONS in the DISABILITY CONDITION (#31) file.
 ;
 Q  ;no direct entry
 ;
POST(DVBTMP,DVBTOT) ;post-install driver for updating the (#31) file
 ;This procedure will call a series of routines that contain the data
 ;element values that will be used to delete requested VBA-ICD9 mapping.
 ;
 ;  Input:
 ;    DVBTMP - Closed Root global reference for error reporting
 ;    DVBTOT - Total number of ICD9 codes filed
 ;
 ;  Output:
 ;    DVBTMP - Temp file of error messages (if any)
 ;    DVBTOT - Total number of ICD9 codes filed
 ;
 N DVBCNT
 S DVBTMP=$G(DVBTMP)
 S DVBTOT=$G(DVBTOT) I DVBTOT']"" S DVBTOT=0
 I DVBTMP']"" S DVBTMP=$NA(^TMP("DVB4P66",$J,"DELICD")) K @DVBTMP
 D BLDXRF(DVBTMP,.DVBTOT)
 ;
BLDXRF(DVBTMP,DVBTOT) ;call delete VBA/ICD9 codes
 ;
 ;  Input:
 ;    DVBRTN - Post Install routine to process VBA/ICD9 codes
 ;    DVBTMP - Closed Root global reference for error reporting
 ;    DVBTOT - Total number of ICD9 codes filed
 ;
 ;  Output:
 ;    DVBTOT - Total number of ICD9 codes filed
 ;
 N DVBLINE  ;$TEXT code line
 N DVBLN    ;line counter incrementer
 N DVBTAG   ;line tag of routine to process
 N DVBVBA   ;VBA DX code (external value)
 N DVBVB    ;DX CODE
 ;
 S (DVBLN,DVBVBA)=0
 ;
 F DVBLN=1:1 S DVBTAG="DELCODE+"_DVBLN,DVBLINE=$T(@DVBTAG) S DVBVB=$P(DVBLINE,";",3,999) Q:DVBLINE["EXIT"  D
 .;get VBA DX CODE var setup
 .S DVBVBA=$P(DVBVB,"^",1)
 .I '$O(^DIC(31,"C",DVBVBA,"")) D
 ..S @DVBTMP@("ERROR",DVBVBA)="DX CODE not found in (#31) file"
 ..S DVBVBA=0
 ..;
 .;quit back to loop if no VBA code ien found (just in case)
 .I 'DVBVBA Q
 .;
 .D BLDVBA(DVBVBA,DVBLINE,.DVBTOT)
 Q
 ; ;
BLDVBA(DVBVBA,DVBLINE,DVBTOT) ;extract ICD9 codes from text line
 ;
 ;  Input:
 ;    DVBVBA - VBA DX code (external value)
 ;   DVBLINE - $TEXT code line of ICD9's
 ;    DVBTOT - Total number of ICD9 codes filed
 ;
 ;  Output:
 ;    DVBTOT - Total number of ICD9 codes filed
 ;
 Q:'$G(DVBVBA)
 Q:$G(DVBLINE)'[";"
 ;
 N DVBDATA,DVBI,DVBICD,DVBICDEN,DVBIEN,DVBMATCH,DVBX
 ;
 ;loop in case there are multiple VBA iens setup
 I DVBVBA'="" S DVBIEN=0
 F  S DVBIEN=$O(^DIC(31,"C",DVBVBA,DVBIEN)) Q:DVBIEN=""  D
 . S DVBX=$P(DVBVB,"^",1)
 . S (DVBI,DVBICD)=0
 . F DVBI=1:1 S DVBDATA=$P(DVBX,"^",DVBI) Q:DVBDATA=""  D
 . . Q:DVBDATA[";"
 . . S DVBICD=$P(DVBVB,"^",2),DVBMATCH=+$P(DVBVB,"^",3)
 . . ; - get ICD9 pointer from ICD DIAGNOSIS (#80) file
 . . S DVBICDEN=+$$ICDDX^ICDCODE(DVBICD,DT)
 . . I 'DVBICDEN!(DVBICDEN<0)!(DVBICD=DVBICDEN) D  Q
 . . . S @DVBTMP@("ERROR",DVBVBA,DVBIEN,DVBICD)="not found in ICD DIAGNOSIS (#80) file"
 . . ;
 . . Q:'$D(^DIC(31,DVBIEN,"ICD","B",DVBICDEN))  ;
 . . ;
 . . I '$$FILEICD(DVBIEN,DVBICDEN,DVBMATCH) D  Q
 . . . S @DVBTMP@("ERROR",DVBVBA,DVBIEN,DVBICD)="error filing to (#31) file"
 . . S DVBTOT=DVBTOT+1
 Q
 ;
 ;
FILEICD(DVBIEN,DVBICDEN,DVBMATCH) ;file code mapping to delete icds from (#31) file
 ;
 ;  Input:
 ;    DVBIEN    - ien of VBA DX CODE in file (#31)
 ;    DVBICDEN  - ien of ICD9 code in file (#80)
 ;    DVBMATCH  - match code (1 or 0)
 ;
 ;  Output:
 ;    Function result - 1 on success, 0 on failure
 ;
 ; Fields :
 ; (#20) RELATED ICD9 CODES - ICD;0 POINTER Multiple (#31.01)
 ;   (#31.01) -- RELATED ICD9 CODES SUB-FILE
 ;    Field(s):
 ;    .01 RELATED ICD9 CODES - 0;1 POINTER TO ICD DIAGNOSIS FILE (#80)
 ;    .02 ICD9 MATCH - 0;2 SET ('0' FOR PARTIAL MATCH; '1' FOR MATCH;)
 ;
 N DVBERR,DVBFDA,DVBRSLT,DIK
 S DVBRSLT=0
 ;
 I $G(DVBIEN),$G(DVBICDEN),$G(DVBMATCH)]"" D
 .S DA(1)=DVBIEN
 .S DA=$O(^DIC(31,DA(1),"ICD","B",DVBICDEN,0)) Q:DA'>0  D
 ..W !!,"DELETING FROM DISABILITY CODE "_DVBVBA_""
 ..W !!,"DELETING ICD CODE "_DVBICD_" FROM MAPPING"
 ..;I DA'>0 D  Q:DA'>0
 ..S DIK="^DIC(31,"_DA(1)_",""ICD""," D ^DIK K DA
 .S:'$D(DVBERR) DVBRSLT=1
 Q DVBRSLT
 ;
 ;
 ;codes to be deleted
DELCODE ;DISABILITY CODE^ICDCODE
 ;;7705^287.4
 ;;7332^787.6
 ;;EXIT
 Q
