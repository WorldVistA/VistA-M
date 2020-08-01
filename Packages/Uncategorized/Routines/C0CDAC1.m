C0CDAC1 ; GPL - Patient Portal - CCDA Template Routines ;8/29/13  17:05
 ;;0.1;C0CDA;nopatch;noreleasedate;Build 1
 ;
 ; License AGPL v3.0
 ; 
 ; This software was funded in part by Oroville Hospital, and was
 ; created with help from Oroville's doctors and staff.
 ;
 Q
 ;
FILEIN ; import the valueset xml file, parse with MXML, and put the dom in ^TMP
 ;
 N FNAME,DIRNAME
 W !,"Please enter the directory and file name for the NLM Valueset XML file"
 Q:'$$GETDIR(.DIRNAME,"/home/vista") ; prompt the user for the directory
 Q:'$$GETFN(.FNAME,"toc.xml") ; prompt user for filename
 N GN S GN=$NA(^KBAI("CCDA","PARTNERS")) ; root to store xml and dom
 K @GN ; clear the area
 N GN1 S GN1=$NA(@GN@("XML",1)) ; place to put the xml file
 W !,"Reading in file ",FNAME," from directory ",DIRNAME
 Q:$$FTG^%ZISH(DIRNAME,FNAME,GN1,4)=""
 N KBAIDID
 W !,"Parsing file ",FNAME
 S KBAIDID=$$EN^MXMLDOM($NA(@GN@("XML")),"W")
 I KBAIDID=0 D  Q  ;
 . ZWRITE ^TMP("MXMLERR",$J,*)
 W !,"Merging MXMLDOM to TMP"
 M @GN@("DOM")=^TMP("MXMLDOM",$J,KBAIDID)
 K ^TMP("MXMLDOM",$J)
 Q
 ;
GETDIR(KBAIDIR,KBAIDEF) ; extrinsic which prompts for directory
 ; returns true if the user gave values
 S DIR(0)="F^3:240"
 S DIR("A")="File Directory"
 I '$D(KBAIDEF) S KBAIDEF="/home/vista/"
 S DIR("B")=KBAIDEF
 D ^DIR
 I Y="^" Q 0 ;
 S KBAIDIR=Y
 Q 1
 ;
GETFN(KBAIFN,KBAIDEF) ; extrinsic which prompts for filename
 ; returns true if the user gave values
 S DIR(0)="F^3:240"
 S DIR("A")="File Name"
 I '$D(KBAIDEF) S KBAIDEF="toc.xml"
 S DIR("B")=KBAIDEF
 D ^DIR
 I Y="" Q 0 ;
 I Y="^" Q 0 ;
 S KBAIFN=Y
 Q 1
 ;
WKSPACE(ZWHERE) ; extrinsic that returns a workspace global reference
 ; ZWHERE IS PASSED BY VALUE AND HAS FORMAT PROJECT:SPACE:TOPIC
 N ZDIR,ZPROJ,ZSPACE,ZPROJ,ZTOPIC,ZFILE,ZROOT,ZTARG
 S ZROOT=$NA(^KBAI)
 S ZPROJ=$P(ZWHERE,":",1)
 S ZSPACE=$P(ZWHERE,":",2)
 S ZTOPIC=$P(ZWHERE,":",3)
 S ZTARG=$NA(@ZROOT@(ZPROJ,ZSPACE,ZTOPIC))
 Q ZTARG
 ;
tree(where,prefix,docid) ; show a tree starting at a node in MXML.
 ; 
 i $g(prefix)="" s prefix="|--" ; starting prefix
 ;n node s node=$na(^KBAI("CCDA","TOC","DOM",where))
 n node s node=$na(^TMP("MXMLDOM",$J,docid,where))
 n txt s txt=$$CLEAN($$ALLTXT(node))
 w !,prefix_@node_" "_txt
 n zi s zi=""
 f  s zi=$o(@node@("A",zi)) q:zi=""  d  ;
 . w !,prefix_"  : "_zi_"^"_$g(@node@("A",zi))
 f  s zi=$o(@node@("C",zi)) q:zi=""  d  ;
 . d tree(zi,"|  "_prefix,docid)
 q
 ;
