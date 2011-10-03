PXRMEUT1 ; SLC/PKR - General extract utilities ;07/14/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;=================================================
CLDATES ;Cleanup entries in ^TMP("PXRMDDOC",$J) before making date checks.
 ;For drug findings consolidate PS(55, PS(55NVA, and PSRX( back to
 ;PSDRUG(.
 N FI,FIND0,ITEM,GLOBAL,LIST
 S FIND0=""
 F  S FIND0=$O(^TMP("PXRMDDOC",$J,FIND0)) Q:FIND0=""  D
 . S FI=$P(FIND0,U,1)
 . S GLOBAL=$P(FI,";",2)
 . I GLOBAL'["PS" Q
 . S GLOBAL="PSDRUG("
 . S ITEM=$P(FI,";",1)
 . S FI=ITEM_";"_GLOBAL_U_$P(FIND0,U,2,11)
 . S LIST(FIND0)=FI
 ;
 S FIND0=""
 F  S FIND0=$O(LIST(FIND0)) Q:FIND0=""  D
 . S FI=LIST(FIND0)
 . S ^TMP("PXRMDDOC",$J,FI)=^TMP("PXRMDDOC",$J,FIND0)
 . K ^TMP("PXRMDDOC",$J,FIND0)
 Q
 ;
 ;=================================================
DAYSIM(FMDATE) ;Given a FileMan date return the number of days in the month.
 N MONTH
 S MONTH=$E(FMDATE,4,5)
 S DAYS=$S(MONTH="01":31,MONTH="02":28,MONTH="03":31,MONTH="04":30,MONTH="05":31,MONTH="06":30,MONTH="07":31,MONTH="08":31,MONTH="09":30,MONTH="10":31,MONTH="11":30,MONTH="12":31,1:"")
 I MONTH="02" D
 . N LYEAR,YEAR
 . S YEAR=$E(FMDATE,1,3)+1700
 . S LYEAR=$S((YEAR#4=0)&(YEAR#100'=0):1,YEAR#400=0:1,1:0)
 . I LYEAR S DAYS=29
 Q DAYS
 ;
 ;=================================================
DCONV(DATE,LBBDT,LBEDT) ;Convert dates to actual values.
 I DATE=0 Q DATE
 N PXRMDATE
 S PXRMDATE=$S(DATE["BDT":LBBDT,1:LBEDT)
 S DATE=$$STRREP^PXRMUTIL(DATE,"BDT","T")
 Q $$CTFMD^PXRMDATE(DATE)
 ;
 ;=================================================
DOCDATES(RULESET,LBBDT,LBEDT,NL,OUTPUT) ;
 N EM,FRACT,FRDATA,FRDATES,FRIEN,FRLST,FRLIEN,FROLST,FROUT,FRPAT
 N FRPERM,FRSTRT,FRTIEN,FRTYP,FSEQ,OPER,PXRMFVPL
 N RRIEN,RSDATA,RSDATES,RBDT,REDT,SEQ,SUB
 I $G(PXRMDDOC)=2 D CLDATES
 ;Build the variable pointer list.
 D BLDRLIST^PXRMVPTR(811.902,.01,.PXRMFVPL)
 S SEQ="",NL=0
 F  S SEQ=$O(^PXRM(810.4,RULESET,30,"B",SEQ)) Q:'SEQ  D
 . S SUB=$O(^PXRM(810.4,RULESET,30,"B",SEQ,"")) Q:'SUB
 . S RSDATA=$G(^PXRM(810.4,RULESET,30,SUB,0)) Q:RSDATA=""
 . S OPER=$P(RSDATA,U,3)
 . S OPER=$$EXTERNAL^DILFD(810.41,.03,"",OPER,.EM)
 . S RSDATES=$G(^PXRM(810.4,RULESET,30,SUB,1))
 .;Finding rule ien.
 . S FRIEN=$P(RSDATA,U,2) Q:'FRIEN
 .;Check if entry is a finding rule (not a set or reminder rule)
 . S FRDATA=$G(^PXRM(810.4,FRIEN,0)),FRTYP=$P(FRDATA,U,3) Q:FRTYP=3
 . S FRDATES=$P(FRDATA,U,4,5)
 .;Get term IEN for finding rule
 . I FRTYP=1 S FRTIEN=$P(FRDATA,U,7) Q:'FRTIEN
 .;Get Reminder definition IEN for Reminder rule
 . I FRTYP=2 S RRIEN=$P(FRDATA,U,10) Q:'RRIEN
 .;Determine RBDT and REDT
 . D RDATES(RSDATES,FRDATES,LBBDT,LBEDT,.RBDT,.REDT)
 . S NL=NL+1,OUTPUT(NL)=""
 . S NL=NL+1,OUTPUT(NL)="SEQUENCE "_SEQ_" "_$P(FRDATA,U,1)
 . S NL=NL+1,OUTPUT(NL)=" Operation: "_OPER
 .;Term finding rules
 . I FRTYP=1 D TERM(FRTIEN,LBBDT,LBEDT,RBDT,REDT,.PXRMFVPL,.NL,.OUTPUT)
 .;Reminder Definition List Rule
 . I FRTYP=2 D REM(RRIEN,LBBDT,LBEDT,RBDT,REDT,.PXRMFVPL,.NL,.OUTPUT)
 Q
 ;
 ;=================================================
FMULPRT(FARR,PXRMFVPL,NL,OUTPUT) ;Print the finding multiple
 ;information.
 N BDT,EDT,DERROR,FNAME,FTYPE,IND,LC,NOCC,NOUT
 N TBDT,TEDT,TEMP,TEXTIN,TEXTOUT,VPTR
 S IND=0
 F  S IND=+$O(FARR(20,IND)) Q:IND=0  D
 . S VPTR=$P(FARR(20,IND,0),U,1)
 . S FNAME=$$ENTRYNAM^PXRMPTD2(VPTR)
 . S FTYPE=$$FTYPE^PXRMPTD2(VPTR,1)
 . S TEXTIN="FINDING "_IND_"-"_FTYPE_"."_FNAME
 . D FORMATS^PXRMTEXT(3,78,TEXTIN,.NOUT,.TEXTOUT)
 . F LC=1:1:NOUT S NL=NL+1,OUTPUT(NL)=TEXTOUT(LC)
 .;Set the finding parameters.
 . D SSPAR^PXRMUTIL(FARR(20,IND,0),.NOCC,.BDT,.EDT)
 . S NL=NL+1,OUTPUT(NL)="   Beginning Date/Time: "_$$FMTE^XLFDT(BDT,"5Z")
 . S NL=NL+1,OUTPUT(NL)="   Ending Date/Time:    "_$$FMTE^XLFDT(EDT,"5Z")
 . I $G(PXRMDDOC)'=2 Q
 . S DERROR=0
 . S TEMP=$G(^TMP("PXRMDDOC",$J,$P(FARR(20,IND,0),U,1,11)))
 .;If TEMP is null then no evaluation was required and the check 
 .;cannot be made
 . I TEMP="" Q
 . I $P(TEMP,U,1)'=BDT D
 .. S DERROR=1
 .. S NL=NL+1,OUTPUT(NL)="  There is a consistency problem with the beginning date!"
 .. S NL=NL+1,OUTPUT(NL)="  Date used to build the list was: "_$$FMTE^XLFDT($P(TEMP,U,1),"5Z")
 . I $P(TEMP,U,2)'=EDT D
 .. S DERROR=1
 .. S NL=NL+1,OUTPUT(NL)="  There is a consistency problem with the ending date!"
 .. S NL=NL+1,OUTPUT(NL)="  Date used to build the list was: "_$$FMTE^XLFDT($P(TEMP,U,2),"5Z")
 . I DERROR D
 .. S NL=NL+1,OUTPUT(NL)="  Please notify the developers."
 .. ;S NL=NL+1,OUTPUT(NL)="  Please enter a Remedy ticket."
 .. S NL=NL+1,OUTPUT(NL)=" "
 Q
 ;
 ;=================================================
RDATES(RSDATES,FRDATES,LBBDT,LBEDT,RBDT,REDT) ;Determine the beginning and
 ;ending dates.
 ;Date precedence: LIST BUILD < RULE SET < FINDING RULE < TERM/REMINDER
 S RBDT=$P(FRDATES,U,1),REDT=$P(FRDATES,U,2)
 I RBDT="",REDT="" S RBDT=$P(RSDATES,U,1),REDT=$P(RSDATES,U,2)
 I RBDT="",REDT="" S RBDT=LBBDT,REDT=LBEDT
 I RBDT="" S RBDT=0
 I REDT="" S REDT=LBEDT
 I REDT=0 S REDT=DT
 ;Convert RBDT and REDT to FileMan dates.
 S RBDT=$$DCONV(RBDT,LBBDT,LBEDT)
 S REDT=$$DCONV(REDT,LBBDT,LBEDT)
 ;If the month is missing use January for the beginning date and
 ;December for the ending date.
 I $E(RBDT,4,5)="00" S RBDT=$E(RBDT,1,3)_"01"_$E(RBDT,6,7)
 I $E(REDT,4,5)="00" S REDT=$E(REDT,1,3)_"12"_$E(REDT,6,7)
 ;If the day is missing use the first for beginning date and the end
 ;of the month for ending date.
 I $E(RBDT,6,7)="00" S RBDT=$E(RBDT,1,5)_"01"
 I $E(REDT,6,7)="00" S REDT=$E(REDT,1,5)_$$DAYSIM(REDT)
 Q
 ;
 ;=================================================
REM(IEN,LBBDT,LBEDT,RBDT,REDT,PXRMFVPL,NL,OUTPUT) ;
 N DEFARR
 D DEF^PXRMLDR(IEN,.DEFARR)
 D DATES^PXRMRUL1(LBBDT,LBEDT,RBDT,REDT,.DEFARR)
 S NL=NL+1,OUTPUT(NL)=" REMINDER DEFINITION "_$P(DEFARR(0),U,1)
 D FMULPRT(.DEFARR,.PXRMFVPL,.NL,.OUTPUT)
 Q
 ;
 ;=================================================
TERM(IEN,LBBDT,LBEDT,RBDT,REDT,PXRMFVPL,NL,OUTPUT) ;
 N TERMARR
 D TERM^PXRMLDR(IEN,.TERMARR)
 D DATES^PXRMRUL1(LBBDT,LBEDT,RBDT,REDT,.TERMARR)
 S NL=NL+1,OUTPUT(NL)=" TERM "_$P(TERMARR(0),U,1)
 D FMULPRT(.TERMARR,.PXRMFVPL,.NL,.OUTPUT)
 Q
 ;
