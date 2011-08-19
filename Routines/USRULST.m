USRULST ; SLC/JER - List Class Membership by user       ;3/23/10
 ;;1.0;AUTHORIZATION/SUBSCRIPTION;**2,3,4,9,10,16,17,21,22,28,33**;Jun 20, 1997;Build 7
 ; 30 Jun 00 MA - Added MAIN2 to prevent stack overflow
 ; 20 Sep 00 MA - Removed MAIN2 and added GETUSER and chg protocol to
 ; avoid looping through MAIN when doing a "CHANGE VIEW".
 ;  7 Aug 01 MA - Removed line "S USRDUZ=+Y" from line tag GETUSER()
 ;  6 Sep 01 MA - Added line "I +Y>0 S USRDUZ=Y" in GETUSER
 ;  to avoid adding USER Classes to the wrong person.
MAIN ; Control Branching
 N DIC,X,Y,USRDUZ
 S DIC=200,DIC(0)="AEMQ",DIC("A")="Select USER: "
 D ^DIC Q:+Y'>0
 S USRDUZ=+Y
 D EN^VALM(USRLTMPL)
 K USRLTMPL
 Q
GETUSER() ; Get a new user
 N DIC,X,Y
 S DIC=200,DIC(0)="AEMQ",DIC("A")="Select USER: "
 D ^DIC     ; If Y is not set then will use current USRDUZ
 I +Y>0 S USRDUZ=+Y
 Q USRDUZ
MAKELIST ; Build review screen list
 W !,"Searching for the User Classes."
 D BUILD(USRDUZ)
 Q
BUILD(USRDUZ) ; Build List
 ; DBIA 872 ^ORD(101)
 N USRCNT,USRNAME,USRPICK
 S (USRCNT,VALMCNT)=0
 S USRPICK=+$O(^ORD(101,"B","USR ACTION SELECT LIST ELEMENT",0)) ;ICR 87
 K ^TMP("USRUSER",$J),^TMP("USRUSERIDX",$J),^TMP("USRU",$J)
 ;D WHATIS^USRLM(USRDUZ,"^TMP(""USRU"",$J)")
 D WHATIS^USRLM(USRDUZ,"^TMP(""USRU"",$J)",1) ; Use .01 class name 
 S USRNAME=""
 F  S USRNAME=$O(^TMP("USRU",$J,USRNAME),-1) Q:USRNAME=""  Q:USRNAME=0  D
 . N USRDA,USREFF,USREXP,USRMEM,USRREC,USRCLNM
 . S USRMEM=$G(^TMP("USRU",$J,USRNAME))
 . S USRDA=+$P(USRMEM,U,2)
 . S USRCLNM=$P(USRMEM,U,3)
 . S USREFF=$$DATE^USRLS(+$P(USRMEM,U,4),"MM/DD/YY")
 . S USREXP=$$DATE^USRLS(+$P(USRMEM,U,5),"MM/DD/YY")
 . S USRCNT=+$G(USRCNT)+1
 . S USRREC=$$SETFLD^VALM1(USRCNT,"","NUMBER")
 . S USRREC=$$SETFLD^VALM1(USRCLNM,USRREC,"CLASS")
 . S USRREC=$$SETFLD^VALM1(USREFF,USRREC,"EFFECTIVE")
 . S USRREC=$$SETFLD^VALM1(USREXP,USRREC,"EXPIRES")
 . S VALMCNT=+$G(VALMCNT)+1
 . S ^TMP("USRUSER",$J,VALMCNT,0)=USRREC
 . S ^TMP("USRUSER",$J,"IDX",VALMCNT,USRCNT)=""
 . S ^TMP("USRUSERIDX",$J,USRCNT)=VALMCNT_U_USRDA W:VALMCNT#10'>0 "."
 S ^TMP("USRUSER",$J,0)=+$G(USRCNT)_U_$P(^TMP("USRU",$J,0),U,2)
 S ^TMP("USRUSER",$J,"#")=USRPICK_"^0:"_+$G(USRCNT)
 I $D(VALMHDR)>9 D HDR
 I +$G(USRCNT)'>0 D
 . S ^TMP("USRUSER",$J,1,0)="",VALMCNT=2
 . S ^TMP("USRUSER",$J,2,0)="No Class Memberships found for "_$P(^TMP("USRU",$J,0),U,2)
 Q
HDR ; Initialize header for review screen
 N BY,USRX,USRCNT,TITLE,USRNAME
 S USRX=$G(^TMP("USRUSER",$J,0)),USRNAME=$P(USRX,U,2)
 S TITLE=USRNAME
 I USRNAME["?SBPN" D
 . S VALMSG="(?SBPN) missing SIGNATURE BLOCK PRINTED NAME"
 ;If this user has been terminated change the title to reflect this.
 I $$ISTERM^USRLM(USRDUZ) S TITLE=TITLE_" (terminated)"
 S USRCNT=$J(+USRX,4)_" Class"_$S(+USRX=1:"",1:"es")
 S VALMHDR(1)=$$CENTER^USRLS(TITLE)
 S VALMHDR(1)=$$SETSTR^VALM1(USRCNT,VALMHDR(1),(IOM-$L(USRCNT)),$L(USRCNT))
 Q
CLEAN ; "Joel...Clean up your mess!"
 K ^TMP("USRUSER",$J),^TMP("USRUSERIDX",$J),^TMP("USRU",$J)
 Q
