DDEMAP ;SPFO/RAM,MKB - DDE GENERATE ENTITY MAP ;AUG 1, 2018
 ;;22.2;VA FileMan;**9**;Jan 05, 2016;Build 73
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
MAIN ;
 ;
 N FDA,IENS,FIELD,ERR,XUMF,IEN,DIR,X,Y,MAPIFN,DA,DINUM,ZERO,DIC,DA,DIRUT
 ;
 K DIR,X,Y
 S DIR(0)="F^3:30^"
 S DIR("A")="Enter name of ENTITY RESOURCE - use camelCase"
 D ^DIR Q:$G(DIRUT)
 ;
 I $D(^DDE("B",Y)) W !!,"An Entity Resource name must be unique - try again",!! G MAIN
 ;
 S ENTITY=Y
 ;
NUM ;
 ;
 K DIR,X,Y
 S DIR(0)="NO^1:999999999999:8^"
 S DIR("A")="Enter file number to auto map"
 D ^DIR Q:$G(DIRUT)
 ;
 I '$$VFILE^DILFD(Y) W !!,"Not a valid file number in this account - try again",!! G NUM
 ;
 S MAPIFN=Y
 ;
 D ZERO,CLEAN,ITEM,EXIT
 ;
 Q
 ;
ZERO ; -- zero node
 ;
 K DIC S DIC="^DDE(",X=ENTITY,DIC(0)="F" D FILE^DICN K DIC
 ;
 S IEN=+Y
 S ZERO=$G(^DIC(MAPIFN,0))
 ;
 K FDA
 S IENS=IEN_","
 ;
 S FDA(1.5,IENS,.02)=MAPIFN
 ;
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 Q
 ;
CLEAN ; -- clean out SEQUENCE
 ;
 K FDA
 S SEQ=0
 F  S SEQ=$O(^DDE(IEN,1,SEQ)) Q:'SEQ  D
 .S IENS=SEQ_","_IEN_","
 .S FDA(1.51,IENS,.01)="@"
 ;
 D FILE^DIE("E","FDA")
 ;
 Q
 ;
