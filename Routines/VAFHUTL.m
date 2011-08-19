VAFHUTL ;ALB/CM/PHH/EG/GAH UTILITIES ROUTINE ; 10/18/06
 ;;5.3;Registration;**91,151,568,585,725**;Jun 06, 1996;Build 12
 ;
 ;
LTD(DFN) ;
 ;This function will find the last time seen at the facility
 ;
 ;  Input:  DFN -- pointer to the patient in file #2
 ;
 ;  Output:  FileMan Date/time ^ I,D,R,A,S ^ HL7 Date/time ^ Variable PTR
 ;
 ;  I = inpatient, D = discharge, R = Registration, A = Appointment
 ;  S = Stop Code
 ;
 ;  If Unsuccessful, Output:  -1^error message
 ;
 N LTD,X,FLG,LAST,VARPTR
 ;
 S FLG=""
 ; - need a patient
 I '$G(DFN) Q "-1^Missing Parameters for LTD function"
 ;
 ; - if current inpatient, set LTD = today and quit
 I $G(^DPT(DFN,.105)) S LTD=DT,FLG="I" I $D(^DGPM("ATID1",DFN)) S LAST=9999999.9999999-($O(^DGPM("ATID1",DFN,""))) G LTDQ
 ;
 ; - get the last discharge date
 S LTD=+$O(^DGPM("ATID3",DFN,"")) S:LTD FLG="D",LAST=9999999.9999999-LTD,LTD=LAST\1 S:LTD>DT (LAST,LTD)=DT
 ;
 ; - get the last registration date and compare to LTD
 S X=+$O(^DPT(DFN,"DIS",0)) I X S X=9999999-X S:(X\1)>LTD LAST=X,LTD=X\1,FLG="R",VARPTR=DFN_";DPT("
 ;
 ; - get the last appointment and compare to LTD
 N SDDATE,SDARRAY,SDCLIEN,SDSTAT
 S SDDATE=LTD,SDARRAY("FLDS")=3,SDARRAY(4)=DFN
 I $$SDAPI^SDAMA301(.SDARRAY)>0 D
 .S SDCLIEN=0
 .F  S SDCLIEN=$O(^TMP($J,"SDAMA301",DFN,SDCLIEN)) Q:'SDCLIEN!(SDDATE>DT)  D
 ..F  S SDDATE=$O(^TMP($J,"SDAMA301",DFN,SDCLIEN,SDDATE)) Q:'SDDATE!(SDDATE>DT)  D
 ...S SDSTAT=$P($P(^TMP($J,"SDAMA301",DFN,SDCLIEN,SDDATE),"^",3),";")
 ...I SDSTAT="R" D
 ....S LAST=SDDATE,LTD=SDDATE\1,FLG="A"
 ....I $D(VARPTR) K VARPTR
 K ^TMP($J,"SDAMA301")
 ;
 ; - get the last standalone after LTD
 S X=$$GETLAST^SDOE(DFN,LTD_".9999")
 I X S LAST=+$$SCE^DGSDU(X,1,0),LTD=LAST\1,FLG="S",VARPTR=X_";SCE("
 ;
LTDQ I '$D(LAST) Q "-1^No last date"
 I '$D(VARPTR) S VARPTR=$$VPTR(FLG,DFN,LAST)
 I +VARPTR<1 Q "-1^No last date"
 Q LAST_"^"_FLG_"^"_$$HLDATE^HLFNC(LAST,"TS")_"^"_VARPTR
 ;
 ;
