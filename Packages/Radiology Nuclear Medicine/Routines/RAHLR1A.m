RAHLR1A ;HISC/GJC - Generate Common Order (ORM) Message ;11/10/99  10:42
 ;;5.0;Radiology/Nuclear Medicine;**47**;Mar 16, 1998;Build 21
 ;
 ;
 ;Integration Agreements
 ;----------------------
 ;$$GET1^DIQ(2056); ^DIWP(10011); NPFON^MAG7UFO(5021)
 ;$$ZDS^MAGDRAHL(5022); $$FMTHL7^XLFDT(10103); $$HLNAME^XLFNAME(3065)
 ;
 ;IA: 767 global read on ^DGSL(38.1,D0,0)
 ;calls to $$GET1^DIQ(44,IEN,.01) covered by IA: 10040
 ;calls to $$GET1^DIQ(4,IEN,.01) covered by IA: 10090
 ;
EN ;Called from RAHLR1; used to build the OBR, OBX, & ZDS segments
 ;The following key variables are defined in INIT^RAHLR1
 ;RAZRXAM=reg. exam zero node
 ;RAZXAM=exam zero node
 ;RAZDTE=9999999.9999-RADTI ;FM internal date/time
 ;RAZDAYCS:
 ;  IF SSAN SITE PARAMETER="Y" RAZDAYCS=SSAN  (sss-mmddyy-case#)
 ;  ELSE IF SSAN'="Y"          RAZDAYCS=DAY CASE# (mmddyy-case#)
 ;RAZORD=rad/nuc med order zero node
 ;RAZPROC=exam specific procedure
 ;
 ;Note: RAOBR(n+1) = OBR-'n' because our software begins
 ;building the segment with the segment header ('OBR')
 ;
 ;new some variables...
 N %,DN,FT,I,J,PI,PTR,X,Y,Z,RAX,RAXX
 ;Compile OBR Segment
 ;Set ID OBR-1
OBRPRC ;OBR segment
 S RAOBR(2)=1
 ;Placer Order Number OBR-2 site id-mmddyy-case#
 ;Filler Order Number OBR-3 site id-mmddyy-case#
 ; RAZDAYCS will be set to SSAN (site specific acc number) if the Site
 ; Acc Number division parameter (79,.131)=YES, else DAY CASE# format
 S (RAOBR(3),RAOBR(4))=RAZDAYCS
 S RAZCPT=$P(RAZPROC,U,9),RAZCPT(0)=$$NAMCODE^RACPTMSC(RAZCPT,DT)
 ;RAZCPT(0)=CPT code from file 81^short name of CPT code from file 81
 ;RAOBR(5)=CPT code #81_comp sep_CPT code short name #81_comp sep_"C4"
 ;         _comp sep_IEN file #71_comp sep_procedure name #71_comp sep_
 ;         "99RAP"
 ;
 S RAOBR(5)=$P(RAZCPT(0),U)_$E(HLECH)_$$ESCAPE^RAHLRU($P(RAZCPT(0),U,2))_$E(HLECH)_"C4"
 S RAOBR(5)=RAOBR(5)_$E(HLECH)_+$P(RAZXAM,U,2)_$E(HLECH)_$$ESCAPE^RAHLRU($P(RAZPROC,U))_$E(HLECH)_"99RAP"
 ;Priority OBR-5 (REQUEST URGENCY) 75.1;6
 S RAOBR(6)=$S($P(RAZORD,U,6)=1:"S",$P(RAZORD,U,6)=2:"A",1:"R")
 ;Specimen Source OBR-15 75.1;125 PROCEDURE MODIFIERS (mult: 75.1125)
 ;(left & right only)
 S RAZPMOD=$$SPECSRC^RAHLRU1(+$P(RAZXAM,U,11))
 S:$L(RAZPMOD) RAOBR(16)=$$REPEAT^RAHLRU1($E(HLECH),4)_$E(HLECH,4)_RAZPMOD
 ;
 ;Ordering Provider OBR-16 (REQUESTING PHYSICIAN) 75.1;14
 I $P(RAZORD,U,14),($$GET1^DIQ(200,$P(RAZORD,U,14),.01)'="") D
 .K RAZNME S RAZNME("FILE")=200,RAZNME("IENS")=$P(RAZORD,U,14)
 .S RAZNME("FIELD")=.01
 .S RAOBR(17)=$P(RAZORD,U,14)_$E(HLECH)_$$HLNAME^XLFNAME(.RAZNME,"S",$E(HLECH,1))
 .Q
 ;
 ;Call Back Phone numbers of Ordering Provider OBR-17 (mirrors ORC-14)
 D
 .N RAX,I,M S M="",I=0
 .D NPFON^MAG7UFO("RAX",$P(RAZORD,U,14))
 .F  S I=$O(RAX(I)) Q:'I  S M=M_$$ESCAPE^RAHLRU($G(RAX(I,1,1)))_$E(HLECH)_$G(RAX(I,2,1))_$E(HLECH)_$G(RAX(I,3,1))_$E(HLECH,2)
 .S:$L(M) RAOBR(18)=$E(M,1,$L(M)-1)
 ;
 ;Placer Field 1 OBR-18 site id-mmddyy-case# (mirrors OBR-2 & OBR-3)
 S RAOBR(19)=RAZDAYCS
 ;
 ;Placer Field 2 definition has been changed by a VistA Imaging request
 ;-> prior to 07/2007: inv. date/time of the exam concatenated to (by the
 ;  dash) the exam record IEN (Placer Fld 2 OBR-19 = Filler Fld 1 OBR-20)
 ;-> after 07/2007: case number
 ;RAZDAYCS=sss-mmddyy-case# OR mmddyy-case#
 S RAOBR(20)=$P(RAZDAYCS,"-",$L(RAZDAYCS,"-"))
 ;
 ;Filler Field 1 OBR-20 is defined as the site specific accession number:
 ;site id-mmddyy-case# Note: same value as OBR-18, OBR-2, & OBR-3
 ;(change effective 07/2007)
 S RAOBR(21)=RAZDAYCS
 ;
 ;Filler Field 2 OBR-21
 S RAOBR(22)=$$OBR21^RAHLRU(HLECH,RAZRXAM)
 ;
 ;Diagnostic Service Section ID OBR-24 MODALITY 71.0731 ptr to #73.1
 ;we capture modality data if there is only one sub-file record
 S RAZIEN=+$O(^RAMIS(71,+$P(RAZXAM,U,2),"MDL",0))
 I RAZIEN,(RAZIEN=$O(^RAMIS(71,+$P(RAZXAM,U,2),"MDL",$C(32)),-1)) D
 .S RAZMODAL=+$G(^RAMIS(71,+$P(RAZXAM,U,2),"MDL",RAZIEN,0))
 .S RAOBR(25)=$$ESCAPE^RAHLRU($P($G(^RAMIS(73.1,RAZMODAL,0)),U))
 .Q
 ;Quantity/Timing OBR-27.4 equates to SCHEDULED DATE (TIME optional)
 ; 75.1;23  Priority OBR-27.6 equates to REQUEST URGENCY of order 75.1;6
 ;Quantity/Timing OBR-27 (OBR-27 & ORC-7 share the same value)
 S RAOBR(28)=$$REPEAT^RAHLRU1($E(HLECH,1),3)_$$FMTHL7^XLFDT($P(RAZORD,U,23))_$$REPEAT^RAHLRU1($E(HLECH,1),2)_$S($P(RAZORD,U,6)=1:"S",$P(RAZORD,U,6)=2:"A",1:"R")
 ;
 ;Parent OBR-29 (OBR-29 & ORC-8 share the same value)
 S RAOBR(30)=$G(RAORC(9)) ;see PARENT^RAHLR1
 ;
 ;Transportation Mode OBR-30 75.1;19
 S RAZTMODE=$P(RAZORD,U,19)
 S RAOBR(31)=$S(RAZTMODE="a":"WALK",RAZTMODE="w":"WHLC",RAZTMODE="s":"CART",RAZTMODE="p":"PORT",1:"")
 ;Reason for Study OBR-31
 S $P(RAOBR(32),HLCS,2)=$S($L(RAZORD1):RAZORD1,1:"See Clinical History:")
 ;build the OBR segment
 D BLSEG^RAHLRU1("OBR",.RAOBR)
 ;build the ZDS segment
 D ZDS(RADTI,RACNI,RAZDAYCS)
 ;
OBXPRC ;Compile 'OBX' Segment for Procedure
 ;RAXX = Counter in segment 
 S (RAOBX(2),RAXX)=1
 S RAOBX(3)="CE",RAOBX(4)="P"_$E(HLECH)_"PROCEDURE"_$E(HLECH)_"L"
 S RAOBX(6)=$P(RAZXAM,U,2)_$E(HLECH)_$$ESCAPE^RAHLRU($P($G(^RAMIS(71,+$P(RAZXAM,U,2),0)),U))_$E(HLECH)_"L"
 S RAOBX(12)="O"
 D BLSEG^RAHLRU1("OBX",.RAOBX) K RAOBX
 ;
OBXPMOD ;Compile 'OBX' segment for procedure modifiers
 S RAOBX(2)=$G(RAXX)
 S RAOBX(3)="TX",RAOBX(4)="M"_$E(HLECH)_"MODIFIERS"_$E(HLECH)_"L"
 S RAOBX(12)="O",(I,J)=0
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",I)) Q:'I  D
 .S PTR=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",I,0))
 .S J=J+1,RAOBX(2)=RAXX+J,RAOBX(6)=$$ESCAPE^RAHLRU($P($G(^RAMIS(71.2,PTR,0)),U))
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .Q
 S RAXX=RAOBX(2)
 K RAOBX
 ;
OBXCPTM ;Compile 'OBX' segment for CPT modifiers
 S RAOBX(2)=$G(RAXX)
 S RAOBX(3)="CE",RAOBX(4)="C4"_$E(HLECH)_"CPT MODIFIERS"_$E(HLECH)_"L"
 S RAOBX(12)="O",(I,J)=0
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",I)) Q:'I  D
 .S PTR=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",I,0))
 .S J=J+1,RAOBX(2)=RAXX+J,RAOBX(6)=$$CPTMOD^RAHLRU(PTR,HLECH,DT)
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 S RAXX=RAOBX(2)
 K RAOBX,RAZCPTM
 ;
OBXHIST ;Compile 'OBX' Segment for Clinical History
 I $L(RAZORD1) D  ;add Reason for Study as a prefix
 .S RAXX=RAXX+1,RAOBX(2)=RAXX,RAOBX(3)="TX"
 .S RAOBX(4)="H"_$E(HLECH)_"HISTORY"_$E(HLECH)_"L",RAOBX(12)="O"
 .S RAOBX(6)="Reason for Study: "_$$ESCAPE^RAHLRU($G(RAZORD1))
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .S RAXX=RAXX+1,RAOBX(2)=RAXX,RAOBX(3)="TX"
 .S RAOBX(4)="H"_$E(HLECH)_"HISTORY"_$E(HLECH)_"L",RAOBX(12)="O"
 .S RAOBX(6)=" "  ;blank line to separate Reason For Study & Clin Hist
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .Q
 I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",0)) D
 .S RAOBX(2)=$G(RAXX),RAOBX(3)="TX"
 .S RAOBX(4)="H"_$E(HLECH)_"HISTORY"_$E(HLECH)_"L"
 .;accumulate data into ^UTILITY($J,"W")...
 .K ^UTILITY($J,"W")
 .S DIWF="",DIWR=80,(DIWL,RADIWL)=1,RAI=0
 .F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAI)) Q:'RAI  D
 ..S X=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAI,0)) D ^DIWP
 ..Q
 .;build the OBX segment from the data in ^UTILITY($J,"W")...
 .S (I,J)=0,RAOBX(12)="O"
 .F  S I=$O(^UTILITY($J,"W",RADIWL,I)) Q:'I  D
 ..S J=J+1,RAOBX(2)=RAXX+J
 ..S RAOBX(6)=$$ESCAPE^RAHLRU($G(^UTILITY($J,"W",RADIWL,I,0)))
 ..D BLSEG^RAHLRU1("OBX",.RAOBX)
 ..Q
 .S RAXX=RAOBX(2)
 .Q
 K DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,RADIWL,RAI,RAOBX,^UTILITY($J,"W")
 ;