ITEM ;
 ;
 N FIELD,SEQ,IDX,ZERO,NAME,SUBFILE,TYPE,ZEROIDX,REQUIRED,MIN,MAX,MULTNAME
 ;
 S FIELD=.001,SEQ=0,IDX=0
 F  S FIELD=$O(^DD(MAPIFN,FIELD)) Q:'FIELD  D
 . S ZERO=$G(^DD(MAPIFN,FIELD,0)) Q:ZERO=""
 . S NAME=$P(ZERO,U)
 . S TYPE=$P(ZERO,U,2)
 . S REQUIRED=$S(TYPE["R":1,1:0)
 . S SUBFILE=$S(TYPE:TYPE,1:"")
 . S TYPE=$S(TYPE["F":"string",TYPE["D":"date",TYPE["N":"number",1:"string")
 . S SUBFILE=+SUBFILE
 . S MULTNAME=$S(SUBFILE:NAME,1:$G(MULTNAME))
 . S SEQ=SEQ+1,IDX=IDX+1
 . S MAX=$P(ZERO,U,5),MIN=""
 . I MAX["K:$L(X)>" S MIN=+$P(MAX,"!($L(X)<",2),MAX=+$P(MAX,"K:$L(X)>",2)
 . D NODE
 . I FIELD=".01" D IDNODE
 ;
 Q
 ;
NODE ; -- ITEM NODE
 ;
 K FDA
 S IENS="+"_IDX_","_IEN_","
 S FDA(1.51,IENS,.01)=$$CC(NAME)
 S FDA(1.51,IENS,.02)=SEQ                   ;FIELD
 S FDA(1.51,IENS,.03)=$S(SUBFILE:"L",1:"S") ;TYPE
 S FDA(1.51,IENS,.04)=$S(SUBFILE:SUBFILE,1:MAPIFN)
 S:'SUBFILE FDA(1.51,IENS,.05)=FIELD
 S:SUBFILE FDA(1.51,IENS,1.01)=2
 ;S FDA(1.51,IENS,1.08)=SEQ
 ;S:MIN FDA(1.51,IENS,1.04)=MIN
 ;S:MAX FDA(1.51,IENS,1.05)=MAX
 ;S:REQUIRED FDA(1.51,IENS,1.1)=REQUIRED
 ;S FDA(1.51,IENS,1.12)=NAME
 ;
 I SUBFILE D  S FDA(1.51,IENS,.08)=NAME ;D:SUBFILE SUBFILE
 . N DIC,X,Y,IEN,IENS,FDA
 . ; create sub-entity
 . I $D(^DDE("B",NAME)) S NAME=NAME_" "_SUBFILE ;ensure unique name
 . S DIC="^DDE(",X=NAME,DIC(0)="F",DIC("DR")=".02///"_SUBFILE
 . D FILE^DICN S (IEN,SUB)=+Y
 . ; populate
 . D SUBFILE
 ;
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 Q
 ;
IDNODE ; id node
 ;
 K FDA
 S IENS=IEN_","
 ;
 S FDA(1.5,IENS,1.1)=$$CC(NAME)
 S FDA(1.5,IENS,1.2)=".01"
 S FDA(1.5,IENS,1.4)="B"
 ;
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 Q
 ;
SUBFILE ;
 ;
 N SUBSEQ,ZERO1FLD,SUBFIELD,SUBNAME,SUBTYPE,SUBIDX,REQUIRED,MIN,MAX
 ;
 S ZERO1FLD=$P($G(^DD(SUBFILE,.01,0)),U)
 ;
 S SUBFIELD=.001,SUBSEQ=0,SUBIDX=0
 F  S SUBFIELD=$O(^DD(SUBFILE,SUBFIELD)) Q:'SUBFIELD  D
 . S ZERO=$G(^DD(SUBFILE,SUBFIELD,0)) Q:ZERO=""
 . S SUBNAME=$P(ZERO,U)
 . S SUBTYPE=$P(ZERO,U,2)
 . S REQUIRED=$S(SUBTYPE["R":1,1:0)
 . S SUBTYPE=$S(SUBTYPE["F":"string",SUBTYPE["D":"date",SUBTYPE["N":"number",1:"string")
 . S SUBSEQ=SUBSEQ+1,SUBIDX=SUBIDX+1
 . S:SUBFIELD=".01" ZEROIDX=SUBIDX
 . S MAX=$P(ZERO,U,5),MIN=""
 . I MAX["K:$L(X)>" S MIN=+$P(MAX,"!($L(X)<",2),MAX=+$P(MAX,"K:$L(X)>",2)
 . D SUBELE
 . ;D SUBSEQ
 ;
 Q
 ;
SUBELE ; -- SUBFILE ITEMS
 ;
 I $O(^DDE(IEN,1,"B",$$CC(SUBNAME),0)) D
 . N SUFFIX,ZNAME S SUFFIX=1
 . D  S SUBNAME=ZNAME
 .. F  S ZNAME=$$CC(SUBNAME)_SUFFIX,SUFFIX=SUFFIX+1 Q:'$O(^DDE(IEN,1,"B",ZNAME,0))
 . S:SUBFIELD=".01" ZERO1FLD=SUBNAME
 ;
 N IENS
 ;
 ;S IDX=IDX+1
 ;
 N FDA
 S IENS="+"_SUBIDX_","_IEN_","
 S FDA(1.51,IENS,.01)=$$CC(SUBNAME)
 S FDA(1.51,IENS,.02)=SUBIDX ;SUBFIELD
 S FDA(1.51,IENS,.03)="S"    ;SUBTYPE
 S FDA(1.51,IENS,.04)=SUBFILE
 S FDA(1.51,IENS,.05)=SUBFIELD
 ;S FDA(1.51,IENS,1.01)=$$CC(ZERO1FLD)
 ;S:MIN FDA(1.51,IENS,1.04)=MIN
 ;S:MAX FDA(1.51,IENS,1.05)=MAX
 ;S:REQUIRED FDA(1.51,IENS,1.1)=REQUIRED
 ;
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 Q
 ;
SUBSEQ ; -- SUBFILE SEQUENCE
 ;
 N IENS
 ;
 K FDA
 S IENS="+"_SUBSEQ_","_ZEROIDX_","_IEN_","
 S FDA(1.512,IENS,.01)=SUBSEQ
 S FDA(1.512,IENS,.02)=$$CC(SUBNAME)
 S FDA(1.512,IENS,.03)=SUBFIELD
 ;
 D UPDATE^DIE("E","FDA",,"ERR")
 ;
 Q
 ;
EXIT ; -- cleanup, and quit
 ;
 Q
 ;
CC(X) ; -- camelCase
 ;
 Q:$G(X)="" ""
 ;
 N Y,Y1,Y2
 S Y=$$TITLE^XLFSTR(X)
 S Y=$TR(Y," ","")
 S $E(Y,1)=$$LOW^XLFSTR($E(Y,1))
 S Y=$TR(Y,")","")
 S Y=$TR(Y,"'","")
 S Y=$TR(Y,"]","")
 S Y=$TR(Y,"?","")
 S Y=$TR(Y,"}","")
 I Y["{" S Y1=$P(Y,"("),Y2=$P(Y,"(",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_Y2
 I Y["[" S Y1=$P(Y,"["),Y2=$P(Y,"[",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_Y2
 I Y["/" S Y1=$P(Y,"/"),Y2=$P(Y,"/",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_Y2
 I Y["\" S Y1=$P(Y,"\"),Y2=$P(Y,"\",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_Y2
 I Y["-" S Y1=$P(Y,"-"),Y2=$P(Y,"-",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_Y2
 I Y["." S Y1=$P(Y,"."),Y2=$P(Y,".",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_Y2
 I Y["(" S Y1=$P(Y,"("),Y2=$P(Y,"(",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_Y2
 I Y["&" S Y1=$P(Y,"&"),Y2=$P(Y,"&",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_"And"_Y2
 I Y["+" S Y1=$P(Y,"+"),Y2=$P(Y,"+",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_"Plus"_Y2
 I Y["$" S Y1=$P(Y,"$"),Y2=$P(Y,"$",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_"Dollar"_Y2
 I Y["#" S Y1=$P(Y,"#"),Y2=$P(Y,"#",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_"Number"_Y2
 I Y["%" S Y1=$P(Y,"%"),Y2=$P(Y,"%",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_"Percent"_Y2
 I Y["~" S Y1=$P(Y,"~"),Y2=$P(Y,"~",2),$E(Y2,1)=$$UP^XLFSTR($E(Y2,1)),Y=Y1_"Tilde"_Y2
 ;
 Q Y
 ;
