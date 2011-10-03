DGPFHLL ;ALB/RPM - PRF HL7 TRANSMISSION LOG API'S ; 3/6/03
 ;;5.3;Registration;**425,650**;Aug 13, 1993;Build 3
 ;
 Q
 ;
GETLOG(DGLIEN,DGPFL) ;retrieve a transmission log record
 ;
 ;  Input:
 ;    DGLIEN - IEN for PRF HL7 TRANSMISSION LOG (#26.17) file
 ;
 ;  Output:
 ;    Function value - 1 on success, 0 on failure
 ;    DGPFL - array of transmission data fields
 ;            Subscript   Field#
 ;            ----------  ------
 ;            "MSGID"     .01
 ;            "ASGNHIST"  .02
 ;            "TRANSDT"   .03
 ;            "MSGSTAT"   .04
 ;            "SITE"      .05
 ;            "ACKDT"     .06
 ;            "ERROR",n   .07
 ;
 N DGIENS  ;IEN string
 N DGFLDS  ;results array
 N DGECNT  ;error counter
 N DGERR   ;error arrary
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGLIEN)>0,$D(^DGPF(26.17,DGLIEN)) D
 . S DGIENS=DGLIEN_","
 . D GETS^DIQ(26.17,DGIENS,"**","IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . S DGRSLT=1
 . S DGPFL("MSGID")=$G(DGFLDS(26.17,DGIENS,.01,"I"))_U_$G(DGFLDS(26.17,DGIENS,.01,"E"))
 . S DGPFL("ASGNHIST")=$G(DGFLDS(26.17,DGIENS,.02,"I"))_U_$G(DGFLDS(26.17,DGIENS,.02,"E"))
 . S DGPFL("TRANSDT")=$G(DGFLDS(26.17,DGIENS,.03,"I"))_U_$G(DGFLDS(26.17,DGIENS,.03,"E"))
 . S DGPFL("MSGSTAT")=$G(DGFLDS(26.17,DGIENS,.04,"I"))_U_$G(DGFLDS(26.17,DGIENS,.04,"E"))
 . S DGPFL("SITE")=$G(DGFLDS(26.17,DGIENS,.05,"I"))_U_$G(DGFLDS(26.17,DGIENS,.05,"E"))
 . S DGPFL("ACKDT")=$G(DGFLDS(26.17,DGIENS,.06,"I"))_U_$G(DGFLDS(26.17,DGIENS,.06,"E"))
 . ;
 . ;build error code array
 . S DGIENS="",DGECNT=0
 . F  S DGIENS=$O(DGFLDS(26.1707,DGIENS)) Q:DGIENS=""  D:$G(DGFLDS(26.1707,DGIENS,.01,"E"))]""
 . . S DGECNT=DGECNT+1
 . . S DGPFL("ERROR",DGECNT)=DGFLDS(26.1707,DGIENS,.01,"E")
 ;
 Q DGRSLT
 ;
