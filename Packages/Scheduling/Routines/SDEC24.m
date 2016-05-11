SDEC24 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
SEARCHAV(SDECY,SDECRES,SDECSTRT,SDECEND,SDECTYPES,SDECAMPM,SDECWKDY)  ;Searches availability database
 ;SEARCHAV(SDECY,SDECRES,SDECSTRT,SDECEND,SDECTYPES,SDECAMPM,SDECWKDY)  external parameter tag is in SDEC
 ;Searches availability database for availability blocks between
 ;     SDECSTRT and SDECEND for each of the resources in SDECRES.
 ;The av blocks must be one of the types in SDECTYPES, must be
 ;AM or PM depending on value in SDECAMPM and
 ;must be on one of the weekdays listed in SDECWKDY.
 ;
 ;Return recordset containing the start times of availability blocks
 ;meeting the search criteria.
 ;
 ;Variables:
 ;SDECRES |-Delimited list of resource names
 ;SDECSTRT FM-formatted beginning date of search
 ;SDECEND FM-Formatted ending date of search
 ;SDECTYPES |-Delimited list of access type IENs
 ;SDECAMPM "AM" for am-only, "PM" for pm-only, "BOTH" for both
 ;SDECWKDY "" if any weekday, else |-delimited list of weekdays
 ;
 ;NOTE: If SDECEND="" Then:
 ; either ONE record is returned matching the first available block
 ; -or- NO record is returned indicating no available block exists
 ;
 N %DT,SDEC,X,Y
 S X=SDECSTRT,%DT="X" D ^%DT S SDECSTRT=$P(Y,".")
 S:+SDECSTRT<0 SDECSTRT=DT
 S X=SDECEND,%DT="X" D ^%DT S SDECEND=$P(Y,".")
 S:+SDECEND<0 SDECEND=9990101
 S SDECEND=SDECEND_".99"
 N SDECRESN,SDECRESD,SDECDATE,SDECI,SDECABD,SDECNOD,SDECATD,SDECATN
 N SDAB,SDECTYPE
 S SDAB="^TMP("_$J_",""SDEC"",""BLKS"")"
 K @SDAB
 ;
 ;Set up access types array
 F SDEC=1:1:$L(SDECTYPES,"|") D
 . S SDECATD=$P(SDECTYPES,"|",SDEC)
 . S:+SDECATD SDEC(409.823,SDECATD)=""
 ;
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S ^TMP("SDEC",$J,0)="T00030RESOURCENAME^D00030DATE^T00030ACCESSTYPE^T00030COMMENT"_$C(30)
 F SDEC=1:1:$L(SDECRES,"|") S SDECRESN=$P(SDECRES,"|",SDEC) D
 . Q:'$D(^SDEC(409.831,"B",SDECRESN))
 . S SDECRESD=$O(^SDEC(409.831,"B",SDECRESN,0))
 . Q:'+SDECRESD
 . Q:'$D(^SDEC(409.831,SDECRESD,0))
 . D GETSLOTS^SDEC04(SDAB,SDECRESD,SDECSTRT,SDECEND)
 . Q:'$O(@SDAB@(0))  ;$D(^SDEC(409.821,"ARSCT",SDECRESD))
 . S SDECNOD=@SDAB@(1)
 . S SDECDATE=$P(SDECNOD,U,2)   ;$O(^SDEC(409.821,"ARSCT",SDECRESD,SDECSTRT))
 . Q:SDECDATE=""
 . Q:SDECDATE>SDECEND
 . ;TODO: Screen for AMPM
 . ;TODO: Screen for Weekday
 . ;
 . S SDECI=SDECI+1
 . ;S SDECABD=$O(^SDEC(409.821,"ARSCT",SDECRESD,SDECDATE,0))
 . ;S SDECNOD=$G(^SDEC(409.821,SDECABD,0))
 . Q:SDECNOD=""
 . S Y=$P(SDECDATE,".")
 . D DD^%DT
 . S SDECATD=$P(SDECNOD,U,5) ;ACCESS TYPE POINTER
 . S SDECATD=$G(^SDEC(409.823,+SDECATD,0))
 . S SDECATN=$P(SDECATD,U)
 . I +SDECATD,SDECTYPES]"" Q:'$D(SDEC(409.823,SDECATD))
 . ;TODO: Screen for TYPE ----DONE!
 . ;TODO: Comment
 . S ^TMP("SDEC",$J,SDECI)=SDECRESN_U_Y_U_SDECATN_U_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
