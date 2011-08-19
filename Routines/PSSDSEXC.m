PSSDSEXC ;BIR/RTR-Exceptions for Dose call ;02/24/09
 ;;1.0;PHARMACY DATA MANAGEMENT;**117**;9/30/97;Build 101
 ;
 ;Set Output PSSDOSGL for Dose Call
 ;
 ; 
 ;Document in ICD
 ;Inform CPRS about pharmacy input number and how you may add to it a piece 5
 ;CPRS/Inpatient MUST kill both Output Globals
 ;
 ;4 globals to check:
 ;  Top Level for -1
 ;  errors
 ;  exceptions
 ;  regular data global
 ;loop on Pharmacy Order number, since you may add to it
 ;
 ;
 ;
 ;PSSDBCAR ARRAY pieces:
 ;1 = S for Single, D for Daily B for Both
 ;2 = Drug Name
 ;3 = Drug Internal Entry Number
 ;4 = Frequency Flag
 ;5 = 1 for Maintenance, 0 for Single Dose
 ;6 = 1 to only Show General information (Or General Dose error) and errors (No Single or Range Messages)
 ;7 = 1 To NEVER show General Dosing information, overrides piece 8
 ;8 = 1 Show general even though piece 1 = "S"
 ;9 = FDB ROUTE
 ;10 = 1 to show General Dose exception in place of General Dose info when no General Dose Information exists
 ;PSSDBCAX holds error to show
 ;11 = 1 to indicate to show the Daily Error message because you added up previod Dosage at this DOing Sequence, which dailys are screened out
 ;12 = 1 to screen out frequency exceptions
 ;
FMT ;PSSDBDGO =1 if you wnt to interface, 0 if not (All order are Single Dose and Free Text Dose could not be evaluated
 ;Change IDC where -1 is only check, unless you reset 0 node after your code, but ICD Output is different you these 2
 ;Inform CORS of this
 N PSSDWLP,PSSDWL1,PSSDWLPV
 I PSSDBASA,PSSDBDGO S ^TMP($J,PSSDBASF,"OUT",0)=^TMP($J,PSSDBASE,"OUT",0)
 I PSSDBASB,PSSDBDGO S ^TMP($J,PSSDBASG,"OUT",0)=^TMP($J,PSSDBASE,"OUT",0)
 ;Should be able to just Quit if it's equal to 0, no need to continue?
 I $P($G(^TMP($J,PSSDBASE,"OUT",0)),"^")=-1 Q
 ;
 ;If interface goes down between Ping and Actual DOse Call, and you get the scenarion where you don't have to go
 ;through the interface to show Bad Dose warning, do you still show it if a)It's the only Input Dose, and B) It's
 ;one of many DOsages and it fails becuase of the interface
 ;
 ;Test where all you have is one Dosing sequence that does not go to interface
 ;Set errors, this needs to be re-coded setting all, no codes in error global for single, daily, etc
 ;What if error/exceptions should only be applied to say DOsing sequence 3 of 5 Dosing sequences, you probably just return at the beginning
 ;Is there even a way to tell
 S PSSDWLP="" F  S PSSDWLP=$O(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP)) Q:PSSDWLP=""  D:'$P(PSSDWLP,";",5)
 .F PSSDWL1=0:0 S PSSDWL1=$O(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1)) Q:'PSSDWL1  D:'$$ERR1^PSSDSAPK
 ..I $G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG"))'="" D
 ...I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG")=$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG"))
 ...I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWLP,"ERROR",PSSDWL1,"MSG")=$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG"))
 ..I $G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"TEXT"))'="" S PSSDWLPV=$S($G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"SEV"))="Warning":0,1:1) D
 ...I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"TEXT")=$S(PSSDWLPV:"Reason: ",1:"")_$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"TEXT"))
 ...I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWLP,"ERROR",PSSDWL1,"TEXT")=$S(PSSDWLPV:"Reason: ",1:"")_$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"TEXT"))
 ;
 ;
 ;Set exceptions
 D EXCP
 ;Set messages
 D MESQ
 I 'PSSDBDGO D
 .I PSSDBASA D  Q
 ..I $D(^TMP($J,PSSDBASF,"OUT")) S ^TMP($J,PSSDBASF,"OUT",0)=1 Q
 ..S ^TMP($J,PSSDBASF,"OUT",0)=0
 .I PSSDBASB D  Q
 ..I $D(^TMP($J,PSSDBASG,"OUT")) S ^TMP($J,PSSDBASG,"OUT",0)=1 Q
 ..S ^TMP($J,PSSDBASG,"OUT",0)=0
 Q
 ;
 ;;
