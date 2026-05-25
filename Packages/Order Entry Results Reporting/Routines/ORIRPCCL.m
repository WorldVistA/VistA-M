ORIRPCCL ; SLC/AGP - Information panel On-Click RPC ;Jun 11, 2025@12:22:01
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**508**;Dec 17, 1997;Build 39
 ;
 ;
 Q
 ;
GETCLICK(RESULTS,IJSON) ;
 N DARRAY,DFN,ERROR,IDS,INFOARRAY,INPUTS,ISNAT,LASTUPDATE,PKG,PKGIEN,SUB,SRCDATA,TARRAY,USER
 S SUB="ORIRPCCL CLICKEVENT"
 K ^TMP(SUB,$J)
 S RESULTS=$NA(^TMP(SUB,$J))
 D DECODE^XLFJSON("IJSON","INPUTS","ERROR")
 I $D(ERROR) D SETERROR(.TARRAY,"Problem decoding JSON document.") G ENX
 S (SRCDATA("sourceId"),IDS)=$G(INPUTS("id")) I IDS="" D SETERROR(.TARRAY,"Panel ids not found") G ENX
 S DFN=+$G(INPUTS("patientId")) I DFN=0 D SETERROR(.TARRAY,"Patient id not found.") G ENX
 S PKG=$G(INPUTS("package")) I PKG="" D SETERROR(.TARRAY,"Package name not found.") G ENX
 S USER=+$G(INPUTS("connectionUser")) I USER=0 D SETERROR(.TARRAY,"Connected user information not found.") G ENX
 S ISNAT=$S($G(INPUTS("isNational"))="true":1,$G(INPUTS("isNational"))="false":0,1:"") I ISNAT="" D SETERROR(.TARRAY,"Is national value not found.") G ENX
 S LASTUPDATE=+$G(INPUTS("lastUpdated"))
 I '$$GETINFOARRAY(.INFOARRAY,IDS,.TARRAY,LASTUPDATE) G ENX
 I '$$REQDATA(.INFOARRAY,.INPUTS,.TARRAY,.DARRAY) G ENX
 I '$$PROCESS(DFN,USER,IDS,PKG,SUB,.INFOARRAY,.DARRAY,.TARRAY,.INPUTS) G ENX
 S TARRAY("success")="true"
ENX ;
 K ^TMP(SUB,$J)
 D ENCODE^XLFJSON("TARRAY",$NA(^TMP(SUB,$J)),"ERROR")
 Q
 ;
GETINFOARRAY(INFOARRAY,IDS,TARRAY,LASTUPDATE) ;
 N LIDX,PIDX,PKIDX,TIDX,LD
 S TIDX=$P(IDS,";"),PKIDX=$P(IDS,";",2),LIDX=$P(IDS,";",3),PIDX=$P(IDS,";",4)
 ;additonal check to make sure can get to InfoPanel Section Button
 I TIDX=0 D SETERROR(.TARRAY,"Top level entry in file #101.71 not found.") Q 0
 I PKIDX=0 D SETERROR(.TARRAY,"Package level entry in file #101.71 entry "_$S(ISNAT=1:"National",1:"Local")_" not found.") Q 0
 I LIDX=0 D SETERROR(.TARRAY,"Location level entry in file #101.71 entry "_$S(ISNAT=1:"National",1:"Local")_"for package entry "_PKG_" not found.") Q 0
 I PIDX=0 D SETERROR(.TARRAY,"Panel level entry in file #101.71 entry "_$S(ISNAT=1:"National",1:"Local")_"for package entry "_PKG_" not found.") Q 0
 S LD=+$P($G(^ORI(101.71,TIDX,0)),U,3)
 ;I LASTUPDATE>0,LD>0,$$FMDIFF^XLFDT(LD,LASTUPDATE,2)>0 D SETERROR(.TARRAY,"Panels have been updated please try again.") S TARRAY("refreshAllInfoPanels")="true" Q 0
 M INFOARRAY=^ORI(101.71,TIDX,"PKG",PKIDX,"LOC",LIDX,"ITM",PIDX)
 Q 1
 ;
