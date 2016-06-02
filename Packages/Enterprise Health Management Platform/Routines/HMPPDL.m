HMPPDL ;ASMR/PB - Get a users default patient list for HMP ; 07/31/2015
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Jul 31, 2015;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References      DBIA#
 ; ------------------------------
 ;  $$BROKER^XWBLID          2190
 ;  $$GET^XPAR               2263
 ;  CLINPTS2^ORQPTQ2         4207
 ;  BYWARD^ORWPT             4904
 ;  PROVPTS^ORQPTQ2          4207
 ;  SPECPTS^ORQPTQ2          4207
 ;  $$UP^XLFSTR             10104
 ;  $$FMTE^XLDFT            10103
 ;  $$GET1^DIQ               2056
 ;
 Q
 ;
DEFLIST(Y,DUZ) ; return current user's default patient list
 I $$BROKER^XWBLIB S Y=$NA(^TMP("OR",$J,"PATIENTS")) ; GUI = global.  ICR 2190
 I '$$BROKER^XWBLIB S ^TMP("OR",$J,"PATIENTS",0)=""  ;ICR 2190
 Q:'$D(DUZ)  ;DUZ is required in order to get the list of patients for the user
 N FROM,IEN,BEG,END,API,ORSRV,ORQDAT,ORQCNT,ORGUI
 ;S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U) ; get the users Network Identifier for the user
 S ORSRV=$$GET1^DIQ(200,DUZ_",",29,"I") ; get the users Network Identifier for the user  ICR 2056
 S FROM=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT LIST SOURCE",1,"Q") ; gets the users default preference for patient list source. ICR 2263
 ;FROM - T:Team/Personal List, W:Ward List, C:Clinic List, P:Provider List, S:Specialty List; M:Combination List.
 ;FROM must be defined
 Q:'$L($G(FROM))
 I FROM="T" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT TEAM",1,"Q") D:+$G(IEN)>0 TEAMPTS^ORQPTQ1(.Y,IEN)  ;returns the list of patients assigned to a team.  ICR 2263
 I FROM="W" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT WARD",1,"Q") D:+$G(IEN)>0 BYWARD^ORWPT(.Y,IEN)  ;returns the list of patients on a ward  ICR 4904 ICR 2263
 I FROM="P" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT PROVIDER",1,"Q") D:+$G(IEN)>0 PROVPTS^ORQPTQ2(.Y,IEN)  ;returns the list of patients assigned to a provider  ICR 4207 ICR 2263
 I FROM="S" S IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),"ORLP DEFAULT SPECIALTY",1,"Q") D:+$G(IEN)>0 SPECPTS^ORQPTQ2(.Y,IEN)  ;returns the list of patients assigned to a specialty  ICR 4207 ICR 2263
 I FROM="C" D
 .S API="ORLP DEFAULT CLINIC "_$$UP^XLFSTR($$DOW^XLFDT(DT)),IEN=$$GET^XPAR("USR^SRV.`"_+$G(ORSRV),API,1,"Q") I +$G(IEN)>0 D  ;returns a list of patients for the clinic based on the user's default start and end dates ICR 2263, ICR 10104
 ..S BEG=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))  ;returns the user's default start date ICR 2263,  ICR 10104
 ..I BEG="T+0" S BEG=$$FMTE^XLFDT(DT,BEG)  ;ICR 10103
 ..S END=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))  ;returns the user's default end date  ICR 2263,  ICR 10104
 ..I END="T+0" S END=$$FMTE^XLFDT(DT,END)  ;ICR 10103
 ..D CLINPTS2^ORQPTQ2(.Y,+$G(IEN),BEG,END) ;returns the patient list ICR 4207
 ;The code below will pull a list of patients for the user based on the combinations of lists set up for the user in
 ;OR(100.24, OE/RR PT SEL COMBO FILE. This file stores the users combinations use to pull a combined list of patients from multiple files. 
 ;The COMBINATION ITEM multiple stores the file's IEN and the file root for the files that store the patient list.
 ;The user can create lists from the WARD LOCATIONS (#42), NEW PERSON (#200), FACILITY TREATING SPECIALTY (#45.7), OE/RR LIST (#101.21) and the HOSPITAL LOCATION(#44)
 ;or any combinations of these files. Each list is stored in a separate row in the COMBINATION ITEM multiple. The code
 ;loops through this multiple and the pulls the lists based on the entries. 
 I FROM="M" D
 .;S IEN=$D(^OR(100.24,DUZ,0)) I +$G(IEN)>0 S IEN=DUZ D
 .S IEN=$$GET1^DIQ(100.24,DUZ_",",.01,"I") I +$G(IEN)>0 S IEN=DUZ D   ;ICR 2056 
 ..S BEG=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC START DATE",1,"E"))  ;returns the user's default start date ICR 10104
 ..I BEG="T+0" S BEG=$$FMTE^XLFDT(DT,BEG)
 ..S END=$$UP^XLFSTR($$GET^XPAR("USR^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORLP DEFAULT CLINIC STOP DATE",1,"E"))  ;returns the user's default end date ICR 10104
 ..I END="T+0" S END=$$FMTE^XLFDT(DT,END)
 ..D COMBPTS^ORQPTQ6(0,+$G(IEN),BEG,END) ; first parameter "0"= GUI RPC call. Returns the lists patients for each entry in the COMBINATION ITEM multiple
 I ($$BROKER^XWBLIB)&(FROM'="M") D  ; Combinations already written to global. ICR 2190
 .S ORQDAT="",ORQCNT=0
 .F  S ORQCNT=$O(Y(ORQCNT)) Q:ORQCNT=""  S ORQDAT=Y(ORQCNT) D
 ..S ^TMP("OR",$J,"PATIENTS",ORQCNT,0)=ORQDAT
 I ('$$BROKER^XWBLIB) S Y=FROM_";"_+$G(IEN)_";"_$G(BEG)_";"_$G(END) ;   ICR 2190
 Q
