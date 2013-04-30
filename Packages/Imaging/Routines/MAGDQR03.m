MAGDQR03 ;WOIFO/EdM/JSL/SAF - Imaging RPCs for Query/Retrieve ; 17 Feb 2010 11:18 AM
 ;;3.0;IMAGING;**51,54,66,123**;Mar 19, 2002;Build 67;Jul 24, 2012
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
 ; When RESULT^MAGDQR03 is called, the following input parameters
 ; should be properly defined:
 ;   TYPE   = R(adiology) or C(onsult)
 ;   RESULT = pointer into results global (#2006.5732)
 ;   MAGIEN = pointer into the Image File (#2005)
 ;   MAGDFN = pointer into the Patient File (#2)
 ;   MAGRORD = second level pointer into the Rad/Nuc Med Patient File (#70)
 ;             (Radiology orders only)
 ;   MAGINTERP = third level pointer into the Rad/Nuc Med Patient File (#70)
 ;             (Radiology orders only) 
 ; 
 ; This routine contains code to calculate values for DICOM Tags
 ; that can be derived from those two pointers.
 ; All other DICOM Tags are computed in MAGDQR06.
 ; (This routine does the things that are the same for all images.
 ; MAGDQR06 differentiates between Radiology, Consults, and anything else.)
 ;
RESULT(TYPE,RESULT,MAGIEN,MAGDFN,MAGRORD,MAGINTERP) ;
 ; validate input parameters
 I "^R^C^"'[("^"_TYPE_"^") D ERR^MAGDQR01("Study type (radiology/consult) not defined") Q
 I '$G(RESULT) D ERR^MAGDQR01("Invalid query result set "_RESULT_" specified") Q
 I $D(MAGIEN),$D(^MAG(2005,MAGIEN))
 E  D ERR^MAGDQR01("Invalid image ID "_MAGIEN_" specified for result") Q
 I $D(MAGDFN),$D(^DPT(MAGDFN))
 E  D ERR^MAGDQR01("Invalid patient ID "_MAGDFN_" specified for result") Q
 I TYPE="R",'$G(MAGRORD) D  Q
 . D ERR^MAGDQR01("Invalid Radiology order number "_MAGRORD_" specified")
 . Q
 I TYPE="R",'$G(MAGINTERP) D  Q
 . D ERR^MAGDQR01("Invalid Radiology interpretation "_MAGINTERP_" specified")
 . Q
 ;
 N E,L,OK,V,X,T
 N SENSEMP ; ----- sensitive/employee flag
 N ACCESSION ; --- accession number
 S SENSEMP=0,OK=1
 ;
 ; new specs for sens/emp patients 3/20/09 - data will be picked up, but scrubbed
 ;
 S SENSEMP=SENSEMP+($$EMPL^DGSEC4(MAGDFN)=1) ; IA #3646
 S SENSEMP=SENSEMP+($P($G(^DGSL(38.1,MAGDFN,0)),"^",2)=1) ; IA #767
 S SENSEMP=0 ; sensitive/employee data suppression to be suspended as of Jan 2010
 ; increment (static) dummy Study Instance UID if sensitive/employee
 S:SENSEMP ^("DUMMY SIUID")=^TMP("MAG",$J,"DICOMQR","DUMMY SIUID")+1
 ;
 ; calculate accession number here 2/17/10, moved from Q0080050^MAGDQR06
 ;
 D:TYPE="R"
 . S X=$P($G(^RADPT(MAGDFN,"DT",MAGRORD,"P",MAGINTERP,0)),"^",17) ; IA # 1172
 . S ACCESSION=$P($G(^RARPT(+X,0)),"^",1) ; IA # 1171
 . Q
 D:TYPE="C"
 . N R2,TIUNUM,CONSIX
 . S R2=$G(^MAG(2005,MAGIEN,2)) Q:R2=""
 . I $P(R2,"^",6)=2006.5839 D  Q
 . . S CONSIX=$P(R2,"^",7)
 . . S ACCESSION="GMRC-"_CONSIX
 . . Q
 . I $P(R2,"^",6)=8925 D  Q
 . . S TIUNUM=$P(R2,"^",7) Q:'TIUNUM
 . . S CONSIX=$P($G(^TIU(8925,TIUNUM,14)),"^",5)
 . . S:$P(CONSIX,";",2)="GMR(123," ACCESSION="GMRC-"_$P(CONSIX,";",1)
 . . Q
 . Q
 ;
 ; retrieve element values, indicate unsupported elements
 S T="" F  S T=$O(REQ(T)) Q:T=""  D
 . S L=$TR(T,",")
 . S E=$TR($E(L,1),"0123456789abcdef","QRSTUVWXYZABCDEF")
 . S $E(L,1)=E S:L'?8UN L=""
 . I L'="",$T(@L)'="" D @L S V(T)=$G(V(T)) Q
 . ; unsupported tag <> fatal error
 . D ERR^MAGDQR01("Cannot calculate value for tag: """_T_""".") S ERROR=0
 . Q
 ;
 I ERROR D ERRSAV^MAGDQR01 S FATAL=1 Q
 ;
 Q:'OK  ; don't return result on key mismatch
 ;
 D  Q:'OK  ; There must be a valid Study Instance UID
 . N V,T
 . S T="0020,000D" D Q020000D
 . S OK=(V(T)'="")
 . Q
 ;
 S ^("RESULTSET")=^TMP("MAG",$J,"DICOMQR","RESULTSET")+1
 D
 . N RSLTHDR,R1,V1,V2,VAL
 . S RSLTHDR="0000,0902^Result # "_^TMP("MAG",$J,"DICOMQR","RESULTSET")
 . S R1=$O(^MAGDQR(2006.5732,RESULT,1," "),-1)+1
 . S ^MAGDQR(2006.5732,RESULT,1,R1,0)=RSLTHDR
 . S VAL=$G(^MAG(2005,MAGIEN,2))\1
 . S ^TMP("MAG",$J,"QR",99,VAL_" "_MAGDFN,R1)=MAGIEN
 . S T="" F  S T=$O(V(T)) Q:T=""  D
 . . S VAL=$G(V(T))
 . . S V1="" F  S V1=$O(V(T,V1)) Q:V1=""  D
 . . . Q:$G(V(T,V1))=""
 . . . S:VAL'="" VAL=VAL_"\" S VAL=VAL_V(T,V1)
 . . . Q
 . . S R1=R1+1,^MAGDQR(2006.5732,RESULT,1,R1,0)=T_"^"_VAL
 . . S ^MAGDQR(2006.5732,RESULT,1,"B",T,R1)=""
 . . Q:$D(V(T))<10
 . . S V1="" F  S V1=$O(V(T,V1)) Q:V1=""  D
 . . . S V2="" F  S V2=$O(V(T,V1,V2)) Q:V2=""  D
 . . . . S VAL=$G(V(T,V1,V2)) Q:VAL=""
 . . . . S R1=R1+1,^MAGDQR(2006.5732,RESULT,1,R1,0)=T_"^"_VAL
 . . . . S ^MAGDQR(2006.5732,RESULT,1,"B",T,R1)=""
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
COMPARE(TAG,ACTUAL) N LOC,TMP,WILD
 Q:'$G(REQ(TAG)) 1
 S WILD=$G(REQ(TAG,1)) Q:WILD="" 0
 Q:$G(ACTUAL)="" 0
 S LOC(ACTUAL)=""
 Q $$MATCHD(WILD,"LOC(LOOP)","TMP(LOOP)")
 ;
MATCH1(X,Y) N I,M
 F  Q:X=""  Q:Y=""  D
 . I $E(X,1)=$E(Y,1) S X=$E(X,2,$L(X)),Y=$E(Y,2,$L(Y)) Q
 . I $E(Y,1)="?" S X=$E(X,2,$L(X)),Y=$E(Y,2,$L(Y)) Q
 . I $E(Y,1)="*" D  Q:M
 . . I Y="*" S (X,Y)="",M=1 Q
 . . S Y=$E(Y,2,$L(Y)),M=0
 . . F I=1:1:$L(X) I $$MATCH1($E(X,I,$L(X)),Y) S M=1,X=$E(X,I,$L(X)) Q
 . . Q
 . S X="!",Y=""
 . Q
 S:$TR(Y,"*")="" Y="" Q:X'="" 0 Q:Y'="" 0
 Q 1
 ;
MATCHD(WILDCARD,STRUCTUR,FOUND) N C,LOOP,L1,L9,SEEK,X,Y
 ;  -- Scans a structure,
 ;     reports entries in @STRUCTUR that match WILDCARD;
 ;     the result is reported in local array @FOUND
 S C=0
 S L1=$P($P(WILDCARD,"?",1),"*",1),L9=L1_"~"
 I L1=WILDCARD D  Q C
 . S LOOP=L1
 . I $D(@STRUCTUR) S @FOUND="",C=C+1 Q
 . Q
 S LOOP=L1 F  D  S LOOP=$O(@STRUCTUR) Q:LOOP=""  Q:LOOP]]L9
 . Q:LOOP=""  Q:'$D(@STRUCTUR)
 . Q:'$$MATCH1(LOOP,WILDCARD)
 . S @FOUND="",C=C+1
 . Q
 Q C
 ;
Q0080018 ;U Image Instance UID
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="1.2.840.113754.2.1.3.1.1.1.1.66."_$G(^TMP("MAG",$J,"DICOMQR","DUMMY SIUID"))
 . Q
 ; no
 N SOPUID
 I MAGIEN="" S V(T)="" Q
 S V(T)=$P($G(^MAG(2005,MAGIEN,"PACS")),"^",1)
 S SOPUID=$P($G(^MAG(2005,MAGIEN,"SOP")),"^",2)
 S:SOPUID'="" V(T)=SOPUID
 Q
 ;
Q0080020 ;R Study Date
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I,REQDT S I=$O(REQ(T,"")) S:I REQDT=$TR($P($G(REQ(T,I)),"-",1),"*")
 . S V(T)=$S($G(REQDT)?8N:REQDT,1:$$DT^XLFDT+17000000)
 . Q
 ; no
 I MAGIEN="" S V(T)="" Q
 S V(T)=$P($G(^MAG(2005,MAGIEN,2)),"^",5)\1+17000000
 Q
 ;
Q0080030 ;R  Study Time
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I,REQTM S I=$O(REQ(T,"")) S:I REQTM=$TR($P($G(REQ(T,I)),"-",1),"*")
 . S V(T)=$S($G(REQTM)?6N:REQTM,1:$E($P($$NOW^XLFDT,".",2)_"000000",1,6))
 . Q
 ; no
 I MAGIEN="" S V(T)="" Q
 S V(T)=$TR($J("."_$P($P($G(^MAG(2005,MAGIEN,2)),"^",5),".",2)*1E6,6)," ",0)
 Q
 ;
Q0080050 D Q0080050^MAGDQR06 ;R  Accession Number
 Q
 ;
Q0100010 ;R  Patient's Name
 ; No IA needed, PIMS 5.3
 S V(T)=$S('SENSEMP:$P($G(^DPT(MAGDFN,0)),"^",1),1:"IMAGPATIENT,SENSITIVE")
 S V(T)=$$VA2DCM^MAGDQR01(V(T))
 Q
 ;
Q0100020 ;R  Patient ID
 ; No IA needed, PIMS 5.3
 S V(T)=$S('SENSEMP:$P($G(^DPT(MAGDFN,0)),"^",9),1:"000001234")
 Q
 ;
Q0200010 D Q0200010^MAGDQR06 ;R  Study ID
 Q
 ;
Q020000D ;U  Study Instance UID
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="1.2.840.113754.2.1.3.1.1.66."_$G(^TMP("MAG",$J,"DICOMQR","DUMMY SIUID"))
 . Q
 ; no
 I MAGIEN="" S V(T)="" Q
 N PARENT
 S PARENT=$P($G(^MAG(2005,MAGIEN,0)),"^",10)
 S:'PARENT PARENT=MAGIEN
 S V(T)=$P($G(^MAG(2005,PARENT,"PACS")),"^",1)
 Q
 ;
Q020000E ;U  Series Instance UID
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . S V(T)="1.2.840.113754.2.1.3.1.1.1.66."_$G(^TMP("MAG",$J,"DICOMQR","DUMMY SIUID"))
 . Q
 ; no
 I MAGIEN="" S V(T)="" Q
 S V(T)=$P($G(^MAG(2005,MAGIEN,"SERIESUID")),"^",1)
 Q
 ;
Q0080052 ;O  Query Level
 N I
 S I=$O(REQ(T,"")),V(T)=""
 S:I V(T)=$G(REQ(T,I))
 Q
 ;
Q0080061 ;O  Modalities in Study
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I
 . S I=$O(REQ(T,""))
 . S V(T)="OT" I I,$G(REQ(T,I))]"" S V(T)=REQ(T,I)
 . Q
 ; no
 N ANY,I1,I2,LIST,MOD,P1,P2,R,TMP
 I MAGIEN="" S V(T)="" Q
 ;
 S I1="" F  S I1=$O(REQ(T,I1)) Q:I1=""  D
 . S R=$TR(REQ(T,I1),"/","\")
 . F I2=1:1:$L(R,"\") S X=$P(R,"\",I2) S:X'="" LIST(X)=1
 . Q
 ;
 S X=$P($G(^MAG(2005,MAGIEN,0)),"^",8) S:$E(X,1,4)="RAD " X=$E(X,5,$L(X))
 S:X'="" MOD(X)=""
 S R="",P1=0 F  S P1=$O(^MAG(2005,MAGIEN,1,P1)) Q:'P1  D
 . S P2=+$G(^MAG(2005,MAGIEN,1,P1,0)) Q:'P2
 . S X=$P($G(^MAG(2005,P2,0)),"^",8)
 . S:$E(X,1,4)="RAD " X=$E(X,5,$L(X))
 . S:X'="" MOD(X)=""
 . Q
 S R="",ANY=0,X="" F  S X=$O(MOD(X)) Q:X=""  D
 . D  ; filter out consult-related noise
 . . Q:$E(X,1,7)="CONSULT"  Q:X="CON/PROC"
 . . S:R'="" R=R_"," S R=R_X
 . . Q
 . I $O(LIST(""))="" S ANY=1 Q
 . S I1="" F  S I1=$O(LIST(I1)) Q:I1=""  D  Q:ANY
 . . S:$$MATCHD(X,"LIST(LOOP)","TMP(LOOP)") ANY=1
 . . Q
 . Q
 S V(T)=R
 S:'ANY OK=0
 Q
 ;
Q0080062 D Q0080062^MAGDQR06 ;O  SOP Classes in Study
 Q
 ;
Q0080090 D Q0080090^MAGDQR06 ;O  Referring Physician's Name
 Q
 ;
Q0081030 D Q0081030^MAGDQR06 ;O  Study Description
 Q
 ;
Q0081032 ;O  Procedure Code Sequence
 Q
 ;
Q0080100 D Q0080100^MAGDQR06 ;O  >Code Value
 Q
 ;
Q0080102 ;O  >Coding Scheme Designator
 S V("0008,1030",1,T)="C4"
 Q
 ;
Q0080103 ;O  >Coding Scheme Version
 S V("0008,1030",1,T)=4
 Q
 ;
Q0080104 D Q0080104^MAGDQR06 ;O  >Code Meaning
 Q
 ;
Q0081060 D Q0081060^MAGDQR06 ;O  Name of Physician(s) Reading Study
 Q
 ;
Q0081080 D Q0081080^MAGDQR06 ;O  Admitting Diagnosis Description
 Q
 ;
Q0100021 ;O  Issuer of Patient ID
 S V(T)="USSSA"
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0100030 ;O  Patient's Birth Date
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I,REQDT S I=$O(REQ(T,"")) S:I REQDT=$TR($P($G(REQ(T,I)),"-",1),"*")
 . S V(T)=$S($G(REQDT)?8N:REQDT,1:$$DT^XLFDT+17000000)
 . Q
 ; no
 S V(T)=$P($G(^DPT(MAGDFN,0)),"^",3)\1+17000000
 I $E(V(T),5,6)="00" S V(T)="" ; invalid month for DICOM
 I $E(V(T),7,8)="00" S V(T)="" ; invalid year for DICOM
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0100032 ;O  Patient's Birth Time
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I,REQTM S I=$O(REQ(T,"")) S:I REQTM=$TR($P($G(REQ(T,I)),"-",1),"*")
 . S V(T)=$S($G(REQTM)?6N:REQTM,1:$E($P($$NOW^XLFDT,".",2)_"000000",1,6))
 . Q
 ; no
 S V(T)=$TR($J("."_$P($P($G(^DPT(MAGDFN,0)),"^",3),".",2)*1E6,6)," ",0)
 S:V(T)="000000" V(T)="" ; no time on file
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0100040 ;O  Patient's Sex
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S V(T)=$S(I:$S($G(REQ(T,I))]"":REQ(T,I),1:"O"),1:"O")
 . Q
 ; no
 S V(T)=$P($G(^DPT(MAGDFN,0)),"^",2)
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0101000 ;O  Other Patient IDs
 ; sensitive/employee?
 I SENSEMP S V(T)="000001234" Q  ; yes, scrub
 ; no
 N DFN,I,VA,VADPT
 S DFN=MAGDFN D DEM^VADPT
 S X=$P(^DPT(DFN,0),"^",9) S:X'="" DFN(X)=""
 S:$G(VA("PID"))'="" DFN(VA("PID"))=""
 S:$G(VA("BID"))'="" DFN(VA("BID"))=""
 I $T(GETICN^MPIF001)'="" S X=$$GETICN^MPIF001(DFN) S:+X DFN(X)=""
 S I=0,X="" F  S X=$O(DFN(X)) Q:X=""  S I=I+1,V(T,I)=X
 ;;;S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0101001 ;O  Other Patient Names
 ; sensitive/employee?
 I SENSEMP S V(T)="IMAGPATIENT,SENSITIVE" Q  ; yes, scrub
 ; no
 N D1,I
 S (I,D1)=0 F  S D1=$O(^DPT(MAGDFN,0.01,D1)) Q:'D1  D
 . S X=$P($G(^DPT(MAGDFN,0.01,D1,0)),"^",1)
 . S:X'="" I=I+1,V(T,I)=X
 . Q
 ;;;S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0101010 ;O  Patient's Age
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 N DOB,FROM,YEARS
 S DOB=$P($G(^DPT(MAGDFN,0)),"^",3)
 S FROM=$P($G(^DPT(MAGDFN,.35)),"^",1) S:'FROM FROM=DT
 S YEARS=$E(FROM,1,3)-$E(DOB,1,3)
 S:$E(FROM,4,7)<$E(DOB,4,7) YEARS=YEARS-1
 S V(T)=($P($J(YEARS/1000,0,3),".",2))_"Y"
 ;;;S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0101020 ;O  Patient's Size
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 S V(T)=$P($G(^DPT(MAGDFN,57)),"^",1) ; height in cm - field not populated
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0101030 ;O  Patient's Weight
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 S V(T)=$P($G(^DPT(MAGDFN,57)),"^",2) ; weight in kg - field not populated
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0102160 ;O  Ethnic Group
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 S V(T)=$P($G(^DPT(MAGDFN,0)),"^",6)
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0102180 ;O  Occupation
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 S V(T)=$P($G(^DPT(MAGDFN,0)),"^",7)
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q01021B0 D Q01021B0^MAGDQR06 ;O  Additional Patient History
 Q
 ;
Q0104000 D Q0104000^MAGDQR06 ;O  Patient Comments
 Q
 ;
Q0201206 ;O  Number of Study Related Series
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 N N,S,UID
 S UID=$G(V("0020,000D")),N=0
 I UID'=""  S S="" F  S S=$O(^MAG(2005,"P",UID,S)) Q:S=""  S N=N+1
 S V(T)=N
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
Q0201208 ;O  Number of Study Related Instances
 ; sensitive/employee?
 I SENSEMP D  Q  ; yes, scrub
 . N I S I=$O(REQ(T,"")) S:I V(T)=$S($G(REQ(T,I))]"":REQ(T,I),1:"")
 . Q
 ; no
 N N,P1,P2,S,UID
 S UID=$G(V("0020,000D")),N=0
 I UID'=""  S S="" F  S S=$O(^MAG(2005,"P",UID,S)) Q:S=""  D
 . S P1=0 F  S P1=$O(^MAG(2005,S,1,P1)) Q:'P1  D
 . . S P2=+$G(^MAG(2005,S,1,P1,0)) Q:'P2
 . . S N=N+1
 . . Q
 . Q
 S V(T)=N
 S:'$$COMPARE(T,V(T)) OK=0
 Q
 ;
U008010C D U008010C^MAGDQR06 ;O  Interpretation Author
 Q
 ;
