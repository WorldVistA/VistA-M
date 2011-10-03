MAGGTLB ;WOIFO/LB - RPC call for Laboratory/Imaging interface ; [ 11/24/2004 04:06 ]
 ;;3.0;IMAGING;**48,72**;10-November-2008;;Build 1324
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
 ;This routine is called from the Laboratory Image capture window.
 ;The line tag SECT is used for selection of the Laboratory section.
 ;The line tag STAIN is used for selection of Histological stain.
 ;The line tag MICRO is used for selection of Microscopic Objective.
 ;The line tag START is used for selection of the specimen that the image
 ;relates to. This line tag will require a lab section (Autopsy/
 ;Gross, Autopsy/Microscopic, EM, Surgical Path, or Cytology),
 ;the Accession year, and either an Accession # or Autopsy #.  Based on
 ;this information it will return an array of specimens for selection.
 ;
START(MAGRY,SECT,YR,ACNUM,XXX) ;RPC Call to Return a list of specimens
 ;  -Removed DFN (XXX) -no longer being used for lookup
 ;SECT = Lab entry from 2005.03
 ;YR = 4 digits of year (1700-2000's)
 ;ACNUM = Accession number or autopsy number
 ;Returns an array of specimens for the year_accession#.
 ;MAGRY(#)=Piece 1 = Pt Name            piece 2 = Ssn
 ;               3 = Date/Time                4 = Accn #
 ;               5 = Pathologist              6 = Specimen
 ;               7 = Ien for file 2005.03     8 = Dfn
 ;               9 = Lrdfn                   10 = Ien for date/time
 ;              11 = Ien specimen            12 = Lab section subfile
 ;                                                 imaging field number
 ;              13 = LR global being referenced
 ;the MAGRY(0)=0 or # lines in array^status (success or no success)
 ;the MAGRY(1)=titles for the grid array
 N Y,YEAR
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 S MAGRY(0)="0^No Data",DATA=0
 S MAGRY(1)="Name^SSN^Date/Time^Acc #^Pathologist^Specimen"
 N CNT,NUM,DATE,ANUM,NUM,DATA,LRDFN,LRI,LINE,MAGI,DATE,PATH,SPEC,MAGABV
 N MAGNODE,MAGSSN,PAT,MAGSECT,FILE,DATA,MAGDFN,MAGNM,MAGX,X0
 S DATA=0
 S LINE=2
 S MAGRY(0)="0^No specimen information found, please enter via DHCP Lab application"
 I '$G(SECT)!('$G(ACNUM))!($L(YR)'=4) D  Q
 . S MAGRY(0)="0^Incorrect variables sent"
 S MAGABV=$P(SECT,"~",2),SECT=$P(SECT,"~")
 Q:'$D(^MAG(2005.03,SECT,0))
 S MAGSECT=$P(^MAG(2005.03,SECT,0),"^"),MAGI=$E($P(^(0),"^",2),1)
 S MAGNODE=$S(MAGI="S":"SP",MAGI="E":"EM",MAGI="C":"CY",1:"AU")
 S MAGX="A"_MAGNODE_"A"
 ;Xref to search accession year and accession/autopsy #.
 I YR<1700 S MAGRY(0)="0^=Invalid year provided" Q
 S YEAR=YR,YR=YEAR-1700
 ;2001-1700 =301 Fileman internal & YR2K compliance
 ;Checked with Lab developers, still setting 3digit year in xref
 ;S YR=$S(YR>1999:3_$E(YR,3,4),1:2_$E(YR,3,4))  ;CODE FOR YRS >1999
 ;Checking MUMPs x-ref which can not be done via FM DB silent calls.
 I '$D(^LR(MAGX,YR,MAGABV,ACNUM)) D  Q
 . S MAGRY(0)="0^Accession number "_MAGABV_" "_YEAR_" "_ACNUM_" is invalid"
 . ;No data for the year accession #
 S LRDFN=$O(^LR(MAGX,YR,MAGABV,ACNUM,0)),LRI=$O(^(LRDFN,0))
 S MAGDFN=$P(^LR(LRDFN,0),"^",3),FILE=$P(^LR(LRDFN,0),"^",2)
 S (MAGNM,MAGSSN)=""
 I FILE=2 S X=^DPT(MAGDFN,0),MAGNM=$P(X,"^"),MAGSSN=$P(X,"^",9) ;Patient file
 I FILE[67 D  Q:MAGNM="" 
 . D GETS^DIQ(67,MAGDFN,".01;.09","E","MAGZZ","MAGERR")
 . I $D(MAGERR("DIERR")) S MAGRY(0)="0^Patient lookup failed" Q
 . S MAGNM=$G(MAGZZ(67,MAGDFN_",",".01","E"))
 . S MAGSSN=$G(MAGZZ(67,MAGDFN_",",".09","E"))
 I "ASCE"'[MAGI Q   ;Not a valid lab section (Autopsy,Surgical Path, Cytology or EM)
 S MAGNODE=$S(MAGI="S":"SP",MAGI="E":"EM",MAGI="C":"CY",1:"AY")
 G:MAGNODE="AY" AUTOPSY    ;Need this because 2005.03 does not reference the right node.
 Q:'$D(^LR(LRDFN,MAGNODE,LRI,0))
 S X0=^LR(LRDFN,MAGNODE,LRI,0),PATH=$P(X0,"^",2),NUM=$P(X0,"^",6)
 S DATE=$P(X0,"^",1),ANUM=NUM
LOOK ;
 S PATH=$S('PATH:"UNKNOWN",1:$$GET1^DIQ(200,PATH_",",.01))
 S YEAR=$E(DATE,1,3)+1700     ;4 digit year
 ; YR2K Compliance 301+1700=2001
 S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_YEAR
 S X=0 F  S X=$O(^LR(LRDFN,MAGNODE,LRI,.1,X)) Q:'X  D
 . S SPEC=$P($G(^LR(LRDFN,MAGNODE,LRI,.1,X,0)),"^")
 . S MAGRY(LINE)=MAGNM_"^"_MAGSSN_"^"_DATE_"^"_ANUM_"^"_PATH_"^"_SPEC_"^"_SECT_"^"_MAGDFN_"^"_LRDFN_"^"_LRI_"^"_X_"^"_"2005"_"^"_"LR("_LRDFN_","""_MAGNODE_""","_LRI_",.1,"_X
 . S DATA=1,LINE=LINE+1
 I DATA S MAGRY(0)=(LINE-2)_"^"_"DATA FOUND"
 Q
AUTOPSY ;
 N MAGERR,MAGRYLN,MAGZZ,XX
 S (MAGERR,MAGZZ)=""
 S X0=^LR(LRDFN,"AU"),DATE=$P(X0,"^"),NUM=$P(X0,"^",6)
 S PATH=$P(X0,"^",7),ANUM=NUM
 S PATH=$S('PATH:"UNKNOWN",1:$$GET1^DIQ(200,PATH_",",.01))
 ;  DATE in line below, was DATA ( DATA was a misprint ) GEK
 S YEAR=$E(DATE,1,3)+1700   ;4 digit year
 ; YR2K compliance 301+1700= 2001
 S DATE=$E(DATE,4,5)_"/"_$E(DATE,6,7)_"/"_YEAR
 S XX=0 F  S XX=$O(^LR(LRDFN,MAGNODE,XX)) Q:'XX  D
 . Q:'$D(^LR(LRDFN,MAGNODE,XX,0))
 . S SPEC=$P(^LR(LRDFN,MAGNODE,XX,0),"^")
 . D GETS^DIQ(61,SPEC,".01","E","MAGZZ","MAGERR")
 . S SPEC=$S($D(MAGERR("DIERR")):"UNKNOWN",1:$G(MAGZZ(61,SPEC_",",".01","E")))
 . S MAGRYLN=""
 . S MAGRYLN=MAGNM_"^"_MAGSSN_"^"_DATE_"^"_ANUM_"^"_PATH_"^"_SPEC
 . S MAGRYLN=MAGRYLN_"^"_SECT_"^"_MAGDFN_"^"_LRDFN_"^^"_XX
 . S MAGRYLN=MAGRYLN_"^"_$S(MAGSECT["GROSS":2005,1:2005.1)
 . S MAGRYLN=MAGRYLN_"^"_"LR("_LRDFN_","""_MAGNODE_""","_XX
 . S MAGRY(LINE)=MAGRYLN
 . S DATA=1,LINE=LINE+1
 I DATA S MAGRY(0)=(LINE-2)_"^"_"DATA FOUND"
 I 'DATA S MAGRY(0)="0^No organ/tissue defined for this autopsy."
 ;If MAGSECT[ "GROSS" then the field # is 2005 for subfile 63.2
 ;else the field # is 2005.1 for the same subfile (AUTOPSY ORGAN/TISSUE).
 Q
STAIN(MAGRY) ;RPC Call to return array of entries from
 ;       file 2005.4, Image Histological Stain.
 ;
 S MAGRY(0)="0^No Entries found for file 2005.4"
 Q:'$D(^MAG(2005.4,0))    ;Imaging file not defined.
 N ENTRY,CNT,DATA,BLANK
 S ENTRY=0,CNT=1,DATA=0,$P(BLANK," ",30)=" "
 F  S ENTRY=$O(^MAG(2005.4,ENTRY)) Q:'ENTRY  D
 . Q:'$D(^MAG(2005.4,ENTRY,0))  S X=$P(^MAG(2005.4,ENTRY,0),"^")
 . S MAGRY(CNT)=X_BLANK_"^"_X,CNT=CNT+1,DATA=1
 I DATA S MAGRY(0)="1^DATA FOUND"_U_(CNT-1)
 Q
MICRO(MAGRY) ;RPC Call to Return array of entries from 
 ;        file 2005.41, Microscopic Objective
 S MAGRY(0)="0^No entries found for file 2005.41"
 Q:'$D(^MAG(2005.41,0))    ;Imaging file not defined.
 N ENTRY,CNT,DATA,BLANK
 S ENTRY=0,CNT=1,DATA=0,$P(BLANK," ",30)=" "
 F  S ENTRY=$O(^MAG(2005.41,ENTRY)) Q:'ENTRY  D
 . Q:'$D(^MAG(2005.41,ENTRY,0))  S X=$P(^MAG(2005.41,ENTRY,0),"^")
 . S MAGRY(CNT)=X_BLANK_"^"_X,CNT=CNT+1,DATA=1
 I DATA S MAGRY(0)="1^DATA FOUND"_"^"_(CNT-1)
 Q
SECT(MAGRY) ;RPC Call to Build Pathology selection 
 ;       from file 68 accordingly to user's division
 ;MAGRY - Returns array of lab section name, section abbreviation
 ;        used in defining the accession number & xref lookup, 
 ;        as well as the IEN in Imaging Parent file.
 N Y,A,B,BLANK,MAGABV,MAGERR,MAGIEN,MAGNM,MAGNNM,MAGSEC,MAGTYPE,DATA
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 S MAGRY(0)="0^No entries found^0"
 S MAGSEC="SPCYEMAU",(A,B)=0,$P(BLANK," ",30)="" D CK Q:MAGERR
 F  S A=$O(^LRO(68,A)) Q:'A  D
 . I MAGSEC[$P($G(^LRO(68,A,0)),"^",2),$P(^LRO(68,A,0),"^",2)]"""",$G(^LRO(68,A,3,+DUZ(2),0)) D
 . . S MAGABV=$P(^LRO(68,A,0),"^",11) Q:MAGABV=""   ;No abbreviation defined
 . . S MAGTYPE=$P(^LRO(68,A,0),"^",2),MAGNM=$P(^LRO(68,A,0),"^")
 . . Q:MAGSEC'[MAGTYPE  D PARENT    ;Must be pathology section.
 . . S B=B+1,DATA=1,MAGRY(B)=MAGNM_BLANK_"^"_MAGIEN_"~"_MAGABV
 I '$D(DATA) S MAGRY(0)="0^No entries found for your division^0" Q
 I DATA S B=B+1,MAGRY(0)="1^Entries found^"_B
 Q
CK ;Check for valid division.
 S MAGERR=1
 N MAGSITE,MAGER
 S MAGSITE=+DUZ(2)
 I 'MAGSITE D  Q
 . S MAGRY(0)="0^You don't have a division setup."
 ;  gek/ change : ..."A",MAGSITE...  to  ..."","`"_MAGSITE...
 I '$$FIND1^DIC(4,"","","`"_MAGSITE,"","","MAGER") D  Q
 . S MAGRY(0)="0^No division name found."
 S MAGERR=0
 Q
PARENT ;Set the corresponding parent file/subfile in ^MAG(2005.03,62:64.
 S MAGIEN=$S(MAGTYPE="SP":63.08,MAGTYPE="EM":63.02,MAGTYPE="CY":63.09,1:63.2)
 I MAGTYPE="AU" S MAGIEN=63.2,MAGNNM=MAGNM_" (GROSS)",B=B+1,MAGRY(B)=MAGNNM_BLANK_"^"_MAGIEN_"~"_MAGABV,MAGNNM="",MAGIEN=63,MAGNM=MAGNM_" (MICROSCOPIC)"
 ;Autopsy selection will have two selection (GROSS or MICROSCOPIC) and the parent file ^MAG(2005.03 has two entries (63 & 63.2).
 Q
