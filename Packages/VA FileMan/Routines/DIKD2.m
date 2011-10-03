DIKD2 ;SFISC/MKO-DELETE A NEW-STYLE INDEX ;10:28 AM  1 Nov 2002
 ;;22.0;VA FileMan;**12,95**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DELIXN(DIFIL,DIXR,DIFLG,DIKDOUT,DIKDMSG) ;Delete new-style index
DELIXNX ;Come here from DELIXN^DDMOD
 N %,DIC,DIF,DIFLIST,DIINDEX,DIQUIT,DITOP,X,Y
 ;
 ;Init
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 S DIFLG=$G(DIFLG)
 S DIF=$E("D",DIFLG'["d")
 I DIFLG'["c" D CHK G:$G(DIQUIT) END
 S DITOP=DIFIL F  Q:'$D(^DD(DITOP,0,"UP"))  S DITOP=^("UP")
 D GETFLIST^DIKCUTL(DIXR,.DIFLIST)
 D LOADXREF^DIKC1("","","K",DIXR,"","DIINDEX")
 ;
 ;Delete data in index
 D:DIFLG["K" KILL(DITOP,.DIINDEX,DIFLG)
 ;
 ;Delete index, recompile
 D DELDEF(DIXR)
 D DIEZ(.DIFLIST,DIFLG,$G(DIKDOUT))
 D DIKZ^DIKD(DITOP,DIFLG,$G(DIKDOUT))
 ;
END ;Move error message if necessary and quit
 D:$G(DIKDMSG)]"" CALLOUT^DIEFU(DIKDMSG)
 Q
 ;
DELDEF(DIXR) ;Delete index definition
 N DIK,DA
 W:$G(DIFLG)["W" !,"Deleting index definition ..."
 S DIK="^DD(""IX"",",DA=DIXR D ^DIK
 Q
 ;
DIEZ(DIFLIST,DIFLG,DIKDOUT) ;Recompile input templates containing field
 N DIFIL,DIFLD,DIKTEML
 S DIFIL=0 F  S DIFIL=$O(DIFLIST(DIFIL)) Q:'DIFIL  D
 . S DIFLD=0 F  S DIFLD=$O(DIFLIST(DIFIL,DIFLD)) Q:'DIFLD  D
 .. D DIEZ^DIKD(DIFIL,DIFLD,DIFLG,$G(DIKDOUT),.DIKTEML)
 Q
 ;
CHK ;Check input parameters
 I '$G(DIFIL) D:DIF["D" ERR^DIKCU2(202,"","","","FILE") D QUIT
 I $G(DIXR)="" D:DIF["D" ERR^DIKCU2(202,"","","","CROSS-REFERENCE") D QUIT
 D:'$$VFLAG^DIKCU1(DIFLG,"KWcd",DIF) QUIT
 ;
 S DIXR=$O(^DD("IX","BB",DIFIL,DIXR,0))
 D:'DIXR QUIT
 Q
 ;
QUIT ;Set flag to quit
 S DIQUIT=1
 Q
 ;
KILL(DITOP,DIINDEX,DIFLG) ;Delete index data
 N DIFIL,DITYP,DICTRL,DIXR
 ;
 Q:'$D(DIINDEX)
 S DIFIL=$O(DIINDEX(0)) Q:'DIFIL
 S DIXR=$O(DIINDEX(DIFIL,0)) Q:'DIXR
 S DITYP=$P(DIINDEX(DIFIL,DIXR),U,4)
 ;
 I $G(DIFLG)["W" D
 . I DITYP="R" W !,"Removing index ..."
 . E  W !,"Executing kill logic ..."
 ;
 ;Call INDEX^DIKC to execute the kill logic
 S DICTRL="K"_$S(DITOP'=DIFIL:"W"_DIFIL,1:"")
 S DICTRL("LOGIC")="DIINDEX"
 D INDEX^DIKC(DITOP,"","",DIXR,.DICTRL)
 Q
