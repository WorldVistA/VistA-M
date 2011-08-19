MCORMN2 ;WISC/MLH-NON-INTERACTIVE INQUIRY ;3/18/97  13:02
 ;;2.3;Medicine;**4**;09/13/1996
 N MCDIQ0
 ;Q:'$D(MCDIC)!($D(MCDA)[0)!($D(MCDR)[0)  S MCDIL=0,(MCDA(0),MCD0)=MCDA,MCDIQ0=""
 Q:'$D(MCDIC)!($D(MCDA)[0)!($O(MCDRDR(0))'>0)  S MCDIL=0,(MCDA(0),MCD0)=MCDA,MCDIQ0=""
 ;I $D(MCDIQ)#2 G Q:MCDIQ["^"!($E(MCDIQ,1,2)="DI") S:MCDIQ'["(" MCDIQ=MCDIQ_"("
 S:'$D(MCDIQ(0)) MCDIQ(0)="",MCDIQ0="MCDIQ(0),"
 I $D(MCDIQ)[0 S MCDIQ="^TMP(""MC"",$J,",MCDIQ0="MCDIQ,"
 S MCDIQ0=MCDIQ0_"MCDIQ0",MCE="""E"""
 I MCDIC S MCDIC=$S($D(^DIC(MCDIC,0,"GL")):^("GL"),1:"") G:MCDIC="" Q
LEVEL ;    handle data at this level
 G Q:'$D(@(MCDIC_"0)")) S MCDI=+$P(^(0),U,2) G Q:'$D(^(MCDA,0))
 ;  Note: There is no way to be sure of the value of MCDIC.
 ;        We are assuming that it is ^DIC(MCDIC,0,"GL").
 ;F I=1:1 S MCDIQ1=$P(MCDR,";",I) Q:MCDIQ1=""  D COLON:MCDIQ1[":",FIELD:MCDIQ1>0
 S (I,MCDRDR)=0
 F  S MCDRDR=$O(MCDRDR(MCDRDR)),I=I+1 Q:MCDRDR'>0  S MCDIQ1=MCDRDR(MCDRDR) D COLON:MCDIQ1[":",FIELD:MCDIQ1>0
Q Q:MCDIL  K MCPCT,MCF,MCI,MCJ,MCX,MCY,MCC,MCDA(0),MCDRS,MCDIL,MCDI,MCDIQ1,MCE,MCD0 K:MCDIQ0]"" @MCDIQ0
 Q
COLON ;    process set of fields delimited by colon
 S MCDIQ2=$P(MCDIQ1,":",2)
 F MCDIQ1=MCDIQ1:0 D FIELD S MCDIQ1=$O(^DD(MCDI,MCDIQ1)) I MCDIQ1'>0!(MCDIQ1'<MCDIQ2) S:MCDIQ1'=MCDIQ2 MCDIQ1=0 Q
 Q
FIELD ;    process single field
 Q:'$D(^DD(MCDI,MCDIQ1,0))  S (MCF,MCY)=^(0),MCC=$P(MCF,U,4),MCX=$P(MCC,";",2),MCC=$P(MCC,";",1),MCJ=$P(MCF,U,2) G PROC:MCJ["C"
 I +MCC'=MCC S MCC=""""_MCC_""""
 I MCX=0,$D(^DD(+MCJ,.01,0)) G WD:$P(^(0),U,2)["W",SUBFIL ;    yes
 I '$D(@(MCDIC_MCDA_","_MCC_")"))#2 S MCY="" G PROC
 S MCC=@(MCDIC_MCDA_","_MCC_")"),MCY=$S(MCX["E":$E(MCC,+$P(MCX,"E",2),+$P(MCX,",",2)),1:$P(MCC,U,MCX))
 I MCDIQ(0)["I",(MCDIQ(0)["N"&(MCY]"")!(MCDIQ(0)'["N")) S @(MCDIQ_"MCDI,MCDA,MCDIQ1,""I"")")=MCY
PROC ;process a single datum
 Q:MCDIQ(0)'["E"&(MCDIQ(0)'="")&(MCDIQ(0)'["N")  Q:MCDIQ(0)="IN"!(MCDIQ(0)="NI")
 I MCJ["C" S D0=MCD0,D1=$G(MCD1),X=MCX,Y=MCY X $P(MCY,U,5,999) K MCY,Y S MCX=X,MCY=MCX
 I MCJ'["C" S MCC=$P(^DD(MCDI,MCDIQ1,0),U,2) D:MCY]"" SPEC
 IF MCY'=""!(MCDIQ(0)'["N") D
 .S @(MCDIQ_MCE_",MCDI,MCDA,MCDIQ1,1)")=MCY
 Q
WD ;    word-processing field
 N MCWP,MCATT S MCWP=0
 F  D WP2 Q:+MCX=0
 I MCWP'=0 S MCATT=$P(MCF,U,1)_"^W"
 E  S MCATT="^^"
 ;S @("$P("_MCDIQ_"MCDI,MCDA,MCDIQ1,""F""),U,1,2)=MCATT")
 Q
WP2 ; Note: We cannot be sure of the value of MCDIC.
 S MCX=$O(@(MCDIC_"MCDA,"_MCC_",MCX)")) Q:+MCX=0
 S @(MCDIQ_MCE_",MCDI,MCDA,MCDIQ1,MCX)")=^(MCX,0),MCWP=1
 Q
SUBFIL ;    process data in a sub-file
 Q:'$D(MCDR(+MCJ))  Q:'$D(MCDA(+MCJ))  N MCDIQ1,MCI,MCDI S MCDIL=MCDIL+1
 S MCDRS(MCDIL)=MCDR,MCDIC(MCDIL)=MCDIC,MCDR=MCDR(+MCJ),MCDA(MCDIL)=MCDA
 S MCDI=+MCJ,MCDIC=MCDIC_MCDA_","_MCC_",",MCDA=MCDA(+MCJ),@("MCD"_MCDIL)=MCDA
 D LEVEL S MCDR=MCDRS(MCDIL),MCDA=MCDA(MCDIL),MCDIC=MCDIC(MCDIL)
 K MCDRS(MCDIL),MCDIC(MCDIL),MCDA(MCDIL),@("MCD"_MCDIL)
 S MCDIL=MCDIL-1 Q
SPEC ;
 I MCC["O",$D(^(2)) X ^(2) Q  ;NAKED REFERENCE IS TO ^DD(FILE#,FIELD#,0)
SPECS ;Naked Reference for this paragraph reference to ^DD(FILE#,FIELD,0)
 I MCC["S" S MCC=";"_$P(^(0),U,3),MCPCT=$F(MCC,";"_MCY_":") S:MCPCT MCY=$P($E(MCC,MCPCT,999),";",1) Q
 I MCC["P",$D(@("^"_$P(^(0),U,3)_"0)")) S MCC=$P(^(0),U,2) Q:'$D(^(MCY,0))  S MCY=$P(^(0),U) I $D(^DD(+MCC,.01,0)) S MCC=$P(^(0),U,2) G SPECS
 I MCC["V",+MCY,$D(@("^"_$P(MCY,";",2)_"0)")) S MCC=$P(^(0),U,2) Q:'$D(^(+MCY,0))  S MCY=$P(^(0),U) I $D(^DD(+MCC,.01,0)) S MCC=$P(^(0),U,2) G SPECS
 Q
