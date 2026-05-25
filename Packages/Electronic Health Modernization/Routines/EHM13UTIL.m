EHM13UTIL ; ALB/WTC - EHM*1*13 utilities ; Jun 05, 2025@14:49:13
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 ;
 Q  ;
 ;
ENCTRSTS(IEN) ;
 ;
 ;  Returns status of encounter or its parent.
 ;
 ;  IEN = Encounter (pointer to #409.68)
 ;
 N STATUS ;
 I '$D(^SCE(IEN,0)) Q "" ; Bad data
 I $P(^SCE(IEN,0),U,6)'="" S IEN=$P(^SCE(IEN,0),U,6) ;  Not a parent encounter.  Return status from its parent.
 ;
 S STATUS=$$GET1^DIQ(409.68,IEN,.12) ;
 ;I STATUS="ACTION REQUIRED",$$MPTYNCTR(IEN)=1 Q "" ;  Empty ACTION REQUIRED encounter.
 Q STATUS ;
 ; 
MPTYNCTR(IEN) ;
 ;
 ;  Returns 1 if encounter is "empty".  0 if not.  "Empty" means no diagnosis, service/procedure, provider, immunization, health factor or associated TIU document.
 ;
 ;  IEN= Encounter (pointer to #409.68)
 ;
 N VISIT,TIUDOC,RESULT ;
 ;
 I $G(^SCE(IEN,0))="" Q 1 ;  Bad data.
 I $P(^SCE(IEN,0),U,6)'="" S IEN=$P(^SCE(IEN,0),U,6) ;  Not a parent encounter.  Return status from its parent.
 ;
 S VISIT=$P(^SCE(IEN,0),U,5) I 'VISIT Q 1 ;  No visit.
 ;
 I $D(^AUPNVPRV("AD",VISIT)) Q 0 ; Visit has provider.
 I $D(^AUPNVPOV("AD",VISIT)) Q 0 ; Visit has diagnosis.
 I $D(^AUPNVCPT("AD",VISIT)) Q 0 ; Visit has service/procedure.
 I $D(^AUPNVIMM("AD",VISIT)) Q 0 ; Visit has immunization.
 I $D(^AUPNVHF("AD",VISIT)) Q 0 ; Visit has health factor.
 I $D(^TIU(8925,"AVSIT",VISIT)) D  Q RESULT ; Visit has TIU document.
 . ;
 . ;  Scan TIU documents.  If any of them are not RETRACTED, then encounter is not empty.
 . ;
 . S RESULT=1,TIUDOC=0 F  S TIUDOC=$O(^TIU(8925,"AVSIT",VISIT,TIUDOC)) Q:'TIUDOC  I $$GET1^DIQ(8925,TIUDOC,.05)'="RETRACTED" S RESULT=0 Q  ;
 ;
 Q 1 ;
 ;
ADDAPPT(SCIEN,APPTDTTM,DFN,IEN2) ;
 ;
 ;  Add appointment to file #409.84
 ;
 N SDECIEN,FDA,DURATION,RESRCIEN,IENS ;
 ;
 S DURATION=$P(^SC(SCIEN,"S",APPTDTTM,1,IEN2,0),U,2) ;
 S RESRCIEN=$O(^SDEC(409.831,"ALOC",SCIEN,0)) ;
 ;
 S SDECIEN="+1," ;
 S FDA(409.84,SDECIEN,.01)=APPTDTTM ;
 S FDA(409.84,SDECIEN,.02)=$$FMADD^XLFDT(APPTDTTM,,,DURATION) ;
 S FDA(409.84,SDECIEN,.05)=DFN ;
 S FDA(409.84,SDECIEN,.07)=RESRCIEN ;
 S FDA(409.84,SDECIEN,.08)=$P(^SC(SCIEN,"S",APPTDTTM,1,IEN2,0),U,6) ;
 S FDA(409.84,SDECIEN,.09)=$P(^SC(SCIEN,"S",APPTDTTM,1,IEN2,0),U,7) ;
 S FDA(409.84,SDECIEN,.18)=DURATION ;
 D UPDATE^DIE("","FDA","IENS") ;
 S SDECIEN=+$G(IENS(1)) I SDECIEN<1 S SDECIEN="0^Add appointment failed" ;
 Q SDECIEN ;
 ;
LASTFI(DFN,NAME) ;
 ;
 ;  DFN  = Patient (pointer to #2) [OPTIONAL]
 ;  NAME = Name in 'last,first' format
 ;
 ;  Return last name and first initial of a patient (if DFN passed in) or other name (if DFN absent).
 ;
 N LASTFI ;
 S LASTFI="" ;
 I $G(DFN) S NAME=$P(^DPT(DFN,0),U,1) ;
 Q:$G(NAME)="" "" ;
 ;
 S LASTFI=$P(NAME,",",1)_","_$E($P(NAME,",",2),1) ;
 Q LASTFI ;
 ;
FMTDTTM(DATETIME) ;
 ;
 ;  Return formatted date/time (MM/DD/YY@HHMM)
 ;
 N MM,DD,YY,FMTDTTM ;
 ;
 S FMTDTTM=$$FMTE^XLFDT(DATETIME,2),MM=$P($P(FMTDTTM,"@",1),"/",1),DD=$P($P(FMTDTTM,"@",1),"/",2),YY=$P($P(FMTDTTM,"@",1),"/",3) ;
 S:$L(MM)<2 MM="0"_MM S:$L(DD)<2 DD="0"_DD S:$L(YY)<2 YY="0"_YY ;
 S FMTDTTM=MM_"/"_DD_"/"_YY_"@"_$P($P(FMTDTTM,"@",2),":",1,2) ;
 Q FMTDTTM ;
 ;
PROGRESS(DONE,TOTAL) ;
 ;
 ;  Display progress going through file.
 ;
 I $G(TOTAL) W *13 S $X=0 W $J(DONE/TOTAL*100\1,8),"% of ",TOTAL Q  ;
 W *13 S $X=0 W $FN(DONE,",") Q  ;  
 ;
COMMAOUT(NUMITEMS,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10) ;
 ;
 ;  NUMITEMS    = Number of items to include in the output string.
 ;  S1,S2,...S10 = Up to 10 values to include in the output string.
 ;
 ;  Output comma-delimited string of values.
 ;
 N COMMAOUT,I,X ;
 S COMMAOUT="" F I=1:1:NUMITEMS S @("X=S"_I),COMMAOUT=COMMAOUT_$C(34)_X_$C(34)_$S(I<NUMITEMS:",",1:"") ;
 Q COMMAOUT ;
 ;
CENTER(TEXT,WIDTH) ;
 ;
 ;  Return centered text.
 ;
 N CENTERED ;
 S CENTERED=$J("",WIDTH-$L(TEXT)/2)_TEXT ;
 Q CENTERED ;
 ;
DASHES(COUNT) ;
 ;
 N I,DASHES S DASHES="" F I=1:1:COUNT S DASHES=DASHES_"-" ;
 Q DASHES ;
 ;
CONTINUE() ;
 ;
 ;  Prompt user to continue or quit.
 ;
 N DIR,Y,DIRUT ;
 S DIR(0)="Y",DIR("A")="Continue",DIR("B")="YES" D ^DIR ; 
 I $D(DIRUT) Q 0 ;
 Q Y ;
 ;
STRIP(X) ;
 ;
 ;  Strip off leading spaces.
 ;
 Q:$E(X,1)'=" " X ;
 S X=$E(X,2,$L(X)) Q $$STRIP(X) ;
 ;
COMMAOUT2(ARY) ;
 ;
 ;  ARY = Array of values to include in the output string.
 ;
 ;  Output comma-delimited string of values.
 ;
 N COMMAOUT,I,X ;
 S COMMAOUT="",I="" F  S I=$O(ARY(I)) Q:I=""  S X=ARY(I),COMMAOUT=COMMAOUT_$C(34)_X_$C(34)_"," ;
 Q $E(COMMAOUT,1,$L(COMMAOUT)-1) ;
 ;
CONVDATE() ;
 ;
 ;  Enter conversion date
 ;
 N DIR,DIRUT,X,Y ;
 ;
 S DIR(0)="D^::EX",DIR("A")="Conversion Date" D ^DIR Q:$D(DIRUT) "" ;
 Q Y ;
 ;
SORTORDR() ;
 ;
 ;  Sort Order
 ;
 N DIR,X,Y,DIRUT ;
 ;
 S DIR(0)="S^1:Appointment Date/Time, Patient, Clinic;2:Clinic, Appointment Date/Time, Patient;3:Patient, Appointment Date/Time, Clinic",DIR("A")="Sort Order",DIR("B")=1 D ^DIR Q:Y="" "" Q:$D(DIRUT) "" ;
 Q Y ;
 ;
FILTER() ;
 ;
 ;  Encounter filter
 ;
 N DIR,X,Y,DIRUT ;
 ;
 S DIR(0)="SO^1:All;2:With Encounters;3:Without Encounters;4:Without ACTION REQUIRED Encounters",DIR("A")="Appointment Filter",DIR("B")="ALL" D ^DIR Q:$D(DIRUT) "" ;
 Q Y ;
 ;
CLINICS(CLINICS) ;
 ;
 ;  Clinics to include or exclude.  Returns A=All, X=All except selected clinics, S=Selected clinics.  CLINICS array returned for X and S.
 ;
 N DIR,X,Y,DIRUT,CLINFLTR,DIC ;
 ;
 S DIR(0)="SO^A:All;X:Excluding selected clinics;S:Selected clinics",DIR("A")="Clinics",DIR("B")="All" D ^DIR Q:$D(DIRUT) "" S CLINFLTR=Y ;
 ;
 I CLINFLTR="A" Q CLINFLTR ;
 ;
 ;  Select clinics to include/exclude
 ;
 F  K DIC S DIC=44,DIC(0)="AEQM",DIC("A")="Clinic to "_$S(CLINFLTR="X":"exclude",1:"include")_": " D ^DIC Q:$D(DIRUT)  Q:Y=-1  S CLINICS(+Y)=$S(CLINFLTR="X":"EXCLUDE",1:"INCLUDE") ;
 ;
 Q CLINFLTR ;
 ;
NONCOUNT() ;
 ;
 ;  Include/exclude non-count clinics.
 ;
 N DIR,X,Y,DIRUT ;
 ;
 S DIR(0)="SO^I:Include;E:Exclude",DIR("A")="Non-count Clinics",DIR("B")="I" D ^DIR Q:$D(DIRUT) "" ;
 Q Y ;
 ;
RPTFMT() ;
 ;
 ;  Output format
 ;
 N DIR,X,Y,DIRUT ;
 ;
 S DIR(0)="SO^F:Formatted Report;C:Comma-Delimited",DIR("A")="Output Format",DIR("B")="Formatted Report" D ^DIR Q:$D(DIRUT) "" ;
 Q Y ;
 ;
