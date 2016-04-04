DDS6 ;SFISC/MKO-DELETIONS ; 14NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1003**
 ;
 ;Enter here if user deleted record from the .01 of the (sub)record
 ;(called from DDS01)
 ;In:  DDSU array, DDSOLD, DDSFLD
 D D
 I 'Y D  ;DELETE DIDN'T HAPPEN
 . S @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"D")=DDSOLD
 . S:$D(DDSU("X"))#2 @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"X")=DDSU("X")
 E  D
 . I $D(DDSREP) D
 .. D DEL^DDSM1(DDSDA)  ;THIS WILL COME BACK TO K IN THIS ROUTINE!
 . E  D K(DDSDA,DIE) I $D(DDSPTB) D
 .. S DDACT="NB"
 .. S $P(@DDSREFT@(DDSPG,DDSBK),U)=""
 .. D DB^DDSR(DDSPG,DDSBK)
 .. D RPF^DDS7(DDP,DDSPTB,DDSDA,.DA)
 . E  S DDACT="Q",DA="",DDSDAORG=DA,DDSDA="0,"
 . I '$D(DDSPTB),'$P(DDSSC(DDSSC),U,4),'$D(DDSREP) D
 .. D PG^DDSRSEL
 .. I $G(DDSSEL) D
 ... D CLRDAT^DDSRSEL
 ... D R^DDSR
 ... D PUT^DDSVALF(1,1,$P(^DIST(.403,+DDS,21),U),"","","0,")
 Q
 ;
DM ;Enter here if user deleted record from the Select prompt
 ;(called from DDS5)
 ;In:  DDSU array, DDSOLD, DDSFLD
 ;
 ;Get DA and DIE for subfile level and delete
 D DDA^DDS5(DDSOLD,.DA,.DDSDL)
 D
 . N DIE,DDSDA
 . S DIE=U_$P(DDSU("M"),U,2)
 . S DDSDA=DA_"," F DDSI=1:1:DDSDL S DDSDA=DDSDA_DA(DDSI)_","
 . K DDSI
 . D D
 . D:Y K(DDSDA,DIE)
 ;
 I 'Y D
 . S @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"D")=DDSOLD
 . S:$D(DDSU("X"))#2 @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"X")=DDSU("X")
 . D UDA^DDS5(.DA,.DDSDL)
 E  D
 . D LST^DDS5(.DA,.DDSDL,DDP,DDSDA,DDSFLD)
 . D UDA^DDS5(.DA,.DDSDL)
 Q
 ;
D ;Delete the subrecord
 ;In: DA array, DIE, DDSDL; Out: Y=1 if successful
 N DR,DDS6DA,DDSI
 D:DDM CLRMSG^DDS
 S DDM=1
 ;
 K DIR S DIR(0)="YO"
 D BLD^DIALOG(8080,$$EZBLD^DIALOG(8078+(DDSDL>0)),"","DIR(""A"")")
 D BLD^DIALOG(9038,"","","DIR(""?"")")
 ;
 S DIR0=IOSL-1_U_($L(DIR("A"))+1)_"^3^"_(IOSL-3)_"^0"
 D ^DIR K DIR
 D CLRMSG^DDS
 I X=""!$D(DIRUT)!'Y S Y=0 K DIRUT,DUOUT,DIROUT,DTOUT Q
 ;
 S DDS6DA=DA N D0
 F DDSI=1:1 Q:$D(DA(DDSI))[0  S DDS6DA(DDSI)=DA(DDSI) N @("D"_DDSI)
 W $P(DDGLVID,DDGLDEL,9) S X=IOM X DDGLZOSF("RM")
 S DR=".01///@" D ^DIE K DI ;DELETE THE SUB-RECORD!
 W $P(DDGLVID,DDGLDEL,8) S X=0 X DDGLZOSF("RM")
 ;
 ;I $D(DA) H 2 W $P(DDGLCLR,DDGLDEL,2) D R^DDSR S Y=0 Q
 I $D(DA) S:$Y>(DDSHBX+1) DDSKM=1,DDM=1 S Y=0 Q
 ;
 S Y=1,DA=DDS6DA
 I '$G(DDSCHANG),$G(DDSPARM)["C" S DDSCHANG=1
 F DDSI=1:1 Q:$D(DDS6DA(DDSI))[0  S DA(DDSI)=DDS6DA(DDSI)
 Q
 ;
K(DDSIEN,DIE) ;Remove all data pertaining to the (sub)record from @DDSREFT
 ;In: DDSIEN = IENS of record being deleted
 ;    DIE    = global root
 ;
 N B,P,FN,PAT,PDA,IENS
 S PAT=".E1"""_DDSIEN_""""
 ;
 ;Loop through all pages/blocks in ^TMP
 S P=0 F  S P=$O(@DDSREFT@(P)) Q:'P  D
 . S B=0 F  S B=$O(@DDSREFT@(P,B)) Q:'B  D
 .. ;Get file number of the block
 .. S FN="F"_$P(@DDSREFS@(P,B),U,3)
 .. ;
 .. ;Loop through all records loaded for that block
 .. S IENS=" "
B .. F  S IENS=$O(@DDSREFT@(P,B,IENS)) Q:IENS'[","  D
 ... ;
 ... ;If the data pertains to the current or ancestor file, kill it
 ... ;Get the parent IENS (also indicates the block is repeating)
 ... S PDA=$P($G(@DDSREFT@(P,B,IENS)),U,2)
 ... ;
 ... I 'PDA,IENS?@PAT,$P(@DDSREFT@(P,B,IENS,"GL"),DIE)="" D
 .... K @DDSREFT@(P,B,IENS)
 .... K @DDSREFT@(FN,IENS)
SUB ... E  I $P($G(@DDSREFT@(P,B,IENS)),U,6)!PDA,@DDSREFT@(P,B,IENS,"GL")=DIE D  ;IF IT'S A MULTIPLE IN A REPEATING BLOCK
 .... D DELP(P,B,PDA,DDSIEN)
 .... K @DDSREFT@(FN,DDSIEN)
 Q
 ;
DELP(P,B,PDA,IENS) ;Delete subrecord from parent's list
 ;In: P    = page number
 ;    B    = block number
 ;    PDA  = parent IENS
 ;    IENS = IENS of record to remove
 N R,S
 ;
 S S=$G(@DDSREFT@(P,B,PDA,"B",IENS)) Q:'S
 K @DDSREFT@(P,B,PDA,"B",IENS)
 ;
 F S=S:1 Q:$D(@DDSREFT@(P,B,PDA,S+1))[0  D
 . S R=@DDSREFT@(P,B,PDA,S+1)
 . S @DDSREFT@(P,B,PDA,S)=R
 . S @DDSREFT@(P,B,PDA,"B",R)=S
 K @DDSREFT@(P,B,PDA,S)
 Q
 ;
DEL ;Delete (sub)records added between saves
 ;(user quit without saving)
 N DA,DIK
 S DDSI=0
 F  S DDSI=$O(@DDSREFT@("ADD",DDSI)) Q:'DDSI  D
 . K DA
 . S DA=$P(@DDSREFT@("ADD",DDSI),U),DIK=U_$P(^(DDSI),U,2)
 . F DDSX=2:1:$L(DA,",")-1 S DA(DDSX-1)=$P(DA,",",DDSX)
 . S DA=+DA
 . D ^DIK
 K DDSI,DDSX
 Q
 ;#8078  record
 ;#8079  subrecord
 ;#8080  WARNING: DELETIONS ARE DONE...
 ;#9038  Enter 'Y' to delete...
