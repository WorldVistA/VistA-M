ORWU ; SLC/KCM - General Utilites for Windows Calls; 2/28/01 [1/15/04 11:43am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85,132,148,149,187,195,215,243**;Dec 17, 1997;Build 242
 ;
DT(Y,X,%DT) ; Internal Fileman Date/Time
 ; change the '00:00' that could be passed so Fileman doesn't reject
 I $L($P(X,"@",2)),("00000000"[$TR($P(X,"@",2),":","")) S $P(X,"@",2)="00:00:01"
 S %DT=$G(%DT,"TS") D ^%DT K %DT
 Q
VALDT(Y,X,%DT) ; Validate date/time
 S:'$D(%DT) %DT="TX" D ^%DT
 Q
USERINFO(REC) ; Relevant info for current user
 ; return DUZ^NAME^USRCLS^CANSIGN^ISPROVIDER^ORDERROLE^NOORDER^DTIME^
 ;        COUNTDOWN^ENABLEVERIFY^NOTIFYAPPS^MSGHANG^DOMAIN^SERVICE^
 ;        AUTOSAVE^INITTAB^LASTTAB^WEBACCESS^ALLOWHOLD^ISRPL^RPLLIST^
 ;        CORTABS^RPTTAB^STANUM^GECSTATUS^PRODACCT
 N X,ORRPL,ORRPL1,ORRPL2,ORTAB,CORTABS,RPTTAB,ORDT,OREFF,OREXP,ORDATEOK
 S REC=DUZ_U_$P(^VA(200,DUZ,0),U)
 S $P(REC,U,3)=$S($D(^XUSEC("ORES",DUZ)):3,$D(^XUSEC("ORELSE",DUZ)):2,$D(^XUSEC("OREMAS",DUZ)):1,1:0)
 S $P(REC,U,4)=$D(^XUSEC("ORES",DUZ))&$D(^XUSEC("PROVIDER",DUZ))
 S $P(REC,U,5)=$D(^XUSEC("PROVIDER",DUZ))
 S $P(REC,U,6)=$$ORDROLE
 S $P(REC,U,7)=$$GET^XPAR("USR^SYS^PKG","ORWOR DISABLE ORDERING",1,"I")
 S $P(REC,U,8)=$$GET^XPAR("USR^SYS","ORWOR TIMEOUT CHART",1,"I")
 I '$P(REC,U,8),$G(DTIME) S $P(REC,U,8)=DTIME
 S $P(REC,U,9)=$$GET^XPAR("USR^SYS^PKG","ORWOR TIMEOUT COUNTDOWN",1,"I")
 S X=$$GET^XPAR("USR^SYS^PKG","ORWOR ENABLE VERIFY",1,"I")
 S $P(REC,U,10)=$S(X=1:1,X=2:0,1:'$P(REC,U,7))
 S $P(REC,U,11)=$$GET^XPAR("USR^SYS^PKG","ORWOR BROADCAST MESSAGES",1,"I")
 S $P(REC,U,12)=$$GET^XPAR("USR^SYS^PKG","ORWOR AUTO CLOSE PT MSG",1,"I")
 S $P(REC,U,13)=$$KSP^XUPARAM("WHERE")  ; domain
 S $P(REC,U,14)=+$G(^VA(200,DUZ,5))     ; service/section
 S $P(REC,U,15)=$$GET^XPAR("USR^SYS^PKG","ORWOR AUTOSAVE NOTE",1,"I")
 S $P(REC,U,16)=$$GET^XPAR("USR^DIV^SYS^PKG","ORCH INITIAL TAB",1,"I")
 S $P(REC,U,17)=$$GET^XPAR("USR^DIV^SYS^PKG","ORCH USE LAST TAB",1,"I")
 S $P(REC,U,18)=$$GET^XPAR("USR^DIV^SYS^PKG","ORWOR DISABLE WEB ACCESS",1,"I")
 S $P(REC,U,19)=$$GET^XPAR("SYS^PKG","ORWOR DISABLE HOLD ORDERS",1,"I")
 ; 2 pieces added by PKS on 11/5/2001 for "Reports Only:"
 ; IA# 10060 allows read access to ^VA(200 file.
 S ORRPL=$G(^VA(200,DUZ,101))           ; RPL node.
 S ORRPL1=$P(ORRPL,U)
 S $P(REC,U,20)=ORRPL1                  ; ISRPL piece.
 S ORRPL2=$P(ORRPL,U,2)
 S $P(REC,U,21)=ORRPL2                  ; RPLLIST piece.
 ;
 ; Additional pieces for CPRS tabs access:
 ; IA# 10060 allows read access to ^VA(200.01013 multiple.
 S ORDT=DT                              ; Today.
 S (CORTABS,RPTTAB)=0
 S ORRPL=0
 F  S ORRPL=$O(^VA(200,DUZ,"ORD",ORRPL)) Q:ORRPL<1  D
 .S ORTAB=$G(^VA(200,DUZ,"ORD",ORRPL,0))
 .I ORTAB="" Q
 .S OREFF=$P(ORTAB,U,2)
 .S OREXP=$P(ORTAB,U,3)
 .S ORTAB=$P(ORTAB,U)
 .I ORTAB="" Q
 .S ORTAB=$G(^ORD(101.13,ORTAB,0))
 .I ORTAB="" Q
 .S ORTAB=$P(ORTAB,U)
 .I ORTAB="" Q
 .S ORTAB=$$UP^XLFSTR(ORTAB)
 .S ORDATEOK=1                             ; Default.
 .I ((OREFF="")!(OREFF>ORDT)) S ORDATEOK=0 ; Eff. date NG.
 .I ORDATEOK  D
 ..I OREXP="" Q                            ; No exp. date.
 ..I (OREXP<ORDT) S ORDATEOK=0             ; Exp. date NG.
 ..I (OREXP=ORDT) S ORDATEOK=0             ; Exp. date NG.
 .;
 .; Set TRUE if OK:
 .I ((ORTAB="COR")&(ORDATEOK)) S CORTABS=1
 .I ((ORTAB="RPT")&(ORDATEOK)) S RPTTAB=1
 ;
 ; When done, set all valid tabs for access:
 S $P(REC,U,22)=CORTABS                 ; "Core" tabs.
 S $P(REC,U,23)=RPTTAB                  ; "Reports" tab.
 ;
 S $P(REC,U,24)=$P($$SITE^VASITE,U,3)
 S $P(REC,U,25)=$$GET^XPAR("USR^TEA","PXRM GEC STATUS CHECK",1,"I")
 S $P(REC,U,26)=$$PROD^XUPROD
 Q
 ;
HASKEY(VAL,KEY) ; returns TRUE if the user possesses the security key
 S VAL=''$D(^XUSEC(KEY,DUZ))
 Q
HASOPTN(VAL,OPTION) ; returns TRUE if the user has access to a menu option
 S VAL=+$$ACCESS^XQCHK(DUZ,OPTION)
 I VAL'>0 S VAL=0
 E  S VAL=1
 Q
NPHASKEY(VAL,NP,KEY) ; returns TRUE if the person has the security key
 S VAL=''$D(^XUSEC(KEY,NP))
 Q
ORDROLE() ; returns the role a person takes in ordering
 ; VAL: 0=nokey, 1=clerk, 2=nurse, 3=physician, 4=student, 5=bad keys
 ;I '$G(ORWCLVER) Q 0  ; version of client is to old for ordering
 I ($D(^XUSEC("OREMAS",DUZ))+$D(^XUSEC("ORELSE",DUZ))+$D(^XUSEC("ORES",DUZ)))>1 Q 5
 I $D(^XUSEC("OREMAS",DUZ)) Q 1                           ; clerk
 I $D(^XUSEC("ORELSE",DUZ)) Q 2                           ; nurse
 I $D(^XUSEC("ORES",DUZ)),$D(^XUSEC("PROVIDER",DUZ)) Q 3  ; doctor
 I $D(^XUSEC("PROVIDER",DUZ)) Q 4                         ; student
 Q 0
VALIDSIG(ESOK,X) ; returns TRUE if valid electronic signature
 S X=$$DECRYP^XUSRB1(X),ESOK=0                   ; network encrypted
 D HASH^XUSHSHP
 I X=$P($G(^VA(200,+DUZ,20)),U,4) S ESOK=1
 Q
TOOLMENU(ORLST) ; returns a list of items for the Tools menu
 N ANENT
 S ANENT="ALL^"_$S($G(^VA(200,DUZ,5)):"^SRV.`"_+$G(^(5)),1:"")
 D GETLST^XPAR(.ORLST,ANENT,"ORWT TOOLS MENU","N")
 Q
ACTLOC(LOC) ; Function: returns TRUE if active hospital location
 ; IA# 10040.
 N D0,X I +$G(^SC(LOC,"OOS")) Q 0                ; screen out OOS entry
 S D0=+$G(^SC(LOC,42)) I D0 D WIN^DGPMDDCF Q 'X  ; chk out of svc wards
 S X=$G(^SC(LOC,"I")) I +X=0 Q 1                 ; no inactivate date
 I DT>$P(X,U)&($P(X,U,2)=""!(DT<$P(X,U,2))) Q 0  ; chk reactivate date
 Q 1                                             ; must still be active
 ;
CLINLOC(Y,FROM,DIR) ; Return a set of clinics from HOSPITAL LOCATION
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D  ; IA# 10040.
 . S IEN="" F  S IEN=$O(^SC("B",FROM,IEN),DIR) Q:'IEN  D
 . . I ($P($G(^SC(IEN,0)),U,3)'="C")!('$$ACTLOC(IEN)) Q
 . . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
INPLOC(Y,FROM,DIR) ;Return a set of wards from HOSPITAL LOCATION
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D  ; IA# 10040.
 . S IEN="" F  S IEN=$O(^SC("B",FROM,IEN),DIR) Q:'IEN  D
 . . I ($P($G(^SC(IEN,0)),U,3)'="W") Q
 . . I '$$ACTLOC(IEN) Q
 . . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
HOSPLOC(Y,FROM,DIR) ; Return a set of locations from HOSPITAL LOCATION
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(^SC("B",FROM),DIR) Q:FROM=""  D  ; IA# 10040.
 . S IEN="" F  S IEN=$O(^SC("B",FROM,IEN),DIR) Q:'IEN  D
 . . Q:("CW"'[$P($G(^SC(IEN,0)),U,3)!('$$ACTLOC(IEN)))
 . . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
NEWPERS(ORY,ORFROM,ORDIR,ORKEY,ORDATE,ORVIZ,ORALL) ; Return a set of names from the NEW PERSON file.
 ; SLC/PKS: Code moved to ORWU1 on 12/3/2002.
 D NP1^ORWU1
 Q
GBLREF(VAL,FN) ; return global reference for file number
 S VAL="" Q:'FN
 S VAL=$$ROOT^DILFD(+FN)
 ; I $E($RE(VAL))="," S VAL=$E(VAL,1,$L(VAL)-1)_")"
 ; I $E($RE(VAL))="(" S VAL=$P(VAL,"(",1) 
 Q
GENERIC(Y,FROM,DIR,REF) ; Return a set of entries from xref in REF
 ; .Y=returned list, FROM=text to $O from, DIR=$O direction,
 N I,IEN,CNT S I=0,CNT=44
 F  Q:I'<CNT  S FROM=$O(@REF@(FROM),DIR) Q:FROM=""  D
 . S IEN="" F  S IEN=$O(@REF@(FROM,IEN),DIR) Q:'IEN  D
 . . S I=I+1,Y(I)=IEN_"^"_FROM
 Q
EXTNAME(VAL,IEN,FN) ; return external form of pointer
 ; IEN=internal number, FN=file number
 N REF S REF=$G(^DIC(FN,0,"GL")),VAL=""
 I $L(REF),+IEN S VAL=$P($G(@(REF_IEN_",0)")),U)
 Q
PARAM(VAL,APARAM) ; return a parameter value for a user
 ; call assumes current user, default entities, single instance
 S VAL=$$GET^XPAR("ALL",APARAM,1,"I")
 Q
PARAMS(ORLIST,APARAM) ; return a list of parameter values
 ; call assumes current user, default entities, multiple instances
 D GETLST^XPAR(.ORLIST,"ALL",APARAM,"Q")
 Q
DEVICE(Y,FROM,DIR) ; Return a subset of entries from the Device file
 ; .LST(n)=IEN;Name^DisplayName^Location^RMar^PLen
 ; FROM=text to $O from, DIR=$O direction
 N I,IEN,CNT,SHOW,X S I=0,CNT=20
 I FROM["<" S FROM=$RE($P($RE(FROM),"<  ",2))
 F  Q:I'<CNT  S FROM=$O(^%ZIS(1,"B",FROM),DIR) Q:FROM=""  D
 . S IEN=0 F  S IEN=$O(^%ZIS(1,"B",FROM,IEN)) Q:'IEN  D
 .. N X0,X1,X90,X91,X95,XTYPE,XSTYPE,XTIME,ORA,ORPX,POP
 .. Q:'$D(^%ZIS(1,IEN,0))  S X0=^(0),X1=$G(^(1)),X90=$G(^(90)),X91=$G(^(91)),X95=$G(^(95)),XSTYPE=$G(^("SUBTYPE")),XTIME=$G(^("TIME")),XTYPE=$G(^("TYPE"))
 .. I $E($G(^%ZIS(2,+XSTYPE,0)))'="P" Q  ;Printers only
 .. S X=$P(XTYPE,"^") I X'="TRM",X'="HG",X'="HFS",X'="CHAN" Q  ;Device Types
 .. S X=X0 I ($P(X,U,2)="0")!($P(X,U,12)=2) Q  ;Queuing allowed
 .. S X=+X90 I X,(X'>DT) Q  ;Out of Service
 .. I XTIME]"" S ORA=$P(XTIME,"^"),ORPX=$P($H,",",2),ORPCNT=ORPX\60#60+(ORPX\3600*100),ORPX=$P(ORA,"-",2) I ORPX'<ORA&(ORPCNT'>ORPX&(ORPCNT'<ORA))!(ORPX<ORA&(ORPCNT'<ORA!(ORPCNT'>ORPX))) Q  ;Prohibited Times
 .. S POP=0
 .. I X95]"" S ORPX=$G(DUZ(0)) I ORPX'="@" S POP=1 F ORA=1:1:$L(ORPX) I X95[$E(ORPX,ORA) S POP=0 Q
 .. Q:POP  ;Security check
 .. S SHOW=$P(X0,U) I SHOW'=FROM S SHOW=FROM_"  <"_SHOW_">"
 .. S I=I+1,Y(I)=IEN_";"_$P(X0,U)_U_SHOW_U_$P(X1,U)_U_$P(X91,U)_U_$P(X91,U,3)
 Q
URGENCY(Y) ; -- retrieve set values from dd for discharge summary urgency
 N ORDD,I,X
 D FIELD^DID(8925,.09,"","POINTER","ORDD")
 F I=1:1 S X=$P(ORDD("POINTER"),";",I) Q:X=""   S Y(I)=$TR(X,":","^")
 Q
PATCH(VAL,X) ; Return 1 if patch X is installed
 S VAL=$$PATCH^XPDUTL(X)
 Q
VERSION(VAL,X) ;Return version of package or namespace
 S VAL=$$VERSION^XPDUTL(X)
 Q
VERSRV(VAL,X,CLVER) ; Return server version of option name
 S ORWCLVER=$G(CLVER)  ; leave in partition for session
 N BADVAL,ORLST
 D FIND^DIC(19,"",1,"X",X,1,,,,"ORLST")
 I 'ORLST("DILIST",0) S VAL="0.0.0.0" Q
 S VAL=ORLST("DILIST","ID",1,1)
 S VAL=$P(VAL,"version ",2)
 S BADVAL=0
 I $P(VAL,".",1)="" S BADVAL=1
 I $P(VAL,".",2)="" S BADVAL=1
 I $P(VAL,".",3)="" S BADVAL=1
 I $P(VAL,".",4)="" S BADVAL=1
 I ((BADVAL)!('VAL)!(VAL="")) S VAL="0.0.0.0"
 Q
