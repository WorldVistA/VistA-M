DIKCFORM ;SFISC/MKO-ENTRY POINTS FOR THE 'DIKC EDIT' FORM ;2:57 PM  25 Apr 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**20,68,108**
 ;
 ;==========================
 ; [DIKC EDIT] entry points
 ;==========================
 ;
TYPEVAL ;Validation on Type (#.2)
 Q:DDSOLD=""
 I X'="MU"!($G(DUZ(0))'="@") D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"You can only change the Type of cross reference to MUMPS, and only if you're a programmer.")
 ;
 I X="MU",$P($G(^DD(+$$FNO^DILIBF($$GET^DDSVAL(.11,DA,.01)),0,"DI")),U)="Y" D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Cannot create MUMPS cross references on archived files.")
 Q
TYPECHG ;Post action on change for Type (#.2)
 N NAME,USE
 S USE=$$GET^DDSVAL(.11,DA,.42) Q:USE]""
 S NAME=$$GET^DDSVAL(.11,DA,.02)
 I NAME]"",$E(NAME)'="A" D PUT^DDSVAL(.11,DA,.42,"LS","","I")
 Q
 ;
NAMEVAL ;Validation for Name (#.02)
 Q:$P(^DD("IX",DA,0),U,2)=X
 I X="" D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Index Name is a required field.")
 ;
 N F01,TYPE
 ;
 S F01=$$GET^DDSVAL(.11,DA,.01)
 I $D(^DD("IX","BB",F01,X)) D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"A"_$E("n","AEIOUaeiou"[$E(X))_" '"_X_"' Index already exists.")
 ;
 I $D(^DD(F01,0,"IX",X)) D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"A"_$E("n","AEIOUaeiou"[$E(X))_" '"_X_"' cross-reference already exists.")
 ;
 I $E(X)="A",$D(^DD("KEY","AU",DA)) D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Uniqueness Index Name cannot start with 'A'.")
 Q
 ;
NAMECHG ;Post action on change for Name (#.02)
 N SORT1,SORT2,USE
 S USE=$$GET^DDSVAL(.11,DA,.42)
 S SORT1=$E(DDSOLD)="A",SORT2=$E(X)="A"
 D:SORT1'=SORT2!(USE="") PUT^DDSVAL(.11,DA,.42,$S(SORT2:"S",1:"LS"),"","I")
 D BLDLOG^DIKCFORM(DA)
 Q
 ;
USEVAL ;Validation for Use (#.42)
 N NAME,TYPE
 S NAME=$$GET^DDSVAL(.11,DA,.02)
 S TYPE=$$GET^DDSVAL(.11,DA,.2)
 I NAME=""!(TYPE="") D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Please enter a NAME and TYPE for this Index.")
 ;
 I X="S" D:$E(NAME)'="A"
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Indexes used for Sorting Only must start with 'A'.")
 E  I X="LS" D:$E(NAME)="A"
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Indexes used for Lookup & Sorting cannot start with 'A'.")
 E  I TYPE="R" D
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Only MUMPS Indexes can be Action-type Indexes.")
 E  I $E(NAME)'="A" D
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Action-type Indexes must start with 'A'.")
 Q
 ;
VALLOG ;Called from data validation of logic fields
 I $G(DUZ(0))'="@" D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"Only programmers are allowed to edit index logic.")
 ;
 I $$GET^DDSVAL(DIE,.DA,.2,"","I")'="MU" D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL($C(7)_"You can modify the logic of only 'MUMPS' indexes.")
 Q
 ;
BLDLOG(DIXR) ;Build the logic of the cross reference
 ;Called from post actions of fields on form [DIKC EDIT]
 N TYPE
 S TYPE=$$GET^DDSVAL(.11,DIXR,.2)
 I TYPE="MU" D UPDEXEC(DIXR) Q
 ;
 N FILE,NAME,RTYPE,RFILE
 S FILE=$$GET^DDSVAL(.11,DIXR,.01)
 S NAME=$$GET^DDSVAL(.11,DIXR,.02)
 S RTYPE=$$GET^DDSVAL(.11,DIXR,.5)
 S RFILE=$$GET^DDSVAL(.11,DIXR,.51)
 ;
 N LDIF,LEV,ROOT,WKILL
 I FILE'=RFILE Q:RTYPE'="W"  S LDIF=$$FLEVDIFF^DIKCU(FILE,RFILE)
 E  S LDIF=0
 S ROOT=$$FROOTDA^DIKCU(FILE,LDIF_"O",.LEV)_""""_NAME_""""
 S WKILL="K "_ROOT_")"
 ;
 N CNT,CRV,FCNT,MAXL,ORD,SBSC,VAL
 S CRV(1)=DIXR
 S CRV=0 F  S CRV=$O(^DD("IX",DIXR,11.1,CRV)) Q:'CRV  D:$G(^(CRV,0))'?."^"
 . S ORD=$$GET^DDSVAL(.114,.CRV,.01) Q:'ORD
 . S:$$GET^DDSVAL(.114,.CRV,1)="F" FCNT=$G(FCNT)+1
 . S CNT=$G(CNT)+1
 . S SBSC=$$GET^DDSVAL(.114,.CRV,.5) Q:'SBSC
 . S MAXL=$$GET^DDSVAL(.114,.CRV,6)
 . S SBSC(SBSC)=ORD_U_MAXL
 ;
 S SBSC=0 F  S SBSC=$O(SBSC(SBSC)) Q:'SBSC  D
 . S ORD=$P(SBSC(SBSC),U),MAXL=$P(SBSC(SBSC),U,2)
 . I $G(CNT)=1 S VAL=$S(MAXL:"$E(X,1,"_MAXL_")",1:"X")
 . E  S VAL=$S(MAXL:"$E(X("_ORD_"),1,"_MAXL_")",1:"X("_ORD_")")
 . S ROOT=ROOT_","_VAL
 ;
 N L
 F L=LDIF:-1:1 S ROOT=ROOT_",DA("_L_")"
 S ROOT=ROOT_",DA)"
 ;
 N SET,KILL
 I '$O(SBSC(0)) S (SET,KILL)="Q",WKILL=""
 E  S SET="S "_ROOT_"=""""",KILL="K "_ROOT
 D PUT^DDSVAL(.11,DIXR,1.1,SET)
 D PUT^DDSVAL(.11,DIXR,2.1,KILL)
 D PUT^DDSVAL(.11,DIXR,2.5,WKILL)
 D PUT^DDSVAL(.11,DIXR,.4,$S($G(FCNT)>1:"R",1:"F"),"","I")
 Q
 ;
CRVTYPE ;Post-Action on change for Cross-Reference Value -> Type of Value
 N DIKCIENS
 S DIKCIENS=DA_","_DA(1)_","
 ;
 I X="F" D
 . D REQ^DDSUTL("FILE",1,2.1,1,DIKCIENS)
 . D REQ^DDSUTL("FIELD",1,2.1,1,DIKCIENS)
 . D REQ^DDSUTL("COMPUTED CODE",1,2.2,0,DIKCIENS)
 . D PUT^DDSVAL(DIE,.DA,4,"")
 . D PUT^DDSVAL(DIE,.DA,4.5,"")
 E  D
 . D REQ^DDSUTL("FILE",1,2.1,0,DIKCIENS)
 . D REQ^DDSUTL("FIELD",1,2.1,0,DIKCIENS)
 . D REQ^DDSUTL("COMPUTED CODE",1,2.2,1,DIKCIENS)
 . D PUT^DDSVAL(DIE,.DA,2,"")
 . D PUT^DDSVAL(DIE,.DA,3,"")
 ;
 D UPDEXEC(DA(1))
 Q
 ;
UPDEXEC(DIXR) ;Update Execution based on number of field-type xref values
 N CRV,FCNT
 S CRV(1)=DIXR,CRV=0
 F  S CRV=$O(^DD("IX",DIXR,11.1,CRV)) Q:'CRV  D
 . Q:'$$GET^DDSVAL(.114,.CRV,.01)
 . S:$$GET^DDSVAL(.114,.CRV,1)="F" FCNT=$G(FCNT)+1
 D PUT^DDSVAL(.11,DIXR,.4,$S($G(FCNT)>1:"R",1:"F"),"","I")
 Q
 ;
BKPRE21 ;Pre-Action for block 'DIKC EDIT FIELD CRV'
 N X
 S X=$$GET^DDSVAL(DIE,.DA,5) D TRANS
 Q
 ;
TRANS ;Post-Action on Change for Transform for Storage
 N DIKCIENS
 S DIKCIENS=DA_","_DA(1)_","
 I X]"" D
 . D UNED^DDSUTL("TRANSFORM FOR DISPLAY",1,2.1,0,DIKCIENS)
 E  D
 . D PUT^DDSVAL(DIE,.DA,5.5,"")
 . D UNED^DDSUTL("TRANSFORM FOR DISPLAY",1,2.1,1,DIKCIENS)
 Q
 ;
VALFILE ;Data Validation for File
 Q:X=""  Q:X=DDSOLD
 N LDIF,RFILE
 S RFILE=$$GET^DDSVAL(.11,DA,.51)
 ;
 I X'=RFILE D
 . S LDIF=$$FLEVDIFF^DIKCU(X,RFILE)
 . I LDIF="" D  Q
 .. D HLP^DDSUTL($C(7)_"File must be a parent (ancestor) of Root File.")
 .. S DDSERROR=1
 . D:DDSOLD=RFILE PUT^DDSVAL(.11,DA,.5,"W","","I")
 E  D:DDSOLD'=RFILE PUT^DDSVAL(.11,DA,.5,"I","","I")
 Q
 ;
FORMDV ;Form-Level Data Validation
 ;Check that Subscript Numbers are unique and consecutive from 1.
 N DIKCDA,DIKCI,DIKCLIST,DIKCSS,DIKCSQ
 ;
 ;Build list DIKCLIST(ss#,ien) while checking for duplicates.
 ;Also check that a file# is assigned for Field-type CRVs and that
 ;they it is equal to root file.
 S DIKCDA(1)=DA
 S DIKCDA=0 F  S DIKCDA=$O(^DD("IX",DA,11.1,DIKCDA)) Q:'DIKCDA  D
 . I $$GET^DDSVAL(.114,.DIKCDA,1)="F" D
 .. N DIKCFIL,DIKCMSG,DIKCRF
 .. S DIKCFIL=$$GET^DDSVAL(.114,.DIKCDA,2)
 .. I DIKCFIL="" D
 ... D:'$D(DDSERROR) MSG^DDSUTL($C(7)_"UNABLE TO SAVE CHANGES")
 ... S DDSERROR=1
 ... S DIKCMSG(1)="FILE for Order #"_$$GET^DDSVAL(.114,.DIKCDA,.01)_" is missing."
 ... S DIKCMSG(2)="  To correct the problem, press <RET> at the Order # on Page 2."
 ... S DIKCMSG(3)="  In the resulting pop-up page, FILE will be filled in automatically."
 ... S DIKCMSG(4)="  Try saving again."
 ... D MSG^DDSUTL(.DIKCMSG)
 .. E  S DIKCRF=$$GET^DDSVAL(.11,DA,.51) I DIKCFIL'=DIKCRF D
 ... D:'$D(DDSERROR) MSG
 ... S DDSERROR=1
 ... D MSG^DDSUTL("FILE for Order #"_$$GET^DDSVAL(.114,.DIKCDA,.01)_" is not equal to the Root File: "_DIKCRF_".")
 . S DIKCSS=$$GET^DDSVAL(.114,.DIKCDA,.5) Q:'DIKCSS
 . I $D(DIKCLIST(DIKCSS)) D
 .. D:'$D(DDSERROR) MSG
 .. S DDSERROR=1
 .. D MSG^DDSUTL("The subscript number "_DIKCSS_" is used more than once.")
 . E  S DIKCLIST(DIKCSS,DIKCDA)=""
 ;
 ;If no duplicates, check that subscript numbers are consecutive from 1
 I '$D(DDSERROR) D
 . S DIKCSS=0
 . F DIKCI=1:1 S DIKCSS=$O(DIKCLIST(DIKCSS)) Q:'DIKCSS!$G(DDSERROR)  D:DIKCSS'=DIKCI
 .. S DDSERROR=1
 .. D MSG
 .. D MSG^DDSUTL("Subscript numbers must be consecutive numbers starting with 1.")
 Q
 ;
MSG ;Print message
 D MSG^DDSUTL($C(7)_"UNABLE TO SAVE CHANGES")
 Q
 ;
POSTSV ;Post Save
 ;Clean-up global (get rid of null nodes)
 ;Kill DIKCREB, the flag that indicates that a crv was deleted, but
 ;the logic wasn't yet saved.
 N CRV,ND
 S CRV=0 F  S CRV=$O(^DD("IX",DA,11.1,CRV)) Q:'CRV  D
 . F ND=1.5,2,3 I $D(^DD("IX",DA,11.1,CRV,ND))#2,^(ND)="" K ^(ND)
 K DIKCREB
 Q
