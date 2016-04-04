DIFROMS1 ;SFISC/DCL/TKW-MOVE DD TO TARGET ARRAY ;17APR2003
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**125**
 ;
 Q
EN ;
 I '$D(@DIFRFIA) D ERR(1) Q
 G:$G(DIFRFILE) FCHK
 S DIFRFILE=0 F  S DIFRFILE=$O(@DIFRFIA@(DIFRFILE)) Q:DIFRFILE'>0  D FILE
 Q
FCHK I '$D(@DIFRFIA@(DIFRFILE)) D ERR(2) Q
FILE N DSEC,DIFRD,DIFRX,DIFR01,DIFRFDD
 N DIFRQ,DIFRTART,DIFRK,R,R1,R2,R3,C,F,G,I,DIFRPFD
 S DIFR01=$G(@DIFRFIA@(DIFRFILE,0,1))
 S DIFRFDD=$TR($P(DIFR01,"^",3),"FP","fp")'="p"
 S DSEC=$TR($P(DIFR01,"^",2),"y","Y")="Y"
 S DIFRPFD=@DIFRFIA@(DIFRFILE,DIFRFILE)=0
 I DIFRFDD!DIFRPFD D
 .M @DIFRTA@("^DIC",DIFRFILE,DIFRFILE,"%")=^DIC(DIFRFILE,"%")
 .M @DIFRTA@("^DIC",DIFRFILE,DIFRFILE,"%D")=^DIC(DIFRFILE,"%D")
 .S @DIFRTA@("^DIC",DIFRFILE,DIFRFILE,0)=$P(^DIC(DIFRFILE,0),"^",1,2)
 .S @DIFRTA@("^DIC",DIFRFILE,DIFRFILE,0,"GL")=^DIC(DIFRFILE,0,"GL")
 .S @DIFRTA@("^DIC",DIFRFILE,"B",$E(@DIFRFIA@(DIFRFILE),1,30),DIFRFILE)=""
 .Q
 I DSEC,(DIFRFDD!(DIFRPFD)) D
 .D XY^%RCR("^DIC("_DIFRFILE_",0,",$$OREF^DILF($NA(@DIFRTA@("SEC","^DIC",DIFRFILE,DIFRFILE,0))))
 .K @DIFRTA@("SEC","^DIC",DIFRFILE,DIFRFILE,0,"GL")
 .Q
 S DIFRD=0
 ;              * * Go through each DD and sub-DD * *
 F  S DIFRD=$O(@DIFRFIA@(DIFRFILE,DIFRD)) Q:DIFRD'>0  S DIFRPFD=^(DIFRD)=0 D
 .S DIFRX=0
 .;         * * Merge each field DD to transport structure * *
 .;F  S DIFRX=$O(^DD(DIFRD,DIFRX)) Q:DIFRX'>0  I $D(@DIFRFIA@(DIFRFILE,DIFRD))<9!($D(@DIFRFIA@(DIFRFILE,DIFRD,DIFRX))) D
 .F  S DIFRX=$O(^DD(DIFRD,DIFRX)) Q:DIFRX'>0  I DIFRPFD!($D(@DIFRFIA@(DIFRFILE,DIFRD,DIFRX))) D
 ..M @DIFRTA@("^DD",DIFRFILE,DIFRD,DIFRX)=^DD(DIFRD,DIFRX)
 ..N SEC F SEC=8,8.5,9 I $D(^DD(DIFRD,DIFRX,SEC)) D:SEC=8  I SEC>8,^(SEC)'="^",$P(^(0),"^",2)'["K",^(SEC)'="@" D
 ...I DSEC S @DIFRTA@("SEC","^DD",DIFRFILE,DIFRD,DIFRX,SEC)=^DD(DIFRD,DIFRX,SEC)
 ...K @DIFRTA@("^DD",DIFRFILE,DIFRD,DIFRX,SEC)
 ...Q
 ..; If multiple field sent, send ^DD(SUBFILE#,0) and ^("NM",multiple name) for partial DDs
 ..I 'DIFRPFD D
 ...N SUBNUM S SUBNUM=$$SUBNUM(DIFRD,DIFRX)
 ...I 'SUBNUM Q
 ...S @DIFRTA@("^DD",DIFRFILE,SUBNUM,0)=^DD(SUBNUM,0)
 ...S @DIFRTA@("^DD",DIFRFILE,SUBNUM,0,"NM",$O(^DD(SUBNUM,0,"NM","")))=""
 ...Q
 ..Q
 .;                * * Clean up x-refs in DDs * *
 .S DIFRQ=$NA(@DIFRTA@("^DD",DIFRFILE,DIFRD))
 .S DIFRTART=$$OREF^DILF(DIFRQ)
 .F  S DIFRQ=$Q(@DIFRQ) Q:$P(DIFRQ,DIFRTART)]""!(DIFRQ="")  D:$P(DIFRQ,DIFRTART,2,99)[""""
 ..S DIFRK=1
 ..S R2=$P(DIFRQ,DIFRTART,2,99),$E(R2,$L(R2))="",C=$L(R2,","),F=1,R1=0
 ..F I=1:1 Q:I'<C  S G=$P(R2,",",F,I) Q:G=""  I G'[""""!($L(G,"""")#2&($E(G)="""")&($E(G,$L(G))="""")) S F=F+$L(G,","),I=F-1,R1=R1+1,C=C+($L(G,",")-1) I 'G,G'?1"0".E,R1#2 S DIFRK=DIFRTART_$P(R2,",",1,I)_")" Q
 ..Q:DIFRK
 ..K @DIFRK
 ..Q
 .;           * * Build DD 0 node after x-ref clean up * *
 .;               for full DD or full sub-DD
 .I DIFRFDD!(DIFRPFD) D
 ..M @DIFRTA@("^DD",DIFRFILE,DIFRD,0)=^DD(DIFRD,0)
 ..K @DIFRTA@("^DD",DIFRFILE,DIFRD,0,"VR")
 ..Q
 .Q
IXKEY ; Send entries from KEY and INDEX file
 S DIFRD=0
 F  S DIFRD=$O(@DIFRFIA@(DIFRFILE,DIFRD)) Q:DIFRD'>0  D
 . I $O(^DD("IX","B",DIFRD,0)) D DDIXOUT^DIFROMSX(DIFRFILE,DIFRD,DIFRFDD,DIFRTA)
 . I $O(^DD("KEY","B",DIFRD,0)) D DDKEYOUT^DIFROMSY(DIFRFILE,DIFRD,DIFRTA)
 . Q
 Q
 ;
 Q
SUBNUM(F,FD) ;
 ;Returns 0 if FielD in File is not multiple, otherwise subfile#.
 N SUBNUM S SUBNUM=+$P($G(^DD(F,FD,0)),U,2)
 I 'SUBNUM Q 0
 I $P($G(^DD(SUBNUM,.01,0)),U,2)["W" Q 0
 Q SUBNUM
 ;
ERR(X) D BLD^DIALOG($P($T(ERR+X),";",5)) Q
 ;;FIA Array Does Not Exist;1;9501
 ;;FIA File Number Invalid;2;9502
