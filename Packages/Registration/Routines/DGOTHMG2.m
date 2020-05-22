DGOTHMG2 ;SHRPE/YMG - OTH Management actions (cont.) ;04/30/19
 ;;5.3;Registration;**952**;Aug 13, 1993;Build 160
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
AP ; add 90 day period
 ;
 ; DSPMODE, DGIEN33 and DGDFN are defined in ^DGOTHMGT
 ;
 N CRDTM,DAYS,DGFAC,DGFRES,DGIEN365,DGIEN90,DGUSR,DTDIFF,DTSTR90,DTSTR365,EDT365,EDT90,MAXDT,MINDT,NUM365,NUM90,PNDREQ,OTHDATA,PNDSTR
 N REQTYPE,SDT90,STARTDT,STOP,SUBDT,Z
 D FULL^VALM1,CLEAR^VALM1
 S VALMBCK="R"
 ; check security key
 I '$$CHKKEY^DGOTHMG1("DG OTH ADD PERIOD") D  Q
 .W !!,"You need DG OTH ADD PERIOD security key in order to use this action!"
 .D ASKCONT
 .Q
 D HEADER(DGDFN) ; display header
 S Z=$$LASTPRD^DGOTHUT1(DGIEN33),NUM365=$P(Z,U),DGIEN365=$P(Z,U,2),NUM90=$P(Z,U,3),DGIEN90=$P(Z,U,4) ; get data for the last 90 day period
 W !!,"365 Day Period: ",$S(NUM365>0:NUM365,1:"None")
 W !," 90 Day Period: ",$S(NUM90>0:NUM90,1:"None")
 S DTSTR90=$$GET90DT^DGOTHUT1(DGIEN33,$P(Z,U,2),$P(Z,U,4)) ; get dates for the last 90 day period
 S SDT90=$P(DTSTR90,U),EDT90=$P(DTSTR90,U,2),DAYS=$P(DTSTR90,U,3)
 I SDT90>0 D
 .W !!,"The most recent 90 day period start",$S(SDT90<DT:"ed on "_$$FMTE^XLFDT(SDT90),SDT90>DT:"s on "_$$FMTE^XLFDT(SDT90),1:"s today")
 .W " and end",$S(EDT90<DT:"ed on "_$$FMTE^XLFDT(EDT90),EDT90>DT:"s on "_$$FMTE^XLFDT(EDT90),1:"s today")
 .S DTSTR365=$$GET365DT^DGOTHUT1(DGIEN33,DGIEN365),EDT365=$P(DTSTR365,U,2)
 .W !,"The most recent 365 day period end",$S(EDT365<DT:"ed on "_$$FMTE^XLFDT(EDT365),EDT365>DT:"s on "_$$FMTE^XLFDT(EDT365),1:"s today")
 .Q
 W !!,"Days Remaining: ",$S(SDT90>0:DAYS,1:"N/A")
 ; don't allow new 90 day period if there's already one that starts in the future
 I SDT90>DT D  Q
 .W !!,"Latest 90 day period starts in the future (on ",$$FMTE^XLFDT(SDT90),")"
 .W !,"Authorizing another 90 day period is not allowed!"
 .D ASKCONT
 .Q
 ; display message if current 90 day period is greater than 2 (last 90 day period is greater than 1)
 I NUM90>1 W !!,"Patient has been authorized for 180 days or more of care",!
 ; get current user and facility
 S DGUSR=$$UP^XLFSTR($$NAME^XUSER(DUZ,"F")),DGFAC=$P($$SITE^VASITE(),U)
 ; check for existing pending request
 S PNDSTR=$$GETPEND^DGOTHUT1(DGDFN),PNDREQ=$P(PNDSTR,U)
 I PNDREQ=-1 D DISPERR($P(PNDSTR,U,2)) Q
 I PNDREQ D
 .W !!,"Existing pending request:"
 .W !,"    Request submitted on ",$$FMTE^XLFDT($P(PNDSTR,U,2)),"; response not yet received.",!
 .Q
 ; get record creation date / time
 S CRDTM=$S(PNDREQ:$P(PNDSTR,U,6),1:$$NOW^XLFDT())
 ; prompt for authorization approval
 S REQTYPE=$$ASKAUAP() I REQTYPE="" Q
 ; if approved request
 I REQTYPE="Y" D  Q
 .; calculate date range for the start date
 .; earliest date allowed is the end date of the last 90 day period + 1 or today's date
 .; with DG OTH MGR key earliest date can be up to 15 days in the past
 .; latest date allowed is the earliest date + 15 days if earliest date is in the future, or today's date + 15 days if earliest date is in the past
 .S DTDIFF=$$FMDIFF^XLFDT(DT,EDT90,1)
 .S MINDT=$S(DTDIFF'>0:$$FMADD^XLFDT(EDT90,1),1:DT)
 .S MAXDT=$$FMADD^XLFDT(MINDT,15)
 .; allow past date with DG OTH MGR key
 .I DTDIFF>0,$$CHKKEY^DGOTHMG1("DG OTH MGR") S MINDT=$S(DTDIFF>15:$$FMADD^XLFDT(DT,-15),1:$$FMADD^XLFDT(EDT90,1))
 .; prompt for period start date
 .S STARTDT=$$ASKSTDT(MINDT,MAXDT) I STARTDT'>0 Q
 .S $P(OTHDATA,U,6)=STARTDT
 .; put current user and facility into OTHDATA
 .S $P(OTHDATA,U,7)=DGUSR
 .S $P(OTHDATA,U,8)=DGFAC
 .; find out which 365 day period we're going to use
 .S $P(OTHDATA,U)=$S($$FMDIFF^XLFDT(STARTDT,$P(DTSTR365,U,2))>0:NUM365+1,1:NUM365)
 .; find out which 90 day period we're going to use
 .S $P(OTHDATA,U,2)=$S($P(OTHDATA,U)=NUM365:NUM90+1,1:1)
 .; put record creation timestamp into OTHDATA
 .S $P(OTHDATA,U,9)=CRDTM
 .I $P(OTHDATA,U,2)>1 S STOP=0 D  I STOP Q
 ..; not the 1st 90 day period, display auth. prompts
 ..; prompt for Date request submitted
 ..S SUBDT=$$ASKREQDT(DT,$S($P(PNDSTR,U):$P(PNDSTR,U,2),1:"")) I SUBDT'>0 S STOP=1 Q
 ..S $P(OTHDATA,U,3)=SUBDT
 ..; prompt for authorized by
 ..S Z=$$ASKAUBY() I Z="" S STOP=1 Q
 ..S $P(OTHDATA,U,4)=Z
 ..; prompt for authorization received date
 ..S Z=$$ASKAURDT(DT) I Z'>0 S STOP=1 Q
 ..S $P(OTHDATA,U,5)=Z
 ..Q
 .; file data
 .S DGFRES=$$FILAUTH^DGOTHUT1(DGDFN,OTHDATA)
 .I '+DGFRES D DISPERR($P(DGFRES,U,2))
 .I +DGFRES D
 ..W !!,"The patient has been authorized for an additional 90 day period"
 ..W !,"with the starting date of ",$$FMTE^XLFDT($P(OTHDATA,U,6))
 ..D ASKCONT
 ..S DSPMODE=0 ; switch view to approved requests
 ..; clear existing pending request, if it exists
 ..I PNDREQ D CLRPND(DGDFN)
 ..K VALMDDF M VALMDDF=DGSVDDF("A") D CHGCAP^VALM("LINE","Line") ; use CHGCAP^VALM to reload VALMDDF array
 ..D BLD^DGOTHMGT(DSPMODE) ; rebuild list
 ..D BLDHDR^DGOTHMGT(DSPMODE) ; rebuild header
 ..; Callpoint to queue an entry in File #301.5 that will trigger
 ..; Enrollment Full Data Transmission (ORF/ORU~ZO7) HL7 message.
 ..D EVENT^IVMPLOG(DGDFN)
 ..Q
 .Q
 ; prompt for Date request submitted (applies to both pending and denied requests)
 S SUBDT=$$ASKREQDT(DT,$S($P(PNDSTR,U):$P(PNDSTR,U,2),1:"")) I SUBDT'>0 Q
 ; if pending request
 I REQTYPE="P" D  Q
 .S $P(OTHDATA,U)=1
 .S $P(OTHDATA,U,2)=SUBDT
 .S $P(OTHDATA,U,3)=DGUSR
 .S $P(OTHDATA,U,4)=DGFAC
 .S $P(OTHDATA,U,5)=CRDTM
 .; file data
 .S DGFRES=$$FILPEND^DGOTHUT1(DGDFN,OTHDATA)
 .I '+DGFRES D DISPERR($P(DGFRES,U,2))
 .I +DGFRES D
 ..W !!,$$CJ^XLFSTR("Pending authorization request filed successfully.",80) D ASKCONT
 ..D BLDHDR^DGOTHMGT(DSPMODE) ; rebuild header
 ..; Callpoint to queue an entry in File #301.5 that will trigger
 ..; Enrollment Full Data Transmission (ORF/ORU~ZO7) HL7 message.
 ..D EVENT^IVMPLOG(DGDFN)
 ..Q
 .Q
 ; denied request (REQTYPE="N") if we got here
 S Z=$$ASKAUCMT() I Z="" Q
 S $P(OTHDATA,U,1)=SUBDT
 S $P(OTHDATA,U,2)=Z
 S $P(OTHDATA,U,3)=DGUSR
 S $P(OTHDATA,U,4)=DGFAC
 S $P(OTHDATA,U,5)=CRDTM
 S DGFRES=$$FILDEN^DGOTHUT1(DGDFN,OTHDATA)
 I '+DGFRES D DISPERR($P(DGFRES,U,2))
 I +DGFRES D
 .W !!,$$CJ^XLFSTR("Denied authorization request filed successfully.",80) D ASKCONT
 .S DSPMODE=1 ; switch view to denied requests
 .; clear existing pending request, if it exists
 .I PNDREQ D CLRPND(DGDFN)
 .K VALMDDF M VALMDDF=DGSVDDF("D") D CHGCAP^VALM("LINE","Line") ; use CHGCAP^VALM to reload VALMDDF array
 .D BLD^DGOTHMGT(DSPMODE) ; rebuild list
 .D BLDHDR^DGOTHMGT(DSPMODE) ; rebuild header
 .; Callpoint to queue an entry in File #301.5 that will trigger
 .; Enrollment Full Data Transmission (ORF/ORU~ZO7) HL7 message.
 .D EVENT^IVMPLOG(DGDFN)
 .Q
 Q
 ;
CLRPND(DGDFN) ; clear existing pending request
 ;
 ; DGDFN - patient's DFN
 ;
 N DGRES
 S DGFRES=$$FILPEND^DGOTHUT1(DGDFN,"0^^^^^^")
 I '+DGFRES D DISPERR($P(DGFRES,U,2)) Q
 W !!,"Existing pending request has been removed.",!
 Q
 ;
ASKCONT ; display "press <Enter> to continue" prompt
 N Z
 W !!,$$CJ^XLFSTR("Press <Enter> to continue.",80)
 R !,Z:DTIME
 Q
 ;
HEADER(DFN) ;
 N DDASH,DGNAME,DGDOB,VADM
 D DEM^VADPT ;get patient demographics
 S DGNAME=VADM(1),DGDOB=$P(VADM(3),U,2)
 W ?24,"START ADDITIONAL 90-DAY PERIOD"
 W !,"Patient Name: ",DGNAME,?60,"DOB: ",DGDOB
 S $P(DDASH,"=",81)="" W !,DDASH,! ;write dash lines
 Q
 ;
DISPERR(DGERR) ; display error message
 ;
 ; DGERR - message to display
 ;
 W !!,"Error while filing OTH data:",!,DGERR
 D ASKCONT
 Q
 ;
ASKREQDT(MAXDT,DEFDT) ; prompt for date request submitted
 ;
 ; MAXDT = latest allowed date (required)
 ; DEFDT = default date
 ;
 ; returns date in internal FM format or 0 on user exit
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="D^:"_MAXDT_":EX"
 S DIR("A")="Date request submitted"
 I +$G(DEFDT)>0 S DIR("B")=$$FMTE^XLFDT(DEFDT)
 S DIR("?",1)="Enter the date authorization request was submitted."
 S DIR("?",2)="No future date allowed."
 S DIR("?")="Latest allowed date is "_$$FMTE^XLFDT(MAXDT)
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 0
 Q +Y
 ;
ASKAUAP() ; prompt for authorization approved
 ;
 ; returns "Y" for approved, "N" for not approved, "P" for pending, or "" on user exit
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^Y:Yes;N:No;P:Pending"
 S DIR("A")="Authorization approved (Y/N/P): "
 S DIR("?",1)="Select 'Y' if request has been approved."
 S DIR("?",2)="  Also select 'Y' if 1st 90 day period of additional 365 day period"
 S DIR("?",3)="  (approval not required)."
 S DIR("?",4)="Select 'N' if request has been denied."
 S DIR("?")="Select 'P' if request is still pending."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q Y
 ;
ASKAUCMT() ; prompt for authorization comment
 ;
 ; returns entered comment or "" on user exit
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="FA^1:60"
 S DIR("A")="Authorization comment: "
 S DIR("?")="Free text comment, 1 to 60 characters in length."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q Y
 ;
ASKAUBY() ; prompt for authorized by
 ;
 ; returns name of the user selected or "" on user exit
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="FA^1:60"
 S DIR("A")="Authorized by: "
 S DIR("?")="Free text name, 1 to 60 characters in length."
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q ""
 Q Y
 ;
ASKAURDT(MAXDT) ; prompt for authorization received date
 ;
 ; MAXDT = latest allowed date (required)
 ;
 ; returns date in internal FM format or 0 on user exit
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="D^:"_MAXDT_":EX"
 S DIR("A")="Authorization received date"
 S DIR("?",1)="Enter the date authorization was received."
 S DIR("?",2)="No future date allowed."
 S DIR("?")="Latest allowed date is "_$$FMTE^XLFDT(MAXDT)
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 0
 Q +Y
 ;
ASKSTDT(MINDT,MAXDT) ; prompt for period start date
 ;
 ; MINDT = earliest allowed date (required)
 ; MAXDT = latest allowed date (required)
 ;
 ; returns date in internal FM format or 0 on user exit
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 N MAXDTE,MINDTE
 ; get min and max dates in external format
 S MINDTE=$$FMTE^XLFDT(MINDT),MAXDTE=$$FMTE^XLFDT(MAXDT)
 S DIR(0)="DA^"_MINDT_":"_MAXDT_":EX"
 ;S DIR("A")="Additional period start date ("_MINDTE_" - "_MAXDTE_"): "
 S DIR("A")="Additional period start date: "
 S DIR("?",1)="Enter the start date of this 90 day period."
 S DIR("?",2)="Entering past dates requires DG OTH MGR security key."
 S DIR("?",3)="Earliest allowed date is "_MINDTE_"."
 S DIR("?")="Latest allowed date is "_MAXDTE
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 0
 Q +Y
 ;
