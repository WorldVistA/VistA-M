SROGMTS0 ;BIR/ADM - SURGERY HEALTH SUMMARY ; [ 02/18/04  7:12 AM ]
 ;;3.0; Surgery ;**100**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to TGET^TIUSRVR1 supported by DBIA #2944
 ;
 Q
ED(X) ; external date
 S X=$G(X) Q:'$L(X) ""
 S X=$TR($$FMTE^XLFDT(X,"5DZ"),"@"," ")
 Q X
EDT(X) ; external date and time
 S X=$G(X) Q:'$L(X) ""
 S X=$TR($$FMTE^XLFDT(X,"2ZM"),"@"," ")
 Q X
EN(X) ; Convert Case
 N Y,SROK,SROC,SRWORD,SRPC,SRLEAD,SRTLR,SRTR,SRCTR,SRPRE
 S (SRTR,SRWORD,SRPC)="",X=$$UP(X)
 ; Parse by Spaces
 F SRCTR=1:1:$L(X," ") D
 . S SRWORD=$P(X," ",SRCTR)
 . S (SRPC,SRLEAD,SRTLR)=""
 . I $E(SRWORD,1)="(" S SRWORD=$E(SRWORD,2,$L(SRWORD)),SRLEAD="("
 . I $E(SRWORD,$L(SRWORD))=")" S SRWORD=$E(SRWORD,1,($L(SRWORD)-1)),SRTLR=")"
 . ; String contains special characters
 . S SROK=1 F SROC="(",")","-","*","+","{","&","}","[","]","/","\","|",",","'" S:SRWORD[SROC SROK=0 Q:'SROK
 . I 'SROK D SP
 . I SROK D SRWORD
 . S:SRLEAD'="" SRWORD=SRLEAD_SRWORD
 . S:SRTLR'="" SRWORD=SRWORD_SRTLR
 . S SRTR=SRTR_" "_SRWORD
 S X=$$TRIM(SRTR) Q X
EN2(X) ; Convert Case 2
 S X=$$CK($$EN($G(X))) Q X
