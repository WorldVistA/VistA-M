VAFHLZGD ;ALB/KCL/CPM - Create generic HL7 ZGD segment ; 17 Febuary 1993
 ;;5.3;Registration;**33,68**;Aug 13, 1993
 ;
 ;
EN(DFN,VAFSTR,VAFREQ,VAFNUM) ; This generic extrinsic function was
 ;                                 designed to return the HL7 ZGD
 ;                                 segment.  This segment contains
 ;                                 generic information pertaining to
 ;                                 a patient's legal guardian.
 ;
 ;  Input - DFN as internal entry number of the PATIENT file.
 ;          VAFSTR as string of fields requested separated by commas
 ;          VAFREQ is 1 if VA guardian data is requested, 2 if Civil
 ;                   guardian data is requested.
 ;          VAFNUM as sequential number to add to SET ID.
 ;
 ;     *****Also assumes all HL7 variables returned from*****
 ;          INIT^HLTRANS are defined.
 ;
 ; Output - String of data forming the HL7 ZGD segment.
 ;
 N VAFNODE,VAFY,X,X1
 I '$G(DFN)!($G(VAFSTR)']"") G QUIT
 I $G(VAFREQ)'=2 S VAFREQ=1 ; Default to VA guardian
 S $P(VAFY,HLFS,8)="",VAFSTR=","_VAFSTR_","
 S X=$P($T(GUAR+VAFREQ),";;",2),VAFNODE=$G(^DPT(DFN,X))
 S $P(VAFY,HLFS,1)=$G(VAFNUM)+1 ; Sequential number (Required field)
 S $P(VAFY,HLFS,2)=VAFREQ ; Guardian type (Required field)
 I VAFSTR[",3," S $P(VAFY,HLFS,3)=$S($P(VAFNODE,"^",4)]"":$P(VAFNODE,"^",4),1:HLQ) ; Guardian
 I VAFSTR[",4," S X=$P(VAFNODE,"^",3),X1=$S(VAFREQ=1:$P($G(^DIC(4,+X,0)),"^",1),1:X),$P(VAFY,HLFS,4)=$S(X1]"":X1,1:HLQ) ; Guardian Institution
 I VAFSTR[",5," S $P(VAFY,HLFS,5)=$S($P(VAFNODE,"^",5)]"":$P(VAFNODE,"^",5),1:HLQ) ; Relationship
 I VAFSTR[",6," S X1=$$ADDR^VAFHLFNC($P(VAFNODE,"^",6,7)_"^^"_$P(VAFNODE,"^",8,9)_"^"_$P(VAFNODE,"^",$P($T(GUAR+VAFREQ),";;",3))),$P(VAFY,HLFS,6)=$S(X1]"":X1,1:HLQ) ; Address
 I VAFSTR[",7," S X1=$$HLPHONE^HLFNC($P(VAFNODE,"^",11)),$P(VAFY,HLFS,7)=$S(X1]"":X1,1:HLQ) ; Phone
 I VAFSTR[",8," S X1=$$HLDATE^HLFNC($P($G(^DPT(DFN,.29)),"^",VAFREQ)),$P(VAFY,HLFS,8)=$S(X1]"":X1,1:HLQ) ; Date Ruled Incomp
 ;
QUIT ; 
 Q "ZGD"_HLFS_$G(VAFY)
 ;
GUAR ; Corresponding nodes for guarantor type and ZIPZ+4 field piece.
 ;;.29;;13
 ;;.291;;12
