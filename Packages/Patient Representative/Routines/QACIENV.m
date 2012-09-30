QACIENV ; OAKOIFO/TKW - ENVIRONMENT CHECK ROUTINE FOR PATCH QAC*2.0*19 (PATS) ;3/31/06  13:34
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
EN ; PATS Environment Check Routine
 ; Check to see if DGRR Broker Type options exist
 N DGOPTPL,DGOPTPC
 S DGOPTPL=$$FIND1^DIC(19,,"QX","DGRR GUI PATIENT LOOKUP","B")
 S DGOPTPC=$$FIND1^DIC(19,,"QX","DGRR PATIENT SERVICE QUERY","B")
 I 'DGOPTPL D  S XPDABORT=1
 . W !!,"The Patient Service Lookup Broker Type Option DGRR GUI PATIENT LOOKUP"
 . W !,"is not found on your VistA system. Patient Service Lookup"
 . W !,"must be installed prior to installing PATS!"
 . Q
 I 'DGOPTPC D  S XPDABORT=1
 . W !!,"The Patient Service Construct Broker Type Option DGRR PATIENT SERVICE QUERY"
 . W !,"is not found on your VistA system. Patient Service Construct"
 . W !,"must be installed prior to installing PATS!"
 . Q
 Q
 ;
 ;
