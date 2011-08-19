MDXMLFM1 ; HOIFO/DP/NCA - Data -> XML Utilities ; [01-10-2003 09:14]
 ;;1.0;CLINICAL PROCEDURES;**6**;Apr 01, 2004;Build 102
 ; Integration Agreements:
 ; IA# 10035 [Supported] ^DPT references
 ;
 ; Special note: This routine assumes RESULTS contains the closed
 ;               root specification, ^TMP($J) where the output of
 ;               these calls will go.
 ;               i.e. S RESULTS=$NA(^TMP($J))
 ;
 ;               Calling app needs to call NEWDOC^MDXMLFM *ONCE*
 ;               to clear the global before building an XML document.
 ;
LOADALL(IENLIST,DD,FLDS) ; Load complete dataset
 ;
 ; Loads entire dataset from @IENLIST@(...)
 ;
 N MDIEN S MDIEN=0
 D NEWDOC("RESULTS")
 D XMLDATA("STATUS","OK")
 F  S MDIEN=$O(@IENLIST@(MDIEN)) Q:'MDIEN  S MDFDAT=$G(@IENLIST@(MDIEN)) D
 .D BLDXML(DD,MDIEN,.FLDS,MDFDAT)
 D ENDDOC("RESULTS")
 Q
 ;
LOADONE(IEN,DD,FLDS) ; Load single record as dataset
 ;
 ; Not to be used recursively
 ; Assumes complete data set is one record
 ;
 D NEWDOC("RESULTS")
 D XMLDATA("STATUS","OK")
 D BLDXML(DD,IEN,.FLDS)
 D ENDDOC("RESULTS")
 Q
 ;
LOADFILE(MDNUM,MDROOT,MDFLDS) ; Bulk load file MDNUM into XML
 ;
 ; Loads all records and all fields in the DD# MDNUM
 ; Optionally include a closed root of the index to use MDROOT
 ; Optionally include a list of fields #;#;#;# will default to "*"
 ;
 N MDIEN,MDNODE,MDIDS,MDTEMP,MDHDR,MDNAME
 S MDTEMP=$NA(^TMP("MD_TEMP",$J)) K @MDTEMP
 S MDNAME=$$GET1^DID(MDNUM,,,"NAME")
 I $G(MDROOT)]"" S:'$D(@MDROOT)#2 MDROOT=""
 S:$G(MDROOT)="" MDROOT=$$ROOT^DILFD(MDNUM,,1)
 S:$G(MDFLDS)="" MDFLDS="*"
 ;
 ; Load the records via Fileman GETS^DIQ
 ;
 S MDIEN=0
 F  S MDIEN=$O(@MDROOT@(MDIEN)) Q:'MDIEN  D
 .D GETS^DIQ(MDNUM,MDIEN_",",MDFLDS,"I",MDTEMP)
 ;
 ; Grab the tags and types if any records were processed
 ;
 S MDIEN=$O(@MDTEMP@(MDNUM,"")) D:MDIEN]""
 .F X=0:0 S X=$O(@MDTEMP@(MDNUM,MDIEN,X)) Q:'X  D
 ..S MDTAG=$$GET1^DID(MDNUM,X,,"LABEL")
 ..S MDTYPE=$$GET1^DID(MDNUM,X,,"TYPE")
 ..S MDPTR=$$GET1^DID(MDNUM,X,,"POINTER")
 ..S @MDTEMP@(MDNUM,0,X,"TAG")=$$TAGSAFE(MDTAG)
 ..S @MDTEMP@(MDNUM,0,X,"TYPE")=MDTYPE
 ..S @MDTEMP@(MDNUM,0,X,"PTR")=MDPTR
 ;
 ; Ok, lets add the file
 ;
 D XMLDATA("TABLENAME",MDNAME)
 S MDIENS=$O(@MDTEMP@(MDNUM,0))
 F  Q:MDIENS=""  D
 .D XMLHDR("RECORD")
 .S MDFLD=$O(@MDTEMP@(MDNUM,MDIENS,0))
 .F  Q:MDFLD=""  D
 ..S MDTAG=@MDTEMP@(MDNUM,0,MDFLD,"TAG")
 ..S MDATA=@MDTEMP@(MDNUM,MDIENS,MDFLD,"I")
 ..S MDTYPE=@MDTEMP@(MDNUM,0,MDFLD,"TYPE") D
 ...I MDTYPE["WORD" D XMLWP(MDTAG,MDATA) Q
 ...I MDTYPE["DATE" D XMLDT(MDTAG,MDATA) Q
 ...D XMLDATA(MDTAG,MDATA)
 ..S MDFLD=$O(@MDTEMP@(MDNUM,MDIENS,MDFLD))
 .D XMLFTR("RECORD")
 .S MDIENS=$O(@MDTEMP@(MDNUM,MDIENS))
 Q
 ;
BLDFLD(RESULTS,DD,FLDS) ; Add a field or field^field to the FLDS array
 F  D  Q:FLDS']""
 .S Y=$P(FLDS,"^",1),FLDS=$P(FLDS,"^",2,250)
 .S MDFLD=$P(Y,";",1) K RESULTS(MDFLD)
 .I $P(Y,";",2)]"" S RESULTS(MDFLD,"FORMAT")=$P(Y,";",2)
 .E  S RESULTS(MDFLD,"FORMAT")="I"
 .I $P(Y,";",3)]"" S RESULTS(MDFLD,"TAG")=$P(Y,";",3)
 .E  S RESULTS(MDFLD,"TAG")=$TR($$GET1^DID(DD,MDFLD,"","LABEL")," ","_")
 .I $P(Y,";",4)]"" S RESULTS(MDFLD,"TYPE")=$P(Y,";",4)
 .E  S RESULTS(MDFLD,"TYPE")=$$GET1^DID(DD,+MDFLD,"","TYPE")
 Q
 ;
