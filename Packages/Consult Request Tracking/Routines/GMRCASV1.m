GMRCASV1 ;SLC/JFR - HIERARCHY MGMT cont'd ; 01/10/02 21:34
 ;;3.0;CONSULT/REQUEST TRACKING;**18,15,23,22,42**;DEC 27, 1997
 ;
 ; This routine invokes IA #3252
 ;
 Q  ; don't start at the top
GUI(GMRCARR,GMRCSTRT,GMRCWHY,GMRCSYN,GMRCO) ;;return CSLT services for GUI
 ;Input:
 ; GMRCARR - passed in as the array to return results in
 ; GMRCSTRT- service name or ien to begin building from
 ; GMRCWHY - 0 for display, 1 for forwarding or ordering
 ; GMRCSYN - Boolean: 1=return synonyms, 0=do not
 ; GMRCO   - consult ien from file 123
 ;Output: Array formatted as follows-
 ;      svc ien^svc name or syn^parent^has children^svc usage
 ;
 N GMRCDG,GMRCGRP,GMRCTO
 ;Following line modified to accept the Name as well as the IEN for a Service, TDP - 2/9/2005
 S GMRCDG=$$FIND1^DIC(123.5,,"AX",GMRCSTRT,"B") I 'GMRCDG Q
 S GMRCTO=GMRCWHY
 D SERV1^GMRCASV I '$D(^TMP("GMRCSLIST",$J)) Q
 I '$G(GMRCSYN) G GUIQ ;M @GMRCARR=^TMP("GMRCSLIST",$J) Q  ;no synonyms needed
 N GMRC,GMRCSVC,GMRCS,NEXT,PIEC
 S GMRC=0,NEXT=$O(^TMP("GMRCSLIST",$J," "),-1)+1
 F  S GMRC=$O(^TMP("GMRCSLIST",$J,GMRC)) Q:'GMRC  Q:$P(^TMP("GMRCSLIST",$J,GMRC),U,5)="S"  D
 . I $P(^TMP("GMRCSLIST",$J,GMRC),U,5)=1 Q
 . S GMRCSVC=+^TMP("GMRCSLIST",$J,GMRC)
 . S GMRCS=0
 . F  S GMRCS=$O(^GMR(123.5,GMRCSVC,2,GMRCS)) Q:'GMRCS  D
 .. S PIEC(1)=GMRCSVC
 .. S PIEC(2)=$P(^GMR(123.5,GMRCSVC,0),U)
 .. S PIEC(2)=^GMR(123.5,GMRCSVC,2,GMRCS,0)_"  <"_PIEC(2)_">"
 .. S ^TMP("GMRCSLIST",$J,NEXT)=PIEC(1)_"^"_PIEC(2)_"^^^S"
 .. S NEXT=NEXT+1
 .. Q
 . Q
GUIQ M @GMRCARR=^TMP("GMRCSLIST",$J)
 K ^TMP("GMRCS",$J),^TMP("GMRCSLIST",$J)
 Q
 ;
PAGE(PG) ;print header and increment page
 S PG=PG+1
 W !,"Consult Hierarchy list",?30,$$HTE^XLFDT($H),?60,"Page: ",PG
 W !,$$REPEAT^XLFSTR("-",78)
 Q
 ;
QUEUE ; queue up the print
 N ZTRTN,ZTSK,ZTIO,ZTDTH,ZTDESC
 S ZTRTN="PRTLST^GMRCASV",ZTDESC="Consult Service Hierarchy List"
 S ZTIO=ION,ZTDTH=$H
 D ^%ZTLOAD
 I $G(ZTSK) W !,"Queued to Print, Task # ",ZTSK
 E  W !,"Sorry, Try again Later"
 Q
