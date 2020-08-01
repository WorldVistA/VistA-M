 ; ----------------------------------------------------------------------------
 ;| ewd-document-store: Persistent JavaScript Objects and Document Database  |
 ;|                      using Global Storage                                |
 ;|                                                                          |
 ;| Copyright (c) 2016-19 M/Gateway Developments Ltd,                        |
 ;| Redhill, Surrey UK.                                                      |
 ;| All rights reserved.                                                     |
 ;|                                                                          |
 ;| http://www.mgateway.com                                                  |
 ;| Email: rtweed@mgateway.com                                               |
 ;|                                                                          |
 ;|                                                                          |
 ;| Licensed under the Apache License, Version 2.0 (the "License");          |
 ;| you may not use this file except in compliance with the License.         |
 ;| You may obtain a copy of the License at                                  |
 ;|                                                                          |
 ;|     http://www.apache.org/licenses/LICENSE-2.0                           |
 ;|                                                                          |
 ;| Unless required by applicable law or agreed to in writing, software      |
 ;| distributed under the License is distributed on an "AS IS" BASIS,        |
 ;| WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. |
 ;| See the License for the specific language governing permissions and      |
 ;|  limitations under the License.                                          |
 ;----------------------------------------------------------------------------
 ;
 ; 16 June 2020
 ;
 ; QEWD Interface to mgsql
 ;
ping() ; // for testing
 s ^qewdTemp($j,"ping")=$h
 QUIT "pong"
 ;
openNewFile(filepath)
 o filepath:(noreadonly:variable:newversion:exception="g openNewFileNotExists") 
 QUIT 1
openNewFileNotExists
 QUIT 0
 ;
zwr(ref) ;
 ;
 n file,io,ok
 ;
 s file="/opt/qewd/mapped/go-"_$j_".txt"
 s io=$io
 s ok=$$openNewFile(file)
 if 'ok QUIT ok
 ;
 s $zt="g zwrError"
 u file
 zwr @ref
 c file
 u io
 QUIT 1
 ;
zwrError
 s $zt=""
 c file u io
 QUIT 0
 ;
sqlquery(sql) ;
 ;
 n ok,row
 ;
 ; // selects and creates
 ;
 i '$d(^qewdTemp($j,"input")) d  QUIT ok
 . n %zi,%zo
 . i $e(sql,1,13)'="create index " d
 . . s %zi("stmt")=1
 . s ok=$$exec^%mgsql("",sql,.%zi,.%zo)
 . m ^qewdTemp($j,"output")=%zo
 . s ^qewdTemp($j,"query")=sql
 ;
 ; // inserts
 ;
 s row=""
 f  s row=$o(^qewdTemp($j,"input",row)) q:row=""  d
 . n %zi,%zo
 . m %zi=^qewdTemp($j,"input",row)
 . s %zi("stmt")=1
 . s ok=$$exec^%mgsql("",sql,.%zi,.%zo)
 . m ^qewdTemp($j,"output",row)=%zo
 s ^qewdTemp($j,"query")=sql
 QUIT ok
 ;
fn() ; Generic function invoker
 ;
 n arg,comma,func,i,result
 ;
 s func=$g(^qewdTemp($j,"function"))
 i func="" QUIT -1
 s func=func_"("
 s i=""
 s comma=""
 f  s i=$o(^qewdTemp($j,"args",i)) q:i=""  d
 . s func=func_comma_""""_^qewdTemp($j,"args",i)_""""
 . s comma=","
 s func="s result=$$"_func_")"
 i $g(^qewdTemp($j,"log"))=1 d
 . s ^qewdTemp($j,"x")=func
 x func
 i $g(^qewdTemp($j,"log"))=1 d
 . s ^qewdTemp($j,"result")=result
 ;
 QUIT ""_result
 ;
 
