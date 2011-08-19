RGUTMTL ;CAIRO/DKM - Multi-term lookup support ;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Parse term into component words (KWIC)
PARSE2(RGTRM,RGRTN,RGMIN) ;
 N X,L,C,%
 K RGRTN
 S %="RGRTN(I)",X=$$UP^XLFSTR(RGTRM),RGMIN=+$G(RGMIN)
 D S^XTLKWIC
 S L="",C=0
 F  S L=$O(RGRTN(L)) Q:L=""  D
 .I $L(L)<RGMIN K RGRTN(L)
 .E  S C=C+1
 Q C
 ; Parse term into component words
PARSE(RGTRM,RGRTN,RGMIN) ;
 N X,Y,Z,L,C
 K RGRTN
 S RGTRM=$$UP^XLFSTR(RGTRM),C=0,RGMIN=+$G(RGMIN,1),Z=""
 F X=1:1 Q:'$L(RGTRM)  D:$E(RGTRM,X)'?1AN
 .S Y=Z,Z=$E(RGTRM,X),L=$E(RGTRM,1,X-1),RGTRM=$E(RGTRM,X+1,999),X=0
 .I $L(L)'<RGMIN,L'=+L,'$D(RGRTN(L)) S RGRTN(L)=Y,C=C+1,Y=""
 Q C
 ; Create/delete an MTL cross reference for term
XREF(RGRT,RGTRM,RGDA,RGDEL) ;
 N RGZ,RGG
 S RGZ=$L(RGRT),RGG=$S($E(RGRT,RGZ)=")":$E(RGRT,1,RGZ-1)_",",1:RGRT_"(")_"RGZ,",RGZ=$C(1)
 F  S RGZ=$O(RGDA(RGZ),-1) Q:'RGZ  S RGG=RGG_""""_RGDA(RGZ)_""","
 S RGG=RGG_""""_RGDA_""")"
 Q:'$$PARSE(RGTRM,.RGZ)
 S RGZ="",RGDEL=''$G(RGDEL)
 L +@RGRT
 F  S RGZ=$O(RGZ(RGZ)) Q:RGZ=""  D
 .I ''$D(@RGG)=RGDEL D
 ..I RGDEL K @RGG  K:$D(@RGRT@(RGZ))<10 @RGRT@(RGZ)
 ..E  D:'$D(@RGRT@(RGZ)) REFNEW(RGZ) S @RGG=""
 ..D REFCNT(RGZ,$S(RGDEL:-1,1:1))
 L -@RGRT
 Q
 ; Increment/decrement reference count for term and its stems
REFCNT(RGX,RGI) ;
 Q:'$L(RGX)
 I $D(@RGRT@(RGX)) D
 .N RGZ
 .S RGZ=$G(@RGRT@(RGX))+RGI
 .I RGZ<1 K @RGRT@(RGX)
 .E  S @RGRT@(RGX)=RGZ
 D REFCNT($E(RGX,1,$L(RGX)-1),RGI)
 Q
 ; Create new term reference
REFNEW(RGX) ;
 N RGZ,RGC,RGABR
 S RGZ=RGX,RGC=0,RGABR=0
 F  S RGZ=$$STEM(RGZ,RGX) Q:'$L(RGZ)  S RGC=RGC+$G(@RGRT@(RGZ)),RGZ=RGZ_$C(255)
 S @RGRT@(RGX)=RGC
 Q
 ; Lookup a term in an MTL index
 ; RGRT  = Root of index (e.g., ^RGCOD(990.9,"AD"))
 ; RGTRM = Term to lookup
 ; RGRTN = Root of returned array (note: killed before populated)
 ; RGABR = If nonzero, user can abort lookup with ^
LKP(RGRT,RGTRM,RGRTN,RGABR) ;
 N RGX,RGY,RGW,RGF,RGIEN,RGL,RGM,RGTRM1
 I $$NEWERR^%ZTER N $ET S $ET=""
 K @RGRTN
 S RGABR=+$G(RGABR),@$$TRAP^RGZOSF("LKP2^RGUTMTL")
 I $$PARSE(RGTRM,.RGTRM)=1 S RGW(1,$O(RGTRM("")))=""
 E  D
 .S RGTRM="",RGM=9999999999
 .F  S RGTRM=$O(RGTRM(RGTRM)) Q:RGTRM=""  D  Q:RGL<0
 ..S RGX=RGTRM(RGTRM)["=",RGY=RGTRM(RGTRM)["~",RGTRM1="",RGL=$S(RGY:9999999999,1:-1)
 ..I 'RGY F  S RGTRM1=$$STEM(RGTRM1,RGTRM,RGX) Q:RGTRM1=""  D:$D(^(RGTRM1))>1  Q:RGL>RGM
 ...S:RGL=-1 RGL=0
 ...S RGL=RGL+$G(^(RGTRM1))
 ...S RGTRM1=RGTRM1_$C(255)
 ..S RGW(RGL,RGTRM)=""
 ..I RGL>0,RGL<RGM S RGM=RGL
 ..D:RGABR ABORT
 Q:$D(RGW(-1)) 0
 S RGW="",RGF=0
 F  S RGW=$O(RGW(RGW)),RGTRM="" Q:RGW=""  D  Q:RGF=-1
 .F  S RGTRM=$O(RGW(RGW,RGTRM)) Q:RGTRM=""  D  Q:RGF=-1
 ..S RGX=RGTRM(RGTRM)["=",RGY=RGTRM(RGTRM)["~"
 ..I RGF D
 ...S RGIEN=0
 ...F  S RGIEN=$O(@RGRTN@(RGIEN)),RGTRM1="" Q:'RGIEN  D  Q:RGF=-1
 ....F  S RGTRM1=$$STEM(RGTRM1,RGTRM,RGX) Q:RGTRM1=""  Q:$D(^(RGTRM1,RGIEN))
 ....I RGY-(RGTRM1="") K @RGRTN@(RGIEN) S:$D(@RGRTN)'>1 RGF=-1
 ..E  D
 ...S RGTRM1="",RGF=1
 ...F  S RGTRM1=$$STEM(RGTRM1,RGTRM,RGX) Q:RGTRM1=""  M @RGRTN=^(RGTRM1)
 ...S:$D(@RGRTN)'>1 RGF=-1
 Q $D(@RGRTN)>1
LKP2 K @RGRTN
 Q -1
 ; Check for user abort
ABORT N RGZ
 R RGZ#1:0
 D:RGZ=U RAISE^RGZOSF()
 Q
 ; Return in successive calls all terms sharing common stem
 ; (sets naked reference)
STEM(RGLAST,RGSTEM,RGF) ;
 D:RGABR ABORT
 I RGLAST="" S RGLAST=RGSTEM Q:$D(@RGRT@(RGLAST)) RGLAST
 Q:$G(RGF) ""
 S RGLAST=$O(@RGRT@(RGLAST))
 Q $S($E(RGLAST,1,$L(RGSTEM))=RGSTEM:RGLAST,1:"")
