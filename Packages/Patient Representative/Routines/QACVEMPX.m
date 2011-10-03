QACVEMPX ; OAKOIFO/TKW - Return Person Data, called by RPC ;9/25/07  14:14
 ;;2.0;Patient Representative;**19,21**;07/25/1995;Build 5
EN(PATSBY,LKUPVAL,PATSROWS,PATSFRM0,PATSFRM1)        ; Lookup Employee by Name, then
 ; Output XML formatted data from NEW PERSON file.
 ; PATSBY contains the name of the output array (pass by reference)
 ; LKUPVAL is the name of the person to be matched (LAST,FIRST), or
 ;         an array of Security Keys.
 ; PATSROWS=Number of rows to return in each call
 ; PATSFRM0=Employee Name value from previous call (empty on first call, pass by ref)
 ; PATSFRM1=Employee IEN from previous call (empty on first call, pass by ref)
 K ^TMP("DILIST",$J),^TMP("PatsPersonXml",$J)
 N STDNAME,ULASTNM,NAMECOMP,IENS,PIECE,OUTCNT,TAGLIST,FROM,PART,SRVIEN,MAILCODE,TITLE,SRVRSTA,PATSMORE,PATSERR,DIERR,I,J,X,Y
 ; If LKUPVAL exists, it contains an employee name, find partial matches.
 I $G(LKUPVAL)]"" D
 . S ULASTNM=$P(LKUPVAL,",")
 . D LOOKUP1
 . I (ULASTNM[" ")!(ULASTNM["'") D LOOKUP2
 . Q
 ; Else, it contains an array of Security Key values, find all
 ; holders of those keys.
 I $G(LKUPVAL)="" D
 . D EN^QACVKHLD(.LKUPVAL,PATSROWS,.PATSFRM0,.PATSFRM1)
 . S FROM(1)=$G(PATSFRM0),FROM(2)=$G(PATSFRM1)
 . S PATSMORE=$S(FROM(1)="":0,1:1)
 . Q
 I '$D(^TMP("DILIST",$J)),'$D(^TMP("DIERR",$J)) Q
 S PATSERR="" I $D(^TMP("DIERR",$J)) S PATSERR=$G(^TMP("DIERR",$J,1,"TEXT",1))
 ; Get Station Number of Institution where server resides (IA #1518)
 S SRVRSTA=$$STA^XUAF4(+$$GET1^DIQ(8989.3,1,217,"I"))
 ; Set name of output array into output parameter.
 S PATSBY=$NA(^TMP("PatsPersonXml",$J))
 ; Now build the output.
 D HDR
 S OUTCNT=2
 D EN2(.OUTCNT),FOOTER(.OUTCNT)
 Q
 ;
 ;
LOOKUP1 ; Use current routine to standardize the name (IA #3065)
 ; (name may contain spaces or apostrophes).
 S STDNAME=LKUPVAL
 I '$G(PATSROWS) S PATSROWS=10
 S PATSMORE=0
 I STDNAME["," S STDNAME=$$FORMAT^XLFNAME7(.STDNAME,1,35,,,,,1)
 E  S STDNAME=$$FORMAT^XLFNAME7(.STDNAME,1,35,,0,,1,1)
 ; If we've already found all matches to current standard, get out.
 N QOUT S QOUT=0
 I (ULASTNM[" ")!(ULASTNM["'") D  Q:QOUT
 . S X=$P($G(PATSFRM0),",")
 . Q:X=""
 . I (X[" ")!(X["'") Q
 . S QOUT=1 Q
 ; Get list of matching names.
 D GETLIST(STDNAME,PATSROWS,.PATSFRM0,.PATSFRM1,.PATSMORE,.FROM)
 Q
LOOKUP2 ; Use old routine to standardize the name (no punctuation
 ; except hyphens).)
 ; Quit if the maximum number of names has been found.
 Q:PATSMORE
 ; Convert user input using old standardization routine
 S STDNAME=LKUPVAL
 D STDNAME^XLFNAME(.STDNAME,"FG")
 ; Find enough names to fill the list
 N NEWROWS
 S NEWROWS=PATSROWS-$P($G(^TMP("DILIST",$J,0)),"^")
 ; If list is already full, see whether there are more names
 ; using the old standardization, then quit.
 I NEWROWS'>0 D  Q
 . I $D(^VA(200,"B",STDNAME)) S NEWROWS=1
 . E  S X=$O(^VA(200,"B",STDNAME)) I $E(X,1,$L(STDNAME))=STDNAME S NEWROWS=1
 . I NEWROWS=1 S PATSMORE=1,FROM(1)=STDNAME,FROM(2)=""
 . Q
 ; Save off names found using current name standardization.
 K ^TMP("QACOLD",$J)
 I $D(^TMP("DILIST",$J)) D
 . M ^TMP("QACOLD",$J)=^TMP("DILIST",$J)
 . K ^TMP("QACOLD",$J,0) Q
 K ^TMP("DILIST",$J)
 ; Get new list of matching names.
 D GETLIST(STDNAME,NEWROWS,.PATSFRM0,.PATSFRM1,.PATSMORE,.FROM)
 ; Merge the two lists into ^TMP("DILIST",$J).
 S I=$O(^TMP("QACOLD",$J,PATSROWS+1),-1)
 I I D
 . S X=$P($G(^TMP("DILIST",$J,0)),"^")
 . I X F J=1:1:X I $D(^TMP("DILIST",$J,J,0)) S ^TMP("QACOLD",$J,(I+J),0)=^TMP("DILIST",$J,J,0) K ^TMP("DILIST",$J,J,0)
 . M ^TMP("DILIST",$J)=^TMP("QACOLD",$J)
 . S $P(^TMP("DILIST",$J,0),"^")=X+I
 . K ^TMP("QACOLD",$J)
 . Q
 Q 
GETLIST(STDNAME,PATSROWS,PATSFRM0,PATSFRM1,PATSMORE,FROM) ; Get a list of names matching STDNAME
 N FIRST,LAST,LEN,SCR,CURRDT
 S LAST=$P(STDNAME,","),FIRST=$P(STDNAME,",",2,99)
 S CURRDT=$$DT^XLFDT()
 ; Screen out terminated users.
 S SCR="I ($P(^(0),""^"",11)=""""!(CURRDT<$P(^(0),""^"",11)))"
 ; If first name was passed, check for it with a screen.
 S LEN=$L(FIRST) I LEN>0 S SCR=SCR_",$E($P($P(^(0),""^""),"","",2,99),1,"_LEN_")="_""""_FIRST_""""
 ; Set the starting values, and partial match values.
 I $G(PATSFRM0)="" S FROM(1)=LAST,FROM(2)=""
 E  S FROM(1)=PATSFRM0,FROM(2)=$G(PATSFRM1)
 S PART(1)=LAST
 ; Return list of standard name pointer, title and mail code (IA #10060)
 D LIST^DIC(200,,"@;8;28","MP",PATSROWS,.FROM,.PART,"B",SCR)
 ; Set flag telling whether there are more entries to fetch).
 S PATSMORE=$S(FROM(1)="":0,1:1)
 Q
 ;
HDR ; Build header node
 S ^TMP("PatsPersonXml",$J,1)="<?xml version=""1.0"" encoding=""utf-8""?>"
 S ^TMP("PatsPersonXml",$J,2)="<PersonDataSet hasMore="""_PATSMORE_""" patsFrom0="""_FROM(1)_""" patsFrom1="""_FROM(2)_""" vistAError="""_PATSERR_""">"
 Q
 ;
EN2(OUTCNT) ; Build output for individual persons.
 N TAGLIST,IENS,TITLE,MAILCODE,NAMECOMP,I,J,X,Y
 ; Build list of XML tags to use in output.
 D BLDLST(.TAGLIST)
 ; Read through lister results and build output
 F I=0:0 S I=$O(^TMP("DILIST",$J,I)) Q:'I  S X=$G(^(I,0)) D
 . S OUTCNT=OUTCNT+1
 . S ^TMP("PatsPersonXml",$J,OUTCNT)="<PatsPerson>"
 . S IENS=$P(X,"^") Q:IENS=""  S IENS=IENS_","
 . ; NOTE: removes reserved XML characters (see $$SYMENC^MXMLUTL, IA#4153)
 . S TITLE=$$SYMENC^MXMLUTL($E($P(X,"^",2),1,30))
 . S MAILCODE=$$SYMENC^MXMLUTL($E($P(X,"^",3),1,30))
 . ; Get the individual name components and add them to the output (IA #3065)
 . K NAMECOMP
 . S NAMECOMP=$P($G(^VA(200,+IENS,0)),"^")
 . ; If name contains apostrophes or spaces, use current standardization
 . I ($P(NAMECOMP,",")["'")!($P(NAMECOMP,",")[" ") D
 .. S NAMECOMP=$$FORMAT^XLFNAME7(.NAMECOMP,1,35,,,,,2)
 .. S NAMECOMP=NAMECOMP("FAMILY")_"^"_NAMECOMP("GIVEN")_"^"_NAMECOMP("MIDDLE")_"^"_NAMECOMP("SUFFIX")
 .. Q
 . ; Else, use old standardization routine.
 . E  D
 .. K NAMECOMP S NAMECOMP("FILE")=200,NAMECOMP("FIELD")=.01,NAMECOMP("IENS")=IENS
 .. S NAMECOMP=$$HLNAME^XLFNAME(.NAMECOMP,"S")
 . F J=1:1:6 D
 .. S OUTCNT=OUTCNT+1
 .. S Y=$P(NAMECOMP,"^",J)
 .. S ^TMP("PatsPersonXml",$J,OUTCNT)="<"_TAGLIST(J)_">"_Y_"</"_TAGLIST(J)_">"
 .. Q
 . S OUTCNT=OUTCNT+1
 . S ^TMP("PatsPersonXml",$J,OUTCNT)="<Title>"_TITLE_"</Title>"
 . S OUTCNT=OUTCNT+1
 . S ^TMP("PatsPersonXml",$J,OUTCNT)="<MailCode>"_MAILCODE_"</MailCode>"
 . S OUTCNT=OUTCNT+1
 . S ^TMP("PatsPersonXml",$J,OUTCNT)="<VistaIen>"_$P(X,"^")_"</VistaIen>"
 . S OUTCNT=OUTCNT+1
 . S ^TMP("PatsPersonXml",$J,OUTCNT)="</PatsPerson>"
 . Q
 Q
 ;
FOOTER(OUTCNT) ; Add the footer
 S ^TMP("PatsPersonXml",$J,OUTCNT+1)="</PersonDataSet>"
 K ^TMP("DILIST",$J)
 Q
 ;
CONV(NAMEPART) ; Convert a name part to mixed case
 N LEN,TEMP,UPPER,I,X
 S LEN=$L(NAMEPART),UPPER=1,TEMP=""
 F I=1:1:LEN S X=$E(NAMEPART,I,I) D
 . I UPPER=1 D
 .. I X?1L S X=$C($A(X)-32)
 .. S UPPER=0 Q
 . E  I X?1U S X=$C($A(X)+32)
 . S TEMP=TEMP_X
 . I X'?1L,X'?1U S UPPER=1
 . Q
 Q TEMP
 ;
BLDLST(TAGLIST) ; Build list of XML data tags
 S TAGLIST(1)="LastName"
 S TAGLIST(2)="FirstName"
 S TAGLIST(3)="MiddleName"
 S TAGLIST(4)="NameSuffix"
 S TAGLIST(5)="NamePrefix"
 S TAGLIST(6)="Degree"
 Q
 ;
