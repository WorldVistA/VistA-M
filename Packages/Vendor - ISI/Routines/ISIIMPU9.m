ISIIMPU9 ;;ISI GROUP/MLS -- MED IMPORT Utility
 ;;1.0;;;Jun 26,2012;Build 93
 Q  
MISCDEF ;;+++++ DEFINITIONS OF MED MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------------
 ;;PAT_SSN          |FIELD      |2,.09      |Patient SSN (identifier)
 ;;DRUG             |FIELD      |50,.01     |Generic Name
 ;;DATE             |FIELD      |           |Multiple uses (issue, dispense, fill)
 ;;EXPIRDT          |FIELD      |50,17.1    |Expiration Date
 ;;SIG              |FIELD      |51,.01     |Medication Instruction name
 ;;QTY              |FIELD      |           |Quantity.  Must be a number
 ;;SUPPLY           |FIELD      |52,8       |# of Days supply. Must be a number
 ;;REFILL           |FIELD      |           |# of refills.  Must be a number.
 ;;PROV             |FIELD      |200,.01    |Provider
 Q
 ;
MEDMISC(MISC,ISIMISC)
 ;INPUT: 
 ;  MISC(0)=PARAM^VALUE - raw list ovalues from RPC client
 ;
 ;OUTPUT:
 ;  ISIMISC(PARAM)=VALUE
 ;
 N MISCDEF
 K ISIMISC
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 S ISIRC=$$MEDMISC1("ISIMISC")
 Q ISIRC ;return code
 ;
MEDMISC1(DSTNODE)
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$$TRIM^XLFSTR($P(MISC(I),U,2))
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="DATE" D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid "_PARAM_" date/time." Q
 . . S VALUE=RESULT
 . . I $P(VALUE,".",2)="" S VALUE=VALUE_".1200"
 . . Q
  . I PARAM="EXPIRDT" D  
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid "_PARAM_" date." Q
 . . S VALUE=RESULT
 . . Q
 . I EXIT Q
 . S @DSTNODE@(PARAM)=VALUE
 . Q
 Q ISIRC ;return code
 ;
LOADMISC(MISCDEF) ;
 N BUF,FIELD,I,NAME,TYPE
 K MISCDEF
 F I=3:1  S BUF=$P($T(MISCDEF+I),";;",2)  Q:BUF=""  D
 . S NAME=$$TRIM^XLFSTR($P(BUF,"|"))  Q:NAME=""
 . S TYPE=$$TRIM^XLFSTR($P(BUF,"|",2))
 . S FIELD=$$TRIM^XLFSTR($P(BUF,"|",3))
 . S MISCDEF(NAME)=TYPE_"|"_FIELD
 Q
 ;
