RCRJRCO ;WISC/RFJ-control collection of monthly data ;1 Nov 97
 ;;4.5;Accounts Receivable;**96,106,101,103,147,156,169,170,174,191,203,239**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;  called by menu option to regenerate monthly data
 N %,%DT,%X,%Y,DA347,DIQ2,DATEMOYR,FMSDOCNO,GECSDATA,LASTMONT,RCRJFAR1,RCRJFAR2,RCRJFBDR,RCRJFOIG,RCRJFSV,RCRJFTR,RCRJFWR,X,Y,ZTSK,RCNOHSIF
 ;
 S RCNOHSIF=$$NOHSIF() ; HSIF is disabed
 ;
 W !!,"This option will re-run the AR Data Collector, extracting data from"
 W !,"the AR database and sending the data to the National Database and FMS."
 W !,"It will also re-generate the Bad Debt Report and the OIG Extract."
 W !!,"This option will perform the following tasks:",!
 W !,"  1.  Re-send the data to the National Database.  The data will only be"
 W !,"      re-sent if you answer YES to the prompt.  The data will only be"
 W !,"      accepted in the NDB if the month-year has not been closed (in the NDB)."
 W !,"  2.  Re-send the data to FMS on the SV and WR documents.  The data"
 W !,"      will only be re-sent if it has not been previously accepted by FMS."
 W !,"  3.  Re-send the OIG Extract.  If the selected month is the end of the"
 W !,"      quarter (December, March, June, or September), the OIG Extract can"
 W !,"      be re-generated."
 ;
 ;  do not allow dates in future to be selected
 ;S (LASTMONT,DATEMOYR)=$$PREVMONT^RCRJRBD(DT)
 I $E(DT,6,7)'>$E($$LDATE^RCRJR(DT),6,7) S (LASTMONT,DATEMOYR)=$$PREVMONT^RCRJRBD(DT)
 I $E(DT,6,7)>$E($$LDATE^RCRJR(DT),6,7) S (LASTMONT,DATEMOYR)=$E($$LDATE^RCRJR(DT),1,5)_"00"
 S %DT(0)=-LASTMONT
 S %DT("A")="Retransmit AR Data Collector data for Month/Year: "
 S %DT="AEMP"
 W ! D ^%DT
 I Y<1 Q
 ;
 S (DATEMOYR,Y)=$E(Y,1,5)_"00" D DD^%DT
 ;
 ;  try and find SV document to see if its accepted
 K GECSDATA
 D KEYLOOK^GECSSGET("SV-"_DATEMOYR,1)
 I $G(GECSDATA) D  Q:'$G(GECSDATA)
 .   W !!,"The SV document has been transmitted to fms, document number: "_GECSDATA("2100.1",GECSDATA,".01","E")
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="A" D  Q
 .   .   W !,"The SV document has been ACCEPTED in FMS and will not be resent."
 .   .   S RCRJFSV=1
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="R" D  Q
 .   .   W !,"The SV document has REJECTED and will be RETRANSMITTED."
 .   W !,"The SV document has NOT been ACCEPTED in FMS."
 .   S %=$$ASKTRANS I %<0 K GECSDATA Q
 .   I %'=1 S RCRJFSV=1  ;do not send document
 ;
 ;  try and find WR document to see if its accepted
 K GECSDATA
 D KEYLOOK^GECSSGET("WR-"_DATEMOYR,1)
 I $G(GECSDATA) D  Q:'$G(GECSDATA)
 .   W !!,"The WR document has been transmitted to fms, document number: "_GECSDATA("2100.1",GECSDATA,".01","E")
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="A" D  Q
 .   .   W !,"The WR document has been ACCEPTED in FMS and will not be resent."
 .   .   S RCRJFWR=1
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="R" D  Q
 .   .   W !,"The WR document has REJECTED and will be RETRANSMITTED."
 .   W !,"The WR document has NOT been ACCEPTED in FMS."
 .   S %=$$ASKTRANS I %<0 K GECSDATA Q
 .   I %'=1 S RCRJFWR=1  ;do not send document
 ;
 ;  try and find the Bad Debt SV document to see if its accepted
 K GECSDATA
 D KEYLOOK^GECSSGET("SV-"_$E(DATEMOYR,1,5)_"01",1)
 I $G(GECSDATA) D  Q:'$G(GECSDATA)
 .   W !!,"The Bad Debt SV document has been transmitted to fms, document number: "_GECSDATA("2100.1",GECSDATA,".01","E")
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="A" D  Q
 .   .   W !,"The Bad Debt SV document has been ACCEPTED in FMS and will not be resent."
 .   .   S RCRJFBDR=1
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="R" D  Q
 .   .   W !,"The Bad Debt SV document has REJECTED and will be RETRANSMITTED."
 .   W !,"The Bad Debt SV document has NOT been ACCEPTED in FMS."
 .   S %=$$ASKTRANS I %<0 K GECSDATA Q
 .   I %'=1 S RCRJFBDR=1  ;do not send document
 ;
 ;  try and find TR document to see if its accepted
 K GECSDATA
 I 'RCNOHSIF D KEYLOOK^GECSSGET("TR-"_DATEMOYR,1)
 I $G(GECSDATA) D  Q:'$G(GECSDATA)
 .   W !!,"The TR document has been transmitted to fms, document number: "_GECSDATA("2100.1",GECSDATA,".01","E")
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="A" D  Q
 .   .   W !,"The TR document has been ACCEPTED in FMS and will not be resent."
 .   .   S RCRJFTR=1
 .   I $E($G(GECSDATA(2100.1,GECSDATA,3,"E")))="R" D  Q
 .   .   W !,"The TR document has REJECTED and will be RETRANSMITTED."
 .   W !,"The TR document has NOT been ACCEPTED in FMS."
 .   S %=$$ASKTRANS I %<0 K GECSDATA Q
 .   I %'=1 S RCRJFTR=1  ;do not send document
 ;
 I RCNOHSIF S RCRJFTR=1  ;do not send TR if disabled
 ;
 ;  ask to resend AR1 NDB data
 S %=$$ASKNDB("AR1") I %<0 Q
 I %'=1 S RCRJFAR1=1  ;do not send to ndb
 ;
 ;  ask to resend AR2 NDB data
 S %=$$ASKNDB("AR2") I %<0 Q
 I %'=1 S RCRJFAR2=1  ;do not send to ndb
 ;
 ;  ask to resend the OIG extract
 S RCRJFOIG=1  ;  resend the OIG extract
 D  I %<0 Q
 .   S %=$$ASKOIG I %<0 Q
 .   I %=1 S RCRJFOIG=0  ;re-send oig extract
 ;
 ;
 I $G(RCRJFAR1),$G(RCRJFAR2),$G(RCRJFSV),$G(RCRJFWR),$G(RCRJFTR),$G(RCRJFBDR),$G(RCRJFOIG) W !!,"No reports have been selected for retransmission." Q
 ;
 W !!,"This option will retransmit the following monthly reports:"
 I '$G(RCRJFAR1) W !,"  AR1 to the NDB."
 I '$G(RCRJFAR2) W !,"  AR2 to the NDB."
 I '$G(RCRJFSV) W !,"  SV document to FMS."
 I '$G(RCRJFWR) W !,"  WR document to FMS."
 I '$G(RCRJFTR) W !,"  TR document to FMS."
 I '$G(RCRJFBDR) W !,"  rebuild the Bad Debt Report."
 I '$G(RCRJFOIG) W !,"  resend the OIG Extract."
 ;
 I $$ASKOKAY(DATEMOYR)=1 D
 .   W !!,"This will be queued to run in the background.  When it completes,"
 .   W !,"a mail message will be sent to the mail group RC AR DATA COLLECTOR."
 .   S ZTDESC="AR Data Collector",ZTRTN="DQ^RCRJRCO",ZTDTH=$H,ZTIO=""
 .   S ZTSAVE("DATEMOYR")="",ZTSAVE("RCRJF*")="",ZTSAVE("ZTREQ")="@"
 .   D ^%ZTLOAD
 .   W !!,"Queued to run in task ",$G(ZTSK)
 Q
 ;
 ;
