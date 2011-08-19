GMVGETQL ;HOIFO/FT-GET QUALIFIER INFORMATION ;2/26/07  16:27
 ;;5.0;GEN. MED. REC. - VITALS;**23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ; <None> 
 ;
 ; This routine supports the following IAs:
 ; #5048 - FIELD, GETIEN, VT entry points     (supported)
 ;
FIELD(GMVIEN,GMVFIELD,GMVFMT) ; Returns the qualifier values
 ;  Input:   GMVIEN - File 120.52 internal entry number (required)
 ;         GMVFIELD - field you want (required)
 ;                    1 = name(.01)
 ;                    2 = Synonym (.02)
 ;                    3 = VUID (99.99)
 ;                    4 = Master Entry For VUID
 ;           GMVFMT - return internal or external value (optional)
 ;                    I fo Internal, E for External
 ;                    default is E
 ; Output: field value or -1 if there is an error
 ;
 I $G(GMVIEN)="" Q -1
 I $G(GMVFIELD)="" Q -1
 S GMVFMT=$E($G(GMVFMT,"E"))
 S GMVFMT=$$UPPER^GMVGETVT(GMVFMT)
 S GMVFMT=$S(GMVFMT="I":"I",1:"E")
 I GMVFIELD=1 Q $$GET1^DIQ(120.52,+GMVIEN,.01,GMVFMT)
 I GMVFIELD=2 Q $$GET1^DIQ(120.52,+GMVIEN,.02,GMVFMT)
 I GMVFIELD=3 Q $$GET1^DIQ(120.52,+GMVIEN,99.99,GMVFMT)
 I GMVFIELD=4 Q $$GET1^DIQ(120.52,+GMVIEN,99.96,GMVFMT)
 Q -1
 ;
GETIEN(GMVX,GMVY) ; Returns the qualifier IEN
 ;  Input: GMVX - File 120.52 look up value (required)
 ;         GMVY - index type (required)
 ;                1 = name (.01)
 ;                2 = VUID (99.99)
 ; Output: File 120.52 internal entry number
 ;         or null if not found
 ;         or -1 if there is an error
 ;
 I $G(GMVX)="" Q -1
 I $G(GMVY)="" Q -1
 I GMVY=1 Q $O(^GMRD(120.52,"B",GMVX,0))
 I GMVY=2 Q $O(^GMRD(120.52,"AVUID",GMVX,0))
 Q -1
 ;
VT(RESULT,GMVIEN) ; Returns the vital types and category values for a qualifier
 ;  Input: RESULT = Array name to return data in (required)
 ;         GMVIEN = File 120.52 internal entry number (required)
 ; Output: RESULT(0)=piece1
 ;         RESULT(n)=piece2^piece3^piece4^piece5
 ;         where piece1 = number of entries found or -1 if an error
 ;               piece2 = File 120.51 entry number
 ;               piece3 = File 120.51 .01  field value
 ;               piece4 = File 120.53 entry number
 ;               piece5 = File 120.53 .01 field value
 ;                    n = sequential number starting with 1
 ;
 N GMVCATE,GMVCATI,GMVCNT,GMVLOOP,GMVNODE,GMVTE,GMVTI
 S (GMVCNT,GMVLOOP)=0
 I $G(GMVIEN)="" Q
 ; check if RESULT is defined?
 F  S GMVLOOP=$O(^GMRD(120.52,GMVIEN,1,GMVLOOP)) Q:'GMVLOOP  D
 .S GMVNODE=$G(^GMRD(120.52,GMVIEN,1,GMVLOOP,0))
 .Q:GMVNODE=""
 .S GMVTI=$P(GMVNODE,U,1)
 .Q:'GMVTI
 .S GMVTE=$$FIELD^GMVGETVT(GMVTI,1,"E")
 .Q:GMVTE=""
 .S GMVCATI=$P(GMVNODE,U,2)
 .S GMVCATE=""
 .I GMVCATI S GMVCATE=$$FIELD^GMVGETC(GMVCATI,1,"E")
 .S GMVCNT=GMVCNT+1
 .S RESULT(GMVCNT)=GMVTI_U_GMVTE_U_GMVCATI_U_GMVCATE
 .Q
 S RESULT(0)=GMVCNT
 Q
 ;
