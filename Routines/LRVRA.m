LRVRA ;DALOI/JMC-Lab Routine Data Verification by UID ;2/12/97  11:06
 ;;5.2;LAB SERVICE;**153,221,263**;Sep 27, 1994
 N LRANYAA,LRUID,LRNOP
 S LRANYAA=+$P($G(^LRO(68.2,LRLL,10,LRPROF,0)),"^",3)
 S LRUID="" D NEXT
 D
 . N X
 . S X=$S(+$P($G(^LAB(69.9,1,0)),U,7):+$P(^(0),U,7),1:1)
 . S LRTM60=9999999-$$FMADD^XLFDT(DT,-X)
 F  D  Q:LREND
 . K LRTEST,C5,LRSET,LRLDT,DIC,LRNM,LRNG,LRDL,LRDEL,T,LRFP,LRAB,LRVER,Y,Z
 . S LRCFL="",EAMODE=1
 . N DIR,DIRUT,DTOUT,DUOUT,X,Y
 . D WLN I $G(LRNOP) D NEXT Q
 . D ^LRVR1,NEXT
 Q
 ;
WLN ; Select next accession (UID) to work with.
 W ! S LRNOP=0
 K DIR
 S DIR(0)="FO^1:10",DIR("A")="Unique Identifier",DIR("?")="^D LW^LRVRA"
 I $L(LRUID) S DIR("B")=LRUID
 D ^DIR
 I $D(DIRUT) D STOP^LRVR S LRNOP=1 Q
 S LRUID=Y
 I LRUID'?1.10N S LRUID=$$UP^XLFSTR(LRUID)
 I $L(LRUID)<10 S LRUID=$$LWP(LRUID)
 I $L(LRUID)<10 S LRUID="" G WLN
 D UID
 I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) D  G WLN
 . W !,"No accession on file for this UID."
 . D NEXT
 S LRDFN=+^LRO(68,LRAA,1,LRAD,1,LRAN,0),LRCEN=$S($D(^(.1)):^(.1),1:0),LRODT=$S($P(^(0),U,4):$P(^(0),U,4),1:$P(^(0),U,3)),LRSN=$P(^(0),U,5)
 S LRORU3=$G(^LRO(68,LRAA,1,LRAD,1,LRAN,.3))
 S LRDPF=$P(^LR(LRDFN,0),U,2),DFN=$P(^(0),U,3)
 D PT^LRX W !,PNM,?30,SSN
 W:LRCEN !,"ORDER #: ",LRCEN
 I '$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,3)),"^",3) D
 . N LRAA,LRAD,LRAN
 . S LRSTATUS="C" D P15^LROE1
 . I LRCDT<1 S LRNOP=1
 I '$G(LRNOP),$P($G(^LRO(69,LRODT,1,LRSN,1)),U,4)'="C" D
 . W !,"You cannot verify an accession which has not been collected.",$C(7)
 . S LRNOP=1
 I $G(LRNOP) D NEXT
 Q
 ;
LW ; Display list of UID's available
 N DIR,DIRUT,DUOUT,DTOUT,I,J,K,L,LREND,X,Y
 S LREND=0
 S K=$$BLDHELP("",LRLL,LRPROF)
 I 'K W !,$C(7),"No results found in UID cross-reference." Q
 S J=IOSL-6,L=K\(J*2) S:'(K#(J*2)) L=L-1
 F I=0:1:L D  Q:LREND
 . W @IOF,$$CJ^XLFSTR("Current Unique Identifiers with Results Available",IOM),!!
 . F K=((J*2)*I)+1:1:((J*2)*I)+J D
 . . W ?3,$P($G(^TMP($J,"LR","UIDHELP",K)),"^",2)
 . . W ?43,$P($G(^TMP($J,"LR","UIDHELP",(K+J))),"^",2),!
 . W ! S DIR(0)="E" D ^DIR
 . I $D(DIRUT) D STOP^LRVR Q
 K ^TMP($J,"LR","UIDHELP")
 Q
 ;
