DGPTFUT ;WOIFO/PLT,HIOFO/FT,WIOFO/PMK - PTF UTILITIES WITH API - ICR #6130  ;05/04/15 10:07am
 ;;5.3;Registration;**884**;Aug 13, 1993;Build 31
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;direct entry not allowed
 QUIT
 ;
 ;dga=401, 501, 601, 701 or 801 of multiple fields of file #45 - ^dgpt
 ;dgb=ien of file #45 - ^dgpt
 ;.dgc=return values, initialized with kill, dgc(0)= discharge date for dga=701
 ;                dgc(ien)= 401 sugery/procedure date, 501 movement date
 ;                          601 procedure date, 701 discharge date
 ;                          801 cpt record date/time
PTFIEN(DGA,DGB,DGC) ;get the ien's for 701,401,501,601,801 and recd dt/time
 K DGC
 N A,B,C
 I DGA=701 S DGC(0)=$P($G(^DGPT(DGB,70)),U) QUIT
 S A=$S(DGA=401:"S",DGA=501:"M",DGA=601:"P",DGA=801:"C",1:"") QUIT:A=""
 ;the piece # of the record date/time
 S C=1 S:DGA=501 C=10
 S B=0 F  S B=$O(^DGPT(DGB,A,B)) QUIT:'B  S DGC(B)=$P($G(^(B,0)),U,C)
 QUIT
 ;
 ;dga=401, 501, 601, 701 or 801
 ;dgb=ien of file #45 - ptf
 ;dgc=ien of field multiple 401, 501, 601,801, nil if dga=701
 ;.dgd=return values, initialized with kill, dgd=^1 to ^15 demographic data, see tag 101
 ;                        ^16 rec date/time^17 405 ien if dga=501
 ; dgd(0)=prin dia ien^prin poa^icd code^poa external if dga=7/801
 ; dgd(1)=ien of icd1^poa1 internal^icd code^poa external, dgd(2)=...
 ; dgd(25)=ien of icd25^poa25 internal^icd code^poa external
 ; dgd(#) is undef if icd nil
 ;dge=1 for dgd(#,1)=short description, dgd(2,1)...,dgd(25,1)
 ; dge=2 dgd(1,2)=long description, dgd(2,2)...,dgd(25,2)
 ; dge=3 for both dgd(1,1) and dgd(1,2)..., dgd(25,1) and dgd(25,2)
PTFICD(DGA,DGB,DGC,DGD,DGE) ;get icd/poa/description of file #45
 K DGD
 S DGD=$$101(DGB) S:$P(DGD,U,2) $P(DGD,U,12)=$$GETLABEL^DGPTIC10($P(DGD,U,11),$S(DGA=701!(DGA=501):"D",DGA=401!(DGA=601):"P",1:""))
 D @DGA
 QUIT
 ;
 ;
 ;ptf=ien of file #45
 ;value= ^1 patient name^2 patient ien^3 adm dt^4 fac^5 fee basis
 ; ^6 status^7 type record^8 ptf ien generating this census rec
 ; ^9 census date ptr^10 discharge date^11 effective date
 ; ^12 icd label if from tag ptficd
101(PTF) ;ef= value of ptf demographic data
 N A,B,C,D
 QUIT:'PTF ""  QUIT:'$D(^DGPT(PTF)) ""
 S A=^DGPT(PTF,0),B=$G(^(70))
 S C=$$GET7DATE^DGPTIC10(PTF)
 S D=$P(^DPT(+A,0),U)_U_$P(A,U,1,4),$P(D,U,6)=$P(A,U,6)_U_$P(A,U,11)_U_$P(A,U,12)_U_$P(A,U,13)_U_$P(B,U)_U_C
 QUIT D
 ;
 ;
401 ;401 multiple operation icd
 N A,B,C
 QUIT:'$D(^DGPT(DGB,"S",DGC,0))  S A=^(0),B=$G(^(1)),$P(DGD,U,16)=$P(A,U)
 F C=8:1:27 S:$P(A,U,C)]"" DGD(C-7)=$P(A,U,C)_U_U_$$ICDCODE(80.1,$P(A,U,C))
 F C=1:1:5 S:$P(B,U,C)]"" DGD(C+20)=$P(B,U,C)_U_U_$$ICDCODE(80.1,$P(B,U,C))
 I $G(DGE) D DOPDES(80.1)
 QUIT
 ;
 ;
