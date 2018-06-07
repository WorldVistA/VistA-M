PSSHRVAL ;WOIFO/Alex Vasquez,Timothy Sabat,Steve Gordon - Data Validation routine for drug checks ;01/15/07
 ;;1.0;PHARMACY DATA MANAGEMENT;**136,160,178**;9/30/97;Build 14
 ;
 ;
 ;@NOTE: The exception node looks like this.
 ;PSSHASH("Exception","PROSPECTIVE","DOSE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText
 ;PSSHASH("Exception","PROSPECTIVE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText
 ;PSSHASH("Exception","PROFILE",PharmacyOrderNum,Counter)=Gcn,Vuid,IEN,DrugName,CprsOrderNum,Package,Reason,ReasonCode,ResonSource,ReasonText
 ;PSSHASH("Exception","PatientIenMissing")=""
 ;PSSHASH("Message")="Failed Validation"
 ;PSSHASH("ReasonCode")="Reason Code Not Determined Yet"
 ;
 ;
 ;^TMP GLOBAL DATA=GCNSEQNO^VUID^IEN^NAME^DOSE AMOUNT^DOSE UNIT^DOSE RATE^FREQ^DURATION^DURATION RATE^ROUTE^DOSE TYPE^not used^DOSE FORM FLAG
 ;
 ;Business rules:
 ;1. If a prospective" node does not have a GCNSEQNO, it will be KILLED
 ;2.If a "profile" node does not have a GCNSEQNO, it will be KILLED
 ;3.If no prospective nodes exist, DRUGDRUG,THERAPY and DOSE will be killed off
 ;4.Only checks will be performed for those check nodes that still exist (e.g. DRUGDRUG,
 ;THERAPY and DOSE)
 ;If any of the demographics are out of range (age<=0,BSA<0 (or null) or Weight<0 or null) dose node will be killed.
 ;
 QUIT
 ;;
DRIVER(PSSBASE) ;
 ;@DRIVER
 ;@DESC The driver for the validation of drug checks.
 ;@PSSBASE The base
 ;
 NEW PSSHASH
 ;
 SET PSSHASH("Base")=PSSBASE
 SET PSSHASH("ReasonCode")="" ;for version 0.5 version not yet defined.
 ;
 DO BUILD(.PSSHASH)
 ;
 DO WRITE^PSSHRVL1(.PSSHASH)
 DO CHKNODES(.PSSHASH)
 QUIT $$CONTINUE(.PSSHASH)
 ;
CHKNODES(PSSHASH) ;
 ;@DESC Determines which nodes should be killed off or kept
 ;
 ;SET DoseValue,"Demo" PSSHASH array to kill off dose node
 NEW ORDER
 ;
 SET ORDER=""
 IF '$L($O(^TMP($JOB,PSSHASH("Base"),"IN","PROSPECTIVE",ORDER))) DO
 .;If only send in profile with profile flag OK
 .I $D(^TMP($JOB,PSSHASH("Base"),"IN","PROFILEVPROFILE"))&($L($O(^TMP($JOB,PSSHASH("Base"),"IN","PROFILE",ORDER)))) Q
 .DO KILLALL^PSSHRVL1(PSSHASH("Base"))
 IF $D(PSSHASH("DoseValue","DEMOAGE")) DO
 .DO KILLCHEK^PSSHRVL1("DOSE",PSSHASH("Base"))
 QUIT
 ;
CONTINUE(PSSHASH) ;
 ;@DESC Determines whether or not to proceed with checks.
 ;@RETURNS 1 if you may continue, 0 if not.
 ;
 NEW PSS
 SET PSS("AnyChecksLeft")=0
 DO:$DATA(^TMP($JOB,PSSHASH("Base"),"IN","DRUGDRUG"))
  . SET PSS("AnyChecksLeft")=1
  . QUIT 
 DO:$DATA(^TMP($JOB,PSSHASH("Base"),"IN","THERAPY"))
 . SET PSS("AnyChecksLeft")=1
 . QUIT
 DO:$DATA(^TMP($JOB,PSSHASH("Base"),"IN","DOSE"))
 . SET PSS("AnyChecksLeft")=1
 . QUIT
 DO:$DATA(^TMP($JOB,PSSHASH("Base"),"IN","PING"))
  . SET PSS("AnyChecksLeft")=1
  . QUIT
 QUIT PSS("AnyChecksLeft")
 ;
BUILD(PSSHASH) ;
 ;@DESC Builds the internal hash used to parse for errors.
 ;@PSSHASH The internal variables.
 ;DO CHKINEXP(.PSSHASH)
 DO CHKINEXP(.PSSHASH) ;CHK FOR "IN" EXCEPTIONS
 DO DRUGPROS(.PSSHASH)
 DO DRUGPROF(.PSSHASH)
 QUIT
 ;
CHKINEXP(PSSHASH) ;
 ;INPUT PSSHASH array
 ;PSSHASH("Exception",TYPE,"DOSE",PSS("PharmOrderNum"),COUNTER)
 ;PSSHASH("Exception",TYPE,PSS("PharmOrderNum"),COUNTER)
 I $D(^TMP($JOB,PSSHASH("Base"),"IN","EXCEPTIONS","OI")) D OIEXP(.PSSHASH)
 I $D(^TMP($JOB,PSSHASH("Base"),"IN","EXCEPTIONS","DOSE")) D DOSINEXP(.PSSHASH)
 Q
 ;
DRUGPROS(PSSHASH) ;
 ;@DESC Loops on the prospective drugs
 ;@PSSHASH The internal variables.
 ;
 NEW PSS
 SET PSS("ProspectiveOrProfile")="PROSPECTIVE"
 SET PSS("PharmOrderNum")=""
 ;
 FOR  SET PSS("PharmOrderNum")=$ORDER(^TMP($JOB,PSSHASH("Base"),"IN","PROSPECTIVE",PSS("PharmOrderNum"))) QUIT:PSS("PharmOrderNum")=""  DO
  . SET PSS("DrugValue")=^TMP($JOB,PSSHASH("Base"),"IN","PROSPECTIVE",PSS("PharmOrderNum"))
  . DO CHECKGCN(.PSS,.PSSHASH)
  . DO CHECKDOS(.PSS,.PSSHASH)
  . QUIT
 QUIT
 ;
DEMOGRAF(PSS,PSSHASH,PSDRUG) ;
 ;@DESC Validates the demographic info
 ;@PSSHASH The hash the demographic info is stored in
 ;
 ;Gcn
 N AGE,WEIGHT,BSA,MESSAGE,ORDER
 ;
 SET PSS("T")=$PIECE(PSS("DoseValue"),"^",1)_"^"
 ;Vuid
 SET PSS("T")=PSS("T")_$PIECE(PSS("DoseValue"),"^",2)_"^"
 ;Ien
 SET PSS("T")=PSS("T")_$PIECE(PSS("DoseValue"),"^",3)_"^"
 ;DrugName
 SET PSS("T")=PSS("T")_$PIECE(PSS("DoseValue"),"^",4)_"^"
 ;CprsOrderNumber
 SET PSS("T")=PSS("T")_$PIECE(PSS("DoseValue"),"^",5)_"^"
 ;Package
 SET PSS("T")=PSS("T")_$PIECE(PSS("DoseValue"),"^",6)_"^"
 ;Reason
 ;SET PSS("T")=PSS("T")_PSSHASH("Message")_"^"
 I $D(^TMP($JOB,PSSHASH("Base"),"IN","DOSE")) D
 .S AGE=+$G(^TMP($J,PSSHASH("Base"),"IN","DOSE","AGE"))
 .S WEIGHT=+$G(^TMP($J,PSSHASH("Base"),"IN","DOSE","WT"))
 .S BSA=+$G(^TMP($J,PSSHASH("Base"),"IN","DOSE","BSA"))
 .;Validate age in days exists or BSA or Weight are not less than zero.
 .S MESSAGE=$$DEMOCHK^PSSHRVL1(AGE,BSA,WEIGHT,PSDRUG,$G(PSSDSWHE)) Q:'$L(MESSAGE)  ;IF NO ISSUE DON'T GO ANY FURTHER
 .S PSSNOAGE=1
 .I AGE'>0 D SETDSEXP(.PSS,.PSSHASH,MESSAGE,0,1),PSSDBCAR
 .;cmf rtc#509375;I WEIGHT'>0 D SETDSEXP(.PSS,.PSSHASH,MESSAGE,0,3)
 .;cmf rtc#509375;I BSA'>0 D SETDSEXP(.PSS,.PSSHASH,MESSAGE,0,4)
 .;This is already looping through all dose nodes from DRUGPROS
 .;IF BAD DEMOGRAPHIC Set array node below and have CHKNODES tag kill Dose node
 .S PSSHASH("DoseValue","DEMOAGE")=""
 KILL PSS("T")
 QUIT 
 ;
PSSDBCAR ; set global array for setting dose output globals ; cmf RTC #159140, #163341
 Q:'$D(PSSDBCAR)
 Q:'$D(PSS("PharmOrderNum"))
 S $P(PSSDBCAR(PSS("PharmOrderNum")),U,27)=1
 Q
 ;;
CHECKDOS(PSS,PSSHASH) ; 
 ;@DESC Check if the dose exists.
 ;@PSS The temp hash
 ;@PSSHASH The internal hash
 N DOSEVALUE,DOSE,DOSEUNIT,DOSERATE,FREQ,DURATION,DURRATE,ROUTE,DOSETYPE,DRUGNM,MESSAGE,PSSNOAGE
 DO:$DATA(^TMP($JOB,PSSHASH("Base"),"IN","DOSE",PSS("PharmOrderNum")))
  .;if prospective killed off then GCN bad-no need to go any further
  .I '$DATA(^TMP($JOB,PSSHASH("Base"),"IN","PROSPECTIVE",PSS("PharmOrderNum"))) Q
  . SET PSS("DoseValue")=^TMP($JOB,PSSHASH("Base"),"IN","DOSE",PSS("PharmOrderNum"))
  . SET PSS("Package")=""
  . SET PSS("ReasonSource")=$$GETUCI^PSSHRVL1()
  . ;
  . ;I '$$DEMOGRAF(.PSS,.PSSHASH) Q  ;Check age and other parameters
  . ;If this is a "specific" call
  . ;SET PSS("Package")="N/A"
  . ;SET PSS("ReasonSource")=$$GETUCI^PSSHRVL1()
  . ;SET PSS("Message")=PSSHASH("Message")
  . S DOSEVALUE=PSS("DoseValue")
  . S DRUGNM=$P(DOSEVALUE,U,4)
  . S DOSE=$P(DOSEVALUE,U,5),DOSEUNIT=$P(DOSEVALUE,U,6),DOSERATE=$P(DOSEVALUE,U,7)
  . S FREQ=$P(DOSEVALUE,U,8),DURATION=$P(DOSEVALUE,U,9)
  . S DURRATE=$P(DOSEVALUE,U,10),ROUTE=$P(DOSEVALUE,U,11),DOSETYPE=$P(DOSEVALUE,U,12)
  . ;Check piece 12--if not set correctly go no further
  . S PSSNOAGE=0 D DEMOGRAF(.PSS,.PSSHASH,DRUGNM)  Q:PSSNOAGE  ;Check age and other parameters
  . S MESSAGE=$$CHKDSTYP^PSSHRVL1(DOSETYPE,DRUGNM) I $L(MESSAGE) D
  . . D SETDSEXP(.PSS,.PSSHASH,MESSAGE,12,2)
  . ;set defaults for all possible errors
  . ;check piece 5 dose
  . S MESSAGE=$$CHKDOSE^PSSHRVL1(DOSE,DRUGNM) I $L(MESSAGE) D
  . .D SETDSEXP(.PSS,.PSSHASH,MESSAGE,5)
  . ;check piece 6-dose units
  . S MESSAGE=$$CHKUNIT^PSSHRVL1(DOSEUNIT,DRUGNM) I $L(MESSAGE) D
  . .D SETDSEXP(.PSS,.PSSHASH,MESSAGE,6)
  . ;Check piece 7--dose rate
  . S MESSAGE=$$CHKRATE^PSSHRVL1(DOSERATE,"DOSE",DRUGNM) I $L(MESSAGE) D
  . . D SETDSEXP(.PSS,.PSSHASH,MESSAGE,7)
  . ;Check Piece 8--frequency
  . ;S MESSAGE=$$CHKFREQ^PSSHRVL1(FREQ) I $L(MESSAGE) D
  . ;.D SETDSEXP(.PSS,.PSSHASH,MESSAGE,8)
  . ;Check piece 9-duration
  . S MESSAGE=$$CHKDRATN^PSSHRVL1(DURATION,DRUGNM) I $L(MESSAGE) D
  . .D SETDSEXP(.PSS,.PSSHASH,MESSAGE,9)
  . ;Check piece 10-DURATION RATE
  . S MESSAGE=$$CHKRATE^PSSHRVL1(DURRATE,"DURATION",DRUGNM,DURATION) I $L(MESSAGE) D
  . .D SETDSEXP(.PSS,.PSSHASH,MESSAGE,10)
  . ;PIECE 11-ROUTE
  . S MESSAGE=$$MEDRTE^PSSHRVL1(ROUTE,DRUGNM) I $L(MESSAGE) D
  . .D SETDSEXP(.PSS,.PSSHASH,MESSAGE,11,2)
  . QUIT   ;Checking if dose exists.
 QUIT
 ;
SETDSEXP(PSS,PSSHASH,MESSAGE,DOSPIECE,PSSDBIN) ;
 ;SET DOSE EXCEPTION
 ;PSS-ARRAY OF MED PROFILE INFORMATION(BY REF)
 ;PSSHASH-HOLDS DATA EXCEPTION (BY REF)
 ;MESSAGE-REASON AND ERROR REASON
 ;DOSEPIECE-THE OFFENDING PIECE OF DATA FROM DOSING INFORMATON-NOT SENT IF FROM
 ;DEMOGRAF CALL.
 ;
 SET PSS("Counter")=$$NEXTDOS(.PSS,.PSSHASH)
 SET PSS("ReasonCode")=PSSHASH("ReasonCode")
 SET PSS("Message")=$P(MESSAGE,U)
 SET PSS("ReasonText")=$P(MESSAGE,U,2)
 SET PSS("CprsOrderNumber")=""
 SET PSSHASH("Exception",PSS("ProspectiveOrProfile"),"DOSE",PSS("PharmOrderNum"),PSS("Counter"))=$$DOSPIECE(.PSS)
 I $G(DOSPIECE) SET PSSHASH("DoseValue",DOSPIECE)=""
 D KILLNODE^PSSHRVL1(PSSHASH("Base"),"DOSE",PSS("PharmOrderNum"))
 D KILLNODE^PSSHRVL1(PSSHASH("Base"),"PROSPECTIVE",PSS("PharmOrderNum"))
 S $P(PSSDBCAR(PSS("PharmOrderNum")),"^",13)=1
 S:$G(PSSDBIN)=1 $P(PSSDBCAR(PSS("PharmOrderNum")),"^",19)=1
 S:$G(PSSDBIN)=2 $P(PSSDBCAR(PSS("PharmOrderNum")),"^",23)=1
 S:$G(PSSDBIN)=3 $P(PSSDBCAR(PSS("PharmOrderNum")),"^",25)=1
 S:$G(PSSDBIN)=4 $P(PSSDBCAR(PSS("PharmOrderNum")),"^",26)=1
 QUIT
 ;
DOSINEXP(PSSHASH) ;
 N ORDERNUM,MESSAGE,REASON,DRUGNM,ERRNUM,TMPNODE,PSS
 S ORDERNUM=""
 F  S ORDERNUM=$O(^TMP($JOB,PSSHASH("Base"),"IN","EXCEPTIONS","DOSE",ORDERNUM)) Q:'$L(ORDERNUM)  D
 .S TMPNODE=$G(^TMP($JOB,PSSHASH("Base"),"IN","EXCEPTIONS","DOSE",ORDERNUM)) Q:'$L(TMPNODE)
 .S ERRNUM=+TMPNODE  ;ERROR NUMBER
 .S DRUGNM=$P(TMPNODE,U,2)
 .S MESSAGE=$$DOSEMSG^PSSHRVL1(DRUGNM)
 .S REASON=$$INRSON^PSSHRVL1(ERRNUM)
 .S MESSAGE=MESSAGE_U_REASON
 .S PSS("PharmOrderNum")=ORDERNUM
 .S PSS("ProspectiveOrProfile")="PROSPECTIVE"
 .S PSS("Package")=""
 .S PSS("DoseValue")=""
 .S PSS("ReasonSource")=$$GETUCI^PSSHRVL1()
 .D SETDSEXP(.PSS,.PSSHASH,MESSAGE)
 Q
 ;
OIEXP(PSSHASH) ;
 N ORDITEM,ERRNUM,MESSAGE,REASON,PSS,ORDERNUM,TMPNODE
 S ORDITEM=""
 F  S ORDITEM=$O(^TMP($JOB,PSSHASH("Base"),"IN","EXCEPTIONS","OI",ORDITEM)) Q:'$L(ORDITEM)  D
 .S TMPNODE=$G(^TMP($JOB,PSSHASH("Base"),"IN","EXCEPTIONS","OI",ORDITEM)) Q:'$L(TMPNODE)
 .S ERRNUM=+TMPNODE  ;ERROR NUMBER
 .S ORDERNUM=$P(TMPNODE,U,2)
 .S MESSAGE=$$OIMSG^PSSHRVL1(ORDITEM,ORDERNUM)
 .S REASON="" I $E(PSSHASH("Base"),1,2)="PS" S REASON=$$INRSON^PSSHRVL1(ERRNUM,ORDERNUM)
 .S $P(PSS("I"),U,7)=MESSAGE
 .S $P(PSS("I"),U,10)=REASON
 .S PSS("PharmOrderNum")=ORDERNUM
 .S PSS("ProspectiveOrProfile")=$S($$ISPROF^PSSHRCOM(ORDERNUM):"PROFILE",1:"PROSPECTIVE")
 .S PSS("Package")=""
 .S PSS("DoseValue")=""
 .S PSS("ReasonSource")=$$GETUCI^PSSHRVL1()
 .S PSS("Counter")=$$NEXTGCN(.PSS,.PSSHASH)
 .D SETEXCP(.PSS,.PSSHASH)
 .D HDOSE(ORDERNUM) D KILLNODE^PSSHRVL1(PSSHASH("Base"),PSS("ProspectiveOrProfile"),ORDERNUM)
 Q
 ;
NEXTDOS(PSS,PSSHASH) ;
 ;@DESC Gets the next dose
 ;@PSS The temp hash
 ;@PSSHASH The internal hash ;
 ;@NOTE PSSHASH looks like this: 
 ; PSSHASH("Exception","PROSPECTIVE","DOSE",PharmacyOrderNum,Counter
 ; 
 N PSNEXT
 S PSNEXT=":"
 S PSNEXT=$ORDER(PSSHASH("Exception","PROSPECTIVE","DOSE",PSS("PharmOrderNum"),PSNEXT),-1)
 Q PSNEXT+1
 ;
NEXTGCN(PSS,PSSHASH) ;
 ;@DESC Gets the next Gcn
 ;@PSS The temp hash
 ;@PSSHASH The internal hash
 ;
 N PSNEXT
 S PSNEXT=":"
 S PSNEXT=$ORDER(PSSHASH("Exception",PSS("ProspectiveOrProfile"),PSS("PharmOrderNum"),PSNEXT),-1)
 Q PSNEXT+1
 ;
DOSPIECE(PSS) ;
 ;@DESC Appends all pre-defined pieces to a temp var
 ;@PSS The temp hash
 ;@RETURNS The appended temp var.
 ;
 SET PSS("I")=$PIECE(PSS("DoseValue"),"^",1)_"^" ;GCN
 SET PSS("I")=PSS("I")_$PIECE(PSS("DoseValue"),"^",2)_"^" ;Vuid
 SET PSS("I")=PSS("I")_$PIECE(PSS("DoseValue"),"^",3)_"^" ;Ien
 SET PSS("I")=PSS("I")_$PIECE(PSS("DoseValue"),"^",4)_"^" ;DrugName
 SET PSS("I")=PSS("I")_PSS("CprsOrderNumber")_"^" ;CprsOrderNumber
 SET PSS("I")=PSS("I")_PSS("Package")_"^" ;Package
 SET PSS("I")=PSS("I")_PSS("Message")_"^"
 SET PSS("I")=PSS("I")_PSS("ReasonCode")_"^"
 SET PSS("I")=PSS("I")_PSS("ReasonSource")_"^"
 SET PSS("I")=PSS("I")_PSS("ReasonText")
 QUIT PSS("I")
 ;
CHECKGCN(PSS,PSSHASH) ;
 ;@DESC Checks the GCN for a Drug
 ;@PSS A temp array
 ;@PSSHASH The input array
 ;@ASSERT PSS("DrugValue") exists.
 ;
 N DRUGNM,DRUGIEN,MESSAGE,REASON,BADGCN
 SET PSS("Counter")="0"
 DO:'$PIECE(PSS("DrugValue"),"^",1)
  . SET DRUGIEN=$P(PSS("DrugValue"),"^",3)
  . SET DRUGNM=$P(PSS("DrugValue"),"^",4)
  . S BADGCN=0
  . S:$PIECE(PSS("DrugValue"),"^",1)'?1.N BADGCN=-1
  . SET MESSAGE=$$GCNREASN^PSSHRVL1(DRUGIEN,DRUGNM,PSS("PharmOrderNum"),BADGCN)
  . I $L(MESSAGE) SET REASON=$P(MESSAGE,U,2,3),MESSAGE=$P(MESSAGE,U)
  . SET PSS("Counter")=$$NEXTGCN(.PSS,.PSSHASH)
  . SET PSS("I")="^" ;Gcn
  . SET PSS("I")=PSS("I")_$PIECE(PSS("DrugValue"),"^",2)_"^" ;Vuid
  . SET PSS("I")=PSS("I")_$PIECE(PSS("DrugValue"),"^",3)_"^" ;Ien
  . SET PSS("I")=PSS("I")_$PIECE(PSS("DrugValue"),"^",4)_"^" ;DrugName
  . SET PSS("I")=PSS("I")_$PIECE(PSS("DrugValue"),"^",5)_"^" ;CprsOrderNumber
  . SET PSS("I")=PSS("I")_$PIECE(PSS("DrugValue"),"^",6)_"^" ;Package
  . SET PSS("I")=PSS("I")_MESSAGE_"^"
  . ;Reason code is null for 0.5
  . SET PSS("I")=PSS("I")_PSSHASH("ReasonCode")_U
  . ;Set reason text
  . SET PSS("I")=PSS("I")_$$GETUCI^PSSHRVL1()_U
  . SET PSS("I")=PSS("I")_REASON
  . ;
  . D SETEXCP(.PSS,.PSSHASH)
  . D HDOSE(PSS("PharmOrderNum")) D KILLNODE^PSSHRVL1(PSSHASH("Base"),PSS("ProspectiveOrProfile"),PSS("PharmOrderNum"))
 QUIT
 ;
SETEXCP(PSS,PSSHASH) ;
 SET PSSHASH("Exception",PSS("ProspectiveOrProfile"),PSS("PharmOrderNum"),PSS("Counter"))=PSS("I")
 Q
 ;
DRUGPROF(PSSHASH) ;
 ;@DESC Checks the profile drugs.
 ;@PSSHASH The internal hash
 ;
 NEW PSS
 SET PSS("ProspectiveOrProfile")="PROFILE"
 SET PSS("PharmOrderNum")=""
 FOR  SET PSS("PharmOrderNum")=$ORDER(^TMP($JOB,PSSHASH("Base"),"IN",PSS("ProspectiveOrProfile"),PSS("PharmOrderNum"))) QUIT:PSS("PharmOrderNum")=""  DO
  . SET PSS("DrugValue")=^TMP($JOB,PSSHASH("Base"),"IN",PSS("ProspectiveOrProfile"),PSS("PharmOrderNum"))
  . DO CHECKGCN(.PSS,.PSSHASH)
  . QUIT
 QUIT
 ;
 ;
HDOSE(PSSDLDOS) ; If it's a Dose Call
 I '$D(^TMP($J,PSSHASH("Base"),"IN","DOSE",PSSDLDOS)) Q
 D KILLNODE^PSSHRVL1(PSSHASH("Base"),"DOSE",PSSDLDOS)
 S $P(PSSDBCAR(PSSDLDOS),"^",13)=1
 Q
