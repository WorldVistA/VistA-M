XVEMSQE ;DJB/VSHL**QWIKs - Edit Name,Code,Description,Param,Box [9/9/95 6:34pm];2017-08-16  10:34 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
NAME ;Edit QWIK Name
 Q:$G(NAM)']""  Q:'$D(^XVEMS("QU",XVV("ID"),NAM))
 I $G(FLAGJMP) Q:FLAGJMP'=1
 S CD=NAM D SCREEN^XVEMKEA("Edit NAME: ",1,XVV("IOM")-1)
 D JUMP^XVEMSQA Q:FLAGJMP
 I XVVSHC="<ESCH>" D MSG^XVEMSQA(1) G NAME
 I ",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_XVVSHC_",") S FLAGQ=1 Q
 I XVVSHC="<TAB>" Q
 I XVVSHC'="<RET>",XVVSHC?1"<".E1">".E G NAME
 S CD=$$ALLCAPS^XVEMKU(CD) I NAM=CD Q
 I CD']""!(CD="^") G:$$ASKDEL^XVEMSQU()'=1 NAME KILL ^XVEMS("QU",XVV("ID"),NAM) S XVVSHC="<TAB>" W !!?1,NAM," deleted.." Q
 I CD'?1A.7AN D MSG^XVEMSQA(1) G NAME
 I $D(^XVEMS("QU",XVV("ID"),CD)) D MSG^XVEMSQA(6) G NAME
 S ^XVEMS("QU",XVV("ID"),CD)=^XVEMS("QU",XVV("ID"),NAM)
 NEW X S X="" F  S X=$O(^XVEMS("QU",XVV("ID"),NAM,X)) Q:X=""  S ^XVEMS("QU",XVV("ID"),CD,X)=^XVEMS("QU",XVV("ID"),NAM,X)
 KILL ^XVEMS("QU",XVV("ID"),NAM)
 S NAM=CD
 Q
 ;====================================================================
CODE ;Get M Code
 I $G(FLAGJMP),$D(^XVEMS("QU",XVV("ID"),NAM)) Q:FLAGJMP'=2
 S (CD,CDHLD)=$G(^XVEMS("QU",XVV("ID"),NAM))
CODE1 D SCREEN^XVEMKEA("Edit CODE: ",1,XVV("IOM")-1)
 D JUMP^XVEMSQA Q:FLAGJMP
 I CD="?"!(CD="??")!(XVVSHC="<ESCH>") D MSG^XVEMSQA(2) G CODE
 I XVVSHC="<ESCU>",CD]"" W $C(7) Q
 I XVVSHC="<ESCU>" D UNSAVE^XVEMSQA I CD']"" G CODE
 I ",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_XVVSHC_",") S FLAGQ=1 Q
 I XVVSHC="<TAB>" Q
 I XVVSHC'="<RET>",XVVSHC'="<ESCU>",XVVSHC?1"<".E1">".E G CODE
 I CD']""!(CD="^") G:'$$ASKDEL^XVEMSQU() CODE  KILL ^XVEMS("QU",XVV("ID"),NAM) S XVVSHC="<TAB>" W !!?1,NAM," deleted.." Q
 D KILLCHK^XVEMKU(CD)
 I CD'=CDHLD  S ^XVEMS("QU",XVV("ID"),NAM)=CD
 I XVVSHC="TOO LONG" G CODE1
 Q
 ;====================================================================
TEXT(TYPE) ;Text for Description and Param Notes. TYPE=DSC or PARAM
 I $G(TYPE)'="DSC",$G(TYPE)'="PARAM" Q
 Q:'$D(^XVEMS("QU",XVV("ID"),NAM))
 I $G(FLAGJMP) Q:TYPE="DSC"&(FLAGJMP'=3)  Q:TYPE="PARAM"&(FLAGJMP'=4)
TEXT1 I TYPE="DSC" S CD=$P($G(^XVEMS("QU",XVV("ID"),NAM,"DSC")),"^",1),PROMPT="Edit DESCRIPTION: "
 I TYPE="PARAM" S CD=$P($G(^XVEMS("QU",XVV("ID"),NAM,"DSC")),"^",2),PROMPT="Edit PARAM NOTES: "
 D SCREEN^XVEMKEA(PROMPT,1,XVV("IOM")-1)
 D JUMP^XVEMSQA Q:FLAGJMP
 I CD="?"!(CD="??")!(XVVSHC="<ESCH>") D MSG^XVEMSQA(3) G TEXT1
 I ",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_XVVSHC_",") S FLAGQ=1 Q
 S:CD="^" XVVSHC="<TAB>" Q:XVVSHC="<TAB>"
 I XVVSHC'="<RET>",XVVSHC?1"<".E1">".E G TEXT1
 I CD["^" D MSG^XVEMSQA(4) G TEXT1
 I CD]"",CD'?1.55ANP W $C(7) D MSG^XVEMSQA(3) G TEXT1
 I TYPE="DSC" S $P(^XVEMS("QU",XVV("ID"),NAM,"DSC"),"^",1)=CD
 I TYPE="PARAM" S $P(^XVEMS("QU",XVV("ID"),NAM,"DSC"),"^",2)=CD
 Q
 ;====================================================================
BOX ;Display Box
 Q:'$D(^XVEMS("QU",XVV("ID"),NAM))
 I $G(FLAGJMP) Q:FLAGJMP'=5
 S CD=$P($G(^XVEMS("QU",XVV("ID"),NAM,"DSC")),"^",3)
 D SCREEN^XVEMKEA("Edit BOX: ",1,XVV("IOM")-1)
 D JUMP^XVEMSQA Q:FLAGJMP
 I CD="?"!(CD="??")!(XVVSHC="<ESCH>") D MSG^XVEMSQA(5) G BOX
 I ",<ESC>,<F1E>,<F1Q>,<TO>,"[(","_XVVSHC_",") S FLAGQ=1 Q
 S:CD="^" XVVSHC="<TAB>" Q:XVVSHC="<TAB>"
 I XVVSHC'="<RET>",XVVSHC?1"<".E1">".E G BOX
 I CD]"",CD'?1.N!(CD'>0) W $C(7) D MSG^XVEMSQA(5) G BOX
 S $P(^XVEMS("QU",XVV("ID"),NAM,"DSC"),"^",3)=CD
 Q
