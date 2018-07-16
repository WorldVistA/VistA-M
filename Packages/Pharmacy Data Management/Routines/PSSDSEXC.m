PSSDSEXC ;BIR/RTR-Exceptions for Dose call ;02/24/09
 ;;1.0;PHARMACY DATA MANAGEMENT;**117,160,178,206,224**;9/30/97;Build 3
 ;
 ;Called from PSSDSAPD, this routine takes the results from the call to First DataBank and creates displayable TMP
 ;globals for the calling applications. Typically, PSSDBASA indicates a CPRS call, and PSSDBASB indicates a pharmacy call
 ;
 ;PSSDBCAR ARRAY pieces, set mostly in PSSDSAPD and a few other rotuines:
 ;1 = S for Single Dose, D for Daily Dose, B for Both
 ;2 = Drug Name
 ;3 = Drug Internal Entry Number
 ;4 = Frequency Flag
 ;5 = 1 for Maintenance Dose, 0 for Single Dose
 ;6 = 1 to only Show General information (Or General Dose error) and errors (No Single Dose or Daily DOse Messages)
 ;7 = 1 To NEVER show General Dosing information, overrides piece 8
 ;8 = 1 Show General Dosing Guidelines even though piece 1 = "S"
 ;9 = FDB ROUTE
 ;10 = 1 to show General Dosing exception in place of General Dosing information when no General Dosing Information exists
 ;11 = 1 to indicate to show the Daily Dose Error message, (generally screened out in this case)
 ;     because you added up previous Dosages at this Dosing Sequence,
 ;12 = 1 to screen out frequency exceptions
 ;13 = 1, set in this routine and PSSDSAPD, to indicate the need to show the generic exception message
 ;14 = 1 to exclude from all Dose checks based on Schedule
 ;15 = 1 to exclude from Daily Dose check based on Schedule
 ;16 = 1 to indicate this Dosing sequence is part of a complex order
 ;17 = 1 to indicate a GCNSECNQ number problem
 ;18 = 1 to indicate there is an Input Exception
 ;19 = 1 to indicate missing age
 ;20 = 1 to indicate Free Text Dose can't be evaluated
 ;21 = 1 to indicate Free Text Infusion Rate exception
 ;22 = 1 to indicate FDB Warning exists
 ;23 = 1 for missing Dose Route or Dose Type
 ;24 = 1 Indicates Single Dose message or error/exception was shown, and no Daily message  **Added for 2.1 **
 ;25 = 1 Indicates missing weight for drug requiring weight
 ;26 = 1 Indicates missing BSA for drug requiring BSA
 ;27 = 1 Indicates a 2.1 Drug or Order level message tweak was done in PSSDSEXD
 ;28 = 1 Indicates in 2.1 show custom max daily dose message
 ;29 = 1 Indicates in 2.1 max daily dose frequency out of range, show custom frequency message
 ;30 = 1 Indicates in 2.1 NotScreened message tweak in CHECKMSG^PSSDSEXD
 ;31 = 1 Indicates doseRouteDescription is null (Invalid Route passed into FDB)
 ;32 = Text to append to errors/exceptions if Piece 31 is 1
 ;33 = 1 Indicates in 2.1 Dummy Data is being used for call to FDB
 ;34 = 1 to indicate unableToCheck MaxSingleDose
 ;35 = 1 to indicate unableToCheck MaxDailyDose
 ;
 ;PSSDBCAX holds the errors to show
 ;
 ;2.1  PSSDBSNO checks added - if 0, all schedule are excluded from Doising checks
