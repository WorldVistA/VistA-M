C0CDAC6 ; GPL - Patient Portal - CCDA Routines ;09/23/13  17:05
 ;;0.1;JJOHPP;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
VITALS(BLIST,DFN,CCDAWRK,CCDARPT,CCDACTRL) ;
 ;
 N CCDAV,CCDAV1,PARMS,HAVDTS
 I $D(@CCDACTRL@("PARMS")) M PARMS=@CCDACTRL@("PARMS")
 S HAVDTS=0
 I $D(PARMS("startDateTime")) S HAVDTS=1
 N STRT,STOP
 S STRT=$G(PARMS("startDateTime"))
 S STOP=$G(PARMS("endDateTime"))
 S @CCDARPT@("STATUS")="EXTRACTING"
 S @CCDARPT@("EXTRACT-BEGIN")=$$NOW^XLFDT
 D GETPAT^C0CDACD(.CCDAV1,DFN,"vitals",STRT,STOP) ; 
 I '$D(CCDAV1) Q  ;
 D POSTPRS(.CCDAV,.CCDAV1) ; special handling for vitals array
 S @CCDARPT@("EXTRACT-ENDS")=$$NOW^XLFDT
 ;
 ; deterimine if there are vitals in the date range
 ;
 N HAVEVIT S HAVEVIT=1
 I HAVDTS=1 D  ; we have requested dates
 . S HAVEVIT=0 ; assume no vitals in date range
 . N C0I S C0I=0
 . F  S C0I=$O(CCDAV(C0I)) Q:HAVEVIT  Q:+C0I=0  D  ;
 . . N C0DATE S C0DATE=$G(CCDAV(C0I,"taken@value"))
 . . I $$SKIP^C0CDACV(C0DATE,.PARMS)=0 S HAVEVIT=1
 I $D(C0DEBUG) I 'HAVEVIT W !,"NO VITALS"
 Q:'HAVEVIT
 ;
 ; vitals section html
 ;
 N C0HTML,C0ARY
 S C0ARY("TITLE")="Vital Signs"
 S C0ARY("HEADER",1)="Date"
 S C0ARY("HEADER",2)="Vital Sign"
 S C0ARY("HEADER",3)="Value"
 S C0ARY("HEADER",4)="Details"
 S C0ARY("HEADER",5)="Source"
 ;
 N DONE ; array of things that are done - for latest processing
 I $G(PARMS("VITALS"))="" S PARMS("VITALS")="LATEST"
 N C0I S C0I=0
 N C0N S C0N=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ;
 . N C0DATE,C0D S C0D=$G(CCDAV(C0I,"taken@value"))
 . Q:$$SKIP^C0CDACV(C0D,.PARMS)
 . I C0D'="" S C0DATE=$$HTMLDT^C0CDACU(C0D) ; date
 . E  S C0DATE="" ; no date
 . N C0I2 S C0I2=0
 . F  S C0I2=$O(CCDAV(C0I,C0I2)) Q:+C0I2=0  D  ;
 . . N GGID S GGID="uri_120_5-"_$G(CCDAV(C0I,C0I2,"measurement@id"))
 . . S CCDAV(C0I,C0I2,"uri")=GGID
 . . Q:$$REDACT^C0CDACV(CCDAV(C0I,C0I2,"uri"),.PARMS)
 . . Q:CCDAV(C0I,C0I2,"measurement@value")="Unavailable"
 . . N VNAME S VNAME=CCDAV(C0I,C0I2,"measurement@name") ; vital sign name
 . . I $G(PARMS("VITALS"))="LATEST" I $D(DONE(VNAME)) Q  ; already did this one
 . . S DONE(VNAME)=""
 . . S C0N=C0N+1 ; HTML line
 . . ;I C0I2=1 S C0ARY(C0N,1)=C0DATE ; switch these to get a battery look
 . . S C0ARY(C0N,1)=C0DATE
 . . ;E  S C0ARY(C0N,1)=""
 . . S C0ARY(C0N,1,"ID")=$G(CCDAV(C0I,C0I2,"uri"))
 . . I $G(CCDAV(C0I,C0I2,"measurement@name"))="" Q  ; not a valid record
 . . I $G(CCDAV(C0I,C0I2,"measurement@value"))="" Q  ; not a valid record
 . . I $G(CCDAV(C0I,C0I2,"measurement@value"))="Refused" Q  ; not valid
 . . S C0ARY(C0N,2)=CCDAV(C0I,C0I2,"measurement@name") ; vital sign name
 . . S C0ARY(C0N,3)=CCDAV(C0I,C0I2,"measurement@value")_" "_$G(CCDAV(C0I,C0I2,"measurement@units")) ; measurement value
 . . I $G(CCDAV(C0I,C0I2,"measurement@metricValue"))'="" D  ;
 . . . I $G(CCDAV(C0I,C0I2,"measurement@metricUnits"))="kg" D  ;
 . . . . N TKG S TKG=CCDAV(C0I,C0I2,"measurement@metricValue")
 . . . . I TKG["." S TKG=$P(TKG,".",1)
 . . . . S CCDAV(C0I,C0I2,"measurement@metricValue")=TKG
 . . . S C0ARY(C0N,3)=CCDAV(C0I,C0I2,"measurement@metricValue")_" "_$G(CCDAV(C0I,C0I2,"measurement@metricUnits")) ; measurement value
 . . I $G(CCDAV(C0I,C0I2,"measurement@low"))'="" S C0ARY(C0N,4)="low:  "_CCDAV(C0I,C0I2,"measurement@low")_" high: "_CCDAV(C0I,C0I2,"measurement@high")
 . . E  S C0ARY(C0N,4)=" "
 . . S C0ARY(C0N,5)=$G(CCDAV(C0I,"location@name"))_" " ; source
 ;
 I +$O(C0ARY("AAAAA"),-1)=0 Q  ; all vitals have been redacted
 ;
 ; the vitals section component
 ;
 N LSECT S LSECT=$NA(@CCDAWRK@("VITALSECTION"))
 D GET^C0CDACU(LSECT,"TVITSEC^C0CDAC6")
 D QUEUE^MXMLTMPL(BLIST,LSECT,1,@LSECT@(0))
 ;
 ; vitals html generation
 ;
 N LHTML S LHTML=$NA(@CCDAWRK@("VITHTML"))
 D GENHTML^C0CDACU(LHTML,"C0ARY")
 D QUEUE^MXMLTMPL(BLIST,LHTML,1,@LHTML@(0))
 ;
 ; vitals xml processing
 ;
 N VTBL D INITBL(.VTBL) ; initialize coding table
 N C0VCNT S C0VCNT=0
 F  S C0I=$O(CCDAV(C0I)) Q:+C0I=0  D  ; 
 . N C0J S C0J=0
 . N C0DTE S C0DTE=$G(CCDAV(C0I,"taken@value"))
 . Q:$$SKIP^C0CDACV(C0DTE,.PARMS) ; quit if not in date range
 . N C0DATE S C0DATE=$$FMDTOUTC^C0CDACU(C0DTE)
 . K C0ARY
 . S C0ARY("guid1")=$$UUID^C0CDACU() ; random
 . S C0ARY("vitalDateTime")=C0DATE
 . S C0VCNT=C0VCNT+1 ; count of xml pieces in vitals
 . N WRK S WRK=$NA(@CCDAWRK@("VITXML",C0VCNT))
 . D GETNMAP^C0CDACU(WRK,"TVITORG^C0CDAC6","C0ARY")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . F  S C0J=$O(CCDAV(C0I,C0J)) Q:+C0J=0  D  ;
 . . K C0ARY
 . . Q:$$REDACT^C0CDACV(CCDAV(C0I,C0J,"uri"),.PARMS)
 . . Q:$G(CCDAV(C0I,C0J,"measurement@value"))="Unavailable"
 . . I $G(CCDAV(C0I,C0J,"measurement@name"))="" Q  ; not a valid record
 . . I $G(CCDAV(C0I,C0J,"measurement@value"))="" Q  ; not a valid record
 . . I $G(CCDAV(C0I,C0J,"measurement@value"))="Refused" Q  ; not valid
 . . S C0VCNT=C0VCNT+1
 . . S C0ARY("vitalDateTime")=C0DATE
 . . S C0ARY("guid2")=$$UUID^C0CDACU() ; guid for each vital
 . . S C0ARY("vitalsRef")="#"_$G(CCDAV(C0I,C0J,"uri"))
 . . S C0ARY("measurement@units")=$G(CCDAV(C0I,C0J,"measurement@units"))
 . . I $G(CCDAV(C0I,C0J,"measurement@metricUnits"))'="" D  ;
 . . . S C0ARY("measurement@units")=$G(CCDAV(C0I,C0J,"measurement@metricUnits"))
 . . . I C0ARY("measurement@units")="C" S C0ARY("measurement@units")="Cel"
 . . I C0ARY("measurement@units")="" S C0ARY("measurement@units")="UNK"
 . . ; convert units to UCUM
 . . I C0ARY("measurement@units")="in" S C0ARY("measurement@units")="[in_us]"
 . . I C0ARY("measurement@units")="lb" S C0ARY("measurement@units")="[lb_av]"
 . . I C0ARY("measurement@units")="F" S C0ARY("measurement@units")="[degF]"
 . . S C0ARY("measurement@value")=$G(CCDAV(C0I,C0J,"measurement@value"))
 . . I $G(CCDAV(C0I,C0J,"measurement@metricValue"))'="" D  ;
 . . . ; astro gpl
 . . . N C0V S C0V=$G(CCDAV(C0I,C0J,"measurement@metricValue"))
 . . . I C0V["." S C0V=$P(C0V,".",1)
 . . . S C0ARY("measurement@value")=C0V
 . . S C0ARY("vitalSource")=$G(CCDAV(C0I,"location@name"))
 . . N VIT S VIT=CCDAV(C0I,C0J,"measurement@name")
 . . S C0ARY("measurement@name")=VIT
 . . I VIT="BLOOD PRESSURE" D VITBP  Q  ;
 . . I '$D(VTBL(VIT)) D  ; vital not found in table
 . . . S C0ARY("vitalsName")=VIT
 . . E  D  ; found in table
 . . . S C0ARY("vitalsName")=VTBL(VIT,"name")
 . . . S C0ARY("vitalsCode")=VTBL(VIT,"loinc")
 . . . I C0ARY("vitalsName")="PAIN" S C0ARY("measurement@units")="1 to 10" ; fix this
 . . S WRK=$NA(@CCDAWRK@("VITXML",C0VCNT))
 . . D GETNMAP^C0CDACU(WRK,"TVITOBS^C0CDAC6","C0ARY")
 . . ;B
 . . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 . S C0VCNT=C0VCNT+1
 . S WRK=$NA(@CCDAWRK@("VITXML",C0VCNT))
 . D GET^C0CDACU(WRK,"TORGEND^C0CDAC6")
 . D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ;
 ; vital section ending
 ;
 N VITEND S VITEND=$NA(@CCDAWRK@("VITEND"))
 D GET^C0CDACU(VITEND,"TVITEND^C0CDAC6")
 D QUEUE^MXMLTMPL(BLIST,VITEND,1,@VITEND@(0))
 ;
 Q
 ;
VITBP ; special handling for blood pressure.. split into two measurements
 N BPVAL,SYS,DIA
 S BPVAL=C0ARY("measurement@value") ; ie 100/58
 S SYS=+$P(BPVAL,"/",1) ; numerator
 S DIA=+$P(BPVAL,"/",2) ; denominator
 I BPVAL["//" D  ; typo
 . S SYS=+$P(BPVAL,"//",1) ; numerator
 . S DIA=+$P(BPVAL,"//",2) ; denominator
 ;
 S C0ARY("vitalsName")=VTBL("BP SYSTOLIC","name")
 S C0ARY("vitalsCode")=VTBL("BP SYSTOLIC","loinc")
 S C0ARY("measurement@value")=SYS
 S C0VCNT=C0VCNT+1
 S WRK=$NA(@CCDAWRK@("VITXML",C0VCNT))
 D GETNMAP^C0CDACU(WRK,"TVITOBS^C0CDAC6","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 ;
 S C0ARY("vitalsName")=VTBL("BP DIASTOLIC","name")
 S C0ARY("vitalsCode")=VTBL("BP DIASTOLIC","loinc")
 S C0ARY("measurement@value")=DIA
 S C0VCNT=C0VCNT+1
 S WRK=$NA(@CCDAWRK@("VITXML",C0VCNT))
 D GETNMAP^C0CDACU(WRK,"TVITOBS^C0CDAC6","C0ARY")
 D QUEUE^MXMLTMPL(BLIST,WRK,1,@WRK@(0))
 Q
 ;
INITBL(TBL) ; initialize vitals coding table
 ; 
 S TBL("TEMPERATURE","loinc")="8310-5"
 S TBL("TEMPERATURE","name")="Body Temperature"
 S TBL("BP DIASTOLIC","loinc")="8462-4"
 S TBL("BP DIASTOLIC","name")="INTRAVASCULAR DIASTOLIC"
 S TBL("BP SYSTOLIC","loinc")="8480-6"
 S TBL("BP SYSTOLIC","name")="INTRAVASCULAR SYSTOLIC"
 S TBL("HEAD","loinc")="8287-5"
 S TBL("HEAD","name")="Head Circumference"
 S TBL("PULSE","loinc")="8867-4"
 S TBL("PULSE","name")="Heart Rate"
 S TBL("HEIGHT","loinc")="8302-2"
 S TBL("HEIGHT","name")="Height"
 S TBL("HEIGHT LYING","loinc")="8306-3"
 S TBL("HEIGHT LYING","name")="Height (Lying)"
 S TBL("PULSE OXIMETRY","loinc")="59408-5"
 ;S TBL("PULSE OXIMETRY","loinc")="2710-2"
 S TBL("PULSE OXIMETRY","name")="OXYGEN SATURATION"
 S TBL("RESPIRATION","loinc")="9279-1"
 S TBL("RESPIRATION","name")="Respiratory Rate"
 ;S TBL("WEIGHT","loinc")="3141-9"
 ;S TBL("WEIGHT","name")="Weight Measured"
 S TBL("WEIGHT","loinc")="29463-7"
 S TBL("WEIGHT","name")="Body Weight"
 S TBL("PAIN","loinc")="38214-3"
 S TBL("PAIN","name")="PAIN SEVERITY"
 Q
 ;
POSTPRS(OARY,IARY) ; further parse the vitals array. 
 ; OARY (output array) and IARY (input array) are passed by reference
 ; here's a sample we will work from:
 ;G("vital",101,"entered@value")=3080930.12033
 ;G("vital",101,"facility@code")=195966
 ;G("vital",101,"facility@name")="OROVILLE HOSPITAL"
 ;G("vital",101,"location@code")=3
 ;G("vital",101,"location@name")="IF-FINE"
 ;G("vital",101,"measurements.measurement[1].qualifiers.qualifier[1]@name")="L ARM"
 ;G("vital",101,"measurements.measurement[1].qualifiers.qualifier[2]@name")="SITTING"
 ;G("vital",101,"measurements.measurement[1].qualifiers.qualifier[3]@name")="CUFF"
 ;G("vital",101,"measurements.measurement[1].qualifiers.qualifier[4]@name")="ADULT"
 ;G("vital",101,"measurements.measurement[1]@high")="210/110"
 ;G("vital",101,"measurements.measurement[1]@id")=52
 ;G("vital",101,"measurements.measurement[1]@low")="100/60"
 ;G("vital",101,"measurements.measurement[1]@name")="BLOOD PRESSURE"
 ;G("vital",101,"measurements.measurement[1]@units")="mm[Hg]"
 ;G("vital",101,"measurements.measurement[1]@value")="156/72"
 ;G("vital",101,"measurements.measurement[1]@vuid")=4500634
 ;G("vital",101,"measurements.measurement[2].qualifiers.qualifier@name")="ACTUAL"
 ;G("vital",101,"measurements.measurement[2]@id")=55
 ;G("vital",101,"measurements.measurement[2]@metricUnits")="cm"
 ;G("vital",101,"measurements.measurement[2]@metricValue")=182.88
 ;G("vital",101,"measurements.measurement[2]@name")="HEIGHT"
 ;G("vital",101,"measurements.measurement[2]@units")="in"
 ;G("vital",101,"measurements.measurement[2]@value")=72
 ;G("vital",101,"measurements.measurement[2]@vuid")=4688724
 ;G("vital",101,"measurements.measurement[3].qualifiers.qualifier[1]@name")="RADIAL"
 ;G("vital",101,"measurements.measurement[3].qualifiers.qualifier[2]@name")="SITTING"
 ;G("vital",101,"measurements.measurement[3].qualifiers.qualifier[3]@name")="PALPATED"
 ;G("vital",101,"measurements.measurement[3].qualifiers.qualifier[4]@name")="LEFT"
 ;G("vital",101,"measurements.measurement[3]@high")=120
 ;G("vital",101,"measurements.measurement[3]@id")=50
 ;G("vital",101,"measurements.measurement[3]@low")=60
 ;G("vital",101,"measurements.measurement[3]@name")="PULSE"
 ;G("vital",101,"measurements.measurement[3]@units")="/min"
 ;G("vital",101,"measurements.measurement[3]@value")=96
 ;G("vital",101,"measurements.measurement[3]@vuid")=4500636
 ;G("vital",101,"measurements.measurement[4]@id")=53
 ;G("vital",101,"measurements.measurement[4]@name")="PAIN"
 ;G("vital",101,"measurements.measurement[4]@value")=1
 ;G("vital",101,"measurements.measurement[4]@vuid")=4500635
 ;G("vital",101,"measurements.measurement[5]@high")=100
 ;G("vital",101,"measurements.measurement[5]@id")=54
 ;G("vital",101,"measurements.measurement[5]@low")=0
 ;G("vital",101,"measurements.measurement[5]@name")="PULSE OXIMETRY"
 ;G("vital",101,"measurements.measurement[5]@units")="%"
 ;G("vital",101,"measurements.measurement[5]@value")=98
 ;G("vital",101,"measurements.measurement[5]@vuid")=4500637
 ;G("vital",101,"measurements.measurement[6].qualifiers.qualifier[1]@name")="SPONTANEOUS"
 ;G("vital",101,"measurements.measurement[6].qualifiers.qualifier[2]@name")="SITTING"
 ;G("vital",101,"measurements.measurement[6]@high")=30
 ;G("vital",101,"measurements.measurement[6]@id")=51
 ;G("vital",101,"measurements.measurement[6]@low")=8
 ;G("vital",101,"measurements.measurement[6]@name")="RESPIRATION"
 ;G("vital",101,"measurements.measurement[6]@units")="/min"
 ;G("vital",101,"measurements.measurement[6]@value")=20
 ;G("vital",101,"measurements.measurement[6]@vuid")=4688725
 ;G("vital",101,"measurements.measurement[7].qualifiers.qualifier@name")="ORAL"
 ;G("vital",101,"measurements.measurement[7]@high")=102
 ;G("vital",101,"measurements.measurement[7]@id")=49
 ;G("vital",101,"measurements.measurement[7]@low")=95
 ;G("vital",101,"measurements.measurement[7]@metricUnits")="C"
 ;G("vital",101,"measurements.measurement[7]@metricValue")=37.5
 ;G("vital",101,"measurements.measurement[7]@name")="TEMPERATURE"
 ;G("vital",101,"measurements.measurement[7]@units")="F"
 ;G("vital",101,"measurements.measurement[7]@value")=99.5
 ;G("vital",101,"measurements.measurement[7]@vuid")=4500638
 ;G("vital",101,"measurements.measurement[8].qualifiers.qualifier[1]@name")="ACTUAL"
 ;G("vital",101,"measurements.measurement[8].qualifiers.qualifier[2]@name")="STANDING"
 ;G("vital",101,"measurements.measurement[8]@id")=56
 ;G("vital",101,"measurements.measurement[8]@metricUnits")="kg"
 ;G("vital",101,"measurements.measurement[8]@metricValue")=88.64
 ;G("vital",101,"measurements.measurement[8]@name")="WEIGHT"
 ;G("vital",101,"measurements.measurement[8]@units")="lb"
 ;G("vital",101,"measurements.measurement[8]@value")=195
 ;G("vital",101,"measurements.measurement[8]@vuid")=4500639
 ;G("vital",101,"taken@value")=3080930.130648
 ;
 N C0I,C0I2,C0I3,C0N1,C0N2,C0V
 S C0I=$O(IARY("")) ; vital
 S C0N1=0
 F  S C0N1=$O(IARY(C0I,C0N1)) Q:+C0N1=0  D  ;
 . S C0I2=""
 . F  S C0I2=$O(IARY(C0I,C0N1,C0I2)) Q:C0I2=""  D  ;
 . . S C0V=IARY(C0I,C0N1,C0I2) ; value
 . . I C0I2["qualifiers.qualifier" D  Q  ;
 . . . W:$G(C0DEBUG) !,"found qualifier: ",C0I2
 . . . S C0N2=$P($P(C0I2,"measurements.measurement[",2),"]",1) ; [x] value
 . . . I C0I2["qualifier@" D  Q  ;
 . . . . N C0VV S C0VV="qualifier@"_$P(C0I2,"qualifier@",2) 
 . . . . S OARY(C0N1,C0N2,C0VV,1)=C0V
 . . . E  D  Q  ;
 . . . . N C0N3 S C0N3=$P($P(C0I2,"qualifier[",2),"]",1) ; [y] value
 . . . . S OARY(C0N1,C0N2,"qualifier",C0N3)=C0V
 . . I C0I2["measurements.measurement[" D  Q  ;
 . . . N C0VN S C0VN=$P(C0I2,"]",2) ; @variableName
 . . . S C0N2=$P($P(C0I2,"measurements.measurement[",2),"]",1) ; [x] value
 . . . S OARY(C0N1,C0N2,"measurement"_C0VN)=C0V
 . . . W:$G(C0DEBUG) !,"found measurement: ",C0VN," ",C0I2
 . . E  I C0I2["measurements.measurement@" D  Q  ;
 . . . N C0VN S C0VN=$P(C0I2,"measurements.",2)
 . . . S OARY(C0N1,1,C0VN)=C0V
 . . . W:$G(C0DEBUG) !,"found solo measurement: ",C0VN," ",C0I2
 . . S OARY(C0N1,C0I2)=C0V
 I $D(C0DEBUG) B
 Q
 ;
TVITSEC ;
 ;;<component>
 ;;<section classCode="DOCSECT" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.4.1"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.2.4.1" extension="2015-08-01"></templateId>
 ;;<code code="8716-3" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Vital Signs"></code>
 Q
 ;
TVITORG ; vitals organizer
 ;;<entry>
 ;;<organizer classCode="CLUSTER" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.26"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.26" extension="2015-08-01"></templateId>
 ;;<id root="@@guid1@@"></id>
 ;;<code code="46680005" codeSystem="2.16.840.1.113883.6.96" codeSystemName="SNOMED" displayName="vital signs">
 ;;<translation code="74728-7" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Vital signs, weight, height, head circumference, oximetry, BMI, and BSA panel - HL7.CCDAr1.1" />
 ;;</code>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime value="@@vitalDateTime@@"></effectiveTime>
 Q
 ;
TVITOBS ; vitals observation
 ;;<component>
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.27"></templateId>
 ;;<templateId root="2.16.840.1.113883.10.20.22.4.27" extension="2014-06-09"></templateId>
 ;;<id root="@@guid2@@"></id>
 ;;<code code="@@vitalsCode@@" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="@@vitalsName@@">
 ;;<originalText>@@measurement@name@@</originalText>
 ;;</code>
 ;;<text mediaType="text/plain">
 ;;<reference value="@@vitalsRef@@"></reference>
 ;;</text>
 ;;<statusCode code="completed"></statusCode>
 ;;<effectiveTime value="@@vitalDateTime@@"></effectiveTime>
 ;;<value unit="@@measurement@units@@" value="@@measurement@value@@" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="PQ"></value>
 ;;<entryRelationship contextConductionInd="true" typeCode="REFR">
 ;;<observation classCode="OBS" moodCode="EVN">
 ;;<code code="48766-0" codeSystem="2.16.840.1.113883.6.1" codeSystemName="LOINC" displayName="Information source"></code>
 ;;<statusCode code="completed"></statusCode>
 ;;<value xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ST">@@vitalSource@@</value>
 ;;</observation>
 ;;</entryRelationship>
 ;;</observation>
 ;;</component>
 Q
 ;
TORGEND ;
 ;;</organizer>
 ;;</entry>
 Q
 ;
TVITEND ;
 ;;</section>
 ;;</component>
 Q
 ;
