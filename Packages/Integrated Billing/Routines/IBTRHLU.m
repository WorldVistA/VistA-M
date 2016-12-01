IBTRHLU ;ALB/JWS - Receive and store 278 Response message ;05-JUN-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
SPAR ; **Segment Parsing
 ;
 ; This tag will parse the current segment referenced by the HCT index
 ; and place the results in the IBSEG array.
 ;
 ; Input Variables
 ; HCT
 ;
 ; Output Variables
 ; IBSEG (ARRAY of fields in segment)
 ;
 N II,IJ,IK,IM,IS,ISBEG,ISCT,ISDATA,ISEND,ISPEC,LSDATA,NPC
 ;
 ;Reset IBSEG
 K IBSEG
 ;
 S ISCT="",II=-1,IS=0
 F  S ISCT=$O(^TMP($J,"IBTRHLI",HCT,ISCT)) Q:ISCT=""  D
 . S IS=IS+1
 . S ISDATA(IS)=$G(^TMP($J,"IBTRHLI",HCT,ISCT))
 . I $O(^TMP($J,"IBTRHLI",HCT,ISCT))="" S ISDATA(IS)=ISDATA(IS)_HLFS
 . S ISPEC(IS)=$L(ISDATA(IS),HLFS)
 . Q
 S IM=0,LSDATA=""
LP ;**
 S IM=IM+1 Q:IM>IS
 S LSDATA=LSDATA_ISDATA(IM),NPC=ISPEC(IM)
 F IJ=1:1:NPC-1 D
 . S II=II+1,IBSEG(II)=$$CLNSTR($P(LSDATA,HLFS,IJ),$E(HL("ECH"),1,2)_$E(HL("ECH"),4),$E(HL("ECH")))
 . I II=0,IBSEG(0)="MSH" S II=II+1,IBSEG(1)="|"
 S LSDATA=$P(LSDATA,HLFS,NPC)
 G LP
CLNSTR(STRING,CHARS,SUBSEP) ;** Remove extra trailing components and subcomponents in the HL7 seg
 N NUMPEC,PEC,RTSTRING
 S RTSTRING=$$RTRIMCH(STRING,CHARS)
 ; Now we have string w/o trailing chars, remove from subs
 S NUMPEC=$L(RTSTRING,SUBSEP)
 F PEC=1:1:NUMPEC S $P(RTSTRING,SUBSEP,PEC)=$$RTRIMCH($P(RTSTRING,SUBSEP,PEC),CHARS)
 Q RTSTRING
 ;
RTRIMCH(STR,CHRS) ;** Remove the trailing chars from string
 N R,L
 S L=1,CHRS=$G(CHRS," ")
 F R=$L(STR):-1:1 Q:CHRS'[$E(STR,R)
 I L=R,(CHRS[$E(STR)) S STR=""
 Q $E(STR,L,R)
 ;
