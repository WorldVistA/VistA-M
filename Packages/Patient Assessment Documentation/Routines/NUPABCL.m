NUPABCL ;PHOENIX/KLD; 7/1/99; ADMISSION ASSESSMENT BROKER CALL UTILITIES; 1/11/12  8:37 AM
 ;;1.0;NUPA;;;Build 105
ST Q
 ;
LOOK(RESULT,PAR) ;Lookup data using ^DIC
 ;F=file number, V=Value to lookup, FD=fields to display,
 ;IND=indexes to search, NUM=# of entries to display, SCR=screen
 S:PAR("V")="DUZ" PAR("V")="`"_DUZ S:$G(PAR("IND"))="" PAR("IND")="B"
 S:PAR("F")=2&(PAR("IND")'["BS5") PAR("IND")=PAR("IND")_"^BS5"
 S:'+$G(PAR("NUM")) PAR("NUM")=20
 N I F I="F","V","FD","IND","NUM","SCR" S PAR(I)=$G(PAR(I))
 S:PAR("FD")="" PAR("FD")="@;.01"
 S:PAR("FD")'="@;.01"&$E(PAR("FD")'="@") PAR("FD")="@;"_PAR("FD")
 D:PAR("F")&(PAR("V")]"") FIND^DIC(PAR("F"),"",PAR("FD"),"P",PAR("V"),PAR("NUM"),PAR("IND"),PAR("SCR"),"","","")
 I $D(^TMP("DILIST",$J)),'$D(^TMP("DILIST",$J,0)) S ^TMP("DILIST",$J,0)=$O(^TMP("DILIST",$J,9E9),-1)
 S:'$D(^TMP("DILIST",$J)) ^TMP("DILIST",$J,0)="0^*^0"
 I $D(^TMP("DIERR",$J)),'$D(^TMP("DILIST",$J,1,0)) K ^TMP("DILIST",$J) D
 .S ^TMP("DILIST",$J,0)="666^*^1^ERROR",^TMP("DILIST",$J,1,0)=$G(^TMP("DIERR",$J,1,"TEXT",1))
 K ^TMP("DILIST",$J,0,"MAP") S RESULT=$NA(^TMP("DILIST",$J)) Q
 ;
DLOOK(RESULT,F,V,TYPE,SCR,IND) ;Lookup using the IND xref for when the .01 is a date or pointer.
 ;F=file number, V=Value to lookup
 N C34,CNT,FLAG,G1,G2,GLO1,GLO2,I,II S C34=$C(34),SCR=$G(SCR),CNT=0
 S:$G(TYPE)="" TYPE="D" S:$G(IND)="" IND="B" K ^TMP($J)
 S GLO1=^DIC(F,0,"GL")_""""_IND_"""," S:TYPE'="VP" GLO1=GLO1_(V-.001)
 S:TYPE="VP" GLO1=GLO1_C34_($P(V,";")-1)_";"_$P(V,";",2)_C34
 S GLO1=GLO1_")"
 F I=0:0 S G1=$O(@GLO1) Q:G1=""!(G1'[V)  D
 .S:TYPE'="VP" GLO1=$P(GLO1,",",1,2)_","_G1_")"
 .S:TYPE="VP" GLO1=$P(GLO1,",",1,2)_","_C34_G1_C34_")"
 .S GLO2=$P(GLO1,")")_",0)"
 .F II=0:0 S G2=$O(@GLO2) Q:G2=""  S FLAG=1 D
 ..I SCR]"" S X=@($P(GLO2,",")_","_G2_",0)") X SCR S FLAG=$T
 ..I FLAG S CNT=CNT+1 S:TYPE="D" ^TMP($J,CNT)=$$D(G1) D
 ...S:TYPE="P"!(TYPE="VP") ^TMP($J,CNT)=G1
 ...S ^TMP($J,CNT)=^TMP($J,CNT)_U_G2_U_@(^DIC(F,0,"GL")_G2_",0)")
 ..S:TYPE'="VP" GLO2=$P(GLO1,",",1,2)_","_G1_","_G2_")"
 ..S:TYPE="VP" GLO2=$P(GLO1,",",1,2)_","_C34_G1_C34_","_G2_")"
 S:'$D(^TMP($J)) ^TMP($J,1)=0 S RESULT=$NA(^TMP($J)) Q
 ;