EXCP ;Set Exceptions
 ;STill need to do RESET, but also need to add other errors, and also some of those errros need a different heading (Daily Dose checks..)
 ;Maybe add loop on PSSDBCAS at end for each RX_NUM, because they need to stay together AND REMOVE PSSDBCAS CHECK
 ;;Need to set exception documented in ICD (oTHER PIECES STILL NEED SET, WHAT IF FOR A DOSE YOU CREATED)
 ;
 ;
 ;Loop through error array set in PSSDSAPD, add to Main EXCEPTION global (Except for Free Text Dosage Not Evaluated error)
 N PSSDWE1,PSSDWE2,PSSDWE3,PSSDWE4,PSSDWEE1,PSSDWEE2,PSSDWEX1,PSSDWEX2,PSSDWEX3,PSSDWEX4,PSSDWEX5,PSSDWEX6,PSSDWEX7,PSSDWSR1,PSSDWSR2,PSSDWSR3,PSSDWER1,PSSDWER2,PSSDWEGC,PSSDWER9,PSSNOE9
 S PSSDWEX3="" F  S PSSDWEX3=$O(PSSDBCAR(PSSDWEX3)) Q:PSSDWEX3=""  D ADOSE D
 .I '$O(PSSDBCAX(PSSDWEX3,0)) Q
 .S PSSDWEX4=0 F PSSDWEX7=0:0 S PSSDWEX7=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX7)) Q:'PSSDWEX7  S PSSDWEX4=PSSDWEX7
 .S PSSDWEX4=PSSDWEX4+1
 .F PSSDWEX5=0:0 S PSSDWEX5=$O(PSSDBCAX(PSSDWEX3,PSSDWEX5)) Q:'PSSDWEX5  D:PSSDWEX5'=1
 ..S PSSDWEX6=$T(ERROR+PSSDWEX5) S PSSDWSR1=$P(PSSDWEX6,";;",4)
 ..S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)="^^^^^^"_$S(PSSDWSR1:"Daily Dose Range Check Error Summary for Drug: ",1:"Dosing Checks could not be performed for Drug: ")_$P(PSSDBCAR(PSSDWEX3),"^",2)_"^^^" D DSQ
 ..S PSSDWEX4=PSSDWEX4+1
 ;
 ;
 ;Loop through EXCEPTION global, call RESET if Free Text Dosage error exists and EXCEPTION from interface exists, then set 2 processing global outputs
 K PSSDWE3
 S PSSDWE1="" F  S PSSDWE1=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1)) Q:PSSDWE1=""  D NOEXP^PSSDSAPK I '$D(PSSNOE9(PSSDWE1)) S PSSDWEX1(PSSDWE1)="" D:$D(PSSDBCAX(PSSDWE1,1)) RESET D
 .S PSSDWE4=1,(PSSDWSR3,PSSDWER1,PSSDWER2,PSSDWER9)=0
 .S PSSDWEE1=$P($G(PSSDBCAR(PSSDWE1)),"^",2),PSSDWEE2=$P($G(PSSDBCAR(PSSDWE1)),"^",3)
 .F PSSDWE2=0:0 S PSSDWE2=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)) Q:'PSSDWE2  S PSSDWSR2=$S($P(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2),"^",7)["Summary":1,1:0) D
 ..S PSSDWEGC=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10) I $$ERR2^PSSDSAPK Q
 ..I 'PSSDWSR2 D  Q
 ...I PSSDWE4=1 D  S PSSDWE4=2
 ....I PSSDBASA D HDER1
 ....I PSSDBASB D HDER2
 ...I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)=$S('PSSDWER1:"  Reason(s): ",1:"             ")_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10) I PSSDWEGC'["Frequency",PSSDWER9 D HDER3
 ...I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)=$S('PSSDWER1:"  Reason(s): ",1:"             ")_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10) I PSSDWEGC'["Frequency",PSSDWER9 D HDER4
 ...S PSSDWE4=PSSDWE4+1,PSSDWER1=1
 ..I 'PSSDWSR3 D  S PSSDWE4=PSSDWE4+1
 ...S PSSDWSR3=1
 ...I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",7)
 ...I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",7)
 ..I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)=$S('PSSDWER2:"  Reason(s): ",1:"             ")_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10)
 ..I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)=$S('PSSDWER2:"  Reason(s): ",1:"             ")_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10)
 ..S PSSDWE4=PSSDWE4+1,PSSDWER2=1
 ;
 ;
 ;If Free Text error message existed, but no Exception came back from Interface set the Free Text exception
 S PSSDWEX2="" F  S PSSDWEX2=$O(PSSDBCAR(PSSDWEX2)) Q:PSSDWEX2=""  D
 .I '$D(PSSDWEX1(PSSDWEX2)),$D(PSSDBCAX(PSSDWEX2,1)),'$D(PSSNOE9(PSSDWEX2)) D
 ..I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,1)="Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWEX2),"^",2)
 ..I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWEX2,"EXCEPTIONS",1)="Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWEX2),"^",2)
 ..I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,2)="  Reason(s): Free Text Dosage could not be evaluated"
 ..I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWEX2,"EXCEPTIONS",2)="  Reason(s): Free Text Dosage could not be evaluated"
 ..;Need to set exception documented in ICD (OTHER PIECES STILL NEED SET, WHAT IF FOR A DOSE YOU CREATED)
 ..S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,1)="^^^^^^Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWEX2),"^",2)_"^^^"_"Free Text Dosage could not be evaluated"
 Q
 ;
 ;
