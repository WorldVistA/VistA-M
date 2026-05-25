MAGDFCNV ;WOIFO/PMK - Read HL7 and generate DICOM ; Jan 13, 2026@11:26:58
 ;;3.0;IMAGING;**11,51,141,138,231,333**;Mar 19, 2002;Build 2
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;
 ; Supported IA #2171 reference $$STA^XUAF4 function call
 ; Supported IA #2541 reference $$KSP^XUPARAM function call
 ; Supported IA #2051 reference $$FIND1^DIC function call
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Controlled IA #4897 to read BUILD file (#9.6)
 ;
CONSOLID() ; check if this is a consolidated site or not
 ; return 0 = non-consolidated (normal) site
 ; return 1 = consolidated site
 ;
 ; code for the main VistA HIS
 Q $GET(^MAG(2006.1,"CONSOLIDATED"))="YES"
 ;
ACQDEV(MFGR,MODEL,SITE) ; get pointer to the Acquisition Device file
 N ACQDEV ;--- name of acquisition device
 N ACQDEVP ;-- pointer to acquisition device file (#2006.04)
 ;
 S ACQDEV=$$UP^MAGDFCNV(MFGR_" ("_MODEL_")")
 S ACQDEVP=$O(^MAG(2006.04,"B",ACQDEV,""))
 I 'ACQDEVP D  ; create the entry
 . L +^MAG(2006.04,0):1E9 ; serialize name generation code
 . I '$D(^MAG(2006.04,0)) S ^(0)="ACQUISITION DEVICE^2006.04^^"
 . S ACQDEVP=$P(^MAG(2006.04,0),"^",3)+1
 . S ^MAG(2006.04,ACQDEVP,0)=ACQDEV_"^"_SITE_"^" ; 3rd piece is null
 . S ^MAG(2006.04,"B",ACQDEV,ACQDEVP)=""
 . S $P(^MAG(2006.04,0),"^",3)=ACQDEVP
 . S $P(^MAG(2006.04,0),"^",4)=ACQDEVP
 . L -^MAG(2006.04,0) ; clear the serial name generation code
 Q ACQDEVP
 ;
EQUIVGRP(P1,P2) ; see if two SOP Class pointers are in equivalent groups
 N G1,G2
 Q:'$G(P1) 0
 Q:'$G(P2) 0
 S G1=$P($G(^MAG(2006.532,P1,0)),"^",3) S:G1="" G1=P1
 S G2=$P($G(^MAG(2006.532,P2,0)),"^",3) S:G2="" G2=P2
 Q G1=G2
 ;
UP(X) ; special UPPER CASE function -- removes redundant blanks as well
 F  Q:X'["  "  S $E(X,$F(X,"  ")-1)=""  ; remove redundant blank
 I $E(X)=" " S $E(X)=""  ; remove leading blank
 I $E(X,$L(X))=" " S $E(X,$L(X))=""  ; remove trailing blank
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz^|","ABCDEFGHIJKLMNOPQRSTUVWXYZ~~")
 ;
STATNUMB() ; return numeric 3-digit station number for the VA
 N STATNUMB
 S STATNUMB=$$STA^XUAF4($$KSP^XUPARAM("INST")) ; station number
 ; station number is 3 digits, exclusive of any modifiers or full station number for IHS
 Q $S($$ISIHS^MAGSPID():STATNUMB,1:$E(STATNUMB,1,3))
 ;
DIVISION() ; return the user's hospital division - P333 PMK 01/13/2026
 N DIVISION
 S DIVISION=$G(DUZ(2),0) ; user's logon division
 I 'DIVISION D
 . S DIVISION="-1,User's Division is not defined"
 . Q
 Q DIVISION
 ;
GMRCACN(GMRCIEN) ; return a site-specific accession number for clinical specialties
 ; GMRCIEN is the CPRS Consult Request Tracking GMRC IEN - REQUEST/CONSULTATION file(#123)
 N A ; return DILIST from FIND^DIC
 N ACNUMB ; accession number for a consult/procedure request
 N EXAMDATE ; date of exam
 N P162DATE ; installation date for MAG*3.0*162, when site-specific accession numbers started
 ; shouldn't use FIND1^DIC because it fails if the patch was installed multiple times
 D FIND^DIC(9.7,"","17I;@","B","MAG*3.0*162","","","","","A") ; P333 PMK 12/15/2022
 S P162DATE=$G(A("DILIST","ID",1,17)) ; install complete date & time
 S EXAMDATE=$$GET1^DIQ(123,GMRCIEN,.01,"I")
 I EXAMDATE<P162DATE D  ; legacy accession number format
 . ; Format: GMRC-<gmrcien>, where <gmrcien> is the internal entry number of the request 
 . S ACNUMB="GMRC-"_GMRCIEN
 . Q 
 E  D  ; site-specific accession number format
 . ; Format: <sss>-GMR-<gmrcien>, where <sss> is station number, and <gmrcien>
 . ;         is the internal entry number of the request, up to 8 digits (100 million) 
 . S ACNUMB=$$STATNUMB()_"-GMR-"_GMRCIEN
 . Q
 Q ACNUMB
 ;
GMRCIEN(ACNUMB) ; return the GMRC IEN, given a consult/procedure accession number
 ; ACNUMB is the accession number for a consult/procedure request
 ; OLD Format: GMRC-<gmrcien>, where <gmrcien>is the internal entry number of the request
 ; New Format: <sss>-GMR-<gmrcien>, where <sss> is station number, and <gmrcien>
 ;             is the internal entry number of the request, up to 8 digits (100 million)
 N GMRCIEN ; CPRS Consult Request Tracking GMRC IEN - REQUEST/CONSULTATION file(#123)
 I ACNUMB?1"GMRC-"1N.N S GMRCIEN=$P(ACNUMB,"-",2) ; return the second piece
 E  I ACNUMB?1N.N1"-GMR-"1N.N S GMRCIEN=$P(ACNUMB,"-",3) ; return the third piece
 E  S GMRCIEN="" ; invalid consult request tracking accession number format
 Q GMRCIEN
 ;
HOSTNAME() ;
 Q $P(##class(%SYS.System).GetNodeName(),".",1)
 ;
CHECKSUM ; interactive routine checksums - P333 PMK 06/06/2022
 N DEFAULT,DONE,HELP,PROMPT,ROUTINE,X
 ;
 U $P:132 ; switch to 132 character mode
 S DEFAULT=""
 S PROMPT="Checksums by Routine name or Patch number?"
 S HELP(1)="Enter ""R"" to output the checksums for a set of named routines."
 S HELP(2)="or ""P"" to output the checksums for all the routines in a patch."
 S HELP(3)=""
 S HELP(4)="Enter caret (""^"") to exit."
 ;
 S DONE=0 F  D  Q:DONE
 . K ^TMP("MAG",$J,"ROUTINES")
 . I $$RP(PROMPT,DEFAULT,.X,.HELP)<0 S DONE=-1 Q
 . I X="PATCH" D
 . . D PATCH
 . . S DEFAULT="P"
 . . Q
 . E  D
 . . D ROUTINE
 . . S DEFAULT="R"
 . . Q
 . ;
 . W ! D CHECKSUMS
 . K ^TMP("MAG",$J,"ROUTINES")
 . Q
 U $P:IOM ; switch back to regular character mode
 Q
 ;
ROUTINE ; get a list of routines
 N DONE,LINE1,LINE2,R,SELECT,STATUS,STOP,X
 K ^TMP("MAG",$J,"ROUTINES")
 S DONE=0
 F  D  Q:DONE
 . W !,"Routine(s): "
 . R X:DTIME
 . I X="" S DONE=1 Q
 . I X="^" S DONE=-1 Q
 . I X?1"'".E S X=$E(X,2,999),SELECT=0 ; unselect the routine(s)
 . E  S SELECT=1 ; select the routine(s)
 . I X?1"^".E S X=$E(X,2,999) ; strip off leading ^ in routine name
 . I X?.E1"*" D
 . . S (R,X)=$P(X,"*")
 . . S STATUS=$$SAVERTN(R,SELECT)
 . . S STOP=X_"ZZZ" F  S R=$O(^ROUTINE(R)) Q:R=""  Q:R]STOP  D
 . . . S STATUS=$$SAVERTN(R,SELECT)
 . . . Q
 . . Q
 . E  I $$SAVERTN(X,SELECT) ; set $T
 . E  W " -- not on file"
 . Q
 Q
 ;
SAVERTN(R,SELECT) ; save the routine info
 N EXISTS,LINE1,LINE2
 I $D(^ROUTINE(R)) D
 . I SELECT D  ; select the routine
 . . S LINE1=$G(^ROUTINE(R,0,1)),LINE2=$G(^(2))
 . . S ^TMP("MAG",$J,"ROUTINES",R)=$P(LINE1,";",3)_"^"_$P(LINE2,";",5)
 . . Q
 . E  D  ; unselect the routine
 . . K ^TMP("MAG",$J,"ROUTINES",R)
 . . Q
 . S EXISTS=1
 . Q
 E  S EXISTS=0
 Q EXISTS
 ;
PATCH ; get a patch number
 N A,B,DONE,IEN,LINE1,LINE2,PLIST,PATCH,R,S,X
 S DONE=0
 F  D  Q:DONE
 . W !!,"Patch number: "
 . R X:DTIME
 . I "^"[X S DONE=1 Q
 . I (X'?1N.N),(X'?1A.A1"*".1N.N.".".N1"*"1N.N) W "  ???" S X="?"
 . I "?"[X D  Q
 . . W !!,"Enter the full patch number or just the last digits for MAG*3.0*nnn"
 . . Q
 . I X?1N.N S PATCH="MAG*3.0*"_X
 . E  D
 . . S PATCH=$$UP(X)
 . . I $P(PATCH,"*",2)?1N.N S $P(PATCH,"*",2)=$P(PATCH,"*",2)_".0"
 . . Q
 . S IEN=$$FIND1^DIC(9.6,"","BX",PATCH)
 . I IEN=0 W " ??? No ",PATCH," patch" Q
 . D GETS^DIQ(9.67,"9.8,"_IEN_",","10*","N","A","B")
 . S S="" F  S S=$O(A(9.68,S)) Q:S=""  D
 . . S R=$G(A(9.68,S,.01)) Q:R=""
 . . S LINE1=$G(^ROUTINE(R,0,1)),LINE2=$G(^(2))
 . . S PLIST=$P(LINE2,";",5)
 . . S ^TMP("MAG",$J,"ROUTINES",R)=$P(LINE1,";",3)_"^"_PLIST ; last edit date/time
 . . Q
 . S DONE=1
 . Q
 Q
 ;
CHECKSUMS ; output the checksums
 N R
 S R="" F  S R=$O(^TMP("MAG",$J,"ROUTINES",R)) Q:R=""  D
 . W !,R,?10,$J($$CHK2(R),10)
 . W ?23,$P($G(^TMP("MAG",$J,"ROUTINES",R)),"^",1) ; patch list
 . W ?46,$P($G(^TMP("MAG",$J,"ROUTINES",R)),"^",2) ; last edit date/time
 . Q
 Q
 ;
NOQUOTES(X) ; "Copy as path" has leading and trailing quotes - remove them
 I $E(X)="""",$E(X,$L(X))="""" S X=$E(X,2,$L(X)-1) ; P333 PMK 04/23/2025
 Q X
 ;
RP(PROMPT,DEFAULT,CHOICE,HELP) ; generic question driver
 N I,OK,X
 S OK=0 F  D  Q:OK
 . W !!,PROMPT," " I $L($G(DEFAULT)) W DEFAULT,"// "
 . R X:DTIME E  S X="^"
 . I X="",$L($G(DEFAULT)) S X=DEFAULT W X
 . I X="",'$L($G(DEFAULT)) S X="*" ; fails tests
 . I X["^" S CHOICE="^",OK=-1 Q
 . I "Pp"[$E(X) S CHOICE="PATCH",OK=1 Q
 . I "Rr"[$E(X) S CHOICE="ROUTINE",OK=1 Q
 . I X["?",$D(HELP) D
 . . W !
 . . F I=1:1 Q:'$D(HELP(I))  W !,HELP(I)
 . . Q
 . E  W "   ???",!,"Please enter ""R"" for routines or ""P"" for a patch"
 . Q
 Q OK
 ;
CHK2(R) ; checksum algorithm for a routine
 N K,X,Y
 S Y=0
 F K=1:1 S X=$T(+K^@R) Q:X=""  S:K'=2 Y=Y+$$C2(X,K)
 Q Y
 ;
C2(X,K) ; checksum algorithm for a line
 N F,I,Y
 S Y=0
 S F=$F(X," "),F=$S($E(X,F)'=";":$L(X),$E(X,F+1)=";":$L(X),1:F-2)
 F I=1:1:F S Y=$A(X,I)*(I+K)+Y
 Q Y
