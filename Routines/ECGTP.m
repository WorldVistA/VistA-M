ECGTP ;ALB/CMF-driver for generic table printer;9 Aug 2009
 ;;2.0; EVENT CAPTURE ;**100**;8 May 96;Build 21
EN ; entry point - NOT FOR INTERACTIVE
 Q
 ;
START ; entry when queued
 U IO
 D PRINT
 D END
 Q
 ;
PRINT  ; print the object
 N X
 D METHOD^ECOB40(.X,ECOBHNDL_".Execute")
 Q
 ;
END   ; cleanup
 D DESTROY^ECOB40(ECOBHNDL)
 Q
 ;
