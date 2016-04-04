DICU1 ;SEA/TOAD,SF/TKW-VA FileMan: Lookup Tools, Get IDs & Index ;26JUNE2011
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**GFT,1042**
 ;
IDENTS(DIFLAGS,DIFILE,DIDS,DIWRITE,DIDENT,DINDEX) ;
 ; get definition of fields to return with each entry
 ;
ID1 ; prepare to build output processor:
 ;
 S DIDS=";"_DIDS_";"
 I DIDS[";@;" S DIDS("@")=""
 E  S:DIDS'[";-WID;" DIDS("WID")="" S:DIDS=";;" DIDS("FID")=""
 N DICRSR,DICOUNT S (DICRSR,DICOUNT)=0
 I DIFLAGS["P" S DICRSR=1,DIDENT(-3)="IEN"
 N DIFORMAT,DIDEFALT S DIDEFALT=$S(DIFLAGS["I":"I",1:"E")
 ;
ID1A ; for Lister: add indexed fields to DIDENT array (to build 1 nodes)
 ;
 I DIFLAGS[3,DIFLAGS'["S",DIDS'[";-IX",'$D(DIDS("@")) D
 . S DIDENT=-2,DIDENT(-2)=1
 . D THROW^DICU11(DIFLAGS,.DIDENT,.DIDS,.DICRSR,.DICOUNT,DIDEFALT,.DINDEX)
 . S DIDENT=0
 ;
ID2 ; decide whether to auto-include the .01 in the field list
 ; will come out in 1 node for Lister, in "ID" nodes for Finder
 ;
 N DIUSEKEY S (DIUSEKEY,DIDENT)=0
 I '$D(DIDS("@")),DIDS'[";-.01;",DIFLAGS'["S" D
 . I DIFLAGS[4 S DIUSEKEY="1F" Q
 . I DIDS[";.01;"!(DIDS[";.01E") Q
 . S DIUSEKEY=1 N DISUB F DISUB=1:1:DINDEX("#") D  Q:'DIUSEKEY
 . . Q:$G(DINDEX(DISUB,"FIELD"))'=.01  ;**GFT
 . . S DIUSEKEY=DINDEX(DISUB,"FILE")'=DIFILE
 . Q
 I DIUSEKEY S DIDENT(-2)=1,DIDENT=.01
 N DICODE,DIDEF,DIEFROM,DIETO,DINODE,DIPIECE,DISTORE,DITYPE,DIFRMAT2
 N DILENGTH,DIOUTI S DILENGTH=$L(DIDS,";"),DIOUTI=0
 ;
ID3 ; Process auto-included .01 field (if included) on first pass,
 ; Start loop to process each field from DIFIELDS parameter
 ; and Identifiers.
 ;
 F  D  Q:$G(DIERR)!DIOUTI
 . S DIFORMAT=""
 . I DIUSEKEY D  Q
 . . D BLD S DIUSEKEY=$S(DIUSEKEY="1F":"F",1:0)
 . . S:DIDENT=-2 DIDENT=.01 Q
 . D  Q:'DIDENT
 . . S DIUSEKEY=0
 . . ; Find next Identifier
 . . I $D(DIDS("FID")) D  Q
 . . . S DIDENT=$O(^DD(DIFILE,0,"ID",DIDENT))
 . . . I 'DIDENT K DIFRMAT2
 . . . I DIDENT="" S:DIDS=";;" DIOUTI=1 K DIDS("FID")
 . .
ID4 . . ; Find next field in DIFIELDS input parameter.
 . .
 . . S DICOUNT=DICOUNT+1
 . . S DIDENT=$P(DIDS,";",DICOUNT)
 . . I DIDENT="",DICOUNT'<DILENGTH S DIOUTI=1
ID4A . . ; process IX specifier
 . . I DIDENT["IX" D  Q
 . . . I $$BADIX(DIDENT) D ERR202 Q
 . . . Q:DIDS[";-IX;"
 . . . D THROW^DICU11(DIFLAGS,.DIDENT,.DIDS,.DICRSR,.DICOUNT,DIDEFALT,.DINDEX)
 . .
ID4B . . ; process FID, WID, and @ specifiers
 . .
 . . I DIDENT["FID" D  S DIDENT="" Q
 . . . Q:DIDENT="-FID"!(DIDS[";-FID;")
 . . . D GETFORM^DICU11(.DIDENT,.DIFRMAT2,.DIDS,.DICOUNT)
 . . . S DIDS("FID")=1 Q
 . . I DIDENT["WID" D  S DIDENT="" Q
 . . . I DIDENT'="WID",DIDENT'="-WID" D ERR202 Q
 . . . Q:DIDENT="-WID"!(DIDS[";-WID;")
 . . . D WRITEID^DICU11(DIFILE,.DIDENT,.DICRSR) K DIDS("WID") Q
ID4X ..I $TR(DIDENT,"@")]"" N X,DICR S X=DIDENT I +X'=$TR(X,"IE") D  Q:$D(X)  ;***GFT
 ...N DISVFILE
 ...S DISVFILE=DIFILE N DIFILE S DIFILE=DISVFILE ;Q^DIC2 KILLS DIFILE
 ...D EXPR^DICOMP(DIFILE,"m",X) Q:'$D(X)  ;Create the code to do the computation
 ...S DICRSR=DICRSR+1 S:$G(Y)["m" DIGFT(DICRSR,"MULTIPLE")=1 S:$G(Y)["D" DIGFT(DICRSR,"DATE")=1
 ...S Y="C"_(DICOUNT-1) ;COMPUTED
 ...S:DIFLAGS["P" $P(DIDENT(-3),U,DICRSR)=Y ;THIS WILL BECOME THE PACKED "MAP"
 ...S:DIFLAGS'["P" DIDENT(-3,$O(^DD(DISVFILE," "),-1)+1,Y)="" ;THIS IS THE UNPACKED MAP
 ...S DIDENT(DICRSR,Y,0)="D COMP^DICU1("_DICRSR_")"
 ...M DIGFT(DICRSR)=X S DIDENT=""
 . . I DIDENT["@" D:DIDENT'="@" ERR202 Q
 . . I 'DIDENT D:DIDENT'="" ERR202 Q
 . .
ID4C . . ; process field # specifiers from DIFIELDS parameter
 . .
 . . D GETFORM^DICU11(.DIDENT,.DIFORMAT,.DIDS,.DICOUNT)
 .
 . ; Here we quit if field is already in the DIDENT array.
 . I DIDS=";;",DIFLAGS[4,DIUSEKEY'="F",DIDENT=.01 Q
 . I DIDS=";;",DIFLAGS[3,DINDEX("FLIST")[("^"_DIDENT_"^") Q
 .
ID5 . ; for file IDs, we skip non-display IDs
 .
 . N DIPLUS S DIPLUS=+DIDENT
 . N DILAST S DILAST=$P(DIDENT,DIPLUS,2,999)
 . I DIDENT["-" D  Q
 . . I DILAST'="" D ERR202 Q
 . . I '$D(^DD(DIFILE,-DIPLUS)) D ERR(501,DIFILE,"","",-DIPLUS) Q
 . E  I (DILAST'?.1"E".1"I")&(DILAST'?.1"I".1"E") D ERR202 Q
 . Q:DIDS[(";-"_DIDENT_";")
 . I $D(DIDS("FID")) D  I DINODE="W """"" Q
 . . S DINODE=$G(^DD(DIFILE,0,"ID",DIDENT))
 . I $G(DIFRMAT2)]"" S DIFORMAT=DIFRMAT2
 . D BLD Q
 ;
ID6 ; Write Identifiers: add to output processor
 ; ID Parameter: add ID parameter to output processor
 ;
 Q:$G(DIERR)
 I $D(DIDS("WID")) D WRITEID^DICU11(DIFILE,.DIDENT,.DICRSR)
 I DIWRITE'="" D
 . S DIDENT="ZZZ ID" I DIFLAGS["P" S DICRSR=DICRSR+1
 . S DIDENT(DICRSR,DIDENT,0)="N DIMSG "_DIWRITE
 . S:DIFLAGS["P" $P(DIDENT(-3),U,DICRSR)="IDP" Q
 Q
 ;
BLD ; get fetch code for value
 D GET^DICUIX1(DIFILE,DIFILE,DIDENT,.DIDEF,.DICODE) Q:DIDEF=""!$G(DIERR)
 I DIFORMAT="" S DIFORMAT=$S(DIUSEKEY="1F":"I",1:DIDEFALT)
 D
 . N DIVALUE S DIVALUE=DIDENT
 . I DIUSEKEY'["F",$D(DIDS("FID")),DIDENT'=.01 S DIVALUE="FID("_DIVALUE_")"
 . S:DIFORMAT="I" DIVALUE=DIVALUE_DIFORMAT
 . I DIFLAGS["P" S $P(DIDENT(-3),U,(DICRSR+1))=DIVALUE Q
 . Q:DIUSEKEY="1F"
 . S DIDENT(-3,+DIDENT,DIVALUE)="" Q
BLD1 ; set up format code and load with fetch code into DIDENT
 N DIVALUE,DISUB S DIVALUE=DICODE,DISUB=0
 S DITYPE=$P(DIDEF,U,2) I DITYPE'["C" D
 . S DIVALUE=$$FORMAT^DICU11(DIDENT,DICODE,DIUSEKEY,DIFORMAT,DIDEFALT,DIFLAGS)
 I DIUSEKEY="1F",DIDENT=.01 S DIDENT=-2,DISUB=.01
 I DIFLAGS["P" S DICRSR=DICRSR+1
 I DITYPE'["C" S DIDENT(DICRSR,DIDENT,DISUB,DIFORMAT)=DIVALUE Q
 S DIDENT(DICRSR,DIDENT,0)=DIVALUE
 S DIDENT(DICRSR,DIDENT,0,"TYPE")="C"
 Q
 ;
 ;
COMP(DIGFTI) ;EXECUTE A COMPUTED FIELD!   COME HERE FROM DICU2
 N X,Y,J,I
 S J=0 F Y=$L(DIEN,","):-1:1 S X=$P(DIEN,",",Y) I X]"" N @("D"_J) S @("D"_J)=X,J=J+1 ;Temporarily set D0,D1,etc
 M X=DIGFT(DIGFTI)
 I '$D(DIGFT(DIGFTI,"MULTIPLE")) X X D:$D(DIGFT(DIGFTI,"DATE"))  S ^TMP("DIMSG",$J,1)=X Q  ;SINGLE-VALUED COMPUTED EXPRESSION
 .N Y S Y=X X:Y ^DD("DD") S X=Y
 N DICMX S DICMX="S ^($O(^TMP(""DIMSG"",$J,999),-1)+1)=X" X X ;MULTIPLE-VALUED COMPUTED EXPRESSION
 Q
 ;
 ;
ERR(DIERN,DIFILE,DIENS,DIFIELD,DI1) ;
 ;
 ; add an error to the message array
 ; GET
 ;
 N DIPE
 S DIPE("FILE")=$G(DIFILE)
 S DIPE("IEN")=$G(DIENS)
 S DIPE("FIELD")=$G(DIFIELD)
 S DIPE(1)=$G(DI1)
 D BLD^DIALOG(DIERN,.DIPE,.DIPE)
 Q
 ;
ERR202 D ERR(202,"","","","FIELDS") Q
 ;
BADIX(DIDENT) ;
 ;
 N DIBAD S DIBAD=DIDENT'="IX"&(DIDENT'="-IX")&(DIDENT'?1"IX"1"E".1"I")
 S DIBAD=DIDENT'?1"IX"1"I".1"E"&DIBAD
 Q DIBAD
 ;
 ; 202   The input parameter that identifies the |1
 ;
