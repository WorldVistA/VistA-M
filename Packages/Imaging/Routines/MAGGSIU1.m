MAGGSIU1 ;WOIFO/GEK/NST - Utilities for Image Add/Modify ; 04 Mar 2010 4:04 PM
 ;;3.0;IMAGING;**7,8,108**;Mar 19, 2002;Build 1738;May 20, 2010
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
 ; GEK 11/04/2002  Keep MAGGTU1 as utility for DA2NAME and DRIVE
 ;
MAKENAME(MAGGFDA) ; get info from the MAGGFDA array
 ;  For all Images the Name (.01) is first 18 characters of patient name 
 ;    concatenated with SSN.
 ;  If No patient name is sent, well make the name from the short desc.
 ;  We were making name of : 
 ;    $E(PATENT NAME,1,10)' '$E(DESC CATEG,1,9)' 'MM/DD/YY   (DOC DATE)
 N ZDESC,X
 S ZDESC=""
 ; If we don't have a patient name ( later) we set .01 to Short Desc 
 ; if it exists.
 I $D(MAGGFDA(2005,"+1,",10)) S ZDESC=$E(MAGGFDA(2005,"+1,",10),1,30)
 ;                   DFN
 I $D(MAGGFDA(2005,"+1,",5)) D
 . S X=MAGGFDA(2005,"+1,",5)
 . ;                NAME                        SSN
 . S ZDESC=$E($P(^DPT(X,0),U),1,18)_"   "_$P(^DPT(X,0),U,9)
 ;
 Q ZDESC
MAKECLAS ; Patch 8: This call will attempt to compute an Image CLASS ^ (#41) CLASS [2P] 
 ; from the TYPE Field   (#42) TYPE [3P]  
 ; Call assumes the FM FDA Array MAGGFDA exists.
 ;// Note : this is also called from MAGGTIA. TYPE may not exist.
 ; Calling RTN expects MAGERR to exist if error.
 N TYPE,CLS
 S TYPE=$G(MAGGFDA(2005,"+1,",42))
 ; Can't make Type required.  yet.
 ;I TYPE="" S MAGERR="0^A Value for Field #42 (Image Type) is missing." Q
 I TYPE="" Q
 S CLS=$P(^MAG(2005.83,TYPE,0),U,2)
 I 'CLS S MAGERR="0^Missing Class pointer for TYPE : "_$P(^MAG(2005.83,TYPE,0),U)_" ("_TYPE_")" Q
 S MAGGFDA(2005,"+1,",41)=CLS
 Q
MAKEPKG ;Patch 8 This call will attempt to compute the field (#40) PACKAGE INDEX [1S] from Patent Data File.
 ; Call assumes the FM FDA Array MAGGFDA exists.
 N PARENT,PKG,PXIEN,MAGRY,OK,TYPE
 S PARENT=$G(MAGGFDA(2005,"+1,",16))
 S TYPE=$G(MAGGFDA(2005,"+1,",42))
 I (PARENT="")&(TYPE=$$PHOTODA) D  Q
 . S MAGGFDA(2005,"+1,",40)="PHOTOID"
 . ;  Need next line, bacause the Method that returns Photo ID for a Pat.
 . ;  checks for PHOTO ID in the Cross Reference.
 . S MAGGFDA(2005,"+1,",6)="PHOTO ID"
 . Q
 I PARENT="" S MAGGFDA(2005,"+1,",40)="NONE" Q  ;MAGERR="0^Missing Parent Data File pointer" Q
 I PARENT'=8925 S PKG=$P(^MAG(2005.03,PARENT,2),U) Q
 S PXIEN=$G(MAGGFDA(2005,"+1,",17))
 D DATA^MAGGNTI(.MAGRY,PXIEN)
 D ISCP^TIUCP(.OK,$P(MAGRY,U,2)) I OK S MAGGFDA(2005,"+1,",40)="CP" Q
 D ISCNSLT^TIUCNSLT(.OK,$P(MAGRY,U,2)) I OK S MAGGFDA(2005,"+1,",40)="CONS" Q
 S MAGGFDA(2005,"+1,",40)="NOTE"
 Q
MAKEPROC ; Patch 8: This call will attempt to compute PROCEDURE field  ^ (#6) PROCEDURE [8F] 
 ; from Fields:   (#41) CLASS [2P]  or PACKAGE field (#40) PACKAGE [1S]
 ; Call assumes the FM FDA Array MAGGFDA exists.
 ; We are here because TYPE INDEX, CLASS INDEX and PACKAGE INDEX exist but PROCEDURE doesn't 
 ; Calling RTN expects MAGERR to exist if error. ; 
 N TYPE,CLS,PKG
 I $G(MAGGFDA(2005,"+1,",40),"NONE")'="NONE" S MAGGFDA(2005,"+1,",6)=MAGGFDA(2005,"+1,",40) Q 
 S TYPE=$G(MAGGFDA(2005,"+1,",42))
 ; Can't make Type required.  yet.
 S CLS=$P(^MAG(2005.83,TYPE,0),U,2)
 I 'CLS S MAGERR="0^Missing Class pointer for TYPE : "_$P(^MAG(2005.83,TYPE,0),U)_" ("_TYPE_")" Q
 S MAGGFDA(2005,"+1,",6)=$P($$GET1^DIQ(2005.82,CLS,".01","E"),"/")
 Q
MAKEORIG ; Patch 8: This call will default the Origin field #45 to "VA"
 ; We are here because TYPE exists in the Array but Origin doesn't
 S MAGGFDA(2005,"+1,",45)="V"       ; Patch 108: set to "V"
 Q
KILLENT(MAGGDA) ; Delete the entry just created, because of Post processing Error
 D CLEAN^DILF
 S DA=MAGGDA,DIK="^MAG(2005," D ^DIK
 K DA,DIC,DIK
 Q
RTRNERR(ETXT,MAGGXE) ; There was error from UPDATE^DIE quit with error text
 S ETXT="0^ERROR  "_MAGGXE("DIERR",1,"TEXT",1)
 Q
PHOTODA() ;Return the DA from File IMAGE INDEX FOR TYPES that is the PhotoID entry.
 Q $O(^MAG(2005.83,"B","PHOTO ID",""))
