PSJMISC2 ;BIR/MV - MISC. CALLS FOR IV DOSING CHECKS;6 Jun 07 / 3:37 PM
 ;;5.0;INPATIENT MEDICATIONS ;**181,252,256**;16 DEC 97;Build 34
 ; Reference to ^PS(51.1 is supported by DBIA #2177
 ; Reference to ^PSSDSAPI is supported by DBIA #5425
 ;
P8(PSJINFRT) ;Set infusion rate in term of numeric, dose unit over time unit
 ;PSJINFRT - Infusion Rate
 ;Return either Null or numeric^doseUnit^timeUnit
 ;PWJP8ERR - Must be clean up by calling routine.
 ;PSJP8ERR = 1 - "FRQ_ERROR"
 ;PSJP8ERR = 2 - "WT_ERROR"
 ;PSJP8ERR = 3 - "HT_ERROR"
 ;PSJP8ERR = 4 - Set both WT & HT error
 ;
 I $G(PSJINFRT)="" Q ""
 NEW X,PSJBSA,PSJBSAFG,PSJHT,PSJWT,PSJWTFG,PSJTIME,PSJUNIT,PSJP1,PSJP2,PSJNUT,PSJUP8
 K PSJP8ERR
 S PSJUP8=$$UP^XLFSTR(PSJINFRT)
 I $S(PSJUP8["TITRATE AT ":0,PSJUP8["TITRATE":1,1:0) S PSJP8ERR=1 Q ""
 I PSJUP8["BOLUS" S PSJP8ERR=1 Q ""
 S PSJP1=$P(PSJUP8,"@")
 S:PSJP1["INFUSE OVER " PSJP1=$P(PSJP1,"INFUSE OVER ",2)
 S:PSJP1["INFUSE AT " PSJP1=$P(PSJP1,"INFUSE AT ",2)
 S:PSJP1["INFUSE " PSJP1=$P(PSJP1,"INFUSE ",2)
 S:PSJP1["OVER " PSJP1=$P(PSJP1,"OVER ",2)
 S:PSJP1["START AT " PSJP1=$P(PSJP1,"START AT ",2)
 S:PSJP1["TITRATE AT " PSJP1=$P(PSJP1,"TITRATE AT ",2)
 I PSJP1[" TO " S PSJP8ERR=1 Q ""
 S:PSJP1["," PSJP1=$TR(PSJP1,",","")
 S PSJP1=$TR(PSJP1," ")
 I '+PSJP1 S PSJP8ERR=1 Q ""
 ;
 S PSJP2=$P(PSJUP8,"@",2)
 I PSJUP8["@",$S(PSJP2=0:0,'+PSJP2:1,1:0) S PSJP8ERR=1 Q ""
 ;
 I PSJP1'["/" S PSJP8ERR=1 Q ""
 ;Process ml/hr, mg/day... types
 NEW PSJUOTME
 I $S(PSJP1["/KG/":0,PSJP1["/M2/":0,1:1) S PSJUOTME=$$UNTOTME(PSJP1) Q PSJUOTME
 ;
 ;If Infusion rate contains /KG/, /M2/ and also contains ML/HR
 I PSJP1["ML/HR" S PSJP8ERR=1 Q ""
 ;
 ;Set patient parameter
 S X=$$BSA^PSSDSAPI($G(DFN))
 S PSJHT=+$P(X,U),PSJWT=+$P(X,U,2),PSJBSA=+$P(X,U,3)
 S PSJTIME=$P(PSJP1,"/",3)
 S PSJTIME=$$TIME(PSJTIME)
 S X=$P(PSJP1,"/"),PSJUNIT=$P(X,+X,2)
 I PSJP1["." S PSJUNIT=$$UNIT(PSJUNIT)
 S PSJUNIT=$$UNIT^PSSDSAPI(PSJUNIT)
 ;
 ;Calculate SDA using weight
 I PSJP1["/KG/" S PSJWTFG=$$WT() Q PSJWTFG
 ;
 ;Calculate SDA using  BSA
 I PSJP1["/M2/" S PSJBSAFG=$$BSA() Q PSJBSAFG
 ;
 Q ""
WT() ;
 NEW X
 I $S(PSJUNIT="":1,PSJTIME="":1,'PSJWT:1,'+PSJP1:1,1:0) S PSJP8ERR=2 Q ""
 S X=(+PSJP1*PSJWT)_U_PSJUNIT_U_PSJTIME
 Q X
BSA() ;
 NEW X
 I $S(PSJUNIT="":1,PSJTIME="":1,'PSJBSA:1,'+PSJP1:1,1:0) D  Q ""
 . I $G(PSJHT)=0,($G(PSJWT)=0) S PSJP8ERR=4 Q
 . I $G(PSJHT)=0 S PSJP8ERR=3 Q
 . I $G(PSJWT)=0 S PSJP8ERR=2
 S X=(+PSJP1*PSJBSA)_U_PSJUNIT_U_PSJTIME
 Q X
UNTOTME(PSJINF) ;Process Infusion rate for format of Num Unit/time. Ex: 8MG/HR, 125ML/HR, 1000UNITS/HR@TITRATE
 ;Return n^unit^time if infusion rate contain numeric + Unit over time (8MG/HR;125ML/HR) format in p1^p2^p3
 ;Otherwise return null
 ;PSJINF is already have "OVER" and whatever from "@" removed
 NEW PSJNUM,PSJP1S1,PSJP1S2,PSJUNIT,PSJTIME
 I $G(PSJINF)="" S PSJP8ERR=1 Q ""
 S PSJNUM=+PSJINF
 I 'PSJNUM S PSJP8ERR=1 Q ""
 S PSJP1S1=$P(PSJINF,"/")
 S PSJP1S2=$P(PSJINF,"/",2)
 ; Should be free text if in format: "8MG/HRML/HR" PSJP1S2="HRML/HR"
 I PSJP1S2["ML/HR" S PSJP8ERR=1 Q ""
 S PSJUNIT=$P(PSJP1S1,PSJNUM,2)
 S PSJUNIT=$$UNIT^PSSDSAPI(PSJUNIT)
 I PSJUNIT="" S PSJP8ERR=1 Q ""
 S PSJTIME=$$TIME(PSJP1S2)
 I PSJTIME="" S PSJP8ERR=1 Q ""
 Q PSJNUM_U_PSJUNIT_U_PSJTIME
TIME(PSJTIME) ;
 Q:$G(PSJTIME)="" ""
 I PSJTIME="MIN" Q "MINUTE"
 I PSJTIME="MINUTE" Q "MINUTE"
 I PSJTIME="MINUTES" Q "MINUTE"
 I PSJTIME="HR" Q "HOUR"
 I PSJTIME="HOUR" Q "HOUR"
 I PSJTIME="HOURS" Q "HOUR"
 I PSJTIME="DAY" Q "DAY"
 I PSJTIME="DAYS" Q "DAY"
 Q ""
UNIT(PSJUNIT) ;Remove extra zero after decimal point
 NEW PSJX
 I $G(PSJUNIT)=""!($G(PSJUNIT)=0) Q ""
 F  S PSJX=$E(PSJUNIT,1,1) Q:PSJX'=0  S:PSJX=0 PSJUNIT=$E(PSJUNIT,2,$L(PSJUNIT))
 Q PSJUNIT
OLDSCHD(PSJOLDNM) ;checking if the schedule in the order is an old schedule name
 ;PSJOLDNM(ORD_SCHD) - the schedule as entered in the order
 ;PSJOLDNM(OLD_SCHD) - found an old schedule name
 ;PSJOLDNM(NEW_SCHD) - new schedule name
 ;Note - if schedule is DOW or in DOW format, don't check for Old Schedule Name
 NEW PSJSCH,PSJNSCH,PSJNSCH0,PSJIEN
 S PSJSCH=$G(PSJOLDNM("ORD_SCHD"))
 Q:PSJSCH=""
 I $D(^PS(51.1,"APPSJ",PSJSCH)) Q
 S PSJIEN=$O(^PS(51.1,"D",PSJSCH,0))
 I +PSJIEN D  Q
 . S PSJNSCH0=$G(^PS(51.1,PSJIEN,0))
 . Q:$P(PSJNSCH0,U,5)="D"
 . S PSJNSCH=$P(PSJNSCH0,U,1)
 . Q:$$DOW^PSIVUTL(PSJNSCH)
 . I PSJNSCH]"" S PSJOLDNM("NEW_SCHD")=PSJNSCH,PSJOLDNM("OLD_SCHD")=PSJSCH
 Q
PROMPT(PSJOLDNM,PSJMSGFL) ;display the replaced schedule name and prompt if the user want to continue with the order
 NEW PSJMSG,VALMBCK,PSGORQF
 I $G(PSJOLDNM("ORD_SCHD"))=""!$G(PSJOLDNM("ORD_SCHD"))="" Q
 S PSJMSG="The schedule "_PSJOLDNM("ORD_SCHD")_" has been replaced with "_PSJOLDNM("NEW_SCHD")_" by the system administrator after this order was "_$S($G(PSJMSGFL)="R":"renewed.",1:"entered.")
 W !!!
 D WRITE^PSJMISC(PSJMSG)
 ;PSGORQF=1 if the user said No from the prompt below, VALMBCK="R" from this call. Newed to keep the orig value.
 I $G(PSJMSGFL)]"" S PSGORQF=1 D  D PAUSE^PSJLMUT1
 . I $G(PSJMSGFL)="V" W !,"Please correct the schedule before verifying this order."
 . I $G(PSJMSGFL)="R" W !,"WARNING - Renewed RXs cannot be edited. Please enter new order."
 D:$G(PSJMSGFL)="" CONT^PSJOCDT
 Q $G(PSGORQF)
CHKSCHD(PSJOLDNM,PSJMSGFL) ;
 ;PSJMSGFL = "V" if calling during verification; "R" - renew; null - otherwise
 NEW PSGORQF
 I $G(PSJOLDNM("ORD_SCHD"))]"" D OLDSCHD(.PSJOLDNM)
 I $G(PSJOLDNM("NEW_SCHD"))]"" S PSGORQF=$$PROMPT(.PSJOLDNM,$G(PSJMSGFL))
 Q $G(PSGORQF)
