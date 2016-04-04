DICF0 ;SEA/TOAD,SF/TKW-VA FileMan: Finder, get alternate index ;2/8/00  11:11
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**28**
 ;
ALTIDX(DINDEX,DIFILE,DIVALUE,DISCREEN,DINUMBER) ; Find alternate index when lookup value for first subscript is null.
 N DIX S DIX=DINDEX,DIX("WAY")=DINDEX("WAY"),DIX("OLDSUB")=DINDEX("#")
 D IDXOK(.DINDEX,DIFILE,.DIX) Q:DIX'=DINDEX
A1 ; Find next lookup value
 N DIFIELD,DISUB,DITYPE,I,J,K,X,Y,Z
 F DISUB=1:0 S DISUB=$O(DIVALUE(DISUB)) Q:'DISUB  I DIVALUE(DISUB)]"" D
 . S X=$G(DINDEX(DISUB,"TYPE"))
 . S DITYPE=$S(X="V":3,X="P":2,1:1),DITYPE(DITYPE,DISUB)=""
 . Q
 S DIX=""
 F DITYPE=1,2,3 Q:DIX]""  I $D(DITYPE(DITYPE)) F DISUB=0:0 D  Q:'DISUB  Q:DIX]""
 . S DISUB=$O(DITYPE(DITYPE,DISUB)) Q:'DISUB
 . S DIFIELD=DINDEX(DISUB,"FIELD")
A2 . ; find alternate index on that field.
 . F I=0:0 S I=$O(^DD(DIFILE,DIFIELD,1,I)) Q:'I  S X=$G(^(I,0)) D  Q:DIX]""
 . . I $P(X,U,3)="",$P(X,U,2)]"A[" S DIX=$P(X,U,2) Q:DIX'=DINDEX
 . . S DIX="" Q
 . I DIX]"" S DIX("#")=1,DIX(1)=DISUB Q
 . F I=0:0 S I=$O(^DD("IX","F",DIFILE,DIFIELD,I)) Q:'I  D  Q:DIX]""
 . . S DIX=$P($G(^DD("IX",I,0)),U,2) Q:DIX=""
 . . I DIX=DINDEX S DIX="" Q
 . . D IDXOK(.DINDEX,DIFILE,.DIX,I,.DIVALUE)
 . . Q
 . Q
 Q:DIX=""
A3 ; Rearrange lookup values and for new index
 N DIV,DIS
 M DIS("S")=DISCREEN("S"),DIS("F")=DISCREEN("F")
 F I=1:1:DIX("#") S J=DIX(I) D
 . Q:DIVALUE(J)=""
 . M DIV(I)=DIVALUE(J),DIS(I)=DISCREEN(J)
 . K DIVALUE(J),DISCREEN(J) Q
A4 ; Build screening logic for fields whose lookup values are not on new index.
 F J=0:0 S J=$O(DIVALUE(J)) Q:'J  D
 . M DIS("VAL",J)=DIVALUE(J)
 . I $D(DISCREEN(J)) D
 . . S X="DINDEX(",Z="DISCREEN(""VAL"","
 . . F K=0:0 S K=$O(DISCREEN(J,K)) Q:'K  S Y=DISCREEN(J,K) I Y[X S DISCREEN(J,K)="" F  Q:Y'[X  D
 . . . N L,S S S=$P(Y,X),L=$L(S_X),S=S_Z,Y=$E(Y,L+1,$L(Y))
 . . . S DISCREEN(J,K)=DISCREEN(J,K)_S
 . . . I Y'[X S DISCREEN(J,K)=DISCREEN(J,K)_Y
 . . . Q
 . . M DIS("X",J)=DISCREEN(J) Q
 . N DICODE,DINODE
 . D GET^DICUIX1(DIFILE,DIFILE,DINDEX(J,"FIELD"),.DINODE,.DICODE)
 . I "PVSD"'[DINDEX(J,"TYPE") S DIS("X",J,"GET")="S DIVAL="_DICODE Q
 . S DIS("X",J,"GET")="S DIVAL=$$EXTERNAL^DIDU("_DIFILE_","_DINDEX(J,"FIELD")_","""","_DICODE_")"
 . D
 . . N DISAVJ S DISAVJ=J N J
 . . S X=$$EXTERNAL^DIDU(DINDEX(DISAVJ,"FILE"),DINDEX(DISAVJ,"FIELD"),"",DIS("VAL",DISAVJ),"DIERR")
 . . S J=$O(DIS("VAL",DISAVJ,99999),-1)+1
 . . S DIS("VAL",DISAVJ,J)=X Q
 . Q
 K DINDEX S DINDEX=DIX,DINDEX("WAY")=DIX("WAY")
 I DIFLAGS["l" S DINDEX("START")=DIX,DINDEX("OLDSUB")=DIX("OLDSUB")
 K DISCREEN,DIVALUE M DISCREEN=DIS,DIVALUE=DIV K DIS,DIV
 D INDEX^DICUIX(.DIFILE,DIFLAGS,.DINDEX,"",.DIVALUE,DINUMBER,.DISCREEN)
 D XFORM^DICF1(DIFLAGS,.DIVALUE,.DISCREEN,.DINDEX)
 Q
 ;
IDXOK(DINDEX,DIFILE,DIX,DIXIEN,DIVALUE) ; Return alternate index name DIX if it has no set/kill conditions and all subscripts are fields from original index DINDEX.
 I '$G(DIXIEN) S DIXIEN=$O(^DD("IX","BB",DIFILE,DIX,0)) I 'DIXIEN S DIX="" Q
 I $G(^DD("IX",DIXIEN,1.4))]""!($G(^(2.4))]"") S DIX="" Q
 N I,J,X,DIFIELD,DISKIP S DISKIP=1 I $O(DIVALUE(0)) S DIX("#")=0
 F I=0:0 S I=$O(^DD("IX",DIXIEN,11.1,"AC",I)) Q:'I  S DISKIP=1 D  Q:DISKIP
 . S X=$G(^DD("IX",DIXIEN,11.1,I,0))
 . Q:$P(X,U,3)'=DIFILE  Q:$P(X,U,6)'=I  S DIFIELD=$P(X,U,4) Q:'DIFIELD
 . Q:$G(^DD("IX",DIXIEN,11.1,I,2))]""
 . I '$O(DIVALUE(0)) S DISKIP=0 Q
 . F J=1:1:DINDEX("#") D  Q:'DISKIP
 . . Q:DINDEX(J,"FIELD")'=DIFIELD
 . . I I=1,DIVALUE(J)="" Q
 . . S DIX(I)=J,DISKIP=0 Q
 . I 'DISKIP S DIX("#")=DIX("#")+1
 . Q
 I DISKIP S DIX="" Q
 Q
 ;
