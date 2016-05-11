HMPXGLAB ; ASMR/hrubovcak - Lab data retrieval ;Nov 05, 2015 15:27:37
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
LABTSTNM(HMPLTIEN) ;function, return NAME field (#.01) from LABORATORY TEST file (#60)
 ; IA 10054 - NAME can be read with FileMan
 ; HMPLTIEN - Lab Test IEN (required)
 Q:'($G(HMPLTIEN)>0) "ERROR: Lab Test IEN missing"
 ;
 N DA,DIC,DIQ,DR,FLAGS,HMPRSLT,HMPTSTNM
 S DIC=60,DR=".01",DA=HMPLTIEN,DIQ="HMPRSLT",DIQ(0)="E",FLAGS="E"
 D EN^DIQ1
 ;
 Q $G(HMPRSLT(60,HMPLTIEN,.01,"E"))
 ;
LRDFN(HMPDFN) ;function, return LRDFN from PATIENT file
 ;
 Q:'($G(HMPDFN)>0) ""  ; patient's DFN required
 ;
 N HMPDEMOG
 D TOP^HMPXGDPT("HMPDEMOG",HMPDFN,"63","I")  ; (#63) LABORATORY REFERENCE
 Q $G(HMPDEMOG(2,HMPDFN,63,"I"))
 ;
