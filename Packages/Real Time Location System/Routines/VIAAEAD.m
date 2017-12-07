VIAAEAD ;ALB/CR - RTLS Multiple RPCs for Engineering ;5/4/16 10:08am
 ;;1.0;RTLS;**3**;April 22, 2013;Build 20
 ;
 Q
 ; Access to file #6914 covered by IA #5913
 ; Access to file #6911 covered by IA #5914
 ; Access to file #6928 covered by IA #5915
 ; Access to file #6917 covered by IA #5916
 ; Access to file #6914.1 covered by IA #5917
 ; Access to file #6912 covered by IA #5918
 ; Access to file #6910 covered by IA #5920
 ;
EQMVUPD(RETSTA,AEMSID,ROOMNUM,TMSTMP) ; Equipment move into AEMS
 ; RPC [VIAA ENG ASSET MOVE]
 ;
 ; When equipment moves to a new location this function updates the
 ; following fields in file 6914:
 ; LOCATION (24)
 ; PHYSICAL INVENTORY DATE (23)
 ; 
 ; Input:
 ;   RETSTA is the name of the return array
 ;   AEMSID is equipment ID (IEN in 6914)
 ;   ROOMNUM is the room number for the location the equipment was
 ;   moved to
 ;   TMSTMP is timestamp in ISO format but time is optional
 ; Output:
 ;   "1^update successful" if update succeeds, otherwise
 ;   "-###^" concatenated with a failure message, where '###' is a 3-digit code
 ;
 I $G(AEMSID)="" S RETSTA(0)="-400^AEMS IEN not specified for look up in the EQUIPMENT INV. file, #6914" Q
 I '$D(^ENG(6914,"EE",AEMSID)) S RETSTA(0)="-404^AEMS IEN "_AEMSID_" was not found in the EQUIPMENT INV. file, #6914" Q
 I $G(ROOMNUM)="" S RETSTA(0)="-400^Room Number not specified for look up in the ENG SPACE file, #6928" Q
 I '$D(^ENG("SP","B",ROOMNUM)) S RETSTA(0)="-404^Room number "_ROOMNUM_" not found in the ENG SPACE file, #6928" Q
 I $G(TMSTMP)="" S RETSTA(0)="-400^Time Stamp of equipment move not specified" Q
 N FDA,ERR,RECCT,ROOMIEN
 K ^TMP("VIAADUP",$J)
 S RECCT=0
 ; if the room number is a duplicate in file #6928, reject the move and inform RTLS
 S ROOMIEN=0 F  S ROOMIEN=$O(^ENG("SP","B",ROOMNUM,ROOMIEN)) Q:'ROOMIEN  S ^TMP("VIAADUP",$J,ROOMIEN)="",RECCT=$G(RECCT)+1
 I $D(^TMP("VIAADUP",$J))&(RECCT>1) D  Q
 . S RETSTA(0)="-409^Move Failed - Duplicate Room Number ("_ROOMNUM_") Detected."
 . K ^TMP("VIAADUP",$J)
 ;
 ; convert timestamp from ISO format to FileMan internal format
 S TMSTMP=$$ISO2FM(TMSTMP)
 I TMSTMP=-1 S RETSTA(0)="-400^Time Stamp not valid" Q
 S AEMSID=$O(^ENG(6914,"EE",AEMSID,""))
 S ROOMIEN=+$O(^ENG("SP","B",ROOMNUM,""))
 ;
 S FDA(6914,AEMSID_",",23)=TMSTMP
 S FDA(6914,AEMSID_",",24)=ROOMIEN
 D UPDATE^DIE(,"FDA",,"ERR")
 I $D(ERR) S RETSTA(0)="-500^Update of EQUIPMENT INV. file, #6914, failed" Q
 S RETSTA(0)="1^Update of EQUIPMENT INV. file, #6914, successful"
 Q
 ;
