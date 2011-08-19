VAFHLZEM ;ALB/KCL,TDM - Create generic HL7 ZEM segment ; 12/22/08 4:37pm
 ;;5.3;Registration;**68,754**;Aug 13, 1993;Build 46
 ;
 ;
EN(DFN,VAFSTR,VAFREQ,VAFNUM) ; This generic extrinsic function was
 ;                         designed to return the HL7 ZEM segment.  This
 ;                         segment contains VA-specific information
 ;                         pertaining to the employment of a patient or
 ;                         his/her spouse.
 ;
 ;  Input - DFN as internal entry number of the PATIENT file.
 ;          VAFSTR as the string of fields requested seperated by commas.
 ;          VAFREQ is 1 for PATIENT request, is 2 for SPOUSAL request.
 ;                   If nothing is passed default to PATIENT request.
 ;          VAFNUM as sequential number to add to SETID.
 ;
 ;     *****Also assumes all HL7 variables returned from*****
 ;          INIT^HLTRANS are defined.
 ;
 ; Output - String of data forming the HL7 ZEM segment.
 ;
 N X,X1,VAFY
 I '$G(DFN)!($G(VAFSTR)']"") G QUIT
 S $P(VAFY,HLFS,9)="",VAFSTR=","_VAFSTR_",",VAFREQ=$G(VAFREQ)
 S $P(VAFY,HLFS,1)=$S($G(VAFNUM):VAFNUM,1:1) ; Sequential number (required field)
 I VAFREQ'=2 S $P(VAFY,HLFS,2)=1 D PATZEM
 I VAFREQ=2 S $P(VAFY,HLFS,2)=2 D SPOUZEM
QUIT ; 
 Q "ZEM"_HLFS_$G(VAFY)
 ;
PATZEM ; Patient data requested.
 S X=$G(^DPT(DFN,.311))
 I VAFSTR[",3," S $P(VAFY,HLFS,3)=$S($P(X,"^",15)]"":$P(X,"^",15),1:HLQ) ; Employment Status.
 I VAFSTR[",4," S $P(VAFY,HLFS,4)=$S($P(X,"^",1)]"":$P(X,"^",1),1:HLQ) ; Employer Name.
 I VAFSTR[",5," S X1=$P($G(^DPT(DFN,0)),"^",7),$P(VAFY,HLFS,5)=$S(X1]"":X1,1:HLQ) ; Occupation.
 I VAFSTR[",6," S X1=$$ADDR^VAFHLFNC($P(X,"^",3,7)_"^"_$P($G(^DPT(DFN,.22)),"^",5)),$P(VAFY,HLFS,6)=$S(X1]"":X1,1:HLQ) ; Employer Address.
 I VAFSTR[",7," S X1=$$HLPHONE^HLFNC($P(X,"^",9)),$P(VAFY,HLFS,7)=$S(X1]"":X1,1:HLQ) ; Employer Phone.
 I VAFSTR[",8," S X1=$$YN^VAFHLFNC($P(X,"^",2)),$P(VAFY,HLFS,8)=$S(X1]"":X1,1:HLQ) ; Government Agency.
 ;I VAFSTR[",8," S $P(VAFY,HLFS,8)=$S($P(X,"^",2)]"":$P(X,"^",2),1:HLQ) ; Government Agency.
 I VAFSTR[",9," S X1=$$HLDATE^HLFNC($P(X,"^",16)),$P(VAFY,HLFS,9)=$S(X1]"":X1,1:HLQ)  ;Retirement Date
 Q
 ;
SPOUZEM ; Spousal data requested.
 S X=$G(^DPT(DFN,.25))
 I VAFSTR[",3," S $P(VAFY,HLFS,3)=$S($P(X,"^",15)]"":$P(X,"^",15),1:HLQ) ; Employment Status.
 I VAFSTR[",4," S $P(VAFY,HLFS,4)=$S($P(X,"^",1)]"":$P(X,"^",1),1:HLQ) ; Employer Name.
 I VAFSTR[",5," S $P(VAFY,HLFS,5)=$S($P(X,"^",14)]"":$P(X,"^",14),1:HLQ) ; Occupation.
 I VAFSTR[",6," S X1=$$ADDR^VAFHLFNC($P(X,"^",2,6)_"^"_$P($G(^DPT(DFN,.22)),"^",6)),$P(VAFY,HLFS,6)=$S(X1]"":X1,1:HLQ) ; Employer Address.
 I VAFSTR[",7," S X1=$$HLPHONE^HLFNC($P(X,"^",8)),$P(VAFY,HLFS,7)=$S(X1]"":X1,1:HLQ) ; Employer Phone.
 I VAFSTR[",8," S $P(VAFY,HLFS,8)=HLQ
 I VAFSTR[",9," S X1=$$HLDATE^HLFNC($P(X,"^",16)),$P(VAFY,HLFS,9)=$S(X1]"":X1,1:HLQ)  ;Retirement Date
 Q
