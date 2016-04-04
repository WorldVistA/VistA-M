DIFROMSE ;SFISC/DCL-FILE ORDER TO RESOLVE POINTERS ;07:27 AM  2 Jun 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
 ;File Order List for Resolving Pointers
FOLRP(DIFRFLG,DIFRTA) ;FLAGS,TARGET_ARRAY ; Creates the "DIORD" subscript
 ;                structure in the transport array.
 ;FLAGS,TARGET_ARRAY
 ;*
 ;FLAGS = None
 ;*
 ;TARGET_ARRAY = CLOSED ROOT
 ;               This is the Transport Array Root.
 ;               "DIORD" is appended to the array root.
 ;               A ordered list of files is returned
 ;               in the target array.  Each file is given
 ;               a value to determine which file should have
 ;               pointers resolved.  After each file has been
 ;               assigned a value it is ordered by value then
 ;               by file number.  If files have the same value
 ;               the file number is then used to determine the
 ;               order.  This call is used after all the file
 ;               being transported are in the "FIA" structure.
 ;*
 Q:$G(DIFRTA)']""
 N DIFRCNT,DIFRDD,DIFRF,DIFRFILE,DIFRFLD,DIFRX
 S DIFRFILE=0
 K ^TMP("DIFROMSE",$J),^TMP("DIFRORD",$J),^TMP("DIFRFILE",$J),@DIFRTA@("DIORD")
 F  S DIFRFILE=$O(@DIFRTA@("FIA",DIFRFILE)) Q:DIFRFILE'>0  D
 .D FSF^DIFROMSP(DIFRFILE,"","^TMP(""DIFROMSE"",$J)")
 .Q
 S DIFRFILE=0
 F  S DIFRFILE=$O(^TMP("DIFROMSE",$J,DIFRFILE)) Q:DIFRFILE'>0  D
 .S DIFRDD=0,^TMP("DIFRORD",$J,DIFRFILE)=0
 .F  S DIFRDD=$O(^TMP("DIFROMSE",$J,DIFRFILE,DIFRDD)) Q:DIFRDD'>0  D
 ..S DIFRFLD=0
 ..F  S DIFRFLD=$O(^DD(DIFRDD,DIFRFLD)) Q:DIFRFLD'>0  S DIFRX=$G(^(DIFRFLD,0)) D
 ...Q:$P(DIFRX,"^",2)
 ...Q:$P(DIFRX,"^",2)'["P"&($P(DIFRX,"^")'["V")
 ...S DIFRCNT=0
 ...I $P(DIFRX,"^",2)["V" D  G P
 ....S DIFRF=0 F  S DIFRF=$O(^DD(DIFRDD,DIFRFLD,"V","B",DIFRF)) Q:DIFRF'>0  S ^TMP("DIFRFILE",$J,DIFRF)=DIFRCNT+1
 ....Q
 ...I +$P(@("^"_$P(DIFRX,"^",3)_"0)"),"^",2)=DIFRFILE S:$G(^TMP("DIFRORD",$J,DIFRFILE))'>DIFRCNT ^(DIFRFILE)=DIFRCNT Q
 ...I $P(DIFRX,"^",2)["P" S ^TMP("DIFRFILE",$J,+$P(@("^"_$P(DIFRX,"^",3)_"0)"),"^",2))=DIFRCNT+1
P ...S DIFRF=$O(^TMP("DIFRFILE",$J,"")) Q:DIFRF=""  S DIFRCNT=^(DIFRF) K ^(DIFRF)
 ...I $G(^TMP("DIFRORD",$J,DIFRF))'>DIFRCNT S ^(DIFRF)=DIFRCNT
 ...S DIFRX=^DD(DIFRF,.01,0)
 ...I $P(DIFRX,"^",2)["P" S ^TMP("DIFRFILE",$J,+$P(@("^"_$P(DIFRX,"^",3)_"0)"),"^",2))=DIFRCNT+1 G P
 ...G:$P(DIFRX,"^",2)'["V" P
 ...S DIFRF=0 F  S DIFRF=$O(^DD(DIFRDD,DIFRFLD,"V","B",DIFRF)) Q:DIFRF'>0  S ^TMP("DIFRFILE",$J,DIFRF)=DIFRCNT
 ...S DIFRCNT=DIFRCNT+1
 ...G P
 ...Q
 ..Q
 .Q
 S DIFRFILE=0
 F  S DIFRFILE=$O(^TMP("DIFRORD",$J,DIFRFILE)) Q:DIFRFILE'>0  S DIFRX=^(DIFRFILE),^TMP("DIFRORD",$J,"DIORD",DIFRX,DIFRFILE)=""
 S DIFRX="",DIFRCNT=1 F  S DIFRX=$O(^TMP("DIFRORD",$J,"DIORD",DIFRX),-1) Q:DIFRX=""  D
 .S DIFRFILE=0 F  S DIFRFILE=$O(^TMP("DIFRORD",$J,"DIORD",DIFRX,DIFRFILE)) Q:DIFRFILE'>0  D
 ..S @DIFRTA@("DIORD",DIFRCNT)=DIFRFILE,DIFRCNT=DIFRCNT+1
 D KILL
 Q
KILL ;
 K ^TMP("DIFROMSE",$J),^TMP("DIFRORD",$J),^TMP("DIFRFILE",$J)
 Q
 ;
CHK(DIFRFLG,DIFRSA,DIFRTA) ;CHECK FILES POINTED TO AGAINST FILES GOING OUT WITH DATA
 ;Compares the "DIORD" with the "FIA" structures
 ;FLAGS,SOURCE_ARRAY,TARGET_ARRAY
 ;*
 ;FLAGS = None
 ;*
 ;SOURCE_ARRAY = TRANSPORT ARRAY ROOT
 ;*
 ;TARGET_ARRAY = TARGET ARRAY ROOT
 ;               Returns a list of files that are pointed to
 ;               but not being exported.  This is used after
 ;               all the files being exported are in the "FIA"
 ;               structure.
 ;*
 Q:$G(DIFRSA)']""
 Q:$G(DIFRTA)']""
 N DIFRX,DIFRFILE
 S DIFRX=0
 F  S DIFRX=$O(@DIFRSA@("DIORD",DIFRX)) Q:DIFRX'>0  S DIFRFILE=^(DIFRX) D
 .Q:$D(@DIFRSA@("DATA",DIFRFILE))&($P($G(@DIFRSA@("FIA",DIFRFILE,0,1)),"^",5)="y")
 .S @DIFRTA@(DIFRFILE)=""
 .Q
 Q
