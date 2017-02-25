PSORRP ;AITC/BWF - Remote RX report ;8/15/16 5:44pm
 ;;7.0;OUTPATIENT PHARMACY;**454**;DEC 1997;Build 349
 ;
EN ; -- main entry point for PSO LM REMOTE RX REPORT
 N PSOREPORT
 D EN^VALM("PSO LM REMOTE RX REPORT")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)=$P("Prescriptions dispensed for other Host Pharmacies^Our prescriptions, filled by other facilities as the Dispensing Pharmacy^All OneVA Pharmacy Prescription Activity","^",PSOREPORT)
 Q
 ;
INIT ; -- init variables and list array
 ;F LINE=1:1:30 D SET^VALM10(LINE,LINE_"     Line number "_LINE)
 ;S VALMCNT=30
 N SBY,DONE,QUIT,SDATE,EDATE,DFN,SITEIEN,DISP,DIR,Y,%DT,DIC,DFN,SITEIEN,DISP
 S VALMCNT=0
 ;S DIR(0)="S^1:Prescriptions dispensed for other Host Pharmacies;2:Our prescriptions, filled by other facilities as the Dispensing Pharmacy;3:All OneVA Pharmacy Prescription Activity"
 ;S DIR("A")="Select item" D ^DIR S PSOREPORT=Y
 S DIR(0)="N^1:3:0"
 S DIR("A",1)=""
 S DIR("A",2)="   1.   Prescriptions dispensed for other Host Pharmacies"
 S DIR("A",3)="   2.   Our prescriptions, filled by other facilities as the Dispensing Pharmacy"
 S DIR("A",4)="   3.   All OneVA Pharmacy Prescription Activity"
 S DIR("A",5)=""
 S DIR("A")="   Select item"
 S DIR("?")="Answer with 1, 2, or 3."
 S DIR("?",1)=""
 S DIR("?",2)="Selecting 1 will display the list of prescriptions that our local facility has"
 S DIR("?",3)="dispensed on behalf of other host Pharmacy locations as part of the OneVA"
 S DIR("?",4)="Pharmacy program. Selecting 2 will display the list of prescriptions other VA"
 S DIR("?",5)="Pharmacy locations have filled as a dispensing site for a prescription that"
 S DIR("?",6)="originated from our location. Selecting 3 will list all prescriptions that"
 S DIR("?",7)="either we have filled for other Pharmacy locations as the dispensing site or"
 S DIR("?",8)="other Pharmacy locations have filled on our behalf."
 S DIR("?",9)=""
 ;S DIR("??")="^D EXTHLP^PSORRP"
 ;
 ;
 D ^DIR S PSOREPORT=Y
 ;
 I Y="^" S VALMQUIT="" Q
 S DISP=Y
 W "  ",$S(DISP=1:"Prescriptions dispensed for other Host Pharmacies",DISP=2:"Our prescriptions, filled by other facilities as the Dispensing Pharmacy",DISP=3:"All OneVA Pharmacy Prescription Activity",1:"")
 ;
 S DISP=$S(DISP=1:"RF^PR",DISP=2:"OR^OP",1:"RF^PR^OR^OP")
 K DIR
 S DIR(0)="S^D:DATE RANGE;P:PATIENT;S:SITE"
 S DIR("A")="Search by"
 S DIR("?")="specific patient or S for a report for a specific VA Pharmacy."
 S DIR("?",1)="Answer with D for report within a specific date range or P for a report for a"
 ;
 D ^DIR
 I Y="^" S VALMQUIT="" Q
 S SBY=Y
 ; if date range
 S QUIT=0
 I SBY="D" D  G:QUIT INIT
 .S DONE=0
 .F  D  Q:DONE!(QUIT)
 ..S %DT="AQEP",%DT("A")="Enter start date: ",%DT("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-30),1) D ^%DT
 ..I Y<0 S QUIT=1 Q
 ..I Y S SDATE=Y,DONE=1
 . Q:QUIT
 .S DONE=0
 .F  D  Q:DONE!(QUIT)
 ..S %DT="AQEP",%DT("A")="Enter end date: ",%DT("B")=$$FMTE^XLFDT(DT,1) D ^%DT
 ..I Y<0 S QUIT=1 Q
 ..I Y S EDATE=Y,DONE=1
 . Q:QUIT
 .D DTRNG(SDATE,EDATE,DISP)
 I SBY="P" D  G:QUIT INIT
 .S DIC="^DPT(",DIC(0)="QEAMZ" D ^DIC I Y<0 S QUIT=1 Q
 .S DFN=+Y
 .D PAT(DFN,DISP)
 I SBY="S" D  G:QUIT INIT
 .S DIC="^DIC(4,",DIC(0)="QEAMZ" D ^DIC I Y<0 S QUIT=1 Q
 .S SITEIEN=+Y
 .D SITE(SITEIEN,DISP)
 I 'VALMCNT,SBY="D" K DIR S DIR(0)="FO",DIR("A")="Nothing to list for this date range. Press return to continue" D ^DIR S VALMQUIT=1
 I 'VALMCNT,SBY="P" K DIR S DIR(0)="FO",DIR("A")="Nothing to list for this patient. Press return to continue" D ^DIR S VALMQUIT=1
 I 'VALMCNT,SBY="S" K DIR S DIR(0)="FO",DIR("A")="Nothing to list for this site. Press return to continue" D ^DIR S VALMQUIT=1
 Q
INITQ ;
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 K VALMQUIT,VALMLST,VALMHDR,VALMAR,VALMBG,VALMCNT
 Q
 ;
EXPND ; -- expand code
 Q
 ;
DTRNG(BEG,END,FLTR) ;
 N IEN,LINE,TCOST,TYPE
 S (LINE,TCOST)=0
 S BEG=BEG-.01,END=END_.2359
 F  S BEG=$O(^PSRXR(52.09,"B",BEG)) Q:'BEG!(BEG>END)  D
 .S IEN=0 F  S IEN=$O(^PSRXR(52.09,"B",BEG,IEN)) Q:'IEN  D
 ..S TYPE=$$GET1^DIQ(52.09,IEN,.05,"I") I FLTR'[TYPE Q
 ..S TCOST=$G(TCOST)+$J($$GET1^DIQ(52.09,IEN,1.2,"I"),0,2)
 ..S LINE=LINE+1 D BLDLINE(IEN,.LINE)
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"Total Cost for items in this report: $"_$J(TCOST,0,2))
 Q
