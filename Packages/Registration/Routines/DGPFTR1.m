DGPFTR1 ;SHRPE/YMG - PRF TRANSFER REQUESTS ACTIONS ; 05/08/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; List Manager actions for DGPF PRF TRANSFER REQUESTS option.
 ;
 Q
 ;
CV ; change list view
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N DTMOK,EDTM,FLAG,PAT,QID,SDTM,STATUS,STR,TMPDTM,XQY0
 D FULL^VALM1,CLEAR^VALM1
 S STR=""
 ; query Id selection
 S QID=$$ASKALL("query Id","query Ids") I QID="" G CVX
 I QID'="ALL" S QID=$$SELQID() S STR=QID D BLDHDR^DGPFTR(STR),BLD^DGPFTR(STR) G CVX
 ; patient selection
 S PAT=$$ASKALL("patient","patients") I PAT="" G CVX
 I PAT'="ALL" D  I $D(DUOUT)!$D(DTOUT) G CVX
 .S DIR(0)="PA^2:AEMQ"
 .S DIR("S")="I $O(^DGPF(26.22,""D"",Y,""""))"
 .S DIR("A",1)=""
 .S DIR("A")="Select patient to view requests for: "
 .D ^DIR K DIR
 .S PAT=$P(Y,U) ; patient DFN
 .Q
 ; flag selection
 S FLAG=$$ASKALL("flag","flags") I FLAG="" G CVX
 I FLAG'="ALL" D  I $D(DUOUT)!$D(DTOUT) G CVX
 .S DIR(0)="PA^26.15:AEMQ"
 .S DIR("A",1)=""
 .S DIR("A")="Select record flag to view requests for: "
 .D ^DIR K DIR
 .S FLAG=$P(Y,U) ; flag ien in file 26.15
 .Q
 ; status selection
 S STATUS=$$ASKALL("status","statuses") I STATUS="" G CVX
 I STATUS'="ALL" D  I $D(DUOUT)!$D(DTOUT) G CVX
 .S DIR(0)="26.22,.05A"
 .S DIR("A",1)=""
 .S DIR("A")="Select status of the requests to view: "
 .D ^DIR K DA,DIR
 .S STATUS=+Y ; internal status code (26.22/.05)
 .Q
 ; date/time selection
 S SDTM=$$ASKALL("date/time","dates/times") I SDTM="" G CVX
 I SDTM'="ALL" D  I $D(DUOUT)!$D(DTOUT) G CVX
 .S TMPDTM=$O(^DGPF(26.22,"B",""))
 .S DIR(0)="DA^::TSX"
 .S DIR("A",1)=""
 .S DIR("A",2)="Note: starting date defaults to the earliest request on file."
 .S DIR("A",3)=""
 .S DIR("A")="Enter the starting date of the requests to view: "
 .S DIR("B")=$$FMTE^XLFDT(TMPDTM,1)
 .D ^DIR K DIR
 .S SDTM=+Y
 .I $D(DUOUT)!$D(DTOUT) Q
 .S TMPDTM=$O(^DGPF(26.22,"B",""),-1)
 .S DTMOK=0 F  D  Q:DTMOK!$D(DUOUT)!$D(DTOUT)
 ..S DIR(0)="DA^::TSX"
 ..S DIR("A",1)=""
 ..S DIR("A",2)="Note: ending date defaults to the latest request on file."
 ..S DIR("A",3)=""
 ..S DIR("A")="Enter the ending date of the requests to view: "
 ..S DIR("B")=$$FMTE^XLFDT(TMPDTM,1)
 ..D ^DIR K DIR I $D(DUOUT)!$D(DTOUT) Q
 ..I SDTM>+Y W !!!,"Starting date cannot be later than ending date!",! Q
 ..S DTMOK=1
 ..Q
 .S EDTM=+Y
 .Q
 S STR=QID_U_PAT_U_FLAG_U_STATUS_U_SDTM S:$G(EDTM) STR=STR_U_EDTM
 S VALMBG=1 D BLDHDR^DGPFTR(STR),BLD^DGPFTR(STR)
 S DSPSTR=STR ; save new display filters
 ;
CVX ; exit point
 S VALMBCK="R"
 Q
 ;
SELQID() ; user prompt for selection of query Id
 ;
 ; returns selected query Id or "" for user exit
 ;
 N D,DIC,DTOUT,DUOUT,X,Y
 S DIC="^DGPF(26.22,",DIC(0)="AEOQSX",D="C"
 S DIC("A")="Select query Id of the request to view: "
 D IX^DIC
 I $D(DUOUT)!$D(DTOUT) Q ""
 Q X
 ;
ASKALL(STR1,STR2) ; user prompt for All / Selected
 ; STR1 - item name to ask about (singular)
 ; STR2 - item name to ask about (plural)
 ;
 ; returns "ALL" for All, "S" for singular, or "" for user exit
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("B")="ALL"
 S DIR("A",1)=""
 S DIR("A")="View requests for all "_STR2_" or selected "_STR1_" (ALL/S): "
 S DIR(0)="SA^ALL:All "_STR2_";S:Selected "_STR1
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) Q ""
 Q Y
 ;
SD ; show request details
 N DGFDA,DGIEN,IENS,SEL
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")) I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 .S DGIEN=+$G(@VALMAR@("IDX",SEL,SEL)) I 'DGIEN W !!,"Invalid selection." Q
 .S IENS=DGIEN_"," D GETS^DIQ(26.22,IENS,"*","E","DGFDA")
 .W !!,"     Transfer request details:"
 .W !,"     -------------------------"
 .D DISPREQ(IENS,.DGFDA)
 .Q
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
RR ; review pending request
 N ACT,ASGIEN,DATAARY,DFN,DGERR,DGFDA,DGFERR,DGICN,DGIEN,DGPFA,IENS,SEL,STATUS
 D FULL^VALM1
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL=$O(VALMY("")) I SEL,$D(@VALMAR@("IDX",SEL,SEL)) D
 .S DGIEN=+$G(@VALMAR@("IDX",SEL,SEL)) I 'DGIEN W !!,"Invalid selection." Q
 .S IENS=DGIEN_"," D GETS^DIQ(26.22,IENS,"*","EI","DGFDA")
 .S STATUS=$G(DGFDA(26.22,IENS,.05,"I"))
 .; if request status is not "PENDING", bail out
 .I STATUS'=2 D  Q
 ..W !!,"Only transfer requests with 'PENDING' status are eligible for review."
 ..W !,"This request has ",$G(DGFDA(26.22,IENS,.05,"E"))," status!"
 ..Q
 .W !!,"     Review transfer request:"
 .W !,"     ------------------------"
 .D DISPREQ(IENS,.DGFDA)
 .S ACT=$$ASKREV() ; ask user for approval / rejection
 .I ACT'="" D
 ..S DATAARY("REVCMT")=$$ASKRSN(1,$S(ACT="R":1,1:0)) I ACT="R",DATAARY("REVCMT")="" Q
 ..S DGERR=""
 ..S DATAARY("REQDTM")=$G(DGFDA(26.22,IENS,.01,"I"))
 ..S DFN=$G(DGFDA(26.22,IENS,.03,"I"))
 ..I '$$MPIOK^DGPFUT(DFN,.DGICN) W !!,"Invalid patient ICN - must be national." Q
 ..S DATAARY("DFN")=DFN
 ..S DATAARY("ICN")=DGICN
 ..S DATAARY("FLAG")=$G(DGFDA(26.22,IENS,.04,"I"))
 ..S DATAARY("REVBY")=$$GET1^DIQ(200,DUZ_",",.01)
 ..S DATAARY("REVDTM")=$$NOW^XLFDT()
 ..S DATAARY("REQID")=$G(DGFDA(26.22,IENS,.08,"E"))
 ..S DATAARY("MSGID")=$G(DGFDA(26.22,IENS,.09,"E"))
 ..S DATAARY("QOK")=1
 ..S DATAARY("REVRES")=$S(ACT="R":"D",1:"A")
 ..; update log entry
 ..L +^DGPF(26.22,DGIEN):5 I '$T W !!,"Record locked by another user. Please try again later." Q
 ..D UPDLOG^DGPFHLT3(IENS,"",.DATAARY,.DGFERR)
 ..L -^DGPF(26.22,DGIEN)
 ..I $D(DGFERR) D  Q
 ...W !!,"Error while updating log entry with ien = ",DGIEN
 ...W !,"Error code: ",$G(DGFERR("DIERR",1))
 ...W !,"Error text: ",$G(DGFERR("DIERR",1,"TEXT",1))
 ...Q
 ..S DATAARY("REVDUZ")=DUZ
 ..S DATAARY("SENDTO")=$P($$PARENT^DGPFUT1($G(DGFDA(26.22,IENS,.1,"I"))),U)
 ..I DATAARY("SENDTO")=0 S DATAARY("SENDTO")=$G(DGFDA(26.22,IENS,.1,"I"))
 ..S ASGIEN=$$FNDASGN^DGPFAA(DFN,DATAARY("FLAG")_";DGPF(26.15,") ; PRF assignment ien in file 26.13
 ..I ASGIEN'>0 S DGERR="Receiver was unable to find corresponding PRF flag assignment."
 ..I DGERR="",'$$GETASGN^DGPFAA(ASGIEN,.DGPFA,1) S DGERR="Receiver was unable to retrieve corresponding PRF flag assignment."
 ..S DATAARY("ORIGOWN")=$P($G(DGPFA("OWNER")),U)
 ..S DATAARY("SFIEN")=$S(ACT="R":$P($G(DGPFA("OWNER")),U),1:$G(DGFDA(26.22,IENS,.1,"I")))
 ..S DATAARY("SFNAME")="Station # "_$$STA^XUAF4(DATAARY("SFIEN"))_"("_$$NAME^XUAF4(DATAARY("SFIEN"))_")"
 ..I ACT="A" D
 ...; approved request - change ownership
 ...I DGERR="" S DGERR=$$UPDASGN^DGPFHLT1(0,ASGIEN,.DATAARY,.DGPFA)
 ...Q
 ..; send response message (RSP^K11)
 ..D SEND^DGPFHLT2(DGERR,.DATAARY)
 ..D BLD^DGPFTR(DSPSTR) ; rebuild display list
 ..Q
 .Q
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
DISPREQ(IENS,DGFDA) ; display request data
 ; IENS - ien in file 26.22_","
 ; DGFDA - FDA array containing data for a given transfer request log entry
 ;
 N STR
 I '$D(DGFDA) Q
 W !
 S STR=$G(DGFDA(26.22,IENS,.01,"E"))
 W !,"Request date/time:   ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.02,"E"))
 W !,"Requester name:      ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,2.01,"E"))
 W !,"Request reason:      ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.03,"E"))
 W !,"Patient name:        ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.04,"E"))
 W !,"Record flag name:    ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.05,"E"))
 W !,"Request status:      ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.06,"E"))
 W !,"Reviewer name:       ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.07,"E"))
 W !,"Review date/time:    ",$S(STR'="":STR,1:"N/A")
  S STR=$G(DGFDA(26.22,IENS,2.02,"E"))
 W !,"Review reason:       ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.08,"E"))
 W !,"Query id:            ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.09,"E"))
 W !,"HL7 message id:      ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,.1,"E"))
 W !,"Requesting facility: ",$S(STR'="":STR,1:"N/A")
 S STR=$G(DGFDA(26.22,IENS,1,"E"))
 W !,"Error message:       ",$S(STR'="":STR,1:"N/A")
 Q
 ;
ASKREV() ; user prompt for request approval / rejection
 ;
 ; returns "A" for Approval, "R" for rejection, or "" for user exit
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A",1)=""
 S DIR("A",2)=""
 S DIR("A")="Do you wish to approve or reject this transfer request? (A/R): "
 S DIR(0)="SA^A:Approve request;R:Reject request"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) Q ""
 Q Y
 ;
ASKRSN(TYPE,RFLG) ; user prompt for request / response reason
 ;
 ; TYPE = 0 for request reason, 1 for response reason
 ; RFLG = 0 for optional entry, 1 for required entry
 ;
 ; returns entered reason or "" for user exit
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A",1)=""
 S DIR("A",2)=""
 S DIR("A")="Ownership Request"_$S(TYPE:" Approval/Rejection",1:"")_" Reason: "
 S DIR(0)="FA"_$S(RFLG:"",1:"O")_"^10:80"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) Q ""
 Q Y
