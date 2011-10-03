VDEFEL ;INTEGIC/YG & BPOIFO/JG- VDEF library functions; ; 21 Dec 2004  11:29 AM
 ;;1.00;VDEF;;Dec 17, 2004
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ; No bozos
 ;
 ; VDEF Library Subroutines.
 ;
SETDLMS ; Set HL7 delimiters from HL array if any or to std. HL7 ^~|\&
 S X=$E($G(HL("FS"))) S:X="" X="^" S SEPF=X
 S X=$G(HL("ECH")) S:X="" X="~|\&"
 S SEPC=$E(X),SEPS=$E(X,4),SEPR=$E(X,2),SEPE=$E(X,3)
 Q
 ;
 ; Converts IEN from new person file (200) into HL7 XCN data
XCN200(VAL,SRC) ;
 ; Inputs: VAL - IEN from ^VA(200)
 ;         SRC - Source for person (Optional)
 ; Return: VAL is converted to HL7 XCN name format
 I VAL="" Q VAL
 N NM S NM("FILE")=200,NM("FIELD")=.01,NM("IENS")=VAL_","
 S VAL=VAL_SEPC_$$HLNAME^XLFNAME(.NM,"S",SEPC)
 I $G(SRC)'="" S $P(VAL,SEPC,8)=SRC
 E  S $P(VAL,SEPC,8)="VistA200"
 Q VAL
 ;
 ; Format VAL into HL7 TS date/time
TS(VAL) ; Format VAL as valid HL7 TS date/time/time zone
 N OVAL,%DT,%H,% I VAL'?3A.E&(+VAL=0)!(+VAL=-1) S VAL="" G TSEXIT
 ;
 ; Already in HL7 TS or DT form?
 G TSEXIT:VAL?8N.6N1"-"4N!(VAL?8N.6N1"+"4N)!(VAL?8N),TZ:VAL?12N
 S OVAL=VAL
 ;
 ; Convert alpha month if needed
 I VAL'?5N1","1.5N,VAL'?7N,VAL'?7N1"."0.6N D
 . N X,Y,%DT S %DT="TS",X=VAL D ^%DT I Y=-1 S VAL="" Q
 . S VAL=Y,OVAL=VAL
 G TSEXIT:VAL=""
 ;
 ; Date in $H format?
 I VAL?5N1","1.5N S %H=VAL D YMD^%DTC S VAL=X_%,OVAL=VAL
 ;
 ; Convert to HL7 format
 S VAL=$$HLDATE^HLFNC(VAL,"TS") I VAL=-1 S VAL="" G TSEXIT
 ;
 ; Correct the time zone if time present
TZ I $L(VAL)>8,VAL'["-",VAL'["+" S VAL=$P(VAL,"-")_$$TZ^XLFDT
TSEXIT Q VAL
 ;
RTNVAL ; Validate entry for file #577, field # .3, EXTRACTION PROGRAM
 ; Entry must be either "INACTIVE" or the name of the M routine
 ; used to extract the VistA data and create the HL7 message.
 ; Used by input transform of file #577, field #.3 and by the KID
 ; post-install API in application domains's packages.
 ;
 I X'="INACTIVE",$T(@("^"_X))=""  K X Q  ; Program ain't there
 I $P($T(@("VALID^"_X)),";",3)'="VDEF HL7 MESSAGE BUILDER" K X Q
 Q