SP ; Special Characters
 ; Special Cases of Special Characters
 I $$UP(SRWORD)="W/&W/O" S SRWORD="w/&w/o" Q
 I $$UP(SRWORD)="W&W/O" S SRWORD="w&w/o" Q
 I $$UP(SRWORD)="&/OR" S SRWORD="&/or" Q
 I SRWORD="W/O" S SRWORD="w/o" Q
 N SROK,SRWD1,SRWD2,SRW,SRWCTR,SRCHR
 S SRWD1=SRWORD,SRWD2="",SRW=""
 F SRWCTR=1:1:$L(SRWD1) D
 . S SRCHR=$E(SRWD1,SRWCTR) I "()-*+{}'&[]/\|,"[SRCHR,$L(SRW) D  Q
 . . S SRPRE=""
 . . S:$E(SRW,1,2)="ZZ"&($L(SRW)>2) SRPRE="ZZ",SRW=$E(SRW,3,$L(SRW))
 . . S SRW=SRPRE_$$CASE(SRW,SRCHR)
 . . S SRWD2=SRWD2_SRW_SRCHR,SRW=""
 . S SRW=SRW_SRCHR
 I $L(SRW) D
 . N SRPSN F SRPSN=1:1:$L(SRW) Q:"()-*+{}'&[]/\|,"'[$E(SRW,SRPSN)
 . N SROW,SRLW S SRLW=$E(SRW,0,(SRPSN-1))
 . S SROW=$E(SRW,SRPSN,$L(SRW))
 . S SRPRE="" S:$E(SROW,1,2)="ZZ"&($L(SROW)>2) SRPRE="ZZ",SROW=$E(SROW,3,$L(SROW))
 . S SROW=SRPRE_$$CASE(SROW,$E($G(SRWD2),$L($G(SRWD2))))
 . S SRW=SRLW_SROW
 . S SRWD2=SRWD2_SRW
 S SRWORD=SRWD2 S:SRCTR=1 SRWORD=$$LD(SRWORD)
 K SRWD1,SRWD2
 Q
SRWORD ; Convert word
 S SRPRE="" S:$E(SRWORD,1,2)="ZZ"&($L(SRWORD)>2) SRPRE="ZZ",SRWORD=$E(SRWORD,3,$L(SRWORD))
 S SRWORD=SRPRE_$$CASE(SRWORD,"")
 Q
CASE(X,J) ; Set to Mixed/lower/UPPER case
 N SRTAG,SRRTN,Y S X=$$UP($G(X)),Y="",SRTAG=$L(X),SRRTN="SROGMTS1"
 S:+SRTAG>4 SRRTN="SROGMTS2" S:+SRTAG>9 SRTAG="M"
 Q:+SRTAG=0&(SRTAG'="M") X
 S SRRTN=SRTAG_"^"_SRRTN D @SRRTN
 I $L(Y) S X=Y Q X
 S X=$$MX(X)
 Q X
LO(X) Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
MX(X) Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
LD(X) Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(X,2,$L(X))
TRIM(X) S X=$G(X) F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
CK(X) ;
 S X=$G(X)
 F  Q:X'["(S)"  S X=$P(X,"(S)",1)_"(s)"_$P(X,"(S)",2,299)
 F  Q:X'[" A "  S X=$P(X," A ",1)_" a "_$P(X," A ",2,229)
 I X["Class a" F  Q:X'["Class a"  S X=$P(X,"Class a",1)_"Class A"_$P(X,"Class a",2,229)
 I X["Type a" F  Q:X'["Type a"  S X=$P(X,"Type a",1)_"Type A"_$P(X,"Type a",2,229)
 F  Q:X'["'S"  S X=$P(X,"'S",1)_"'s"_$P(X,"'S",2,229)
 I X["mg Diet" F  Q:X'["mg Diet"  S X=$P(X,"mg Diet",1)_"MG Diet"_$P(X,"mg Diet",2,229)
 I X["LO-Fat" F  Q:X'["LO-Fat"  S X=$P(X,"LO-Fat",1)_"Lo-Fat"_$P(X,"LO-Fat",2,229)
 I $E(X,1)="'" S X="'"_$$LD($E(X,2,$L(X)))
 S X=$TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(X,2,$L(X))
 Q X
DICT ; get dictation from TIU completed
 N SRCT,SRL,SRNON,SRSTAT,SRSUM,SRTIU,SRTN,SROY,SRT
 S SRTN=IEN,SRNON=$S($P($G(^SRF(SRTN,"NON")),"^")="Y":1,1:0)
 S (SRSTAT,SRSUM)="" D STATUS I SRSTAT=7 K ^TMP("SRLQ",$J) D
 . S REC(130,SRTN,1.15,1)=SRSUM,REC(130,SRTN,1.15,2)="",SRCT=3
 . D TGET^TIUSRVR1(.SROY,SRTIU,"VIEW")
 . S SRT=0 F  S SRT=$O(@SROY@(SRT)) Q:SRT=""  D
 . . I $D(@SROY@(SRT))=10 S REC(130,SRTN,1.15,SRCT)=@SROY@(SRT,0)
 . . E  S REC(130,SRTN,1.15,SRCT)=@SROY@(SRT)
 . . S SRCT=SRCT+1
 . K @SROY
 Q
STATUS ; get status of summary in TIU
 I 'SRNON D  Q
 .S SRTIU=$P($G(^SRF(SRTN,"TIU")),"^") I SRTIU S SRSTAT=$$STATUS^SROESUTL(SRTIU) D
 ..I SRSTAT=7 S SRSUM=" * * The Operation Report has been electronically signed. * *"
 I SRNON D
 .S SRTIU=$P($G(^SRF(SRTN,"TIU")),"^",3) I SRTIU S SRSTAT=$$STATUS^SROESUTL(SRTIU) D
 ..I SRSTAT=7 S SRSUM=" * * The Procedure Report (Non-OR) has been electronically signed. * *" Q
 Q
