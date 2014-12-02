 ;MPIPSIM.PSIMWebServicePort.execute.1
 ;(C)InterSystems, generated for class MPIPSIM.PSIMWebServicePort.execute.  Do NOT edit. 08/23/2013 09:38:06AM
 ;;594C5462;MPIPSIM.PSIMWebServicePort.execute
 ;
%NormalizeObject()
	If m%%RequestName Set:i%%RequestName'="" i%%RequestName=(..%RequestNameNormalize(i%%RequestName))
	If m%%Result Set:i%%Result'="" i%%Result=(..%ResultNormalize(i%%Result))
	If m%%result12 Set:i%%result12'="" i%%result12=(..%result12Normalize(i%%result12))
	If m%requestXML Set:i%requestXML'="" i%requestXML=(..requestXMLNormalize(i%requestXML))
	Quit 1
%ValidateObject(force=0)
	New iv,sc,rc Set sc=1
	If '(..%IsModified()) Quit 1
	If m%%RequestName Set iv=..%RequestName If iv'="" Set rc=(..%RequestNameIsValid(iv)) If ('rc) Set sc=$$xEmbedErr(sc,rc,5802,"%RequestName",iv)
	If m%%Result Set iv=..%Result If iv'="" Set rc=(..%ResultIsValid(iv)) If ('rc) Set sc=$$xEmbedErr(sc,rc,5802,"%Result",iv)
	If m%%result12 Set iv=..%result12 If iv'="" Set rc=(..%result12IsValid(iv)) If ('rc) Set sc=$$xEmbedErr(sc,rc,5802,"%result12",iv)
	If m%requestXML Set iv=..requestXML If iv'="" Set rc=(..requestXMLIsValid(iv)) If ('rc) Set sc=$$xEmbedErr(sc,rc,5802,"requestXML",iv)
	Quit sc
xEmbedErr(sc,rc,errcode,loc,val) { Set rc=$$EmbedError^%apiOBJ(rc,errcode,$classname()_":"_loc,val) Quit $select(+sc:rc,1:$$AppendStatus^%occSystem(sc,rc)) }
	Quit
zInvoke(%Client,%Action,requestXML) public {
 Set ..requestXML=$get(requestXML)
 Do %Client.InvokeClient($this,"execute",%Action)
 Quit ..%Result }
zNeedsAdjustment(ResultName) public {
 Set ResultName="executeResult"
 Quit 1 }
zReset() public {
 Quit }
zXMLDTD(top,format,input,dtdlist)
 Quit ##class(%XML.Implementation).XMLDTD("MPIPSIM.PSIMWebServicePort.execute",.top,.format,.input,.dtdlist)
zXMLExportInternal()
 New tag,summary,attrsVal,savelocal,aval,k,tmpPrefix,prefixDepth,xsitype,hasNoContent,hasElement,topPrefix,topAttrs,typesPrefix,beginprefix,endprefix,soapPrefix,schemaPrefix,xsiPrefix,xsiAttrs,initlist,initialCR,inlineFlag,initlist
 Set $ztrap="XMLExportInternalTrap"
 If 'encoded Quit $$Error^%apiOBJ(6231,fmt)
 Set summary=summaryArg
 If group Quit $$Error^%apiOBJ(6386,"MPIPSIM.PSIMWebServicePort.execute")
 If indentFlag Set initialCR=($extract(currentIndent,1,2)=$c(13,10))
 Set id=createId
 Set temp=""
 If id'="" {
   If $piece($get(idlist(+$this)),",",2)'="" Quit 1
   Set idlist(+$this)=id_",1"
 }
 Set initlist=$lb($get(oreflist),inlineFlagArg),oreflist=1,inlineFlag=inlineFlagArg
 If 'nocycle,inlineFlag {
   If $data(oreflist($this)) Quit $$Error^%apiOBJ(6296,"MPIPSIM.PSIMWebServicePort.execute")
   Set oreflist($this)=""
 }
 Set tag=$get(topArg)
 If $IsObject(namespaces) {
   Set sc=namespaces.PushNodeForExport("PSIM",$get(local,0),1,0,,.topPrefix,.topAttrs,.typesPrefix,.attrsPrefix,.soapPrefix,.schemaPrefix,.xsiPrefix,.xsiAttrs,.usePrefix)
   If 'sc Quit sc
   Set beginprefix=""
   If xsiAttrs'="" Set xsiAttrs=" "_xsiAttrs
   If topAttrs'="" Set temp=temp_" "_topAttrs
   If tag="" Set tag="execute"
   Set xsitype=namespaces.OutputTypeAttribute
 } Else {
   Set typesPrefix=namespaces If (typesPrefix'=""),($extract(typesPrefix,*)'=":") Set typesPrefix=typesPrefix_":"
   Set (topPrefix,attrsPrefix,topAttrs,beginprefix)=""
   Set soapPrefix="SOAP-ENC:"
   Set schemaPrefix="s:"
   Set xsiPrefix="xsi:"
   Set xsiAttrs=""
   If tag="" Set tag=typesPrefix_"execute"
   Set xsitype=0
 }
 Set local=+$get(local),savelocal=local
 Set endprefix="</"_beginprefix,beginprefix="<"_beginprefix
 If ($get(typeAttr)'=""),(typeAttr'="MPIPSIM.PSIMWebServicePort.execute") Set temp=temp_" "_xsiPrefix_"type="""_typesPrefix_"execute"""_xsiAttrs,xsiAttrs=""
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
 If $IsObject(namespaces) Do namespaces.PopNode()
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
 If $IsObject(namespaces) Do namespaces.PopNode()
 Quit sc
