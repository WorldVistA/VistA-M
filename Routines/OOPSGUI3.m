OOPSGUI3 ;WIOFO/LLH-UTILITY BROKER CALLS ;10/03/01
 ;;2.0;ASISTS;**8,7**;Jun 03, 2002
 ;
SETLCK(RESULTS,IEN) ; Set Lock on Claim being edited
 ;  Input:  IEN - ASISTS Internal record number to be locked
 ; Output: RESULTS - Status message, if record not locked
 ;
 I '$G(IEN) S RESULTS="Need Record Number to proceed" Q
 L +^OOPS(2260,IEN):2
 E  S RESULTS="Another User Editing Record, Try Again Later." Q
 S RESULTS="RECORD LOCKED"
 Q
CLRLCK(RESULTS,IEN) ; Clears Lock on Claim being edited
 ;   Input:    IEN - ASISTS Internal record number to be cleared
 ;  Output: RESULTS - Status message, if appropriate
 ;
 I '$G(IEN) S RESULTS="Need Record Number to proceed" Q
 L -^OOPS(2260,IEN)
 S RESULTS="RECORD UNLOCKED"
 Q
GETLIST(RESULTS,FLD) ; RPC Call - Get Pointed to List
 ;  Input:      FLD - will be the file and field # in FILE,FIELD format.
 ;                    if there is a 3 piece of FLD, it will contain the
 ;                    piece number of an extra data element to be
 ;                    returned.  The format is FILE^FIELD^PIECE#
 ; Output:  RESULTS - return array
 ;
 N FILE,FIELD,TYPE
 S FILE=$P($G(FLD),U),FIELD=$P($G(FLD),U,2)
 S TYPE=$$GET1^DID(FILE,FIELD,"","TYPE")
 I TYPE="SET" D SET1 Q
 I TYPE="POINTER" D SET3 Q
 Q