show(what) ;
 I '$D(C0XJOB) S C0XJOB=$J
 d tree(what)
 q
 ; 
tree2(where,prefix,root,zout) ; show a tree starting at a node in MXML. 
 ; node is passed by name
 ; 
 i $g(prefix)="" s prefix="|--" ; starting prefix
 i '$d(KBAIJOB) s KBAIJOB=$J
 i '$d(root) s root=$na(^TMP("MXMLDOM",1))
 n node s node=$na(@root@(where))
 n txt s txt=$$CLEAN($$ALLTXT(node))
 w !,where," ",prefix_@node_" "_txt
 d oneout(zout,where_prefix_@node_" "_txt)
 n zi s zi=""
 f  s zi=$o(@node@("A",zi)) q:zi=""  d  ;
 . w !,where," ",prefix_"  : "_zi_"^"_$g(@node@("A",zi))
 . d oneout(zout,where_prefix_"  : "_zi_"^"_$g(@node@("A",zi)))
 f  s zi=$o(@node@("C",zi)) q:zi=""  d  ;
 . d tree2(zi,"|  "_prefix,root,zout)
 q
 ;
oneout(zbuf,ztxt) ; adds a line to zbuf
 n zi s zi=$o(@zbuf@(""),-1)+1
 s @zbuf@(zi)=ztxt
 q
 ;
go ; 
 d mktemp2^C0CDAC1("advanceDirective",213,219)
 d mktemp2^C0CDAC1("reasonForVisit",319,325)
 d mktemp2^C0CDAC1("familyHistory",326,332)
 d mktemp2^C0CDAC1("functionalStatus",333,338)
 d mktemp2^C0CDAC1("instructions",363,370)
 d mktemp2^C0CDAC1("planOfCare",876,882)
 d mktemp2^C0CDAC1("reasonForReferral",1332,1338)
 q
 ;
 ;mktemp2(zrtn,zbeg,zend,zname) ; create an xml template out of the MXML dom
mktemp2(zname,zbeg,zend,zrtn) ; create an xml template out of the MXML dom
 ; at docid beginning with zbeg and ending with zend, both nodes passed by
 ; value. zrtn is passed by name.
 I '$D(zrtn) S zrtn="GPL" K GPL
 N GN S GN=$NA(^TMP("MXMLDOM",$J,1))
 K @GN
 M @GN=^KBAI("CCDA","TOC","DOM")
 D OUTXML(zrtn,1,zbeg,zend)
 N GTMP S GTMP=$NA(^TMP("JJOHXML",$J))
 K @GTMP
 M @GTMP=@zrtn
 N ZDOC S ZDOC=$$PARSE(GTMP)
 I $D(^TMP("MXMLERR",$J)) D  B  ;
 . ZWR ^TMP("MXMLERR",$J,*)
 W $$GTF^%ZISH($na(@GTMP@(1)),3,"/home/vista/",zname_".temp")
 K @GTMP
 D tree(1,,ZDOC)
 K ^TMP("MXMLDOM",$J,ZDOC)
 Q
 ;
PARSE(INXML,INDOC) ;CALL THE MXML PARSER ON INXML, PASSED BY NAME
 ; EXTRINSIC WHICH RETURNS THE DOCID ASSIGNED BY MXML
 Q $$EN^MXMLDOM(INXML,"W")
 ;
mktemp(zname,zbeg,zend,root) ; create a template named zname
 ; beginning at node zbeg and ending at node zend of root
 ; root is passed by name, all others passed by value
 ;
 ;i '$d(root) s root=$na(^KBAI("CCDA","PARTNERS","DOM"))
 i '$d(root) s root=$na(^KBAI("CCDA","TOC","DOM"))
 n zg s zg=$na(^KBAI("TEMPLATE",zname,"DOM")) ; place to put the template
 s @zg@("created")=$$NOW^XLFDT
 n zii s zii=$o(@root@(zbeg),-1)
 n zn s zn=0
 f  s zii=$o(@root@(zii)) q:+zii>zend  d  ;
 . s zn=zn+1
 . m @zg@(zn)=@root@(zii)
 q
 ;
