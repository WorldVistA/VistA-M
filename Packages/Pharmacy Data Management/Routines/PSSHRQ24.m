PSSHRQ24 ;WOIFO/AV,TS,SG,CF - Parses out drugsNotChecked and DrugDoseCheck XML (cont) ;09/20/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**178,206,224**;9/30/97;Build 3
 ;
 ; @authors - Alex Vazquez, Tim Sabat, Steve Gordon, Chris Flegel
 ; @date    - June 23, 2014
 ; @version - 1.0
 ;
 QUIT
 ;
DOSEWRIT(HASH,BASE) ;
 ; @DESC Handles writing the drug dose output global
 ;
 ; @HASH Variable containing drug dose values
 ; @BASE Base of output global
 ;
 ; @RETURNS Nothing
 ;
 NEW I,NODE,QT,IEN,PSSFSCO,PSSFSCB,PSSFSCN,PSSFSCI
 ;get dose form flag
 ;
 SET QT=""""
 SET I=""
 FOR  SET I=$ORDER(HASH(I)) QUIT:I=""!('I)  DO
 . SET NODE="^TMP($JOB,BASE,""OUT"",""DOSE"",HASH(I,""orderNumber""),HASH(I,""drugName""))"
 . SET IEN=HASH(I,"ien")
 . ;
 . ; Single values
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"singleDoseStatus") SET @NODE@("SINGLE","STATUS",IEN)=HASH(I,"singleDoseStatus")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"singleDoseStatusCode") SET @NODE@("SINGLE","STATUSCODE",IEN)=HASH(I,"singleDoseStatusCode")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"singleDoseMessage") SET @NODE@("SINGLE","MESSAGE",IEN)=HASH(I,"singleDoseMessage")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"singleDoseMax") SET @NODE@("SINGLE","MAX",IEN)=HASH(I,"singleDoseMax")
 . ; Range values
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"rangeDoseLow") SET @NODE@("RANGE","LOW",IEN)=HASH(I,"rangeDoseLow")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"rangeDoseHigh") SET @NODE@("RANGE","HIGH",IEN)=HASH(I,"rangeDoseHigh")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"rangeDoseStatus") SET @NODE@("RANGE","STATUS",IEN)=HASH(I,"rangeDoseStatus")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"rangeDoseStatusCode") SET @NODE@("RANGE","STATUSCODE",IEN)=HASH(I,"rangeDoseStatusCode")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"rangeDoseMessage") SET @NODE@("RANGE","MESSAGE",IEN)=HASH(I,"rangeDoseMessage")
 . ;set general dose form data
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"doseFormHigh") SET @NODE@("GENERAL","DOSEFORMHIGH",IEN)=HASH(I,"doseFormHigh")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"doseFormHighUnit") SET @NODE@("GENERAL","DOSEFORMHIGHUNIT",IEN)=HASH(I,"doseFormHighUnit")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"doseFormLow") SET @NODE@("GENERAL","DOSEFORMLOW",IEN)=HASH(I,"doseFormLow")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"doseFormLowUnit") SET @NODE@("GENERAL","DOSEFORMLOWUNIT",IEN)=HASH(I,"doseFormLowUnit")
 . ; General subscript values
 . SET @NODE@("GENERAL","DOSEHIGH",IEN)=HASH(I,"doseHigh")
 . SET @NODE@("GENERAL","DOSEHIGHUNIT",IEN)=HASH(I,"doseHighUnit")
 . SET @NODE@("GENERAL","DOSELOW",IEN)=HASH(I,"doseLow")
 . SET @NODE@("GENERAL","DOSELOWUNIT",IEN)=HASH(I,"doseLowUnit")
 . SET @NODE@("GENERAL","DOSEROUTEDESCRIPTION",IEN)=HASH(I,"doseRouteDescription")
 . SET @NODE@("GENERAL","MESSAGE",IEN)=$$BUILDMSG^PSSHRQ25(I,.HASH)
 . ; "CHEMO" value, if any
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"chemoInjectable") SET @NODE@("CHEMO")=HASH(I,"chemoInjectable")
 . ; Daily values
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"dailyDoseStatus") SET @NODE@("DAILY","STATUS",IEN)=HASH(I,"dailyDoseStatus")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"dailyDoseStatusCode") SET @NODE@("DAILY","STATUSCODE",IEN)=HASH(I,"dailyDoseStatusCode")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"dailyDoseMessage") SET @NODE@("DAILY","MESSAGE",IEN)=HASH(I,"dailyDoseMessage")
 . ; Max Daily values
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"maxDailyDoseStatus") SET @NODE@("DAILYMAX","STATUS",IEN)=HASH(I,"maxDailyDoseStatus")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"maxDailyDoseStatusCode") SET @NODE@("DAILYMAX","STATUSCODE",IEN)=HASH(I,"maxDailyDoseStatusCode")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"maxDailyDoseMessage") SET @NODE@("DAILYMAX","MESSAGE",IEN)=HASH(I,"maxDailyDoseMessage")
 . ; general maximum life  time dose
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"maxLifetimeDose") SET @NODE@("MAXLIFETIME","DOSE",IEN)=HASH(I,"maxLifetimeDose")
 . ; Frequency values, if any
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"frequencyStatus") SET @NODE@("FREQ","FREQUENCYSTATUS",IEN)=HASH(I,"frequencyStatus")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"frequencyStatusCode") SET @NODE@("FREQ","FREQUENCYSTATUSCODE",IEN)=HASH(I,"frequencyStatusCode")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"frequencyMessage") SET @NODE@("FREQ","FREQUENCYMESSAGE",IEN)=HASH(I,"frequencyMessage")
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"frequencyHigh") SET @NODE@("FREQ","FREQUENCYHIGH",IEN)=HASH(I,"frequencyHigh") D CSTMFREQ(.HASH,I,NODE,IEN)
 . I $$CHKVAL^PSSHRQ23(.HASH,I,"frequencyLow") SET @NODE@("FREQ","FREQUENCYLOW",IEN)=HASH(I,"frequencyLow") D CSTMFREQ(.HASH,I,NODE,IEN)
 . ; dose percent elements
 . D:$D(HASH(I,"single"))=10 WRITEDSP^PSSHRQ2D(NODE,.HASH,I,IEN,"single","","")
 . D:$D(HASH(I,"rangeLow"))=10 WRITEDSP^PSSHRQ2D(NODE,.HASH,I,IEN,"rangeLow","","")
 . D:$D(HASH(I,"rangeHigh"))=10 WRITEDSP^PSSHRQ2D(NODE,.HASH,I,IEN,"rangeHigh","","")
 . D:$D(HASH(I,"daily"))=10 WRITEDSP^PSSHRQ2D(NODE,.HASH,I,IEN,"daily","","")
 . D:$D(HASH(I,"maxDaily"))=10 WRITEDSP^PSSHRQ2D(NODE,.HASH,I,IEN,"maxDaily","DAILYMAX","")
 . D:$D(HASH(I,"maxLifetime"))=10 WRITEDSP^PSSHRQ2D(NODE,.HASH,I,IEN,"maxLifetime","","")
 . D:$D(HASH(I,"maxLifetimeOrder"))=10 WRITEDSP^PSSHRQ2D(NODE,.HASH,I,IEN,"maxLifetimeOrder","","")
 . ;;
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxLifetimeOrderMessage") @NODE@("MAXLIFETIMEORDER","MESSAGE",IEN)=HASH(I,"maxLifetimeOrderMessage")
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxLifetimeOrderStatus") @NODE@("MAXLIFETIMEORDER","STATUS",IEN)=HASH(I,"maxLifetimeOrderStatus")
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxLifetimeOrderStatusCode") @NODE@("MAXLIFETIMEORDER","STATUSCODE",IEN)=HASH(I,"maxLifetimeOrderStatusCode")
 . ;;
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxSingleNTEDose") @NODE@("MAXSINGLENTE","DOSE",IEN)=HASH(I,"maxSingleNTEDose")
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxSingleNTEDoseUnit") @NODE@("MAXSINGLENTE","DOSEUNIT",IEN)=HASH(I,"maxSingleNTEDoseUnit")
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxSingleNTEDoseForm") @NODE@("MAXSINGLENTE","DOSEFORM",IEN)=HASH(I,"maxSingleNTEDoseForm")
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxSingleNTEDoseFormUnit") @NODE@("MAXSINGLENTE","DOSEFORMUNIT",IEN)=HASH(I,"maxSingleNTEDoseFormUnit")
 . ;;
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxDailyDose") @NODE@("DAILYMAX","DOSE",IEN)=HASH(I,"maxDailyDose")
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxDailyDoseUnit") @NODE@("DAILYMAX","DOSEUNIT",IEN)=HASH(I,"maxDailyDoseUnit")
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxDailyDoseForm") @NODE@("DAILYMAX","DOSEFORM",IEN)=HASH(I,"maxDailyDoseForm")
 . S:$$CHKVAL^PSSHRQ23(.HASH,I,"maxDailyDoseFormUnit") @NODE@("DAILYMAX","DOSEFORMUNIT",IEN)=HASH(I,"maxDailyDoseFormUnit")
 . ;;
 .;
 .; -- in 2.1 if max daily dose frequency out of range flag=1 perform max daily dose check
 . I $G(HASH(I,"orderNumber"))]"",$P($G(PSSDBCAR($G(HASH(I,"orderNumber")))),"^",29) D
 . . S PSSFSCO=HASH(I,"orderNumber"),PSSFSCB=BASE,PSSFSCN=HASH(I,"drugName"),PSSFSCI=HASH(I,"ien") D MAXD^PSSDSUTA(PSSFSCO,PSSFSCB,PSSFSCN,PSSFSCI,.PSSDBCAR)
 . QUIT
 ;
 QUIT
 ;;
CSTMFREQ(HASH,I,NODE,IEN) ;; build customized frequency message
 N MSG,LOW,LOWI,LOWS,LOWR,LOWSWAP,HIGH,HIGHI,HIGHS,HIGHR,HIGHSWAP
 Q:$D(@NODE@("FREQ","FREQUENCYCUSTOMMESSAGE",IEN))
 S (LOWS,HIGHS)=0
 S MSG="Recommended frequency of "_$G(HASH(I,"drugName"))
 S LOW=$G(HASH(I,"frequencyLow"))
 S:+$P(LOW,".",2)=0 LOW=$P(LOW,".")
 S HIGH=$G(HASH(I,"frequencyHigh"))
 S:+$P(HIGH,".",2)=0 HIGH=$P(HIGH,".")
 I (LOW="")!(HIGH="")!(+LOW=0)!(+HIGH=0)!(+LOW<0)!(+HIGH<0) S @NODE@("FREQ","FREQUENCYCUSTOMMESSAGE",IEN)=MSG_" is unavailable." Q
 D:LOW<1 
 .S LOWI=+$P(1/LOW,".",1)
 .S LOWR=$E(+$P(1/LOW,".",2),1)
 .S LOWR=$S(LOWR>4:1,1:0)
 .S LOW=LOWI+LOWR
 .S LOWS=1
 D:HIGH<1 
 .S HIGHI=+$P(1/HIGH,".",1)
 .S HIGHR=$E(+$P(1/HIGH,".",2),1)
 .S HIGHR=$S(HIGHR>4:1,1:0)
 .S HIGH=HIGHI+HIGHR
 .S HIGHS=1
 D:(HIGH<LOW)&(LOWS=1)&(HIGHS=1)
 .S HIGHSWAP=HIGH
 .S LOWSWAP=LOW
 .S LOW=HIGHSWAP
 .S HIGH=LOWSWAP
 I HIGH=LOW D 
 .I HIGHS=0 S MSG=MSG_" is "_HIGH_" time(s) per day."
 .E  S MSG=MSG_" is every "_HIGH_" days."
 .Q 
 I HIGH'=LOW  D 
 .I LOWS+HIGHS=0 S MSG=MSG_" is "_LOW_" to "_HIGH_" times per day." Q
 .I (LOWS=1)&(HIGHS=0) D  Q
 ..S:LOW'=1 MSG=MSG_" is every "_LOW_" day(s) to "_HIGH_" time(s) per day."
 ..S:LOW=1 MSG=MSG_" is "_LOW_" to "_HIGH_" time(s) per day."
 .S MSG=MSG_" is every "_LOW_" day(s) to "_HIGH_" days."
 .Q
 S @NODE@("FREQ","FREQUENCYCUSTOMMESSAGE",IEN)=MSG
 Q
 ;;
