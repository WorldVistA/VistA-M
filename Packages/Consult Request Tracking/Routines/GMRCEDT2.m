GMRCEDT2 ;SLC/JFR,DCM - RESUBMIT A CANCELLED CONSULT ;10/09/15  13:08
 ;;3.0;CONSULT/REQUEST TRACKING;**1,5,12,15,22,33,66,46,73,85**;DEC 27, 1997;Build 3
 ;
 ;ICRs in use: #2053 (DIE), #2056 (GET1^DIQ), #872 (ORD(101))
 ;patch 85 removed call to $$PDOK^GMRCEDT4
 ;
EN(GMRCO,COMNO) ;entry point into the routine
 ;COMNO=CMDA from ^GMRCEDT2=comments array IEN from ^GMR(123,IEN,40,
 ;GMRCO=IEN of the consult from file 123
 I $S($P(^GMR(123,GMRCO,0),"^",12)'=13:1,$D(GMRCRSUB):1,1:0) D  Q
 .S GMRCMSG="***     Consult Has Already Been Resubmitted   ***"
 .S GMRCMSG(1)="***  No Further Action Is Required Or Allowed ***"
 .D EXAC^GMRCADC(.GMRCMSG)
 .S:'$D(GMRCRSUB) GMRCRSUB=1
 .Q
 N MSG S MSG=$$EDRESOK(GMRCO)
 I '+MSG D EXAC^GMRCADC($P(MSG,U,2)) Q
 I '$D(GMRCGUIF) W !,"Resubmitting Consult ... One moment please ..."
 K ^TMP("GMRCSUB",$J) S ^TMP("GMRCSUB",$J)=0
 I $D(GMRCEDT(1)) S ^TMP("GMRCSUB",$J,1)="GMRCSS^"_+GMRCEDT(1)
 I $D(GMRCED(1)) D
 . I $P(GMRCED(1),U)=$P(^GMR(123,+GMRCO,0),U,8) K GMRCED(1) Q
 . S ^TMP("GMRCSUB",$J,2)="GMRCPROC^"_+GMRCED(1)_";GMR(123.3,"
 I $D(GMRCED(2)) D
 . I $P(GMRCED(2),U)=$P(^GMR(123,+GMRCO,0),U,18) K GMRCED(2) Q
 . S ^TMP("GMRCSUB",$J,3)="GMRCION^"_$P(GMRCED(2),U)
 I $D(GMRCED(3)) D
 . I $P(GMRCED(3),U)=$P(^GMR(123,+GMRCO,0),U,9) K GMRCED(3) Q
 . S ^TMP("GMRCSUB",$J,4)="GMRCURG^"_$P(GMRCED(3),U)
 I $D(GMRCED(4)) D
 . I $P(GMRCED(4),U)=$P(^GMR(123,+GMRCO,0),U,10) K GMRCED(4) Q
 . S ^TMP("GMRCSUB",$J,5)="GMRCPL^"_$P(GMRCED(4),U)
 I $D(GMRCED(5)) D  ;wat/66 add early date
 . I $P(GMRCED(5),U)=$P(^GMR(123,+GMRCO,0),U,24) K GMRCED(5) Q
 . S ^TMP("GMRCSUB",$J,6)="GMRCERDT^"_$P(GMRCED(5),U)
 I $D(GMRCED(6)) D
 . I $P(GMRCED(6),U)=$P(^GMR(123,+GMRCO,0),U,11) K GMRCED(6) Q
 . I '$L($P(GMRCED(6),U)) S $P(GMRCED(6),U)="@"
 . S ^TMP("GMRCSUB",$J,7)="GMRCATN^"_$P(GMRCED(6),U)
 I $D(GMRCED(7)) D
 . I GMRCED(7)=$G(^GMR(123,+GMRCO,30)) K GMRCED(7) Q
 . I $P(GMRCED(7),U)_" ("_$P(GMRCED(7),U,2)_")"=$G(^GMR(123,GMRCO,30)) K GMRCED(7) Q
 . I '$L($P(GMRCED(7),U)) S $P(GMRCED(7),U,1,2)="@"
 . S ^TMP("GMRCSUB",$J,8)="GMRCDIAG^"_GMRCED(7)
 I $D(^TMP("GMRCED",$J,20)) S ^TMP("GMRCSUB",$J,20)="GMRCRFQ^" D
 . N ND S ND=0
 . F  S ND=$O(^TMP("GMRCED",$J,20,ND)) Q:'ND  D
 .. S ^TMP("GMRCSUB",$J,20,ND)=^TMP("GMRCED",$J,20,ND,0)
 I $D(^TMP("GMRCED",$J,40)) S ^TMP("GMRCSUB",$J,40)="COMMENT^" D
 . N ND S ND=0
 . F  S ND=$O(^TMP("GMRCED",$J,40,ND)) Q:'ND  D
 .. S ^TMP("GMRCSUB",$J,40,ND)=^TMP("GMRCED",$J,40,ND,0)
 D FILE^GMRCGUIC(+GMRCO,$NAME(^TMP("GMRCSUB",$J)),1)
 N GMRCADUZ S GMRCADUZ=""
 S DFN=$P(^GMR(123,+GMRCO,0),"^",2),GMRCPROV=$P(^(0),"^",14)
 S GMRCTYPE=$P(^GMR(123,+GMRCO,0),U,17),GMRCTRLC="XX",VISIT="",RMBED=""
 S DIE="^GMR(123,",DA=+GMRCO,DR="8////^S X=5;9////^S X=11" D ^DIE
 K DIE,DA,DR
 S GMRCRSUB=1
 S GMRCURG=$P(^GMR(123,+GMRCO,0),"^",9)
 I +$P(^GMR(123,+GMRCO,0),"^",11) S GMRCADUZ($P(^(0),"^",11))=""
 S GMRCSVC=$P(^GMR(123,+GMRCO,0),"^",5)
 I +GMRCSVC D
 . D EN^GMRCT(GMRCSVC)
 S GMRCORTX="Resubmitted consult "_$$ORTX^GMRCAU(+GMRCO)_$S(+GMRCURG:" ("_$P(^ORD(101,+GMRCURG,0),"^",2)_")",1:"")
 K GMRCFL,GMRCPROV,GMRCTYPE,GMRCTRLC,VISIT,RMBED,GMRCOM,GMRCURG
 K GMRCSVC,GMRCORTX
 Q
EDRESOK(GMRCDA) ;check cslt or proc to see if still resubmittable
 ; if procedure is inactive or no services, not resubmittable
 ; if service is grouper or disabled, not resubmittable
 N MSG,GMRC
 Q:'$D(^GMR(123,+$G(GMRCDA),0)) "0^Invalid Consult Number"
 I $P($G(^GMR(123,+GMRCDA,12)),U,5)="F" D  Q MSG
 . S MSG="0^This inter-facility cconsult may only be resubmitted by the"
 . S MSG=MSG_" ordering facility."
 S GMRC(0)=^GMR(123,+GMRCDA,0)
 I '$P(GMRC(0),U,8) D  Q MSG
 . I "19"[+$P(^GMR(123.5,+$P(GMRC(0),U,5),0),U,2) D  Q
 .. S MSG="0^The service for this Consult is no longer orderable."
 . S MSG=1
 S MSG=1
 I "19"[+$P(^GMR(123.5,+$P(GMRC(0),U,5),0),U,2) S MSG=0
 I '$L($$GET1^DIQ(123.3,+$P(GMRC(0),U,8),.01)) S MSG=0
 I +$$GET1^DIQ(123.3,+$P(GMRC(0),U,8),.02) S MSG=0
 I '$D(^GMR(123.3,+$P(GMRC(0),U,8),2,"B",+$P(GMRC(0),U,5))) S MSG=0
 I MSG=0 D
 . S MSG=MSG_"^This procedure may no longer be ordered or the service "
 . S MSG=MSG_"may no longer perform it."
 Q MSG