PAT(DFN,FLTR) ;
 N IEN,LINE,TCOST,TYPE
 S (LINE,TCOST)=0
 S IEN=0 F  S IEN=$O(^PSRXR(52.09,"C",DFN,IEN)) Q:'IEN  D
 .S TYPE=$$GET1^DIQ(52.09,IEN,.05,"I") I FLTR'[TYPE Q
 .S TCOST=$G(TCOST)+$J($$GET1^DIQ(52.09,IEN,1.2,"I"),0,2)
 .S LINE=LINE+1 D BLDLINE(IEN,.LINE)
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"Total Cost for items in this report: $"_$J(TCOST,0,2))
 Q
SITE(SITEIEN,FLTR) ;
 N IEN,LINE,TCOST,TYPE
 S (LINE,TCOST)=0
 S IEN=0 F  S IEN=$O(^PSRXR(52.09,"E",SITEIEN,IEN)) Q:'IEN  D
 .S TYPE=$$GET1^DIQ(52.09,IEN,.05,"I") I FLTR'[TYPE Q
 .S TCOST=$G(TCOST)+$J($$GET1^DIQ(52.09,IEN,1.2,"I"),0,2)
 .S LINE=LINE+1 D BLDLINE(IEN,.LINE)
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"Total Cost for items in this report: $"_$J(TCOST,0,2))
 Q
BLDLINE(IEN,LINE) ;
 N DATE,PAT,DRUG,SITE,TYPE,QTY,DSUPP,F,IENS,DATA,IENS,LINEVAR
 S IENS=IEN_","
 S F=52.09
 D GETS^DIQ(F,IENS,"**","IE","DATA")
 S LINEVAR=""
 S DATE=$P(DATA(F,IENS,.01,"E"),U)
 S PAT=$G(DATA(F,IENS,.02,"E"))
 S SITE=$G(DATA(F,IENS,.04,"E"))
 S TYPE=$G(DATA(F,IENS,.05,"I"))
 S QTY=$G(DATA(F,IENS,.07,"E"))
 S DSUPP=$G(DATA(F,IENS,.08,"E"))
 S DRUG=$G(DATA(F,IENS,1,"E"))
 S LINEVAR=$$SETFLD^VALM1($J(LINE,2),LINEVAR,"LINENO")
 S LINEVAR=$$SETFLD^VALM1(DATE,LINEVAR,"DATE")
 S LINEVAR=$$SETFLD^VALM1(PAT,LINEVAR,"PATIENT")
 ;S LINEVAR=$$SETFLD^VALM1(SITE,LINEVAR,"SITE")
 S LINEVAR=$$SETFLD^VALM1(DRUG,LINEVAR,"DRUG")
 S LINEVAR=$$SETFLD^VALM1(TYPE,LINEVAR,"TYPE")
 S LINEVAR=$$SETFLD^VALM1(QTY,LINEVAR,"QTY")
 S LINEVAR=$$SETFLD^VALM1(DSUPP,LINEVAR,"DSUPP")
 D SET^VALM10(LINE,LINEVAR,IEN)
 S VALMCNT=$G(VALMCNT)+1
 Q
