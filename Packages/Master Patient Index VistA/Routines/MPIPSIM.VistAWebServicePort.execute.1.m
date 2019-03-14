 ;MPIPSIM.VistAWebServicePort.execute.1
 ;(C)InterSystems, generated for class MPIPSIM.VistAWebServicePort.execute.  Do NOT edit. 03/14/2019 02:01:35PM
 ;;36543374;MPIPSIM.VistAWebServicePort.execute
 ;
%NormalizeObject() public {
	If '$system.CLS.GetModified() Quit 1
	If m%%RequestName Set:i%%RequestName'="" i%%RequestName=(..%RequestNameNormalize(i%%RequestName))
	If m%%Result Set:i%%Result'="" i%%Result=(..%ResultNormalize(i%%Result))
	If m%%result12 Set:i%%result12'="" i%%result12=(..%result12Normalize(i%%result12))
	If m%requestXML Set:i%requestXML'="" i%requestXML=(..requestXMLNormalize(i%requestXML))
	Quit 1 }
%ValidateObject(force=0,checkserial=1) public {
	set sc=1
	If '$system.CLS.GetModified() Quit sc
	If m%%RequestName Set iv=..%RequestName If iv'="" Set rc=(..%RequestNameIsValid(iv)) If ('rc) Set sc=$$EmbedErr^%occSystem(sc,rc,5802,"%RequestName",iv)
	If m%%Result Set iv=..%Result If iv'="" Set rc=(..%ResultIsValid(iv)) If ('rc) Set sc=$$EmbedErr^%occSystem(sc,rc,5802,"%Result",iv)
	If m%%result12 Set iv=..%result12 If iv'="" Set rc=(..%result12IsValid(iv)) If ('rc) Set sc=$$EmbedErr^%occSystem(sc,rc,5802,"%result12",iv)
	If m%requestXML Set iv=..requestXML If iv'="" Set rc=(..requestXMLIsValid(iv)) If ('rc) Set sc=$$EmbedErr^%occSystem(sc,rc,5802,"requestXML",iv)
	Quit sc }
zInvoke(%Client,%Action,requestXML) public {
 Set ..requestXML=$get(requestXML)
 Do %Client.InvokeClient($this,"execute",%Action)
 Quit ..%Result }
zNeedsAdjustment(ResultName) public {
 Set ResultName="responseXML"
 Quit 1 }
zReset() public {
 Quit }
zXMLDTD(top,format,input,dtdlist)
 Quit ##class(%XML.Implementation).XMLDTD("MPIPSIM.VistAWebServicePort.execute",.top,.format,.input,.dtdlist)
