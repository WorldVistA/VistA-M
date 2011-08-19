PXRMLOCL ; SLC/PKR - Handle location findings. ;08/27/2008
 ;;2.0;CLINICAL REMINDERS;**4,6,11**;Feb 04, 2005;Build 39
 ;This routine is for location list patient lists.
 ;=============================================
ALLLOCS(SUB) ;Build a list of all hospital locations associated
 ;with Visit file entries.
 N HLOC
 K ^TMP($J,SUB)
 S HLOC=""
 ;DBIA #2028
 F  S HLOC=$O(^AUPNVSIT("AHL",HLOC)) Q:HLOC=""  S ^TMP($J,SUB,HLOC)=""
 Q
 ;
 ;=============================================
EVALPL(FINDPA,ENODE,TERMARR,PLIST) ;Evaluate location term findings
 ;for patient lists. Return the list in ^TMP($J,PLIST)
 N BDT,EDT,ITEM,FILENUM,PFINDPA
 N STATUSA,TEMP,TFINDING,TFINDPA
 S FILENUM=$$GETFNUM^PXRMDATA(ENODE)
 S ITEM=""
 F  S ITEM=$O(TERMARR("E",ENODE,ITEM)) Q:+ITEM=0  D
 . S TFINDING=""
 . F  S TFINDING=$O(TERMARR("E",ENODE,ITEM,TFINDING)) Q:+TFINDING=0  D
 .. K PFINDPA,TFINDPA
 .. M TFINDPA=TERMARR(20,TFINDING)
 ..;Set the finding parameters.
 .. D SPFINDPA^PXRMTERM(.FINDPA,.TFINDPA,.PFINDPA)
 .. D GPLIST(FILENUM,"IP",ITEM,.PFINDPA,PLIST)
 Q
 ;
 ;=============================================
