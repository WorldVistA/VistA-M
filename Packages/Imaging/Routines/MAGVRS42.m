MAGVRS42 ;WOIFO/MLH/NST - Utility for file lookup by name/value pairs ; 06 Feb 2012 07:10 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
FINDBYAT(OUT,FILE,ATTSARY) ; Find by name/value pairs
 ; inputs:    FILE    a FileMan file number (must be a parent file)
 ;            ATTSARY array of name/value pairs - names must be those
 ;                    of main-level fields (not multiples or children)
 ;
 ; Performs a name/value pair lookup on a flat FileMan file.
 ; 
 N OSEP,ISEP,SSEP ; separators
 N ATTIX ; attribute array index
 N ATTNAME,ATTVAL ; attribute name and value
 N SRCHFLD ; search field number
 N SRCHARY ; search fields array
 N SCREEN ; screening logic string
 N SCRLOGIC ; single piece of screening logic
 N XREFINFO ; cross-reference information from data dictionary
 N XREFNAME ; index to pass to the FileMan search function
 N XREFIX ; index of cross references for a field
 N XREFVAL ; value to be looked up on the cross reference
 N DIC ; file reference of the global node
 N DLAYGO ; FileMan parameter enabling LAYGO for referenced file.
 N OUTIX ; output index
 ;
 K OUT
 S OSEP=$$OUTSEP^MAGVRS41,ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 ; validate input parameters
 I 'FILE S OUT(1)="-1"_SSEP_"No file specified" Q
 I ($E(FILE,1,4)'=2005),($E(FILE,1,4)'=2006) S OUT(1)="-12"_SSEP_"File not in valid search range" Q
 D  Q:$D(OUT)  ; does the file exist?
 . N MAGATTS
 . D FILE^DID(FILE,"N","NAME","MAGATTS")
 . I '$D(MAGATTS("NAME")) S OUT(1)="-2"_SSEP_"Invalid file number ("_FILE_")" Q
 . Q
 I $D(ATTSARY)<10 S OUT(1)="-3"_SSEP_"No search attributes specified" Q
 ;
 S ATTIX=0
 ; Parse the attributes.  Find a cross-reference to look up on, and build a
 ; screen if there are multiple search criteria.  At least one of the
 ; search fields must be cross-referenced.
 F  S ATTIX=$O(ATTSARY(ATTIX)) Q:'ATTIX  D  Q:$D(OUT)
 . S ATTNAME=$P(ATTSARY(ATTIX),ISEP,1),ATTVAL=$P(ATTSARY(ATTIX),ISEP,2)
 . I ATTNAME="" D  Q
 . . S OUT(1)="-4"_SSEP_"Field name missing"
 . . Q
 . ; Set SERVICE INSTITUTION based on value sent for CREATING ENTITY
 . ;;;;
 . I "^2005.6^2005.61^"[("^"_FILE_"^"),ATTNAME="CREATING ENTITY" D  Q:$D(OUT)
 . . N SIFLD,SIVAL,Y,X
 . . ; Note: This must be refined (preferably recast as a service)
 . . ;       if external (non-VA) institution files are introduced in future
 . . S SIFLD="SERVICE INSTITUTION REFERENCE"
 . . S DIC=2005.8,DIC(0)="X",X=ATTVAL D ^DIC S SIVAL=$P(Y,"^",1)
 . . I SIVAL<0 S OUT(1)=-101_SSEP_"CREATING ENTITY ("_ATTVAL_") not found in IMAGING SERVICE INSTITUTION File" Q
 . . S ATTVAL=SIVAL,ATTNAME=SIFLD
 . . Q
 . ;;;
 . S SRCHFLD=$S(ATTNAME?.N.1".".N:ATTNAME,1:$$GETFIELD^MAGVRS41(FILE,ATTNAME))  ; Field Name has at least one Alpha character
 . I SRCHFLD="" D  Q
 . . S OUT(1)="-5"_SSEP_"Unknown field name"
 . . Q
 . D  ; select an index and build a search string
 . . N GBLINFO ; DD information about a field
 . . N GBLLOC ; global location of the field on the file
 . . N GBLNODE ; global node of the field on the file
 . . N GBLPIECE ; piece of the field on the global node
 . . ; already got a cross reference name and value?  if not, try to find one;
 . . ; otherwise, add this field to the screen
 . . I $D(^DD(FILE,"IX",SRCHFLD)),'$D(XREFNAME) D  Q:XREFNAME'=""  ; ICR 5550
 . . . S XREFIX=0
 . . . F  S XREFIX=$O(^DD(FILE,SRCHFLD,1,XREFIX)) Q:'XREFIX  D  Q:$G(XREFNAME)'=""
 . . . . ; select only regular xrefs; not MUMPS / trigger xrefs, etc.
 . . . . S XREFINFO=$G(^DD(FILE,SRCHFLD,1,XREFIX,0)) Q:XREFINFO=""
 . . . . S:$P(XREFINFO,"^",3)="" XREFNAME=$P(XREFINFO,"^",2)
 . . . . S:XREFNAME'="" XREFVAL=ATTVAL
 . . . . Q
 . . . Q
 . . ; add this field to the screen
 . . D FIELD^DID(FILE,SRCHFLD,,"GLOBAL SUBSCRIPT LOCATION","GBLINFO")
 . . I $D(^TMP("DIERR",$J)) D  Q
 . . . S OUT(1)="-13"_SSEP_$G(^TMP("DIERR",$J,1))_"FM "_$G(^(1,"TEXT",1))
 . . . Q
 . . S GBLLOC=$G(GBLINFO("GLOBAL SUBSCRIPT LOCATION"))
 . . I GBLLOC="" S OUT(1)="-11"_SSEP_"DD information not available for attribute "_ATTNAME Q
 . . S GBLNODE=$P(GBLLOC,";",1),GBLPIECE=+$P(GBLLOC,";",2)
 . . I 'GBLPIECE D  Q
 . . . S OUT(1)="-6"_SSEP_"Not a top-level field name"
 . . . Q
 . . I GBLNODE="" D  Q
 . . . S OUT(1)="-7"_SSEP_"Corrupt field definition in DD"
 . . . Q
 . . I GBLNODE'=+GBLNODE S GBLNODE=""""""_GBLNODE_""""""
 . . S SCRLOGIC="$P(@(DIC_Y_"","_GBLNODE_")""),""^"","_GBLPIECE_")="""_ATTVAL_""""
 . . S SCREEN=$S('$D(SCREEN):"I "_SCRLOGIC,1:SCREEN_","_SCRLOGIC)
 . . Q
 . Q
 Q:$D(OUT)
 I ('$D(XREFVAL))!('$D(XREFNAME)) S OUT(1)="-9"_SSEP_"No cross reference found to search on" Q
 D FIND^DIC(FILE,,"@","QX",XREFVAL,,XREFNAME,$G(SCREEN))
 ; retrieve search results and massage into expected format
 I '$D(^TMP("DILIST",$J,2)) S OUT(1)="-10"_SSEP_"NO MATCH FOUND" Q
 M OUT=^TMP("DILIST",$J,2)
 S OUTIX=0
 F  S OUTIX=$O(OUT(OUTIX)) Q:'OUTIX  S OUT(OUTIX)="0"_SSEP_SSEP_OUT(OUTIX)
 ;
 Q
