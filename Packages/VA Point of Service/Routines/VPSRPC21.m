VPSRPC21  ;;DALOI/KML,WOIFO/BT - Update of Patient Demographics RPC (Continue from VPSRPC2) ;11/20/11 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**2**;Oct 21, 2011;Build 41
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; ICR# 3618 - Postal Code and County Code APIs (Supported)
 Q
 ;
ADDRVAL(PTIEN,REC,REQLST,ILST,VRES) ; validate for required fields for address sets
 ; INPUT - all input parameters except PTIEN passed in by reference
 ;   PTIEN  = DFN
 ;   REC    = incremental number assigned to each subscript built in the OUTPUT array
 ;   REQLST = array to be used when validating the required address sets
 ;   ILST   = data passed in by Vecna (VPSLST array)
 ; OUTPUT 
 ;   VRES   = the array to return the results of ADDRESS validation processing.  Exceptions (only) made available as RPC output for client
 ;
 N OK,ER
 ; validate country and zip code for permanent address
 S OK=$$PERMVAL(.REQLST,.ILST,.ER)
 I 'OK D ADDERR(.REC,.VRES,.ER) ;Add errors to the result array
 I 'OK D CLRPERM(.REQLST,.ILST) ; did not pass validation; clear permanet address fields
 ;
 ; validate foreign/temporary address
 S OK=$$TEMPVAL(PTIEN,.REQLST,.ILST,.ER)
 I 'OK D ADDERR(.REC,.VRES,.ER) ;Add errors to the result array
 I 'OK D CLRTEMP(.REQLST,.ILST) ; did not pass validation; clear permanet address fields
 Q
 ;
PERMVAL(REQLST,ILST,ER) ;validate country and zip code for permanent address
 ; INPUT - all input parameters passed in by reference
 ;   REQLST = array to be used when validating the required address sets
 ;   ILST   = data passed in by Vecna (VPSLST array)
 ; OUTPUT
 ;   ER     = array of Error Message or Empty (No error)
 ; RETURN
 ;    1     = success
 ;    0     = failed
 ;
 ; country must exist. The cross reference validation will happen during filing
 K ER
 ; check if Vecna sent permanent address
 N PERM S PERM=0
 N FLD F FLD=.111,.114,.115,.117,.1112,.1173 I $P(REQLST(FLD),U,3)]"" S PERM=1 Q  ;determine if vecna sent permanent address fields
 Q:'PERM 1 ; permanent address fields not sent, no error
 ;
 ; country must exist to update permanent address fields
 N COUNTRY S COUNTRY=$P(REQLST(.1173),U,3) ;Country sent by Vecna
 I COUNTRY="" S ER(1)="COUNTRY is needed for PERMANENT address fields.  Write to Patient record for the ADDRESS fields did not get performed"
 Q:$D(ER) 0
 N USAADDR S USAADDR=(COUNTRY="USA")!(COUNTRY="UNITED STATES")!(COUNTRY?1N.N)
 Q:'USAADDR 1 ; no zip code validation for non US address
 ;
 ; Validate Zip Code. Changing City, County or State must be accompanied by Zip Code
 N ZIP S ZIP=$P(REQLST(.1112),U,3) ;Zip Code sent by Vecna
 I ZIP="" D CLRCCS(.REQLST,.ILST) ;if zip code was not sent, clear city, county, state from processing. This is to guard someone for entering invalid City/County/State
 Q:ZIP="" 1 ; no city,county,state update, no error
 ;
 N XIP D POSTALB^XIPUTIL(ZIP,.XIP) ;IA #3618 (Supported)
 I 'XIP S ER(1)=XIP("ERROR")_".  Write to Patient record for the ADDRESS fields did not get performed" ;can't find zipcode
 Q:'XIP 0
 ;
 ; validate city,county,state,country for the zipcode
 N CITY S CITY=$P(REQLST(.114),U,3)
 N STATE S STATE=$P(REQLST(.115),U,3)
 N COUNTY S COUNTY=$P(REQLST(.117),U,3)
 N EFLG S EFLG=$$GETZIP(CITY,COUNTY,STATE,.XIP,.ZIPIDX) ;get the index of XIP 
 I EFLG=-1 S ER(1)="Invalid STATE for the ZIPCODE of PERMANENT address.  Write to Patient record for the ADDRESS fields did not get performed"
 I EFLG=-2 S ER(1)="Cannot find DEFAULT CITY for the ZIPCODE OF PERMANENT address.  Write to Patient record for the ADDRESS fields did not get performed"
 I EFLG=1 D UPDZIP(ZIPIDX,.XIP,.REQLST,.ILST) ; Change city, county, state, country to match VistA
 ;
 Q '$D(ER)
 ;
