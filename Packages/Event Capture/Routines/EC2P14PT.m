EC2P14PT ;ALB/JAP - PATCH EC*2.0*12 Post-Init Rtn ; 11/4/98
 ;;2.0; EVENT CAPTURE ;**14**;8 May 96
 ;
 ;delete the identifier on file #720.5
 K ^DD(720.5,0,"ID",.02)
 Q
