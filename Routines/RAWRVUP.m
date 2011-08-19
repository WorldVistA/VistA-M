RAWRVUP ;HISC/GJC-Display procedures with their wRVU values  ;10/26/05  14:57
 ;;5.0;Radiology/Nuclear Medicine;**64,77**;Mar 16, 1998;Build 7
 ;09/25/06 KAM/BAY Remedy Call 154793 PATCH *77 RVU with 0 value
 ;         and changed CPT calls from ^ICPTCOD to ^RACPTMSC
 ;         eliminating the need for IA's 1995 amd 1996
 ;03/28/07 KAM/BAY Remedy Call 179232 Patch RA*5*77
 ;         Add check to see if current RVU data is available and if 
 ;         not use previous year RVU data and added default scaling
 ;         factors
 ;
 ;DBIA#:4799 ($$RVU^FBRVU) return wRVU value for CPT, CPT Mod, & exam
 ;      date/time
 ;DBIA#:10060 EN1^RASELCT enacts 10060 which allows lookups on the NEW
 ;            PERSON (#200) file
 ;DBIA#:10063 ($$S^%ZTLOAD)
 ;DBIA#:10103 ($$FMTE^XLFDT) & ($$NOW^XLFDT)
 ;DBIA#:10104 ($$CJ^XLFSTR)
 ;DBIA#:1519  ($$EN^XUTMDEVQ)
 ;DBIA#:4432  (LASTCY^FBAAFSR) return last calendar year file
 ;            162.99 was updated
 ;
EN(RASCLD) ;entry point
 ;input: RASCLD=one if scaled, 0 if un-scaled
 K ^TMP($J,"RA PROCEDURES")
 ;
PROC ;allow the user to select one/many/all Rad/Nuc Med procedures
 S RADIC="^RAMIS(71,",RADIC(0)="QEAMZ",RAUTIL="RA PROCEDURES"
 S RADIC("A")="Select Procedures: ",RADIC("B")="All",RAXIT=0
 ;screen: based on user selection of procedure activity and that the
 ;procedure must have a CPT code (only detailed and series procedures)
 S RADIC("S")="I $P(^(0),U,9)" ;must have a CPT code (detailed/series)
 W !! D EN1^RASELCT(.RADIC,RAUTIL)
 S RAXIT=RAQUIT K %W,%Y1,DIC,RADIC,RAQUIT,RAUTIL,X,Y
 ;did the user select physicians to compile data on? if not, quit
 I $O(^TMP($J,"RA PROCEDURES",""))="" D  D XIT Q
 .W !!?3,$C(7),"Rad/Nuc Med Procedures were not selected."
 .Q
 ;
 F I="RASCLD","^TMP($J,""RA PROCEDURES""," S ZTSAVE(I)=""
 S I="RA print wRVUs for Rad/Nuc Med procedures"
 D EN^XUTMDEVQ("START^RAWRVUP",I,.ZTSAVE,,1)
 I +$G(ZTSK)>0 W !!,"Task Number: "_ZTSK,!
 K I,ZTSAVE,ZTSK
 Q
 ;
START ;
 S:$D(ZTQUEUED)#2 ZTREQ="@"
 ; 03/29/07 KAM/BAY Patch RA*5*77/179232 Added RACYFLG to next line
 S $P(RALN,"-",IOM+1)="",(RACNT,RAPG,RAXIT,RACYFLG)=0
 ;03/29/07 KAM/BAY RA*5*77/179232 Added Fee Basis Data Check
 D CHKCY
 S RARUNDT=$$FMTE^XLFDT(DT,"1P")
 S RAHDR="PROCEDURE CPT CODE AND"_$S(RASCLD=1:" SCALED",1:"")_" WORK RELATIVE VALUE UNITS (wRVU)"
 S RAX="" D HDR
 F  S RAX=$O(^TMP($J,"RA PROCEDURES",RAX)) Q:RAX=""  D  Q:RAXIT
 .S RAY=0
 .F  S RAY=$O(^TMP($J,"RA PROCEDURES",RAX,RAY)) Q:'RAY  D  Q:RAXIT
 ..S RACNT=RACNT+1 S:RACNT#500=0 (RAXIT,ZTSTOP)=$$S^%ZTLOAD() Q:RAXIT
 ..S RAMIS(0)=$G(^RAMIS(71,RAY,0))
 ..S RAPROC=$E($P(RAMIS(0),U),1,35) ;truncate to thirty-five chars 
 ..S RAPTYPE=$S($P(RAMIS(0),U,6)="D":"Detailed",1:"Series")
 ..S RAITYPE=$P($G(^RA(79.2,+$P(RAMIS(0),U,12),0)),U,3)
 ..;09/27/2006 KAM/BAY RA*5*77 Changed next line to use ^RACPTMSC
 ..S RACPT=$P(RAMIS(0),U,9),RACPT=$P($$NAMCODE^RACPTMSC(RACPT,DT),U,1)
 ..;determine if there are default CPT modifiers for this procedure; if
 ..;so, does one indicate 'bilateral'? If bilateral multiply wRVU by two.
 ..S RACPTMOD="",RABILAT=0
 ..I $O(^RAMIS(71,RAY,"DCM",0))>0 S RAI=0 D
 ...F  S RAI=$O(^RAMIS(71,RAY,"DCM",RAI)) Q:'RAI  D
 ....S RACPTMOD(0)=+$G(^RAMIS(71,RAY,"DCM",RAI,0))
 ....;09/27/2006 KAM/BAY RA*5*77 Changed next line to use ^RACPTMSC
 ....S RA813(0)=$$BASICMOD^RACPTMSC(RACPTMOD(0),DT)
 ....I 'RABILAT,$P(RA813(0),U,2)=50 S RABILAT=1 ;bilateral multiplier=2
 ....S RACPTMOD=RACPTMOD_$P(RA813(0),U,2)_","
 ....Q
 ...Q
 ..;get wRVU value from FEE BASIS; returns a string: status^value^message
 ..;where status'=1 means "in error"
 .. ;03/29/07 KAM/BAY RA*5*77/179232 Added $S to next line
 ..S RAWRVU=$$RVU^FBRVU(RACPT,RACPTMOD,$S(RACYFLG:DT-10000,1:DT))
 .. ; 09/25/2006 Remedy call 154793 Correct 0 RVUs
 .. I $P(RAWRVU,U,2)=0,RACPTMOD="" D
 ... ;03/29/07 KAM/BAY RA*5*77/179232 Added $S to next line
 ... S RAWRVU=$$RVU^FBRVU(RACPT,26,$S(RACYFLG:DT-10000,1:DT))
 .. ; 
 ..I $P(RAWRVU,U)=1 D
 ...;apply bilateral multiplier if appropriate
 ...S:RABILAT RAWRVU=$P(RAWRVU,U,2)*2
 ...;or not...
 ...S:'RABILAT RAWRVU=$P(RAWRVU,U,2)
 ...Q
 ..E  S RAWRVU=0 ;status some other value than 1; "in error"
 ..;
 ..S:RAWRVU>0 RAWRVU=$J(RAWRVU,1,2)
 ..;
SCALED ..;when scaled find scaled wRVU value
 ..I RASCLD=1,(RAWRVU>0) D
 ...S RASFACTR=$$SFCTR(+$P(RAMIS(0),U,12)) ;pass i-type ptr
 ...S RASWRVU=$J((RAWRVU*RASFACTR),1,2)
 ...Q
 ..E  S RASWRVU=0 ;mult by zero
 ..;
 ..W !,RAPROC,?37,RAPTYPE,?48,RAITYPE,?58,RACPT,?68,$S(RASCLD=1:$J(RASWRVU,7,2),1:$J(RAWRVU,7,2))
 ..I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() D:'RAXIT HDR
 ..Q
 .Q
 I 'RAXIT,(RASCLD) S RASFACTR(0)="" D
 .I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 .W !!,"For calendar year "_($E(DT,1,3)+1700)_" the following scaling factors apply:"
 .S I=0
 . ;04/13/07 KAM/BAY RA*5*77 Modified next line to loop thru all imaging types
 .F  S I=$O(^RA(79.2,I)) Q:'I  D  Q:RAXIT
 ..S I(0)=$G(^RA(79.2,I,0))
 ..I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 ..; 04/13/07 KAM/BAY RA*5*77 Added $S to next line
 .. W !,$P(I(0),U),?34,$P(I(0),U,3),?49,$S($O(^RA(79.2,I,"CY",0))>0:$$SFCTR^RAWRVUP(I,DT),1:"1.00 (default)")
 ..Q
 .S RAXIT=$$EOS^RAUTL5()
 .Q
 D XIT
 Q
 ;
HDR ; Header for our report
 W:RAPG!($E(IOST,1,2)="C-") @IOF
 S RAPG=RAPG+1 W !?(IOM-$L(RAHDR)\2),RAHDR
 W !,"Run Date: ",RARUNDT,?68,"Page: ",RAPG
 ;03/28/07 KAM/BAY RA*5*77/179232 Added next 2 lines
 I $G(RACYFLG) D
 . W !,?7,"***This report was prepared with "_$$LASTCY^FBAAFSR()_" Calendar Year RVU Data***"
 W:'$D(RASFACTR(0))#2 !!,"Procedure",?37,"Proc Type",?48,"Img Type",?58,"CPT Code",?68,$S(RASCLD=1:"  S",1:"   ")_"wRVU"
 W:$D(RASFACTR(0))#2 !!,"Imaging Type",?34,"Abbreviation",?51,"wRVU scaling factor"
 W !,RALN
 Q
 ;
XIT ;kill variables and exit
 I 'RAXIT W:'RACNT !,$$CJ^XLFSTR("No data found for this report",IOM)
 K DILN,DTOUT,DUOUT,I,POP,RA813,RABILAT,RACNT,RACPT,RACPTMOD,RAHDR,RAI
 K RAITYPE,RALN,RAMIS,RAPTYPE,RAPG,RAPROC,RARUNDT,RASCLD,RASFACTR
 K RASWRVU,RAWRVU,RAX,RAXIT,RAY,RAYEAR,X,Y,RACYFLG
 K ^TMP($J,"RA PROCEDURES")
 Q
 ;
SFCTR(RAITYP,RAYEAR) ;return the calendar year specific scaling factor for a
 ;specific imaging type
 ;input: RAITYP=imaging type
 ;       RAYEAR=internal FM date/time format; resolves to current year
 ;return: calendar year specific scaling factor
 N RASF,RAYR S RAYEAR=$G(RAYEAR,DT) ;default to DT (current year)
 S (RAYEAR,RAYR)=$E(RAYEAR,1,3)+1700
 S RASF=+$O(^RA(79.2,RAITYP,"CY","B",RAYEAR,0))
 ;if RASF=0 for the current year, check for the most recent year
 I RASF=0 D
 .S RAYEAR=+$O(^RA(79.2,1,"CY","B",RAYEAR),-1)
 .S RASF=+$O(^RA(79.2,RAITYP,"CY","B",RAYEAR,0))
 .Q
 S RASF=+$P($G(^RA(79.2,RAITYP,"CY",RASF,0)),U,2)
 S:RASF=0 RASF=1 ;defaults to one
 Q $J(RASF,$L(RASF),2)_$S(RAYEAR:" ("_RAYR_")",1:"")
 ;
CHKCY ;03/28/2007 KAM/BAY RA*5*77 Remedy Call 179232 Check for latest RVU
 ;data from Fee Basis
 S RACYFLG=0,Y=$G(DT) D DD^%DT
 I $$LASTCY^FBAAFSR()<$P(Y," ",3) S RACYFLG=1
 Q
