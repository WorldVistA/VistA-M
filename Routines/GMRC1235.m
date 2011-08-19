GMRC1235 ;BP/SBR - Input Transform for SERVICE USAGE field ; 11/5/2009
 ;;3.0;CONSULT/REQUEST TRACKING;**71**;DEC 27, 1997;Build 14
USAGE ;
 N CNT,PC,GMRCPROC,PROC
 S CNT=0
 I X=9!(X=1) D
 . S PC="" F  S PC=$O(^GMR(123.3,PC)) Q:PC=""  D
 . . I $D(^GMR(123.3,PC,2,"B",GMRCSRVC)) S GMRCPROC($P($G(^GMR(123.3,PC,0)),"^",1))=""
 I $D(GMRCPROC) D
 . D EN^DDIOL(,,"!")
    . D EN^DDIOL("WARNING:  By changing the service usage of this service,")
    . D EN^DDIOL("you are making it unselectable by the users.  The following")
    . D EN^DDIOL("procedure(s) contain this Service in the RELATED SERVICES")
    . D EN^DDIOL("field and should be edited to remove/replace this service")
    . D EN^DDIOL("as necessary:")
 . S PROC="" F  S PROC=$O(GMRCPROC(PROC)) Q:PROC=""  D EN^DDIOL("     "_PROC)
 . D EN^DDIOL(,,"!")
 Q
