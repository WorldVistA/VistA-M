DG53705E ;ALB/TMK - DG*5.3*705 Environment check ; 05-APR-2006
 ;;5.3;Registration;**705**;Aug 13, 1993
 ;
EN ; Check for need to update
 Q
 ;
CKUPD() ; Check to see if update is necessary
 ; Return 1 if necessary, 0 if not necessary
 N HASDVB54,Z,ZERR,DIERR
 S HASDVB54=0
 D FIND^DIC(9.7,"","","X","DVB*4.0*54","","","","","Z","ZERR")
 I $G(Z("DILIST",0)),$S($G(^TMP("DG*5.3*705",$J))!$D(^DIC(2,"%","B","QAM",7))!$D(^DD(2,0,"PT",19000.00001,.01))!$D(^DD(2,0,"ID","GARB")):1,1:0) S HASDVB54=1
 D CLEAN^DILF
 Q HASDVB54
 ;
