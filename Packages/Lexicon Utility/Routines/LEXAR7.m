LEXAR7 ;ISL/KER - Look-up Response (MAIL) ;01/03/2011
 ;;2.0;LEXICON UTILITY;**9,25,73**;Sep 23, 1996;Build 10
 ;
 Q
 ;  This routines sends a Mailman message containing the Unresolved
 ;  Narratives and Comments stored in file 757.06 to the Field Office
 ;  at G.LEXUNR@ISC-SLC.VA.GOV.  Once sent, the Unresolved Narratives
 ;  and comments are purged from file 757.06.  Both the Unresolved 
 ;  Narratives and comments are used to update the Lexicon Utility.
 ;
SEND ; Task MAILMAN to Send Unresolved Narratives to the ISC
 I +($$TOT^LEXAR6)'>49!('$L($G(^LEX(757.06,0))))!(+($P($G(^LEX(757.06,0)),"^",4))<1) G SENDQ
 G:$D(^TMP("LEXSEND")) SENDQ S ^TMP("LEXSEND",$J)=""
 N X,Y,ZTQUEUED,ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,%,%X,%Y
 S ZTRTN="ISC^LEXAR7",ZTDESC="Sending Narratives to IRMFO",ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS
SENDQ ; End of Send
 K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN
 Q
DUMP ; Dump Narratives to Developer
 D HOME^%ZIS S U="^" Q:+($G(DUZ))=0  Q:+($O(^LEX(757.06,0)))'>0
 S ^TMP("LEXSEND",$J)="" K ^TMP("LEXMSG",$J) D ISC K ^TMP("LEXSEND",$J)
 Q
ISC ; Create MAILMAN Message for the IRMFO
 G:'$D(^TMP("LEXSEND")) ISCQ G:$D(^TMP("LEXMSG")) ISCQ
 ;
 ; LEXT    Narrative Type
 ; LEXN    Narrative
 ; LEXA    # of Narratives Added to Message
 ;
 N DA,DIC,DIK,DIE,X,Y,LEXT,LEXN,LEXA S:$D(ZTQUEUED) ZTREQ="@" D INM S DA=0,DIK="^LEX(757.06,",LEXA=0
 F  S DA=$O(^LEX(757.06,DA)) Q:+DA=0  D
 . S LEXT="UNR"
 . I '$D(^LEX(757.06,DA,1)),'$D(^LEX(757.06,DA,2)),'$D(^LEX(757.06,DA,3)),$D(^LEX(757.06,DA,4)) S LEXT="COM"
 . Q:+($G(^LEX(757.06,DA,99)))'>0
 . S LEXN=$P($G(^LEX(757.06,DA,0)),"^",1) Q:'$L(LEXN)  Q:'$D(^LEX(757.06,"B",$E(LEXN,1,30),DA))
 . Q:+($G(LEXA))>50
 . D ADD("   ",LEXT) S LEXA=LEXA+1
 . I $L($P($G(^LEX(757.06,DA,0)),U,1)) D
 . . I LEXT="UNR" D ADD("NAR",$P($G(^LEX(757.06,DA,0)),U,1,2)) Q
 . . D ADD("EXP",$P($G(^LEX(757.06,DA,0)),U,1)) Q
 . D:$L($P($G(^LEX(757.06,DA,0)),U,3)) ADD("SCH",$P($G(^LEX(757.06,DA,0)),U,3))
 . D:$L($P($G(^LEX(757.06,DA,0)),U,4)) ADD("FND",$P($G(^LEX(757.06,DA,0)),U,4))
 . D:$L($P($G(^LEX(757.06,DA,1)),U,1)) ADD("APP",$P($G(^LEX(757.06,DA,1)),U,1))
 . D:$L($P($G(^LEX(757.06,DA,1)),U,2)) ADD("SER",$P($G(^LEX(757.06,DA,1)),U,2))
 . D:$L($P($G(^LEX(757.06,DA,1)),U,3)) ADD("LOC",$P($G(^LEX(757.06,DA,1)),U,3))
 . D:$L($P($G(^LEX(757.06,DA,2)),U,1)) ADD("FLN",$P($G(^LEX(757.06,DA,2)),U,1))
 . D:$L($P($G(^LEX(757.06,DA,2)),U,2)) ADD("IDX",$P($G(^LEX(757.06,DA,2)),U,2))
 . D:$L($P($G(^LEX(757.06,DA,2)),U,3)) ADD("SCT",$P($G(^LEX(757.06,DA,2)),U,3))
 . D:$L($G(^LEX(757.06,DA,3))) ADD("SCR",$G(^LEX(757.06,DA,3)))
 . D:$L($P($G(^LEX(757.06,DA,4)),U,1)) ADD("IEN",$P($G(^LEX(757.06,DA,4)),U,1))
 . D:$L($P($G(^LEX(757.06,DA,4)),U,2)) ADD("COM",$P($G(^LEX(757.06,DA,4)),U,2))
 . I +($G(DA))>0 K ^LEX(757.06,+($G(DA)),99) D:$D(^LEX(757.06,+($G(DA)),0)) ^DIK
 D N0,MAIL S LEXA=$$TOT^LEXAR6