zXMLGetSchemaImports(imports,classes)
 Quit ##class(%XML.Implementation).XMLGetSchemaImports("MPIPSIM.PSIMWebServicePort.execute",.imports,.classes)
zXMLImportAttributes()
 ;
 Quit 1
XMLImportAttrErr Quit $$Error^%apiOBJ(6260,ref,$get(@tree@(node,"a",ref)),@tree@(node)_$$XMLImportAttrLocation(node))
XMLImportAttrLocation(node) new msg,loc
 Set loc=$lb($listget($get(@tree@(node,0)),5),$listget($get(@tree@(node,0)),6))
 If loc="" Quit ""
 Set msg=$get(^%qCacheMsg("%ObjectErrors",$s(""'="":$zcvt("","L"),1:$get(^||%Language,"en")),"XMLImportLocation")," (%1,%2)")
 Quit $$FormatText^%occMessages(msg,$listget(loc,1),$listget(loc,2))
zXMLImportInternal()
 New child,node,data,ref,encodedArray,loopref,element,key,nsIndex
 Set $ztrap="XMLImportInternalTrap"
 If $case($piece(fmt,",",1),"encoded":0,"encoded12":0,:1) Quit $$Error^%apiOBJ(6231,fmt)
 Set nsIndex=$get(@tree@("ns","PSIM"))
 Set (node,ref)=nodeArg
 If ($listget($get(@tree@(node,0)),1)'="e")||(tag'=@tree@(node)) Goto XMLImportMalformed
 If bareProjection Quit $$Error^%apiOBJ(6386,"MPIPSIM.PSIMWebServicePort.execute")
 If $data(@tree@(node,"a","id")) Set idlist(node)=$this
 If +$listget($get(@tree@(node,0)),7,0) Quit 1
 Set sc=$$XMLImportElements()
XMLImportExit Quit sc
XMLImportElements() ;
 Set child=""
XMLLOOP For  { Set child=$order(@tree@(node,"c",child)) If (child="")||($listget($get(@tree@(child,0)),1)'="w") Quit }
 If child="" Quit sc
 Set tag=@tree@(child)
 Set ref=child
 If $listget($get(@tree@(ref,0)),1)'="e" Goto XMLImportMalformedNoTag
 If tag="result" {
   Set tmp=$select($listget($get(@tree@(ref,0)),3)="":"",1:$get(@tree@("ns#",$list(^(0),3))))
   If tmp'="" {
     Set tmpns="http://www.w3.org/2003/05/soap-rpc"
     If (tmpns'="")&&(tmp'=tmpns) Goto XMLImportNS
   }
   If $$XMLImportId() {
     Set data=idlist(ref)
   } Else { Goto:'sc XMLImportExit
     If +$listget($get(@tree@(ref,0)),7,0) { Set data=""
     } Else {
             Set data=$order(@tree@(ref,"c",""))
             If $order(@tree@(ref,"c",data))'="" {
               Set data="" If '##class(%XML.ImportHandler).SerializeNode(tree,ref,0,0,.data) Goto XMLImportErr
             } ElseIf data'="" { Goto:$listget($get(@tree@(data,0)),1)="e" XMLImportErr Set data=@tree@(data) }
             If data'="" Goto:('..%result12IsValid(data)) XMLImportErr
             If data="" Set data=$c(0)
     }
     If $data(@tree@(ref,"a","id")) Set idlist(ref)=data
   }
   Set ..%result12=data
   Goto XMLLOOP }
 If tag="executeResult" {
   If '$case($listget($get(@tree@(ref,0)),3),"":1,nsIndex:1,:0) Goto XMLImportNS
   If $$XMLImportId() {
     Set data=idlist(ref)
   } Else { Goto:'sc XMLImportExit
     If +$listget($get(@tree@(ref,0)),7,0) { Set data=""
     } Else {
             Set data=$order(@tree@(ref,"c",""))
             If $order(@tree@(ref,"c",data))'="" {
               Set data="" If '##class(%XML.ImportHandler).SerializeNode(tree,ref,0,0,.data) Goto XMLImportErr
             } ElseIf data'="" { Goto:$listget($get(@tree@(data,0)),1)="e" XMLImportErr Set data=@tree@(data) }
             If data'="" Goto:('..%ResultIsValid(data)) XMLImportErr
             If data="" Set data=$c(0)
     }
     If $data(@tree@(ref,"a","id")) Set idlist(ref)=data
   }
   Set ..%Result=data
   Goto XMLLOOP }
 Goto XMLImportBadTag
