XINDX13 ; OSE/SMH - Input, Print, and Sort Template Analysis;2018-02-28  10:16 AM
 ;;7.3;TOOLKIT;**10001**;Apr 25, 1995;Build 4
 ; Entire routine authored by Sam Habiel; minor modifications by
 ; Christopher Edwards
 ;
 ; This routine finds non-self files that are pointed to by a template
 ; EPs DIPTM and DIETM support XINDX12 in finding M code in Input and
 ; Print templates.
 ;
ALL(path) ; [Public] Export all template CSV files at once to a specific dir
 i $g(path)=""     s path=$$DEFDIR^%ZISH()
 do DIBT(path),DIET(path),DIPT(path)
 quit
 ;
DIBT(path,filename) ; [Public] Sort template analysis
 n outputData
 i $g(path)=""     s path=$$DEFDIR^%ZISH()
 i $g(filename)="" s filename="DIBTOUT.csv"
 d DIBTCOL(.outputData)
 d DIBTOUT(.outputData,path,filename)
 quit
 ;
DIET(path,filename) ; [Public] Input template analysis
 n outputData
 i $g(path)=""     s path=$$DEFDIR^%ZISH()
 i $g(filename)="" s filename="DIETOUT.csv"
 d DIETCOL(.outputData)
 d DIETOUT(.outputData,path,filename)
 quit
 ;
DIPT(path,filename) ; [Public] Print template analysis
 n outputData
 i $g(path)=""     s path=$$DEFDIR^%ZISH()
 i $g(filename)="" s filename="DIPTOUT.csv"
 d DIPTCOL(.outputData)
 d DIPTOUT(.outputData,path,filename)
 quit
 ;
DIBTCOL(outputData) ; [Private] Sort Template Data Collection
 ; for each template
 n dibt f dibt=0:0 s dibt=$o(^DIBT(dibt)) q:'dibt  d
 . quit:'$data(^DIBT(dibt,0))                 ; get valid ones only
 . new name s name=$p(^DIBT(dibt,0),U)
 . new file s file=$p(^DIBT(dibt,0),U,4)
 . n isSort s isSort=$order(^DIBT(dibt,2,0))  ; make sure they are sort templates
 . if 'isSort quit
 . ;
 . ; walk through each field
 . n line f line=0:0 s line=$order(^DIBT(dibt,2,line)) quit:'line  do
 .. n lineData ; We have some variances on how the data is stored (lines below)
 .. i $d(^(line))#2   s lineData=^DIBT(dibt,2,line) ; **NAKED**
 .. i $d(^(line,0))#2 s lineData=^DIBT(dibt,2,line,0) ; **NAKED**
 .. ;
 .. ; some vital data
 .. n lineFile s lineFile=$piece(lineData,U)
 .. i '$data(^DD(lineFile)) quit  ; bad DD
 .. n lineField s lineField=$piece(lineData,U,2)
 .. n lineFieldSpec s lineFieldSpec=$p(lineData,U,3)
 .. ;
 .. ; if it's the same file, and not a relational field, we are not interested
 .. i lineFile=file,(lineFieldSpec'[":"&(lineFieldSpec'[" IN ")) quit
 .. ;
 .. ; if the parent is the same file, and ditto, we are still not interested
 .. i $$PARENT(lineFile)=file,(lineFieldSpec'[":"&(lineFieldSpec'[" IN ")) quit
 .. ;
 .. ; We are interested
 .. ; Do we have the field?
 .. i lineField="" do
 ... ;
 ... ; no we don't so get the fields using DICOMP
 ... n X
 ... d EXPR^DICOMP(lineFile,"dmFITSL",lineFieldSpec)
 ... i '$d(X) quit
 ... ; X("USED")="404.51^.07;404.57^.02"
 ... i X("USED")="" quit  ; not an expression that uses fields
 ... n pairs,pair f pairs=1:1:$l(X("USED"),";") d
 .... s pair=$p(X("USED"),";",pairs)
 .... n thisFile  s thisFile=$p(pair,U,1)
 .... n thisField s thisField=$p(pair,U,2)
 .... i thisFile=file quit
 .... s outputData(file,thisFile,thisField)=dibt_U_name
 .. ;
 .. ; we have a field. Take it at face value
 .. e  s outputData(file,lineFile,lineField)=dibt_U_name
 quit
 ;
