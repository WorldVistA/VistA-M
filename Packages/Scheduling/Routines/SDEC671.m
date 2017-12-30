SDEC671 ;OAK/MKO-POST INSTALL FOR SD*5.3*671 ;12:33 PM  23 Jun 2017
 ;;5.3;Scheduling;**671**;Aug 13, 1993;Build 25
 Q
 ;
POST ;Entry point for Post InstalL
 D ADDPROT
 D TRANSFER
 D POST2
 Q
 ;
ADDPROT ;Link OR and SD protocols
 N RET
 D BMES^XPDUTL("Adding Protocol 'OR RECEIVE' to the protocol 'SD EVSEND OR'.")
 S RET=$$ADD^XPDPROT("SD EVSEND OR","OR RECEIVE","",1)
 D:'RET MES^XPDUTL("ERROR: "_$P(RET,"^",2)_" **")
 ;
 D BMES^XPDUTL("Adding Protocol 'OCX ORDER CHECK HL7 RECIEVE' to the protocol 'SD EVSEND OR'.")
 S RET=$$ADD^XPDPROT("SD EVSEND OR","OCX ORDER CHECK HL7 RECIEVE","",1)
 D:'RET MES^XPDUTL("ERROR: "_$P(RET,"^",2)_" **")
 ;
 I $$PATCH^XPDUTL("OR*3.0*434") D
 .D BMES^XPDUTL("Adding Protocol 'SD RECEIVE OR' to the protocol 'OR EVSEND SD'.")
 .S RET=$$ADD^XPDPROT("OR EVSEND SD","SD RECEIVE OR","",1)
 .D:'RET MES^XPDUTL("ERROR: "_$P(RET,"^",2)_" **")
 Q
 ;
