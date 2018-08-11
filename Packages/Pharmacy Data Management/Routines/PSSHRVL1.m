PSSHRVL1 ;WOIFO/Alex Vasquez, Timothy Sabat, Steve Gordon - Continuation Data Validation routine for drug checks ;01/15/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136,169,160,173,178,224**;9/30/97;Build 3
 ;
 ; Reference to ^PSNDF(50.68 supported by IA #2079
 ; Reference to ^PSNDF(50.68 supported by IA #3735
 ; 
NEXTEX(PSS,PSSHASH) ;
 ;@DESC Gets the next exception
 ;@PSS The temp hash
 ;@PSSHASH The internal hash
 ;
 N PSNEXT
 S PSNEXT=":"
 S PSNEXT=$ORDER(^TMP($JOB,PSSHASH("Base"),"OUT","EXCEPTIONS",PSS("PharmOrderNo"),PSNEXT),-1)
 Q PSNEXT+1
 ;;
NEXTEXD(PSS,PSSHASH) ;
 ;@DESC Gets the next dose exception
 ;@PSS The temp hash
 ;@PSSHASH The internal hash
 N PSNEXT
 S PSNEXT=":"
 S PSNEXT=$ORDER(^TMP($JOB,PSSHASH("Base"),"OUT","EXCEPTIONS","DOSE",PSS("PharmOrderNo"),PSNEXT),-1)
 Q PSNEXT+1
 ;;
WRITE(PSSHASH) ;
 ;@Writes a response, based on the list of exceptions stored in Hash
 ;@NOTE The internal hash looks like this:
 ;PSSHASH("Exception","PROSPECTIVE","DOSE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText,NoWrite
 ;PSSHASH("Exception","PROSPECTIVE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText,NoWrite
 ;PSSHASH("Exception","PROFILE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText,NoWrite
 ;PSSHASH("Exception","PatientIenMissing")=""
 ;PSSHASH("Reason")="Failed Validation"
 ;
 ;
 NEW PSS
 SET PSS("PharmOrderNo")=""
 SET PSS("I")=""
 FOR  SET PSS("PharmOrderNo")=$ORDER(PSSHASH("Exception","PROFILE",PSS("PharmOrderNo"))) QUIT:PSS("PharmOrderNo")=""  DO 
  . FOR  SET PSS("I")=$ORDER(PSSHASH("Exception","PROFILE",PSS("PharmOrderNo"),PSS("I"))) QUIT:PSS("I")=""  DO
  . . DO WPROFILE(.PSSHASH,.PSS)
  . . QUIT
  . QUIT
 ;
 SET PSS("PharmOrderNo")=""
 SET PSS("I")=""
 FOR  SET PSS("PharmOrderNo")=$ORDER(PSSHASH("Exception","PROSPECTIVE","DOSE",PSS("PharmOrderNo"))) QUIT:PSS("PharmOrderNo")=""  DO 
  . FOR  SET PSS("I")=$ORDER(PSSHASH("Exception","PROSPECTIVE","DOSE",PSS("PharmOrderNo"),PSS("I"))) QUIT:PSS("I")=""  DO
  . . DO WDOSE(.PSSHASH,.PSS)
  . . ;kill off node to prevent next loop from setting PSS("PharmOrderNo") to "DOSE"
  . . K PSSHASH("Exception","PROSPECTIVE","DOSE",PSS("PharmOrderNo"),PSS("I"))
  . QUIT
 ;
 SET PSS("PharmOrderNo")=""
 SET PSS("I")=""
 FOR  SET PSS("PharmOrderNo")=$ORDER(PSSHASH("Exception","PROSPECTIVE",PSS("PharmOrderNo"))) QUIT:PSS("PharmOrderNo")=""  DO 
  . FOR  SET PSS("I")=$ORDER(PSSHASH("Exception","PROSPECTIVE",PSS("PharmOrderNo"),PSS("I"))) QUIT:PSS("I")=""  DO
  . . DO WPROSPEC(.PSSHASH,.PSS)
  . QUIT
 ;
 QUIT
 ;;
WDOSE(PSSHASH,PSS) ;
 ;@DESC Writes the dose exceptions out.
 ;@PSSHASH The internal hash
 ;@PSS The temp hash
 ;@NOTE The exception hash looks like this.
 ;PSSHASH("Exception","PROSPECTIVE","DOSE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText
 ;
 NEW TYPE,I
 SET PSS("DoseValue")=$G(^TMP($JOB,PSSHASH("Base"),"IN","DOSE",PSS("PharmOrderNo")))
 ;Set the next exception
 D:$P(PSSHASH("Exception","PROSPECTIVE","DOSE",PSS("PharmOrderNo"),PSS("I")),U,11)'=1
 .S ^TMP($JOB,PSSHASH("Base"),"OUT","EXCEPTIONS","DOSE",PSS("PharmOrderNo"),$$NEXTEXD(.PSS,.PSSHASH))=PSSHASH("Exception","PROSPECTIVE","DOSE",PSS("PharmOrderNo"),PSS("I"))
 QUIT
 ;;
WPROFILE(PSSHASH,PSS) ;
 ;@DESC Writes the profile drug exceptions out.
 ;@PSSHASH The internal hash
 ;@PSS The temp hash
 ;Kill the corresponding profile drug
 ;KILL ^TMP($JOB,PSSHASH("Base"),"IN","PROFILE",PSS("PharmOrderNo"))
 ;Set the exception in the global
 S:$P(PSSHASH("Exception","PROFILE",PSS("PharmOrderNo"),PSS("I")),U,11)'=1 ^TMP($JOB,PSSHASH("Base"),"OUT","EXCEPTIONS",PSS("PharmOrderNo"),$$NEXTEX(.PSS,.PSSHASH))=PSSHASH("Exception","PROFILE",PSS("PharmOrderNo"),PSS("I"))
 ;If no profile drugs left and the proVpro flag exists, delete it.
 DO:'$DATA(^TMP($JOB,PSSHASH("Base"),"IN","PROFILE"))
  . ;KILL ^TMP($JOB,PSSHASH("Base"),"IN","PROFILEVPROFILE")
  .  D KILLCHEK(PSSHASH("Base"),"PROFILEVPROFILE")
  . QUIT
 QUIT
 ;;
WPROSPEC(PSSHASH,PSS) ;
 ;@DESC Writes the prospective drug exceptions out.
 ;@PSSHASH The internal hash
 ;@PSS The temp hash
 ;@NOTE Exception Hash Looks Like
 ;PSSHASH("Exception","PROSPECTIVE","DOSE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText
 ;PSSHASH("Exception","PROSPECTIVE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText
 ;
 ;Set the exception data
 S:$P(PSSHASH("Exception","PROSPECTIVE",PSS("PharmOrderNo"),PSS("I")),U,11)'=1 ^TMP($JOB,PSSHASH("Base"),"OUT","EXCEPTIONS",PSS("PharmOrderNo"),$$NEXTEX(.PSS,.PSSHASH))=PSSHASH("Exception","PROSPECTIVE",PSS("PharmOrderNo"),PSS("I"))
 QUIT
 ;
KILLALL(BASE) ;
 ;INPUTS BASE SUBCRIPT
 ;@DESC Kills the DrugDrug, Therapy, ProfileVProfile, and Dose check nodes.
 DO KILLCHEK("DRUGDRUG",BASE)
 DO KILLCHEK("THERAPY",BASE)
 DO KILLCHEK("PROFILEVPROFILE",BASE)
 DO KILLCHEK("DOSE",BASE)
 QUIT
 ;;
KILLCHEK(PSSCHECK,BASE) ;
 ;@DESC Kills the check node specified in parameter
 ;@PSSCHEK The node to kill
 ;
 KILL ^TMP($JOB,BASE,"IN",PSSCHECK)
 QUIT
 ;
 ;
KILLNODE(BASE,TYPE,ORDER) ;
 ;
 ;@DESC KILLS A SINGLE NODE FOR A DRUG
 ;@BASE--the subscript after $JOB
 ;@TYPE-Can have 3 possible values: "PROSPECTIVE","PROFILE" or "DOSE"
 ;@ODRDER-Is the order information to make the node unique
 KILL ^TMP($JOB,BASE,"IN",TYPE,ORDER)
 Q
 ;
GCNREASN(DRUGIEN,DRUGNM,ORDRNUM,BADGCN) ;
 ;
 ;Returns a message and reason on why a drug does not have a GCNSEQNO
 ;inputs: DRUGIEN-IEN OF DRUG
 ;DRUGNM-NAME OF DRUG
 ;ORDRNUM-PHARMACY ORDER NUM
 ;BADGCN-(OPTIONAL)FLAG IS SET to 1 IF DRUG RETURNED AS NOT FOUND BY SWRI/FDB
 ;        if set to -1 Missing or invalid GCNSEQNO  from Input node  
 N VAPROD1,NDNODE,REASON,MESSAGE,VAIEN,PSSVQPAC,PSSVQDOS,PSSVQNOM,PSSVQREM,PSSVQTY1,PSSVQTY2,PSSREASN
 S MESSAGE=$$NOCHKMSG(DRUGNM,ORDRNUM),PSSVQDOS=0,PSSVQPAC=$S($E(PSSHASH("Base"),1,2)="PS":1,1:0) I $T(DS^PSSDSAPI)]"",$$DS^PSSDSAPI S PSSVQDOS=1
 S REASON="",PSSVQREM=$S($P(ORDRNUM,";")="R":1,1:0)
 S PSSVQTY1=$P(ORDRNUM,";",3),PSSVQTY1=$$UP^XLFSTR(PSSVQTY1),PSSVQTY2=$S(PSSVQTY1["PROSPECTIVE":1,1:0)
 ;
 S VAPROD1=""
 D  ;Case statement
 .I $G(BADGCN)=1 S MESSAGE=$$NXCHKMSG(DRUGNM) S PSSVQNOM=$$GCMESS,REASON=$S(PSSVQNOM:"^1",1:""),PSSREASN=1 Q
 .I '$G(DRUGIEN),'PSSVQREM S REASON="No dispense drug found for Orderable Item",PSSREASN=2 Q
 .S NDNODE=$G(^PSDRUG(DRUGIEN,"ND"))
 .;if no ndnode or 3rd piece not populated 
 .I 'PSSVQREM,'$L(NDNODE)!('$P(NDNODE,U,3)) D  Q
 ..S REASON="Drug not matched to NDF",PSSREASN=3 D:PSSVQPAC&($D(^TMP($J,PSSHASH("Base"),"IN","DOSE"))) NZMSG I 'PSSVQPAC S MESSAGE=$$NXCHKMSG(DRUGNM),REASON=""
 .S VAIEN=$S('PSSVQREM:+$P(NDNODE,U,3),1:0)
 .S:VAIEN VAPROD1=$P($G(^PSNDF(50.68,VAIEN,1)),U,5)    ; Get the GCNSEQNO
 .I 'VAPROD1!($G(BADGCN)=-1) D
 ..S MESSAGE=$$NXCHKMSG(DRUGNM) S PSSVQNOM=$$GCMESS,REASON=$S(PSSVQNOM:"^1",1:""),PSSREASN=4
 ;
 I PSSVQPAC=0,PSSVQTY2=1 D
 .S ^TMP($J,PSSHASH("Base"),"OR-TRANSIENT",DRUGIEN,DRUGNM,ORDRNUM,BADGCN)=MESSAGE_U_PSSREASN
 Q MESSAGE_U_REASON
 ;
NOCHKMSG(DRUGNM,ORDRNUM) ;
 ;Returns msg that no checks could be performed.
 ;INPUTS: 
 ;DRUGNM-Name of drug
 ;ORDRNUM-PHARMACY ORDER NUMBER
 N MESSAGE
 S MESSAGE="Enhanced Order Checks cannot be performed for "_$$LOCORREM(ORDRNUM)_$$OUTPAT(ORDRNUM)_" Drug: "_DRUGNM
 Q MESSAGE
 ;
OUTPAT(ORDRNUM) ;
 ; Returns " Outpatient" if it is one.
 ;INPUTS: 
 ;ORDRNUM-PHARMACY ORDER NUMBER
 ;PSSBASE - globally defined
 ;
 N OUTPAT
 S OUTPAT=""
 I $$LOCORREM(ORDRNUM)="Local" D
 .I $E(ORDRNUM)'="I",$E(ORDRNUM)'="R",ORDRNUM["PROFILE",$G(^TMP($J,PSSBASE,"IN","SOURCE"))="I" S OUTPAT=" Outpatient"
 Q OUTPAT
 ;
OIMSG(OINAME,PSSNOITN) ;
 ;INPUT: Orderable item name
 ;       Order number
 ;RETURNS-ERROR MESSAGE
 N MESSAGE,PSSNOITP,PSSNOITD,PSSNOIT1,PSSNOIT2
 S PSSNOITP=$S($E(PSSHASH("Base"),1,2)="PS":0,1:1)
 S PSSNOITD=0 I $T(DS^PSSDSAPI)]"",$$DS^PSSDSAPI S PSSNOITD=1
 S PSSNOIT1=$P(PSSNOITN,";",3),PSSNOIT1=$$UP^XLFSTR(PSSNOIT1),PSSNOIT2=$S(PSSNOIT1["PROSPECTIVE":1,1:0)
 I PSSNOITP D  Q MESSAGE
 .I $D(^TMP($J,PSSHASH("Base"),"IN","DOSE")) D  Q
 ..S MESSAGE="Maximum Single Dose Check could not be done for Drug: "_OINAME_", please complete a manual check for appropriate Dosing."
 .S MESSAGE="Order Checks could not be done for Drug: "_OINAME_", please complete a manual check for Drug Interactions"_$S(PSSNOITD&($G(PSSNOIT2)):", Duplicate Therapy and appropriate Dosing.",1:" and Duplicate Therapy.")
 S MESSAGE="Enhanced Order Checks cannot be performed for Orderable Item: "_OINAME
 Q MESSAGE
 ;
INRSON(ERRNUM,ORDERNUM) ;
 ;INPUT-REASON CODE (1,2 OR 3)
 ;ORDERNUM-(OPTIONAL)-ORDERNUMBER
 ;OUTPUT-REASON MESSAGE
 ;
 N REASON,NONVAFLG
 S NONVAFLG=0  ;DEFAULT
 S ORDERNUM=$G(ORDERNUM)
 I $E(ORDERNUM)="N" S NONVAFLG=1
 D
 .I ERRNUM=1 D  Q
 .. I 'NONVAFLG S REASON="No Dispense Drug found." Q   ; No active Dispense Drug found for Pending order. 
 .. I NONVAFLG S REASON="No Dispense Drug found."      ; No active Dispense Drug found for Non-VA med order.
 .I ERRNUM=2 S REASON="Free Text Dosage could not be evaluated." Q
 .I ERRNUM=3 S REASON="Free Text Infusion Rate could not be evaluated."
 .I ERRNUM=4 S REASON="No active IV Additive/Solution marked for IV fluid order entry could be found."
 Q REASON
 ;
DEMOCHK(AGE,BSA,WEIGHT,PSDRUG,WHERE) ;
 ;Checks age and returns message and error reason
 ;input: AGE--AGE
 ;BSA-BSA
 ;WEIGHT OF THE PATIENT
 ;WHERE value of PSSDSWHE (1 for OR, 0 for IP/OP) as determined by dosing API
 ;output: message and reason strings
 ;
 N PSMESSAGE,PSREASON,PSRESULT,TEXT,X,FLAG
 S PSRESULT="",PSREASON="",TEXT="",WHERE=$S(+$G(WHERE)=1:1,1:0),AGE=+$G(AGE),BSA=+$G(BSA),WEIGHT=+$G(WEIGHT)
 I AGE=0 D  Q PSRESULT
 .S TEXT=" AGE"
 .D:WHERE=0 
 ..S PSMESSAGE=$$DOSEMSG(PSDRUG)
 ..S PSREASON="One or more required patient parameters unavailable:"_TEXT
 .D:WHERE=1 
 ..S PSMESSAGE="Dosing checks could not be done for Drug: "_PSDRUG_", please complete a manual check for appropriate dosing."
 .S PSRESULT=PSMESSAGE_U_PSREASON
 Q PSRESULT
 ;
MEDRTE(PSROUTE,PSDRUGNM) ;
 ;Checks route if null
 ;inputs: ROUTE-MEDICATION ROUTE
 ;DRUGNM-DRUG NAME
 ;RETURNS THE ERROR MESSAGE AND ERROR REASON 
 N PSMESSAGE,PSREASON,PSRESULT
 S PSRESULT=""
 I '$L(PSROUTE) D
 .S PSMESSAGE=$$DOSEMSG(PSDRUGNM)
 .;S PSREASON="Unmapped Local Medication Route"
 .S PSREASON="Invalid or Undefined Dose Route"
 .S PSRESULT=PSMESSAGE_U_PSREASON
 Q PSRESULT
 ;
 ;
CHKDSTYP(DOSETYP,PSDRUGNM) ;
 ;inputs: DOSETYP-DOSE TYPE (MAINTENANCE,LOADING)
 ;PSDRUGNM-DRUG NAME
 ;RETURNS THE ERROR MESSAGE AND ERROR REASON 
 N PSREASON,PSRESULT,PSMSG,TEXT,OKFLAG
 S PSRESULT="",OKFLAG=0
 F TEXT="LOADING","MAINTENANCE","INITIAL DOSE","INTERMEDIATE DOSE","PROPHYLACTIC","SINGLE DOSE" D  Q:OKFLAG
 .I DOSETYP=TEXT S OKFLAG=1 Q
 I '$L(DOSETYP)!'OKFLAG D
 .S PSMSG=$$DOSEMSG(PSDRUGNM)
 .;S PSREASON="Undefined Dose Type"
 .S PSREASON="Invalid or Undefined Dose Type"
 .S PSRESULT=PSMSG_U_PSREASON
 Q PSRESULT
 ;
CHKDOSE(PSDOSE,PSDRUGNM) ;
 ;CHECKS THE DOSE OF DRUG DOSE REQUEST
 ;INPUTS: PSDOSE-ORDERED DOSE OF A DRUG
 ;PSDRUGNM=NAME OF DRUG
 ;RETURNS THE ERROR MESSAGE AND ERROR REASON
 N PSREASON,PSRESULT,PSMSG
 S PSRESULT=""
 I PSDOSE'=+PSDOSE D
 .S PSMSG=$$DOSEMSG(PSDRUGNM)
 .S PSREASON="Invalid or Undefined Dose"
 .S PSRESULT=PSMSG_U_PSREASON
 Q PSRESULT
 ;
CHKUNIT(PSUNIT,PSDRUGNM) ;
 ;CHECKS THE UNITS OF A DOSE-RETURNS ERROR AND REASON
 ;INPUTS: PSUNIT-UNITS OF THE DRUG
 ;PSDRUGNM-NAME OF THE DRUG
 N PSREASON,PSRESULT,PSMSG
 S PSRESULT=""
 I '$L(PSUNIT) D
 .S PSMSG=$$DOSEMSG(PSDRUGNM)
 .S PSREASON="Invalid or Undefined Dose Unit"
 .S PSRESULT=PSMSG_U_PSREASON
 Q PSRESULT
 ;
CHKFREQ(PSFREQ) ;
 ;INPUTS: PSFREQ-HOW OFTEN A DRUG IS ADMINISTRED
 ;RETURNS-ERROR MESSAGE AND ERROR REASON
 N PSREASON,PSRESULT,PSMSG
 S PSMSG="Daily Dosage Range Check could not be performed."
 S PSRESULT=""
 D
 .I '$L(PSFREQ) Q  ;Freq can be null
 .I '$$VALFREQ^PSSHFREQ(PSFREQ) D
 ..S PSREASON="Invalid or Undefined Frequency"
 ..S PSRESULT=PSMSG_U_PSREASON
 Q PSRESULT
 ;
CHKRATE(PSRATE,TYPE,DRUGNM,DURATION) ;
 ;INPUTS: PSRATE-Can be either dose or duration rate
 ;TYPE-DOSE OR DURATION
 ;DRUGNM-DRUG NAME
 ;DURATION-OPTIONAL DURATION NUMERIC
 S DURATION=$G(DURATION)
 ;output: returns error message and reason
 N OKFLAG,STDRATE,RESULT,REASON,PSMSG
 S RESULT=""
 S OKFLAG=0 ;ASSUME BAD
 D
 .I '$L(PSRATE),TYPE="DURATION",'$L(DURATION) Q  ;can be null for duration if duration is null
 .F STDRATE="H","HOUR","MINUTE","MIN","DAY" D  Q:OKFLAG
 ..I PSRATE=STDRATE S OKFLAG=1
 .I 'OKFLAG D
 ..S TYPE=$S(TYPE="DURATION":"Duration",TYPE="DOSE":"DOSE",1:"Duration or Dose")
 ..S REASON="Invalid or Undefined "_TYPE_" Rate"
 ..S PSMSG=$$DOSEMSG(DRUGNM)
 ..S RESULT=PSMSG_U_REASON
 Q RESULT
 ;
CHKDRATN(DURATION,DRUGNM) ;
 ;INPUTS; DURATION-INTEGER-HOW LONG A DRUG IS TAKEN
 ;PSMSG-ERROR MESSAGE
 N RESULT,REASON,PSMSG
 S RESULT=""
 ;If not integer error
 D
 .I '$L(DURATION) Q  ;can be null OK
 .;must be an integer > 0
 .;I (DURATION'=+DURATION)!(DURATION'=(DURATION\1))!(DURATION=0) D
 .I (DURATION=0)!(DURATION'?1.N) D
 ..S REASON="Invalid or Undefined Duration"
 ..S PSMSG=$$DOSEMSG(DRUGNM)
 ..S RESULT=PSMSG_U_REASON
 Q RESULT
 ;
DOSEMSG(DRUGNAME,TYPE,WARN) ;
 ;INPUTS:DRUGNMAME
 ;TYPE-either "R" for range or "S" for single or "D" for daily or "M" for max daily (optional)
 ;WARN-'W' for warning text, else exception text
 ;OUTPUT STANDARD DOSAGE ERROR MESSAGE
 N RETURN,TEXT
 S TYPE=$G(TYPE) ;OPTIONAL PARAMETER ONLY CALLED FROM PSSHRQ23
 S WARN=$G(WARN) ;OPTIONAL PARAMETER ONLY CALLED FROM PSSDSEXD
 S TEXT=$S(WARN="W":" Warning for ",1:" could not be performed for Drug: ")
 D
 .I TYPE="S" D  Q
 ..SET RETURN="Maximum Single Dose Check"_TEXT_DRUGNAME
 .I TYPE="M" D  Q
 ..S RETURN="Max Daily Dose Check"_TEXT_DRUGNAME
 .S RETURN=$S(WARN="W":"Dosing Order Check",1:"Dosing Checks")_TEXT_DRUGNAME
 Q RETURN
 ;
GETUCI() ;
 ;RETURNS CURRENT UCI
 N Y
 X ^%ZOSF("UCI")
 Q Y
 ;
ERRMSG(TYPE,DRUGNAME,ORDRNUM,WARNING) ;
 ;Returns standard messages for error nodes
 ;created from FDB alerts
 ;inputs:
 ;TYPE-DRUGDRUG,THERAPY,DOSE
 ;DRUGNAME-NAME OF DRUG
 ;WARNING (OPTIONAL) 1 OR 0 IF SET CAME BACKF FROM FDB AS SEVERITY OF WARINING)
 ;CALLED BY MSGWRITE^PSSHRQ21
 ;FDB Errors, Input Exceptions and Dose Screening prior to FDB call pass in Null Type
 N MSG,LOCORREM
 S WARNING=$G(WARNING)
 S MSG=""
 S LOCORREM=$$LOCORREM(ORDRNUM)
 D
 .I WARNING D  Q
 ..I TYPE="DRUGDRUG" S MSG="Drug Interaction Order Check for "_LOCORREM_" Drug: "
 ..I TYPE="THERAPY" S MSG="Duplicate Therapy Order Check for "_LOCORREM_" Drug: "
 ..I TYPE="DOSE" S MSG="Dosing Order Check Warning for "_DRUGNAME_":" Q    ; do not execute the next line - and 2.1 change from Maximum to Dosing Order..
 ..S MSG=MSG_DRUGNAME_" Warning"
 .I TYPE="DRUGDRUG" S MSG="Drug Interaction Order Check could not be performed."
 .I TYPE="THERAPY" S MSG="Duplicate Therapy Order Check could not be performed for "_LOCORREM_" Drug: "_DRUGNAME
 .I TYPE="DOSE" S MSG=$$DOSEMSG(DRUGNAME)
 Q MSG
 ;
ORDRTYP(ORDERNUM) ;
 ;RETURNS THE TYPE OF ORDER: OUTPATIENT PROSPECTIVE DRUG, OUTPATIENT, REMOTE OR INPATIENT
 ;INPUTS: ORDERNUM: TYPE;ORDER NUMBER;DRUG TYPE (PROFILE, PROSPECTIVE, REMOTE);COUNTER
 N TYPE,C1
 S TYPE=""
 S C1=$E(ORDERNUM)
 D
 .I ORDERNUM["REMOTE" S TYPE="REMOTE" Q
 .I C1="O" S TYPE="OUTPATIENT" Q
 .I C1="Z" S TYPE="OUTPATIENT" Q
 .I C1="I" S TYPE="INPATIENT" Q
 .I C1="R" S TYPE="REMOTE" Q
 Q TYPE
 ;
LOCORREM(ORDERNUM) ;
 ;INPUTS: ORDERNUM: TYPE;ORDER NUMBER;DRUG TYPE (PROFILE, PROSPECTIVE, REMOTE);COUNTER
 ;OUTPUTS:-String either "local" or "Remote"
 N ORDRTYP,LOCORREM
 S ORDRTYP=$$ORDRTYP(ORDERNUM)
 D
 .I ORDRTYP="REMOTE" S LOCORREM="Remote" Q
 .S LOCORREM="Local"
 Q LOCORREM
 ;
STATMSG() ;
 ;This returns the standard message when an FDB update is being performed.
 ;
 N MSG
 ;S MSG="Enhanced Order checks are unavailable. A Vendor database update is in progress."
 ;S MSG="The connection to the vendor database has been disabled."
 S MSG=$S(+$G(PSSDSWHE)=0:"The connection to the vendor database has been disabled.",1:"Vendor database updates are being processed.")  ;2.1 message text split
 Q MSG
 ;
 ;
GCMESS() ;Get Exclude field
 N PSSVQND,PSSVQEXC,PSSVQPVP
 S PSSVQPVP=$P(ORDRNUM,";",3)
 I '$D(PSJDGCK) S PSSVQND=^TMP($J,PSSHASH("Base"),"IN",PSSVQPVP,ORDRNUM)
 I $D(PSJDGCK) S PSSVQND=^TMP($J,PSSHASH("Base"),"IN","PROSPECTIVE",ORDRNUM)
 S PSSVQEXC=""
 D GCNMESX
 Q PSSVQEXC
 ;
 ;
GCNMESX ;
 N PSSVQDRG,PSSVQ1,PSSVQ3,PSSVQVUI,PSSVQAR,PSSVQ4,PSSVQARR
 S PSSVQDRG=$P(PSSVQND,"^",3) I PSSVQDRG D  Q
 .S PSSVQ1=$P($G(^PSDRUG(PSSVQDRG,"ND")),"^"),PSSVQ3=$P($G(^PSDRUG(PSSVQDRG,"ND")),"^",3)
 .I PSSVQ1,PSSVQ3 S PSSVQEXC=$$DDIEX^PSNAPIS(PSSVQ1,PSSVQ3)
 S PSSVQVUI=$P(PSSVQND,"^",2) I 'PSSVQVUI Q
 S PSSVQAR="PSSVQARR"
 D GETIREF^XTID(50.68,.01,PSSVQVUI,PSSVQAR)
 S PSSVQ4=$O(PSSVQARR(50.68,.01,""))
 I PSSVQ4 S PSSVQEXC=$$DDIEX^PSNAPIS("",PSSVQ4)
 Q
 ;
 ;
NXCHKMSG(DRUGNM) ;2.1 changes
 N PSSZMESS
 I $D(^TMP($J,PSSHASH("Base"),"IN","DOSE")) D  Q PSSZMESS
 .I 'PSSVQDOS!('PSSVQTY2)!(PSSVQREM)!($$EXMT(DRUGIEN)) S PSSZMESS=MESSAGE Q
 .S PSSZMESS="Dosing Checks could not be performed for Drug: "_DRUGNM_", please complete a manual check for appropriate Dosing." ; 2.1 Schedule not known, so message must stay generic
 S PSSZMESS="Order Checks could not be done for"
 S PSSZMESS=PSSZMESS_$S(PSSVQREM:" Remote",2:"")_" Drug: "_DRUGNM_", please complete a manual check for Drug Interactions"_$S(PSSVQDOS&($G(PSSVQTY2))&('$$EXMT(DRUGIEN)):", Duplicate Therapy and appropriate Dosing.",1:" and Duplicate Therapy.")
 Q PSSZMESS
 ;
 ;
NZMSG ;Reset Message for Pharmacy Not matched to NDF error for Dosing
 S MESSAGE="Maximum Single Dose Check could not be performed for Drug: "_DRUGNM
 Q
 ;;
EXMT(PSSHRDRG) ; given drug ien, is it exempt from dosing call?  2.1 change
 I PSSHRDRG'>0 Q 0
 Q $$EXMT^PSSDSAPI(PSSHRDRG)