WPSET(RESULT,F,N,D) ;Stick data into a word processing field one line at a time
 ;F=file (global name), N=Line number, D=Data to insert
 I $G(F)=""!('$G(N))!($G(D)="") S RESULT=0 Q
 S D=$G(D),F=F_")" I N<2 K @F Q:'N
 S F=$P(F,")")_",0)",@F="^^"_N_U_N_U_DT_U
 S F=$P(F,"0)")_N_",0)",@F=D,RESULT=1 Q
 ;
WPGET(RESULT,F,IEN,N) ;Get data from a word processing field
 ;F=file (global name- "^DIZ(644123,"), IEN=Line number+",", N=Node
 K ^TMP($J) S ^TMP($J)=""
 I F]"",","'[IEN,N]"" M ^TMP($J)=@(F_IEN_N_")") K ^TMP($J,0) S:'$D(^TMP($J)) ^TMP($J,1,0)=""
 S RESULT=$NA(^TMP($J)) Q
 ;
FILE(RESULT,DIE,DA,F,V,S) ;File info - F=Field, V=Value, S=# of slashes
 ;DA can have pieces for DA(1), DA(2), etc.
 N DR,I F I=2:1 Q:$P(DA,U,I)=""  S DA(I-1)=$P(DA,U,I)
 S DA=+DA S:'$D(S) S=V,V="" F I=1:1:S S F=F_"/"
 S DR=F_V D ^DIE S RESULT=1 Q
 ;
NEW(RESULT,DIC,X,XX) ;Add a new entry to a file 
 N % S DIC=$G(DIC),X=$G(X),XX=$G(XX) I DIC=""!(X="") S RESULT=0 Q
 I X="NOW" D NOW^%DTC S X=%
 D ADD Q
 ;
NEWN(RESULT,DIC,X,S) ;Add new entry if none already exists
 N DOLRT,Y S X=$G(X) I X="" S RESULT=-1 Q
 S S=$G(S),Y=0
NEWN1 S:X'?1.N X=$C(34)_X_$C(34) S Y=$O(@(DIC_"""B"""_","_X_","_Y_")"))
 S:$E(X)=$C(34)&($E(X,$L(X))=$C(34)) X=$E(X,2,$L(X)-1)
 I 'Y D ADD Q  ;none exists
 S DOLRT=1 I S]"" X S S DOLRT=$T
 I DOLRT S RESULT=Y Q  ;entry has desired value
 G NEWN1
 ;
ADD S:'$D(DA(1))&($L(DIC,",")=4) DA(1)=$P(DIC,",",2)
 S:$L(DIC,",")=6 DA(2)=$P(DIC,",",2),DA(1)=$P(DIC,",",4)
 S:$L(DIC,",")=8 DA(3)=$P(DIC,",",2),DA(2)=$P(DIC,",",5),DA(1)=$P(DIC,",",6)
 K DD,DO S DIC(0)="L" D FILE^DICN S RESULT=+Y Q
 ;
SCREEN(R,S)  ;Xecute a screen (or xecutable code)
 N NUPA,X S X="SCRERR^NUPABCL",@^%ZOSF("TRAP")
 S X=S D ^DIM I '$D(X) S R=""
 E  X S S R=$T
SCRERR S:'$D(R) R="" S:$D(NUPA) R=NUPA Q
 ;        ;
DATE(RESULT,X) ;Return a date from a string
 N %DT S %DT="T" D ^%DT S RESULT=Y Q
 ;
LIST(RESULT,F,S,M) ;List of all entries from a file.
 ;F=file number, S=Screen, M=Subscript of a multiple
 ;May not work well if .01 is a pointer
 N CNT,I,II,X K ^TMP($J) I '$D(^DIC(F,0,"GL")) S ^TMP($J,0)="" Q
 S F=^DIC(F,0,"GL"),S=$G(S),M=$G(M)
 D LISTGET S RESULT=$NA(^TMP($J)) Q
 ;