DIBTOUT(outputData,outputPath,outputFile) ; [Private] Sort Template Data Output
 n POP
 d OPEN^%ZISH("file1",outputPath,outputFile,"W")
 i POP quit
 u IO
 n file,dstFile,dstField,dibtIEN,dibtName
 n c s c=","
 w "SORT TEMPLATE IEN,SORT TEMPLATE NAME,SOURCE FILE,DESTINATION FILE,DESTINATION FIELD",!
 f file=0:0 s file=$o(outputData(file)) q:'file  d
 . f dstFile=0:0 s dstFile=$o(outputData(file,dstFile)) q:'dstFile  d
 .. f dstField=0:0 s dstField=$o(outputData(file,dstFile,dstField)) q:'dstField  d
 ... n data s data=outputData(file,dstFile,dstField)
 ... s dibtIEN=$p(data,U,1)
 ... s dibtName=$p(data,U,2)
 ... w dibtIEN_c_dibtName_c_file_c_dstFile_c_dstField,!
 d CLOSE^%ZISH("file1")
 quit
 ;
DIETCOL(outputData,mCodeData) ; [Private] Input Template Data Collection
 ; for each template
 ; s outputData(file,thisFile,thisField)=dibt_U_name
 n diet f diet=0:0 s diet=$o(^DIE(diet)) q:'diet  do
 . quit:'$data(^DIE(diet,0))                 ; get valid ones only
 . new name s name=$p(^DIE(diet,0),U)
 . new file s file=$p(^DIE(diet,0),U,4)
 . ;
 . ; for each file in the input template
 . n line f line=0:0 s line=$o(^DIE(diet,"DR",line)) q:line>98  q:line=""  do  ; 99 is reserved for some compiled code
 .. n lineFile f lineFile=0:0 s lineFile=$o(^DIE(diet,"DR",line,lineFile)) q:'lineFile  q:(lineFile'=+lineFile)  do
 ... n fields s fields=^DIE(diet,"DR",line,lineFile)
 ... n fieldIndex,field f fieldIndex=1:1:$l(fields,";") do
 .... s field=$piece(fields,";",fieldIndex)
 .... ; various tests for the field
 .... i field="" quit       ; empty field. Can happen!
 .... ;
 .... ; FROM X+2^DIA3: Get M field and check it
 .... N X S X=field
 .... i X'?.E1":" S X=$S(X["//^":$P(X,"//^",2),1:X),X=$S(X[";":$P(X,";"),1:X) D ^DIM
 .... i $d(X) s mCodeData(lineFile,line)=X quit
 .... ;
 .... ; We analyzed the M code; now we just want the dependencies
 .... if lineFile=file quit  ; DR file same as our file; not interested
 .... if $$PARENT(lineFile)=file quit  ; ditto, for parent
 .... ;
 .... ; range like .01:5
 .... i $l(field,":")=2,(+$p(field,":"))=$p(field,":") do  quit
 ..... n start s start=$p(field,":",1)
 ..... n end     s end=$p(field,":",2)
 ..... i $data(^DD(lineFile,start)) s outputData(file,lineFile,start)=diet_U_name
 ..... n eachField s eachField=start
 ..... f  s eachField=$o(^DD(lineFile,eachField)) q:eachField>end  q:eachField=""  do
 ...... s outputData(file,lineFile,eachField)=diet_U_name
 .... ;
 .... i $e(field)="@" quit  ; jump to another place in the template. Not a field
 .... s field=+field
 .... i '$data(^DD(lineFile,field)) quit  ; field doesn't exist
 .... s outputData(file,lineFile,field)=diet_U_name
 quit
 ;