BLDXML(DD,IEN,FLDS,MDFDAT) ; Builds an XML Record based on DD, IEN, and FLDS
 ; Note: this is a standalone module requiring DD and IEN
 ; so that it can be easily used by the custom query routines
 N MDFLD,MDIENS,MDKTR,X,Y
 D XMLHDR("RECORD")
 S MDIENS=IEN_",",MDFLD="",MDKTR=0
 F  S MDFLD=$O(FLDS(MDFLD)) Q:MDFLD=""  D
 .; .001 is always the IEN *IF* it is included in the view
 .I +MDFLD=.001 D XMLDATA(FLDS(MDFLD,"TAG"),+MDIENS) S MDKTR=MDKTR+1 Q
 .S MDFMT=$G(FLDS(MDFLD,"FORMAT"),"I")
 .; Process as a date
 .I $G(FLDS(MDFLD,"TYPE"))["DATE" D  Q
 ..S X=$$GET1^DIQ(DD,MDIENS,MDFLD,"I")
 ..I X]""&(MDFMT'="I") D  S X=Y
 ...S Y=($E(X,1,3)+1700)_"-"_$E(X,4,5)_"-"_$E(X,6,7) Q:X'["."
 ...S X=X+.0000001  ; Add it in ensure all the time parts
 ...S Y=Y_" "_$E(X,9,10)_":"_$E(X,11,12)_":"_$E(X,13,14)
 ..D XMLDATA(FLDS(MDFLD,"TAG"),X)
 .; Process as WP
 .I $G(FLDS(MDFLD,"TYPE"))["WORD" D  Q
 ..D XMLHDR(FLDS(MDFLD,"TAG"))
 ..S Y=$O(@RESULTS@(""),-1)+1
 ..S X=$$GET1^DIQ(DD,MDIENS,MDFLD,"",$NA(@RESULTS@(Y)))
 ..D XMLFTR(FLDS(MDFLD,"TAG"))
 .; Just return with specified data format
 .S MDKTR=MDKTR+1
 .D XMLDATA(FLDS(MDFLD,"TAG"),$P(MDFDAT,U,MDKTR))
 D XMLFTR("RECORD")
 Q
 ;
XMLCMT(COMMENT) ; Add a comment to a document
 D XMLADD("<!-- "_COMMENT_" -->")
 Q
 ;
XMLHDR(TAG) ; Add a header tag to the global
 S TAG=$$TAGSAFE(TAG)
 D XMLADD("<"_TAG_">")
 Q
 ;
XMLFTR(TAG) ; Add a footer tag to the global
 D XMLHDR("/"_TAG)
 Q
 ;
XMLDATA(TAG,X) ; Add a data element to the global
 S TAG=$$TAGSAFE(TAG)
 I $G(X)="" D XMLADD("<"_TAG_" />")
 E  D XMLADD("<"_TAG_">"_$$XMLSAFE(X)_"</"_TAG_">")
 Q
 ;
XMLPT(X) ; Add a standard pt identifier node
 S X(1,"NAME")=$P(^DPT(X,0),U)
 S X(2,"SSN")=$P(^DPT(X,0),U,9)
 S X(3,"SEX")=$P(^DPT(X,0),U,2)
 S Y=$P(^DPT(X,0),U,3)
 S Y(1)=1700+$E(Y,1,3),Y(2)=+$E(Y,4,5),Y(3)=+$E(Y,6,7)
 S X(4,"DOB_Y")=Y(1)
 S X(5,"DOB_M")=Y(2)
 S X(6,"DOB_D")=Y(3)
 D XMLIDS("PATIENT",.X,1)
 Q
 ;
XMLWP(TAG,X) ; Add text in array @X to the global
 S TAG=$$TAGSAFE(TAG)
 I $G(X)="" D XMLADD("<"_TAG_" />") Q  ; Empty global ref
 D XMLHDR(TAG)
 F Y=0:0 S Y=$O(@X@(Y)) Q:'Y  D XMLADD(@X@(Y))
 D XMLFTR(TAG)
 Q
 ;
XMLDT(TAG,X) ; Add date or date/time to the global
 S TAG=$$TAGSAFE(TAG)
 I $G(X)="" D XMLADD("<"_TAG_" />") Q  ; No data
 ; Build the ID array
 S X(1,"Y")=(1700+$E(X,1,3))
 S X(2,"M")=+$E(X,4,5)
 S X(3,"D")=+$E(X,6,7)
 D:X]"."
 .S X=X+.0000001
 .S X(4,"hh")=+$E(X,9,10)
 .S X(5,"mm")=+$E(X,11,12)
 .S X(6,"ss")=+$E(X,13,14)
 D XMLIDS(TAG,.X,1)
 Q
 ;
XMLIDS(TAG,IDS,CLOSE) ; Add a data element to the global with ids
 S TAG="<"_$$TAGSAFE(TAG)
 F X=0:0 S X=$O(IDS(X)) Q:'X  D
 .S Y="" F  S Y=$O(IDS(X,Y)) Q:Y=""  D
 ..S TAG=TAG_" "_Y_"="""_$$XMLSAFE(IDS(X,Y))_""""
 S:$G(CLOSE) TAG=TAG_" /" ; Close out the tag element
 S TAG=TAG_">"
 D XMLADD(TAG)
 Q
 ;
XMLADD(X) ; Add to the global
 S @RESULTS@($O(@RESULTS@(""),-1)+1)=$G(X)
 Q
 ;
ADDERR(X) ;
 S MDERROR($O(MDERR(""),-1)+1)=X
 Q
 ;
XMLOK(RESULTS) ; Build an XML OK message
 K @RESULTS
 S @RESULTS@(0)="<RESULTS>"
 S @RESULTS@(1)="<STATUS>OK</STATUS>"
 S @RESULTS@(2)="</RESULTS>"
 Q
 ;
XMLERR(ERRMSG) ; Build an XML error Message to return
 K @RESULTS
 S @RESULTS@(0)="<RESULTS>"
 S @RESULTS@(1)="<STATUS>ERROR</STATUS>"
 I $D(ERRMSG)=1 D  ; Simple one liner
 .S @RESULTS@(2)="<MESSAGE>"_$$XMLSAFE(ERRMSG)_"</MESSAGE>"
 I $D(ERRMSG)>2 D  ; Load the array into the XML message
 .S @RESULTS@(2)="<MESSAGE>"_$G(ERRMSG,"NO DESCRIPTION")
 .S X="ERRMSG" F  S X=$Q(@X) Q:X=""!(X'?1"ERRMSG(".E)  D
 ..S @RESULTS@($O(@RESULTS@(""),-1)+1)=$$XMLSAFE(@X)
 .S @RESULTS@($O(@RESULTS@(""),-1)+1)="</MESSAGE>"
 S @RESULTS@($O(@RESULTS@(""),-1)+1)="</RESULTS>"
 Q
 ;
XMLDATE(X) ; Transform Y into XML safe date
 N Y
 S Y=($E(X,1,3)+1700)_"-"_$E(X,4,5)_"-"_$E(X,6,7)
 D:X["."
 .S X=X+.0000001
 .S Y=Y_" "_$E(X,9,10)_":"_$E(X,11,12)_":"_$E(X,13,14)
 Q Y
 ;
XMLSAFE(X) ; Transform X into XML safe data
 S X=$$TRNSLT(X,"&","&amp;")
 S X=$$TRNSLT(X,"<","&lt;")
 S X=$$TRNSLT(X,">","&gt;")
 S X=$$TRNSLT(X,"'","&apos;")
 S X=$$TRNSLT(X,"""","&quot;")
 Q X
 ;
TAGSAFE(X) ; Transform X into XML tag
 S:X?1N.E X="_"_X  ; Remove starting numeric
 Q $TR(X," '`()<>*[]","__________")
 ;
NEWDOC(ROOT,COMMENT) ; Start a new document
 K @RESULTS
 D XMLADD("<?xml version=""1.0"" standalone=""yes""?>")
 I $G(COMMENT)]"" D XMLCMT(COMMENT)
 D XMLHDR($G(ROOT,"RESULTS"))
 Q
 ;
ENDDOC(ROOT) ; End this document
 D XMLFTR($G(ROOT,"RESULTS"))
 Q
 ;
TRNSLT(X,X1,X2) ; Translate every Y to Z in X
 N Y
 Q:X'[X1 X  ; Nothing to translate
 S Y="" F  Q:X=""  D
 .I X[X1 S Y=Y_$P(X,X1)_X2,X=$P(X,X1,2,250) Q
 .S Y=Y_X,X=""
 Q Y
 ;