VPTR(TYPE,DFN,EDATE) ;
 ;Gets pointer for inpatient/outpatient event
 ;
 I '$D(TYPE)!('$D(DFN))!('$D(EDATE)) Q "-1^Missing Parameters for VPTR function"
 N PTR,IND
 I TYPE'="A"&(TYPE'="D")&(TYPE'="I") Q "-1^NOT IN or OUT PATIENT"
 I TYPE="I"!(TYPE="D") D
 .;inpatient or discharge
 .S IND=$O(^DGPM("APID",DFN,"")),PTR=$O(^DGPM("APID",DFN,IND,""))
 .I $D(^DGPM(PTR)) S PTR="-1^MISSING ENTRY"
 .I +PTR>0 S PTR=PTR_";DGPM("
 I TYPE="A" D
 .;outpatient appointment
 .I $D(^SCE("ADFN",DFN,LAST)) S PTR=$O(^SCE("ADFN",DFN,LAST,"")) S:('$D(^SCE(+PTR,0))) PTR=DFN_";DPT(" S:($D(^SCE(+PTR,0))) PTR=PTR_";SCE("
 .I '$D(^SCE("ADFN",DFN,LAST)) S PTR=DFN_";DPT("
 Q PTR
 ;
GETF(SEG) ;NOT USED ANY MORE
 ;This function will return all of the available fields for the SEG
 ;segment as found in the HL7 DHCP PARAMETER file, as a string,
 ;separated by commas
 ;
 ;Input:  SEG - HL7 Segment
 ;Output:  Successful - string of field numbers seperated by commas
 ;If unsuccessful, -1^error message will be returned.
 ;
 ;NOTE: HL("SAN") must be defined as Sending Application in file 771
 ;N ENT,FLDS
 ;I '$D(HLENTRY)!('$D(SEG)) Q "-1^MISSING PARAMETERS"
 ;do lookup in #771 for HLENTRY
 ;S DIC="^HL(770,",DIC(0)="MQZ",X=HLENTRY D ^DIC
 ;I +Y<0 Q "-1^NO ENTRY IN FILE 771"
 ;S ENT=$P(^HL(770,+Y,0),"^",8) I ENT="" Q "-1^NO ENTRY IN APPLICATION FIELD"
 ;
 N ENT,FLDS
 I $G(HL("SAN"))]"",$G(SEG)]""
 E  Q "-1^MISSING PARAMETERS HL(SAN)!SEG"
 ;
 S ENT=$O(^HL(771,"B",HL("SAN"),0))
 I 'ENT Q "-1^NO ENTRY IN FILE 771"
 ;
 S DIC="^HL(771,ENT,""SEG"",",X=SEG,DIC(0)="MQZ" D ^DIC
 K DIC,X
 I +Y<0 K Y Q "-1^NO ENTRY IN SUBFILE #771.05"
 S FLDS=$P(^HL(771,ENT,"SEG",+Y,"F"),"^") K Y
 Q FLDS
 ;
UPDATE(PIVOT,ADATE,APTR,REMOVE) ;
 ;
 ;This function will allow the updating of PIVOT number entry, updating
 ;EVENT DATE/TIME and the VARIABLE POINTER and setting of the DELETED
 ;field.
 ;
 ;Input:  PIVOT  - Pivot Number
 ;        ADATE  - Event Date/Time (new)
 ;        APTR   - Variable Pointer (new)
 ;        REMOVE - 1 or null if 1 set DELETED field
 ;
 ;Output:  0 if successful
 ;        -1^error message if not successful
 ;
 I '$D(PIVOT) Q "-1^MISSING PARAMETERS"
 I '$D(^VAT(391.71,"D",PIVOT)) Q "-1^NO PIVOT ENTRY"
 I '$D(REMOVE) S REMOVE=""
 I APTR?.N1";".A1"(" D
 .I $P(APTR,";",2)="DPT(" S APTR="P.`"_+APTR
 .I $P(APTR,";",2)="SCE(" S APTR="O.`"_+APTR
 .I $P(APTR,";",2)="DGMP(" S APTR="I.`"_+APTR
 S DA=$O(^VAT(391.71,"D",PIVOT,"")) I DA="" Q "-1^BAD CROSS REFERENCE"
 S DIE="^VAT(391.71,",DIC(0)="MQZ",DR=""
 I ADATE'="" S DR=DR_".01///"_ADATE_";"
 I APTR'="" S DR=DR_".05///"_APTR_";"
 S DR=DR_".07///"_REMOVE
 L +^VAT(391.71,DA,0):5
 I '$T Q "-1^Unable to lock entry in Pivot file"
 D ^DIE L -^VAT(391.71,DA,0)
 K DIE,DR,DIC,DA,X,Y
 Q 0
 ;
SEND(VAR1) ;this function will test for the on/off parameter to send ADT messages.
 ;OUTPUTS   0 will indicate NOT to send
 ;          1 will indicate TO send
 ;          0 in second piece will indicate NOT to send HL7 v2.3
 ;          1 in second piece will indicate to send HL7 v2.3
 N VAR1
 S VAR1=$O(^DG(43,0))
 I +VAR1 S VAR1=$P($G(^DG(43,VAR1,"HL7")),"^",2,3)
 Q VAR1
 ;
HLQ(DATA) ;this function returns the value passed to it or HLQ
 I $G(DATA)="" Q HLQ
 Q DATA
 ;
NOSEND() ;function TURNS OFF the on/off parameter to send ADT messages.
 ;        used by init to disable all ADT HL7 protocols
 ; 
 ;OUTPUTS   1 will indicate it was SET NOT to send
 ;          0 will indicate it failed to SET IT NOT to send
 ;
 N VAR1
 S VAR1=$O(^DG(43,0))
 I +VAR1 S $P(^DG(43,+VAR1,"HL7"),"^",2,3)="0^0" Q 0
 Q 1
 ;
DPROTO(PNAM) ;returns 0 if protocol disabled field is not null, ie disabled
 ;        returns 1 if protocol is NOT disabled
 I $G(PNAM)]"",$P($G(^ORD(101,+$O(^ORD(101,"B",PNAM,0)),0)),"^",3)]"" Q 0
 Q 1
