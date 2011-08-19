ORWORDG ; SLC/KCM/JLI - Organize display groups;11:25 AM  11 Mar 1998 3/2/02 4PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,141**;Dec 17, 1997
 ;
MAPSEQ(Y) ; similar to GRPSEQB, for 32bit
 N C,I,X
 D GRPSEQ(.X)
 S C=0,I=0
 F  S I=$O(X(I)) Q:I=""  S C=C+1,Y(C)=I_"="_X(I)_U_$P(^ORD(100.98,I,0),U,2)
 Q
GRPSEQB(Y) ;
 ; Call GRPSEQ, format for broker:
 ;   Y(n)=Ptr to Display Group ^ Sequence ^ Top Level Display Group Name
 N C,I,X
 D GRPSEQ(.X)
 S C=0,I=0
 F  S I=$O(X(I)) Q:I=""  S C=C+1,Y(C)=I_U_X(I)
 Q
GRPSEQ(BYGRP) ;
 ; Expanded list of display groups with sequence as value
 N I,ORY,TOPINFO
 D GETLST^XPAR(.ORY,"ALL","ORWOR CATEGORY SEQUENCE")
 S I=0 F  S I=$O(ORY(I)) Q:I=""  D
 . S BYGRP($P(ORY(I),U,2))=$P(ORY(I),U,1)_U_$P(^ORD(100.98,$P(ORY(I),U,2),0),U,2)
 S I=0 F  S I=$O(BYGRP(I)) Q:I=""  S TOPINFO=BYGRP(I) D EXPAND(I)
 Q
EXPAND(GROUP) ;
 ; (used by GRPSEQ)
 N I,CHILD
 S I=0 F  S I=$O(^ORD(100.98,GROUP,1,I)) Q:I<1  D
 . S CHILD=$P(^ORD(100.98,GROUP,1,I,0),"^",1)
 . I '$D(BYGRP(CHILD)) S BYGRP(CHILD)=TOPINFO D EXPAND(CHILD)
 Q
ALLTREE(LST) ; Return the tree for all display groups
 N ROOT,ILST
 S ILST=0,ROOT=$O(^ORD(100.98,"B","ALL",0))
 S ILST=ILST+1,LST(ILST)=ROOT_U_"ALL SERVICES^0^+"
 D LSTCHLD(ROOT)
 Q
LSTCHLD(PARENT) ; list descendends of this node (recursive)
 N CHILD,I
 S I=0 F  S I=$O(^ORD(100.98,PARENT,1,I)) Q:'I  D
 . S CHILD=+^ORD(100.98,PARENT,1,I,0)
 . S ILST=ILST+1,LST(ILST)=CHILD_U_$P(^ORD(100.98,CHILD,0),U)_U_PARENT
 . I $D(^ORD(100.98,CHILD,1))>1 D
 . . S LST(ILST)=LST(ILST)_"^+"
 . . D LSTCHLD(CHILD)
 Q
REVSTS(LST) ; Return the status flags available for review orders
 ;N I,X,T S ILST=0
 ;F I=1:1 S T="ORDSTS+"_I_"^ORCHANG2" S X=$T(@T) Q:$P(X,";",4)="ZZZZ"  D
 ;. S ILST=ILST+1,LST(ILST)=$P(X,";",3)_U_$P(X,";",4)
 D STSLST^ORCHANG2(.LST)
 Q
IEN(VAL,X) ; Return IEN for a display group
 S VAL=$O(^ORD(100.98,"B",X,0))
 Q