ISCQ ; End of Send MAILMAN Message
 K LEXA,LEXN,LEXT S:$D(ZTQUEUED) ZTREQ="@"
 Q
ADD(LEXI,LEXS) ; Add text to message
 ; 
 ; LEXI    Narrative Segment ID
 ; LEXS    Segment String
 ; LEXC    Counter/IEN for ^TMP("LEXMSG",$J,LEXC)
 ;
 N LEXC S LEXC=+($G(^TMP("LEXMSG",$J,0)))+1,^TMP("LEXMSG",$J,0)=LEXC,^TMP("LEXMSG",$J,LEXC)=LEXI
 S:$G(LEXS)'="" ^TMP("LEXMSG",$J,LEXC)=^TMP("LEXMSG",$J,LEXC)_"^"_LEXS
 Q
MAIL ; MAILMAN
 N XCNP,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,Y,LEXADR S LEXADR=$$ADR^LEXU G:'$L(LEXADR) MAILQ
 G:'$D(^TMP("LEXMSG",$J)) MAILQ G:+($G(LEXA))=0 MAILQ G:+($G(^TMP("LEXMSG",$J,0)))=0 MAILQ
 K XMZ N DIFROM S XMSUB="Unresolved Narratives - "_LEXA_" items"
 S XMY(("G.LEXUNR@"_LEXADR))="",XMTEXT="^TMP(""LEXMSG"",$J,",XMDUZ=.5
 ; Patch 57, discontinue the transmission of Unresolved Narratives
 ; D ^XMD
MAILQ ; End of MAILMAN
 K ^TMP("LEXSEND",$J),^TMP("LEXMSG",$J),DIFROM,LEXA,XCNP,XMDUZ,XMZ,XMSUB,XMY,XMTEXT,XMDUZ,XMSCR,REF, Q
INM ; Initialize Message
 N LEXI S (LEXI,^TMP("LEXMSG",$J,0))=0 F  S LEXI=$O(^TMP("LEXMSG",$J,LEXI)) Q:+LEXI=0  K ^TMP("LEXMSG",$J,LEXI)
 Q
N0 ; ^LEX(757.06,0)
 N LEX3,LEX4,DA S (LEX3,LEX4,DA)=0 F  S DA=$O(^LEX(757.06,DA)) Q:+DA=0  S LEX3=DA,LEX4=LEX4+1
 S LEX3=+LEX3,LEX4=+LEX4 S:+LEX3=0 LEX3="" S:+LEX4=0 LEX4="" S ^LEX(757.06,0)=$P($G(^LEX(757.06,0)),"^",1,2)_"^"_LEX3_"^"_LEX4
 Q
CLR ; Clear all narratives
 N DA,DIK S DA=0,U="^",DIK="^LEX(757.06," F  S DA=$O(^LEX(757.06,DA)) Q:+DA=0  D ^DIK
 N LEXN S LEXN=$P(^LEX(757.06,0),"^",1,2)_"^^" S ^LEX(757.06,0)=LEXN
 Q