zXMLExportInternal()
 New tag,summary,attrsVal,savelocal,aval,k,tmpPrefix,prefixDepth,hasNoContent,hasElement,topAttrs,beginprefix,endprefix,savexsiAttrs,initialxsiAttrs,initlist,initialCR,inlineFlag,popAtEnd,saveTopPrefix,saveTypesPrefix,saveAttrsPrefix,saveUsePrefix,initlist
 Set $ztrap="XMLExportInternalTrap",popAtEnd=0
 If 'encoded Quit $$Error^%apiOBJ(6231,fmt)
 Set summary=summaryArg,initialxsiAttrs=xsiAttrs
 If group Quit $$Error^%apiOBJ(6386,"MPIPSIM.VistAWebServicePort.execute")
 If indentFlag Set initialCR=($extract(currentIndent,1,2)=$c(13,10))
 Set id=createId
 Set temp=""
 If id'="" {
   If $piece($get(idlist(+$this)),",",2)'="" Quit 1
   Set idlist(+$this)=id_",1"
 }
 Set initlist=$lb($get(oreflist),inlineFlagArg),oreflist=1,inlineFlag=inlineFlagArg
 If 'nocycle,inlineFlag {
   If $data(oreflist($this)) Quit $$Error^%apiOBJ(6296,"MPIPSIM.VistAWebServicePort.execute")
   Set oreflist($this)=""
 }
 Set tag=$get(topArg)
 Set tmpi=(($get(typeAttr)'="")&&(typeAttr'="MPIPSIM.VistAWebServicePort.execute"))
 If $IsObject(namespaces) {
   If namespaces.Stable,namespaces.CurrentNamespace="VISTA",'tmpi||(typesPrefix'="") {
     Set topAttrs=""
   } Else {
     Set popAtEnd=1,saveTopPrefix=topPrefix,saveTypesPrefix=typesPrefix,saveAttrsPrefix=attrsPrefix,saveUsePrefix=usePrefix
     Set sc=namespaces.PushNodeForExport("VISTA",$get(local,0),1,0,,.topPrefix,.topAttrs,.typesPrefix,.attrsPrefix,.usePrefix)
     If 'sc Quit sc
   }
   Set beginprefix=""
   If topAttrs'="" Set temp=temp_" "_topAttrs
   If tag="" Set tag="execute"
   Set xsitype=namespaces.OutputTypeAttribute
 } Else {
   Set saveTopPrefix=topPrefix,saveTypesPrefix=typesPrefix,saveAttrsPrefix=attrsPrefix,saveUsePrefix=usePrefix
   Set typesPrefix=namespaces If (typesPrefix'=""),($extract(typesPrefix,*)'=":") Set typesPrefix=typesPrefix_":"
   Set (topPrefix,attrsPrefix,topAttrs,beginprefix)=""
   If tag="" Set tag=typesPrefix_"execute"
   Set xsitype=0
 }
 Set local=+$get(local),savelocal=local
 Set endprefix="</"_beginprefix,beginprefix="<"_beginprefix
 If tmpi Set temp=temp_" "_xsiPrefix_"type="""_typesPrefix_"execute"""_xsiAttrs,xsiAttrs=""
   If id'="" Set temp=" "_$select($get(soap12):soapPrefix_"id",1:"id")_"=""id"_id_""""_temp
 Set temp=temp_xsiAttrs,xsiAttrs=""
 If indentFlag Set %xmlmsg=currentIndent if $data(%xmlBlock) { Do xeWrite^%occXMLInternal } else { write %xmlmsg } Set currentIndent=$select(initialCR:"",1:$c(13,10))_currentIndent_indentChars
 If tag[":" Set topPrefix=$piece(tag,":"),tag=$piece(tag,":",2)  If topPrefix'="" Set topPrefix=topPrefix_":"
 Set %xmlmsg="<"_topPrefix_tag_temp if $data(%xmlBlock) { Do xeWrite^%occXMLInternal } else { write %xmlmsg }
 Set attrsVal=attrsArg,attrsArg="" Set %xmlmsg=attrsVal if $data(%xmlBlock) { Do xeWrite^%occXMLInternal } else { write %xmlmsg }
 Set %xmlmsg=">" if $data(%xmlBlock) { Do xeWrite^%occXMLInternal } else { write %xmlmsg }
 Set prefixDepth=0
 Set val=..requestXML
 If val'="" {
   Set %xmlmsg=currentIndent_beginprefix_"requestXML"_$select(xsitype:" "_xsiPrefix_"type="""_schemaPrefix_"string""",1:"")_">"_$select(val=$c(0):"",1:$select((val["<")||(val[">")||(val["&"):"<![CDATA["_$replace(val,"]]>","]]]]><![CDATA[>")_"]]>",1:val))_endprefix_"requestXML>" if $data(%xmlBlock) { Do xeWrite^%occXMLInternal } else { write %xmlmsg }
 }
 If indentFlag Set currentIndent=$extract(currentIndent,1,*-$length(indentChars)) Set %xmlmsg=currentIndent if $data(%xmlBlock) { Do xeWrite^%occXMLInternal } else { write %xmlmsg }
 Set %xmlmsg="</"_topPrefix_tag_">" if $data(%xmlBlock) { Do xeWrite^%occXMLInternal } else { write %xmlmsg } If indentFlag,'initialCR if $data(%xmlBlock) { Set %xmlmsg="" Do xeWriteLine^%occXMLInternal } else { write ! } Set $extract(currentIndent,1,2)=""
 If '$IsObject(namespaces) || (popAtEnd=1) Set topPrefix=saveTopPrefix,typesPrefix=saveTypesPrefix,attrsPrefix=saveAttrsPrefix,usePrefix=saveUsePrefix
 If popAtEnd Do namespaces.PopNode()
 Set oreflist=$list(initlist),inlineFlag=$list(initlist,2)
 If inlineFlag {
   If 'nocycle Kill oreflist($this)
 }
 Quit sc
XMLExportInternalTrap Set $ztrap=""
 If $data(val) , $IsObject(val) , ($piece($ze,">",1)="<METHOD DOES NOT EXIST") {
   Set sc=$$Error^%apiOBJ(6249,$classname(val))
 } Else {
   Set sc=$$Error^%apiOBJ(5002,$ze)
 }
XMLExportExit 
 If '$IsObject(namespaces) || (popAtEnd=1) Set topPrefix=saveTopPrefix,typesPrefix=saveTypesPrefix,attrsPrefix=saveAttrsPrefix,usePrefix=saveUsePrefix
 If popAtEnd Do namespaces.PopNode()
 Quit sc
zXMLGetSchemaImports(imports,classes)
 Quit ##class(%XML.Implementation).XMLGetSchemaImports("MPIPSIM.VistAWebServicePort.execute",.imports,.classes)
zXMLImportAttributes()
 ;
 Quit 1
XMLImportAttrErr Quit $$Error^%apiOBJ(6260,ref,$get(@(tree)@("d",$zlascii(attributeList(ref),13))),@(tree)@("d",$zlascii(nodelist,9))_$$XMLImportAttrLocation(nodelist))
XMLImportAttrLocation(nodelist) new msg,loc
 Set loc=$lb($zlascii(nodelist,21),$zlascii(nodelist,25))
 If loc="" Quit ""
 Set msg=$get(^%qCacheMsg("%ObjectErrors",$s(""'="":$zcvt("","L"),1:$s($mvv(58)="":"en",1:$mvv(58))),"XMLImportLocation")," (%1,%2)")
 Quit $$FormatText^%occMessages(msg,$listget(loc,1),$listget(loc,2))
zXMLImportInternal()
 New child,childlist,node,nodelist,inner,innerlist,data,encodedArray,key,nsIndex,savechild,savechildlist,saveinner,saveinnnerlist
 Set $ztrap="XMLImportInternalTrap"
 If $case($piece(fmt,",",1),"encoded":0,"encoded12":0,:1) Quit $$Error^%apiOBJ(6231,fmt)
 Set nsIndex=$get(@(tree)@("N","VISTA"))
 Set node=nodeArg,nodelist=nodeArgChildlist
 If tag'=@(tree)@("d",$zlascii(nodelist,9)) Set inner=node Goto XMLImportMalformed
 If bareProjection Quit $$Error^%apiOBJ(6386,"MPIPSIM.VistAWebServicePort.execute")
 Do XMLImportAttrnode() If $data(attributeList("id")) Set idlist(node)=$this
 If $zboolean(+($zlascii(nodelist,13)#16),+1,1) Quit 1
 Set sc=$$XMLImportElements()
XMLImportExit Quit sc
XMLImportElements() ;
XMLLOOP1 Set descriptor=$zlascii(nodelist,$zwascii(nodelist,17)) Set child=($zlascii(@(tree)@($piece(node,",",1)),$piece(node,",",2))\16)_","_$zwascii(nodelist,17) If (descriptor#16)=3 { Set child="" } For { Quit:child=""  Quit:(descriptor#16)'=2  Set descriptor=$piece(child,",",2)+4 Set child=$piece(child,",",1)_","_descriptor Set descriptor=$zlascii(nodelist,descriptor) If (descriptor#16)=3 { If (descriptor\16)'=0 { Set child=##class(%XML.ImportHandler).NextChild(tree,node,.nodelist,child,.descriptor) } Else {Set child="" }} } Goto XMLLOOP2
XMLLOOP For  { Set descriptor=$piece(child,",",2)+4 Set child=$piece(child,",",1)_","_descriptor Set descriptor=$zlascii(nodelist,descriptor) If (descriptor#16)=3 { If (descriptor\16)'=0 { Set child=##class(%XML.ImportHandler).NextChild(tree,node,.nodelist,child,.descriptor) } Else {Set child="" }} Quit:child=""  Quit:(descriptor#16)'=2  }
XMLLOOP2 If child="" Quit sc
 If (descriptor#16)'=0 Set inner=child Goto XMLImportMalformedNoTag
 Set childlist=@(tree)@((descriptor\16))
 Set tag=@(tree)@("d",$zlascii(childlist,9))
 If tag="result" {
   Set tmp=$get(@(tree)@("n",$zwascii(childlist,19)))
   If tmp'="" {
     Set tmpns="http://www.w3.org/2003/05/soap-rpc"
     If (tmpns'="")&&(tmp'=tmpns) Goto XMLImportNSchild
   }
   Set savechild=child,savechildlist=childlist
   If $$XMLImportIdChild() {
     Set data=idlist(child)
   } Else { Goto:'sc XMLImportExit
     If $zboolean(+($zlascii(childlist,13)#16),+1,1) { Set data=""
     } Else {
             If (($length(childlist)-$zwascii(childlist,17)-3)\4)>1 {
               Set data="" If '##class(%XML.ImportHandler).SerializeNode(tree,child,0,0,.data,,,childlist) Goto XMLImportErrchild
             } Else { Set descriptor=$zlascii(childlist,$zwascii(childlist,17)) Set data=($zlascii(@(tree)@($piece(child,",",1)),$piece(child,",",2))\16)_","_$zwascii(childlist,17) If (descriptor#16)=3 { Set data="" }
               If data'="" { Goto:(descriptor#16)=0 XMLImportErrchild Set data=@(tree)@("d",(descriptor\16)) }}
             If data="" Set data=$c(0)
     }
     Do XMLImportAttrchild() If $data(attributeList("id")) Set idlist(child)=data
   }
   Set child=savechild,childlist=savechildlist
   Set ..%result12=data
   Goto XMLLOOP }
 If tag="responseXML" {
   If '$case($zwascii(childlist,19),0:1,nsIndex:1,:0) Goto XMLImportNSchild
   Set savechild=child,savechildlist=childlist
   If $$XMLImportIdChild() {
     Set data=idlist(child)
   } Else { Goto:'sc XMLImportExit
     If $zboolean(+($zlascii(childlist,13)#16),+1,1) { Set data=""
     } Else {
             If (($length(childlist)-$zwascii(childlist,17)-3)\4)>1 {
               Set data="" If '##class(%XML.ImportHandler).SerializeNode(tree,child,0,0,.data,,,childlist) Goto XMLImportErrchild
             } Else { Set descriptor=$zlascii(childlist,$zwascii(childlist,17)) Set data=($zlascii(@(tree)@($piece(child,",",1)),$piece(child,",",2))\16)_","_$zwascii(childlist,17) If (descriptor#16)=3 { Set data="" }
               If data'="" { Goto:(descriptor#16)=0 XMLImportErrchild Set data=@(tree)@("d",(descriptor\16)) }}
             If data="" Set data=$c(0)
     }
     Do XMLImportAttrchild() If $data(attributeList("id")) Set idlist(child)=data
   }
   Set child=savechild,childlist=savechildlist
   Set ..%Result=data
   Goto XMLLOOP }
 Goto XMLImportBadTagchild
XMLImportBadTagchild Set inner=child
XMLImportBadTag Quit $$Error^%apiOBJ(6237,tag_$$XMLImportLocation(inner))
XMLImportBadTypenode Set inner=node Goto XMLImportBadType
XMLImportBadTypechild Set inner=child
XMLImportBadType Quit $$Error^%apiOBJ(6277,class,$select(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))#16)=0:@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)),9)),1:@(tree)@("d",($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)))_$$XMLImportLocation(inner))
XMLImportErrnode Set inner=node Goto XMLImportErr
XMLImportErrchild Set inner=child
XMLImportErr
 Set data=##class(%XML.ImportHandler).GetNextChild(tree,inner,"")
 If (data'="") {
   If ($zlascii(@(tree)@($piece(data,",",1)),$piece(data,",",2))#16)'=0 {
     Quit $$Error^%apiOBJ(6232,@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)),9))_$$XMLImportLocation(inner),$extract(@(tree)@("d",($zlascii(@(tree)@($piece(data,",",1)),$piece(data,",",2))\16)),1,200))
   } Else {
     Quit $$Error^%apiOBJ(6253,@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)),9))_$$XMLImportLocation(inner),@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(data,",",1)),$piece(data,",",2))\16)),9)))
   }
 } Else {
   Quit $$Error^%apiOBJ(6252,@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)),9))_$$XMLImportLocation(inner))
 }
