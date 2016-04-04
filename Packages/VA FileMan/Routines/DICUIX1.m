DICUIX1 ;SF/TOAD/TKW-FileMan: Lookup Tools, Indexes (called by DICUIX) ;4JUL2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,28,3,1032**
 ;
GET(DITOP,DIFILE,DIFIELD,DIDEF,DICODE) ;
 ; get the definition and fetch code for a field
 ;
G1 ; handle .001 fields, fetch field definition, & handle undefineds
 ;
 I DIFIELD=.001 S DICODE="DIEN",DIDEF="" Q
 S DIDEF=$G(^DD(DIFILE,DIFIELD,0)),DICODE=""
 I DIDEF="" D ERR^DICU1(501,DIFILE,"","",DIFIELD) Q
 ;
G2 ; piece out the fields data type, & handle multiples and WPs
 ;
 N DITYPE S DITYPE=$P(DIDEF,U,2)
 I DITYPE D  Q
 . I $P($G(^DD(+DITYPE,.01,0)),U,2)["W" S DITYPE="Word-processing"
 . E  S DITYPE="Multiple"
 . D ERR^DICU1(520,DIFILE,"",DIFIELD,DITYPE)
 ;
G3 ; handle computed fields
 ;
 I DITYPE["C" D  Q
 .I DITYPE["m" D ERR^DICU1(520,DIFILE,"",DIFIELD,"Multiple Computed") Q  ;**GFT
 . S DICODE=$P(DIDEF,U,5,9999)
 . S DIDEF=$P(DIDEF,U,1,4)
 ;
G30 ; Handle whole file x-refs
 I DIFILE'=DITOP S DICODE="DINDEX(DISUB)" Q
G4 ; get field's storage location, handle ?, build node fetch code
 ;
 N DISTORE S DISTORE=$P(DIDEF,U,4)
 N DINODE S DINODE=$P(DISTORE,";")
 N DIPIECE S DIPIECE=$P(DISTORE,";",2)
 I DINODE="",$P(DIPIECE,"E")'="",'DIPIECE S (DICODE,DIDEF)="" Q
 I DINODE=0,DIFILE=DITOP S DINODE="DI0NODE"
 E  S DINODE="$G(@DIFILE(DIFILE)@(+DIEN,"""_DINODE_"""))"
 ;
G5 ; build field fetch code (piece or extract) & quit
 ;
 I DIPIECE S DICODE="$P("_DINODE_",U,"_DIPIECE_")"
 E  D
 . N DIEFROM S DIEFROM=$P($E(DIPIECE,2,9999),",")
 . N DIETO S DIETO=$P(DIPIECE,",",2)
 . S DICODE="$E("_DINODE_","_DIEFROM_","_DIETO_")"
 Q
 ;
FIELD(DIFILE,DIFIELD,DINDEX) ;
 ;
 ; return code to fetch field value prior to screen execution
 ;
F1 ; handle .01 & computeds, build node expression
 ;
 I DIFIELD=.01 Q "DINDEX(1)"
 N DISTORE S DISTORE=$P(DINDEX(1,"DEF"),U,4)
 N DINODE S DINODE=$P(DISTORE,";")
 N DIPIECE S DIPIECE=$P(DISTORE,";",2)
 I 'DINODE,$P(DIPIECE,"E")'="",'DIPIECE Q "X"
 I DINODE=0 S DINODE="DI0NODE"
 E  S DINODE="$G(@DIFILE(DIFILE)@(+DIEN,"""_DINODE_"""))"
 ;
F2 ; build fetch code from node expression
 ;
 N DICODE
 I DIPIECE S DICODE="$P("_DINODE_",U,"_DIPIECE_")"
 E  D
 . N DIEFROM S DIEFROM=$P($E(DIPIECE,2,9999),",")
 . N DIETO S DIETO=$P(DIPIECE,",",2)
 . S DICODE="$E("_DINODE_","_DIEFROM_","_DIETO_")"
 Q DICODE
 ;
GETTMP(DITEMP,DISUB) ; Return name of unique entry in ^TMP global.
 I $G(DISUB(1))']"" S DISUB(1)=$G(DISUB)
 N I S DITEMP="^TMP("
 F I=0:0 S I=$O(DISUB(I)) Q:'I  I DISUB(I)]"" D
 . N X S X=DISUB(I) I +$P(X,"E")'=X S X=""""_X_""""
 . S DITEMP=DITEMP_X_","
 N DIKJ,J
 F DIKJ=$J:.01 S J=DITEMP_DIKJ_")" I '$D(@J) L +@J Q
 S @J="",DITEMP=J L -@J Q
 ;
TMPB(DITEMP,DIFILE) ; Set place for temporary "B" index on file
 N DISUB S DISUB(1)="DICLB",DISUB(2)=DIFILE
 D GETTMP(.DITEMP,.DISUB)
 S DITEMP=$E(DITEMP,1,($L(DITEMP)-1)) Q
 ;
BLDB(DIROOT,DITEMP) ; Build temporary "B" index on file
 N DIENTRY,DIVALUE S DIENTRY=0,DITEMP=DITEMP_")"
 F  S DIENTRY=$O(@DIROOT@(DIENTRY)) Q:'DIENTRY  D
 . S DIVALUE=$P($G(@DIROOT@(DIENTRY,0)),U) Q:DIVALUE=""
 . S @DITEMP@(DIVALUE,DIENTRY)=""
 . Q
 Q
 ;
TMPIDX(DISUB,DITEMP,DITEMP2,DINDEX) ; Set data to build temporary index on Lister call with Pointer/VP in index.
 S DITEMP2=DITEMP
 D GETTMP^DICUIX1(.DITEMP,"DICL")
 S DITEMP=$E(DITEMP,1,($L(DITEMP)-1))
 S DINDEX("ROOTCNG",DISUB)=""
 Q
 ;
CHKP(DIFILE,DINDEX,DINUMBER,DIFRPRT,DISCREEN,DICQ1) ; Check whether to build temporary index on Lister call with Pointer/VP in first subscript of index.
 N DIN1,DIN2,X,I,D S DIN2=0
 S DIN1=+$P($G(@DIFILE(DIFILE)@(0)),U,4)
 N DIF,DIVPTR M DIF=DIFILE S DIVPTR=$S(DINDEX(1,"TYPE")="V":1,1:0)
 D FOLLOW^DICL3(.DIF,"",DINDEX(1,"NODE"),1,0,"",DINDEX(1,"FIELD"),DINDEX(1,"FILE"),DIVPTR,1,.DISCREEN)
 F I=1:1 S X=+$P($G(DIF("STACKEND",I)),U,2) Q:'X  D
 . S X=$G(^DIC(X,0,"GL")) Q:X=""  S X=$G(@(X_"0)"))
 . S DIN2=DIN2+$P(X,U,4)
 S D=1 D
 . N F1,F2 S F1=DINDEX(1,"FILE"),F2=DINDEX(1,"FIELD")
 . I 'DIVPTR S I=$P($G(^DD(F1,F2,0)),U,2) S:I["*" D=.5 Q
 . F I=0:0 S I=$O(^DD(F1,F2,"V",I)) Q:'I  I $G(^(I,1))]"" S D=.5 Q
 . S D=D*.5 Q
 S DIN2=$S(DINUMBER!(DIFRPRT]""):DIN2/(40*D),1:DIN2/(20*D))
 I $G(DICQ1),DIFRPRT]"" S DIN2=DIN2/2
 I DIN2>DIN1,DIN1>500,'$G(DICQ1) Q 0
 Q DIN2>DIN1
 ;
