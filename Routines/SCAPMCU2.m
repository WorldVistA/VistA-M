SCAPMCU2 ;ALB/REW - TEAM API UTILITIES ;6/29/99  19:40  ; Compiled May 29, 2007 15:16:13
 ;;5.3;Scheduling;**41,177,205,458**;AUG 13, 1993;Build 14
 ;;1.0
DTAFTER(FILE,IEN,STATUS,DATE) ;return next date after given one
 N SCX
 S SCX=-1
 G:('$G(FILE))!("^404.52^404.58^404.59^"'[$G(FILE))!('$G(IEN)) QTDTAF
 S ROOT="^SCTM("_FILE_",""AIDT"",IEN,STATUS)"
 S EFFDT=-DATE
 S SCX=$P($O(@ROOT@(EFFDT),-1),"-",2)
QTDTAF Q SCX
 ;
DTBEFORE(FILE,IEN,STATUS,DATE) ;return next date before given one
 N SCX
 S SCX=-1
 G:('$G(FILE))!("^404.52^404.58^404.59^"'[$G(FILE))!('$G(IEN)) QTDTBF
 S ROOT="^SCTM("_FILE_",""AIDT"",IEN,STATUS)"
 S EFFDT=-DATE
 S SCX=$P($O(@ROOT@(EFFDT)),"-",2)
QTDTBF Q SCX
 ;
ACTHISTB(FILE,IEN) ;boolean active function
 ;abbreviated form of call below - no error handling
 N X,SCACTB
 S X=+$$ACTHIST(.FILE,.IEN,"SCACTB")
 Q $S(X=1:1,1:0)
 ;
ACTHIST(FILE,IEN,SCDATES,SCERR,SCLIST) ;is entry active for a time period?
 ; Input Parameters:
 ;    File = either 404.52 or 404.58 or 404.59
 ;    IEN  = pointer to team(404.51) or team position(404.57)
 ;    SCDATES = (SEE PRIOR DEFINITION)
 ;    SCLIST  = Output array
 ;  Returned:
 ;  status (-1:error|0:inactive|1:active)^ien for file^actdt^inacdt
 ;          which ien depends on status
 ;
 N OK,X,ROOT,SCBEGIN,SCEND,SCINCL,SCDATE,SCA,SCDTS,SCE
 S OK=-1,X=""
 G:('$G(FILE))!("^404.52^404.53^404.58^404.59^"'[$G(FILE))!('$G(IEN)) QTACTH
 S ROOT="^SCTM("_FILE_",""AIDT"",IEN,SCSTAT"
 D INIT^SCAPMCU1(.OK) ; set default dates,output & error array (if undefined)
 IF 'OK S OK=-1 G QTACTH
 S SCDATE=SCEND
 S OK=0
 ;if incl=0 ->a partial hit should be returned
LOOP IF 'SCINCL D
 .F  S X=$$DATES^SCAPMCU1(.FILE,.IEN,.SCDATE) S SCA=$P(X,U,2),SCE=$P(X,U,3) D  Q:$P(X,U,5)!(SCE<SCBEGIN)!(OK=-1)
 ..IF 'X S SCDATE=SCA Q
 ..IF +X=1 D
 ...S OK=1
 ...S SCDATE=SCA-.000001
 ...Q:$D(@SCLIST@(FILE,"SCLST",IEN,SCA))
 ...S SCN=$G(@SCLIST@(FILE,0),0)+1
 ...S @SCLIST@(FILE,0)=SCN
 ...S @SCLIST@(FILE,SCN)=IEN_U_$$EXT(FILE,IEN)_U_SCA_U_$P(X,U,3)
 ...S @SCLIST@(FILE,"SCLST",IEN,SCA,SCN)=""
 ..ELSE  D
 ...S OK=-1
 ...S SCPARM("EFFECTIVE DATE")=$G(SCDATE,"Undefined")
 ...D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ELSE  D
 .S X=$$DATES^SCAPMCU1(.FILE,.IEN,.SCDATE)
 .IF X&($P(X,U,2)'>SCBEGIN) D
 ..S OK=1
 ..Q:$D(@SCLIST@(FILE,"SCLST",IEN,$P(X,U,2)))
 ..S SCN=$G(@SCLIST@(FILE,0),0)+1
 ..S @SCLIST@(FILE,0)=SCN
 ..S @SCLIST@(FILE,SCN)=IEN_U_$$EXT(FILE,IEN)_U_$P(X,U,2)_U_$P(X,U,3)
 ..S @SCLIST@(FILE,"SCLST",IEN,$P(X,U,2),SCN)=""
QTACTH Q OK_U_$P(X,U,4)_U_$P(X,U,2)_U_$P(X,U,3)
 ;
EXT(FILE,IEN) ;return external value of team or team position file
 N SCEXT
 S SCEXT=-1
 IF FILE=404.58 D
 .S SCEXT=$P($G(^SCTM(404.51,+$G(IEN),0)),U,1)
 .S:'$L(SCEXT) SCEXT=-1
 IF "^404.52^404.53^404.59^"[(U_FILE_U) D
 .S SCEXT=$P($G(^SCTM(404.57,+$G(IEN),0)),U,1)
 .S:'$L(SCEXT) SCEXT=-1
QTEXT Q SCEXT
 ;
GETPC(DFN,DATE,PCROLE,ASSTYPE) ;return pc position & team for a date
 ; DFN - pointer to patient file
 ; DATE - date of interest (Default=DT)
 ; PCROLE - Default=1 (PC Practitioner Position) note 2= pc attending
 ; ASSTYPE - Default=1 (PC Team)
 ; returns sctp^sctm^assigned to pc?
 ;
 N ACTDT,SCTP,SCTM,SCPTA,INACTDT
 Q $$GETPCTP(.DFN,.DATE,.PCROLE)_U_$$GETPCTM(.DFN,.DATE,.ASSTYPE)_U_($D(^SCPT(404.41,"APC",+DFN))>0)
 ;
HISTPTTP(DFN,SCTP,DATE) ;404.43 entry for pt,position - if active on date
 ;return -1 if error, 0 if no active entry or 404.43 ien if one
 Q:'$G(DFN)!('$G(SCTP))!('$G(DATE)) -1
 N SCACT,HISTIEN,SCINACT,SCDT
 S SCDT=DATE+.00000001
 S SCACT=+$O(^SCPT(404.43,"ADFN",DFN,SCTP,SCDT),-1)
 S HISTIEN=+$O(^SCPT(404.43,"ADFN",DFN,SCTP,SCACT,0))
 S SCINACT=$P($G(^SCPT(404.43,HISTIEN,0)),U,4)
 Q $S('SCACT:0,('HISTIEN):0,('SCINACT):HISTIEN,(DATE>SCINACT):0,1:HISTIEN)
 ;
HISTPTTM(DFN,SCTM,DATE) ;404.42 entry for tm,position - if active on date
 ; return -1 if error, 0 if no active entry or 404.42 entyr if one
 Q:'$G(DFN)!('$G(SCTM))!('$G(DATE)) -1
 N SCACT,HISTIEN,SCINACT,SCDT
 S SCDT=DATE+.00000001
 S SCACT=-$O(^SCPT(404.42,"AIDT",DFN,SCTM,-SCDT))
 S HISTIEN=+$O(^SCPT(404.42,"AIDT",DFN,SCTM,-SCACT,0))
 S SCINACT=$P($G(^SCPT(404.42,HISTIEN,0)),U,9)
 Q $S('SCACT:0,('HISTIEN):0,('SCINACT):HISTIEN,(DATE>SCINACT):0,1:HISTIEN)
 ;
GETPCTM(DFN,DATE,ASSTYPE) ;return pc team for a date
 ; DFN - pointer to patient file
 ; DATE - date of interest
 ; ASSTYPE - Default=1 (PC Team)
 ; returns sctm
 ;
 N ACTDT,SCTP,SCPTTMA,SCINDT,SCTM,SCGOOD
 S ASSTYPE=$G(ASSTYPE,1)
 S DATE=$G(DATE,DT)
 ; returns pointer to 404.51, if exists, 0 if not
 S ACTDT=+$O(^SCPT(404.42,"APCTM",+DFN,+ASSTYPE,(DATE+.000001)),-1)
 I 'ACTDT Q 0
 S SCTM=0,SCGOOD=0
 F  S SCTM=$O(^SCPT(404.42,"APCTM",+DFN,+ASSTYPE,+ACTDT,SCTM)) Q:SCTM=""  D  Q:SCGOOD 
 .S SCPTTMA=$O(^SCPT(404.42,"APCTM",+DFN,+ASSTYPE,+ACTDT,+SCTM,""),-1)
 .S SCINDT=$P($G(^SCPT(404.42,+SCPTTMA,0)),U,9)
 .I SCINDT="" S SCGOOD=1 Q 
 Q $S('SCINDT:+SCTM,(SCINDT'<DATE):+SCTM,1:0)
 ;
GETPCTP(DFN,DATE,PCROLE) ;return pc position for a date
 ; DFN - pointer to patient file
 ; DATE - date of interest
 ; PCROLE - Default=1 (PC Practitioner Position) note 2= pc attending
 ; returns sctp,or 0 if none or -1 if error
 ;
 N ACTDT,SCTP,SCTM,SCPTA,INACTDT,SCPTTPA,SCOK,TPLP,TPDALP
 S SCOK=1,SCTP=0
 S DATE=$G(DATE,DT)
 S PCROLE=$G(PCROLE,1)
 ; returns pointer to 404.57, if exists, 0 if not
 S ACTDT=+$O(^SCPT(404.43,"APCPOS",+DFN,+PCROLE,(DATE+.000001)),-1)
 F TPLP=0:0 S TPLP=$O(^SCPT(404.43,"APCPOS",+DFN,+PCROLE,+ACTDT,TPLP)) Q:TPLP=""!(SCTP=-1)  F TPDALP=0:0 S TPDALP=$O(^SCPT(404.43,"APCPOS",+DFN,+PCROLE,+ACTDT,TPLP,TPDALP)) Q:TPDALP=""  DO  Q:SCTP=-1
 .S INACTDT=$P($G(^SCPT(404.43,+TPDALP,0)),U,4)
 .;if already an active date then an error
 .I 'INACTDT S SCTP=$S(SCTP>0:-1,1:TPLP) Q
 .I INACTDT'<DATE S SCTP=$S(SCTP>0:-1,1:TPLP)
 .Q
 Q +SCTP
 ;
GETPRTP(SCTP,DATE) ;returns ien & name of practitioner filling position
 ;   Returned [Error:-1,Else: sc200^practname]
 N X,SCPRDTS,SCPR
 S DATE=$G(DATE,DT)
 S SCPRDTS("BEGIN")=DATE
 S SCPRDTS("END")=DATE
 S X=$$PRTP^SCAPMC(SCTP,"SCPRDTS","SCPR")
 Q $S(X<1:-1,1:$P($G(SCPR(1)),U,1)_U_$P($G(SCPR(1)),U,2))
 ;
EXTMPRTP(SCTP,DATE) ;returns external of team and practitioner for position
 ;
 N SCX
 S SCX=$$GETPRTP(.SCTP,.DATE)
 Q $P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+SCTP,0)),U,2),0)),U,1)_"   "_$P(SCX,U,2)
 ;
NMPCTP(DFN,DATE,PCROLE) ;returns ien & name of pc position
 ; (See GETPCTP for variables)
 N X
 S X=$$GETPCTP(DFN,.DATE,.PCROLE)
 Q $S('$G(X):"",X=-1:"",1:X_U_$P($G(^SCTM(404.57,+X,0)),U,1))
 ;
NMPCPR(DFN,DATE,PCROLE) ;returns ien & name of pract filling pc position
 ; DFN - pointer to patient file 
 ; DATE - date of interest 
 ; PCROLE - Practitioner Position where '1' = PC provider
 ;                                      '2' = PC attending 
 ;                                      '3' = PC associate provider
 ;
 ; returns sctp (ien^name), or "" if none or -1 if error 
 ; 
 N SCTP,PCAP
 ;bp/cmf 205 original code next line
 ;S PCAP=PCROLE S:PCROLE=3 PCROLE=1
 ;bp/cmf 205 change code begin
 ;;S PCROLE=+$G(PCROLE,1),(PCAP,PCROLE)=$S(PCROLE=0:1,PCROLE>2:1,1:PCROLE)
 S (PCROLE,PCAP)=+$G(PCROLE,1)
 S PCAP=$S(PCAP=0:1,PCAP>3:1,1:PCAP)
 S PCROLE=$S(PCROLE=0:1,PCROLE>2:1,1:PCROLE)
 ;bp/cmf 205 change code end
 S SCTP=+$$NMPCTP(.DFN,.DATE,.PCROLE)
 Q $S('SCTP:"",1:$$PCPROV^SCAPMCU3(SCTP,.DATE,PCAP))
 ;
NMPCTM(DFN,DATE,PCROLE) ;returns ien & name of pc team
 ; (See GETPCTM for variables)
 N X
 S X=$$GETPCTM(DFN,.DATE,.PCROLE)
 Q $S('$G(X):"",1:X_U_$P($G(^SCTM(404.51,+X,0)),U,1))
 ;
ALPHA(INARRAY,OUTARRAY) ;not supported - for PCMM only
 ; returns array sorted by 2nd piece's value
 ; it keeps the 0 node -it does not return any x-ref values
 ; it only converts arrays of type 1-n to another 1-n array
 N SCNDX,SCX,SCNODE,SCY
 S (SCX,SCY)=0
 S:$D(@INARRAY@(0)) @OUTARRAY@(0)=@INARRAY@(0)
 F  S SCX=$O(@INARRAY@(SCX)) Q:'SCX  S SCNODE=@INARRAY@(SCX) Q:'$L(SCNODE)  D
 .S ^TMP($J,"SCTMPSORT","B",$P(SCNODE,U,2),SCX)=""
 S SCNDX=""
 F  S SCNDX=$O(^TMP($J,"SCTMPSORT","B",SCNDX)) Q:SCNDX=""  D
 .S SCX=0
 .F  S SCX=$O(^TMP($J,"SCTMPSORT","B",SCNDX,SCX)) Q:'SCX  D
 ..S SCY=SCY+1
 ..S @OUTARRAY@(SCY)=$G(@INARRAY@(SCX))
 K ^TMP($J,"SCTMPSORT","B")
 Q