MESQ ;
 ;To show General DOsing guideline, we check piece 4 of PSSDBCAR for Bad Frequency, is that always reliable?
 ;Our only other alternative to is check for text containing Frequency in the error messages
 N PSSDWE5,PSSDWDRG,PSSDWIEN,PSSDWGFB,PSSDWGER
 S PSSDWE5="" F  S PSSDWE5=$O(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5)) Q:PSSDWE5=""  D
 .S PSSDWGER=0
 .;Next Line, should I set from the TMP global instead of from the PSSDBCAR array
 .S PSSDWDRG=$P($G(PSSDBCAR(PSSDWE5)),"^",2),PSSDWIEN=$P($G(PSSDBCAR(PSSDWE5)),"^",3) Q:PSSDWDRG=""!('PSSDWIEN)
 .I $P($G(PSSDBCAR(PSSDWE5)),"^")="S" D:'$P($G(PSSDBCAR(PSSDWE5)),"^",6) SING D:$P($G(PSSDBCAR(PSSDWE5)),"^",6)!($P($G(PSSDBCAR(PSSDWE5)),"^",8)) GEN Q
 .S PSSDWGFB=0 I $P($G(PSSDBCAR(PSSDWE5)),"^")="D" D:'$P($G(PSSDBCAR(PSSDWE5)),"^",6) DAILY D:PSSDWGFB!('$P($G(PSSDBCAR(PSSDWE5)),"^",4))!($D(PSSDBCAX(PSSDWE5,1)))!($P($G(PSSDBCAR(PSSDWE5)),"^",8))!($P($G(PSSDBCAR(PSSDWE5)),"^",6)) GEN Q
 .D SING,DAILY D:PSSDWGFB!('$P($G(PSSDBCAR(PSSDWE5)),"^",4))!($D(PSSDBCAX(PSSDWE5,1)))!($P($G(PSSDBCAR(PSSDWE5)),"^",8))!($P($G(PSSDBCAR(PSSDWE5)),"^",6)) GEN
 Q
 ;
 ;
SING ;
 I $P($G(PSSDBCAR(PSSDWE5)),"^",6) Q
 N PSSDWE6
 S PSSDWE6=$G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"SINGLE","STATUSCODE",PSSDWIEN))
 Q:PSSDWE6=1
 I PSSDWE6>1,PSSDWE6<5 D  Q
 .I PSSDBASA D
 ..I $G(PSSDBADJ(PSSDWE5))="" S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"1_SINGLE","MESSAGE",PSSDWIEN)=PSSDWDRG_": "_^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"SINGLE","MESSAGE",PSSDWIEN) Q
 ..S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"1_SINGLE","MESSAGE",PSSDWIEN)=$G(PSSDBADJ(PSSDWE5))_" "_PSSDWDRG_": "_^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"SINGLE","MESSAGE",PSSDWIEN)
 .I PSSDBASB D  S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE","1_SINGLE",PSSDWIEN)=PSSDWDRG_": "_^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"SINGLE","MESSAGE",PSSDWIEN)
 ..S:$G(PSSDBADJ(PSSDWE5))'="" ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE",".5_SINGLE",PSSDWIEN)=$G(PSSDBADJ(PSSDWE5))
 Q
 ;
 ;
