XINDX13 ; OSE/SMH - Input, Print, and Sort Template Analysis;03/01/2018  8:37 AM
 ;;7.3;TOOLKIT;**140**;Apr 25, 1995;Build 40
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine finds non-self files that are pointed to by a template
 ; EPs DIPTM and DIETM support XINDX12 in finding M code in Input and
 ; Print templates.
 ;
ALL(path) ; [Public] Export all template CSV files at once to a specific dir
 I $G(path)="" S path=$$DEFDIR^%ZISH()
 D DIBT(path),DIET(path),DIPT(path)
 Q
 ;
DIBT(path,filename) ; [Public] Sort template analysis
 N outputData
 I $G(path)="" S path=$$DEFDIR^%ZISH()
 I $G(filename)="" S filename="DIBTOUT.csv"
 D DIBTCOL(.outputData)
 D DIBTOUT(.outputData,path,filename)
 Q
 ;
DIET(path,filename) ; [Public] Input template analysis
 N outputData
 I $G(path)="" S path=$$DEFDIR^%ZISH()
 I $G(filename)="" S filename="DIETOUT.csv"
 D DIETCOL(.outputData)
 D DIETOUT(.outputData,path,filename)
 Q
 ;
DIPT(path,filename) ; [Public] Print template analysis
 N outputData
 I $G(path)="" S path=$$DEFDIR^%ZISH()
 I $G(filename)="" S filename="DIPTOUT.csv"
 D DIPTCOL(.outputData)
 D DIPTOUT(.outputData,path,filename)
 Q
 ;
DIBTCOL(outputData) ; [Private] Sort Template Data Collection
 ; for each template
 N dibt F dibt=0:0 S dibt=$O(^DIBT(dibt)) Q:'dibt  D
 . Q:'$D(^DIBT(dibt,0))  ; get valid ones only
 . N name,file,isSort,line
 . S name=$P(^DIBT(dibt,0),U),file=$P(^DIBT(dibt,0),U,4)
 . S isSort=$O(^DIBT(dibt,2,0)) ; make sure they are sort templates
 . I 'isSort Q
 . ;
 . ; walk through each field
 . F line=0:0 S line=$O(^DIBT(dibt,2,line)) Q:'line  D
 .. N lineData,lineFile,lineField,lineFieldSpec
 .. ; We have some variances on how the data is stored (lines below)
 .. S:$D(^DIBT(dibt,2,line))#2 lineData=^(line)
 .. S:$D(^DIBT(dibt,2,line,0))#2 lineData=^(0)
 .. ;
 .. ; some vital data
 .. S lineFile=$P(lineData,U)
 .. I '$D(^DD(lineFile)) Q  ; bad DD
 .. S lineField=$P(lineData,U,2),lineFieldSpec=$P(lineData,U,3)
 .. ;
 .. ; if it's the same file, and not a relational field, we are not interested
 .. I lineFile=file,(lineFieldSpec'[":"&(lineFieldSpec'[" IN ")) Q
 .. ;
 .. ; if the parent is the same file, and ditto, we are still not interested
 .. I $$PARENT(lineFile)=file,(lineFieldSpec'[":"&(lineFieldSpec'[" IN ")) Q
 .. ;
 .. ; We are interested
 .. ; Do we have the field?
 .. I lineField="" D
 ... ; no we don't so get the fields using DICOMP
 ... N X,pairs,pair
 ... D EXPR^DICOMP(lineFile,"dmFITSL",lineFieldSpec)
 ... I '$D(X) Q
 ... ; X("USED")="404.51^.07;404.57^.02"
 ... I X("USED")="" Q  ; not an expression that uses fields
 ... F pairs=1:1:$L(X("USED"),";") D
 .... S pair=$P(X("USED"),";",pairs)
 .... N thisFile,thisField
 .... S thisFile=$P(pair,U,1),thisField=$P(pair,U,2)
 .... I thisFile=file Q
 .... S outputData(file,thisFile,thisField)=dibt_U_name
 .. ; we have a field. Take it at face value
 .. E  S outputData(file,lineFile,lineField)=dibt_U_name
 Q
 ;
