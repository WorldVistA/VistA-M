PRSNRDN1 ;WOIFO/KJS - GROUP SUMMARY ACTIVITY DIRECT AND NON DIRECT II REPORT ;080411
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;   
 ; 
GATHER(SKILMIX,GRP,PRSIEN,BEG,END) ;Entry point to gather POC data from 451
 ;INPUT:
 ;   SKILMIX: ARRAY containing totals for various types of work
 ;            subscripted by nurse role (or skill mix)
 ;   GRP: Nurse default location or T&L Unit
 ;   PRSIEN: Nurse ien 450
 ;   BEG,END: FileMan begin and end dates for report
 ;
 N INDEX,CNT,DAYNODE,FMDT,PPIEN,PRSNDAY
 S FMDT=BEG-.1
 S (INDEX,CNT)=0
 F  S FMDT=$O(^PRST(458,"AD",FMDT)) Q:FMDT>END!(FMDT'>0)!STOP  D
 .S DAYNODE=$G(^PRST(458,"AD",FMDT))
 .S PPIEN=+DAYNODE
 .S PRSNDAY=$P(DAYNODE,U,2)
 .K POCD   ;array to hold POC data
 .D L1^PRSNRUT1(.POCD,PPIEN,PRSIEN,PRSNDAY)
 .Q:$G(POCD(0))=0
 .D DATA(.SKILMIX,GRP)
 ;
 Q
 ;
 ;
DATA(SKILMIX,GRP) ;Extract data from POCD array
 ;
 N PRSL,ST,SP,MEAL,HOURS,TT,TIEN,POC,POC1,WIEN,TW,TWD,TYPETM,TYPEWK
 ;
 S PRSL=0
 F  S PRSL=$O(POCD(PRSL)) Q:PRSL'>0  D
 .;
 .;Start and stop time and mealtime
 .S ST=$P(POCD(PRSL),U),SP=$P(POCD(PRSL),U,2),MEAL=$P(POCD(PRSL),U,3)
 .;
 .;Get elapsed time
 .S HOURS=$$AMT^PRSPSAPU(ST,SP,MEAL)
 .;
 .;Type of Time code IEN
 .S (TIEN,TYPETM)=""
 .S TT=$P(POCD(PRSL),U,4)
 .I TT'="" D
 ..;
 ..;Type of Time code
 ..S TIEN=$O(^PRST(457.3,"B",TT,TIEN))
 ..Q:TIEN=""
 ..;
 ..;Description for Type of Time code
 ..S TYPETM=$P(^PRST(457.3,TIEN,0),U,2)  ;eg, Direct Care, AL
 ..;
 .S POC1=""
 .S POC=$P(POCD(PRSL),U,5)
 .I POC'="" D
 ..S POC1=$P($$ISACTIVE^PRSNUT01(DT,POC),U,2) ;Location
 .;
 .;Type of Work Code IEN
 .S (TW,TWD)=""
 .S WIEN=$P(POCD(PRSL),U,6)
 .I WIEN'="" D
 ..;
 ..;Type of Work Code
 ..S TW=$P(^PRSN(451.5,WIEN,0),U)
 ..;
 ..;Description for Type of Work code
 ..S TWD=$P(^PRSN(451.5,WIEN,0),U,2)
 .
 .;  save skill mix, hours and type of work into SKILMIX array
 .Q:(TYPETM="")!(POC1="")
 .;
 .S TYPEWK=$S(TW="DC":"Direct",1:"Non Direct")
 .S SKILMIX(GRP,TYPETM,TYPEWK)=$G(SKILMIX(GRP,TYPETM,TYPEWK))+HOURS
 Q
HDR(EXTBEG,EXTEND) ;Display header for report of Individual Nurse Activity
 ;
 W @IOF
 S PG=PG+1,PRTGP=1
 W ?17,"GROUP SUMMARY ACTIVITY DIRECT AND NON DIRECT REPORT"
 W !,?15,EXTBEG_" - "_EXTEND,?45,"Run Date: ",TODAY,?70,"Page: ",$J(PG,3)
 W !         ;blank line
 W !,"Location",?22,"Type of Time",?44,"Type of Work",?75,"Hours"
 W !,"--------------------------------------------------------------------------------"
 ;
 Q
PRTLP(EXTBEG,EXTEND) ;Order through SKILMIX array, total data & display
 N RNDC,LNDC,UNDC,GP,TNDC,TYPEWK,TYPETM
 S GP=0
 F  S GP=$O(SKILMIX(GP)) Q:GP=""!STOP  D
 .S TYPETM="",PRTGP=1
 .F  S TYPETM=$O(SKILMIX(GP,TYPETM)) Q:TYPETM=""!STOP  D
 ..S (RNDC,LNDC,UNDC,TNDC)=0
 ..S TYPEWK=""
 ..F  S TYPEWK=$O(SKILMIX(GP,TYPETM,TYPEWK)) Q:TYPEWK=""!STOP  D
 ...S TOTHRS=$P(SKILMIX(GP,TYPETM,TYPEWK),U)
 ...D PPP(.STOP,EXTBEG,EXTEND)
 Q
PPP(STOP,EXTBEG,EXTEND) ;
 I PRTGP W !,GP S PRTGP=0
 W ?22,TYPETM,?44,TYPEWK,?72,$J(TOTHRS,8,2),!
 I (IOSL-5)<$Y S STOP=$$ASK^PRSLIB00() I 'STOP D HDR(EXTBEG,EXTEND)
 Q
