USRLM ; SLC/JER - User Class Membership functions and proc's ; 11/25/09
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**2,3,6,7,8,13,16,25,28,33**;Jun 20, 1997;Build 7
 ;======================================================================
ISA(USER,CLASS,ERR,USRDT) ; Boolean - Is USER a Member of CLASS?
 N USRY,USRI
 I $S(CLASS="USER":1,CLASS=+$O(^USR(8930,"B","USER",0)):1,1:0) S USRY=1 G ISAX
 ; In case USER is entered as the name, not IEN:
 I '+USER S USER=$$FIND1^DIC(200,,"X",USER,,,"USRERR") K USRERR
 I +USER'>0 S ERR="INVALID USER" Q 0
 I '+CLASS S CLASS=+$O(^USR(8930,"B",CLASS,0))
 I +CLASS'>0 S ERR="INVALID USER CLASS" Q 0
 ; If USER is a member of CLASS return true
 S USRY=0
 I +$D(^USR(8930.3,"AUC",USER,CLASS)) D
 . N USRMDA
 . S USRMDA=0
 . F  S USRMDA=+$O(^USR(8930.3,"AUC",USER,CLASS,USRMDA)) Q:((+USRMDA'>0)!(USRY))  D
 .. S USRY=+$$CURRENT(USRMDA,$G(USRDT))
 I USRY Q USRY
 ; Otherwise, check to see if user is a member of any subclass of CLASS
 S USRI=0
 F  S USRI=$O(^USR(8930,+CLASS,1,USRI)) Q:+USRI'>0!+$G(USRY)  D
 . N USRSUB S USRSUB=+$G(^USR(8930,+CLASS,1,USRI,0)) Q:+USRSUB'>0
 . S USRY=$$ISA(USER,USRSUB,,+$G(USRDT)) ; Recurs to find members of subclass
ISAX Q +$G(USRY)
 ;======================================================================
ISAWM(USER,CLASS) ; Boolean - Is USER a Member of CLASS, with message.
 I $$ISA(USER,CLASS) D  Q 1
 . W !,"Already a member of this class"
 . H 2
 E  Q 0
 ;
 ;======================================================================
CURRENT(MEMBER,USRDT) ; Boolean - Is Membership current?
 N USRIN,USROUT,USRY
 I +$G(USRDT)'>0 S USRDT=DT
 S USRIN=+$P($G(^USR(8930.3,+MEMBER,0)),U,3)
 S USROUT=+$P($G(^USR(8930.3,+MEMBER,0)),U,4)
 I USRIN'>USRDT,$S(USROUT>0&(USROUT'<USRDT):1,USROUT=0:1,1:0) S USRY=1
 E  S USRY=0
 Q USRY
 ;
 ;======================================================================
ISTERM(USER,ERR) ;Return true if USER (DUZ or IEN in file 200) has a termination date
 ; and that date is less than the current date and time.
 N TERM,TERMDATE,IENS,HUSH
 S (TERM,TERMDATE)=0
 S IENS=USER_",",TERMDATE=$$GET1^DIQ(200,IENS,9.2,"I",,"ERR") ; ICR 10060
 I $D(ERR("DIERR","E",601)) D  G ISTERMX
 . S ERR="INVALID USER"
 . S HUSH=$S($$BROKER^XWBLIB:1,1:0) ; ICR 2198
 . I 'HUSH W !,"Warning: bad data. ",+USER," does not exist in file 200!" H 3
 I (+TERMDATE>0)&(+TERMDATE<$$NOW^XLFDT) S TERM=1
ISTERMX ;
  Q TERM
  ;
 ;======================================================================
RESIZE(LONG,SHORT,SHRINK) ; Resizes list area
 N USRBM S USRBM=$S(VALMMENU:SHORT,+$G(SHRINK):SHORT,1:LONG)
 I VALM("BM")'=USRBM S VALMBCK="R" D
 . S VALM("BM")=USRBM,VALM("LINES")=(USRBM-VALM("TM"))+1
 . I +$G(VALMCC) D RESET^VALM4
 Q
 ;======================================================================