FMT ;PSSDBDGO =1 if you went to interface, 0 if you did not go to interface; PSSDBSNO IS 0 if all schedules are excluded
 N PSSDWLP,PSSDWL1,PSSDWLPV,PSSDWRSN
 I PSSDBASA,PSSDBDGO,PSSDBSNO S ^TMP($J,PSSDBASF,"OUT",0)=^TMP($J,PSSDBASE,"OUT",0)
 I PSSDBASB,PSSDBDGO,PSSDBSNO S ^TMP($J,PSSDBASG,"OUT",0)=^TMP($J,PSSDBASE,"OUT",0)
 I $P($G(^TMP($J,PSSDBASE,"OUT",0)),"^")=-1 Q
 ;
 ;
 ;Set errors
 S PSSDWLP="" F  S PSSDWLP=$O(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP)) Q:PSSDWLP=""  D:'$P(PSSDWLP,";",5)&('$P(PSSDBCAR(PSSDWLP),"^",14))  ;2.1 piece 14 check added
 .D CKWRN^PSSDSAPK F PSSDWL1=0:0 S PSSDWL1=$O(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1)) Q:'PSSDWL1  D NOTS^PSSDSAPA D:'$$ERR1^PSSDSAPK
 ..I $P(PSSDBCAR(PSSDWLP),"^",22),$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"SEV"))'="Warning" Q
 ..I '$P(PSSDBCAR(PSSDWLP),"^",22) I $P(PSSDBCAR(PSSDWLP),"^",19)!$P(PSSDBCAR(PSSDWLP),"^",20)!$P(PSSDBCAR(PSSDWLP),"^",21) Q
 ..S $P(PSSDBCAR(PSSDWLP),"^",24)=1 D RTEXT^PSSDSUTL(PSSDWLP,0) ;2.1
 ..I $G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG"))'="" D
 ...I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG")=$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG"))
 ...I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWLP,"ERROR",PSSDWL1,"MSG")=$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"MSG"))
 ..I $G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"TEXT"))'="" S PSSDWLPV=$S($G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"SEV"))="Warning":0,1:1) D
 ...I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"TEXT")=$S(PSSDWLPV:PSSDWRSN,1:"")_$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"TEXT")) D:'PSSDWLPV
 ....S ^TMP($J,PSSDBASF,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"WARN")="Warning"
 ...I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWLP,"ERROR",PSSDWL1,"TEXT")=$S(PSSDWLPV:PSSDWRSN,1:"")_$G(^TMP($J,PSSDBASE,"OUT","DOSE","ERROR",PSSDWLP,PSSDWL1,"TEXT")) D:'PSSDWLPV
 ....S ^TMP($J,PSSDBASG,"OUT",PSSDWLP,"ERROR",PSSDWL1,"WARN")="Warning"
 ;
 ;
 I PSSDBSNO D EXCP
 I PSSDBSNO D MESQ
 I 'PSSDBDGO!(PSSDBSNO) D
 .I PSSDBASA D  Q
 ..I $D(^TMP($J,PSSDBASF,"OUT")) S ^TMP($J,PSSDBASF,"OUT",0)=1 Q
 ..S ^TMP($J,PSSDBASF,"OUT",0)=0
 .I PSSDBASB D  Q
 ..I $D(^TMP($J,PSSDBASG,"OUT")) S ^TMP($J,PSSDBASG,"OUT",0)=1 Q
 ..S ^TMP($J,PSSDBASG,"OUT",0)=0
 Q
 ;
 ;
