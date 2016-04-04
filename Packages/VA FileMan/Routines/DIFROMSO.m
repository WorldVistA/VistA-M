DIFROMSO ;SCISC/DCL-DIFROM SERVER EDE OUT ;01:18 PM  8 Feb 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
 ;
 ; * EXTENDED DATABASE ELEMENTS (EDE) OUT *
EDEOUT(DIFRFILE,DIFRIEN,DIFRFLG,DIFRNAME,DIFRFIA,DIFRTA,DIFRLST,DIFRMSGR) ;
 ;FILE,IEN,FLAGS,PKGNAME,FIA_ARRAY,TARGET_ARRAY,RECORD_LIST,MSG_ROOT
 ;FILE=FILE NUMBER can only be:.5,.4,.401,.402,.403
 ;                            (.404 automatically comes with .403)
 ;     (Required) -
 ;                  Forms           .403   ^DIST(.403,   "DIST(.403,"
 ;                  Blocks          .404   ^DIST(.404,   "DIST(.404,"
 ;                  Input Template  .402   ^DIE(         "DIE"
 ;                  Print Template  .4     ^DIPT(        "DIPT"
 ;                  Sort Template   .401   ^DIBT(        "DIBT"
 ;                  Functions       .5     ^DD("FUNC",   "FUN"
 ;                  Dialog          .84    ^DI(.84,      ????
 ;
 ;                  Note: Blocks pointed to by Forms
 ;                        are automatically sent
 ;*
 ;IEN=INTERNAL ENTRY NUMBER - DA
 ;    (Required if LIST_ARRAY is not passed) - Identifies
 ;                 the internal entry number for the
 ;                 EDE being exported.
 ;*
 ;FLAGS="S" Strip Security Codes in Transport Structure (Do not send security codes for Forms and Templates)
 ;*
 ;PKGNAME=Package Name
 ;    (Required) - Identifies the unique key subscript
 ;                 in the export target array.
 ;*
 ;FIA_ARRAY="FIA"_ARRAY_INPUT_ARRAY_ROOT  * *NO LONGER USED* *
 ;    (Optional) - Close Input Array Reference
 ;    See DIFROM SERVER documentation for FIA array structure
 ;    definitions.  If undefined Target Array Root will be used
 ;    to append the "FIA" subscript  Default will be
 ;    ^XTMP("XPDT",DIFRNAME,"FIA")
 ;*
 ;TARGET_ARRAY=CLOSED_OUTPUT_ARRAY_ROOT
 ;    (Optional) - Closed Output Array Reference where the data will
 ;    be retuned to be temporarily stored for distribution.
 ;    ^XTMP("XPDT",DIFRNAME,"KRN") will be default.
 ;*
 ;LIST_ARRAY=LIST OF IENs PASSED BY VALUE
 ;    (Required if ENTRY not passed) - Closed Array
 ;    Reference where records for this type of template
 ;    exist.  Nodes can contain ,0).  If +value is greater
 ;    than 0 it is used, otherwise the subscript is
 ;    used as the IEN.
 ;*
 ;MSG_ROOT=CLOSED ARRAY REFERENCE
 ;    (Optional) - Closed array reference where messages such as
 ;    errors will be returned.  If not passed, decendents of ^TMP
 ;    will be used.
 ;*
 I '$D(DIQUIET) N DIQUIET S DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1
 I $G(U)'="^"!($G(DT)'>0)!($G(DTIME)'>0)!('$D(DUZ)) D DT^DICRW
 I $G(DIFRNAME)']"" D BLD^DIALOG(9530) Q
 D
 .N X
 .S X=DIFRFILE
 .I X=.5!(X=.4)!(X=.401)!(X=.402)!(X=.403)!(X=.84) Q
 .S DIFRFILE=0
 .Q
 I DIFRFILE'>0 D BLD^DIALOG(9531) Q
 I $G(DIFRTA)="" S DIFRTA=$NA(^XTMP("XPDT",DIFRNAME,"KRN"))
 ;*
 ;        * *DIFRFIA NO LONGER USED* *
 ;S DIFRFIA=$G(DIFRFIA) S:DIFRFIA="" DIFRFIA=$NA(^XTMP("XPDT",DIFRNAME,"FIA"))
 ;I '$D(@DIFRFIA) D BLD^DIALOG(9501) Q
 ;*
 I $G(DIFRIEN)'>0&($G(DIFRLST)="") D BLD^DIALOG(9531) Q
 I $G(DIFRIEN)'>0,$D(@DIFRLST)'>9 D BLD^DIALOG(9532) Q
 S DIFRFLG=$G(DIFRFLG)
 N DIFRFNAM
 S DIFRFNAM=$P($P(".4;PRINT TEMPLATE^.401;SORT TEMPLATE^.402;INPUT TEMPLATE^.403;FORM^.404;BLOCK^.5;FUNCTION^.84;DIALOG",DIFRFILE_";",2),"^")
 D EDEOUT^DIFROMS5
 G EXIT
 ;
EXIT I $G(DIFRMSGR)]"" D CALLOUT^DIEFU(DIFRMSGR)
 Q