RTLSDTEX(RETSTA,REQDATA,DATAID) ; Extract AEMS-RTLS DATA
 ; RPC [VIAA ENG GET DATA]
 ; 
 ; This RPC allows retrieval of one or all entries from the following
 ; files:
 ;   EQUIPMENT INV. (6914)
 ;   EQUIPMENT CATEGORY (6911)
 ;   ENG SPACE (6928) 
 ;  
 ; Input:
 ;   RETSTA is the name of the return array
 ;   REQDATA identifies the type of data that is required
 ;     "EQUIPMENT" for equipment
 ;     "CATEGORY" for categories
 ;     "LOCATION" for locations
 ;   DATAID identifies which data is to be returned for REQDATA
 ;     "ALL" for all data for a given REQDATA
 ;     AEMSID for individual equipment item
 ;     CATID for an individual category
 ;     LOCID (IEN) for an individual location
 ; Output:
 ;   Global ^TMP("VIAA"_REQDATA,$J)
 ;     Contains data for REQDATA and DATAID,
 ;     (if REQDATA="EQUIPMENT" and DATAID="ALL" 
 ;      then just AEMSIDs are returned)
 ;     otherwise
 ;     "-###^" concatenated with reason for failure message, where 
 ;     '###' is a 3-digit code
 ;
 ;
 N RNS
 S RNS="VIAA"_REQDATA
 I $G(REQDATA)="" S RNS="VIAAEQUIPMENT",^TMP(RNS,$J,0)="-400^REQDATA parameter not specified" D EX1 Q
 I $G(DATAID)="" S ^TMP(RNS,$J,0)="-400^DATA ID parameter not specified" D EX1 Q
 ;
 I ("^EQUIPMENT^CATEGORY^LOCATION^"'[("^"_REQDATA_"^")) D  Q
 . S ^TMP(RNS,$J,0)="-400^REQDATA parameter not recognized" D EX1
 ;
 ; scan appropriate file and save data in ^TMP
 K ^TMP(RNS,$J)
 I REQDATA="EQUIPMENT" D GETEQPD(REQDATA,DATAID)
 I REQDATA="CATEGORY" D GETCATD(REQDATA,DATAID)
 I REQDATA="LOCATION" D GETSPCD(REQDATA,DATAID)
 ; 
EX1 S RETSTA=$S($D(^TMP(RNS,$J)):$NA(^TMP(RNS,$J)),RETSTA'="":RETSTA,1:"-404^No data found")
 Q
 ;
GETEQPD(REQDATA,DATAID) ; get equipment data
 ;
 ; check that asset is on file if info for single asset requested
 I DATAID'="ALL",'$D(^ENG(6914,"EE",DATAID)) D  Q
 . S ^TMP(RNS,$J,0)="-404^AEMS IEN "_DATAID_" was not found in the EQUIPMENT INV. file, #6914"
 ;
 N RECCT
 S RECCT=0
 ; return info for a single asset
 I DATAID'="ALL" D  Q
 . D GETEQPD1(DATAID)
 ;
 ; return info for all assets 'IN USE'
 N AEMSID
 S AEMSID=""
 F  S AEMSID=$O(^ENG(6914,"EE",AEMSID)) Q:AEMSID=""  D
 . S EIEN=$O(^ENG(6914,"EE",AEMSID,""))
 . I $$GET1^DIQ(6914,EIEN,20,"I")'=1 Q
 . S RECCT=RECCT+1
 . S ^TMP(RNS,$J,RECCT,0)=AEMSID
 I RECCT=0 S ^TMP(RNS,$J,0)="-404^No data found"
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
GETEQPD1(AEMSID) ; get data for one item
 ;
 N EIEN,LOCID,MODEL,MANUF,CATDET,CATDET2,CATEG,SERNO,USESTAT,VALUE
 N ENTDAT,MOVDAT,EQNAM,CMRDESC,CMRPTR,SERVICE,CSTKNO,CSTKDESC,CSTKIEN
 N ACQDATE,CMRNAM,PASYST,DATA,FSYNON,DISPDATE
 N PURCHORD,RESPSHOP,TYPENTRY,SITEID,DEFSITE
 ;
 S EIEN=$O(^ENG(6914,"EE",AEMSID,"")) ; equipment IEN
 S LOCID=$$GET1^DIQ(6914,EIEN,24)     ; location
 S MANUF=$$GET1^DIQ(6914,EIEN,1)      ; manufacturer
 S PASYST=$$GET1^DIQ(6914,EIEN,2)     ; parent system
 S EQNAM=$$GET1^DIQ(6914,EIEN,3)      ; mfgr. equipment name
 S MODEL=$$GET1^DIQ(6914,EIEN,4)      ; model
 S SERNO=$$GET1^DIQ(6914,EIEN,5)      ; serial number
 ;
 ; use category IEN to get cat desc and first record of the synonym
 S CATEG=$$GET1^DIQ(6914,EIEN,6,"I")  ; equipment category ien
 I $G(CATEG)="" S CATDET="^" ; category does not exist in entry
 ; get category description and first synonym
 I CATEG]"" D
 . S CATDESC=$P($G(^ENG(6911,CATEG,0)),U)
 . S FSYNON=$P($G(^ENG(6911,CATEG,1,1,0)),U)
 . S CATDET=CATDESC_U_FSYNON
 . ; get the rest of synonyms (if any)
 . S CATDET2=$$SYN(CATEG)
 . S CATDET=CATDET_CATDET2 ; category description and all synonyms
 . I CATDET2="" S CATDET=CATDET_"" ; no synonym found
 ;
 S TYPENTRY=$$GET1^DIQ(6914,EIEN,7)    ; type of entry
 S PURCHORD=$$GET1^DIQ(6914,EIEN,11)   ; purchase order #
 S VALUE=$$GET1^DIQ(6914,EIEN,12)      ; asset value
 S ACQDATE=$$GET1^DIQ(6914,EIEN,13,"I")    ; acquisition date
 ;
 ; get category stock # and brief description
 S CSTKNO=$$GET1^DIQ(6914,EIEN,18)
 I $G(CSTKNO)="" S CSTKDESC=""
 I CSTKNO]"" D
 . S CSTKIEN=+$O(^ENCSN(6917,"B",CSTKNO,""))
 . S CSTKDESC=$$GET1^DIQ(6917,CSTKIEN,2,"E")
 ;
 S CMRPTR=$$GET1^DIQ(6914,EIEN,19,"I")          ; cmr pointer
 S CMRNAM=$$GET1^DIQ(6914.1,CMRPTR,.01)         ; cmr name
 I CMRPTR>0 S CMRDESC=$P($G(^ENG(6914.1,CMRPTR,0)),U,8)  ; brief description
 I '$D(CMRDESC) S CMRDESC=""
 S USESTAT=$$GET1^DIQ(6914,EIEN,20)        ; use status
 S SERVICE=$$GET1^DIQ(6914,EIEN,21)        ; service pointer
 S ENTDAT=$$GET1^DIQ(6914,EIEN,.6,"I") ; date asset entered in AEMS
 S MOVDAT=$$GET1^DIQ(6914,EIEN,23,"I") ; physical inventory date
 S RESPSHOP=$$GET1^DIQ(6914.04,"1,"_EIEN_",",.01) ; responsible shop
 S SITEID=$$GET1^DIQ(6914,EIEN,60)       ; station number for eqmt
 S DEFSITE=$$GET1^DIQ(6910,1,1,"I")      ; default station number
 S DISPDATE=$$GET1^DIQ(6914,EIEN,22,"I") ; disposition date
 S DATA=AEMSID_U_LOCID_U_MODEL_U_MANUF_U_CATDET_U_USESTAT
 S DATA=DATA_U_SERNO_U_VALUE_U_ENTDAT_U_MOVDAT_U_EQNAM_U_CMRDESC_U_CMRNAM ; added CMRNAM per VA change 9/23/13
 S DATA=DATA_U_SERVICE_U_CSTKNO_U_CSTKDESC_U_PASYST_U_TYPENTRY
 S DATA=DATA_U_PURCHORD_U_ACQDATE_U_RESPSHOP_U_SITEID_U_DEFSITE_U_DISPDATE
 S RECCT=RECCT+1
 S ^TMP(RNS,$J,RECCT,0)=DATA
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
GETCATD(REQDATA,DATAID) ; retrieve AEMS category data from file 6911
 ;
 ; if name is longer than 30 characters, use special handling
 N RECCT
 S RECCT=0
 I $L(DATAID)>30 D  Q
 . N DATAID1,EIEN
 . S DATAID1=$E(DATAID,1,30)
 . I '$D(^ENG(6911,"B",DATAID1)) S ^TMP(RNS,$J,0)="-404^"_DATAID_" was not found in the EQUIPMENT CATEGORY file, #6911" Q
 . F EIEN=0:0 S EIEN=$O(^ENG(6911,"B",DATAID1,EIEN)) Q:'EIEN  I $P(^ENG(6911,EIEN,0),"^",1)=DATAID S ^TMP(RNS,$J,RECCT+1,0)=EIEN_"^"_$P(^ENG(6911,EIEN,0),"^",1)
 ;
 ; check that asset is on file if info for single asset requested
 I DATAID'="ALL",'$D(^ENG(6911,"B",DATAID)) D  Q
 . S ^TMP(RNS,$J,0)="-404^"_DATAID_" is not a recognized category in the EQUIPMENT CATEGORY file, #6911"
 ;
 ; return info for a single category
 I DATAID'="ALL" D  Q
 . D GETCATD1(DATAID)
 ;
 ; return info for all categories
 N CATID
 F CATID=0:0 S CATID=$O(^ENG(6911,CATID)) Q:'CATID  D
 . S RECCT=RECCT+1
 . S CATDESC=$P($G(^ENG(6911,CATID,0)),U,1) ; category description
 . S DATA=CATID_U_CATDESC
 . S ^TMP(RNS,$J,RECCT,0)=CATID_U_CATDESC
 I RECCT=0 S ^TMP(RNS,$J,0)="-404^No data found"
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
GETCATD1(CATID) ; get data for one category
 N CIEN,DATA,CATDESC
 I '$D(^ENG(6911,"B",CATID)) S ^TMP(RNS,$J,0)="-404^"_CATID_" was not found in the EQUIPMENT CATEGORY file, #6911" Q
 S CIEN=$O(^ENG(6911,"B",CATID,""))
 S CATDESC=$P($G(^ENG(6911,CIEN,0)),U,1) ; category description
 S DATA=CIEN_U_CATDESC
 S RECCT=RECCT+1
 S ^TMP(RNS,$J,RECCT,0)=DATA
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
GETSPCD(REQDATA,DATAID) ; retrieve AEMS space/location data from file 6928
 ;
 ; check asset is on file if info for single space/location requested
 I DATAID'="ALL",'$D(^ENG("SP",DATAID)) D  Q
 . S ^TMP(RNS,$J,0)="-404^"_DATAID_" is not a recognized location in the ENG SPACE file, #6928"
 ;
 N RECCT
 S RECCT=0
 ; return info for a single space/location
 I DATAID'="ALL" D  Q
 . D GETSPCD1(DATAID)
 ;
 ; return info for all spaces/locations
 N LOCDESC ; location description
 S LOCDESC=""
 F  S LOCDESC=$O(^ENG("SP","B",LOCDESC)) Q:LOCDESC=""  D
 . D GETSPCD2(LOCDESC)
 I RECCT=0 S ^TMP(RNS,$J,0)="-404^No data found"
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
GETSPCD1(LOCID) ; get data for one location
 N DATA,LOCDESC
 I +LOCID=0 S ^TMP(RNS,$J,0)="-404^"_LOCID_" is not a valid Location ID in the ENG SPACE file, #6928" Q
 S LOCDESC=$P(^ENG("SP",LOCID,0),U,1)
 S DATA=LOCID_U_LOCDESC
 S RECCT=RECCT+1
 S ^TMP(RNS,$J,RECCT,0)=DATA
 S RETSTA=$NA(^TMP(RNS,$J))
 Q 
 ;
