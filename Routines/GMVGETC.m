GMVGETC ;HOIFO/FT-GET CATEGORY INFORMATION ;2/26/07  15:32
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
 ; This routine supports the following IAs:
 ; #5050 - FIELD, GETIEN, VT entry points    (supported)
 ;
FIELD(GMVIEN,GMVFIELD,GMVFMT) ; Returns the FILE 120.53 value
 ;  Input:   GMVIEN = File 120.53 internal entry number (required)
 ;         GMVFIELD = field you want (required)
 ;                    1 = Name (.01)
 ;                    2 = VUID (99.99)
 ;                    3 = Master Entry For VUID (99.98)
 ;           GMVFMT = return internal or external value (optional)
 ;                    I for Internal, E for External
 ;                    default is E
 ; Output: field value or -1 if there is an error
 ;
 I $G(GMVIEN)="" Q -1
 I $G(GMVFIELD)="" Q -1
 S GMVFMT=$G(GMVFMT)
 S GMVFMT=$$UPPER^GMVGETVT(GMVFMT)
 S GMVFMT=$S(GMVFMT="I":"I",1:"E")
 I GMVFIELD=1 Q $$GET1^DIQ(120.53,+GMVIEN,.01,GMVFMT)
 I GMVFIELD=2 Q $$GET1^DIQ(120.53,+GMVIEN,99.99,GMVFMT)
 I GMVFIELD=3 Q $$GET1^DIQ(120.53,+GMVIEN,99.98,GMVFMT)
 Q -1
 ;
GETIEN(GMVX,GMVY) ; Returns the qualifier IEN
 ;  Input: GMVX - File 120.53 look up value (required)
 ;         GMVY - index type (required)
 ;                1 - Name (.01)
 ;                2 - VUID (99.99)
 ; Output: File 120.53 internal entry number,
 ;         or null if not found,
 ;         or -1 if there is an error
 N GMVIEN
 I $G(GMVX)="" Q -1
 I $G(GMVY)="" Q -1
 I GMVY=1 Q $O(^GMRD(120.53,"B",GMVX,0))
 I GMVY=2 Q $O(^GMRD(120.53,"AVUID",GMVX,0))
 Q -1
 ;
VT(RESULT,GMVIEN) ; Returns the vital types (field #1) values
 ;  Input: RESULT = Array name to return data in (required)
 ;         GMVIEN = File 120.53 internal entry number (required)
 ; Output: RESULT(0)=piece1
 ;         RESULT(n)=piece2^piece3
 ;
 ;         where piece1 = number of entries found or -1 if an error
 ;               piece2 = FILE 120.51 entry number
 ;               piece3 = FILE 120.51, Field .01 external value
 ;                    n = a sequential number starting with 1
 ;
 N GMVCNT,GMVLOOP,GMVNODE,GMVVTE,GMVVTI
 ; What if RESULT is not defined?
 S (GMVCNT,GMVLOOP,RESULT(0))=0
 I $G(GMVIEN)="" Q
 F  S GMVLOOP=$O(^GMRD(120.53,GMVIEN,1,GMVLOOP)) Q:'GMVLOOP  D
 .S GMVNODE=$G(^GMRD(120.53,GMVIEN,1,GMVLOOP,0))
 .Q:GMVNODE=""
 .S GMVVTI=$P(GMVNODE,U,1)
 .Q:'GMVVTI
 .S GMVVTE=$$FIELD^GMVGETVT(GMVVTI,1,"E")
 .Q:GMVVTE=-1
 .S GMVCNT=GMVCNT+1
 .S RESULT(GMVCNT)=GMVVTI_U_GMVVTE
 .Q
 S RESULT(0)=GMVCNT
 Q
 ;
