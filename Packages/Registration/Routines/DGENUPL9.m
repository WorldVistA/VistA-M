DGENUPL9 ;ISA/KWP,JAN,BRM,PJR,LBD,TDM - CD CONSISTENCY CHECKS ; 8/18/08 9:23am
 ;;5.3;REGISTRATION;**232,378,451,564,628,688**;Aug 13,1993;Build 29
 ;
CDCHECK() ;
 ;Description: Does the consistency checks on the CATASTROPHIC DISABILITY objects.
 ;Input:
 ;  MSGS -Error messages
 ;  DGPAT -Patient array
 ;  MSGID -HL7 Message ID
 ;  OLDCDIS -CD array with data from file
 ;  DGCDIS -CD Array
 ;  ERRCOUNT -number of errors
 ;Output:
 ;  1 if consistency checks passed, 0 otherwise
 ;
 ; VistA Changes (DG*5.3*451) added CCs listed below in place of the
 ; previous Consistency Checks based on new business rules.
 ;
 N CDERR
 ; Reject CD update if required fields are missing
 I DGCDIS("VCD")="Y",'$$CHECK^DGENCDA1(.DGCDIS,.CDERR) D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),"CD Error: "_CDERR,.ERRCOUNT) Q 0
 ;
 ; If CD is Yes on VISTA and update is Yes and the current Date of
 ; Decision is more recent than the incoming one, reject update.
 I OLDCDIS("VCD")="Y",DGCDIS("VCD")="Y",DGCDIS("DATE")<OLDCDIS("DATE") D ADDERROR^DGENUPL(MSGID,DGPAT("SSN"),"CD Error: Date of Decision is more recent at site",.ERRCOUNT) Q 0
 ;
 ; CD evaluation of 'NO' shall not overwrite a CD evaluation of
 ; 'YES' unless it is from the originating site.
 I OLDCDIS("VCD")="Y",DGCDIS("VCD")="N",OLDCDIS("FACDET")'=DGCDIS("FACDET") Q 0  ;no error message when this occurs per bus. rules
 ;
 Q 1
AO ;Agent Orange Exp. Location - overflow code from MERGE^DGENUPL4
 I DGELG("AO")'="" D
 . I DGELG("AO")="Y",$G(DGELG("AOEXPLOC"))'="" Q   ;Added DG*5.3*688
 . I DGELG("AO")="Y",OLDELG("AOEXPLOC")="" D
 . . S DGELG3("AOEXPLOC")="V" D BULLETIN
 . I DGELG("AO")="N",OLDELG("AOEXPLOC")'="" D
 . . S DGELG3("AOEXPLOC")="@" D BULLETIN
 Q
BULLETIN ;Agent Orange Exposure Location Change
 ;  >> this function has been removed based on a customer request
 ;  >> the code is being left for reactivation if desired w/ ESR
 Q
 N DGBULL,DGLINE,DGMGRP,DGNAME,DIFROM,VA,VAERR,XMTEXT,XMSUB,XMDUZ
 S DGMGRP=$O(^XMB(3.8,"B","DGEN ELIGIBILITY ALERT",""))
 Q:'DGMGRP
 D XMY^DGMTUTL(DGMGRP,0,1)
 S DGNAME=$P($G(^DPT(DFN,0)),"^"),DGSSN=$P($G(^DPT(DFN,0)),"^",9)
 S XMTEXT="DGBULL("
 S XMSUB="AGENT ORANGE EXPOSURE LOCATION CHANGE"
 S DGLINE=0
 D LINE^DGEN("Patient: "_DGNAME,.DGLINE)
 D LINE^DGEN("SSN: "_DGSSN,.DGLINE)
 D LINE^DGEN("",.DGLINE)
 D LINE^DGEN("This veteran's Agent Orange Exposure Location has been changed.",.DGLINE)
 D LINE^DGEN("Contact the HEC by phone if you have questions or believe",.DGLINE)
 D LINE^DGEN("this information to be incorrect.",.DGLINE)
 D ^XMD
 Q