TERM ;USR actions to be taken when a user is terminated. Invoked by
 ;XU USER TERMINATE.  XUIFN is the user being terminated; Newed in XUSERP.
 ;Sets all Class Memberships to expired.
 N IND,OLDTERM,NOW
 S NOW=DT ;Piece 4 is date only, time not needed.
 S IND=""
 F  S IND=$O(^USR(8930.3,"B",XUIFN,IND)) Q:IND=""  D
 . S OLDTERM=+$P($G(^USR(8930.3,IND,0)),U,4)
 . I (OLDTERM>0)&(OLDTERM<NOW) Q
 . S $P(^USR(8930.3,IND,0),U,4)=NOW
 Q
 ;
 ;======================================================================
WHOIS(MEMBER,CLASS,NAME01) ; Given a Class, set array of CURRENT members. Used in CANDEL.
 ; CLASS is pointer to file 8930
 ; MEMBER is name of array (local or global) in which members are
 ;        returned in alphabetical order by name
 ; NAME01 is optional. If NAME01>0 use .01 Class Name in returned data.
 D WHOIS1^USRLM1(MEMBER,CLASS,+$G(NAME01)) Q  ;Moved to USRLM1
 ;
 ;======================================================================
WHOIS2(MEMBER,USRCLASS,NAME01) ;Given a Class, return list of CURRENT members
 ; Uses WHOISTMP^USRLM1 (and XREF ACU)
 ; USRCLASS is pointer to file 8930
 ; MEMBER is name of array (local or global) in which members are
 ;        returned in alphabetical order by name - indexed by number
 ;       i.e. @MEMBER@(1 ...n)
 ;  @member@(0) = ien of8930^usr class name^count of members
 ;  @member@(1..n)=
 ;    1    2        3          4         5        6       7      8
 ;  p200^p8930.3^classname^effectdate^inactdate^username^title^mailcode
 ;  Note: For pieces 2,4 & 5 - Only one of potentially many is returned
 ; NAME01 is optional. If NAME01>0 use .01 Class Name in returned data.
 ;N USER,USRNM,USRCLNM,USRCNT,USRDA,USRNDX,EFFCTV,EXPIRES,USRI
 N USER,USRNM,USRDA,USRNDX,EFFCTV,EXPIRES,USRI
 D WHOISTMP^USRLM1(.USRCLASS,+$G(NAME01))
 S USRNM="",USRNDX=0
 F  S USRNM=$O(^TMP("USRWHO",$J,"USRWHO2","B",USRNM)) Q:USRNM']""  D
 . S USER=0 F  S USER=$O(^TMP("USRWHO",$J,"USRWHO2","B",USRNM,USER)) Q:'USER  D
 . . S USRNDX=USRNDX+1
 . . S @MEMBER@(USRNDX)=^TMP("USRWHO",$J,"USRWHO2",USER)
 S @MEMBER@(0)=^TMP("USRWHO",$J,"USRWHO2",0)
 S $P(@MEMBER@(0),U,3)=USRNDX
 K ^TMP("USRWHO",$J,"USRWHO2")
 Q
 ;
 ;======================================================================