GETQLOG(DGLIEN,DGPFL) ;retrieve a query log record
 ;
 ;  Input:
 ;    DGLIEN - IEN for PRF HL7 QUERY LOG (#26.19) file
 ;
 ;  Output:
 ;    Function value - 1 on success, 0 on failure
 ;    DGPFL - array of transmission data fields
 ;            Subscript  Field#
 ;            ---------  ------
 ;            "MSGID"    .01
 ;            "EVNT"     .02
 ;            "TRANSDT"  .03
 ;            "MSGSTAT"  .04
 ;            "SITE"     .05
 ;            "ACKDT"    .06
 ;            "ERROR",n  .07
 ;
 N DGIENS  ;IEN string
 N DGFLDS  ;results array
 N DGECNT  ;error counter
 N DGERR   ;error arrary
 N DGRSLT  ;function value
 ;
 S DGRSLT=0
 I $G(DGLIEN)>0,$D(^DGPF(26.19,DGLIEN)) D
 . S DGIENS=DGLIEN_","
 . D GETS^DIQ(26.19,DGIENS,"**","IEZ","DGFLDS","DGERR")
 . Q:$D(DGERR)
 . S DGRSLT=1
 . S DGPFL("MSGID")=$G(DGFLDS(26.19,DGIENS,.01,"I"))_U_$G(DGFLDS(26.19,DGIENS,.01,"E"))
 . S DGPFL("EVNT")=$G(DGFLDS(26.19,DGIENS,.02,"I"))_U_$G(DGFLDS(26.19,DGIENS,.02,"E"))
 . S DGPFL("TRANSDT")=$G(DGFLDS(26.19,DGIENS,.03,"I"))_U_$G(DGFLDS(26.19,DGIENS,.03,"E"))
 . S DGPFL("MSGSTAT")=$G(DGFLDS(26.19,DGIENS,.04,"I"))_U_$G(DGFLDS(26.19,DGIENS,.04,"E"))
 . S DGPFL("SITE")=$G(DGFLDS(26.19,DGIENS,.05,"I"))_U_$G(DGFLDS(26.19,DGIENS,.05,"E"))
 . S DGPFL("ACKDT")=$G(DGFLDS(26.19,DGIENS,.06,"I"))_U_$G(DGFLDS(26.19,DGIENS,.06,"E"))
 . ;
 . ;build error code array
 . S DGIENS="",DGECNT=0
 . F  S DGIENS=$O(DGFLDS(26.1907,DGIENS)) Q:DGIENS=""  D:$G(DGFLDS(26.1907,DGIENS,.01,"E"))]""
 . . S DGECNT=DGECNT+1
 . . S DGPFL("ERROR",DGECNT)=DGFLDS(26.1907,DGIENS,.01,"E")
 ;
 Q DGRSLT
 ;
FNDLOG(DGFILE,DGMSGID) ;find and return the record number from a given HL7
 ;                LOG file for a given HL7 Message ID
 ;
 ;  Input:
 ;     DGFILE - file number of HL7 log file
 ;    DGMSGID - HL7 Message ID
 ;
 ;  Output:
 ;   Function value - IEN of HL7 LOG file on success, 0 on failure
 ;
 N DGIEN  ;function value
 ;
 I +$G(DGFILE),+$G(DGMSGID) D
 . S DGIEN=$O(^DGPF(DGFILE,"B",DGMSGID,0))
 Q $S($G(DGIEN)>0:DGIEN,1:0)
 ;