DAILY ;
 I $P($G(PSSDBCAR(PSSDWE5)),"^",6) Q
 N PSSDWE9
 S PSSDWE9=$G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"RANGE","STATUSCODE",PSSDWIEN))
 Q:PSSDWE9=1
 I PSSDWE9>1,PSSDWE9<5 D  Q
 .I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"2_RANGE","MESSAGE",PSSDWIEN)=PSSDWDRG_": "_^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"RANGE","MESSAGE",PSSDWIEN)
 .I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE","2_RANGE",PSSDWIEN)=PSSDWDRG_": "_^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"RANGE","MESSAGE",PSSDWIEN)
 I PSSDWE9=5 D  S PSSDWGFB=1 Q
 .;S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"2_RANGE","MESSAGE",PSSDWIEN)="Daily dose range check could not be performed for "_PSSDWDRG_". REASON: "_^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"RANGE","MESSAGE",PSSDWIEN)
 Q
 ;
 ;
GEN ;General Dosing Guidelines
 I $P($G(PSSDBCAR(PSSDWE5)),"^",7) Q
 I $G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"GENERAL","MESSAGE",PSSDWIEN))'="" D  Q
 .I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"3_GENERAL","MESSAGE",PSSDWIEN)=^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"GENERAL","MESSAGE",PSSDWIEN)
 .I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE","3_GENERAL",PSSDWIEN)=^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"GENERAL","MESSAGE",PSSDWIEN)
 ;I '$P($G(PSSDBCAR(PSSDWE5)),"^",10) Q
 I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"3_GENERAL","MESSAGE",PSSDWIEN)="General dosing range for "_$P($G(PSSDBCAR(PSSDWE5)),"^",2)_" ("_$P($G(PSSDBCAR(PSSDWE5)),"^",9)_") could not be obtianed from vendor database."
 I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE","3_GENERAL",PSSDWIEN)="General dosing range for "_$P($G(PSSDBCAR(PSSDWE5)),"^",2)_" ("_$P($G(PSSDBCAR(PSSDWE5)),"^",9)_") could not be obtianed from vendor database."
 ;S PSSDWGER=1
 Q
 ;
 ;
GENERR ;Set General Dosing Guidelines exception
 Q
 D GENERRX^PSSDSAPK
 Q
 ;
 ;
RESET ;Reset main exception global if Free text Dose could not be evaluated
 N PSSDWB1,PSSDWB2,PSSDWB3
 S PSSDWB1="" F  S PSSDWB1=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB1)) Q:PSSDWB1=""  D
 .S PSSDWB2=$G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB1))
 .I $P(PSSDWB2,"^",10)'="Invalid or Undefined Dose",$P(PSSDWB2,"^",10)'="Invalid or Undefined Dose Unit" S PSSDWB3(PSSDWB1)=^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB1)
 .K ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB1)
 ;STill need to set other pieces to match ICD, maybe
 S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,1)="^^^^^^Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWE1),"^",2)_"^^^Free Text Dosage could not be evaluated"
 S PSSDWB2=2,PSSDWB1="" F  S PSSDWB1=$O(PSSDWB3(PSSDWB1)) Q:PSSDWB1=""  D
 .S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB2)=PSSDWB3(PSSDWB1)
 .S PSSDWB2=PSSDWB2+1
 Q
 ;
 ;