showtemp(zname,root) ; display a template stored at root (passed by name)
 ;
 i '$d(root) s root=$na(^KBAI("TEMPLATE",zname,"DOM"))
 i '$d(@root@(1)) d  q  ;
 . w !,"Error, template ",zname," does not exist"
 n out s out=$na(^TMP("CCDAOUT2",$J))
 d tree2(1,,root,out)
 D BROWSE^DDBR(out,"N","Transfer of Care CCDA")
 k @out
 q
 ;
ALLTXT(where) ; extrinsic returns concatinated all text lines from the node 
 ;
 n zti s zti=""
 n ztr s ztr=""
 f  s zti=$o(@where@("T",zti)) q:zti=""  d  ;
 . s ztr=ztr_$g(@where@("T",zti))
 q ztr
 ;
CLEAN(STR) ; extrinsic function; returns string
 ;; Removes all non printable characters from a string.
 ;; STR by Value
 N TR,I
 F I=0:1:31 S TR=$G(TR)_$C(I)
 S TR=TR_$C(127)
 N ZR S ZR=$TR(STR,TR)
 S ZR=$$LDBLNKS(ZR) ; get rid of leading blanks
 QUIT ZR
 ;
LDBLNKS(st) ; extrinsic which removes leading blanks from a string
 n pos f pos=1:1:$l(st)  q:$e(st,pos)'=" "
 q $e(st,pos,$l(st))
 ;
toc ; display the Transfer of Care sample xml
 n gn s gn=$na(^KBAI("CCDA","TOC","DOM"))
 n out s out=$na(^TMP("CCDAOUT",$J))
 d tree2(1,,gn,out)
 D BROWSE^DDBR(out,"N","Transfer of Care CCDA")
 k @out
 q
 ;
partners ; display the partners healthcare sample xml
 n gn s gn=$na(^KBAI("CCDA","PARTNERS","DOM"))
 n out s out=$na(^TMP("CCDAOUT",$J))
 d tree2(1,,gn,out)
 D BROWSE^DDBR(out,"N","Partners Healthcare sample CCDA")
 k @out
 q
 ;
