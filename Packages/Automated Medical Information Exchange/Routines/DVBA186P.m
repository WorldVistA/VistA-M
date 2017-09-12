DVBA186P ;ALB/DJS - DVBA*2.7*186 POST-INIT ROUTINE ; 8/27/13
 ;;2.7;AMIE;**186**;Apr 10, 1995;Build 21
 ;
 Q  ;NO DIRECT ENTRY
 ;
POST ; Main entry point for post-int item
 ; Populate VLER DAS URL parameter definitions  
 ;
 N DVBERR
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VLER DAS CH3 URL","https://CAPRIAuthSvrTest.domain.ext:7003/CapriProxyServlet")
 D UPDMSG("DVBAB CAPRI VLER DAS CH3 URL",DVBERR)
 S DVBERR=$$ENXPAR("PKG","DVBAB CAPRI VLER DAS PROD URL","https://CAPRIAuthSvrProd.domain.ext:7003/CapriProxyServlet")
 D UPDMSG("DVBAB CAPRI VLER DAS PROD URL",DVBERR)
 ;
POST2 ; Create record to add & update file
 ; This TAG adds an entry to the REMOTE APPLICATION file (#8994.5) for VLER DAS - CAPRI
 N IEN,OPTNM,ARY,OPTIEN
 S IEN="" F  S IEN=$O(^DIC(19,IEN)) Q:IEN=""  D
 . S OPTNM=$P($G(^DIC(19,IEN,0)),U,1) Q:OPTNM'="DVBA CAPRI GUI"  S OPTIEN=IEN
 S ARY(8994.5,"?+1,",.01)="VLER DAS-CAPRI"  ;Remote application name
 S ARY(8994.5,"?+1,",.02)=OPTIEN  ;Context option IEN FOR "DVBA CAPRI GUI"
 S ARY(8994.5,"?+1,",.03)=">:6IZRxZG-axn7]oX3S"  ;Application code
 S ARY(8994.51,"?+2,?+1,",.01)="S"  ;Callback type
 S ARY(8994.51,"?+2,?+1,",.02)=-1  ;Callback port
 S ARY(8994.51,"?+2,?+1,",.03)="XXX"  ;Callback server
 D UPDATE^DIE("","ARY","","MSG")  ;Update Remote Application file with new VLER DAS-CAPRI entry
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
 ;
ENXPAR(DVBENT,DVBPAR,DVBVAL) ;Update Parameter values
 ;
 ;  Input:
 ;    DVBENT - Parameter Entity
 ;    DVBPAR - Parameter Name
 ;    DVBVAL - Parameter Value
 ;
 ;  Output:
 ;    Function value - returns "0" on success;
 ;                     otherwise returns error#^errortext
 ;
 N DVBERR
 D EN^XPAR(DVBENT,DVBPAR,1,DVBVAL,.DVBERR)
 Q DVBERR
 ; 
UPDMSG(DVBPAR,DVBERR) ;display update message
 ;
 ;  Input:
 ;    DVBPAR - Parameter Name
 ;    DVBERR - Parameter Update result
 ;
 ;  Output: none
 ; 
 I DVBERR D
 . D MES^XPDUTL(DVBPAR_" update FAILURE.")
 . D MES^XPDUTL("  Failure reason: "_DVBERR)
 E  D
 . D MES^XPDUTL(DVBPAR_" update SUCCESS.")
 Q
 ;