EXCP ;Set Exceptions
 N PSSDWE1,PSSDWE2,PSSDWE3,PSSDWE4,PSSDWEE1,PSSDWEE2,PSSDWEX1,PSSDWEX2,PSSDWEX3,PSSDWEX4,PSSDWEX5,PSSDWEX6,PSSDWEX7,PSSDWSR1,PSSDWSR2,PSSDWSR3,PSSDWER1,PSSDWER2,PSSDWEGC,PSSDWER9,PSSNOE9,PSSDWEEX
 S PSSDWEX3="" F  S PSSDWEX3=$O(PSSDBCAR(PSSDWEX3)) Q:PSSDWEX3=""  D ADOSE^PSSDSAPK D:'$P(PSSDBCAR(PSSDWEX3),"^",14)  ;2.1 Piece 14 check added
 .I '$O(PSSDBCAX(PSSDWEX3,0)) Q
 .S PSSDWEX4=0 F PSSDWEX7=0:0 S PSSDWEX7=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX7)) Q:'PSSDWEX7  S PSSDWEX4=PSSDWEX7
 .S PSSDWEX4=PSSDWEX4+1
 .F PSSDWEX5=0:0 S PSSDWEX5=$O(PSSDBCAX(PSSDWEX3,PSSDWEX5)) Q:'PSSDWEX5  I PSSDWEX5=2!(PSSDWEX5=3)!(PSSDWEX5>11) D
 ..I $P(PSSDBCAR(PSSDWEX3),"^",19)!($P(PSSDBCAR(PSSDWEX3),"^",20)) Q
 ..I $P(PSSDBCAR(PSSDWEX3),"^",21) I PSSDWEX5'=3,PSSDWEX5'=12,PSSDWEX5'=13,PSSDWEX5'=14 Q
 ..S PSSDWEX6=$T(ERROR+PSSDWEX5) S PSSDWSR1=$P(PSSDWEX6,";;",4) S $P(PSSDBCAR(PSSDWEX3),"^",24)=1 ;piece 24 added for 2.1
 ..S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)="^^^^^^"_$S(PSSDWSR1:"Daily Dose Range Check Error Summary for Drug: ",1:"Dosing Checks could not be performed for Drug: ")_$P(PSSDBCAR(PSSDWEX3),"^",2)_"^^^" D DSQ
 ..S PSSDWEX4=PSSDWEX4+1
 ;
 ;
 ;Loop through EXCEPTION global, call RESET if Free Text Dosage error exists and EXCEPTION from interface exists, then set 2 processing global outputs
 K PSSDWE3
 S PSSDWE1="" F  S PSSDWE1=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1)) Q:PSSDWE1=""  D NOEXP^PSSDSAPK I '$D(PSSNOE9(PSSDWE1)) S PSSDWEX1(PSSDWE1)="" D:$D(PSSDBCAX(PSSDWE1,1)) RESET D
 .I $P(PSSDBCAR(PSSDWE1),"^",22)!($P(PSSDBCAR(PSSDWE1),"^",14)) Q  ;2.1 piece 14 check added
 .S PSSDWE4=1,(PSSDWSR3,PSSDWER1,PSSDWER2,PSSDWER9)=0
 .S PSSDWEE1=$P($G(PSSDBCAR(PSSDWE1)),"^",2),PSSDWEE2=$P($G(PSSDBCAR(PSSDWE1)),"^",3)
 .D RTEXT^PSSDSUTL(PSSDWE1,1)
 .F PSSDWE2=0:0 S PSSDWE2=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)) Q:'PSSDWE2  S PSSDWSR2=$S($P(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2),"^",7)["Summary":1,1:0) D
 ..S PSSDWEGC=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10) I $$ERR2^PSSDSAPK Q
 ..I $P(PSSDBCAR(PSSDWE1),"^",19),PSSDWEGC'["patient parameters" Q
 ..I '$P(PSSDBCAR(PSSDWE1),"^",19),$P(PSSDBCAR(PSSDWE1),"^",23),PSSDWEGC'["Dose Type",PSSDWEGC'["Dose Route" Q
 ..S $P(PSSDBCAR(PSSDWE1),"^",24)=1 ;2.1
 ..I 'PSSDWSR2 D  Q
 ...I PSSDWE4=1 D  S PSSDWE4=2
 ....I PSSDBASA D HDER1
 ....I PSSDBASB D HDER2
 ...I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)=$S('PSSDWER1:PSSDWRSN,1:"             ")_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10) I PSSDWEGC'["Frequency",PSSDWER9 D HDER3
 ...I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)=$S('PSSDWER1:PSSDWRSN,1:"             ")_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10) I PSSDWEGC'["Frequency",PSSDWER9 D HDER4
 ...S PSSDWE4=PSSDWE4+1,PSSDWER1=1
 ..I 'PSSDWSR3 D  S PSSDWE4=PSSDWE4+1
 ...S PSSDWSR3=1
 ...I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",7)
 ...I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)=$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",7)
 ..I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)=$S('PSSDWER2:PSSDWRSN,1:"             ")_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10)
 ..I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)=$S('PSSDWER2:PSSDWRSN,1:"             ")_$P($G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE2)),"^",10)
 ..S PSSDWE4=PSSDWE4+1,PSSDWER2=1
 ;
 ;
 ;If Free Text error message existed, but no Exception came back from Interface set the Free Text exception
 S PSSDWEX2="" F  S PSSDWEX2=$O(PSSDBCAR(PSSDWEX2)) Q:PSSDWEX2=""  I '$P(PSSDBCAR(PSSDWEX2),"^",19),'$P(PSSDBCAR(PSSDWEX2),"^",22),'$P(PSSDBCAR(PSSDWEX2),"^",14) D  ;2.1 piece 14 check added
 .I '$D(PSSDWEX1(PSSDWEX2)),$D(PSSDBCAX(PSSDWEX2,1)),'$D(PSSNOE9(PSSDWEX2)) D
 ..S $P(PSSDBCAR(PSSDWEX2),"^",24)=1,PSSDWEEX=$S('$P(PSSDBCAR(PSSDWEX2),"^",15)&('$P(PSSDBCAR(PSSDWEX2),"^",16))&($P(PSSDBCAR(PSSDWEX2),"^",5)):"Dosing Checks",1:"Maximum Single Dose Check") ;2.1
 ..D RTEXT^PSSDSUTL(PSSDWEX2,1)
 ..I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,1)=PSSDWEEX_" could not be done for Drug: "_$P(PSSDBCAR(PSSDWEX2),"^",2) ;2.1 change
 ..I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWEX2,"EXCEPTIONS",1)=PSSDWEEX_" could not be performed for Drug: "_$P(PSSDBCAR(PSSDWEX2),"^",2) ;2.1 change
 ..I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,2)=PSSDWRSN_"Free Text Dosage could not be evaluated"
 ..I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWEX2,"EXCEPTIONS",2)=PSSDWRSN_"Free Text Dosage could not be evaluated"
 ..S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX2,1)="^^^^^^Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWEX2),"^",2)_"^^^"_"Free Text Dosage could not be evaluated"
 D CONTINUE^PSSDSEXD ;; Mocha 2.1 Drug Level Message tweaks ;; 
 Q
 ;
 ;
