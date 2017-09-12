DVBA185P ;ALB/DJS - PATCH DVBA*2.7*185 POST-INSTALL ROUTINE;21-JUN-2013
 ;;2.7;AMIE;**185**;Apr 10, 1995;Build 18
 ; This routine adds an entry to the REMOTE APPLICATION file (#8994.5) for CCR-CAPRI
 Q
 ;
POST ; Create record to add & update file
 ;
 S IEN="" F  S IEN=$O(^DIC(19,IEN)) Q:IEN=""  D
 . S OPTNM=$P($G(^DIC(19,IEN,0)),U,1) Q:OPTNM'="DVBA CAPRI GUI"  S OPTIEN=IEN
 S ARY(8994.5,"?+1,",.01)="CCR-CAPRI"  ;Remote application name
 S ARY(8994.5,"?+1,",.02)=OPTIEN  ;Context option IEN FOR "DVBA CAPRI GUI"
 S ARY(8994.5,"?+1,",.03)="J\f0LPa:]m#vpVZo2i[D"  ;Application code
 S ARY(8994.51,"?+2,?+1,",.01)="S"  ;Callback type
 S ARY(8994.51,"?+2,?+1,",.02)=-1  ;Callback port
 S ARY(8994.51,"?+2,?+1,",.03)="XXX"  ;Callback server
 D UPDATE^DIE("","ARY","","MSG")  ;Update Remote Application file with new CCR-CAPRI entry
    I $G(MSG("DIERR"))'="" D
 .N ERR,LN,LN2
 .S (ERR,LN2)=0
 .F  S ERR=+$O(MSG("DIERR",ERR)) Q:'ERR  D
 ..S LN=0
 ..F  S LN=+$O(MSG("DIERR",ERR,"TEXT",LN)) Q:'LN  D
 ...S LN2=LN2+1
 ...S X(LN2)=MSG("DIERR",ERR,"TEXT",LN)
 ...D BMES^XPDUTL(X(LN2))
 Q