VALMEDS(ISIMISC)
 ; Entry point to validate content of MEDS create array
 ; 
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("DRUG")="ASPRIN" 
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,DFN,VALUE,RESULT,MSG,MISCDEF,EXIT,Y,RESULT,PSOSITE
 S EXIT=0,FLAG=""
 D LOADMISC(.MISCDEF) ; Load MISC definition params
 ;
 ; -- PAT_SSN --
 I '$D(ISIMISC("PAT_SSN")) Q "-1^Missing Patient SSN."
 I $D(ISIMISC("PAT_SSN")) D  
 . S VALUE=$G(ISIMISC("PAT_SSN")) I VALUE="" S EXIT=1 Q
 . I '$D(^DPT("SSN",VALUE)) S EXIT=1 Q
 . S DFN=$O(^DPT("SSN",VALUE,"")) I DFN="" S EXIT=1 Q
 . S ISIMISC("DFN")=DFN
 . Q
 Q:EXIT "-1^Invalid PAT_SSN (#2,.09)."
 ;
 ; -- DRUG --
 ; Check VA PRODUCT file for RX NORM value (OROVILLE specific)
 I $D(^PSNDF(50.68,"VARXCUI",$G(ISIMISC("DRUG")))) D  
 . N VAPROD,DRUG S (VAPROD,DRUG)=0 
 . F  S VAPROD=$O(^PSNDF(50.68,"VARXCUI",ISIMISC("DRUG"),VAPROD)) Q:'VAPROD!DRUG  D  
 . . S DRUG=$O(^PSDRUG("AC0P",VAPROD,"")) I DRUG S ISIMISC("DRUG")=$P($G(^PSDRUG(DRUG,0)),U)
 . . Q
 . Q
 ;
 I $G(ISIMISC("DRUG"))="" Q "-1^Missing DRUG (#50,.01) value."
 ;
 I $D(ISIMISC("DRUG")) D  
 . S VALUE=ISIMISC("DRUG")
 . I '$D(^PSDRUG(VALUE,0)) S VALUE=$O(^PSDRUG("B",VALUE,""))
 . I 'VALUE S EXIT=1 Q
 . I $P($G(^PSDRUG(VALUE,2)),U,1)="" S EXIT=1 Q ;Missing pointer to Orderable item #50.7
 . ;I $P($G(^PSDRUG(VALUE,0)),U,3)="" S EXIT=1 Q ;Missing DEA value
 . ;I $P($G(^PSDRUG(VALUE,660)),U,6)="" S EXIT=1 Q ;Missing unit price
 . S ISIMISC("DRUG")=VALUE
 . Q
 Q:EXIT "-1^Invalid DRUG (#50,.01) value." 
 ;
 ; -- DATE --
 I $G(ISIMISC("DATE"))="" Q "-1^Missing Fill Date"
 I $G(ISIMISC("EXPIRDT"))="" Q "-1^Missing Expire Date" 
 ;
 ; -- SIG -- 
 I $G(ISIMISC("SIG"))="" Q "-1^Missing SIG (#51,.01) value."
 I $D(ISIMISC("SIG")) D  
 . S FIELD=$P(MISCDEF("SIG"),"|",2)
 . S FILE=$P(FIELD,","),FIELD=$P(FIELD,",",2)
 . S VALUE=ISIMISC("SIG")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1
 . S VALUE=$O(^PS(51,"B",VALUE,""))
 . I $P(^PS(51,VALUE,0),U,4)>1 S EXIT=1 Q ;#51,30 Intended use is Inpatient only
 . Q
 Q:EXIT "-1^Invalid Medication Instruction/SIG (#51,.01) value."
 ;
 ; -- QTY --
 I $G(ISIMISC("QTY"))="" Q "-1^Missing QTY (quantity) value."
 S VALUE=ISIMISC("QTY") I VALUE'?1N.N Q "-1^Invalid QTY (quantity) value. Must be number."
 ;
 ; -- SUPPLY --
 I $G(ISIMISC("SUPPLY"))="" Q "-1^Missing SUPPLY (DAYS SUPPLY) value."
 S VALUE=ISIMISC("SUPPLY") I VALUE'?1N.N Q "-1^Invalid SUPPLY (DAYS SUPPLY)value. Must be number."
 ;
 ; -- REFILL --
 I $G(ISIMISC("REFILL"))="" Q "-1^Missing REFILL (# of refills) value."
 S VALUE=ISIMISC("QTY") I VALUE'?1N.N Q "-1^Invalid REFILL (# or refills) value. Must be number."
 ;
 ; -- PROV --
 I $G(ISIMISC("PROV"))'="" D  
 . S FIELD=$P(MISCDEF("PROV"),"|",2)
 . S FILE=$P(FIELD,","),FIELD=$P(FIELD,",",2)
 . S VALUE=ISIMISC("PROV")
 . D CHK^DIE(FILE,FIELD,FLAG,VALUE,.RESULT,.MSG) I RESULT="^" S EXIT=1 Q
 . ;if multiple entries, check for valid entry
 . S EXIT=1
 . S Y=0 F  S Y=$O(^VA(200,"B",VALUE,Y)) Q:Y=""  D  
 . . I +$G(^VA(200,Y,"PS"))'=1 Q ;Authorized to write medical orders check
 . . S EXIT=0,ISIMISC("PROV")=Y
 . . Q
 I $G(ISIMISC("PROV"))="" D  
 . S EXIT=1
 . I +$G(^VA(200,DUZ,"PS"))'=1 Q ;
 . S ISIMISC("PROV")=DUZ,EXIT=0
 . Q
 Q:EXIT "-1^Invalid PROVIDER (#200,.01)."
 ;
 S PSOSITE=0 F  S PSOSITE=$O(^PS(59,PSOSITE)) Q:'PSOSITE  D  I $G(ISIMISC("PSOSITE"))'="" Q
 . S Y=+$G(^PS(59,PSOSITE,"I"))
 . I Y="" S ISIMISC("PSOSITE")=PSOSITE Q
 . I Y>DT Q
 . S ISIMISC("PSOSITE")=PSOSITE
 . Q
 Q:$G(ISIMISC("PSOSITE"))="" "-1^Can't locate valid OUTPATIENT SITE FILE (#59)."
 ;
 Q 1
