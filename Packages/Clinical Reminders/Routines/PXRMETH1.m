PXRMETH1 ; SLC/PJH - Reminder Extract History ;09/07/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
BLDLIST(EDIEN) ;Build workfile
 ;EDIEN is the extract definition IEN.
 N IND,FMTSTR,PLIST
 K ^TMP("PXRMETH",$J)
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLL")
 ;Build list of extract summaries in period order
 I PXRMVIEW="P" D LIST1(EDIEN,"PXRMETH",FMTSTR)
 ;Build list of extract summaries in date order
 I PXRMVIEW="D" D LIST2(EDIEN,"PXRMETH",FMTSTR)
 Q
 ;
FMT(NUMBER,NAME,EDATE,XDATE,AUTO,FMTSTR,NL,OUTPUT) ;Format
 N TAUTO,TDATE,TEMP,TNAME,TSOURCE
 S TEMP=NUMBER_U_NAME_U
 S TDATE=$$FMTE^XLFDT(EDATE,"5Z")
 S TEMP=TEMP_$$LJ^XLFSTR(TDATE,20," ")
 S TDATE=XDATE I TDATE S TDATE=$$FMTE^XLFDT(TDATE,"5Z")
 S TEMP=TEMP_" "_$$LJ^XLFSTR(TDATE,22," ")
 S TAUTO=AUTO
 S TEMP=TEMP_TAUTO
 D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NL,.OUTPUT)
 Q
 ;
HELP(CALL) ;General help text routine.
 N HTEXT
 I CALL=1 D
 .S HTEXT(1)="Select DE to delete an extract.\\"
 .S HTEXT(2)="Select ES to view the details of an extract or run a compliance"
 .S HTEXT(3)="report for the extract.\\Select MT to transmit extract details to the AAC.\\"
 .S HTEXT(4)="Select TH to view the transmission history for an extract."
 ;
 I CALL=3 D
 .S HTEXT(1)="Select Y to send the results of the Extract to the National Austin database."
 ;
 I CALL=4 D
 .S HTEXT(4)="Select Y to overwrite the previous Extract stored in the National Austin Database."
 D HELP^PXRMEUT(.HTEXT)
 Q
 ;
LIST1(EDIEN,NODE,FMTSTR) ;Build a list of extract summaries for a parameter.
 N AUTO,EDATE,HL7ID,HL7SUB,IND,JND,NAME,NL,NUM,OUTPUT
 N PERIOD,STR,XDATE,YEAR
 ;Build list of extract summaries in reverse date order.
 S YEAR="9999",(NUM,VALMCNT)=0
 F  S YEAR=$O(^PXRMXT(810.3,"D",EDIEN,YEAR),-1) Q:YEAR=""  D
 .S PERIOD="99"
 .F  S PERIOD=$O(^PXRMXT(810.3,"D",EDIEN,YEAR,PERIOD),-1) Q:PERIOD=""  D
 ..S IND=""
 ..F  S IND=$O(^PXRMXT(810.3,"D",EDIEN,YEAR,PERIOD,IND),-1) Q:IND=""  D
 ...S NAME=$P($G(^PXRMXT(810.3,IND,0)),U)
 ...S EDATE=$P($G(^PXRMXT(810.3,IND,0)),U,6)
 ...S AUTO=$P($G(^PXRMXT(810.3,IND,4)),U,5)
 ...S AUTO=$S(AUTO="A":"Y",1:"N")
 ...S HL7ID=$O(^PXRMXT(810.3,IND,5,"B",""),-1),XDATE="",HL7SUB=""
 ...I HL7ID S HL7SUB=$O(^PXRMXT(810.3,IND,5,"B",HL7ID,""))
 ...I HL7SUB S XDATE=$P($G(^PXRMXT(810.3,IND,5,HL7SUB,0)),U,2)
 ...I 'XDATE S XDATE="Not Transmitted"
 ...S NUM=NUM+1
 ...D FMT(NUM,NAME,EDATE,XDATE,AUTO,FMTSTR,.NL,.OUTPUT)
 ...F JND=1:1:NL D
 ....S VALMCNT=VALMCNT+1,^TMP(NODE,$J,VALMCNT,0)=OUTPUT(JND)
 ....S ^TMP(NODE,$J,"IDX",VALMCNT,NUM)=""
 ....S ^TMP(NODE,$J,"SEL",NUM)=IND
 Q
 ;
LIST2(EDIEN,NODE,FMTSTR) ;Build a list of extract summaries for a parameter.
 N AUTO,EDATE,HL7ID,HL7SUB,IND,JND,NAME,NL,NUM,OUTPUT
 N PERIOD,STR,XDATE,YEAR
 ;Build list of extract summaries in reverse date order.
 S EDATE="",(NUM,VALMCNT)=0
 F  S EDATE=$O(^PXRMXT(810.3,"C",EDIEN,EDATE),-1) Q:'EDATE  D
 .S IND=""
 .F  S IND=$O(^PXRMXT(810.3,"C",EDIEN,EDATE,IND)) Q:'IND  D
 ..S NAME=$P($G(^PXRMXT(810.3,IND,0)),U,1)
 ..S AUTO=$P($G(^PXRMXT(810.3,IND,4)),U,5)
 ..S AUTO=$S(AUTO="A":"Y",1:"N")
 ..S HL7ID=$O(^PXRMXT(810.3,IND,5,"B",""),-1),XDATE="",HL7SUB=""
 ..I HL7ID S HL7SUB=$O(^PXRMXT(810.3,IND,5,"B",HL7ID,""))
 ..I HL7SUB S XDATE=$P($G(^PXRMXT(810.3,IND,5,HL7SUB,0)),U,2)
 ..I 'XDATE S XDATE="Not Transmitted"
 ..S NUM=NUM+1
 ..D FMT(NUM,NAME,EDATE,XDATE,AUTO,FMTSTR,.NL,.OUTPUT)
 ..F JND=1:1:NL D
 ...S VALMCNT=VALMCNT+1,^TMP(NODE,$J,VALMCNT,0)=OUTPUT(JND)
 ...S ^TMP(NODE,$J,"IDX",VALMCNT,NUM)=""
 ...S ^TMP(NODE,$J,"SEL",NUM)=IND
 Q
 ;
