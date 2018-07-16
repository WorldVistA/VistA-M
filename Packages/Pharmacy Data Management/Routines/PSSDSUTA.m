PSSDSUTA ;BIR/RTR-Dosing Utility Routine ;11/24/14
 ;;1.0;PHARMACY DATA MANAGEMENT;**178,224**;9/30/97;Build 3
 ;
FCY() ;Validate Frequency, leading and trailing spaces already stripped off, and uppercase conversion done
 N PSSFCYF,PSSFCYL,PSSFCY1,PSSFCY2,PSSFCYA,PSSFCYB
 S PSSFCYF=$P(PSSDBEB2,"^",8)
 I $D(PSSDBCAZ(PSSDBEB1,"FRQ_ERROR"))!(PSSFCYF="")!(PSSFCYF[".") Q 1
 I PSSFCYF?.N Q 0
 I PSSFCYF="QD"!(PSSFCYF="BID")!(PSSFCYF="TID")!(PSSFCYF="QID")!(PSSFCYF="QAM")!(PSSFCYF="QSHIFT")!(PSSFCYF="QOD")!(PSSFCYF="QHS")!(PSSFCYF="QPM") Q 0
 S PSSFCYL=$L(PSSFCYF) I PSSFCYL'=3,PSSFCYL'=4 Q 1
 S PSSFCY1=$E(PSSFCYF),PSSFCY2=$E(PSSFCYF,PSSFCYL)
 I PSSFCY1'="Q",PSSFCY1'="X" Q 1
 I PSSFCY1="Q","DWLH"'[PSSFCY2 Q 1
 I PSSFCY1="X","DWL"'[PSSFCY2 Q 1
 S PSSFCYA=$E(PSSFCYF,2) I PSSFCYA'?1N Q 1
 I PSSFCYL=3 Q 0
 S PSSFCYB=$E(PSSFCYF,3) I PSSFCYB'?1N Q 1
 Q 0
 ; 
MAXD(PSSDADO,PSSDADB,PSSDADNM,PSSDADI,PSSDBCAR) ; -- in 2.1 Perform Max Daily Dose check when Frequency is Out of Range - called from PSSHRQ24
 ;PSSDADO - Order Number
 ;PSSDADB - Base
 ;PSSDADNM - Drug Name
 ;PSSDADI - Drug IEN
 ;PSSDBCAR - array documented in PSSDSEXC
 ;
 ;Return: If message is built, show custom max daily dose message flag is set to 1
 ;        $P(PSSDBCAR(PSSDADO),"^",28)=1
 ;        If unable to complete max daily dose check, set frequency flag to 0
 ;        $P(PSSDBCAR(PSSDADO),"^",4)=0
 ;
 N PSSCMDDF,PSSDADD,PSSDADZ,PSSDADU,PSSDADH,PSSDADC1,PSSDADE,PSSDADF,PSSDADFF,PSSFDBU
 ; -- check for missing variables, exit if not defined
 I $G(PSSDADO)']""!($G(PSSDADB)']"")!($G(PSSDADNM)']"")!($G(PSSDADI)'>0) Q
 I $G(PSSDADO)]"",'$D(PSSDBCAR(PSSDADO)) Q
 ; -- initialize custom max daily dose check flag
 S PSSCMDDF=0
 ; -- set PSSDADZ=Input Parameters
 S PSSDADZ=$G(^TMP($J,PSSDADB,"IN","DOSE",PSSDADO))
 ; -- set PSSDADD=Dose Amount, PSSDADU=FDB Dose Unit, PSSDADF=Frequency
 S PSSDADD=$P(PSSDADZ,"^",5),PSSDADU=$P(PSSDADZ,"^",6),PSSDADF=$P(PSSDADZ,"^",8)
 ; -- check key variables, exit if not defined
 I PSSDADD=""!(PSSDADU="")!(PSSDADF="") G MAXDQ
 ; -- get dose form unit flag
 S PSSDADFF=$P(PSSDADZ,"^",14)
 ; -- Calculated Daily Dose or Dose Form Amount
 ;    -- if numeric PSSDADH=frequency*dose amount, otherwise call function to determine
 S PSSDADH=$S(PSSDADF?.N:PSSDADF*PSSDADD,1:$$CALCDDA(PSSDADF,PSSDADD))
 ;    -- exit if not defined
 I 'PSSDADH G MAXDQ
 ; -- set PSSDADE=FDB Max Daily Dose or Dose Form Unit
 S PSSDADE=$G(^TMP($J,PSSDADB,"OUT","DOSE",PSSDADO,PSSDADNM,"DAILYMAX",$S(PSSDADFF:"DOSEFORMUNIT",1:"DOSEUNIT"),PSSDADI))
 ; -- set PSSDADC1=FDB Max Daily Dose or Dose Form Amount
 S PSSDADC1=$G(^TMP($J,PSSDADB,"OUT","DOSE",PSSDADO,PSSDADNM,"DAILYMAX",$S(PSSDADFF:"DOSEFORM",1:"DOSE"),PSSDADI))
 ; -- exit if not defined
 I PSSDADE=""!(PSSDADC1="") G MAXDQ
 ;
 ; -- FDB not sending FDB Max Daily Dose or Dose Form Unit in Standard format try and derive
 S PSSFDBU=$$GETUNIT(PSSDADE,PSSDADU)
 ; -- exit if not defined
 I PSSFDBU="" G MAXDQ
 ;
 ; -- if FDB Dose Unit is different than FDB Max Daily Dose or Dose Form Unit see if FDB Max Daily Dose or Dose Form Amount can be converted, exit if not defined
 I PSSDADU'=PSSFDBU S PSSDADC1=$$CONVMDDA(PSSDADU,PSSFDBU,PSSDADC1) I PSSDADC1="" G MAXDQ
 ;
 ; -- if FDB Max Daily Dose or Dose Form Unit Value contains "PER KILOGRAM"
 ;    weight is required to derive the maximum daily dose, exit if not defined
 I $$UP^XLFSTR(PSSDADE)["PER KILOGRAM" D  G MAXDQ:PSSDADC1=""
 . ; -- check weight
 . I $G(^TMP($J,PSSDADB,"IN","DOSE","WT"))>0 D
 . . ; -- Calculate FDB Max Daily Dose or Dose Form as PSSDADC1=PSSDADC1*patient weight (in kg)
 . . S PSSDADC1=PSSDADC1*$G(^TMP($J,PSSDADB,"IN","DOSE","WT"))
 . ELSE  D
 . . ; -- if unable to calculate set FDB Max Daily Dose or Dose Form Unit=""
 . . S PSSDADC1=""
 . . ; -- update max daily dose error message if weight missing
 . . D ERRMSG(PSSDADO,PSSDADB,"Weight")
 ;
 ; -- if FDB Max Daily Dose or Dose Form Unit Value contains "PER METER SQUARED"
 ;    BSA is required to derive the maximum daily dose, exit if not defined
 I $$UP^XLFSTR(PSSDADE)["PER METER SQUARED" D  G MAXDQ:PSSDADC1=""
 . ; -- check BSA
 . I $G(^TMP($J,PSSDADB,"IN","DOSE","BSA"))>0 D
 . . ; -- Calculate FDB Max Daily Dose or Dose Form as PSSDADC1=PSSDADC1*patient BSA (in m2)
 . . S PSSDADC1=PSSDADC1*$G(^TMP($J,PSSDADB,"IN","DOSE","BSA"))
 . ELSE  D
 . . ; -- if unable to calculate set FDB Max Daily Dose or Dose Form Unit=""
 . . S PSSDADC1=""
 . . ; -- update max daily dose error message if BSA missing
 . . D ERRMSG(PSSDADO,PSSDADB,"Body surface area")
 ;
 ; -- build customized max daily dose message, kill FDB message, set message flag 
 D MAXDMSG(PSSDADO,PSSDADB,PSSDADNM,PSSDADI,PSSDADH,PSSDADU,PSSDADC1,PSSDADFF,.PSSDBCAR)
 ; -- set custom max daily dose check flag completed=1
 S PSSCMDDF=1
MAXDQ ; -- set frequency flag=0 if unable to complete max daily dose check
 I '$G(PSSCMDDF) S $P(PSSDBCAR(PSSDADO),"^",4)=0
 Q
 ;
CALCDDA(PSSDADF,PSSDADD) ; -- in 2.1 calculate daily dose amount by converting FDB frequency patterns into numeric daily dose amount
 ;PSSDADF - Frequency Pattern
 ;PSSDADD - Dose Amount
 ;
 ;Return: Calculated Daily Dose Amount or 0
 ;
 N PSSDADL,PSSDADN,PSSDADTM,PSSDADS
 ; -- check for missing variables, exit if not defined
 I $G(PSSDADF)']""!($G(PSSDADD)'>0) Q 0
 ; -- every day, in morning, at bed time, in evening
 I PSSDADF="QD"!(PSSDADF="QAM")!(PSSDADF="QHS")!(PSSDADF="QPM") Q PSSDADD
 ; -- every other day
 I PSSDADF="QOD" Q .5*PSSDADD
 ; -- twice a day
 I PSSDADF="BID" Q $$CALCDDAT("D",2,PSSDADD)
 ; -- three times per day
 I PSSDADF="TID" Q $$CALCDDAT("D",3,PSSDADD)
 ; -- four times per day
 I PSSDADF="QID" Q $$CALCDDAT("D",4,PSSDADD)
 ; -- set PSSDADL=Frequency Length, exit if not equal to 3 or 4
 S PSSDADL=$L(PSSDADF) I PSSDADL'=3,PSSDADL'=4 Q 0
 ; -- set PSSDADS=Action associated with frequency Q=every, X=times
 S PSSDADS=$E(PSSDADF)
 ; -- check action associated with frequency, exit if not "Q" or "X"
 I PSSDADS'="Q",PSSDADS'="X" Q 0
 ; -- set PSSDADN=Frequency Number
 S PSSDADN=$E(PSSDADF,2,$L(PSSDADF)-1)
 ; -- check if PSSDADN is numeric, exit if it is not
 I PSSDADN'?.N Q 0
 ; -- set PSSDADTM=period of time associated with frequency H=hour, D=day, W=week, L=month
 S PSSDADTM=$E(PSSDADF,PSSDADL)
 ; -- calculate times per day, week, month
 I PSSDADS="X" Q $$CALCDDAT(PSSDADTM,PSSDADN,PSSDADD)
 ; -- check for period of time, exit if not defined
 I PSSDADTM'="H",PSSDADTM'="D",PSSDADTM'="W",PSSDADTM'="L" Q 0
 ; -- calculate 24 hours/Frequency Number*Dose Amount
 I PSSDADTM="H" Q 24/PSSDADN*PSSDADD
 ; -- calculate 1 day/Frequency Number*Dose Amount
 I PSSDADTM="D" Q 1/PSSDADN*PSSDADD ;PSSDADD/PSSDADN
 ; -- calculate 1/(7 days*Frequency Number)*Dose Amount
 I PSSDADTM="W" Q 1/(7*PSSDADN)*PSSDADD
 ; -- calculate 1/(30 days*Frequency Number)*Dose Amount
 Q 1/(30*PSSDADN)*PSSDADD
 ;
CALCDDAT(PSSDADTM,PSSDADN,PSSDADD) ; -- in 2.1 calculate daily dose amount based on time per day, week or month
 ;PSSDADTM - Period of Time [D=day, W=week, L=month]
 ;PSSDADN - Frequency Number
 ;PSSDADD - Dose Amount
 ;
 ;Return: Calculated Daily Dose Amount or 0
 ;
 ; -- check for missing variables, exit if not defined
 I $G(PSSDADTM)']""!($G(PSSDADN)'>0)!($G(PSSDADD)'>0) Q 0
 ; -- check for period of time, exit if not defined
 I PSSDADTM'="D",PSSDADTM'="W",PSSDADTM'="L" Q 0
 ; -- times per day calculate Frequency Number*Dose Amount
 I PSSDADTM="D" Q PSSDADN*PSSDADD
 ; -- times per week calculate (Frequency Number/7)*Dose Amount
 I PSSDADTM="W" Q (PSSDADN/7)*PSSDADD
 ; -- times per month calculate (Frequency Number/30)*Dose Amount
 Q (PSSDADN/30)*PSSDADD
 ;
GETUNIT(PSSDADE,PSSDADU) ; -- in 2.1 FDB not sending Dose Unit in Standard format try and derive
 ;PSSDADE - FDB Max Daily Dose or Dose Form Unit String
 ;          [Ex. "milliliter per day"]
 ;PSSDADU - FDB Dose Unit
 ;
 ;Return: First Databank Dose Unit or ""
 ;
 ; -- check for missing variables, exit if not defined
 I $G(PSSDADE)']""!($G(PSSDADU)']"") Q ""
 ; -- parse PSSDADE string to get text for Dose Unit before first space
 N PSSDADL,PSSDUIEN,PSSFDBU
 I PSSDADE[" " D  I PSSDADE="" Q ""
 . F PSSDADL=1:1:$L(PSSDADE) Q:$E(PSSDADE,PSSDADL)'=" "
 . I $L(PSSDADE)=PSSDADL S PSSDADE="" Q
 . S PSSDADE=$E(PSSDADE,PSSDADL,$L(PSSDADE))
 . S PSSDADE=$P(PSSDADE," ")
 ; -- convert text to upper case
 S PSSDADE=$$UP^XLFSTR(PSSDADE)
 ; -- if text matches FDB Dose Unit, return FDB Dose Unit and exit
 I PSSDADE=PSSDADU Q PSSDADU
 ; -- check Dose Unit file (#51.24) for a matching First Databank Dose Unit
 ;    -- if text matches First Databank Dose Unit, return First Databank Dose Unit and exit
 S PSSDUIEN=$O(^PS(51.24,"C",PSSDADE,0)) I PSSDUIEN Q PSSDADE
 ;    -- if text matches Name, return First Databank Dose Unit and exit
 S PSSDUIEN=$O(^PS(51.24,"UPCASE",PSSDADE,0)) I PSSDUIEN D  Q PSSFDBU
 . S PSSFDBU=$P($G(^PS(51.24,PSSDUIEN,0)),"^",2)
 ;    -- if text matches a Synonym, return First Databank Dose Unit and exit
 S PSSDUIEN=$O(^PS(51.24,"D",PSSDADE,0)) I PSSDUIEN D  Q PSSFDBU
 . S PSSFDBU=$P($G(^PS(51.24,PSSDUIEN,0)),"^",2)
 Q ""
 ;
CONVMDDA(PSSDADU,PSSFDBU,PSSDADC1) ; -- in 2.1 Convert FDB Max Daily Dose or Dose Form Amount using Dose Unit Conversion file (#51.25)
 ;PSSDADU - FDB Dose Unit
 ;PSSFDBU - FDB Max Daily Dose or Dose Form Unit
 ;PSSDADC1- FDB Max Daily Dose or Dose Form Amount
 ;
 ;Return: Converted FDB Max Daily Dose or Dose Form Amount or ""
 ;
 N PSSCMDDA,PSSDADM,PSSDUCI,PSSDUC2I
 ; -- check for missing variables, exit if not defined
 I $G(PSSDADU)']""!($G(PSSFDBU)']"")!($G(PSSDADC1)'>0) Q ""
 ; -- If FDB Dose Unit is the same as the FDB Max Daily Dose or Dose Form Unit
 ;    return the FDB Max Daily Dose or Dose Form Amount
 I PSSDADU=PSSFDBU Q PSSDADC1
 ; -- set PSSDUCI=Dose Unit Conversion file (#51.25) IEN, exit if not defined
 S PSSDUCI=$O(^PS(51.25,"B",PSSFDBU,0)) I 'PSSDUCI Q ""
 ; -- set PSSDUC2I=Dose Unit 2 sub-file (#51.251) IEN, exit if not defined
 S PSSDUC2I=$O(^PS(51.25,PSSDUCI,1,"B",PSSDADU,0)) I 'PSSDUC2I Q ""
 ; -- set PSSDADM=Conversion Factor field (#1) in Dose Unit 2 sub-file (#51.251), exit if not defined
 S PSSDADM=$P($G(^PS(51.25,PSSDUCI,1,PSSDUC2I,0)),"^",2) I 'PSSDADM Q ""
 ; -- set PSSDADC1=(FDB Max Daily Dose or Dose Form)*Conversion Factor
 S PSSCMDDA=PSSDADC1*PSSDADM I 'PSSCMDDA Q ""
 Q PSSCMDDA
 ;
MAXDMSG(PSSDADO,PSSDADB,PSSDADNM,PSSDADI,PSSDADH,PSSDADU,PSSDADC1,PSSDADFF,PSSDBCAR) ; -- in 2.1 build customized max daily dose message
 ;PSSDADO - Order Number
 ;PSSDADB - Base
 ;PSSDADNM - Drug Name
 ;PSSDADI - Drug IEN
 ;PSSDADH - Calculated Daily Dose or Dose Form Amount
 ;PSSDADU - FDB Dose Unit
 ;PSSDADC1- FDB Max Daily Dose or Dose Form Amount
 ;PSSDADFF - Dose Form Unit Flag  (Optional)
 ;PSSDBCAR - array documented in PSSDSEXC
 ;
 ;Return: If message is built set show custom max daily dose message flag
 ;        $P(PSSDBCAR(PSSDADO),"^",28)=1
 ;
 N PSSERRN,PSSMSG,PSSDWL1
 ; -- check for missing variables, exit if not defined
 I $G(PSSDADO)']""!($G(PSSDADB)']"")!($G(PSSDADNM)']"")!($G(PSSDADI)'>0)!($G(PSSDADH)'>0)!($G(PSSDADU)']"")!($G(PSSDADC1)'>0) Q
 I $G(PSSDADO)]"",'$D(PSSDBCAR(PSSDADO)) Q
 ; -- check if Calculated Daily Dose or Dose Form (PSSDADH) is greater than FDB Max Daily Dose or Dose Form (PSSDADC1)
 I PSSDADH>PSSDADC1 D
 . ; -- build customized max daily dose message
 . S PSSMSG="Total dose"_$S($G(PSSDADFF):" form",1:"")_" amount of "_$$FMTNUM($G(PSSDADH))_" "_$G(PSSDADU)_"/DAY exceeds the maximum daily dose"_$S($G(PSSDADFF):" form",1:"")_" amount of "_$$FMTNUM($G(PSSDADC1))_" "_$G(PSSDADU)_"/DAY."
 . ; -- set message
 . S ^TMP($J,PSSDADB,"OUT","DOSE",PSSDADO,PSSDADNM,"DAILYMAX","MESSAGE",PSSDADI)=PSSMSG
 . ; -- set show custom max daily dose message flag=1
 . S $P(PSSDBCAR(PSSDADO),"^",28)=1
 ; -- initialize error number
 S PSSERRN=0
 ; -- search for FDB max daily dose frequency check error to delete
 S PSSDWL1=""
 F  S PSSDWL1=$O(^TMP($J,PSSDADB,"OUT","DOSE","ERROR",PSSDADO,PSSDWL1)) Q:PSSDWL1=""!(PSSERRN>0)  D
 . ; -- check for FDB max daily dose frequency check error
 . I $G(^TMP($J,PSSDADB,"OUT","DOSE","ERROR",PSSDADO,PSSDWL1,"MSG"))["Max Daily" D
 . . ; -- set error number to error to delete
 . . S PSSERRN=PSSDWL1
 ; -- delete FDB max daily dose frequency check error
 I PSSERRN>0 K ^TMP($J,PSSDADB,"OUT","DOSE","ERROR",PSSDADO,PSSERRN)
 Q
 ;
FMTNUM(X,PSSGDIF) ; -- in 2.1 format number for display
 ;X - Number
 ;PSSGDIF - General Dosing Information Flag  (Optional)
 ;
 ;Return: Formatted Number or 0
 ;
 ;Format Criteria: 
 ; - If after a decimal only zeros exist, do not display (i.e. 600.0 or 600.00 display 600)
 ; - Maintain leading zeros (i.e. 0.25)
 ; - For Customized Max Daily Dose (MDD):
 ;   -- Round calculated value to 3 decimal places.
 ;   -- If result is '0' after 3 decimals places, return 5 decimal places or all decimal places. 
 ; - For General Dosing Information (GDI):
 ;   -- Round calculated value to 5 decimal places.
 ;   -- If result is '0' after 5 decimals places, return 6 decimal places or all decimal places. 
 ;
 ;   Examples:
 ;    - If calculated MDD was 0.0001234
 ;      rounding to 3 decimals was 0.000 then display 0.00012.
 ;    - If calculated MDD was 0.000678
 ;      rounding to 3 decimals was 0.001 then display 0.001.
 ;    - If calculated GDI was 0.000001234
 ;      rounding to 5 decimals was 0.00000 then display 0.000001.
 ;    - If calculated MDD was 0.00000678
 ;      rounding to 5 decimals was 0.00001 then display 0.00001.
 N ND,X2,X3
 ; -- check for missing variable, exit if not defined
 I $G(X)'>0 Q 0
 ; -- get number of decimals, exclude trailing zeros
 S ND=$L($P(+X,".",2))
 ; -- calculate number of decimals for rounding
 I $G(PSSGDIF) D
 . S X2=$S(X'[".":0,$J(X,"",5)<.00001:$S(ND<6:ND,1:6),ND<5:ND,1:5)
 ELSE  D
 . S X2=$S(X'[".":0,$J(X,"",3)<.001:$S(ND<5:ND,1:5),ND<3:ND,1:3)
 ; -- if value of X is zero, use entire decimal value
 I +$J(X,"",X2)=0 S X2=$L($P(X,".",2))
 ; -- format number
 S X=$J(X,"",X2)
 ; -- strip leading and trailing zeros
 S X=+X
 ; -- add leading 0 for decimal value
 I $E(X)="." S X="0"_X
 ; -- include commas in number format
 I $L($P(X,".",1))>3 S:X'["." X2=0 S X3=$L(X) D COMMA^%DTC
 Q $G(X)
 ;
ERRMSG(PSSDADO,PSSDADB,PSSERRT) ; -- in 2.1 update max daily dose error message if BSA or weight missing
 ;PSSDADO - Order Number
 ;PSSDADB - Base
 ;PSSERRT - Type of Error [Weight or Body surface area]
 N PSSDWL1,PSSERRN,PSSERRM
 ; -- check for missing variables, exit if not defined
 I $G(PSSDADO)']""!($G(PSSDADB)']"")!($G(PSSERRT)']"") Q
 ; -- initialize error number
 S PSSERRN=0
 ; -- initialize error message
 S PSSERRM=$G(PSSERRT)_" required"
 ; -- search for FDB max daily dose error to update
 S PSSDWL1=""
 F  S PSSDWL1=$O(^TMP($J,PSSDADB,"OUT","DOSE","ERROR",PSSDADO,PSSDWL1)) Q:PSSDWL1=""!(PSSERRN>0)  D
 . ; -- check for FDB max daily dose error
 . I $G(^TMP($J,PSSDADB,"OUT","DOSE","ERROR",PSSDADO,PSSDWL1,"MSG"))["Max Daily" D
 . . ; -- set error number to error to update
 . . S PSSERRN=PSSDWL1
 . ; -- check for FDB maximum single dose error, if contains type of error get message
 . I $G(^TMP($J,PSSDADB,"OUT","DOSE","ERROR",PSSDADO,PSSDWL1,"MSG"))["Maximum Single",$G(^("TEXT"))[PSSERRT D
 . . ; -- get FDB maximum single error message
 . . S PSSERRM=$G(^TMP($J,PSSDADB,"OUT","DOSE","ERROR",PSSDADO,PSSDWL1,"TEXT"))
 ; -- update FDB max daily dose error message
 I PSSERRN>0,$G(PSSERRM)]"" S ^TMP($J,PSSDADB,"OUT","DOSE","ERROR",PSSDADO,PSSERRN,"TEXT")=PSSERRM
 Q
 ;
CHKCFREQ(PSSDADO,PSSDBASE,PSSDBASG,PSSDBCAR) ; -- in 2.1 check for custom frequency -- called from PSSDSAPA
 ;PSSDADO - Order Number
 ;PSSDBASE - Base
 ;PSSDBASG - Base for Pharmacy
 ;PSSDBCAR - array documented in PSSDSEXC
 N PSSCFMSG,PSSCNTR,PSSDADNM,PSSDWIEN
 ; -- check for missing variables, exit if not defined
 I $G(PSSDADO)']""!($G(PSSDBASE)']"")!($G(PSSDBASG)']"") Q
 I $G(PSSDADO)]"",'$D(PSSDBCAR(PSSDADO)) Q
 ; -- if exclude from Daily Dose check based on Schedule=1 or indicate this Dosing sequence is part of a complex order=1
 ;    or dosing sequence to do Daily Dose check, based on sum of previous Dosing sequences in complex order=1, exit don't include custom frequency
 I $P(PSSDBCAR(PSSDADO),"^",15)!($P(PSSDBCAR(PSSDADO),"^",16))!($P(PSSDADO,";",5)) Q
 ; -- set PSSDADNM=Drug Name, PSSDWIEN=Drug IEN, PSSCNTR=Counter
 S PSSDADNM=$P(PSSDBCAR(PSSDADO),"^",2),PSSDWIEN=+$P(PSSDBCAR(PSSDADO),"^",3),PSSCNTR=$P(PSSDADO,";",4)
 ; -- check for custom frequency
 I $G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDADO,PSSDADNM,"FREQ","FREQUENCYCUSTOMMESSAGE",PSSDWIEN))]"" S PSSCFMSG=$G(^(PSSDWIEN)) D
 .S ^TMP($J,PSSDBASG,"OUT",PSSCNTR,PSSDADO,"MESSAGE","4_TRAIL")=PSSCFMSG
 Q
