DDGFU ;SFISC/MKO-CALLED FROM THE FORMS ;10:49 AM  27 Jul 1995
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
VAL1 ;Data validation code
 ;Form: DDS FIELD ADD
 I $$GET^DDSVALF("BLOCK","DDGF FIELD ADD")]"",$$GET^DDSVALF("FIELD ORDER","DDGF FIELD ADD")]"",$$GET^DDSVALF("FIELD TYPE","DDGF FIELD ADD")]"" Q
 ;
 S DDGFT(1)=$C(7)_"Unable to save values."
 S DDGFT(2)="All values must be filled in order to add a new field."
 D HLP^DDSUTL(.DDGFT)
 S DDSERROR=1
 K DDGFT
 Q
 ;
DDCAP ;Caption, Post action on change
 ;Form:  DDGF FIELD DD
 N DDGFOPG
 S DDGFOPG=$$OTHPG
 D:DDSOLD="!M" PUT^DDSVAL(.4044,.DA,1.1,"")
 ;
 D:X="" CAPNULL(DDGFOPG)
 D:X]"" UPDDC(DDGFOPG)
 Q
 ;
OTHPG() ;Return Other Params page#
 N FLD,SUB,OPG
 S FLD=$$GET^DDSVAL(.4044,.DA,4)
 I FLD D
 . S OPG=11
 . S SUB=+$P($G(^DD(DDGFDD,FLD,0)),U,2)
 . S:SUB OPG=$S(SUB_$P($G(^DD(SUB,.01,0)),U,2)'["W":21,1:31)
 Q $G(OPG)
 ;
FOCAP ;Caption, Post action on change
 ;Form:  DDGF FIELD FORM ONLY
 D:X'="!M" PUT^DDSVAL(.4044,.DA,1.1,"")
 ;
 D:X="" CAPNULL(21)
 D:X]"" UPDDC(21)
 Q
 ;
COMPCAP ;Caption, Post action on change
 ;Form:  DDGF FIELD COMPUTED
 D:X'="!M" PUT^DDSVAL(.4044,.DA,1.1,"")
 ;
 D:X="" CAPNULL(11)
 D:X]"" UPDDC(11)
 Q
 ;
CAPNULL(OPG) ;Caption changed to null
 N DC,SC
 ;
 ;Clear suppress colon
 S SC=$$GET^DDSVALF("SUPPRESS COLON AFTER CAPTION?")
 D PUT^DDSVALF("SUPPRESS COLON AFTER CAPTION?","","","","I")
 Q:'$G(OPG)
 ;
 ;Clear caption coords
 D PUT^DDSVALF("CAPTION COORDINATE",1,OPG,"")
 ;
 ;Move data to the left
 S DC=$$GET^DDSVALF("DATA COORDINATE",1,OPG)
 S $P(DC,",",2)=$P(DC,",",2)-$L(DDSOLD)-1-'SC
 S:$P(DC,",",2)<1 $P(DC,",",2)=1
 D PUT^DDSVALF("DATA COORDINATE",1,OPG,DC,"I")
 Q
 ;
UPDDC(OPG) ;Update data coords
 N DC,COL
 S DC=$$GET^DDSVALF("DATA COORDINATE",1,OPG)
 S COL=$P(DC,",",2),COL=COL+$L(X)-$L(DDSOLD)
 I DDSOLD="" D
 . D PUT^DDSVALF("CAPTION COORDINATE",1,OPG,DC,"I")
 . S COL=COL+2
 S:COL<1 COL=1
 S $P(DC,",",2)=COL
 D PUT^DDSVALF("DATA COORDINATE",1,OPG,DC)
 Q
 ;
