HDISVU01 ;BPFO/JRP - UTILITY CALLS;12/21/2004
 ;;1.0;HEALTH DATA & INFORMATICS;**6**;Feb 22, 2005
 ;
XMLTFM(XMLDT,LTZ) ;Convert XML date/time to FM date/time
 ; Input : XMLDT - XML date/time
 ;         LTZ - Flag indicating if time should be converted to local
 ;               time (XML d/t contains time zone designation)
 ;               0 = No (default)     1 = Yes
 ;Output : Date/time in FileMan format
 ; Notes : Null ("") returned on error
 N HL7DT,FMDT
 S XMLDT=$G(XMLDT)
 I XMLDT="" Q ""
 S LTZ=+$G(LTZ)
 S LTZ=$S(LTZ:"L",1:"U")
 ;Convert to HL7 format
 S HL7DT=$TR($P(XMLDT,"T",1),"-")_$TR($P(XMLDT,"T",2),":")
 ;Convert HL7 format to FileMan format
 S FMDT=$$HL7TFM^XLFDT(HL7DT,LTZ)
 I FMDT=-1 S FMDT=""
 Q FMDT
 ;
FMTXML(FMDT,NOTIME,MIDNIGHT) ;Convert FM date/time to XML date/time
 ; Input : FMDT - FileMan date/time
 ;         NOTIME - Flag indicating if time shouldn't be included
 ;                  0 = No (include time)(default)   1 = Yes (no time)
 ;         MIDNIGHT - Flag indicating if midnight should be used when
 ;                    no time is passed in
 ;                    0 = No (leave as is)(default)     1 = Yes
 ;Output : Date/time in XML format
 ; Notes : Null ("") returned on error
 N XTRNDT,XMLDT,FLAG
 S NOTIME=+$G(NOTIME)
 S MIDNIGHT=+$G(MIDNIGHT)
 I $P(FMDT,".",2)="" I 'MIDNIGHT S NOTIME=1
 I $P(FMDT,".",2)?1."0" I 'NOTIME S MIDNIGHT=1
 ;No time overrides midnight addition
 I NOTIME S MIDNIGHT=0
 ;Drop time
 S FLAG=$S(NOTIME:"7FD",1:"7FS")
 ;Convert
 S XTRNDT=$$FMTE^XLFDT(FMDT,FLAG)
 ;Append midnight
 I MIDNIGHT I $P(XTRNDT,"@",2)="" S $P(XTRNDT,"@",2)="00:00:00"
 S XMLDT=$TR(XTRNDT,"@ /","T0-")
 I 'NOTIME S XMLDT=XMLDT_$$TZ^XLFDT()
 Q XMLDT
 ;
ERR2XTMP(NODE,DESC,TEXTARR) ;Add error info to XTMP global
 ; Input : NODE - Namespaced node name to store info off of
 ;                (Defaults to "HDI")
 ;         DESC - Error description (short text)
 ;         TEXTARR - Array containing error text (full global ref)
 ;Output : None
 ; Notes : Sets the following nodes in XTMP
 ;           ^XTMP(NODE,0) = Purge Date (T+10) ^ Create Date (NOW)
 ;                           ^ "HDI software issues"
 ;           ^XTMP(NODE,x,0) = Create Date (NOW) ^ DESC
 ;           ^XTMP(NODE,x,"ERR") = TEXTARR
 S NODE=$G(NODE)
 S:NODE="" NODE="HDI"
 S DESC=$G(DESC)
 S TEXTARR=$G(TEXTARR)
 N CDATE,PDATE,SUB
 ;Set main node in XTMP
 S CDATE=$$NOW^XLFDT()
 S PDATE=$$FMADD^XLFDT(CDATE,10)
 S ^XTMP(NODE,0)=PDATE_"^"_CDATE_"^HDI software issues"
 ;Get next error node
 S SUB=1+$O(^XTMP(NODE,""),-1)
 ;Set main error node
 S ^XTMP(NODE,SUB,0)=CDATE_"^"_DESC
 ;Store error text
 I TEXTARR'="" M ^XTMP(NODE,SUB,"TXT")=@TEXTARR
 ;Done
 Q
