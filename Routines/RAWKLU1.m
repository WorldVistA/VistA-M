RAWKLU1 ;HISC/GJC-physician workload statistics by wRVU or CPT ;10/26/05  14:57
 ;;5.0;Radiology/Nuclear Medicine;**64,77**;Mar 16, 1998;Build 7
 ;03/28/07 KAM/BAY Remedy Call 179232 Patch RA*5*77
 ;         Add note to header if current calendar year data was
 ;         not used used in the report creation and add default
 ;         scaling factors to print
 ;
 ;DBIA#:2541 ($$KSP^XUPARAM) returns the DEFAULT INSTITUTION (#217)
 ;      from the KERNEL SYSTEM PARAMETERS (#8989.3) file.
 ;DBIA#:2171 ($$NAME^XUAF4) resolves the DEFAULT INSTITUTION value into
 ;      the name of the facility
 ;DBIA#:10063 ($$S^%ZTLOAD)
 ;DBIA#:10103 ($$FMTE^XLFDT) & ($$NOW^XLFDT)
 ;
EN ;entry point; called from RAWKLU...
 S RAFAC=$$NAME^XUAF4(+$$KSP^XUPARAM("INST"))
 S:RAFAC="" RAFAC="***undefined facility name***"
 S $P(RALN,"-",IOM+1)="",(RACNT,RAPG)=0
 S RAHDR="IMAGING PHYSICIAN WORKLOAD SUMMARY BY "
 I RARPTYP="CPT" S RAHDR=RAHDR_"NUMBER OF CPT CODES"
 I RARPTYP="RVU" S RAHDR=RAHDR_$S(RASCLD=1:"SCALED ",1:"")_"PROFESSIONAL COMPONENT CMS RVU"
 S RARDATE=$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 ;
 ;$O through physician names; print totals...
 I RARPTYP="RVU" S RATMP="("_$S(RASCLD'=1:"un-s",1:"S")_"caled wRVU)"
 S RAPCE=$S(RARPTYP="CPT":3,RARPTYP="RVU"&(IOM=132):5,1:7)
 S RATRUNC=$S(RARPTYP="CPT":20,RARPTYP="RVU"&(IOM=80):23,1:27)
 S RAWDTH=$S(RARPTYP="CPT":5,1:8),RADEC=$S(RARPTYP="RVU":2,1:0)
 D HDR S RAX=""
 F  S RAX=$O(^TMP($J,"RA BY STFPHYS",RAX)) Q:RAX=""  D  Q:RAXIT
 .S RACNT=RACNT+1,RAY=$G(^TMP($J,"RA BY STFPHYS",RAX)),RATOT=0
 .;did the user stop the task? Check every five hundred records...
 .S:RACNT#500=0 (RAXIT,ZTSTOP)=$$S^%ZTLOAD() Q:RAXIT
 .W !,$E(RAX,1,RATRUNC) ;physician name
 .D WRITE(RAPCE,0,RAY,RAWDTH,RADEC)
 .S RAFMAT=$P($T(CFMAT+10),";;",2,99)
 .;single physician total for all i-types - adj RAWDTH for totals
 .W ?$P(RAFMAT,U,RAPCE),$J(RATOT,$S(RAWDTH=8:10,1:6),RADEC)
 .I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 .Q
 ;print the imaging type and physician totals...
 I RAXIT D XIT Q
 I 'RACNT W !,$$CJ^XLFSTR("No data found for this report",IOM) D XIT Q
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 S RAY=$G(^TMP($J,"RA BY I-TYPE")),RATOT=0
 W !!,"Physician Total"
 D WRITE(RAPCE,0,RAY,RAWDTH,RADEC)
 S RAFMAT=$P($T(CFMAT+10),";;",2,99)
 ;total for all physicians for all i-types - adj RAWDTH for totals
 W ?$P(RAFMAT,U,RAPCE),$J(RATOT,$S(RAWDTH=8:10,1:6),RADEC) ;physician total for all i-types
 I RASCLD=1 S RASFACTR="" D
 .I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 .W !!,"For calendar year "_($E(DT,1,3)+1700)_" the following scaling factors apply:"
 .S I=0
 . ;04/13/07 KAM/BAY RA*5*77 Modified next line to loop thru all imaging types
 .F  S I=$O(^RA(79.2,I)) Q:'I   D  Q:RAXIT
 ..S I(0)=$G(^RA(79.2,I,0))
 ..I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 .. ;04/13/07 KAM/BAY Added $S to next line for default
 .. W !,$P(I(0),U),?34,$P(I(0),U,3),?49,$S($O(^RA(79.2,I,"CY",0))>0:$$SFCTR^RAWRVUP(I,DT),1:"1.00 (default)")
 ..Q
 .Q
XIT ;exit and kill variables
 K I,RACNT,RADEC,RAFAC,RAFMAT,RAHDR,RAI,RALN,RAPCE,RAPG,RARDATE,RASFACTR,RATAB,RATMP,RATOT
 K RATRUNC,RAWDTH,RAX,RAY
 Q
 ;
HDR ; Header for our report
 W:RAPG!($E(IOST,1,2)="C-") @IOF
 S RAPG=RAPG+1
 W !?(IOM-$L(RAHDR)\2),RAHDR
 W !,"Run Date: ",RARDATE,?68,"Page: ",RAPG
 W !,"Facility: ",$E(RAFAC,1,40),?41,"Date Range: ",RABGDTX_" - "_RAENDTX
 ;03/28/07 KAM/BAY RA*5*77/179232 Added next 2 lines
 I $G(RACYFLG) D
 . W !,?7,"***This report was prepared with "_$$LASTCY^FBAAFSR()_" Calendar Year RVU Data***"
 ;header formatting logic for CPT & RVU reports
 W:RARPTYP="RVU" !,$$CJ^XLFSTR(RATMP,IOM)
 W:RARPTYP="CPT" ! ;CPT report
 N RAPCE S RAPCE=$S(RARPTYP="CPT":2,RARPTYP="RVU"&(IOM=132):4,1:6)
 I '$D(RASFACTR)#2 D
 .W !,"Physician" D WRITE(RAPCE,1)
 W:$D(RASFACTR)#2 !,"Imaging Type",?34,"Abbreviation",?49,"wRVU scaling factor"
 W !,RALN
 Q
 ;
STRTDT(RADATE,RAEARLY) ;Prompt the user for the starting date report verified
 ;RADATE-Today's date; DT-implicitly defined as today's date(internal format)
 ;RAEARLY-Earliest conceivable starting date
 W ! K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y N RARSLT
 S DIR(0)="DA^"_RAEARLY_":"_"DT:PEX"
 S DIR("A",1)="Calculate physician workload over a date range; enter a start date"
 S DIR("A")="of: "
 S DIR("?",1)="Workload is assigned on the date the report is verified, not the date"
 S DIR("?",2)="the report is dictated.",DIR("?",3)=""
 S DIR("?",4)="This is the date from which our search will begin. The starting"
 S DIR("?",5)="date must not precede: "_$$FMTE^XLFDT(RAEARLY,"1D")_" and must not come after: "_RADATE_"."
 S DIR("?")="Dates associated with a time will not be accepted."
 S DIR("B")=RADATE D ^DIR
 S:$D(DIRUT) RARSLT=-1 S:'$D(DIRUT) RARSLT=Y_U_Y(0)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q RARSLT
 ;
ENDDT(RABGDTI,RABGDTX) ;Prompt the user for the ending date report verified (no greater than a 
 ;year after the start date input by the user)
 ;DT-implicitly defined as today's date(internal format)
 ;RABGDTI-The search start date (selected by the user; internal format)
 ;RABGDTX-The search start date (selected by the user; external format)
 W ! K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y N RAEND,RARSLT
 ;is today's date 365 days or more past the start date? If yes, calculate end date
 ;by adding a year to the start date selected by the user
 I $$FMDIFF^XLFDT(DT,RABGDTI,1)'<365 S RAEND=$$FMADD^XLFDT(RABGDTI,365,0,0,0)
 ;if not, default using DT (today's date) 
 S:'$D(RAEND)#2 RAEND=DT
 S DIR(0)="DA^"_RABGDTI_":"_RAEND_":PEX"
 S DIR("A")="Enter an end date of: "
 S DIR("?",1)="Workload is assigned on the date the report is verified, not the date"
 S DIR("?",2)="the report is dictated.",DIR("?",3)=""
 S DIR("?",4)="This is the date in which our search will end. The ending date"
 S DIR("?",5)="must not precede: "_RABGDTX_" and must not exceed: "_$$FMTE^XLFDT(RAEND,"1D")_"."
 S DIR("?")="Dates associated with a time will not be accepted."
 S DIR("B")=$$FMTE^XLFDT(RAEND,"1D") D ^DIR K DIR
 S:$D(DIRUT) RARSLT=-1 S:'$D(DIRUT) RARSLT=Y_U_Y(0)
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 Q RARSLT
 ;
WRITE(RAPCE,HDR,RAY,RAWDTH,RADEC) ;Write out the column headers and the data for our reports.
 ;input: RAPCE=the piece of data referenced from the format string defined in CFMAT (req'd)
 ;         HDR=1 if called from the HDR subroutine, else HDR is 0 (req'd)
 ;         RAY=data to be printed; not a label (optional)
 ;      RAWDTH=field width; right justified (optional)
 ;       RADEC=number of decimal places; either zero or two (optional)
 S RANGE=$S(HDR=1:10,1:9)
 F RAI=1:1:RANGE S RAFMAT=$P($T(CFMAT+RAI),";;",2,99) D
 .S RATAB=$P(RAFMAT,U,RAPCE) S:HDR=0 RATOT=RATOT+$P(RAY,U,RAI)
 .I $P(RAFMAT,U)="NUC",((RAPCE=6)!(RAPCE=7)) W ! ;RVU on 80
 .W ?RATAB,$S(HDR=1:$P(RAFMAT,U),1:$J(+$P(RAY,U,RAI),RAWDTH,RADEC))
 .Q
 K RANGE
 Q
 ;
CFMAT ;ImgTyp Abbr^colabbr-cpt80^col-data80^colabbr-rvu132^col-data132^colabbr-rvu80^col-data80
 ;;RAD^23^21^34^29^30^25
 ;;MRI^29^27^45^40^40^35
 ;;CT^36^33^56^50^51^45
 ;;US^42^39^66^60^61^55
 ;;NUC^47^45^75^70^14^9
 ;;VAS^53^51^85^80^25^20
 ;;ANI^59^57^95^91^36^31
 ;;CARD^64^63^104^100^46^42
 ;;MAM^70^67^115^110^58^53
 ;;Total^75^74^125^120^70^65
 ;;