GETZIP(CITY,COUNTY,STATE,XIP,ZIPIDX) ;get the index of XIP of permanent address
 ; INPUT
 ;   CITY   = City sent by VecNa
 ;   COUNTY = County sent by VecNa
 ;   STATE  = State sent by VecNa
 ;   XIP    = VistA Zip Code information in array (multiple entries could exist for a zipcode)
 ; OUTPUT
 ;   ZIPIDX = The selected Index of XIP containing the ZIP CODE information
 ; RETURN
 ;    0     = City, State, County, Country have perfect match between Vecna and Vista
 ;    1     = City/County/state/country doesn't match, require update
 ;   -1     = State sent by Vecna doesn't match VistA based on the ZipCode
 ;   -2     = Can't find default city for the zipcode
 ;
 N RET S RET=-2 ; can't find default address
 S ZIPIDX=0
 ;
 ; find the city in the XIP array
 N IDX F IDX=1:1:XIP I $$UP^XLFSTR($P(XIP(IDX,"CITY"),"*"))=$$UP^XLFSTR(CITY) S ZIPIDX=IDX Q
 ;
 ; if city found, use the index of the XIP as the result
 I ZIPIDX D  ; check other address fields
 . I $P(XIP(ZIPIDX,"CITY"),"*")=CITY,XIP(ZIPIDX,"STATE")=STATE,XIP(ZIPIDX,"COUNTY")=COUNTY S RET=0 Q  ;perfect match
 . I STATE]"",$$UP^XLFSTR(XIP(ZIPIDX,"STATE"))'=$$UP^XLFSTR(STATE) S RET=-1 Q  ;error out, state must match
 . S RET=1 ;require update
 ;
 ; if city not found, use the default address
 I 'ZIPIDX D
 . F IDX=1:1:XIP I XIP(IDX,"CITY KEY")=XIP(IDX,"PREFERRED CITY KEY") S ZIPIDX=IDX,RET=1 Q  ;require update
 . I ZIPIDX,STATE]"",$$UP^XLFSTR(XIP(ZIPIDX,"STATE"))'=$$UP^XLFSTR(STATE) S RET=-1 Q  ;error out, state must match
 ;
 Q RET
 ;
UPDZIP(ZIPIDX,XIP,REQLST,ILST) ; Change city, county, state, country of permanent address to match VistA
 ; INPUT
 ;   ZIPIDX = The selected Index of XIP containing the ZIP CODE information
 ;   XIP    = VistA Zip Code information in array (multiple entries could exist for a zipcode)
 ; OUTPUT
 ;   REQLST = array to be used when validating the required address sets - will be updated based on VistA ZIP Code
 ;   ILST   = data passed in by Vecna (VPSLST array) - will be updated based on VistA ZIP Code
 ;
 S $P(REQLST(.114),U,3)=$P(XIP(ZIPIDX,"CITY"),"*")
 S $P(REQLST(.115),U,3)=XIP(ZIPIDX,"STATE")
 S $P(REQLST(.117),U,3)=XIP(ZIPIDX,"COUNTY")
 ;
 N FLD
 F FLD=.114,.115,.117 D
 . N RECNO S RECNO=$P(REQLST(FLD),U)
 . I 'RECNO D
 . . S RECNO=$O(ILST(""),-1)+1
 . . S $P(REQLST(FLD),U)=RECNO
 . S ILST(RECNO)=$P(REQLST(FLD),U,2,3)
 Q
 ;
CLRPERM(REQLST,ILST) ;clear permanent address
 ; INPUT - all input parameters passed in by reference
 ;   REQLST = array to be used when validating the required address sets
 ; OUTPUT 
 ;   ILST   = data passed in by Vecna (VPSLST array) to be cleared so no update will happen
 ;
 N FLD,RECNO
 F FLD=.111,.112,.113,.114,.115,.117,.121,.1171,.1172,.1173,.1112 S RECNO=$P(REQLST(FLD),U) I RECNO]"" K ILST(RECNO) ; remove from input array so they are not processed for filing into patient record
 Q
 ;
CLRCCS(REQLST,ILST) ;clear zipcode, city, state, county from processing
 ; INPUT - all input parameters passed in by reference
 ;   REQLST = array to be used when validating the required address sets
 ; OUTPUT 
 ;   ILST   = data passed in by Vecna (VPSLST array) to be cleared so no update will happen
 ;
 N FLD,RECNO
 F FLD=.1112,.114,.115,.117 S RECNO=$P(REQLST(FLD),U) I RECNO]"" K ILST(RECNO) ; remove from input array so they are not processed for filing into patient record
 Q
 ;
