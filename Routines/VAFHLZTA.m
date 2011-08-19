VAFHLZTA ;ALB/ESD,TDM - Creation of ZTA segment ; 3/28/09 4:29pm
 ;;5.3;Registration;**68,653,688,806**;Aug 13, 1993;Build 1
 ;
 ; This generic extrinsic function returns the HL7 VA-Specific Temporary Address (ZTA) segment.
 ;
 ;
EN(DFN,VAFSTR,VAFNUM,HL) ; Returns HL7 ZTA segment containing temporary address
 ;                 data.
 ;
 ;  Input - DFN as internal entry number of the PATIENT file
 ;          VAFSTR as string of fields requested separated by commas.
 ;          VAFNUM as SetId - set to 1.
 ;          HL *** NOT USED, WILL BE REMOVED AT A LATER TIME ***
 ;
 ; Output - string of components forming the ZTA segment.
 ;
 N VAFNODE,VAFY,X,X1
 N COMP,HLES,VAFNODE1,HL7STRG,SQ5,CNTRY
 I '$G(DFN)!($G(VAFSTR)']"") G QUIT
 I $G(HLFS)="" N HLFS S HLFS="^"
 I $G(HL("FS"))="" S HL("FS")=HLFS
 I $G(HLQ)="" N HLQ S HLQ=""""""
 I $G(HLECH)="" N HLECH S HLECH="~|\&"
 I $G(HL("ECH"))="" S HL("ECH")=HLECH
 S COMP=$E(HLECH,1),HLES=$E(HLECH,3)
 S VAFNODE=$G(^DPT(DFN,.121)),VAFNODE1=$G(^DPT(DFN,.122))
 S $P(VAFY,HLFS,9)="",VAFSTR=","_VAFSTR_","
 S $P(VAFY,HLFS,1)=1 ; SetId equal to 1
 I VAFSTR[",2," S X=$P(VAFNODE,"^",9),$P(VAFY,HLFS,2)=$$YN^VAFHLFNC(X) ; Temporary Address Enter/Edit?
 I VAFSTR[",3," S X=$$HLDATE^HLFNC($P(VAFNODE,"^",7)),$P(VAFY,HLFS,3)=$S(X]"":X,1:HLQ) ; Temporary Address Start Date
 I VAFSTR[",4," S X=$$HLDATE^HLFNC($P(VAFNODE,"^",8)),$P(VAFY,HLFS,4)=$S(X]"":X,1:HLQ) ; Temporary Address End Date
 I VAFSTR[",5," D
 . K HL7STRG S HL7STRG=$P(VAFNODE,"^",1) D HL7TXT^VAFCQRY1(.HL7STRG,.HL,HLES) S SQ5=$S(HL7STRG="":HLQ,1:HL7STRG)
 . K HL7STRG S HL7STRG=$P(VAFNODE,"^",2) D HL7TXT^VAFCQRY1(.HL7STRG,.HL,HLES) S $P(SQ5,COMP,2)=$S(HL7STRG="":HLQ,1:HL7STRG)
 . K HL7STRG S HL7STRG=$P(VAFNODE,"^",3) D HL7TXT^VAFCQRY1(.HL7STRG,.HL,HLES) S $P(SQ5,COMP,8)=$S(HL7STRG="":HLQ,1:HL7STRG)
 . S CNTRY=$$GET1^DIQ(2,DFN_",",.1223)  ;RETURN EXTERNAL VALUE
 . I CNTRY="US" S CNTRY="USA"
 . K HL7STRG S HL7STRG=$P(VAFNODE,"^",4),$P(SQ5,COMP,3)=$S(HL7STRG="":HLQ,1:HL7STRG)
 . I CNTRY=""!(CNTRY="USA") D    ;have USA address
 . . S X=$$GET1^DIQ(5,+$P(VAFNODE,"^",5)_",",1),$P(SQ5,COMP,4)=$S(X="":HLQ,1:X)
 . . S X=$P(VAFNODE,"^",12),$P(SQ5,COMP,5)=$S(X="":HLQ,1:X)
 . I CNTRY'="",(CNTRY'="USA") D  ;Check for foreign address fields
 . . S X=$P(VAFNODE1,"^",1),$P(SQ5,COMP,4)=$S(X="":HLQ,1:X)
 . . S X=$P(VAFNODE1,"^",2),$P(SQ5,COMP,5)=$S(X="":HLQ,1:X)
 . S $P(SQ5,COMP,6)=$S(CNTRY="":HLQ,1:CNTRY)
 . S X=$$GET1^DIQ(2,DFN_",",.12111),$P(SQ5,COMP,9)=$S(X="":HLQ,1:X)
 . S $P(VAFY,HLFS,5)=SQ5
 I VAFSTR[",6," S X=$$GET1^DIQ(2,DFN_",",.12111),$P(VAFY,HLFS,6)=$S(X="":HLQ,1:X)
 I VAFSTR[",7," S X=$$HLPHONE^HLFNC($P(VAFNODE,"^",10)),$P(VAFY,HLFS,7)=$S(X]"":X,1:HLQ) ; Temporary Address Phone
 I VAFSTR[",8," S X=$$HLDATE^HLFNC($P(VAFNODE,"^",13)),$P(VAFY,HLFS,8)=$S(X]"":X,1:HLQ) ; Temp Addr Last Updated
 I VAFSTR[",9," D   ; Temp Addr Site of Change
 . S X=$P(VAFNODE,"^",14),X=$$GET1^DIQ(4,(+X)_",",99)
 . S $P(VAFY,HLFS,9)=$S(X]"":X,1:HLQ)
QUIT Q "ZTA"_HLFS_$G(VAFY)
