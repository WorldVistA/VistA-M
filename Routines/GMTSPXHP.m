GMTSPXHP ; SLC/SBW - PCE Location of Home component ; 08/27/2002
 ;;2.7;Health Summary;**56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  1254  LOC^PXRHS13
 ;   DBIA 10011  ^DIWP
 ;   DBIA 10029  ^DIWW
 ;                        
HOMELOC ; Location of Home
 N GMTSI,DIWL,DIWR,DIWF,X K ^UTILITY($J,"W"),^TMP("PXLOC",$J)
 D LOC^PXRHS13(DFN) Q:'$D(^TMP("PXLOC",$J))
 S DIWL=1,DIWR=80,DIWF="W",GMTSI=0
 F  S GMTSI=$O(^TMP("PXLOC",$J,GMTSI)) Q:'GMTSI  D  Q:$D(GMTSQIT)
 . S X=^(GMTSI) D CKP^GMTSUP Q:$D(GMTSQIT)  D ^DIWP
 D CKP^GMTSUP Q:$D(GMTSQIT)  D ^DIWW
 K ^TMP("PXLOC",$J)
 Q
