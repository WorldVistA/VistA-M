VBECDCU ;hoifo/gjc-data conversion & pre-implementation utilities;Nov 21, 2002
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$GTF^%ZISH is supported by IA: 2320
 ;Call to $$EXTERNAL^DILFD is supported by IA: 2055
 ;Call to GETS^DIQ is supported by IA: 2056
 ;Call to GETICN^MPIF001 is supported by IA: 2701
 ;Call to $$FMTE^XLFDT is supported by IA: 10103
 ;Call to SETUP^XQALERT is supported by IA: 10081
 ;Call to GETS^DIQ is supported by IA: 10060
 ;Call to ^DIR is supported by IA: 10026
 ;Call to $$FMADD^XLFDT is supported by IA: 10103
 ;
GTF(VBECGR,VBECIS,VBECF) ; save off data stored in a global to a VMS
 ; or NT/2000 file.
 ; input: VBECGR=global reference
 ;        VBECIS=Identifies the incrementing subscript level. For
 ;               example, if you pass ^TMP(115,1,1,0) as the global
 ;               reference parameter, and pass 3 as the incr_subsc
 ;               parameter, $$GTF will increment the third subscript,
 ;               ^TMP(115,1,x), but will read nodes at the full global
 ;               reference ^TMP(115,1,x,0).
 ;         VBECF=Name of the file where the data is to reside.
 ; output: 1=success, 0=failure
 ;
 ; Here's an example (from the Hines development account) on how the
 ; the call works: S Y=$$GTF^%ZISH($NA(^TMP("VBEC NP",$J,1,0)),3,
 ; "SYS$USER:[CEBE]","ZZNP.TXT")
 S VBECP=$P($G(^VBEC(6000,1,0)),U,6) ; VBECP=file path
 ;
 Q $$GTF^%ZISH(VBECGR,VBECIS,VBECP,VBECF)
 ;