DIBTOUT(outputData,outputPath,outputFile) ; [Private] Sort Template Data Output
 N POP
 D OPEN^%ZISH("file1",outputPath,outputFile,"W")
 I POP Q
 U IO
 N c,file,dstFile,dstField,dibtIEN,dibtName
 S c=","
 W "SORT TEMPLATE IEN,SORT TEMPLATE NAME,SOURCE FILE,DESTINATION FILE,DESTINATION FIELD",!
 F file=0:0 S file=$Q(outputData(file)) Q:'file  D
 . F dstFile=0:0 S dstFile=$O(outputData(file,dstFile)) Q:'dstFile  D
 .. F dstField=0:0 S dstField=$O(outputData(file,dstFile,dstField)) Q:'dstField  D
 ... N data S data=outputData(file,dstFile,dstField)
 ... S dibtIEN=$P(data,U,1),dibtName=$P(data,U,2)
 ... W dibtIEN_c_dibtName_c_file_c_dstFile_c_dstField,!
 D CLOSE^%ZISH("file1")
 Q
 ;
DIETCOL(outputData,mCodeData) ; [Private] Input Template Data Collection
 ; for each template
 ; s outputData(file,thisFile,thisField)=dibt_U_name
 N diet F diet=0:0 S diet=$O(^DIE(diet)) Q:'diet  D
 . Q:'$D(^DIE(diet,0))  ; get valid ones only
 . N name,file,line,lineFile
 . S name=$P(^DIE(diet,0),U),file=$P(^DIE(diet,0),U,4)
 . ; for each file in the input template
 . F line=0:0 S line=$O(^DIE(diet,"DR",line)) Q:line>98!(line="")  D  ; 99 is reserved for some compiled code
 .. F lineFile=0:0 S lineFile=$O(^DIE(diet,"DR",line,lineFile)) Q:'lineFile!(lineFile'=+lineFile)  D
 ... N fields,fieldIndex,field
 ... S fields=^DIE(diet,"DR",line,lineFile)
 ... F fieldIndex=1:1:$L(fields,";") D
 .... S field=$P(fields,";",fieldIndex)
 .... ; various tests for the field
 .... Q:field=""  ; empty field. Can happen!
 .... ;
 .... ; FROM X+2^DIA3: Get M field and check it
 .... N X S X=field
 .... I X'?.E1":" S X=$S(X["//^":$P(X,"//^",2),1:X),X=$S(X[";":$P(X,";"),1:X) D ^DIM
 .... I $D(X) S mCodeData(lineFile,line)=X Q
 .... ;
 .... ; We analyzed the M code; now we just want the dependencies
 .... Q:lineFile=file  ; DR file same as our file; not interested
 .... Q:$$PARENT(lineFile)=file  ; ditto, for parent
 .... ;
 .... ; range like .01:5
 .... I $L(field,":")=2,(+$P(field,":"))=$P(field,":") D  Q
 ..... N start,end,eachField
 ..... S start=$P(field,":",1),end=$P(field,":",2)
 ..... I $D(^DD(lineFile,start)) S outputData(file,lineFile,start)=diet_U_name
 ..... S eachField=start
 ..... F  S eachField=$O(^DD(lineFile,eachField)) Q:eachField>end!(eachField="")  D
 ...... S outputData(file,lineFile,eachField)=diet_U_name
 .... ;
 .... Q:$E(field)="@"  ; jump to another place in the template. Not a field
 .... S field=+field
 .... Q:'$D(^DD(lineFile,field))  ; field doesn't exist
 .... S outputData(file,lineFile,field)=diet_U_name
 Q
 ;