ISMULT(ZOID) ; RETURN TRUE IF ZOID IS ONE OF A MULTIPLE
 N ZN
 ;I $$TAG(ZOID)["entry" B
 S ZN=$$NXTSIB(ZOID)
 I ZN'="" Q $$TAG(ZOID)=$$TAG(ZN) ; IF TAG IS THE SAME AS NEXT SIB TAG
 Q 0
 ;
FIRST(ZOID) ;RETURNS THE OID OF THE FIRST CHILD OF ZOID
 Q $$CHILD^MXMLDOM(JJOHDOC,ZOID)
 ;
PARENT(ZOID) ;RETURNS THE OID OF THE PARENT OF ZOID
 Q $$PARENT^MXMLDOM(JJOHDOC,ZOID)
 ;
ATT(RTN,NODE) ;GET ATTRIBUTES FOR ZOID
 S HANDLE=JJOHDOC
 K @RTN
 D GETTXT^MXMLDOM("A")
 Q
 ;
TAG(ZOID) ; RETURNS THE XML TAG FOR THE NODE
 N X,Y
 S Y=""
 S X=$G(C0CCBK("TAG")) ;IS THERE A CALLBACK FOR THIS ROUTINE
 I X'="" X X ; EXECUTE THE CALLBACK, SHOULD SET Y
 I Y="" S Y=$$NAME^MXMLDOM(JJOHDOC,ZOID)
 Q Y
 ;
NXTSIB(ZOID) ; RETURNS THE NEXT SIBLING
 Q $$SIBLING^MXMLDOM(JJOHDOC,ZOID)
 ;
DATA(ZT,ZOID) ; RETURNS DATA FOR THE NODE
 ;N ZT,ZN S ZT=""
 ;S C0CDOM=$NA(^TMP("MXMLDOM",$J,JJOHDOC))
 ;Q $G(@C0CDOM@(ZOID,"T",1))
 S ZN=$$TEXT^MXMLDOM(JJOHDOC,ZOID,ZT)
 Q
 ;
OUTXML(ZRTN,INID,ZBEG,ZEND) ; USES MXMLBLD TO OUTPUT XML FROM AN MXMLDOM
 ; ZBEG AND ZEND ARE PASSED BY VALUE AND DEFINE A RANGE OF NODES TO OUTPUT
 ; ZRTN IS PASSED BY NAME. INID IS PASSED BY VALUE AND IS THE DOCID OF THE DOM
 ;
 I '$D(ZBEG) S ZBEG=1
 I '$D(ZEND) S ZEND=$O(^TMP("MXMLDOM",$J,INID,""),-1) ; LAST NODE
 S JJOHDOC=INID
 D START^MXMLBLD($$TAG(ZBEG),,"G")
 N ZMAX S ZMAX=ZEND
 D NDOUT2($$FIRST(ZBEG),ZMAX)
 D END^MXMLBLD ;END THE DOCUMENT
 M @ZRTN=^TMP("MXMLBLD",$J)
 K ^TMP("MXMLBLD",$J)
 Q
 ;
NDOUT(ZOID) ;CALLBACK ROUTINE - IT IS RECURSIVE
 N ZI S ZI=$$FIRST(ZOID)
 I ZI'=0 D  ; THERE IS A CHILD
 . N ZATT D ATT("ZATT",ZOID) ; THESE ARE THE ATTRIBUTES MOVED TO ZATT
 . D MULTI^C0CMXMLB("",$$TAG(ZOID),.ZATT,"NDOUT^C0CDAC1(ZI)") ;HAVE CHILDREN
 E  D  ; NO CHILD - IF NO CHILDREN, A NODE HAS DATA, IS AN ENDPOINT
 . ;W "DOING",ZOID,!
 . N ZD D DATA("ZD",ZOID) ;NODES WITHOUT CHILDREN HAVE DATA
 . N ZATT D ATT("ZATT",ZOID) ;ATTRIBUTES
 . D ITEM^MXMLBLD("",$$TAG(ZOID),.ZATT,$G(ZD(1))) ;NO CHILDREN
 I $$NXTSIB(ZOID)'=0 D  ; THERE IS A SIBLING
 . D NDOUT($$NXTSIB(ZOID)) ;RECURSE FOR SIBLINGS
 Q
 ;
NDOUT2(ZOID,MAX) ;CALLBACK ROUTINE - IT IS RECURSIVE
 ; MAX IS A LIMITER NODE FOR PROCESSING CHILDREN
 N ZI S ZI=$$FIRST(ZOID)
 I ZI'=0 D  ; THERE IS A CHILD
 . I ZI>MAX Q  ; do not go beyond the MAX node
 . N ZATT D ATT("ZATT",ZOID) ; THESE ARE THE ATTRIBUTES MOVED TO ZATT
 . D MULTI^MXMLBLD("",$$TAG(ZOID),.ZATT,"NDOUT2^C0CDAC1(ZI,MAX)") ;CHILDREN
 E  D  ; NO CHILD - IF NO CHILDREN, A NODE HAS DATA, IS AN ENDPOINT
 . ;W "DOING",ZOID,!
 . N ZD D DATA("ZD",ZOID) ;NODES WITHOUT CHILDREN HAVE DATA
 . N ZATT D ATT("ZATT",ZOID) ;ATTRIBUTES
 . D ITEM^MXMLBLD("",$$TAG(ZOID),.ZATT,$G(ZD(1))) ;NO CHILDREN
 I $$NXTSIB(ZOID)'=0 D  ; THERE IS A SIBLING
 . I $$NXTSIB(ZOID)>MAX Q  ; don't go beyond the max
 . D NDOUT2($$NXTSIB(ZOID),MAX) ;RECURSE FOR SIBLINGS
 Q
 ;