SET1 ;-- extract a set of codes --
EN2 N LIST,MUTL,X
 S LIST=$$GET1^DID(2260,FIELD,"","POINTER")
 I $E(LIST,1,3)="OOPS" G SET3
 S MULT=$$GET1^DID(2260,FIELD,"","SPECIFIER")
 I MULT["A" D
 . S LIST=$$GET1^DID(+MULT,.01,"","POINTER")
 F X=1:1 Q:$P($G(LIST),";",X)']""  S RESULTS(X)=$P($G(LIST),";",X)
 Q
SET3 ;-- extract items from pointed-to file --
 N ADDED,ITEM,MULT,ROOT,X,XREF,SFLD,VAL,PTR,PCE,VALID
 S XREF="B",X=0
 S ROOT="^"_$$GET1^DID(FILE,FIELD,"","POINTER")
 S MULT=$$GET1^DID(FILE,FIELD,"","SPECIFIER")
 I MULT["A" D
 . S ROOT="^"_$$GET1^DID(+MULT,.01,"","POINTER")
 S ITEM="" F  S ITEM=$O(@(ROOT_"XREF,ITEM)")) Q:$G(ITEM)']""  D
 .S PTR=0 F  S PTR=$O(@(ROOT_"XREF,ITEM,PTR)")) Q:PTR=""  D
 ..I PTR'?1N.N Q
 ..S VAL=$P(@(ROOT_PTR_",0)"),U)
 ..;Need to get Station Number with Name to uniquely identify for user
 ..I FIELD=13 D  I '$G(VALID) Q
 ...S VALID=1,SFLD=ROOT_PTR_",99)"
 ...I $P($G(@SFLD),U,4)=1 S VALID=0
 ...I $P($G(@SFLD),U)'="" S VAL=VAL_" = "_$P($G(@SFLD),U)
 ...I $P(VAL," = ")="" S VALID=0
 ..I (FILE=2260)&(FIELD=30!(FIELD=62)!(FIELD=70)!(FIELD=123)!(FIELD=124)!(FIELD=126)) D
 ... S SFLD=ROOT_PTR_",0)"
 ... I $P($G(@SFLD),U,2)'="" S VAL=VAL_" - "_$P($G(@SFLD),U,2)
 ..S X=X+1,RESULTS(X)=PTR_":"_VAL
 ..I $P($G(FLD),U,3)]"" D
 ...S PCE=$P($G(FLD),U,3)
 ...S RESULTS(X)=RESULTS(X)_":"_$P(@(ROOT_"PTR,0)"),U,PCE)
 Q
 ;
GETSCHED(RESULTS,INPUT) ;
 ;  Input: INPUT - Is the file, field #, and IEN in 
 ;                 FILE^FIELD^IEN fmt
 ; Output: RESULTS - return array (Integers indicating schedule)
 ;
 S RESULTS(1)="*"
 N CODE,LAST,DATA,DAY,Y,X,FIELD,FILE,IEN,ROOT,XREF,NODE,PIECE
 S FILE=$P($G(INPUT),U),FIELD=$P($G(INPUT),U,2)
 S IEN=$P($G(INPUT),U,3),ROOT=$$GET1^DID(FILE,"","","GLOBAL NAME")
 I '$G(IEN) Q
 S XREF=$$GET1^DID(FILE,FIELD,"","GLOBAL SUBSCRIPT LOCATION")
 S NODE=$P($G(XREF),";"),PIECE=$P($G(XREF),";",2)
 S CODE=$P($G(@(ROOT_"IEN,NODE)")),U,PIECE) Q:$G(CODE)']""
 S LAST=$L(CODE,",")
 F X=1:1:LAST D
 .S DATA=$P($G(CODE),",",X) Q:$G(DATA)']""  D
 .I $G(DATA)'["-" S DAY(DATA)=$G(DATA) Q
 .F Y=$P(DATA,"-",1):1:$P(DATA,"-",2) S DAY(Y)=Y
 S X=0
 F  D  Q:+X'>0
 .S X=$O(DAY(X)) Q:+X'>0  S RESULTS(1)=RESULTS(1)_","_X
 Q
 ;
REPLMULT(RESULTS,INPUT,DATA) ;
 ;  Input:   INPUT - contains the FILE, FIELD, and IEN of the record
 ;                   to have the data filed into.
 ;            DATA - contains the replacement data (internal code/ptr)
 ; Output: RESULTS - results array to be sent back to client
 ;
 D REPLIN,REPLDEL,REPLADD
 K DA,DIK,FILE,FIELD,NODE,ROOT,SAVEDIK,SUB
 Q
REPLIN ;
 S FILE=$P($G(INPUT),U),FIELD=$P($G(INPUT),U,2),DA(1)=$P($G(INPUT),U,3)
 S ROOT=$$ROOT^DILFD(FILE,0,"GL")
 S SUB=$$GET1^DID(2260,FIELD,"","GLOBAL SUBSCRIPT LOCATION")
 S NODE=$P($G(SUB),";"),PCE=$P($G(SUB),";",2)
 S SAVEDIK=ROOT_DA(1)_","_$C(34)_NODE_$C(34)_","
 Q
REPLDEL ;
 S DA=0,DIK=SAVEDIK
 F  S DA=$O(@(ROOT_"DA(1),NODE,DA)")) Q:(+DA'>0)  D ^DIK
 Q
REPLADD ;
 N CNT,DIC,DLAYGO,X
 S DLAYGO=DA(1),DIC=SAVEDIK,DIC(0)="LNX"
 S CNT=0
 F  D  Q:+CNT'>0
 . S CNT=$O(DATA(CNT)) Q:+CNT'>0
 . S X=DATA(CNT)
 . K DD,DO D FILE^DICN
 Q
 ;
BODY(RESULTS) ; get valid Body Parts from file 2261.1
 ;  Input:          - none
 ; Output:  RESULTS - an array containing the body parts
 ;
 N PP,COUNT,DATA,BPIEN,BPGRP,BODY
 S (PP,COUNT)=0
 F  S PP=$O(^OOPS(2261.1,PP)) Q:+PP'>0  D
 . Q:$P(^OOPS(2261.1,PP,0),U,2)=0
 . Q:+$P(^OOPS(2261.1,PP,0),U,2)>0
 . S DATA=^OOPS(2261.1,PP,0)
 . ; patch 5 llh - get Body Part Group IEN and Name and send back
 . S BPIEN=$P($G(DATA),U,3),BPGRP=""
 . I $G(BPIEN) S BPGRP=$P($G(^OOPS(2263.8,BPIEN,0)),U) D
 .. S BODY(BPGRP)=BPIEN
 . S RESULTS(COUNT)=$P(DATA,U)_" - "_$P(DATA,U,2)_U_BPGRP
 . S COUNT=COUNT+1
 S BPGRP=""
 F  S BPGRP=$O(BODY(BPGRP)) Q:BPGRP=""  D
 . S RESULTS(COUNT)=U_BPGRP_U_BODY(BPGRP),COUNT=COUNT+1
 QUIT
GETDATA(RESULTS,INPUT) ; Retrieves Set of Code, WP, and Multiple valued fields
 ;    for any file and field passed in the INPUT parameter
 ;  Input - INPUT contains the File & Field # of the file to retrieve the
 ;          data from and the File IEN.  The format is FILE^FIELD^IEN
 ; Output - RESULTS, the array containing the data being returned  
 ;
 N IEN,FILE,FIELD,NODE,PCE,ROOT,TYP,SUB
 S FILE=$P($G(INPUT),U),FIELD=$P($G(INPUT),U,2),IEN=$P($G(INPUT),U,3)
 I $G(IEN)=""!($G(FILE)="")!($G(FIELD)="") Q
 S ROOT=$$ROOT^DILFD(FILE,0,"GL")
 S TYP=$$GET1^DID(FILE,FIELD,"","TYPE")
 S SUB=$$GET1^DID(FILE,FIELD,"","GLOBAL SUBSCRIPT LOCATION")
 S NODE=$P($G(SUB),";"),PCE=$P($G(SUB),";",2)
 I TYP="POINTER",PCE>0 D PTR Q
 I TYP="POINTER",PCE=0 D PTRMULT Q
 I TYP="SET",PCE>0 D SET Q
 I TYP="SET",PCE=0 D SETMULT Q
 I TYP="WORD-PROCESSING" D WPFLD Q
 Q
SET ;
 N CODE,LIST,X
 S CODE=$P(@(ROOT_"IEN,NODE)"),U,PCE)
EN1 S LIST=$$GET1^DID(FILE,FIELD,"","SPECIFIER")
 I +LIST S FILE=+LIST,FIELD=.01 G EN1
 S LIST=$$GET1^DID(FILE,FIELD,"","POINTER")
 I $G(LIST)="" Q
 F X=1:1 Q:$P(LIST,";",X)']""  I $P($P(LIST,";",X),":")=CODE S RESULTS(1)=$P(LIST,";",X)
 Q
 ;
SETMULT ;
 N A,LIST,REC,DATA,X
ENM S LIST=$$GET1^DID(FILE,FIELD,"","SPECIFIER")
 I +LIST S FILE=+LIST,FIELD=.01 G ENM
 S LIST=$$GET1^DID(FILE,FIELD,"","POINTER")
 I $G(LIST)="" Q
 S (REC,X)=0 F  D  Q:+REC'>0
 .S REC=$O(@(ROOT_"IEN,NODE,REC)")) Q:+REC'>0
 .S DATA=@(ROOT_"IEN,NODE,REC,0)")
 .S A=$P($G(LIST),DATA_":",2)
 .S X=X+1
 .S RESULTS(X)=$G(DATA)_":"_$P($G(A),";")
 Q
PTR ; Pointer fields
 N PTR,PROOT
 S PTR=$P(@(ROOT_"IEN,NODE)"),U,PIECE)
 S PROOT="^"_$$GET1^DID(FILE,FIELD,"","POINTER")
 S RESULTS(1)=PTR_":"_$P(@(PROOT_"PTR,0)"),U,1)
 Q
PTRMULT ; Multiple pointer value fields
 N DATA,XROOT,PROOT,REC,RECORD,X
 S XROOT=+$$GET1^DID(FILE,FIELD,"","SPECIFIER")
 S PROOT="^"_$$GET1^DID(XROOT,.01,"","POINTER")
 S (REC,X)=0 F  D  Q:+REC'>0
 .S REC=$O(@(ROOT_"IEN,NODE,REC)")) Q:+REC'>0
 .S RECORD=@(ROOT_"IEN,NODE,REC,0)")
 .S DATA=$P($G(RECORD),U,1)
 .S X=X+1,RESULTS(X)=$G(DATA)_":"_$P(@(PROOT_"DATA,0)"),U,1)
 Q
WPFLD ; Word processing fields
 N DA
 S DA=0  F  D  Q:+DA'>0
 .S DA=$O(@(ROOT_"IEN,NODE,DA)")) Q:+DA'>0
 .S RESULTS(DA)=@(ROOT_"IEN,NODE,DA,0)")
 Q
 ;
STATINFO(RESULTS,STATIEN) ;Get Station Info from DIC(4
 ;  Input STATIEN - Required valid IEN for a station in DIC 4.
 ; Output RESULTS - Station Address info stored in this format
 ;                  STREET^CITY^STATE^ZIP or if not a valid IEN
 ;                  "INVALID STATION"
 N STATE,CITY,ADDR,ZIP
 I $$GET1^DIQ(4,STATIEN,.01)="" S RESULTS(0)="INVALID STATION" Q
 S STATE=$$GET1^DIQ(4,STATIEN,.02)
 S CITY=$$GET1^DIQ(4,STATIEN,1.03)
 S ADDR=$$GET1^DIQ(4,STATIEN,1.01)
 S ZIP=$$GET1^DIQ(4,STATIEN,1.04)
 S RESULTS(0)=ADDR_U_CITY_U_STATE_U_ZIP
 Q