MESQ ;Set Messages
 N PSSDWE5,PSSDWDRG,PSSDWIEN,PSSDWGFB,PSSDWSPS,PSSDWADJ
 S PSSDWE5="" F  S PSSDWE5=$O(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5)) Q:PSSDWE5=""  I $D(PSSDBCAR(PSSDWE5)),'$P(PSSDBCAR(PSSDWE5),"^",14) D  ;2.1 piece 14 check added
 .S PSSDWDRG=$P(PSSDBCAR(PSSDWE5),"^",2),PSSDWIEN=$P(PSSDBCAR(PSSDWE5),"^",3),PSSDWADJ=0 Q:PSSDWDRG=""!('PSSDWIEN)
 .I $G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"SINGLE","STATUSCODE",PSSDWIEN))=5 S $P(PSSDBCAR(PSSDWE5),"^",13)=1
 .I $P(PSSDBCAR(PSSDWE5),"^")="S" D:'$P(PSSDBCAR(PSSDWE5),"^",6) SING D:$P(PSSDBCAR(PSSDWE5),"^",6)!($P(PSSDBCAR(PSSDWE5),"^",8)) GEN Q
 .S PSSDWGFB=0 I $P(PSSDBCAR(PSSDWE5),"^")="D" D:'$P(PSSDBCAR(PSSDWE5),"^",6) DAILY D  Q  ;line broken up and piece 24 check added at end
 ..I $$SHOGEN D GEN
 .D SING,DAILY I $$SHOGEN D GEN
 Q
 ;
 ;
SHOGEN() ;General Dosing Guidelines - Piece 25 and piece 15 check added for 2.1
 I $P(PSSDBCAR(PSSDWE5),"^",16)!($P(PSSDWE5,";",5)) Q 0  ;complex orders, remove in 2.2
 I PSSDWGFB!('$P(PSSDBCAR(PSSDWE5),"^",4))!($D(PSSDBCAX(PSSDWE5,1)))!($P(PSSDBCAR(PSSDWE5),"^",8))!($P(PSSDBCAR(PSSDWE5),"^",6))!(($P(PSSDBCAR(PSSDWE5),"^",24))&($P(PSSDBCAR(PSSDWE5),"^",15))) Q 1
 Q 0
 ;
 ;
SING ;Set Single Dose
 I $P(PSSDBCAR(PSSDWE5),"^",6) Q
 N PSSDWE6
 S PSSDWE6=$G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"SINGLE","STATUSCODE",PSSDWIEN))
 S:PSSDWE6=5 $P(PSSDBCAR(PSSDWE5),U,34)=1
 I PSSDWE6=1 S PSSDWSPS=1 Q
 I PSSDWE6>1,PSSDWE6<5 D  Q
 .S $P(PSSDBCAR(PSSDWE5),"^",24)=1 ;2.1
 .I PSSDBASA D
 ..S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"1_SINGLE","MESSAGE",PSSDWIEN)=PSSDWDRG_": "_^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"SINGLE","MESSAGE",PSSDWIEN)
 .I PSSDBASB D  S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE","1_SINGLE",PSSDWIEN)=PSSDWDRG_": "_^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"SINGLE","MESSAGE",PSSDWIEN)
 ..I $G(PSSDBADJ(PSSDWE5))'="" D ADJUS S PSSDWADJ=1
 Q
 ;
 ;
