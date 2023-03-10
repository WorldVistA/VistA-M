HBHCPROV ;HPS/DSK;HBHC Provider Definition/Edit; Feb 12, 2021@10:15
 ;;1.0;HOSPITAL BASED HOME CARE;**32**;NOV 01, 1993;Build 58
 ;
 Q
 ;
 ;Integration Control Agreements:
 ;10060 - NEW PERSON (#200) file
 ;7262  - PROVIDER CLASS (53.5) field in the NEW PERSON (#200) file
 ;10104 - $$UP^XLFSTR
 ; 
EN ;
 ;Entry point from the option.
 ;VALM variables are not new'd
 N HBHCNAM,HBHCDDX,HBHCNP,HBHCFLAG,HBHCQUIT,HBHCPRT,HBHCMAX
 ;checking to see if 9999 providers have already been defined.
 F HBHCMAX=1:1:10000 Q:'$D(^HBHC(631.4,"B",HBHCMAX))
 S HBHCNP=1,HBHCQUIT=0
 S VALMAR="^TMP(""HBHCLIST"",$J)"
 D EN2
 Q:HBHCQUIT
 D EN^VALM("HBHC EDIT PROVIDER")
 Q
 ;
EN2 ;
 ;Entry point from protocols
 N DIR,Y,DTOUT,DUOUT
 S HBHCFLAG=0
 S DIR("A")="Partial or full name"
 S DIR("B")=$G(HBHCNAM)
 S DIR(0)="F"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT))!($G(Y)="")!('$T) D  Q
 . S HBHCQUIT=1
 . S VALMBCK="R"
 S HBHCNAM=Y
 I HBHCNAM=""!(HBHCNAM="^") Q
 ;convert to uppercase if lowercase entered
 S HBHCNAM=$$UP^XLFSTR(HBHCNAM)
 S HBHCDDX=0
 K ^TMP("HBHC",$J),^TMP("HBHCLIST",$J)
 I $G(HBHCNP) D
 . D FIND^DIC(200,,".01;53.5","B",HBHCNAM,,,,,"^TMP(""HBHC"",$J)")
 . D F200
 I '$G(HBHCNP) D
 . D FIND^DIC(631.4,,".01;1;5;6","M",HBHCNAM,,,,,"^TMP(""HBHC"",$J)")
 . D F6314
 S VALMBCK="R"
 D INIT2
 Q
 ;
INIT ; -- init variables and list array
 N HBHCSQ,HBHCROW
 D CHGCAP^VALM("HEADER","")
 Q
 ;
INIT2 ;
 S HBHCSQ="",VALMCNT=0,VALMBG=1
 F  S HBHCSQ=$O(^TMP("HBHCLIST",$J,HBHCSQ)) Q:HBHCSQ=""  D
 . S HBHCROW=^TMP("HBHCLIST",$J,HBHCSQ)
 . S VALMCNT=VALMCNT+1
 . D SET^VALM10(.VALMCNT,HBHCROW)
 Q
 ;
HDR ;
 S VALMHDR(1)="SQ.  Name                       ID   Team"
 S VALMHDR(2)="---- -------------------------- ---- --------------------------"
 D MAX
 Q
 ;
HDR2 ;
 S VALMHDR(1)="SQ.  Name                       Provider Class            Title"
 S VALMHDR(2)="---- -------------------------  ------------------------- ---------------------"
 S VALMSG="          ""*"" before name = HBPC PROVIDER"
 D MAX
 Q
 ;
MAX ;display warning message in toolbar
 ;re-checking to see if 9999 providers have already been defined.
 F HBHCMAX=1:1:10000 Q:'$D(^HBHC(631.4,"B",HBHCMAX))
 I HBHCMAX=10000 S VALMSG="*** ATTN *** NO MORE HBPC PROVIDERS MAY BE DEFINED." Q
 I HBHCMAX>9800 S VALMSG="*** ATTN *** ONLY "_(10000-HBHCMAX)_" HBPC PROVIDER NUMBERS LEFT."
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
F6314 ;
 N HBHCSQ,HBHCARR,HBHCSP,HBHCLEN,HBHCSEQ
 ;HBHCLIST used for display.
 ;HBHCEDIT used for the edit option, detail display, and print.
 K ^TMP("HBHCLIST",$J),^TMP("HBHCEDIT",$J)
 D HDR
 I $O(^TMP("HBHC",$J,"DILIST",0))="" D  Q
 . S ^TMP("HBHCLIST",$J,1)="No matching active entries in the HBPC PROVIDER (#631.4) file."
 . S HBHCFLAG=1
 S HBHCSP="                       "
 S HBHCLEN=$L($G(HBHCNAM))
 S (HBHCSQ,HBHCSEQ,HBHCNP)=0
 F  S HBHCSQ=$O(^TMP("HBHC",$J,"DILIST","ID",HBHCSQ)) Q:HBHCSQ=""  D
 . K HBHCARR
 . M HBHCARR=^TMP("HBHC",$J,"DILIST","ID",HBHCSQ)
 . ;do not display inactive HBPC providers
 . I HBHCARR(6)]"" Q
 . I '$G(HBHCIENX),$G(HBHCNAM)]"",$E(HBHCARR(1),1,HBHCLEN)'=HBHCNAM Q
 . I $G(HBHCIENX),HBHCARR(.01)'=HBHCIENX Q
 . S HBHCSEQ=HBHCSEQ+1
 . S ^TMP("HBHCLIST",$J,HBHCSEQ)=$E(HBHCSP,1,4-$L(HBHCSEQ))_HBHCSEQ_" "_$E($G(HBHCARR(1)),1,26)_" "
 . S ^TMP("HBHCLIST",$J,HBHCSEQ)=^TMP("HBHCLIST",$J,HBHCSEQ)_$E(HBHCSP,1,26-$L($G(HBHCARR(1))))
 . S ^TMP("HBHCLIST",$J,HBHCSEQ)=^TMP("HBHCLIST",$J,HBHCSEQ)_$G(HBHCARR(.01))_$E(HBHCSP,1,5-$L($G(HBHCARR(.01))))
 . S ^TMP("HBHCLIST",$J,HBHCSEQ)=^TMP("HBHCLIST",$J,HBHCSEQ)_$E($G(HBHCARR(5)),1,25)_" "
 . I $L($G(HBHCARR(5)))<25 S ^TMP("HBHCLIST",$J,HBHCSEQ)=^TMP("HBHCLIST",$J,HBHCSEQ)_$E(HBHCSP,1,26-$L($G(HBHCARR(5))))
 . M ^TMP("HBHCEDIT",$J,HBHCSEQ)=HBHCARR
 . ;Keep track of IEN in file 631.4
 . S ^TMP("HBHCIDX",$J,HBHCSEQ)=^TMP("HBHC",$J,"DILIST",2,HBHCSQ)
 I '$O(^TMP("HBHCLIST",$J,0)) D  Q
 . S ^TMP("HBHCLIST",$J,1)="No matching active entries in the HBPC PROVIDER (#631.4) file."
 . S HBHCFLAG=1
 Q
 ;