DIETOUT(outputData,outputPath,outputFile) ; [Private] Input Template Data Output
 N POP
 D OPEN^%ZISH("file1",outputPath,outputFile,"W")
 I POP Q
 U IO
 N c,file,dstFile,dstField,dietIEN,dietName
 S c=","
 W "INPUT TEMPLATE IEN,INPUT TEMPLATE NAME,SOURCE FILE,DESTINATION FILE,DESTINATION FIELD",!
 F file=0:0 S file=$O(outputData(file)) Q:'file  D
 . F dstFile=0:0 S dstFile=$O(outputData(file,dstFile)) Q:'dstFile  D
 .. F dstField=0:0 S dstField=$O(outputData(file,dstFile,dstField)) Q:'dstField  D
 ... N data S data=outputData(file,dstFile,dstField)
 ... S dietIEN=$P(data,U,1),dietName=$P(data,U,2)
 ... W dietIEN_c_dietName_c_file_c_dstFile_c_dstField,!
 D CLOSE^%ZISH("file1")
 Q
 ;
DIPTCOL(outputData,mCodeData) ; [Private] Print Template Data Collection
 ; for each template
 N dipt F dipt=0:0 S dipt=$O(^DIPT(dipt)) Q:'dipt  D
 . Q:'$D(^DIPT(dipt,0))  ; get valid ones only
 . N name,file
 . S name=$P(^DIPT(dipt,0),U),file=$P(^DIPT(dipt,0),U,4)
 . ;
 . ;D:$T(^XTMLOG)]"" INITEASY^XTMLOG("C","WARN")
 . ; debug
 . ; b:name="ZBJM FEE BASIS LIST"
 . ; debug
 . ;
 . ; for each field
 . N fileNamePrint,line
 . S fileNamePrint=1
 . F line=0:0 S line=$O(^DIPT(dipt,"F",line)) Q:'line  D
 .. N lineContents,fieldDataIndex
 .. S lineContents=^DIPT(dipt,"F",line)
 .. F fieldDataIndex=1:1:$L(lineContents,"~") D
 ... N fieldData,fields
 ... S fieldData=$P(lineContents,"~",fieldDataIndex) Q:fieldData=""
 ... S fields=$P(fieldData,";")
 ... Q:fields=""!(fields=" ")
 ... ;
 ... ; analyze the fields
 ... ;
 ... ; See if we have a multiple navigation. These are noted in the first piece
 ... ; as a series of numbers like 50,1,2,5...
 ... ; don't process these any further if we find them
 ... ; We don't process them as they mean we don't branch out to other files
 ... ; --we just trace our own file down.
 ... N fieldsUpright,fieldIndex,field
 ... S fieldsUpright=1 F fieldIndex=1:1:$L(fields,",") D  Q:'fieldsUpright
 .... S field=$P(fields,",",fieldIndex)
 .... S:field'=+field!(field<0) fieldsUpright=0
 ... I fieldsUpright Q  ;D:$T(^XTMLOG)]"" DEBUG^XTMLOG("Qutting since upright","name,file,fieldData") Q
 ... ;
 ... ; Exclude transition lines
 ... ; We are not interested in the lines that switch files (e.g. in 52: 'PROVIDER:')
 ... N ignoreTransition,fieldIndex,field,nextField
 ... S ignoreTransition=0 F fieldIndex=1:1:$L(fields,",") D  Q:ignoreTransition
 .... S field=$P(fields,",",fieldIndex),nextField=$P(fields,",",fieldIndex+1)
 .... I $E(nextField)=U S ignoreTransition=1 Q
 ... I ignoreTransition Q  ;D:$T(^XTMLOG)]"" DEBUG^XTMLOG("Quitting due to context transistion with no fields","name,file,fieldData") Q
 ... ;
 ... ; If zpiece is defined, then we have a COMPUTED EXPRESSION or M code
 ... N Zpiece,i
 ... S Zpiece=0 F i=1:1:$L(fieldData,";") I $P(fieldData,";",i)="Z" S Zpiece=i Q
 ... ;
 ... ; exclude print only fields (quoted values, or literal $C)
 ... N printOnlyField
 ... S printOnlyField=0
 ... I 'Zpiece F fieldIndex=1:1:$L(fields,",") D  Q:printOnlyField
 .... S field=$P(fields,",",fieldIndex)
 .... Q:+field=field  ; numeric -- quit -- not a literal
 .... I $E(field)="""" S printOnlyField=1
 .... I $E(field,1,5)="W $C(" S printOnlyField=1
 ... I printOnlyField Q  ;D:$T(^XTMLOG)]"" DEBUG^XTMLOG("Quitting for printOnlyField","name,file,fieldData,printOnlyField") Q
 ... ;
 ...  ; This can be a "hidden" M field masqurading
 ... N isNonTradMCode S isNonTradMCode=0
 ... I 'Zpiece D
 .... N p1 S p1=$P(fields,",")
 .... Q:+p1=p1  ; Just a normal field
 .... N X S X=$P(fields,";") D ^DIM
 .... I $D(X) S isNonTradMCode=1
 .... ;D:$t(^XTMLOG)]"" WARN^XTMLOG("Treating Print Field as M code","file,fieldData")
 .... S mCodeData(+file,line)=X
 ... ;
 ... ; Don't process any further if non-Traditional M code
 ... Q:isNonTradMCode
 ... ;
 ... ; Now, process non-M code fields
 ... ; Best template to test this with: MAGV-PAT-QUERY
 ... ; NB: This is a recursive search; each search updates the pointerFile variable
 ... ; We only want the last entry in the pointerFile chain to file the data if there
 ... ; is a field we want to grab
 ... N pointerFile S pointerFile=0
 ... I 'Zpiece F fieldIndex=1:1:$L(fields,",") D
 .... N field,nextField
 .... S field=$P(fields,",",fieldIndex),nextField=$P(fields,",",fieldIndex+1)
 .... I field<0 S pointerFile=-field Q
 .... I field>0,'pointerFile Q  ; field in original file. We are not interested
 .... D ASSERT(+pointerFile=pointerFile)
 .... D ASSERT(+field=field)
 .... ;D:$T(^XTMLOG)]"" INFO^XTMLOG("Num Parsed as:","fieldData,pointerFile,field")
 .... I field>0,pointerFile S outputData(file,pointerFile,field)=dipt_U_name
 ... I 'Zpiece Q  ; can't quit on the for line above
 ... ;
 ... ; Now, process M code/Copmputed code fields.
 ... N exitEarly S exitEarly=0
 ... ;
 ... ; We are really interested in capturing the computed field information
 ... ; (Z piece stuff only)
 ... ; Calculate the correct context for the Computed Expression
 ... N mCodeContext,mCode
 ... S mCode="",mCodeContext=file ; The default
 ... N fileField,fileFieldIndex
 ... F fileFieldIndex=1:1:$L(fields,",") D  Q:mCode]""
 .... S fileField=$P(fields,",",fileFieldIndex)
 .... I fileField'=+fileField S mCode=$P(fields,",",fileFieldIndex,99) Q
 .... ;
 .... ; Relational navigation
 .... I fileField<0 S mCodeContext=-fileField Q
 .... ;
 .... ; Subfile processing. Move context to subfile
 .... I '$D(^DD(mCodeContext,fileField,0)) S exitEarly=1 D  Q  ; doesn't exist!
 ..... ;D:$T(^XTMLOG)]"" WARN^XTMLOG("^DD("_mCodeContext_","_fileField_",0) does not exist")
 .... I fileField>0,$P(^DD(mCodeContext,fileField,0),U,2) S mCodeContext=+$P(^DD(mCodeContext,fileField,0),U,2) Q
 ... Q:exitEarly
 ... ;D:$t(^XTMLOG)]"" DEBUG^XTMLOG("Context for "_fieldData_" is "_mCodeContext_" and M code is "_mCode)
 ... ;
 ... ; debug
 ... ; w mCodeContext,!
 ... ; debug
 ... ;
 ... ;
 ... ; Get the potentially COMPUTED EXPRESSION code for this field
 ... N potComputedCode S potComputedCode=$P(fieldData,";",Zpiece+1)
 ... S potComputedCode=$E(potComputedCode,2,$L(potComputedCode)-1)
 ... ;
 ... ; If M Code is broken up, put it back together
 ... I $F(mCode,"X DXS") D
 .... N startdxs,enddxs,dxsString,s1,s2,dxsCode,%
 .... S startdxs=$f(mCode,"DXS")-3,enddxs=$f(mCode,")",startdxs)-1,dxsString=$E(mCode,startdxs,enddxs)
 .... S s1=$QS(dxsString,1),s2=$QS(dxsString,2),dxsCode=^DIPT(dipt,"DXS",s1,s2)
 .... S %("X "_dxsString)=dxsCode,mCode=$$REPLACE^XLFSTR(mCode,.%)
 ... ;
 ... ; Is it the same (after removing the quotes) as the MCode?
 ... ; If so, then this is not a computed expression
 ... ; We can abandon hope of finding what field it refers to.
 ... I potComputedCode=mCode D  Q
 .... S mCodeData(+file,line)=mCode
 .... ;D:$T(^XTMLOG)]"" INFO^XTMLOG(fieldData_" in "_file_" considered to be M code")
 ...
 ... ; debug
 ...
 ... ; At this point, we think it's a computed expression.
 ... ; Lets try to to see
 ... N X
 ... D EXPR^DICOMP(mCodeContext,"dmFITSL",potComputedCode)
 ... I '$D(X) Q  ;D:$T(^XTMLOG)]"" ERROR^XTMLOG("Can't resolve "_fieldData_" into fields (context "_mCodeContext_", name "_name_")") Q
 ... Q:X("USED")=""  ; not an expression that uses fields (NOW, PAGE)
 ... ;
 ... N pairs,pair F pairs=1:1:$L(X("USED"),";") D
 .... S pair=$P(X("USED"),";",pairs)
 .... N thisFile,thisField
 .... S thisFile=$P(pair,U,1),thisField=$P(pair,U,2)
 .... Q:thisFile=file
 .... S outputData(file,thisFile,thisField)=dipt_U_name
 ;D:$T(^XTMLOG)]"" ENDLOG^XTMLOG()
 Q
 ;
DIPTOUT(outputData,outputPath,outputFile) ; [Private] Print Template Data Output
 N POP
 D OPEN^%ZISH("file1",outputPath,outputFile,"W")
 I POP Q
 U IO
 N c,file,dstFile,dstField,dietIEN,dietName
 S c=","
 W "PRINT TEMPLATE IEN,PRINT TEMPLATE NAME,SOURCE FILE,DESTINATION FILE,DESTINATION FIELD",!
 F file=0:0 S file=$O(outputData(file)) Q:'file  D
 . F dstFile=0:0 S dstFile=$O(outputData(file,dstFile)) Q:'dstFile  D
 .. F dstField=0:0 S dstField=$O(outputData(file,dstFile,dstField)) Q:'dstField  D
 ... N data S data=outputData(file,dstFile,dstField)
 ... S dietIEN=$P(data,U,1),dietName=$P(data,U,2)
 ... W dietIEN_c_dietName_c_file_c_dstFile_c_dstField,!
 D CLOSE^%ZISH("file1")
 Q
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
 Q:'$D(^DIE(B,0))  ; get valid ones only
 N name,file
 S name=$P(^DIE(B,0),U),file=$P(^DIE(B,0),U,4)
 ;
 ; for each file in the input template
 N line,lineFile
 F line=0:0 S line=$O(^DIE(B,"DR",line)) Q:line>98!(line="")  D  ; 99 is reserved for some compiled code
 . F lineFile=0:0 S lineFile=$O(^DIE(B,"DR",line,lineFile)) Q:'lineFile!(lineFile'=+lineFile)  D
 .. N fields,fieldIndex,field
 .. S fields=^DIE(B,"DR",line,lineFile) F fieldIndex=1:1:$L(fields,";") D
 ... S field=$P(fields,";",fieldIndex)
 ... ; various tests for the field
 ... Q:field=""  ; empty field. Can happen!
 ... ;
 ... ; FROM X+2^DIA3: Get M field and check it
 ... N X S X=field
 ... I X'?.E1":" S X=$S(X["//^":$P(X,"//^",2),1:X),X=$S(X[";":$P(X,";"),1:X) D ^DIM
 ... ; Add code to be INDEXed
 ... I $D(X) S INDX=X D ADDLN^XINDX11
 Q
 ;
DIPTM ; [Public] Collect M code fields from all print templates
 ; ZEXCEPT: B,INDX
 Q:'$D(^DIPT(B,0))                 ; get valid ones only
 N name,file,fileNamePrint,line
 S name=$P(^DIPT(B,0),U),file=$P(^DIPT(B,0),U,4)
 ;
 ; for each field
 S fileNamePrint=1
 F line=0:0 S line=$O(^DIPT(B,"F",line)) Q:'line  D
 . N lineContents,fieldDataIndex,fieldData,fields
 . S lineContents=^DIPT(B,"F",line)
 . F fieldDataIndex=1:1:$L(lineContents,"~") D
 .. S fieldData=$P(lineContents,"~",fieldDataIndex)
 .. Q:fieldData=""
 .. S fields=$P(fieldData,";")
 .. Q:fields=""!(fields=" ")
 .. ;
 .. ; If zpiece is defined, then we have a COMPUTED EXPRESSION or M code
 .. N i,Zpiece
 .. S Zpiece=0 F i=1:1:$L(fieldData,";") I $P(fieldData,";",i)="Z" S Zpiece=i Q
 .. ;
 .. ; This can be a "hidden" M field masqurading -- the entire line is M code
 .. ; NB: This is rare, but print templates support that.
 .. N isNonTradMCode S isNonTradMCode=0
 .. I 'Zpiece D
 ... N p1,X
 ... S p1=$P(fields,",") I +p1=p1 Q  ; Just a normal field
 ... S X=$P(fields,";") D ^DIM
 ... ; Add code to be INDEXed
 ... I $D(X) S isNonTradMCode=1 S INDX=X D ADDLN^XINDX11 Q
 .. ;
 .. Q:isNonTradMCode  ; We already have M code. Quit.
 .. ;
 .. Q:'Zpiece  ; Straight field
 .. ;
 .. ; extract compiled code from file/subfile references
 .. N mCode,fileField,fileFieldIndex
 .. S mCode=""
 .. F fileFieldIndex=1:1:$L(fields,",") D  Q:mCode]""
 ... S fileField=$P(fields,",",fileFieldIndex)
 ... I fileField'=+fileField S mCode=$P(fields,",",fileFieldIndex,99)
 .. ;
 .. I mCode="" Q  ; no compiled code in this field
 .. ;
 .. ; If zpiece is defined, see if computed expression or M code
 .. ; Get the potentially COMPUTED EXPRESSION code for this field
 .. N potComputedCode S potComputedCode=$P(fieldData,";",Zpiece+1)
 .. S potComputedCode=$E(potComputedCode,2,$L(potComputedCode)-1)
 .. ;
 .. ; If M Code is broken up, put it back together
 .. I $F(mCode,"X DXS") D
 ... N startdxs,enddxs,dxsString,s1,s2,dxsCode,%
 ... S startdxs=$F(mCode,"DXS")-3,enddxs=$F(mCode,")",startdxs)-1
 ... S dxsString=$E(mCode,startdxs,enddxs),s1=$QS(dxsString,1),s2=$QS(dxsString,2)
 ... S dxsCode=^DIPT(B,"DXS",s1,s2)
 ... S %("X "_dxsString)=dxsCode,mCode=$$REPLACE^XLFSTR(mCode,.%)
 .. ;
 .. ; Is it the same (after removing the quotes) as the MCode?
 .. ; If so, then this is not a computed expression
 .. I potComputedCode=mCode D  Q
 ... N X S X=mCode D ^DIM
 ... ; Add code to be INDEXed
 ... I $D(X) S INDX=X D ADDLN^XINDX11
 Q
 ;
PARENT(subfile) ; [Private] Find out who my parent is
 ; WARNING: Recursive algorithm
 I $D(^DD(subfile,0,"UP")) Q $$PARENT(^("UP"))
 Q subfile
 ;
ASSERT(x) I 'x S $EC=",u-assert,"
 Q
 ;