DAILY ;Set Daily (Range) Dose
 I $P(PSSDBCAR(PSSDWE5),"^",6)!($P(PSSDBCAR(PSSDWE5),"^",15)) Q  ;2.1 piece 15 check added
 N PSSDWE9
 S PSSDWE9=$G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"DAILYMAX","STATUSCODE",PSSDWIEN))
 S:PSSDWE9=5 $P(PSSDBCAR(PSSDWE5),U,35)=1
 Q:PSSDWE9=1
 ;I PSSDWE9=4,$G(PSSDBFRC(PSSDWE5,"CONJ"))="T" Q
 ; -- if status code is between (2 and 4) or ( in 2.1 if show custom max daily dose message flag=1)
 I (PSSDWE9>1&(PSSDWE9<5))!($P(PSSDBCAR(PSSDWE5),"^",28)) D  S $P(PSSDBCAR(PSSDWE5),"^",24)="" D KGEN Q
 .I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"2_RANGE","MESSAGE",PSSDWIEN)=PSSDWDRG_": "_$G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"DAILYMAX","MESSAGE",PSSDWIEN))
 .I PSSDBASB D  S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE","2_RANGE",PSSDWIEN)=PSSDWDRG_": "_$G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"DAILYMAX","MESSAGE",PSSDWIEN))
 ..I $G(PSSDBADJ(PSSDWE5))'="",'PSSDWADJ D ADJUS
 I PSSDWE9=5,'$P(PSSDBCAR(PSSDWE5),"^",29) S PSSDWGFB=1
 Q
 ;
 ;
GEN ;General Dosing Guidelines
 I $P(PSSDBCAR(PSSDWE5),"^",7) Q
 I $P(PSSDBCAR(PSSDWE5),"^",15),$G(PSSDWSPS) D KGEN Q
 I $P(PSSDBCAR(PSSDWE5),"^",16)!($P(PSSDWE5,";",5)) Q  ;complex orders, remove in 2.2
 ;I $D(PSSDBCDP(PSSDWE5)) D SGEN^PSSDSAPA Q   ; works with CRT+31^PSSDSAPD - add both back in 2.2
 I $G(^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"GENERAL","MESSAGE",PSSDWIEN))'="" D  Q
 .I PSSDBASA S ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"3_GENERAL","MESSAGE",PSSDWIEN,1)=^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"GENERAL","MESSAGE",PSSDWIEN)
 .I PSSDBASB S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE","3_GENERAL",PSSDWIEN,1)=^TMP($J,PSSDBASE,"OUT","DOSE",PSSDWE5,PSSDWDRG,"GENERAL","MESSAGE",PSSDWIEN)
 Q
 ;
 ;
KGEN ;Kill General Dosing
 I PSSDBASA K ^TMP($J,PSSDBASF,"OUT","DOSE",PSSDWE5,PSSDWDRG,"3_GENERAL","MESSAGE",PSSDWIEN,1)
 I PSSDBASB K ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE","3_GENERAL",PSSDWIEN,1)
 Q
 ;
 ;
GENERR ;Set General Dosing Guidelines exception
 Q
 D GENERRX^PSSDSAPK
 Q
 ;
 ;
