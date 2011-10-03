XUMF5II ;ISS/PAVEL - XUMF5 MD5 Hash Entry point ;5/9/06  11:01
 ;;8.0;KERNEL;**407**;July 10, 1995;Build 8
 ;
 ;MD5 based on info from 4.005 SORT BY VUID
 ;
 Q
INIT ;
 K ^TMP("PROOT",$J) ;ROOT of file in the case of pointer...
 K ^TMP("UNIQUE",$J) ; Global of unique Values
 N X1,X11,X2,X20,X22,X3,X10,X21
 ;TMP5(sequence #)= 1  if unique value
 S DIC=4.005,X=$S(X0:"`",1:"")_X0,DIC(0)="Z",U="^" D ^DIC
 I Y=-1 S ERROR="1^Unknown entry of 4.005 File: "_X0 Q
 S X0=+Y,X0NAME=$P(Y(0),U) S:'$G(MODE) MODE=+$P(Y(0),U,2) K TMP M TMP=@($$ROOT^DILFD(4.005,,0)_"""AC"",X0)")
 ; Set TMP5 if pointer type of field
 S X1=0,(X10,X20)=0 F  S X1=$O(TMP(X1)) Q:'X1  S X2=$O(TMP(X1,X0,0)) D
 .S X3=$O(TMP(X1,X0,X2,0))
 .S X11=$O(TMP(X1)),X21=$O(TMP(+X11,X0,0))
 .I X20'=X2,X2'=X21,'$D(^DIC(X2)),$G(^DD(X2,0))'["EFFECTIVE DATE/TIME" S TMP6(X2,X3)=1
 .S X20=X2
 .S POINTER=$$POINTER(X2,X3)
 .S:POINTER TMP7(X2,X3)=POINTER
 D GETS^DIQ(4.005,X0_",","**","","TMP1")
 S A="" F  S A=$O(TMP1(4.00511,A)) Q:'$L(A)  D
 .N X1,X2
 .S X1=$P(A,",",2),X2=$P(A,",",1)
 .S:TMP1(4.00511,A,2)="INTERNAL" TMP2(X1,X2)=""
 .;+++++++++++++++Set array of fields of pointer type VUID into TMP4 +++++++++++++++++++++++++
 .;TMP1(4.00511,A,3) = File Number Of Pointed to Field for VUID sort
 .S:TMP1(4.00511,A,3) TMP4(X1,X2)=TMP1(4.00511,A,3)
 .;+++++++++++++++Set array of columns with Unique value into TMP5 +++++++++++++++++++++++++
 .;TMP1(4.00511,A,4) = Unique value YES
 .S:TMP1(4.00511,A,4)="YES" TMP5(X1,X2)=1
 ;
 ;MODE set from input parameter or from file.
 S A=$C(1,35,69,103)
 S B=$C(137,171,205,239)
 S C=$C(254,220,186,152)
 S D=$C(118,84,50,16)
 S ABCD=A_B_C_D
 S (CNT,CNTT,CNHT)=0
 S VALUE=""
 ;X1 = SEQUENCE
 ;X2 = FILE/SUBFILE #
 ;X3 = Field #
 ;TMP(MD5 Sequence ,IEN of entry from 4.005 file , File/Subfile#,field#)=""
 ;TMP1 = FILE # ALL ENTRIES
 ;TMP2(file#, field #)=""  Set.. if INTERNAL value required
 ;TMP4(file#, field #)=Subfile #   Set if SORT by VUID for subfile = file #
 ;TMP5(file#, field #)= 1  if unique value requested
 ;TMP6(file#, field #)= 1  if column mode.. it's not used yet...
 ;TMP7(file#, field #)=file # of pointer type field
 S START=1,X1=0,LEV=0,X2OLD=0,XMD5=$O(^TMP("XUMF ERROR",$J,9999999999999),-1)+1,EXITMD5=0
 Q
END ;************ So get the final ABCD value... ************
 S ABCD=$$MD5E^XUMF5AU(ABCD,VALUE,0,CNHT*64+$L(VALUE))
 D:MODE
 .W ! D SETACK^XUMF5I($S(MODE=1.1:"",1:"Last value: ")_VALUE)
 .D SETACK^XUMF5I("LAST HASH:  "_$$MAIN^XUMF5BYT($$HEX^XUMF5AU(ABCD))) W !
 .D SETACK^XUMF5I("Total number of Characters included in Hash : "_(CNHT*64+$L(VALUE)))
 .D SETACK^XUMF5I("Length of last value: "_$L(VALUE))
 .D SETACK^XUMF5I("Number of file entries: "_CNTT)
 .D SETACK^XUMF5I("Number of hash entries: "_(CNHT+1))
 .D SETACK^XUMF5I("Number of values: "_CNT)
 .W !
 ;************ Hex conversion + storage of the final ABCD value ************
 S VALUE=$$MAIN^XUMF5BYT($$HEX^XUMF5AU(ABCD))
 K FDA
 S FDA(4.005,X0_",",4)=$$NOW^XLFDT
 S FDA(4.005,X0_",",5)=VALUE
 K ERR D FILE^DIE(,"FDA","ERR")
 I $D(ERR) D
 .S ERROR="1^MD5 Date updating error"
 .D EM^XUMFX("file DIE call error message in RDT",.ERR)
 .K ERR
 D SETACK^XUMF5I("MD5 Signature Entry: "_X0NAME)
 D SETACK^XUMF5I("Local Hash value: "_VALUE)
 S ERROR=$G(ERROR)
 S X1=$O(@($$ROOT^DILFD(4.009,,0,"ERR")_"0)"))_","
 D GETS^DIQ(4.009,X1,"*",,"TMP3") S VERSION=$G(TMP3(4.009,X1,1))
 S $P(ERROR,U,2)=$P(ERROR,U,2)_";CHECKSUM:"_VALUE_";VERSION:"_VERSION_";"
 D SETACK^XUMF5I("ERROR variable: "_ERROR)
 K ^TMP("PROOT",$J)
 Q VALUE
 Q
POINTER(X2,XXP)     ;GET THE POINTER FILE #
 N FTYPE,TT,I
 S:'$G(XXP) XXP=.01
 D FIELD^DID(X2,XXP,,"TYPE;POINTER","TT")
 Q:$G(TT("TYPE"))'="POINTER" 0
 Q:'$L($G(TT("POINTER"))) 0
 S TT="1^"_TT("POINTER")
 Q TT