ERROR ;List of errors, for complex orders piece 3 =1 if only for Daily and adding previous sequences
 ;;1;;Free Text Dosage could not be evaluated
 ;;2;;Invalid or Undefined Frequency
 ;;3;;Free Text Infusion Rate could not be evaluated
 ;;4;;Not all Dose types are Maintenance;;1
 ;;5;;Not all Dose Units are defined or are the same;;1
 ;;6;;Not all Med Routes are defined or are the same;;1
 ;;7;;Not all Frequencies are valid;;1
 ;;8;;Not all Durations are the same;;1
 ;;9;;At least one Duration is less than one day;;1
 ;;10;;At least one Schedule is a Day of Week Schedule;;1
 ;;11;;One or more Free Text Dosages could not be evaluated;;1
 ;;12;;One or more required patient parameters unavailable: Height
 ;;13;;One or more required patient parameters unavailable: Weight
 ;;14;;One or more required patient parameters unavailable: Height, Weight
 ;;15;;Frequency greater than order duration
 Q
 ;
 ;
DUNIT() ;Find unit
 ;Piece 3 of PSSDBCAR must be a File 50 IEN
 N PSSDBEG1,PSSDBEG2,PSSDBEG3,PSSDBEG4,PSSDBEG5,PSSDBEG6,PSSDBEG7,X,Y
 S PSSDBEG4=""
 S PSSDBEG1=$P(PSSDBCAR(PSSDBEB1),"^",3)
 I PSSDBEG1 D  I PSSDBEG4'="" Q PSSDBEG4
 .S PSSDBEG2=$P($G(^PSDRUG(PSSDBEG1,"ND")),"^"),PSSDBEG3=$P($G(^PSDRUG(PSSDBEG1,"ND")),"^",3)
 .I 'PSSDBEG2!('PSSDBEG3) Q
 .S PSSDBEG5=$$DFSU^PSNAPIS(PSSDBEG2,PSSDBEG3)
 .S PSSDBEG6=$P(PSSDBEG5,"^",6)
 .I PSSDBEG6'="" S PSSDBEG7=$$UNIT^PSSDSAPI(PSSDBEG6) I PSSDBEG7'="" S PSSDBEG4=PSSDBEG7
 I PSSDBEG1 F PSSDBEG2=0:0 S PSSDBEG2=$O(^PSDRUG(PSSDBEG1,"DOS2",PSSDBEG2)) Q:'PSSDBEG2!(PSSDBEG4'="")  D
 .S PSSDBEG3=$P($G(^PSDRUG(PSSDBEG1,"DOS2",PSSDBEG2,0)),"^",5)
 .I PSSDBEG3,$P($G(^PS(51.24,PSSDBEG3,0)),"^",2)'="" S PSSDBEG4=$P(^PS(51.24,PSSDBEG3,0),"^",2)
 I PSSDBEG4'="" Q PSSDBEG4
 I PSSDBEG1 S PSSDBEG2=$P($G(^PSDRUG(PSSDBEG1,2)),"^") I PSSDBEG2 D
 .S PSSDBEG3=$P($G(^PS(50.7,PSSDBEG2,0)),"^",2) I PSSDBEG3 D
 ..F PSSDBEG5=0:0 S PSSDBEG5=$O(^PS(50.606,PSSDBEG3,"NOUN",PSSDBEG5)) Q:'PSSDBEG5!(PSSDBEG4'="")  D
 ...S PSSDBEG6=$P($G(^PS(50.606,PSSDBEG3,"NOUN",PSSDBEG5,0)),"^")
 ...I PSSDBEG6'="" S PSSDBEG7=$$UNIT^PSSDSAPI(PSSDBEG6) I PSSDBEG7'="" S PSSDBEG4=PSSDBEG7
 I PSSDBEG4'="" Q PSSDBEG4
 Q "EACH"
 ;
 ;