XMLImportIdErr Set sc=$$Error^%apiOBJ(6236,id,@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)),9))_$$XMLImportLocation(inner)) Quit sc
XMLImportMalformed Set sc=$$Error^%apiOBJ(6233,$select(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))#16)=0:@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)),9)),1:@(tree)@("d",($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)))_$$XMLImportLocation(inner)) Quit sc
XMLImportMalformedNoTag Set node=$select($piece(inner,",",1)<=0:0,1:$zlascii(@(tree)@($piece(inner,",",1)),1)_","_$zlascii(@(tree)@($piece(inner,",",1)),5)),sc=$$Error^%apiOBJ(6254,$select(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))#16)=0:@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)),9)),1:@(tree)@("d",($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16))),$select(($zlascii(@(tree)@($piece(node,",",1)),$piece(node,",",2))#16)=0:@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(node,",",1)),$piece(node,",",2))\16)),9)),1:@(tree)@("d",($zlascii(@(tree)@($piece(node,",",1)),$piece(node,",",2))\16)))_$$XMLImportLocation(node)) Quit sc
XMLImportNSchild Set inner=child
XMLImportNS Set sc=$$Error^%apiOBJ(6235,@(tree)@("d",$zlascii(@(tree)@(($zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2))\16)),9))_$$XMLImportLocation(inner)) Quit sc
XMLImportLocation(node) new msg,loc
 Set loc=$lb($zlascii(@(tree)@(($zlascii(@(tree)@($piece(node,",",1)),$piece(node,",",2))\16)),21),$zlascii(@(tree)@(($zlascii(@(tree)@($piece(node,",",1)),$piece(node,",",2))\16)),25))
 If loc="" Quit ""
 Set msg=$get(^%qCacheMsg("%ObjectErrors",$s(""'="":$zcvt("","L"),1:$s($mvv(58)="":"en",1:$mvv(58))),"XMLImportLocation")," (%1,%2)")
 Quit $$FormatText^%occMessages(msg,$listget(loc,1),$listget(loc,2))
XMLImportInternalTrap Set $ztrap=""
 If $ZE["<CLASS DOES NOT EXIST>" Goto XMLImportBadTagchild
 Quit $$Error^%apiOBJ(5002,$ZE)
XMLImportIdChild() Set inner=child,innerlist=childlist,tmp=$$XMLImportId(),child=inner,childlist=innerlist Quit tmp
XMLImportId() ;
 Do XMLImportAttrinner()
 If $data(attributeList("href")) {
   Set id=$get(@(tree)@("d",$zlascii(attributeList("href"),13)))
   If $extract(id)="#" {
     Set tmp=$select($get(@(tree)@("i",$extract(id,2,*)))="":"",1:$piece(@(tree)@("i",$extract(id,2,*)),",",1)_","_$piece(@(tree)@("i",$extract(id,2,*)),",",2)) If tmp="" Goto XMLImportIdErr
     Set inner=tmp
     Set descriptor=$zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2)) Set innerlist=@(tree)@((descriptor\16))
   }
 } ElseIf $data(attributeList("ref")),($get(@(tree)@("n",$zwascii(attributeList("ref"),9)))="http://www.w3.org/2003/05/soap-encoding") {
   Set id=$get(@(tree)@("d",$zlascii(attributeList("ref"),13)))
   Set tmp=$select($get(@(tree)@("i",id))="":"",1:$piece(@(tree)@("i",id),",",1)_","_$piece(@(tree)@("i",id),",",2)) If tmp="" Goto XMLImportIdErr
   Set inner=tmp
   Set descriptor=$zlascii(@(tree)@($piece(inner,",",1)),$piece(inner,",",2)) Set innerlist=@(tree)@((descriptor\16))
 } ElseIf '$data(attributeList("id")) {
   Quit 0
 }
 Quit $data(idlist(inner))
XMLImportAttrnode()
 If $get(attributeList)=node Quit
 Kill attributeList
 Set attributeList=node
 Set offset=29 While offset<$zwascii(nodelist,17) { Set attribute=$extract(nodelist,offset,offset+15)
    Set attrname=@(tree)@("d",$zlascii(attribute,1))
    Set attributeList(attrname)=attribute
 Set offset=offset+16 }
 Quit
XMLImportAttrchild()
 If $get(attributeList)=child Quit
 Kill attributeList
 Set attributeList=child
 Set offset=29 While offset<$zwascii(childlist,17) { Set attribute=$extract(childlist,offset,offset+15)
    Set attrname=@(tree)@("d",$zlascii(attribute,1))
    Set attributeList(attrname)=attribute
 Set offset=offset+16 }
 Quit
XMLImportAttrinner()
 If $get(attributeList)=inner Quit
 Kill attributeList
 Set attributeList=inner
 Set offset=29 While offset<$zwascii(innerlist,17) { Set attribute=$extract(innerlist,offset,offset+15)
    Set attrname=@(tree)@("d",$zlascii(attribute,1))
    Set attributeList(attrname)=attribute
 Set offset=offset+16 }
 Quit
zXMLIsObjectEmpty(ignoreNull)
 If ..%result12'="" Quit 0
 If ..%Result'="" Quit 0
 If ..requestXML'="" Quit 0
 Quit 1
zXMLNew(document,node,containerOref="")
	Quit (##class(MPIPSIM.VistAWebServicePort.execute).%New())
zXMLSchema(top="",format="",namespacePrefix="",input=0,refOnly=0,schema)
 Quit ##class(%XML.Implementation).XMLSchema("MPIPSIM.VistAWebServicePort.execute",top,format,namespacePrefix,input,refOnly,.schema)
