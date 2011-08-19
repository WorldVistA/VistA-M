GMVGETVT ;HOIFO/FT-GET VITAL TYPE INFORMATION ;2/26/07  15:35
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls          (supported)
 ;
 ; This routine supports the following IAs:
 ; #5047 - FIELD, GETIEN, LIST, TYPES entry points   (supported)
 ;
FIELD(GMVIEN,GMVFIELD,GMVFMT) ; Returns the vital type (FILE 120.51) values
 ;  Input:   GMVIEN = File 120.51 internal entry number (required)
 ;         GMVFIELD = field you want (required)
 ;                    1 = Name (.01)
 ;                    2 = Abbreviation (1)
 ;                    3 = PCE Abbreviation (7)
 ;                    4 = VUID (99.99) 
 ;                    5 = Master Entry For VUID (99.98)
 ;           GMVFMT = return internal or external value (optional)
 ;                    I for Internal, E for External
 ;                    default is E
 ; Output: field value or -1 if there is an error
 ;
 I $G(GMVIEN)="" Q -1
 I $G(GMVFIELD)="" Q -1
 S GMVFMT=$G(GMVFMT)
 S GMVFMT=$$UPPER(GMVFMT)
 S GMVFMT=$S(GMVFMT="I":"I",1:"E")
 I GMVFIELD=1 Q $$GET1^DIQ(120.51,+GMVIEN,.01,GMVFMT)
 I GMVFIELD=2 Q $$GET1^DIQ(120.51,+GMVIEN,1,GMVFMT)
 I GMVFIELD=3 Q $$GET1^DIQ(120.51,+GMVIEN,7,GMVFMT)
 I GMVFIELD=4 Q $$GET1^DIQ(120.51,+GMVIEN,99.99,GMVFMT)
 I GMVFIELD=5 Q $$GET1^DIQ(120.51,+GMVIEN,99.98,GMVFMT)
 Q -1
 ;
GETIEN(GMVX,GMVY) ; Returns the vital type IEN
 ;  Input:   GMVX - File 120.51 look up value (required)
 ;           GMVY - index type (required)
 ;                  1 - Name (.01)
 ;                  2 - Abbreviation (1)
 ;                  3 - PCE Abbreviation (7)
 ;                  4 - VUID (99.99)
 ; Output: File 120.51 internal entry number,
 ;         or null if not found, 
 ;         or -1 if there is an error
 I $G(GMVX)="" Q -1
 I $G(GMVY)="" Q -1
 ;S GMVX=$$UP^XLFSTR(GMVX) ;make this an input parameter?
 I GMVY=1 Q $O(^GMRD(120.51,"B",GMVX,0))
 I GMVY=2 Q $O(^GMRD(120.51,"C",GMVX,0))
 I GMVY=3 Q $O(^GMRD(120.51,"APCE",GMVX,0))
 I GMVY=4 Q $O(^GMRD(120.51,"AVUID",GMVX,0))
 Q -1
 ;
LIST(GMVARRAY,GMVFMT) ; Return list of supported vital types
 ;  Input:   GMVARRAY - Array name to return data in (required)
 ;             GMVFMT - return internal or external value (optional)
 ;                      I for Internal or E for External
 ;                      default is I
 ; Output: GMVARRAY(0)=piece1
 ;         GMVARRAY(n)=piece2^piece3^piece4^piece5^piece6^piece7
 ;
 ; where: piece1 = number of entries found
 ;        piece2 = FILE 120.51 internal entry number (.001)
 ;        piece3 = Name (.01)
 ;        piece4 = Abbreviation (1)
 ;        piece5 = PCE Abbreviation (7)
 ;        piece6 = VUID (99.99)
 ;        piece7 = Master Entry for VUID (99.98)
 ;             n = a sequential number starting with 1
 ;
 N GMVCNT,GMVFLD,GMVIEN,GMVLOOP,GMVNAME,GMVNODE,GMVTYPES
 ; check if GMVARRAY is defined?
 S GMVFMT=$G(GMVFMT)
 S GMVFMT=$$UPPER(GMVFMT)
 S GMVFMT=$S(GMVFMT="I":"I",1:"E")
 S GMVCNT=0,GMVNAME=""
 S GMVTYPES=$$TYPES()
 F  S GMVNAME=$O(^GMRD(120.51,"B",GMVNAME)) Q:GMVNAME=""  D
 .S GMVIEN=0
 .F  S GMVIEN=$O(^GMRD(120.51,"B",GMVNAME,GMVIEN)) Q:'GMVIEN  D
 ..S GMVNODE=$G(^GMRD(120.51,GMVIEN,0))
 ..Q:GMVNODE=""
 ..Q:GMVTYPES'[$P(GMVNODE,U,2)
 ..F GMVLOOP=1:1:5 D
 ...S GMVFLD(GMVLOOP)=$$FIELD(GMVIEN,GMVLOOP,GMVFMT)
 ..S GMVCNT=GMVCNT+1
 ..;GMVARRAY(n)=ien^name^abbrev^pce abbrev^vuid^master entry for vuid
 ..S GMVARRAY(GMVCNT)=GMVIEN_U_GMVFLD(1)_U_GMVFLD(2)_U_GMVFLD(3)_U_GMVFLD(4)_U_GMVFLD(5)
 ..Q
 .Q
 S GMVARRAY(0)=GMVCNT
 Q
TYPES() ; Returns list of abbreviations for the vitals types currently
 ; tracked
 ;  Input: none
 ; Output: string of vital type abbreviations (File 120.51, Field 1
 ;         values) separated by up-arrows
 ;
 Q "BP^CG^CVP^HT^P^PN^PO2^R^T^WT"
 ;
UPPER(GMVX) ; Change text to uppercase
 ;  Input: GMVX - string
 ; Output: string converted to uppercase
 S GMVX=$G(GMVX)
 Q $$UP^XLFSTR(GMVX)
 ;