POSTCH1 ;Field, Post Action On Change
 ;Form: DDGF FIELD DD
 ;
 ;Reset (if caption not !M): caption, caption and data coords,
 ; data length
 ;Input:
 ; DDGFPG = Page #
 ; DA(1)  = Block #
 ; DA     = Field order
 ; X      = Fld #
 ; DDSOLD = Prev fld #
 ;
 Q:X=""
 N FILE,FLD,DD,C,C0,CC,DC,SC,L,OPG,OPG0,PLRC
 ;
 S FLD=X
 S FILE=+$P(^DIST(.404,DA(1),0),U,2) Q:'FILE
 S DD=$G(^DD(FILE,FLD,0)) Q:DD?."^"
 S OPG=$$OTHPG
 ;
 S OPG0=11
 I $G(DDSOLD)]"" D
 . N SUB
 . S SUB=+$P($G(^DD(FILE,DDSOLD,0)),U,2)
 . S:SUB OPG0=$S(SUB_$P($G(^DD(SUB,.01,0)),U,2)'["W":21,1:31)
 ;
 S (C,C0)=$$GET^DDSVALF("CAPTION",1,1)
 S:C]"" CC=$$GET^DDSVALF("CAPTION COORDINATE",1,OPG0)
 S DC=$$GET^DDSVALF("DATA COORDINATE",1,OPG0)
 ;
 I OPG'=OPG0 D
 . D:C]"" PUT^DDSVALF("CAPTION COORDINATE",1,OPG,CC)
 . D:DC]"" PUT^DDSVALF("DATA COORDINATE",1,OPG,DC)
 . D DESTROY^DDSUTL(OPG0)
 . 
 ;
 I $D(DDGFREF),$D(DDGFPG) S PLRC=$P($G(@DDGFREF@("F",DDGFPG)),U,4)
 S PLRC=$S($G(PLRC)]"":PLRC-1,1:IOM-2)-$P($G(@DDGFREF@("F",DDGFPG,DA(1))),U,2)
 S L=$$LENGTH(FILE,FLD) S:'L L=1
 ;
 I C'="!M",$P(DD,U)]"" D
 . S C=$P(DD,U)
 . I $P(DD,U,2),$P($G(^DD(+$P(DD,U,2),.01,0)),U,2)'["W" S C="Select "_C
 . D PUT^DDSVALF("CAPTION",1,1,C)
 . ;
 . I C0="" D
 .. S CC=DC
 .. S $P(DC,",",2)=$P(DC,",",2)+2
 .. D PUT^DDSVALF("CAPTION COORDINATE",1,OPG,CC)
 . E  Q:$P(CC,",")'=$P(DC,",")
 . ;
 . S $P(DC,",",2)=$P(DC,",",2)+$L(C)-$L(C0)
 . S:$P(DC,",",2)<1 $P(DC,",",2)=1
 . D PUT^DDSVALF("DATA COORDINATE",1,OPG,DC)
 ;
 I C0'="!M",$P(DC,",",2)-2+L>PLRC S L=PLRC-$P(DC,",",2)+2
 D PUT^DDSVALF("DATA LENGTH",1,OPG,L)
 Q
 ;
HBVAL ;Validate hdr blk
 Q:X=""  Q:'$O(@(DIE_DA_",40,""B"",X,"""")"))
 S DDSERROR=1
 D HLP^DDSUTL($C(7)_DDSEXT_" already exists on this page.")
 Q
 ;
LENGTH(DIFILE,DIFLD) ;Find max field length
 N DD,DIIT,DILEN,DITYPE
 S DILEN=""
 S DD=$G(^DD(DIFILE,DIFLD,0)) Q:DD?."^" DILEN
 S DITYPE=$P(DD,U,2),DIIT=$P(DD,U,5,999)
 ;
 I DIIT["$L(X)>" S DILEN=+$P($P(DIIT,"$L(X)>",2,999),"E")
 E  I DITYPE["N" S DILEN=+$P(DITYPE,"J",2)
 E  I DITYPE["P" S DILEN=$$LENGTH(+$P(DITYPE,"P",2),.01)
 ;
 E  I DITYPE["S" D
 . N DICODE,DICODEA,DIPC
 . S DICODE=$P(DD,U,3)
 . F DIPC=1:1 S DICODEA=$P(DICODE,";",DIPC) Q:DICODEA=""  D
 .. S DILEN=$$MAX(DILEN,$L($P(DICODEA,":")),$L($P(DICODEA,":",2)))
 ;
 E  I DITYPE["D" D
 . N DIDT
 . S DIDT=$P($P(DIIT,"S %DT=""",2,999),"""")
 . S DILEN=$S(DIDT["S"&(DIDT["T"):20,DIDT["T":17,1:11)
 ;
 E  I DITYPE["V" D
 . N DIL,DIX
 . S DIX=0 F  S DIX=$O(^DD(DIFILE,DIFLD,"V",DIX)) Q:'DIX  D
 .. Q:'$G(^DD(DIFILE,DIFLD,"V",DIX,0))
 .. S DIL=$G(DIL)+1
 .. S DIL(DIL)=$$LENGTH(+^DD(DIFILE,DIFLD,"V",DIX,0),.01)
 . S DILEN=$G(DIL(1))
 . F DIL=1:1:$G(DIL)-1 S DILEN=$$MAX(DIL(DIL),DIL(DIL+1))
 ;
 E  I DITYPE D
 . Q:$D(^DD(+DITYPE,.01,0))[0
 . S DILEN=$S($P(^DD(+DITYPE,.01,0),U,2)["W":1,1:$$LENGTH(+DITYPE,.01))
 ;
 Q DILEN
 ;
MAX(X,Y,Z) ;Return max of 2 or 3 numbers
 N M
 S M=$S(X>Y:+X,1:+Y),M=$S(M>$G(Z):M,1:+$G(Z))
 Q M