DQ ;  start collection of monthly data
 ;  datemoyr is for the month and year to run collector (ex 2971000)
 ;  rcrjfsv and rcrjfwr are flags to stop the sv and wr documents
 ;  rcrjfbdr is a flag to stop the rebuild of the bad debt report
 N %,DATEBEG,DATEEND,PRCASITE,X
 ;
 I $$NOHSIF() S RCRJFTR=1 ; disable TR to FMS
 ;  get last month
 I $G(DATEMOYR) S DATEEND=$$LDATE^RCRJR(DATEMOYR)
 I '$G(DATEMOYR) S DATEEND=$$LDATE^RCRJR(DT),DATEMOYR=$E(DATEEND,1,5)_"00"
 ;
 ;S DATEBEG=$$LDATE^RCRJR($$PREVMONT^RCRJRBD(DATEEND))+1
 S DATEBEG=$S(+$E(DATEEND,2,5)=309:$E(DATEEND,1,5)_"01",1:$$LDATE^RCRJR($$PREVMONT^RCRJRBD(DATEEND))+1)
 ;S DATEEND=$P("31^28^31^30^31^30^31^31^30^31^30^31","^",+$E(DATEMOYR,4,5)) I DATEEND=28,((17+$E(DATEMOYR))_$E(DATEMOYR,2,3))#4=0 S DATEEND=29
 ;S DATEEND=$$LDATE^RCRJR(DT)
 ;S DATEEND=$E(DATEMOYR,1,5)_DATEEND
 ;
 S PRCASITE=$$SITE^RCMSITE
 ;
 ;  queue the AR2 data collector to run in the background
 I '$G(RCRJFAR2) D
 .   S ZTDESC="AR2 Data Collector",ZTRTN="DQ^RCRJRCO2",ZTDTH=$H,ZTIO=""
 .   S ZTSAVE("PRCASITE")="",ZTSAVE("DATEBEG")="",ZTSAVE("DATEEND")="",ZTSAVE("ZTREQ")="@"
 .   D ^%ZTLOAD
 ;
 ;  no point in running data collector, nothing being sent
 I $G(RCRJFAR1),$G(RCRJFSV),$G(RCRJFWR),$G(RCRJFTR),$G(RCRJFBDR),$G(RCRJFOIG) Q
 ;
 ;  run the AR1 data collector
 D START^RCRJRCOL(PRCASITE,DATEBEG,DATEEND)
 Q
 ;
 ;
