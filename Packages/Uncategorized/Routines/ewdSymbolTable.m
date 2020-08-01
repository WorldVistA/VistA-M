ewdSymbolTable ; ewd-globals-session functions for symbol table management
 ;
 ; ----------------------------------------------------------------------------
 ; | ewd-session: Session management using ewd-document-store                 |
 ; |                                                                          |
 ; | Copyright (c) 2016-17 M/Gateway Developments Ltd,                        |
 ; | Copyright (c) 2017 Sam Habiel, Pharm.D. (added set, kill, get,           |
 ; |               reimplemented GT.M symbol table code)                      |
 ; | Reigate, Surrey UK.                                                      |
 ; | All rights reserved.                                                     |
 ; |                                                                          |
 ; | http://www.mgateway.com                                                  |
 ; | Email: rtweed@mgateway.com                                               |
 ; |                                                                          |
 ; |                                                                          |
 ; | Licensed under the Apache License, Version 2.0 (the "License");          |
 ; | you may not use this file except in compliance with the License.         |
 ; | You may obtain a copy of the License at                                  |
 ; |                                                                          |
 ; |     http://www.apache.org/licenses/LICENSE-2.0                           |
 ; |                                                                          |
 ; | Unless required by applicable law or agreed to in writing, software      |
 ; | distributed under the License is distributed on an "AS IS" BASIS,        |
 ; | WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. |
 ; | See the License for the specific language governing permissions and      |
 ; |  limitations under the License.                                          |
 ; ----------------------------------------------------------------------------
 ;
 ; 2 August 2017
 ;
 ;QUIT
 ;
clearSymbolTable() ;
 k
 QUIT 1
 ;
saveSymbolTable(%zzg) ;
 ; Save Symbol Table to specified global node (%zzg)
 ; %zzg is of form "^gloName(""sub1"",""sub2"")"
 ; %zzg must specify at least one subscript
 ;
 k @%zzg
 i $zv["GT.M" zshow "v":@%zzg QUIT 1
 ;
 QUIT $zu(160,1,%zzg)
 ;
restoreSymbolTable(gloRef) ;
 ; Restore Symbol Table from specified global node
 ; gloRef is of form "^gloName(""sub1"",""sub2"")"
 
 ; gloRef must specify at least one subscript
 ;
 k (gloRef)
 i $zv["GT.M" d  QUIT 1
 . n %zzv
 . s %zzv=""
 . f  s %zzv=$o(@gloRef@("V",%zzv)) q:%zzv=""  s @^(%zzv)
 ;
 QUIT $zu(160,0,gloRef)
 ;
getSessionSymbolTable(sessid) ;
 ;
 n gloRef
 ;
 s gloRef="^%zewdSession(""session"","_sessid_",""ewd_symbolTable"")"
 i $$restoreSymbolTable(gloRef)
 k %zzg
 QUIT "ok"
 ;
setVar(var,val) ;
 s @var=val
 QUIT @var
 ;
 ;
killVar(var) ;
 k @var
 QUIT 1
 ;
getVar(var) ;
 QUIT $$GETV(var)
 ;
 ; Public domain code from VistA for getting a variable
 ; from XWBPRS. This lets us get ISVs as well as well as vars with quotes
 ;
GETV(V) ;get value of V - reference parameter
 N X
 S X=V
 IF $E(X,1,2)="$$" QUIT ""
 IF $C(34,36)[$E(V) X "S V="_$$VCHK(V)
 E  S V=@V
 QUIT V
 ;
VCHK(S) ;Parse string for first argument
 N C,I,P
 F I=1:1 S C=$E(S,I) D VCHKP:C="(",VCHKQ:C=$C(34) Q:" ,"[C
 QUIT $E(S,1,I-1)
 ;
VCHKP S P=1 ;Find closing paren
 F I=I+1:1 S C=$E(S,I) Q:P=0!(C="")  I "()"""[C D VCHKQ:C=$C(34) S P=P+$S("("[C:1,")"[C:-1,1:0)
 QUIT
 ;
VCHKQ ;Find closing quote
 F I=I+1:1 S C=$E(S,I) Q:C=""!(C=$C(34))
 QUIT