TRANSFER ;Copy data from File #409.85 to #409.86
 N PATCH,STUS
 S PATCH=$O(^XPD(9.7,"B","SD*5.3*671",""),-1) I PATCH>0 D
 .S STUS=$$GET1^DIQ(9,7,PATCH,.02,"I")
 .I STUS=3 D BMES^XPDUTL("POST-INIT routine has already run!")
 Q:$G(STUS)=3
 I $G(^XTMP("SDEC671")) D
 .D BMES^XPDUTL("POST-INIT routine already started, PLEASE refer to patch instructions to restart!")
 Q:$G(^XTMP("SDEC671"))
 N CA85,CDT85,CLM85,CN85,CR85,CU85,DFN85
 S ^XTMP("SDEC671")=""
 ;
 ;Loop through entries in file #409.85
 S DFN85=0 F  S DFN85=$O(^SDEC(409.85,"B",DFN85)) Q:DFN85'>0  D
 .S IEN85="" F  S IEN85=$O(^SDEC(409.85,"B",DFN85,IEN85)) Q:IEN85=""  D
 ..N FDA,SEQ,MSG,DIERR,DIMSG,R85
 ..S R85=$G(^SDEC(409.85,IEN85,0)) Q:R85=""
 ..Q:$P($G(R85),"^",17)'="O"  ;Current status (#23)
 ..Q:DFN85'=$P(R85,"^")
 ..Q:$O(^SDEC(409.85,IEN85,4,0))'>0  ;Patient contact multiple (#44)
 ..;
 ..;Set FDA for top level fields of File #409.86
 ..S FDA(409.86,"+1,",.01)=DFN85 ;Patient
 ..S FDA(409.86,"+1,",1)=$P(R85,"^",9) ;Req specific clinic (#8,P44) -> Clinic
 ..S FDA(409.86,"+1,",2)=$P(R85,"^",16) ;CID/Preferred Date of Appt (#22) -> Preferred date
 ..S FDA(409.86,"+1,",2.1)=$P(R85,"^",5) ;Request type (#4) -> Request type
 ..S FDA(409.86,"+1,",2.2)=1 ;Sequence
 ..S FDA(409.86,"+1,",1.1)=$P(R85,"^",4) ;Req service/specialty (#8.5,P40.7) -> Service
 ..;
 ..;Loop through PATIENT CONTACT multiple (#44) of File #409.85 and set FDA array
 ..;for the DATE/TIME of CONTACT multiple (#3) of File #409.86
 ..S SEQ=1
 ..S CN85="" F  S CN85=$O(^SDEC(409.85,IEN85,4,CN85)) Q:CN85'>0  D
 ...S CR85=$G(^SDEC(409.85,IEN85,4,CN85,0)) Q:CR85=""
 ...S CDT85=$P(CR85,"^") Q:CDT85=""  ;Date entered (#.01)
 ...S CU85=$P(CR85,"^",2) Q:CU85=""  ;Entered by user (#2,P200)
 ...S CA85=$P(CR85,"^",3) Q:CA85=""  ;Action (#3)
 ...S CLM85="" I CA85="M" S CA85="C",CLM85=1
 ...;
 ...S SEQ=SEQ+1
 ...S IENS="+"_SEQ_",+1,"
 ...S FDA(409.863,IENS,.01)=$P(CR85,"^")
 ...S FDA(409.863,IENS,1)=CA85 ;Contact type
 ...S:SEQ=2 FDA(409.863,IENS,2)=$P(R85,"^",18) ;Comments from top level #409.85,25 -> Comments
 ...S FDA(409.863,IENS,3)=CLM85 ;Left message
 ...S FDA(409.863,IENS,4)=SEQ-1 ;Sequence
 ...S FDA(409.863,IENS,5)=CU85 ;User entered contact
 ...S FDA(409.863,IENS,6)=CDT85 ;Date/time entered
 ..;
 ..S ^XTMP("SDEC671")=DFN85_"^"_IEN85
 ..D UPDATE^DIE("","FDA","","MSG")
 Q
 ;
RESTART ;Copy data from File #409.85 to #409.86
 N CA85,CDT85,CLM85,CN85,CR85,CU85,DFN85
 ;
 ;Loop through entries in file #409.85
 I '$G(^XTMP("SDEC671")) S $P(^XTMP("SDEC671"),"^",1)=0
 S DFN85=$P(^XTMP("SDEC671"),"^",1) F  S DFN85=$O(^SDEC(409.85,"B",DFN85)) Q:DFN85'>0  D
 .S IEN85="" F  S IEN85=$O(^SDEC(409.85,"B",DFN85,IEN85)) Q:IEN85=""  D
 ..N FDA,SEQ,MSG,DIERR,DIMSG,R85
 ..S R85=$G(^SDEC(409.85,IEN85,0)) Q:R85=""
 ..Q:$P($G(R85),"^",17)'="O"  ;Current status (#23)
 ..Q:DFN85'=$P(R85,"^")
 ..Q:$O(^SDEC(409.85,IEN85,4,0))'>0  ;Patient contact multiple (#44)
 ..;
 ..;Set FDA for top level fields of File #409.86
 ..S FDA(409.86,"+1,",.01)=DFN85 ;Patient
 ..S FDA(409.86,"+1,",1)=$P(R85,"^",9) ;Req specific clinic (#8,P44) -> Clinic
 ..S FDA(409.86,"+1,",2)=$P(R85,"^",16) ;CID/Preferred Date of Appt (#22) -> Preferred date
 ..S FDA(409.86,"+1,",2.1)=$P(R85,"^",5) ;Request type (#4) -> Request type
 ..S FDA(409.86,"+1,",2.2)=1 ;Sequence
 ..S FDA(409.86,"+1,",1.1)=$P(R85,"^",4) ;Req service/specialty (#8.5,P40.7) -> Service
 ..;
 ..;Loop through PATIENT CONTACT multiple (#44) of File #409.85 and set FDA array
 ..;for the DATE/TIME of CONTACT multiple (#3) of File #409.86
 ..S SEQ=1
 ..S CN85="" F  S CN85=$O(^SDEC(409.85,IEN85,4,CN85)) Q:CN85'>0  D
 ...S CR85=$G(^SDEC(409.85,IEN85,4,CN85,0)) Q:CR85=""
 ...S CDT85=$P(CR85,"^") Q:CDT85=""  ;Date entered (#.01)
 ...S CU85=$P(CR85,"^",2) Q:CU85=""  ;Entered by user (#2,P200)
 ...S CA85=$P(CR85,"^",3) Q:CA85=""  ;Action (#3)
 ...S CLM85="" I CA85="M" S CA85="C",CLM85=1
 ...;
 ...S SEQ=SEQ+1
 ...S IENS="+"_SEQ_",+1,"
 ...S FDA(409.863,IENS,.01)=$P(CR85,"^")
 ...S FDA(409.863,IENS,1)=CA85 ;Contact type
 ...S:SEQ=2 FDA(409.863,IENS,2)=$P(R85,"^",18) ;Comments from top level #409.85,25 -> Comments
 ...S FDA(409.863,IENS,3)=CLM85 ;Left message
 ...S FDA(409.863,IENS,4)=SEQ-1 ;Sequence
 ...S FDA(409.863,IENS,5)=CU85 ;User entered contact
 ...S FDA(409.863,IENS,6)=CDT85 ;Date/time entered
 ..;
 ..S ^XTMP("SDEC671")=DFN85_"^"_IEN85
 ..D UPDATE^DIE("","FDA","","MSG")
 Q
 ;
POST2 ;
 N PAT84,ST84,APP84,IEN84,CL84P,CL84,DFN84,PAT0,STA
 S J=0
 ;
 S ADT84="" F  S ADT84=$O(^SDEC(409.84,"B",ADT84)) Q:ADT84'>0  D
 .S IEN84="" F  S IEN84=$O(^SDEC(409.84,"B",ADT84,IEN84)) Q:IEN84=""  D
 ..S PAT84="" S PAT84=^SDEC(409.84,IEN84,0) Q:PAT84=""
 ..Q:$P($G(PAT84),"^",5)=""
 ..Q:$P($G(PAT84),"^",3)'=""  ;Quit if cancel d/t entered
 ..Q:$P($G(PAT84),"^",4)'=""
 ..Q:$P($G(PAT84),"^",12)'=""
 ..Q:$P($G(PAT84),"^",14)'=""  ;Quit if checkout d/t entered
 ..S ST84="" S ST84=$P($G(PAT84),"^",17)
 ..S DFN84="" S DFN84=$P($G(PAT84),"^",5) Q:DFN84=""
 ..S CL84P="" S CL84P=$P($G(PAT84),"^",7) Q:CL84P=""
 ..S CL84="" S CL84=$$GET1^DIQ(409.831,CL84P,.04,"I") Q:CL84=""
 ..S PAT0="" S PAT0=$G(^DPT(DFN84,0)) Q:PAT0=""
 ..S STA="" S STA=$$STATUS^SDAM1(DFN84,ADT84,CL84,PAT0)
 ..I ($P(STA,";",1)=11)!($P(STA,";",1)=3) D DEL
 ..Q
 Q
 ;
DEL ;
 N REC2
 S REC2=$G(^DPT(DFN84,"S",ADT84,0))
 Q:$P(REC2,"^",1)=CL84
 W !,IEN84_"   "_ADT84_"  "_$P(^DPT(DFN84,0),"^",1)
 S J=J+1 S ^XTMP("673SDEC",J)=IEN84_"   "_ADT84_"  "_$P(^DPT(DFN84,0),"^",1)
 S DIK="^SDEC(409.84,",DA=IEN84 D ^DIK
 Q
