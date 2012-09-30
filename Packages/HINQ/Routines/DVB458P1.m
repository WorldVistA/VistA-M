DVB458P1 ;ALB/RBS - POST-INSTALL FOR PATCH DVB*4*58 (CONT.) ; 4/24/07 3:53pm
 ;;4.0;HINQ;**58**;03/25/92;Build 29
 ;
 ;This routine is the main post-install driver that will update the
 ;DISABILITY CONDITION (#31) file with the new mapping of Rated
 ;Disabilities (VA) VBA DX CODES to specific ICD DIAGNOSIS codes.
 ;
 Q  ;no direct entry
 ;
POST(DVBTMP,DVBTOT) ;post-install driver for updating the (#31) file
 ;This procedure will call a series of routines that contain the data
 ;element values that will be used to create the new VBA-ICD9 mapping.
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
 I DVBTMP']"" S DVBTMP=$NA(^TMP("DVB458P",$J)) K @DVBTMP
 ;
 ;loop each routine
 F DVBCNT=1:1:6 S DVBRTN="^DVB458P"_DVBCNT D
 . Q:($T(@DVBRTN)="")
 . D BLDXRF(DVBRTN,DVBTMP,.DVBTOT)
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
 N DVBLN    ;line counter incrimenter
 N DVBTAG   ;line tag of routine to process
 N DVBVBA   ;VBA DX code (external value)
 ;
 S (DVBLN,DVBVBA)=0
 ;
 F  S DVBTAG="TEXT+"_DVBLN_DVBRTN,DVBLINE=$T(@DVBTAG) Q:DVBLINE["$EXIT"  D
 . ;get VBA DX CODE var setup
 . I DVBLINE'["~" D  Q
 . . S DVBVBA=$P(DVBLINE,";",3),DVBLN=DVBLN+1
 . . ; - if code not found setup ^TMP() file error record
 . . I '$O(^DIC(31,"C",DVBVBA,"")) D
 . . . S @DVBTMP@("ERROR",DVBVBA)="DX CODE not found in (#31) file"
 . . . S DVBVBA=0
 . ;
 . ;quit back to loop if no VBA code ien found (just in case)
 . I 'DVBVBA S DVBLN=DVBLN+1 Q
 . ;
 . D BLDVBA(DVBVBA,DVBLINE,.DVBTOT)
 . S DVBLN=DVBLN+1
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
 Q:$G(DVBLINE)']""
 ;
 N DVBDATA,DVBI,DVBICD,DVBICDEN,DVBIEN,DVBMATCH,DVBX
 ;
 ;loop in case there might be multiple VBA ien's setup
 S DVBIEN=0
 F  S DVBIEN=$O(^DIC(31,"C",DVBVBA,DVBIEN)) Q:DVBIEN=""  D
 . S DVBX=$P(DVBLINE,";",3,999)
 . S (DVBI,DVBICD)=0
 . F DVBI=1:1 S DVBDATA=$P(DVBX,"^",DVBI) Q:DVBDATA=""  D
 . . Q:DVBDATA[";"
 . . S DVBICD=$P(DVBDATA,"~"),DVBMATCH=+$P(DVBDATA,"~",2)
 . . ; - get ICD9 pointer from ICD DIAGNOSIS (#80) file
 . . S DVBICDEN=+$$ICDDX^ICDCODE(DVBICD)
 . . I ('DVBICDEN)!(DVBICDEN<0) D  Q
 . . . S @DVBTMP@("ERROR",DVBVBA,DVBIEN,DVBICD)="not found in ICD DIAGNOSIS (#80) file"
 . . ;
 . . Q:$D(^DIC(31,DVBIEN,"ICD","B",DVBICDEN))  ;ICD9 already setup
 . . ;
 . . ;call to create new multiple field (#20) RELATED ICD9 CODES
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
 ; New Fields created:
 ; (#20) RELATED ICD9 CODES - ICD;0 POINTER Multiple (#31.01)
 ;   (#31.01) -- RELATED ICD9 CODES SUB-FILE
 ;    Field(s):
 ;    .01 RELATED ICD9 CODES - 0;1 POINTER TO ICD DIAGNOSIS FILE (#80)
 ;    .02 ICD9 MATCH - 0;2 SET ('0' FOR PARTIAL MATCH; '1' FOR MATCH;)
 ;
 N DVBERR,DVBFDA,DVBRSLT
 S DVBRSLT=0
 ;
 I $G(DVBIEN),$G(DVBICDEN),$G(DVBMATCH)]"" D
 . K DVBFDA,DVBERR
 . S DVBFDA(31,"?+1,",.01)=DVBIEN
 . S DVBFDA(31.01,"+2,?+1,",.01)=DVBICDEN
 . S DVBFDA(31.01,"+2,?+1,",.02)=DVBMATCH
 . D UPDATE^DIE("","DVBFDA","","DVBERR")
 . S:'$D(DVBERR) DVBRSLT=1
 Q DVBRSLT
 ;
 ;
 ;FOR TESTING ONLY
DELETE ;delete (#20) field sub-file (#31.01) ICD9 entries
 ;
 N DVBIEN,CNT
 N DA,DIC,DIK,X,Y
 ;
 ;delete all ICD9 entries first
 S (CNT,DVBIEN)=0
 F  S DVBIEN=$O(^DIC(31,DVBIEN)) Q:DVBIEN=""  D
 . I $O(^DIC(31,DVBIEN,"ICD",0)) D
 . . S DA(1)=DVBIEN,DIK="^DIC(31,"_DA(1)_",""ICD"",",DA=0,CNT=CNT+1
 . . I CNT=1 D BMES^XPDUTL("  >>> *** Removing data from field #20 in the DISABILITY CONDITION (#31) file... "),MES^XPDUTL("  ")
 . . F  S DA=$O(^DIC(31,DA(1),"ICD",DA)) Q:'DA  D ^DIK
 . . ;
 . . ;now kill the (#20) RELATED ICD9 CODES field node
 . . I '$O(^DIC(31,DA(1),"ICD",0)) K ^DIC(31,DA(1),"ICD",0)
 Q
 ;
 ;
 ;NOTE:
 ;The DISABILITY CONDITION FILE (#31) will have a new multiple field
 ;added that will contain the Rated Disabilities (VA) field DX CODE
 ;mapping of a specific ICD9 diagnosis code and a Match code value.
 ;
 ; New Fields created:
 ; (#20) RELATED ICD9 CODES - ICD;0 POINTER Multiple (#31.01)
 ;   (#31.01) -- RELATED ICD9 CODES SUB-FILE
 ;    Field(s):
 ;    .01 RELATED ICD9 CODES - 0;1 POINTER TO ICD DIAGNOSIS FILE (#80)
 ;    .02 ICD9 MATCH - 0;2 SET ('0' FOR PARTIAL MATCH; '1' FOR MATCH;)
 ;
 ;The following TEXT lines are a combination of a single 4 digit VBA
 ;rated disabilities code (DX CODE) on one line followed by on the
 ;next sequential line(s), all of the related ICD9 DIAGNOSIS codes
 ;that are to be mapped together.  Each IDC9 code also has a (1/0)
 ;match value that will be filed with it.
 ;
 ;Example:
 ;   ;;5000  = a single (VBA) Rated Disabilities (VA) DX CODE
 ;   ;;003.24~1^376.03~1^730.00~1^... = string of ICD9 DIAGNOSIS CODES
 ;                                      (delimited by (^) up-arrow)
 ;   Each (^) piece contains 2 pieces of data delimited by (~):
 ;     $P(1) = a single ICD9 diagnosis code
 ;     $P(2) = (1/0) match code value
 ;
 ;   Note: If the TEXT line ends with a (;) semi-colon, this means the
 ;         next sequential line is associated with the same DX CODE.
 ;         (No sequential line(s) are carried over to the next
 ;          post-install Routine.)
 ;
TEXT ;;5000
 ;;003.24~0^376.03~0^730.00~0^730.01~0^730.02~0^730.03~0^730.04~0^730.05~0^730.06~0^730.07~0^730.08~0^730.09~1^730.10~0^730.11~0^730.12~0^730.13~0^730.14~0^730.15~0^730.16~0^730.17~0^730.18~0^730.19~1^;
 ;;730.20~0^730.21~0^730.22~0^730.23~0^730.24~0^730.25~0^730.26~0^730.27~0^730.28~0^730.29~1
 ;;5001
 ;;015.00~0^015.01~0^015.02~0^015.03~0^015.04~0^015.05~0^015.06~0^015.10~0^015.11~0^015.12~0^015.13~0^015.14~0^015.15~0^015.16~0^015.20~0^015.21~0^015.22~0^015.23~0^015.24~0^015.25~0^015.26~0^015.50~0^;
 ;;015.51~0^015.52~0^015.53~0^015.54~0^015.55~0^015.56~0^015.60~0^015.61~0^015.62~0^015.63~0^015.64~0^015.65~0^015.66~0^015.70~0^015.71~0^015.72~0^015.73~0^015.74~0^015.75~0^015.76~0^015.80~0^015.81~0^;
 ;;015.82~0^015.83~0^015.84~0^015.85~0^015.86~0^015.90~0^015.91~0^015.92~0^015.93~0^015.94~0^015.95~0^015.96~0
 ;;5002
 ;;714.0~0^714.1~0^714.2~0^714.30~0^714.31~0^714.32~0^714.33~0^714.4~0
 ;;5003
 ;;715.00~0^715.04~0^715.09~0^715.10~0^715.11~0^715.12~0^715.13~0^715.14~0^715.15~0^715.16~0^715.17~0^715.18~0^715.20~0^715.21~0^715.22~0^715.23~0^715.24~0^715.25~0^715.26~0^715.27~0^715.28~0^715.30~0^;
 ;;715.31~0^715.32~0^715.33~0^715.34~0^715.35~0^715.36~0^715.37~0^715.38~0^715.80~0^715.89~0^715.90~0^715.91~0^715.92~0^715.93~0^715.94~0^715.95~0^715.96~0^715.97~0^715.98~0
 ;;5004
 ;;098.50~0
 ;;$EXIT
