MAGDGL ;WOIFO/EdM - Global Lister ; 05/27/2005  09:23
 ;;3.0;IMAGING;**11,51**;26-August-2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; Call Global Variable Lister
 N DTIME,I,MAX,N,WILD,OUT,T,X
 S DTIME=$G(DTIME,300),MAX=20
 F  D  Q:WILD=""
 . W !,"Global Variable name: ^" R WILD:DTIME E  S WILD=""
 . S:WILD="^" WILD=""
 . Q:WILD=""
 . S:$E(WILD,1)'="^" WILD="^"_WILD
 . S (N,START)=0 F  D  Q:N<MAX  Q:X["^"
 . . K OUT
 . . D LIST(.OUT,WILD,MAX,START)
 . . I OUT(1)<0 D  Q
 . . . W !,"Error in processing:",!,OUT(1),!
 . . . W !,"Enter a ""wildcard"" that indicates what part of which"
 . . . W !,"global variable is to be displayed."
 . . . W !,"The following examples show the options:"
 . . . W !,"  ^MAG(2005,0)              - one single node"
 . . . W !,"  ^MAG(2005,,100)           - 2nd subscript may have any value"
 . . . W !,"  ^MAG(2005,50:200,100)     - 2nd subscript must be between 50 and 200"
 . . . W !,"  ^MAG(2005,""B"",::%S[""JOHN"" - third subscript must contain specific text"
 . . . W !,"  ^MAG(2005,,0:0:%D[""JOHN""  - data must contain specific text"
 . . . S X="^"
 . . . Q
 . . S I=1,N=0 F  S I=$O(OUT(I)) Q:I=""  D
 . . . S N=N+2
 . . . W !,OUT(I) S T=$O(OUT(I)) Q:T=""
 . . . W " = ",OUT(T) S I=T
 . . . F  D  Q:T=""
 . . . . S T=$O(OUT(T)) Q:T=""  I OUT(T)'="" S T="" Q
 . . . . S T=$O(OUT(T)) Q:T=""  W OUT(T) S I=T
 . . . . Q
 . . . Q
 . . I N<MAX S X="^" Q
 . . W !!,"More? YES// " R X:DTIME E  S X="^"
 . . I X="" S X="YES" W X
 . . I "Yy"'[$E(X_"^",1) S X="^" Q
 . . S START=OUT(1)
 . . Q
 . Q
 Q
 ;
LIST(OUT,WILD,MAX,START) ; RPC = MAG DICOM LIST GLOBAL VARIABLE
 N %D,E,I,L,M,N,NODE,OK,Q,REF,X
 I $D(RPC0) D  Q:'OK
 . N KEY,LIST,RET
 . S KEY="MAG SYSTEM",LIST(1)=KEY D OWNSKEY^XUSRB(.RET,.LIST,DUZ)
 . S OK=$G(RET(1))
 . S:'OK OUT(1)="-13,Calling user does not have security key "_KEY
 . Q
 I $E($G(WILD),1)'="^" S OUT(1)="-1,Invalid wild-card: "_WILD Q
 S NODE=0,START=$G(START)\1 S:START<1 START=0
 S (N,M)=1,Q=0,REF(1,1,1)="" F I=1:1:$L(WILD) D
 . S E=$E(WILD,I)
 . I Q S REF(1,N,M)=REF(1,N,M)_E S:E="""" Q=0 Q
 . I E="""" S Q=1,REF(1,N,M)=REF(1,N,M)_E Q
 . I "()"[E S N=N+1,REF(1,N)=E,N=N+1,M=1,REF(1,N,1)="" Q
 . I E="," D  Q
 . . I N=1 S M=M+1,REF(1,1,M)=E,M=M+1,REF(1,1,M)="" Q
 . . S N=N+1,REF(1,N)=E,N=N+1,M=1,REF(1,N,1)=""
 . . Q
 . I N=1,"[|]"[E S M=M+1,REF(1,N,M)=E,M=M+1,REF(1,N,M)="" Q
 . I " :"[E S M=M+1,REF(1,N,M)=E,M=M+1,REF(1,N,M)="" Q
 . S REF(1,N,M)=REF(1,N,M)_E
 . Q
 K:REF(1,N,M)="" REF(1,N,M)
 S REF="",I="" F  S I=$O(REF(1,1,I)) Q:I=""  S REF=REF_REF(1,1,I)
 S X="-2,Invalid Global Variable Name "_REF D
 . N $ET
 . S $ET="S X=X_$EC,$EC="""" Q"
 . S X=$D(@REF)
 . Q
 I X<0 S OUT(1)=X Q
 S N=0 D TRAVERSE(3,REF_"(")
 S OUT(1)=NODE
 Q
 ;
TRAVERSE(LEV,ROOT) N FROM,IF,NAME,%S,SEP,TO
 S NAME=ROOT_"%S)",(FROM,TO,IF)=""
 I $O(REF(1,LEV,1))="",$G(REF(1,LEV,1))="" D  Q
 . S %S="" F  S %S=$O(@NAME) Q:%S=""  D SHOW Q:N'<MAX
 . Q
 I $O(REF(1,LEV,1))="" D  Q
 . S %S=REF(1,LEV,1)
 . D:%S'=""
 . . N $ET
 . . S $ET="S OK=""-6,Error in subscript-value ""_%S_"": ""_$EC,$EC="""" Q"
 . . X "S %S="_%S
 . . Q
 . D SHOW
 . Q
 F SEP=2:2 D  Q:'SEP
 . I '$O(REF(1,LEV,SEP-2)) S SEP=0 Q
 . S (FROM,TO,IF)=""
 . I $G(REF(1,LEV,SEP)," ")=" " S %S=REF(1,LEV,SEP-1) D SHOW Q
 . S FROM=$G(REF(1,LEV,SEP-1)),TO=$G(REF(1,LEV,SEP+1)),SEP=SEP+2
 . S IF="" I $G(REF(1,LEV,SEP))=":" S IF=$G(REF(1,LEV,SEP+1)),SEP=SEP+2
 . D:FROM'=""
 . . N $ET
 . . S $ET="S OK=""-4,Error in from-value ""_FROM_"": ""_$EC,$EC="""" Q"
 . . X "S FROM="_FROM
 . . Q
 . D:TO'=""
 . . N $ET
 . . S $ET="S OK=""-5,Error in to-value ""_TO_"": ""_$EC,$EC="""" Q"
 . . X "S TO="_TO
 . . Q
 . S %S=FROM F  D SHOW S %S=$O(@NAME) Q:%S=""  I TO'="" Q:%S]]TO
 . Q
 Q
 ;
Q(X) I +X=X Q X
 N E,I,R
 S R="" F I=1:1:$L(X) S E=$E(X,I),R=R_E S:E="""" R=R_E
 Q """"_R_""""
 ;
SHOW N A,C,I,NM,OK,X
 Q:%S=""
 S OK='$L(IF)
 I IF["%S",IF'["%D" D  Q:'OK
 . N $ET
 . S $ET="S OK=""-3,Error in ""_IF_"": ""_$EC,$EC="""" Q"
 . X "I "_IF_" S OK=1"
 . Q
 D:$D(@NAME)#2
 . S %D=@NAME I IF'="" D  Q:'OK
 . . N $ET
 . . S $ET="S OK=""-3,Error in ""_IF_"": ""_$EC,$EC="""" Q"
 . . X "I "_IF_" S OK=1"
 . . Q
 . I OK<0 W !,OK Q
 . S NODE=NODE+1 I START>0 S START=START-1 Q
 . S NM=$NA(@NAME)
 . S X="""",C=0 F I=1:1:$L(%D) D
 . . S A=$A(%D,I)
 . . I A>31,A<127,'C S X=X_$C(A) S:A=34 X=X_$C(A) Q
 . . I A>31,A<127 S C=0,X=X_")_"""_$C(A) S:A=34 X=X_$C(A) Q
 . . I X="""" S X="$C("_A,C=1 Q
 . . I C S X=X_","_A Q
 . . S X=X_"""_$C("_A,C=1
 . . Q
 . S X=X_$S(C:")",1:"""")
 . F  D  Q:X=""
 . . S N=N+1,OUT(N+1)=NM,NM=""
 . . S N=N+1,OUT(N+1)=$E(X,1,250),X=$E(X,251,$L(X))
 . . Q
 . Q
 Q:N'<MAX
 Q:$G(REF(1,LEV+1))=")"
 D:OK TRAVERSE(LEV+2,ROOT_$$Q(%S)_",")
 Q
 ;