F200 ;
 N HBHCSQ,HBHCARR,HBHCSP,HBHC200,HBHCTITLE,Y
 K ^TMP("HBHCLIST",$J),^TMP("HBHCEDIT",$J),^TMP("HBHCIDX",$J)
 D HDR2
 I '$O(^TMP("HBHC",$J,"DILIST",0)) D  Q
 . S ^TMP("HBHCLIST",$J,1)="No matching entries in the NEW PERSON (#200) file."
 S HBHCSP="                       "
 S HBHCSQ=""
 F  S HBHCSQ=$O(^TMP("HBHC",$J,"DILIST","ID",HBHCSQ)) Q:'HBHCSQ  D
 . K HBHCARR
 . M HBHCARR=^TMP("HBHC",$J,"DILIST","ID",HBHCSQ)
 . S ^TMP("HBHCLIST",$J,HBHCSQ)=$E(HBHCSP,1,4-$L(HBHCSQ))_HBHCSQ_" "
 . S HBHC200=^TMP("HBHC",$J,"DILIST",2,HBHCSQ)
 . ;Prefix with "*" if an active HBHC provider.
 . I $D(^HBHC(631.4,"C",HBHC200)) D
 . . N HBHCHIT,HBHCIEN
 . . S (HBHCHIT,HBHCIEN)=0
 . . F  S HBHCIEN=$O(^HBHC(631.4,"C",HBHC200,HBHCIEN)) Q:HBHCIEN=""  Q:HBHCHIT  D
 . . . I '$P(^HBHC(631.4,HBHCIEN,0),"^",7) S HBHCHIT=1
 . . I HBHCHIT S HBHCARR(.01)="*"_HBHCARR(.01)
 . S ^TMP("HBHCLIST",$J,HBHCSQ)=^TMP("HBHCLIST",$J,HBHCSQ)_$E($G(HBHCARR(.01)),1,25)_"  "
 . I $L($G(HBHCARR(.01)))<25 D
 . . S ^TMP("HBHCLIST",$J,HBHCSQ)=^TMP("HBHCLIST",$J,HBHCSQ)_$E(HBHCSP,1,25-$L($G(HBHCARR(.01))))
 . S ^TMP("HBHCLIST",$J,HBHCSQ)=^TMP("HBHCLIST",$J,HBHCSQ)_$E($G(HBHCARR(53.5)),1,25)_" "
 . I $L($G(HBHCARR(53.5)))<25 D
 . . S ^TMP("HBHCLIST",$J,HBHCSQ)=^TMP("HBHCLIST",$J,HBHCSQ)_$E(HBHCSP,1,25-$L($G(HBHCARR(53.5))))
 . ;adding two spaces so columns will line up if no provider class
 . I $G(HBHCARR(53.5))="" S ^TMP("HBHCLIST",$J,HBHCSQ)=^TMP("HBHCLIST",$J,HBHCSQ)_"  "
 . S HBHCTITLE=$$GET1^DIQ(200,HBHC200_",",8)
 . S ^TMP("HBHCLIST",$J,HBHCSQ)=^TMP("HBHCLIST",$J,HBHCSQ)_$E(HBHCTITLE,1,20)
 Q
 ;
