PRCPRPCR ;WISC/RFJ-patient distribution costs                       ;11 Mar 94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I "PS"'[PRCP("DPTYPE") W !,"THIS REPORT SHOULD ONLY BE PRINTED BY THE PRIMARY AND SECONDARY INVENTORY POINTS." Q
 N DATEEND,DATESTRT,DISTRALL,END,PRCPFITM,PRCPOPCE,PRCPOPCS,PRCPPATE,PRCPPATS,PRCPSUMM,PRCPSURE,PRCPSURS,START,X,Y
 K X S X(1)="The Patient Distribution Cost Report will print all items distributed to patients for a selected time frame."
 D DISPLAY^PRCPUX2(40,79,.X)
 ;
 ;  select the invpts distributing to the patient
 K ^TMP($J,"PRCPURS3")
 I PRCP("DPTYPE")="P" D
 .   K X S X(1)="Besides displaying distributions from the "_PRCP("IN")_" inventory point, select other DISTRIBUTION POINTS to display or ALL" W ! D DISPLAY^PRCPUX2(2,40,.X)
 .   D DISTRSEL^PRCPURS3(PRCP("I"))
 S ^TMP($J,"PRCPURS3","YES",PRCP("I"))=""
 ;
 ;  summary only ?
 S PRCPSUMM=$$SUMMARY^PRCPURS0 I PRCPSUMM<0 D Q Q
 I PRCPSUMM S (PRCPOPCS,PRCPPATS,PRCPSURS)="",(PRCPOPCE,PRCPPATE,PRCPSURE)="z" G GETDATE
 ;
 ;  select surgical specialty start, end with
 K X S X(1)="Select the range of surgery specialties to display.  For example, start with NEUROSUR, end with NEUROSUR to print the surgery specialty NEUROSURGERY." W ! D DISPLAY^PRCPUX2(5,75,.X)
 D RANGE("SURGICAL SPECIALTY") I START="^" D Q Q
 S PRCPSURS=START,PRCPSURE=END
 ;
 ;  select patient start, end with
 K X S X(1)="Select the range of patients to display.  For example, start with SMITH, end with SMITH to print patients with last names of SMITH." W ! D DISPLAY^PRCPUX2(5,75,.X)
 D RANGE("PATIENT NAME") I START="^" D Q Q
 S PRCPPATS=START,PRCPPATE=END
 ;
 ;  select opcode start, end with
 K X S X(1)="Select the range of principal procedure codes to display.  For example, start with 00124, end with 00126 to print procedure codes including and between 00124 and 00126." W ! D DISPLAY^PRCPUX2(5,75,.X)
 D RANGE("PRINCIPAL PROCEDURE CODES") I START="^" D Q Q
 S PRCPOPCS=START,PRCPOPCE=END
 ;
 ;  print items ?
 K X S X(1)="You have the option to break out the report by distributed items.  If you select this option, the report will probably use a lot of paper to print." W ! D DISPLAY^PRCPUX2(5,75,.X)
 S XP="Do you want to list out the items distributed",XH="Enter YES to list out the items distributed to the patient."
 S PRCPFITM=$$YN^PRCPUYN(2) I 'PRCPFITM D Q Q
 ;
GETDATE ;  select date range
 K X S X(1)="Select the date range for displaying patient distribution costs" W ! D DISPLAY^PRCPUX2(2,40,.X)
 D DATESEL^PRCPURS2("") I '$G(DATESTRT) D Q Q
 W ! S %ZIS="Q" D ^%ZIS G:POP Q I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK D Q Q
 .   S ZTDESC="Patient Distribution Cost Report",ZTRTN="DQ^PRCPRPCR"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("D*")="",ZTSAVE("^TMP($J,""PRCPURS3"",")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;  queue starts here
 N %,%I,AVERAGE,DA,DATA,DATE,DFN,DISTRNM,DISTRPT,INOUTPAT,ITEMDA,NOW,OPCODE,PAGE,PATNAME,PRCPFLAG,PRCPFTOT,SCREEN,SSN,SURGDATA,SURGEON,SURGSPEC,TOTCOST,VA,VADM,VAERR,X,Y
 D SORT^PRCPRPC1
 D PRINT^PRCPRPC2
Q D ^%ZISC K ^TMP($J,"PRCPURS3"),^TMP($J,"PRCPRPCR"),^TMP($J,"PRCPRPCRT")
 Q
 ;
 ;
RANGE(TYPE)        ;  start with end with for type
 ;  return variables start and end
 N X
 K START,END
 F  D  Q:$D(START)
 .   W !,"START with ",TYPE,": FIRST// " R X:DTIME I '$T!(X["^") S START="^" Q
 .   I X["?" K X S X(1)="Select the starting "_TYPE_".  If you select the default FIRST entry, NULL entries will be selected." D DISPLAY^PRCPUX2(5,75,.X) Q
 .   S START=X
 I START="^" Q
 F  D  Q:$D(END)
 .   W !,"  END with ",TYPE,": LAST// " R X:DTIME I '$T!(X["^") S END="^" Q
 .   I X["?" K X S X(1)="Select the ending "_TYPE_".  The ending "_TYPE_" should be the same or follow after the starting "_TYPE_"." D DISPLAY^PRCPUX2(5,75,.X) Q
 .   I X="" S X="z"
 .   I START]X K X S X(1)="Ending "_TYPE_" must follow starting "_TYPE_"." D DISPLAY^PRCPUX2(5,75,.X) Q
 .   S END=X
 I END="^" S START="^"
 Q
