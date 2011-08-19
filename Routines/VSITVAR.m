VSITVAR ;ISD/RJP - Define Visit Array Variables ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996;
 Q
 ;
 ; - IEN = <visit record number>
 ;   FLD = <field mnemonic>
 ;   VAL = <data value>
 ;   VSITDD0  = <indirect reference to dd for field>
 ;   FMT = <output format [I:internal/E:external/B:both]>
 ;   WITHIEN = 1: first subscript of VSIT array is IEN second is field. 
 ;             0,"",not passed: field is only subscript
 ;
ALL(IEN,FMT,WITHIEN) ; - define all VSIT("xxx") nodes using record # IEN
 ;
 N REC,FLD,FLDINDX,VAL,VSITI
 S IEN=+$G(IEN),FMT=$G(FMT),WITHIEN=$G(WITHIEN)
 D:'($D(^TMP("VSITDD",$J))\10) FLD^VSITFLD
 S VSITI=0
 S REC(0)=$G(^AUPNVSIT(IEN,0)) F  S VSITI=$O(^(VSITI)) Q:VSITI'>0  S REC(VSITI)=^(VSITI)
 S FLDINDX=""
 F  S FLDINDX=$O(^TMP("VSITDD",$J,FLDINDX)) Q:FLDINDX=""  D
 . S FLD=$G(^TMP("VSITDD",$J,FLDINDX))
 . S VAL=$P($G(REC($P(FLD,";",3))),"^",$P(FLD,";",4))
 . I WITHIEN S VSIT(IEN,FLDINDX)=$$GET(FLDINDX,VAL,FMT)
 . E  S VSIT(FLDINDX)=$$GET(FLDINDX,VAL,FMT)
 Q
 ;
SLC(IEN,FLD,FMT) ; - define only VSIT(FLD) node using record # IEN
 ;
 N REC,NXT,VAL,VSITI
 S IEN=$G(IEN),FLD=$G(FLD),FMT=$G(FMT)
 D:'($D(^TMP("VSITDD",$J))\10) FLD^VSITFLD
 F VSITI=1:1:$L(FLD,"^") S NXT=$P(FLD,"^",VSITI) D:NXT]""
 . D:$G(REC($P(^TMP("VSITDD",$J,NXT),";",3)))=""
 . . S REC($P(^TMP("VSITDD",$J,NXT),";",3))=$G(^AUPNVSIT(IEN,$P(^TMP("VSITDD",$J,NXT),";",3)))
 . S VAL=$P($G(REC($P(^TMP("VSITDD",$J,NXT),";",3))),"^",$P(^TMP("VSITDD",$J,NXT),";",4))
 . S VSIT(NXT)=$$GET(NXT,VAL,FMT)
 K FMT
 Q
 ;
 ; ---------------------------------------------------------------------
 ;
GET(FLD,VAL,FMT,DATEFMT) ; - Get/Check value for field
 ;
 N X,Y,VSITDD0
 S FLD=$G(FLD),VAL=$G(VAL),FMT=$G(FMT)
 D:'($D(^TMP("VSITDD",$J))\10) FLD^VSITFLD
 S Y=""
 S FLD=$G(^TMP("VSITDD",$J,FLD))
 D:FLD]""
 . S VSITDD0=$P($G(^DD(9000010,$P(FLD,";",2),0)),"^",2)
 . S Y=$S(VSITDD0["N":"TXT",VSITDD0["F":"TXT",VSITDD0["P":"PTR",VSITDD0["S":"SET",VSITDD0["D":"DAT",1:"")
 . S VSITDD0="^DD(9000010,"_$P(FLD,";",2)_",0)"
 Q $S(Y="TXT":$$TXT(VAL,FMT),Y="DAT":$$DAT(VAL,FMT,$G(DATEFMT)),Y="SET":$$SET(VAL,FMT,VSITDD0),Y="PTR":$$PTR(VAL,FMT,VSITDD0),1:"")
 ;
TXT(VAL,FMT) ; - number/free text valued data
 ;
 S VAL=$G(VAL),FMT=$G(FMT),FMT=$S(FMT]""&("IEB"[FMT):FMT,1:"I")
 Q $S("IB"[FMT:VAL,1:"")_$S("EB"[FMT:$S(VAL]"":"^",1:"")_VAL,1:"")
 ;
DAT(VAL,FMT,DATEFMT) ; - date valued data
 ;
 N X,Y,%DT
 S VAL=$G(VAL),FMT=$G(FMT),FMT=$S(FMT]""&("IEB"[FMT):FMT,1:"I")
 S %DT=$S($G(DATEFMT)]"":DATEFMT,1:"TSX")
 S X=VAL
 D ^%DT K %DT S VAL=$S(Y>0:Y,1:"")
 S:"EB"[FMT&(Y]"") Y=$$FMTE^XLFDT(VAL,"1P")
 Q $S("IB"[FMT:VAL,1:"")_$S("EB"[FMT:$S(Y]"":"^",1:"")_Y,1:"")
 ;
SET(VAL,FMT,VSITDD0) ; - set of codes valued data
 ;
 N Y S Y=""
 S VAL=$G(VAL),FMT=$G(FMT),FMT=$S(FMT]""&("IEB"[FMT):FMT,1:"I")
 S VSITDD0=$G(@VSITDD0),VSITDD0=$S($P(VSITDD0,"^",2)'["S":"",1:";"_$P(VSITDD0,"^",3))
 D:VAL]""
 . I VSITDD0[(";"_$P(VAL,"^")_":") S Y=$P(VSITDD0,";",$L($E(VSITDD0,1,$F(VSITDD0,";"_$P(VAL,"^")_":")),";")) ; - internal code
 . E  S Y=$P(VSITDD0,";",$L($E(VSITDD0,1,$F(VSITDD0,":"_$TR(VAL,"^"))-1),";")) ; - external code
 . S Y=$TR(Y,":","^")
 Q $S("IB"[FMT:$P(Y,"^"),1:"")_$S("EB"[FMT:$S($P(Y,"^",2)]"":"^",1:"")_$P(Y,"^",2),1:"")
 ;
PTR(VAL,FMT,VSITDD0) ; - pointer valued data
 ;
 N D,Y,DIC S VAL=$G(VAL),FMT=$G(FMT),FMT=$S(FMT]""&("IEB"[FMT):FMT,1:"I")
 S VSITDD0=$G(@VSITDD0),Y="" D:$P(VSITDD0,"^",2)["P"
 . F  I $D(@("^"_$P(^(0),"^",3)_"0)")) S VSITDD0=$P(^(0),"^",2) Q:'$D(^(+VAL,0))  S Y=$P(^(0),"^") I $D(^DD(+VSITDD0,.01,0)) S VSITDD0=$P(^(0),"^",2) Q:VSITDD0'["P"
 S:Y]"" Y=VAL_"^"_Y
 I +VSITDD0,'+$P(Y,"^") S X=VAL,DIC=+VSITDD0,DIC(0)="N",D="B" D IX^DIC S Y=$S(Y>0:Y,1:"")
 Q $S("IB"[FMT:$P(Y,"^"),1:"")_$S("EB"[FMT:$S($P(Y,"^",2)]"":"^",1:"")_$P(Y,"^",2),1:"")
