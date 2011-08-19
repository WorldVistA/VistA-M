LEXNDX1 ; ISL Set/kill indexes (Part 1)            ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
S ; Set Expression file (#757.01) word index node AWRD
 Q:'$D(X)!('$D(DA))  Q:$D(DIC)#2=0
 Q:'$D(@(DIC_DA_",0)"))  Q:'$D(@(DIC_DA_",1)"))  Q:+($P(@(DIC_DA_",1)"),U,1))=0
 N LEXIDX,LEXJ,LEXI,LEXTYPE,LEXT S LEXTYPE=+X Q:LEXTYPE'>0
 S LEXT=$P($G(^LEX(757.011,LEXTYPE,0)),"^",2) Q:+LEXT=0
 S LEXTYPE=$P($G(^LEX(757.011,LEXTYPE,0)),"^",1) D:LEXTYPE["DELETED" U
 S X=@(DIC_DA_",0)") S:X'="" ^LEX(757.01,"B",$$UP^XLFSTR($E(X,1,63)),DA)=""
 S LEXEX=$P(^LEX(757,$P(^LEX(757.01,DA,1),U,1),0),U,1),LEXIDX=""
 D PTX^LEXTOLKN
 I $D(^TMP("LEXTKN",$J,0)),^TMP("LEXTKN",$J,0)>0 S LEXI="" F LEXJ=1:1:^TMP("LEXTKN",$J,0) D
 . S LEXI=$O(^TMP("LEXTKN",$J,LEXJ,""))
 . I '$D(^LEX(757.01,"AWRD",LEXI,LEXEX)) D
 . . S:'$D(^LEX(757.01,DA,4,"B",LEXI)) ^LEX(757.01,"AWRD",LEXI,LEXEX,DA)=""
 D L K LEXIDX,LEXEX,LEXI,LEXTYPE,LEXT,LEXJ,^TMP("LEXTKN",$J,0),^TMP("LEXTKN",$J) Q
 ;
K ; Kill Expression file (#757.01) word index node AWRD
 Q:'$D(X)!('$D(DA))  D U
 Q:'$D(^LEX(757.01,DA,0))  Q:+($P(^LEX(757.01,DA,1),U,1))=0
 N LEXTYPE,LEXT S LEXTYPE=+X Q:LEXTYPE'>0
 S LEXT=$P($G(^LEX(757.011,LEXTYPE,0)),"^",2) Q:+LEXT=0
 N LEXIDX,LEXJ,LEXI S X=^LEX(757.01,DA,0),LEXIDX=""
 D PTX^LEXTOLKN I $D(^TMP("LEXTKN",$J,0)),^TMP("LEXTKN",$J,0)>0 S LEXI="" F LEXJ=1:1:^TMP("LEXTKN",$J,0) D
 . S LEXI=$O(^TMP("LEXTKN",$J,LEXJ,""))
 . K ^LEX(757.01,"AWRD",LEXI,DA)
 K LEXIDX,LEXTYPE,LEXI,LEXJ,^TMP("LEXTKN",$J,0),^TMP("LEXTKN",$J) Q
L ; Link words
 N DIC,LEXDEXP D KILL^LEXNDX2 S LEXDEXP=DA
 ;     For Subsets
 I $D(^LEX(757.21,"B",LEXDEXP)) D
 . S DA=0 F  S DA=$O(^LEX(757.21,"B",LEXDEXP,DA)) Q:+DA=0  D
 . . N X S X=$P(^LEX(757.21,DA,0),U,2) Q:+X<1  D SS^LEXNDX2
 ;     For Replacement Words
 I $D(^LEX(757.05,"AEXP",LEXDEXP)) D
 . S DA=0 F  S DA=$O(^LEX(757.05,"AEXP",LEXDEXP,DA)) Q:+DA=0  D
 . . N X,LEXMC S X=$P(^LEX(757.05,DA,0),U,1) Q:X=""
 . . S LEXMC=$P($G(^LEX(757.01,LEXDEXP,1)),U,1) Q:+LEXMC'>0
 . . S ^LEX(757.01,"AWRD",X,LEXDEXP,"LINKED")=""
 S DA=LEXDEXP
 Q
U ; Unlink words
 N DIC,LEXDEXP D KILL^LEXNDX2 S LEXDEXP=DA
 ;     For Subsets
 I $D(^LEX(757.21,"B",LEXDEXP)) D
 . S DA=0 F  S DA=$O(^LEX(757.21,"B",LEXDEXP,DA)) Q:+DA=0  D
 . . N X S X=$P(^LEX(757.21,DA,0),U,2) Q:+X<1  D SK^LEXNDX2
 ;     For Replacement Words
 I $D(^LEX(757.05,"AEXP",LEXDEXP)) D
 . S DA=0 F  S DA=$O(^LEX(757.05,"AEXP",LEXDEXP,DA)) Q:+DA=0  D
 . . N X,LEXMC S X=$P(^LEX(757.05,DA,0),U,1) Q:X=""
 . . S LEXMC=$P($G(^LEX(757.01,LEXDEXP,1)),U,1) Q:+LEXMC'>0
 . . K ^LEX(757.01,"AWRD",X,LEXDEXP,"LINKED")
 S DA=LEXDEXP
 Q
REIDXMC ; Re-Index Expression file word index AWRD
 S:$D(ZTQUEUED) ZTREQ="@"
 N LEXIDX,LEXREIX,DA,X S DA=0,X="",(LEXREIX,LEXIDX)="" K ^TMP("LEXSTOP","REIDXMC")
 F  S DA=$O(^LEX(757.01,DA)) Q:+DA=0!($D(^TMP("LEXSTOP","REIDXMC")))  D
 . S X=$P(^LEX(757.01,DA,1),U,2) D S
 K ^TMP("LEXSTOP","REIDXMC"),LEXIDX,DA,X
 Q
RMC ; Re-Index Expression file word index AWRD (Task Manager)
 S ZTRTN="REIDXMC^LEXNDX1"
 S ZTDESC="Re-Indexing Major Concept Words in ""AWRD"" index"
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS W:$D(ZTSK) !!,"Re-Indexing Major Concept Words in ""AWRD"" index" W:'$D(ZTSK) !!,"Task to re-index Major Concept not created"
 K ZTDTH,ZTDESC,ZTIO,ZTRTN
 Q
RALL ; Re-Index entire file (needs DIC)
 S DIK=$G(DIC) Q:DIK=""  Q:'$D(@(DIK_"0)"))
 S ZTREQ="@",(ZTSAVE("ZTREQ"),ZTSAVE("DIK"))="",ZTRTN="IXALL^DIK"
 S ZTDESC="Re-Indexing "_DIK
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS
 K ZTDTH,ZTDESC,ZTIO,ZTRTN,ZTREQ,ZTSAVE
 Q
