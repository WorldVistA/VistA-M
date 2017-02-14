HMPTIUL ;ASMR/HM/CK - RPC to display long list of titles;Mar 29, 2016 11:34:29
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;PER VA Directive 6402, this routine should not be modified
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; TIU NATIONAL TITLE LINK      5677
 Q
 ;
LONGLIST(Y) ;long list of titles
 ; .Y = Return list contains the IEN and NAME of the Document Class hierarchy
 ;        TITLE, DOCUMENT CLASS, CLASS - DE3566 added document class and class
 ; it will return all titles with restrictions with inactive titles removed 
 ;  e.g 622^ATTENDING  <CARDIOLOGY ATTENDING CONSULT>^618^CARDIOLOGY^3^PROGRESS NOTES^38^CLINICAL DOCUMENTS
 ;
 N CLASS,DA,DOCCLASS,I,PARNTDOC,PARENT,SN,STATUS,TITLE,X
 K Y  ; Y is the returned value
 S I=0,CLASS=0,TITLE=""
 F  S CLASS=$O(^TIU(8925.1,"ACL",CLASS)) Q:+CLASS'>0  D  ;ICR 5677 TIU NATIONAL TITLE LINK
 . F  S TITLE=$O(^TIU(8925.1,"ACL",CLASS,TITLE)) Q:TITLE=""  D
 . . S DA=0
 . . F  S DA=$O(^TIU(8925.1,"ACL",CLASS,TITLE,DA)) Q:+DA'>0  D
 . . . S SN=$G(^TIU(8925.1,DA,0)),STATUS=$P(SN,"^",7)
 . . . Q:STATUS'=11  ; return Active Titles only
 . . . ; DE3566 March 28, 2016 CK- return the Document Class hierarchy
 . . . ; get DOCUMENT CLASS - DE3566
 . . . S DOCCLASS("IEN")=+$$DOCCLASS^TIULC1(+DA)  ;ICR 3548
 . . . S DOCCLASS("NAM")=$P(^TIU(8925.1,DOCCLASS("IEN"),0),U)
 . . . ; get Parent of DOCUMENT CLASS - DE3566
 . . . S PARNTDOC("IEN")=+$$CLINDOC^TIULC1(+DA)
 . . . S PARNTDOC("NAM")=$P(^TIU(8925.1,PARNTDOC("IEN"),0),U)
 . . . ; get Parent Class of above - DE3566
 . . . S PARENT("IEN")=38
 . . . S PARENT("NAM")=$P(^TIU(8925.1,PARENT("IEN"),0),U)
 . . . ; Populate list of TIU Long List of Titles
 . . . S I=I+1,Y(I)=DA_U_TITLE_U_DOCCLASS("IEN")_U_DOCCLASS("NAM")_U_PARNTDOC("IEN")_U
 . . . S Y(I)=Y(I)_PARNTDOC("NAM")_U_PARENT("IEN")_U_PARENT("NAM")
 . . . ;DE3566 end of changes
 Q
 ;