LWP(LRSD) ; Display list of partial UID's available
 N DIR,DIRUT,DUOUT,DTOUT,I,J,K,L,LREND,LRUID,M,X,Y
 S LRSD=$G(LRSD),(LREND,M)=0,LRUID=""
 S K=$$BLDHELP(LRSD,LRLL,LRPROF)
 I 'K W !,$C(7),"No results found in UID cross-reference." Q LRUID
 S J=IOSL-6,L=K\(J*2) S:'(K#(J*2)) L=L-1
 F I=0:1:L D  Q:LREND
 . W @IOF,$$CJ^XLFSTR("Current Unique Identifiers with Results Available",IOM),!!
 . F K=((J*2)*I)+1:1:((J*2)*I)+J D
 . . I $D(^TMP($J,"LR","UIDHELP",K)) D
 . . . W ?3,$J(K,3),".  ",$P($G(^TMP($J,"LR","UIDHELP",K)),"^",2)
 . . . I K>M S M=K
 . . I $D(^TMP($J,"LR","UIDHELP",K+J)) D
 . . . W ?43,$J(K+J,3),".  ",$P($G(^TMP($J,"LR","UIDHELP",(K+J))),"^",2)
 . . . I (K+J)>M S M=K+J
 . . W !
 . W ! S DIR(0)="NO^1:"_$S(M>500:500,1:M),DIR("A")="Select UID"
 . D ^DIR
 . W @IOF
 . I $D(DUOUT) D STOP^LRVR Q
 . I '$D(DIRUT),Y D
 . . S LRUID=$P(^TMP($J,"LR","UIDHELP",Y),"^")
 . . D STOP^LRVR
 K ^TMP($J,"LR","UIDHELP")
 Q LRUID
 ;
NEXT ; Retrieve next UID in xref.
 N LRUIDX,LRQUIT
 S LRQUIT=0 ; Set flag
 S LRUIDX=$G(LRUID) ; Define if undefined
 F  S LRUIDX=$O(^LAH(LRLL,1,"U",LRUIDX)) Q:LRUIDX=""  D  Q:LRQUIT
 . N LRUID
 . S LRUID=LRUIDX
 . D UID
 . I $L(LRUID) S LRQUIT=1 ; Found a UID from this accession area.
 S LRUID=LRUIDX
 Q
 ;
UID ; Setup accession variables for a given UID.
 N X
 S X=$Q(^LRO(68,"C",LRUID))
 I $QS(X,3)'=LRUID S (LRAD,LRAN)=0,LRUID="" Q
 I 'LRANYAA,$QS(X,4)'=LRAA S (LRAD,LRAN)=0,LRUID="" Q
 S LRAA=$QS(X,4),LRAD=$QS(X,5),LRAN=$QS(X,6)
 Q
 ;
BLDHELP(LRSD,LRLL,LRPROF) ; Build list of UID's
 ; Input LRSD - seed value for partial lookups
 ;              if null or missing then return all UID's in xref.
 ;       LRLL - ien of loadlist.
 ;     LRPROF - ien of profile on loadlist.
 ; Only max of 500 allow to be displayed.
 N I,K,LRAA,LRAD,LRAN,X,Y
 K ^TMP($J,"LR","UIDHELP")
 S LRSD=$G(LRSD),LRLL=+$G(LRLL),LRPROF=+$G(LRPROF)
 S LRAA=$P($G(^LRO(68.2,LRLL,10,LRPROF,0)),"^",2)
 S I="",K=0
 F  S I=$O(^LAH(LRLL,1,"U",I)) Q:I=""!(K>500)  D
 . I $L(LRSD),LRSD'=$E(I,($L(I)-$L(LRSD))+1,$L(I)) Q  ; Is not a partial match
 . S Y=I
 . S X=$Q(^LRO(68,"C",I))
 . I $QS(X,3)'=I Q  ; UID not in "C" x-reference.
 . I 'LRANYAA,LRAA'=$QS(X,4) Q  ; Not in this accession area.
 . S LRAA=$QS(X,4),LRAD=$QS(X,5),LRAN=$QS(X,6)
 . I LRAA,LRAD,LRAN S Y=Y_"^"_Y_" ["_$P($G(^LRO(68,LRAA,1,LRAD,1,LRAN,.2)),"^")_"]"
 . E  Q
 . I K=500 S Y="^Display abort - too many to list"
 . S K=K+1,^TMP($J,"LR","UIDHELP",K)=Y
 Q K
