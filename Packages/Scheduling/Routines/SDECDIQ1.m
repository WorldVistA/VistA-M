SDECDIQ1 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ; Documentation for the APIs in this routine can be found
 ; in routine XBDIQ0.
 ;
DOC ;
 Q
 ;
EN ;PEP - Returns single entries
 NEW XB0,XBDIC,XBFN,XBGBL,XBNEWPAR,XBGL
 S XBDIC=DIC
 I DA'=+DA D PARSE(DA)
 D DICFNGL(DIC),^SDECSFGR(XBFN,.XBGBL)
 S XBDIC=$P(XBGBL,"DA,"),DIC=XBDIC
 D ENDIQ1,EXIT
 Q
 ;
ENP(DIC,DA,DR,DIQ,XBFMT) ;PEP - param pass into EN
 S:'$D(DIQ(0)) DIQ(0)=$G(XBFMT)
 D EN
 Q
 ;
ENPM(DIC,DA,DR,DIQ,XBFMT) ;PEP - param pass into EN
 S:'$D(DIQ(0)) DIQ(0)=$G(XBFMT)
 D ENM
 Q
 ;
ENM ;PEP - get multiple entries
 NEW XB0,XBDIC,XBFN,XBGBL,XBNEWPAR,XBGL
 S XBDIC=DIC
 S:$G(DA)="" DA=0
 I DA'=+DA D PARSE(DA)
 S:(+$G(DIQ(0))'>0) DIQ(0)=1_$G(DIQ(0))
 D DICFNGL(DIC)
 S XBDIC=$P(XBGL,"DA,"),DIC=XBDIC,DA=0,DIC(0)=""
 I $D(DIC("S")) S XBDICS=DIC("S")
 F  S DA=$O(@(XBDIC_"DA)")) Q:DA'>0  D
 . S XB0=@(XBDIC_"DA,0)")
 . I $L($G(XBDICS)) S DIC("S")=XBDICS
 . I $D(DIC("S")) S X="`"_DA,DIC(0)="N" D ^DIC Q:Y'>0
 . S DIC=XBDIC
 . D ENDIQ1
 .Q
 KILL XBDICS
 S DA=""
 D EXIT
 Q
 ;
ENDIQ1 ;EP - call EN^DIQ1
 NEW XBDIQ,XBGBL0,XBGLS,XBLVL,XBUDA,XB,XB0
 S XBDIQ=DIQ,XBDIQ(0)=$G(DIQ(0))
 NEW DIQ,XBDTMP
 D LEVELS
 D
 . NEW DIC,DR,DA
 . D SETDIQ1
 . D ENDIQ1X
 .Q
 D PULLDIQ1
 Q:XBDIQ(0)'["I"  ;  Internal if XB["I"
 KILL DIC
 S DIC=XBDIC ;reset dic
 S DIQ(0)="I"
 D ENDIQ1X,PULLDIQ1
 KILL ^UTILITY("DIQ1",$J)
 Q
 ;
ENDIQ1X ;EP - to call DIQ1 with new
 ;I $G(XBDIQ1(0))["N" S DIQ(0)=$G(DIQ(0))_"N"
 I $G(XBFMT)["N",$G(DIQ(0))'["N" S DIQ(0)=$G(DIQ(0))_"N"
 D EN^SDECNEW("ENDIQ1XN^SDECDIQ1","DR;DA;DIC;DIQ;XBDTMP;XBSRCFL")
 Q
 ;
ENDIQ1XN ;EP
 S DIQ="XBDTMP("
 D EN^DIQ1
 Q
 ;
EXIT ;EP
 KILL XBI,XBDEST,XBNEWPAR
 Q
 ;
PULLDIQ1 ;EP - PULL FROM ^UTILITY("DIQ1",$J)
 D %XY
 S XBGLS=XBDIQ_"""ID"")" S @XBGLS=DA_":"_DIC_":"_XBUDA_":"_+XBDIQ(0)
 D %XY^%RCR
 Q
 ;
%XY ;EP - set %X & %Y to format
 N %
 KILL %X,%Y
 S XBUDA=""
0 I +XBDIQ(0)=0 D  Q
 . S %X="XBDTMP("_XBFN_","_DA_",",%Y=XBDIQ
 .Q
1 I +XBDIQ(0)=1 D  Q
 . S %X="XBDTMP("_XBFN_",",%Y=XBDIQ,XBUDA=DA_","
 .Q
2 I +XBDIQ(0)=2 D  Q
 . S %X="XBDTMP("_XBFN_","
 . D  ;build da(x),..,da subscripts
 .. S %Y=""
 .. F %=1:1 Q:'$G(DA(%))  S %Y=DA(%)_","_%Y
 ..Q
 . S XBUDA=%Y_DA_","
 . S %Y=XBDIQ_%Y
 .Q
%XYE Q
 ;--
DICFNGL(X) ;EP - set XBFN & XBGL0 return 1 error
 NEW Y
 KILL XBGL,XBFN
 I X S XBFN=X D ^SDECSFGR(XBFN,.XBGL) Q
 I 'X S Y=X_"0)" S XBFN=+$P(@Y,U,2),Y=0 D ^SDECSFGR(XBFN,.XBGL)
 Q
 ;
DICFNGLX ;
 Q
 ;
VAL(DIC,DA,DR) ;PEP - extrinsic pull a value for a field
 NEW DIQ,XBT
 S DIQ="XBT("
 D EN
 Q $G(XBT(+DR))
 ;
VALI(DIC,DA,DR) ;PEP - extrinsic pull a value for a field
 NEW DIQ,XBT
 S DIQ="XBT(",DIQ(0)="I"
 D EN
 Q $G(XBT(+DR,"I"))
 ;
PARSE(XBDA) ;PEP - parse DA literal into da array
 NEW D,I,J
 F I=1:1 S D(I)=$P(XBDA,",",I) Q:D(I)=""
 S I=I-1
 F J=0:1:I-1 S DA(J)=D(I-J)
 F J=0:1:I-1 F  Q:(DA(J)=+DA(J))  S DA(J)=@(DA(J))
 S DA=DA(0)
 KILL DA(0)
 Q
 ;
DIC(XBFN) ;PEP -  Extrinsic entry to return DIC from global
 NEW XBDIC
 D EN^SDECSFGR(XBFN,.XBDIC)
 S XBDIC=$P(XBDIC,"DA,")
 Q XBDIC
 ;
LEVELS ;EP - setup XB_FN_DA_DR_FLD arrays for upper levels it they exist
 ;set bottom level
 KILL XB
 S XBLVL=0
 S XB(0,"DR")=DR,XB(0,"DA")=DA,XB(0,"FN")=XBFN
 S XB(0,"FLD")=""
 S XB(0,"PAR")=$G(^DD(XB(0,"FN"),0,"UP"))
 S:XB(0,"PAR")]"" XB(XBLVL,"FLD")=$O(^DD(XB(0,"PAR"),"SB",XB(0,"FN"),""))
 D ^SDECSFGR(XB(0,"FN"),.XBGBL0)
 S XB(0,"GBL")=$P(XBGBL0,"DA,")
 I XB(0,"PAR")]"" S XB(0+1,"FN")=XB(0,"PAR"),XBLVL=XBLVL+1 D PARENT
 Q
 ;
PARENT ; gather parent information
 ; build elements from XBFN(XBLVL)
 S XB(XBLVL,"DA")=DA(XBLVL)
 S XB(XBLVL,"DR")=XB(XBLVL-1,"FLD")
 S XB(XBLVL,"FLD")=""
 S XB(XBLVL,"PAR")=$G(^DD(XB(XBLVL,"FN"),0,"UP"))
 S:XB(XBLVL,"PAR")]"" XB(XBLVL,"FLD")=$O(^DD(XB(XBLVL,"PAR"),"SB",XB(XBLVL,"FN"),""))
 D ^SDECSFGR(XB(XBLVL,"FN"),.XBGBL0)
 S XB(XBLVL,"GBL")=$P(XBGBL0,"DA,")
 I XB(XBLVL,"PAR")]"" S XB(XBLVL+1,"FN")=XB(XBLVL,"PAR"),XBLVL=XBLVL+1 D PARENT
EPAR ;
 Q
 ;
SETDIQ1 ;EP - set DR(fn and DA(fn arrays for DIQ1
 F XBLVL=0:1 Q:'$D(XB(XBLVL))  D
 . S DR(XB(XBLVL,"FN"))=XB(XBLVL,"DR")
 . S DA(XB(XBLVL,"FN"))=XB(XBLVL,"DA")
 . S DIC=XB(XBLVL,"GBL")
 . S DR=XB(XBLVL,"DR")
 . S DA=XB(XBLVL,"DA")
 .Q
 ;   kill off redundant DR( and DA(
 S XBLVL=XBLVL-1
 KILL DR(XB(XBLVL,"FN")),DA(XB(XBLVL,"FN"))
 Q
 ;
