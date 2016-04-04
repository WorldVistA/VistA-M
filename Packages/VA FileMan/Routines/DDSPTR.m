DDSPTR ;SFISC/MKO-SET "PT" AND "PTB" NODES ;7JAN2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1003**
 ;
PT(DDSDDP,EXP,DDS,PG,BK) ;Set "PT" and "PTB" nodes
 N DDP,FDL,CD,FD
 S DDP=DDSDDP
 S $P(@DDSREFS@(PG,BK),U,8)=1
 ;
 D:EXP?1"FO(".E FO(DDP,EXP,DDS,PG,BK,.CD,.FDL)
 D:EXP'?1"FO(".E DD(DDP,EXP,BK,.CD,.FDL)
 Q:$G(DIERR)
 ;
 S:FDL?.E1"^" FDL=$E(FDL,1,$L(FDL)-1)
 S @DDSREFS@(PG,BK,"PTB")=FDL
 F CD=1:1:CD S @DDSREFS@(PG,BK,"PTB",CD)=CD(CD)
 F CD=1:1:$L(FDL,U) D
 . S FD=$P($P(FDL,U,CD),";"),DDP=+FD,FD=$P(FD,",",2,99)
 . S @DDSREFS@("PT",DDP,FD,PG,BK)=""
 Q
 ;
DD(DDP,EXP,BK,CD,FDL,COMP) ;Parse DD expression
 ;In:
 ;  DDP  = file #
 ;  EXP  = rel expr
 ;  BK   = blk # (to get DD# of blk)
 ;  COMP = flag, EXP not pointer link
 ;         1, def is ext (DDSCOMP and DDSVAL)
 ;         2, def is int (DDSVAL)
 ;Returns:
 ;  CD   = array of code that sets DA
 ;  FDL  = list of flds used in expr
 ;
 N FD1,FD2,P,TYP
 I EXP?1"DD(".E D
 . N I
 . S I=$$RPAR^DDSLIB(EXP,3)
 . S DDP=$P($E(EXP,4,I-2),",")
 . S EXP=$P($E(EXP,4,I-2),",",2,999)_$E(EXP,I,999)
 ;
 I $G(DDP)="" D BLD^DIALOG(202,"file") Q
 ;
