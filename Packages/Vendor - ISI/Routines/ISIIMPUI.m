ISIIMPUI ;;ISI GROUP/MLS -- NON-VA MED IMPORT Utility
 ;;3.0;ISI_DATA_LOADER;;Jun 26, 2019;Build 80
 ;
 ; VistA Data Loader 2.0
 ;
 ; Copyright (C) 2012 Johns Hopkins University
 ;
 ; VistA Data Loader is provided by the Johns Hopkins University School of
 ; Nursing, and funded by the Department of Health and Human Services, Office
 ; of the National Coordinator for Health Information Technology under Award
 ; Number #1U24OC000013-01.
 ;
 ;Licensed under the Apache License, Version 2.0 (the "License");
 ;you may not use this file except in compliance with the License.
 ;You may obtain a copy of the License at
 ;
 ;    http://www.apache.org/licenses/LICENSE-2.0
 ;
 ;Unless required by applicable law or agreed to in writing, software
 ;distributed under the License is distributed on an "AS IS" BASIS,
 ;WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 ;See the License for the specific language governing permissions and
 ;limitations under the License.
 ;
 Q
MISCDEF ;;+++++ DEFINITIONS OF NON-VA MED MISC PARAMETERS +++++
 ;;NAME             |TYPE       |FILE,FIELD |DESC
 ;;-----------------------------------------------------------------------
 ;;PAT_SSN          |FIELD      |2,.09      |Patient SSN (identifier)
 ;;DRUG             |FIELD      |55,52.2,.01|Orderable Item
 ;;DATE             |FIELD      |55,52.2,8  |Multiple uses (Start Date)
 ;;DOSAGE           |FIELD      |55,52.2,2  |Medication Dosage
 ;;SIG              |FIELD      |55,52.2,4  |Medication Schedule
 ;;ROUTE            |FIELD      |55,52.2,3  |Medication Route
 ;;DISC             |FIELD      |55,52.2,10 |Disclaimer Text
 Q
 ;
MEDMISC(MISC,ISIMISC) ;
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
MEDMISC1(DSTNODE) ;
 N PARAM,VALUE,DATE,RESULT,MSG,EXIT
 S (EXIT,ISIRC)=0,(I,VALUE)=""
 F  S I=$O(MISC(I))  Q:I=""  D  Q:EXIT
 . S PARAM=$$TRIM^XLFSTR($P(MISC(I),U))  Q:PARAM=""
 . S VALUE=$P(MISC(I),U,2)
 . I '$D(MISCDEF(PARAM)) S ISIRC="-1^Bad parameter title passed: "_PARAM,EXIT=1 Q
 . I VALUE="" S ISIRC="-1^No data provided for parameter: "_PARAM,EXIT=1 Q
 . I PARAM="DATE" D
 . . S DATE=VALUE D DT^DILF("T",DATE,.RESULT,"",.MSG)
 . . I RESULT<0 S EXIT=1,ISIRC="-1^Invalid "_PARAM_" date/time." Q
 . . S VALUE=RESULT
 . . I $P(VALUE,".",2)="" S VALUE=VALUE_".1200"
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
VALMEDS(ISIMISC) ;
 ; Entry point to validate content of MEDS create array
 ;
 ; Input - ISIMISC(ARRAY)
 ; Format:  ISIMISC(PARAM)=VALUE
 ;     eg:  ISIMISC("DRUG")="ASPRIN"
 ;
 ; Output - ISIRC [return code]
 N FILE,FIELD,FLAG,DFN,VALUE,RESULT,MSG,MISCDEF,EXIT,Y,RESULT,PSOSITE
 S EXIT=0,FLAG=""
 ;D LOADMISC(.MISCDEF) ; Load MISC definition params
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
 ;
 I $G(ISIMISC("DRUG"))="" Q "-1^Pharmacy Orderable Item value."
 ;
 I $D(ISIMISC("DRUG")) D
 . S VALUE=ISIMISC("DRUG")
 . N OITM S OITM=$O(^ORD(101.44,"B","ORWDSET NV RX",0))
 . S VALUE=$O(^ORD(101.44,OITM,20,"C",VALUE,""))
 . I 'VALUE S EXIT=1 Q
 . S ISIMISC("DRUG")=+$P(^ORD(101.44,OITM,20,VALUE,0),U)
 . Q
 Q:EXIT "-1^Invalid Pharmacy Orderable Item value."
 ;
 ; -- DATE --
 I $G(ISIMISC("DATE"))="" Q "-1^Missing Start Date"
 ;
 ; -- SIG --
 I $G(ISIMISC("SIG"))="" Q "-1^Missing Schedule value."
 ;
 ; -- DOSAGE --
 I $G(ISIMISC("DOSAGE"))="" Q "-1^Missing Dosage value."
 ;
 ; -- ROUTE --
 I $G(ISIMISC("ROUTE"))="" Q "-1^Missing Route value."
 ;
 Q 1