DFM() ;get Dose Form Indicator
 ;Go over code again, you default to 0, is that OK? you get 1st Active one, regarless of if that's the
 ;one it was dervied from, say in auto-pop logic, but for multiple 51.24 entries with same FDB Routem piece 3 should be the same, right Lina
 ;using SCREEN XTID everywhere in 117, how do you determine UNit, what if MG/ML, at this Tag, should aleayd be piece 2, right
 ;Make sure you got all places where DFN should be called, no other place you are setting piece 6 of TMP global
 ;Make sure Mai wasn't calling this in PSSDSAPD, and test both DFM calls from PSSDSAPD
 N PSSDFDFK,PSSDFDFL
 I $G(PSSDBAR("UNIT"))="" Q 0
 S PSSDFDFL=0 F PSSDFDFK=0:0 S PSSDFDFK=$O(^PS(51.24,"C",PSSDBAR("UNIT"),PSSDFDFK)) Q:'PSSDFDFK!(PSSDFDFL)  I '$$SCREEN^XTID(51.24,.01,PSSDFDFK_",") S PSSDFDFL=PSSDFDFK
 I PSSDFDFL,$P($G(^PS(51.24,PSSDFDFL,0)),"^",3) Q 1
 Q 0
 ;
 ;
HDER1 ;Set header for exceptions for Output 1
 I PSSDWEGC["Frequency" D  S PSSDWER9=1 Q
 .S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)="Daily Dose Range Check could not be performed for Drug: "_PSSDWEE1
 S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",7)
 Q
 ;
 ;
HDER2 ;Set header for exceptions for Output 2
 I PSSDWEGC["Frequency" D  S PSSDWER9=1 Q
 .S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)="Daily Dose Range Check could not be performed for Drug: "_PSSDWEE1
 S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",7)
 Q
 ;
 ;
HDER3 ;Reset header node for Output 1 to Non-Frequency header
 S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,1)="Dosing Checks could not be performed for Drug: "_PSSDWEE1
 Q
 ;
 ;
HDER4 ;Reset header node for Output 2 to Non-frequency header
 S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",1)="Dosing Checks could not be performed for Drug: "_PSSDWEE1
 Q
 ;
 ;
ADOSE ;Add DOSE subscript to any EXCEPTION from interface without DOSE subscript
 I '$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS",PSSDWEX3,"")) Q
 N PSSDWEZ4,PSSDWEZ5,PSSDWEZ6,PSSDWEZ7
 S PSSDWEZ4=0 F PSSDWEZ7=0:0 S PSSDWEZ7=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEZ7)) Q:'PSSDWEZ7  S PSSDWEZ4=PSSDWEZ7
 S PSSDWEZ4=PSSDWEZ4+1
 F PSSDWEZ5=0:0 S PSSDWEZ5=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS",PSSDWEX3,PSSDWEZ5)) Q:'PSSDWEZ5  D
 .S PSSDWEZ6=^TMP($J,PSSDBASE,"OUT","EXCEPTIONS",PSSDWEX3,PSSDWEZ5)
 .S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEZ4)=PSSDWEZ6
 .I $P(PSSDWEZ6,"^",10)'="" S $P(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEZ4),"^",7)="Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWEX3),"^",2)
 .S PSSDWEZ4=PSSDWEZ4+1
 Q
 ;
 ;
ADJU ;Set Adjusted Dose message
 S:$G(PSSDBFDB(PSSDBLP,"ADJ_MSG"))'="" PSSDBADJ(PSSDBFDB(PSSDBLP,"RX_NUM"))=$G(PSSDBFDB(PSSDBLP,"ADJ_MSG"))
 Q
 ;
 ;
DSQ ;
 S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)=^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)_$P(PSSDWEX6,";;",3)
 I $G(PSSDBCAX(PSSDWEX3,PSSDWEX5))="" Q
 S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)=^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)_$G(PSSDBCAX(PSSDWEX3,PSSDWEX5))
 Q