OBXALL ;Compile 'OBX' Segment for Allergies
 N DFN S DFN=RADFN D ALLERGY^RADEM
 S RAOBX(2)=$G(RAXX)
 S RAOBX(3)="TX",RAOBX(4)="A"_$E(HLECH)_"ALLERGIES"_$E(HLECH)_"L"
 S RAOBX(12)="O",(I,J)=0
 I $D(GMRAL)#2 D 
 .F  S I=$O(PI(I)) Q:'I  D
 ..S J=J+1,FT=PI(I),RAOBX(2)=RAXX+J,RAOBX(6)=$$ESCAPE^RAHLRU(FT)
 ..D BLSEG^RAHLRU1("OBX",.RAOBX)
 .S RAXX=RAOBX(2)
 K RAOBX
 ;
OBXTCOM ;Compile 'OBX' segment for tech comments
 S RAOBX(2)=$G(RAXX)
 S RAOBX(3)="TX",RAOBX(4)="TCM"_$E(HLECH)_"TECH COMMENT"_$E(HLECH)_"L"
 S RAOBX(12)="O",(I,J)=0
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",I)) Q:'I  D
 .S J=J+1,FT=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",I,"TCOM"))
 .S RAOBX(2)=RAXX+J,RAOBX(6)=$$ESCAPE^RAHLRU(FT)
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .Q
EXIT ;clean up symbol table are return to RAHLR1
 K RAOBX,RAXX,GMRAL,RAOBR,RAZCPT,RAZDIV,RAZIEN,RAZILOC,RAZITYPE,RAZMODAL
 K RAZNME,RAZPHONE,RAZPMOD,RAZTMODE
 Q
 ;
