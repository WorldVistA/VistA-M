DIQGDDU ;SFISC/DCL-DATA DICTIONARY UTILITIES ;1:16 PM  26 Sep 1996
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
FL(DIQGFILE,DIQGFLD) ;Return field length
 ;Short version of DIOS1
 ;In:
 ;  DIQGFILE = file#
 ;  DIQGFLD  = field#
 ;
 I $G(DIQGFILE)'>0 D ERR202("FILE NUMBER") Q ""
 I $G(DIQGFLD)'>0 D ERR202("FIELD NUMBER") Q ""
 ;
 N DD,DIIT,DN,W
 S DD=$G(^DD(DIQGFILE,DIQGFLD,0))
 I DD?."^" D ERR1700("DD FOR FILE#"_DIQGFILE_", FIELD#"_DIQGFLD_" DOES NOT EXIST") Q ""
 ;
 S W=0,DN=$P(DD,"^",2),DIIT=$P(DD,"^",5,999)
 ;
 I DN S W=$$FL(+DN,.01)
 E  I DN["W" S W=""
 E  I DN["P" S W=$$FL(+$P(DN,"P",2),.01)
 E  I DN["J" S W=+$P(DN,"J",2)
 ;
 E  I DN["S" D
 . N C,C1,P
 . S C=$P(DD,U,3)
 . F P=1:1 S C1=$P(C,";",P) Q:C1=""  S W=$$MAX(W,$L($P(C1,":",2)))
 ;
 E  I DN["D" D
 . N D
 . S D=$P($P(DIIT,"S %DT=""",2,999),"""")
 . S W=$S(D["S"&(D["T"):21,D["T":18,1:12)
 ;
 E  I DN["V" D
 . N N
 . S N=0
 . F  S N=$O(^DD(DIQGFILE,DIQGFLD,"V",N)) Q:'N  S:$G(^(N,0)) W=$$MAX(W,$$FL(+^(0),.01))
 ;
 E  I DIIT["$L(X)>" S W=+$P(DIIT,"$L(X)>",2)
 E  S W=+$P($P($P($P(DD,"^",4),";",2),"E",2),",")
 ;
 S:W=0 W=30
 Q W
 ;
MAX(X,Y,Z) ;Return maximum of 2 or 3 numbers
 N M
 S M=$S(X>Y:+X,1:+Y),M=$S(M>$G(Z):M,1:+$G(Z))
 Q M
 ;
ERR202(DIQGERR) ;Error processing
 N P S P(1)=DIQGERR
 D BLD^DIALOG(202,.P)
 Q
ERR1700(DIQGERR) ;Error processing
 N P S P(1)=DIQGERR
 D BLD^DIALOG(1700,.P)
 Q
 ;
RIF(DA,DR,DIQGETA) ;FUNCTION CALL FOR RI
RI ;REQUIRED IDENTIFIERS - CALLED BY EN3^DIQGDD
 ;DA=FILENR,DR="REQUIRED IDENTIFIERS",DIQGETA=TARGET_ARRAY
 N DIQGRIA,DIQGRI,DIQGR
 D REQIDS^DICU(DA,"DIQGRIA")
 S DIQGRIA="",DIQGRI=0
 F  S DIQGRIA=$O(DIQGRIA(DR,DIQGRIA)) Q:DIQGRIA=""  D
 .S DIQGRI=DIQGRI+1,@DIQGETA@(DR,DIQGRI,"FIELD")=DIQGRIA
 .Q
 Q $S(DIQGRI:$NA(@DIQGETA@(DR)),1:"")