STOXMIT(DGHIEN,DGMSGID,DGINST,DGERR) ;store the transmission log data
 ;
 ;  Input:
 ;     DGHIEN - pointer to PRF ASSIGNMENT HISTORY (#26.14) file
 ;    DGMSGID - message ID from VistA HL7
 ;     DGINST - pointer to the INSTITUTION (#4) file
 ;
 ;  Output:
 ;    DGERR - undefined on success, error message on failure
 ;
 N DGFDA     ;fda array
 N DGFDAIEN  ;UPDATE^DIE ien result
 ;
 I +$G(DGHIEN),$D(^DGPF(26.14,DGHIEN)),$D(DGMSGID),+$G(DGINST),$D(^DIC(4,DGINST)) D
 . Q:$$FNDLOG^DGPFHLL(26.17,DGMSGID)
 . S DGFDA(26.17,"+1,",.01)=DGMSGID
 . S DGFDA(26.17,"+1,",.02)=DGHIEN
 . S DGFDA(26.17,"+1,",.03)=$$NOW^XLFDT()
 . S DGFDA(26.17,"+1,",.04)="T"
 . S DGFDA(26.17,"+1,",.05)=DGINST
 . D UPDATE^DIE("","DGFDA","DGFDAIEN","DGERR")
 Q
 ;
STOQXMIT(DGEVNT,DGMSGID,DGINST,DGERR) ;store the query log data
 ;
 ;  Input:
 ;     DGEVNT - pointer to PRF event in PRF HL7 EVENT (#26.21) file
 ;    DGMSGID - message ID from VistA HL7
 ;     DGINST - pointer to the INSTITUTION (#4) file
 ;
 ;  Output:
 ;    DGERR - undefined on success, error message on failure
 ;
 N DGFDA     ;fda array
 N DGFDAIEN  ;UPDATE^DIE ien result
 ;
 I +$G(DGEVNT),$D(DGMSGID),+$G(DGINST),$D(^DIC(4,DGINST)) D
 . Q:$$FNDLOG^DGPFHLL(26.19,DGMSGID)
 . S DGFDA(26.19,"+1,",.01)=DGMSGID
 . S DGFDA(26.19,"+1,",.02)=DGEVNT
 . S DGFDA(26.19,"+1,",.03)=$$NOW^XLFDT()
 . S DGFDA(26.19,"+1,",.04)="T"
 . S DGFDA(26.19,"+1,",.05)=DGINST
 . D UPDATE^DIE("","DGFDA","DGFDAIEN","DGERR")
 Q
 ;
STOSTAT(DGFILE,DGLIEN,DGSTAT,DGEARR) ;update the HL7 transmission status
 ;
 ;  Input:
 ;    DGFILE - file number of HL7 LOG file
 ;    DGLIEN - IEN of selected HL7 LOG file
 ;    DGSTAT - internal Status value
 ;    DGEARR - (optional) array of error message codes
 ;                        format: DGEARR(n)=error code
 ;
 ;  Output:
 ;    none
 ;
 N DGERR    ;filer errors
 N DGFDA    ;fda array
 N DGI      ;generic index
 N DGLIENS  ;iens string
 ;
 I $G(DGFILE)]"",+$G(DGLIEN),$D(^DGPF(DGFILE,DGLIEN)),$G(DGSTAT)]"" D
 . Q:'$$TESTVAL^DGPFUT(DGFILE,.04,DGSTAT)
 . S DGLIENS=DGLIEN_","
 . S DGFDA(DGFILE,DGLIENS,.04)=DGSTAT
 . S DGFDA(DGFILE,DGLIENS,.06)=$$NOW^XLFDT()
 . S DGI=0
 . F  S DGI=$O(DGEARR(DGI)) Q:'DGI  I DGEARR(DGI)]"" D
 . . S DGFDA(DGFILE_"07","+"_DGI_","_DGLIEN_",",.01)=DGEARR(DGI)
 . D UPDATE^DIE("","DGFDA","","DGERR")
 Q
 ;
GETLSQ(DGEVNT) ;get last site queried
 ;
 ;  Input:
 ;    DGEVNT - pointer to PRF HL7 EVENT (#26.21) file
 ;
 ;  Output:
 ;   Function value - last site queried as pointer to INSTITUTION (#4)
 ;                    file on success; 0 on failure
 ;
 N DGARR   ;array of query sites sorted by date
 N DGLIEN  ;pointer to PRF HL7 QUERY LOG (#26.19)
 N DGLOG   ;query log data array
 ;
 S DGLIEN=0
 S DGEVNT=+$G(DGEVNT)
 F  S DGLIEN=$O(^DGPF(26.19,"C",DGEVNT,DGLIEN)) Q:'DGLIEN  D
 . K DGLOG
 . Q:'$$GETQLOG(DGLIEN,.DGLOG)
 . I +$G(DGLOG("TRANSDT"))>0,+$G(DGLOG("SITE"))>0 S DGARR(+$G(DGLOG("TRANSDT")))=+$G(DGLOG("SITE"))
 Q +$G(DGARR(+$O(DGARR(""),-1)))
 ;
PRGQLOG(DGEVNT) ;purge PRF Query Log entries
 ;This procedure purges non-Accepted entries in the PRF HL7 QUERY LOG
 ;(#26.19) file for a given PRF HL7 EVENT.
 ;
 ;  Input:
 ;    DGEVNT  - pointer to PRF HL7 EVENT (#26.21) file
 ;
 ;  Output:  none
 ;
 N DGERR   ;FM error array
 N DGFDA   ;FM FDA array
 N DGLIEN  ;PRF HL7 QUERY LOG (#26.19) file IEN
 N DGSTAT  ;transmission status
 ;
 S DGEVNT=+$G(DGEVNT)
 S DGLIEN=0
 ;
 F  S DGLIEN=$O(^DGPF(26.19,"C",DGEVNT,DGLIEN))  Q:'DGLIEN  D
 . K DGFDA,DGERR
 . S DGSTAT=$$GET1^DIQ(26.19,DGLIEN_",",.04,"I","","DGERR")
 . ;
 . Q:$E(DGSTAT)="A"  ;don't purge "A" or "AN" status entries
 . ;
 . S DGFDA(26.19,DGLIEN_",",.01)="@"
 . D FILE^DIE("","DGFDA","DGERR")
 ;
 Q
