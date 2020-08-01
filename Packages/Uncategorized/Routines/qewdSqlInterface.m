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
 ; 21 November 2019
 ;
 ; QEWD Interface to mgsql
 ;
ping() ; // for testing
 s ^rob("ping")=$h
 QUIT "pong"
 ;
sqlquery(sql) ;
 ;
 n row
 ;
 ; // selects and creates
 ;
 i '$d(^qewdTemp($j,"input")) d  QUIT ok
 . n ok,%zi,%zo
 . s %zi("stmt")=1
 . s ok=$$exec^%mgsql("",sql,.%zi,.%zo)
 . m ^qewdTemp($j,"output")=%zo
 . s ^qewdTemp($j,"query")=sql
 ;
 ; // inserts
 ;
 s row=""
 f  s row=$o(^qewdTemp($j,"input",row)) q:row=""  d
 . n ok,%zi,%zo
 . m %zi=^qewdTemp($j,"input",row)
 . s %zi("stmt")=1
 . s ok=$$exec^%mgsql("",sql,.%zi,.%zo)
 . m ^qewdTemp($j,"output",row)=%zo
 s ^qewdTemp($j,"query")=sql
 QUIT ok
 ;