GETSPCD2(LOCDESC) ; get data for all locations
 N DATA,LOCIEN
 S LOCIEN=$O(^ENG("SP","B",LOCDESC,""))
 S DATA=LOCIEN_U_LOCDESC
 S RECCT=RECCT+1
 S ^TMP(RNS,$J,RECCT,0)=DATA
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
GETNEENS(RETSTA,AEMSID,NUMBER) ; Get a number of AEMSID's
 ;
 S AEMSID=$G(AEMSID)
 S NUMBER=$G(NUMBER,50)
 I NUMBER'=+NUMBER S RETSTA="Number must be numeric" Q
 S RNS="VIAAENR",REQDATA="EQUIPMENT"
 K ^TMP(RNS,$J)
 S RECCT=0
 F  S AEMSID=$O(^ENG(6914,"EE",AEMSID)) Q:AEMSID=""  Q:RECCT=NUMBER  D
 . S RECCT=RECCT+1
 . S ^TMP(RNS,$J,RECCT,0)=AEMSID
 I RECCT=0 S ^TMP(RNS,$J,0)="-404^No data found"
 S RETSTA=$NA(^TMP(RNS,$J))
 Q
 ;
EQSEED(RETSTA,AEMSID,LOCID,TMSTMP) ; RPC to save an equipment move into AEMS
 ; When equipment moves to a new location
 ; this function updates the following fields in file 6914:
 ; LOCATION
 ; 
 ; RETSTA is the name of the return array
 ; AEMSID is equipment ID (IEN in 6914)
 ; LOCID is the identity of the location at which the equipment is arriving
 ; TMSTMP is timestamp in ISO format
 ;
 S RETSTA=1
 I $G(AEMSID)="" S RETSTA="-400^AEMS ID "_AEMSID_" not specified for EQUIPMENT INV. file, #6914" Q
 I $G(LOCID)="" S RETSTA="-400^Location ID not specified for ENG SPACE file, #6928" Q
 I $G(TMSTMP)="" S RETSTA="-400^timestamp not specified" Q
 I '$D(^ENG(6914,"EE",AEMSID)) S RETSTA="-404^"_AEMSID_" AEMS IEN was not found in the EQUIPMENT INV. file, #6914" Q
 N FDA,ERR
 ; convert timestamp from ISO format to FileMan internal format
 S TMSTMP=$$ISO2FM(TMSTMP)
 S AEMSID=$O(^ENG(6914,"EE",AEMSID,""))
 ; need to establish LOCID format
 S FDA(6914,AEMSID_",",23)=TMSTMP
 S FDA(6914,AEMSID_",",24)=LOCID
 D UPDATE^DIE(,"FDA",,"ERR")
 I $D(ERR) S RETSTA="-500^update failed" Q
 S RETSTA="1^update successful"
 Q
 ;