ADDERR(REC,VRES,ER) ;Add error to the result array
 ; INPUT - all input parameters passed in by reference
 ;   ER     = Error Message to be returned to vecna
 ;   REC    = incremental number assigned to each subscript built in the OUTPUT array
 ; OUTPUT 
 ;   VRES   = the array to return the results of ADDRESS validation processing.  Exceptions (only) made available as RPC output for client
 ;
 N IDX S IDX=""
 F  S IDX=$O(ER(IDX)) Q:IDX=""  S REC=REC+1,VRES(REC)="^^99^"_ER(IDX)
 Q
 ;
TEMPVAL(PTIEN,REQLST,ILIST,ER) ; validate temporary address
 ; INPUT - all input parameters except PTIEN passed in by reference
 ;   PTIEN  = DFN
 ;   REQLST = array to be used when validating data
 ;   ILIST  = data passed in by Vecna (VPSLST array)
 ; OUTPUT 
 ;   ER     = array of Error Message or Empty (No error)
 ; RETURN
 ;    1     = success
 ;    0     = failed
 ;
 K ER
 N TEMP S TEMP=0
 ; check if Vecna sent temp address
 N NUM F NUM=.1211,.1214,.1215,.1217,.1218,.12111,.12112,.1223 Q:TEMP  I $P(REQLST(NUM),U,3)]"" S TEMP=1  ;determine if any required temp address fields are sent
 Q:'TEMP 1 ; temporary address fields not sent
 ;
 ; validate country fields
 N COUNTRY S COUNTRY=$P(REQLST(.1223),U,3)
 I COUNTRY="" S ER(1)=$P(REQLST(.1223),U,2)_" is needed for TEMPORARY (USA and FOREIGN) address fields.  Write to Patient record not performed"
 Q:COUNTRY="" 0
 ;
 ; validate temporarty address 
 N USAADDR S USAADDR=(COUNTRY="USA")!(COUNTRY="UNITED STATES")!(COUNTRY?1N.N)
 I USAADDR D USVAL(.REQLST,.ER) ;validate US Address
 I 'USAADDR D NONUSVAL(.REQLST,.ER) ; validate foreign address
 Q:$D(ER) 0
 ;
 ; update TEMPORARY ADDRESS ACTIVE? field to yes when all required TEMPORARY address fields (USA or FOREIGN) are submitted.
 N VPSFDA S VPSFDA(2,PTIEN_",",.12105)="Y"
 D FILE^DIE("","VPSFDA","")
 Q 1
 ;
USVAL(REQLST,ER) ;validate US Address
 ; INPUT - all input parameters except PTIEN passed in by reference
 ;   REQLST = array to be used when validating data
 ; OUTPUT 
 ;   ER     = array of Error Message or Empty (No error)
 ;
 N IDX S IDX=0
 ;
 ; validate required fields
 N FLD
 F FLD=.1211,.1214,.1215,.1217,.1218,.12111,.12112 I $P(REQLST(FLD),U,3)="" D
 . S IDX=IDX+1
 . S ER(IDX)=$P(REQLST(FLD),U,2)_" is needed for TEMPORARY (USA) address fields.  Write to Patient record for TEMPORARY ADDRESS fields did not get performed"
 Q
 ;
NONUSVAL(REQLST,ER) ; validate foreign address
 ; INPUT - all input parameters except PTIEN passed in by reference
 ;   REQLST = array to be used when validating data
 ; OUTPUT 
 ;   ER     = array of Error Message or Empty (No error)
 ;
 N IDX S IDX=0
 ;
 ; validate required fields
 N FLD
 F FLD=.1211,.1214,.1217,.1218 I $P(REQLST(FLD),U,3)="" D
 . S IDX=IDX+1
 . S ER(IDX)=$P(REQLST(FLD),U,2)_" is needed for TEMPORARY (foreign) address fields.  Write to Patient record not performed"
 Q
 ;
CLRTEMP(REQLST,ILST) ;clear temporary address
 ; INPUT - all input parameters passed in by reference
 ;   REQLST = array to be used when validating the required address sets
 ; OUTPUT 
 ;   ILST   = data passed in by Vecna (VPSLST array) to be cleared so no update will happen
 ;
 N FLD,RECNO
 F FLD=.1211,.1212,.1213,.1214,.1215,.1217,.1218,.1219,.1221,.1222,.1223,.12111,.12112 S RECNO=$P(REQLST(FLD),U) I RECNO]"" K ILST(RECNO)  ; remove from input array so they are not processed for filing into patient record
 Q