501 ;501 multiple - movement icd/poa
 N A,B,C,D
 QUIT:'$D(^DGPT(DGB,"M",DGC,0))  S A=^(0),B=$G(^(81)),C=$G(^(82)),$P(DGD,U,16)=$P(A,U,10)
 F D=5:1:9 S:$P(A,U,D)]"" DGD(D-4)=$P(A,U,D)_U_$P(C,U,D-4)_U_$$ICDCODE(80,$P(A,U,D))_U_$S($P(C,U,D-4)]"":$$EXTERNAL^DILFD(45.02,82.01,"",$P(C,U,D-4)),1:"")
 F D=11:1:15 S:$P(A,U,D)]"" DGD(D-5)=$P(A,U,D)_U_$P(C,U,D-5)_U_$$ICDCODE(80,$P(A,U,D))_U_$S($P(C,U,D-5)]"":$$EXTERNAL^DILFD(45.02,82.01,"",$P(C,U,D-5)),1:"")
 F D=1:1:15 S:$P(B,U,D)]"" DGD(D+10)=$P(B,U,D)_U_$P(C,U,D+10)_U_$$ICDCODE(80,$P(B,U,D))_U_$S($P(C,U,D+10)]"":$$EXTERNAL^DILFD(45.02,82.01,"",$P(C,U,D+10)),1:"")
 I $G(DGE) D DOPDES(80)
 QUIT
 ;
 ;
601 ;601 multiple - procedure icd
 N A,B,C
 QUIT:'$D(^DGPT(DGB,"P",DGC,0))  S A=^(0),B=$G(^(1)),$P(DGD,U,16)=$P(A,U)
 F C=5:1:24 S:$P(A,U,C)]"" DGD(C-4)=$P(A,U,C)_U_U_$$ICDCODE(80.1,$P(A,U,C))
 F C=1:1:5 S:$P(B,U,C)]"" DGD(C+20)=$P(B,U,C)_U_U_$$ICDCODE(80.1,$P(B,U,C))
 I $G(DGE) D DOPDES(80.1)
 QUIT
 ;
 ;
701 ;primary and secondary diagnosis icd/poa
 N A,B,C,D,E
 QUIT:'$D(^DGPT(DGB,0))  S A=$G(^(70)),B=$G(^(71)),C=$G(^(82))
 S E=$P(A,U,10) S:E="" E=$P(A,U,11)
 S:E]"" DGD(0)=E_U_$P(C,U,1)_U_$$ICDCODE(80,E)_U_$S($P(C,U,1)]"":$$EXTERNAL^DILFD(45,82.01,"",$P(C,U,1)),1:"")
 F D=16:1:24 S:$P(A,U,D)]"" DGD(D-15)=$P(A,U,D)_U_$P(C,U,D-14)_U_$$ICDCODE(80,$P(A,U,D))_U_$S($P(C,U,D-14)]"":$$EXTERNAL^DILFD(45,82.02,"",$P(C,U,D-14)),1:"")
 F D=1:1:15 S:$P(B,U,D)]"" DGD(D+9)=$P(B,U,D)_U_$P(C,U,D+10)_U_$$ICDCODE(80,$P(B,U,D))_U_$S($P(C,U,D+10)]"":$$EXTERNAL^DILFD(45,82.02,"",$P(C,U,D+10)),1:"")
 I $G(DGE) D DOPDES(80)
 QUIT
 ;
 ;
801 ;801 multiple - cpt code
 N A
 QUIT:'$D(^DGPT(DGB,"C",DGC,0))  S A=^(0)
 S:$P(A,U,4)]"" DGD(0)=$P(A,U,4)_U_U_$$ICDCODE(80,$P(A,U,4))
 I $G(DGE) D DOPDES(80)
 QUIT
 ;
 ;
 ;dga=80 or 80.1