ASKNDB(REPORT) ;  ask to resend to national database
 ;  report = AR1 or AR2
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Do you want to resend the "_REPORT_" data to the National Database"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ASKBDR() ;  ask to rebuild the bad debt report
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Do you want to rebuild the Bad Debt Report"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ASKOKAY(DATEMOYR) ;  ask if its okay
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S Y=DATEMOYR D DD^%DT
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Are you SURE you want to regenerate the data for "_Y
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ASKTRANS() ;  ask if its okay to retransmit document to FMS
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S Y=DATEMOYR D DD^%DT
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Do you want to regenerate and retransmit this document to FMS"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;
ASKOIG() ;  ask to resend to oig
 ;  1 is yes, otherwise no
 N DIR,DIQ2,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YO",DIR("B")="NO"
 S DIR("A")="  Do you want to resend the data to the OIG"
 W ! D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S Y=-1
 Q Y
 ;
 ;The Date when AAC is ready for Point Accounts:
PAEFFDT() Q 3031001 ;10/1/2003
 ;
 ; The Data Collector cannot send 5287 Point Accounts before the Effective Date
 ; This function adjusts the fund depending on the current date
ADJFUND(RCFUND) ;
 I DT'<$$PAEFFDT() Q RCFUND ; Do nothing after the effective date
 I $E(RCFUND,1,4)=5287 Q 5287 ; No point accounts before the effective date
 Q RCFUND
 ;
 ; The function returns 1 if MCCF-HSIF transfer is disabled
NOHSIF() ;
 Q (DT'<$$PAEFFDT())  ; Disabled after the AAC is ready.