XMLImportBadTag Quit $$Error^%apiOBJ(6237,tag_$$XMLImportLocation(ref))
XMLImportBadType Quit $$Error^%apiOBJ(6277,class,@tree@(ref)_$$XMLImportLocation(ref))
XMLImportErr
 Set data=$order(@tree@(ref,"c",""))
 If (data'="") {
   If $listget($get(@tree@(data,0)),1)'="e" {
     Quit $$Error^%apiOBJ(6232,@tree@(ref)_$$XMLImportLocation(ref),$extract(@tree@(data),1,200))
   } Else {
     Quit $$Error^%apiOBJ(6253,@tree@(ref)_$$XMLImportLocation(ref),@tree@(data))
   }
 } Else {
   Quit $$Error^%apiOBJ(6252,@tree@(ref)_$$XMLImportLocation(ref))
 }
XMLImportIdErr Set sc=$$Error^%apiOBJ(6236,id,@tree@(ref)_$$XMLImportLocation(ref)) Quit sc
XMLImportMalformed Set sc=$$Error^%apiOBJ(6233,@tree@(ref)_$$XMLImportLocation(ref)) Quit sc
XMLImportMalformedNoTag Set node=$listget($get(@tree@(ref,0)),2),sc=$$Error^%apiOBJ(6254,@tree@(ref),@tree@(node)_$$XMLImportLocation(node)) Quit sc
XMLImportNS Set sc=$$Error^%apiOBJ(6235,@tree@(ref)_$$XMLImportLocation(ref)) Quit sc
XMLImportLocation(node) new msg,loc
 Set loc=$lb($listget($get(@tree@(node,0)),5),$listget($get(@tree@(node,0)),6))
 If loc="" Quit ""
 Set msg=$get(^%qCacheMsg("%ObjectErrors",$s(""'="":$zcvt("","L"),1:$get(^||%Language,"en")),"XMLImportLocation")," (%1,%2)")
 Quit $$FormatText^%occMessages(msg,$listget(loc,1),$listget(loc,2))
XMLImportInternalTrap Set $ztrap=""
 If $ZE["<CLASS DOES NOT EXIST>" Goto XMLImportBadTag
 Quit $$Error^%apiOBJ(5002,$ZE)
XMLImportId() ;
 If $data(@tree@(ref,"a","href")) {
   Set id=$get(@tree@(ref,"a","href"))
   If $extract(id)="#" {
     Set tmp=$get(@tree@("id",$extract(id,2,*))) If tmp="" Goto XMLImportIdErr
     Set ref=tmp
   }
 } ElseIf $data(@tree@(ref,"a","ref")) , ($select($get(@tree@(ref,"a","ref","u"))="":"",1:$get(@tree@("ns#",^("u"))))="http://www.w3.org/2003/05/soap-encoding") {
   Set id=$get(@tree@(ref,"a","ref"))
   Set tmp=$get(@tree@("id",id)) If tmp="" Goto XMLImportIdErr
   Set ref=tmp
 } ElseIf '$data(@tree@(ref,"a","id")) {
   Quit 0
 }
 Quit $data(idlist(ref))
zXMLIsObjectEmpty(ignoreNull)
 If ..%result12'="" Quit 0
 If ..%Result'="" Quit 0
 If ..requestXML'="" Quit 0
 Quit 1
zXMLNew(document,node,containerOref="")
	Quit (##class(MPIPSIM.PSIMWebServicePort.execute).%New())
zXMLSchema(top="",format="",namespacePrefix="",input=0,refOnly=0,schema)
 Quit ##class(%XML.Implementation).XMLSchema("MPIPSIM.PSIMWebServicePort.execute",top,format,namespacePrefix,input,refOnly,.schema)
