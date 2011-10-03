PSULRHL1 ;HCIOFO/BH/RDC - Process real time HL7 Lab messages ; 1/10/11 8:10am
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**3,11,16,18**;MARCH, 2005;Build 7
 ;
 ; DBIA 3565 to subscribe to the LR7O ALL EVSEND RESULTS protocol
 ; DBIA 998 to dig through ^DPT(i,"LR" go get the ien to file #63
 ; DBIA 91-A to dig through ^LAB(60 to get the name of the test
 ; DBIA 3630 to call the HL7 PID builder
 ; DBIA 4727 to call EN^HLOCNRT
 ; DBIA 3646 to call API: $$EMPL^DGSEC4
 ; DBIA 4658 to call API: $$TSTRES^LRRPU
 ;
 ; This program is called when a lab test is verified. If it is for a
 ; chemistry test, and patient is a Veteran, an HL7 message will
 ; be created and sent to the national PBM Lab database.
 ;
 ;
HL7 ; Entry point for PBM processing - triggered by lab protocol 
 ; LR7O ALL EVSEND RESULTS.
 ;
 ;*18 Added PSUDIV
 N ARR,FIRST,LRDFN,PSUEXT,PSUHLFS,PSUHLECH,PSUHLCS,PSUDIV
 ;
 ;  OREMSG is the pointer reference to the global that contains the
 ;  lab data and is passed in by the LR7O ALL EVSEND RESULTS protocol.
 ;  
 I '$D(@OREMSG) Q
 ;
 ; Get Lab parameters
 ;
 D INIT^HLFNC2("PSU-SITE-DRIVER",.PSUHL)
 ;
 ; Set up CS delimeter for the Pharmacy message
 ;
 S PSUHL("CS")=$E(PSUHL("ECH"),1)
 ;
 ; Set up segment processing parameters 
 ;
 S PSUEXT("PSUBUF")=$NA(^TMP("HLS",$J))
 S PSUEXT("PSUPTR")=0
 ;
 ; Get the delimiters that the passed in lab data is using
 ;
 D PARAMS
 S PSUHLECH=$G(ARR("PSUHLECH"),"^~\&")
 S PSUHLCS=$E(PSUHLECH,1)
 ;
 ; Quit if no DFN
 ;
 I '$D(ARR) Q
 I ARR("DFN")=0!(ARR("DFN")="") Q
 ;
 ; *16 - Quit if patient is an employee & Non-Veteran 
 ;
 N DFN,VAEL S DFN=ARR("DFN") D ELIG^VADPT
 I $$EMPL^DGSEC4(DFN,"PS"),'VAEL(4) Q
 ;
 ; Get Lab's equivalent of a DFN (LRDFN)
 ;
 S LRDFN=$P(^DPT(ARR("DFN"),"LR"),"^")  ; DBIA 998 to get file #63 ien
 ;
 ; Loop through the lab data 
 ;
 S FIRST=1
 D LOOP
 ;
 ; Generate an HL7 if data exists to be sent
 ;
 I 'FIRST D GENERATE
 ;
 K PSUHL,ERR,OPTNS,ERR
 ;
 Q
 ;
LOOP ;
 N CNT,LRIDT,LRSS,PREV1,PREV2,QUIT1,QUIT2,REC,REC1,REC2,SEG,SEG1,SEG2,STR1
 K ^TMP("HLS",$J)
 S CNT=0
 F  Q:CNT=""  S CNT=$O(@OREMSG@(CNT)) Q:'CNT  D
 . S REC=@OREMSG@(CNT)
 . S REC=$$STRING(REC,CNT)
 . S SEG=$P(REC,PSUHLFS,1)
 . I SEG'="ORC" Q
 . S STR1=$P(REC,PSUHLFS,4)
 . S STR1=$P(STR1,PSUHLCS,1)
 . S LRSS=$P(STR1,";",4)
 . ;
 . ; Quit if data is not for Chemistry
 . ;
 . I LRSS'="CH" Q
 . S LRIDT=$P(STR1,";",5)
 . S QUIT1=0
 . F  Q:QUIT1!(CNT="")  S PREV1=CNT,CNT=$O(@OREMSG@(CNT)) Q:'CNT  D
 . . S REC1=@OREMSG@(CNT)
 . . S REC1=$$STRING(REC1,CNT)
 . . S SEG1=$P(REC1,PSUHLFS,1)
 . . I SEG1="ORC" S CNT=PREV1,QUIT1=1 Q
 . . I SEG1'="OBR" Q
 . . ; If this is the first OBR being processed i.e. this is valid 
 . . ; chemistry data set the PID segment
 . . ;*18 Include ORC segment
 . . I FIRST D PID,ORC S FIRST=0
 . . D OBR(REC1)
 . . S QUIT2=0
 . . F  Q:QUIT2  S PREV2=CNT,CNT=$O(@OREMSG@(CNT)) Q:'CNT  D
 . . . S REC2=@OREMSG@(CNT)
 . . . S REC2=$$STRING(REC2,CNT)
 . . . S SEG2=$P(REC2,PSUHLFS,1)
 . . . I SEG2="OBR"!(SEG2="ORC") S CNT=PREV2,QUIT2=1 Q
 . . . I SEG2'="OBX" Q
 . . . D OBX(REC2)
 Q
 ;
PID ;  Create the PID segment using the standard builder
 ;
 N K1,NEWSEG,SEG
 S SEG="SEG"
 D BLDPID^VAFCQRY(ARR("DFN"),1,"1,2,3",.SEG,.PSUHL,.ERR)
 ;
 ; Loop through the returned array just in case the data is spread over
 ; more than one node
 ;
 S K1="",NEWSEG=""
 F  S K1=$O(SEG(K1)) Q:'K1  D
 . S NEWSEG=NEWSEG_SEG(K1)
 ;
 ; Set the data string into the PBM HL7 array
 ;
 D SETSEG(NEWSEG)
 ;
 Q
 ;
ORC ; ORC needed to send Station Number. PSU*4*18
 N ORCSEG,STATION,SEG
 S ORCSEG="ORC"
 ;
 ; Retrieve station number using the division #
 S STATION=$$GET1^DIQ(4,$G(PSUDIV),99)
 ;
 S $P(SEG,PSUHL("CS"),14)=STATION
 S $P(ORCSEG,PSUHL("FS"),11)=SEG
 ;
 ; Put the string into the PBM HL7 global
 ;
 D SETSEG(ORCSEG)
 ;
 Q
 ;
OBR(REC) ;  Re-forms lab OBR to only send required data
 ;
 N OBRSEG,SITE,SPECDATE
 S OBRSEG="OBR"
 S SPECDATE=$P(REC,PSUHLFS,8)
 S SITE=$P(REC,PSUHLFS,16)
 S SITE=$TR(SITE,PSUHLCS,PSUHL("CS"))
 ;
 ; Create new OBR Segment and pass to SETSEG
 ;
 S $P(OBRSEG,PSUHL("FS"),8)=SPECDATE
 S $P(OBRSEG,PSUHL("FS"),16)=SITE
 ;
 ; Set the data string into the PBM HL7 array
 ;
 D SETSEG(OBRSEG)
 ;
 Q
 ;
OBX(REC) ;  Reforms lab OBX to only send the data needed
 N CODES,HRANGE,LABS,LNAME,LR60,LRANGE,LRDN,LOINC,LOINCS,P2,P3,P12,RANGE,RES,RESULTS,SEG,UNITS
 ;
 S P2=$P(REC,PSUHLFS,2)
 S P3=$P(REC,PSUHLFS,3)
 S P12=$P(REC,PSUHLFS,12)
 S RESULTS=$P(REC,PSUHLFS,6)
 S UNITS=$P(REC,PSUHLFS,7)
 S LABS=$TR($P(REC,PSUHLFS,4),"~","_")
 S LR60=$P(LABS,"^",4)
 I LR60']"" Q
 S LRDN=$G(^LAB(60,LR60,0))
 S LRDN=$P($P(LRDN,"^",5),";",2)   ;  DBIA 91 for data name
 ;
 ; Make the call to LRRPU to get the LOINC code for this test
 ;
 I LRDN']"" Q
 S RES=$$TSTRES^LRRPU(LRDFN,LRSS,LRIDT,LRDN,LR60,1)
 ;
 S CODES=$P(RES,U,8),LOINCS=$P(CODES,"!",3)
 S LOINC=$P(LOINCS,";",1),LNAME=$P(LOINCS,";",2)
 S LRANGE=$P(RES,U,3),HRANGE=$P(RES,U,4)
 S RANGE=LRANGE_"-"_HRANGE I RANGE="-" S RANGE=""
 ;
 ; Use the Pharmacy HL7 delimeters
 ;
 S LABS=$TR(LABS,PSUHLCS,PSUHL("CS"))
 ;
 ; Add LOINC to the list of Labs if it exists
 ;
 I LOINC'="" D
 . ;
 . ; Append the LOINC data using the pharmacy delimiters
 . S LABS=LABS_PSUHL("CS")_LOINC_PSUHL("CS")_LNAME_PSUHL("CS")_"99LN"
 ;
 ; Put the data in the string
 ;
 S SEG="OBX"
 S $P(SEG,PSUHL("FS"),2)=P2
 S $P(SEG,PSUHL("FS"),3)=P3
 S $P(SEG,PSUHL("FS"),4)=LABS
 S $P(SEG,PSUHL("FS"),6)=RESULTS
 S $P(SEG,PSUHL("FS"),7)=UNITS
 S $P(SEG,PSUHL("FS"),8)=RANGE
 S $P(SEG,PSUHL("FS"),12)=P12
 ;
 ; Put the string into the PBM HL7 global
 ;
 D SETSEG(SEG)
 ;
 Q
 ;
STRING(HLSTR,CNT) ;  Loops through sub nodes to create a full data string
 N J
 S J=""
 F  S J=$O(@OREMSG@(CNT,J))  Q:J=""  S HLSTR=HLSTR_@OREMSG@(CNT,J)
 Q HLSTR
 ;
PARAMS ; Get the delimiters used in the lab data
 ;
 N CNT,ID,QUIT,REC,RES
 K ARR
 S (QUIT,CNT)=0,RES=""
 F  S CNT=$O(@OREMSG@(CNT)) Q:'CNT!(QUIT=2)  D
 . S REC=@OREMSG@(CNT)
 . I $E(REC,1,3)="MSH" D  Q
 . . S PSUHLFS=$E(REC,4,4)
 . . S PSUDIV=$P(REC,PSUHLFS,4) ;Get Division # PSU*18
 . . S ARR("PSUHLECH")=$P(REC,PSUHLFS,2),QUIT=QUIT+1
 . I $P(REC,PSUHLFS,1)="PID" D  Q
 . . S ARR("DFN")=$P(REC,PSUHLFS,4)
 . . S QUIT=QUIT+1
 Q
 ;
GENERATE ; Generate HL7 message
 ;
 ; D GENERATE^HLMA("PSU-SITE-DRIVER","GM",1,.RESULT,"",.OPTNS)
 S OPTNS("QUEUE")="PBM LAB"
 S RESULT=$$EN^HLOCNRT("PSU-SITE-DRIVER","GM",.OPTNS)
 I +RESULT'=RESULT D
 . S ^XTMP("PBM/HLO",DT,$J)=RESULT
 K ^TMP("HLS",$J)
 Q
 ;
 ;
SETSEG(SEG) ;
 ;
 ;***** STORES THE SEGMENT INTO THE ^TMP("HLS",$J) BUFFER
 ;
 ; SEG           HL7 segment
 ;
 ; The SETSEG procedure stores the HL7 segment into the
 ; standard HL7 buffer ^TMP("HLS",$J). The <TAB>, <CR> and <LF>
 ; characters are replaced with spaces. Long segments are split among 
 ; sub-nodes of the main segment node.
 ;
 ; The PSUEXT array must be initialized before
 ; calling this function.
 ;
 N I1,I2,MAXLEN,NODE,PTR,PTR1,SID,SL
 S NODE=PSUEXT("PSUBUF"),PTR=$G(PSUEXT("PSUPTR"))+1
 S SL=$L(SEG),MAXLEN=245  K @NODE@(PTR)
 ;--- Store the segment
 S @NODE@(PTR)=$TR($E(SEG,1,MAXLEN),$C(9,10,13),"   ")
 ;
 ;--- Split the segment into sub-nodes if necessary
 D:SL>MAXLEN
 . S I2=MAXLEN
 . F PTR1=1:1  S I1=I2+1,I2=I1+MAXLEN-1  Q:I1>SL  D
 . . S @NODE@(PTR,PTR1)=$TR($E(SEG,I1,I2),$C(9,10,13),"   ")
 ;--- Save the pointer
 S PSUEXT("PSUPTR")=PTR
 Q
