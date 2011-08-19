FBNHRCS ;ACAMPUS/dmk-RCS 10-0168 (18-3)
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;this routine will output data needed to complete the CNH codesheet
 ;it is a quarterly report. user will select first, second, third or
 ;fourth quarter and fiscal year.
 ;
 D SITEP^FBAAUTL Q:$G(FBPOP)
 W !!?17,"COMMUNITY NURSING HOME REPORT 10-0168",!!
SELECT ;select quarter
 S DIR(0)="SM^1:First Quarter;2:Second Quarter;3:Third Quarter;4:Fourth Quarter"
 S DIR("?")="Select the reporting quarter"
 D ^DIR K DIR Q:$D(DIRUT)
 Q:'Y  S FBQTR=+Y
 ;
 ;select fiscal year for report
 S DIR(0)="D^::AE",DIR("A")="Fiscal Year: "
 S DIR("?",1)="Examples of Valid Dates:"
 S DIR("?",2)="   1994 or 94 or 1/94 or an exact date"
 S DIR("?")="   If you enter an exact date the Fiscal Year for that date will be used."
 D ^DIR K DIR Q:$D(DIRUT)!('Y)  S FBFY=+Y D
 .  ; set FBBEG  =  beginning date of selected quarter and fiscal year
 .  ; set FBEND  =  ending date of selected quarter and fiscal year
 .  ;
 . S FBBEG=$E(FBFY,1,3)-$S(FBQTR=1:1,1:0)_$P($P($T(DATES+FBQTR),";;",2),"^")
 . S FBEND=$E(FBFY,1,3)-$S(FBQTR=1:1,1:0)_$P($P($T(DATES+FBQTR),";;",2),"^",2)
 ;
CODE I $$VERSION^XPDUTL("GEC")>1.6 W !,"Do you want to generate code sheets for these Nursing Homes?" S DIR(0)="Y",DIR("B")="No" D ^DIR K DIR Q:$D(DTOUT)!($D(DUOUT))  S:Y FBGECS=1
 ;
 W !!,"The CNH 10-0168 (RCS 18-3) will be compiled for the following date range:"
 W !?5,"FROM DATE: ",$$DATX^FBAAUTL(FBBEG),"    TO DATE: ",$$DATX^FBAAUTL(FBEND)
 ;want to continue
 S DIR(0)="Y",DIR("A")="Want to continue",DIR("B")="Yes" D ^DIR K DIR
 G END:$D(DIRUT)!('Y)
 ;
 S PGM="START^FBNHRCS",VAR="FBBEG^FBEND^FBGECS^FBSITE(1)" D ZIS^FBAAUTL G:FBPOP END
 ;
START D START^FBNHRCS1,^FBNHRCS3 G END:$G(FBOUT) I $G(FBGECS) D ^FBNHRCS4
 ;
END K DTOUT,DIRUT,DUOUT,I,J,JJ,K,FB,FBD,FBHIGH,FBLOW,FBI,FBV,FBPOP,FBY,FBSITE,FBQTR,FBBEG,FBEND,FBFY,^TMP($J),VNAM,CNT,FBAASN,FBSN,FBGECS
 D CLOSE^FBAAUTL Q
 ;
DATES ;store date ranges for each quarter (format mmdd $T(DATES)+FBQTR)
 ;;1001^1231
 ;;0101^0331
 ;;0401^0630
 ;;0701^0930
 Q
