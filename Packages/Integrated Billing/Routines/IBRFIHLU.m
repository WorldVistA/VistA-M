IBRFIHLU ;TDM/DAL - HL7 Utilities ;24-AUG-2015  ; 1/8/16 1:14pm
 ;;2.0;INTEGRATED BILLING;**547**;21-MAR-94;Build 119
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
HLP(PROTOCOL) ;  Find the Protocol IEN
 Q +$O(^ORD(101,"B",PROTOCOL,0))
 ;
NAME(NM) ;  Convert a name that isn't in standard VISTA format -
 NEW LNM,FNM,MI
 ;
 I NM?." " Q NM
 ;  LastName,FirstName MI
 I NM["," Q NM
 ;
 ; Remove double-spaces from name
 F  Q:$L(NM,"  ")<2  S NM=$P(NM,"  ",1)_" "_$P(NM,"  ",2,9999)
 ;
 ; Trim leading/trailing spaces
 S NM=$$TRIM^XLFSTR(NM)
 ;
 ; Find number of spaces in name
 S II=$L(NM," ")
 ;
 I II>3 Q NM
 I II=3 S FNM=$P(NM," ",1),MI=" "_$P(NM," ",2),LNM=$P(NM," ",3)
 I II=2 S FNM=$P(NM," ",1),LNM=$P(NM," ",2),MI=""
 I II<2 Q NM
 Q LNM_","_FNM_MI
 ;
SPAR     ;  Segment Parsing
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
 S ISCT="",II=0,IS=0
 F  S ISCT=$O(^TMP($J,"IBRFIHLI",HCT,ISCT)) Q:ISCT=""  D
 . S IS=IS+1
 . S ISDATA(IS)=$G(^TMP($J,"IBRFIHLI",HCT,ISCT))
 . I $E(ISDATA(IS),1)=$C(10) S ISDATA(IS)=$E(ISDATA(IS),2,($L(ISDATA(IS))))    ;Strip out Line Feed
 . I $O(^TMP($J,"IBRFIHLI",HCT,ISCT))="" S ISDATA(IS)=ISDATA(IS)_HLFS
 . S ISPEC(IS)=$L(ISDATA(IS),HLFS)
 ;
 S IM=0,LSDATA=""
LP S IM=IM+1 Q:IM>IS
 S LSDATA=LSDATA_ISDATA(IM),NPC=ISPEC(IM)
 F IJ=1:1:NPC-1 D
 . S II=II+1,IBSEG(II)=$$CLNSTR($P(LSDATA,HLFS,IJ),$E(HL("ECH"),1,2)_$E(HL("ECH"),4),$E(HL("ECH")))
 S LSDATA=$P(LSDATA,HLFS,NPC)
 G LP
CLNSTR(STRING,CHARS,SUBSEP)      ; Remove extra trailing components and subcomponents in the HL7 seg
 ;
 N NUMPEC,PEC,RTSTRING
 ;
 S RTSTRING=$$RTRIMCH(STRING,CHARS)
 ; Now we have string w/o trailing chars, remove from subs
 S NUMPEC=$L(RTSTRING,SUBSEP)
 F PEC=1:1:NUMPEC S $P(RTSTRING,SUBSEP,PEC)=$$RTRIMCH($P(RTSTRING,SUBSEP,PEC),CHARS)
 Q RTSTRING
 ;
RTRIMCH(STR,CHRS) ; Remove the trailing chars from string
 ;
 N R,L
 ;
 S L=1,CHRS=$G(CHRS," ")
 F R=$L(STR):-1:1 Q:CHRS'[$E(STR,R)
 I L=R,(CHRS[$E(STR)) S STR=""
 Q $E(STR,L,R)
