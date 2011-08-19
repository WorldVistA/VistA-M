TIU182D1 ; SLC/MAM - After installing TIU*1*182 ; 05/20/2004
 ;;1.0;Text Integration Utilities;**182**;Jun 20, 1997
 ; External References
 ;   DBIA 3409  ^USR(8930,"B"
DELETE(TIUDA,PIEN,ITEMDA) ; Delete DDEF TIUDA; If parent PIEN and
 ;Item IEN ITEMDA sent, first delete item from parent
 N DA,DIK,X,Y,I
 I $G(PIEN),$G(ITEMDA) D
 . S DA(1)=PIEN,DA=ITEMDA,DIK="^TIU(8925.1,DA(1),10," D ^DIK
 N DA,DIK
 S DA=TIUDA,DIK="^TIU(8925.1," D ^DIK
 Q
 ;
PARENT(NUM) ; Return IEN of parent new DDEF should be added to
 N PIEN,PNUM
 ; Parent node has form:
 ;   ^TMP("TIU182",$J,"DATA",NUM,PIEN) = IEN of parent if known, or
 ;   ^TMP("TIU182",$J,"DATA",NUM,PNUM) = DDEF# of parent if not
 S PIEN=$G(^TMP("TIU182",$J,"DATA",NUM,"PIEN"))
 ; -- If parent IEN is known, we're done:
 I PIEN G PARENTX
 ; -- If not, get DDEF# of parent
 S PNUM=+$G(^TMP("TIU182",$J,"DATA",NUM,"PNUM"))
 ; -- Get Parent IEN from "DONE" node, which was set
 ;    when parent was created:
 S PIEN=+$G(^XTMP("TIU182",PNUM,"DONE"))
PARENTX I 'PIEN!'$D(^TIU(8925.1,PIEN,0)) D
 . S ^TMP("TIU182ERR",$J,NUM)="FINDPARENT"
 Q PIEN
 ;
ADDITEM(NUM,TIUDA,PIEN)  ; Add DDEF TIUDA to Parent; Return Item IEN
 N MENUTXT,TIUFPRIV,TIUFISCR
 N DIE,DR
 S TIUFPRIV=1
 N DA,DIC,DLAYGO,X,Y
 N I,DIY
 S DA(1)=PIEN
 S DIC="^TIU(8925.1,"_DA(1)_",10,",DIC(0)="LX"
 S DLAYGO=8925.14
 ; -- If TIUDA is say, x, and Parent has x as IFN in Item subfile,
 ;    code finds item x under parent instead of creating a new item,
 ;    so don't use "`"_TIUDA:
 S X=^TMP("TIU182",$J,"BASICS",NUM,"NAME")
 ; -- Make sure the DDEF it adds is TIUDA and not another w same name:
 S TIUFISCR=TIUDA ; activates item screen on fld 10, Subfld .01 in DD
 D ^DIC I Y'>0!($P(Y,U,3)'=1) S ^TMP("TIU182ERR",$J,NUM)="ADDITEM"
 Q Y
 ;
FILEITEM(NUM,PIEN,ITEMDA) ; File Menu Text for DDEF item ITEMDA
 ;under parent
 N TIUFPRIV,MENUTXT,ITEMFDA
 K TIUIERR
 S TIUFPRIV=1,MENUTXT=$G(^TMP("TIU182",$J,"DATA",NUM,"MENUTXT"))
 S ITEMFDA(8925.14,ITEMDA_","_PIEN_",",4)=MENUTXT
 D FILE^DIE("TE","ITEMFDA","TIUIERR")
 I $D(TIUIERR) S ^TMP("TIU182ERR",$J,NUM)="FILEITEM"
 Q
 ;
FILE(NUM,TIUDA) ; File fields for new DDEF TIUDA
 ; Files ALL FIELDS set in "FILEDATA" nodes of ^TMP:
 ;   ^TMP("TIU182",$J,"FILEDATA",NUM,Field#)
 N TIUFPRIV,FDA
 K ^TMP("DIERR",$J)
 S TIUFPRIV=1
 M FDA(8925.1,TIUDA_",")=^TMP("TIU182",$J,"FILEDATA",NUM)
 D FILE^DIE("TE","FDA")
 I $D(^TMP("DIERR",$J)) S ^TMP("TIU182ERR",$J,NUM)="FILE"
 Q
 ;
CREATE(NUM) ; Create new DDEF entry
 N DIC,DLAYGO,DA,X,Y
 S DIC="^TIU(8925.1,",DLAYGO=8925.1
 S DIC(0)="LX",X=^TMP("TIU182",$J,"BASICS",NUM,"NAME")
 S DIC("S")="I $P(^(0),U,4)="_""""_^TMP("TIU182",$J,"BASICS",NUM,"INTTYPE")_""""
 D ^DIC
 I $P($G(Y),U,3)'=1 S ^TMP("TIU182ERR",$J,NUM)="CREATE"
 Q $G(Y)
