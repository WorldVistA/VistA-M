TIUDDT ; SLC/JM - XRef & Input Transform code for Template File #8927;8/23/2001
 ;;1.0;TEXT INTEGRATION UTILITIES;**76,119,125**;Jun 20, 1997
 ;
 ; Input Transform functions return true if the field value is bad
 ;
BADTYPE(X,DA) ;Input Transform for .03 TYPE field
 N BAD,NODE
 S BAD=0,NODE=$$GETNODE()
 I $P(NODE,U,4)="A" D
 .I $$ISROOT(X) S BAD=$$BADROOT(DA,X)
 .I X="P" S BAD=$$BADPROOT(DA,$P(NODE,U,6))
 Q BAD
 ;
BADSTS(X,DA) ;Input Transform for .04 STATUS Field
 N BAD,NODE,TYPE
 S BAD=0
 I X="A" D
 .S NODE=$$GETNODE()
 .S TYPE=$P(NODE,U,3)
 .I $$ISROOT(TYPE) S BAD=$$BADROOT(DA,TYPE)
 .I TYPE="P" S BAD=$$BADPROOT(DA,$P(NODE,U,6))
 Q BAD
 ;
BADOWNER(X,DA) ;Input Transform for .06 PERSONAL OWNER Field
 N BAD,NODE,ROOT,TYPE
 S BAD=0
 I +X D
 .S NODE=$$GETNODE()
 .I $P(NODE,U,3)="P",$P(NODE,U,4)="A" S BAD=$$BADPROOT(DA,X)
 .I 'BAD D
 ..F TYPE="R","TF","CF","OF" D  Q:+BAD
 ...S ROOT=$O(^TIU(8927,"AROOT",$$ROOTIDX(TYPE),0))
 ...I +ROOT S BAD='$$PARENTOK(DA,ROOT)
 Q BAD
 ;
BADITEM(X,DA1) ;Input Transform for ITEMS .02 ITEM Field
 Q '$$PARENTOK(DA1,X)
 ;
 ; Field Cross Reference Routines
 ;
TYPESETR(X,DA) ; .03 TYPE Field "AROOT" and "AP" XRef Set Logic
 N NODE,OWNER
 S NODE=$$GETNODE()
 I $P(NODE,U,4)="A" D
 .I $$ISROOT(X),'$$BADROOT(DA,X) D
 ..S ^TIU(8927,"AROOT",$$ROOTIDX(X),DA)=""
 .I X="P" D
 ..S OWNER=$P(NODE,U,6)
 ..I '$$BADPROOT(DA,OWNER) D
 ...S ^TIU(8927,"AROOT",OWNER,DA)=""
 Q
 ;
TYPEKILR(X,DA) ; .03 TYPE Field "AROOT" and "AP" XRef Kill Logic
 N NODE,OWNER
 I $$ISROOT(X) K ^TIU(8927,"AROOT",$$ROOTIDX(X),DA)
 I X="P" D
 .S NODE=$$GETNODE()
 .S OWNER=$P(NODE,U,6)
 .I +OWNER K ^TIU(8927,"AROOT",OWNER,DA)
 Q
 ;
STSSETR(X,DA) ; .04 STATUS Field "AROOT" and "AP" XRef Set Logic
 N NODE,TYPE,OWNER
 I X="A" D
 .S NODE=$$GETNODE()
 .S TYPE=$P(NODE,U,3)
 .I $$ISROOT(TYPE),'$$BADROOT(DA,TYPE) D
 ..S ^TIU(8927,"AROOT",$$ROOTIDX(TYPE),DA)=""
 .I TYPE="P" D
 ..S OWNER=$P(NODE,U,6)
 ..I +OWNER,'$$BADPROOT(DA,OWNER) D
 ...S ^TIU(8927,"AROOT",OWNER,DA)=""
 Q
 ;
STSKILLR(X,DA) ; .04 STATUS Field "AROOT" XRef Kill Logic
 N NODE,TYPE,OWNER
 S NODE=$$GETNODE()
 S TYPE=$P(NODE,U,3)
 I $$ISROOT(TYPE) K ^TIU(8927,"AROOT",$$ROOTIDX(TYPE),DA)
 I TYPE="P" D
 .S OWNER=$P(NODE,U,6)
 .I +OWNER K ^TIU(8927,"AROOT",OWNER,DA)
 Q
 ;
OWNRSETR(X,DA) ; .06 OWNER Field "AROOT" XRef Set Logic
 N NODE
 I +X D
 .S NODE=$$GETNODE()
 .I $P(NODE,U,4)="A",$P(NODE,U,3)="P",'$$BADPROOT(DA,X) D
 ..S ^TIU(8927,"AROOT",X,DA)=""
 Q
 ;
OWNRKILR(X,DA) ; .06 OWNER Field "AROOT" XRef Kill Logic
 I +X K ^TIU(8927,"AROOT",X,DA)
 Q
BADLINK(X,DA) ;Input Transform for .19 LINK field
 N BAD,IDX
 S BAD=0
 S IDX=$O(^TIU(8927,"AL",X,0))
 I +IDX,IDX'=DA S BAD=1
 Q BAD
 ;
 ; Internal Routines
 ;
GETNODE() ; Sets NODE variable
 Q $G(^TIU(8927,DA,0))
 ;
BADROOT(DA,TIUTYPE) ; Returns True if there is another root
 N CURROOT,BAD
 S BAD=0
 S CURROOT=$O(^TIU(8927,"AROOT",$$ROOTIDX(TIUTYPE),0))
 I +CURROOT,CURROOT'=DA S BAD=1
 Q BAD
 ;
BADPROOT(DA,OWNER) ; Returns True if there is another personal root
 N CURROOT,BAD
 S BAD=0
 I +OWNER D
 .S CURROOT=$O(^TIU(8927,"AROOT",OWNER,0))
 .I +CURROOT,CURROOT'=DA S BAD=1
 Q BAD
 ;
PARENTOK(PARENT,ITEM) ; Returns True if ITEM is not in it's own parent list
 N IDX,OK
 S IDX=0,OK=1
 F  S IDX=$O(^TIU(8927,"AD",PARENT,IDX)) Q:'IDX  D  Q:'OK
 .I IDX=ITEM S OK=0
 .E  S OK=$$PARENTOK(IDX,ITEM)
 Q OK
ISROOT(TYPE) ; Returns TRUE if TYPE is a valid root folder type
 Q $S(TYPE="R":1,TYPE="TF":1,TYPE="CF":1,TYPE="OF":1,1:0)
ROOTIDX(TYPE) ; Returns "AROOT" Index value for root types
 Q $S(TYPE="R":"ROOT",TYPE="TF":"TITLES",TYPE="CF":"CONSULTS",TYPE="OF":"PROCEDURES",1:"")
