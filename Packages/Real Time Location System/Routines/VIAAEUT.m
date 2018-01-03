VIAAEUT ;ALB/CR - RTLS Get ENG Information ;5/4/16 9:59am
 ;;1.0;RTLS;**3**;April 22, 2013;Build 20
 ;
 ; Access to file #49 covered by IA #10093
 ; Access to file #6914 covered by IA #5913
 ; Access to file #6911 covered by IA #5914
 ; Access to file #6928 covered by IA #5915
 ;
 Q
 ; get all the categories from Engineering file #6911
GETCAT(RETSTA,REQDATA,DATAID) ;
 ; RPC [VIAA ENG GET CATEGORY]
 ;
 ; Input: all required
 ;   RETSTA is the name of the return array
 ;   REQDATA = keywords "CATEGORY" or "NAME" or "IEN" only
 ;   1) DATAID = "ALL" to return all category names
 ;   2) DATAID = name of the desired category
 ;   3) DATAID=  IEN (number) for the desired category
 ;
 ;   For all cases: return ien^name of category
 ;
 ; Output:
 ;   Global ^TMP("VIAA"_REQDATA,$J) returned via RETSTA which is used
 ;   as a reference, or if there is a failure
 ;   "-###^" concatenated with the reason for failure message, where
 ;   '###' is a 3-digit code
 ;
 N DATA,EIEN,ENCAT,RNS,RECCT
 S RNS="VIAA"_REQDATA
 ;
 I $G(REQDATA)=""&($G(DATAID)="") S RETSTA="-400^REQDATA and DATAID parameters are missing." D EX1 Q
 I $G(REQDATA)="" S RETSTA="-400^REQDATA parameter is null. Legal values are: CATEGORY, NAME, and IEN." D EX1 Q
 I $G(DATAID)="" S RETSTA="-400^DATAID is null. Legal values are: keyword 'ALL', a category name, or a number greater than zero." D EX1 Q
 ;
 I ("^CATEGORY^NAME^IEN^"'[("^"_REQDATA_"^")) D  Q
 . S RETSTA="-400^REQDATA parameter not recognized." D EX1
 ;
 I REQDATA="CATEGORY" D ALLCAT(REQDATA,DATAID)
 I REQDATA="NAME" D NAMECAT(REQDATA,DATAID)
 I REQDATA="IEN" D IENCAT(REQDATA,DATAID)
 ;
EX1 S RETSTA=$S($D(^TMP(RNS,$J)):$NA(^(0)),$D(RETSTA):RETSTA,1:"-404^No data found.")
 Q
 ;
 ;
ALLCAT(REQDATA,DATAID) ;
 ; return IENs and names for all equipment categories
 ;
 K ^TMP(RNS,$J)
 I DATAID'="ALL" S RETSTA="-400^"_DATAID_" is not valid to get all categories. Expected 'ALL'." Q
 S RECCT=0
 S ENCAT=""  ; engineering category
 F EIEN=0:0 S EIEN=$O(^ENG(6911,EIEN)) Q:EIEN'>0  D
 . S ENCAT=$$GET1^DIQ(6911,EIEN,.01,"E")
 . S RECCT=RECCT+1
 . S ^TMP(RNS,$J,RECCT,0)=EIEN_U_ENCAT
 I RECCT=0 S ^TMP(RNS,$J,0)="-404^No data found."
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
 ;
NAMECAT(REQDATA,DATAID) ;
 ; return IEN and name for one category name
 ;
 S RECCT=0
 K ^TMP(RNS,$J)
 ; if name passed is longer than 30 characters, use special handling
 I $L(DATAID)>30 D  Q
 . N DATAID1,EIEN
 . S DATAID1=$E(DATAID,1,30)
 . I '$D(^ENG(6911,"B",DATAID1)) S RETSTA="-404^"_DATAID_" was not found in the EQUIPMENT CATEGORY file, #6911." Q
 . F EIEN=0:0 S EIEN=$O(^ENG(6911,"B",DATAID1,EIEN)) Q:'EIEN  I $P(^ENG(6911,EIEN,0),"^",1)=DATAID S ^TMP(RNS,$J,RECCT+1,0)=EIEN_"^"_$P(^ENG(6911,EIEN,0),"^",1)
 ;
 I '$D(^ENG(6911,"B",DATAID)) S RETSTA="-404^"_DATAID_" was not found in the EQUIPMENT CATEGORY file, #6911." Q
 S EIEN=+$O(^ENG(6911,"B",DATAID,""))
 S ENCAT=$$GET1^DIQ(6911,EIEN,.01,"E")
 S RECCT=RECCT+1
 S ^TMP(RNS,$J,RECCT,0)=EIEN_U_ENCAT
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
 ;
IENCAT(REQDATA,DATAID) ;
 ; return IEN and name for one IEN category
 ;
 K ^TMP(RNS,$J)
 I +DATAID=0 S RETSTA="-400^DATAID cannot be zero for an IEN in the EQUIPMENT CATEGORY file, #6911." Q
 I DATAID<0 S RETSTA="-400^"_DATAID_" must be greater than zero for an IEN in the EQUIPMENT CATEGORY file, #6911." Q
 I '$D(^ENG(6911,DATAID)) S RETSTA="-404^"_DATAID_" was not found in the EQUIPMENT CATEGORY file, #6911." Q
 S RECCT=0
 S ENCAT=$$GET1^DIQ(6911,DATAID,.01,"E")
 S DATA=DATAID_U_ENCAT
 S RECCT=RECCT+1
 S ^TMP(RNS,$J,RECCT,0)=DATA
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
 ; get all locations from Engineering file #6928
GETLOC(RETSTA,REQDATA) ;
 ; RPC [VIAA ENG GET LOCATION]
 ;
 ; Input: all required
 ;  RETSTA is the return array
 ;  REQDATA is the key word "LOCATION" for all locations.
 ;
 ; Output:
 ;  Global ^TMP("VIAALOCATION",$J) - all available locations with the
 ;  following fields will be returned:
 ;  IEN, room number, building number, building file pointer,
 ;  division, wing, service, and inverse location
 ;
 N EIEN,ROOMN,BLDNUM,BLDPTR,DIV,SERV,SERVNAM,INVLOC,WING,RECCT,RNS
 S RNS="VIAALOCATION"
 K ^TMP(RNS,$J)
 I $G(REQDATA)="" S ^TMP(RNS,$J,0)="-400^Location cannot be null for look up in the SPACE file, #6928." D EX2 Q
 I REQDATA'="LOCATION" S ^TMP(RNS,$J,0)="-400^Keyword 'LOCATION' is missing." D EX2 Q
 S ROOMN="",RECCT=0
 F EIEN=0:0 S EIEN=$O(^ENG("SP",EIEN)) Q:EIEN'>0  D
 . S ROOMN=$$GET1^DIQ(6928,EIEN,.01,"E")           ; room number
 . S BLDNUM=$$GET1^DIQ(6928,EIEN,.5,"E")           ; building number
 . S BLDPTR=$$GET1^DIQ(6928,EIEN,.51,"I")          ; building pointer
 . S DIV=$$GET1^DIQ(6928,EIEN,.6,"E")              ; division
 . S WING=$$GET1^DIQ(6928,EIEN,1,"E")
 . S SERVNAM=$$GET1^DIQ(6928,EIEN,1.5,"E")         ; service name
 . S INVLOC=$$GET1^DIQ(6928,EIEN,19,"E")           ; inversed location
 . S RECCT=RECCT+1
 . S ^TMP(RNS,$J,RECCT,0)=EIEN_U_ROOMN_U_BLDNUM_U_BLDPTR_U_DIV_U_WING_U_SERVNAM_U_INVLOC
 I RECCT=0 S ^TMP(RNS,$J,0)="-404^No data found."
EX2 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
 ; get the latest entries from Engineering file #6914
LASTEE(RETSTA,REQDATA) ;
 ; RPC [VIAA ENG GET EQUIPMENT]
 ;
 ; Input: all required
 ;   RETSTA is the return array
 ;   REQDATA contains the latest stored EE number from InSites
 ;
 ; Output:
 ;   Global ^TMP("VIAALASTEE",$J) - list of most recent EE numbers
 ;   if available, otherwise an error message is sent back to client
 ;
 N EEDIF,I,LASTEE,RECCT,RNS
 S RNS="VIAALASTEE"
 K ^TMP(RNS,$J)
 S RECCT=0
 I $G(REQDATA)="" S ^TMP(RNS,$J,0)="-400^EE number cannot be null for look up in EQUIPMENT INV. file, #6914." D EX3 Q
 I (REQDATA'>0)!(REQDATA'?1N.10N) S ^TMP(RNS,$J,0)="-400^"_REQDATA_" is not a legal EE number in the EQUIPMENT INV. file, #6914." D EX3 Q
 I (REQDATA>9999999999)!(REQDATA<1)!(REQDATA?.E1"."1N.N) D  Q
 . S ^TMP(RNS,$J,0)="-400^"_REQDATA_" is not a legal EE number in the EQUIPMENT INV. file, #6914." D EX3
 I '$D(^ENG(6914,REQDATA)) S ^TMP(RNS,$J,0)="-404^EE number "_REQDATA_" was not found in the EQUIPMENT INV. file, #6914." D EX3 Q
 S LASTEE=$P(^ENG(6914,0),"^",3) ; last entry
 S EEDIF=LASTEE-REQDATA ; get # of new EE entries
 I EEDIF<0 S ^TMP(RNS,$J,0)="-404^EE number "_REQDATA_" was not found in the EQUIPMENT INV. file, #6914." D EX3 Q
 F I=1:1:EEDIF D
 . S REQDATA=REQDATA+1
 . S RECCT=RECCT+1
 . S ^TMP(RNS,$J,RECCT,0)=REQDATA
 I RECCT=0 S ^TMP(RNS,$J,0)="-404^No new EE entries found."
EX3 S RETSTA=$NA(^TMP(RNS,$J))
 Q
