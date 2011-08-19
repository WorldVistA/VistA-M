ALPBGEN1 ;SFVAMC/JC - Parse and File HL7 PMU messages ;05/10/07
 ;;3.0;BAR CODE MED ADMIN;**8,37**;Mar 2004;Build 10
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
PARSIT ;PARSE MESSAGE ON RECEIVING SIDE
 N FS,EC,CS,RS,ESC,SS,EEC,EFS,ECS,ERS,ESS,ALPBID,ALPBKY,ALPBMENU,ALPBMT,ALPBVC,DATE,DIK,DLAYGO,STF
 S FS=$G(HL("FS")) I FS="" W !,"NO SEPARATOR" Q:FS=""  ;Field separator
 S EC=$G(HL("ECH")) Q:EC=""  ;Encoding Charaters
 S CS=$E(EC) ;Component separator
 S RS=$E(EC,2) ;Repitition separator
 S ESC=$E(EC,3) ;Escape character
 S SS=$E(EC,4) ;Subcomponent separator
 S EEC=ESC_"E"_ESC ;escaped escape character
 S EFS=ESC_"F"_ESC ;escaped field sep
 S ECS=ESC_"S"_ESC ;escaped component sep
 S ERS=ESC_"R"_ESC ; escaped repitition sep
 S ESS=ESC_"T"_ESC ;escaped subcomponent separator
 N ALPBI,ALBPJ,ALPBX,ALPBAC,ACLPVC,ALPBSSN,ALPBERR,ALPBNAM,ALPBTRM
 F  X HLNEXT Q:$G(HLQUIT)'>0  D
 . I $E(HLNODE,1,3)="EVN" S ALPBMT=$P(HLNODE,2)
 . I $E(HLNODE,1,3)="STF" S STF=$E(HLNODE,5,9999) D PSTF
 Q
PSTF ;Process STF segment
 S ALPBKY=$P(STF,FS,1) Q:ALPBKY'[200_CS_"VISTA"
 S ALPBID=$P(STF,FS,2) S ALPBSSN=$E(ALPBID,1,9),ALPBAC=$P(ALPBID,RS,2),ALPBVC=$P(ALPBID,RS,3) D
 . S ALPBSSN=$TR(ALPBSSN,"-","")
 . I ALPBAC']"" S ALERR("ACCESS")="MISSING ACCESS CODE"
 . I ALPBVC']"" S ALERR("VERIFY")="MISSING VERIFY CODE"
 . ;Unescape Access Code
 . S ALPBAC=$$UNESC(ALPBAC)
 . ;Unescape Verify Code
 . S ALPBVC=$$UNESC(ALPBVC)
 S ALPBNAM=$P(STF,FS,3),ALPBNAM=$P(ALPBNAM,CS,1)_","_$P(ALPBNAM,CS,2)_" "_$P(ALPBNAM,CS,3)_" "_$P(ALPBNAM,CS,4) I ALPBNAM["  " S ALPBNAM=$TR(ALPBNAM," ","") I ALPBNAM']"" S ALERR("NAME")="MISSING NAME"
 I $D(ALERR) G PERR
 S ALPBDIS=$S($P(STF,FS,7)="I":1,1:0)
 I $P(STF,FS,13)]"" S ALPBTRM=$$HL7TFM^XLFDT($P(STF,FS,13),"L")
FILE ;Store File 200 data on backup system
 N Y,DIC,DIE,DA,DR
 Q:'$D(ALPBNAM)
 Q:$L(ALPBSSN)'=9
 ;Try exact SSn lookup first
 K Y S DIC="^VA(200,",DIC(0)="X",X=ALPBSSN,D="SSN" D IX^DIC
 ;S DLAYGO=200,DIC="^VA(200,",DIC(0)="LM",X=ALPBNAM D ^DIC K DIC,DA,DR
 ;If SSN lookup fails, try name lookup and add
 I +Y<1 S DLAYGO=200,DIC="^VA(200,",DIC(0)="LM",X=ALPBNAM D ^DIC K DIC,DA,DR
 I +Y>0 S (ALPBDA,DA,DUZ)=+Y S ALPBMENU=$O(^DIC(19,"B","PSB BCBU WRKSTN MAIN",0)) D
 . S DIE="^VA(200,",DR="2////^S X=ALPBAC"
 . ;Update name too
 . S DR=DR_";.01////^S X=ALPBNAM"
 . I ALPBDIS]"" S DR=DR_";7////^S X=ALPBDIS"
 . I ALPBSSN]"",$L(ALPBSSN)=9 S DR=DR_";9////^S X=ALPBSSN"
 . I ALPBVC]"" S DR=DR_";11////^S X=ALPBVC"
 . I +ALPBMENU S DR=DR_";201////^S X=ALPBMENU"
 . I $G(ALPBTRM)]"" S DR=DR_";9.2////^S X=ALPBTRM"
 . I $G(DR)]"" D ^DIE K DIC,DA,DR S DIK=DIE,DA=ALPBDA D IX1^DIK
 K ALPBDA,HL,ALPBDIS,ALPBI,ALBPJ,ALPBX,ALPBAC,ACLPVC,ALPBSSN,ALERR,ALPBNAM,ALPBTRM
 Q
UNESC(ST,PR) ;Unescape string from message
 ;ST=String to translate
 ;PR=Event Protocol to set up HL array variables (optional)
 ;First, do the escape character
 I $G(ST)="" Q ""
 S PR=$G(PR) I PR]"" D INIT^HLFNC2(PR,.HL)
 I '$D(HL) D
 . S HL("FS")="^"
 . S HL("ECH")="~|\&"
 S FS=$G(HL("FS")) I FS="" Q "" ;Field separator
 S EC=$G(HL("ECH")) I EC="" Q ""  ;Encoding Charaters
 S CS=$E(EC) ;Component separator
 S RS=$E(EC,2) ;Repitition separator
 S ESC=$E(EC,3) ;Escape character
 S SS=$E(EC,4) ;Subcomponent separator
 S EEC=ESC_"E"_ESC ;escaped escape character
 S EFS=ESC_"F"_ESC ;escaped field sep
 S ECS=ESC_"S"_ESC ;escaped component sep
 S ERS=ESC_"R"_ESC ; escaped repitition sep
 S ESS=ESC_"T"_ESC ;escaped subcomponent separator
 K I,J,K,L,X F  S X=$F(ST,EEC) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K($G(I)+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[EEC K(I)=$P(K(I),EEC)_ESC S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X F  S X=$F(ST,EFS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K($G(I)+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[EFS K(I)=$P(K(I),EFS)_FS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ECS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ECS K(I)=$P(K(I),ECS)_CS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ERS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ERS K(I)=$P(K(I),ERS)_RS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 ;
 K I,J,K,L,X S I=0 F  S X=$F(ST,ESS) S:X I=$G(I)+1,K(I)=$E(ST,1,X-1),ST=$E(ST,X,999) S:'X K(I+1)=ST Q:'X
 S I=0 F  S I=$O(K(I)) Q:I<1  S:K(I)[ESS K(I)=$P(K(I),ESS)_SS S L=$G(L)_K(I)
 I $G(L)]"" S ST=L
 K I,J,K,L,X
 Q ST
PERR ;PROCESSING ERRORS
 H 1 S DATE=$$NOW^XLFDT M ^TMP("BCBU",$J,$S($G(ALPBSSN)'="":ALPBSSN,1:0),DATE)=ALERR
 K ALERR
 Q