LIST2(RESULT,F,FD,S) ;List of all entries from a file including other fields
 ;F=file in format "^DIZ(644123,", S=Screen
 ;FD=other fields in format FILE^Field 1^Field 2 etc
 N I,II,OFD S FD=$G(FD),S=$G(S),M="" K ^TMP($J)
 I FD]"" F I=2:1 Q:$P(FD,U,I)=""  D
 .S OFD=$G(OFD)+1,OFD(OFD)=$P(^DD(+FD,$P(FD,U,I),0),U,4)
 D LISTGET S RESULT=$NA(^TMP($J)) Q
 ;
LISTGET N OFDV F I=0:0 S I=$O(@(F_"I)")) Q:'I  S X=$G(^(I,0)) D:X]""
 .I S]"" X S Q:'$T
 .I M D  Q
 ..F II=0:0 S II=$O(@(F_"I,M,II)")) Q:'II  S ^TMP($J,"B",$P(^(II,0),U),II)=""
 .I $G(OFD) F II=1:1:OFD S OFDV(II)=$P($G(^(+OFD(II))),U,$P(OFD(II),";",2))
 .Q:$P(X,U)=""  S ^TMP($J,"B",$P(X,U),I)=""
 .I $D(OFDV) F II=1:1 Q:'$D(OFDV(II))  S ^TMP($J,"B",$P(X,U),I)=^TMP($J,"B",$P(X,U),I)_U_OFDV(II)
 S CNT=0,I="" F  S I=$O(^TMP($J,"B",I)) Q:I=""  D
 .F II=0:0 S II=$O(^TMP($J,"B",I,II)) Q:'II  D
 ..S CNT=CNT+1,^TMP($J,CNT)=I_U_II_^TMP($J,"B",I,II)
 K ^TMP($J,"B") S:'$D(^TMP($J)) ^TMP($J,1)="NOTHING FOUND" Q
 ;
PF(R,X,FP)  ;Is Date X > OR < $H?  X should be in "7/7/11@12:30:00 PM" format.
 ;Set FP to "P" to check if X is in the past, or set FP to "F"
 ;to see if X is in the future.  R will equal 0 or 1.
 N %,CHKDT D RDFD(.CHKDT,X),NOW^%DTC S FP=$G(FP),R=-1
 S:FP="P" R=$S(CHKDT<%:1,1:0) S:FP="F" R=$S(CHKDT>%:1,1:0)
 Q
 ;
CDTR(RESULT) ;Current date/time (regular format)
 N % D NOW^%DTC S RESULT=$$D1($P(%,"."))_"  "_$$T1($P(%,".",2)) Q
CDTF(RESULT) ;Current date/time (fileman format)
 N % D NOW^%DTC S RESULT=% Q
 ;
FDRD(R,Y) ;Convert Fileman date to regular date
 D DD^%DT S R=Y Q
RDFD(R,X) ;Convert regular date to Fileman date
 N %DT S %DT="TS" D ^%DT S R=Y Q
 ;
D(Y) D DD^%DT Q Y
D1(Y) Q +$E(Y,4,5)_"/"_+$E(Y,6,7)_"/"_$E(Y,2,3)
T1(Y) N H S Y=Y_"000000",H=$E(Y,1,2)
 S Y=":"_$E(Y,3,4)_$S($E(Y,1,2)<12:" AM",1:" PM")
 Q $S(+H=0:12,+H<13:+H,1:(H-12))_Y
 ;
P(R,ZTIO,PR) ;Print an array to printer
 N ZTDESC,ZTDTH,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="P1^NUPABCL",ZTDESC="PRINT RPC",ZTSAVE("PR(")="",ZTDTH=$H
 D ^%ZTLOAD S R=+$G(ZTSK) Q
 ;
P1 U IO F I=0:0 S I=$O(PR(I)) Q:I=""  D
 .I $E(PR(I))=$C(12) W:I>1 @IOF S PR(I)=$E(PR(I),2,999)
 .W !,PR(I)
 D ^%ZISC Q
 ;
VD(R,X) ;Is data valid for a Fileman file's field?  X=File #^Field #^Data
 N F,G S G=+X,F=$P(X,U,2),X=$P(X,U,3) X $P(^DD(G,F,0),U,5,99)
 S R=$D(X) Q