DOPDES(DGA) ;set diag,oper and procet short/long description in dgd array
 N DGB
 S DGB="" F  S DGB=$O(DGD(DGB)) QUIT:DGB=""  S:"13"[DGE DGD(DGB,1)=$$ICDDES(DGA,+DGD(DGB),$P(DGD,U,11),1) S:"23"[DGE DGD(DGB,2)=$$ICDDES(DGA,+DGD(DGB),$P(DGD,U,11),2)
 ;
 ;
 ;
 ;a= file #80 or #80.1
 ;b=ien
ICDCODE(A,B) ;ef icd code or nil
 N C
 S C=$$CODEC^ICDEX(A,B)
 QUIT $S(C=-1:"",1:C)
 ;
 ;
 ;dgfn=80 for icd, 80.1 for opration/procedure
 ;dgien=ien of dgfn
 ;dgedt=effective date
 ;a=1 for short description, 2=long
ICDDES(DGFN,DGIEN,DGEDT,A) ;ef= file 80 or 80.1 code description
 QUIT:A=1 $$VST^ICDEX(DGFN,DGIEN,DGEDT)
 QUIT $$VLT^ICDEX(DGFN,DGIEN,DGEDT)
 ;
 ;
STR401(DG0,DG1) ; Builds 25 piece string with OPERATION codes
 ; DG0 = file 45 ien
 ; DG1 = ien of 401 multiple
 ; Returns a string of 25 pieces containing the OPERATION codes
 N DG401,DG401A,DGLOOP,DGSTRING
 S DG0=$G(DG0),DG1=$G(DG1)
 I 'DG0!'DG1 Q ""
 S DG401=$G(^DGPT(DG0,"S",DG1,0)),DG401A=$G(^DGPT(DG0,"S",DG1,1)),DGSTRING=""
 F DGLOOP=8:1:27 S $P(DGSTRING,U,DGLOOP-7)=$P(DG401,U,DGLOOP)
 F DGLOOP=1:1:5 S $P(DGSTRING,U,DGLOOP+20)=$P(DG401A,U,DGLOOP)
 Q DGSTRING
 ;
STR501(DG0,DG1) ; Builds 25 piece string with MOVEMENT codes
 ; DG0 = file 45 ien
 ; DG1 = ien of 501 multiple
 ; Returns a string of 25 pieces containing the MOVEMENT codes
 N DG501,DG501A,DGLOOP,DGSTRING
 S DG0=$G(DG0),DG1=$G(DG1)
 I 'DG0!'DG1 Q ""
 S DG501=$G(^DGPT(DG0,"M",DG1,0)),DG501A=$G(^DGPT(DG0,"M",DG1,81)),DGSTRING=""
 F DGLOOP=5:1:9 S $P(DGSTRING,U,DGLOOP-4)=$P(DG501,U,DGLOOP)
 F DGLOOP=11:1:15 S $P(DGSTRING,U,DGLOOP-5)=$P(DG501,U,DGLOOP)
 F DGLOOP=1:1:15 S $P(DGSTRING,U,DGLOOP+10)=$P(DG501A,U,DGLOOP)
 Q DGSTRING
 ;
STR601(DG0,DG1) ; Builds 25 piece string with PROCEDURE codes
 ; DG0 = file 45 ien
 ; DG1 = ien of 601 multiple
 ; Returns a string of 25 pieces containing the PROCEDURE codes
 N DG601,DG601A,DGLOOP,DGSTRING
 S DG0=$G(DG0),DG1=$G(DG1)
 I 'DG0!'DG1 Q ""
 S DG601=$G(^DGPT(DG0,"P",DG1,0)),DG601A=$G(^DGPT(DG0,"P",DG1,1)),DGSTRING=""
 F DGLOOP=5:1:24 S $P(DGSTRING,U,DGLOOP-4)=$P(DG601,U,DGLOOP)
 F DGLOOP=1:1:5 S $P(DGSTRING,U,DGLOOP+20)=$P(DG601A,U,DGLOOP)
 Q DGSTRING
 ;
STR701(DG0) ; Builds 25 piece string with DIAGNOSTIC codes
 ; DG0 = file 45 ien
 ; Returns a string of 25 pieces containing the 701 codes. First piece is principal DX
 N DG701,DG701A,DGLOOP,DGSTRING
 S DG0=$G(DG0)
 I 'DG0 Q ""
 S DG701=$G(^DGPT(DG0,70)),DG701A=$G(^DGPT(DG0,71)),DGSTRING="",$P(DGSTRING,U,1)=$P(DG701,U,10)
 F DGLOOP=16:1:24 S $P(DGSTRING,U,DGLOOP-14)=$P(DG701,U,DGLOOP)
 F DGLOOP=1:1:15 S $P(DGSTRING,U,DGLOOP+10)=$P(DG701A,U,DGLOOP)
 Q DGSTRING
 ;
STR701P(DG0) ; Builds 25 piece string with 701 Present On Admission (POA) codes
 ; DG0 = file 45 ien
 ; Returns a string of 25 pieces containing the 701 POA codes
 N DG82,DGLOOP,DGSTRING
 S DG0=$G(DG0)
 I 'DG0 Q ""
 S DG82=$G(^DGPT(DG0,82)),DGSTRING=""
 F DGLOOP=1:1:25 S $P(DGSTRING,U,DGLOOP)=$P(DG82,U,DGLOOP)
 Q DGSTRING
 ;
STR501P(DG0,DG1) ; Builds 25 piece string with 501 Present On Admission (POA) codes
 ; DG0 = file 45 ien
 ; DG1 = ien of 501 multiple
 ; Returns a string of 25 pieces containing the 501 POA codes
 N DG82,DGLOOP,DGSTRING
 S DG0=$G(DG0),DG1=$G(DG1)
 I 'DG0!'DG1 Q ""
 S DG82=$G(^DGPT(DG0,"M",DG1,82)),DGSTRING=""
 F DGLOOP=1:1:25 S $P(DGSTRING,U,DGLOOP)=$P(DG82,U,DGLOOP)
 Q DGSTRING
 ;