ADD ;
 N HBHCSQ,HBHCNAMX,HBHCNMX,HBHCTEAM,HBHCIEN,DIC
 N X,HBHCNUM,HBHCNUMX,DIR,DTOUT,DUOUT,DA,HBHCLOCK,HBHCHIT
 I HBHCMAX=10000 D  Q
 . W !,"NO MORE HBPC PROVIDERS MAY BE DEFINED."
 . D PAUSE^VALM1
 I '$G(HBHCNP) D  Q
 . W !,"This option may only be used after NP is invoked and a list displays."
 . D PAUSE^VALM1
 I $G(^TMP("HBHCLIST",$J,1))["No matching" D  Q
 . W !,"Display a list of entries from the New Person file."
 . D PAUSE^VALM1
 R !,"Enter sequence number of provider to add: ",HBHCSQ:DTIME
 I HBHCSQ=""!(HBHCSQ="^") Q
 I '$D(^TMP("HBHCLIST",$J,HBHCSQ)) D  G ADD
 . W !!,"Enter a valid sequence in the display."
 S (HBHCHIT,HBHCLOCK)=0
 S HBHCNAMX=^TMP("HBHC",$J,"DILIST",1,HBHCSQ),HBHCNMX=^TMP("HBHC",$J,"DILIST",2,HBHCSQ)
 ;Check to determine if: (1) entry is locked; (2) provider already has an active number
 I $D(^HBHC(631.4,"C",+HBHCNMX)) D
 . ;another user might be in the process of defining but is still in the session
 . N HBHCIENX S HBHCIENX=""
 . F  S HBHCIENX=$O(^HBHC(631.4,"C",+HBHCNMX,HBHCIENX)) Q:HBHCIENX=""  D
 . . ;if the HBHC TEAM (#5) field is not yet defined, the other user is in
 . . ;the process of adding this provider. The HBHC TEAM (#5) field is required.
 . . I '$P(^HBHC(631.4,HBHCIENX,0),"^",6) D  Q
 . . . S HBHCLOCK=1
 . . . W !,"Another user is in the process of adding this provider."
 . . . D PAUSE^VALM1
 . Q:HBHCLOCK
 . ;Check all entries and allow a new entry if only inactive entries on file.
 . N HBHCDUP
 . S HBHCDUP=""
 . F  S HBHCDUP=$O(^HBHC(631.4,"C",+HBHCNMX,HBHCDUP)) Q:HBHCDUP=""  D
 . . I $P(^HBHC(631.4,HBHCDUP,0),"^",7)="" S HBHCHIT=HBHCDUP
 . I HBHCHIT D
 . . W !,"This provider has already been added with the HBPC Provider number of "
 . . ;Only display last active entry if more than exists. (Procedurally, only one
 . . ;active HBPC Provider number should be defined per new person entry. However,
 . . ;sites might use FileMan for some reason.)
 . . S HBHCNUMX=$P(^HBHC(631.4,+HBHCHIT,0),"^")
 . . W HBHCNUMX,"."
 . . D PAUSE^VALM1
 I HBHCHIT!(HBHCLOCK) Q
 W !,"NAME: ",HBHCNAMX
 S DIR(0)="Y",DIR("A")="Do you wish to add this provider to the HBPC Provider file"
 S DIR("B")="NO" D ^DIR
 I $G(DTOUT)!($G(DUOUT))!('Y) Q
 S HBHCIEN=^TMP("HBHC",$J,"DILIST",2,HBHCSQ)
 F HBHCNUM=1:1:9999 Q:'$D(^HBHC(631.4,"B",HBHCNUM))
 K DD,DO
 S DIC="^HBHC(631.4,"
 S DIC(0)=""
 S DIC("DR")="1///^S X=""`""_HBHCIEN;5"
 S X=HBHCNUM
 D FILE^DICN
 ;refresh display
 K ^TMP("HBHC",$J)
 S HBHCIENX=HBHCNUM
 D FIND^DIC(631.4,,".01;1;5;6","M",HBHCNAMX,,,,,"^TMP(""HBHC"",$J)")
 D F6314
 D INIT2
 Q
 ;
EDIT ;
 N HBHCSQ,HBHCARR,HBHCIENX,DA,DIE,DR,DIR,HBHCSAVE,HBHCSEQZ
 ;HBHCDDX = a detailed display was displayed previously
 ;'$D(HBHCNP) = a list of providers is not displayed
 ;$G(HBHCFLAG) = no matching providers in display
 ;$G(HBHCNP) = a New Person (#200) list is displayed
 I $G(HBHCDDX)!('$D(HBHCNP))!($G(HBHCFLAG))!($G(HBHCNP)) D  Q
 . W !,"Display an HBPC Provider list first."
 . D PAUSE^VALM1
 . S VALMBCK="R"
 I $G(^TMP("HBHCLIST",$J,1))["No matching" D  Q
 . W !,"Display a list of entries."
 . D PAUSE^VALM1
 R !,"Enter sequence number of provider to edit: ",HBHCSQ:DTIME
 I HBHCSQ=""!(HBHCSQ="^") Q
 I '$D(^TMP("HBHCLIST",$J,HBHCSQ)) D  G EDIT
 . W !!,"Enter a valid sequence in the display."
 S HBHCSEQZ=HBHCSQ
 M HBHCARR=^TMP("HBHCEDIT",$J,HBHCSQ)
 S HBHCIENX=^TMP("HBHCIDX",$J,HBHCSQ)
 L +^HBHC(631.4,HBHCIENX):2
 I '$T D  Q
 . W !,"Another user is editing this entry."
 . D PAUSE^VALM1
 S HBHCFLAG=1
 W !,"HBHC Provider Number: ",HBHCARR(.01)," Name: ",HBHCARR(1)
 S DA=HBHCIENX
 S DIE="^HBHC(631.4,"
 S DR="5"
 D ^DIE
 L -^HBHC(631.4,HBHCIENX)
 ;Redisplay provider
 S HBHCSAVE=$G(VALMBG)
 D SAVE
 S HBHCIENX=HBHCARR(.01)
 D FIND^DIC(631.4,,".01;1;5;6","B",HBHCIENX,,,,,"^TMP(""HBHC"",$J)")
 D F6314
 K ^TMP("HBHCZ",$J)
 M ^TMP("HBHCZ",$J)=^TMP("HBHCLIST",$J)
 D INIT2
 D EN^VALM("HBHC EDIT PROVIDER")
 ;After user hits enter, re-display previous list.
 D GET
 M ^TMP("HBHCLIST",$J,HBHCSEQZ)=^TMP("HBHCZ",$J,1)
 S ^TMP("HBHCLIST",$J,HBHCSEQZ)=$E("    ",1,4-$L(HBHCSEQZ))_HBHCSEQZ_$E(^TMP("HBHCLIST",$J,HBHCSEQZ),5,99)
 S ^TMP("HBHCLIST",$J,HBHCSEQZ,0)=^TMP("HBHCLIST",$J,HBHCSEQZ)
 D INIT2
 S VALMBCK="R",VALMBG=HBHCSAVE
 S HBHCFLAG=0
 K ^TMP("HBHCZ",$J)
 Q
 ;
ALLPROV ;Display all active entries in the HBHC PROVIDER (#631.4) file
 N DIR,HBHCSORT,HBHCSQ,HBHCSTR,HBHCNAME,HBHCSUB,HBHCSEQX,HBHCNUMX,HBHCSUB,HBHCIENX
 S HBHCDDX=0
 K ^TMP("HBHC",$J),^TMP("HBHCSORT",$J),^TMP("HBHCLIST",$J)
 S DIR(0)="SB^A:ALPHABETICALLY;N:NUMERICALLY"
 S DIR("A")="Sort alphabetically or numerically"
 D ^DIR
 I $G(DTOUT)!($G(DUOUT))!($G(Y)="")!('$T) S VALMBCK="R" Q
 S HBHCSORT=Y,HBHCNAM=""
 S (HBHCSQ,HBHCSEQX,HBHCIENX,HBHCFLAG)=0
 F  S HBHCSQ=$O(^HBHC(631.4,HBHCSQ)) Q:'HBHCSQ  D
 . S HBHCSEQX=HBHCSEQX+1
 . S HBHCSTR=^HBHC(631.4,HBHCSQ,0)
 . ;do not display inactive HBHC providers
 . Q:$P(HBHCSTR,"^",7)]""
 . ;store ien from file 631.4
 . S $P(HBHCSTR,"^",8)=HBHCSQ
 . S HBHCNAME=$P(HBHCSTR,"^",2),HBHCNAME=$P(^VA(200,+HBHCNAME,0),"^")
 . S HBHCNUMX=$P(HBHCSTR,"^")
 . ;Concatenate name with sequence if more than one provider has same name
 . ;Concatenate with "." and new sequence if somehow two providers have the 
 . ;same number. (The only way for this to occur after install is if the site
 . ;uses FileMan to define HBPC providers. Sites should not use FileMan.)
 . I HBHCSORT="N",$D(^TMP("HBHCSORT",$J,HBHCNUMX)) D
 . . F  Q:'$D(^TMP("HBHCSORT",$J,HBHCNUMX))  S HBHCNUMX=HBHCNUMX+.01,HBHCNUMX=+(HBHCNUMX)
 . S HBHCSUB=$S(HBHCSORT="A":HBHCNAME_HBHCSEQX,1:HBHCNUMX)
 . S ^TMP("HBHCSORT",$J,HBHCSUB)=HBHCSTR
 S (HBHCSQ,HBHCSEQX)=0
 F  S HBHCSQ=$O(^TMP("HBHCSORT",$J,HBHCSQ)) Q:HBHCSQ=""  D
 . S HBHCSTR=^TMP("HBHCSORT",$J,HBHCSQ)
 . S HBHCSEQX=HBHCSEQX+1
 . S ^TMP("HBHC",$J,"DILIST",1,HBHCSEQX)=$P(HBHCSTR,"^")
 . S ^TMP("HBHC",$J,"DILIST",2,HBHCSEQX)=$P(HBHCSTR,"^",8)
 . S ^TMP("HBHC",$J,"DILIST","ID",HBHCSEQX,.01)=$P(HBHCSTR,"^")
 . S HBHCNAME=$P(HBHCSTR,"^",2),HBHCNAME=$P(^VA(200,+HBHCNAME,0),"^")
 . S ^TMP("HBHC",$J,"DILIST","ID",HBHCSEQX,1)=HBHCNAME
 . S ^TMP("HBHC",$J,"DILIST","ID",HBHCSEQX,5)=$G(^HBHC(633,+$P(HBHCSTR,"^",6),0))
 . S ^TMP("HBHC",$J,"DILIST","ID",HBHCSEQX,6)=""
 D F6314
 S VALMBCK="R"
 D INIT2
 Q
 ;
DD ;Detailed display
 I $G(HBHCDDX)!('$D(HBHCNP)) D  Q
 . W !,"Display a New Person or HBPC Provider list first."
 . D PAUSE^VALM1
 . S VALMBCK="R"
 I $G(^TMP("HBHCLIST",$J,1))["No matching" D  Q
 . W !,"Display a list of entries."
 . D PAUSE^VALM1
 . S VALMBCK="R"
 N HBHCSQ,HBHCNAMX,HBHCTEAM,HBHCTITLE,HBHCSERV,HBHCNUM,HBHCNUMX,HBHCARR,HBHCST
 R !,"Enter sequence number of provider to display: ",HBHCSQ:DTIME
 I HBHCSQ=""!(HBHCSQ="^") S VALMBCK="R" Q
 I '$D(^TMP("HBHCLIST",$J,HBHCSQ)) D  G DD
 . W !,"Please try again: ",HBHCSQ," is an invalid sequence."
 S HBHCDDX=1
 ;HBHCNP = Display is currently from New Person (#200) file.
 S:HBHCNP HBHCNAMX=^TMP("HBHC",$J,"DILIST",1,HBHCSQ),HBHCNMX=^TMP("HBHC",$J,"DILIST",2,HBHCSQ)
 I '$G(HBHCNP) D
 . ;must perform several manipulations to find the IEN (HBHCNMX) in file 200.
 . S HBHCNMX=^TMP("HBHCEDIT",$J,HBHCSQ,.01)
 . S HBHCNMX=^TMP("HBHC",$J,"DILIST",2,HBHCSQ)
 . S HBHCNMX=$P(^HBHC(631.4,HBHCNMX,0),"^",2)
 . ;HBHCARR(53.5) = Provider Class
 . S HBHCARR(53.5)=$$GET1^DIQ(200,HBHCNMX_",",53.5)
 . ;HBHCNAMX = Provider Name
 . S HBHCNAMX=^TMP("HBHCEDIT",$J,HBHCSQ,1)
 . K ^TMP("HBHCLIST",$J)
 . ;Display is from HBHC Provider (#631.4) file, so display that data first.
 . D DDHP
 K:HBHCNP ^TMP("HBHCLIST",$J)
 S HBHCTITLE=$$GET1^DIQ(200,HBHCNMX_",",8)
 S HBHCSERV=$$GET1^DIQ(200,HBHCNMX_",",29)
 S HBHCST=$$GET1^DIQ(200,HBHCNMX_",",.115)
 S ^TMP("HBHCLIST",$J,HBHCDDX)="New Person (#200) file IEN:            "_HBHCNMX
 S HBHCDDX=HBHCDDX+1
 S ^TMP("HBHCLIST",$J,HBHCDDX)="Name:                                  "_HBHCNAMX
 S HBHCDDX=HBHCDDX+1
 S ^TMP("HBHCLIST",$J,HBHCDDX)="Title:                                 "_HBHCTITLE
 S HBHCDDX=HBHCDDX+1
 S ^TMP("HBHCLIST",$J,HBHCDDX)="Service/Section:                       "_HBHCSERV
 S HBHCDDX=HBHCDDX+1
 S ^TMP("HBHCLIST",$J,HBHCDDX)="Provider Class:                        "_$G(HBHCARR(53.5))
 S HBHCDDX=HBHCDDX+1
 S ^TMP("HBHCLIST",$J,HBHCDDX)="City, ST:                              "_$P($G(^VA(200,HBHCNMX,.11)),"^",4)
 I HBHCST]"" S ^TMP("HBHCLIST",$J,HBHCDDX)=^TMP("HBHCLIST",$J,HBHCDDX)_", "_HBHCST
 S HBHCDDX=HBHCDDX+1
 S ^TMP("HBHCLIST",$J,HBHCDDX)="Date Entered in the New Person file:   "_$$FMTE^XLFDT($P(^VA(200,HBHCNMX,1),"^",7))
 S HBHCDDX=HBHCDDX+1
 G:'HBHCNP DDFINISH
 ;
DDHP ;
 N HBHCNUMX,HBHCDET,HBHCHIT
 ;Display all active entries in the HBHC Provider file for this provider.
 ;(There should be only one active entry, but it is possible using FileMan
 ; to define more than one.)
 S (HBHCNUM,HBHCHIT)=0
 F  S HBHCNUM=$O(^HBHC(631.4,"C",HBHCNMX,HBHCNUM)) Q:HBHCNUM=""  D
 . ;do not display inactive HBHC Provider information
 . Q:$P(^HBHC(631.4,HBHCNUM,0),"^",7)]""
 . S HBHCDET(HBHCNUM)="",HBHCHIT=HBHCHIT+1
 I '$D(HBHCDET) D
 . S ^TMP("HBHCLIST",$J,HBHCDDX)="Defined as HBPC Provider number:       None"
 . S HBHCDDX=HBHCDDX+1
 . S ^TMP("HBHCLIST",$J,HBHCDDX)="Member of HBPC Team:                   None"
 S HBHCNUM=""
 F  S HBHCNUM=$O(HBHCDET(HBHCNUM)) Q:HBHCNUM=""  D
 . I HBHCHIT>1 S HBHCDDX=HBHCDDX+1
 . S HBHCNUMX=$P(^HBHC(631.4,HBHCNUM,0),"^")
 . S ^TMP("HBHCLIST",$J,HBHCDDX)="Defined as HBPC Provider number:       "_HBHCNUMX
 . S HBHCDDX=HBHCDDX+1
 . S HBHCTEAM=$P(^HBHC(631.4,HBHCNUM,0),"^",6)
 . S HBHCTEAM=$P(^HBHC(633,HBHCTEAM,0),"^")
 . S ^TMP("HBHCLIST",$J,HBHCDDX)="Member of HBPC Team:                   "_HBHCTEAM
 S:'HBHCNP HBHCDDX=HBHCDDX+1
 I HBHCNP D DDFINISH
 Q
 ;
DDFINISH ;
 S VALMBCK="R"
 S VALMHDR(1)="                               Detailed Display"
 S VALMHDR(2)="-------------------------------------------------------------------------------"
 ;Set HBHCNP to zero so user is forced to re-display New Person list if chooses to Add
 S HBHCNP=0
 D INIT2
 Q
 ;
SAVE ;
 K ^TMP("HBHCSAVE",$J),^TMP("HBHCLISTZ",$J),^TMP("HBHCEDITZ",$J)
 M ^TMP("HBHCSAVE",$J)=^TMP("HBHC",$J)
 M ^TMP("HBHCLISTZ",$J)=^TMP("HBHCLIST",$J)
 M ^TMP("HBHCEDITZ",$J)=^TMP("HBHCEDIT",$J)
 K ^TMP("HBHC",$J),^TMP("HBHCLIST",$J),^TMP("HBHCEDIT",$J)
 Q
 ;
GET ;
 K ^TMP("HBHC",$J),^TMP("HBHCLIST",$J),^TMP("HBHCEDIT",$J)
 M ^TMP("HBHC",$J)=^TMP("HBHCSAVE",$J)
 M ^TMP("HBHCLIST",$J)=^TMP("HBHCLISTZ",$J)
 M ^TMP("HBHCEDIT",$J)=^TMP("HBHCEDITZ",$J)
 Q
 ;
PRINT ;Print
 D PRTL^VALM1
 Q
 ;
EXIT ;
 K ^TMP("HBHC",$J),^TMP("HBHCLIST",$J),^TMP("HBHCSORT",$J)
 S VALMBG=1,VALMBCK="Q"
 Q
 ;
EXITOPT ;
 ;called from EXIT ACTION of option HBHC EDIT PROVIDER
 K ^TMP("HBHC",$J),^TMP("HBHCLIST",$J),^TMP("HBHCSORT",$J)
 K ^TMP("HBHCLISTZ",$J),^TMP("HBHCSAVE",$J)
 K ^TMP("HBHCEDIT",$J),^TMP("HBHCEDITZ",$J)
 K ^TMP("HBHCIDX",$J)
 S VALMBG=1,VALMBCK="Q"
 Q
