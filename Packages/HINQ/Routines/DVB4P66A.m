DVB4P66A ;ALB/MJB/RC - DISABILITY FILE UPDATE ; 11/16/10 3:56pm
 ;;4.0;HINQ;**66**;03/25/92;Build 14
 ;
 ;This routine is the post-install driver that will map DISABILITY
 ;CONDITIONS in the DISABILITY CONDITION (#31) file with ICD
 ;DIAGNOSIS codes
 ;
 Q  ;no direct entry
 ;
POST(DVBTMP,DVBTOT) ;post-install driver for updating the (#31) file
 ;This procedure will call a series of routines that contain the data
 ;element values that will be used to update the VBA-ICD9 mapping.
 ;
 ;  Input:
 ;    DVBTMP - Closed Root global reference for error reporting
 ;    DVBTOT - Total number of ICD9 codes filed
 ;
 ;  Output:
 ;    DVBTMP - Temp file of error messages (if any)
 ;    DVBTOT - Total number of ICD9 codes filed
 ;
 N DVBRTN,DVBCNT
 S DVBTMP=$G(DVBTMP)
 S DVBTOT=$G(DVBTOT) I DVBTOT']"" S DVBTOT=0
 I DVBTMP']"" S DVBTMP=$NA(^TMP("DVB4P66",$J,"ADDICD")) K @DVBTMP
 ;
 ;loop each routine
 ;F DVBCNT=1:1:2 S DVBRTN="^DVB464P"_DVBCNT D
 ;. Q:($T(@DVBRTN)="")
 ;. D BLDXRF(DVBRTN,DVBTMP,.DVBTOT)
 D BLDXRF("DVB4P66A",DVBTMP,.DVBTOT)
 Q
 ;
 ;
BLDXRF(DVBRTN,DVBTMP,DVBTOT) ;call each routine to file VBA/ICD9 codes
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
 F DVBLN=1:1 S DVBTAG="TEXT+"_DVBLN_U_DVBRTN,DVBLINE=$T(@DVBTAG) S DVBVB=$P(DVBLINE,";",3,999) Q:DVBLINE["EXIT"  D
 .;get VBA DX CODE var setup
 .S DVBVBA=$P(DVBVB,"^",1)
 .;S DVBVBA=$P(DVBVB,"^",1),DVBLN=DVBLN+1
 .; - if code not found setup ^TMP() file error record
 .I '$O(^DIC(31,"C",DVBVBA,"")) D
 ..S @DVBTMP@("ERROR",DVBVBA)="DX CODE not found in (#31) file"
 ..S DVBVBA=0
 ..;
 .;quit back to loop if no VBA code ien found (just in case)
 .I 'DVBVBA Q
 .;
 .D BLDVBA(DVBVBA,DVBLINE,.DVBTOT)
 Q
 ;
 ;
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
 . . Q:$D(^DIC(31,DVBIEN,"ICD","B",DVBICDEN))  ;ICD9 already setup
 . . ;
 . . ;call to add multiple field (#20) RELATED ICD9 CODES
 . . I '$$FILEICD(DVBIEN,DVBICDEN,DVBMATCH) D  Q
 . . . S @DVBTMP@("ERROR",DVBVBA,DVBIEN,DVBICD)="error filing to (#31) file"
 . . S DVBTOT=DVBTOT+1
 Q
 ;
 ;
FILEICD(DVBIEN,DVBICDEN,DVBMATCH) ;file code mapping to (#31) file
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
 N DVBERR,DVBFDA,DVBRSLT,DIC,DIE,DA,DR
 S DVBRSLT=0
 ;
 I $G(DVBIEN),$G(DVBICDEN),$G(DVBMATCH)]"" D
 .S DA(1)=DVBIEN
 .S DA=$O(^DIC(31,DA(1),"ICD","B",DVBICDEN,0))
 .I DA'>0 D  Q:DA'>0
 ..W !!,"ADDING TO DISABILITY CODE "_DVBVBA_""
 ..W !!,"ADDING ICD CODE "_DVBICD_" TO MAPPING"
 ..S DIC="^DIC(31,"_DA(1)_",""ICD"",",DIC(0)="L",DIC("P")="31.01PA",DLAYGO=31.01
 ..S X=DVBICDEN
 ..K DD,DO D FILE^DICN
 ..S DA=+Y
 ..K DIC,DLAYGO,X,Y
 .;
 .S DIE="^DIC(31,"_DA(1)_",""ICD"","
 .S DR=".02///^S X=DVBMATCH"
 .D ^DIE
 .S:'$D(DVBERR) DVBRSLT=1
 Q DVBRSLT
 ;
 ; Fields :
 ; (#20) RELATED ICD9 CODES - ICD;0 POINTER Multiple (#31.01)
 ;   (#31.01) -- RELATED ICD9 CODES SUB-FILE
 ;    Field(s):
 ;    .01 RELATED ICD9 CODES - 0;1 POINTER TO ICD DIAGNOSIS FILE (#80)
 ;    .02 ICD9 MATCH - 0;2 SET ('0' FOR PARTIAL MATCH; '1' FOR MATCH;)
 ;
 ;The following TEXT lines are a combination of a single 4 digit VBA
 ;rated disabilities code and related ICD9 DIAGNOSIS code to be 
 ;mapped together.  Each IDC9 code also has a (1/0)
 ;match value that will be filed with it.
 ;
 ;DISABILITY CODE^ICDCODE^MATCH - FULL(1) OR PARTIAL(0)
TEXT ;
 ;;7705^287.41^1
 ;;7705^287.49^1
 ;;5238^724.03^0
 ;;7332^787.60^1
 ;;7332^787.61^1
 ;;7332^787.62^1
 ;;7332^787.63^1
 ;;8045^780.33^1
 ;;8861^389.9^1
 ;;8867^011.90^0
 ;;8882^352.9^0
 ;;8883^352.9^0
 ;;8884^352.9^0
 ;;8886^356.9^0
 ;;8887^356.9^0
 ;;8889^345.90^0
 ;;8892^298.9^1
 ;;8893^310.9^1
 ;;8894^300.9^1
 ;;8895^306.9^1
 ;;9007^298.9^1
 ;;EXIT
