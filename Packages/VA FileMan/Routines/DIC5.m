DIC5 ;SFISC/XAK,TKW,SEA/TOAD-VA FileMan: Lookup, Part 1 (utilities) ;24MAY2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,20,31,70,159**
 ;
NODE75 ; Do after executing 7.5 node on DD, called from ^DIC
 I $D(X)#2 S (DIVAL,DIVAL(1))=X Q
 S Y=-1 Q:DIC(0)'["Q"!(DIC(0)'["E")
 W $C(7) Q:$D(DDS)
 W !,$$EZBLD^DIALOG(120,$$EZBLD^DIALOG(8090)) Q
 ;
BYIEN1 ; Lookup record by IEN when user enters `n for a number 'n', called from ^DIC
 S Y=$E(X,2,30) I Y="" S Y=-1 Q
 N % S %=DINDEX("START") N DINDEX S DINDEX="",DINDEX("#")=1,DINDEX("START")=%
 D S^DIC3 I '$T S Y=-1 Q
 N DD,DS,DZ S DS=1,DD=Y,DIX=X D ADDKEY^DIC3,GOT^DIC2
 Q
 ;
BYIEN2 ; Lookup record by IEN when user enters a numeric lookup value, called from ^DIC
 Q:DO(2)<0!($D(DF))
 N T S T=DINDEX(1,"TYPE")
 I $D(@(DIC_"X,0)")) D  Q:Y>0
 . N DD S DD=$D(^DD(DIFILEI,.001))
 . I 'DD Q:T["N"  I '$O(@(DIC_"""A["")")),$O(^("A["))]"" Q
 . N % S %=DINDEX("START") N DINDEX S DINDEX="",DINDEX("#")=1,DINDEX("START")=%
 . S Y=X D S^DIC3 I '$T S Y=-1 Q
 . N DZ,DS,DIX,DIC5D S DIC5D=D,DS=1,DIX=X D ADDKEY^DIC3,GOT^DIC2 Q:Y>0
 . D DO^DIC1 S D=DIC5D
 I T["P"!(T["V"),DIC(0)'["U" S DISKIPIX=D
 Q
 ;
SPACEBAR ; Lookup last record selected by this user when user enters space bar return.  Called from ^DIC
 N % S %=DINDEX("START") N DINDEX S DINDEX="",DINDEX("#")=1,DINDEX("START")=%
 D S^DIC3 I '$T S Y=-1 Q
 N DZ,DS,DIX S DS=1,DIX=X D ADDKEY^DIC3,GOT^DIC2 Q
 ;
KEEPON ; If DIC(0)["T", display entries found so far, then check for internal value if index is date, set, pointer, VP.  Called from ^DIC3.
 I DS D  Q:Y>0!($G(DTOUT))!($G(DIROUT))
 . N I M I=X N X M X=I S I=D N D S D=I K I
 . I DS=1 D
 . . S DS("DD")=1 D G^DIC2 Q
 . E  I $G(DS("DD"))'=DS D Y^DIC1 I '$D(DIROUT),$D(DUOUT) K DUOUT ;22*70
 . K DD,DS,DIX,DIYX S (DD,DS,DS("DD"))=0
 . S:DIC(0)["E" DS(0,"HDRDSP",DIFILEI)=1
 . S DS(0)=$S(Y>0:"1^"_+Y,$G(DTOUT):"1^T",$G(DIROUT):"1^U",1:0)
 . Q
 Q:DIC(0)["U"  I DINDEX=DINDEX("START"),$G(DINDEX("#"))>1 Q
 N I M I=X N X M X=I S I=D N D S D=I K I
 D 1^DICM
 K DD,DS,DIX,DIYX S (DD,DS,DS("DD"))=0
 S DS(0)=$S(Y>0:"1^"_+Y,$G(DTOUT):"1^T",$G(DIROUT):"1^U",1:0)
 Q
 ;
PTRID(DO,DIC) ; Build code in DIC("W") to display Identifiers on pointed-to files
 N DIFILEI,DIGBL,DIOGBL S DIFILEI=+DO(2),DIOGBL=DIC
 F  S DIFILEI=+$P($P($G(^DD(DIFILEI,.01,0)),U,2),"P",2) Q:'DIFILEI  S DIGBL=$G(^DIC(DIFILEI,0,"GL")) Q:DIGBL=""  D Q
 Q
Q ; Build Identifier code for a single pointed-to file
 N DIGBL1 S DIGBL1=DIGBL
 I DIGBL[$C(34) S DIGBL1=$$CONVQQ^DILIBF(DIGBL)
 N N,O,% S N=$O(DIC("W",999999),-1)
 S O=$S(N:DIC("W",N),1:DIC("W"))
 N % S %="I '$G(DICR) S DIEN=+"_DIOGBL_"DIEN,0) I $D("_DIGBL_"DIEN,0)) S DIFILEI="_DIFILEI_",DIGBL="""_DIGBL1_""" D WOV^DICQ1"
 S DIOGBL=DIGBL
 I ($L(O)+$L(%))<230 D  Q
 . I 'N S DIC("W")=DIC("W")_" "_% Q
 . S DIC("W",N)=DIC("W",N)_" "_% Q
 S N=N+1,DIC("W",N)=%
 I N=1 S DIC("W")=DIC("W")_" X DIC(""W"",1)" Q
 S DIC("W",N-1)=DIC("W",N-1)_" X DIC(""W"","_N_")"
 Q
 ;
