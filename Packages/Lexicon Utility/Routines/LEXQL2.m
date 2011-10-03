LEXQL2 ;ISL/KER - Query - Lookup Code (ICD/ICP) ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^DIC(81.3,          ICR   4492
 ;    ^ICD0(              ICR   4485
 ;    ^ICD9(              ICR   4485
 ;    ^ICPT(              ICR   4489
 ;    ^TMP("LEXQL")       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$ICDDX^ICDCODE     ICR   3990
 ;    $$ICDOP^ICDCODE     ICR   3990
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXVDT              Versioning Date - If it does not exist
 ;                        in the environment, TODAY is used
 ;               
 Q
ADD(X) ; Add to List
 N LEXIN,LEXO,LEXOC,LEXCT,LEXTY,LEXTD,LEXTMP S LEXTD=$$DT^XLFDT,U="^"
 S LEXIN=$$UP^XLFSTR($$TM($G(X)))
 I LEXIN["DIAGNOSIS"!(LEXIN["DX")!(LEXIN["ICDDX")  D  Q
 . S LEXTY=1 N LEXTMP F LEXTMP="DIAGNOSIS","ICDDX","DX" F  Q:LEXIN'[LEXTMP  S LEXIN=$P(LEXIN,LEXTMP,1)_$P(LEXIN,LEXTMP,2,299)
 . S LEXIN=$$TM($$DS(LEXIN)),LEXOC=$E(LEXIN,1,($L(LEXIN)-1))_$C(($A($E(LEXIN,$L(LEXIN)))-1))_"~" S LEXCT=LEXIN D ID,RE
 I LEXIN["OPERATION"!(LEXIN["OP")!(LEXIN["ICDOP")  D  Q
 . S LEXTY=2 N LEXTMP F LEXTMP="OPERATION","ICDOP","OP" F  Q:LEXIN'[LEXTMP  S LEXIN=$P(LEXIN,LEXTMP,1)_$P(LEXIN,LEXTMP,2,299)
 . S LEXIN=$$TM($$DS(LEXIN)),LEXOC=$E(LEXIN,1,($L(LEXIN)-1))_$C(($A($E(LEXIN,$L(LEXIN)))-1))_"~" S LEXCT=LEXIN D IP,RE
 I LEXIN["PROCEDURE"!(LEXIN["CPT-4")!(LEXIN["CPT")!(LEXIN["HCPCS")  D  Q
 . S LEXTY=3 S:LEXIN["HCPCS" LEXTY=4 N LEXTMP F LEXTMP="OPERATION","ICDOP","OP" F  Q:LEXIN'[LEXTMP  S LEXIN=$P(LEXIN,LEXTMP,1)_$P(LEXIN,LEXTMP,2,299)
 . S LEXIN=$$TM($$DS(LEXIN)),LEXOC=$E(LEXIN,1,($L(LEXIN)-1))_$C(($A($E(LEXIN,$L(LEXIN)))-1))_"~" S LEXCT=LEXIN D CP^LEXQL3,RE
 I $L(LEXIN)=2,$D(^DIC(81.3,"BA",(LEXIN_" "))),$O(^DIC(81.3,"BA",(LEXIN_" "),0))>0  D  Q
 . S LEXTY=5,LEXOC=$E(LEXIN,1,($L(LEXIN)-1))_$C(($A($E(LEXIN,$L(LEXIN)))-1))_"~" S LEXCT=LEXIN D CM^LEXQL3,RE
 I $L(LEXIN)=5,LEXIN'[".",$D(^ICPT("BA",(LEXIN_" "))),$O(^ICPT("BA",(LEXIN_" "),0))>0  D  Q
 . S LEXTY=3 S:LEXIN'?5N LEXTY=4
 . S LEXOC=$E(LEXIN,1,($L(LEXIN)-1))_$C(($A($E(LEXIN,$L(LEXIN)))-1))_"~" S LEXCT=LEXIN D CP^LEXQL3,RE
 I $L(LEXIN)[".",$L($P(LEXIN,"."))>2,($P(LEXIN,".")?3N!($P(LEXIN,".")?1"E"3N)!($P(LEXIN,".")?1"V"2N))  D  Q
 . S LEXTY=1 S LEXOC=$E(LEXIN,1,($L(LEXIN)-1))_$C(($A($E(LEXIN,$L(LEXIN)))-1))_"~" S LEXCT=LEXIN D ID,RE
 I $L(LEXIN)[".",$L($P(LEXIN,"."))=2,$P(LEXIN,".")?2N  D  Q
 . S LEXTY=1 S LEXOC=$E(LEXIN,1,($L(LEXIN)-1))_$C(($A($E(LEXIN,$L(LEXIN)))-1))_"~" S LEXCT=LEXIN D IP,RE
 Q:$L(LEXIN)'>1
 S LEXOC=$E(LEXIN,1,($L(LEXIN)-1))_$C(($A($E(LEXIN,$L(LEXIN)))-1))_"~",LEXCT=LEXIN
 D ID,IP,CP^LEXQL3,CM^LEXQL3,RE
 Q
RE ;   Re-Order List
 N LEXCT,LEXO,LEXT1,LEXT2,LEX S LEXO="" F  S LEXO=$O(^TMP("LEXQL",$J,"ADDLIST",LEXO)) Q:'$L(LEXO)  D
 . N LEXT1,LEXT2 S LEXT1=$$TM($G(^TMP("LEXQL",$J,"ADDLIST",LEXO)))
 . S LEXT2=$$TM($G(^TMP("LEXQL",$J,"ADDLIST",LEXO,2))) Q:'$L(LEXT2)
 . I $L(LEXT2) S LEX(1)=LEXT2 D PR^LEXQL3(.LEX,70) Q:'$L($G(LEX(1)))
 . S LEXCT=+($G(LEXCT))+1,^TMP("LEXQL",$J,+LEXCT)=$G(LEX(1)),^TMP("LEXQL",$J,0)=+LEXCT
 . S:$L($G(LEX(2))) ^TMP("LEXQL",$J,+LEXCT,2)=$G(LEX(2))
 K ^TMP("LEXQL",$J,"ADDLIST")
 Q
 ;    
ID ; $$ICDDX^ICDCODE(CODE,DATE)
 ;
 ;     1  IEN of code in ^ICD9(        1-5
 ;     2  ICD-9 Dx Code (#.01)         4-7
 ;     4  Versioned Dx (67)            2-30
 ;    10  Status (66)                  6-8 (external)
 ;    12  Inactive Date (66)           10 (external)
 ;    17  Activation Date (66)         10 (external)
 ;           
 S LEXO=LEXOC Q:'$L(LEXO)  Q:'$L($G(LEXCT))  N LEXIX F LEXIX="BA","D" D
 . Q:LEXIX="D"&(LEXOC?1N.NP)  S LEXO=LEXOC S:LEXIX="BA" LEXO=LEXO_" "
 . F  S LEXO=$O(^ICD9(LEXIX,LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXCT))'=LEXCT  D
 . . N LEXIEN S LEXIEN=0  F  S LEXIEN=$O(^ICD9(LEXIX,LEXO,LEXIEN)) Q:+LEXIEN'>0  D
 . . . S LEXIEN=+($G(LEXIEN)) Q:+LEXIEN'>0  N LEXT,LEXD,LEXC,LEXD,LEXN,LEXS,LEXE,LEXDS,LEXTN,LEXTS,LEXSS,LEXDT
 . . . S LEXC=$P($G(^ICD9(+LEXIEN,0)),U,1) Q:'$L(LEXC)  S LEXD=$G(LEXVDT) S:LEXD'?7N LEXD=$G(LEXTD) S LEXT=$$ICDDX^ICDCODE(LEXC,LEXD)
 . . . S LEXC=$P(LEXT,U,2),LEXN=$$UP^XLFSTR($P(LEXT,U,4)),LEXS=$P(LEXT,U,10) Q:'$L(LEXC)  Q:'$L(LEXN)  Q:'$L(LEXS)
 . . . S:+LEXS'>0 LEXE=$P(LEXT,U,12) S:+LEXS>0 LEXE=$P(LEXT,U,17) S LEXTS=$$STY^LEXQL3(LEXC),LEXTN=+LEXTS,LEXTS=$P(LEXTS,U,2) Q:'$L(LEXTS)
 . . . S LEXSS="" S:+LEXS'>0&($L($G(LEXE))) LEXSS="(Inactive)" S LEXDS=LEXN S:$L(LEXSS) LEXDS=LEXDS_" "_LEXSS
 . . . S LEXDT=LEXC,LEXDT=LEXDT_$J(" ",(8-$L(LEXDT)))_LEXDS S:$L(LEXTS) LEXDT=LEXDT_" ("_LEXTS_")"
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_" "))=LEXIEN_U_$$FT^LEXQL3(LEXC,LEXN,$TR(LEXSS,"()",""))
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_" "),2)=LEXIEN_U_$$FC^LEXQL3(LEXC,LEXN,$TR(LEXSS,"()",""))
 Q
IP ; $$ICDOP^ICDCODE(CODE,DATE)
 ; 
 ;     1  IEN of code in ^ICDO(        1-4
 ;     2  ICD-9 code (.01)             3-5
 ;     5  Versioned Oper/Proc (67)     2-50
 ;    10  Status (66)                  6-8 (external)
 ;    12  Inactive Date (66)           10 (external)
 ;    13  Activation Date (66)         10 (external)
 ;
 S LEXO=LEXOC Q:'$L(LEXO)  Q:'$L($G(LEXCT))  N LEXIX F LEXIX="BA","D" D
 . Q:LEXIX="D"&(LEXOC?1N.NP)  S LEXO=LEXOC S:LEXIX="BA" LEXO=LEXO_" "
 . F  S LEXO=$O(^ICD0(LEXIX,LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXCT))'=LEXCT  D
 . . N LEXIEN S LEXIEN=0  F  S LEXIEN=$O(^ICD0(LEXIX,LEXO,LEXIEN)) Q:+LEXIEN'>0  D
 . . . S LEXIEN=+($G(LEXIEN)) Q:+LEXIEN'>0  N LEXT,LEXD,LEXC,LEXD,LEXN,LEXS,LEXE,LEXDS,LEXTN,LEXTS,LEXSS,LEXDT
 . . . S LEXC=$P($G(^ICD0(+LEXIEN,0)),U,1) Q:'$L(LEXC)  S LEXD=$G(LEXVDT) S:LEXD'?7N LEXD=$G(LEXTD) S LEXT=$$ICDOP^ICDCODE(LEXC,LEXD)
 . . . S LEXC=$P(LEXT,U,2),LEXN=$$UP^XLFSTR($P(LEXT,U,5)),LEXS=$P(LEXT,U,10) Q:'$L(LEXC)  Q:'$L(LEXN)  Q:'$L(LEXS)
 . . . S:+LEXS'>0 LEXE=$P(LEXT,U,12) S:+LEXS>0 LEXE=$P(LEXT,U,13) S LEXTS=$$STY^LEXQL3(LEXC),LEXTN=+LEXTS,LEXTS=$P(LEXTS,U,2) Q:'$L(LEXTS)
 . . . S LEXSS="" S:+LEXS'>0&($L($G(LEXE))) LEXSS="(Inactive)" S LEXDS=LEXN S:$L(LEXSS) LEXDS=LEXDS_" "_LEXSS
 . . . S LEXDT=LEXC,LEXDT=LEXDT_$J(" ",(8-$L(LEXDT)))_LEXDS S:$L(LEXTS) LEXDT=LEXDT_" ("_LEXTS_")"
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_" "))=LEXIEN_U_$$FT^LEXQL3(LEXC,LEXN,$TR(LEXSS,"()",""))
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_" "),2)=LEXIEN_U_$$FC^LEXQL3(LEXC,LEXN,$TR(LEXSS,"()",""))
 Q
 ; Miscellaneous
SD(X) ;   Short Date
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
DS(X) ;   Trim Dubble Space Character
 S X=$G(X) Q:X'["  " X  F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,299)
 Q X
CL ;   Clear
 K LEXVDT
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