RESET ;Reset main exception global if Free text dose could not be evaluated
 N PSSDWB1,PSSDWB2,PSSDWB3
 S PSSDWB1="" F  S PSSDWB1=$O(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB1)) Q:PSSDWB1=""  D
 .S PSSDWB2=$G(^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB1))
 .I $P(PSSDWB2,"^",10)'="Invalid or Undefined Dose",$P(PSSDWB2,"^",10)'="Invalid or Undefined Dose Unit" S PSSDWB3(PSSDWB1)=^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB1)
 .K ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB1)
 S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,1)="^^^^^^Dosing Checks could not be performed for Drug: "_$P(PSSDBCAR(PSSDWE1),"^",2)_"^^^Free Text Dosage could not be evaluated"
 S PSSDWB2=2,PSSDWB1="" F  S PSSDWB1=$O(PSSDWB3(PSSDWB1)) Q:PSSDWB1=""  D
 .S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWB2)=PSSDWB3(PSSDWB1)
 .S PSSDWB2=PSSDWB2+1
 Q
 ;
 ;
ERROR ;List of errors, for complex orders piece 3 = 1 if only for Daily Dose and adding previous Dosing sequences
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
DFM() ;get Dose Form Indicator
 N PSSDFDFK,PSSDFDFL
 I $G(PSSDBAR("UNIT"))="" Q 0
 S PSSDFDFL=0 F PSSDFDFK=0:0 S PSSDFDFK=$O(^PS(51.24,"C",PSSDBAR("UNIT"),PSSDFDFK)) Q:'PSSDFDFK!(PSSDFDFL)  I '$$SCREEN^XTID(51.24,.01,PSSDFDFK_",") S PSSDFDFL=PSSDFDFK
 I PSSDFDFL,$P($G(^PS(51.24,PSSDFDFL,0)),"^",3) Q 1
 Q 0
 ;
 ;
HDER1 ;Set header for exceptions for Output 1
 I PSSDWEGC["Frequency" D  S PSSDWER9=1 Q
 .S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)="Max Daily Dose Check could not be performed for Drug: "_PSSDWEE1
 S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,PSSDWE4)=$S('$P(PSSDBCAR(PSSDWE1),"^",15)&('$P(PSSDBCAR(PSSDWE1),"^",16)):"Dosing Checks",1:"Maximum Single Dose Check")_" could not be done for Drug: "_PSSDWEE1 Q
 Q
 ;
 ;
HDER2 ;Set header for exceptions for Output 2
 I PSSDWEGC["Frequency" D  S PSSDWER9=1 Q
 .S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)="Max Daily Dose Check could not be performed for Drug: "_PSSDWEE1
 S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",PSSDWE4)=$S('$P(PSSDBCAR(PSSDWE1),"^",15)&('$P(PSSDBCAR(PSSDWE1),"^",16)):"Dosing Checks",1:"Maximum Single Dose Check")_" could not be performed for Drug: "_PSSDWEE1 Q
 Q
 ;
 ;
HDER3 ;Reset header node for Output 1 to Non-Frequency header
 S ^TMP($J,PSSDBASF,"OUT","EXCEPTIONS","DOSE",PSSDWE1,1)="Maximum Single Dose Check could not be done for Drug: "_PSSDWEE1 ;2.1 CHANGE
 Q
 ;
 ;
HDER4 ;Reset header node for Output 2 to Non-frequency header
 S ^TMP($J,PSSDBASG,"OUT",PSSDWE1,"EXCEPTIONS",1)="Maximum Single Dose Check could not be performed for Drug: "_PSSDWEE1 ;2.1 CHANGE
 Q
 ;
 ;
ADJU ;Set Adjusted Dose message
 S:$G(PSSDBFDB(PSSDBLP,"ADJ_MSG"))'="" PSSDBADJ(PSSDBFDB(PSSDBLP,"RX_NUM"))=$G(PSSDBFDB(PSSDBLP,"ADJ_MSG"))
 Q
 ;
 ;
ADJUS ;Set Adjusted Dose message in Output
 S ^TMP($J,PSSDBASG,"OUT",PSSDWE5,"MESSAGE",".5_SINGLE",PSSDWIEN)=$G(PSSDBADJ(PSSDWE5))
 Q
 ;
 ;
DSQ ;
 S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)=^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)_$P(PSSDWEX6,";;",3)
 I $G(PSSDBCAX(PSSDWEX3,PSSDWEX5))="" Q
 S ^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)=^TMP($J,PSSDBASE,"OUT","EXCEPTIONS","DOSE",PSSDWEX3,PSSDWEX4)_$G(PSSDBCAX(PSSDWEX3,PSSDWEX5))
 Q
