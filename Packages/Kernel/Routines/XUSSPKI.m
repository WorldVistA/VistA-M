XUSSPKI ;ISF/RWF - Kernel Security Services PKI ;02/04/2003  13:19
 ;;8.0;KERNEL;**283**;Jul 10, 1995
 ;;
 Q  ;No entry from top
 ;Supported by IA # 3539
 ;This is a M api to store the Digital Signature in file 8980.2
STORESIG(XU1,XU2,XU3,XU4,XU5) ;Store the signature.
 ;XU1 is the hash
 ;XU2 is the string length
 ;XU3 is an array for the sig
 ;XU4 is the DUZ of the signer
 ;XU5 is the file that holds the data.
 ;Returns 1 if filed OK, "-1^message" if an error.
 N FDA,IEN,CNT,ROOT
 I $$FIND1^DIC(8980.2,,"X",XU1)>0 Q "-1^Dup Hash"
 I $G(XU4)<.5 Q "-1^No DUZ"
 I $G(XU5)="" Q "-1^No File Number"
 S CNT=0,ROOT="XU3"
 F  S ROOT=$Q(@ROOT) Q:ROOT=""  S CNT=CNT+$L(@ROOT)
 I CNT'=XU2 Q "-1^BAD SIG LENGTH"
 S FDA(8980.2,"+1,",.01)=XU1
 S FDA(8980.2,"+1,",.02)=XU2
 S FDA(8980.2,"+1,",.03)=XU4
 S FDA(8980.2,"+1,",.04)=XU5
 S FDA(8980.2,"+1,",1)="XU3"
 D UPDATE^DIE("S","FDA","IEN")
 I $D(^TMP("DIERR",$J)) Q "-1^DBS Error"
 Q 1
 ;
 ;Supported by IA # 3539
CRLURL(XU1) ;Store the URL for the CRL
 ;Store each URL as a separte record
 N FDA,IEN,CNT,NOW,X,Y,ERR
 S ERR=0,NOW=$$NOW^XLFDT
 F CNT=1:1 S X=$P(XU1,$C(9),CNT) Q:X=""  D
 . S Y=$$LOW^XLFSTR($E(X,1,4))
 . I '((Y="http")!(Y="ldap")) Q
 . S FDA(8980.22,"?+"_CNT_",",.01)=X
 . S FDA(8980.22,"?+"_CNT_",",1)=NOW
 . D UPDATE^DIE("S","FDA","IEN")
 . I $D(^TMP("DIERR",$J)) S ERR=1
 . Q
 Q $S('ERR:1,1:"-1^DBS Error")
 ;
 ;Supported by IA # 3539
VERIFY(XU1,XU2,XU3) ;Veryify the data
 ;The HASH is in XU1
 ;The data root is in XU2
 ;(optional) Date to check against
 N CNT,IEN,SD,DR,R,V,ZX K ^TMP("PKI",$J),^TMP("pki",$J)
 S IEN=$$FIND1^DIC(8980.2,,"X",XU1)
 I IEN'>0 Q "-1^FAIL TO FIND HASH"
 S CNT=0,SD=$NA(^TMP("PKI",$J)),DR=$E(XU2,1,$L(XU2)-1)
 ;Load the data into the buffer
 F  S XU2=$Q(@XU2) Q:XU2'[DR  S V=@XU2 I $L(V) D ADD(V)
 D ADD("") ;Blank line between
 ;Load the Digital Signature into the buffer
 F I=1:1 Q:'$D(^XUSSPKI(8980.2,IEN,1,I,0))  S V=^(0) I $L(V) D ADD(V)
 ;Then a Blank line and the Date.
 D ADD(""),ADD($G(XU3))
 ;Send the buffer
 S S=$$EN^XUSC1("DSIG",SD,$NA(ZX))
 S R=$S(S<0:S,1:ZX(1))
 Q R
ADD(V) ;Add to the send array
 S CNT=CNT+1,@SD@(CNT)=V
 Q
 ;
CRLUP ;Send any unsent CRL URL's to the server
 ;Server port is 10270
 L ^XUSSPKI(8980.22,"AC"):1 I '$T Q  ;Busy
 N CNT,SD,FDA,IEN,LIM,NOW,X1,X2,X3 K ^TMP("PKI",$J),^TMP("XUSSPKI",$J)
 ;Only send for 300 days past last seen date
 S X1=0,LIM=$$HTFM^XLFDT($H-300),CNT=0,NOW=$$NOW^XLFDT
 S SD=$NA(^TMP("PKI",$J)),FDA=$NA(^TMP("XUSSPKI",$J))
 F  S X1=$O(^XUSSPKI(8980.22,X1)) Q:X1=""  D
 . S X2=$G(^XUSSPKI(8980.22,X1,0)),X2(1)=$P(X2,U,1),X2(2)=$P(X2,U,2),X2(3)=$P(X2,U,3) Q:'$L(X2(1))
 . ;Only send http for now
 . I "http:"'=$$LOW^XLFSTR($E(X2,1,5)) Q
 . ;Check last seen, Last sent more than 3 hours ago.
 . I (X2(2)<LIM)!($$FMDIFF^XLFDT(NOW,X2(3),2)<10800) Q
 . D ADD(X2(1)) S @FDA@("8980.22",X1_",",2)=NOW
 . Q
 S S=-1 ;Init var, CNT update in ADD
 ;Send the buffer of CRL URL's
 I CNT D
 . S S=$$EN^XUSC1("CRL ",SD,$NA(X3))
 . S @SD@("Result")=S_"^"_$G(X3(1))
 . S S=$S(S<0:S,$G(X3(1))'="OK":"-3^"_$G(X3(1)),1:S)
 I CNT,(S<0) D
 . N XMB,XMY,XMTEXT,XMDUZ S XMB(1)=S,XMB(2)=$$FMTE^XLFDT(NOW),XMDUZ="CRL Upload Task"
 . S XMB="XUSSPKI CRL SERVER" D ^XMB
 . Q
 I S'<0 D
 . D FILE^DIE("K",FDA)
 Q
TESTCRL ;TEST CRLUP
 N FDA,LUD
 S DA=0,RT=$NA(^XUSSPKI(8980.22)),LUD=$$HTFM^XLFDT(+$H_",120")
 F  S DA=$O(@RT@(DA)) Q:DA'>0  S FDA(8980.22,DA_",",2)=LUD
 D FILE^DIE("K","FDA")
 D CRLUP
 W "Result: ",$G(^TMP("PKI",$J,"Result"))
 Q