ISO2FM(TMSTMP) ; External date to FM date
 ; incoming format yyyy-mm-dd<space>hh:MM:ss
 ; e.g. 2012-02-07 09:08:06
 N D,P,DTTM,DTTT
 S D="-",P="."
 ; first convert incoming date to an HL7 format
 S DTTT=$P(TMSTMP,D,4)
 S DTTM=$TR($P(TMSTMP,D,1,3),":- ")
 S $P(DTTM,D,2)=$E(10000+DTTT,2,5)
 ; then convert HL7 date to FM date
 S DTTM=$$HL7TFM^XLFDT(DTTM)
 Q DTTM
 ;
FM2ISO(DATE) ; convert FM date to ISO date
 N DTTM,D,P,C
 S C=":",D="-",P="."
 S DATE=$$FMTHL7^XLFDT(DATE)
 S DTTM=$E(DATE,1,4)_D_$E(DATE,5,6)_D_$E(DATE,7,8)
 S DTTM=DTTM_"T"
 S DTTM=DTTM_$E(DATE,9,10)_C_$E(DATE,11,12)_C_$E(DATE,13,14)_P_"000"
 S DTTM=DTTM_D_$E(DATE,16,17)_C_$E(DATE,18,19)
 Q DTTM
 ;
SYN(CATEG) ; get all synonyms for a given category in a piece of equipment
 N I,COUNT,RECDEL,SYNON
 S RECDEL="|" ; record delimiter
 ;
 S COUNT=+$P($G(^ENG(6911,CATEG,1,0)),U,4)
 I $G(COUNT)=0!($G(COUNT)=1) S CATDET2="" Q CATDET2  ; no synonyms found
 F I=2:1:COUNT D
 . S SYNON=$G(SYNON)_RECDEL_$P($G(^ENG(6911,CATEG,1,I,0)),U)
 S CATDET2=SYNON ; remaining category synonyms
 Q CATDET2