DIETOUT(outputData,outputPath,outputFile) ; [Private] Input Template Data Output
 n POP
 d OPEN^%ZISH("file1",outputPath,outputFile,"W")
 i POP quit
 u IO
 n file,dstFile,dstField,dietIEN,dietName
 n c s c=","
 w "INPUT TEMPLATE IEN,INPUT TEMPLATE NAME,SOURCE FILE,DESTINATION FILE,DESTINATION FIELD",!
 f file=0:0 s file=$o(outputData(file)) q:'file  d
 . f dstFile=0:0 s dstFile=$o(outputData(file,dstFile)) q:'dstFile  d
 .. f dstField=0:0 s dstField=$o(outputData(file,dstFile,dstField)) q:'dstField  d
 ... n data s data=outputData(file,dstFile,dstField)
 ... s dietIEN=$p(data,U,1)
 ... s dietName=$p(data,U,2)
 ... w dietIEN_c_dietName_c_file_c_dstFile_c_dstField,!
 d CLOSE^%ZISH("file1")
 quit
 ;
DIPTCOL(outputData,mCodeData) ; [Private] Print Template Data Collection
 ; for each template
 n dipt f dipt=0:0 s dipt=$o(^DIPT(dipt)) q:'dipt  d
 . quit:'$data(^DIPT(dipt,0))                 ; get valid ones only
 . new name s name=$p(^DIPT(dipt,0),U)
 . new file s file=$p(^DIPT(dipt,0),U,4)
 . ;
 . d:$t(^XTMLOG)]"" INITEASY^XTMLOG("C","WARN")
 . ; debug
 . ; b:name="ZBJM FEE BASIS LIST"
 . ; debug
 . ;
 . ; for each field
 . new fileNamePrint set fileNamePrint=1
 . new line f line=0:0 s line=$o(^DIPT(dipt,"F",line)) q:'line  do
 .. new lineContents s lineContents=^DIPT(dipt,"F",line)
 .. new fieldDataIndex for fieldDataIndex=1:1:$l(lineContents,"~") do
 ... new fieldData set fieldData=$p(lineContents,"~",fieldDataIndex)
 ... quit:fieldData=""
 ... n fields s fields=$p(fieldData,";")
 ... quit:fields=""
 ... quit:fields=" "
 ... ;
 ... ; analyze the fields
 ... ;
 ... ; See if we have a multiple navigation. These are noted in the first piece
 ... ; as a series of numbers like 50,1,2,5...
 ... ; don't process these any further if we find them
 ... ; We don't process them as they mean we don't branch out to other files
 ... ; --we just trace our own file down.
 ... n fieldsUpright s fieldsUpright=1
 ... n fieldIndex f fieldIndex=1:1:$l(fields,",") do  q:'fieldsUpright
 .... n field s field=$p(fields,",",fieldIndex)
 .... i field'=+field!(field<0) s fieldsUpright=0
 ... i fieldsUpright D:$t(^XTMLOG)]"" DEBUG^XTMLOG("Qutting since upright","name,file,fieldData") quit
 ... ;
 ... ; Exclude transition lines
 ... ; We are not interested in the lines that switch files (e.g. in 52: 'PROVIDER:')
 ... n ignoreTransition s ignoreTransition=0
 ... n fieldIndex f fieldIndex=1:1:$l(fields,",") do  q:ignoreTransition
 .... n field s field=$p(fields,",",fieldIndex)
 .... n nextField s nextField=$p(fields,",",fieldIndex+1)
 .... i $e(nextField)=U set ignoreTransition=1 quit
 ... i ignoreTransition D:$t(^XTMLOG)]"" DEBUG^XTMLOG("Quitting due to context transistion with no fields","name,file,fieldData") quit
 ... ;
 ... ; If zpiece is defined, then we have a COMPUTED EXPRESSION or M code
 ... n Zpiece s Zpiece=0
 ... n i f i=1:1:$l(fieldData,";") i $p(fieldData,";",i)="Z" s Zpiece=i quit
 ... ;
 ... ; exclude print only fields (quoted values, or literal $C)
 ... n printOnlyField s printOnlyField=0
 ... i 'Zpiece n fieldIndex f fieldIndex=1:1:$l(fields,",") do  q:printOnlyField
 .... n field s field=$p(fields,",",fieldIndex)
 .... i +field=field quit  ; numeric -- quit -- not a literal
 .... i $e(field)="""" s printOnlyField=1
 .... i $e(field,1,5)="W $C(" s printOnlyField=1
 ... i printOnlyField d:$t(^XTMLOG)]"" DEBUG^XTMLOG("Quitting for printOnlyField","name,file,fieldData,printOnlyField") quit
 ... ;
 ...  ; This can be a "hidden" M field masqurading
 ... n isNonTradMCode s isNonTradMCode=0
 ... if 'Zpiece do
 .... n p1 s p1=$p(fields,",")
 .... i +p1=p1 quit  ; Just a normal field
 .... N X S X=$P(fields,";") D ^DIM
 .... I $D(X) s isNonTradMCode=1
 .... D:$t(^XTMLOG)]"" WARN^XTMLOG("Treating Print Field as M code","file,fieldData")
 .... set mCodeData(+file,line)=X
 ... ;
 ... ; Don't process any further if non-Traditional M code
 ... quit:isNonTradMCode
 ... ;
 ... ; Now, process non-M code fields
 ... ; Best template to test this with: MAGV-PAT-QUERY
 ... ; NB: This is a recursive search; each search updates the pointerFile variable
 ... ; We only want the last entry in the pointerFile chain to file the data if there
 ... ; is a field we want to grab
 ... n pointerFile s pointerFile=0
 ... if 'Zpiece n fieldIndex f fieldIndex=1:1:$l(fields,",") do
 .... n field s field=$p(fields,",",fieldIndex)
 .... n nextField s nextField=$p(fields,",",fieldIndex+1)
 .... i field<0 s pointerFile=-field quit
 .... i field>0,'pointerFile quit  ; field in original file. We are not interested
 .... d ASSERT(+pointerFile=pointerFile)
 .... d ASSERT(+field=field)
 .... d:$t(^XTMLOG)]"" INFO^XTMLOG("Num Parsed as:","fieldData,pointerFile,field")
 .... i field>0,pointerFile s outputData(file,pointerFile,field)=dipt_U_name
 ... if 'Zpiece quit  ; can't quit on the for line above
 ... ;
 ... ; Now, process M code/Copmputed code fields.
 ... new exitEarly set exitEarly=0
 ... ;
 ... ; We are really interested in capturing the computed field information
 ... ; (Z piece stuff only)
 ... ; Calculate the correct context for the Computed Expression
 ... n mCodeContext s mCodeContext=file ; The default
 ... n mCode s mCode=""
 ... n fileField,fileFieldIndex
 ... f fileFieldIndex=1:1:$l(fields,",") do  q:mCode]""
 .... s fileField=$p(fields,",",fileFieldIndex)
 .... i fileField'=+fileField s mCode=$p(fields,",",fileFieldIndex,99) quit
 .... ;
 .... ; Relational navigation
 .... i fileField<0 s mCodeContext=-fileField quit
 .... ;
 .... ; Subfile processing. Move context to subfile
 .... i '$d(^DD(mCodeContext,fileField,0)) set exitEarly=1 do  quit  ; doesn't exist!
 ..... D:$t(^XTMLOG)]"" WARN^XTMLOG("^DD("_mCodeContext_","_fileField_",0) does not exist")
 .... i fileField>0,$P(^DD(mCodeContext,fileField,0),U,2) s mCodeContext=+$P(^DD(mCodeContext,fileField,0),U,2) quit
 ... q:exitEarly
 ... d:$t(^XTMLOG)]"" DEBUG^XTMLOG("Context for "_fieldData_" is "_mCodeContext_" and M code is "_mCode)
 ... ;
 ... ; debug
 ... ; w mCodeContext,!
 ... ; debug
 ... ;
 ... ;
 ... ; Get the potentially COMPUTED EXPRESSION code for this field
 ... n potComputedCode s potComputedCode=$p(fieldData,";",Zpiece+1)
 ... s potComputedCode=$e(potComputedCode,2,$l(potComputedCode)-1)
 ... ;
 ... ; If M Code is broken up, put it back together
 ... i $f(mCode,"X DXS") do
 .... n startdxs s startdxs=$f(mCode,"DXS")-3
 .... n enddxs s enddxs=$f(mCode,")",startdxs)-1
 .... n dxsString s dxsString=$e(mCode,startdxs,enddxs)
 .... n s1,s2
 .... s s1=$qs(dxsString,1)
 .... s s2=$qs(dxsString,2)
 .... n dxsCode s dxsCode=^DIPT(dipt,"DXS",s1,s2)
 .... n % s %("X "_dxsString)=dxsCode
 .... s mCode=$$REPLACE^XLFSTR(mCode,.%)
 ... ;
 ... ; Is it the same (after removing the quotes) as the MCode?
 ... ; If so, then this is not a computed expression
 ... ; We can abandon hope of finding what field it refers to.
 ... i potComputedCode=mCode do  quit
 .... set mCodeData(+file,line)=mCode
 .... d:$t(^XTMLOG)]"" INFO^XTMLOG(fieldData_" in "_file_" considered to be M code")
 ...
 ... ; debug
 ...
 ... ; At this point, we think it's a computed expression.
 ... ; Lets try to to see
 ... n X
 ... d EXPR^DICOMP(mCodeContext,"dmFITSL",potComputedCode)
 ... i '$d(X) D:$t(^XTMLOG)]"" ERROR^XTMLOG("Can't resolve "_fieldData_" into fields (context "_mCodeContext_", name "_name_")") quit
 ... i X("USED")="" quit  ; not an expression that uses fields (NOW, PAGE)
 ... ;
 ... n pairs,pair f pairs=1:1:$l(X("USED"),";") d
 .... s pair=$p(X("USED"),";",pairs)
 .... n thisFile  s thisFile=$p(pair,U,1)
 .... n thisField s thisField=$p(pair,U,2)
 .... i thisFile=file quit
 .... s outputData(file,thisFile,thisField)=dipt_U_name
 D:$t(^XTMLOG)]"" ENDLOG^XTMLOG()
 quit
 ;
DIPTOUT(outputData,outputPath,outputFile) ; [Private] Print Template Data Output
 n POP
 d OPEN^%ZISH("file1",outputPath,outputFile,"W")
 i POP quit
 u IO
 n file,dstFile,dstField,dietIEN,dietName
 n c s c=","
 w "PRINT TEMPLATE IEN,PRINT TEMPLATE NAME,SOURCE FILE,DESTINATION FILE,DESTINATION FIELD",!
 f file=0:0 s file=$o(outputData(file)) q:'file  d
 . f dstFile=0:0 s dstFile=$o(outputData(file,dstFile)) q:'dstFile  d
 .. f dstField=0:0 s dstField=$o(outputData(file,dstFile,dstField)) q:'dstField  d
 ... n data s data=outputData(file,dstFile,dstField)
 ... s dietIEN=$p(data,U,1)
 ... s dietName=$p(data,U,2)
 ... w dietIEN_c_dietName_c_file_c_dstFile_c_dstField,!
 d CLOSE^%ZISH("file1")
 quit
 ;
 ; DIETM and DIPTM are used by XINDEX to process input and sort templates
 ; respectively. XINDEX passes required parameters through the stack instead
 ; passed variables.
 ;
 ; B = {IEN}
 ; INDLC = {counter}
 ; INDRN = {faux routine prefix}
 ; INDC = {IEN} ; {NAME} - {DISPLAY NAME}
 ; INDX = {code to be XINDEXED}
 ; INDL = {NAME field (.01) of IEN}
DIETM ; [Public] Collect M code fileds from all input templates
 ; ZEXCEPT: B,INDX
 quit:'$data(^DIE(B,0))                 ; get valid ones only
 new name s name=$p(^DIE(B,0),U)
 new file s file=$p(^DIE(B,0),U,4)
 ;
 ; for each file in the input template
 n line f line=0:0 s line=$o(^DIE(B,"DR",line)) q:line>98  q:line=""  do  ; 99 is reserved for some compiled code
 . n lineFile f lineFile=0:0 s lineFile=$o(^DIE(B,"DR",line,lineFile)) q:'lineFile  q:(lineFile'=+lineFile)  do
 .. n fields s fields=^DIE(B,"DR",line,lineFile)
 .. n fieldIndex,field f fieldIndex=1:1:$l(fields,";") do
 ... s field=$piece(fields,";",fieldIndex)
 ... ; various tests for the field
 ... i field="" quit       ; empty field. Can happen!
 ... ;
 ... ; FROM X+2^DIA3: Get M field and check it
 ... N X S X=field
 ... i X'?.E1":" S X=$S(X["//^":$P(X,"//^",2),1:X),X=$S(X[";":$P(X,";"),1:X) D ^DIM
 ... ; Add code to be INDEXed
 ... i $d(X) s INDX=X d ADDLN^XINDX11
 quit
 ;
DIPTM ; [Public] Collect M code fields from all print templates
 ; ZEXCEPT: B,INDX
 quit:'$data(^DIPT(B,0))                 ; get valid ones only
 new name s name=$p(^DIPT(B,0),U)
 new file s file=$p(^DIPT(B,0),U,4)
 ;
 ; for each field
 new fileNamePrint set fileNamePrint=1
 new line f line=0:0 s line=$o(^DIPT(B,"F",line)) q:'line  do
 . new lineContents s lineContents=^DIPT(B,"F",line)
 . new fieldDataIndex for fieldDataIndex=1:1:$l(lineContents,"~") do
 .. new fieldData set fieldData=$p(lineContents,"~",fieldDataIndex)
 .. quit:fieldData=""
 .. n fields s fields=$p(fieldData,";")
 .. quit:fields=""
 .. quit:fields=" "
 .. ;
 .. ; If zpiece is defined, then we have a COMPUTED EXPRESSION or M code
 .. n Zpiece s Zpiece=0
 .. n i f i=1:1:$l(fieldData,";") i $p(fieldData,";",i)="Z" s Zpiece=i quit
 .. ;
 .. ; This can be a "hidden" M field masqurading -- the entire line is M code
 .. ; NB: This is rare, but print templates support that.
 .. n isNonTradMCode s isNonTradMCode=0
 .. if 'Zpiece do
 ... n p1 s p1=$p(fields,",")
 ... i +p1=p1 quit  ; Just a normal field
 ... N X S X=$P(fields,";") D ^DIM
 ... ; Add code to be INDEXed
 ... I $D(X) s isNonTradMCode=1 s INDX=X d ADDLN^XINDX11 quit
 .. ;
 .. q:isNonTradMCode  ; We already have M code. Quit.
 .. ;
 .. q:'Zpiece  ; Straight field
 .. ;
 .. ; extract compiled code from file/subfile references
 .. n mCode s mCode=""
 .. n fileField,fileFieldIndex
 .. f fileFieldIndex=1:1:$l(fields,",") do  q:mCode]""
 ... s fileField=$p(fields,",",fileFieldIndex)
 ... i fileField'=+fileField s mCode=$p(fields,",",fileFieldIndex,99)
 .. ;
 .. i mCode="" quit  ; no compiled code in this field
 .. ;
 .. ; If zpiece is defined, see if computed expression or M code
 .. ; Get the potentially COMPUTED EXPRESSION code for this field
 .. n potComputedCode s potComputedCode=$p(fieldData,";",Zpiece+1)
 .. s potComputedCode=$e(potComputedCode,2,$l(potComputedCode)-1)
 .. ;
 .. ; If M Code is broken up, put it back together
 .. i $f(mCode,"X DXS") do
 ... n startdxs s startdxs=$f(mCode,"DXS")-3
 ... n enddxs s enddxs=$f(mCode,")",startdxs)-1
 ... n dxsString s dxsString=$e(mCode,startdxs,enddxs)
 ... n s1,s2
 ... s s1=$qs(dxsString,1)
 ... s s2=$qs(dxsString,2)
 ... n dxsCode s dxsCode=^DIPT(B,"DXS",s1,s2)
 ... n % s %("X "_dxsString)=dxsCode
 ... s mCode=$$REPLACE^XLFSTR(mCode,.%)
 .. ;
 .. ; Is it the same (after removing the quotes) as the MCode?
 .. ; If so, then this is not a computed expression
 .. i potComputedCode=mCode do  quit
 ... N X S X=mCode D ^DIM
 ... ; Add code to be INDEXed
 ... I $D(X) s INDX=X d ADDLN^XINDX11
 quit
 ;
PARENT(subfile) ; [Private] Find out who my parent is
 ; WARNING: Recursive algorithm
 if $data(^DD(subfile,0,"UP")) quit $$PARENT(^("UP"))
 quit subfile
 ;
ASSERT(x) i 'x s $EC=",u-assert,"
 ;
