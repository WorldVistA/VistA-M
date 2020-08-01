SYNGRAF        ;ven/gpl - mash graph utilities ; 9/24/17 4:33pm
 ;;1.0;norelease;;feb 27, 2017;Build 10
 ;
 ;
 q
 ;
 ; All the public entry points for these routines are found in SYNWD
 ;
setroot(graph) ; root of working storage
 new %y set %y=$order(^SYNGRAPH(2002.801,"B",graph,""))
 if %y="" set %y=$$addgraph(graph) ; if graph is not present, add it
 quit $name(^SYNGRAPH(2002.801,%y)) ; root for graph
 ;
rootOf(graph) ; return the root of graph named graph
 new %x1 set %x1=$order(^SYNGRAPH(2002.801,"B",graph,""))
 if %x1="" quit -1
 quit $name(^SYNGRAPH(2002.801,%x1,"graph"))
 ;
addgraph(graph) ; makes a place in the graph file for a new graph
 n fien s fien=$o(^SYNGRAPH(2002.801,"B",graph,""))
 i fien'="" q fien
 ;s fien=$o(^XTMP("SYNGRAPH"," "),-1)+1
 ;s ^XTMP("SYNGRAPH",fien,0)=graph
 ;s ^XTMP("SYNGRAPH","B",graph,fien)=""
 ;q fien
 ;
 ;new fda set fda(17.040801,"?+1,",.01)=graph
 new fda set fda(2002.801,"?+1,",.01)=graph
 new %yerr
 do UPDATE^DIE("","fda","","%yerr")
 new %y set %y=$order(^SYNGRAPH(2002.801,"B",graph,""))
 quit %y
 ;
purgegraph(graph) ; delete a graph
 new %y set %y=$order(^SYNGRAPH(2002.801,"B",graph,""))
 if %y="" quit 0
 ;k ^XTMP("SYNGRAPH",%y)
 ;k ^XTMP("SYNGRAPH","B",graph,%y)
 ;q
 ;
 new fda set fda(2002.801,%y_",",.01)="@"
 new %yerr
 do UPDATE^DIE("","fda","","%yerr")
 if '$data(%yerr) quit 1
 zwr %yerr
 quit 0 
 ;
insert2graph(ary,graph,replace) ; insert a new entry to a graph
 ; ary is passed by name, graph is the name of the graph
 ; if replace=1 the graph will be killed first before merge
 new root set root=$$setroot(graph)
 new groot set groot=$name(@root@("graph"))
 new id set id=$order(@ary@(""))
 if replace=1 kill @groot@(id) 
 merge @groot=@ary
 quit
 ;
nameThis(altname) ; returns the id to be used for altname
 ; this will eventually use the context graph and the 
 ; local variable context to query the altname and obtain an id
 new result
 if $data(context) set result=$$queryContext(context,"id",altname) q result
 if altname="background-dd-map" set result="sbform" quit result
 quit altname
 ;
getThis(rary,fn,nocache) ; find a file and read it into rary array  
 new ary
 if '$g(nocache) do fromCache("ary",fn)
 if $d(ary) do  quit  ;
 . merge @rary=ary
 do queryTag("ary",fn)
 if '$d(ary) do  quit  ;
 . write !,"error retrieving array ",fn
 new file set file=$order(ary(1,"file",""))
 new dir set dir=$order(ary(1,"localdir",""))_"/"
 new tmp set tmp=$name(^TMP("yottawrk",$J))
 kill @tmp
 new tmp1 set tmp1=$name(@tmp@(1))
 new ok set ok=$$FTG^%ZISH(dir,file,tmp1,3)
 if 'ok do  quit  ;
 . write !,"error loading file ",dir_file
 if '$g(nocache) do toCache(tmp,fn,"html-cache")
 merge @rary=@tmp
 kill @tmp
 quit
 ;
queryContext(context,pred,obj) ; look up project specific 
 ; names and values from the context graph
 ; tbd
 quit obj
 ;
queryTag(rtn,tag) ; returns a json/mumps array of tagged items
 new graph set graph="seeGraph"
 kill @rtn
 new root set root=$$setroot(graph)
 new groot set groot=$na(@root@("graph"))
 if '$d(@groot@("pos","tag",tag)) quit
 new x1,y1 set (x1,y1)=""
 new cnt set cnt=0
 for  set x1=$order(@groot@("pos","tag",tag,x1)) quit:x1=""  do  ;
 . for  set y1=$order(@groot@("pos","tag",tag,x1,y1)) quit:y1=""  do  ;
 . . set cnt=cnt+1
 . . merge @rtn@(cnt)=@groot@(x1,y1)
 quit
 ;
fromCache(rary,name,graph) ; return a file from the cache
 if '$d(graph) set graph="html-cache"
 new zgn set zgn=$$setroot(graph)
 quit:'$data(@zgn@("graph","B",name))
 new zien set zien=$order(@zgn@("graph","B",name,""))
 quit:zien=""
 merge @rary=@zgn@("graph",zien)
 quit
 ;
toCache(arry,name,graph) ; put a file in the cache
 if '$d(graph) set graph="html-cache"
 new zgn set zgn=$$setroot(graph)
 new zien
 if $data(@zgn@("graph","B",name)) do  ;
 . set zien=$order(@zgn@("graph","B",name,""))
 . kill @zgn@("graph",zien)
 . kill @zgn@("graph","B",name,zien)
 if $get(zien)="" do  ;
 . set zien=$order(@zgn@("graph"," "),-1)+1
 merge @zgn@("graph",zien)=@arry
 set @zgn@("graph","B",name,zien)=""
 quit
 ;
beautify(inary,outary) ; pretty print a line of json
 new zg,zi set (zg,zi)=""
 for  set zi=$order(@inary@(zi)) quit:zi=""  set zg=zg_@inary@(zi)
 do ary2file("zg",^%WHOME,"json.json")
 zsy "python -m json.tool "_^%WHOME_"json.json > "_^%WHOME_"pretty-json.json"
 do file2ary(outary,^%WHOME,"pretty-json.json")
 q
 ;
ary2file(ary,dir,file) ;
 new tmp set tmp=$name(^TMP("yottawrk",$J))
 kill @tmp
 if '$data(@ary@(1)) do  ; not really an array
 . if $get(@ary)="" quit ; not a string either
 . merge @tmp@(1)=@ary ; input was a string
 else   merge @tmp=@ary
 new tmp1 set tmp1=$name(@tmp@(1))
 new ok set ok=$$GTF^%ZISH(tmp1,3,dir,file)
 if 'ok do  quit  ;
 . write !,"error saving file ",dir_file
 quit
 ;
file2ary(ary,dir,file)
 new tmp set tmp=$name(^TMP("yottawrk",$J))
 kill @tmp
 new tmp1 set tmp1=$name(@tmp@(1))
 new ok set ok=$$FTG^%ZISH(dir,file,tmp1,3)
 if 'ok do  quit  ;
 . write !,"error loading file ",dir_file
 merge @ary=@tmp
 kill @tmp
 quit
 ;
