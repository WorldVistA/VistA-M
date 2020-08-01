SYNWD     ;ven/gpl - mash graph utilities ; 9/24/17 4:33pm
 ;;1.0;norelease;;feb 27, 2017;Build 10
 ;
 ;
 q
 ;
 ; All the public entry points for handling in mash data are in this routine
 ;
 ; 
 ; graph handling routines
 ;
setroot(graph) ; root of working storage
 quit $$setroot^SYNGRAF(graph)
 ;
rootOf(graph) ; return the root of graph named graph
 quit $$rootOf^SYNGRAF(graph)
 ;
addgraph(graph) ; makes a place in the graph file for a new graph
 do addgraph^SYNGRAF(graph)
 quit
 ;
purgegraph(graph) ; delete a graph
 do purgegraph^SYNGRAF(graph)
 quit
 ;
insert2graph(ary,graph,replace) ; insert a new entry to a graph
 do insert2graph^SYNGRAF(.ary,graph,replace)
 quit
 ;
nameThis(altname) ; returns the id to be used for altname
 ; this will eventually use the context graph and the 
 ; local variable context to query the altname and obtain an id
 quit $$nameThis^SYNGRAF(altname)
 ;
getThis(rary,fn,nocache) ; find a file and read it into rary array  
 do getThis^SYNGRAF(rary,fn,$get(nocache))
 quit
 ;
queryContext(context,locator,property) ; look up project specific 
 ; names and values from the context graph
 ; tbd
 quit $$queryContext^SYNGRAF(context,locator,property)
 ;
queryTag(rtn,tag) ; returns a json/mumps array of tagged items
 do queryTag^SYNGRAF(rtn,tag)
 quit
 ;
fromCache(rary,name,graph) ; return a file from the cache
 do fromCache(rary,name,graph)
 quit
 ;
toCache(arry,name,graph) ; put a file in the cache
 do toCache^SYNGRAF(arry,name,graph)
 quit
 ;
beautify(inary,outary) ; pretty print a line of json
 do beautify^SYNGRAF(inary,outary)
 quit
 ;
ary2file(ary,dir,file) ;
 do ary2file^SYNGRAF(.ary,dir,file)
 quit
 ;
file2ary(ary,dir,file)
 do file2ary^SYNGRAF(.ary,dir,file)
 quit
 ;
 ;
 ;
 ; csv handling routines
 ;
csv2graph(source,graph) ; import a csv file to a graph
 ; graph is optional, will default to csvGraph
 ; source is either a filename which will be found in seeGraph
 ; or a global passed by name usually loaded with FTG^%ZISH
 ;
 d csv2graph^SYNCSV(source,$get(graph))
 quit
 ;
prune(txt) ; extrinsic removes extra quotes
 quit $$prune^SYNCSV(txt)
 ;
delim(ary) ; figures out the cvs delimiter
 ; return -1 if there not found
 ; ary is passed by reference
 ; returns the delimiter
 quit $$delim^SYNCSV(.ary)
 ;
wellformed(ary,delim) ; extrinsic returns 1 if ary is well formed
 ; checks to see that the count of the delimiter is the same
 ; on every line
 ; ary is passed by reference
 ;
 quit $$wellformed^SYNCSV(.ary,delim)
 ;
