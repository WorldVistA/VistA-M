LEXRXR ;ISL/KER - Re-Index Lexicon - Reports ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757)           SACC 1.3
 ;    ^LEX(757.001)       SACC 1.3
 ;    ^LEX(757.01)        SACC 1.3
 ;    ^LEX(757.02)        SACC 1.3
 ;    ^LEX(757.1)         SACC 1.3
 ;    ^LEX(757.21)        SACC 1.3
 ;    ^LEXT(757.2)        SACC 1.3
 ;    ^TMP("LEXRXR",$J)   SACC 2.3.2.5.1
 ;    ^TMP("LEXRXRM",$J)  SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
 ;    $$S^%ZTLOAD         ICR  10063
 ;    ^DIC                ICR  10006
 ;    $$GET1^DIQ          ICR   2056
 ;    $$DT^XLFDT          ICR  10103
 ;    ^XMD                ICR  10070
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ; 
 ;     LEXBYTES   If set, the size in will be displayed in 
 ;                bytes (vs. MB, KB, GB)
 ;     LEXCAP     If set, the output will be displayed in a '^'
 ;                delimited string for import to a spreadsheet
 ;     LEXDOT     Include Dot leaders in display (this can be
 ;                set to any character)
 ;     LEXINS     Forces a copy of the report to be forwarded
 ;                the developer at G.LEXINS MailGroup
 ;     LEXTEST    Run in Test Mode
 ;               
ALL ; Reports (All)
 N ENV S ENV=$$ENV Q:+ENV'>0
 N X,Y,ZTQUEUED,ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTPRI,LEXMAIL,LEXTYPE,LEXTSK S LEXMAIL="",LEXTYPE="ALL"
 S ZTDESC="Lexicon - Data/Index report for All Files",ZTRTN="ALLT^LEXRXR",ZTPRI=4,ZTIO="",ZTDTH=$H
 S ZTSAVE("LEXMAIL")="",ZTSAVE("LEXTYPE")="",ZTSAVE("DUZ")="" S:$D(LEXINS) ZTSAVE("LEXINS")=""
 D:'$D(LEXTEST)&('$D(LEXCAP)) ^%ZTLOAD D:$D(LEXTEST)!($D(LEXCAP)) @ZTRTN
 K LEXTSK I +($G(ZTSK))>0 D
 . S LEXTSK(1)="Task #"_+($G(ZTSK))_" was created to report the number and sizes"
 . S LEXTSK(2)="of the data and indexes for the primary Lexicon files."
 . S LEXTSK(3)="When the task completes a message will be sent to you reporting the results."
 . D PR^LEXU(.LEXTSK,70) S LEXI=0 F  S LEXI=$O(LEXTSK(LEXI)) Q:+LEXI'>0  D
 . . S LEXC=$$TM($G(LEXTSK(LEXI))) W !,"  ",LEXC
 D HOME^%ZIS K ZTDESC,ZTDTH,ZTIO,ZTRTN W:+($G(ZTSK))>0&('$D(LEXINS)) ! H:+($G(ZTSK))>0&('$D(LEXINS)) 1
 Q
