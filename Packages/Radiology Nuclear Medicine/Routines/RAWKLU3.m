RAWKLU3 ;HISC/GJC-physician wRVU (scaled too) by procedure ;10/26/05  14:57 [3/15/06 12:30pm]
 ;;5.0;Radiology/Nuclear Medicine;**64,77**;Mar 16, 1998;Build 7
 ;
 ;03/28/07 KAM/BAY Remedy Call 179232 Patch RA*5*77
 ;         Add note to header if current calendar year data was 
 ;         not used in the report creation and added default
 ;         scaling factors
 ;
 ;DBIA#:2541 ($$KSP^XUPARAM) returns the DEFAULT INSTITUTION (#217)
 ;      from the KERNEL SYSTEM PARAMETERS (#8989.3) file.
 ;DBIA#:2171 ($$NAME^XUAF4) resolves the DEFAULT INSTITUTION value into
 ;      the name of the facility
 ;DBIA#:10063 ($$S^%ZTLOAD)
 ;DBIA#:10103 ($$FMTE^XLFDT) & ($$NOW^XLFDT)
 ;DBIA#:10104 ($$CJ^XLFSTR)
 ;
EN ;entry point; called from RAWKLU2...
 S RAFAC=$$NAME^XUAF4(+$$KSP^XUPARAM("INST"))
 S:RAFAC="" RAFAC="***undefined facility name***"
 S $P(RALN,"-",IOM+1)="",(RACNT,RAPG,RAXIT)=0
 S RAHDR="IMAGING PHYSICIAN "_$S(RASCLD=1:"SCALED",1:"UN-SCALED")_" wRVU SUMMARY BY CPT"
 S RARDATE=$$FMTE^XLFDT($$NOW^XLFDT,"1D")
 ;
 ;get the data from the global array and print it...
 D HDR S RASTF=""
 F  S RASTF=$O(^TMP($J,"RA BY STFPHYS",RASTF)) Q:RASTF=""  D  Q:RAXIT  D PHYTTL
 .S RADAT(0)=$G(^TMP($J,"RA BY STFPHYS",RASTF))
 .S RATTLXP=$P(RADAT(0),U),RATLRVUP=$P(RADAT(0),U,2)
 .W !,RASTF S RACPT=""
 .F  S RACPT=$O(^TMP($J,"RA BY STFPHYS",RASTF,RACPT)) Q:RACPT=""  D  Q:RAXIT
 ..S RAWRVU=""
 ..F  S RAWRVU=$O(^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU)) Q:RAWRVU=""  D  Q:RAXIT
 ...S RAPRC=""
 ...F  S RAPRC=$O(^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU,RAPRC)) Q:RAPRC=""  D  Q:RAXIT
 ....S RADAT(1)=$G(^TMP($J,"RA BY STFPHYS",RASTF,RACPT,RAWRVU,RAPRC))
 ....S RATTLX=$P(RADAT(1),U,2) ;total # of exams
 ....S RATTLRVU=$P(RADAT(1),U,3) ;total wRVU for a multiple occurances of the same CPT
 ....S RACNT=RACNT+1 S:RACNT#500=0 (RAXIT,ZTSTOP)=$$S^%ZTLOAD() Q:RAXIT
 ....I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 ....W !?2,RACPT,?12,$E(RAPRC,1,35),?50,$J(RAWRVU,6,2),?58,$J(RATTLX,8,0),?70,$J(RATTLRVU,8,2)
 ....Q
 ...Q
 ..Q
 .Q
 ;
 I RAXIT D XIT Q
 I 'RACNT W !,$$CJ^XLFSTR("No data found for this report",IOM) D XIT Q 
 ;
DSPSFTR ;display CY i-type scaling factors if appropriate
 ;04/13/2007 KAM/BAY RA*5*77 added default scaling factors
 I RASCLD=1 S RASFACTR="" D
 .I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 .W !!,"For calendar year "_($E(DT,1,3)+1700)_" the following scaling factors apply:"
 .S I=0
 . ;04/13/07 KAM/BAY RA*5*77 Modified next line to loop thru all imaging types
 .F  S I=$O(^RA(79.2,I)) Q:'I  D  Q:RAXIT
 ..S I(0)=$G(^RA(79.2,I,0))
 ..I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 .. ;04/13/07 KAM/BAY Added $S to next line
 .. W !,$P(I(0),U),?34,$P(I(0),U,3),?49,$S($O(^RA(79.2,I,"CY",0))>0:$$SFCTR^RAWRVUP(I,DT),1:"1.00 (default)")
 ..Q
 .Q
XIT ;exit and kill variables
 K I,RACNT,RACPT,RADAT,RAFAC,RAHDR,RAI,RALN,RAPG,RAPRC,RARDATE,RASFACTR
 K RASTF,RATLRVUP,RATTLRVU,RATTLX,RATTLXP,RAWRVU
 Q
 ;
HDR ; Header for our report
 W:RAPG!($E(IOST,1,2)="C-") @IOF
 S RAPG=RAPG+1
 W !?(IOM-$L(RAHDR)\2),RAHDR
 W !,"Run Date: ",RARDATE,?68,"Page: ",RAPG
 W !,"Facility: ",RAFAC,?41,"Date Range: ",RABGDTX_" - "_RAENDTX
 ;header formatting logic for CPT scaled/un-scaled wRVU reports
 ;03/28/07 KAM/BAY RA*5*77/179232 Added next 2 lines
 I $G(RACYFLG) D
 . W !,?7,"***This report was prepared with "_$$LASTCY^FBAAFSR()_" Calendar Year RVU Data***"
 W:'$D(RASFACTR)#2 !!,"Staff Physician",?58,"Total #",?73,"Total",!?2,"CPT Code",?12,"Procedure",?51,$S(RASCLD=1:"SwRVU",1:" wRVU"),?58,"of exams",?73,$S(RASCLD=1:"SwRVU",1:" wRVU")
 W:$D(RASFACTR)#2 !,"Imaging Type",?34,"Abbreviation",?49,"wRVU scaling factor"
 W !,RALN
 Q
 ;
PHYTTL ;print the procedure & wRVU totals for the staff physician
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 W !?59,"-------",?71,"-------",!?58,$J(RATTLXP,8,0),?70,$J(RATLRVUP,8,2)
 Q
 ;