ZDS(RADTI,RACNI,RAZDAYCS) ;Compile the 'ZDS' segment
 ;Input: RADTI-inverse date/time of the examination
 ;       RACNI-IEN of the examination record
 ;       RAZDAYCS-If SSAN parameter="Y",  SSAN format:  sss-mmddyy-case#
 ;               -If SSAN'="Y" day & case# of exam, format: mmddyy-case#
 ;Note: 'ZDS^MAGDRAHL' depends on the HLECH array being defined
 ;
 ;If the exam has a Study Instance UID defined [^DD(70.03,81)] use that
 ; value to build the ZDS segment
 ;If the exam does not have a Study Instance UID defined, i.e. it was
 ; created before the code to build the SIUID field, then build the
 ; SIUID on the fly here and use that value in the ZDS segment
 ;
 N I F I=1:1:$L(HLECH) S HLECH(I)=$E(HLECH,I)
 ;
 ;If exam has an SIUID defined use it
 S RASIUID=$$GETSIUID^RAAPI(RADFN,RADTI,RACNI) I RASIUID'="" D  Q
 .S HLA("HLS",$$RTNSUB^RAHLRU1()+1)=$$ZDS^MAGDRAHL(RASIUID)
 .F I=$O(HLECH($C(32)),-1):-1:1 K HLECH(I) ;kill array elements
 ;
 ;If exam does not have an SIUID defined build it here on the fly
 I RASIUID="" D
 .S RASIUID=$$STUDYUID^MAGDRAHL(RADTI,RACNI,RAZDAYCS)
 .S HLA("HLS",$$RTNSUB^RAHLRU1()+1)=$$ZDS^MAGDRAHL(RASIUID)
 F I=$O(HLECH($C(32)),-1):-1:1 K HLECH(I) ;kill array elements
 Q
