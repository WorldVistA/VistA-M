HMPUPD ;SLC/MKB,ASMR/RRB - Update local data ;11/13/13 2:11pm
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**;Sep 01, 2011;Build 63
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
PHONE(HMP,JSON) ; RPC = HMP PUT PHONE
 Q
PUT(HMP,DFN,CMD,JSON) ; -- update phone numbers
 ; RPC = HMP PUT DEMOGRAPHICS
 ;
 N ARRAY,HMPERR,ERR,HOME,CELL,WORK,NOK,ECON,X,OK,HMPSYS
 S HMPSYS=$$GET^XPAR("SYS","HMP SYSTEM NAME")
 D DECODE^HMPJSON("JSON","ARRAY","HMPERR")
 I $D(HMPERR) D  G PQ
 . K ARRAY N HMPTMP,HMPTXT
 . S HMPTXT(1)="Problem decoding json input."
 . D SETERROR^HMPUTILS(.HMPTMP,.HMPERR,.HMPTXT,.JSON)
 . K HMPERR D ENCODE^HMPJSON("HMPTMP","ARRAY","HMPERR")
 . S HMP(.5)="{""apiVersion"":""1.01"",""error"":{"
 . M HMP(1)=ARRAY
 . S HMP(2)="}}"
 ;
 S DFN=+$G(DFN) I DFN<1 S ERR=$$ERR(1,DFN) G PHQ
 S CMD=$G(CMD) ;can only update phone#
 N HMPX,HMPDR,I,J S (HMPDR,HOME,CELL,WORK,NOK,ECON)=""
 D VAL("old")
 S I="" F  S I=$O(ARRAY("telecom",I)) Q:I<1  D
 . I $G(ARRAY("telecom",I,"use"))="H" D  Q
 .. S HOME=$G(ARRAY("telecom",I,"value"))
 .. I HOME=HOME("old") S HOME="" Q           ;no change
 .. I "@"[HOME S:$L(HOME("old")) HOME="@" Q  ;delete
 .. S HOME=$$FORMAT(HOME),ARRAY("telecom",I,"value")=HOME
 . I $G(ARRAY("telecom",I,"use"))="MC" D  Q
 .. S CELL=$G(ARRAY("telecom",I,"value"))
 .. I CELL=CELL("old") S CELL="" Q           ;no change
 .. I "@"[CELL S:$L(CELL("old")) CELL="@" Q  ;delete
 .. S CELL=$$FORMAT(CELL),ARRAY("telecom",I,"value")=CELL
 . I $G(ARRAY("telecom",I,"use"))="WP" D  Q
 .. S WORK=$G(ARRAY("telecom",I,"value"))
 .. I WORK=WORK("old") S WORK="" Q           ;no change
 .. I "@"[WORK S:$L(WORK("old")) WORK="@" Q  ;delete
 .. S WORK=$$FORMAT(WORK),ARRAY("telecom",I,"value")=WORK
 S I="" F  S I=$O(ARRAY("contact",I)) Q:I<1  D
 . S X=$P($G(ARRAY("contact",I,"typeCode")),":",4) Q:X=""  ;NOK or ECON
 . S J="" F  S J=$O(ARRAY("contact",I,"telecom",J)) Q:J<1  D
 .. Q:$G(ARRAY("contact",I,"telecom",J,"use"))'="H"
 .. S @X=$G(ARRAY("contact",I,"telecom",J,"value"))
 .. I @X=@X@("old") S @X="" Q           ;no change
 .. I "@"[@X S:$L(@X@("old")) @X="@" Q  ;delete
 .. S @X=$$FORMAT(@X),ARRAY("contact",I,"telecom",J,"value")=@X
 .. ; X="NOK" S NOK=$$FORMAT(NOK),ARRAY("contact",I,"telecom",J,"value")=NOK
 ;
 S:$L(HOME) HMPX(.131)=HOME,HMPDR=".131"
 S:$L(CELL) HMPX(.134)=CELL,HMPDR=HMPDR_$S($L(HMPDR):";",1:"")_".134"
 S:$L(WORK) HMPX(.132)=WORK,HMPDR=HMPDR_$S($L(HMPDR):";",1:"")_".132"
 S:$L(ECON) HMPX(.339)=ECON,HMPDR=HMPDR_$S($L(HMPDR):";",1:"")_".339"
 S:$L(NOK) HMPX(.219)=NOK,HMPDR=HMPDR_$S($L(HMPDR):";",1:"")_".219"
 I '$O(HMPX(0)) S ERR=$$ERR(3) G PHQ
 D EDIT^VAFCPTED(DFN,"HMPX",HMPDR)
 S X=$G(^DPT(DFN,.13)),OK=1 D  ;check global ;ICR 10035 DE2818 ASF 11/12/15
 . I $L(HOME),$S(HOME="@":$L($P(X,U)),1:(HMPX(.131)'=$P(X,U))) S OK=0
 . I $L(CELL),$S(CELL="@":$L($P(X,U,4)),1:(HMPX(.134)'=$P(X,U,4))) S OK=0
 . I $L(WORK),$S(WORK="@":$L($P(X,U,2)),1:(HMPX(.132)'=$P(X,U,2))) S OK=0
 . I $L(ECON) S X=$G(^DPT(DFN,.33)) I $S(ECON="@":$L($P(X,U,9)),1:(HMPX(.339)'=$P(X,U,9))) S OK=0 ;ICR 10035 DE2818 ASF 11/12/15
 . I $L(NOK) S X=$G(^DPT(DFN,.21)) I $S(NOK="@":$L($P(X,U,9)),1:(HMPX(.219)'=$P(X,U,9))) S OK=0 ;ICR 10035 DE2818 ASF 11/12/15
 S:'OK ERR=$$ERR(5)
 ;
PHQ ; add item count and terminating characters
 I $D(ERR) S HMP(1)="{""apiVersion"":""1.01"",""error"":{""message"":"""_ERR_"""},""success"":false}" G PQ
 ; HMP="{""apiVersion"":""1.01"",""data"":{""updated"":"_""""_$$HL7NOW_""""_",""localId"":"""_DFN_"""},""success"":true}"
 D POSTX^HMPEVNT("patient",DFN)
 D ENCODE^HMPJSON("ARRAY","HMP","HMPERR")
 I $D(HMPERR) D  G PQ
 . K HMP N HMPTMP,HMPTXT
 . S HMPTXT(1)="Problem encoding json output."
 . D SETERROR^HMPUTILS(.HMPTMP,.HMPERR,.HMPTXT,.ARRAY)
 . K HMPERR D ENCODE^HMPJSON("HMPTMP","HMP","HMPERR")
 . S HMP(.5)="{""apiVersion"":""1.01"",""error"":{",HMP(99)="}}"
 S HMP(.5)="{""apiVersion"":""1.01"",""params"":{"_$$SYS^HMPDJ_"},""success"":true,"
 S HMP(.6)="""data"":{""updated"":"""_$$HL7NOW^HMPDJ_""",""totalItems"":1,""items"":["
 S HMP(99)="]}}"
PQ ; exit
 K ^TMP($J,"HMP")
 M ^TMP($J,"HMP")=HMP
 K HMP S HMP=$NA(^TMP($J,"HMP"))
 Q
 ;
FORMAT(X) ; -- enforce (xxx)xxx-xxxx phone format
 S X=$G(X) I X?1"("3N1")"3N1"-"4N.E Q X
 N P,N,I,Y S P=""
 F I=1:1:$L(X) S N=$E(X,I) I N=+N S P=P_N
 S:$L(P)<10 P=$E("0000000000",1,10-$L(P))_P
 S Y=$S(P:"("_$E(P,1,3)_")"_$E(P,4,6)_"-"_$E(P,7,10),1:"")
 Q Y
 ;
HL7NOW() ; -- Return current time in HL7 format
 Q $P($$FMTHL7^XLFDT($$NOW^XLFDT),"-")
 ;
ERR(X,VAL) ; -- return error message
 N MSG  S MSG="Error"
 I X=1  S MSG="Patient with dfn '"_$G(VAL)_"' not found"
 I X=2  S MSG="Domain type '"_$G(VAL)_"' not recognized"
 I X=3  S MSG="Data not changed"
 I X=4  S MSG="Unable to create new object"
 I X=5  S MSG="Update failed"
 I X=99 S MSG="Unknown request"
 Q MSG
 ;
VAL(SUB) ; -- pull values from ^DPT
 N X S X=$G(^DPT(DFN,.13)) ;ICR 10035 DE2818 ASF 11/12/15
 S HOME(SUB)=$P(X,U),CELL(SUB)=$P(X,U,4),WORK(SUB)=$P(X,U,2)
 S X=$G(^DPT(DFN,.33)),ECON(SUB)=$P(X,U,9) ;ICR 10035 DE2818 ASF 11/12/15
 S X=$G(^DPT(DFN,.21)),NOK(SUB)=$P(X,U,9) ;ICR 10035 DE2818 ASF 11/12/15
 Q
