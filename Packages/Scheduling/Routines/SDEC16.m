SDEC16 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
ADDRES(SDECY,SDECVAL) ;ADD/EDIT RESOURCE
 ;ADDRES(SDECY,SDECVAL)  external parameter tag is in SDEC
 ;Add/Edit SDEC RESOURCE entry
 ;INPUT:
 ;   SDECVAL - ResourceID|ResourceName|<NOT USED>|HospLocID|TIME_SCALE
 ;            |LETTER_TEXT|NO_SHOW_LETTER|CANCELLATION_LETTER
 ;            | INACTIVATEDDT | INACTIVATEDUSR | REACTIVATEDDT
 ;            | REACTIVATEDUSR | RESOURCETYPE | RESOURCETYPEIEN
 ;  1. ResourceID - (optional) Pointer to the SDEC RESOURCE file
 ;                         a new entry is added if IEN is 0
 ;  2. ResourceName - (required) Value put into the RESOURCE field
 ;                               of the SDEC RESOURCE file
 ;  3. NOT USED  INACTIVE This is 'computed' based on inactivation
 ;                        and reactivation fields
 ;  4. HospLocID - (required) Hospital Location ID - pointer to the
 ;                        HOSPITAL LOCATION file 44
 ;  5. TIME_SCALE - (optional) Value put into the TIME SCALE field
 ;                             of the SDEC RESOURCE file
 ;                         Allowed values: 5 10 15 20 30 60
 ;  6. LETTER_TEXT - (optional) Value converted to Word Processor and
 ;                            put into the LETTER TEXT field of the
 ;                            SDEC RESOURCE file
 ;  7. NO_SHOW_LETTER - (optional) Value converted to Word Processor
 ;                            and put into the NO SHOW LETTER field of
 ;                            the SDEC RESOURCE file
 ;  8. CANCELLATION_LETTER - (optional) Value converted to
 ;                            Word Processor and put into the CLINIC
 ;                                    CANCELLATION LETTER field
 ;                                    of the SDEC RESOURCE file
 ;  9. DATE/TIME     - (optional) DATE/TIME entered in external format
 ;                                Defaults to NOW.
 ; 10. ENTEREDBY     - (optional) Entered by User pointer to NEW PERSON
 ;                                Defaults to current user
 ; 11. INACTIVATEDDT - (optional) inactivated Date/Time external format
 ; 12. INACTIVATEDUSR- (optional) inactivating user pointer to
 ;                                NEW PERSON file
 ; 13. REACTIVATEDDT - (optional) reactivated Date/Time external format
 ; 14. REACTIVATEDUSR- (optional) reactivating user pointer to
 ;                                NEW PERSON file
 ; 15. RESOURCETYPE - (required) valid values are:
 ;                                H for HOSPITAL LOCATION (or clinic)
 ;                                P for NEW PERSON (Provider)
 ;                                A for ADDITIONAL RESOURCE
 ; 16. RESOURCETYPEIEN - (required) pointer to 1 of the following:
 ;                                HOSPITAL LOCATION file
 ;                                NEW PERSON file
 ;                                ADDITIONAL RESOURCE file
 ;RETURN:
 ; SDEC RESOURCE ien
 ;
 ;
 N SDECIENS,SDECFDA,SDECIEN,SDECMSG,SDEC,SDECINA,SDECNOTE,SDECNAM
 N SDEDT,SDEUSR,SDIDT,SDIUSR,SDRDT,SDRUSR,SDREST,SDRESTID
 N %DT,X,Y
 S SDECY="^TMP(""SDEC"","_$J_")"
 K ^TMP("SDEC",$J)
 S ^TMP("SDEC",$J,0)="I00020RESOURCEID^T00030ERRORTEXT"_$C(30)
 ; Changed following from a $G = "" to $D check: $G didn't work since SDECVAL is an array. MJL 10/18/2006
 I SDECVAL="",$D(SDECVAL)<2 D ERR(0,"SDEC16: Invalid null input Parameter") Q
 ;Unpack array at @XWBARY
 I SDECVAL="" D
 . N SDECC S SDECC=0 F  S SDECC=$O(SDECVAL(SDECC)) Q:'SDECC  D
 . . S SDECVAL=SDECVAL_SDECVAL(SDECC)
 ;validate ien
 S SDECIEN=$P(SDECVAL,"|")
 I SDECIEN'="" I '$D(^SDEC(409.831,+SDECIEN,0)) D ERR(0,"SDEC16: Invalid IEN "_SDECIEN) Q
 I +SDECIEN D
 . S SDEC="EDIT"
 . S SDECIENS=+SDECIEN_","
 E  D
 . S SDEC="ADD"
 . S SDECIENS="+1,"
 ;validate name
 S SDECNAM=$P(SDECVAL,"|",2)
 I SDEC="ADD",SDECNAM="" D ERR(0,"SDEC16: Resource Name is required.")
 ;Prevent adding entry with duplicate name
 I $D(^SDEC(409.831,"B",SDECNAM)),$O(^SDEC(409.831,"B",SDECNAM,0))'=SDECIEN D  Q
 . D ERR(0,"SDEC16: Cannot have two Resources with the same name.")
 . Q
 ;validate resource type (required)
 S SDREST=$P(SDECVAL,"|",15)
 S SDREST=$S(SDREST="H":"SC(",SDREST="P":"VA(200,",SDREST="A":"SDEC(409.834,",1:"")
 I SDEC="ADD",SDREST="" D ERR(0,"SDEC16: Invalid resource type "_$P(SDECVAL,"|",15)) Q
 ;validate resource type ID (required)
 S SDRESTID=$P(SDECVAL,"|",16)
 I SDEC="ADD" I '$D(@("^"_SDREST_+SDRESTID_",0)")) D ERR(0,"SDEC16: Invalid resource type ID "_$P(SDECVAL,"|",16)) Q
 ;validate date/time entered
 S SDEDT=$P(SDECVAL,"|",9),Y=""
 I SDEDT'="" S %DT="TX" S X=$G(SDEDT) D ^%DT S SDEDT=Y
 I Y=-1 D ERR(0,"SDEC16: Invalid date/time entered "_$P(SDECVAL,"|",9)) Q
 ;validate entered by user
 S SDEUSR=$P(SDECVAL,"|",10)
 I SDEUSR'="" I '$D(^VA(200,+SDEUSR,0)) D ERR(0,"SDEC16: Invalid entered by user id "_$P(SDECVAL,"|",10)) Q
 ;validate inactivation date
 S SDIDT=$P(SDECVAL,"|",11),Y=""
 I SDIDT'="" S %DT="TX" S X=$G(SDIDT) D ^%DT S SDIDT=Y
 I Y=-1 D ERR(0,"SDEC16: Invalid inactivation date "_$P(SDECVAL,"|",11)) Q
 ;validate inactivation user
 S SDIUSR=$P(SDECVAL,"|",12)
 I SDIUSR'="" I '$D(^VA(200,+SDIUSR,0)) D ERR(0,"SDEC16: Invalid inactivation user id "_$P(SDECVAL,"|",12)) Q
 ;validate reactivation date
 S SDRDT=$P(SDECVAL,"|",13),Y=""
 I SDRDT'="" S %DT="TX" S X=$G(SDRDT) D ^%DT S SDRDT=Y
 I Y=-1 D ERR(0,"SDEC16: Invalid reactivation date "_$P(SDECVAL,"|",13)) Q
 ;validate reactivation user
 S SDRUSR=$P(SDECVAL,"|",14)
 I SDRUSR'="" I '$D(^VA(200,+SDRUSR,0)) D ERR(0,"SDEC16: Invalid reactivation user id "_$P(SDECVAL,"|",14)) Q
 ;
 S:$P(SDECVAL,"|",2)'="" SDECFDA(409.831,SDECIENS,.01)=$P(SDECVAL,"|",2) ;NAME
 I SDRESTID'="",SDREST'="" S SDECFDA(409.831,SDECIENS,.012)=SDRESTID_";"_SDREST   ;resource type
 I SDEDT'="" S SDECFDA(409.831,SDECIENS,.015)=SDEDT
 I SDEUSR'="" S SDECFDA(409.831,SDECIENS,.016)=SDEUSR
 I SDIDT'="" S SDECFDA(409.831,SDECIENS,.021)=SDIDT S SDECFDA(409.831,SDECIENS,.025)=""
 I SDIUSR'="" S SDECFDA(409.831,SDECIENS,.022)=SDIUSR S SDECFDA(409.831,SDECIENS,.026)=""
 I SDRDT'="" S SDECFDA(409.831,SDECIENS,.025)=SDRDT
 I SDRUSR'="" S SDECFDA(409.831,SDECIENS,.026)=SDRUSR
 I +$P(SDECVAL,"|",5) S SDECFDA(409.831,SDECIENS,.03)=+$P(SDECVAL,"|",5) ;TIME SCALE
 I +$P(SDECVAL,"|",4) S SDECFDA(409.831,SDECIENS,.04)=$P(SDECVAL,"|",4) ;HOSPITAL LOCATION
 ;
 K SDECMSG
 I SDEC="ADD" D  ;TODO: Check for error
 . K SDECIEN
 . D UPDATE^DIE("","SDECFDA","SDECIEN","SDECMSG")
 . S SDECIEN=+$G(SDECIEN(1))
 E  D
 . D FILE^DIE("","SDECFDA","SDECMSG")
 ;
 I $P(SDECVAL,"|",2)="@" D RSRCDEL(SDECIEN) G RSRCX
 ;LETTER TEXT wp field
 S SDECNOTE=$P(SDECVAL,"|",6)
 ;
 I SDECNOTE]"" S SDECNOTE(.5)=SDECNOTE,SDECNOTE=""
 I $D(SDECNOTE(0)) S SDECNOTE(.5)=SDECNOTE(0) K SDECNOTE(0)
 ;
 I $D(SDECNOTE(.5)) D
 . D WP^DIE(409.831,SDECIEN_",",1,"","SDECNOTE","SDECMSG")
 ;
 ;NO SHOW LETTER wp fields
 K SDECNOTE
 S SDECNOTE=$P(SDECVAL,"|",7)
 ;
 I SDECNOTE]"" S SDECNOTE(.5)=SDECNOTE,SDECNOTE=""
 I $D(SDECNOTE(0)) S SDECNOTE(.5)=SDECNOTE(0) K SDECNOTE(0)
 ;
 I $D(SDECNOTE(.5)) D
 . D WP^DIE(409.831,SDECIEN_",",1201,"","SDECNOTE","SDECMSG")
 ;
 ;CANCELLATION LETTER wp field
 K SDECNOTE
 S SDECNOTE=$P(SDECVAL,"|",8)
 ;
 I SDECNOTE]"" S SDECNOTE(.5)=SDECNOTE,SDECNOTE=""
 I $D(SDECNOTE(0)) S SDECNOTE(.5)=SDECNOTE(0) K SDECNOTE(0)
 ;
 I $D(SDECNOTE(.5)) D
 . D WP^DIE(409.831,SDECIEN_",",1301,"","SDECNOTE","SDECMSG")
 I $$GET1^DIQ(409.831,SDECIEN_",",.02)="YES"   ;computed code calls RESDG^SDEC01B