FPLIST(FILENUM,HLOCL,NOCC,BDT,EDT,PLIST) ;Find patient list data for
 ;a visit to a hospital location. Return the list in ^TMP($J,PLIST).
 N BTIME,DAS,DATE,DEND,DFN,DONE,DS,ETIME,HLOC,INVBD,INVDATE,INVDT,INVED
 N NFOUND,SC,TEMP,TGLIST,TIME
 S TGLIST="FPLIST_PXRMLOCL"
 K ^TMP($J,TGLIST)
 S DEND=$S(EDT[".":EDT,1:EDT+.235959)
 ;"AHL" in Visit file is inverse date_.time instead of a full inverse
 ;date and time. For example if the date/time is 3030704.104449 then
 ;"AHL" has 6969295.104449 instead of 6969295.89555
 S INVBD=9999999-$P(BDT,".",1),BTIME="."_$P(BDT,".",2)
 S INVED=9999999-$P(DEND,".",1),ETIME="."_$P(DEND,".",2)
 S DS=INVED-.000001
 S HLOC=""
 F  S HLOC=$O(^TMP($J,HLOCL,HLOC)) Q:HLOC=""  D
 . S INVDT=DS,DONE=0
 .;DBIA #2028
 . F  S INVDT=$O(^AUPNVSIT("AHL",HLOC,INVDT)) Q:(DONE)!(INVDT="")  D
 .. S INVDATE=$P(INVDT,".",1)
 .. I INVDATE>INVBD S DONE=1 Q
 .. S TIME="."_$P(INVDT,".",2)
 .. I INVDATE=INVED,TIME>ETIME Q
 .. I INVDATE=INVBD,TIME<BTIME Q
 .. S DAS=0
 .. F  S DAS=$O(^AUPNVSIT("AHL",HLOC,INVDT,DAS)) Q:DAS=""  D
 ...;Check the associated appointment for a valid status.
 ... I '$$VAPSTAT^PXRMVSIT(DAS) Q
 ... S TEMP=^AUPNVSIT(DAS,0)
 ... S DATE=$P(TEMP,U,1)
 ... S DFN=$P(TEMP,U,5)
 ... S SC=$P(TEMP,U,7)
 ... S ^TMP($J,TGLIST,DFN,INVDT,DAS)=DATE_U_HLOC_U_SC
 ;Return the NOCC most recent for each patient.
 S DFN=0
 F  S DFN=$O(^TMP($J,TGLIST,DFN)) Q:DFN=""  D
 . S (INVDT,NFOUND)=0
 . F  S INVDT=$O(^TMP($J,TGLIST,DFN,INVDT)) Q:(NFOUND=NOCC)!(INVDT="")  D
 .. S DAS=""
 .. F  S DAS=$O(^TMP($J,TGLIST,DFN,INVDT,DAS)) Q:(NFOUND=NOCC)!(DAS="")  D
 ... S NFOUND=NFOUND+1
 ... S ^TMP($J,PLIST,DFN,NFOUND)=DAS_U_^TMP($J,TGLIST,DFN,INVDT,DAS)
 K ^TMP($J,TGLIST)
 Q
 ;
 ;=============================================
GPLIST(FILENUM,SNODE,ITEM,PFINDPA,PLIST) ;Add to the patient list.
 ; Return the list in ^TMP($J,PLIST).
 ;^TMP($J,PLIST,T/F,DFN,IND,FILENUM)=DAS^DATE^HLOC^VALUE
 N BDT,CASESEN,COND,CONVAL,DAS,DATE,EDT,DFN,FIEVD,FLIST
 N ICOND,IEN,IND,IPLIST,LNAME,NOCC,NFOUND,NGET,NP,SAVE,STATUSA
 N TEMP,TGLIST,TPLIST,UCIFS,VALUE,VSLIST
 S TGLIST="GPLIST_PXRMLOCL"
 ;Set the finding search parameters.
 D SSPAR^PXRMUTIL(PFINDPA(0),.NOCC,.BDT,.EDT)
 ;Ignore negative occurrence count, date reversal not allowed in
 ;patient lists.
 S NOCC=$S(NOCC<0:-NOCC,1:NOCC)
 D SCPAR^PXRMCOND(.PFINDPA,.CASESEN,.COND,.UCIFS,.ICOND,.VSLIST)
 S NGET=$S(UCIFS:50,$D(STATUSA):50,1:NOCC)
 ;Get a list of unique locations.
 S LNAME=$P(^PXRMD(810.9,ITEM,0),U,1)
 I LNAME="VA-ALL LOCATIONS" D ALLLOCS("HLOCL")
 I LNAME'="VA-ALL LOCATIONS" D LOCLIST^PXRMLOCF(ITEM,"HLOCL")
 D FPLIST(FILENUM,"HLOCL",NGET,BDT,EDT,TGLIST)
 S DFN=""
 F  S DFN=$O(^TMP($J,TGLIST,DFN)) Q:DFN=""  D
 . K TPLIST
 . M TPLIST=^TMP($J,TGLIST,DFN)
 . S (IND,NFOUND)=0
 . K IPLIST
 . F  S IND=$O(TPLIST(IND)) Q:(IND="")!(NFOUND=NOCC)  D
 .. S TEMP=TPLIST(IND)
 .. S DAS=$P(TEMP,U,1)
 .. S DATE=$P(TEMP,U,2)
 .. D GETDATA^PXRMDATA(FILENUM,DAS,.FIEVD)
 .. S VALUE=$G(FIEVD("VALUE"))
 .. S FIEVD("DATE")=DATE
 .. S CONVAL=$S(COND'="":$$COND^PXRMCOND(CASESEN,ICOND,VSLIST,.FIEVD),1:1)
 .. S SAVE=$S('UCIFS:1,(UCIFS&CONVAL):1,1:0)
 .. I SAVE D
 ... S NFOUND=NFOUND+1
 ... S IPLIST(CONVAL,DFN,NFOUND,FILENUM)=TEMP_U_VALUE
 . M ^TMP($J,PLIST)=IPLIST
 K ^TMP($J,"HLOCL"),^TMP($J,TGLIST)
 Q
 ;
 ;=============================================
PCSTOPL ;Print the Clinic Stop list. Called by the print template PXRM
 ;LOCATION LIST INQUIRY.
 N AMIS,CSTEXL,CSTOP,EXCLNCS,IND,JND,SKIP,TEMP
 S (IND,SKIP)=0
 F  S IND=+$O(^PXRMD(810.9,D0,40.7,IND)) Q:IND=0  D
 . S TEMP=^PXRMD(810.9,D0,40.7,IND,0)
 . S CSTOP=$P(TEMP,U,1)
 .;DBIA #557
 . S CSTOP=$P(^DIC(40.7,CSTOP,0),U,1)
 . S AMIS=$P(TEMP,U,2)
 . I SKIP W ! S SKIP=0
 . W !,?2,CSTOP,?34,AMIS
 . I $D(^PXRMD(810.9,D0,40.7,IND,1)) D
 .. S SKIP=1
 .. W !,?4,"Credit Stops to Exclude:"
 .. S JND=0
 .. F  S JND=+$O(^PXRMD(810.9,D0,40.7,IND,1,JND)) Q:JND=0  D
 ... S TEMP=$P(^PXRMD(810.9,D0,40.7,IND,1,JND,0),U,1)
 ... S TEMP=$P(^DIC(40.7,TEMP,0),U,1,2)
 ... S CSTOP=$P(TEMP,U,1)
 ... S AMIS=$P(TEMP,U,2)
 ... W !,?6,CSTOP,?38,AMIS
 . S CSTEXL=$G(^PXRMD(810.9,D0,40.7,IND,2))
 . I CSTEXL'="" D
 .. W !,?4,"Credit Stops to Exclude (LIST): ",$P(^PXRMD(810.9,CSTEXL,0),U,1)
 . S EXCLNCS=+$G(^PXRMD(810.9,D0,40.7,IND,3))
 . W !,?4,"Exclude locations with no credit stop: ",$S(EXCLNCS:"YES",1:"NO")
 . S SKIP=1
 Q
 ;
