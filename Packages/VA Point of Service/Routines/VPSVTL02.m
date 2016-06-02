VPSVTL02 ;ALBANY/KC - Patient Vitals RPC;08/14/14 09:28
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**10**;July 8, 2015;Build 16
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #3217    DDR FIND1                 (Supported)
 ; #4815    GMVDCSAV                  (Controlled)
 ; #6207    ABBVAL GMVUTL             (Controlled)
 Q
WRITE(VPSARR,VPSNUM,VPSTYP,VTYP,VVAL,DTM,BY,LOC,QLFS,OX) ;
 ;
 ; INPUT
 ;   VPSNUM  - Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP  - Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VTYP    - Parameter for Vital Type
 ;   VVAL    - Rate for the Vital Type
 ;   DTM     - Date Time
 ;   BY      - Vitals entered by (user in File #200)
 ;   LOC     - Hospital location (File 44)
 ;   QLFS    - String of Qualifiers for this vital entry (Q1:Q2:Q3) (SITTING:R ARM)
 ;   OX      = Oxygen flow rate and percentage value (1 l/min 90%)
 ;
 ; OUTPUT
 ;   VPSARR  - 
 ;           If error 
 ;                   VPSARR=0^Error message
 ;           otherwise
 ;                   VPSARR=1(^Alert of abnormal vital vlaue - optional)
 ;                   
 ;
 ;
 ;
 N CNT,DFN,DDR,RES,VTIEN,ALERT
 S CNT=0
 S ALERT=""
 K VPSARR
 S VPSARR=1
 S DFN=$$VALIDATE^VPSRPC1($G(VPSTYP),$G(VPSNUM))
 I $G(BY)="" S BY=$G(DUZ)
 I +DFN<0 S VPSARR="0^"_$P(DFN,"^",2) Q
 I $G(VVAL)="" S VPSARR="0^Missing vital measurement value" Q
 I $G(VTYP)="" S VPSARR="0^Missing vital type" Q
 I VTYP="T",((+VVAL<45)!(+VVAL>120)) S VPSARR="0^Invalid vital measurement value for temperature of "_VVAL Q
 I VTYP="BP",VVAL'?1.N."/".N S VPSARR="0^Invalid vital measurement value for BP of "_VVAL Q
 I VTYP="BP" D
 . N DIA,SYT
 . S SYT=$P(VVAL,"/")
 . S DIA=$P(VVAL,"/",2)
 . I SYT<0!(SYT>300)!(DIA<0)!(DIA>300) S VPSARR="0^Invalid vital measurement value for BP of "_VVAL
 I VTYP'="BP",VVAL'?1.E S VPSARR="0^Invalid vital measurement value for "_VTYP_" of "_VVAL Q
 I VTYP="PN",VVAL<0!((VVAL>10)&(VVAL'=99)) S VPSARR="0^Invalid vital measurement value for Pain of "_VVAL Q
 I VTYP="PO2",VVAL<0!(VVAL>100) S VPSARR="0^Invalid vital measurement value for "_VTYP_" of "_VVAL Q
 I VTYP="P",VVAL<0!(VVAL>300) S VPSARR="0^Invalid vital measurement value for "_VTYP_" of "_VVAL Q
 I VTYP="R",VVAL<0!(VVAL>100) S VPSARR="0^Invalid vital measurement value for "_VTYP_" of "_VVAL Q
 I VTYP="WT",VVAL<0!(VVAL>1500) S VPSARR="0^Invalid vital measurement value for "_VTYP_" of "_VVAL Q
 I VTYP="HT",VVAL<10!(VVAL>100) S VPSARR="0^Invalid vital measurement value for "_VTYP_" of "_VVAL Q
 ;
 Q:$P(VPSARR,U)=0 
 ; Find Vital Type IEN using Vital Type Abbrev.
 S RES=""
 S DDR("FILE")=120.51
 S DDR("VALUE")=VTYP
 S DDR("FLAGS")="MX"
 D FIND1C^DDR2(.RES,.DDR)
 S VTIEN=+$G(RES(1))
 I VTIEN=0 S VPSARR="0^Invalid Vital Type ("_VTYP_")" Q
 N RK
 S RK=$$ABBVAL^GMVUTL7(VTIEN)
 I $L(RK)>0 D
 . I +VVAL>$P(RK,U)!(+VVAL<$P(RK,U,2)) S ALERT="Abnormal value of "_VVAL_" for vital type "_VTYP
 . I VTYP="BP",+$P(VVAL,"/",2)>$P(RK,U,3)!(+$P(VVAL,"/",2)<$P(RK,U,4)) S ALERT="Abnormal value of "_VVAL_" for vital type "_VTYP
 ;
 ;
 ; Find Qualifier IENs
 G:$G(QLFS)="" DT1
 K RES
 N QL,QIEN,ER,QIENS,I
 S DDR("FILE")=120.52
 S DDR("FLAGS")="MX"
 S ER=0
 S QIENS=""
 F I=1:1:$L(QLFS,":") S QL=$P(QLFS,":",I) D
 . S DDR("VALUE")=QL
 . D FIND1C^DDR2(.RES,.DDR)
 . S QIEN=+$G(RES(1))
 . I QIEN=0 S VPSARR="0^Invalid Qualifier ("_QL_")",ER=1 Q
 . S QIENS=QIENS_":"_QIEN
 Q:ER
 ; Remove leading colon
 S QIENS=$E(QIENS,2,999)
 ;
DT1 ;
 I $$DTCHK^VPSVTL01($G(DTM)) S VPSARR="0^Invalid or missing Date time" Q
 ; Set up variables for call to store vitals by calling EN1^GMVDCSAV
 ; GMVDATA has the following data:
 ; piece1^piece2^piece3^piece4^piece5
 ; where:
 ;   piece1 = date/time in FileMan internal format
 ;   piece2 = patient number from FILE 2 (i.e., DFN)
 ;   piece3 = vital type, a semi-colon, the reading, a semi-colon, and
 ;            oxygen flow rate and percentage values [optional] (e.g.,
 ;            21;99;1 l/min 90%)
 ;   piece4 = hospital location (FILE 44) pointer value
 ;   piece5 = FILE 200 user number (i.e., DUZ), an asterisk, and the 
 ;            qualifier (File 120.52) internal entry numbers separated by
 ;            colons (e.g., 547*50:65)
 ; Example:
 ;  > S GMVDATA="3051011.1635^134^1;120/80;^67^87*2:38:50:75"
 ;  > D EN1^GMVDCSAV(.RESULT,GMVDATA)
 N GMVDATA,RESULT
 S GMVDATA=DTM_U_DFN_U_VTIEN_";"_$G(VVAL)_";"_$G(OX)_U_$G(LOC)_U_$G(BY)_"*"_$G(QIENS)
 D EN1^GMVDCSAV(.RESULT,GMVDATA)
 I $G(RESULT(0))="" S VPSARR=1
 E  I RESULT(0)="ERROR" S VPSARR="0^"_$O(RESULT(""),-1)
 I VPSARR=1,ALERT]"" S VPSARR="1^"_ALERT
 Q
