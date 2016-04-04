DDSCOMP ;SFISC/MKO-EVALUATE COMPUTED EXPRESSIONS ;8:55 AM  12 Feb 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
PARSE(DDP,EXP,BK,NEXP,AR,FDL) ;Parse the computed expression EXP
 ;Returns:
 ;  NEXP = EXP with {expr} replaced with DDSE(n)
 ;  AR   = array when executed sets DDSE(n)
 ;  FDL  = list of fields referenced
 N I,J,N,ST
 ;
 S NEXP="",(N,AR)=0,ST=1
 S I=0 F  D  Q:'I!$G(DIERR)
 . S I=$$FIND^DDSLIB(EXP,"{",I) Q:'I
 . S N=N+1
 . S NEXP=NEXP_$E(EXP,ST,I-2)_"DDSE("_N_")"
 . S ST=$$FIND^DDSLIB(EXP,"}",I)
 . D EVAL(DDP,$E(EXP,I,ST-2),BK,N,.AR,.FDL) Q:$G(DIERR)
 . S I=ST
 Q:$G(DIERR)
 S NEXP=$S(EXP?1"=".E:"S Y",1:"")_NEXP_$E(EXP,ST,999)
 ;
 S AR=N
 S:$G(FDL)]"" FDL=$E(FDL,1,$L(FDL)-1)
 Q
 ;
EVAL(DDP,EXP,BK,N,AR,FDL) ;Evaluate field expression
 ;In:
 ;  EXP = computed expr
 ;  N   = expr number -- index into DDSE()
 ;Out:
 ;  AR  = array of code that sets DDSE(n)
 ;  FDL = list of fields used in expr
 ;
 N CD
 D:EXP?1"FO(".E FO^DDSPTR(DDP,EXP,"","",BK,.CD,.FDL,1)
 D:EXP'?1"FO(".E DD^DDSPTR(DDP,EXP,"",.CD,.FDL,1)
 Q:$G(DIERR)
 ;
 I CD=1 S AR(N)="N X "_CD(1)_",DDSE("_N_")=X"
 E  D
 . F CD=1:1:CD S AR(N,CD)=CD(CD)
 . S AR(N,CD)=AR(N,CD)_",DDSE("_N_")=X"
 . S AR(N)="N DDSI,X S DDSE("_N_")="""" F DDSI=1:1:"_CD_" Q:DDSI>1&($G(X)'>0)!'$D(*DDSREFC*,DDSI))  X ^(DDSI)"
 Q
 ;
RPCF(DDSPG) ;Repaint computed fields
 ;Called from ^DDS01 and ^DDSVALF when value used in
 ;computed expression changes
 N DDSCBK,DDSCDDO
 ;
 S DDSCBK="" F  S DDSCBK=$O(@DDSREFS@("COMP",DDP,DDSFLD,DDSPG,DDSCBK)) Q:DDSCBK=""  D
 . I $P($G(@DDSREFS@(DDSPG,DDSCBK)),U,7)>1 D DB^DDSR(DDSPG,DDSCBK) Q
 . N DA,DDSDA
 . D GETDA(DDSPG,DDSCBK,.DA)
 . S DDSDA=$$DDSDA(.DA)
 . S DDSCDDO="" F  S DDSCDDO=$O(@DDSREFS@("COMP",DDP,DDSFLD,DDSPG,DDSCBK,DDSCDDO)) Q:DDSCDDO=""  D RPCF1
 ;
 Q
 ;
RPCF1 ;
 N DDSC,DDSE,DDSLEN,DDSX
 S DDSC=$G(@DDSREFS@(DDSPG,DDSCBK,DDSCDDO,"D")) Q:DDSC=""
 S DDSX=$$VAL(DDSCDDO,DDSCBK,DDSDA)
 ;
 S DY=+DDSC,DX=$P(DDSC,U,2),DDSLEN=$P(DDSC,U,3)
 I $P(DDSC,U,10) S DDSX=$J("",DDSLEN-$L(DDSX))_$E(DDSX,1,DDSLEN)
 E  S DDSX=$E(DDSX,1,DDSLEN)_$J("",DDSLEN-$L(DDSX))
 X IOXY
 W $P(DDGLVID,DDGLDEL)_DDSX_$P(DDGLVID,DDGLDEL,10)
 ;
 N DDP,DDSFLD
 S DDP=0,DDSFLD=DDSCDDO_","_DDSBK
 D:$D(@DDSREFS@("COMP",DDP,DDSFLD,DDSPG)) RPCF(DDSPG)
 ;
 Q
 ;
GETDA(P,B,DA) ;Get DA array of block
 N I K DA
 S DA=$G(@DDSREFT@(P,B)) Q:DA=""  Q:'$G(^(B,DA))
 F I=2:1:$L(DA,",")-1 S DA(I-1)=$P(DA,",",I)
 S DA=+DA
 Q
 ;
VAL(DDSDDO,DDSBK,DDSDA) ;Return value of computed field
 N DDSE,DDSX,Y
 I $D(DDSDA) N DA D DA(DDSDA,.DA)
 S DDSX=0 F  S DDSX=$O(@DDSREFS@("COMPE",DDSBK,DDSDDO,DDSX)) Q:DDSX=""  X ^(DDSX)
 K Y X $G(@DDSREFS@("COMPE",DDSBK,DDSDDO))
 Q $G(Y)
 ;
DA(DDSDA,DA) ;Return DA array based on DDSDA
 N I
 S DA=$P(DDSDA,",")
 F I=2:1:$L(DDSDA,",") S DA(I-1)=$P(DDSDA,",",I)
 Q
 ;
DDSDA(DA) ;Return DDSDA based on DA array
 N DDSDA,I
 I $G(DA)="" S DDSDA="0,"
 E  D
 . S DDSDA=DA_","
 . F I=1:1 Q:$G(DA(I))=""  S DDSDA=DDSDA_DA(I)_","
 Q DDSDA