ALLT ; Reports (All) Tasked
 K ^TMP("LEXRXR",$J),^TMP("LEXRXRM",$J) D CON,FRE,EXP,COD,SEM,SUB
 D:$D(LEXMAIL)&('$D(LEXCAP)) MAIL D:'$D(LEXMAIL)!($D(LEXCAP)) MAILQ
 Q
 ;
 ; Reports
CON ;   Major Concept Map file #757 Report
 K ^TMP("LEXRXR",$J) K:'$D(LEXMAIL) ^TMP("LEXRXRM",$J)
 K:$D(LEXCAP) LEXTEST,LEXDOT K:$D(LEXTEST) LEXDOT S LEXFI=757 N LEXTC S LEXTC=$$UPD(LEXFI)
 S ^TMP("LEXRXR",$J,"IN","B")=$$NAM("B","Expression")
 D FILE(LEXFI)
 Q
FRE ;   Concept Usage file #757.001 Report
 K ^TMP("LEXRXR",$J) K:'$D(LEXMAIL) ^TMP("LEXRXRM",$J)
 K:$D(LEXCAP) LEXTEST,LEXDOT K:$D(LEXTEST) LEXDOT S LEXFI=757.001 N LEXTC S LEXTC=$$UPD(LEXFI)
 S ^TMP("LEXRXR",$J,"IN","B")=$$NAM("B","Major Concept")
 S ^TMP("LEXRXR",$J,"IN","AF")=$$NAM("AF","Frequency of Use")
 D FILE(LEXFI)
 Q
EXP ;   Expressions file #757.01 Report
 K ^TMP("LEXRXR",$J) K:'$D(LEXMAIL) ^TMP("LEXRXRM",$J)
 K:$D(LEXCAP) LEXTEST,LEXDOT K:$D(LEXTEST) LEXDOT S LEXFI=757.01
 N LEXTC S LEXTC=$$UPD(LEXFI)
 S ^TMP("LEXRXR",$J,"IN","B")=$$NAM("B","Expression") S ^TMP("LEXRXR",$J,"IN","ADC")=$$NAM("ADC","Deactivated IENs")
 S ^TMP("LEXRXR",$J,"IN","AH")=$$NAM("AH","SNOMED CT Hierarchy"),^TMP("LEXRXR",$J,"IN","APAR")=$$NAM("APAR","Parent Term")
 S ^TMP("LEXRXR",$J,"IN","ADTERM")=$$NAM("ADTERM","Deactivated Expressions") S ^TMP("LEXRXR",$J,"IN","AMC")=$$NAM("AMC","Major Concept Expressions")
 S ^TMP("LEXRXR",$J,"IN","ASL")=$$NAM("ASL","Token String Lengths") S ^TMP("LEXRXR",$J,"IN","AWRD")=$$NAM("AWRD","Words in an Expression")
 D FILE(LEXFI)
 Q
COD ;   Codes file #757.02 Report
 K ^TMP("LEXRXR",$J) K:'$D(LEXMAIL) ^TMP("LEXRXRM",$J)
 K:$D(LEXCAP) LEXTEST,LEXDOT K:$D(LEXTEST) LEXDOT S LEXFI=757.02 N LEXTC S LEXTC=$$UPD(LEXFI)
 S ^TMP("LEXRXR",$J,"IN","ACODE")=$$NAM("ACODE","Codes *") S ^TMP("LEXRXR",$J,"IN","ACT")=$$NAM("ACT","Code Activation Dates")
 S ^TMP("LEXRXR",$J,"IN","ADC")=$$NAM("ADC","Deactivated Entries *") S ^TMP("LEXRXR",$J,"IN","ADCODE")=$$NAM("ADCODE","Deactivated Code *")
 S ^TMP("LEXRXR",$J,"IN","ADX")=$$NAM("ADX","ICD-10-CM Diagnosis Codes") S ^TMP("LEXRXR",$J,"IN","AMC")=$$NAM("AMC","Code Major Concept")
 S ^TMP("LEXRXR",$J,"IN","APCODE")=$$NAM("APCODE","Preferred Term Flag") S ^TMP("LEXRXR",$J,"IN","APR")=$$NAM("APR","ICD-10-PCS Procedure Codes")
 S ^TMP("LEXRXR",$J,"IN","ASRC")=$$NAM("ASRC","Codes by Coding System") S ^TMP("LEXRXR",$J,"IN","AUPD")=$$NAM("AUPD","Date Coding System was Updated")
 S ^TMP("LEXRXR",$J,"IN","AVA")=$$NAM("AVA","VA Coding Systems") S ^TMP("LEXRXR",$J,"IN","B")=$$NAM("B","Code Expression")
 S ^TMP("LEXRXR",$J,"IN","CODE")=$$NAM("CODE","Codes") D FILE(LEXFI)
 Q
SEM ;   Semantic Map file #757.1 Report
 K ^TMP("LEXRXR",$J) K:'$D(LEXMAIL) ^TMP("LEXRXRM",$J)
 K:$D(LEXCAP) LEXTEST,LEXDOT K:$D(LEXTEST) LEXDOT S LEXFI=757.1 N LEXTC S LEXTC=$$UPD(LEXFI)
 S ^TMP("LEXRXR",$J,"IN","AMCC")=$$NAM("AMCC","Major Concept Semantic Class") S ^TMP("LEXRXR",$J,"IN","AMCT")=$$NAM("AMCT","Major Concept Semantic Type")
 S ^TMP("LEXRXR",$J,"IN","ASTT")=$$NAM("ASTT","Semantic Type Major Concept") S ^TMP("LEXRXR",$J,"IN","B")=$$NAM("B","Major Concept")
 D FILE(LEXFI)
 Q
SUB ;   Subset Report
 N LEXB,LEXD,LEXEXE,LEXFI,LEXFS,LEXIX,LEXM,LEXN,X K ^TMP("LEXRXR",$J)
 I $D(LEXCAP)!($D(LEXTEST)) S LEXEXE="K:$D(LEXCAP) LEXTEST,LEXDOT K:$D(LEXTEST) LEXDOT" X LEXEXE
 S LEXM=$E($G(LEXDOT),1) S:'$L(LEXM) LEXM=" " S:'$L($G(LEXDOT))&($D(LEXDOT)) LEXM="." S LEXFI=757.21,LEXFS=757.2
 N LEXTC S LEXTC=$$UPD(LEXFI) D SIN S X=$$RC(LEXFI),X=$$IC(LEXFI) D TN D:$L($O(^TMP("LEXRXR",$J,"IN",""))) HDR(LEXFI)
 S LEXIX="" F  S LEXIX=$O(^TMP("LEXRXR",$J,"IN",LEXIX)) Q:'$L(LEXIX)  D
 . S LEXN="" F  S LEXN=$O(^TMP("LEXRXR",$J,"IN",LEXIX,LEXN)) Q:'$L(LEXN)  D
 . . N LEXD,LEXB S LEXD=$P($G(^TMP("LEXRXR",$J,"IN",LEXIX,LEXN)),"^",1)
 . . S LEXB=$P($G(^TMP("LEXRXR",$J,"IN",LEXIX,LEXN)),"^",2) D LIN(LEXN,LEXD,LEXB)
 D:$L($O(^TMP("LEXRXR",$J,"IN",""))) TT D:$D(LEXTEST)!('$D(LEXMAIL)) SM K ^TMP("LEXRXR",$J)
 Q
 ;
 ; Miscellaneous
FILE(X) ;   Process File #X
 N LEXBTS,LEXD,LEXDAT,LEXDB,LEXDN,LEXDR,LEXFI,LEXI,LEXIB,LEXIN,LEXIR,LEXIX,LEXNAM,LEXNDS,LEXTB,LEXTN
 S LEXFI=+($G(X)) Q:'$D(^LEX(+LEXFI,0))
 S LEXD=$$RC(LEXFI),LEXDR=+LEXD,LEXDN=$P(LEXD,"^",2),LEXDB=$P(LEXD,"^",3) S LEXTN=+($G(LEXTN))+LEXDN,LEXTB=+($G(LEXTB))+LEXDB
 S LEXI=$$IC(LEXFI),LEXIR=+LEXI,LEXIN=$P(LEXI,"^",2),LEXIB=$P(LEXI,"^",3) S LEXTN=+($G(LEXTN))+LEXIN,LEXTB=+($G(LEXTB))+LEXIB
 D:$L($O(^TMP("LEXRXR",$J,"IN",""))) HDR(LEXFI)
 S LEXIX="" F  S LEXIX=$O(^TMP("LEXRXR",$J,"IN",LEXIX)) Q:'$L(LEXIX)  D
 . N LEXNAM,LEXDAT,LEXNDS,LEXBTS S LEXNAM=$O(^TMP("LEXRXR",$J,"IN",LEXIX,"")) Q:'$L(LEXNAM)
 . S LEXDAT=$G(^TMP("LEXRXR",$J,"IN",LEXIX,LEXNAM)),LEXNDS=$P(LEXDAT,"^",1),LEXBTS=$P(LEXDAT,"^",2) D LIN(LEXNAM,LEXNDS,LEXBTS)
 D TN D:$L($O(^TMP("LEXRXR",$J,"IN",""))) TT D:$D(LEXTEST)!('$D(LEXMAIL)) SM
 K ^TMP("LEXRXR",$J) K:'$D(LEXMAIL) ^TMP("LEXRXRM",$J)
 Q
HDR(X) ;     File Header
 N LEXFI,LEXFN,LEXT S LEXFI=+($G(X)) I $D(^LEX(+LEXFI)) D
 . N LEXFN,LEXT S LEXFN=$P($G(^LEX(LEXFI,0)),"^",1) Q:'$L(LEXFN)
 . S LEXT=" "_LEXFN,LEXT=LEXT_$J(" ",(30-$L(LEXT)))_"File #"_LEXFI D BL,TL(LEXT)
 S LEXT=" Component",LEXT=LEXT_$J(" ",(47-$L(LEXT)))_$J("Nodes",10)_"    "_$J("Size",10) D BL,TL(LEXT)
 S LEXT=" ------------------------------------",LEXT=LEXT_$J(" ",(47-$L(LEXT)))_$J("--------",10)_"    "_$J("------",10) D TL(LEXT)
 Q
RC(X) ;     Record Counts
 N LEXB,LEXC,LEXFI,LEXN,LEXNAM,LEXNC,LEXNN,LEXR S LEXFI=+($G(X)) Q:LEXFI'>0 ""  Q:'$D(^LEX(+LEXFI,0)) ""
 S (LEXR,LEXB,LEXN,LEXC)=0 F  S LEXR=$O(^LEX(+LEXFI,LEXR)) Q:+LEXR'>0  D
 . N LEXNN,LEXNC S LEXNN="^LEX("_+LEXFI_","_+LEXR_")",LEXNC="^LEX("_LEXFI_","_+LEXR_"," S LEXC=LEXC+1
 . F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . . S LEXN=+($G(LEXN))+1 S LEXB=((+($G(LEXB))+$L(LEXNN))+$L(@LEXNN))+1
 S LEXNAM="Total Data Nodes" S:+LEXC>0 LEXNAM=LEXNAM_" ("_+LEXC_" Record"_$S(+LEXC>1:"s",1:"")_")"
 K ^TMP("LEXRXR",$J,"TD") S X=LEXC_"^"_LEXN_"^"_LEXB,^TMP("LEXRXR",$J,"TD",LEXNAM)=X
 I $D(LEXTEST) W !,LEXNAM,?47,$J(LEXN,8),?58,$J($G(LEXB),10),$S(+($G(LEXB))>0:" b",1:"")
 Q X
IC(X) ;     Index Counts
 N LEXB,LEXC,LEXFI,LEXIB,LEXIN,LEXIX,LEXN,LEXNAM,LEXNB,LEXNC,LEXNN S LEXFI=+($G(X)) Q:+LEXFI'>0 ""  Q:'$D(^LEX(+LEXFI,0)) ""
 S (LEXC,LEXN,LEXB)=0,LEXIX="A" F  S LEXIX=$O(^LEX(LEXFI,LEXIX)) Q:'$L(LEXIX)  D
 . N LEXTMP S LEXTMP=$$UPD(LEXFI,LEXIX)
 . Q:$E(LEXIX,1)'?1U  S LEXC=LEXC+1 N LEXIB,LEXIN,LEXNAM,LEXNN,LEXNC S (LEXIN,LEXIB)=0
 . S LEXNAM=$G(^TMP("LEXRXR",$J,"IN",LEXIX)) S:'$L(LEXNAM) LEXNAM=$$NAM(LEXIX,"Unknown")
 . S LEXNN="^LEX("_+LEXFI_","""_LEXIX_""")" S LEXNC="^LEX("_+LEXFI_","""_LEXIX_""","
 . F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . . N LEXNB S LEXIN=LEXIN+1,LEXN=LEXN+1,LEXNB=(+$L(LEXNN)+$L(@LEXNN))+1 S LEXB=+($G(LEXB))+LEXNB,LEXIB=+($G(LEXIB))+LEXNB
 . K ^TMP("LEXRXR",$J,"IN",LEXIX) S ^TMP("LEXRXR",$J,"IN",LEXIX,LEXNAM)=LEXIN_"^"_+($G(LEXIB))
 . W:$D(LEXTEST) !,?1,LEXNAM,?47,$J(LEXIN,8),?58,$J($G(LEXIB),10),$S(+($G(LEXIB))>0:" b",1:"")
 S LEXNAM="Total Index Nodes" S:+LEXC>0 LEXNAM=LEXNAM_" ("_LEXC_$S(LEXC>1:" Indexes",1:" Index")_")"
 K ^TMP("LEXRXR",$J,"TI") S X=LEXC_"^"_LEXN_"^"_LEXB,^TMP("LEXRXR",$J,"TI",LEXNAM)=X
 I $D(LEXTEST) W !," ",LEXNAM,?47,$J(LEXN,8),?58,$J($G(LEXB),10),$S(+($G(LEXB))>0:" b",1:"")
 Q X
TN ;     Total Nodes/Bytes
 N LEXB,LEXD,LEXN,LEXS S (LEXN,LEXB)=0
 S LEXS=$O(^TMP("LEXRXR",$J,"TI","")) I $L(LEXS) S LEXD=$G(^TMP("LEXRXR",$J,"TI",LEXS)),LEXN=LEXN+$P(LEXD,"^",2),LEXB=LEXB+$P(LEXD,"^",3)
 S LEXS=$O(^TMP("LEXRXR",$J,"TD","")) I $L(LEXS) S LEXD=$G(^TMP("LEXRXR",$J,"TD",LEXS)),LEXN=LEXN+$P(LEXD,"^",2),LEXB=LEXB+$P(LEXD,"^",3)
 S ^TMP("LEXRXR",$J,"TT","Total Data/Index Nodes")=LEXN_"^"_LEXB
 Q
TT ;     Totals
 N LEXBTS,LEXDAT,LEXNAM,LEXNDS D BL
 S LEXNAM=$O(^TMP("LEXRXR",$J,"TI","")) I $D(LEXNAM) D
 . S LEXDAT=$G(^TMP("LEXRXR",$J,"TI",LEXNAM)),LEXNDS=$P(LEXDAT,"^",2),LEXBTS=$P(LEXDAT,"^",3) D LIN(LEXNAM,LEXNDS,LEXBTS)
 S LEXNAM=$O(^TMP("LEXRXR",$J,"TD","")) I $D(LEXNAM) D
 . S LEXDAT=$G(^TMP("LEXRXR",$J,"TD",LEXNAM)),LEXNDS=$P(LEXDAT,"^",2),LEXBTS=$P(LEXDAT,"^",3) D LIN(LEXNAM,LEXNDS,LEXBTS)
 S LEXNAM=$O(^TMP("LEXRXR",$J,"TT","")) I $D(LEXNAM) D
 . S LEXDAT=$G(^TMP("LEXRXR",$J,"TT",LEXNAM)),LEXNDS=$P(LEXDAT,"^",1),LEXBTS=$P(LEXDAT,"^",2) D LIN(LEXNAM,LEXNDS,LEXBTS)
 Q
NAM(X,Y) ;     Name
 N LEXI,LEXN S LEXI=$G(X) S:$E(LEXI,1)'?1U LEXI="" S:$L(LEXI)&($E(LEXI,1)?1U) LEXI=""""_LEXI_""""
 S LEXN=$G(Y) S:$L(LEXI) LEXI=LEXI_$J(" ",11-$L(LEXI)) S X=LEXI_LEXN
 Q X
SIN ;     Subset Names
 N LEXFI,LEXFS,LEXIX,LEXSB,LEXSI,LEXST S LEXFI=757.21,LEXFS=757.2,LEXIX="A"
 F  S LEXIX=$O(^LEX(LEXFI,LEXIX)) Q:'$L(LEXIX)  D
 . I LEXIX="B" S ^TMP("LEXRXR",$J,"IN",LEXIX)=$$NAM(LEXIX,"Expression IEN") Q
 . I LEXIX="C" S ^TMP("LEXRXR",$J,"IN",LEXIX)=$$NAM(LEXIX,"Expression Text") Q
 . N LEXSB,LEXSI,LEXST S LEXSB=LEXIX S LEXSB=$E(LEXSB,2,4) Q:'$L(LEXSB)
 . S LEXSI=$O(^LEXT(LEXFS,"AA",LEXSB,0)),LEXST=$$MIX^LEXXM($P($G(^LEXT(LEXFS,+LEXSI,0)),"^",1))
 . S ^TMP("LEXRXR",$J,"IN",LEXIX)=$$NAM(LEXIX,LEXST)
 Q
LIN(X,Y,Z) ;   Line (format name, nodes, size)
 N LEXBT,LEXM,LEXND,LEXNM,LEXSIZ,LEXT S LEXNM=$G(X),LEXND=+($G(Y)),LEXBT=$G(Z),LEXSIZ=$$SIZ(LEXBT),LEXT=""
 I $D(LEXCAP) S LEXT=LEXNM_"^"_LEXND S:$D(LEXBYTES) LEXT=LEXT_"^"_LEXBT S:'$D(LEXCAP) LEXT=LEXT_"^"_LEXSIZ D TL(LEXT) Q
 S LEXM=$E($G(LEXDOT),1) S:'$L(LEXM) LEXM=" " S:'$L($G(LEXDOT))&($D(LEXDOT)) LEXM="."
 S LEXT=" "_LEXNM S:($L(LEXT)#2)'>0 LEXT=LEXT_" " F  Q:$L(LEXT)>47  S LEXT=LEXT_" "_$G(LEXM)
 S:$L(LEXND)=7 LEXT=LEXT_" " S:$L(LEXND)=6 LEXT=LEXT_"  " S:$L(LEXND)=5 LEXT=LEXT_" "_$G(LEXM)_" " S:$L(LEXND)=4 LEXT=LEXT_" "_$G(LEXM)_"  "
 S:$L(LEXND)=3 LEXT=LEXT_" "_$G(LEXM)_" "_$G(LEXM)_" " S:$L(LEXND)=2 LEXT=LEXT_" "_$G(LEXM)_" "_$G(LEXM)_"  "
 S:$L(LEXND)=1!($L(LEXND)'>0) LEXT=LEXT_" "_$G(LEXM)_" "_$G(LEXM)_" "_$G(LEXM)_" " S LEXT=LEXT_LEXND
 S LEXT=LEXT_$J(" ",(61-$L(LEXT))) S:$D(LEXBYTES) LEXT=LEXT_$J(LEXBT,10) S:'$D(LEXBYTES) LEXT=LEXT_$J(LEXSIZ,10) D TL(LEXT)
 Q
BL(X) ;     Blank Line
 D TL(" ")
 Q
TL(X) ;     Text Line
 N LEXI S LEXI=$O(^TMP("LEXRXRM",$J," "),-1)+1
 S ^TMP("LEXRXRM",$J,+LEXI)=$G(X),^TMP("LEXRXRM",$J,0)=LEXI
 Q
SIZ(X) ;     Size
 N NUM,SUF S SUF=" B ",NUM=+($G(X)) Q:NUM'>0 ""  Q:$D(LEXBYTES) NUM
 Q:NUM'>1024&($D(LEXCAP)) (NUM_"^B") Q:NUM'>1024 (NUM_SUF)
 S SUF=" KB",NUM=NUM/1024,NUM=$FN(NUM,"",0) Q:NUM'>1024&($D(LEXCAP)) (NUM_"^KB") Q:NUM'>1024 (NUM_SUF)
 S SUF=" MB",NUM=NUM/1024,NUM=$FN(NUM,"",0) Q:NUM'>1024&($D(LEXCAP)) (NUM_"^MB") Q:NUM'>1024 (NUM_SUF)
 S SUF=" GB",NUM=NUM/1024,NUM=$FN(NUM,"",0) Q:NUM'>1024&($D(LEXCAP)) (NUM_"^GB") Q:NUM'>1024 (NUM_SUF)
 Q (NUM_"   ")
SM ;   Show Message
 W !! N LEXI S LEXI=0 F  S LEXI=$O(^TMP("LEXRXRM",$J,+LEXI)) Q:+LEXI'>0  W !,$G(^TMP("LEXRXRM",$J,+LEXI))
 Q
ST ;   Show Message
 N LEXNN,LEXNC S LEXNN="^TMP(""LEXRXR"","_$J_")",LEXNC="^TMP(""LEXRXR"","_$J_"," W:$D(^TMP("LEXRXR",$J)) !
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  W !,LEXNN,"=",@LEXNN
 Q
MAIL ;   MailMan
 G:$D(LEXCAP) MAILQ N DIFROM,XCNP,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,LEXADR,LEXUSR,LEXTC,Y
 S LEXADR="" S LEXTC=$$UPD(3.9) G:'$D(^TMP("LEXRXRM",$J)) MAILQ G:+($G(^TMP("LEXRXRM",$J,0)))=0 MAILQ K XMZ N DIFROM
 S XMSUB="Lexicon Data/Index Nodes and Size" K XMY S:+($G(DUZ))>0 XMY(+($G(DUZ)))=""
 S LEXUSR=$$USR(+($G(DUZ))) S:$L(LEXUSR) XMY(LEXUSR)=""
 S:$D(LEXINS) LEXADR=$$ADR S:$L(LEXADR) XMY(("G.LEXINS@"_LEXADR))="" G:'$D(XMY) MAILQ
 S XMTEXT="^TMP(""LEXRXRM"",$J,",XMDUZ=.5 D ^XMD I '$D(ZTQUEUED),+($G(XMZ))>0 D
 . W !!," 'Lexicon Data/Index Nodes and Size' message (#",+($G(XMZ)),") sent"
MAILQ ;     End of MailMan message
 K ^TMP("LEXRXR",$J),^TMP("LEXRXRM",$J) K DIFROM,XCNP,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,LEXSUB,X,Y N LEXINS
 Q
ADR(LEX) ;     MailMan Address - G.LEXINS@DOMAIN.EXT
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="FO-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 S DIC="^DIC(4.2,",DIC(0)="M",(LEX,X)="ISC-SLC.DOMAIN.EXT" D ^DIC Q:+Y>0 LEX
 Q "ISC-SLC.DOMAIN.EXT"
UPD(X,Y) ;     Update Task ^%ZTSK
 N LEXFI,LEXNM,LEXDES,LEXDEF,LEXIX S LEXFI=+($G(X)),LEXIX=$G(Y),LEXNM="" S X=0
 S LEXDEF="" S:$G(LEXTYPE)="ALL" LEXDEF="Lexicon - Data/Index report for All Files"
 I LEXFI=3.9 S LEXNM="MailMan",LEXDES="Lexicon - Sending MailMan message"
 I $P(LEXFI,".",1)="757" D
 . S LEXNM=$P($G(^LEX(LEXFI,0)),"^",1) Q:'$L(LEXNM)  S LEXNM=LEXNM_" file #"_LEXFI
 . S:$L(LEXIX)&($E(LEXIX,1)?1U) LEXNM=LEXNM_" """_LEXIX_""""
 . S LEXDES="Lexicon - Checking "_LEXNM
 I $D(ZTQUEUED) S:$L(LEXNM) X=$$S^%ZTLOAD(LEXDES) S:'$L(LEXNM)&($L(LEXDEF)) X=$$S^%ZTLOAD(LEXDEF)
 Q X
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
ENV(X) ;   Environment
 D HOME^%ZIS S U="^",DT=$$DT^XLFDT,DTIME=300 K POP N NM S NM=$$USR+($G(DUZ))
 I '$L(NM) W !!,?5,"Invalid/Missing DUZ" N LEXBYTES,LEXCAP Q 0
 Q 1
USR(X) ;   User Name
 Q:+($G(X))'>0 ""
 Q $$GET1^DIQ(200,(+($G(X))_","),.01)
