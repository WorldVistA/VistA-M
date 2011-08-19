EASEZF1A ;ALB/ma-Filing 1010EZ Data to Patient Database(AO) ;11/09/04  13:07
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**57**;Nov 9, 2004
 ;
 Q
 ; File value "V(ietnam)" in Patient File #2
 ;  in field "Agent Orange Location" #3213
 ;  if answer is "Y(es)" in the field "Agent Orange exposure"
 ;  and File NULL if "N(o)"
F32102(EASAPP,EASDFN,EASDATA) ; File Value to Patient File #2
 ;input  EASAPP = ien to file #712
 ;       EASDFN = ien to #2
 ;       EASDATA = Agent Orange Exposure ("Y/N")
 ;
 N EZAOL,EZIENS
 S EZIENS=EASDFN_","
 S EZAOL(EASAPP,2,EZIENS,.3213)=$S(EASDATA["Y":"V",1:"")
 D FILE^DIE("","EZAOL("_EASAPP_")","ERR")
 Q