RSRCX ;
 S ^TMP("SDEC",$J,1)=$G(SDECIEN)_"^"_$C(30)_$C(31)
 Q
 ;
RSRCDEL(SDECIEN)  ;delete resource from supporting files
 N SDECG,SDECH,SDECS,DA,DIE,DR
 ;remove SDEC RESOURCE from SDEC RESOURCE GROUP(s)
 S SDECG=""
 F  S SDECG=$O(^SDEC(409.832,"AB",SDECIEN,SDECG)) Q:SDECG=""  D
 . S SDECS=""
 . F  S SDECS=$O(^SDEC(409.832,"AB",SDECIEN,SDECG,SDECS)) Q:SDECS=""  D
 . . S DIE="^SDEC(409.832,"_SDECG_",1,"
 . . S DA=SDECS
 . . S DA(1)=SDECG
 . . S DR=".01///@"
 . . D ^DIE
 ;
 ;remove SDEC RESOURCE from SDEC RESOURCE USER(s)
 S SDECG=$O(^SDEC(409.833,"B",SDECIEN,"")) D
 .I SDECG'="" D
 ..S DIE=409.833
 ..S DA=SDECG
 ..S DR=".01///@"
 ..D ^DIE
 ;
 ;remove appointments that are linked to SDEC RESOURCE in the SDEC APPOINTMENT file
 S SDECG=""
 F  S SDECG=$O(^SDEC(409.84,"ARSRC",SDECIEN,SDECG)) Q:SDECG=""  D
 . S SDECH=""
 . S SDECH=$O(^SDEC(409.84,"ARSRC",SDECIEN,SDECG,SDECH)) Q:SDECH=""  D
 . . S DIE=409.84
 . . S DA=SDECH
 . . S DR=".01///@"
 . . D ^DIE
 ;
 Q
 ;
ERROR ;
 D ^%ZTER
 I '+$G(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(0,"SDEC16 Error")
 Q
 ;
ERR(SDECERID,ERRTXT) ;Error processing
 S:'+$G(SDECI) SDECI=999999
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERID_"^"_ERRTXT_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