WHATIS(USER,CLASS,NAME01) ; Given a User, set array of classes USER belongs to
 ; USER is pointer to file 200
 ; CLASS is name of the array (local or global) to be set.
 ;   Array is set in alpha order
 ;   by name(display name or class name)in uppercase. Numeric indicator is appended to name
 ;   to accomodate multiple memberships over time in the same class.
 ;     ARRAY(Uppername_indicator)=UserClassIEN^MembershipIEN^name^EffectDt^ExpireDt
 ; NAME01 is optional. If NAME01>0 use .01 Class Name
 ;   Otherwise, use Display Name
 N IND,GROUP,CLASSNM,CLASSCNT,USRCUR,USRDA,EFFCTV,EXPIRES,EFFCTV1,TMPDATA,UPCLASNM
 K ^TMP("USRWHATIS",$J)
 S (CLASSCNT,IND,GROUP)=0 S NAME01=+$G(NAME01)
 F  S GROUP=$O(^USR(8930.3,"AUC",USER,GROUP)) Q:+GROUP'>0  D
 . S USRDA=0
 . F  S USRDA=$O(^USR(8930.3,"AUC",USER,GROUP,USRDA)) Q:+USRDA'>0  D
 .. S USRCUR="E",EFFCTV1=""
 .. S EFFCTV=$P($G(^USR(8930.3,+USRDA,0)),U,3) S:EFFCTV="" EFFCTV1=DT
 .. S EXPIRES=$P($G(^USR(8930.3,+USRDA,0)),U,4) S:EXPIRES="" EXPIRES=9999999
 .. I EFFCTV'>DT,EXPIRES'<DT S USRCUR="C"
 .. I EFFCTV>DT S USRCUR="F"
 .. S CLASSNM=$$CLNAME(+GROUP,+$G(NAME01)),UPCLASNM=$$UP^XLFSTR(CLASSNM)
 .. S TMPDATA=GROUP_U_USRDA_U_CLASSNM_U_EFFCTV_U_$S(EXPIRES=9999999:"",1:EXPIRES)
 .. S ^TMP("USRWHATIS",$J,UPCLASNM,USRCUR,$S(EFFCTV="":EFFCTV1,1:EFFCTV),EXPIRES)=TMPDATA
 I $D(^TMP("USRWHATIS",$J)) D
 . S UPCLASNM=""
 . F  S UPCLASNM=$O(^TMP("USRWHATIS",$J,UPCLASNM)) Q:UPCLASNM=""  D
 .. F USRCUR="F","E","C" D
 ... S EFFCTV=""
 ... F  S EFFCTV=$O(^TMP("USRWHATIS",$J,UPCLASNM,USRCUR,EFFCTV)) Q:EFFCTV=""  D
 .... S EXPIRES=""
 .... F  S EXPIRES=$O(^TMP("USRWHATIS",$J,UPCLASNM,USRCUR,EFFCTV,EXPIRES)) Q:EXPIRES=""  D
 ..... S IND=IND+1
 ..... S @CLASS@(UPCLASNM_IND)=$G(^TMP("USRWHATIS",$J,UPCLASNM,USRCUR,EFFCTV,EXPIRES))
 ..... S CLASSCNT=+$G(CLASSCNT)+1
 S @CLASS@(0)=USER_U_$$SIGNAME^USRLS(+USER)_U_CLASSCNT
 K ^TMP("USRWHATIS",$J)
 Q
 ;====================================================================== 
CLNAME(CLASS,NAME01) ; Given a class, return the Display Name or
 ; NAME01 is optional. If NAME01>0 use .01 Class Name in returned data.
 N USRREC,USRY
 S USRREC=$G(^USR(8930,+CLASS,0))
 Q $S(+$G(NAME01)>0:$P(USRREC,U),$P(USRREC,U,4)]"":$P(USRREC,U,4),1:$$MIXED^USRLS($P(USRREC,U)))
 ;
 ;======================================================================
PUT(USER,CLASS) ; Make user a member of a given class
 N DIC,DLAYGO,DA,DR,DIE,X,Y
 S (DIC,DLAYGO)=8930.3,DIC(0)="LXF",X=""""_"`"_USER_"""" D ^DIC Q:+Y'>0
 S DIE=DIC,DA=+Y,DR=".02///"_CLASS_";.03///"_DT
 D ^DIE
 Q
 ;====================================================================== 
SUBCLASS(DA,CLASS) ; Evaluate whether a given USER CLASS is a DESCENDENT
 ;                 of another class
 ; Receives DA = record # of possible subclass in 8930, and
 ;       CLASS = record # of possible descendent class in 8930
 N USRI,USRY S (USRI,USRY)=0
 I +$G(DA)'>0 S DA=+$O(^USR(8930,"B",DA,0))
 I +$G(CLASS)'>0 S CLASS=+$O(^USR(8930,"B",CLASS,0))
 F  S USRI=$O(^USR(8930,"AD",DA,USRI)) Q:+USRI'>0!(USRY=1)  D
 . I USRI=CLASS S USRY=1 Q
 . S USRY=$$SUBCLASS(USRI,CLASS)
 Q USRY
 ;====================================================================== 
CANDEL(USRCLDA,NAME01) ; Evaluate whether user can delete a class.  Can't find where it's used.
 ; NAME01 is optional. If NAME01>0 use .01 Class Name in returned data.
 N USRMLST,USRY S USRY=0
 D WHOIS1^USRLM1("USRMLST",USRCLDA,+$G(NAME01))
 I +$P(USRMLST(0),U,3)>0 S USRY=1 W "  There are members of the class ",$$CLNAME(USRCLDA,+$G(NAME01))
 Q USRY
