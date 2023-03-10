XINDX11 ;ISC/GRK - Create phantom routines for functions, options, etc. ;07/08/98  15:06
 ;;7.3;TOOLKIT;**20,27,121,132,140,148**;Apr 25, 1995;Build 3
 ; Per VHA Directive 2004-038, this routine should not be modified.
 G:INP(10)=9.7 RTN
 N INDSTAT ;p148 tracks if status message was displayed
 G:INP(10)=9.4 PKG
BUILD ; Process Build File
 N KRN,BLDFIL,BLDDEL
 S BLDDEL=U
 S BLDFIL=.5,INDFN="^DD(""FUNC"",",INDRN="|func",INDD="Function",INDSB="FUNC",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=19,INDFN="^DIC(19,",INDRN="|opt",INDD="Option",INDSB="OPT",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDDEL="    "
 S BLDFIL=.401,INDFN="^DIBT(",INDRN="|sort",INDD="Sort Template",INDSB="SORT^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=.402,INDFN="^DIE(",INDRN="|inpt",INDD="Input Template",INDSB="INPUT^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=.4,INDFN="^DIPT(",INDRN="|prnt",INDD="Print Template",INDSB="PRINT^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=.403,INDFN="^DIST(.403,",INDRN="|form",INDD="Form",INDSB="FORM^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDDEL=U
 S BLDFIL=.84,INDFN="^DI(.84,",INDRN="|dlg",INDD="Dialog",INDSB="DIALOG^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=9.2,INDFN="^DIC(9.2,",INDRN="|help",INDD="Help Frame",INDSB="HELP^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=19.1,INDFN="^DIC(19.1,",INDRN="|key",INDD="Security Key",INDSB="KEY^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=409.61,INDFN="^SD(409.61,",INDRN="|list",INDD="List Template",INDSB="LIST^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=101,INDFN="^ORD(101,",INDRN="|ptcl",INDD="Protocol",INDSB="PROTOCOL^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=771,INDFN="^HL(771,",INDRN="|hlap",INDD="HL7 Application Parameter",INDSB="HL7AP^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
 S BLDFIL=8994,INDFN="^XWB(8994,",INDRN="|rpc",INDD="Remote Procedure",INDSB="RPC^XINDX12",INDXN="Build file",INDSTAT=0 D BLDITEM
RTN ;Routines
 D RTN^XTRUTL1(INDDA,INP(10))
 Q
 ;
BLDITEM ; Process Each Build item in build file
 D HDR
 F KRN=0:0 S KRN=$O(^XPD(9.6,INDDA,"KRN",BLDFIL,"NM",KRN)) Q:KRN'>0  S (INDL,INDXN)=$P(^(KRN,0),BLDDEL) D STAT:'INDSTAT,ENTRY
 I INDLC=2 K ^UTILITY($J,INDRN),^UTILITY($J,1,INDRN) ;patch 121
 QUIT
 ;
PKG D NAMSP ;Package file
 S INDFN="^DD(""FUNC"",",INDRN="|func",INDD="Function",INDSB="FUNC",INDSTAT=0 D NAME
 S INDFN="^DIC(19,",INDRN="|opt",INDD="Option",INDSB="OPT",INDSTAT=0 D NAME
 S INDFN="^DIBT(",INDRN="|sort",INDD="Sort Template",INDSB="SORT^XINDX12",INDSTAT=0 D NAME
 S INDFN="^DIE(",INDRN="|inpt",INDD="Input Template",INDSB="INPUT^XINDX12",INDSTAT=0 D NAME
 S INDFN="^DIPT(",INDRN="|prnt",INDD="Print Template",INDSB="PRINT^XINDX12",INDSTAT=0 D NAME
 S INDFN="^DIST(.403,",INDRN="|form",INDD="Form",INDSB="FORM^XINDX12",INDSTAT=0 D NAME
 S INDFN="^DI(.84,",INDRN="|dlg",INDD="Dialog",INDSB="DIALOG^XINDX12",INDSTAT=0 D NAME
 S INDFN="^DIC(9.2,",INDRN="|help",INDD="Help Frame",INDSB="HELP^XINDX12",INDSTAT=0 D NAME
 S INDFN="^DIC(19.1,",INDRN="|key",INDD="Security Key",INDSB="KEY^XINDX12",INDSTAT=0 D NAME
 S INDFN="^SD(409.61,",INDRN="|list",INDD="List Template",INDSB="LIST^XINDX12",INDSTAT=0 D NAME
 S INDFN="^ORD(101,",INDRN="|ptcl",INDD="Protocol",INDSB="PROTOCOL^XINDX12",INDSTAT=0 D NAME
 S INDFN="^HL(771,",INDRN="|hlap",INDD="HL7 Application Parameter",INDSB="HL7AP^XINDX12",INDSTAT=0 D NAME
 S INDFN="^XWB(8994,",INDRN="|rpc",INDD="Remote Procedure",INDSB="RPC^XINDX12",INDSTAT=0 D NAME
 Q
 ;
NAME ; Index based on Package file #9.4
 Q:'$D(@(INDFN_"""B"")"))  ; Don't run if there isn't a B cross reference
 D HDR ; Add Header in the style of |{component} ; '{Namespace}' {Filename as defined above}s. With a comment line below.
 S INDL=$E(INDXN,1,$L(INDXN)-1)_$C($A(INDXN,$L(INDXN))-1)_"z" ; get the last letter of the prefix and get the previous letter (B=A), then append "z" to the end
 F A=0:0 S INDL=$O(@(INDFN_"""B"",INDL)")) Q:$P(INDL,INDXN,1)]""!(INDL="")  D  ; Order through the B index of the given file. If it nolonger matches the prefix or we hit the end of the B index quit
 . F B=0:0 S B=$O(@(INDFN_"""B"",INDL,B)")) Q:B=""  D  ; For each IEN in the B index
 .. X INDF ; Make sure it isn't an excluded namespace
 .. D:C8 STAT:'INDSTAT,@INDSB ; If it isn't an excluded namesapce cross reference it
 I INDLC=2 K ^UTILITY($J,INDRN),^UTILITY($J,1,INDRN) Q  ; If there is only a header delete the faux routine
 S ^UTILITY($J,1,INDRN,0,0)=INDLC ; set the number of lines in the routine where the output will find it
 Q
NAMSP ; Setup processing for Indexing based on package file
 S INDXN=$P(^DIC(9.4,DA,0),"^",2) ; PREFIX (#1) from Package File
 S C9=0 ; Subscript for INDXN
 S INDXN(C9)="," ; 0th subscript is always ","
 F A=0:0 S A=$O(^DIC(9.4,DA,"EX",A)) Q:A'>0  D  ; For each excluded name space in the package file
 . I $D(^(A,0))#2 D  ; If there is an excluded namespace value
 .. S C9=C9+1 ; increment the counter
 .. S INDXN(C9)=$P(^(0),"^") ; set INDXN(COUNTER)=excluded namespace
 S INDF="S C8=1 F H=1:1:C9 I $P(INDL,INDXN(H))="""" S C8=0 Q" ; Checks excluded namespaces
 Q
STAT ;write status ;p148
 S INDSTAT=1
 W !,"Processing ",INDD,"s",!
 Q
HDR S INDLC=0,INDC=INDRN_" ; '"_INDXN_"' "_INDD_"s.",INDX=";" D ADD S ^UTILITY($J,INDRN)="",^UTILITY($J,1,INDRN,0,0)=0
 Q
ENTRY F B=0:0 S B=$O(@(INDFN_"""B"",INDXN,B)")) Q:B=""  D @INDSB
 S ^UTILITY($J,1,INDRN,0,0)=INDLC
 Q
FUNC ;Process Function file entry
 Q:'($D(^DD("FUNC",B,0))#2)  S INDC=B_" ; "_$P(^(0),"^",1)_" - "_$S($D(^(9))#2:$E(^(9),1,190),1:""),INDX=$S($D(^(1))#2:^(1),1:";") D ADD
 Q
OPT ;Process option file entry for MUMPS code
 Q:'$D(^DIC(19,B,0))  S T=$P(^(0),"^",4),INDC=B_" ; "_$P(^(0),"^",1)_" - "_$P(^(0),"^",2)_" ("_$P($P($P(^DD(19,4,0),"^",3),T_":",2),";",1)_")"_$S($P(^DIC(19,B,0),"^",6)]"":" - Locked by "_$P(^(0),"^",6),1:""),INDX="" D ADD
 S INDN="15,20,26,"_$S(T="E":"34,35,54",T="I":"34,35",T="P":"69,69.1,69.2,69.3,71,72,73",T="R":25,1:"") D OPTC:INDN
 Q
OPTC F J=1:1 S H=$P(INDN,",",J) Q:H=""  I $D(^DIC(19,B,H))#2 D
 . S %=^(H),INDX=$S(H'=25:%,1:"D "_$E("^",%'["^")_$P(%,"[")),INDC=" ; "_$P(^DD(19,H,0),"^",1) D ADD
 Q
ADD ;Put code in UTILITY for processing
 S INDLC=INDLC+1,^UTILITY($J,1,INDRN,0,INDLC,0)=INDC I INDX]"" S INDLC=INDLC+1,^UTILITY($J,1,INDRN,0,INDLC,0)=" "_INDX
 Q
ADDLN ;
 S INDLC=INDLC+1,^UTILITY($J,1,INDRN,0,INDLC,0)=" "_INDX
 Q