PROCESS(DFN,USER,IDS,PKG,SUB,INFOARRAY,DARRAY,RESULTS,INPUTS) ;
 N ACT,EID,ETYPE,IEN,IDX,MPIEN,NODE,REQDATA,RET,ROUTINE,RTN,TAG,TARRAY,TEMP,URL
 S ACT=$P(INFOARRAY(30),U)
 S ACT=$$GETCOMP^ORDD71(ACT)
 S EID=+$P($G(INFOARRAY(30)),U,5)
 I ACT="actShowEditor" Q $$GETEDITOR^OREDITOR(DFN,USER,IDS,PKG,EID,.DARRAY,.RESULTS)
 I ACT="actShowHTMLEditor" Q $$GETEDITOR^ORHEDITOR(DFN,USER,IDS,PKG,EID,.DARRAY,.RESULTS)
 M REQDATA("requiredData")=DARRAY
 S MPIEN=+$P(INFOARRAY(30),U,3)
 I ACT="actShowDetail"!(ACT="actShowMessage")&(MPIEN=0) D SETDETAILS(.INPUTS,.RESULTS) Q 1
 I ACT="actShowUrl",MPIEN=0 D SETURL(.INFOARRAY,.INPUTS,.RESULTS) Q 1
 Q:'MPIEN 0 ; ajb, hard error when no detail code set and CALL DETAIL RPC=YES
 ;S REQDATA("userId")=USER
 S RET=$$ONCLICKEXECODE^ORIUTL(SUB,DFN,USER,"ONCLICK",IDS,MPIEN,.REQDATA)
 I +RET<1 D SETERROR(.RESULTS,$P(RET,U,2)) Q 0
 I ACT="actShowUrl" S RESULTS("results")=$G(^TMP(SUB,$J,"CODE",IDS,"results",1)) Q 1
 S IDX=0 F  S IDX=$O(^TMP(SUB,$J,"CODE",IDS,"results",IDX)) Q:IDX'>0  D
 . S TARRAY(IDX)=^TMP(SUB,$J,"CODE",IDS,"results",IDX)_$C(13)_$C(10)
 M RESULTS("results","\")=TARRAY
 Q 1
 ;
REQDATA(INFOARRAY,INPUTS,ARRAY,DARRAY) ;
 N DIEN,DSIEN,DTYPE,DNAME,DVALUE,ERROR,FOUND,HASOPT,IEN,IDX,NODE
 N OPTARRAY,OPTFOUND,REQ,RESULT,RIDX,RIEN,TMP
 S RESULT=1
 I '$D(INPUTS("requiredData")) Q RESULT
 S RIDX=0,ERROR=""
 F  S RIDX=$O(INPUTS("requiredData",RIDX)) Q:RIDX'>0!(ERROR'="")  D
 .S DTYPE=$G(INPUTS("requiredData",RIDX,"dataType","name")) I DTYPE="" Q
 .S DIEN=+$O(^ORI(101.73,"G",DTYPE,"")) I DIEN=0 S ERROR="Could not find data type of "_DTYPE Q
 .K OPTARRAY
 .S DNAME="",OPTFOUND=0,HASOPT=0
 .F  S DNAME=$O(INPUTS("requiredData",RIDX,"dataType","data",DNAME)) Q:DNAME=""!(ERROR'="")  D
 .. S DVALUE=$G(INPUTS("requiredData",RIDX,"dataType","data",DNAME))
 .. S DSIEN=$O(^ORI(101.73,DIEN,40,"B",DNAME,"")) I DSIEN=0 S ERROR="Cannot find the data type of "_DNAME
 .. S REQ=$P($G(^ORI(101.73,DIEN,40,DSIEN,0)),U,2)
 .. S DARRAY(DTYPE,DNAME)=DVALUE
 .. I REQ="N"  Q
 .. I REQ="Y",DVALUE="" S ERROR="Value for "_DTYPE_" data property "_DNAME_" not found." Q
 .. I REQ="O" S HASOPT=1,OPTFOUND=$S(DVALUE'="":1,1:0),OPTARRAY(DNAME)=""
 .I HASOPT,'OPTFOUND D  Q
 ..S DNAME="",TMP=""
 ..F  S DNAME=$O(OPTARRAY(DNAME)) Q:DNAME=""  S TMP=TMP_$S(TMP'="":", ",1:"")_DNAME
 ..S ERROR="Value for "_DTYPE_" data propert"_$S($L(TMP,",")>1:"ies ",1:"y ")_TMP_" not found."
 ;Check database to validate the GUI is passing requried data back to VistA based off current file definition
 I ERROR="" D
 .S RIDX=0 F  S RIDX=$O(INFOARRAY("REQD",RIDX)) Q:RIDX'>0!(ERROR'="")  D
 ..S NODE=$G(INFOARRAY("REQD",RIDX,0)) I '+$P(NODE,U,2) Q
 ..S IEN=$P(NODE,U)
 ..S IDX=0,FOUND=0,TMP=""
 ..S DTYPE=$P($G(^ORI(101.73,IEN,0)),U,3) I DTYPE="" Q
 ..;check for at least one OR value is defined
 ..F  S IDX=$O(^ORI(101.73,IEN,40,"R","O",IDX)) Q:IDX'>0!(FOUND=1)  D
 ...S DNAME=$P($G(^ORI(101.73,IEN,40,IDX,0)),U) I DNAME="" Q
 ...I $G(DARRAY(DTYPE,DNAME))'="" S FOUND=1 Q
 ...S TMP=TMP_$S(TMP'="":", "_DNAME,1:DNAME)
 ..I 'FOUND,TMP'="" S ERROR="Value for "_DTYPE_" data propert"_$S($L(TMP,",")>1:"ies ",1:"y ")_TMP_" not found." Q
 ..;check for all required data is passed in
 ..S IDX=""
 ..F  S IDX=$O(^ORI(101.73,IEN,40,"R","Y",IDX)) Q:IDX'>0!(ERROR'="")  D
 ...S DNAME=$P($G(^ORI(101.73,IEN,40,IDX,0)),U) I DNAME="" Q
 ...I $G(DARRAY(DTYPE,DNAME))="" S ERROR="Value for "_DTYPE_" data property "_DNAME_" not found."
 I ERROR'="" D SETERROR(.ARRAY,ERROR) S RESULT=0
 Q RESULT
 ;
SETERROR(ARRAY,ERROR) ;
 S ARRAY("success")="false"
 S ARRAY("error")=ERROR
 Q
 ;
SETDETAILS(INPUTS,RESULTS) ;
 N DA,DATA,DFN,IDS
 S IDS=$G(INPUTS("id"))
 S DFN=+$G(INPUTS("patientId"))
 S DA(0)=$P(IDS,";"),DA(1)=$P(IDS,";",2),DA(2)=$P(IDS,";",3),DA(3)=$P(IDS,";",4)
 D DTEXT^ORIRPC(.DA,.DATA,DFN,"",1,"")
 M RESULTS("results","\")=DATA("presentation",1,"detailText","\")
 Q
 ;
SETURL(INFOARRAY,INPUTS,RESULTS) ;
 N DARRAY,DFN,IDX,NAME,TYPE,URL,VALUE
 M DARRAY=INPUTS("requiredData")
 S DFN=INPUTS("patientId")
 S URL=$P($G(INFOARRAY("URL")),U)
 S URL=$$STRREP^ORIUTL(URL,"%DFN",DFN)
 S IDX=0 F  S IDX=$O(DARRAY(IDX)) Q:IDX'>0  D
 .S TYPE=$G(DARRAY(IDX,"dataType","name"))
 .S NAME="" F  S NAME=$O(DARRAY(IDX,"dataType","data",NAME)) Q:NAME=""  D
 ..I NAME'="id" Q
 ..S VALUE=$G(DARRAY(IDX,"dataType","data",NAME))
 ..I TYPE="dataDivision" S URL=$$STRREP^ORIUTL(URL,"%DIVISION",VALUE) Q
 ..I TYPE="dataPort" S URL=$$STRREP^ORIUTL(URL,"%PORT",VALUE) Q
 ..I TYPE="dataServer" S URL=$$STRREP^ORIUTL(URL,"%SRV",VALUE) Q
 ..I TYPE="dataStationNumber" S URL=$$STRREP^ORIUTL(URL,"%STATION",VALUE) Q
 ..I TYPE="dataUserInformation" S URL=$$STRREP^ORIUTL(URL,"%DUZ",VALUE)
 I URL["%H" S URL=$$STRREP^ORIUTL(URL,"%H",$H)
 I URL["%J" S URL=$$STRREP^ORIUTL(URL,"%J",$J)
 S RESULTS("results")=URL
 Q
 ;