SEL ;
 N DIR,ITEM,IEN,IENS,DATA,CNT,F,TYPE,ARY,SITELBL
 S ARY=$NA(^TMP("PSORRD",$J))
 K @ARY
 S CNT=1
 S F=52.09
 I $P(XQORNOD(0),"=",2) S Y=+$P(XQORNOD(0),"=",2)
 I '$P(XQORNOD(0),"=",2) D  Q:'Y
 .;S DIR(0)="N^"_VALMBG_":"_VALMLST_":0" D ^DIR Q:'Y
 . S DIR(0)="N^"_1_":"_VALMCNT_":0" D ^DIR Q:'Y
 S ITEM=Y,IEN=$O(@VALMAR@("IDX",ITEM,0))
 Q:'IEN
 S IENS=IEN_","
 D GETS^DIQ(F,IENS,"**","IE","DATA")
 S TYPE=$G(DATA(F,IENS,.05,"I"))
 ; set up data
 S @ARY@(CNT,0)="Request Date/Time:                    "_$G(DATA(F,IENS,.01,"E")),CNT=CNT+1
 S @ARY@(CNT,0)="Patient:                              "_$G(DATA(F,IENS,.02,"E")),CNT=CNT+1
 S @ARY@(CNT,0)="RX #:                                 "_$G(DATA(F,IENS,.03,"I")),CNT=CNT+1
 S SITELBL=$S(TYPE?1"O".E:"Rx Dispensed by Site:                 ",1:"Rx Hosted at Site:                    ")
 S @ARY@(CNT,0)=SITELBL_$G(DATA(F,IENS,.04,"E")),CNT=CNT+1
 S @ARY@(CNT,0)="Request Type:                         "_$G(DATA(F,IENS,.05,"E")),CNT=CNT+1
 S @ARY@(CNT,0)="Requesting Pharmacist:                "_$S((TYPE="PR")!(TYPE="RF"):$G(DATA(F,IENS,.06,"E")),(TYPE="OR")!(TYPE="OP"):$G(DATA(F,IENS,.061,"E"))),CNT=CNT+1
 S @ARY@(CNT,0)="Quantity:   "_$G(DATA(F,IENS,.07,"E"))_"   Days Supply: "_$G(DATA(F,IENS,.08,"E"))
 S @ARY@(CNT,0)="Dispensed Date:                       "_$G(DATA(F,IENS,.1,"E")),CNT=CNT+1
 S @ARY@(CNT,0)="Drug Name at Originating (Host) site: "_$G(DATA(F,IENS,1,"E")),CNT=CNT+1
 S @ARY@(CNT,0)="Local (matched) drug:                 "_$G(DATA(F,IENS,1.1,"E")),CNT=CNT+1
 S @ARY@(CNT,0)="Cost of Local Refill/Partial:         $"_$J($G(DATA(F,IENS,1.2,"E")),0,2)
 S PSORCNT=CNT
 D ^PSORRD
 K @ARY,PSORCNT
 S VALMBCK="R"
 Q
 ;
EXTHLP ;
 W !,"Selecting 1 will display the list of prescriptions that our local facility has"
 W !,"dispensed on behalf of other host Pharmacy locations as part of the OneVA"
 W !,"Pharmacy program. Selecting 2 will display the list of prescriptions other VA"
 W !,"Pharmacy locations have filled as a dispensing site for a prescription that"
 W !,"originated from our location. Selecting 3 will list all prescriptions that"
 W !,"either we have filled for other Pharmacy locations as the dispensing site or"
 W !,"other Pharmacy locations have filled on our behalf."
 Q
