VAFHLZIR ;ALB/SEK,TDM - Create generic HL7 ZIR segment ; 6/3/10 9:43am
 ;;5.3;Registration;**33,94,151,466,653,754**;Aug 13, 1993;Build 46
 ;
 ;
EN(VAFIEN,VAFSTR,VAFNUM,VAFENC) ; This generic extrinsic function was designed to
 ;          return the HL7 ZIR segment.  This segment contains
 ;          VA-specific information pertaining to income relation type
 ;          data for a veteran and any applicable relations.
 ;
 ;  Input - VAFIEN as internal entry number of the INCOME RELATION file.
 ;          VAFSTR as the string of fields requested seperated by commas.
 ;          VAFNUM as the number desired for the SET ID (default = 1)
 ;          VAFENC as Outpatient Encounter IEN (from file #409.68)
 ;
 ;  NOTE:   Input variable VAFENC was added as part of the Ambulatory
 ;          Care Reporting project.
 ;
 ;     *****Also assumes all HL7 variables returned from*****
 ;          INIT^HLTRANS are defined.
 ;
 ; Output - String of data forming the ZIR segment.
 ;
 ;
 N VAFDFN,VAFERR,VAFENODE,VAFNODE,VAFY,X,RELTYP,DCHILD
 I $G(VAFSTR)']"" G QUIT
 S VAFENC=+$G(VAFENC)
 I '$G(VAFIEN)&('VAFENC) G QUIT
 S $P(VAFY,HLFS,14)="",VAFSTR=","_VAFSTR_","
 S VAFNODE=$G(^DGMT(408.22,+$G(VAFIEN),0))
 I $G(VAFNODE)']""&('VAFENC) G QUIT
 S $P(VAFY,HLFS,1)=$S($G(VAFNUM):VAFNUM,1:1)
 S RELTYP=+$P($G(^DGPR(408.12,+$P($G(^DGMT(408.21,+$P(VAFNODE,"^",2),0)),"^",2),0)),"^",2)
 S DCHILD=$S(((RELTYP>2)&(RELTYP<7)):1,1:0)
 I VAFSTR[",2," S $P(VAFY,HLFS,2)=$$YN^VAFHLFNC($P(VAFNODE,"^",5)) ; Married last calendar year
 I VAFSTR[",3," S $P(VAFY,HLFS,3)=$$YN^VAFHLFNC($P(VAFNODE,"^",6)) ; Lived with patient
 ;I VAFSTR[",4," S X=$P(VAFNODE,"^",7),$P(VAFY,HLFS,4)=$S(X]"":X,1:HLQ) ; Amount contributed to spouse
 I VAFSTR[",4," S X=$P(VAFNODE,"^",$S(DCHILD:19,1:7)),$P(VAFY,HLFS,4)=$S(X]"":X,1:HLQ) ; Amount contributed to spouse/child
 I VAFSTR[",5," S $P(VAFY,HLFS,5)=$$YN^VAFHLFNC($P(VAFNODE,"^",8)) ; Dependent children (y/n)
 I VAFSTR[",6," S $P(VAFY,HLFS,6)=$$YN^VAFHLFNC($P(VAFNODE,"^",9)) ; Incapable of self-support
 I VAFSTR[",7," S $P(VAFY,HLFS,7)=$$YN^VAFHLFNC($P(VAFNODE,"^",10)) ; Contributed to support
 I VAFSTR[",8," S $P(VAFY,HLFS,8)=$$YN^VAFHLFNC($P(VAFNODE,"^",11)) ; Child had income
 I VAFSTR[",9," S $P(VAFY,HLFS,9)=$$YN^VAFHLFNC($P(VAFNODE,"^",12)) ; Income available to you
 I VAFSTR[",10," S X=$P(VAFNODE,"^",13),$P(VAFY,HLFS,10)=$S(X]"":X,1:HLQ) ; Number of dependent children
 ;
 ; ALB/ESD - Data elements 11,12,13 added as part of Ambulatory Care
 ;           Reporting Project requirements.
 ;
 I VAFSTR[",11,"!(VAFSTR[",12,")!(VAFSTR[",13,") D
 . ;
 . ;- If no encounter ptr, encounter node or DFN elements 11 - 13 = HLQ
 . I ('VAFENC) S VAFERR=1 Q
 . S VAFENODE=$$SCE^DGSDU(VAFENC) I VAFENODE']"" S VAFERR=1 Q
 . S VAFDFN=$P(VAFENODE,"^",2) S:VAFDFN="" VAFERR=1 Q
 I VAFSTR[",11," S $P(VAFY,HLFS,11)=$S('$G(VAFERR):+$$DEP^VAFMON(VAFDFN,$P(VAFENODE,"^")),1:HLQ) ;Total Dependents
 I VAFSTR[",12," S $P(VAFY,HLFS,12)=$S('$G(VAFERR):+$$INCOME^VAFMON(VAFDFN,$P(VAFENODE,"^")),1:HLQ) ;Patient Income
 ;
 ;- If outpat encounter node exists, get appointment type &
 ;  eligibility of encounter and make call to get means test indicator
 I VAFSTR[",13," S $P(VAFY,HLFS,13)=$S('$G(VAFERR):$$MTI^SCDXUTL0(VAFDFN,$P(VAFENODE,"^"),$P(VAFENODE,"^",13),$P(VAFENODE,"^",10),VAFENC),1:HLQ) ;Means Test Indicator
 ;
 ;- If MT Indicator not = code AN, C, or G, change number of dependents
 ;  to XX (not applicable)
 I VAFSTR[",11," I '$G(VAFERR) D
 . I $P(VAFY,HLFS,13)'="AN"&($P(VAFY,HLFS,13)'="C")&($P(VAFY,HLFS,13)'="G") S $P(VAFY,HLFS,11)="XX" ;Total Dependents not applicable for MT indicators AS,N,X,U
 ;
 I VAFSTR[",14," S X=$P(VAFNODE,"^",18),$P(VAFY,HLFS,14)=$S(X=0:"N",X=1:"Y",1:HLQ) ; Dependent child school indicator
 ;
QUIT Q "ZIR"_HLFS_$G(VAFY)