DELETE(VBECY) ; purge the ^TMP("VBEC*",$J) global
 ; input: VBECY=$J or process id, or zero to kill along all processes.
 S VBECY=+$G(VBECY),VBECX="VBEC FINI"
 F  S VBECX=$O(^TMP(VBECX)) Q:VBECX=""!(VBECX]"VBEC63 zzz")  D  Q:'VBECYN
 .I '$D(VBECYN)#2 D  Q:'VBECYN
 ..K DIR,DTOUT,DUOUT,DIRUT
 ..S DIR(0)="Y",DIR("A")="Are you sure you want to delete the temporary globals"
 ..S DIR("B")="No",DIR("?")="Answer 'Yes' to delete globals, or 'No' forgo global deletion." D ^DIR S VBECYN=Y
 ..S:$D(DIRUT)#2 VBECYN=0
 ..Q
 .W !,"Killing ^TMP("""_VBECX_""""
 .W $S(VBECY>0:","_VBECY_")",1:")")
 .K:VBECY ^TMP(VBECX,VBECY) K:'VBECY ^TMP(VBECX)
 .H 1
 .Q
 W:'$D(VBECYN)#2 !!,"No data to delete."
 W:$D(VBECYN)#2 !!,"Done..." K VBECX,VBECY,VBECYN,X,Y
 Q
 ;
NP200(IEN) ; gather New Person information in order to populate
 ; the appropriate SQL Server table on the VBECS side.
 ; Name, SSN, Termination Date, & Division are the attributes returned.
 ; Input: IEN the internal entry number of the New Person record.
 ; We'll be saving New Person (NP) data off in ^TMP("VBEC NP",$J) and
 ; plan to create our NP VMS file after all other VMS files are closed.
 Q:IEN=""!(+IEN'=IEN)  K LRARY N LRSTR
 S LRTRMDT="" D GETS^DIQ(200,IEN_",",".01;9;9.2;16*","EI","LRARY")
 S LRNAME=LRARY(200,IEN_",",.01,"E")
 S LRSSN=LRARY(200,IEN_",",9,"E") S:LRSSN="" LRSSN="*"
 Q:($D(^TMP("VBECX NP",$J,IEN,LRNAME,LRSSN)))#2  ; data already exists
 S:LRARY(200,IEN_",",9.2,"I")'="" LRTRMDT=$$DATE(LRARY(200,IEN_",",9.2,"I"))
 I ($D(LRARY(200.02))\10) D
 .S LRA="" F  S LRA=$O(LRARY(200.02,LRA)) Q:LRA=""  D
 ..S DIVPTR=LRARY(200.02,LRA,.01,"I")
 ..S DIVNAME=LRARY(200.02,LRA,.01,"E")
 ..S CNT=$$CNT("VBEC NP",$J),CNT=CNT+1
 ..S LRSTR=IEN_"^"_LRNAME_"^"_LRSSN_"^"_LRTRMDT_"^"_DIVPTR_"^"_DIVNAME
 ..S VBECTOT("VBEC NP")=+$G(VBECTOT("VBEC NP"))+1
 ..S ^TMP("VBEC NP",$J,CNT,0)=LRSTR_$C(13)
 ..S ^TMP("VBECX NP",$J,IEN,LRNAME,LRSSN)=""
 ..Q
 .Q
 E  D
 .S CNT=$$CNT("VBEC NP",$J),CNT=CNT+1
 .S LRSTR=IEN_"^"_LRNAME_"^"_LRSSN_"^"_"^"_LRTRMDT_"^^"
 .S VBECTOT("VBEC NP")=+$G(VBECTOT("VBEC NP"))+1
 .S ^TMP("VBEC NP",$J,CNT,0)=LRSTR_$C(13)
 .S ^TMP("VBECX NP",$J,IEN,LRNAME,LRSSN)=""
 .Q
 K CNT,DIVNAME,DIVPTR,LRA,LRNAME,LRSSN,LRTRMDT ; LRTRMDT=termination date
 K LRARY Q
 ;
XTRNL(LRFL,LRFD,LRFLG,LRINT) ; change data from its internal value
 ; to its external value.
 ; LRFL-file or subfile number   LRFLD-field number
 ; LRFLG-Output transform for pointer data. 'F' if the first field
 ;  in a pointer chain has a output transform, apply the transform
 ;  & quit.  'L' if the last field in a pointer chain has a output
 ;  transform, apply the transform & quit.  'U' if the first field
 ;  in a pointer chain has a output transform, apply the transform
 ;  to the last field in the pointer chain & quit.
 ;  function documented @ VA FileMan v22 Programmer Manual pg:2-171
 ;  LRINT-the internal value being converted.
 Q $$EXTERNAL^DILFD(LRFL,LRFD,LRFLG,LRINT)
 ;
DATE(LRDATE) ; date/time transformed.  Initial format created in order to
 ; handle an individual's date of birth, input in 'LRDATE', formatted
 ; 'mm/dd/yy<sp>time'.
 ;
 ; check for midnight date/time (yyymmdd.24) and convert it to
 ; a valid SQL Server date/time.  Example: if date/time is: 3030715.24
 ; convert to: 3030715.235959
 I $P(LRDATE,".",2)=24 S LRDATE=$$FMADD^XLFDT(LRDATE,0,0,0,-1)
 ;
 S LRMTH="^Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec"
 S LRDATE=$$FMTE^XLFDT(LRDATE,1),LRDATE=$TR(LRDATE,",","")
 S LRDATE=$TR(LRDATE,$P(LRDATE," "),$L($P(LRMTH,U_$P(LRDATE," ")),U))
 S LRDATE=$TR($P(LRDATE,"@")," ","/")_$S(LRDATE["@":"@"_$P(LRDATE,"@",2),1:"")
 Q $TR(LRDATE,"@"," ")
 ;
ALERT(DUZ,TSK,FLG,ABN) ;trigger an alert when the pre-implementation or
 ;data conversion finishes.
 ;Input: DUZ-The user initiating these tasks, and ultimately informed
 ;           when the process completes.
 ;       TSK-The task being executed; either the pre-implementation or
 ;           the data conversion.  '1' implies data conversion, '0'
 ;           implies the pre-implementation
 ;       FLG-status of data conversion: >0=anomalies, 0=no anomalies
 ;       ABN-flag to indicate if abnormal conditions exist, specifically
 ;           if the user stopped the process via TaskMan, or if data to
 ;           convert does not exist.  Input will be -1 for no data, and
 ;           "S" if the user stopped the process.
 ;
 K XQA,XQAMSG,XQAROU S XQA(DUZ)=""
 S XQAMSG="VBECS "_$S(TSK=0:"Anomaly Check",1:"Data Conversion")_" complete"
 S:ABN=-1 XQAMSG=XQAMSG_", data non-existent"
 S:ABN="S" XQAMSG=XQAMSG_", user terminated"
 I FLG=0 S XQAMSG=XQAMSG_", anomalies non-existent."
 I FLG>0 S XQAMSG=XQAMSG_", anomalies identified."
 D SETUP^XQALERT K XQA,XQAMSG,XQAROU
 Q
 ;
RPT(TSK) ;report header
 ; Input: TSK-The task being executed; either the pre-implementation or
 ;           the data conversion.  'DC' implies data conversion, 'PI'
 ;           implies the pre-implementation
 W:$E(IOST,1,2)="C-" @IOF
 S $P(VBECLN,"-",(IOM+1))=""
 W !,"VBECS "_$S(TSK="DC"=1:"data conversion",1:"pre-implementation")_" process",?$S(IOM=132:117,1:65),"Page 1 of 1",VBECLN
 Q
 ;
CNT(X,Y) ; return the value of a subscript
 ; Input: X=the name of the subscript, i.e., "VBEC63 DEM"
 ;        Y=$J
 Q +$O(^TMP(X,Y,999999999999),-1)
 ;
SWAP(LRF,LRP) ; swap the VistA pointer (or free-text blood supplier) data for
 ; the SQL GUID equivalent.  In the case that the entry is not mapped
 ; (VistA pointer has no corresponding SQL Server GUID), this utility
 ; returns null.
 ; input: LRF=file being mapped
 ;        LRP=VistA pointer value (IEN or record 'pointed to')
 ;return: null or a valid GUID
 ;
 Q:LRF="" "" Q:LRP="" "" N VBEC6005,VBEC6007
 I LRF'=66.01 S VBEC6005=$O(^VBEC(6005,"B",LRF_"-"_LRP,""))
 E  S VBEC6005=$O(^VBEC(6005,"AA",LRF,LRP,""))
 Q:VBEC6005="" ""
 S VBEC6007=$P($G(^VBEC(6005,VBEC6005,0)),U,5)
 Q:VBEC6007="" ""
 Q $P($G(^VBEC(6007,VBEC6007,0)),U,3)
 ;
BLUT(Y) ; obtain ABO GROUP (#.05) & RH TYPE (#.06) from Lab Data (#63) file
 S Y("ABO")=$P($G(^LR(Y,0)),U,5),Y("RH")=$E($P($G(^LR(Y,0)),U,6),1)
 ; note: we're interested 'n' for negative & 'p' for positive (1 char)
 Q Y("ABO")_U_Y("RH")
 ;
ICN(DFN) ; obtain the patient's ICN.  DFN is input, and either the ICN,
 ; if it exists, or null will be returned.
 ;   APIs used by this subroutine (in extrinsic function $$ICN)
 ; #2701-$$GETICN^MPIF001(DFN), this function returns the ICN
 S LRICN="" ; default to null
 I ($T(GETICN^MPIF001)'="") D
 .; the $$GETICN^MPIF001 returns delimited data.  If the ICN exists,
 .; it's returned as ICN_'V'_ICN checksum.  If it doesn't exist, it's
 .; returned as -1_'^'_error message.  We change -1 to null for SQL
 .S LRICN=$$GETICN^MPIF001(DFN),LRICN=$S($P(LRICN,"^")="-1":"",1:LRICN)
 .Q
 Q LRICN
 ;