LOOP S CD=$G(CD)+1
LOOP1 I $E(EXP)="""" D
 . N I S I=$$AFTQ^DDSLIB(EXP)
 . S FD1=$$UQT^DDSLIB($E(EXP,1,I-1)),FD2=$P($E(EXP,I,999),":",2,999)
 . S P=$P($E(EXP,I,999),":")
 E  D
 . S FD1=$P($P(EXP,":"),";"),FD2=$P(EXP,":",2,999)
 . S P=$P($P(EXP,":"),";",2,999)
 S FD1=$$FIELD^DDSLIB(DDP,FD1) Q:$G(DIERR)
 ;
 S TYP=$P(^DD(DDP,FD1,0),U,2)
 I TYP S DDP=+TYP,EXP=FD2 D:EXP="" BLD^DIALOG(3083) Q:EXP=""  G LOOP1
 ;
 I FD2="",$G(COMP) D  Q
 . S P=$S(COMP=1:P'["I",1:P["E")
 . S CD(CD)="S X=$$GET^DDSVAL("_DDP_","_$S(CD=1:".DA",1:"X")_","_FD1_$S(P:","""",""E""",1:"")_")"
 . S FDL=$G(FDL)_DDP_","_FD1_U
 ;
 I TYP["V" D  Q:$G(DIERR)
 . S CD(CD)="S X=+$$GET^DDSVAL("_DDP_","_$S(CD=1:".DA",1:"X")_","_FD1_")"
 . S FDL=$G(FDL)_DDP_","_FD1_U
 . D GETFF(.FD2,.DDP)
 E  I TYP["P" D
 . S CD(CD)="S X=$$GET^DDSVAL("_DDP_","_$S(CD=1:".DA",1:"X")_","_FD1_")"
 . S FDL=$G(FDL)_DDP_","_FD1_U
 . S DDP=+$P(TYP,"P",2)
COMPTR E  I TYP["Cp" D
 .S CD(CD)="N D0 S D0=DA X $P(^DD("_DDP_","_FD1_",0),U,5,999) S X=X"
 .S FDL=$G(FDL)_DDP_","_FD1_U
 .S DDP=+$P(TYP,"p",2)
 E  D  Q:$G(DIERR)
 . N D,F,S
 . S FDL=$G(FDL)_DDP_","_FD1_";J^"
 . D LKPARM(P,.F,.D,.S)
 . S CD(CD)="N D,DIC,Y S X=$$GET^DDSVAL("_DDP_","_$S(CD=1:".DA",1:"X")_","_FD1_$S(F:"",1:","""",""E""")_")"
 . D GETFF(.FD2,.DDP) Q:$G(DIERR)
 . I FD2="" D  Q:$G(DIERR)
 .. I $G(COMP) D BLD^DIALOG(3083) Q
 .. S DDP=$P(^DIST(.404,BK,0),U,2)
 . I DDP="" D BLD^DIALOG(202,"file") Q
 . I '$D(^DD(DDP))!'$D(^DIC(DDP,0,"GL")) D  Q
 .. N P S P("FILE")=DDP D BLD^DIALOG(401,.P)
 . S CD(CD)=CD(CD)_",DIC="""_^DIC(DDP,0,"GL")_""""_D_S_" S X=+Y"
 ;
 I FD2]"" S EXP=FD2 G LOOP
 S CD(CD)=CD(CD)_",DA=X"
 Q
 ;
FO(DDP,EXP,DDS,PG,BK,CD,FDL,COMP) ;Parse FO expression
 N FD1,FD2,I,P
 ;
 S:'$D(DDS) DDS="" S:'$D(PG) PG="" S:'$D(BK) BK=""
 S CD=1
 S I=$$RPAR^DDSLIB(EXP,3)
 S FD1=$E(EXP,4,I-2),P=$P($E(EXP,I,999),":")
 S FD2=$P($E(EXP,I,999),":",2,999)
 F I=1:1:3 S P(I)=$$PIECE^DDSLIB(FD1,",",I)
 ;
 S FD1=$P($$GETFLD^DDSLIB(P(1),P(2),P(3),DDS,PG,BK,"F"),",",1,2)
 Q:$G(DIERR)
 ;
 I FD2="",$G(COMP) D  Q
 . S P=$S(COMP=1:P'["I",1:P["E")
 . S CD(1)="S X=$$GET^DDSVALF("""_FD1_""","""","""","""_$S(P:"E",1:"")_""",DDSDA)"
 . S FDL=$G(FDL)_"0,"_FD1_U
 ;
 I $P($G(^DIST(.404,+$P(FD1,",",2),40,+FD1,20)),U)="" D  Q
 . N P S P(1)="READ TYPE",P(2)="form-only field in the BLOCK"
 . D BLD^DIALOG(3011,.P)
 ;
 I $P(^DIST(.404,+$P(FD1,",",2),40,+FD1,20),U)["P" D
 . S CD(1)="S X=$$GET^DDSVALF("""_FD1_""","""","""","""",DDSDA)"
 . S FDL=$G(FDL)_"0,"_FD1_U
 . S DDP=U_$P($P(^DIST(.404,+$P(FD1,",",2),40,+FD1,20),U,3),":")
 E  D  Q:$G(DIERR)
 . N D,F,S
 . S FDL=$G(FDL)_"0,"_FD1_";J^"
 . D LKPARM(P,.F,.D,.S)
 . S CD(1)="N D,DIC,Y S X=$$GET^DDSVALF("""_FD1_""","""","""","""_$S(F:"",1:"E")_""",DDSDA)"
 . D GETFF(.FD2,.DDP) Q:$G(DIERR)
 . I FD2="" S DDP=$P(^DIST(.404,BK,0),U,2)
 . I DDP="" D BLD^DIALOG(202,"file") Q
 . I '$D(^DD(DDP))!'$D(^DIC(DDP,0,"GL")) D  Q
 .. N P S P("FILE")=DDP D BLD^DIALOG(401,.P)
 . S CD(1)=CD(1)_",DIC="""_^DIC(DDP,0,"GL")_""""_D_S_" S X=+Y"
 ;
 I FD2="" S CD(CD)=CD(CD)_",DA=X"
 E  S EXP=FD2 D DD(DDP,EXP,BK,.CD,.FDL,$G(COMP))
 Q
 ;
GETFF(FD2,DDP) ;Get file, field
 ;Input:  FD2=file:field:...
 ;Output: FD2=field:...
 ;        DDP=file number
 I $E(FD2)="""" D
 . N I S I=$$AFTQ^DDSLIB(FD2,1)
 . S DDP=$$UQT^DDSLIB($E(FD2,1,I-1)),FD2=$E(FD2,I,999)
 E  S DDP=$P(FD2,":"),FD2=$P(FD2,":",2,999)
 ;
 I DDP]"",DDP'=+$P(DDP,"E") D
 . I '$D(^DIC("B",DDP)) D BLD^DIALOG(3012,DDP) Q
 . S DDP=$O(^DIC("B",DDP,""))
 Q
 ;
LKPARM(P,F,D,S) ;Parse lookup params
 ;In:  P = specifiers separated by ;
 ;Out: F = 1 if int form wanted
 ;     D = code that sets D and DIC(0)
 ;     S = code that calls ^DIC
 N I,IP,L,M
 S (D,F,L,M)=""
 F I=1:1:$L(P,";") D
 . S IP=$P(P,";",I) Q:IP=""
 . I IP="I" S F=1 Q
 . I IP="L" S L=1 Q
 . I IP?.1"M"1"IX(".E1")" D  Q
 .. S IP=$P($P(IP,"(",2),")")
 .. S:$E(IP)'="""" IP=$$QT^DDSLIB(IP)
 .. S D=",D="_IP
 .. I $L(IP,U)>1 S D=D_",DIC(0)=""MF""",S=" D MIX^DIC1"
 .. E  S D=D_",DIC(0)=""F""",S=" D IX^DIC"
 S:D="" D=",DIC(0)=""MF""",S=" D ^DIC"
 S D=D_" S:$G(DDS1E) DIC(0)=DIC(0)_""E"_$E("L",L)_""""
 Q
