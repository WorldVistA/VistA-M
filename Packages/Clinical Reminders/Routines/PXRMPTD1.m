PXRMPTD1 ;SLC/PKR/PJH/AGP - Reminder Inquiry print template routines. ;02/08/2012
 ;;2.0;CLINICAL REMINDERS;**4,12,22**;Feb 04, 2005;Build 160
 ;
 ;=======================================
AFREQ ; Print baseline FREQUENCY/AGE RANGE.
 N PXAMAX,PXAMIN,PXF,PXF0,PXW
 S PXF0=$G(^PXD(811.9,D0,7,D1,0))
 S PXF=$P(PXF0,U,1)
 S PXAMIN=$P(PXF0,U,2)
 S PXAMAX=$P(PXF0,U,3)
 I PXF="" S PXW="MISSING FREQUENCY"
 S PXW=$$FREQ^PXRMPTD2(PXF)
 S PXW=PXW_$$FMTAGE^PXRMAGE(PXAMIN,PXAMAX)
 W "  ",PXW
 Q
 ;
 ;=======================================
DUEWI ;Print DO WITHIN time frame
 N PXF,PXW
 S PXF=$P($G(^PXD(811.9,D0,0)),U,4)
 I (PXF="")!(+PXF=0) W "  Wait until actually DUE" Q
 S PXW=$$FREQ^PXRMPTD2(PXF)
 W "  Do if DUE within "_PXW
 Q
 ;
 ;=======================================
EDIT ;Print latest entry in edit history
 N CNT,DIWF,DIWL,DIWR,EDATA,EIEN,ETIME,FIRST,IC,MAX,UIEN,USER,X
 K ^UTILITY($J,"W")
 ;Get edit history count
 S MAX=$G(^PXRM(800,1,"EDIT HISTORY COUNT")) I MAX="" S MAX=2
 ;Last N lines
 S CNT=0,EIEN="A",FIRST=1
 F  S EIEN=$O(^PXD(811.9,D0,110,EIEN),-1) Q:'EIEN  Q:CNT=MAX  D
 .;Edit date and edit by fields
 .S EDATA=$G(^PXD(811.9,D0,110,EIEN,0)) Q:EDATA=""
 .S ETIME=$P(EDATA,U),UIEN=$P(EDATA,U,2) Q:'UIEN
 .S USER=$$GET1^DIQ(200,UIEN,.01),CNT=CNT+1
 .;Comments
 .S DIWF="C50",DIWL=20,DIWR=78
 .S IC=0
 .F  S IC=$O(^PXD(811.9,D0,110,EIEN,1,IC)) Q:'IC  D
 ..S X=$G(^PXD(811.9,D0,110,EIEN,1,IC,0))
 ..D ^DIWP
 .;Output
 .;Header
 .I FIRST S FIRST=0 W "Edit History:",!!
 .W ?4,"Edit date:",?16,$$FMTE^XLFDT(ETIME,"1")
 .W ?40,"Edit by:",?52,USER
 .W !,?4,"Edit Comments:"
 .S IC=0
 .F  S IC=$O(^UTILITY($J,"W",DIWL,IC)) Q:IC=""  D
 ..W ?20,^UTILITY($J,"W",DIWL,IC,0),!
 .K ^UTILITY($J,"W")
 .W !!
 Q
 ;
 ;=======================================
USAGE ;Format usage string
 W ?7,$$XFORM($P($G(^PXD(811.9,D0,100)),U,4))
 Q
 ;
 ;=======================================
XFORM(Y) ;Print transform for field 103 in file #811.9
 ;If ALL
 N ARRAY,IC,LIT,OUTPUT,X
 I Y["*" D
 . S ARRAY("CPRS")=""
 . S ARRAY("DATA EXTRACT")=""
 . S ARRAY("REPORTS")=""
 ;Look for others.
 F IC=1:1:$L(Y) D
 . S X=$E(Y,IC)
 . I X="*" Q
 . S LIT=$S(X="C":"CPRS",X="X":"DATA EXTRACT",X="R":"REPORTS",X="P":"PATIENT",X="L":"REMINDER PATIENT LIST",X="O":"REMINDER ORDER CHECKS",1:"")
 . I LIT'="" S ARRAY(LIT)=""
 ;
 S LIT="",OUTPUT=""
 F  S LIT=$O(ARRAY(LIT)) Q:LIT=""  D
 . S OUTPUT=OUTPUT_", "_LIT
 Q $E(OUTPUT,3,$L(OUTPUT))
 ;
