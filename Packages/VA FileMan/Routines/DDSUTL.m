DDSUTL ;SFISC/MKO-PROGRAMMER UTILITIES ;11:37 AM  25 Jul 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
MSG(TXT) ;
 ;Data validation messages
 D PROC(.TXT,$NA(@DDSREFT@("MSG")))
 Q
 ;
HLP(TXT) ;
 ;Help box messages
 D PROC(.TXT,$NA(@DDSREFT@("HLP")))
 Q
PROC(TXT,GLB) ;
 ;Put text into global
 N CNT,I
 S CNT=$G(@GLB)
 I $D(TXT)<9 S CNT=CNT+1,@GLB@(CNT)=TXT
 E  S I="" F CNT=CNT:1 S I=$O(TXT(I)) Q:I=""  S @GLB@(CNT+1)=TXT(I)
 S @GLB=CNT
 Q
 ;
REFRESH ;Refresh the screen
 G R^DDSR
 ;
MLOAD(DDSIEN) ;Load subrecords for current multiple
 G MLOAD^DDSM1
 ;
MDEL(DDSIEN) ;Delete subrecords for current multiple
 G MDEL^DDSM1
 ;
UNED(DDSF,DDSB,DDSP,DDSVAL,DDSUDA) ;Change DISABLE EDITING attribute
 S:$D(DDSVAL)[0 DDSVAL=""
 D SETATT(4)
 Q
 ;
REQ(DDSF,DDSB,DDSP,DDSVAL,DDSUDA) ;Change REQUIRED attribute
 S:$D(DDSVAL)[0 DDSVAL=""
 D SETATT(1)
 Q
 ;
 ;
SETATT(DDSUPC) ;Set attribute node, piece DDSUPC
 N DDSOVAL,DDSUDDP,DDSUFLD,DDSUTP
 I $D(DDSPG)[0 N DDSPG S DDSPG=""
 I $D(DDSBK)[0 N DDSBK S DDSBK=""
 S DDSP=$$GETFLD^DDSLIB(DDSF,$G(DDSB),$G(DDSP),+DDS,DDSPG,DDSBK)
 I $G(DIERR) D ERR^DDSMSG Q
 ;
 S DDSF=$P(DDSP,","),DDSB=$P(DDSP,",",2),DDSP=$P(DDSP,",",3)
 ;
 S DDSUDDP=+$P($G(^DIST(.404,DDSB,0)),U,2)
 I DDSUDDP,$G(DDSUDA)]"" N DDSDA S DDSDA=DDSUDA
 E  I DDSUDDP,DDSB'=DDSBK N DDSDA D GL^DDS10(DDSUDDP,.DDSDAORG,"","",.DDSDA)
 ;
 S DDSUTP=$P($G(^DIST(.404,DDSB,40,DDSF,0)),U,3) S:'DDSUTP DDSUTP=3
 I DDSUTP=2 D
 . S DDSUFLD=DDSF_","_DDSB
 . S DDSUDDP=0
 E  I DDSUTP=3 D  Q:'DDSUFLD
 . S DDSUFLD=$P($G(^DIST(.404,DDSB,40,DDSF,1)),U)
 E  Q
 ;
 S DDSOVAL=$P($G(@DDSREFT@("F"_DDSUDDP,DDSDA,DDSUFLD,"A")),U,DDSUPC)
 Q:DDSVAL=DDSOVAL
 S $P(@DDSREFT@("F"_DDSUDDP,DDSDA,DDSUFLD,"A"),U,DDSUPC)=DDSVAL
 Q
 ;
ADD(DDSFIL,X,DA,DINUM,DDSDIC0,DDSDR,DDSL) ;
 ;Add an entry as part of a transaction
 ;DDSL=1 means don't lock
 ;
 N %,%W,%Y,C,D0,DD,DO,DI,DIC,DIE,DQ,DR
 N DDSDA,DDSDIC,DDSFD,DDSREQ,DDSUP,I
 K DIERR,^TMP("DIERR",$J)
 K:'$G(DINUM) DINUM
 S:$G(DDSDIC0)="" DDSDIC0="L"
 S DIC(0)=DDSDIC0,Y=-1
 S:$G(DDSDR)]"" DIC("DR")=DDSDR
 S DIC=$$ROOT^DILFD(DDSFIL,.DA),DDSDIC=$$CREF^DIQGU(DIC)
 ;
 I $D(@DDSDIC@(0))[0 D  Q:$G(DIC("P"))=""
 . S DDSUP=$G(^DD(DDSFIL,0,"UP")) Q:'DDSUP
 . S DDSFD=$O(^DD(DDSUP,"SB",DDSFIL,"")) Q:'DDSFD
 . S DIC("P")=$P($G(^DD(DDSUP,DDSFD,0)),U,2)
 ;
 I DDSDIC0'["E",$$REQID(DDSFIL,.DDSREQ) D  Q:$G(DIERR)
 . N F
 . S F=""
 . F  S F=$O(DDSREQ(F)) Q:'F  I $G(DIC("DR"))'[(F_"///") D BLD^DIALOG(3031,"ADD^DDSUTL") Q
 ;
 D FILE^DICN K DTOUT,DUOUT Q:Y=-1!'$D(DDS)
 ;
 I '$G(DDSL) D
 . N I,L,R
 . S L=1,R=DIC_DA_","
 . F I=$L(R,",")-1:-1:1 I $D(^TMP("DDS",$J,"LOCK",$P(R,",",1,I)_")"))#2 S L=0 Q
 . I L,$D(^TMP("DDS",$J,"LOCK",$P(R,"(")))#2 S L=0
 . I L L +@(DIC_+Y_")"):0 S ^TMP("DDS",$J,"LOCK",DIC_+Y_")")=""
 ;
 S DDSDA=+Y_","
 F I=1:1 Q:$D(DA(I))[0  S DDSDA=DDSDA_DA(I)_","
 S ^("ADD")=$G(@DDSREFT@("ADD"))+1,^("ADD",^("ADD"))=DDSDA_DIC
 Q
 ;
REQID(FIL,REQ) ;
 ;Get list of required identifiers into DDSREQ
 N F
 K REQ
 S F="" F  S F=$O(^DD(FIL,0,"ID",F)) Q:F'=+$P(F,"E")  D
 . S:$P($G(^DD(FIL,F,0)),U,2)["R" REQ(F)=""
 Q $D(REQ)>0
 ;
DESTROY(PG) ;Destroy all data for page PG
 N P,B,F,IENS,TP,FIL,FLD
 S P=$O(^DIST(.403,+DDS,40,"B",PG,"")) Q:'P
 S B=0 F  S B=$O(^DIST(.403,+DDS,40,P,40,B)) Q:'B  D
 . Q:'$D(^DIST(.403,+DDS,40,P,40,B,0))
 . Q:'$D(^DIST(.404,B,0))  S FIL=$P(^(0),U,2)
 . S F=0 F  S F=$O(^DIST(.404,B,40,F)) Q:'F  D
 .. Q:'$D(^DIST(.404,B,40,F,0))  S TP=$P(^(0),U,3)
 .. S:'TP TP=3
 .. ;
 .. I TP=3 S FF="F"_FIL,FLD=$G(^DIST(.404,B,40,F,1)) Q:FLD?."^"
 .. E  I TP=2 S FF="F0",FLD=F_","_B
 .. E  Q
 .. ;
 .. S IENS=" "
 .. F  S IENS=$O(@DDSREFT@(FF,IENS)) Q:IENS=""  K ^(IENS,FLD)
 ;
 K @DDSREFT@(P),@DDSREFT@("XCAP",P)
 Q
 ;
 ;
DDSDA(DA,DL,DDSDA) ;Determine DDSDA
 ;
 N I
 I DA="" S DDSDA="" Q
 S DDSDA=DA_"," F I=1:1:DL S DDSDA=DDSDA_DA(I)_","
 Q
